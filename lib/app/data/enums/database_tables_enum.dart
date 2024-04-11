enum DatabaseTables {
  currentShift('currentShift'),
  currentTicket('currentTicket'),
  finishedTickets('finishedTickets'),
  projects('allProjects'),
  customers('customers'),
  customersPivot('customersPivot'),
  equipments('equipments'),
  sync('sync'),
  trucks('trucks'),
  helpers('helpers'),
  supervisors('supervisors'),
  workerTypes('workerTypes'),
  CompanyMen('CompanyMen'),
  currentWorker('currentWorker'),
  sessions('sessions'),
  shifts('shifts'),
  workers('workers'),
  tickets('tickets'),
  jsas('jsas');

  const DatabaseTables(this.tableName);
  final String tableName;
}
