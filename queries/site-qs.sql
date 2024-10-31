with site_qs (ao, user_name) as (select 'so_black_ao_outer_rim', 'Photo Op'
                                 union all
                                 select 'so_black_ao_station', 'Roughage'
                                 union all
                                 select 'so_black_ao_stomping_grounds', 'Mustang Sally'
                                 union all
                                 select 'so_orange_ao_iron_horse', 'Sonic'
                                 union all
                                 select 'so_orange_ao_mine', 'Fixodent'
                                 union all
                                 select 'so_orange_ao_nomad', 'Rowengartner'
                                 union all
                                 select 'so_orange_ao_store', 'Flo-Rida'
                                 union all
                                 select 'so_orange_ao_zoo', 'Blue Steel'
                                 union all
                                 select 'so_orange_black_ops_collinsville', 'Chief Choppa'
                                 union all
                                 select 'so_purple_ao_little_egypt', 'Plankton'
                                 union all
                                 select 'so_purple_ao_pitch', 'O\'Donk'
                                 union all
                                 select 'so_purple_ao_prost', 'NIPS'
                                 union all
                                 select 'so_purple_rucks', 'Fuzzy')
select aos.ao,
       users.user_name,
       site_qs.user_name as exp_user_name,
       u2.user_id        as exp_user_id
from aos
         left join users on (aos.site_q_user_id = users.user_id)
         join site_qs on (aos.ao = site_qs.ao)
         left join users as u2 on (site_qs.user_name = u2.user_name)
order by aos.ao;

with site_qs (ao, user_name) as (select 'so_black_ao_outer_rim', 'Photo Op'
                                 union all
                                 select 'so_black_ao_station', 'Roughage'
                                 union all
                                 select 'so_black_ao_stomping_grounds', 'Mustang Sally'
                                 union all
                                 select 'so_orange_ao_iron_horse', 'Sonic'
                                 union all
                                 select 'so_orange_ao_mine', 'Fixodent'
                                 union all
                                 select 'so_orange_ao_nomad', 'Rowengartner'
                                 union all
                                 select 'so_orange_ao_store', 'Flo-Rida'
                                 union all
                                 select 'so_orange_ao_zoo', 'Blue Steel'
                                 union all
                                 select 'so_orange_black_ops_collinsville', 'Chief Choppa'
                                 union all
                                 select 'so_purple_ao_little_egypt', 'Plankton'
                                 union all
                                 select 'so_purple_ao_pitch', 'O\'Donk'
                                 union all
                                 select 'so_purple_ao_prost', 'NIPS'
                                 union all
                                 select 'so_purple_rucks', 'Fuzzy')
update aos
    left join site_qs on (aos.ao = site_qs.ao)
    join users on (site_qs.user_name = users.user_name)
set site_q_user_id = users.user_id
where (
              aos.site_q_user_id is null
              or
              aos.site_q_user_id != users.user_id
          )
