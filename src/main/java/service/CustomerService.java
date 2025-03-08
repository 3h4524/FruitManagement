package service;

import dao.GenericDAO;
import jakarta.persistence.EntityManager;
import model.Customer;
import org.mindrot.jbcrypt.BCrypt;
import java.util.List;

public class CustomerService {
    private GenericDAO<Customer> customerDao = new GenericDAO<>(Customer.class);
    public List<Customer> getAllCustomer() {
        return customerDao.getAll();
    }

    public Customer getCustomerById(int id) {
        return customerDao.findById(id);
    }

    public boolean addCustomer(Customer customer) {
        return customerDao.insert(customer);
    }

    public boolean updateCustomer(Customer customer) {
        return customerDao.update(customer);
    }

    public boolean deleteCustomer(int id) {
        Customer customer = customerDao.findById(id);
        if (customer != null) {
            customer.setStatus("INACTIVE");
            customerDao.update(customer);
            return true;
        }
        return false;
    }

    public List<Customer> getCustomerByName(String name){
        return customerDao.findByName(name);
    }

    public Customer checkExistUserName(String username) {
        return customerDao.findByUserName(username);
    }


    public static void main(String[] args) {

    }
}
