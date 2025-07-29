Return-Path: <dmaengine+bounces-5880-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 421A5B147F7
	for <lists+dmaengine@lfdr.de>; Tue, 29 Jul 2025 08:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59E53189DD91
	for <lists+dmaengine@lfdr.de>; Tue, 29 Jul 2025 06:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1296C256C73;
	Tue, 29 Jul 2025 06:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ZgyvaIy2"
X-Original-To: dmaengine@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4DB25392C;
	Tue, 29 Jul 2025 06:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753768815; cv=none; b=gG2jVUDucAXWtBOs4WGQIufqjONxlupogWKBOfXwei+qy2H1p+1pEyyuafr47lEoT/+RcDH9nzVgssBnx3YRewio4sl85I4nSWGk5x17g+W/yAh1i0iDRZkx5nsgsTitOieuVcPh0FNhSY/t+Sr5cpwqRYPSYDHjmc6UJvXdwrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753768815; c=relaxed/simple;
	bh=BOZK7uoy4NT1ZPWwSg/BNcdYL8v2hRwIa+yK2NTu+0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EF1CzfB6BuFEAQqmfLJJOZvJKs6dt9t87Hv9rTVBNdZvPFuJOtD5+hGMBkpcwmWi86sfmNHqRAIDNaxvOeT0yI7u+9LuZZiFIDkd3V0MogTKod76sTUbnZKtJ6uz47gztiypGJ3VybtGEJ9SiSP8SkdhlLMhRUtZNM8KI4oG+6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ZgyvaIy2; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753768802; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=0BLczX5byzZnV8u9NvWmi/kT+UhJ9Db7wkvWdJmZ7UY=;
	b=ZgyvaIy2cFBIS0mhXLLIAvGu7bWTDcicUFUIRPiaeC5jt7Kx5BUtLHYILCeNDoWQk/mfsdnSOnWU9/0j+ED5yf0DZXRxcZCRwPJQeXD3PY4t1wvwuUgt3fuLRTxNK4LQZwZ4q7J1OCYDMYsS90K2voLlSpiJbaYnjHopFSNdmxw=
Received: from 30.246.181.19(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WkOoC7l_1753768801 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 29 Jul 2025 14:00:01 +0800
Message-ID: <96373d78-e76d-4d86-87ac-a6cb2a0334e5@linux.alibaba.com>
Date: Tue, 29 Jul 2025 14:00:01 +0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] dmaengine: idxd: Fix refcount underflow on module
 unload
To: Yi Sun <yi.sun@intel.com>
Cc: Fenghua Yu <fenghuay@nvidia.com>, vinicius.gomes@intel.com,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 dave.jiang@intel.com, gordon.jin@intel.com
References: <20250617102712.727333-1-yi.sun@intel.com>
 <20250617102712.727333-3-yi.sun@intel.com>
 <39398407-009e-4afe-acb6-e3de931627d7@nvidia.com>
 <aIXuYVtGSV0OHHps@ysun46-mobl.ccr.corp.intel.com>
 <316cd6b2-3519-4353-8c53-06997096b216@linux.alibaba.com>
 <aIdiTlIU03stIdqe@ysun46-mobl.ccr.corp.intel.com>
 <2ee448d2-76b2-446c-9368-8b90ec087419@linux.alibaba.com>
 <aIg87RSWc8-KbQ4v@ysun46-mobl.ccr.corp.intel.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <aIg87RSWc8-KbQ4v@ysun46-mobl.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/7/29 11:15, Yi Sun 写道:
