Return-Path: <dmaengine+bounces-11092-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LLOJA1hHWq2ZwkAu9opvQ
	(envelope-from <dmaengine+bounces-11092-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 01 Jun 2026 12:38:05 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F269461DA5F
	for <lists+dmaengine@lfdr.de>; Mon, 01 Jun 2026 12:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 511753129DBE
	for <lists+dmaengine@lfdr.de>; Mon,  1 Jun 2026 10:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA80836A03A;
	Mon,  1 Jun 2026 10:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GqcnQDZf"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40683391853;
	Mon,  1 Jun 2026 10:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780308804; cv=none; b=TT9GR7IQmeX2bcLNcyNrdrekzpmjlgoqnT8En7v2hsWGoPnkTMep0B4AS7//PbJCK00bx3tWPuwn9EH5oGOHc5uXlMZ1wejQWcCBtfMcTjlmpqqYqIXfKXeVwcsEySzERz0vTcSeAAPQyj9LNWLvlqhf2Egw74PEZMeQui5Cg0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780308804; c=relaxed/simple;
	bh=Xxn5LduHW27aHRk3Nxa0KhU5LfwsLM5uGY7TL8EEJo0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hzHRhc1H0O58PL29MJczEnRx3jRtEGE7/ynxizZJd4vsV1T8zvKg1rS3p8ddxmclYtTVP7zGl7xSSfKy5jW7idXYOskHiSNNP3XwKDdRjJhbXo+igYaS3W64TQ2p7wDv4YAuAACBx7JjgQSPv12t0zq1dKqtSpr5Ca6xufEAsHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GqcnQDZf; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B43F31F00899;
	Mon,  1 Jun 2026 10:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780308799;
	bh=zkZxxo+DbhtocrgxOX6eFjQ3qpxX0SjSE7EYIFTudE4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GqcnQDZfjObhALNuhTQoLCW+XoEbjbRZ1EOdEZzCQvPKRiC49dVvC/hvj0tRrWSYo
	 U65QJCB7I+VzLn9229w0wZL4vSxVUqBcc6MbayQSmVJQTJ9V16wGVOxZFL4JN6AfIO
	 a0GhJ4zcfPtYuGKLIFWey9w4NwnEjcpfp1MQ7GA9SAENX2GkbKgHmpwF+KvdhlV4Qc
	 VIGS8VN7E06tkBcPbU9Lu6l8/6jnr9p3DrW9Sp7NaV2TpCYmpdStT5pcLQXeYHyS0R
	 P1NT5edtXSUJnfFUK99USOhfxF7T0RqK0wtcp/Hu8Z1msqQBZbghXLSL9cJ/gkX+ze
	 LOED6TTcE0haA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/3] dmaengine: atcdmac300: Add driver for Andes
 ATCDMAC300 DMA controller
Reply-To: sashiko-reviews@lists.linux.dev
To: "CL Wang" <cl634@andestech.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org, vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260601094846.1097678-3-cl634@andestech.com>
References: <20260601094846.1097678-3-cl634@andestech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 10:13:18 +0000
Message-Id: <20260601101318.B43F31F00899@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11092-lists,dmaengine=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lists.linux.dev:replyto,andestech.com:email]
X-Rspamd-Queue-Id: F269461DA5F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 12 potential issue=
(s) to consider:
- [Critical] Missing `.remove` callback leads to memory leaks and Use-After=
-Free when the driver is unbound via sysfs.
- [High] Strict power-of-two validation on all address widths and burst siz=
es breaks standard DMA clients.
- [High] Hardware interrupts are incorrectly masked by a software state var=
iable before clearing, leading to an unhandled interrupt storm and system l=
ockup.
- [High] The channel's `cyclic` state flag is never cleared, causing invali=
d pointer dereferences on resume or when subsequently reused for non-cyclic=
 transfers.
- [High] The DMA device is registered and exposed to clients before its int=
errupt handler and hardware coherence (IOCP) are fully initialized.
- [High] Write-1-to-Clear (W1C) race condition in `atcdmac_interrupt` uncon=
ditionally clears all interrupt types, losing concurrently triggered unhand=
led interrupts.
- [High] Lack of synchronization between the custom threaded IRQ and channe=
l teardown causes list corruption and memory leaks.
- [High] If `atcdmac_suspend` times out waiting for channels to go idle, it=
 permanently bricks the DMA controller by leaving `stop_mask` fully asserte=
