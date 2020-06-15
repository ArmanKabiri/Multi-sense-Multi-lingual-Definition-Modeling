# Author: Arman Kabiri
# University of new Brunswick
# Email: Arman.Kabiri94@gmail.com

using ArgParse
using AdaGram

s = ArgParseSettings()

@add_arg_table s begin
  "model"
    help = "path to the pre-trained model"
    arg_type = AbstractString
    required = true
  "output"
    help = "embeddings output file path"
    arg_type = AbstractString
    required = true
end

threshold = 0.01
args = parse_args(ARGS, s);
print(string("loading model in ",args["model"]))
vm, dict = load_model(args["model"]);
print("model is loaded\n")

open(args["output"], "w") do file
	buffer = IOBuffer()
	n_vocab = 0
	for (word_index,word) in enumerate(dict.id2word)
		if !in('#',word)
			if(word_index%10000==0)
			    print(string(word_index/length(dict.id2word)*100," %\n"))
			end
			senses_prob = expected_pi(vm, word_index)
			i_temp=1
			highest_sense_prob=0
			mostCommon_sense_vector=[]
			for (s_index,s_prob) in enumerate(senses_prob)
			    if(s_prob>threshold)
				sense_vector = vm.In[:, s_index, word_index]
				write(buffer,string(word,"#",i_temp," "))
				write(buffer,join(sense_vector, " "))
				write(buffer,"\n")
				i_temp=i_temp+1
				n_vocab +=1
				if(s_prob>highest_sense_prob)
				    mostCommon_sense_vector = sense_vector;
				    highest_sense_prob = s_prob
				end
			     end
			end
			write(buffer,string(word," "))
			write(buffer,join(mostCommon_sense_vector, " "))
			write(buffer,"\n")
			n_vocab +=1
		else
			print(string(word," was droped!\n"))
		end
	end
	dimensionality = length(vm.In[:, 1, 1])
	print("Writing to file\n")
	write(file,"$n_vocab $dimensionality\n")
	write(file, takebuf_string(buffer))
	print("File is ready. Done!\n")
end
