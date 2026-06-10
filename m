Return-Path: <dmaengine+bounces-11402-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id a5RpLyM6KWqfSgMAu9opvQ
	(envelope-from <dmaengine+bounces-11402-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 12:19:15 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E77F668323
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 12:19:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=X15r0LNR;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11402-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-11402-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 703F83098052
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 10:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD753ED5AC;
	Wed, 10 Jun 2026 10:17:42 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B04F23392A;
	Wed, 10 Jun 2026 10:17:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781086661; cv=none; b=YOXNVYI9i9RY6c0YLR3quz3NTTqj34vrshbCVIGNSONj3Smib389gxY++Kj1OmK2rrwTwZk5x8iHOleJZP2X3pdAs7YUpdmAAhXmJbtXNMDWdYhK9HjQsjx0oVKjEo+xuG4coD5pteTpTMw0ERa2XYOVG9XrKleE/pFX2HVFing=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781086661; c=relaxed/simple;
	bh=vIm9EW8+qM519LrTMzI97uooQWWThCZR1d3GNFu1Qu8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bshwdpHTbcJUxO5DFOzvAwTM0DSOdwegiYAwcjBOZNu5Z3pSbldDNRPQdAqyE+iZWcPCpvD3gaONppZNtJWrVMwiAEGY0fbFYQqzPBckrzfnf6ORxVOPYyrkUPwbSd0SrAq2umiddEVgk0Y4PcprGSfsn8PQE1ZggOr3yxYprG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X15r0LNR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD1EA1F00893;
	Wed, 10 Jun 2026 10:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781086660;
	bh=zE5zw1Db+w0eaEmPQmsMxwL7d85a7F0DGrQzO0X1hIU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X15r0LNRZCJF8kBuRCx45ELz8YmTZgLaoK43+ofVAfWnne7IhZpSHcXWdcb9FCjqa
	 cXCjjoDNNuYueHaNAiv1cIyOt6FF5iRne3XdDkEJFp3E3nzUjrhNyRni3Fl93HA5qk
	 8Nt73n1Ky+7rnTz7/f+EmELLCPEDes4Rt6FUYZ128YyKfqszaSQZb4T78LQBtpt2Si
	 7ZBruBWVer5PwvDV9/moOxWlHb1VT8kdecu2nDhxuBK4zxysLvj3xzZDnnBLACnyvy
	 bnhkfpG52cRQPmlPajhirReBKrFZgO9yCni1LCArzSAagCXEJBrQcF9yteaNfyJs8i
	 3oKgV+CYuiCkQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/3] dmaengine: atcdmac300: Add driver for Andes
 ATCDMAC300 DMA controller
Reply-To: sashiko-reviews@lists.linux.dev
To: "CL Wang" <cl634@andestech.com>
Cc: conor+dt@kernel.org, robh@kernel.org, vkoul@kernel.org, devicetree@vger.kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260610095724.1980622-3-cl634@andestech.com>
References: <20260610095724.1980622-3-cl634@andestech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 10:17:39 +0000
Message-Id: <20260610101739.DD1EA1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-11402-lists,dmaengine=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:cl634@andestech.com,m:conor+dt@kernel.org,m:robh@kernel.org,m:vkoul@kernel.org,m:devicetree@vger.kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sashiko.dev:url,lists.linux.dev:replyto,vger.kernel.org:from_smtp,andestech.com:email,smtp.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2E77F668323

Thank you for your contribution! Sashiko AI review found 10 potential issue=
(s) to consider:
- [High] Unmanaged `cyclic` flag leads to NULL pointer dereferences, infini=
te loops, and resume panics.
- [High] Interrupt handler masks hardware interrupt status with `used_chan`=
, leaving unmasked interrupts unacknowledged.
- [High] Premature execution of unissued DMA descriptors violates the DMA e=
ngine API.
- [High] Missing `device_synchronize` callback prevents safe client synchro=
nization with the threaded IRQ handler.
- [High] Fetching the client callback outside the lock in `atcdmac_advance_=
work` creates a Use-After-Free race with channel termination.
- [High] Reusing descriptors from `free_list` does not clear previously set=
 callbacks and parameters.
