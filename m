Return-Path: <dmaengine+bounces-5870-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59804B1363D
	for <lists+dmaengine@lfdr.de>; Mon, 28 Jul 2025 10:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2384A7A329A
	for <lists+dmaengine@lfdr.de>; Mon, 28 Jul 2025 08:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF1A230BFD;
	Mon, 28 Jul 2025 08:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Qi6pAesr"
X-Original-To: dmaengine@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28077230D0D;
	Mon, 28 Jul 2025 08:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753690877; cv=none; b=d1PhBybJrf9tXCemirR1FgTXuFrP1OVZYP5UqR4FHKkArdD0md6SnOs+Srq3Wlr3MYP0p/8mddFwpbAxiLLgYCRQbJsXhOakOJxUqxSYAzfknCsfr0X8RG2pRSGcn9zHYRKneeabASvaY9GOLZ24ba8Z33VWDG7YNRljxCf1xss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753690877; c=relaxed/simple;
	bh=7ZyvY7I7owQbk72RPNwke6/k7cK+PHG379I5u290lJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mqfb4a1g4gmZU8HYs134MyFteEYj6IiMrTAzO9F5rAje255u8TCDLH8x4urs3FXNmFov3wG5DWD0PuFlEp3UeL7X4i9gvCs1V7Gy1Q//TpjBZevWxVq5plZ+FHmpDAHLifOXyvYzcF7Q5j9sOWgPT2HtxoqwlFJNB9H6pAq+bx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Qi6pAesr; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753690865; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=cGln4gZn1Fqk/yjNF3DgDWSE89q2gcWJtiK8Gbfwbck=;
	b=Qi6pAesrSWf3TS7MbODcgO/ZddwJ1Riskd/uGRttI28pBEi4NxV/ARIOqvzP91DUwxNrE6bPASjeryb1i7/QXrovzGyQ5WI/WqwVPfyLpkQqiGP/jH+Pi2NspbR87MarUPvhbCzby6hu7DGYJ8JfzABOQLE1Dw1pM8Dg/j3MRcw=
