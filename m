Return-Path: <dmaengine+bounces-5917-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4152B16993
	for <lists+dmaengine@lfdr.de>; Thu, 31 Jul 2025 02:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19CA318C7C49
	for <lists+dmaengine@lfdr.de>; Thu, 31 Jul 2025 00:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EE2440C;
	Thu, 31 Jul 2025 00:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b/e/6PFm"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B08510E5;
	Thu, 31 Jul 2025 00:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753921052; cv=none; b=hqiD6F51k5M3osli4OHg0nYnqqJK5SG8pfTiQsK6Jm0K5Pr6rFoAHOiu138PrfdkpgKHatnYr8H7oMCn1bpn2xHmKyXpnWyoneOw3IAx1rb6/FwDys+ccUHy6IVd/uX4YYO9VQDEkNEh+2m03DGzxrPOeZ06UPPVj4QwRLGCPAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753921052; c=relaxed/simple;
	bh=zBPPpAN+9NMZUY5H2kP5CwEIL6eJk9RXiEVECNoG20U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bgCUVGw7IHcJYhhSm6bHqjcAIuckjFvSVxfbOM6XmeYtT+55T1wIaly17OUKix90nFFxL1hAJVjioSgL9wLdxUAhXCZ+NpFXdtCuxMn31Ay77FymxKv14vORWHk3BbG7P85X+nICWha/fxAwBxxCZOPtGU67hQ0Ak8Envw+5uKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b/e/6PFm; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753921050; x=1785457050;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=zBPPpAN+9NMZUY5H2kP5CwEIL6eJk9RXiEVECNoG20U=;
  b=b/e/6PFm1FK8QCO8rDvSA3V3xSEcPAwLgQdTp0Ps4QTngJVHKKKKVofq
   qU0rnX6Up7ubFNS1GuGPaA+9HYFtShMzIeAGNgxxOHIlwYQ+h6nE8HIC7
   8qU/fhU3/BcRseIOi2VcgRzmUn1ziNBQDDo1HdQSpYHi3e0L0Igt0rlGR
   miN11JWzVfXYbalb8pDRAM7dOr8go9g8JxSS68hmMJRnD7xtl7vPf85+n
   MmkZ6HYSCtlAX3gsATgmMdZZGLg1gBF6CEV/kk38QUceP7Kb1MWSZC2jq
   xcE8tDYH4eCQBnnNNCja8gH+boxTNg+uRTnd5CwpUobuZuhIhVQYVlhcf
   Q==;
X-CSE-ConnectionGUID: SBaQxyMxRdWYOiMTroSdQQ==
X-CSE-MsgGUID: kgOPveuDR4G7nf9S8MURcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="55936014"
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; 
   d="scan'208";a="55936014"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 17:17:29 -0700
X-CSE-ConnectionGUID: k4mGFaTNT3aYfWqbzwEBrA==
X-CSE-MsgGUID: ZuThy3+nS9qZlA4LJDPKvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; 
   d="scan'208";a="168407754"
Received: from vcostago-mobl3.jf.intel.com (HELO vcostago-mobl3) ([10.98.32.147])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 17:17:29 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>, Yi Sun <yi.sun@intel.com>
Cc: Fenghua Yu <fenghuay@nvidia.com>, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org, dave.jiang@intel.com, gordon.jin@intel.com
Subject: Re: [PATCH v3 2/2] dmaengine: idxd: Fix refcount underflow on
 module unload
In-Reply-To: <2ee448d2-76b2-446c-9368-8b90ec087419@linux.alibaba.com>
References: <20250617102712.727333-1-yi.sun@intel.com>
 <20250617102712.727333-3-yi.sun@intel.com>
 <39398407-009e-4afe-acb6-e3de931627d7@nvidia.com>
 <aIXuYVtGSV0OHHps@ysun46-mobl.ccr.corp.intel.com>
 <316cd6b2-3519-4353-8c53-06997096b216@linux.alibaba.com>
 <aIdiTlIU03stIdqe@ysun46-mobl.ccr.corp.intel.com>
 <2ee448d2-76b2-446c-9368-8b90ec087419@linux.alibaba.com>
