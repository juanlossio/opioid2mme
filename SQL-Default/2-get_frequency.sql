create or replace function parse_daily_dose (in_sig varchar2)
    return number is out_daily_dose number;
begin 
    select 
        (case 
            when ' ' || lower(in_sig) || ' ' like lower('%every hour%') then 24
            when ' ' || lower(in_sig) || ' ' like lower('%every hr%') then 24
            when ' ' || lower(in_sig) || ' ' like lower('%q hour%') then 24
            when ' ' || lower(in_sig) || ' ' like lower('%q hr%') then 24
            when ' ' || lower(in_sig) || ' ' like lower('%every two h%') then 12
            when ' ' || lower(in_sig) || ' ' like lower('%every 2 h%') then 12
            when ' ' || lower(in_sig) || ' ' like lower('%q two h%') then 12
            when ' ' || lower(in_sig) || ' ' like lower('%q 2 h%') then 12
            when ' ' || lower(in_sig) || ' ' like lower('%q 2h%') then 12
            when ' ' || lower(in_sig) || ' ' like lower('%q2 h%') then 12
            when ' ' || lower(in_sig) || ' ' like lower('%q2h%') then 12
            when ' ' || lower(in_sig) || ' ' like lower('%twelve times daily%') then 12
            when ' ' || lower(in_sig) || ' ' like lower('%twelve times a day%') then 12
            when ' ' || lower(in_sig) || ' ' like lower('%twelve times per day%') then 12
            when ' ' || lower(in_sig) || ' ' like lower('% 12 times per day%') then 12
            when ' ' || lower(in_sig) || ' ' like lower('% 12 times daily%') then 12
            when ' ' || lower(in_sig) || ' ' like lower('% 12 times a day%') then 12
            when ' ' || lower(in_sig) || ' ' like lower('%every three h%') then 8
            when ' ' || lower(in_sig) || ' ' like lower('%every 3 h%') then 8
            when ' ' || lower(in_sig) || ' ' like lower('%q three h%') then 8
            when ' ' || lower(in_sig) || ' ' like lower('%q 3 h%') then 8
            when ' ' || lower(in_sig) || ' ' like lower('%q 3h%') then 8
            when ' ' || lower(in_sig) || ' ' like lower('%q3 h%') then 8
            ---
            when ' ' || lower(in_sig) || ' ' like lower('%q1h%') then 24
            when ' ' || lower(in_sig) || ' ' like lower('%q2h%') then 12
            when ' ' || lower(in_sig) || ' ' like lower('%q3h%') then 8
            when ' ' || lower(in_sig) || ' ' like lower('%q4h%') then 6
            when ' ' || lower(in_sig) || ' ' like lower('%q6h%') then 4
            when ' ' || lower(in_sig) || ' ' like lower('%q8h%') then 3
            when ' ' || lower(in_sig) || ' ' like lower('%q12h%') then 2
            when ' ' || lower(in_sig) || ' ' like lower('%q24h%') then 1
            ---
            when ' ' || lower(in_sig) || ' ' like lower('%2 (two) times a day') then 2
            when ' ' || lower(in_sig) || ' ' like lower('%3 (three) times a day') then 3
            when ' ' || lower(in_sig) || ' ' like lower('%4 (four) times a day') then 4
            when ' ' || lower(in_sig) || ' ' like lower('%6 (six) times a day') then 6
            when ' ' || lower(in_sig) || ' ' like lower('%8 (eight) times a day') then 8
            when ' ' || lower(in_sig) || ' ' like lower('%12 (twelve) times a day') then 12
            when ' ' || lower(in_sig) || ' ' like lower('%24 (twenty-four) times a day') then 24
            ---
            when ' ' || lower(in_sig) || ' ' like lower('%twelve times daily%') then 8
            when ' ' || lower(in_sig) || ' ' like lower('%twelve times a day%') then 8
            when ' ' || lower(in_sig) || ' ' like lower('% 8 times daily%') then 8
            when ' ' || lower(in_sig) || ' ' like lower('% 8 times a day%') then 8
            when ' ' || lower(in_sig) || ' ' like lower('%seven times per day%') then 7
            when ' ' || lower(in_sig) || ' ' like lower('%seven times a day%') then 7
            when ' ' || lower(in_sig) || ' ' like lower('%seven times daily%') then 7
            when ' ' || lower(in_sig) || ' ' like lower('% 7 times daily%') then 7
            when ' ' || lower(in_sig) || ' ' like lower('% 7 times a day%') then 7
            when ' ' || lower(in_sig) || ' ' like lower('% 7 times per day%') then 7
            when ' ' || lower(in_sig) || ' ' like lower('%every four h%') then 6
            when ' ' || lower(in_sig) || ' ' like lower('%every 4 h%') then 6
            when ' ' || lower(in_sig) || ' ' like lower('%q four h%') then 6
            when ' ' || lower(in_sig) || ' ' like lower('%q 4 h%') then 6
            when ' ' || lower(in_sig) || ' ' like lower('%six times per day%') then 6
            when ' ' || lower(in_sig) || ' ' like lower('%six times daily%') then 6
            when ' ' || lower(in_sig) || ' ' like lower('% 6 times per day%') then 6
            when ' ' || lower(in_sig) || ' ' like lower('% 6 times daily%') then 6
            when ' ' || lower(in_sig) || ' ' like lower('%q 4-6 h%') then 6
            when ' ' || lower(in_sig) || ' ' like lower('%q 4 to 6 h%') then 6
            when ' ' || lower(in_sig) || ' ' like lower('%q-4 h%') then 6
            when ' ' || lower(in_sig) || ' ' like lower('%q-4-6 h%') then 6
            when ' ' || lower(in_sig) || ' ' like lower('%q-4 to 6 h%') then 6
            when ' ' || lower(in_sig) || ' ' like lower('%q4 h%') then 6    
            when ' ' || lower(in_sig) || ' ' like lower('%q4-6 h%') then 6
            when ' ' || lower(in_sig) || ' ' like lower('%q4 to 6 h%') then 6
            when ' ' || lower(in_sig) || ' ' like lower('%every 4-6 h%') then 6
            when ' ' || lower(in_sig) || ' ' like lower('%every 4 to 6 h%') then 6
            when ' ' || lower(in_sig) || ' ' like lower('%every four to six h%') then 6
            when ' ' || lower(in_sig) || ' ' like lower('%five times per day%') then 5
            when ' ' || lower(in_sig) || ' ' like lower('%five times daily%') then 5
            when ' ' || lower(in_sig) || ' ' like lower('%five times a day%') then 5
            when ' ' || lower(in_sig) || ' ' like lower('% 5 times per day%') then 5
            when ' ' || lower(in_sig) || ' ' like lower('% 5 times a day%') then 5
            when ' ' || lower(in_sig) || ' ' like lower('% 5 times daily%') then 5
            when ' ' || lower(in_sig) || ' ' like lower('%every six h%') then 4
            when ' ' || lower(in_sig) || ' ' like lower('%every 6 h%') then 4
            when ' ' || lower(in_sig) || ' ' like lower('%q six h%') then 4
            when ' ' || lower(in_sig) || ' ' like lower('%q 6 h%') then 4
            when ' ' || lower(in_sig) || ' ' like lower('%q 6h%') then 4
            when ' ' || lower(in_sig) || ' ' like lower('%q6 h%') then 4
            when ' ' || lower(in_sig) || ' ' like lower('%q-6 h%') then 4
            when ' ' || lower(in_sig) || ' ' like lower('%four times daily%') then 4
            when ' ' || lower(in_sig) || ' ' like lower('%four times a day%') then 4
            when ' ' || lower(in_sig) || ' ' like lower('%four times per day%') then 4
            when ' ' || lower(in_sig) || ' ' like lower('% 4 times daily%') then 4
            when ' ' || lower(in_sig) || ' ' like lower('% 4 times a day%') then 4
            when ' ' || lower(in_sig) || ' ' like lower('% 4 times per day%') then 4
            when ' ' || lower(in_sig) || ' ' like lower('%qid%') then 4
            when ' ' || lower(in_sig) || ' ' like lower('%every six to eight h%') then 4
            when ' ' || lower(in_sig) || ' ' like lower('%every 6 to 8 h%') then 4
            when ' ' || lower(in_sig) || ' ' like lower('%every 6-8 h%') then 4
            when ' ' || lower(in_sig) || ' ' like lower('%q 6 to 8 h%') then 4
            when ' ' || lower(in_sig) || ' ' like lower('%q 6-8 h%') then 4
            when ' ' || lower(in_sig) || ' ' like lower('%q6 to 8 h%') then 4
            when ' ' || lower(in_sig) || ' ' like lower('%q-6-8 h%') then 4
            when ' ' || lower(in_sig) || ' ' like lower('%q-6 to 8 h%') then 4
            when ' ' || lower(in_sig) || ' ' like lower('%q6-8 h%') then 4
            when ' ' || lower(in_sig) || ' ' like lower('%every eight h%') then 3
            when ' ' || lower(in_sig) || ' ' like lower('%every 8 h%') then 3
            when ' ' || lower(in_sig) || ' ' like lower('%q eight h%') then 3
            when ' ' || lower(in_sig) || ' ' like lower('%q 8 h%') then 3
            when ' ' || lower(in_sig) || ' ' like lower('%q-8 h%') then 3
            when ' ' || lower(in_sig) || ' ' like lower('%q8 h%') then 3
            when ' ' || lower(in_sig) || ' ' like lower('%three times daily%') then 3
            when ' ' || lower(in_sig) || ' ' like lower('%three times a day%') then 3
            when ' ' || lower(in_sig) || ' ' like lower('%three times per day%') then 3
            when ' ' || lower(in_sig) || ' ' like lower('% 3 times daily%') then 3
            when ' ' || lower(in_sig) || ' ' like lower('% 3 times a day%') then 3
            when ' ' || lower(in_sig) || ' ' like lower('% 3 times per day%') then 3
            --
            when ' ' || lower(in_sig) || ' ' like lower('% 3 (three) times daily%') then 3
            when ' ' || lower(in_sig) || ' ' like lower('% 3 (three) times a day%') then 3
            when ' ' || lower(in_sig) || ' ' like lower('% 3 (three) times per day%') then 3
            ---
            when ' ' || lower(in_sig) || ' ' like lower('%tid%') then 3
            when ' ' || lower(in_sig) || ' ' like lower('%every twelve h%') then 2
            when ' ' || lower(in_sig) || ' ' like lower('%every 12 h%') then 2
            when ' ' || lower(in_sig) || ' ' like lower('%q 12 h%') then 2
            when ' ' || lower(in_sig) || ' ' like lower('%q-12 h%') then 2 
            when ' ' || lower(in_sig) || ' ' like lower('%q twelve h%') then 2
            when ' ' || lower(in_sig) || ' ' like lower('%q12 h%') then 2
            when ' ' || lower(in_sig) || ' ' like lower('%twice a day%') then 2
            when ' ' || lower(in_sig) || ' ' like lower('%twice per day%') then 2
            when ' ' || lower(in_sig) || ' ' like lower('%twice daily%') then 2
            when ' ' || lower(in_sig) || ' ' like lower('%two times a day%') then 2
            when ' ' || lower(in_sig) || ' ' like lower('% 2 times daily%') then 2
            when ' ' || lower(in_sig) || ' ' like lower('% 2 times per day%') then 2
            when ' ' || lower(in_sig) || ' ' like lower('%bid%') then 2
            when ' ' || lower(in_sig) || ' ' like lower('%every other day%') then 0.5
            when ' ' || lower(in_sig) || ' ' like lower('%every 48 h%') then .5
            when ' ' || lower(in_sig) || ' ' like lower('%q 48 h%') then .5
            when ' ' || lower(in_sig) || ' ' like lower('%q48 h%') then .5
            when ' ' || lower(in_sig) || ' ' like lower('%every 72 h%') then (1/3)
            when ' ' || lower(in_sig) || ' ' like lower('%q 72 h%') then (1/3)
            when ' ' || lower(in_sig) || ' ' like lower('%q72 h%') then (1/3)
            when ' ' || lower(in_sig) || ' ' like lower('%every 3 days%') then (1/3)
            when ' ' || lower(in_sig) || ' ' like lower('%q 3 days%') then (1/3)
            when ' ' || lower(in_sig) || ' ' like lower('%q3 days%') then (1/3)
            when ' ' || lower(in_sig) || ' ' like lower('%every 7 days%') then (1/7)
            when ' ' || lower(in_sig) || ' ' like lower('%q 7 days%') then (1/7)
            when ' ' || lower(in_sig) || ' ' like lower('%q7 days%') then (1/7)
            when ' ' || lower(in_sig) || ' ' like lower('%once a week%') then (1/7)  
            when ' ' || lower(in_sig) || ' ' like lower('%per 24%') then 1
            when ' ' || lower(in_sig) || ' ' like lower('% 24 h%') then 1
            when ' ' || lower(in_sig) || ' ' like lower('%every twenty four hours%') then 1
            when ' ' || lower(in_sig) || ' ' like lower('%every 24 hours%') then 1
            when ' ' || lower(in_sig) || ' ' like lower('%every morning%') then 1
            when ' ' || lower(in_sig) || ' ' like lower('%every evening%') then 1
            when ' ' || lower(in_sig) || ' ' like lower('%once daily%') then 1
            when ' ' || lower(in_sig) || ' ' like lower('%for 1 dose%') then 1
            when ' ' || lower(in_sig) || ' ' like lower('%once%') then 1
            when ' ' || lower(in_sig) || ' ' like lower('%every day%') then 1
            when ' ' || lower(in_sig) || ' ' like lower('%daily%') then 1
            when ' ' || lower(in_sig) || ' ' like lower('%nightly%') then 1
            when ' ' || lower(in_sig) || ' ' like lower('%every bedtime%') then 1
            when ' ' || lower(in_sig) || ' ' like lower('%at bedtime%') then 1
            when ' ' || lower(in_sig) || ' ' like lower('%qd%') then 1
            when ' ' || lower(in_sig) || ' ' like lower('%qdaily%') then 1
            when ' ' || lower(in_sig) || ' ' like lower('%per day%') then 1
            when ' ' || lower(in_sig) || ' ' like lower('% 1 h%') then 24
            when ' ' || lower(in_sig) || ' ' like lower('% 2 h%') then 12
            when ' ' || lower(in_sig) || ' ' like lower('% 3 h%') then 8
            when ' ' || lower(in_sig) || ' ' like lower('% 4 h%') then 6
            when ' ' || lower(in_sig) || ' ' like lower('% 6 h%') then 4
            when ' ' || lower(in_sig) || ' ' like lower('% 8 h%') then 3  
            when ' ' || lower(in_sig) || ' ' like lower('% 12 h%') then 2
            when ' ' || lower(in_sig) || ' ' like lower('% 24 h%') then 1
            when ' ' || lower(in_sig) || ' ' like lower('% 1h%') then 24
            when ' ' || lower(in_sig) || ' ' like lower('% 2h%') then 12
            when ' ' || lower(in_sig) || ' ' like lower('% 3h%') then 8
            when ' ' || lower(in_sig) || ' ' like lower('% 4h%') then 6
            when ' ' || lower(in_sig) || ' ' like lower('% 6h%') then 4
            when ' ' || lower(in_sig) || ' ' like lower('% 8h%') then 3  
            when ' ' || lower(in_sig) || ' ' like lower('% 12h%') then 2
            when ' ' || lower(in_sig) || ' ' like lower('% 24h%') then 1
            ---
            when ' ' || lower(in_sig) || ' ' like lower('%every 1 (one) h%') then 24
            when ' ' || lower(in_sig) || ' ' like lower('%every 2 (two) h%') then 12
            when ' ' || lower(in_sig) || ' ' like lower('%every 3 (three) h%') then 8
            when ' ' || lower(in_sig) || ' ' like lower('%every 4 (four) h%') then 6
            when ' ' || lower(in_sig) || ' ' like lower('%every 6 (six) h%') then 4
            when ' ' || lower(in_sig) || ' ' like lower('%every 8 (eight) h%') then 3
            when ' ' || lower(in_sig) || ' ' like lower('%every 12 (twelve) h%') then 2
            when ' ' || lower(in_sig) || ' ' like lower('%every 24 (twenty-four) h%') then 1
        else null end) into out_daily_dose from dual;
    return out_daily_dose;
