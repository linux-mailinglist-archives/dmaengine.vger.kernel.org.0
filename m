Return-Path: <dmaengine+bounces-4753-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95734A6203E
	for <lists+dmaengine@lfdr.de>; Fri, 14 Mar 2025 23:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3231463E70
	for <lists+dmaengine@lfdr.de>; Fri, 14 Mar 2025 22:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DE11CDFAC;
	Fri, 14 Mar 2025 22:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gxiGwwSO"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C851953A9;
	Fri, 14 Mar 2025 22:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741991075; cv=none; b=BOXotHSkGcb2ijXevS4cRsijxK5L66jWFTBHUTK01/IZLLEWcRim8zGhz7bS9aqR2VBgp7SQDbURMgzJse+veoAHQfBG/PJtWS/KaNopHTz+DMtto3ZW232ESyKQ6sqqcnToUdnFWZ/RKBSJ9PRbHImNyYIERwvL8nHizTkA2dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741991075; c=relaxed/simple;
	bh=2iPF09/73Y2/FsHDG/bBMsESVkhQixGyqVI21C9ul58=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EO9rD0MLLx2l7ehgXouXqYMtucRu/erA0h3SqtYFd4qDhP31j2RBspUCvanpLnIGvRTDPvbriljYQT68p/sUHQ8MamKyOx8uELnr11hsjmiikZEgEKTm9ZQXi+5qBYyP0tHSxWrmISgU77U6bhhRdaAopAOLXYj46EePBW+0VHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gxiGwwSO; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741991073; x=1773527073;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=2iPF09/73Y2/FsHDG/bBMsESVkhQixGyqVI21C9ul58=;
  b=gxiGwwSO4CDVEXNTqRmXYVjxw8Gry4A4CQ0JilTa/s/zii1Rmk8MgLeb
   b6vxDCfCm4ghjNmtTE0JgRp3Vz9q8CKA5g7RMExiHLF/lGohqv18Fprh6
   pvALzlSNVXgpA5g38X8u+dkntuHxWN0Z4kAE1UVtMbTH+AC+5DYNvZOSo
   huBFTNtS3regAbpfcWNgrryyxfuE9M9JyBjK63XIvn2TzE67Pbh6kiiFx
   eqX4Xl0gyglID/rrquAs+d1Yz710d70btO6DkREq9kqoBHzguVp1hoy23
   /gOsYCdhb5hoYNqRiwT1tKu552YMWfmF1j3OyXJf59JCeBqCysFCCR/12
   Q==;
X-CSE-ConnectionGUID: 4csbV0LYT8OG2Fmntarz0g==
X-CSE-MsgGUID: q7HFZsedTvO7kX15ePo4Bg==
X-IronPort-AV: E=McAfee;i="6700,10204,11373"; a="60700719"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="60700719"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 15:24:31 -0700
X-CSE-ConnectionGUID: VIOTuoN3TbCQwH9bO+LheQ==
X-CSE-MsgGUID: Z8Nf02SFQ/+sk54i7KNxKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="121350507"
Received: from bjrankin-mobl3.amr.corp.intel.com (HELO vcostago-mobl3) ([10.124.222.233])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 15:24:32 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Nathan Lynch <nathan.lynch@amd.com>, Vinod Koul <vkoul@kernel.org>,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: dave.jiang@intel.com, kristen.c.accardi@intel.com, kernel test robot
 <oliver.sang@intel.com>
Subject: Re: [PATCH v1] dmaengine: dmatest: Fix dmatest waiting less when
 interrupted
In-Reply-To: <87y0x7z45p.fsf@AUSNATLYNCH.amd.com>
References: <20250305230007.590178-1-vinicius.gomes@intel.com>
 <878qpa13fe.fsf@AUSNATLYNCH.amd.com> <87senhoq1k.fsf@intel.com>
 <874izx10nx.fsf@AUSNATLYNCH.amd.com> <87wmcslwg4.fsf@intel.com>
 <871pv01vaz.fsf@AUSNATLYNCH.amd.com> <87r030ldbw.fsf@intel.com>
 <87y0x7z45p.fsf@AUSNATLYNCH.amd.com>
Date: Fri, 14 Mar 2025 15:24:30 -0700
Message-ID: <87ldt7l081.fsf@intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Nathan Lynch <nathan.lynch@amd.com> writes:

