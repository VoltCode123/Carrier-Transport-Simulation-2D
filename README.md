# Carrier-Transport-Simulation-2D


---

## Carrier Transport Simulation in Semiconductors (2D)  

### Overview  
This project simulates **2D carrier transport** in a semiconductor under an **applied voltage bias** while incorporating **recombination and generation effects**. It is designed for **GNU Octave** and provides **visualizations of electron and hole densities** over time.  

### Features  
- **2D carrier transport modeling** with user-defined parameters  
- **Voltage bias application** to simulate semiconductor devices  
- **Drift and diffusion current calculations**  
- **Shockley-Read-Hall (SRH) recombination modeling**  
- **Real-time visualization** of carrier densities  

### Dependencies  
- GNU Octave (recommended for compatibility)  
- Gnuplot (for visualization)  

### How to Run  
1. **Install GNU Octave** (if not installed)  
2. **Run the script** in Octave:  
   ```octave
   newcarrier_transport_2D
   ```
3. **Enter required inputs**, such as temperature, semiconductor size, number of grid points, time steps, and applied voltage.  
4. **Visualize carrier concentration changes** over time.  

### Input Parameters  
| Parameter | Description | Unit |  
|-----------|-------------|------|  
| Temperature | Semiconductor temperature | K |  
| Lx, Ly | Semiconductor dimensions | μm |  
| Nx, Ny | Grid resolution | - |  
| Nt | Number of time steps | - |  
| dt | Time step duration | ps |  
| V_bias | Applied voltage | V |  

### Output  
- **Electron and hole density plots** in **log scale**  
- **Dynamic visualization** of carrier transport over time  

### License  
This project is open-source. Feel free to use and modify it.  

----
