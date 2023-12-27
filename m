Return-Path: <dmaengine+bounces-669-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E64E981EB75
	for <lists+dmaengine@lfdr.de>; Wed, 27 Dec 2023 03:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 161411C21285
	for <lists+dmaengine@lfdr.de>; Wed, 27 Dec 2023 02:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C421FDC;
	Wed, 27 Dec 2023 02:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Li2/n73J"
X-Original-To: dmaengine@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51221FC8
	for <dmaengine@vger.kernel.org>; Wed, 27 Dec 2023 02:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231227021000epoutp0251f99fc04cf98a9af0e6d998f4556ed6~kjkhi_SA22583125831epoutp02g
	for <dmaengine@vger.kernel.org>; Wed, 27 Dec 2023 02:10:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231227021000epoutp0251f99fc04cf98a9af0e6d998f4556ed6~kjkhi_SA22583125831epoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1703643000;
	bh=3MtKijwCwbeW1ArT+tjE3XqIsWl4XTNfXUalV6UpnKk=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=Li2/n73Jf4OpQ3vzXRIUM1e0Kl8jiNBRJZ92zt9qTcaN6Zqzfj4EnwKVCbL+RIrib
	 N8JAWAkvzAxY4WCOYgxkmBIE2NiV3NWwpfIXUGm4Edfo45JFVCJh7KhmgbTWfObdtj
	 ZE3tN6Ub673GTEnKCGJ4lO7tPf+5jQrBhEqQ5150=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTP id
	20231227021000epcas2p1bea9bcf039ca47127548095efe2ca7b3~kjkhVvnQR3213032130epcas2p1Y;
	Wed, 27 Dec 2023 02:10:00 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.90]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4T0FTM5Yckz4x9Pp; Wed, 27 Dec
	2023 02:09:59 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
	epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	7B.47.09622.6778B856; Wed, 27 Dec 2023 11:09:58 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
	20231227020958epcas2p3e6cc1534894f0b6c9266bc6b647346c6~kjkfQYigK1000710007epcas2p3C;
	Wed, 27 Dec 2023 02:09:58 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231227020958epsmtrp296b3822bde1eb0bf06648fe62885f9c4~kjkfPxe0Y0622906229epsmtrp2T;
	Wed, 27 Dec 2023 02:09:58 +0000 (GMT)
