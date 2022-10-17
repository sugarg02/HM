import java.io.IOException;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;

/*
 * In the mapper we take the state name to be filtered out from the configuration setting using the name "str_to_filter".
 * Then we split the "value" passed to mapped based on tab character which is the delimiter in the input records into array of strings.
 * We then take the 2nd element of this array. Remember we are using key-value-text-input format for input file.
 * So the field before the first tab is the key and remaining part of input record is used as value.
 * We then compare the 2nd element with the string to be filtered out. If it is not equal then
 * we write the key and value to context i.e. mapper's output which is the final output as well.
 */

public class FilterJobNewMapper extends Mapper<Text, Text, Text, Text> {

	@Override
	  public void map(Text key, Text value, Context context)
	      throws IOException, InterruptedException {

		Configuration conf = context.getConfiguration();
		String filter_string = conf.get("str_to_filter");

		String s = value.toString();
	    String[] fields = s.split("\t");
        String stt = fields[2];

        if(!(stt.equals(filter_string))) {
	    	context.write(key, value);
	    }
		
	  }
}
