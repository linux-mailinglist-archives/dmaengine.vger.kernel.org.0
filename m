Return-Path: <dmaengine+bounces-702-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2868275C6
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jan 2024 17:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4885CB20970
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jan 2024 16:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA1753E21;
	Mon,  8 Jan 2024 16:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwGDrlhN"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED09A53E1F;
	Mon,  8 Jan 2024 16:51:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C52DC433C9;
	Mon,  8 Jan 2024 16:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704732716;
	bh=cMf5KfygtFUujOz6nnfZjEMH0xkyeduynIy/j2/t/J0=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=TwGDrlhN2Hpqmak9XS/DlsOIlyk6M5pTzK+mn9EBkKuI8hcSbDMB4i7y7MAZiiVsa
	 6OagVf9Wy31m9w+t/8xRVBf6UOgJTu7HHjoJWEU5BE0HnOQJNAKOSFJA3i54dhLlvO
	 6S7RRTrLNLe8qUCOxp9o4SFHPEC3okW9yuzBTRPJ/kbuAgImREMA8c6MFTX7l2nka2
	 ZkcJHiu7J+wA3FhO2IPJPE3H43HGpKbPg6AQr0nbOYwRgdKAeq937vpm9sh6pigAH2
	 U/kQYwosnz3NSeRhK49OgDtjmYpeD7n1b+XBK6C7HqzcsINGcKKFSNtBGjbWS5nVDt
	 sdPsvisZzpdcQ==
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6da6b0eb2d4so707335b3a.1;
        Mon, 08 Jan 2024 08:51:56 -0800 (PST)
X-Gm-Message-State: AOJu0Yyj815nP0BU/lrtpt4t95LqLnZPgq6cVRUEidCryzK05qHp6ZNw
	Unw6k5h+8MEg1GDNONunIajWz7gbVxjfEptN1pU=
X-Google-Smtp-Source: AGHT+IGYKEAi2IKxFyX6z98IKjDnUc+Jm2MqcYm+l/q/aCiU4B2Kyqii46lHdUDsFe0ajRheHlaHtNnAtpA17w4VDE8=
X-Received: by 2002:a05:6a00:1252:b0:6d9:beca:3a40 with SMTP id
 u18-20020a056a00125200b006d9beca3a40mr1641397pfi.56.1704732715987; Mon, 08
 Jan 2024 08:51:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20231219055052epcas2p4bb1d8210f650ab18370711db2194e8e3@epcas2p4.samsung.com>
 <20231219055026.118695-1-bumyong.lee@samsung.com> <170317622670.683420.3881501030324253538.b4-ty@kernel.org>
 <ZYhQ2-OnjDgoqjvt@wens.tw> <000001da3869$ca643fa0$5f2cbee0$@samsung.com>
