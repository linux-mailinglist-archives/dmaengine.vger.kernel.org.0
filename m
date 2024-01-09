Return-Path: <dmaengine+bounces-706-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5C9827C7A
	for <lists+dmaengine@lfdr.de>; Tue,  9 Jan 2024 02:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A3EA1F2433B
	for <lists+dmaengine@lfdr.de>; Tue,  9 Jan 2024 01:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC02B17D3;
	Tue,  9 Jan 2024 01:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="K7rnWjeT"
X-Original-To: dmaengine@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129EA15A4
	for <dmaengine@vger.kernel.org>; Tue,  9 Jan 2024 01:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240109011804epoutp02d7d282d52293a6417637918ebc4a50ba~oiP4qgWx12938829388epoutp02O
	for <dmaengine@vger.kernel.org>; Tue,  9 Jan 2024 01:18:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240109011804epoutp02d7d282d52293a6417637918ebc4a50ba~oiP4qgWx12938829388epoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1704763084;
	bh=F005C07UIM+p33NeB1c2UyrlA4ZMHWNvS2i18QxUfug=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=K7rnWjeT5qIp9vNfwswc2EBvttxUeUy2Lpnajrg0bKf/th2rC5hgX1lyJUFIMxKm1
	 lqEjLhAC/s2pmAKL9WWo9gWq9iOxhV4gCAiUuQ8+1Fa/4wEbFhWAS88meVVq1K3sdh
	 PBrNYAxr81sXxNJQE4o70uZsr+5Qo1/lRq7CkigM=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTP id
	20240109011803epcas2p1961e260ca04fcc3b5bbfa6a0289cd04d~oiP4avPIV1442614426epcas2p1X;
	Tue,  9 Jan 2024 01:18:03 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.90]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4T8CjR2hczz4x9Q0; Tue,  9 Jan
	2024 01:18:03 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
	epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
	6D.26.09607.BCE9C956; Tue,  9 Jan 2024 10:18:03 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
	20240109011802epcas2p3c16cc83244b79ff4d22a0facee599224~oiP3gK3ty1632216322epcas2p3i;
	Tue,  9 Jan 2024 01:18:02 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240109011802epsmtrp2b9868c113ba41b256ba4532fd9d24052~oiP3fUPpd1050210502epsmtrp2f;
	Tue,  9 Jan 2024 01:18:02 +0000 (GMT)
