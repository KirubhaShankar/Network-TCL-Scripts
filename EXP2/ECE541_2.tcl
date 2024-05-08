#Create a simulator object

set ns [new Simulator]

#Set up NAM trace file

set na [open ECE541_2_a.nam w]
$ns namtrace-all $na

#Define a 'finish' procedure
proc finish {} {

        global ns t0 t1 t2 t3 t4 t5 t6 na
	
	$ns flush-trace
        #Close the trace file	
        close $t0
        close $t1
        close $t2
        close $t3
        close $t4
        close $t5
        close $t6
        	
       #Execute nam on the trace file

        exec nam ECE541_1_a.nam &
	
	exit 0
}

#Create seven nodes
for {set i 0} {$i < 8} {incr i} {

        set n($i) [$ns node]
}
#Create links between the nodes
for {set i 0} {$i < 7} {incr i} {

        $ns duplex-link $n($i) $n(7) 1Mb 10ms DropTail
}
#Setting up Trace Files

set t0 [open ECE541_2_0.tr w]
$ns trace-queue $n(0) $n(7) $t0

set t1 [open ECE541_2_1.tr w]
$ns trace-queue $n(1) $n(7)  $t1

set t2 [open ECE541_2_2.tr w]
$ns trace-queue $n(2) $n(7)  $t2

set t3 [open ECE541_2_3.tr w]
$ns trace-queue $n(3) $n(7)  $t3

set t4 [open ECE541_2_4.tr w]
$ns trace-queue $n(4) $n(7)  $t4

set t5 [open ECE541_2_5.tr w]
$ns trace-queue $n(5) $n(7) $t5

set t6 [open ECE541_2_6.tr w]
$ns trace-queue $n(6) $n(7) $t6

#Create a Null agent (a traffic sink) and attach it to node n7
set null0 [new Agent/Null]
$ns attach-agent $n(7) $null0

#Create UDP port and attach to all source nodes

for {set i 0} {$i < 7} {incr i} {
set udp($i) [new Agent/UDP]
$ns attach-agent $n($i) $udp($i)
}

#Connect the UDP sources to sink
for {set i 0} {$i < 7} {incr i} {
$ns connect $udp($i) $null0  
}

# Create Poisson traffic
set poi0 [new Application/Traffic/Poisson]

$poi0 attach-agent $udp(0)

set poi1 [new Application/Traffic/Poisson]

$poi1 attach-agent $udp(1)
set poi2 [new Application/Traffic/Poisson]

$poi2 attach-agent $udp(2)
set poi3 [new Application/Traffic/Poisson]

$poi3 attach-agent $udp(3)
set poi4 [new Application/Traffic/Poisson]

$poi4 attach-agent $udp(4)
set poi5 [new Application/Traffic/Poisson]

$poi5 attach-agent $udp(5)
set poi6 [new Application/Traffic/Poisson]

$poi6 attach-agent $udp(6)


#Rates changed based on the experiment necessity 
$poi0 set rate_ 0.1Mb
$poi1 set rate_ 0.25Mb
$poi2 set rate_ 0.5Mb
$poi3 set rate_ 1Mb
$poi4 set rate_ 1.5Mb
$poi5 set rate_ 2Mb
$poi6 set rate_ 3Mb


#Schedule events for the Poisson agents
$ns at 0.0 "$poi0 start"
$ns at 10.0 "$poi0 stop"

$ns at 10.0 "$poi1 start"
$ns at 20.0 "$poi1 stop"

$ns at 20.0 "$poi2 start"
$ns at 30.0 "$poi2 stop"

$ns at 30.0 "$poi3 start"
$ns at 40.0 "$poi3 stop"

$ns at 40.0 "$poi4 start"
$ns at 50.0 "$poi4 stop"

$ns at 50.0 "$poi5 start"
$ns at 60.0 "$poi5 stop"

$ns at 60.0 "$poi6 start"
$ns at 70.0 "$poi6 stop"

#Call the finish procedure after 10 seconds of simulation time

$ns at 75.0 "finish"

#Run the simulation

$ns run
