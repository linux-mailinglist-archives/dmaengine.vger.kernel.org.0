Return-Path: <dmaengine+bounces-5871-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 557C4B136DE
	for <lists+dmaengine@lfdr.de>; Mon, 28 Jul 2025 10:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E5F37AA46F
	for <lists+dmaengine@lfdr.de>; Mon, 28 Jul 2025 08:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD51221FD8;
	Mon, 28 Jul 2025 08:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="sWQVgqrq"
X-Original-To: dmaengine@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803DF223335;
	Mon, 28 Jul 2025 08:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753692041; cv=none; b=e9X8nETYavIsTTC8DNsRZ21V3mFP13TnToYuE+Exk3X/s8J1uMlYSGXL1JMFzttQNw+HCz3BI83kno0DLdixk1uHy9i5sXCC4kVriuFf6W6oxJem/ErtGhZwQNcFcZgbvT1ezoyABRMVX1uuC2HdA29MY4zlGFwkfJyNU6OJNrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753692041; c=relaxed/simple;
	bh=rwZJrVP1BT5tyiRZqif+sOLydn/x61D0kRyFWOASAlI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wjs4tmGjH5jFJp+QjXG2pDiq8B/s58BVnegywVh+2hSaIwZo07xQjK5ZkPz94FZ0VZjd+O0AGHFfkY2bdQFaI9uj6wQgcB5ll1XzHJ/GQj/mI/RACcOpTCPSTtES1LH2dqNFdVN9Qzkw4/YKMEVVg4/3xtVKXhtgmSK6T/BaxTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=sWQVgqrq; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753692029; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=uwm9cj3KRx8yDX4BDFgC32VZtWRWP0lSPfYpNdFr2MU=;
	b=sWQVgqrqtMCygYbG/+CY8/b+0EwUQggYs/Nmj1ljBI8p274lFKpKlGXxlLXkD0rubm5vChrbAjswX6dSx/DLb5vkeMojNM6iyyY5ZgD2/cBsIxBcFhpuUcRXwoz/jJWcO/S0OAkki9s+pDA2BLfbgeFBgyT9mycnRIpGfpwavhU=
Received: from 30.246.181.19(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WkG7MMX_1753692028 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 28 Jul 2025 16:40:29 +0800
Message-ID: <316cd6b2-3519-4353-8c53-06997096b216@linux.alibaba.com>
Date: Mon, 28 Jul 2025 16:40:28 +0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] dmaengine: idxd: Fix refcount underflow on module
 unload
To: Yi Sun <yi.sun@intel.com>, Fenghua Yu <fenghuay@nvidia.com>
Cc: vinicius.gomes@intel.com, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org, dave.jiang@intel.com, gordon.jin@intel.com,
 xueshuai@linux.alibaba.com
References: <20250617102712.727333-1-yi.sun@intel.com>
 <20250617102712.727333-3-yi.sun@intel.com>
 <39398407-009e-4afe-acb6-e3de931627d7@nvidia.com>
 <aIXuYVtGSV0OHHps@ysun46-mobl.ccr.corp.intel.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <aIXuYVtGSV0OHHps@ysun46-mobl.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi, Yi Sun, Fenghua Yu,

