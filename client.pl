#! /usr/bin/perl
use strict;
use IO::Socket;
use IO::Select;
my %Server_Info=("Server_Ip"=>"127.0.0.1", "Server_Port"=>"8443");
&main;
sub main{
my $server_ip=$Server_Info{Server_Ip};
my $server_port=$Server_Info{Server_Port};
my $socket=IO::Socket::INET->new(
                       PeerAddr=>$server_ip,
                       PeerPort=>8443,
                      # Type=>SOCK_STREAM,
                       Proto=>'tcp', ) or die "Can't creat the Socket $!\n";
print "This is the client socket \n";
my $data;
my $recv_length;
my $recv_data;
while(1){
          print "Let us send the command:";
          $data=<STDIN>;
          my $clientsend=$socket->send($data);
         print "Send the client command length:$clientsend\n";
          $recv_length=$socket->recv($recv_data,10000);
          print "We receive the command result: $recv_data\n";
          #print "The receive length: $recv_length;\n";
}
close($socket) or die "Close socket failed $!\n";   
}
