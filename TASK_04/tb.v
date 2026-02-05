`timescale 1ns/1ps

module tb;

    // Class handle
    EthPacket pkt;

    // Signals for waveform visibility
    logic [7:0] payload_sig;
    int unsigned len_sig;

    int i;

    initial begin
        // Required for EPWave / GTKWave
        $dumpfile("epwave.vcd");
        $dumpvars(0, tb);

        pkt = new();

        // Generate multiple packets
        repeat (5) begin
            if (pkt.randomize()) begin
                len_sig = pkt.len;

                // Drive payload bytes one by one
                for (i = 0; i < pkt.len; i++) begin
                    payload_sig = pkt.payload[i];
                    #5;   // delay so EPWave shows transitions
                end

                $display("Packet length = %0d bytes", pkt.len);
                $display("Payload = %p", pkt.payload);
            end
            else begin
                $display("Randomization FAILED");
            end

            #10;
        end

        #20;
        $finish;
    end

endmodule
