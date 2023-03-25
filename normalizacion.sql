create or replace table plumas_centro_comercial.centros_comerciales
(
    ID_CENTRO_COMERCIAL int auto_increment comment 'ID del centro comercial(llave primaria)'
        primary key,
    NOMBRE              varchar(50) not null comment 'Nombre del centro comercial'
);

create or replace table plumas_centro_comercial.membresias
(
    ID_MEMBRESIA int auto_increment comment 'ID de la membresía(llave primaria)'
        primary key,
    NOMBRE       varchar(50) not null comment 'Nombre de la membresía',
    DURACION     varchar(20) not null comment 'Duración de la membresía en días, semanas, meses o años'
);

create or replace table plumas_centro_comercial.plumas
(
    ID_PLUMA            int auto_increment comment 'ID de la pluma(llave primaria)'
        primary key,
    MARCA               varchar(25) not null comment 'Marca de la pluma',
    ID_CENTRO_COMERCIAL int         not null comment 'ID del centro comercial donde se encuentra la pluma(llave foranea)',
    constraint plumas_ibfk_1
        foreign key (ID_CENTRO_COMERCIAL) references plumas_centro_comercial.centros_comerciales (ID_CENTRO_COMERCIAL)
            on update cascade
);

create or replace table plumas_centro_comercial.entradas
(
    ID_ENTRADA      int auto_increment comment 'ID de la entrada(llave primaria)'
        primary key,
    ID_PLUMA        int         not null comment 'ID de la pluma donde se registró la entrada(llave foranea)',
    PLACA           varchar(50) not null comment 'Placa del vehículo que ingresó',
    TIPO_ENTRADA    varchar(50) not null comment 'Tipo de entrada(nombre de tabla, ya sea membresias o tickets)',
    ID_TIPO_ENTRADA int         not null comment 'ID del tipo de entrada("llave foranea" polimorfica)',
    FECHA_ENTRADA   datetime    not null comment 'Fecha y hora en que ingresó el vehículo',
    FECHA_SALIDA    datetime    not null comment 'Fecha y hora en que salió el vehículo',
    constraint entradas_ibfk_1
        foreign key (ID_PLUMA) references plumas_centro_comercial.plumas (ID_PLUMA)
            on update cascade
);

create or replace index ID_PLUMA
    on plumas_centro_comercial.entradas (ID_PLUMA);

create or replace index ID_CENTRO_COMERCIAL
    on plumas_centro_comercial.plumas (ID_CENTRO_COMERCIAL);

create or replace table plumas_centro_comercial.tickets_estados
(
    ID_ESTADO_TICKET int auto_increment comment 'ID del estado del ticket(llave primaria)'
        primary key,
    ESTADO           varchar(50) not null comment 'Estado del ticket'
);

create or replace table plumas_centro_comercial.tickets
(
    ID_TICKET int auto_increment comment 'ID del ticket(llave primaria)'
        primary key,
    ID_ESTADO int not null comment 'ID del estado del ticket(llave foranea)',
    ID_PLUMA  int not null comment 'ID del pluma(llave foranea)',
    constraint tickets_ibfk_1
        foreign key (ID_ESTADO) references plumas_centro_comercial.tickets_estados (ID_ESTADO_TICKET)
            on update cascade,
    constraint tickets_ibfk_2
        foreign key (ID_PLUMA) references plumas_centro_comercial.plumas (ID_PLUMA)
            on update cascade
);

create or replace index ID_ESTADO
    on plumas_centro_comercial.tickets (ID_ESTADO);

create or replace index ID_PLUMA
    on plumas_centro_comercial.tickets (ID_PLUMA);

create or replace table plumas_centro_comercial.usuarios
(
    DUI             varchar(10) not null comment 'Documento Único de Identidad(llave primaria)'
        primary key,
    PRIMER_NOMBRE   varchar(50) not null comment 'Primer nombre de la persona',
    PRIMER_APELLIDO varchar(50) not null comment 'Primer apellido de la persona'
);

create or replace table plumas_centro_comercial.membresias_suscripciones
(
    ID_SUSCRIPCIONES_MEMBRESIA int auto_increment comment 'ID de la suscripción a la membresía(llave primaria)'
        primary key,
    DUI_USUARIO                varchar(10) not null comment 'ID del usuario suscriptor(llave foranea)',
    ID_MEMBRESIA               int         not null comment 'ID de la membresía suscrita(llave foranea)',
    FECHA_INICIO               date        not null comment 'Fecha de inicio de la suscripción',
    FECHA_CIERRE               date        not null comment 'Fecha de fin de la suscripción',
    constraint membresias_suscripciones_ibfk_1
        foreign key (DUI_USUARIO) references plumas_centro_comercial.usuarios (DUI)
            on update cascade,
    constraint membresias_suscripciones_ibfk_2
        foreign key (ID_MEMBRESIA) references plumas_centro_comercial.membresias (ID_MEMBRESIA)
            on update cascade
);

create or replace index DUI_USUARIO
    on plumas_centro_comercial.membresias_suscripciones (DUI_USUARIO);

create or replace index ID_MEMBRESIA
    on plumas_centro_comercial.membresias_suscripciones (ID_MEMBRESIA);

