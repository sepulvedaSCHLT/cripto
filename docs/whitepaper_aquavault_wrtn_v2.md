# Whitepaper – AQUAVAULT (WRTN)
## Proyecto ecológico para la creación de reservas de agua potable

---

## 1. Introducción

El agua potable es un recurso cada vez más escaso. Según la ONU, más de 2.000 millones de personas carecen de acceso seguro al agua, y se estima que para 2030 la demanda global podría superar en un 40 % la disponibilidad actual.

En este contexto, se hace urgente desarrollar modelos de financiamiento que permitan acelerar la creación de infraestructuras hídricas sostenibles, transparentes y auditables.

AQUAVAULT (WRTN) nace con la intención de conectar el ecosistema cripto con la creación de reservas reales de agua potable y, en fases posteriores, utilizar esta misma agua como recurso estratégico para infraestructura tecnológica.

---

## 2. Objetivo del Proyecto

AQUAVAULT (WRTN) busca financiar y desarrollar reservas de agua potable, beneficiando directamente a los poseedores del token y a comunidades que necesitan acceso a agua segura.

Los objetivos principales son:

- **Asegurar reservas de agua potable** a través de proyectos físicos (pozos, plantas, almacenamiento).
- **Mejorar la eficiencia energética** apoyando sistemas de enfriamiento sostenible con agua para servidores y minería de criptomonedas.
- **Integrar tecnología blockchain** como capa de transparencia financiera y trazabilidad de fondos.
- **Crear un activo digital sólido**, con reglas claras de emisión, límites de concentración y mecanismos de protección para los usuarios.

---

## 3. Características del Token

### 3.1 Datos generales

- **Nombre:** AQUAVAULT  
- **Símbolo:** WRTN  
- **Red:** Binance Smart Chain – estándar BEP-20  
- **Decimales:** 18  
- **Suministro inicial:** 100.000.000 WRTN  
- **Tipo de contrato:** Token BEP-20 no actualizable (no proxy / no upgradeable)

### 3.2 Límite por wallet (anti-ballenas)

Con el fin de reducir riesgos de manipulación extrema de mercado y concentraciones excesivas, el contrato implementa una lógica de límite por wallet:

- **Límite máximo duro:** ninguna wallet (excepto la del owner o direcciones exentas) puede superar el **30 %** del suministro total.
- El owner puede **ajustar dinámicamente el porcentaje máximo permitido** hacia arriba o hacia abajo en caso de necesitar más descentralización o mayor flexibilidad de liquidez, **pero nunca puede superar el 30 %**.
- Este límite se aplica a transferencias y recepciones de tokens cuando la funcionalidad está habilitada.

### 3.3 Comisión del 2 % (fee ecológico)

Cada transferencia de WRTN puede estar sujeta a un **fee del 2 %**, destinado a un fondo para proyectos de agua potable:

- **Porcentaje de fee:** 2 % del monto transferido.
- **Destino del fee:** una wallet específica asignada al **Fondo de Reservas de Agua**.
- La comisión se descuenta automáticamente de la transacción cuando la funcionalidad de fee está habilitada.
- Ciertas direcciones (por ejemplo, el propio fondo, direcciones técnicas o de liquidez) pueden ser marcadas como **exentas de fee**, para no penalizar operaciones críticas.

Cuando el fee está desactivado, las transferencias funcionan como un BEP-20 estándar sin comisión adicional.

### 3.4 Funciones de emisión y quema (mint / burn)

El diseño del suministro de WRTN combina seguridad, flexibilidad controlada y participación de la comunidad:

- **Mint (creación de tokens):**
  - Solo el **owner** del contrato puede crear nuevos tokens.
  - La función se utiliza para financiar fases posteriores del proyecto, siempre bajo una política transparente documentada.
  - Todos los eventos de mint quedan registrados on-chain.

- **Burn por parte de los usuarios:**
  - **Cualquier titular de WRTN** puede quemar voluntariamente sus propios tokens.
  - Esto reduce el suministro circulante y puede aumentar la escasez del activo.
  - La lógica de burn está diseñada para que *solo* el dueño de los tokens pueda destruirlos; no se permite quemar fondos ajenos.

- **Burn desde el owner (si se utiliza):**
  - El owner puede quemar tokens desde su propia posición de tesorería para ajustar la tokenomics si fuera necesario.
  - Esta acción también queda registrada en el historial on-chain.

> Nota: Aunque en testnet se han realizado pruebas de mint y burn para validar la lógica, en mainnet las políticas de emisión y quema se documentarán públicamente (whitepaper, web y repositorio) antes de ser ejecutadas.

### 3.5 Pausa de transfers (Pausable)

El contrato incorpora una funcionalidad de **pausa global** de transferencias:

- En caso de emergencia (fallo crítico, ataque, incidente regulatorio), el owner puede pausar las transferencias.
- Mientras el contrato está en pausa:
  - No se pueden mover tokens entre wallets (salvo excepciones estrictamente necesarias si se definieron).
