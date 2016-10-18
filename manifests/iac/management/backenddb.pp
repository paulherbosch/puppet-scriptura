class scriptura::iac::management::backenddb (
  $ensure = present,
) {

  class { 'postgresql::server': }

  $database = hiera_hash('scriptura::iac::management::backenddb::database',{})
  $database_grant = hiera_hash('scriptura::iac::management::backenddb::database_grant',{})
  $role = hiera_hash('scriptura::iac::management::backenddb::role',{})
  $pg_hba_rule = hiera_hash('scriptura::iac::management::backenddb::pg_hba_rule',{})

  create_resources('postgresql::server::db',$database)
  create_resources('postgresql::server::database_grant',$database_grant)
  create_resources('postgresql::server::role',$role)
  create_resources('postgresql::server::pg_hba_rule',$pg_hba_rule)

}
