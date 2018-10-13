# Title: Simple Video tag for Jekyll
# Author: Brandon Mathis http://brandonmathis.com
# Description: Easily output MPEG4 HTML5 video with a flash backup.
#
# Syntax {% video url/to/video [width height] [url/to/poster] %}
#
# Example:
# {% video http://site.com/video 720 480 http://site.com/poster-frame.jpg %}
#
# Output:
# <video width='720' height='480' preload='none' controls poster='http://site.com/poster-frame.jpg'>
#   <source src='http://site.com/video.mp4' type='video/mp4; codecs=\"avc1.42E01E, mp4a.40.2\"'/>
#   <source src='http://site.com/video.ogv' type='video/ogg; codecs=theora, vorbis'/>
#   <source src='http://site.com/video.webm' type='video/webm; codecs=vp8, vorbis/>
# </video>
#

module Jekyll

  class VideoTag < Liquid::Tag
    @video = nil
    @poster = ''
    @height = ''
    @width = ''

    def initialize(tag_name, markup, tokens)
      if markup =~ /(https?:\S+)(\s+(https?:\S+))?(\s+(https?:\S+))?(\s+(\d+)\s(\d+))?(\s+(https?:\S+))?/i
        @video  = $1
      end
      super
    end

    def render(context)
      output = super
      type = {
        'mp4' => "type='video/mp4; codecs=\"avc1.42E01E, mp4a.40.2\"'",
        'ogv' => "type='video/ogg; codecs=theora, vorbis'",
        'webm' => "type='video/webm; codecs=vp8, vorbis'"
      }

      if @video.nil?
        "Error processing input, expected syntax: {% video url/to/video [width height] [url/to/poster] %}" 
      else
        video =  "<video width='100%' preload='auto' controls>"
        type.sort{ |x,y| x <=> y }.each do |k,v|
          video += "<source src='#{@video}.#{k}' #{v}>"
        end
        video += "</video>"
      end
    end

  end
end

Liquid::Template.register_tag('video', Jekyll::VideoTag)
