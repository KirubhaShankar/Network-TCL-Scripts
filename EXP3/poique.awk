BEGIN {
    drop = 0;
    recv=0;
    time = 0;
    ratio =0;
    pkt = 0;
    output = 0;
}

#body

{
         event = $1
             time = $2
             level = $4
             
         packet_size = $6


if ( event == "r"){
recv++;
pkt += packet_size;
}

if ( event == "d"){
drop++;
}


} #body

END {
ratio=drop/(recv+drop);
output =  recv*8*packet_size/10000;

print " Loss: ", ratio
print " Throughput in kBps: ", output

}
