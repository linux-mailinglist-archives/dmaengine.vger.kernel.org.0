Return-Path: <dmaengine+bounces-653-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FE081DB18
	for <lists+dmaengine@lfdr.de>; Sun, 24 Dec 2023 16:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7267B1F216D4
	for <lists+dmaengine@lfdr.de>; Sun, 24 Dec 2023 15:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF48C8D2;
	Sun, 24 Dec 2023 15:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="owU/bKbG"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F069FC8C7;
	Sun, 24 Dec 2023 15:40:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63D07C433C8;
	Sun, 24 Dec 2023 15:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703432414;
	bh=yE8hkLvnTOJy7nmW9QVWkEnNeeSTa1o9YlWvPRBpEAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=owU/bKbG1S0Q21VjghNIN2zPriqZ6QtEE5+vdpn51x6whB7bi1ZNXLFiUj0TaIuml
	 lp46C+rHUtnUk55KRUXgIPhizaXM51uFE7/obgshOK0V+8ZxTrm/Kw8Oj6oVmInd5s
	 NMSOuiwCckFgrUwDm20pbK2tpwAOVT84BVH1s7xMq0D7dpwqVE1EC/vxwZCEqaU9ED
	 X2Wm9K6s4CJ7F5pilfGBGP5OcFj9LeGYHIl7dLugoUW98GHKhPKvpmVWIsp12JL3T6
	 3+6aXqXJIXzkBz3bjx7jkmNYWyhz9b8yFluRxnQYF1MnIR4tXXom/bwWqZYvTeRcgA
	 +t3apirXJCDTQ==
Received: by wens.tw (Postfix, from userid 1000)
	id 5F7F85FA73; Sun, 24 Dec 2023 23:40:11 +0800 (CST)
Date: Sun, 24 Dec 2023 23:40:11 +0800
From: Chen-Yu Tsai <wens@kernel.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: p.zabel@pengutronix.de, Bumyong Lee <bumyong.lee@samsung.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: pl330: issue_pending waits until WFP state
Message-ID: <ZYhQ2-OnjDgoqjvt@wens.tw>
References: <CGME20231219055052epcas2p4bb1d8210f650ab18370711db2194e8e3@epcas2p4.samsung.com>
 <20231219055026.118695-1-bumyong.lee@samsung.com>
 <170317622670.683420.3881501030324253538.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170317622670.683420.3881501030324253538.b4-ty@kernel.org>

Hi,

On Thu, Dec 21, 2023 at 10:00:26PM +0530, Vinod Koul wrote:
> 
> On Tue, 19 Dec 2023 14:50:26 +0900, Bumyong Lee wrote:
> > According to DMA-330 errata notice[1] 71930, DMAKILL
> > cannot clear internal signal, named pipeline_req_active.
> > it makes that pl330 would wait forever in WFP state
> > although dma already send dma request if pl330 gets
> > dma request before entering WFP state.
> > 
> > The errata suggests that polling until entering WFP state
> > as workaround and then peripherals allows to issue dma request.
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/1] dmaengine: pl330: issue_pending waits until WFP state
>       commit: d114d3a096194fb2a9c3bedd7be6587b97610625

This seems to cause a stall on my Quartz 64 model B (RK3566) once
Bluetooth over UART is initialized, when combined with a patch of mine
that enables DMA on UARTs [1]. Reverting this patch gets everything
running again.