- Cuando el riesgo desaparece, se puede **reanudar** la operativa.
- Todas las acciones de pausa y reanudación quedan registradas on-chain.

Esta función actúa como un “cortacircuitos” de seguridad para proteger a los usuarios.

### 3.6 Cambio de direcciones críticas

Para gestionar el proyecto a largo plazo y aumentar la robustez operativa, el contrato permite:

- **Actualizar la wallet del Fondo de Reservas de Agua** (por ejemplo, si se migra a una multisig o a una entidad regulada).
- **Transferir la propiedad del contrato** a otra entidad (por ejemplo, una fundación o DAO en etapas posteriores).

Estos cambios solo pueden ser ejecutados por el owner vigente y generan eventos on-chain verificables.

---

## 4. Tokenomics del Proyecto

### 4.1 Flujo de la comisión del 2 %

El 2 % de fee se orienta a financiar proyectos reales de agua potable. Un esquema simplificado:

1. Usuario A envía WRTN a Usuario B.  
2. Del monto total:
   - 98 % llega a B.
   - 2 % se redirige a la **wallet del Fondo de Reservas de Agua**.
3. Los fondos acumulados en esa wallet se destinan a:
   - Diseño y construcción de reservas de agua potable.
   - Mantenimiento, operación y auditoría de las infraestructuras.
   - Iniciativas complementarias (educación, tecnología, estudios de impacto).

Cuando el fee está deshabilitado, este flujo se detiene temporalmente y las transferencias se realizan al 100 % sin comisión.

### 4.2 Distribución inicial (ejemplo de referencia)

La distribución exacta para mainnet será publicada oficialmente, pero un esquema razonable de referencia podría ser:

- **Tesorería del proyecto**: reservas para desarrollo, partnerships y expansión.
- **Liquidez en DEX/CEX**: tokens destinados a pools de liquidez para facilitar la libre negociación.
- **Programa comunitario**: incentivos a largo plazo para holders, comunidad y colaboradores.
- **Fondo de desarrollo tecnológico**: evolución del ecosistema AQUAVAULT (integración con oráculos, dApps, etc.).

> En testnet, los montos y movimientos actuales solo tienen fines de prueba y no representan la tokenomics final de producción.

---

## 5. Roadmap (alto nivel)

### Fase 1 – Fundamentos técnicos y pruebas (completado / en curso)

- Diseño y desarrollo del contrato BEP-20 de AQUAVAULT (WRTN).
- Pruebas en testnet:
  - Límite por wallet.
  - Fee del 2 % y exenciones.
  - Mint, burn, pausa y reanudación.
- Publicación del código en GitHub con documentación técnica básica.
- Creación del whitepaper y README del repositorio.

### Fase 2 – Lanzamiento en mainnet y primeros proyectos

- Auditoría externa (cuando el presupuesto lo permita).
- Despliegue del contrato en Binance Smart Chain mainnet.
- Creación de liquidez inicial en DEX.
- Selección y anuncio del **primer proyecto de reserva de agua**.
- Dashboard público para seguir el uso de fondos recaudados por el fee.

### Fase 3 – Expansión y utilidad tecnológica

- Integración de AQUAVAULT con infraestructuras de enfriamiento sostenible para servidores y/o minería.
- Nuevos partnerships con proyectos ecológicos y tecnológicos.
- Evaluación de gobernanza futura (DAO o estructura híbrida) para la toma de decisiones sobre fondos y roadmap.

---

## 6. Riesgos y Consideraciones

A pesar de las medidas técnicas implementadas, AQUAVAULT (WRTN) no está exento de riesgos:

- **Riesgo de mercado:** el precio del token puede ser altamente volátil.
- **Riesgo regulatorio:** cambios normativos en diferentes países pueden afectar al proyecto.
- **Riesgo operativo:** mala ejecución de proyectos de agua en el mundo real podría reducir el impacto esperado.
- **Riesgo tecnológico:** vulnerabilidades no detectadas en el contrato o en infraestructuras de terceros.

Los usuarios deben realizar su propia investigación (**DYOR**) y comprender que AQUAVAULT no ofrece rentabilidades garantizadas ni constituye asesoría financiera.

---

## 7. Conclusión

AQUAVAULT (WRTN) es un token BEP-20 diseñado para unir el ecosistema cripto con proyectos reales de impacto en el acceso al agua potable y, en fases posteriores, con la infraestructura tecnológica que se beneficia de este recurso.

El contrato combina:

- Mecanismos anti-ballenas (límite por wallet ajustable con tope 30 %),
- Un fee del 2 % orientado a un fondo ecológico,
- Capacidades de mint y burn controladas,
- Funciones de pausa y actualización de wallets críticas,

todo ello con el objetivo de ofrecer un activo transparente, verificable on-chain y orientado a un propósito ambiental concreto.

Este whitepaper se actualizará conforme el proyecto avance, se incorporen auditorías externas y se concreten los primeros proyectos físicos de reservas de agua financiados por AQUAVAULT (WRTN).
