Return-Path: <dmaengine+bounces-10980-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAsnIXoAF2oJ0QcAu9opvQ
	(envelope-from <dmaengine+bounces-10980-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 27 May 2026 16:32:26 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E985E5EA4
	for <lists+dmaengine@lfdr.de>; Wed, 27 May 2026 16:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC648300EF59
	for <lists+dmaengine@lfdr.de>; Wed, 27 May 2026 14:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B7D425CED;
	Wed, 27 May 2026 14:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MiP0SQBv"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A6534107F;
	Wed, 27 May 2026 14:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779892204; cv=none; b=kYKUTxqx+MAyakp6H3fABvFztGR3Yt+1A8RBr/U+f2Ov7DvK8LZuBgMJN9ynP1UUiycW5+CsUMO0Ec/cJXS371ZdeqOzXjycd5Bz08SYY59Zddv8ZdtKOlaLqYCoevqDlvqsPOZbPpYu/KQbWgbeq9ao/NOlm18zokz/zr09ZqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779892204; c=relaxed/simple;
	bh=pMmuccQxM/3B19c3RX6nchFjJhiuy0xgKex4bL+bVyc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iaWBPyzUydvsDn1NUrud9nW0Jnu6mIGp6UVQBHeGKFoAlhQR+B7u+U5vUlHj5XPh28vGw8jJ6HpxZ6QXDQ6LgTXjXUohb/ZQzwKlE9TupgvUZYzl2x7sLCbsTa5Y+zJ1g4Y3ubmhyi5ehvQqBRGLkgRT9RxWNOepYOLI4WpBB3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MiP0SQBv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9991D1F000E9;
	Wed, 27 May 2026 14:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779892202;
	bh=QDRUYYr9IDEEV7PJuJg37DNRFc8ywsf3CX6aI/54xjE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MiP0SQBv/6AIcXc90/yfMUeTNbIzK9+S0bRRXJXh2cV9v95UShVu+kUCsEaEwD2Ei
	 7Bxo57utb0Dtldnh/Uv9NBybRp2hgHtQmcS6UT80sWNiUs2vc5OHo745+/lMSKQy8P
	 A+BKkjZlkKmQwg48iVr12pmhYCdhYhY/xFh+CgZqrEM5aC1Mg+g2+tHqXknjkZ4dZs
	 lYUdoPzVTKfFaO4Z+4VW9FrlYWQUIfcbUMZ9dRzABidz0mVOKkQ0s29Pn5oZdO1czp
	 LYmSdX5BpOPzvdN3VjupQTrJT14nmXcvOY9a0yu6t6Gfb/j2VYkHpFr2a/81x3rsM3
	 i5YES0yeSvKIw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] dmaengine: atcdmac300: Add driver for Andes
 ATCDMAC300 DMA controller
Reply-To: sashiko-reviews@lists.linux.dev
To: "CL Wang" <cl634@andestech.com>
Cc: conor+dt@kernel.org, vkoul@kernel.org, robh@kernel.org, devicetree@vger.kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260527132815.1211195-3-cl634@andestech.com>
References: <20260527132815.1211195-3-cl634@andestech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 14:30:01 +0000
Message-Id: <20260527143001.9991D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10980-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,lists.linux.dev:replyto,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,smtp.kernel.org:mid]
X-Rspamd-Queue-Id: D5E985E5EA4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 12 potential issue=
(s) to consider:
- [Critical] Uninitialized `list_head` in dynamically allocated descriptors=
 causes a NULL pointer dereference in error paths.