In-Reply-To: <000001da3869$ca643fa0$5f2cbee0$@samsung.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Tue, 9 Jan 2024 00:51:44 +0800
X-Gmail-Original-Message-ID: <CAGb2v67sf20Wnoxbi3BrfL0AW6+USWgd7+ZMf-3AVqrXKLXTgA@mail.gmail.com>
Message-ID: <CAGb2v67sf20Wnoxbi3BrfL0AW6+USWgd7+ZMf-3AVqrXKLXTgA@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: pl330: issue_pending waits until WFP state
To: "bumyong.lee" <bumyong.lee@samsung.com>
Cc: Vinod Koul <vkoul@kernel.org>, p.zabel@pengutronix.de, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 27, 2023 at 10:10=E2=80=AFAM bumyong.lee <bumyong.lee@samsung.c=
om> wrote:
>
> Hello.
>
> > On Thu, Dec 21, 2023 at 10:00:26PM +0530, Vinod Koul wrote:
> >
> > This seems to cause a stall on my Quartz 64 model B (RK3566) once
> > Bluetooth over UART is initialized, when combined with a patch of mine
> > that enables DMA on UARTs [1]. Reverting this patch gets everything
> > running again.
> >
> > The following are RCU stalls detected, followed by stack traces produce=
d
> > with pseudo-NMI. Without pseudo-NMIs no stack traces are produced.
> >
> >     rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> >     rcu:     0-...0: (0 ticks this GP) idle=3D80fc/1/0x4000000000000000
> > softirq=3D693/693 fqs=3D31498
> >     rcu:     3-...0: (3 ticks this GP) idle=3D2b44/1/0x4000000000000000
> > softirq=3D553/556 fqs=3D31498
> >     rcu:     (detected by 1, t=3D162830 jiffies, g=3D-307, q=3D32 ncpus=
=3D4)
> >     Sending NMI from CPU 1 to CPUs 0:
> >     NMI backtrace for cpu 0
> >     CPU: 0 PID: 1200 Comm: (udev-worker) Not tainted 6.7.0-rc6-next-
> > 20231222-10300-g8b07e3811bc7 #17
> >     Hardware name: Pine64 RK3566 Quartz64-B Board (DT)
> >     pstate: 00400009 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> >     pc : queued_spin_lock_slowpath+0x50/0x330
> >     lr : pl330_irq_handler+0x2f8/0x5a0
> >     sp : ffffffc080003ec0
> >     pmr_save: 00000060
> >     x29: ffffffc080003ec0 x28: ffffff80017c7000 x27: ffffff8001a58d80
> >     x26: 0000000000000060 x25: ffffff80017d0338 x24: ffffff800161ae38
> >     x23: ffffff8001597c00 x22: ffffffc081960000 x21: 0000000000000000
> >     x20: ffffff800161ac80 x19: ffffff80010c5180 x18: 0000000000000000
> >     x17: ffffffc06e724000 x16: ffffffc080000000 x15: 0000000000000000
> >     x14: 0000000000000000 x13: ffffff80042f102f x12: ffffffc083ad3cc4
> >     x11: 0000000000000040 x10: ffffff800022a0a8 x9 : ffffff800022a0a0
> >     x8 : ffffff8000400270 x7 : 0000000000000000 x6 : 0000000000000000
> >     x5 : ffffff8000400248 x4 : ffffffc06e724000 x3 : ffffffc080003fa0
> >     x2 : 0000000000000000 x1 : 0000000000000001 x0 : ffffff800161ae38
> >     Call trace:
> >      queued_spin_lock_slowpath+0x50/0x330
> >      __handle_irq_event_percpu+0x38/0x16c
> >      handle_irq_event+0x44/0xf8
> >      handle_fasteoi_irq+0xb0/0x28c
> >      generic_handle_domain_irq+0x2c/0x44
> >      gic_handle_irq+0x10c/0x240
> >      call_on_irq_stack+0x24/0x4c
> >      do_interrupt_handler+0x80/0x8c
> >      el1_interrupt+0x44/0x98
> >      el1h_64_irq_handler+0x18/0x24
> >      el1h_64_irq+0x78/0x7c
> >      __d_rehash+0x0/0x94
> >      d_add+0x40/0x80
> >      simple_lookup+0x4c/0x78
> >      path_openat+0x5ec/0xed0
> >      do_filp_open+0x80/0x12c
> >      do_sys_openat2+0xb4/0xe8
> >      __arm64_sys_openat+0x64/0xa4
> >      invoke_syscall+0x48/0x114
> >      el0_svc_common.constprop.0+0x40/0xe0
> >      do_el0_svc+0x1c/0x28
> >      el0_svc+0x34/0xd4
> >      el0t_64_sync_handler+0x100/0x12c
> >      el0t_64_sync+0x1a4/0x1a8
> >     Sending NMI from CPU 1 to CPUs 3:
> >     NMI backtrace for cpu 3
> >     CPU: 3 PID: 31 Comm: kworker/3:0 Not tainted 6.7.0-rc6-next-2023122=
2-
> > 10300-g8b07e3811bc7 #17
> >     Hardware name: Pine64 RK3566 Quartz64-B Board (DT)
> >     Workqueue: events hci_uart_write_work [hci_uart]
> >     pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> >     pc : _state+0x2c/0x138
> >     lr : pl330_start_thread.isra.0+0x2e0/0x32c
> >     sp : ffffffc08157bb20
> >     pmr_save: 00000060
> >     x29: ffffffc08157bb20 x28: 0000000000000000 x27: 0000000000000060
> >     x26: ffffffc080c4e658 x25: 0000000000000060 x24: 0000000001a20000
> >     x23: ffffff8001555000 x22: ffffffc081960020 x21: ffffff800161b068
> >     x20: 0000000000000000 x19: ffffff800161b050 x18: ffffffffffffffff
> >     x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000001
> >     x14: 0000000000000004 x13: 0000000000000009 x12: 0000000000000005
> >     x11: 0000000000000027 x10: 000000000000002b x9 : 0000000000000032
> >     x8 : ffffffc08154521d x7 : 0000000000000005 x6 : 0000000000000010
> >     x5 : 0000000000000001 x4 : ffffffc081960d04 x3 : ffffff800161b280
> >     x2 : ffffff800161b050 x1 : 0000000000204000 x0 : 0000000000000108
> >     Call trace:
> >      _state+0x2c/0x138
> >      pl330_tasklet+0x1f8/0x818
> >      pl330_issue_pending+0x150/0x178
> >      serial8250_tx_dma+0x150/0x21c
> >      serial8250_start_tx+0x9c/0x1c0
> >      __uart_start+0x74/0xfc
> >      uart_write+0xfc/0x2f0
> >      ttyport_write_buf+0x4c/0x90
> >      serdev_device_write_buf+0x24/0x38
> >      hci_uart_write_work+0x54/0x164 [hci_uart]
> >      process_one_work+0x13c/0x2bc
> >      worker_thread+0x2a0/0x52c
> >      kthread+0xe0/0xe4
> >      ret_from_fork+0x10/0x20
> I think the dma channel already passed WFP state.
>
> The errata[1] says that
> 4.  The driver polls the status of channel 0 until it observes that
>      it has entered the "Waiting for peripheral" state
> 5.  The driver enables the peripheral to allow it to issue DMA requests
>
> When I review 8250_dma.c, I think serial8250_do_prepare_tx_dma() of
> serial8250_tx_dma() would enable peripheral to allow issue DMA requests.
> serial8250_do_prepare_tx_dma(p) performs before dma_async_issue_pending()
> It means that serial8250_tx_dma() has reversed sequence step 4 and 5 for
> pl330.

serial8250_prepare_tx_dma() on Rockchip doesn't do anything. The callback
called in serial8250_prepare_tx_dma() simply isn't set.

For this hardware the DMA request will be asserted when the TX FIFO is
empty, or when the RX FIFO has data, depending on the direction.

From the DesignWare UART release notes:

In mode 0 (single shot DMA), the dma_tx_req_n signal goes active low
under the following conditions:
- When the Transmitter Holding Register is empty in non-FIFO mode
- When the transmitter FIFO is empty in FIFO mode with Programmable THRE
  interrupt mode disabled
- When the transmitter FIFO is at or below the programmed threshold with
  Programmable THRE interrupt mode enabled

Mode 1 (continuous DMA) is the same, minus the first condition.

> But I'm not sure if the errata suggests normal slave driver dma usage
> sequence or not.

I'm not sure what you mean by this.

> If it is abnormal sequence, I think it should be handled by quirk

A quirk on which device? The DMA controller?

ChenYu

> [1]: https://developer.arm.com/documentation/genc008428/latest
>