X-AuditID: b6c32a46-d61ff70000002596-4b-658b87767d02
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	2F.9D.18939.5778B856; Wed, 27 Dec 2023 11:09:57 +0900 (KST)
Received: from KORCO121695 (unknown [10.229.18.180]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20231227020957epsmtip18d2b95d427159d6921aced5cdc0dc9e3~kjkfCTw1q1457714577epsmtip13;
	Wed, 27 Dec 2023 02:09:57 +0000 (GMT)
From: "bumyong.lee" <bumyong.lee@samsung.com>
To: "'Chen-Yu Tsai'" <wens@kernel.org>, "'Vinod Koul'" <vkoul@kernel.org>
Cc: <p.zabel@pengutronix.de>, <dmaengine@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
In-Reply-To: <ZYhQ2-OnjDgoqjvt@wens.tw>
Subject: RE: [PATCH] dmaengine: pl330: issue_pending waits until WFP state
Date: Wed, 27 Dec 2023 11:09:57 +0900
Message-ID: <000001da3869$ca643fa0$5f2cbee0$@samsung.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJFg/wutkK7a/Rd7wqs74hlulytOgGLTehrAiCF6NsCwn1+1a+yUIsQ
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPKsWRmVeSWpSXmKPExsWy7bCmuW5Ze3eqwbkVJharp/5ltbi8aw6b
	xd17J1gsdt45wWwxa+51NgdWj02rOtk8+v8aeHzeJBfAHJVtk5GamJJapJCal5yfkpmXbqvk
	HRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQO0UUmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCR
	X1xiq5RakJJTYF6gV5yYW1yal66Xl1piZWhgYGQKVJiQnbFoxU/GgolaFW8/izUwrlHsYuTk
	kBAwkdhzZzlTFyMXh5DADkaJg7sOMkM4nxgl3rQ9QnAWr3jDDNPy788JqMRORokpn16xQTgv
	GSUuN99jBKliE9CVmPnyIAuILSLgKTH96FSwbmaBaInPz3ewgdicAuoS8y4vBrOFBbwkGp/P
	ZO1i5OBgEVCV2HktBCTMK2ApcW9FDyOELShxcuYTFogx8hLb386BOkhB4ufTZawQq9wkXhx7
	DlUjIjG7sw3sUAmBj+wS2xdvhWpwkZjQd5kdwhaWeHV8C5QtJfH53V42CDtfYuacGywQdo3E
	13v/oOL2EovO/GQHuZNZQFNi/S59EFNCQFniyC2otXwSHYf/skOEeSU62oQgTFWJppv1EDOk
	JZadmcE6gVFpFpK/ZiH5axaS+2chrFrAyLKKUSy1oDg3PbXYqMAIHtPJ+bmbGMEpUcttB+OU
	tx/0DjEycTAeYpTgYFYS4ZVV7EgV4k1JrKxKLcqPLyrNSS0+xGgKDOiJzFKiyfnApJxXEm9o
	YmlgYmZmaG5kamCuJM57r3VuipBAemJJanZqakFqEUwfEwenVAOTUKmQ1tfkqzIa6Tz2c2+9
	UPFv3Kj/d38Nx/tzB9NYA47PO/O0eIXcVx2ZlyGx6/sN+e4GFMnvn3U6s7RNxeeQUMGS3s/S
	MeHfpqzfHH3Da9/8NTHeXtV/XloFLbt+btOOaZFi7/61iRjMDFA9tbCs5n/b5bzWQ5qzZ+iE
	OIjebUl32NN6SWb5BvU92x2sm/a8d2+ukVpiP92wSk0oZvkBPrmflm/83sTtWRJ+WJ1hW8bG
	dYKvhJbPXXLnSV+jS5vc2/9FHdY73yny744/d+vMuyXh12xNr8j/ZXrxcXvv+uhP3qo/66ed
	3Fhpfe+gtfeSlFsrfn6429U1a6HRWX7L3OQ53xaIqSS7M6b4h/snKLEUZyQaajEXFScCAGFO
	tR8SBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOLMWRmVeSWpSXmKPExsWy7bCSnG5pe3eqQedFG4vVU/+yWlzeNYfN
	4u69EywWO++cYLaYNfc6mwOrx6ZVnWwe/X8NPD5vkgtgjuKySUnNySxLLdK3S+DKWLTiJ2PB
	RK2Kt5/FGhjXKHYxcnJICJhI/PtzgrmLkYtDSGA7o8TGs89YIBLSEi9av7FC2MIS91uOsEIU
	PWeUWDvhDVgRm4CuxMyXB8FsEQFviYvv9zCD2MwCsRIn/3WyQzQ8ZZS4tGo3G0iCU0BdYt7l
	xWC2sICXROPzmUBTOThYBFQldl4LAQnzClhK3FvRwwhhC0qcnPmEBaSEWUBPom0jI8R4eYnt
	b+cwQ9ymIPHz6TJWiBPcJF4ce84CUSMiMbuzjXkCo/AsJJNmIUyahWTSLCQdCxhZVjGKphYU
	56bnJhcY6hUn5haX5qXrJefnbmIEx4VW0A7GZev/6h1iZOJgPMQowcGsJMIrq9iRKsSbklhZ
	lVqUH19UmpNafIhRmoNFSZxXOaczRUggPbEkNTs1tSC1CCbLxMEp1cDU/i5Zfr7Hu4be6zFv
	7ycZMc49qe/lsONmwCxzj7OHVjs/fFehO/OaoXOQ56SWh8dU3830erxRomnr5KlybL/qFx2o
	27PGKYXhkcRUsbqtkRYNN/fxvP93JHeCWFLpib1fXrq++VJVt3pR+Ynlc/Tm3X2673Unw5YP
	nI+5wvYqnP2vtkDYN3HN34V+GVPXHXuxm/WZe+wT9ZeWUxaafTDnuH+1K7p3VpP9saS2B2d0
	X1l4Z0moP3A6Yu1lN+vVp3OPZvvlR879FpjelVk+8+zjj2cNVyf95S1/Hb6ZYxu/vfltHSnG
	qkaWC45558tVHCsLwxXL1VR0RI9vtTzY9ChV0G+lkJBDh0CO6Ubpf+FSSizFGYmGWsxFxYkA
	MOMjf/oCAAA=
X-CMS-MailID: 20231227020958epcas2p3e6cc1534894f0b6c9266bc6b647346c6
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
	<ZYhQ2-OnjDgoqjvt@wens.tw>

Hello.

> On Thu, Dec 21, 2023 at 10:00:26PM +0530, Vinod Koul wrote:
> 
> This seems to cause a stall on my Quartz 64 model B (RK3566) once
> Bluetooth over UART is initialized, when combined with a patch of mine
> that enables DMA on UARTs [1]. Reverting this patch gets everything
> running again.
> 
> The following are RCU stalls detected, followed by stack traces produced
> with pseudo-NMI. Without pseudo-NMIs no stack traces are produced.
> 
>     rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
>     rcu:     0-...0: (0 ticks this GP) idle=80fc/1/0x4000000000000000
> softirq=693/693 fqs=31498
>     rcu:     3-...0: (3 ticks this GP) idle=2b44/1/0x4000000000000000
> softirq=553/556 fqs=31498
>     rcu:     (detected by 1, t=162830 jiffies, g=-307, q=32 ncpus=4)
>     Sending NMI from CPU 1 to CPUs 0:
>     NMI backtrace for cpu 0
>     CPU: 0 PID: 1200 Comm: (udev-worker) Not tainted 6.7.0-rc6-next-
> 20231222-10300-g8b07e3811bc7 #17
>     Hardware name: Pine64 RK3566 Quartz64-B Board (DT)
>     pstate: 00400009 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>     pc : queued_spin_lock_slowpath+0x50/0x330
>     lr : pl330_irq_handler+0x2f8/0x5a0
>     sp : ffffffc080003ec0
>     pmr_save: 00000060
>     x29: ffffffc080003ec0 x28: ffffff80017c7000 x27: ffffff8001a58d80
>     x26: 0000000000000060 x25: ffffff80017d0338 x24: ffffff800161ae38
>     x23: ffffff8001597c00 x22: ffffffc081960000 x21: 0000000000000000
>     x20: ffffff800161ac80 x19: ffffff80010c5180 x18: 0000000000000000
>     x17: ffffffc06e724000 x16: ffffffc080000000 x15: 0000000000000000
>     x14: 0000000000000000 x13: ffffff80042f102f x12: ffffffc083ad3cc4
>     x11: 0000000000000040 x10: ffffff800022a0a8 x9 : ffffff800022a0a0
>     x8 : ffffff8000400270 x7 : 0000000000000000 x6 : 0000000000000000
>     x5 : ffffff8000400248 x4 : ffffffc06e724000 x3 : ffffffc080003fa0
>     x2 : 0000000000000000 x1 : 0000000000000001 x0 : ffffff800161ae38
>     Call trace:
>      queued_spin_lock_slowpath+0x50/0x330
>      __handle_irq_event_percpu+0x38/0x16c
>      handle_irq_event+0x44/0xf8
>      handle_fasteoi_irq+0xb0/0x28c
>      generic_handle_domain_irq+0x2c/0x44
>      gic_handle_irq+0x10c/0x240
>      call_on_irq_stack+0x24/0x4c
>      do_interrupt_handler+0x80/0x8c
>      el1_interrupt+0x44/0x98
>      el1h_64_irq_handler+0x18/0x24
>      el1h_64_irq+0x78/0x7c
>      __d_rehash+0x0/0x94
>      d_add+0x40/0x80
>      simple_lookup+0x4c/0x78
>      path_openat+0x5ec/0xed0
>      do_filp_open+0x80/0x12c
>      do_sys_openat2+0xb4/0xe8
>      __arm64_sys_openat+0x64/0xa4
>      invoke_syscall+0x48/0x114
>      el0_svc_common.constprop.0+0x40/0xe0
>      do_el0_svc+0x1c/0x28
>      el0_svc+0x34/0xd4
>      el0t_64_sync_handler+0x100/0x12c
>      el0t_64_sync+0x1a4/0x1a8
>     Sending NMI from CPU 1 to CPUs 3:
>     NMI backtrace for cpu 3
>     CPU: 3 PID: 31 Comm: kworker/3:0 Not tainted 6.7.0-rc6-next-20231222-
> 10300-g8b07e3811bc7 #17
>     Hardware name: Pine64 RK3566 Quartz64-B Board (DT)
>     Workqueue: events hci_uart_write_work [hci_uart]
>     pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>     pc : _state+0x2c/0x138
>     lr : pl330_start_thread.isra.0+0x2e0/0x32c
>     sp : ffffffc08157bb20
>     pmr_save: 00000060
>     x29: ffffffc08157bb20 x28: 0000000000000000 x27: 0000000000000060
>     x26: ffffffc080c4e658 x25: 0000000000000060 x24: 0000000001a20000
>     x23: ffffff8001555000 x22: ffffffc081960020 x21: ffffff800161b068
>     x20: 0000000000000000 x19: ffffff800161b050 x18: ffffffffffffffff
>     x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000001
>     x14: 0000000000000004 x13: 0000000000000009 x12: 0000000000000005
>     x11: 0000000000000027 x10: 000000000000002b x9 : 0000000000000032
>     x8 : ffffffc08154521d x7 : 0000000000000005 x6 : 0000000000000010
>     x5 : 0000000000000001 x4 : ffffffc081960d04 x3 : ffffff800161b280
>     x2 : ffffff800161b050 x1 : 0000000000204000 x0 : 0000000000000108
>     Call trace:
>      _state+0x2c/0x138
>      pl330_tasklet+0x1f8/0x818
>      pl330_issue_pending+0x150/0x178
>      serial8250_tx_dma+0x150/0x21c
>      serial8250_start_tx+0x9c/0x1c0
>      __uart_start+0x74/0xfc
>      uart_write+0xfc/0x2f0
>      ttyport_write_buf+0x4c/0x90
>      serdev_device_write_buf+0x24/0x38
>      hci_uart_write_work+0x54/0x164 [hci_uart]
>      process_one_work+0x13c/0x2bc
>      worker_thread+0x2a0/0x52c
>      kthread+0xe0/0xe4
>      ret_from_fork+0x10/0x20
I think the dma channel already passed WFP state.

The errata[1] says that
4.  The driver polls the status of channel 0 until it observes that
     it has entered the "Waiting for peripheral" state 
5.  The driver enables the peripheral to allow it to issue DMA requests

When I review 8250_dma.c, I think serial8250_do_prepare_tx_dma() of 
serial8250_tx_dma() would enable peripheral to allow issue DMA requests.
serial8250_do_prepare_tx_dma(p) performs before dma_async_issue_pending()

It means that serial8250_tx_dma() has reversed sequence step 4 and 5 for
pl330.

But I'm not sure if the errata suggests normal slave driver dma usage
sequence or not.

If it is abnormal sequence, I think it should be handled by quirk
[1]: https://developer.arm.com/documentation/genc008428/latest


