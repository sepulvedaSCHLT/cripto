# AQUAVAULT (WRTN) – Smart Contracts

AQUAVAULT (WRTN) es un token BEP-20 desplegado en Binance Smart Chain con propósito ecológico.  
El objetivo del proyecto es financiar la creación y mantenimiento de **reservas reales de agua potable** y, en una segunda fase, desarrollar soluciones de **enfriamiento sostenible** para centros de datos y operaciones de minería de criptomonedas.

> Este repositorio contiene el código del contrato inteligente y la documentación técnica del proyecto AQUAVAULT (WRTN).

---

## Características del token

- **Red:** Binance Smart Chain (BEP-20)  
- **Nombre:** AQUAVAULT  
- **Símbolo:** WRTN  
- **Suministro total:** 100,000,000 WRTN  
- **Comisión:** 2 % de cada transacción destinada a un fondo de agua  
- **Límite por wallet:** máximo 30 % del suministro total por dirección (excepto la wallet del owner)  
- **Funciones de control:**  
  - `mint` y `burn` controlados por el owner  
  - lógica adicional de seguridad (se añadirá en la nueva versión del contrato)

> ⚠️ La dirección final del contrato se añadirá aquí cuando el nuevo contrato sea desplegado de forma definitiva en BSC.

---

## Estructura del repositorio

Actualmente el repositorio incluye:

- `tokenaquavault.sol` – versión actual del contrato del token AQUAVAULT (WRTN)  
- `tokenproject.sol` – otros experimentos / contratos anteriores  
- `whitepaper_aquavault_wrtn.pdf` – whitepaper del proyecto  
- `logo_32x32.svg`, `logo_aquavault_fixed_32x32.svg` – recursos gráficos del token  

En futuras versiones se organizará en:

- `contracts/` – contratos inteligentes en Solidity  
- `docs/` – documentación y whitepaper  
- `assets/` – logos y material gráfico

---

## Objetivo del proyecto

1. **Fondo de agua potable**  
   - Un porcentaje de cada transacción se envía a un fondo de agua.  
   - Este fondo está destinado a financiar proyectos de captación, almacenamiento y potabilización en zonas de alta necesidad.

2. **Enfriamiento sostenible para infraestructuras blockchain**  
   - En una segunda fase, las reservas de agua se integrarán en sistemas de enfriamiento para centros de datos y minería, buscando reducir la huella hídrica y energética del ecosistema cripto.

---

## Enlaces oficiales

- Sitio web: _próximamente_  
- X (Twitter): https://x.com/AQUAVAULT_WRTN  
- LinkedIn: página de empresa **AQUAVAULT (WRTN)**  
- Telegram: _próximamente_  

Cuando el sitio web y los demás canales estén disponibles de forma definitiva, se actualizarán estos enlaces.

---

## Aviso

Este repositorio y su contenido tienen fines exclusivamente informativos y educativos.  
Nada de lo aquí publicado constituye asesoría financiera ni invitación a invertir.  
Haz siempre tu propia investigación (**DYOR**) y comprende los riesgos asociados a las criptomonedas.
