Return-Path: <dmaengine+bounces-9940-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHapKm6G1mmwFwgAu9opvQ
	(envelope-from <dmaengine+bounces-9940-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 08 Apr 2026 18:46:38 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 126B23BF0CF
	for <lists+dmaengine@lfdr.de>; Wed, 08 Apr 2026 18:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A529303A59C
	for <lists+dmaengine@lfdr.de>; Wed,  8 Apr 2026 16:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508893D2FE1;
	Wed,  8 Apr 2026 16:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="F849nA4U"
X-Original-To: dmaengine@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31D63CF02A;
	Wed,  8 Apr 2026 16:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775666453; cv=none; b=qW6C/iqfGS94etZXL+M7Lbr3Y4JhQrJc59WTOI6CI64l5qKwtUjIowvzPL4B2Ied8e/gq8IpK0eti5gmlx426u3wVdyD4JxO7/GKcu7lmAFQ49XP7zTA504gGqzZNsPA72Zf4bDUafPep8lqLPP7Hy2J5pXYN1gckedAyzuSV0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775666453; c=relaxed/simple;
	bh=X7uwi1mTnlblHvnMF6Xvi2utMBucdMig04mZXn3jTOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=arRaT6MF/SbKqOJ3Nh/71oV8YFibmMMZoczljNU5jUqPWDcHPSMFqwyDppSlKbH+zPV4V1j3pUish14Wb14LKAl4IJYV+vISdyf2usAZ0gTA0ZSst9oZ3QlGIJC+QiL31ZTh7dfrYobeiAm+rdwvdlr3dOeTv43uYPITBMRsk64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=F849nA4U; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A6E62BC4;
	Wed,  8 Apr 2026 09:40:45 -0700 (PDT)
Received: from [10.57.85.157] (unknown [10.57.85.157])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 952A73F632;
	Wed,  8 Apr 2026 09:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775666450; bh=X7uwi1mTnlblHvnMF6Xvi2utMBucdMig04mZXn3jTOw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=F849nA4URN+RFi4j0f5jgoLpZlywmk3Pu6hMnA0qQncicSUV1k8+YOOGBYJZSzaWa
	 WMsa+sEqQWvwY50XlMrAdxLbQ+BeLEJsklz01UjQB01Siqe8pKdIb3MTS2FbTKw0vy
	 rIz0XlbsMeH2E12h1gNYQj8sc9EisZyfYvo/NbKo=
Message-ID: <3a1d0520-3402-47b2-9d7b-4e14a3cd07a4@arm.com>
Date: Wed, 8 Apr 2026 17:40:48 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BUG: net-next (7.0-rc6 based and later) fails to boot on Jetson
 Xavier NX
To: "Russell King (Oracle)" <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-ext4@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>, dmaengine@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Theodore Ts'o
 <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>,
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>
References: <adZTGOjjJrVJOcT8@shell.armlinux.org.uk>
 <adZfTi3R6jtsjXx-@shell.armlinux.org.uk>
 <adZ9grUg71f518Fg@shell.armlinux.org.uk>
 <adZ_ZmjcE8S22vR1@shell.armlinux.org.uk>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <adZ_ZmjcE8S22vR1@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-9940-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[arm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robin.murphy@arm.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:dkim,arm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 126B23BF0CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-04-08 5:16 pm, Russell King (Oracle) wrote:
> On Wed, Apr 08, 2026 at 05:08:34PM +0100, Russell King (Oracle) wrote:
>> The rebase is still progressing, but it's landed on:
>>
>> c7d812e33f3e dmaengine: xilinx: xilinx_dma: Fix unmasked residue subtraction

FWIW I don't see a Tegra having the Xilinx IP in it anyway - judging by 
the DT it has their own tegra-gpcdma engine...

There's a fair chance this could be 90c5def10bea ("iommu: Do not call 
drivers for empty gathers"), which JonH also reported causing boot 
issues on Tegras - in short, SMMU TLB maintenance may not be completed 
properly which could lead to recycled DMA addresses causing exactly this 
kind of random memory corruption. I CC'd you on a patch:

https://lore.kernel.org/linux-iommu/20260408162846.GE3357077@nvidia.com/T/#t

Thanks,
Robin.

>>
>> and while this boots to a login prompt, it spat out a BUG():
>>
>> BUG: sleeping function called from invalid context at kernel/locking/mutex.c:591
>> in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 56, name: kworker/u24:3
>> preempt_count: 0, expected: 0
>> RCU nest depth: 0, expected: 0
>> 3 locks held by kworker/u24:3/56:
>>   #0: ffff000080042148 ((wq_completion)events_unbound#2){+.+.}-{0:0}, at: process_one_work+0x184/0x780
>>   #1: ffff80008299bdf8 (deferred_probe_work){+.+.}-{0:0}, at: process_one_work+0x1ac/0x780
>>   #2: ffff0000808b48f8 (&dev->mutex){....}-{4:4}, at: __device_attach+0x2c/0x188
>> irq event stamp: 10872
>> hardirqs last  enabled at (10871): [<ffff80008013a410>] ktime_get+0x130/0x180
>> hardirqs last disabled at (10872): [<ffff800080d61ac8>] _raw_spin_lock_irqsave+0x84/0x88
>> softirqs last  enabled at (9216): [<ffff80008002807c>] fpsimd_save_and_flush_current_state+0x3c/0x80
>> softirqs last disabled at (9214): [<ffff800080028098>] fpsimd_save_and_flush_current_state+0x58/0x80
>> CPU: 5 UID: 0 PID: 56 Comm: kworker/u24:3 Not tainted 7.0.0-rc1-bisect+ #654 PREEMPT
>> Hardware name: NVIDIA NVIDIA Jetson Xavier NX Developer Kit/Jetson, BIOS 6.0-37391689 08/28/2024
>> Workqueue: events_unbound deferred_probe_work_func
>> Call trace:
>>   show_stack+0x18/0x30 (C)
>>   dump_stack_lvl+0x6c/0x94
>>   dump_stack+0x18/0x24
>>   __might_resched+0x154/0x220
>>   __might_sleep+0x48/0x80
>>   __mutex_lock+0x48/0x800
>>   mutex_lock_nested+0x24/0x30
>>   pinmux_disable_setting+0x9c/0x180
>>   pinctrl_commit_state+0x5c/0x260
>>   pinctrl_pm_select_idle_state+0x4c/0xa0
>>   tegra_i2c_runtime_suspend+0x2c/0x3c
>>   pm_generic_runtime_suspend+0x2c/0x44
>>   __rpm_callback+0x48/0x1ec
>>   rpm_callback+0x74/0x80
>>   rpm_suspend+0xec/0x630
>>   rpm_idle+0x2c0/0x420
>>   __pm_runtime_idle+0x44/0x160
>>   tegra_i2c_probe+0x2e4/0x640
>>   platform_probe+0x5c/0xa4
>>   really_probe+0xbc/0x2c0
>>   __driver_probe_device+0x78/0x120
>>   driver_probe_device+0x3c/0x160
>>   __device_attach_driver+0xbc/0x160
>>   bus_for_each_drv+0x70/0xb8
>>   __device_attach+0xa4/0x188
>>   device_initial_probe+0x50/0x54
>>   bus_probe_device+0x38/0xa4
>>   deferred_probe_work_func+0x90/0xcc
>>   process_one_work+0x204/0x780
>>   worker_thread+0x1c8/0x36c
>>   kthread+0x138/0x144
>>   ret_from_fork+0x10/0x20
>>
>> This is reproducible.
> 
> I've just realised that it's the Tegra I2C bug that is already known
> about, but took ages to be fixed in mainline - it's unrelated to the
> memory corruption, so can be ignored. Sorry for the noise.
> 