d.
- [High] The primary interrupt handler acquires a standard `spinlock_t` and=
 performs MMIO regmap operations, which will cause fatal sleep-in-atomic bu=
gs on PREEMPT_RT.
- [High] In `atcdmac_irq_thread()`, handling Terminal Count (TC) before Err=
or (ERR) falsely reports failed transactions as successful and aborts innoc=
ent queued transactions.
- [High] System resume blindly restarts the head of `active_list` for non-c=
yclic channels, which will erroneously re-execute completed transactions if=
 the IRQ thread was delayed prior to suspend.
- [Medium] atcdmac_prep_dma_memcpy ignores user-provided dmaengine flags.
--

commit 717d2125491de1fc8bc4cf0c28112507cb655dda
Author: CL Wang <cl634@andestech.com>
Subject: dmaengine: atcdmac300: Add driver for Andes ATCDMAC300 DMA control=
ler

This patch adds support for the Andes ATCDMAC300 DMA controller.
The ATCDMAC300 is a memory-to-memory and peripheral DMA controller
that provides scatter-gather, cyclic, and slave transfer capabilities.

> diff --git a/drivers/dma/atcdmac300.h b/drivers/dma/atcdmac300.h
> --- /dev/null
> +++ b/drivers/dma/atcdmac300.h
[ ... ]
> +#define DMA_TC_FIELD		GENMASK(TC_OFFSET + 7, TC_OFFSET)
> +#define DMA_ABT_FIELD		GENMASK(ABT_OFFSET + 7, ABT_OFFSET)
> +#define DMA_ERR_FIELD		GENMASK(ERR_OFFSET + 7, ERR_OFFSET)
> +#define DMA_INT_ALL(val)	(FIELD_GET(DMA_TC_FIELD, (val)) |	\
> +				 FIELD_GET(DMA_ABT_FIELD, (val)) |	\
> +				 FIELD_GET(DMA_ERR_FIELD, (val)))
> +#define DMA_INT_CLR(val)	(FIELD_PREP(DMA_TC_FIELD, (val)) |	\
> +				 FIELD_PREP(DMA_ABT_FIELD, (val)) |	\
> +				 FIELD_PREP(DMA_ERR_FIELD, (val)))

[Severity: High]
Does this Write-1-to-Clear (W1C) mask unconditionally clear all three event
sources for the interrupting channel?

If an ERR or ABT event occurs in the microscopic window between reading the
status register and writing this mask back in the interrupt handler, will
those unread events be permanently lost?

