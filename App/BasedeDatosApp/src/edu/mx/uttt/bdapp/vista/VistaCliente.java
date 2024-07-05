/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package edu.mx.uttt.bdapp.vista;
import edu.mx.uttt.bdapp.entidades.Cliente;
import edu.mx.uttt.bdapp.control.CtrlCliente;

/**
 *
 * @author jlgallardoadmon
 */
public class VistaCliente {
    public static void main(String[] args) {
         
        Cliente c1 = new Cliente();
        c1.setCustomerId("DSMG3");
        c1.setCompanyName("Gallina de Hule");
        c1.setContactName("Lizeth Ksumi Pando");
        c1.setContactTitle("Gerente de ASI");
        c1.setAddress("Av. Libre");
        c1.setCity("Salte si Puedes");
        c1.setRegion("Este");
        c1.setPostalCode("42800");
        c1.setCountry("Irlanda");
        c1.setPhone("566-77654");
        c1.setFax("35345435");
        
        
        // Enviar el objeto Cliente al control Cliente
        CtrlCliente ctrlCli = new CtrlCliente();
        ctrlCli.agregar(c1);
        
    }
}