> On 29.07.2025 10:46, Shuai Xue wrote:
>>
>>
>> 在 2025/7/28 19:43, Yi Sun 写道:
>>> On 28.07.2025 16:40, Shuai Xue wrote:
>>>> Hi, Yi Sun, Fenghua Yu,
>>>>
>>>> 在 2025/7/27 17:16, Yi Sun 写道:
>>>>> On 17.06.2025 14:58, Fenghua Yu wrote:
>>>>>> Hi, Yi,
>>>>>>
>>>>>> On 6/17/25 03:27, Yi Sun wrote:
>>>>>>> A recent refactor introduced a misplaced put_device() call, leading to a
>>>>>>> reference count underflow during module unload.
>>>>>>>
>>>>>>> There is no need to add additional put_device() calls for idxd groups,
>>>>>>> engines, or workqueues. Although commit a409e919ca3 claims:"Note, this
>>>>>>> also fixes the missing put_device() for idxd groups, engines, and wqs."
>>>>>>> It appears no such omission existed. The required cleanup is already
>>>>>>> handled by the call chain:
>>>>>>>
>>>>>>>
>>>>>>> Extend idxd_cleanup() to perform the necessary cleanup, and remove
>>>>>>> idxd_cleanup_internals() which was not originally part of the driver
>>>>>>> unload path and introduced unintended reference count underflow.
>>>>>>>
>>>>>>> Fixes: a409e919ca32 ("dmaengine: idxd: Refactor remove call with idxd_cleanup() helper")
>>>>>>> Signed-off-by: Yi Sun <yi.sun@intel.com>
>>>>>>>
>>>>>>> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
>>>>>>> index 40cc9c070081..40f4bf446763 100644
>>>>>>> --- a/drivers/dma/idxd/init.c
>>>>>>> +++ b/drivers/dma/idxd/init.c
>>>>>>> @@ -1292,7 +1292,10 @@ static void idxd_remove(struct pci_dev *pdev)
>>>>>>>    device_unregister(idxd_confdev(idxd));
>>>>>>>    idxd_shutdown(pdev);
>>>>>>>    idxd_device_remove_debugfs(idxd);
>>>>>>> -    idxd_cleanup(idxd);
>>>>>>> +    perfmon_pmu_remove(idxd);
>>>>>>> +    idxd_cleanup_interrupts(idxd);
>>>>>>> +    if (device_pasid_enabled(idxd))
>>>>>>> +        idxd_disable_system_pasid(idxd);
>>>>>>>
>>>>>> This will hit memory leak issue.
>>>>>>
>>>>>> idxd_remove_internals() does not only put_device() but also free allocated memory for wqs, engines, groups. Without calling idxd_remove_internals(), the allocated memory is leaked.
>>>>>>
>>>>>> I think a right fix is to remove the put_device() in idxd_cleanup_wqs/engines/groups() because:
>>>>>>
>>>>>> 1. idxd_setup_wqs/engines/groups() does not call get_device(). Their counterpart idxd_cleanup_wqs/engines/groups() shouldn't call put_device().
>>>>>>
>>>>>> 2. Fix the issue mentioned in this patch while there is no memory leak issue.
>>>>>>
>>>>>>>    pci_iounmap(pdev, idxd->reg_base);
>>>>>>>    put_device(idxd_confdev(idxd));
>>>>>>>    pci_disable_device(pdev);
>>>>>>
>>>>>> Thanks.
>>>>>>
>>>>>> -Fenghua
>>>>>>
>>>>>
>>>>> Hi Fenghua,
>>>>>
>>>>> As with the comments on the previous patch, the function
>>>>> idxd_conf_device_release already covers part of what is done in
>>>>> idxd_remove_internals, including:
>>>>>    kfree(idxd->groups);
>>>>>    kfree(idxd->wqs);
>>>>>    kfree(idxd->engines);
>>>>>    kfree(idxd);
>>>>>
>>>>> We need to redesign idxd_remove_internals to clearly identify what
>>>>> truely result in memory leaks and should be handled there.
>>>>> Then, we'll need another patch to fix the idxd_remove_internals and call
>>>>> it here.
>>>>>
>>>>> Let's prioritize addressing the two critical issues we've encountered here,
>>>>> and then revisit the memory leak discussion afterward.
>>>>>
>>>>> Thanks
>>>>>  --Sun, Yi
>>>>
>>>> The root cause is simliar to Patch 1, the idxd_conf_device_release()
>>>> function already handles part of the cleanup that
>>>> idxd_cleanup_internals() attempts to do, e.g.
>>>>
>>>>   idxd->wqs
>>>>   idxd->einges
>>>>   idxd->groups
>>>>
>>>> As a result, it causes user-after-free issue.
>>>>
>>>>   ------------[ cut here ]------------
>>>>   WARNING: CPU: 190 PID: 13854 at lib/refcount.c:28 refcount_warn_saturate+0xbe/0x110
>>>>   refcount_t: underflow; use-after-free.
>>>>   drm_client_lib(E) i2c_algo_bit(E) drm_shmem_helper(E) drm_kms_helper(E) nvme(E) mlx5_core(E) mlxfw(E) nvme_core(E) pci_hyperv_intf(E) psample(E) drm(E) wmi(E) pinctrl_emmitsburg(E) sd_mod(E) sg(E) ahci(E) libahci(E) libata(E) fuse(E)
>>>>   Modules linked in: binfmt_misc(E) bonding(E) tls(E) intel_rapl_msr(E) intel_rapl_common(E) intel_uncore_frequency(E) intel_uncore_frequency_common(E) i10nm_edac(E) skx_edac_common(E) nfit(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) coretemp(E) kvm_intel(E) snd_hda_intel(E) kvm(E) snd_intel_dspcfg(E) snd_hda_codec(E) mlx5_ib(E) irqbypass(E) qat_4xxx(E) snd_hda_core(E) dax_hmem(E) ghash_clmulni_intel(E) intel_qat(E) cxl_acpi(E) snd_hwdep(E) rapl(E) snd_pcm(E) cxl_port(E) iTCO_wdt(E) intel_cstate(E) iTCO_vendor_support(E) snd_timer(E) ib_uverbs(E) pmt_telemetry(E) cxl_core(E) rfkill(E) tun(E) dh_generic(E) pmt_class(E) intel_uncore(E) einj(E) pcspkr(E) isst_if_mbox_pci(E) joydev(E) isst_if_mmio(E) idxd(E-) crc8(E) ib_core(E) isst_if_common(E) authenc(E) intel_vsec(E) idxd_bus(E) snd(E) i2c_i801(E) mei_me(E) soundcore(E) i2c_smbus(E) i2c_ismt(E) mei(E) nf_tables(E) nfnetlink(E) ipmi_ssif(E) acpi_power_meter(E) ipmi_si(E) acpi_ipmi(E) ipmi_devintf(E) ipmi_msghandle
>>>>   CPU: 190 UID: 0 PID: 13854 Comm: rmmod Kdump: loaded Tainted: G S          E       6.16.0-rc6+ #116 PREEMPT(none)
>>>>   Tainted: [S]=CPU_OUT_OF_SPEC, [E]=UNSIGNED_MODULE
>>>>   Hardware name: Inspur AliServer-Xuanwu2.0-02-1UCG42PF/AS2111TG5, BIOS 3.0.ES.AL.P.090.01 02/22/2024
>>>>   RIP: 0010:refcount_warn_saturate+0xbe/0x110
>>>>   RSP: 0018:ff7078d2df957db8 EFLAGS: 00010282
>>>>   RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
>>>>   RBP: ff2b10355b055000 R08: 0000000000000000 R09: ff7078d2df957c68
>>>>   RDX: ff2b10b33fdaa3c0 RSI: 0000000000000001 RDI: ff2b10b33fd9c440
>>>>   R10: ff7078d2df957c60 R11: ffffffffbe761d68 R12: ff2b1035a00db400
>>>>   R13: ff2b10355670b148 R14: ff2b103555097c80 R15: ffffffffc0a88938
>>>>   FS:  00007fb5f8f3b740(0000) GS:ff2b10b380bb9000(0000) knlGS:0000000000000000
>>>>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>   CR2: 00005560a898c2d8 CR3: 00000080f9def005 CR4: 0000000000f73ef0
>>>>   PKRU: 55555554
>>>>   Code: 01 01 e8 35 9b 9a ff 0f 0b c3 cc cc cc cc 80 3d 05 4c f5 01 00 75 85 48 c7 c7 30 21 75 bd c6 05 f5 4b f5 01 01 e8 12 9b 9a ff <0f> 0b c3 cc cc cc cc 80 3d e0 4b f5 01 00 0f 85 5e ff ff ff 48 c7
>>>>   Call Trace:
>>>>   idxd_cleanup+0x6b/0x100 [idxd]
>>>>   <TASK>
>>>>   idxd_remove+0x46/0x70 [idxd]
>>>>   pci_device_remove+0x3f/0xb0
>>>>   driver_detach+0x48/0x90
>>>>   device_release_driver_internal+0x197/0x200
>>>>   bus_remove_driver+0x6d/0xf0
>>>>   idxd_exit_module+0x34/0x6c0 [idxd]
>>>>   __do_sys_delete_module.constprop.0+0x174/0x310
>>>>   do_syscall_64+0x5f/0x2d0
>>>>   pci_unregister_driver+0x2e/0xb0
>>>>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>>   RIP: 0033:0x7fb5f8a620cb
>>>>   Code: 73 01 c3 48 8b 0d a5 6d 19 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 75 6d 19 00 f7 d8 64 89 01 48
>>>>   RSP: 002b:00007ffeed6101c8 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
>>>>   RAX: ffffffffffffffda RBX: 00005560a8981790 RCX: 00007fb5f8a620cb
>>>>   RDX: 000000000000000a RSI: 0000000000000800 RDI: 00005560a89817f8
>>>>   R13: 00007ffeed612352 R14: 00005560a89812a0 R15: 00005560a8981790
>>>>   R10: 00007fb5f8baaac0 R11: 0000000000000206 R12: 00007ffeed6103f0
>>>>   </TASK>
>>>>   ---[ end trace 0000000000000000 ]---
>>>>
>>>> With this patch applied, the user-after-free issue is fixed.
>>>>
>>>> But, there is still memory leaks in
>>>>
>>>>   idxd->wqs[i]
>>>>   idxd->einges[i]
>>>>   idxd->groups[i]
>>>>
>>>> I agree with Vinicius that we should cleanup in idxd_conf_device_release().
>>>>
>>>> Thanks.
>>>> Shuai
>>>
>>> Appreciate Shuai's clarification. Yes, it would be better if fixing the memory
>>> leak issue in idxd_conf_device_release() in a separate patch.
>>>
>>> @Shuai, please feel free to proceed if you'd like to cook a patch for it.
>>>
>>> Thanks
>>>    --Sun, Yi
>>
>> Hi, Sun, Yi,
>>
>> I need to correct my previous analysis. After further investigation, I
>> believe there is no memory leak in the current code. The device
>> reference counting and memory management are properly handled through
>> the Linux device model. Each component is freed at the conf_dev
>> destruction time:
>>
>>
>>    idxd->wqs[i] is freed by idxd_conf_wq_release()
>>    idxd->einges[i] is freed by idxd_conf_engine_release()
>>    idxd->groups[i] is freed by idxd_conf_group_release()
>>
>>
>> Adding additional cleanup in idxd_conf_device_release() would actually
>> cause double-free issues. I can reproduce this with KASAN:
>>
>> [kernel][err]BUG: KASAN: slab-use-after-free in idxd_clean_groups+0x137/0x250 [idxd]
>> [kernel][err]==================================================================
>> [kernel][err]Read of size 4 at addr ff1100822ff89038 by task rmmod/13956
>> [kernel][err]
>> [kernel][err]CPU: 185 UID: 0 PID: 13956 Comm: rmmod Kdump: loaded Tainted: G S          E       6.16.0-rc6+ #117 PREEMPT(none)
>> [kernel][err]Tainted: [S]=CPU_OUT_OF_SPEC, [E]=UNSIGNED_MODULE
>> [kernel][err]Hardware name: Inspur AliServer-Xuanwu2.0-02-1UCG42PF/AS2111TG5, BIOS 3.0.ES.AL.P.090.01 02/22/2024
>> [kernel][err]Call Trace:
>> [kernel][err]<TASK>
>> [kernel][err]dump_stack_lvl+0x55/0x70
>> [kernel][err]print_address_description.constprop.0+0x27/0x2e0
>> [kernel][err]? idxd_clean_groups+0x137/0x250 [idxd]
>> [kernel][err]print_report+0x3e/0x70
>> [kernel][err]kasan_report+0xb8/0xf0
>> [kernel][err]? idxd_clean_groups+0x137/0x250 [idxd]
>> [kernel][err]kasan_check_range+0x39/0x1b0
>> [kernel][err]idxd_clean_groups+0x137/0x250 [idxd]
>> [kernel][err]idxd_cleanup_internals+0x1f/0x1b0 [idxd]
>> [kernel][err]idxd_conf_device_release+0xe2/0x2b0 [idxd]
>> [kernel][err]device_release+0x9c/0x210
>> [kernel][err]kobject_cleanup+0x101/0x360
>> [kernel][err]pci_device_remove+0xab/0x1e0
>> [kernel][err]idxd_remove+0x93/0xb0 [idxd]
>> [kernel][err]device_release_driver_internal+0x369/0x530
>> [kernel][err]driver_detach+0xbf/0x180
>> [kernel][err]bus_remove_driver+0x11b/0x2a0
>> [kernel][err]pci_unregister_driver+0x2a/0x250
>> [kernel][err]? kobject_put+0x55/0xe0
>> [kernel][err]idxd_exit_module+0x34/0x40 [idxd]
>> [kernel][err]__do_sys_delete_module.constprop.0+0x2ee/0x580
>> [kernel][err]? fput_close_sync+0xdd/0x190
>> [kernel][err]? __pfx___do_sys_delete_module.constprop.0+0x10/0x10
>> [kernel][err]do_syscall_64+0x5d/0x2d0
>> [kernel][err]? __pfx_fput_close_sync+0x10/0x10
>> [kernel][err]entry_SYSCALL_64_after_hwframe+0x76/0x7e
>> [kernel][err]RIP: 0033:0x7f2ac20620cb
>> [kernel][err]Code: 73 01 c3 48 8b 0d a5 6d 19 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 75 6d 19 00 f7 d8 64 89 01 48
>> [kernel][err]RSP: 002b:00007ffdfec0a598 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
>> [kernel][err]RDX: 000000000000000a RSI: 0000000000000800 RDI: 0000560bd6bd77f8
>> [kernel][err]RAX: ffffffffffffffda RBX: 0000560bd6bd7790 RCX: 00007f2ac20620cb
>> [kernel][err]R10: 00007f2ac21aaac0 R11: 0000000000000206 R12: 00007ffdfec0a7c0
>> [kernel][err]RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
>> [kernel][err]</TASK>
>> [kernel][err]R13: 00007ffdfec0b352 R14: 0000560bd6bd72a0 R15: 0000560bd6bd7790
>> [kernel][err]Allocated by task 1445:
>> [kernel][err]
>> [kernel][warning]kasan_save_stack+0x24/0x50
>> [kernel][warning]kasan_save_track+0x14/0x30
>> [kernel][warning]__kasan_kmalloc+0xaa/0xb0
>> [kernel][warning]idxd_setup_groups+0x2b5/0x7a0 [idxd]
>> [kernel][warning]idxd_setup_internals+0xd1/0x6e0 [idxd]
>> [kernel][warning]idxd_probe+0x93/0x310 [idxd]
>> [kernel][warning]idxd_pci_probe_alloc+0x3f3/0x6e0 [idxd]
>> [kernel][warning]local_pci_probe+0xe5/0x1a0
>> [kernel][warning]work_for_cpu_fn+0x52/0xa0
>> [kernel][warning]process_one_work+0x652/0x1080
>> [kernel][warning]worker_thread+0x652/0xc70
>> [kernel][warning]ret_from_fork+0x253/0x2e0
>> [kernel][warning]kthread+0x34a/0x450
>> [kernel][warning]ret_from_fork_asm+0x1a/0x30
>> [kernel][err]
>> [kernel][err]Freed by task 13956:
>> [kernel][warning]kasan_save_stack+0x24/0x50
>> [kernel][warning]kasan_save_track+0x14/0x30
>> [kernel][warning]kasan_save_free_info+0x3a/0x60
>> [kernel][warning]__kasan_slab_free+0x54/0x70
>> [kernel][warning]kfree+0x12e/0x430
>> [kernel][warning]device_release+0x9c/0x210
>> [kernel][warning]kobject_cleanup+0x101/0x360
>> [kernel][warning]idxd_unregister_devices+0x22d/0x320 [idxd]
>> [kernel][warning]pci_device_remove+0xab/0x1e0
>> [kernel][warning]idxd_remove+0x3c/0xb0 [idxd]
>> [kernel][warning]driver_detach+0xbf/0x180
>> [kernel][warning]device_release_driver_internal+0x369/0x530
>> [kernel][warning]bus_remove_driver+0x11b/0x2a0
>> [kernel][warning]pci_unregister_driver+0x2a/0x250
>> [kernel][warning]idxd_exit_module+0x34/0x40 [idxd]
>> [kernel][warning]do_syscall_64+0x5d/0x2d0
>> [kernel][warning]__do_sys_delete_module.constprop.0+0x2ee/0x580
>> [kernel][err]
>> [kernel][err]The buggy address belongs to the object at ff1100822ff89000
>>
>> The issue shows memory being freed during device_release(), then
>> accessed again in idxd_conf_device_release().
>>
>> Your original approach is correct - the kernel's device model handles
>> the memory management properly, and we should not interfere with it.
>>
>> Feel free to add:
>>
>> Tested-by: Shuai Xue <xueshuai@linux.alibaba.com>
>>
>> Sorry for the confusion in my earlier analysis.
>>
>> Best Regards,
>> Shuai
> 
> I see. Thanks Shuai for the comments and testing efforts.
> I'd like to resend this series with the Tested-by tag to make it easier
> for further review.
> 
> 
> Thanks
>     --Sun, Yi

Hi, Sun, Yi,

Good idea to resend with the Tested-by tag.

I think you should also CC stable, since this issue exists in stable 6.6
and 6.12kernels as well. The refcount underflow and use-after-free
issues are serious enough to warrant backporting the fix.

Thanks,
Shuai

