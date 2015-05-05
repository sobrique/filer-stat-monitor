#!/usr/bin/env perl

use strict;
use warnings;
use FindBin;

package Defs;
use Storable;

our $data_dir = $FindBin::Bin . "/data";
our $xml_dir  = $data_dir . "/xml_to_process";
our $xml_defs = $data_dir . "/xml_defs";
our $rrd_rid  = $data_dir . "/rrd";

my $auth_file = "$data_dir/auth.db";
my $login_info_for;
if   ( -f $auth_file ) { $login_info_for = retrieve($auth_file) }
else                   { $login_info_for = {} }

sub username_for {
    my ($host) = @_;
    return $login_info_for->{$host}->{'username'};
}

sub passwd_for {
    my ($host) = @_;
    return $login_info_for->{$host}->{'passwd'};
}

sub set_username_for {
    my ( $host, $username ) = @_;
    $login_info_for->{$host}->{'username'} = $username;
    Storable::store( \%$login_info_for, $auth_file );
}

sub set_passwd_for {
    my ( $host, $passwd ) = @_;
    $login_info_for->{$host}->{'passwd'} = $passwd;
    Storable::store( \%$login_info_for, $auth_file );
}


our $things_to_fetch = {
    'vol_stats' => {
        'volume' => [
            qw ( read_ops write_ops other_ops
                read_latency write_latency other_latency
                read_blocks write_blocks )
        ],
    },
    'wafl_stats' => { 'wafl'  => [ 'cp_count',         'read_io_type' ] },
    'nfsv3'      => { 'nfsv3' => [ 'nfsv3_op_latency', 'nfsv3_op_count' ] },
    'flashcache' => {
        'ext_cache_obj' => [
            qw ( usage hit miss total
                metadata_hits hit_percent
                evicts invalidates inserts
                readio_chains writeio_chains
                readio_blocks writeio_blocks
                disk_reads_replaced )
        ]
    },
    'hostadapter' => {
        'hostadapter' => [
            qw ( total_reads total_writes
                bytes_read bytes_written )
        ],
    },
    'cifs_stats' => {
        'cifs_stats' => [
            qw ( curr_ses_cnt auth_qlength block_qlength timer_qlength alf_qlength rpc_qlength offload_qlength )
        ],
    },
    'cifs_domaininfo' => {
        'cifsdomain' => [qw ( netlogon_latency lsa_latency samr_latency )],
    },

    'sysstat' => {
        'system' => [
            qw ( nfs_ops cifs_ops http_ops fcp_ops iscsi_ops
                read_ops write_ops total_ops
                sys_read_latency sys_write_latency sys_avg_latency
                net_data_recv net_data_sent
                disk_data_read disk_data_written
                cpu_busy avg_processor_busy  total_processor_busy )
        ],
    },
    'ifnet' => {
        'ifnet' => [
            qw ( send_packets recv_packets
                send_data recv_data
                )
        ],
    },

}
