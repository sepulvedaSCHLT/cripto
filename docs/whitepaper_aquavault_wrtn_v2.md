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
- **Suministro máximo fijo:** 200.000.000 WRTN  
- **Emisión adicional:** no existe función de mint posterior al despliegue (supply cerrado).  
- **Tipo de contrato:** Token BEP-20 no actualizable (no proxy / no upgradeable)

El suministro total se crea en el momento del despliegue y se distribuye según la tokenomics definida. A partir de ese punto no se pueden generar nuevos WRTN; el token solo puede volverse deflacionario mediante quema voluntaria.

---

### 3.2 Límite por wallet (anti-ballenas)

Con el fin de reducir riesgos de manipulación extrema de mercado y concentraciones excesivas, el contrato implementa una lógica de límite por wallet:

- **Límite máximo duro:** ninguna wallet externa puede superar el **30 %** del suministro total.
- El owner puede **ajustar dinámicamente el porcentaje máximo permitido**, hacia arriba o hacia abajo, **pero nunca puede superar el 30 %** (tope duro codificado en el contrato).
- Este límite se aplica únicamente a **wallets externas**; pueden ser excluidas del límite:
  - La wallet del owner,
  - La wallet de reserva de agua,
  - La pool de liquidez principal,
  - Otras wallets internas del proyecto (tesorería, marketing, desarrollo, etc.) marcadas explícitamente.

El objetivo es evitar que una sola wallet externa acumule una porción desproporcionada del supply, reduciendo el riesgo de dumps masivos y manipulación de precio.

---

### 3.3 Comisión ecológica (fee 0–2 %)

Cada transferencia de WRTN puede estar sujeta a un **fee ecológico** destinado al Fondo de Reservas de Agua.

- **Rango de fee permitido:** entre **0 % y 2 %** (0–200 basis points).  
- **Valor objetivo de operación:** 2 % destinado al Fondo de Reserva de Agua.  
- **Destino del fee:** una wallet específica asignada al **Fondo de Reservas de Agua**.  
- **Exenciones:** ciertas direcciones (por ejemplo, la propia wallet de reserva, direcciones técnicas o de liquidez) pueden ser marcadas como **exentas de fee**, para no penalizar operaciones críticas.

El propio contrato impide cualquier valor de fee superior al 2 %: no es posible establecer comisiones confiscatorias más allá de ese límite.

Cuando el fee está configurado en 0 %, las transferencias se comportan como un BEP-20 estándar sin comisión adicional.

---

### 3.4 Funciones de quema (burn)

El diseño del suministro de WRTN está orientado a la seguridad y la deflación voluntaria:

- **No existe mint posterior al despliegue:**
  - Todo el suministro (200.000.000 WRTN) se crea en el constructor del contrato.
  - No hay función pública de creación de nuevos tokens.

- **Burn por parte de los usuarios (deflación voluntaria):**
  - **Cualquier titular de WRTN** puede quemar voluntariamente sus propios tokens mediante una función pública `burn()`.
  - Esto reduce el suministro circulante y el suministro total.
  - La lógica de burn está diseñada para que *solo* el dueño de los tokens pueda destruirlos; no se permite quemar fondos ajenos.

Este enfoque convierte a WRTN en un activo con **supply fijo máximo y potencialmente deflacionario**, dependiendo del comportamiento de los holders y de las posibles campañas de quema que el propio proyecto pueda incentivar.

---

### 3.5 Cambio de direcciones críticas

Para gestionar el proyecto a largo plazo y aumentar la robustez operativa durante la fase inicial, el contrato permite:

- **Actualizar la wallet del Fondo de Reservas de Agua**  
  (por ejemplo, si se migra a una multisig o a una entidad regulada).
- **Registrar la dirección de la pool de liquidez principal**  
  (por ejemplo, el par WRTN/BNB en PancakeSwap) y excluirla del límite por wallet para garantizar la operativa normal del mercado.
- **Marcar wallets internas del proyecto** como excluidas de:
  - Fee (para evitar comisiones en operaciones de tesorería, liquidez, etc.),
  - Límite por wallet (para permitir una gestión estructurada de reservas y fondos internos).

Estos cambios solo pueden ser ejecutados por el owner durante la fase ajustable y generan eventos on-chain verificables.

---

## 4. Tokenomics del Proyecto

### 4.1 Flujo de la comisión ecológica

El fee se orienta a financiar proyectos reales de agua potable. Un esquema simplificado:

1. El Usuario A envía WRTN al Usuario B.  
2. Del monto total:
   - Una parte llega al receptor (por ejemplo, 98 % si el fee está en 2 %).
   - La fracción correspondiente al fee (por ejemplo, 2 %) se redirige a la **wallet del Fondo de Reservas de Agua**.
3. Los fondos acumulados en esa wallet se destinan a:
   - Diseño y construcción de reservas de agua potable.
   - Mantenimiento, operación y auditoría de las infraestructuras.
   - Iniciativas complementarias (educación, tecnología, estudios de impacto).