end parse_daily_dose;
/
create or replace function get_daily_doses (
    number_of_times number,
    freq_name varchar2, 
    sig varchar2
)
    return number 
    is out_daily_doses number;
--
begin 
    if sig is null and freq_name is null and number_of_times is null then 
        out_daily_doses := null;
    else 
        if number_of_times is not null then
            select (case 
                        when lower(freq_name) like '%times daily%' then number_of_times
                        when lower(freq_name) like '%every%' then
                            (case 
                                when lower(freq_name) like '%min%' then  (60/number_of_times)*24
                                when lower(freq_name) like '%hour%' then  24/number_of_times
                                when lower(freq_name) like '%day%' then 1/number_of_times
                                when lower(freq_name) like '%week%%' then  (1/7)/number_of_times
                                when lower(freq_name) like '%month%%' then  (1/30)/number_of_times
                                else null
                            end
                            )
                        else number_of_times end
                    ) into out_daily_doses from dual;
         else 
            if freq_name is not null then
                select (case 
                            when lower(freq_name) like '%times daily%' then (to_number(regexp_substr(freq_name,'(\d+)',1,1)))
                            when lower(freq_name) like '%every%' then
                                (case 
                                    when lower(freq_name) like '%min%' then  (60/(to_number(regexp_substr(freq_name,'(\d+)',1,1))))*24
                                    when lower(freq_name) like '%hour%' then  24/(to_number(regexp_substr(freq_name,'(\d+)',1,1)))
                                    when lower(freq_name) like '%day%' then 1/(to_number(regexp_substr(freq_name,'(\d+)',1,1)))
                                    when lower(freq_name) like '%week%%' then  (1/7)/(to_number(regexp_substr(freq_name,'(\d+)',1,1)))
                                    when lower(freq_name) like '%month%%' then  (1/30)/(to_number(regexp_substr(freq_name,'(\d+)',1,1)))
                                    else parse_daily_dose(freq_name)
                                end)
                            else parse_daily_dose(freq_name) 
                        end) into out_daily_doses from dual; 
            else
                if out_daily_doses is null and sig is not null then
                    out_daily_doses := parse_daily_dose (sig);
                end if;
            end if;
        end if;
    end if;

    return out_daily_doses;
end get_daily_doses;
/