package actions.views;

import java.util.ArrayList;
import java.util.List;

import constants.AttributeConst;
import constants.JpaConst;
import models.Employee;

public class EmployeeConverter {

    /**
     * ViewモデルのインスタンスからDTOモデルのインスタンスを作成する
     * @param ev EmployeeViewのインスタンス
     * @return Employeeのインスタンス
     */
    public static Employee toModel(EmployeeView ev) {

        return new Employee(
                ev.getId(),
                ev.getCode(),
                ev.getName(),
                ev.getPassword(),
                ev.getAdminFlag() == null
                        ? null
                        : ev.getAdminFlag() == AttributeConst.ROLE_ADMIN.getIntegerValue()
                                ? JpaConst.ROLE_ADMIN
                                : JpaConst.ROLE_GENERAL,
                ev.getApprovalFlag() == null
                        ? null
                        : ev.getApprovalFlag() == AttributeConst.ROLE_APRV_DEPT.getIntegerValue()
                                ? JpaConst.ROLE_APRV_DEPT
                                : ev.getApprovalFlag() == AttributeConst.ROLE_APRV_SECT.getIntegerValue()
                                        ? JpaConst.ROLE_APRV_SECT
                                        : JpaConst.ROLE_APRV_GENERAL,
                ev.getCreatedAt(),
                ev.getUpdatedAt(),
                ev.getDeleteFlag() == null
                        ? null
                        : ev.getDeleteFlag() == AttributeConst.DEL_FLAG_TRUE.getIntegerValue()
                                ? JpaConst.EMP_DEL_TRUE
                                : JpaConst.EMP_DEL_FALSE);
    }

    public static EmployeeView toView(Employee e) {

        if(e == null) {
            return null;
        }

        return new EmployeeView(
                e.getId(),
                e.getCode(),
                e.getName(),
                e.getPassword(),
                e.getAdminFlag() == null
                        ? null
                        : e.getAdminFlag() == JpaConst.ROLE_ADMIN
                                ? AttributeConst.ROLE_ADMIN.getIntegerValue()
                                : AttributeConst.ROLE_GENERAL.getIntegerValue(),
                e.getApprovalFlag() == null
                        ? null
                        : e.getApprovalFlag() == JpaConst.ROLE_APRV_DEPT
                                ? AttributeConst.ROLE_APRV_DEPT.getIntegerValue()
                                : e.getApprovalFlag() == JpaConst.ROLE_APRV_SECT
                                        ? AttributeConst.ROLE_APRV_SECT.getIntegerValue()
                                        : AttributeConst.ROLE_APRV_GENERAL.getIntegerValue(),
                e.getCreatedAt(),
                e.getUpdatedAt(),
                e.getDeleteFlag() == null
                        ? null
                        : e.getDeleteFlag() == JpaConst.EMP_DEL_TRUE
                                ? AttributeConst.DEL_FLAG_TRUE.getIntegerValue()
                                : AttributeConst.DEL_FLAG_FALSE.getIntegerValue());
    }

    public static List<EmployeeView> toViewList(List<Employee> list) {
        List<EmployeeView> evs = new ArrayList<>();

        for (Employee e : list) {
            evs.add(toView(e));
        }

        return evs;
    }

    public static void copyViewToModel(Employee e, EmployeeView ev) {
        e.setId(ev.getId());
        e.setCode(ev.getCode());
        e.setName(ev.getName());
        e.setPassword(ev.getPassword());
        e.setAdminFlag(ev.getAdminFlag());
        e.setApprovalFlag(ev.getApprovalFlag());
        e.setCreatedAt(ev.getCreatedAt());
        e.setUpdatedAt(ev.getUpdatedAt());
        e.setDeleteFlag(ev.getDeleteFlag());

    }

}