> diff --git a/drivers/dma/atcdmac300.c b/drivers/dma/atcdmac300.c
> --- /dev/null
> +++ b/drivers/dma/atcdmac300.c
[ ... ]
> +static void atcdmac_start_next_trans(struct atcdmac_chan *dmac_chan)
> +{
> +	struct atcdmac_desc *next_tx =3D NULL;
> +	struct atcdmac_desc *dma_desc;
> +
> +	if (dmac_chan->cyclic) {
> +		/* Get the next DMA descriptor from tx_list. */
> +		dma_desc =3D atcdmac_get_active_head(dmac_chan);
> +		dma_desc->at =3D dma_desc->at->next;

[Severity: High]
If the channel was previously used for cyclic transfers but is now being us=
ed
with non-cyclic transfers or an empty list, could dma_desc->at be NULL or
uninitialized here?

The cyclic state flag is set in atcdmac_prep_dma_cyclic() but doesn't seem =
to
be cleared when preparing other transfer types or freeing resources, which
might lead to a NULL pointer dereference.

[ ... ]
> +static irqreturn_t atcdmac_irq_thread(int irq, void *dev_id)
> +{
> +	struct atcdmac_dmac *dmac =3D dev_id;
> +	struct atcdmac_chan *dmac_chan;
> +	int i;
> +	bool handled =3D false;
> +
> +	for (i =3D 0; i < dmac->num_ch; i++) {
> +		dmac_chan =3D &dmac->chan[i];
> +
> +		if (test_and_clear_bit(ATCDMAC_STA_TC, &dmac_chan->status)) {
> +			atcdmac_advance_work(dmac_chan);
> +			handled =3D true;
> +		}
> +
> +		if (test_and_clear_bit(ATCDMAC_STA_ERR, &dmac_chan->status)) {
> +			atcdmac_handle_error(dmac_chan);
> +			handled =3D true;
> +		}

[Severity: High]
Does evaluating the Terminal Count (TC) status before the Error (ERR) status
cause misattribution of hardware errors?

If both bits are set on the final beat of a transfer, atcdmac_advance_work()
runs first, marks the current transaction as successful, and starts the next
one. Then the ERR block executes and aborts the innocent transaction that j=
ust
started.

[ ... ]
> +static irqreturn_t atcdmac_interrupt(int irq, void *dev_id)
> +{
> +	struct atcdmac_dmac *dmac =3D dev_id;
> +	struct atcdmac_chan *dmac_chan;
> +	unsigned int status;
> +	unsigned int int_ch;
> +	int ret =3D IRQ_NONE;
> +	int i;
> +
> +	regmap_read(dmac->regmap, REG_INT_STA, &status);
> +	int_ch =3D READ_ONCE(dmac->used_chan) & DMA_INT_ALL(status);
> +
> +	while (int_ch) {
> +		spin_lock(&dmac->lock);
> +		dmac->used_chan =3D READ_ONCE(dmac->used_chan) & ~int_ch;
> +		spin_unlock(&dmac->lock);
> +		regmap_write(dmac->regmap, REG_INT_STA, DMA_INT_CLR(int_ch));

[Severity: High]
Are hardware interrupts dangerously masked by the used_chan software state?

If atcdmac_terminate_all() aborts a channel, the hardware asserts an ABORT
interrupt. If used_chan was already cleared, int_ch evaluates to 0.

Will the handler skip the clear loop and return IRQ_NONE, leaving the inter=
rupt
line asserted and trapping the CPU in a hardirq loop?

[Severity: High]
Additionally, this hardirq handler acquires a standard spinlock_t and perfo=
rms
regmap I/O operations.

Since the regmap is not configured with use_raw_spinlock, it defaults to a
sleepable spinlock internally. Will this cause sleep-in-atomic crashes on
PREEMPT_RT kernels?

[ ... ]
> +static struct dma_async_tx_descriptor *
> +atcdmac_prep_dma_memcpy(struct dma_chan *chan,
> +			dma_addr_t dst,
> +			dma_addr_t src,
> +			size_t len,
> +			unsigned long flags)
> +{
[ ... ]
> +	desc =3D atcdmac_build_desc(dmac_chan, src, dst, ctrl,
> +				  len >> src_width, 1);
> +	if (!desc)
> +		goto err_desc_get;
> +
> +	return &desc->txd;

[Severity: Medium]
Are the user-provided dmaengine flags ignored here?

It appears the flags argument is never assigned to desc->txd.flags before
returning, which means client requests like DMA_PREP_INTERRUPT or DMA_CTRL_=
ACK
will not be evaluated.

[ ... ]
> +static struct dma_async_tx_descriptor *
> +atcdmac_prep_dma_cyclic(struct dma_chan *chan,
> +			dma_addr_t buf_addr,
> +			size_t buf_len,
> +			size_t period_len,
> +			enum dma_transfer_direction direction,
> +			unsigned long flags)
> +{
[ ... ]
> +	first->txd.flags =3D flags;
> +	dmac_chan->cyclic =3D true;
> +
> +	return &first->txd;

[Severity: High]
As mentioned earlier, does this flag ever get cleared when the channel is
repurposed for non-cyclic transfers?

[ ... ]
> +static int atcdmac_set_device_config(struct dma_chan *chan,
> +				     struct dma_slave_config *sconfig)
> +{
> +	struct atcdmac_chan *dmac_chan =3D atcdmac_chan_to_dmac_chan(chan);
> +
> +	/* Check if this chan is configured for device transfers */
> +	if (!dmac_chan->dev_chan)
> +		return -EINVAL;
> +
> +	/* Must be powers of two according to ATCDMAC300 spec */
> +	if (!is_power_of_2(sconfig->src_maxburst) ||
> +	    !is_power_of_2(sconfig->dst_maxburst) ||
> +	    !is_power_of_2(sconfig->src_addr_width) ||
> +	    !is_power_of_2(sconfig->dst_addr_width))
> +		return -EINVAL;

[Severity: High]
Does this unconditional check on all fields break standard DMA clients?

For unidirectional transfers (like DMA_MEM_TO_DEV), clients typically leave=
 the
opposite direction's fields zeroed. Since is_power_of_2(0) returns false, w=
ill
this incorrectly reject valid configurations?

[ ... ]
> +static void atcdmac_free_chan_resources(struct dma_chan *chan)
> +{
> +	struct atcdmac_chan *dmac_chan =3D atcdmac_chan_to_dmac_chan(chan);
> +	struct atcdmac_dmac *dmac =3D atcdmac_dev_to_dmac(chan->device);
> +	struct atcdmac_desc *desc_next, *desc;
> +	unsigned long flags;
> +
> +	WARN_ON_ONCE(atcdmac_is_chan_enable(dmac_chan));
> +
> +	spin_lock_irq(&dmac->lock);
> +	dmac->stop_mask |=3D BIT(dmac_chan->chan_id);
> +	spin_unlock_irq(&dmac->lock);
> +
> +	atcdmac_terminate_all(chan);
> +
> +	spin_lock_irqsave(&dmac_chan->lock, flags);
> +	list_for_each_entry_safe(desc,

[Severity: High]
Is there a race condition here with the threaded IRQ?

If a client frees a channel concurrently while the IRQ thread is executing a
callback, this function will clear out free_list without calling
synchronize_irq().

Once the threaded IRQ finishes its callback, it calls atcdmac_put_desc(),
adding the descriptor back to the supposedly empty free_list, leading to me=
mory
leaks and list corruption.

[ ... ]
> +static int atcdmac_probe(struct platform_device *pdev)
> +{
[ ... ]
> +	atcdmac_init_dma_device(pdev, dmac);
> +
> +	ret =3D dma_async_device_register(&dmac->dma_device);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D atcdmac_init_irq(pdev, dmac);
> +	if (ret)
> +		goto err_dma_async_register;
> +
> +	ret =3D of_dma_controller_register(pdev->dev.of_node,
> +					 atcdmac_dma_xlate_handler,
> +					 dmac);
> +	if (ret)
> +		goto err_dma_async_register;
> +
> +	ret =3D atcdmac_init_iocp(pdev, dmac);
> +	if (ret)
> +		goto err_of_dma_register;

[Severity: High]
Is it safe to register the DMA device and expose it to clients before its
interrupt handler and hardware coherence (IOCP) are initialized?

If a client requests a channel and initiates a transfer during this window,
could the hardware perform non-coherent memory accesses and assert interrup=
ts
before the handler is attached?

[Severity: Critical]
Additionally, since the device is registered with non-devm functions, does =
the
lack of a .remove callback allow a privileged user to unbind the driver via
sysfs?

This would trigger devm cleanups while leaving the DMA controller actively
registered in the core dmaengine list, leading to a Use-After-Free on
subsequent DMA requests.

[ ... ]
> +static int atcdmac_resume(struct device *dev)
> +{
[ ... ]
> +	spin_lock_irqsave(&dmac->lock, flags);
> +	dmac->stop_mask =3D 0;
> +	spin_unlock_irqrestore(&dmac->lock, flags);
> +	list_for_each_entry_safe(chan,
> +				 chan_next,
> +				 &dmac->dma_device.channels,
> +				 device_node) {
> +		dmac_chan =3D atcdmac_chan_to_dmac_chan(chan);
> +		spin_lock_irqsave(&dmac_chan->lock, flags);
> +		atcdmac_start_next_trans(dmac_chan);
> +		spin_unlock_irqrestore(&dmac_chan->lock, flags);
> +	}
> +
> +	return 0;
> +}

[Severity: High]
Does blindly restarting the head of active_list here risk re-executing
completed transactions?

If a non-cyclic transfer completes just before suspend, the hardirq fires b=
ut
the threaded IRQ might not have run before tasks were frozen.

The completed descriptor remains on active_list, and this resume path will
mistakenly pop it and submit it to the hardware again.

[ ... ]
> +static int atcdmac_suspend(struct device *dev)
> +{
> +	struct atcdmac_dmac *dmac =3D dev_get_drvdata(dev);
> +	int ret;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&dmac->lock, flags);
> +	dmac->stop_mask =3D BIT(dmac->num_ch) - 1;
> +	spin_unlock_irqrestore(&dmac->lock, flags);
> +	ret =3D atcdmac_wait_chan_idle(dmac,
> +				     dmac->stop_mask,
> +				     ATCDMAC_CHAN_TIMEOUT_US * dmac->num_ch);
> +
> +	return ret;
> +}

[Severity: High]
If this function times out waiting for channels to go idle, it returns an
error, which causes the PM core to abort suspend without calling resume.

Will leaving stop_mask fully asserted silently drop all future transactions=
 and
permanently brick the DMA controller?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601094846.1097=
678-1-cl634@andestech.com?part=3D2