Si el fee se ajusta a 0 %, este flujo se detiene y todas las transferencias se realizan al 100 % sin comisión, conservando la lógica de límite por wallet.

---

### 4.2 Distribución inicial del suministro

La distribución base, sobre un suministro máximo de **200.000.000 WRTN**, está planteada de forma que equilibre sostenibilidad financiera, liquidez de mercado y capacidad de ejecución del proyecto:

- **Fondo de Reserva de Agua – 50 % (100.000.000 WRTN)**  
  Financia proyectos de agua potable y sostenibilidad ambiental.

- **Liquidez Inicial – 20 % (40.000.000 WRTN)**  
  Provisión de liquidez en DEX/CEX para facilitar la libre negociación y reducir volatilidad excesiva.

- **Marketing y Promoción – 15 % (30.000.000 WRTN)**  
  Campañas de adopción, listados, alianzas estratégicas y presencia de marca en el ecosistema cripto y ecológico.

- **Desarrollo Tecnológico – 10 % (20.000.000 WRTN)**  
  Evolución del contrato inteligente, integraciones Web3, herramientas de monitoreo y futuros desarrollos de infraestructura tecnológica asociada al agua.

- **Fondo de Emergencia – 5 % (10.000.000 WRTN)**  
  Auditorías, seguridad, mitigación de incidentes y contingencias operativas.

La asignación exacta en mainnet y los movimientos relevantes de estas wallets se documentarán en:

- Sitio web oficial,  
- Whitepaper,  
- Repositorio de GitHub,  
- Canales de comunicación del proyecto.

---

## 5. Gobernanza del contrato inteligente

### 5.1 Modelo de dos fases

El contrato de AQUAVAULT (WRTN) ha sido diseñado con un modelo de gobernanza en **dos fases**:

1. Una **fase ajustable inicial**, donde el owner dispone de un margen controlado para ajustar parámetros clave dentro de límites estrictos ya codificados.
2. Una fase final de **inmutabilidad total**, lograda mediante la llamada a `renounceOwnership()`, que deja el contrato sin propietario y sin capacidad de modificación administrativa.

Este enfoque busca combinar flexibilidad responsable en el arranque con máxima confianza a largo plazo para holders e inversores.

---

### 5.2 Parámetros ajustables (con límites codificados)

Mientras exista un `owner` activo, se pueden ajustar solo los siguientes parámetros, siempre dentro de rangos definidos en el código:

- **Fee de transacción (0 % – 2 %)**  
  - Parámetro: `feeBasisPoints` (basis points; 100 = 1 %, 200 = 2 %).  
  - Rango permitido: **0 a 200 bps**.  
  - El contrato **rechaza cualquier intento** de establecer un fee superior al 2 %.

- **Límite de posesión por wallet (0 % – 30 % del suministro)**  
  - Parámetro: `maxWalletBps`.  
  - Tope duro codificado: 3.000 bps = **30 %** del suministro total.  
  - El owner puede reducir o incrementar el límite dentro de este rango, pero nunca sobrepasar el 30 %.

- **Wallet de reserva y wallets internas**  
  - `setReserveWallet()` define la dirección donde se acumula el fee ecológico.  
  - `setLiquidityPool()` marca la pool de liquidez principal y la excluye del límite por wallet.  
  - `setExcludedFromFees()` y `setExcludedFromMaxWallet()` permiten declarar wallets internas que no deben pagar fee o no deben estar sujetas al límite por wallet (tesorería, marketing, desarrollo, etc.).

Incluso durante esta fase, se mantienen dos garantías clave:

- El **suministro máximo de 200.000.000 WRTN no puede aumentar**.  
- **Cualquier holder** puede quemar sus tokens mediante `burn()`, reduciendo el supply total.

---

### 5.3 Fase ajustable (“bootstrapping phase”)

La fase ajustable corresponde al período en el que el equipo de AQUAVAULT:

- Configura y prueba:
  - Fee de transacción dentro del rango 0–2 %,
  - Límite de tenencia por wallet dentro del rango 0–30 %,
  - Wallet de reserva, liquidez y wallets internas.
- Observa el comportamiento real del mercado y el impacto del fee ecológico.
- Corrige, si es necesario, desajustes iniciales siempre bajo las restricciones definidas en el contrato.

Todos los cambios administrativos realizados en esta etapa:

- Quedan registrados on-chain y son visibles en BscScan.
- Se comunicarán en los canales oficiales del proyecto (web, GitHub, redes sociales).

El objetivo no es mutar arbitrariamente la tokenomics, sino **afinarla en producción** antes de fijarla para siempre.

---

### 5.4 Renuncia a la propiedad e inmutabilidad

Cuando:

- El fee de transacción se haya validado como sostenible,
- El límite máximo por wallet externa esté definido,
- La configuración de wallets internas y liquidez esté consolidada,

el equipo ejecutará la función:

```solidity
renounceOwnership()