- [Critical] Reused DMA descriptors do not have their linked list pointers =
cleared, potentially causing wild DMA accesses.
- [High] The driver registers the DMA device with the dmaengine and OF fram=
eworks before completing hardware and IRQ initialization.
- [High] The interrupt handler masks the hardware interrupt status with `us=
ed_chan` before clearing, causing unexpected interrupts to remain permanent=
ly asserted.
- [High] `atcdmac_terminate_all()` fails to clear pending hardware interrup=
ts, allowing stale interrupts to erroneously corrupt newly submitted transf=
ers.
- [High] The driver omits a `remove` function, causing a severe use-after-f=
ree if the device is unbound via sysfs.
- [High] A race condition in `atcdmac_advance_work()` causes a use-after-fr=
ee when invoking callbacks for cyclic transfers.
- [High] Spinning with interrupts disabled for up to 100ms during `atcdmac_=
terminate_all()` can cause severe system lockups.
- [High] Acquiring a `spinlock_t` in the primary hardware interrupt handler=
 violates PREEMPT_RT locking rules.
- [High] Cyclic transfers are implemented using software polling and restar=
ts instead of hardware linked lists, introducing unacceptable latency.
- [High] If the wait timeout expires during suspend, the DMA controller is =
left permanently disabled because `dmac->stop_mask` is never restored.
- [Medium] Descriptors are leaked during channel teardown if they are not i=
n the free list.
--

commit e6e8d9a6da52e397472687ec989dd87d328e0650
Author: CL Wang <cl634@andestech.com>

dmaengine: atcdmac300: Add driver for Andes ATCDMAC300 DMA controller

This patch adds support for the Andes ATCDMAC300 DMA controller.
The ATCDMAC300 provides scatter-gather, cyclic, and slave transfer
capabilities.

> diff --git a/drivers/dma/atcdmac300.c b/drivers/dma/atcdmac300.c
> index 0000000000000..367a920cd001c
> --- /dev/null
> +++ b/drivers/dma/atcdmac300.c

[ ... ]

> @@ -76,6 +76,21 @@ static struct atcdmac_desc *atcdmac_alloc_desc(struct =
dma_chan *chan,
>  	struct atcdmac_desc *desc;
>  	dma_addr_t phys;
> =20
>  	desc =3D dma_pool_zalloc(dmac->dma_desc_pool, gfp_flags, &phys);
>  	if (desc) {
>  		INIT_LIST_HEAD(&desc->tx_list);
>  		dma_async_tx_descriptor_init(&desc->txd, chan);

[Severity: Critical]
Does this leave the desc_node list uninitialized? If an error occurs
during transfer preparation, the cleanup routines might access uninitialized
pointers and cause a kernel panic. Should INIT_LIST_HEAD(&desc->desc_node)
be added here?

>  		desc->txd.flags =3D DMA_CTRL_ACK;
>  		desc->txd.tx_submit =3D atcdmac_tx_submit;
>  		desc->txd.phys =3D phys;
>  	}
> =20
>  	return desc;
>  }

[ ... ]

> @@ -215,6 +215,22 @@ static void atcdmac_chain_desc(struct atcdmac_desc *=
*first,
>  			       struct atcdmac_desc *desc,
>  			       bool cyclic)
>  {
>  	if (!(*first)) {
>  		*first =3D desc;
>  		desc->at =3D &desc->tx_list;
>  	} else {
>  		if (!cyclic) {
>  			(*prev)->regs.ll_ptr_lo =3D
>  				lower_32_bits(desc->txd.phys);
>  			(*prev)->regs.ll_ptr_hi =3D
>  				upper_32_bits(desc->txd.phys);
>  		}

[Severity: High]
Is hardware linked list chaining skipped for cyclic transfers here?
By leaving the linked list pointers zeroed during cyclic transfers, the
hardware stops at the end of each period. Does this require the CPU
interrupt handler to manually restart the channel, potentially introducing
audio dropouts and scheduling latency for time-sensitive clients?

>  		list_add_tail(&desc->desc_node, &(*first)->tx_list);
>  	}
>  	*prev =3D desc;
> =20
>  	desc->regs.ll_ptr_hi =3D 0;
>  	desc->regs.ll_ptr_lo =3D 0;
>  }

[ ... ]

