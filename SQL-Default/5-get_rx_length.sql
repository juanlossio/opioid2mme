create or replace function get_rx_length (
    start_time date,
    end_time date
)
return number 
is 
    out_rx_length number;
begin 
    --dbms_output.put_line ('start time: ' || start_time);
    --dbms_output.put_line ('end time: ' || end_time);
    if start_time is not null and end_time is not null then
        out_rx_length := round(end_time - start_time + 1);
    else
        if end_time is null and start_time is not null then
            out_rx_length := 1;
        else
            out_rx_length := null;
        end if;
    end if;

    return out_rx_length;
end get_rx_length;
/