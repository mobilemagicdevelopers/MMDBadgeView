MMDBadgeView
============

MMDBadgeView is a quick, easy, and _simple_ subclass of UILabel that looks like iOS style badges.

Yet Another Badge View?
-----------------------

Yep!  We needed a good badge view when we were working on [This2That](http://itunes.apple.com/us/app/this2that/id499422300?ls=1&mt=8),
but we never found anything we felt was simple enough to suit our needs.  What we really wanted was a UILabel that looked like a badge
so we could style it the way we would any other label and get a good looking badge.

That was the impetus for the MMDBadgeView.  At the time of writing, all styles were configurable via Interface Builder.

How to Use
----------

Drag a UILabel onto your layout in Interface Builder, set the text, and center it.  In Identity Inspector, change its class to MMDBadgeView.

__No, Seriously, how do I use it?__

Seriously, that's it.  It's just a label after all

What Else Does it Do?
---------------------

Currently, it just draws the badge background and does its best to infer the desired size of the border as a percentage of the
height of the text control you're putting it on.  It works for most of the stuff we've done.  In the future, we'd like to make
some things configurable programmatically like stroke size, but we haven't yet.

Future of MMDBadgeView
----------------------

* Some programmatic configuration
** Stroke size
** Stroke color
* Some IB configuration
** Text alignment