Received: from 30.246.181.19(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WkFeaDh_1753690863 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 28 Jul 2025 16:21:04 +0800
Message-ID: <b8d8cd51-41d4-4f8a-a885-baa41f5a587f@linux.alibaba.com>
Date: Mon, 28 Jul 2025 16:21:03 +0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dmaengine: idxd: Remove improper idxd_free
To: Yi Sun <yi.sun@intel.com>, Fenghua Yu <fenghuay@nvidia.com>
Cc: vinicius.gomes@intel.com, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org, dave.jiang@intel.com, gordon.jin@intel.com
References: <20250617102712.727333-1-yi.sun@intel.com>
 <20250617102712.727333-2-yi.sun@intel.com>
 <d4b51d33-e46b-448d-b6d3-f0845b1d05f8@nvidia.com>
 <aIXrCM10dxz0LxRb@ysun46-mobl.ccr.corp.intel.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <aIXrCM10dxz0LxRb@ysun46-mobl.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi, Sun, Yi and Fenghua,

在 2025/7/27 17:02, Yi Sun 写道:
> On 17.06.2025 15:13, Fenghua Yu wrote:
>> Hi, Yi,
>>
>> On 6/17/25 03:27, Yi Sun wrote:
>>> The call to idxd_free() introduces a duplicate put_device() leading to a
>>> reference count underflow:
>>> refcount_t: underflow; use-after-free.
>>> WARNING: CPU: 15 PID: 4428 at lib/refcount.c:28 refcount_warn_saturate+0xbe/0x110
>>> ...
>>> Call Trace:
>>>  <TASK>
>>>   idxd_remove+0xe4/0x120 [idxd]
>>>   pci_device_remove+0x3f/0xb0
>>>   device_release_driver_internal+0x197/0x200
>>>   driver_detach+0x48/0x90
>>>   bus_remove_driver+0x74/0xf0
>>>   pci_unregister_driver+0x2e/0xb0
>>>   idxd_exit_module+0x34/0x7a0 [idxd]
>>>   __do_sys_delete_module.constprop.0+0x183/0x280
>>>   do_syscall_64+0x54/0xd70
>>>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>
>>> The idxd_unregister_devices() which is invoked at the very beginning of
>>> idxd_remove(), already takes care of the necessary put_device() through the
>>> following call path:
>>> idxd_unregister_devices() -> device_unregister() -> put_device()
>>>
>>> In addition, when CONFIG_DEBUG_KOBJECT_RELEASE is enabled, put_device() may
>>> trigger asynchronous cleanup via schedule_delayed_work(). If idxd_free() is
>>> called immediately after, it can result in a use-after-free.
>>>
>>> Remove the improper idxd_free() to avoid both the refcount underflow and
>>> potential memory corruption during module unload.
>>>
>>> Fixes: d5449ff1b04d ("dmaengine: idxd: Add missing idxd cleanup to fix memory leak in remove call")
>>> Signed-off-by: Yi Sun <yi.sun@intel.com>
>>>
>>> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
>>> index 80355d03004d..40cc9c070081 100644
>>> --- a/drivers/dma/idxd/init.c
>>> +++ b/drivers/dma/idxd/init.c
>>> @@ -1295,7 +1295,6 @@ static void idxd_remove(struct pci_dev *pdev)
>>>      idxd_cleanup(idxd);
>>>      pci_iounmap(pdev, idxd->reg_base);
>>>      put_device(idxd_confdev(idxd));
>>> -    idxd_free(idxd);
>>
>> Simply removing idxd_free() causes two issues:
>>
>> 1. This hits memory leak issues because allocated idxd, ida, map are not freed.
>>
>> 2. There is still an underflow issue for dev refcnt in idxd_pci_probe_alloc() when idxd_register_devices() fails. Here get_device() is not called but put_device() is called.
>>
>> A right fix is to remove the put_device() in idxd_free(). This will fix all the above issues.
>>
>> Thanks.
>>
>> -Fenghua
>>
> 
> Hi Fenghua,
>  From my understanding, the function idxd_conf_device_release already
> covers everything done in idxd_free, including:
>      bitmap_free(idxd->opcap_bmap);
>      ida_free(&idxd_ida, idxd->id);
>      kfree(idxd);
> 
> At least the newly added idxd_free in commit 90022b3 doesn't resolve
> any memory leaks, but introduces several duplicated cleanup.
> 
> reference:
> ```
> static void idxd_free(struct idxd_device *idxd)
> {
>         if (!idxd)
>                 return;
> 
>         put_device(idxd_confdev(idxd));
>         bitmap_free(idxd->opcap_bmap);
>         ida_free(&idxd_ida, idxd->id);
>         kfree(idxd);
> }
> ```
> 
> V.S.
> ```
> static void idxd_conf_device_release(struct device *dev)
> {
>      struct idxd_device *idxd = confdev_to_idxd(dev);
> 
>      kfree(idxd->groups);
>      bitmap_free(idxd->wq_enable_map);
>      kfree(idxd->wqs);
>      kfree(idxd->engines);
>      kfree(idxd->evl);
>      kmem_cache_destroy(idxd->evl_cache);
>      ida_free(&idxd_ida, idxd->id);
>      bitmap_free(idxd->opcap_bmap);
>      kfree(idxd);
> }
> ```
> 
> Thanks
>     --Sun, Yi

Thanks for the detailed analysis. After reviewing the code paths, I
agree with Yi Sun's assessment.

Looking at the call flow:

     idxd_remove()
     	-> idxd_unregister_devices
     		-> idxd_conf_device_release
     			-> cleaup // first freed here
     	-> idxd_free
     		-> clean up  // double freed here

The idxd_conf_device_release() function already handles all the cleanup
that idxd_free() attempts to do:

Calling idxd_free() after idxd_unregister_devices() results in
double-free issues. I can reproduce this with the following warning:

     ------------[ cut here ]------------
     ida_free called for id=4 which is not allocated.
     WARNING: CPU: 169 PID: 13495 at lib/idr.c:592 ida_free+0xe2/0x140
     Modules linked in: binfmt_misc(E) bonding(E) tls(E) intel_rapl_msr(E) intel_rapl_common(E) intel_uncore_frequency(E) intel_uncore_frequency_common(E) i10nm_edac(E) skx_edac_common(E) nfit(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) coretemp(E) rfkill(E) kvm_intel(E) kvm(E) snd_hda_intel(E) snd_intel_dspcfg(E) snd_hda_codec(E) irqbypass(E) mlx5_ib(E) nf_tables(E) snd_hda_core(E) dax_hmem(E) ghash_clmulni_intel(E) snd_hwdep(E) cxl_acpi(E) rapl(E) snd_pcm(E) cxl_port(E) pmt_telemetry(E) iTCO_wdt(E) qat_4xxx(E) ib_uverbs(E) cxl_core(E) iTCO_vendor_support(E) pmt_class(E) isst_if_mbox_pci(E) intel_cstate(E) isst_if_mmio(E) snd_timer(E) tun(E) intel_qat(E) nfnetlink(E) intel_uncore(E) einj(E) pcspkr(E) joydev(E) ib_core(E) dh_generic(E) idxd(E-) crc8(E) isst_if_common(E) authenc(E) intel_vsec(E) idxd_bus(E) snd(E) mei_me(E) i2c_i801(E) soundcore(E) i2c_smbus(E) mei(E) i2c_ismt(E) ipmi_ssif(E) acpi_power_meter(E) ipmi_si(E) acpi_ipmi(E) ipmi_devintf(E) ipmi_msghandle
     drm_client_lib(E) i2c_algo_bit(E) drm_shmem_helper(E) drm_kms_helper(E) nvme(E) mlx5_core(E) mlxfw(E) nvme_core(E) pci_hyperv_intf(E) psample(E) drm(E) wmi(E) pinctrl_emmitsburg(E) sd_mod(E) sg(E) ahci(E) libahci(E) libata(E) fuse(E)
     CPU: 169 UID: 0 PID: 13495 Comm: rmmod Kdump: loaded Tainted: G S      W   E       6.16.0-rc6 #115 PREEMPT(none)
     Tainted: [S]=CPU_OUT_OF_SPEC, [W]=WARN, [E]=UNSIGNED_MODULE
     Hardware name: Inspur AliServer-Xuanwu2.0-02-1UCG42PF/AS2111TG5, BIOS 3.0.ES.AL.P.090.01 02/22/2024
     RIP: 0010:ida_free+0xe2/0x140
     Code: f6 48 89 e7 e8 bf 2b 02 00 eb 5e 83 fb 3e 76 3a 48 8b 3c 24 4c 89 ee e8 bc a1 03 00 89 ee 48 c7 c7 b8 be 7a 9a e8 4e 70 2f ff <0f> 0b 48 8b 44 24 38 65 48 2b 05 17 11 20 02 75 3c 48 83 c4 40 5b
     RSP: 0018:ff51ea5f331e3d78 EFLAGS: 00010282
     RAX: 0000000000000000 RBX: 0000000000000004 RCX: ff3a3c153f85c448
     RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ff3a3c153f85c440
     RBP: 0000000000000004 R08: 0000000000000000 R09: ff51ea5f331e3c28
     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
     R13: 0000000000000202 R14: ff3a3b97569ecc80 R15: ffffffffc0d41938
     R10: ff51ea5f331e3c20 R11: ffffffff9b761d68 R12: 000000000000000f
     FS:  00007f4c7e1c3740(0000) GS:ff3a3c15a3679000(0000) knlGS:0000000000000000
     CR2: 0000562018b242c8 CR3: 00000080a849a004 CR4: 0000000000f73ef0
     Call Trace:
     <TASK>
     PKRU: 55555554
     idxd_remove+0x8d/0xa0 [idxd]
     device_release_driver_internal+0x197/0x200
     pci_device_remove+0x3f/0xb0
     driver_detach+0x48/0x90
     do_syscall_64+0x5f/0x2d0
     entry_SYSCALL_64_after_hwframe+0x76/0x7e
     __do_sys_delete_module.constprop.0+0x174/0x310
     idxd_exit_module+0x34/0x680 [idxd]
     bus_remove_driver+0x6d/0xf0
     pci_unregister_driver+0x2e/0xb0
     RIP: 0033:0x7f4c7dc620cb
     RSP: 002b:00007ffcb58d0b78 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
     Code: 73 01 c3 48 8b 0d a5 6d 19 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 75 6d 19 00 f7 d8 64 89 01 48
     RAX: ffffffffffffffda RBX: 0000562018b19780 RCX: 00007f4c7dc620cb
     RDX: 000000000000000a RSI: 0000000000000800 RDI: 0000562018b197e8
     RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
     R10: 00007f4c7ddaaac0 R11: 0000000000000206 R12: 00007ffcb58d0da0
     </TASK>
     R13: 00007ffcb58d2352 R14: 0000562018b192a0 R15: 0000562018b19780

Yi Sun's fix to remove the idxd_free() call is the correct approach. The
device release mechanism properly handles all the cleanup through the
established kernel device model.

Sorry for the confusion in the original implementation.

Tested-by: Shuai Xue <xueshuai@linux.alibaba.com>

Best regards,
Shuai

