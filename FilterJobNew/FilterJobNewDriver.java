import java.io.IOException;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.conf.Configured;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.lib.input.KeyValueTextInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;

/*
 * Driver class of filter job. The job requirement is:
 * From the input records it should filter out the records of the state which is specified in the arguments.
 * The arguments are: 1. Input location, 2. State which is to be filtered out, 3. Output location.
 * $ hadoop jar FilterJobNew.jar FilterJobNewDriver <Input path> <State like FL or NY> <Output path>
 * 
 * The driver takes the 2nd argument (args[1]) and sets it into the configuration with the name "str_to_filter".
 * It also sets the input file as key-value-input-text-input format instead of the default text-input file format.
 * And finally sets number of reduce tasks as zero.This is because after filtering the records we just need to output
 * the whole records as is without any aggregation or any other processing, so reduce task is not required.
 */

public class FilterJobNewDriver extends Configured {

	  public static void main(String[] args) throws IOException, InterruptedException, ClassNotFoundException {

		  if (args.length != 3) {
	      System.out.printf(
	          "Incorrect number of arguments\n");
	      return;
	    }

		Configuration conf = new Configuration();
        conf.set("str_to_filter", args[1]);

		Job job = new Job(conf);
	    job.setJarByClass(FilterJobNewDriver.class);
	    
//	    FileInputFormat.setInputPaths(job, new Path(args[0]));
	    
	    job.setInputFormatClass(KeyValueTextInputFormat.class);
        KeyValueTextInputFormat.setInputPaths(job, new Path(args[0]));
	    FileOutputFormat.setOutputPath(job, new Path(args[2]));

	    job.setMapperClass(FilterJobNewMapper.class);
	    job.setNumReduceTasks(0);

	    job.setMapOutputKeyClass(Text.class);
	    job.setMapOutputValueClass(Text.class);

	    job.setOutputKeyClass(Text.class);
	    job.setOutputValueClass(Text.class);

	    System.exit(job.waitForCompletion(true)?0:-1);
/*
	    if (job.waitForCompletion(true)) System.exit(0);
	    else System.exit(-1);
*/
	  }
}
