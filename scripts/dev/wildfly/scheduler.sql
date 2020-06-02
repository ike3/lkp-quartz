drop index fks_scheduler.idx_qz_test_t_j;
drop index fks_scheduler.idx_qz_test_t_jg;
drop index fks_scheduler.idx_qz_test_t_c;
drop index fks_scheduler.idx_qz_test_t_g;
drop index fks_scheduler.idx_qz_test_t_state;
drop index fks_scheduler.idx_qz_test_t_n_state;
drop index fks_scheduler.idx_qz_test_t_n_g_state;
drop index fks_scheduler.idx_qz_test_t_next_fire_time;
drop index fks_scheduler.idx_qz_test_t_nft_st;
drop index fks_scheduler.idx_qz_test_t_nft_misfire;
drop index fks_scheduler.idx_qz_test_t_nft_st_ms;
drop index fks_scheduler.idx_qz_test_t_nft_st_ms_grp;

drop index fks_scheduler.idx_qz_test_ft_trg_inst_name;
drop index fks_scheduler.idx_qz_test_ft_i_j_r_rcvry;
drop index fks_scheduler.idx_qz_test_ft_j_g;
drop index fks_scheduler.idx_qz_test_ft_jg;
drop index fks_scheduler.idx_qz_test_ft_t_g;
drop index fks_scheduler.idx_qz_test_ft_tg;

drop table fks_scheduler.qz_test_locks;
drop table fks_scheduler.qz_test_scheduler_state;
drop table fks_scheduler.qz_test_fired_triggers;
drop table fks_scheduler.qz_test_paused_trigger_grps;
drop table fks_scheduler.qz_test_calendars;
drop table fks_scheduler.qz_test_blob_triggers;
drop table fks_scheduler.qz_test_simprop_triggers;
drop table fks_scheduler.qz_test_cron_triggers;
drop table fks_scheduler.qz_test_simple_triggers;
drop table fks_scheduler.qz_test_triggers;
drop table fks_scheduler.qz_test_job_details;


create table fks_scheduler.qz_test_job_details
(
  sched_name varchar2(120) not null,
  job_name varchar2(200) not null,
  job_group varchar2(200) not null,
  description varchar2(250) null,
  job_class_name varchar2(250) not null,
  is_durable varchar2(1) not null,
  is_nonconcurrent varchar2(1) not null,
  is_update_data varchar2(1) not null,
  requests_recovery varchar2(1) not null,
  job_data blob null,
  constraint qz_test_job_details_pk primary key (sched_name,job_name,job_group)
);
grant select, insert, update, delete on fks_scheduler.qz_test_job_details to fks_scheduler;


create table fks_scheduler.qz_test_triggers
(
  sched_name varchar2(120) not null,
  trigger_name varchar2(200) not null,
  trigger_group varchar2(200) not null,
  job_name varchar2(200) not null,
  job_group varchar2(200) not null,
  description varchar2(250) null,
  next_fire_time number(19) null,
  prev_fire_time number(19) null,
  priority number(13) null,
  trigger_state varchar2(16) not null,
  trigger_type varchar2(8) not null,
  start_time number(19) not null,
  end_time number(19) null,
  calendar_name varchar2(200) null,
  misfire_instr number(2) null,
  job_data blob null,
  constraint qz_test_triggers_pk primary key (sched_name,trigger_name,trigger_group),
  constraint qz_test_trg_to_jobs_fk foreign key (sched_name,job_name,job_group)
  references fks_scheduler.qz_test_job_details(sched_name,job_name,job_group)
);
grant select, insert, update, delete on fks_scheduler.qz_test_triggers to fks_scheduler;


