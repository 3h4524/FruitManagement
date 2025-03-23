package model;

import jakarta.persistence.*;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.Nationalized;

import java.time.Instant;

@Entity
@NamedQueries({
        @NamedQuery(name = "User.findAll", query = "SELECT u FROM User u"),
        @NamedQuery(name = "User.findById", query = "SELECT u FROM User u WHERE u.id = :id"),
        @NamedQuery(name = "User.findByEmail", query = "SELECT u FROM User u WHERE u.email LIKE :email"),
        @NamedQuery(name = "User.findByStatus", query = "SELECT u FROM User u WHERE u.status = :status"),
        @NamedQuery(name = "User.findByRole", query = "SELECT u FROM User u WHERE u.role = :role"),
        @NamedQuery(name = "User.findByRegistrationDateRange",
                query = "SELECT u FROM User u WHERE u.registrationDate BETWEEN :startDate AND :endDate"),
        @NamedQuery(name = "User.findByName", query = "SELECT u FROM User u WHERE u.name LIKE :name"),
        @NamedQuery(name = "User.findByPhone", query = "SELECT u FROM User u WHERE u.phone = :phone"),
        // Added new named query to support OAuth functionality
        @NamedQuery(name = "User.findByRememberToken",
                query = "SELECT u FROM User u WHERE u.rememberToken = :token AND u.status = 'ACTIVE'")
})
@Table(name = "Users")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "UserID", nullable = false)
    private Integer id;

    @Nationalized
    @Column(name = "Name", nullable = false, length = 100)
    private String name;

    @Nationalized
    @Column(name = "Email", nullable = false, length = 100)
    private String email;

    @Nationalized
    @Column(name = "PasswordHash", nullable = false)
    private String passwordHash;

    @Nationalized
    @Column(name = "Phone", length = 15)
    private String phone;

    @Nationalized
    @Column(name = "Address", length = 200)
    private String address;

    @ColumnDefault("getdate()")
    @Column(name = "RegistrationDate")
    private Instant registrationDate;

    @ColumnDefault("'ACTIVE'")
    @Column(name = "Status", nullable = false, length = 10)
    private String status;

    @Nationalized
    @ColumnDefault("'Customer'")
    @Column(name = "Role", length = 20)
    private String role;

    @Column(name = "remember_token")
    private String rememberToken;

    @Column(name = "profile_picture")
    private String profilePicture;

    @ColumnDefault("0")
    @Column(name = "is_oauth_user")
    private Boolean isOauthUser;

    @Column(name = "oauth_provider", length = 20)
    private String oauthProvider;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPasswordHash() {
        return passwordHash;
    }

    public void setPasswordHash(String passwordHash) {
        this.passwordHash = passwordHash;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Instant getRegistrationDate() {
        return registrationDate;
    }

    public void setRegistrationDate(Instant registrationDate) {
        this.registrationDate = registrationDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getRememberToken() {
        return rememberToken;
    }

    public void setRememberToken(String rememberToken) {
        this.rememberToken = rememberToken;
    }

    public String getProfilePicture() {
        return profilePicture;
    }

    public void setProfilePicture(String profilePicture) {
        this.profilePicture = profilePicture;
    }

    public Boolean getIsOauthUser() {
        return isOauthUser;
    }

    public void setIsOauthUser(Boolean isOauthUser) {
        this.isOauthUser = isOauthUser;
    }

    public String getOauthProvider() {
        return oauthProvider;
    }

    public void setOauthProvider(String oauthProvider) {
        this.oauthProvider = oauthProvider;
    }
    public boolean isActive() { return "ACTIVE".equals(this.status); } // Utility method to check if user is an admin public boolean isAdmin() { return "Admin".equalsIgnoreCase(this.role); }
/*
 TODO [Reverse Engineering] create field to map the 'last_login' column
 Available actions: Define target Java type | Uncomment as is | Remove column mapping
    @Column(name = "last_login", columnDefinition = "timestamp not null")
    private Object lastLogin;
*/
}