X-AuditID: b6c32a48-963ff70000002587-6c-659c9ecb3a43
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	6F.C9.08817.ACE9C956; Tue,  9 Jan 2024 10:18:02 +0900 (KST)
Received: from KORCO121695 (unknown [10.229.18.180]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240109011802epsmtip29cd389aa44399016c9b5662f48afedb6~oiP3Vi3Lc2892828928epsmtip2h;
	Tue,  9 Jan 2024 01:18:02 +0000 (GMT)
From: "bumyong.lee" <bumyong.lee@samsung.com>
To: <wens@kernel.org>
Cc: "'Vinod Koul'" <vkoul@kernel.org>, <p.zabel@pengutronix.de>,
	<dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <CAGb2v67sf20Wnoxbi3BrfL0AW6+USWgd7+ZMf-3AVqrXKLXTgA@mail.gmail.com>
Subject: RE: [PATCH] dmaengine: pl330: issue_pending waits until WFP state
Date: Tue, 9 Jan 2024 10:18:02 +0900
Message-ID: <000001da4299$b0f3d410$12db7c30$@samsung.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJFg/wutkK7a/Rd7wqs74hlulytOgGLTehrAiCF6NsCwn1+1QD5nG5JAk7i1OivrGnMwA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHKsWRmVeSWpSXmKPExsWy7bCmqe7peXNSDba0ClusnvqX1eLyrjls
	FnfvnWCx2HnnBLPFrLnX2RxYPTat6mTz6P9r4PF5k1wAc1S2TUZqYkpqkUJqXnJ+SmZeuq2S
	d3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QRiWFssScUqBQQGJxsZK+nU1RfmlJqkJG
	fnGJrVJqQUpOgXmBXnFibnFpXrpeXmqJlaGBgZEpUGFCdsbDrYYFk20r9jxsYm9gnKXfxcjJ
	ISFgIvH+/2mmLkYuDiGBHYwSmzYtYYZwPjFKdK9ZyQ7hfGOUmP1rCxtMy79rT6Fa9jJKHJj2
	kQ3CeckoMfnqS3aQKjYBXYmZLw+ygNgiAqIS254vYwaxmQXqJDqmvAGzOQUCJfZMvglWIyzg
	JdH4fCZrFyMHB4uAikTvxEKQMK+ApcSRB3vZIGxBiZMzn7BAjJGX2P52DjPEQQoSP58uY4VY
	FSbx+9xlRogaEYnZnW1QNT/ZJc6e9ISwXSQurG1ihLCFJV4d38IOYUtJfH63F+rJfImZc26w
	QNg1El/v/YOK20ssOvOTHeRMZgFNifW79EFMCQFliSO3oC7jk+g4/JcdIswr0dEmBGGqSjTd
	rIeYIS2x7MwM1gmMSrOQvDULyVuzkJw/C2HVAkaWVYxiqQXFuempxUYFJvCITs7P3cQIToha
	HjsYZ7/9oHeIkYmD8RCjBAezkgiv5IzZqUK8KYmVValF+fFFpTmpxYcYTYHhPJFZSjQ5H5iS
	80riDU0sDUzMzAzNjUwNzJXEee+1zk0REkhPLEnNTk0tSC2C6WPi4JRqYDrluMJeSCutdGub
	lu3T6eErDptFSFm/+XCmfOG5q+/3OtxNZ1hoekUmxcTgViCXW/fy7dabrnqy8feWmPQEzyhM
	O9W+9ZlF2LwTjg0M9jurP9jZxpxcMdV0AovAtE0TZuVt7Vweca3st93N785chhM5j2acWio/
	P+MJm39daM/VnPu6oobfXy2a/N5ozkrF5UqFBlwaIrWyIfOVz1d9UrS1P18euWNJRofu6b7l
	l0MvrM6zWR9Q+fXT1qwZNrz3s9eVsa3s1FRtLbU81LrbWP7Wa4NnH1MUl9yNnrD1wdu6pxPO
	PXhlKhkWfPzNFk2fo/6TQqY7uPlceyD5KTvrybWwROPTjopTj9ddc1XjUVdiKc5INNRiLipO
	BADchZEMEQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLLMWRmVeSWpSXmKPExsWy7bCSvO6peXNSDZ4tNLZYPfUvq8XlXXPY
	LO7eO8FisfPOCWaLWXOvszmwemxa1cnm0f/XwOPzJrkA5igum5TUnMyy1CJ9uwSujIdbDQsm
	21bsedjE3sA4S7+LkZNDQsBE4t+1p0wgtpDAbkaJWcdyIOLSEi9av7FC2MIS91uOANlcQDXP
	GSX6P85lBEmwCehKzHx5kAXEFhEQldj2fBkzSBGzQBOjxIPp11kgOm4wSeyc/58dpIpTIFBi
	z+SbYB3CAl4Sjc9nAo3l4GARUJHonVgIEuYVsJQ48mAvG4QtKHFy5hOwcmYBbYmnN59C2fIS
	29/OYYa4TkHi59NlrBBHhEn8PneZEaJGRGJ2ZxvzBEbhWUhGzUIyahaSUbOQtCxgZFnFKJla
	UJybnltsWGCUl1quV5yYW1yal66XnJ+7iREcI1paOxj3rPqgd4iRiYPxEKMEB7OSCK/kjNmp
	QrwpiZVVqUX58UWlOanFhxilOViUxHm/ve5NERJITyxJzU5NLUgtgskycXBKNTAtV5U7NTUq
	7ZiryZHZbo8+rRFnechwNv/kRrnVti+fekoGzjxS0BOSzfD+Z2hGw0PtLU5yIlzHT1oxHe5X
	+Fp1oebh7wuHwiJaRXapWEw033Yka17vX9Eep0JWEfuF9aqG8guNll5T6lcp+eDA+5v9RtD8
	UxvCDm3OcOa4PXP1lxtyAWbsZQ4R/TO2Vl5Ycb82VEfW7MiG9nkcVsUf3wQcOn6yQc6ORZt5
	unih49LpT65fVbTVeX8+2prDc3ZpS7Je89Wmt2bS17S/J4qcjGwo5r15KHn96adHdrktX5hx
	R680f6o25/3mC+61vxmtb7/p3L9WUnLeXG23G3tEXi+Vlo+TfK7mWnebrzn7XpASS3FGoqEW
	c1FxIgAS3orQAAMAAA==
X-CMS-MailID: 20240109011802epcas2p3c16cc83244b79ff4d22a0facee599224
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231219055052epcas2p4bb1d8210f650ab18370711db2194e8e3
References: <CGME20231219055052epcas2p4bb1d8210f650ab18370711db2194e8e3@epcas2p4.samsung.com>
	<20231219055026.118695-1-bumyong.lee@samsung.com>
	<170317622670.683420.3881501030324253538.b4-ty@kernel.org>
	<ZYhQ2-OnjDgoqjvt@wens.tw> <000001da3869$ca643fa0$5f2cbee0$@samsung.com>
	<CAGb2v67sf20Wnoxbi3BrfL0AW6+USWgd7+ZMf-3AVqrXKLXTgA@mail.gmail.com>

Hello.

> > > This seems to cause a stall on my Quartz 64 model B (RK3566) once
> > > Bluetooth over UART is initialized, when combined with a patch of
> > > mine that enables DMA on UARTs [1]. Reverting this patch gets
> > > everything running again.
> > >
> > > The following are RCU stalls detected, followed by stack traces
> > > produced with pseudo-NMI. Without pseudo-NMIs no stack traces are
> produced.
> > >
> > >     rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> > >     rcu:     0-...0: (0 ticks this GP) idle=80fc/1/0x4000000000000000
> > > softirq=693/693 fqs=31498
> > >     rcu:     3-...0: (3 ticks this GP) idle=2b44/1/0x4000000000000000
> > > softirq=553/556 fqs=31498
> > >     rcu:     (detected by 1, t=162830 jiffies, g=-307, q=32 ncpus=4)
> > >     Sending NMI from CPU 1 to CPUs 0:
> > >     NMI backtrace for cpu 0
> > >     CPU: 0 PID: 1200 Comm: (udev-worker) Not tainted 6.7.0-rc6-next-
> > > 20231222-10300-g8b07e3811bc7 #17
> > >     Hardware name: Pine64 RK3566 Quartz64-B Board (DT)
> > >     pstate: 00400009 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > >     pc : queued_spin_lock_slowpath+0x50/0x330
> > >     lr : pl330_irq_handler+0x2f8/0x5a0
> > >     sp : ffffffc080003ec0
> > >     pmr_save: 00000060
> > >     x29: ffffffc080003ec0 x28: ffffff80017c7000 x27: ffffff8001a58d80
> > >     x26: 0000000000000060 x25: ffffff80017d0338 x24: ffffff800161ae38
> > >     x23: ffffff8001597c00 x22: ffffffc081960000 x21: 0000000000000000
> > >     x20: ffffff800161ac80 x19: ffffff80010c5180 x18: 0000000000000000
> > >     x17: ffffffc06e724000 x16: ffffffc080000000 x15: 0000000000000000
> > >     x14: 0000000000000000 x13: ffffff80042f102f x12: ffffffc083ad3cc4
> > >     x11: 0000000000000040 x10: ffffff800022a0a8 x9 : ffffff800022a0a0
> > >     x8 : ffffff8000400270 x7 : 0000000000000000 x6 : 0000000000000000
> > >     x5 : ffffff8000400248 x4 : ffffffc06e724000 x3 : ffffffc080003fa0
> > >     x2 : 0000000000000000 x1 : 0000000000000001 x0 : ffffff800161ae38
> > >     Call trace:
> > >      queued_spin_lock_slowpath+0x50/0x330
> > >      __handle_irq_event_percpu+0x38/0x16c
> > >      handle_irq_event+0x44/0xf8
> > >      handle_fasteoi_irq+0xb0/0x28c
> > >      generic_handle_domain_irq+0x2c/0x44
> > >      gic_handle_irq+0x10c/0x240
> > >      call_on_irq_stack+0x24/0x4c
> > >      do_interrupt_handler+0x80/0x8c
> > >      el1_interrupt+0x44/0x98
> > >      el1h_64_irq_handler+0x18/0x24
> > >      el1h_64_irq+0x78/0x7c
> > >      __d_rehash+0x0/0x94
> > >      d_add+0x40/0x80
> > >      simple_lookup+0x4c/0x78
> > >      path_openat+0x5ec/0xed0
> > >      do_filp_open+0x80/0x12c
> > >      do_sys_openat2+0xb4/0xe8
> > >      __arm64_sys_openat+0x64/0xa4
> > >      invoke_syscall+0x48/0x114
> > >      el0_svc_common.constprop.0+0x40/0xe0
> > >      do_el0_svc+0x1c/0x28
> > >      el0_svc+0x34/0xd4
> > >      el0t_64_sync_handler+0x100/0x12c
> > >      el0t_64_sync+0x1a4/0x1a8
> > >     Sending NMI from CPU 1 to CPUs 3:
> > >     NMI backtrace for cpu 3
> > >     CPU: 3 PID: 31 Comm: kworker/3:0 Not tainted
> > > 6.7.0-rc6-next-20231222-
> > > 10300-g8b07e3811bc7 #17
> > >     Hardware name: Pine64 RK3566 Quartz64-B Board (DT)
> > >     Workqueue: events hci_uart_write_work [hci_uart]
> > >     pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > >     pc : _state+0x2c/0x138
> > >     lr : pl330_start_thread.isra.0+0x2e0/0x32c
> > >     sp : ffffffc08157bb20
> > >     pmr_save: 00000060
> > >     x29: ffffffc08157bb20 x28: 0000000000000000 x27: 0000000000000060
> > >     x26: ffffffc080c4e658 x25: 0000000000000060 x24: 0000000001a20000
> > >     x23: ffffff8001555000 x22: ffffffc081960020 x21: ffffff800161b068
> > >     x20: 0000000000000000 x19: ffffff800161b050 x18: ffffffffffffffff
> > >     x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000001
> > >     x14: 0000000000000004 x13: 0000000000000009 x12: 0000000000000005
> > >     x11: 0000000000000027 x10: 000000000000002b x9 : 0000000000000032
> > >     x8 : ffffffc08154521d x7 : 0000000000000005 x6 : 0000000000000010
> > >     x5 : 0000000000000001 x4 : ffffffc081960d04 x3 : ffffff800161b280
> > >     x2 : ffffff800161b050 x1 : 0000000000204000 x0 : 0000000000000108
> > >     Call trace:
> > >      _state+0x2c/0x138
> > >      pl330_tasklet+0x1f8/0x818
> > >      pl330_issue_pending+0x150/0x178
> > >      serial8250_tx_dma+0x150/0x21c
> > >      serial8250_start_tx+0x9c/0x1c0
> > >      __uart_start+0x74/0xfc
> > >      uart_write+0xfc/0x2f0
> > >      ttyport_write_buf+0x4c/0x90
> > >      serdev_device_write_buf+0x24/0x38
> > >      hci_uart_write_work+0x54/0x164 [hci_uart]
> > >      process_one_work+0x13c/0x2bc
> > >      worker_thread+0x2a0/0x52c
> > >      kthread+0xe0/0xe4
> > >      ret_from_fork+0x10/0x20
> > I think the dma channel already passed WFP state.
> >
> > The errata[1] says that
> > 4.  The driver polls the status of channel 0 until it observes that
> >      it has entered the "Waiting for peripheral" state 5.  The driver
> > enables the peripheral to allow it to issue DMA requests
> >
> > When I review 8250_dma.c, I think serial8250_do_prepare_tx_dma() of
> > serial8250_tx_dma() would enable peripheral to allow issue DMA requests.
> > serial8250_do_prepare_tx_dma(p) performs before
> > dma_async_issue_pending() It means that serial8250_tx_dma() has
> > reversed sequence step 4 and 5 for pl330.
> 
> serial8250_prepare_tx_dma() on Rockchip doesn't do anything. The callback
> called in serial8250_prepare_tx_dma() simply isn't set.
> 
> For this hardware the DMA request will be asserted when the TX FIFO is
> empty, or when the RX FIFO has data, depending on the direction.
> 
> From the DesignWare UART release notes:
> 
> In mode 0 (single shot DMA), the dma_tx_req_n signal goes active low under
> the following conditions:
> - When the Transmitter Holding Register is empty in non-FIFO mode
> - When the transmitter FIFO is empty in FIFO mode with Programmable THRE
>   interrupt mode disabled
> - When the transmitter FIFO is at or below the programmed threshold with
>   Programmable THRE interrupt mode enabled
> 
> Mode 1 (continuous DMA) is the same, minus the first condition.
> 
> > But I'm not sure if the errata suggests normal slave driver dma usage
> > sequence or not.
> 
> I'm not sure what you mean by this.

Errata suggests that Slave device must not send DMA request until PL330
enters WFP state. so I made wait until WFP state in _trigger().
If slave device didn't send DMA request, I think it is okay to wait
until pl330 changes their state to WFP in _trigger().

According to your description,
In order for serial8250 to follow the sequence of the errata, I guess
serial8250 should change mode from fifo mode to DMA mode after doing
issue_pending() not to send DMA request until WFP.

If case of samsung_tty.c, it changes dma mode after doing issue_pending()

s3c64xx_start_rx_dma(ourport); // do issue_pending()
if (ourport->rx_mode == S3C24XX_RX_PIO) 
        enable_rx_dma(ourport); // change uart mode to DMA mode
                                     // to send DMA request

But I'm not sure if most of slave devices send DMA request 
before doing issue_pending().

> 
> > If it is abnormal sequence, I think it should be handled by quirk
> 
> A quirk on which device? The DMA controller?
If the sequence of requesting DMA before doing issue_pending() is common,
The errata suggests wrong sequence for DMA usage in linux.
So, it should be applied to pl330 not to wait WFP _trigger() when quirk
is not enabled.

Unfortunately, I couldn't find more good way when I check pl330 trm
and errata.

Best regards