在 2025/7/27 17:16, Yi Sun 写道:
> On 17.06.2025 14:58, Fenghua Yu wrote:
>> Hi, Yi,
>>
>> On 6/17/25 03:27, Yi Sun wrote:
>>> A recent refactor introduced a misplaced put_device() call, leading to a
>>> reference count underflow during module unload.
>>>
>>> There is no need to add additional put_device() calls for idxd groups,
>>> engines, or workqueues. Although commit a409e919ca3 claims:"Note, this
>>> also fixes the missing put_device() for idxd groups, engines, and wqs."
>>> It appears no such omission existed. The required cleanup is already
>>> handled by the call chain:
>>>
>>>
>>> Extend idxd_cleanup() to perform the necessary cleanup, and remove
>>> idxd_cleanup_internals() which was not originally part of the driver
>>> unload path and introduced unintended reference count underflow.
>>>
>>> Fixes: a409e919ca32 ("dmaengine: idxd: Refactor remove call with idxd_cleanup() helper")
>>> Signed-off-by: Yi Sun <yi.sun@intel.com>
>>>
>>> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
>>> index 40cc9c070081..40f4bf446763 100644
>>> --- a/drivers/dma/idxd/init.c
>>> +++ b/drivers/dma/idxd/init.c
>>> @@ -1292,7 +1292,10 @@ static void idxd_remove(struct pci_dev *pdev)
>>>      device_unregister(idxd_confdev(idxd));
>>>      idxd_shutdown(pdev);
>>>      idxd_device_remove_debugfs(idxd);
>>> -    idxd_cleanup(idxd);
>>> +    perfmon_pmu_remove(idxd);
>>> +    idxd_cleanup_interrupts(idxd);
>>> +    if (device_pasid_enabled(idxd))
>>> +        idxd_disable_system_pasid(idxd);
>>>
>> This will hit memory leak issue.
>>
>> idxd_remove_internals() does not only put_device() but also free allocated memory for wqs, engines, groups. Without calling idxd_remove_internals(), the allocated memory is leaked.
>>
>> I think a right fix is to remove the put_device() in idxd_cleanup_wqs/engines/groups() because:
>>
>> 1. idxd_setup_wqs/engines/groups() does not call get_device(). Their counterpart idxd_cleanup_wqs/engines/groups() shouldn't call put_device().
>>
>> 2. Fix the issue mentioned in this patch while there is no memory leak issue.
>>
>>>      pci_iounmap(pdev, idxd->reg_base);
>>>      put_device(idxd_confdev(idxd));
>>>      pci_disable_device(pdev);
>>
>> Thanks.
>>
>> -Fenghua
>>
> 
> Hi Fenghua,
> 
> As with the comments on the previous patch, the function
> idxd_conf_device_release already covers part of what is done in
> idxd_remove_internals, including:
>      kfree(idxd->groups);
>      kfree(idxd->wqs);
>      kfree(idxd->engines);
>      kfree(idxd);
> 
> We need to redesign idxd_remove_internals to clearly identify what
> truely result in memory leaks and should be handled there.
> Then, we'll need another patch to fix the idxd_remove_internals and call
> it here.
> 
> Let's prioritize addressing the two critical issues we've encountered here,
> and then revisit the memory leak discussion afterward.
> 
> Thanks
>    --Sun, Yi

The root cause is simliar to Patch 1, the idxd_conf_device_release()
function already handles part of the cleanup that
idxd_cleanup_internals() attempts to do, e.g.

     idxd->wqs
     idxd->einges
     idxd->groups

