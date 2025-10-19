package com.petshop.pet.controller.admin;

import com.petshop.pet.domain.Voucher;
import com.petshop.pet.domain.dto.VoucherDTO;
import com.petshop.pet.domain.dto.VoucherUpdateDTO;
import com.petshop.pet.service.VoucherService;
import com.turkraft.springfilter.boot.Filter;
import jakarta.validation.Valid;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/admin")
public class VoucherController {

    private final VoucherService voucherService;

    public VoucherController(VoucherService voucherService){
        this.voucherService = voucherService;
    }

    @GetMapping("/voucher")
    public String getVoucherPage(Model model,
                                 @Filter Specification<Voucher> spec,
                                 @RequestParam(name = "page", defaultValue = "1") int page,
                                 @PageableDefault(size = 5) Pageable pageableDefault){

        Pageable pageable = PageRequest.of(page - 1,
                pageableDefault.getPageSize(),
                pageableDefault.getSort());

        Page<Voucher> vouchers = voucherService.getAllVouchers(spec, pageable);

        model.addAttribute("vouchers", vouchers.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", vouchers.getTotalPages());
        model.addAttribute("totalElements", vouchers.getTotalElements());

        return "admin/voucher/index";
    }

    @GetMapping("/voucher/create")
    public String getCreateVoucherPage(Model model){
        model.addAttribute("newVoucher", new Voucher());
        return "admin/voucher/create";
    }

    @GetMapping("/voucher/{id}")
    public String getVoucherDetailPage(Model model,
                                       @PathVariable("id") long voucherId){
        Voucher voucher = voucherService.getVoucherById(voucherId);
        model.addAttribute("voucher", voucher);

        return "admin/voucher/detail";
    }

    @PostMapping("/voucher/create")
    public String createVoucher(@Valid @ModelAttribute("newVoucher")VoucherDTO voucherDTO,
                               BindingResult bindingResult){

        if(bindingResult.hasErrors())
            return "admin/voucher/create";

        voucherService.createVoucher(voucherDTO);

        return "redirect:/admin/voucher";
    }

    @GetMapping("/voucher/update/{id}")
    public String getUpdateVoucherPage(Model model,
                                       @PathVariable("id") long voucherId){

        Voucher currentVoucher = voucherService.getVoucherById(voucherId);
        model.addAttribute("currentVoucher", currentVoucher);

        return "admin/voucher/update";
    }

    @PostMapping("/voucher/update/{id}")
    public String updateVoucher(@PathVariable("id") long voucherId,
                                @Valid @ModelAttribute("currentVoucher") VoucherUpdateDTO voucherUpdateDTO,
                                BindingResult bindingResult){

        if(bindingResult.hasErrors())
            return "admin/voucher/update";

        voucherService.updateVoucher(voucherId, voucherUpdateDTO);

        return "redirect:/admin/voucher";
    }

    @GetMapping("/voucher/delete/{id}")
    public String getDeleteVoucherPage(@PathVariable("id") long voucherId){
        return "admin/voucher/delete";
    }

    @PostMapping("/voucher/delete/{id}")
    public String deleteVoucher(@PathVariable("id") long voucherId){
        voucherService.deleteVoucher(voucherId);
        return "redirect:/admin/voucher";
    }


}