> Vinicius Costa Gomes <vinicius.gomes@intel.com> writes:
>> Nathan Lynch <nathan.lynch@amd.com> writes:
>>> Vinicius Costa Gomes <vinicius.gomes@intel.com> writes:
>>>> My understanding (and testing) is that wait_event_timeout() will block
>>>> for the duration even in the face of interrupts, 'freezable' will not.
>>>
>>> They have different behaviors with respect to *signals* and the
>>> wake_up() variant used, but not device interrupts.
>>>
>>
>> Ah! That's something that I wasn't considering. That it could be
>> something other than interrupts that were unblocking wait_event_*().
>
> Well, I doubt it would be a signal in this case. Maybe you've
> experienced timeouts?
>

What I was seeing is that the wait_event_freezable_timeout() was
finishing early, 'done->done' was false, and so dmatest considers it a
timeout, and cleans everything up.

Later the pending operation finishes, resulting in the warning below,
because it everything was already cleaned up.

Changing the way the waiting was done fixed the issue. (perhaps
approaching from the other direction, "why is it finishing early?",
might be better)

The log I was seeing is here:

[ 2677.607890] dmatest: Added 1 threads using dma8chan0
[ 2677.608063] dmatest: Started 1 threads using dma8chan0
[ 2677.623910] dmatest: dma8chan0-copy0: result #777: 'test timed out' with=
 src_off=3D0x1 dst_off=3D0x4 len=3D0x1c (0)
[ 2677.623917] dmatest: dma8chan0-copy0: summary 777 tests, 1 failures 5032=
3.83 iops 777 KB/s (0)
[ 2677.624356] ------------[ cut here ]------------
[ 2677.624360] dmatest: Kernel memory may be corrupted!!
[ 2677.624385] WARNING: CPU: 142 PID: 38729 at drivers/dma/dmatest.c:450 dm=
atest_callback+0x30/0x40 [dmatest]
[ 2677.624391] Modules linked in: dmatest(-) idxd idxd_bus xt_conntrack nft=
_chain_nat xt_MASQUERADE nf_nat nf_conntrack_netlink nf_conntrack nf_defrag=
_ipv6 nf_defrag_ipv4 xfrm_user xfrm_algo xt_addrtype nft_compat nf_tables b=
r_netfilter bridge stp llc overlay intel_rapl_msr intel_rapl_common intel_u=
ncore_frequency intel_uncore_frequency_common i10nm_edac skx_edac_common nf=
it x86_pkg_temp_thermal intel_powerclamp coretemp snd_hda_codec_realtek bin=
fmt_misc snd_hda_codec_generic snd_hda_scodec_component kvm_intel snd_hda_i=
ntel dax_hmem snd_intel_dspcfg snd_intel_sdw_acpi cxl_acpi cxl_port snd_hda=
_codec snd_hda_core kvm snd_hwdep ast drm_client_lib drm_shmem_helper rapl =
ipmi_ssif drm_kms_helper cxl_core snd_pcm isst_if_mmio isst_if_mbox_pci int=
el_cstate einj i2c_algo_bit qat_4xxx snd_timer isst_if_common i2c_i801 nls_=
iso8859_1 intel_qat snd mei_me crc8 i2c_mux authenc soundcore i2c_smbus mei=
 i2c_ismt acpi_power_meter ipmi_si acpi_ipmi ipmi_devintf ipmi_msghandler a=
cpi_pad joydev input_leds mac_hid sch_fq_codel dm_multipath
[ 2677.624453]  drm efi_pstore nfnetlink dmi_sysfs ip_tables x_tables autof=
s4 btrfs blake2b_generic zstd_compress raid10 raid456 async_raid6_recov asy=
nc_memcpy async_pq async_xor async_tx xor raid6_pq raid1 raid0 hid_generic =
nvme ghash_clmulni_intel usbhid ahci sha512_ssse3 sha256_ssse3 hid nvme_cor=
e igc sha1_ssse3 libahci wmi pinctrl_emmitsburg aesni_intel crypto_simd cry=
ptd [last unloaded: dmatest]
[ 2677.624482] CPU: 142 UID: 0 PID: 38729 Comm: irq/112-idxd-po Not tainted=
 6.14.0-rc1+ #11
[ 2677.624484] Hardware name: Intel Corporation ArcherCity/ArcherCity, BIOS=
 EGSDCRB1.SYS.0037.P02.2305261001 05/26/2023
