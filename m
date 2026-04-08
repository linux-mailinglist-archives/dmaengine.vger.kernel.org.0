Return-Path: <dmaengine+bounces-9938-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4ESJLnB/1mmQFwgAu9opvQ
	(envelope-from <dmaengine+bounces-9938-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 08 Apr 2026 18:16:48 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1B23BEC03
	for <lists+dmaengine@lfdr.de>; Wed, 08 Apr 2026 18:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93AE6300575A
	for <lists+dmaengine@lfdr.de>; Wed,  8 Apr 2026 16:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0866D39C00C;
	Wed,  8 Apr 2026 16:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ITMYpG4U"
X-Original-To: dmaengine@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D93258EE0;
	Wed,  8 Apr 2026 16:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775665005; cv=none; b=FztJ84kWkke7pFJ7CeedMKfGunLZ4ATAXACmDWd4zYrxFoLjS/HCv0EVezkrJHEercz8jvRXq45OtWEn4FnIFMEw5i6p9LtmmtoBgC1+oJgf3BWSTirtrgGpBpn4jDGP52Y7hpj7SBbj9FGLEjP0I+egKJKmiOjlQpcnqv+JmG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775665005; c=relaxed/simple;
	bh=b4sb+fMRVDp4dZIIy3qq8AiTgJFwthxZDq9ZetayxBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YL+cjWaM86m9ZZPD980aMdBj3BymTfOGFR4rHOiAyv3akJ6GFsn+kSmZPfAVcO0rpap7wHdEPj2yI4mRX4H4lGGLN9PPWLgvfDu5CeBHkoZFIMHjH2OXoZdR+l+YGmOWb0/NaVwz7g8ml1zQn/wqb40sRuB97XWuZFJQG3lqTjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ITMYpG4U; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=CfdyWJ3Qr80V1uKZXTFnDLnM4nsCDmkZ8bNVSdiS6I4=; b=ITMYpG4U+EmGmjq/YNIMceE19n
	Y0SKNHfYZ24VAtlLKbvBPlyGJ/hqHSRCP7MJRMJGXUlkvoLDqoZqP8dAY2T3Je0M45/r+lVzKHVRC
	pA2V3Pw0dXjbpWGy9MjKsX1FJSVP1OdeW7D3NvdVR01jvh7BHtGQJq/wFd9MniTpJVDR6WkasS8IG
	GxXuJ773xL7bv2fxezmkDS1T0xwLOmVCXLN7v/hYOO+3NrtOnOOMamUkdPJNgheAsg9p0UggVhzvk
	q/Ph0j5x8sftCAYnHEqknVfE1XG9zwZC5vb5LL7eefI1GxLB1Gglgs1ryd5SMM5aR5/zdXSj6vI+0
	7XCB/rKQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46498)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1wAVa5-000000002Xb-0zoE;
	Wed, 08 Apr 2026 17:16:41 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1wAVa2-000000003TA-2L3h;
	Wed, 08 Apr 2026 17:16:38 +0100
Date: Wed, 8 Apr 2026 17:16:38 +0100
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
Message-ID: <adZ_ZmjcE8S22vR1@shell.armlinux.org.uk>
References: <adZTGOjjJrVJOcT8@shell.armlinux.org.uk>
 <adZfTi3R6jtsjXx-@shell.armlinux.org.uk>
 <adZ9grUg71f518Fg@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adZ9grUg71f518Fg@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9938-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.967];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,armlinux.org.uk:url,shell.armlinux.org.uk:mid]
X-Rspamd-Queue-Id: 2A1B23BEC03
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 08, 2026 at 05:08:34PM +0100, Russell King (Oracle) wrote:
> The rebase is still progressing, but it's landed on:
> 
> c7d812e33f3e dmaengine: xilinx: xilinx_dma: Fix unmasked residue subtraction
> 
> and while this boots to a login prompt, it spat out a BUG():
> 
> BUG: sleeping function called from invalid context at kernel/locking/mutex.c:591
> in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 56, name: kworker/u24:3
> preempt_count: 0, expected: 0
> RCU nest depth: 0, expected: 0
> 3 locks held by kworker/u24:3/56:
>  #0: ffff000080042148 ((wq_completion)events_unbound#2){+.+.}-{0:0}, at: process_one_work+0x184/0x780
>  #1: ffff80008299bdf8 (deferred_probe_work){+.+.}-{0:0}, at: process_one_work+0x1ac/0x780
>  #2: ffff0000808b48f8 (&dev->mutex){....}-{4:4}, at: __device_attach+0x2c/0x188
> irq event stamp: 10872
> hardirqs last  enabled at (10871): [<ffff80008013a410>] ktime_get+0x130/0x180
> hardirqs last disabled at (10872): [<ffff800080d61ac8>] _raw_spin_lock_irqsave+0x84/0x88
> softirqs last  enabled at (9216): [<ffff80008002807c>] fpsimd_save_and_flush_current_state+0x3c/0x80
> softirqs last disabled at (9214): [<ffff800080028098>] fpsimd_save_and_flush_current_state+0x58/0x80
> CPU: 5 UID: 0 PID: 56 Comm: kworker/u24:3 Not tainted 7.0.0-rc1-bisect+ #654 PREEMPT
> Hardware name: NVIDIA NVIDIA Jetson Xavier NX Developer Kit/Jetson, BIOS 6.0-37391689 08/28/2024
> Workqueue: events_unbound deferred_probe_work_func
> Call trace:
>  show_stack+0x18/0x30 (C)
>  dump_stack_lvl+0x6c/0x94
>  dump_stack+0x18/0x24
>  __might_resched+0x154/0x220
>  __might_sleep+0x48/0x80
>  __mutex_lock+0x48/0x800
>  mutex_lock_nested+0x24/0x30
>  pinmux_disable_setting+0x9c/0x180
>  pinctrl_commit_state+0x5c/0x260
>  pinctrl_pm_select_idle_state+0x4c/0xa0
>  tegra_i2c_runtime_suspend+0x2c/0x3c
>  pm_generic_runtime_suspend+0x2c/0x44
>  __rpm_callback+0x48/0x1ec
>  rpm_callback+0x74/0x80
>  rpm_suspend+0xec/0x630
>  rpm_idle+0x2c0/0x420
>  __pm_runtime_idle+0x44/0x160
>  tegra_i2c_probe+0x2e4/0x640
>  platform_probe+0x5c/0xa4
>  really_probe+0xbc/0x2c0
>  __driver_probe_device+0x78/0x120
>  driver_probe_device+0x3c/0x160
>  __device_attach_driver+0xbc/0x160
>  bus_for_each_drv+0x70/0xb8
>  __device_attach+0xa4/0x188
>  device_initial_probe+0x50/0x54
>  bus_probe_device+0x38/0xa4
>  deferred_probe_work_func+0x90/0xcc
>  process_one_work+0x204/0x780
>  worker_thread+0x1c8/0x36c
>  kthread+0x138/0x144
>  ret_from_fork+0x10/0x20
> 
> This is reproducible.

I've just realised that it's the Tegra I2C bug that is already known
about, but took ages to be fixed in mainline - it's unrelated to the
memory corruption, so can be ignored. Sorry for the noise.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

