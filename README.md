# filer-stat-monitor
Using the NetApp ONTAPI to collate filer stats, collect them and display them via an at-a-glance web page. 

This is a perl based project, and makes use of:
- XML::Twig
- LWP
- Mojolicious::Lite
- Parallel::ForkManager
- NetApp ONTAPI filer management API
- LWP::Protocol::https (probably - it's a good idea, but not mandatory) 
- 
