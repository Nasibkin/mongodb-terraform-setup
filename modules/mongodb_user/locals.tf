locals {
  custom_roles_actions = {
    application_rw = [
      {
        action = "UPDATE"
        resources = [
          {
            collection_name = ""
            database_name   = "example-db"
          }
        ]
      },
      {
        action = "INSERT"
        resources = [
          {
            collection_name = ""
            database_name   = "example-db"
          }
        ]
      },
      {
        action = "REMOVE"
        resources = [
          {
            collection_name = ""
            database_name   = "example-db"
          }
        ]
      },
      {
        action = "FIND"
        resources = [
          {
            collection_name = ""
            database_name   = "example-db"
          }
        ]
      }
    ],
    mongosync_bypass = [
      {
        action = "BYPASS_DOCUMENT_VALIDATION"
        resources = [
          {
            collection_name = ""
            database_name   = "example-db"
          }
        ]
      }
    ]
  }
}