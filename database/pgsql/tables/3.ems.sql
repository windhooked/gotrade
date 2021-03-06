CREATE TABLE IF NOT EXISTS orders
(
  order_id             SERIAL,
  client_guid          TEXT,
  order_key            INT              NOT NULL,
  order_key_version    INT              NOT NULL,
  order_submitted_time TIMESTAMP        NOT NULL,
  instruction          TEXT             NOT NULL,
  market_connector     TEXT             NOT NULL,
  order_type           TEXT             NOT NULL,
  time_in_force        TEXT             NOT NULL,
  handl_inst           INT              NOT NULL,
  symbol               TEXT             NOT NULL,
  exchange             TEXT             NOT NULL,
  side                 TEXT             NOT NULL,
  qty                  DOUBLE PRECISION NOT NULL,
  limit_price          DOUBLE PRECISION,
  filled_qty           DOUBLE PRECISION,
  filled_avg_price     DOUBLE PRECISION,
  order_status_id      INT              NOT NULL,
  is_complete          BOOLEAN          NOT NULL,
  is_booked            BOOLEAN          NOT NULL,
  is_expired           BOOLEAN          NOT NULL,
  trade_booking_id     INT,
  trader_id            INT              NOT NULL,
  account              INT              NOT NULL,
  broker_user_id       TEXT             NOT NULL,
  broker_account       TEXT             NOT NULL,
  description          TEXT,
  source               TEXT             NOT NULL,
  open_close           CHAR(1)          NOT NULL,
  algo                 TEXT,

  PRIMARY KEY (order_key, order_key_version),
  FOREIGN KEY (order_status_id) REFERENCES order_status (order_status_id),
  FOREIGN KEY (trader_id) REFERENCES person (person_id),
  UNIQUE (order_id)
);


CREATE TABLE IF NOT EXISTS execution
(
  execution_id                   SERIAL,
  order_id                       INT NOT NULL,
  order_status_id                INT NOT NULL,
  broker_execution_time          TIMESTAMP,
  qty                            DOUBLE PRECISION,
  cum_qty                        DOUBLE PRECISION,
  price                          DOUBLE PRECISION,
  avg_price                      DOUBLE PRECISION,
  broker_order_id                TEXT,
  broker_exec_id                 TEXT,
  previous_broker_exec_id        TEXT,
  calc_cum_qty                   DOUBLE PRECISION,
  calc_avg_price                 DOUBLE PRECISION,
  exec_type_id                   INT,
  last_mkt                       TEXT,
  last_liquidity_ind_id          INT,
  text                           TEXT,
  exec_broker                    TEXT,
  cancel_replace_by_execution_id INT,
  inserted                       TIMESTAMP DEFAULT (now() AT TIME ZONE 'utc'),

  PRIMARY KEY (execution_id),
  FOREIGN KEY (order_status_id) REFERENCES order_status (order_status_id),
  FOREIGN KEY (order_id) REFERENCES orders (order_id),
  FOREIGN KEY (exec_type_id) REFERENCES exec_type (exec_type_id)
);