- [Medium] `atcdmac_set_device_config` strictly validates unused configurat=
ion fields, breaking unidirectional slave configurations.
- [Medium] Asymmetric registration and teardown order creates Use-After-Fre=
e vulnerabilities and Race Conditions.
- [Medium] Prepared but unsubmitted DMA descriptors are permanently leaked =
due to missing `desc_free` callback.
- [Medium] Truncation of `size_t len` to `unsigned int trans_size` could le=
ad to incomplete DMA transfers on 64-bit platforms.
--

commit 892196b95d4c6cbcb6477d01fb69f6b5e13d4612
Author: CL Wang <cl634@andestech.com>

dmaengine: atcdmac300: Add driver for Andes ATCDMAC300 DMA controller

This patch adds support for the Andes ATCDMAC300 DMA controller.
It provides memory-to-memory and peripheral DMA controller
support with scatter-gather, cyclic, and slave transfer capabilities.

> diff --git a/drivers/dma/atcdmac300.c b/drivers/dma/atcdmac300.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/dma/atcdmac300.c
> @@ -0,0 +1,1518 @@
[ ... ]
> +static struct atcdmac_desc *atcdmac_alloc_desc(struct dma_chan *chan,
> +					       gfp_t gfp_flags)
> +{
[ ... ]
> +	desc =3D dma_pool_zalloc(dmac->dma_desc_pool, gfp_flags, &phys);
> +	if (desc) {
> +		INIT_LIST_HEAD(&desc->tx_list);
> +		dma_async_tx_descriptor_init(&desc->txd, chan);
> +		desc->txd.flags =3D DMA_CTRL_ACK;

[Severity: Medium]
Is there a missing assignment for the desc_free callback here?

When a client prepares a transaction, descriptors are removed from
dmac_chan->free_list. If the client aborts and calls dmaengine_desc_free(),
the dmaengine core attempts to invoke desc->txd.desc_free. Because
atcdmac_alloc_desc() never assigns this callback, the core drops the
descriptor.

Since atcdmac_free_chan_resources() only reclaims descriptors currently
present in free_list, any orphaned, unsubmitted descriptors seem permanently
leaked from dmac->dma_desc_pool. Can we add the appropriate callback to
prevent pool exhaustion?

> +		desc->txd.tx_submit =3D atcdmac_tx_submit;
> +		desc->txd.phys =3D phys;
> +	}
> +
> +	return desc;
> +}
[ ... ]
> +static struct atcdmac_desc *atcdmac_get_desc(struct atcdmac_chan *dmac_c=
han)
> +{
[ ... ]
> +	spin_lock_irqsave(&dmac_chan->lock, flags);
> +	list_for_each_entry_safe(desc, desc_next,
> +				 &dmac_chan->free_list,
> +				 desc_node) {
> +		if (async_tx_test_ack(&desc->txd)) {
> +			list_del_init(&desc->desc_node);
> +			ret =3D desc;
> +			break;
> +		}

[Severity: High]
Should the descriptor callback and parameter fields be reset before reusing
it from the free_list?

When atcdmac_get_desc() retrieves a descriptor for a new transfer, it does
not appear to zero out desc->txd.callback and desc->txd.callback_param. If a
client previously used this descriptor with a callback, freed its context,
and reuses it without setting a new callback, the DMA engine might
inadvertently execute the stale callback.

Could this lead to use-after-free issues if the context is already freed?

> +	}
> +	spin_unlock_irqrestore(&dmac_chan->lock, flags);
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
Does this sequence safely handle channels that have transitioned from cyclic
to non-cyclic transfers, or handle resume states properly?

The driver sets dmac_chan->cyclic to true in atcdmac_prep_dma_cyclic(), but
this flag is never reset to false during atcdmac_terminate_all() or when
preparing subsequent non-cyclic transfers like memcpy.

If a channel is used for a cyclic transfer, terminated, and then reused for=
 a
non-cyclic transfer, the stale cyclic state causes atcdmac_advance_work() to
enter the cyclic path here. For memcpy descriptors, this leads to a null
pointer dereference on dma_desc->at->next.

Additionally, during system resume, atcdmac_resume() unconditionally calls
atcdmac_start_next_trans() on all channels. For a terminated cyclic channel,
active_list is empty, causing atcdmac_get_active_head() to return an invalid
pointer and crashing the kernel upon dereference.

> +		if ((uintptr_t)dma_desc->at =3D=3D (uintptr_t)&dma_desc->tx_list)
> +			next_tx =3D list_entry(dma_desc->at,
> +					     struct atcdmac_desc,
> +					     tx_list);
> +		else
> +			next_tx =3D list_entry(dma_desc->at,
> +					     struct atcdmac_desc,
> +					     desc_node);
> +	} else {
> +		if (list_empty(&dmac_chan->active_list)) {
> +			if (!list_empty(&dmac_chan->queue_list)) {
> +				list_splice_init(&dmac_chan->queue_list,
> +						 &dmac_chan->active_list);

[Severity: High]
Is it safe to splice the entire queue_list into active_list without checking
if the client has explicitly issued the pending descriptors?

The DMA engine API contract requires that descriptors submitted via tx_subm=
it
remain pending and are not started until the client explicitly calls
dma_async_issue_pending().

However, atcdmac_advance_work() unconditionally splices unissued descriptors
from queue_list into active_list when a prior transaction completes.
Similarly, atcdmac_resume() pulls unissued descriptors from queue_list. If a
client submits descriptors but intentionally delays issuing them (e.g. wait=
ing
for a peripheral), the driver will incorrectly execute them prematurely.

> +				next_tx =3D atcdmac_get_active_head(dmac_chan);
> +			}
[ ... ]
> +static void atcdmac_advance_work(struct atcdmac_chan *dmac_chan)
> +{
[ ... ]
> +	if (dmac_chan->cyclic) {
> +		if (!stop)
> +			atcdmac_start_next_trans(dmac_chan);
> +
> +		spin_unlock_irqrestore(&dmac_chan->lock, flags);
> +		res.result =3D DMA_TRANS_NOERROR;
> +		dmaengine_desc_get_callback_invoke(&dma_desc->txd, &res);

[Severity: High]
Does fetching the client callback outside the channel lock create a
use-after-free race condition?

For cyclic transfers, dma_desc remains on active_list. The lock is dropped
via spin_unlock_irqrestore() before accessing dma_desc->txd to invoke the
callback.

While the lock is dropped, a concurrent dmaengine_terminate_all() can acqui=
re
the lock, splice the active_list away, and return dma_desc to the free_list.
The client might then release the channel, freeing the descriptor back to t=
he
pool. The IRQ thread will then use the freed descriptor to invoke the
callback. Should the callback information be extracted while the lock is
still held?

> +	} else {
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

[Severity: High]
Can this loop leave hardware interrupts unacknowledged and cause an interru=
pt
storm?

The handler masks the hardware interrupt status with the software-tracked
used_chan mask. It only clears the interrupts identified by int_ch. If the
hardware asserts an interrupt for a channel not currently in used_chan
(for instance, an ABT interrupt generated by atcdmac_terminate_all() on a
previously idle channel, or a spurious interrupt), int_ch evaluates to 0.

Because the while loop is skipped, the handler will not clear REG_INT_STA
and returns IRQ_NONE. Since the interrupt is level-triggered, the uncleared
interrupt will immediately re-fire, causing an infinite loop until the
kernel disables the IRQ line.

> +		spin_lock(&dmac->lock);
> +		dmac->used_chan =3D READ_ONCE(dmac->used_chan) & ~int_ch;
> +		spin_unlock(&dmac->lock);
> +		regmap_write(dmac->regmap, REG_INT_STA, DMA_INT_CLR(int_ch));
[ ... ]
> +static struct dma_async_tx_descriptor *
> +atcdmac_prep_dma_memcpy(struct dma_chan *chan,
> +			dma_addr_t dst,
> +			dma_addr_t src,
> +			size_t len,
> +			unsigned long flags)
> +{
[ ... ]
> +	ctrl =3D SRC_BURST_SIZE(src_max_burst) |
> +	       SRC_ADDR_MODE_INCR |
> +	       DST_ADDR_MODE_INCR |
> +	       DST_WIDTH(dst_width) |
> +	       SRC_WIDTH(src_width);
> +
> +	desc =3D atcdmac_build_desc(dmac_chan, src, dst, ctrl,
> +				  len >> src_width, 1);

[Severity: Medium]
Could the truncation of size_t len lead to incomplete DMA transfers on 64-b=
it
platforms?

Here, the 64-bit size_t len is shifted and passed as an unsigned int into
atcdmac_build_desc(). If a user requests a transfer length such that
len >> src_width exceeds 32 bits, the value will be silently truncated. The
DMA hardware would perform a shorter transfer but report success, leading to
silent data corruption. Is there a way to safely bound or reject overly lar=
ge
sizes?

> +	if (!desc)
> +		goto err_desc_get;
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

[Severity: Medium]
Does this check incorrectly reject valid, standard unidirectional
configurations?

Standard DMA engine consumers populate only the dma_slave_config fields
corresponding to their active transfer direction, leaving fields for the
unused direction as 0.

Because is_power_of_2(0) returns false, this strict global validation rejec=
ts
perfectly valid setups with -EINVAL, forcing clients to provide dummy
parameters for unused directions. Could the validation be limited to the
active transfer direction?

> +
> +	memcpy(&dmac_chan->dma_sconfig, sconfig, sizeof(*sconfig));
[ ... ]
> +static void atcdmac_init_dma_device(struct platform_device *pdev,
> +				    struct atcdmac_dmac *dmac)
> +{
> +	struct dma_device *device =3D &dmac->dma_device;
> +
> +	device->device_alloc_chan_resources =3D atcdmac_alloc_chan_resources;
> +	device->device_free_chan_resources =3D atcdmac_free_chan_resources;
> +	device->device_tx_status =3D atcdmac_get_tx_status;
> +	device->device_issue_pending =3D atcdmac_issue_pending;
> +	device->device_prep_dma_memcpy =3D atcdmac_prep_dma_memcpy;
> +	device->device_prep_slave_sg =3D atcdmac_prep_device_sg;
> +	device->device_config =3D atcdmac_set_device_config;
> +	device->device_terminate_all =3D atcdmac_terminate_all;
> +	device->device_prep_dma_cyclic =3D atcdmac_prep_dma_cyclic;

[Severity: High]
Is the device_synchronize callback missing from this list?

The driver processes completions and invokes client callbacks in a threaded
IRQ handler (atcdmac_advance_work). Clients rely on
dmaengine_terminate_sync() to ensure all transfers are aborted and no
callbacks are executing before freeing resources.

Without a device_synchronize callback, dmaengine_terminate_sync() fails to
wait for the threaded IRQ. If a client unloads immediately after calling it,
the IRQ thread may still be executing the client's callback, triggering a
use-after-free or executing unloaded module code.

> +
> +	device->dev =3D &pdev->dev;
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

[Severity: Medium]
Does registering the device before fully initializing it expose the driver
to use-after-free or race conditions?

Here, dma_async_device_register() is called before atcdmac_init_irq() and
atcdmac_init_iocp(). Once registered, the device is globally visible and
clients can acquire channels and submit transfers before the IRQ handler or
cache consistency parameters are fully set up.

If the subsequent initialization steps fail, dmac is freed while a client m=
ay
be holding a channel reference. Symmetrically, in atcdmac_remove(), the
driver resets the hardware before calling dma_async_device_unregister(),
meaning active clients may submit new transfers that the now-reset hardware
will attempt to execute. Should registration happen at the very end of prob=
e?

> +	if (ret)
> +		goto err_dma_async_register;
> +
> +	ret =3D atcdmac_init_iocp(pdev, dmac);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610095724.1980=
622-1-cl634@andestech.com?part=3D2

