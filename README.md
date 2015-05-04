# filer-stat-monitor
Using the NetApp ONTAPI to collate filer stats, collect them and display them via an at-a-glance web page. 

This is a perl based project, and makes use of:
- XML::Twig
- LWP
- Mojolicious::Lite
- Parallel::ForkManager
- NetApp ONTAPI filer management API http://community.netapp.com/fukiw75442/attachments/fukiw75442/sdk-and-api-discussions/1285/1/netapp-manageability-sdk-ontap-8.3-api-documentation.zip
- LWP::Protocol::https (probably - it's a good idea, but not mandatory) 


What it does:
- makes calls to the filer ONTAPI 'perf counter' (using XML::Twig to build the the POS request
- dumps to files, for later processing (proxy? and retrieve)
- Collates and processes files with 'info' 
- stores in RRDs
- extracts and graphs using Mojolicious

Counters:
wafl:wafl:cp_count
vol iops
vol bytes/sec
ha iops/btes
interfaces collated bytes and iops
CPU util

Additional metrics/ not aPI?
Vol sizes/dedupe/
aggr sizes dedupe
memerr
mem_stats
(sshonly?)

