Return-Path: <dmaengine+bounces-9937-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBHiHpB91mk0FwgAu9opvQ
	(envelope-from <dmaengine+bounces-9937-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 08 Apr 2026 18:08:48 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F5D3BEB27
	for <lists+dmaengine@lfdr.de>; Wed, 08 Apr 2026 18:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D899300EA94
	for <lists+dmaengine@lfdr.de>; Wed,  8 Apr 2026 16:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35F3347521;
	Wed,  8 Apr 2026 16:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="zrVhyJh9"
X-Original-To: dmaengine@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7053264C7;
	Wed,  8 Apr 2026 16:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775664525; cv=none; b=WPgBxFG0w/77J8mmMhuP/ovRQnfOIeV2CVGLBsgttYdRZOEQLLWWWtAX1q3QmbCStillDaEbRjGQ0UJvvov/9TpQodxKgn7SvPOuFe0PdX/cyClN6FICuouaK3fKAVM3cFfUGlZSaRyCyhHLI7JEEfbVeSVpAAEes1D+3FLPmlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775664525; c=relaxed/simple;
	bh=nKdEIjrrf25a7cvlv62t0Og5ZwpI8Zw49JIoRG6/n8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e/Oo/IJ2cB9sZzaubvoncmaZbNRQAS5kNa2YfZboKIEfrWQ3e0ULf4xfUvzyIyVlncUNhe0X9Q3vSV7WEK5FgHj2NsoMJcIjq1bfjvHN08ZfE9QAQz/iYjUi77IoXK23HoZOYEqgEJU2rJgAbLkG9XcovOwJd9Jx33kNd1B9AxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=zrVhyJh9; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Aig1lg191cXBZucnAyxENvKDcPyUXFvuxSQuwV9cV9s=; b=zrVhyJh9b5pTlInqr7oOP2b00b
	Sc4Vv4IeuoijoqLBX7W2A/CTeV3RWF1ETahKTxT8WN78xaBAuw5u83VVLDZ8o+l9YMZh5PtVlU7bP
	IQOgOcQLHR8nqIyXOdTOsmDwocIGiRBkQP7sxPtz9yBgPvLowpy0Fm1+UvyfoY1jrd3+LYFwTyzCK
	5V9G+xy7oN97W9jbv/43pd5db9ksKQ9sQsHmpThLJl0sqlYdrzANCvs37JqGX94SsoYpzk7W1IFCu
	LON7xk5FEOrgmkuql7qacQ/EIcEXPjhbB1JDYuol4ZcGuV5gVqea85EWox5TUg3HgOe2E9JK02IAi
	P+awcIyw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51122)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1wAVSI-000000002X6-0zei;
	Wed, 08 Apr 2026 17:08:38 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1wAVSE-000000003S6-1t8y;
	Wed, 08 Apr 2026 17:08:34 +0100
Date: Wed, 8 Apr 2026 17:08:34 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-ext4@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	dmaengine@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>
Subject: Re: BUG: net-next (7.0-rc6 based and later) fails to boot on Jetson
 Xavier NX
Message-ID: <adZ9grUg71f518Fg@shell.armlinux.org.uk>
References: <adZTGOjjJrVJOcT8@shell.armlinux.org.uk>
 <adZfTi3R6jtsjXx-@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adZfTi3R6jtsjXx-@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9937-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.970];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,shell.armlinux.org.uk:mid,armlinux.org.uk:url]