create table fks_scheduler.qz_test_simple_triggers
(
  sched_name varchar2(120) not null,
  trigger_name varchar2(200) not null,
  trigger_group varchar2(200) not null,
  repeat_count number(7) not null,
  repeat_interval number(12) not null,
  times_triggered number(10) not null,
  constraint qz_test_smpl_trg_pk primary key (sched_name,trigger_name,trigger_group),
  constraint qz_test_smpl_trg_t_trg_fk foreign key (sched_name,trigger_name,trigger_group)
  references fks_scheduler.qz_test_triggers(sched_name,trigger_name,trigger_group)
);
grant select, insert, update, delete on fks_scheduler.qz_test_simple_triggers to fks_scheduler;


create table fks_scheduler.qz_test_cron_triggers
(
  sched_name varchar2(120) not null,
  trigger_name varchar2(200) not null,
  trigger_group varchar2(200) not null,
  cron_expression varchar2(120) not null,
  time_zone_id varchar2(80),
  constraint qz_test_cron_trg_pk primary key (sched_name,trigger_name,trigger_group),
  constraint qz_test_crn_trg_t_trig_fk foreign key (sched_name,trigger_name,trigger_group)
  references fks_scheduler.qz_test_triggers(sched_name,trigger_name,trigger_group)
);
grant select, insert, update, delete on fks_scheduler.qz_test_cron_triggers to fks_scheduler;


create table fks_scheduler.qz_test_simprop_triggers
(
  sched_name varchar2(120) not null,
  trigger_name varchar2(200) not null,
  trigger_group varchar2(200) not null,
  str_prop_1 varchar2(512) null,
  str_prop_2 varchar2(512) null,
  str_prop_3 varchar2(512) null,
  int_prop_1 number(10) null,
  int_prop_2 number(10) null,
  long_prop_1 number(19) null,
  long_prop_2 number(19) null,
  dec_prop_1 numeric(13,4) null,
  dec_prop_2 numeric(13,4) null,
  bool_prop_1 varchar2(1) null,
  bool_prop_2 varchar2(1) null,
  time_zone_id varchar2(80) null,
  constraint qz_test_smrp_trg_pk primary key (sched_name,trigger_name,trigger_group),
  constraint qz_test_smrp_trg_t_trg_fk foreign key (sched_name,trigger_name,trigger_group)
  references fks_scheduler.qz_test_triggers(sched_name,trigger_name,trigger_group)
);
grant select, insert, update, delete on fks_scheduler.qz_test_simprop_triggers to fks_scheduler;


create table fks_scheduler.qz_test_blob_triggers
(
  sched_name varchar2(120) not null,
  trigger_name varchar2(200) not null,
  trigger_group varchar2(200) not null,
  blob_data blob null,
  constraint qz_test_blob_trg_pk primary key (sched_name,trigger_name,trigger_group),
  constraint qz_test_blb_trg_t_trig_fk foreign key (sched_name,trigger_name,trigger_group)
  references fks_scheduler.qz_test_triggers(sched_name,trigger_name,trigger_group)
);
grant select, insert, update, delete on fks_scheduler.qz_test_blob_triggers to fks_scheduler;


create table fks_scheduler.qz_test_calendars
(
  sched_name varchar2(120) not null,
  calendar_name varchar2(200) not null,
  calendar blob not null,
  constraint qz_test_calendars_pk primary key (sched_name,calendar_name)
);
grant select, insert, update, delete on fks_scheduler.qz_test_calendars to fks_scheduler;


create table fks_scheduler.qz_test_paused_trigger_grps
(
  sched_name varchar2(120) not null,
  trigger_group varchar2(200) not null,
  constraint qz_test_psd_trig_grps_pk primary key (sched_name,trigger_group)
);
grant select, insert, update, delete on fks_scheduler.qz_test_paused_trigger_grps to fks_scheduler;


create table fks_scheduler.qz_test_fired_triggers
(
  sched_name varchar2(120) not null,
  entry_id varchar2(140) not null,
  trigger_name varchar2(200) not null,
  trigger_group varchar2(200) not null,
  instance_name varchar2(200) not null,
  fired_time number(19) not null,
  sched_time number(19) not null,
  priority number(13) not null,
  state varchar2(16) not null,
  job_name varchar2(200) null,
  job_group varchar2(200) null,
  is_nonconcurrent varchar2(1) null,
  requests_recovery varchar2(1) null,
  constraint qz_test_fired_trigger_pk primary key (sched_name,entry_id)
);
grant select, insert, update, delete on fks_scheduler.qz_test_fired_triggers to fks_scheduler;


