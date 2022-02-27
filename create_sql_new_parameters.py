print('Staring Execution ... ')
import json

print('**********************************************')
print('- Reading parameters file')
print('**********************************************')

# Opening parameters JSON file
f = open('parameters.json', 'r')

# returns parameters JSON object as a dictionary
json_data = json.load(f)
print(json_data)

print('**********************************************')
print('- Editing SQL code with new parameters')
print('**********************************************')

query_final = 'drop table mme_prescription; \n' \
'create table mme_prescription as \n' \
'select distinct   \n' \
' d.' + json_data['stride_medication_def']['str'] + ', \n' \
' e.strength_per_unit, e.uom, e.route,  \n' \
' e.mme_conversion_factor, e.ome_factor, d.' + json_data['stride_medication_def']['thera_class'] + ', d.' + json_data['stride_medication_def']['pharm_class'] + ', d.' + json_data['stride_medication_def']['pharm_subclass'] + ', d.' + json_data['stride_medication_def']['form'] + ',  \n' \
' d.' + json_data['stride_medication_def']['route'] + ' as epic_route, \n' \
' d.' + json_data['stride_medication_def']['strength'] + ' as epic_strength, m.*, round(m.' + json_data['stride_medication']['end_time'] + ' - m.' + json_data['stride_medication']['start_time'] + '+1) as rx_length, \n' \
'    get_daily_doses(m.' + json_data['stride_medication']['number_of_times']  + ',m.' + json_data['stride_medication']['freq_name'] + ', m.' + json_data['stride_medication']['sig'] + ') daily_dose,  \n' \
'    get_rx_length(m.' + json_data['stride_medication']['start_time'] + ',m.' + json_data['stride_medication']['end_time'] + ') rx_length_final, \n' \
'    get_strength(e.strength_per_unit,d.' + json_data['stride_medication_def']['strength'] + ') strength_final, \n' \
'    get_mme_factor(e.mme_conversion_factor, e.ome_factor) mme, \n' \
'    get_units_per_dose(get_strength(e.strength_per_unit,d.' + json_data['stride_medication_def']['strength'] + '),m.' + json_data['stride_medication']['hv_discrete_dose']  + ',m.' + json_data['stride_medication']['hv_dose_unit'] + ',m.' + json_data['stride_medication']['sig'] + ') units, \n' \
'    compute_mme_per_day ( \n' \
'        d.' + json_data['stride_medication_def']['str'] + ', \n' \
'        get_strength(e.strength_per_unit,d.' + json_data['stride_medication_def']['strength'] + '), \n' \
'        get_mme_factor(e.mme_conversion_factor, e.ome_factor), \n' \
'        get_units_per_dose(get_strength(e.strength_per_unit,d.' + json_data['stride_medication_def']['strength'] + '),m.' + json_data['stride_medication']['hv_discrete_dose']  + ',m.' + json_data['stride_medication']['hv_dose_unit'] + ',m.' + json_data['stride_medication']['sig'] + '), \n' \
'        get_daily_doses(m.' + json_data['stride_medication']['number_of_times']  + ',m.' + json_data['stride_medication']['freq_name'] + ', m.' + json_data['stride_medication']['sig'] + ') \n' \
'    ) mme_day, \n' \
'    compute_mme_total ( \n' \
'        d.' + json_data['stride_medication_def']['str'] + ', \n' \
'        get_strength(e.strength_per_unit,d.' + json_data['stride_medication_def']['strength'] + '), \n' \
'        get_mme_factor(e.mme_conversion_factor, e.ome_factor), \n' \
'        get_units_per_dose(get_strength(e.strength_per_unit,d.' + json_data['stride_medication_def']['strength'] + '),m.' + json_data['stride_medication']['hv_discrete_dose']  + ',m.' + json_data['stride_medication']['hv_dose_unit'] + ',m.' + json_data['stride_medication']['sig'] + '), \n' \
'        get_daily_doses(m.' + json_data['stride_medication']['number_of_times']  + ',m.' + json_data['stride_medication']['freq_name'] + ', m.' + json_data['stride_medication']['sig'] + '), \n' \
'        get_rx_length(m.' + json_data['stride_medication']['start_time'] + ',m.' + json_data['stride_medication']['end_time'] + '), \n' \
'        refills \n' \
'    ) mme_total \n' \
' from ' + json_data['stride_medication']['new_name_table'] + ' m  \n' \
'  left join ome_stride_medication_morph_eq_fnl e on m.' + json_data['stride_medication']['medication_id']  + ' = e.medication_id \n' \
'  left join ' + json_data['stride_medication_def']['new_name_table'] + ' d on e.medication_id = d.' + json_data['stride_medication_def']['medication_id'] + ' and e.str = d.' + json_data['stride_medication_def']['str'] + ' \n' \
'where lower(d.' + json_data['stride_medication_def']['thera_class'] + ') like lower(\'analgesics\')   \n' \
'and  lower(d.' + json_data['stride_medication_def']['pharm_class'] + ') like lower(\'%opioid%\')  \n' \
'and lower(d.' + json_data['stride_medication_def']['pharm_class'] + ') not like lower(\'%non-opioid%\')  \n' \
'and lower(d.' + json_data['stride_medication_def']['str'] + ') not like lower(\'%buprenorphine%\')  \n' \
'and lower(d.' + json_data['stride_medication_def']['str'] + ') not like lower(\'%acetaminophen%\') \n' \
'and lower(m.' + json_data['stride_medication']['ordering_mode'] + ') like lower(\'Outpatient\'); '


print('Final query: \n-------------\n{}'.format(query_final))



print('**********************************************')
print('- Saving SQL code with new parameters')
print('**********************************************')

with open('9-conversion-to-MME_customized.sql','w') as f_:
    f_.write(query_final)

print('Execution finished!')