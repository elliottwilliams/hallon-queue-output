module Hallon
	class QueueOutput

		attr_accessor :queue, :format, :verbose

		def initialize
			@playing, @stopped = false
			@stutter = 0
			@verbose = false
		end

		def format=(format)
			@format = format
			@buffer_size = (format[:rate] / 2) + 100
		end

		def play
			@playing = true
			@stopped = false
			print "\e[1;32m(play)\e[0m" if @verbose
		end

		def pause
			@playing = false
			print "\e[1;33m(pause)\e[0m" if @verbose
		end

		def stop
			@stopped = true
			@stream_thread.exit if @stream_thread

			print "\e[1;31m(stop)\e[0m" if @verbose
		end

		def drops # Return number of queue stutters since the last call
			current_stutter, @stutter = @stutter, 0
			print "(reported #{current_stutter} stutters) " if current_stutter > 0 && @verbose
			pause if current_stutter > (@format[:rate] / 4)
			current_stutter
		end

		def stream # runs indefinitely
			@stream_thread = Thread.new do
				unless @queue
					raise "Need a Queue to output to before streaming!"
				end
				play # always play initially

				loop do
					if @playing

						completion = Time.now.to_f + 0.5

						# Get the next block from Spotify.
						audio_data = yield(@buffer_size)					

						@queue << audio_data

						actual = Time.now.to_f

						# sleep until it's time for the next frame
						if actual > completion
							process_stutter(completion, actual)
						else
							sleep completion - actual
						end

					end
				end
			end
		end

		private

		def process_stutter(projected_end, actual_end)
			sec_missed     = actual_end - projected_end
			samples_missed = (sec_missed * @format[:rate]).to_i
			print "(#{samples_missed} stutter) " if @verbose
			@stutter += samples_missed
		end

	end
end