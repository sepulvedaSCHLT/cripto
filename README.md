# Whitepaper – AQUAVAULT (WRTN)
## Proyecto ecológico para la creación de reservas de agua potable

---

## 1. Introducción

El agua potable es un recurso cada vez más escaso. Según estimaciones de organismos
internacionales, más de 2.200 millones de personas carecen de acceso seguro al agua, y se
proyecta que para 2030 la demanda global podría superar en torno a un 40% la disponibilidad
actual.

En este contexto, se hace urgente desarrollar modelos sostenibles de financiación y gestión
de infraestructuras hídricas que permitan:

- Asegurar reservas de agua potable.
- Mejorar la eficiencia energética en sectores intensivos en consumo eléctrico.
- Integrar tecnología blockchain como capa de transparencia, trazabilidad y gobernanza.

AQUAVAULT (WRTN) nace con la intención de conectar el ecosistema cripto con la creación
de reservas reales de agua potable y, en fases posteriores, con sistemas de enfriamiento
sostenible para infraestructura tecnológica.

---

## 2. Objetivo del proyecto

AQUAVAULT (WRTN) tiene un doble objetivo:

1. **Financiar y desarrollar reservas de agua potable**, almacenadas y gestionadas bajo
   criterios técnicos y ambientales, con controles transparentes para la comunidad.

2. **Aprovechar dichas reservas en aplicaciones de enfriamiento sostenible** para:
   - Centros de datos.
   - Servidores.
   - Operaciones de minería de criptomonedas u otras infraestructuras intensivas en cómputo.

La visión es que el token WRTN represente, indirectamente, exposición a un activo
estratégico (agua potable y capacidad de enfriamiento) y, al mismo tiempo, contribuya a
reducir el impacto ambiental de la tecnología blockchain.

---

## 3. Características del token

- **Red**: BNB Smart Chain (BEP-20).
- **Nombre**: AQUAVAULT.
- **Símbolo**: `WRTN`.
- **Decimales**: 18.
- **Suministro inicial**: `100,000,000 WRTN`.
- **Tipo de contrato**: ERC20/BEP20 extendido con lógica propia:
  - Límite máximo por wallet (configurable con tope del 30%).
  - Fee fijo del 2% para fondo de agua, cuando está habilitado.
  - Funciones de pausa global (modo emergencia).
  - Funciones de mint y burn bajo reglas controladas.

El contrato está diseñado para ser **no upgradable** en su versión mainnet: una vez
desplegado, su lógica no puede ser reemplazada, lo que aumenta la previsibilidad para
los holders.

---

## 4. Mecanismos del contrato inteligente

### 4.1 Límite máximo por wallet (tope del 30%)

AQUAVAULT implementa un límite máximo de tokens que puede mantener una dirección, expresado como un
porcentaje del suministro total.

- El porcentaje se almacena en una variable interna que representa el **límite máximo por wallet**.
- El contrato establece un **tope duro del 30%** del suministro total:
  - Ninguna wallet sujeta al límite puede superar el 30% del total de tokens en circulación.
- El porcentaje máximo por wallet es **configurable**:
  - Puede ajustarse hacia arriba o hacia abajo en función de las necesidades del proyecto.
  - El valor configurado nunca puede superar el 30%.

Algunas direcciones técnicas pueden ser **exentas** de este límite (por ejemplo, ciertos
contratos, pools o wallets operativas), lo que permite gestionar liquidez, tesorería y
otras funciones sin romper la lógica de protección a los holders.

Este mecanismo busca evitar concentraciones excesivas y reducir el riesgo de manipulación,
manteniendo flexibilidad para adaptarse a nuevas fases (listados, pools, acuerdos con CEX, etc.).

---

### 4.2 Fee ecológico del 2% para el fondo de agua

El contrato define un **fee fijo del 2%** sobre el monto transferido, que se aplica
cuando el mecanismo de fee está habilitado.

- Cuando el fee está activo:
  - El 2% de cada transferencia sujeta a fee se destina a una dirección de tesorería
    denominada **fondo de agua**.
  - El 98% restante llega al destinatario.
- El fee puede estar **habilitado o deshabilitado** según la fase del proyecto.
- Algunas direcciones (por ejemplo, wallets internas del proyecto o contratos específicos)
  pueden estar **exentas** del fee, de forma que sus movimientos no generan comisión.

La finalidad del fee es crear un flujo constante de recursos hacia el fondo de agua,
ligando directamente la actividad on-chain con el avance del proyecto ecológico.

---

### 4.3 Función de pausa (modo emergencia)

El contrato incluye una funcionalidad de **pausa global**:

- Cuando el contrato está en modo pausado:
  - Las transferencias y otras operaciones sujetas a esta condición se revierten.
- Una vez resuelto el incidente o condición de riesgo, el contrato puede volver a su
  funcionamiento normal mediante la reanudación.

Este mecanismo está pensado para situaciones excepcionales (fallos críticos, ataques,
vulnerabilidades detectadas) y añade una capa de protección adicional para los holders.

---

### 4.4 Mint y burn

#### Mint (creación de nuevos tokens)

