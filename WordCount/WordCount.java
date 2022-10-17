import java.io.IOException;
import java.util.*;

import org.apache.hadoop.conf.*;
import org.apache.hadoop.fs.*;
import org.apache.hadoop.io.*;
import org.apache.hadoop.mapreduce.*;
import org.apache.hadoop.mapreduce.lib.input.*;
import org.apache.hadoop.mapreduce.lib.output.*;
import org.apache.hadoop.util.*;

public class WordCount extends Configured implements Tool {

	public static class WCMapper extends Mapper<LongWritable, Text, Text, IntWritable> {
		String line;
		StringTokenizer tokenizer;
		private final static IntWritable one = new IntWritable(1);
		private Text word = new Text();

		public void map(LongWritable key, Text value, Context context)
				throws IOException,  InterruptedException {
			line = value.toString();
			tokenizer = new StringTokenizer(line);
			while (tokenizer.hasMoreTokens()) {
				word.set(tokenizer.nextToken());
				context.write(word, one);
			}
		}
	}

	public static class WCReducer extends Reducer<Text, IntWritable, Text, IntWritable> {
		@Override public void reduce(Text key, Iterable<IntWritable> val, Context context) throws IOException, InterruptedException {
			int sum = 0;
			Iterator<IntWritable> values = val.iterator();
			while (values.hasNext()) {
				sum += values.next().get();
			}
			context.write(key, new IntWritable(sum));
		}
	}

	public int run(String[] args) throws Exception {
		Configuration conf = new Configuration();
		Job job = new Job(conf);
		job.setJarByClass(WordCount.class);
		job.setInputFormatClass(TextInputFormat.class);
		TextInputFormat.addInputPath(job, new Path(args[0]));
		job.setMapperClass(WCMapper.class);
		job.setReducerClass(WCReducer.class);
		job.setNumReduceTasks(2);
		job.setOutputFormatClass(TextOutputFormat.class);

		job.setOutputKeyClass(Text.class);
		job.setOutputValueClass(IntWritable.class);
		job.setMapOutputKeyClass(Text.class);
		job.setMapOutputValueClass(IntWritable.class);

		TextOutputFormat.setOutputPath(job, new Path(args[1]));
		boolean res = job.waitForCompletion(true);
		if (res)
			return 0;
		else
			return -1;
	}

	public static void main(String args[]) throws Exception {
	    int res = ToolRunner.run(new WordCount(), args);
	    System.exit(res);
	}
}
