require "yaml"

manifest = YAML.load_file "manifest.yml"

def files
	Dir.entries(".").reject { |f| f == "." || f == ".." }
end

def sourcepath(source, file)
	File.expand_path(file)
end

def destpath(file, prefix="")
	File.join(Dir.home, prefix, file)
end

manifest["sources"].each do |source|
	if source.is_a?(String)
		Dir.chdir source do
			files.each do |file|
				from = sourcepath(source, file)
				to = destpath(file)

				cmd = "ln -s #{from} #{to}"
				puts cmd
				system cmd
			end
		end
		next
	end

	key = source.keys.first

	prefix = source[key]["prefix"] rescue ""

	Dir.chdir key do
		files.each do |file|
			from = sourcepath(key, file)
			to = destpath(file, prefix)

			cmd = "ln -s #{from} #{to}"
			puts cmd
			system cmd
		end
	end
end

