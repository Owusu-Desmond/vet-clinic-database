-- create patient table
CREATE TABLE patients(
    id INTEGER NOT NULL,
    name VARCHAR(255) NOT NULL,
    date_of_birth DATE NOT NULL
);
ALTER TABLE
    patients ADD PRIMARY KEY(id);

-- create invoice table
CREATE TABLE invioces(
-- create relationship between medical history and patient
ALTER TABLE
    medical_histories ADD CONSTRAINT medical_histories_patient_id_foreign FOREIGN KEY(patient_id) REFERENCES patients(id);

-- create relationship between invoice_items and treatment
ALTER TABLE
    invoices_items ADD CONSTRAINT invoices_items_treatment_id_foreign FOREIGN KEY(treatment_id) REFERENCES treatments(id);

-- create relationship between invoice_items and invoice
ALTER TABLE
    invoices_items ADD CONSTRAINT invoices_items_invoice_id_foreign FOREIGN KEY(invoice_id) REFERENCES invioces(id);

-- create relationship between invoice and medical history
ALTER TABLE
    invioces ADD CONSTRAINT invioces_medical_histroy_id_foreign FOREIGN KEY(medical_histroy_id) REFERENCES medical_histories(id);

-- add the FK indexes
CREATE INDEX
    invoices_items_invoice_id_index ON invoices_items(invoice_id);

CREATE INDEX
    invoices_items_treatment_id_index ON invoices_items(treatment_id);


    id INTEGER NOT NULL,
    total_amount DECIMAL(8, 2) NOT NULL,
    generated_at TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
    payed_at TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
    medical_histroy_id INTEGER NOT NULL
);
ALTER TABLE
    invioces ADD PRIMARY KEY(id);

-- create medical history table
CREATE TABLE medical_histories(
    id INTEGER NOT NULL,
    admitted_at TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
    patient_id INTEGER NOT NULL,
    status VARCHAR(255) NOT NULL
);
ALTER TABLE
    medical_histories ADD PRIMARY KEY(id);

-- create invoice items table
CREATE TABLE invoices_items(
    id INTEGER NOT NULL,
    unit_price DECIMAL(8, 2) NOT NULL,
    quantity INTEGER NOT NULL,
    total_price DECIMAL(8, 2) NOT NULL,
    invoice_id INTEGER NOT NULL,
    treatment_id INTEGER NOT NULL
);
ALTER TABLE
    invoices_items ADD PRIMARY KEY(id);

-- create treatments table
CREATE TABLE treatments(
    id INTEGER NOT NULL,
    type VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL
);
ALTER TABLE
    treatments ADD PRIMARY KEY(id);

-- create relationship between medical history and patient
ALTER TABLE
    medical_histories ADD CONSTRAINT medical_histories_patient_id_foreign FOREIGN KEY(patient_id) REFERENCES patients(id);

-- create relationship between invoice_items and treatment
ALTER TABLE
    invoices_items ADD CONSTRAINT invoices_items_treatment_id_foreign FOREIGN KEY(treatment_id) REFERENCES treatments(id);

-- create relationship between invoice_items and invoice
ALTER TABLE
    invoices_items ADD CONSTRAINT invoices_items_invoice_id_foreign FOREIGN KEY(invoice_id) REFERENCES invioces(id);

-- create relationship between invoice and medical history
ALTER TABLE
    invioces ADD CONSTRAINT invioces_medical_histroy_id_foreign FOREIGN KEY(medical_histroy_id) REFERENCES medical_histories(id);

-- add the FK indexes
CREATE INDEX
    invoices_items_invoice_id_index ON invoices_items(invoice_id);

CREATE INDEX
    invoices_items_treatment_id_index ON invoices_items(treatment_id);

CREATE INDEX
    invioces_medical_histroy_id_index ON invioces(medical_histroy_id);

CREATE INDEX
    medical_histories_patient_id_index ON medical_histories(patient_id);