The following are RCU stalls detected, followed by stack traces
produced with pseudo-NMI. Without pseudo-NMIs no stack traces are
produced.

    rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
    rcu:     0-...0: (0 ticks this GP) idle=80fc/1/0x4000000000000000 softirq=693/693 fqs=31498
    rcu:     3-...0: (3 ticks this GP) idle=2b44/1/0x4000000000000000 softirq=553/556 fqs=31498
    rcu:     (detected by 1, t=162830 jiffies, g=-307, q=32 ncpus=4)
    Sending NMI from CPU 1 to CPUs 0:
    NMI backtrace for cpu 0
    CPU: 0 PID: 1200 Comm: (udev-worker) Not tainted 6.7.0-rc6-next-20231222-10300-g8b07e3811bc7 #17
    Hardware name: Pine64 RK3566 Quartz64-B Board (DT)
    pstate: 00400009 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
    pc : queued_spin_lock_slowpath+0x50/0x330
    lr : pl330_irq_handler+0x2f8/0x5a0
    sp : ffffffc080003ec0
    pmr_save: 00000060
    x29: ffffffc080003ec0 x28: ffffff80017c7000 x27: ffffff8001a58d80
    x26: 0000000000000060 x25: ffffff80017d0338 x24: ffffff800161ae38
    x23: ffffff8001597c00 x22: ffffffc081960000 x21: 0000000000000000
    x20: ffffff800161ac80 x19: ffffff80010c5180 x18: 0000000000000000
    x17: ffffffc06e724000 x16: ffffffc080000000 x15: 0000000000000000
    x14: 0000000000000000 x13: ffffff80042f102f x12: ffffffc083ad3cc4
    x11: 0000000000000040 x10: ffffff800022a0a8 x9 : ffffff800022a0a0
    x8 : ffffff8000400270 x7 : 0000000000000000 x6 : 0000000000000000
    x5 : ffffff8000400248 x4 : ffffffc06e724000 x3 : ffffffc080003fa0
    x2 : 0000000000000000 x1 : 0000000000000001 x0 : ffffff800161ae38
    Call trace:
     queued_spin_lock_slowpath+0x50/0x330
     __handle_irq_event_percpu+0x38/0x16c
     handle_irq_event+0x44/0xf8
     handle_fasteoi_irq+0xb0/0x28c
     generic_handle_domain_irq+0x2c/0x44
     gic_handle_irq+0x10c/0x240
     call_on_irq_stack+0x24/0x4c
     do_interrupt_handler+0x80/0x8c
     el1_interrupt+0x44/0x98
     el1h_64_irq_handler+0x18/0x24
     el1h_64_irq+0x78/0x7c
     __d_rehash+0x0/0x94
     d_add+0x40/0x80
     simple_lookup+0x4c/0x78
     path_openat+0x5ec/0xed0
     do_filp_open+0x80/0x12c
     do_sys_openat2+0xb4/0xe8
     __arm64_sys_openat+0x64/0xa4
     invoke_syscall+0x48/0x114
     el0_svc_common.constprop.0+0x40/0xe0
     do_el0_svc+0x1c/0x28
     el0_svc+0x34/0xd4
     el0t_64_sync_handler+0x100/0x12c
     el0t_64_sync+0x1a4/0x1a8
    Sending NMI from CPU 1 to CPUs 3:
    NMI backtrace for cpu 3
    CPU: 3 PID: 31 Comm: kworker/3:0 Not tainted 6.7.0-rc6-next-20231222-10300-g8b07e3811bc7 #17
    Hardware name: Pine64 RK3566 Quartz64-B Board (DT)
    Workqueue: events hci_uart_write_work [hci_uart]
    pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
    pc : _state+0x2c/0x138
    lr : pl330_start_thread.isra.0+0x2e0/0x32c
    sp : ffffffc08157bb20
    pmr_save: 00000060
    x29: ffffffc08157bb20 x28: 0000000000000000 x27: 0000000000000060
    x26: ffffffc080c4e658 x25: 0000000000000060 x24: 0000000001a20000
    x23: ffffff8001555000 x22: ffffffc081960020 x21: ffffff800161b068
    x20: 0000000000000000 x19: ffffff800161b050 x18: ffffffffffffffff
    x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000001
    x14: 0000000000000004 x13: 0000000000000009 x12: 0000000000000005
    x11: 0000000000000027 x10: 000000000000002b x9 : 0000000000000032
    x8 : ffffffc08154521d x7 : 0000000000000005 x6 : 0000000000000010
    x5 : 0000000000000001 x4 : ffffffc081960d04 x3 : ffffff800161b280
    x2 : ffffff800161b050 x1 : 0000000000204000 x0 : 0000000000000108
    Call trace:
     _state+0x2c/0x138
     pl330_tasklet+0x1f8/0x818
     pl330_issue_pending+0x150/0x178
     serial8250_tx_dma+0x150/0x21c
     serial8250_start_tx+0x9c/0x1c0
     __uart_start+0x74/0xfc
     uart_write+0xfc/0x2f0
     ttyport_write_buf+0x4c/0x90
     serdev_device_write_buf+0x24/0x38
     hci_uart_write_work+0x54/0x164 [hci_uart]
     process_one_work+0x13c/0x2bc
     worker_thread+0x2a0/0x52c
     kthread+0xe0/0xe4
     ret_from_fork+0x10/0x20

[1] https://lore.kernel.org/linux-arm-kernel/20221106161443.4104-1-wens@kernel.org/