create table fks_scheduler.qz_test_scheduler_state
(
  sched_name varchar2(120) not null,
  instance_name varchar2(200) not null,
  last_checkin_time number(19) not null,
  checkin_interval number(13) not null,
  constraint qz_test_sched_state_pk primary key (sched_name,instance_name)
);
grant select, insert, update, delete on fks_scheduler.qz_test_scheduler_state to fks_scheduler;


create table fks_scheduler.qz_test_locks
(
  sched_name varchar2(120) not null,
  lock_name varchar2(40) not null,
  constraint qz_test_locks_pk primary key (sched_name,lock_name)
);
grant select, insert, update, delete on fks_scheduler.qz_test_locks to fks_scheduler;


create index fks_scheduler.idx_qz_test_j_req_recvr on fks_scheduler.qz_test_job_details(sched_name,requests_recovery);
create index fks_scheduler.idx_qz_test_j_grp on fks_scheduler.qz_test_job_details(sched_name,job_group);
create index fks_scheduler.idx_qz_test_t_j on fks_scheduler.qz_test_triggers(sched_name,job_name,job_group);
create index fks_scheduler.idx_qz_test_t_jg on fks_scheduler.qz_test_triggers(sched_name,job_group);
create index fks_scheduler.idx_qz_test_t_c on fks_scheduler.qz_test_triggers(sched_name,calendar_name);
create index fks_scheduler.idx_qz_test_t_g on fks_scheduler.qz_test_triggers(sched_name,trigger_group);
create index fks_scheduler.idx_qz_test_t_state on fks_scheduler.qz_test_triggers(sched_name,trigger_state);
create index fks_scheduler.idx_qz_test_t_n_state on fks_scheduler.qz_test_triggers(sched_name,trigger_name,trigger_group,trigger_state);
create index fks_scheduler.idx_qz_test_t_n_g_state on fks_scheduler.qz_test_triggers(sched_name,trigger_group,trigger_state);
create index fks_scheduler.idx_qz_test_t_nxt_fr_tm on fks_scheduler.qz_test_triggers(sched_name,next_fire_time);
create index fks_scheduler.idx_qz_test_t_nft_st on fks_scheduler.qz_test_triggers(sched_name,trigger_state,next_fire_time);
create index fks_scheduler.idx_qz_test_t_nft_misfire on fks_scheduler.qz_test_triggers(sched_name,misfire_instr,next_fire_time);
create index fks_scheduler.idx_qz_test_t_nft_st_ms on fks_scheduler.qz_test_triggers(sched_name,misfire_instr,next_fire_time,trigger_state);
create index fks_scheduler.idx_qz_test_t_nft_st_grp on fks_scheduler.qz_test_triggers(sched_name,misfire_instr,next_fire_time,trigger_group,trigger_state);
create index fks_scheduler.idx_qz_test_ft_trg_ist_nm on fks_scheduler.qz_test_fired_triggers(sched_name,instance_name);
create index fks_scheduler.idx_qz_test_ft_i_j_r_rcvry on fks_scheduler.qz_test_fired_triggers(sched_name,instance_name,requests_recovery);
create index fks_scheduler.idx_qz_test_ft_j_g on fks_scheduler.qz_test_fired_triggers(sched_name,job_name,job_group);
create index fks_scheduler.idx_qz_test_ft_jg on fks_scheduler.qz_test_fired_triggers(sched_name,job_group);
create index fks_scheduler.idx_qz_test_ft_t_g on fks_scheduler.qz_test_fired_triggers(sched_name,trigger_name,trigger_group);
create index fks_scheduler.idx_qz_test_ft_tg on fks_scheduler.qz_test_fired_triggers(sched_name,trigger_group);
