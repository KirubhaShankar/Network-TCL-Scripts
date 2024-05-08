#This step is to create a simulator

set ns [new Simulator]

#To set a nam & trace file

set nf [open ECE541_3_1.nam w]

$ns namtrace-all $nf

set nd [open ECE541_3_3.tr w]

$ns trace-all $nd

#Code for a 'finish' procedure

proc finish {} {

 global ns nf nd

 $ns flush-trace

 #Close the trace file

 close $nf

 close $nd

 #Execute nam on the trace file

 exec nam ECE541_3_1.nam &

 exit 0

}

set n0 [$ns node]

set n1 [$ns node]

#Code to create links between the nodes

$ns duplex-link $n0 $n1 1Mb 10ms DropTail

#now we need to set queue-size of link n0-n1

$ns queue-limit $n0 $n1 50

#A UDP agent is created and we need to attach it to node n0

set udp0 [new Agent/UDP]

$ns attach-agent $n0 $udp0

#Create a Null agent (a traffic sink) and attach it to node n1

set null0 [new Agent/Null]

$ns attach-agent $n1 $null0

#Generation of Poisson traffic source and attaching it to udp0

set Poi1 [new Application/Traffic/Poisson]

$Poi1 attach-agent $udp0

$Poi1 set rate_ 0.95Mb

#Connect the traffic sources with the traffic sink

$ns connect $udp0 $null0 

#Start and stop - event scheduling for the CBR agents

$ns at 0.0 "$Poi1 start"

$ns at 10.0 "$Poi1 stop"

$ns at 10.0 "finish"

#Last step is to Run the simulation

$ns run
