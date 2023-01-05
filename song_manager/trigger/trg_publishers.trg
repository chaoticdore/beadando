CREATE OR REPLACE TRIGGER trg_publishers
  BEFORE INSERT OR UPDATE ON publishers
  FOR EACH ROW
BEGIN
  IF inserting
  THEN
    IF :new.id IS NULL
    THEN
      :new.id := sq_publishers.nextval;
    END IF;
  
    :new.creating_user := USER;
    :new.creation_time := systimestamp;
    :new.dml_type      := 'I';
    :new.row_version   := 1;
  ELSIF updating
  THEN
    :new.dml_type    := 'U';
    :new.row_version := :old.row_version + 1;
  END IF;
  :new.modifying_user    := USER;
  :new.modification_time := systimestamp;
END trg_publishers;
/
