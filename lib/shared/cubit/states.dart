abstract class InvoiceState {}

class InvoiceInitialState extends InvoiceState {}

class ChangeStatusMenuState extends InvoiceState {}

class InvoiceCreateDataBaseState extends InvoiceState {}

class InvoiceInsertDatabaseState extends InvoiceState {}

class InvoiceUpdateDatabaseState extends InvoiceState {}

class InvoiceDeleteDatabaseState extends InvoiceState {}

class InvoiceGetAllDatabaseState extends InvoiceState {}

class InvoiceGetAllDatabaseLoadingState extends InvoiceState {}

class SearchInvoiceLoadingState extends InvoiceState {}

class SearchInvoiceSuccessState extends InvoiceState {}