> @@ -345,6 +345,43 @@ static void atcdmac_advance_work(struct atcdmac_chan=
 *dmac_chan)
>  	struct dmaengine_result res;
>  	LIST_HEAD(completed);
>  	unsigned long flags;
>  	unsigned short stop;
> =20
>  	spin_lock_irqsave(&dmac_chan->lock, flags);
>  	if (list_empty(&dmac_chan->active_list)) {
>  		spin_unlock_irqrestore(&dmac_chan->lock, flags);
>  		return;
>  	}
> =20
>  	dma_desc =3D atcdmac_get_active_head(dmac_chan);
>  	stop =3D READ_ONCE(dmac->stop_mask) & BIT(dmac_chan->chan_id);
>  	if (dmac_chan->cyclic) {
>  		if (!stop)
>  			atcdmac_start_next_trans(dmac_chan);
> =20
>  		spin_unlock_irqrestore(&dmac_chan->lock, flags);
>  		res.result =3D DMA_TRANS_NOERROR;
>  		dmaengine_desc_get_callback_invoke(&dma_desc->txd, &res);

[Severity: High]
Could this lead to a race condition? The lock is dropped while dma_desc
is still in the active_list. If dmaengine_terminate_all is called from
another CPU, could it free the descriptor and allow it to be reallocated
before the callback pointer is evaluated, potentially executing an
overwritten callback?

>  	} else {
>  		if (list_is_singular(&dmac_chan->active_list)) {
>  			list_splice_init(&dmac_chan->active_list, &completed);
>  			list_splice_init(&dmac_chan->queue_list,
>  					 &dmac_chan->active_list);

[ ... ]

> @@ -472,6 +472,44 @@ static irqreturn_t atcdmac_interrupt(int irq, void *=
dev_id)
>  	struct atcdmac_dmac *dmac =3D dev_id;
>  	struct atcdmac_chan *dmac_chan;
>  	unsigned int status;
>  	unsigned int int_ch;
>  	int ret =3D IRQ_NONE;
>  	int i;
> =20
>  	regmap_read(dmac->regmap, REG_INT_STA, &status);
>  	int_ch =3D READ_ONCE(dmac->used_chan) & DMA_INT_ALL(status);
> =20
>  	while (int_ch) {
>  		spin_lock(&dmac->lock);

[Severity: High]
Does acquiring this spinlock in the primary hardirq handler cause issues
on PREEMPT_RT kernels? Because spinlock_t is a preemptible sleepable lock
on RT, acquiring it in hardirq context can trigger lockdep splats and
deadlocks. Should dmac->lock be converted to a raw_spinlock_t?

[Severity: High]
By masking the interrupt status with used_chan, are we ignoring interrupts
from hardware when used_chan is 0? If an unexpected interrupt fires, int_ch
becomes 0 and the loop terminates without clearing the interrupt in
REG_INT_STA. Since the IRQ is level-triggered, could this result in an
infinite interrupt storm?

>  		dmac->used_chan =3D READ_ONCE(dmac->used_chan) & ~int_ch;
>  		spin_unlock(&dmac->lock);
>  		regmap_write(dmac->regmap, REG_INT_STA, DMA_INT_CLR(int_ch));
> =20
>  		for (i =3D 0; i < dmac->num_ch; i++) {

[ ... ]

> @@ -638,6 +638,23 @@ static struct atcdmac_desc *
>  atcdmac_build_desc(struct atcdmac_chan *dmac_chan,
>  		   dma_addr_t src,
>  		   dma_addr_t dst,
>  		   unsigned int ctrl,
>  		   unsigned int trans_size,
>  		   unsigned int num_sg)
>  {
>  	struct atcdmac_desc *desc;
> =20
>  	desc =3D atcdmac_get_desc(dmac_chan);
>  	if (!desc)
>  		return NULL;
> =20
>  	desc->regs.src_addr_lo =3D lower_32_bits(src);
>  	desc->regs.src_addr_hi =3D upper_32_bits(src);
>  	desc->regs.dst_addr_lo =3D lower_32_bits(dst);
>  	desc->regs.dst_addr_hi =3D upper_32_bits(dst);
>  	desc->regs.ctrl =3D ctrl;
>  	desc->regs.trans_size =3D trans_size;
>  	desc->num_sg =3D num_sg;
> =20
>  	return desc;
>  }

[Severity: Critical]
Are the linked list pointers cleared when a descriptor is reused?
atcdmac_build_desc does not reset ll_ptr_lo and ll_ptr_hi. If this
descriptor was previously used in a scatter-gather chain, could the hardware
erroneously follow stale pointers and cause uncontrolled memory corruption?

[ ... ]

> @@ -953,6 +953,30 @@ static int atcdmac_terminate_all(struct dma_chan *ch=
an)
>  	struct atcdmac_chan *dmac_chan =3D atcdmac_chan_to_dmac_chan(chan);
>  	struct atcdmac_desc *desc_cur, *desc_next;
>  	LIST_HEAD(list);
>  	unsigned long flags;
>  	unsigned int val;
>  	int ret;
> =20
>  	spin_lock_irqsave(&dmac_chan->lock, flags);
>  	atcdmac_abort_chan(dmac_chan);
>  	atcdmac_enable_chan(dmac_chan, 0);
>  	ret =3D regmap_read_poll_timeout_atomic(dmac_chan->dma_dev->regmap,
>  					      REG_CH_EN,
>  					      val,
>  					      !(val & BIT(dmac_chan->chan_id)),
>  					      10,
>  					      ATCDMAC_CHAN_TIMEOUT_US);

[Severity: High]
Is it safe to poll for up to 100ms with local interrupts disabled?
ATCDMAC_CHAN_TIMEOUT_US is 100,000. Busy-waiting this long in an atomic
context can trigger soft lockups and trip the NMI watchdog.

[Severity: High]
Does aborting the channel here leave an unhandled abort interrupt pending?
atcdmac_abort_chan() triggers a hardware abort, but the subsequent
dmac_chan->chan_used =3D 0 causes the interrupt handler to ignore it. If a
new transfer is submitted later, could the stale abort interrupt fire
immediately, disrupting the new transfer state?

>  	if (ret)
>  		dev_err(atcdmac_chan_to_dev(chan),
>  			"Timed out waiting for channel to disable\n");

[ ... ]

> @@ -1066,6 +1066,32 @@ static void atcdmac_free_chan_resources(struct dma=
_chan *chan)
>  {
>  	struct atcdmac_chan *dmac_chan =3D atcdmac_chan_to_dmac_chan(chan);
>  	struct atcdmac_dmac *dmac =3D atcdmac_dev_to_dmac(chan->device);
>  	struct atcdmac_desc *desc_next, *desc;
>  	unsigned long flags;
> =20
>  	WARN_ON_ONCE(atcdmac_is_chan_enable(dmac_chan));
> =20
>  	spin_lock_irq(&dmac->lock);
>  	dmac->stop_mask |=3D BIT(dmac_chan->chan_id);
>  	spin_unlock_irq(&dmac->lock);
> =20
>  	atcdmac_terminate_all(chan);
> =20
>  	spin_lock_irqsave(&dmac_chan->lock, flags);
>  	list_for_each_entry_safe(desc,
>  				 desc_next,
>  				 &dmac_chan->free_list,
>  				 desc_node) {
>  		list_del(&desc->desc_node);
>  		dma_pool_free(dmac->dma_desc_pool, desc, desc->txd.phys);
>  	}

[Severity: Medium]
Could descriptors be leaked if a client submits a new transfer from within
the completion callback during atcdmac_terminate_all? Since the loop above
only iterates over free_list, any newly added descriptors in queue_list
would not be freed and permanently leaked.

> =20
>  	INIT_LIST_HEAD(&dmac_chan->free_list);
>  	dmac_chan->descs_allocated =3D 0;

[ ... ]

> @@ -1438,6 +1438,40 @@ static int atcdmac_probe(struct platform_device *p=
dev)
>  	struct atcdmac_dmac *dmac;
>  	int ret;
> =20
>  	ret =3D atcdmac_init_ioremap_and_regmap(pdev, &dmac);
>  	if (ret)
>  		return ret;
> =20
>  	ret =3D atcdmac_reset_and_wait_chan_idle(dmac);
>  	if (ret)
>  		return ret;
> =20
>  	ret =3D atcdmac_init_desc_pool(pdev, dmac);
>  	if (ret)
>  		return ret;
> =20
>  	ret =3D atcdmac_init_channels(pdev, dmac);
>  	if (ret)
>  		return ret;
> =20
>  	atcdmac_init_dma_device(pdev, dmac);
> =20
>  	ret =3D dma_async_device_register(&dmac->dma_device);
>  	if (ret)
>  		return ret;
> =20
>  	ret =3D atcdmac_init_irq(pdev, dmac);
>  	if (ret)
>  		goto err_dma_async_register;
> =20
>  	ret =3D of_dma_controller_register(pdev->dev.of_node,
>  					 atcdmac_dma_xlate_handler,
>  					 dmac);
>  	if (ret)
>  		goto err_dma_async_register;
> =20
>  	ret =3D atcdmac_init_iocp(pdev, dmac);
>  	if (ret)
>  		goto err_of_dma_register;

[Severity: High]
Are the frameworks being notified before the device is fully initialized?
dma_async_device_register and of_dma_controller_register expose the device
to clients, but atcdmac_init_irq and atcdmac_init_iocp are called after.
If a client immediately queues a transfer, could it execute before the IRQ
handler is ready, leading to unhandled interrupts?

> =20
>  	return 0;

[ ... ]

> @@ -1480,6 +1480,24 @@ static int atcdmac_suspend(struct device *dev)
>  {
>  	struct atcdmac_dmac *dmac =3D dev_get_drvdata(dev);
>  	int ret;
>  	unsigned long flags;
> =20
>  	spin_lock_irqsave(&dmac->lock, flags);
>  	dmac->stop_mask =3D BIT(dmac->num_ch) - 1;
>  	spin_unlock_irqrestore(&dmac->lock, flags);
>  	ret =3D atcdmac_wait_chan_idle(dmac,
>  				     dmac->stop_mask,
>  				     ATCDMAC_CHAN_TIMEOUT_US * dmac->num_ch);
> =20
>  	return ret;
>  }

[Severity: High]
Does a timeout here leave the controller permanently disabled? If
atcdmac_wait_chan_idle times out and returns an error, the PM core skips
the resume callback. Because stop_mask is never cleared, does the DMA
controller reject all future transfers until reboot?

> =20
>  static DEFINE_SIMPLE_DEV_PM_OPS(atcdmac_pm_ops,

[ ... ]

> @@ -1498,6 +1498,14 @@ static const struct of_device_id atcdmac_dt_ids[] =
=3D {
>  	{ .compatible =3D "andestech,ae350-dma", },
>  	{ /* sentinel */ },
>  };
>  MODULE_DEVICE_TABLE(of, atcdmac_dt_ids);
> =20
>  static struct platform_driver atcdmac_driver =3D {
>  	.probe =3D atcdmac_probe,
>  	.driver =3D {
>  		.name =3D "atcdmac300",
>  		.of_match_table =3D atcdmac_dt_ids,
>  		.pm =3D pm_sleep_ptr(&atcdmac_pm_ops),
>  	},
>  };

[Severity: High]
Is a remove function needed here? Memory is allocated via devm_ functions,
but the DMA controller and dmaengine are registered using non-devm APIs.
If the driver is unbound via sysfs, could this lead to a use-after-free
when clients attempt to access the freed memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260527132815.1211=
195-1-cl634@andestech.com?part=3D2