[ 2677.624485] RIP: 0010:dmatest_callback+0x30/0x40 [dmatest]
[ 2677.624488] Code: 44 00 00 80 7f 10 00 75 15 c6 07 01 48 8b 7f 08 31 c9 =
31 d2 be 03 00 00 00 e9 5c 20 03 f6 48 c7 c7 00 22 d6 c0 e8 30 9a f9 f5 <0f=
> 0b c3 cc cc cc cc 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
[ 2677.624489] RSP: 0018:ff574666a8037db8 EFLAGS: 00010282
[ 2677.624491] RAX: 0000000000000000 RBX: ff4a4a2b1bb8a600 RCX: ff4a4a2e6ff=
21a48
[ 2677.624492] RDX: 0000000000000027 RSI: 0000000000000027 RDI: 00000000000=
00001
[ 2677.624493] RBP: 0000000000000001 R08: 0000000000000000 R09: 00000000000=
00003
[ 2677.624494] R10: ff574666a8037c58 R11: ff4a4a327fec9fe8 R12: ff4a4a2b1bb=
8a620
[ 2677.624495] R13: ff4a4a2b1bb8a600 R14: ffffffffffffff88 R15: fffffffffff=
fff88
[ 2677.624496] FS:  0000000000000000(0000) GS:ff4a4a2e6ff00000(0000) knlGS:=
0000000000000000
[ 2677.624498] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2677.624499] CR2: 00007f71f9e543f0 CR3: 0000000159530003 CR4: 0000000000f=
73ef0
[ 2677.624500] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[ 2677.624501] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 00000000000=
00400
[ 2677.624502] PKRU: 55555554
[ 2677.624503] Call Trace:
[ 2677.624505]  <TASK>
[ 2677.624507]  ? __warn+0x91/0x190
[ 2677.624511]  ? dmatest_callback+0x30/0x40 [dmatest]
[ 2677.624515]  ? report_bug+0x164/0x190
[ 2677.624521]  ? handle_bug+0x58/0x90
[ 2677.624524]  ? exc_invalid_op+0x17/0x70
[ 2677.624526]  ? asm_exc_invalid_op+0x1a/0x20
[ 2677.624532]  ? dmatest_callback+0x30/0x40 [dmatest]
[ 2677.624534]  ? dmatest_callback+0x30/0x40 [dmatest]
[ 2677.624536]  idxd_dma_complete_txd+0x151/0x160 [idxd]
[ 2677.624544]  idxd_wq_thread+0x1c0/0x2b0 [idxd]
[ 2677.624549]  irq_thread_fn+0x20/0x60
[ 2677.624554]  irq_thread+0x18b/0x2c0
[ 2677.624556]  ? __pfx_irq_thread_fn+0x10/0x10
[ 2677.624559]  ? __pfx_irq_thread_dtor+0x10/0x10
[ 2677.624562]  ? __pfx_irq_thread+0x10/0x10
[ 2677.624565]  kthread+0x100/0x210
[ 2677.624569]  ? __pfx_kthread+0x10/0x10
[ 2677.624572]  ret_from_fork+0x31/0x50
[ 2677.624575]  ? __pfx_kthread+0x10/0x10
[ 2677.624577]  ret_from_fork_asm+0x1a/0x30
[ 2677.624584]  </TASK>
[ 2677.624585] irq event stamp: 18951
[ 2677.624586] hardirqs last  enabled at (18957): [<ffffffffb6d9c5ee>] __up=
_console_sem+0x5e/0x70
[ 2677.624589] hardirqs last disabled at (18962): [<ffffffffb6d9c5d3>] __up=
_console_sem+0x43/0x70
[ 2677.624591] softirqs last  enabled at (1084): [<ffffffffb6cde835>] handl=
e_softirqs+0x315/0x3f0
[ 2677.624594] softirqs last disabled at (1067): [<ffffffffb6cde9cc>] __irq=
_exit_rcu+0xac/0xd0
[ 2677.624596] ---[ end trace 0000000000000000 ]---

>>> dmatest_callback() employs wake_up_all(), which means this change
>>> introduces no beneficial difference in the wakeup behavior. The dmatest
>>> thread gets woken on receipt of the completion interrupt either way.
>>>
>>> And to reiterate, the change regresses the combination of dmatest and
>>> the task freezer, which is a use case people have cared about,
>>> apparently.
>>>
>>
>> If this change in behavior causes a regression for others, glad to send
>> a revert and find another solution.
>
> Thanks - yes it should be reverted or dropped IMO.

Here's what I am thinking, I'll work on this a few days and see if I can
find an alternative solution and send the revert together with the fix.
If I can't find another solution in a few days, I'll propose the revert
anyway.


Cheers,
--=20
Vinicius