X-Rspamd-Queue-Id: D2F5D3BEB27
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 08, 2026 at 02:59:42PM +0100, Russell King (Oracle) wrote:
> On Wed, Apr 08, 2026 at 02:07:36PM +0100, Russell King (Oracle) wrote:
> > Hi,
> > 
> > Just a heads-up that current net-next (v7.0-rc6 based) fails to boot on
> > my nVidia Jetson Xavier platform. v7.0-rc5 and v6.14 based net-next both
> > boot fine. This is an arm64 platform.
> > 
> > The problem appears to be completely random in terms of its symptoms,
> > and looks like severe memory corruption - every boot seems to produce
> > a different problem. The common theme is, although the kernel gets to
> > userspace, it never gets anywhere close to a login prompt before
> > failing in some way.
> > 
> > The last net-next+ boot (which is currently v7.0-rc6 based) resulted
> > in:
> > 
> > tegra-mc 2c00000.memory-controller: xusb_hostw: secure write @0x00000003ffffff00: VPR violation ((null))
> > ...
> > irq 91: nobody cared (try booting with the "irqpoll" option)
> > ...
> > depmod: ERROR: could not open directory /lib/modules/7.0.0-rc6-net-next+: No such file or directory
> > ...
> > Unable to handle kernel paging request at virtual address 0003201fd50320cf
> > 
> > 
> > A previous boot of the exact same kernel didn't oops, but was unable
> > to find the block device to mount for /mnt via block UUID.
> > 
> > A previous boot to that resulted in an oops.
> > 
> > 
> > The intersting thing is - the depmod error above is incorrect:
> > 
> > root@tegra-ubuntu:~# ls -ld /lib/modules/7.0.0-rc6-net-next+
> > drwxrwxr-x 3 root root 4096 Apr  8 10:23 /lib/modules/7.0.0-rc6-net-next+
> > 
> > The directory is definitely there, and is readable - checked after
> > booting back into net-next based on 7.0-rc5. In some of these boots,
> > stmmac hasn't probed yet, which rules out my changes.
> > 
> > Rootfs is ext4, and it seems there were a lot of ext4 commits merged
> > between rc5 and rc6, but nothing for rc7.
> > 
> > My current net-next head is dfecb0c5af3b. Merging rc7 on top also
> > fails, I suspect also randomly, with that I just got:
> > 
> > EXT4-fs (mmcblk0p1): VFS: Can't find ext4 filesystem
> > mount: /mnt: wrong fs type, bad option, bad superblock on /dev/mmcblk0p1, missing codepage or helper program, or other error.
> > mount: /mnt/: can't find PARTUUID=741c0777-391a-4bce-a222-455e180ece2a.
> > Unable to handle kernel paging request at virtual address f9bf0011ac0fb893
> > Mem abort info:
> >   ESR = 0x0000000096000004
> >   EC = 0x25: DABT (current EL), IL = 32 bits
> >   SET = 0, FnV = 0
> >   EA = 0, S1PTW = 0
> >   FSC = 0x04: level 0 translation fault
> > Data abort info:
> >   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
> >   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> >   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> > [f9bf0011ac0fb893] address between user and kernel address ranges
> > Internal error: Oops: 0000000096000004 [#1]  SMP
> > Modules linked in:
> > CPU: 1 UID: 0 PID: 936 Comm: mount Not tainted 7.0.0-rc7-net-next+ #649 PREEMPT
> > Hardware name: NVIDIA NVIDIA Jetson Xavier NX Developer Kit/Jetson, BIOS 6.0-37391689 08/28/2024
> > pstate: 20400009 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > pc : refill_objects+0x298/0x5ec
> > lr : refill_objects+0x1f0/0x5ec
> > 
> > ...
> > 
> > Call trace:
> >  refill_objects+0x298/0x5ec (P)
> >  __pcs_replace_empty_main+0x13c/0x3a8
> >  kmem_cache_alloc_noprof+0x324/0x3a0
> >  alloc_iova+0x3c/0x290
> >  alloc_iova_fast+0x168/0x2d4
> >  iommu_dma_alloc_iova+0x84/0x154
> >  iommu_dma_map_sg+0x2c4/0x538
> >  __dma_map_sg_attrs+0x124/0x2c0
> >  dma_map_sg_attrs+0x10/0x20
> >  sdhci_pre_dma_transfer+0xb8/0x164
> >  sdhci_pre_req+0x38/0x44
> >  mmc_blk_mq_issue_rq+0x3dc/0x920
> >  mmc_mq_queue_rq+0x104/0x2b0
> >  __blk_mq_issue_directly+0x38/0xb0
> >  blk_mq_request_issue_directly+0x54/0xb4
> >  blk_mq_issue_direct+0x84/0x180
> >  blk_mq_dispatch_queue_requests+0x1a8/0x2e0
> >  blk_mq_flush_plug_list+0x60/0x140
> >  __blk_flush_plug+0xe0/0x11c
> >  blk_finish_plug+0x38/0x4c
> >  read_pages+0x158/0x260
> >  page_cache_ra_unbounded+0x158/0x3e0
> >  force_page_cache_ra+0xb0/0xe4
> >  page_cache_sync_ra+0x88/0x480
> >  filemap_get_pages+0xd8/0x850
> >  filemap_read+0xdc/0x3d8
> >  blkdev_read_iter+0x84/0x198
> >  vfs_read+0x208/0x2d8
> >  ksys_read+0x58/0xf4
> >  __arm64_sys_read+0x1c/0x28
> >  invoke_syscall.constprop.0+0x50/0xe0
> >  do_el0_svc+0x40/0xc0
> >  el0_svc+0x48/0x2a0
> >  el0t_64_sync_handler+0xa0/0xe4
> >  el0t_64_sync+0x19c/0x1a0
> > Code: 54000189 f9000022 aa0203e4 b9402ae3 (f8634840)
> > ---[ end trace 0000000000000000 ]---
> > Kernel panic - not syncing: Oops: Fatal exception
> > 
> > Looking at the changes between rc5 and rc6, there's one drivers/block
> > change for zram (which is used on this platform), one change in
> > drivers/base for regmap, nothing for drivers/mmc, but plenty for
> > fs/ext4. There are five DMA API changes.
> > 
> > Now building straight -rc7. If that also fails, my plan is to start
> > bisecting rc5..rc6, which will likely take most of the rest of the
> > day. So, in the mean time I'm sending this as a heads-up that rc6
> > and onwards has a problem.
> 
> Plain -rc7 fails (another random oops):
> 
> Root device found: PARTUUID=741c0777-391a-4bce-a222-455e180ece2a
> depmod: ERROR: could not open directory /lib/modules/7.0.0-rc7-net-next+: No such file or directory
> depmod: FATAL: could not search modules: No such file or directory
> usb 2-3: new SuperSpeed Plus Gen 2x1 USB device number 2 using tegra-xusb
> hub 2-3:1.0: USB hub found
> hub 2-3:1.0: 4 ports detected
> usb 1-3: new full-speed USB device number 3 using tegra-xusb
> Unable to handle kernel paging request at virtual address 0003201fd50320cf
> Mem abort info:
>   ESR = 0x0000000096000004
>   EC = 0x25: DABT (current EL), IL = 32 bits
>   SET = 0, FnV = 0
>   EA = 0, S1PTW = 0
>   FSC = 0x04: level 0 translation fault
> Data abort info:
>   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
>   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [0003201fd50320cf] address between user and kernel address ranges
> Internal error: Oops: 0000000096000004 [#1]  SMP
> Modules linked in:
> CPU: 1 UID: 0 PID: 917 Comm: mount Not tainted 7.0.0-rc7-net-next+ #649 PREEMPT
> Hardware name: NVIDIA NVIDIA Jetson Xavier NX Developer Kit/Jetson, BIOS 6.0-37391689 08/28/2024
> pstate: 20400009 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : refill_objects+0x298/0x5ec
> lr : refill_objects+0x1f0/0x5ec
> sp : ffff80008606b500
> x29: ffff80008606b500 x28: 0000000000000001 x27: fffffdffc20e6200
> x26: 0000000000000006 x25: 0000000000000000 x24: 000000000000003c
> x23: ffff0000809e4840 x22: ffff0000809dba00 x21: ffff80008606b5a0
> x20: ffff000081133820 x19: fffffdffc20e6220 x18: 0000000000000000
> x17: 0000000000000000 x16: 0000000000000100 x15: 0000000000000000
> x14: 0000000000000000 x13: 0000000000000000 x12: ffff800081e5faa8
> x11: ffff800082192c70 x10: ffff8000814074dc x9 : 0000000000000050
> x8 : ffff80008606b490 x7 : ffff000083988b40 x6 : ffff80008606b4a0
> x5 : 000000080015000f x4 : d503201fd503201f x3 : 00000000000000b0
> x2 : d503201fd503201f x1 : ffff000081133828 x0 : d503201fd503201f
> Call trace:
>  refill_objects+0x298/0x5ec (P)
>  __pcs_replace_empty_main+0x13c/0x3a8
>  kmem_cache_alloc_noprof+0x324/0x3a0
>  mempool_alloc_slab+0x1c/0x28
>  mempool_alloc_noprof+0x98/0xe0
>  bio_alloc_bioset+0x160/0x3e0
>  do_mpage_readpage+0x3d0/0x618
>  mpage_readahead+0xb8/0x144
>  blkdev_readahead+0x18/0x24
>  read_pages+0x58/0x260
>  page_cache_ra_unbounded+0x158/0x3e0
>  force_page_cache_ra+0xb0/0xe4
>  page_cache_sync_ra+0x88/0x480
>  filemap_get_pages+0xd8/0x850
>  filemap_read+0xdc/0x3d8
>  blkdev_read_iter+0x84/0x198
>  vfs_read+0x208/0x2d8
>  ksys_read+0x58/0xf4
>  __arm64_sys_read+0x1c/0x28
>  invoke_syscall.constprop.0+0x50/0xe0
>  do_el0_svc+0x40/0xc0
>  el0_svc+0x48/0x2a0
>  el0t_64_sync_handler+0xa0/0xe4
>  el0t_64_sync+0x19c/0x1a0
> Code: 54000189 f9000022 aa0203e4 b9402ae3 (f8634840)
> ---[ end trace 0000000000000000 ]---
> 
> Now starting the bisect between 7.0-rc5 and 7.0-rc6.

The rebase is still progressing, but it's landed on:

c7d812e33f3e dmaengine: xilinx: xilinx_dma: Fix unmasked residue subtraction

and while this boots to a login prompt, it spat out a BUG():

BUG: sleeping function called from invalid context at kernel/locking/mutex.c:591
in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 56, name: kworker/u24:3
preempt_count: 0, expected: 0
RCU nest depth: 0, expected: 0
3 locks held by kworker/u24:3/56:
 #0: ffff000080042148 ((wq_completion)events_unbound#2){+.+.}-{0:0}, at: process_one_work+0x184/0x780
 #1: ffff80008299bdf8 (deferred_probe_work){+.+.}-{0:0}, at: process_one_work+0x1ac/0x780
 #2: ffff0000808b48f8 (&dev->mutex){....}-{4:4}, at: __device_attach+0x2c/0x188
irq event stamp: 10872
hardirqs last  enabled at (10871): [<ffff80008013a410>] ktime_get+0x130/0x180
hardirqs last disabled at (10872): [<ffff800080d61ac8>] _raw_spin_lock_irqsave+0x84/0x88
softirqs last  enabled at (9216): [<ffff80008002807c>] fpsimd_save_and_flush_current_state+0x3c/0x80
softirqs last disabled at (9214): [<ffff800080028098>] fpsimd_save_and_flush_current_state+0x58/0x80
CPU: 5 UID: 0 PID: 56 Comm: kworker/u24:3 Not tainted 7.0.0-rc1-bisect+ #654 PREEMPT
Hardware name: NVIDIA NVIDIA Jetson Xavier NX Developer Kit/Jetson, BIOS 6.0-37391689 08/28/2024
Workqueue: events_unbound deferred_probe_work_func
Call trace:
 show_stack+0x18/0x30 (C)
 dump_stack_lvl+0x6c/0x94
 dump_stack+0x18/0x24
 __might_resched+0x154/0x220
 __might_sleep+0x48/0x80
 __mutex_lock+0x48/0x800
 mutex_lock_nested+0x24/0x30
 pinmux_disable_setting+0x9c/0x180
 pinctrl_commit_state+0x5c/0x260
 pinctrl_pm_select_idle_state+0x4c/0xa0
 tegra_i2c_runtime_suspend+0x2c/0x3c
 pm_generic_runtime_suspend+0x2c/0x44
 __rpm_callback+0x48/0x1ec
 rpm_callback+0x74/0x80
 rpm_suspend+0xec/0x630
 rpm_idle+0x2c0/0x420
 __pm_runtime_idle+0x44/0x160
 tegra_i2c_probe+0x2e4/0x640
 platform_probe+0x5c/0xa4
 really_probe+0xbc/0x2c0
 __driver_probe_device+0x78/0x120
 driver_probe_device+0x3c/0x160
 __device_attach_driver+0xbc/0x160
 bus_for_each_drv+0x70/0xb8
 __device_attach+0xa4/0x188
 device_initial_probe+0x50/0x54
 bus_probe_device+0x38/0xa4
 deferred_probe_work_func+0x90/0xcc
 process_one_work+0x204/0x780
 worker_thread+0x1c8/0x36c
 kthread+0x138/0x144
 ret_from_fork+0x10/0x20

This is reproducible.

Adding Vinod and Frank, and dmaengine mailing list.

Bisect continuing, assuming this is a "good" commit as it isn't
producing the boot failure with random memory corruption.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

