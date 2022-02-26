drop table mme_prescription;
create table mme_prescription as
select distinct  
 d.str,
 e.strength_per_unit, e.uom, e.route, 
 e.mme_conversion_factor, e.ome_factor, d.thera_class, d.pharm_class, d.pharm_subclass, d.form, 
 d.route as epic_route,
 d.strength as epic_strength, m.*, round(m.end_time - m.start_time+1) as rx_length,
    get_daily_doses(m.number_of_times,m.freq_name, m.sig) daily_dose, 
    get_rx_length(m.start_time,m.end_time) rx_length_final,
    get_strength(e.strength_per_unit,d.strength) strength_final,
    get_mme_factor(e.mme_conversion_factor, e.ome_factor) mme,
    get_units_per_dose(get_strength(e.strength_per_unit,d.strength),m.hv_discrete_dose,m.hv_dose_unit,m.sig) units,
    compute_mme_per_day (
        d.str,
        get_strength(e.strength_per_unit,d.strength),
        get_mme_factor(e.mme_conversion_factor, e.ome_factor),
        get_units_per_dose(get_strength(e.strength_per_unit,d.strength),m.hv_discrete_dose,m.hv_dose_unit,m.sig),
        get_daily_doses(m.number_of_times,m.freq_name, m.sig)
    ) mme_day,
    compute_mme_total (
       d.str,
        get_strength(e.strength_per_unit,d.strength),
        get_mme_factor(e.mme_conversion_factor, e.ome_factor),
        get_units_per_dose(get_strength(e.strength_per_unit,d.strength),m.hv_discrete_dose,m.hv_dose_unit,m.sig),
        get_daily_doses(m.number_of_times,m.freq_name, m.sig),
        get_rx_length(m.start_time,m.end_time),
        refills
    ) mme_total
 from stride_medication m 
  left join ome_stride_medication_morph_eq_fnl e on m.medication_id = e.medication_id
  left join ome_stride_medication_def d on e.medication_id = d.medication_id and e.str = d.str
where lower(d.thera_class) like lower('analgesics')  and  lower(d.pharm_class) like lower('%opioid%') and lower(d.pharm_class) not like lower('%non-opioid%')
and lower(d.str) not like lower('%buprenorphine%')
and lower(d.str) not like lower('%acetaminophen%')
and lower(m.ordering_mode) like lower('Outpatient');