- La lógica de mint permite **acuñar nuevos WRTN y asignarlos a una dirección específica**.
- Solo la dirección propietaria del contrato (owner) puede invocar esta funcionalidad.
- Cada acción de mint:
  - Incrementa el balance de la dirección de destino.
  - Incrementa el `totalSupply` del token.

La existencia de mint se justifica para:

- Adaptar la oferta a nuevas fases del proyecto.
- Financiar infraestructura o acuerdos estratégicos de forma transparente.

La política de uso de mint debe estar bien definida y comunicada a la comunidad.

#### Burn (quema voluntaria por parte de los usuarios)

- Cualquier holder puede **quemar** parte de sus tokens de forma voluntaria.
- El burn se aplica **sobre el propio balance del usuario**.
- Al quemar:
  - Se reduce el balance del usuario.
  - Se reduce el `totalSupply`.

Esto ofrece una herramienta para quienes deseen contribuir a la reducción de oferta a largo
plazo o ajustar su exposición.

---

### 4.5 Gobernanza técnica y propiedad del contrato

El contrato tiene una dirección de **propietario (owner)** que:

- Gestiona parámetros clave:
  - Límite máximo por wallet y su porcentaje (siempre ≤ 30%).
  - Activación/desactivación del fee y definición del fondo de agua.
  - Exenciones de fee y de límite por wallet para direcciones específicas.
  - Activación del modo pausa / reanudación.
  - Funciones de mint.

La propiedad del contrato puede ser transferida a otra dirección para:

- Migrar a una **wallet multi-firma** (recomendado en mainnet).
- Renovar la estructura de control en función de la gobernanza definida para el proyecto.

---

## 5. Tokenomics

El diseño de tokenomics de AQUAVAULT (WRTN) busca equilibrar:

- Financiación directa de reservas de agua.
- Sostenibilidad del proyecto a nivel técnico y de marketing.
- Un margen razonable para desarrollo y contingencias.

Distribución propuesta del suministro inicial de `100,000,000 WRTN`:

- **Fondo de agua / reservas ecológicas**: 50%
- **Liquidez inicial**: 20%
- **Marketing y promoción**: 15%
- **Desarrollo tecnológico**: 10%
- **Fondo de emergencia**: 5%

Esta distribución puede representarse visualmente en forma de gráfico (pie/donut) en los
materiales de presentación y en la página web oficial del proyecto.

El **fee del 2%** se suma como mecanismo adicional de financiación continua para el fondo
de agua, especialmente relevante una vez exista volumen de trading significativo.

---

## 6. Fases del proyecto

El roadmap de AQUAVAULT se estructura en varias fases:

### Fase 1 – Creación de reservas de agua potable

- Identificación de ubicaciones viables y seguras.
- Diseño técnico de las reservas.
- Implementación de soluciones de almacenamiento, tratamiento y monitoreo.
- Integración de reportes transparentes para la comunidad de holders.

### Fase 2 – Sistemas de enfriamiento sostenible

- Uso controlado de parte de las reservas de agua en sistemas de enfriamiento
  para servidores, centros de datos y minería de criptomonedas.
- Búsqueda de acuerdos con operadores de infraestructura tecnológica.
- Enfoque en la mejora de la eficiencia energética y reducción de huella de carbono.

### Fase 3 – Expansión e integración

- Expansión geográfica de las reservas de agua.
- Nuevas alianzas estratégicas con actores del sector hídrico y tecnológico.
- Posible integración con soluciones de gobernanza descentralizada (DAO) para decisiones
  clave del proyecto.

---

## 7. Riesgos y mitigación

Como todo proyecto cripto, AQUAVAULT (WRTN) está expuesto a múltiples riesgos:

- **Riesgo de mercado**: volatilidad en el precio del token.
- **Riesgo regulatorio**: cambios normativos en distintos países.
- **Riesgo tecnológico**: vulnerabilidades en contratos, infraestructuras o integraciones.
- **Riesgo de ejecución**: retrasos o dificultades en la implementación física de reservas de agua.

Medidas de mitigación contempladas:

- Auditorías de código del contrato inteligente antes del despliegue en mainnet.
- Transparencia en el uso del fondo de agua (reportes y trazabilidad on-chain).
- Planificación por fases que permita ajustar la estrategia según la respuesta del mercado
  y el entorno regulatorio.
- Uso de estructuras más seguras (por ejemplo, multi-firma) para custodiar fondos y
  controlar funciones críticas del contrato.

---

## 8. Conclusión

AQUAVAULT (WRTN) no es solo un token: es un intento de conectar el mundo cripto con
soluciones concretas a un problema real y creciente, la escasez de agua potable, y con la
necesidad de hacer más sostenible la infraestructura tecnológica.

El diseño del contrato inteligente —con límite dinámico por wallet, fee ecológico del 2%,
funciones de pausa, mint y burn controlados— busca un equilibrio entre:

- Protección y confianza para los holders.
- Flexibilidad para el equipo en la gestión del proyecto.
- Alineación directa entre la actividad on-chain y el impacto ecológico.

Este whitepaper resume la visión, mecánica y tokenomics de AQUAVAULT en su versión actual
de diseño, incluyendo la actualización del límite máximo por wallet para permitir ajustes
dentro de un tope del 30% sin alterar el resto de reglas fundamentales del contrato.
