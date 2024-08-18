-- *************************** UNIDAD 1 ******************************
-- Función que retorna un tipo TRIGGER

-- Crear un TRIGGER para la tabla PROVEEDORES
-- Validar que el correo sea un dato correcto

INSERT INTO proveedores(nombre, direccion, telefono, correo_electronico) VALUES
    ('Fabricante de juguetes', 'Toluca Km. 17, Toluca', '722-234-5555', 'email@example.com');

CREATE FUNCTION insertar_proveedor()
    RETURNS TRIGGER
    LANGUAGE plpgsql AS
    $$
        DECLARE regex_email TEXT := '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}$';
        BEGIN
            IF NEW.correo_electronico ~ regex_email
                THEN
                    RETURN NEW;
                ELSE
                    RAISE EXCEPTION 'Email: "%" no es valido!!!', NEW.correo_electronico;
            END IF;
        END;
    $$;

CREATE TRIGGER tr_nuevo_proveedor
    BEFORE INSERT
    ON proveedores
    FOR EACH ROW
    EXECUTE FUNCTION insertar_proveedor();

-- *************************** UNIDAD 2 ******************************
-- Triggers escalares BEFORE OR AFTER
    -- Validar que el nuevo precio sea mayor o igual que 10
    -- Trigger de modificacion

CREATE FUNCTION modifica_precio_producto()
    RETURNS TRIGGER
    LANGUAGE plpgsql AS
    $$
        BEGIN
            IF valida_precio(NEW.precio)
                THEN
                    RETURN NEW;
                ELSE
                    NEW.precio := 10::NUMERIC(10, 2);
                    RETURN NEW;
            END IF;
        END;
    $$;

CREATE TRIGGER tr_actualiza_precio_producto
    BEFORE UPDATE
    ON productos
    FOR EACH ROW
    EXECUTE FUNCTION modifica_precio_producto();

UPDATE productos set precio = -15 WHERE id_producto = 7;

-- *************************** UNIDAD 3 ******************************
-- Triggers de AUDITORIA de Base de Datos

-- Auditoría para la tabla detalle_envios
CREATE TABLE auditoria_detalle_envios
(
    id SERIAL PRIMARY KEY,
    usuario VARCHAR(50) NOT NULL,
    fecha_hora TIMESTAMP NOT NULL,
    action VARCHAR(15) NOT NULL,
    data_detalle_envio JSONB NOT NULL
);
SELECT USER;
SELECT now();

CREATE FUNCTION auditoria_detalle_envios()
    RETURNS TRIGGER
    LANGUAGE plpgsql AS
    $audit_envios$
        BEGIN
            CASE TG_OP -- 'INSERT - UPDATE - DELETE'
                WHEN 'INSERT' THEN
                    INSERT INTO auditoria_detalle_envios(usuario, fecha_hora, action, data_detalle_envio)
                        VALUES (user, now(), TG_OP, row_to_json(NEW));
                    RETURN NEW;
                WHEN 'UPDATE' THEN
                    INSERT INTO auditoria_detalle_envios(usuario, fecha_hora, action, data_detalle_envio)
                        VALUES (user, now(), TG_OP, row_to_json(NEW));
                    RETURN NEW;
                WHEN 'DELETE' THEN
                     INSERT INTO auditoria_detalle_envios(usuario, fecha_hora, action, data_detalle_envio)
                        VALUES (user, now(), TG_OP, row_to_json(OLD));
                     RETURN OLD;
            END CASE;
        END;
    $audit_envios$;

CREATE TRIGGER tr_audit_detalle_envios
    AFTER INSERT OR UPDATE  OR DELETE
    ON detalle_envio
    FOR EACH ROW
    EXECUTE FUNCTION auditoria_detalle_envios();


-- *************************** UNIDAD 4 ******************************
-- Manejo de errores desde TRIGGERS (EXCEPTIONS)
-- select date_part('dow',now());

select date_part('dow', current_date);

CREATE FUNCTION elimina_producto()
    RETURNS TRIGGER
    LANGUAGE plpgsql AS
    $$
        DECLARE dia_de_la_semana int;
        BEGIN
            SELECT date_part('dow', current_date) INTO dia_de_la_semana;
            IF dia_de_la_semana = 3
                THEN
                    RAISE EXCEPTION 'Base de Datos en mantenimiento, no se admite eliminaciones';
            END IF;
            RETURN OLD;
        END;
    $$;

CREATE TRIGGER tr_elimina_producto
    BEFORE DELETE
    ON productos
    FOR EACH ROW
    EXECUTE FUNCTION elimina_producto();

-- ************************** UNIDAD 5 ***************************
-- PROYECTO FINAL

CREATE TABLE audit_producto_stock
(
    id SERIAL PRIMARY KEY NOT NULL,
    fecha TIMESTAMP DEFAULT now(),
    usuario TEXT DEFAULT user,
    stock_previo INTEGER NOT NULL ,
    stock_actual INTEGER NOT NULL
);

CREATE FUNCTION fn_audit_producto_stock()
    RETURNS TRIGGER
    LANGUAGE plpgsql AS
    $$
        BEGIN
           INSERT INTO audit_producto_stock(stock_previo, stock_actual) SELECT
                OLD.cantidad_inventario, NEW.cantidad_inventario;

           RETURN NEW;
        END;
    $$;

CREATE TRIGGER tr_audit_producto_stock
    AFTER UPDATE OF cantidad_inventario
    ON productos
    FOR EACH ROW
    EXECUTE FUNCTION fn_audit_producto_stock();


CREATE OR REPLACE FUNCTION fn_agrega_nuevo_stock(id INTEGER, stock INTEGER)
    RETURNS VOID
    LANGUAGE plpgsql AS
    $$
        BEGIN
            IF stock > 0 THEN
                UPDATE productos
                SET cantidad_inventario = cantidad_inventario + stock
                WHERE id_producto = id;

                IF FOUND THEN
                    RAISE INFO 'Se agrego el nuevo stock';
                ELSE
                    RAISE EXCEPTION 'No se puedo agregar el nuevo stock';
                END IF;

            END IF;
        END;
    $$;


CREATE TYPE STOCK_PRODUCTO AS (
    id_producto INTEGER,
    nombre_prodcuto VARCHAR(50),
    stock INTEGER
);

CREATE OR REPLACE PROCEDURE agrega_stock_a_producto(IN STOCK_PRODUCTO)
    LANGUAGE plpgsql AS
    $$
        DECLARE stock ALIAS FOR $1;
        DECLARE item INT := 0;
        BEGIN
            SELECT count(prod.id_producto) INTO item
            FROM productos AS prod
            WHERE prod.id_producto = stock.id_producto AND
                  prod.nombre = stock.nombre_prodcuto;

            RAISE INFO 'Nro de producto con ID: % es igual a: %', stock.id_producto, item;

            IF item = 1 THEN
                PERFORM fn_agrega_nuevo_stock(stock.id_producto, stock.stock);
            END IF;
        END;
    $$;

CALL agrega_stock_a_producto((7, 'Monitor Samsung II', 15)::STOCK_PRODUCTO);




