As a result, it causes user-after-free issue.

     ------------[ cut here ]------------
     WARNING: CPU: 190 PID: 13854 at lib/refcount.c:28 refcount_warn_saturate+0xbe/0x110
     refcount_t: underflow; use-after-free.
     drm_client_lib(E) i2c_algo_bit(E) drm_shmem_helper(E) drm_kms_helper(E) nvme(E) mlx5_core(E) mlxfw(E) nvme_core(E) pci_hyperv_intf(E) psample(E) drm(E) wmi(E) pinctrl_emmitsburg(E) sd_mod(E) sg(E) ahci(E) libahci(E) libata(E) fuse(E)
     Modules linked in: binfmt_misc(E) bonding(E) tls(E) intel_rapl_msr(E) intel_rapl_common(E) intel_uncore_frequency(E) intel_uncore_frequency_common(E) i10nm_edac(E) skx_edac_common(E) nfit(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) coretemp(E) kvm_intel(E) snd_hda_intel(E) kvm(E) snd_intel_dspcfg(E) snd_hda_codec(E) mlx5_ib(E) irqbypass(E) qat_4xxx(E) snd_hda_core(E) dax_hmem(E) ghash_clmulni_intel(E) intel_qat(E) cxl_acpi(E) snd_hwdep(E) rapl(E) snd_pcm(E) cxl_port(E) iTCO_wdt(E) intel_cstate(E) iTCO_vendor_support(E) snd_timer(E) ib_uverbs(E) pmt_telemetry(E) cxl_core(E) rfkill(E) tun(E) dh_generic(E) pmt_class(E) intel_uncore(E) einj(E) pcspkr(E) isst_if_mbox_pci(E) joydev(E) isst_if_mmio(E) idxd(E-) crc8(E) ib_core(E) isst_if_common(E) authenc(E) intel_vsec(E) idxd_bus(E) snd(E) i2c_i801(E) mei_me(E) soundcore(E) i2c_smbus(E) i2c_ismt(E) mei(E) nf_tables(E) nfnetlink(E) ipmi_ssif(E) acpi_power_meter(E) ipmi_si(E) acpi_ipmi(E) ipmi_devintf(E) ipmi_msghandle
     CPU: 190 UID: 0 PID: 13854 Comm: rmmod Kdump: loaded Tainted: G S          E       6.16.0-rc6+ #116 PREEMPT(none)
     Tainted: [S]=CPU_OUT_OF_SPEC, [E]=UNSIGNED_MODULE
     Hardware name: Inspur AliServer-Xuanwu2.0-02-1UCG42PF/AS2111TG5, BIOS 3.0.ES.AL.P.090.01 02/22/2024
     RIP: 0010:refcount_warn_saturate+0xbe/0x110
     RSP: 0018:ff7078d2df957db8 EFLAGS: 00010282
     RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
     RBP: ff2b10355b055000 R08: 0000000000000000 R09: ff7078d2df957c68
     RDX: ff2b10b33fdaa3c0 RSI: 0000000000000001 RDI: ff2b10b33fd9c440
     R10: ff7078d2df957c60 R11: ffffffffbe761d68 R12: ff2b1035a00db400
     R13: ff2b10355670b148 R14: ff2b103555097c80 R15: ffffffffc0a88938
     FS:  00007fb5f8f3b740(0000) GS:ff2b10b380bb9000(0000) knlGS:0000000000000000
     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
     CR2: 00005560a898c2d8 CR3: 00000080f9def005 CR4: 0000000000f73ef0
     PKRU: 55555554
     Code: 01 01 e8 35 9b 9a ff 0f 0b c3 cc cc cc cc 80 3d 05 4c f5 01 00 75 85 48 c7 c7 30 21 75 bd c6 05 f5 4b f5 01 01 e8 12 9b 9a ff <0f> 0b c3 cc cc cc cc 80 3d e0 4b f5 01 00 0f 85 5e ff ff ff 48 c7
     Call Trace:
     idxd_cleanup+0x6b/0x100 [idxd]
     <TASK>
     idxd_remove+0x46/0x70 [idxd]
     pci_device_remove+0x3f/0xb0
     driver_detach+0x48/0x90
     device_release_driver_internal+0x197/0x200
     bus_remove_driver+0x6d/0xf0
     idxd_exit_module+0x34/0x6c0 [idxd]
     __do_sys_delete_module.constprop.0+0x174/0x310
     do_syscall_64+0x5f/0x2d0
     pci_unregister_driver+0x2e/0xb0
     entry_SYSCALL_64_after_hwframe+0x76/0x7e
     RIP: 0033:0x7fb5f8a620cb
     Code: 73 01 c3 48 8b 0d a5 6d 19 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 75 6d 19 00 f7 d8 64 89 01 48
     RSP: 002b:00007ffeed6101c8 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
     RAX: ffffffffffffffda RBX: 00005560a8981790 RCX: 00007fb5f8a620cb
     RDX: 000000000000000a RSI: 0000000000000800 RDI: 00005560a89817f8
     R13: 00007ffeed612352 R14: 00005560a89812a0 R15: 00005560a8981790
     R10: 00007fb5f8baaac0 R11: 0000000000000206 R12: 00007ffeed6103f0
     </TASK>
     ---[ end trace 0000000000000000 ]---

With this patch applied, the user-after-free issue is fixed.

But, there is still memory leaks in

     idxd->wqs[i]
     idxd->einges[i]
     idxd->groups[i]

I agree with Vinicius that we should cleanup in idxd_conf_device_release().

Thanks.
Shuai