Date: Wed, 30 Jul 2025 17:17:28 -0700
Message-ID: <87zfclkycn.fsf@intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Shuai Xue <xueshuai@linux.alibaba.com> writes:

> =E5=9C=A8 2025/7/28 19:43, Yi Sun =E5=86=99=E9=81=93:
>> On 28.07.2025 16:40, Shuai Xue wrote:
>>> Hi, Yi Sun, Fenghua Yu,
>>>
>>> =E5=9C=A8 2025/7/27 17:16, Yi Sun =E5=86=99=E9=81=93:
>>>> On 17.06.2025 14:58, Fenghua Yu wrote:
>>>>> Hi, Yi,
>>>>>
>>>>> On 6/17/25 03:27, Yi Sun wrote:
>>>>>> A recent refactor introduced a misplaced put_device() call, leading =
to a
>>>>>> reference count underflow during module unload.
>>>>>>
>>>>>> There is no need to add additional put_device() calls for idxd group=
s,
>>>>>> engines, or workqueues. Although commit a409e919ca3 claims:"Note, th=
is
>>>>>> also fixes the missing put_device() for idxd groups, engines, and wq=
s."
>>>>>> It appears no such omission existed. The required cleanup is already
>>>>>> handled by the call chain:
>>>>>>
>>>>>>
>>>>>> Extend idxd_cleanup() to perform the necessary cleanup, and remove
>>>>>> idxd_cleanup_internals() which was not originally part of the driver
>>>>>> unload path and introduced unintended reference count underflow.
>>>>>>
>>>>>> Fixes: a409e919ca32 ("dmaengine: idxd: Refactor remove call with idx=
d_cleanup() helper")
>>>>>> Signed-off-by: Yi Sun <yi.sun@intel.com>
>>>>>>
>>>>>> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
>>>>>> index 40cc9c070081..40f4bf446763 100644
>>>>>> --- a/drivers/dma/idxd/init.c
>>>>>> +++ b/drivers/dma/idxd/init.c
>>>>>> @@ -1292,7 +1292,10 @@ static void idxd_remove(struct pci_dev *pdev)
>>>>>>     device_unregister(idxd_confdev(idxd));
>>>>>>     idxd_shutdown(pdev);
>>>>>>     idxd_device_remove_debugfs(idxd);
>>>>>> -    idxd_cleanup(idxd);
>>>>>> +    perfmon_pmu_remove(idxd);
>>>>>> +    idxd_cleanup_interrupts(idxd);
>>>>>> +    if (device_pasid_enabled(idxd))
>>>>>> +        idxd_disable_system_pasid(idxd);
>>>>>>
>>>>> This will hit memory leak issue.
>>>>>
>>>>> idxd_remove_internals() does not only put_device() but also free allo=
cated memory for wqs, engines, groups. Without calling idxd_remove_internal=
s(), the allocated memory is leaked.
>>>>>
>>>>> I think a right fix is to remove the put_device() in idxd_cleanup_wqs=
/engines/groups() because:
>>>>>
>>>>> 1. idxd_setup_wqs/engines/groups() does not call get_device(). Their =
counterpart idxd_cleanup_wqs/engines/groups() shouldn't call put_device().
>>>>>
>>>>> 2. Fix the issue mentioned in this patch while there is no memory lea=
k issue.
>>>>>
>>>>>>     pci_iounmap(pdev, idxd->reg_base);
>>>>>>     put_device(idxd_confdev(idxd));
>>>>>>     pci_disable_device(pdev);
>>>>>
>>>>> Thanks.
>>>>>
>>>>> -Fenghua
>>>>>
>>>>
>>>> Hi Fenghua,
>>>>
>>>> As with the comments on the previous patch, the function
>>>> idxd_conf_device_release already covers part of what is done in
>>>> idxd_remove_internals, including:
>>>>     kfree(idxd->groups);
>>>>     kfree(idxd->wqs);
>>>>     kfree(idxd->engines);
>>>>     kfree(idxd);
>>>>
>>>> We need to redesign idxd_remove_internals to clearly identify what
>>>> truely result in memory leaks and should be handled there.
>>>> Then, we'll need another patch to fix the idxd_remove_internals and ca=
ll
>>>> it here.
>>>>
>>>> Let's prioritize addressing the two critical issues we've encountered =
here,
>>>> and then revisit the memory leak discussion afterward.
>>>>
>>>> Thanks
>>>>   --Sun, Yi
>>>
>>> The root cause is simliar to Patch 1, the idxd_conf_device_release()
>>> function already handles part of the cleanup that
>>> idxd_cleanup_internals() attempts to do, e.g.
>>>
>>>    idxd->wqs
>>>    idxd->einges
>>>    idxd->groups
>>>
>>> As a result, it causes user-after-free issue.
>>>
>>>    ------------[ cut here ]------------
>>>    WARNING: CPU: 190 PID: 13854 at lib/refcount.c:28 refcount_warn_satu=
rate+0xbe/0x110
>>>    refcount_t: underflow; use-after-free.
>>>    drm_client_lib(E) i2c_algo_bit(E) drm_shmem_helper(E) drm_kms_helper=
(E) nvme(E) mlx5_core(E) mlxfw(E) nvme_core(E) pci_hyperv_intf(E) psample(E=
) drm(E) wmi(E) pinctrl_emmitsburg(E) sd_mod(E) sg(E) ahci(E) libahci(E) li=
bata(E) fuse(E)
>>>    Modules linked in: binfmt_misc(E) bonding(E) tls(E) intel_rapl_msr(E=
) intel_rapl_common(E) intel_uncore_frequency(E) intel_uncore_frequency_com=
mon(E) i10nm_edac(E) skx_edac_common(E) nfit(E) x86_pkg_temp_thermal(E) int=
el_powerclamp(E) coretemp(E) kvm_intel(E) snd_hda_intel(E) kvm(E) snd_intel=
_dspcfg(E) snd_hda_codec(E) mlx5_ib(E) irqbypass(E) qat_4xxx(E) snd_hda_cor=
e(E) dax_hmem(E) ghash_clmulni_intel(E) intel_qat(E) cxl_acpi(E) snd_hwdep(=
E) rapl(E) snd_pcm(E) cxl_port(E) iTCO_wdt(E) intel_cstate(E) iTCO_vendor_s=
upport(E) snd_timer(E) ib_uverbs(E) pmt_telemetry(E) cxl_core(E) rfkill(E) =
tun(E) dh_generic(E) pmt_class(E) intel_uncore(E) einj(E) pcspkr(E) isst_if=
_mbox_pci(E) joydev(E) isst_if_mmio(E) idxd(E-) crc8(E) ib_core(E) isst_if_=
common(E) authenc(E) intel_vsec(E) idxd_bus(E) snd(E) i2c_i801(E) mei_me(E)=
 soundcore(E) i2c_smbus(E) i2c_ismt(E) mei(E) nf_tables(E) nfnetlink(E) ipm=
i_ssif(E) acpi_power_meter(E) ipmi_si(E) acpi_ipmi(E) ipmi_devintf(E) ipmi_=
msghandle
>>>    CPU: 190 UID: 0 PID: 13854 Comm: rmmod Kdump: loaded Tainted: G S   =
       E       6.16.0-rc6+ #116 PREEMPT(none)
>>>    Tainted: [S]=3DCPU_OUT_OF_SPEC, [E]=3DUNSIGNED_MODULE
>>>    Hardware name: Inspur AliServer-Xuanwu2.0-02-1UCG42PF/AS2111TG5, BIO=
S 3.0.ES.AL.P.090.01 02/22/2024
>>>    RIP: 0010:refcount_warn_saturate+0xbe/0x110
>>>    RSP: 0018:ff7078d2df957db8 EFLAGS: 00010282
>>>    RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
>>>    RBP: ff2b10355b055000 R08: 0000000000000000 R09: ff7078d2df957c68
>>>    RDX: ff2b10b33fdaa3c0 RSI: 0000000000000001 RDI: ff2b10b33fd9c440
>>>    R10: ff7078d2df957c60 R11: ffffffffbe761d68 R12: ff2b1035a00db400
>>>    R13: ff2b10355670b148 R14: ff2b103555097c80 R15: ffffffffc0a88938
>>>    FS:  00007fb5f8f3b740(0000) GS:ff2b10b380bb9000(0000) knlGS:00000000=
00000000
>>>    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>    CR2: 00005560a898c2d8 CR3: 00000080f9def005 CR4: 0000000000f73ef0
>>>    PKRU: 55555554
>>>    Code: 01 01 e8 35 9b 9a ff 0f 0b c3 cc cc cc cc 80 3d 05 4c f5 01 00=
 75 85 48 c7 c7 30 21 75 bd c6 05 f5 4b f5 01 01 e8 12 9b 9a ff <0f> 0b c3 =
cc cc cc cc 80 3d e0 4b f5 01 00 0f 85 5e ff ff ff 48 c7
>>>    Call Trace:
>>>    idxd_cleanup+0x6b/0x100 [idxd]
>>>    <TASK>
>>>    idxd_remove+0x46/0x70 [idxd]
>>>    pci_device_remove+0x3f/0xb0
>>>    driver_detach+0x48/0x90
>>>    device_release_driver_internal+0x197/0x200
>>>    bus_remove_driver+0x6d/0xf0
>>>    idxd_exit_module+0x34/0x6c0 [idxd]
>>>    __do_sys_delete_module.constprop.0+0x174/0x310
>>>    do_syscall_64+0x5f/0x2d0
>>>    pci_unregister_driver+0x2e/0xb0
>>>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>    RIP: 0033:0x7fb5f8a620cb
>>>    Code: 73 01 c3 48 8b 0d a5 6d 19 00 f7 d8 64 89 01 48 83 c8 ff c3 66=
 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00 00 0f 05 <48> 3d 01 =
f0 ff ff 73 01 c3 48 8b 0d 75 6d 19 00 f7 d8 64 89 01 48
>>>    RSP: 002b:00007ffeed6101c8 EFLAGS: 00000206 ORIG_RAX: 00000000000000=
b0
>>>    RAX: ffffffffffffffda RBX: 00005560a8981790 RCX: 00007fb5f8a620cb
>>>    RDX: 000000000000000a RSI: 0000000000000800 RDI: 00005560a89817f8
>>>    R13: 00007ffeed612352 R14: 00005560a89812a0 R15: 00005560a8981790
>>>    R10: 00007fb5f8baaac0 R11: 0000000000000206 R12: 00007ffeed6103f0
>>>    </TASK>
>>>    ---[ end trace 0000000000000000 ]---
>>>
>>> With this patch applied, the user-after-free issue is fixed.
>>>
>>> But, there is still memory leaks in
>>>
>>>    idxd->wqs[i]
>>>    idxd->einges[i]
>>>    idxd->groups[i]
>>>
>>> I agree with Vinicius that we should cleanup in idxd_conf_device_releas=
e().
>>>
>>> Thanks.
>>> Shuai
>>=20
>> Appreciate Shuai's clarification. Yes, it would be better if fixing the =
memory
>> leak issue in idxd_conf_device_release() in a separate patch.
>>=20
>> @Shuai, please feel free to proceed if you'd like to cook a patch for it.
>>=20
>> Thanks
>>     --Sun, Yi
>
> Hi, Sun, Yi,
>
> I need to correct my previous analysis. After further investigation, I
> believe there is no memory leak in the current code. The device
> reference counting and memory management are properly handled through
> the Linux device model. Each component is freed at the conf_dev
> destruction time:
>
>
>      idxd->wqs[i] is freed by idxd_conf_wq_release()
>      idxd->einges[i] is freed by idxd_conf_engine_release()
>      idxd->groups[i] is freed by idxd_conf_group_release()
>
>
> Adding additional cleanup in idxd_conf_device_release() would actually
> cause double-free issues. I can reproduce this with KASAN:
>

Just tested with Yi Sun latest series applied (the series look good by
the way), and I am seeing this:

[  966.361049] kmemleak: 2075 new suspected memory leaks (see /sys/kernel/d=
ebug/kmemleak)

And from kmemleak:

unreferenced object 0xff110001e3e4b340 (size 192):
  comm "(udev-worker)", pid 2753, jiffies 4295015473
  hex dump (first 32 bytes):
    40 e5 f9 d4 01 00 11 ff 00 00 00 00 00 00 00 00  @...............
    40 2a e5 08 00 00 a0 ff 40 fa ff ff 00 00 00 00  @*......@.......
  backtrace (crc f81b8a71):
    __kmalloc_cache_node_noprof+0x39b/0x450
    idxd_wq_alloc_resources+0x6c9/0x1640 [idxd]
    idxd_drv_enable_wq+0x391/0x1100 [idxd]
    0xffffffffc22aa490
    really_probe+0x1e0/0x930
    __driver_probe_device+0x18c/0x3d0
    driver_probe_device+0x4a/0xd0
    __driver_attach+0x1e1/0x4a0
    bus_for_each_dev+0xef/0x170
    bus_add_driver+0x29d/0x5c0
    driver_register+0x130/0x450
    uncore_pm_notify+0xd1/0x130 [intel_uncore_frequency]
    do_one_initcall+0xb9/0x450
    do_init_module+0x281/0x8c0
    load_module+0x1693/0x2090
    init_module_from_file+0xe8/0x150
unreferenced object 0xff11000150941e40 (size 192):
  comm "(udev-worker)", pid 2753, jiffies 4295015473
  hex dump (first 32 bytes):
    40 de f9 d4 01 00 11 ff 00 00 00 00 00 00 00 00  @...............
    80 2a e5 08 00 00 a0 ff 80 fa ff ff 00 00 00 00  .*..............
  backtrace (crc e1abedf1):
    __kmalloc_cache_node_noprof+0x39b/0x450
    idxd_wq_alloc_resources+0x6c9/0x1640 [idxd]
    idxd_drv_enable_wq+0x391/0x1100 [idxd]
    0xffffffffc22aa490
    really_probe+0x1e0/0x930
    __driver_probe_device+0x18c/0x3d0
    driver_probe_device+0x4a/0xd0
    __driver_attach+0x1e1/0x4a0
    bus_for_each_dev+0xef/0x170
    bus_add_driver+0x29d/0x5c0
    driver_register+0x130/0x450
    uncore_pm_notify+0xd1/0x130 [intel_uncore_frequency]
    do_one_initcall+0xb9/0x450
    do_init_module+0x281/0x8c0
    load_module+0x1693/0x2090
    init_module_from_file+0xe8/0x150
unreferenced object 0xff11000150941840 (size 192):
  comm "(udev-worker)", pid 2753, jiffies 4295015473
  hex dump (first 32 bytes):
    40 fd f9 d4 01 00 11 ff 00 00 00 00 00 00 00 00  @...............
    c0 2b e5 08 00 00 a0 ff c0 fb ff ff 00 00 00 00  .+..............
  backtrace (crc efd34d21):
    __kmalloc_cache_node_noprof+0x39b/0x450
    idxd_wq_alloc_resources+0x6c9/0x1640 [idxd]
    idxd_drv_enable_wq+0x391/0x1100 [idxd]
    0xffffffffc22aa490
    really_probe+0x1e0/0x930
    __driver_probe_device+0x18c/0x3d0
    driver_probe_device+0x4a/0xd0
    __driver_attach+0x1e1/0x4a0
    bus_for_each_dev+0xef/0x170
    bus_add_driver+0x29d/0x5c0
    driver_register+0x130/0x450
    uncore_pm_notify+0xd1/0x130 [intel_uncore_frequency]
    do_one_initcall+0xb9/0x450
    do_init_module+0x281/0x8c0
    load_module+0x1693/0x2090
    init_module_from_file+0xe8/0x150
unreferenced object 0xff110001509425c0 (size 192):
  comm "(udev-worker)", pid 2753, jiffies 4295015473
  hex dump (first 32 bytes):
    40 d1 f9 d4 01 00 11 ff 00 00 00 00 00 00 00 00  @...............
    00 2c e5 08 00 00 a0 ff 00 fc ff ff 00 00 00 00  .,..............
  backtrace (crc 3e67f08):
    __kmalloc_cache_node_noprof+0x39b/0x450
    idxd_wq_alloc_resources+0x6c9/0x1640 [idxd]
    idxd_drv_enable_wq+0x391/0x1100 [idxd]
    0xffffffffc22aa490
    really_probe+0x1e0/0x930
    __driver_probe_device+0x18c/0x3d0
    driver_probe_device+0x4a/0xd0
    __driver_attach+0x1e1/0x4a0
    bus_for_each_dev+0xef/0x170
    bus_add_driver+0x29d/0x5c0
    driver_register+0x130/0x450
    uncore_pm_notify+0xd1/0x130 [intel_uncore_frequency]
    do_one_initcall+0xb9/0x450
    do_init_module+0x281/0x8c0
    load_module+0x1693/0x2090
    init_module_from_file+0xe8/0x150
unreferenced object 0xff11000150942740 (size 192):
  comm "(udev-worker)", pid 2753, jiffies 4295015473
  hex dump (first 32 bytes):
    40 dd f9 d4 01 00 11 ff 00 00 00 00 00 00 00 00  @...............
    40 2c e5 08 00 00 a0 ff 40 fc ff ff 00 00 00 00  @,......@.......
  backtrace (crc 4e740d35):
    __kmalloc_cache_node_noprof+0x39b/0x450
    idxd_wq_alloc_resources+0x6c9/0x1640 [idxd]
    idxd_drv_enable_wq+0x391/0x1100 [idxd]
    0xffffffffc22aa490
    really_probe+0x1e0/0x930
    __driver_probe_device+0x18c/0x3d0
    driver_probe_device+0x4a/0xd0
    __driver_attach+0x1e1/0x4a0
    bus_for_each_dev+0xef/0x170
    bus_add_driver+0x29d/0x5c0
    driver_register+0x130/0x450
    uncore_pm_notify+0xd1/0x130 [intel_uncore_frequency]
    do_one_initcall+0xb9/0x450
    do_init_module+0x281/0x8c0
    load_module+0x1693/0x2090
    init_module_from_file+0xe8/0x150
unreferenced object 0xff11000150943340 (size 192):
  comm "(udev-worker)", pid 2753, jiffies 4295015473
  hex dump (first 32 bytes):
    40 c2 f9 d4 01 00 11 ff 00 00 00 00 00 00 00 00  @...............
    80 2c e5 08 00 00 a0 ff 80 fc ff ff 00 00 00 00  .,..............
  backtrace (crc 68538b12):
    __kmalloc_cache_node_noprof+0x39b/0x450
    idxd_wq_alloc_resources+0x6c9/0x1640 [idxd]
    idxd_drv_enable_wq+0x391/0x1100 [idxd]
    0xffffffffc22aa490
    really_probe+0x1e0/0x930
    __driver_probe_device+0x18c/0x3d0
    driver_probe_device+0x4a/0xd0
    __driver_attach+0x1e1/0x4a0
    bus_for_each_dev+0xef/0x170
    bus_add_driver+0x29d/0x5c0
    driver_register+0x130/0x450
    uncore_pm_notify+0xd1/0x130 [intel_uncore_frequency]
    do_one_initcall+0xb9/0x450
    do_init_module+0x281/0x8c0
    load_module+0x1693/0x2090
    init_module_from_file+0xe8/0x150

I have a series that tries to fix those (and a few other things), I am
finishing testing it, should be able to propose it soon.


Cheers,
--=20
Vinicius

