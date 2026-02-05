class EthPacket;

    // Length of payload
    rand int unsigned len;

    // Dynamic array payload (8-bit bytes)
    rand byte payload[];

    // Length constraint: between 4 and 8 bytes
    constraint len_c {
        len inside {[4:8]};
    }

    // Payload size must match length
    constraint payload_size_c {
        payload.size() == len;
    }

endclass
