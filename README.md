# The glodjib Platform

### What it is

The glodjib Platform is meant to be an easy way for photographers to use a relatively simple but state-of-the-art WYSIWYG
blogging tool in conjunction with automated gallery generation for portfolios.
It has Flickr integration baked right into its core, but is also usable as a standalone solution with satisfactory control
over the presentation of images.
The layout will be customizable, but the standard layout can also be used in conjunction with custom CSS rules and colors
for an individual look.

### Why it exists

I was not satisfied with the solutions available, simple as that. Tried various approaches with Wordpress Plugins, and
none of them gave me the versatility and control I needed. So I decided to make my own, and make it flexible enough for
others to use as well.

### Roadmap

The platform is supposed to be ready for at least my personal use before the end of 2013. When and how other photographers
can use the platform is not decided at this point, but I plan to offer that Q1 2014 at the latest as well.

### Technology

The application uses state-of-the-art frameworks and technology. Among them:

* [Ruby](https://www.ruby-lang.org/en/) 2.1.0
* [Ruby on Rails](http://rubyonrails.org/) 4.0.1
* [jQuery](http://jquery.com/) 1.10.2
* [Bootstrap](http://getbootstrap.com/) 3.0.2
* [TinyMCE](http://www.tinymce.com/)
* [JustifiedGallery](http://miromannino.com/projects/justified-gallery/)
* [Colorbox](http://www.jacklmoore.com/colorbox/)
* [SpinKit](https://github.com/tobiasahlin/SpinKit)
* [BestInPlace](http://bernatfarrero.com/in-place-editing-with-javascript-jquery-and-rails-3/)
* [DropzoneJS](https://github.com/ncuesta/dropzonejs-rails)

It seamlessly integrates with Flickr through the [Flickr API](http://www.flickr.com/services/api/).

It runs on a variety of databases and server platforms, though of course they have to provide Rails stack.
My plan is to offer deployment support and automated deployment with platforms such as [Heroku](https://www.heroku.com/)
and [EngineYard](https://www.engineyard.com/).

CSS gradients were created with [Ultimate CSS Gradient Generator](http://www.colorzilla.com/gradient-editor/).

### License

This work is, so far, licensed under this license:

[![Creative Commons License](http://i.creativecommons.org/l/by-nc-nd/3.0/88x31.png "Creative Commons License")](http://creativecommons.org/licenses/by-nc-nd/3.0/)

I will add commercial licenses at a later point.
