package com.crud.crud.app;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/employees")
// @CrossOrigin(origins = "http://localhost:5173") // Adjust the CORS policy if needed
public class EmployeeController {
    @Autowired
    private EmployeeRepository employeeRepository;

    @GetMapping
    public List<Employee> getAllEmployees() {
        return employeeRepository.findAll();
    }

    @GetMapping("/{id}")
    public Optional<Employee> getEmployeeById(@PathVariable String id) {
        return employeeRepository.findById(id);
    }

    @PostMapping
    public Employee createEmployee(@RequestBody Employee employee) {
        return employeeRepository.save(employee);
    }

    @PutMapping("/{id}")
    public Employee updateEmployee(@PathVariable String id, @RequestBody Employee employee) {
        return employeeRepository.findById(id)
                .map(existingEmployee -> {
                    existingEmployee.setName(employee.getName());
                    existingEmployee.setPosition(employee.getPosition());
                    existingEmployee.setSalary(employee.getSalary());
                    return employeeRepository.save(existingEmployee);
                })
                .orElseGet(() -> {
                    employee.setId(id);
                    return employeeRepository.save(employee);
                });
    }

    @DeleteMapping("/{id}")
    public void deleteEmployee(@PathVariable String id) {
        employeeRepository.deleteById(id);
    }
}