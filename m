Return-Path: <dmaengine+bounces-10449-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qF29LesBBWquRQIAu9opvQ
	(envelope-from <dmaengine+bounces-10449-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2026 00:57:47 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F37253BB0D
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2026 00:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86822301A728
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 22:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30BE39D6D5;
	Wed, 13 May 2026 22:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQJK+alR"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD69368D6F;
	Wed, 13 May 2026 22:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778713064; cv=none; b=Nks4MWk6l55dW3/H+Nmr17qQ48axctxoI0NpMkAxD7+aRz91RXd1be84PUp7DyYEdPgqL/OlLYGu0o/UJBcljCoCGYpmTHwiJK1Fq1xE5G8er9xI39NPFh3tdNo2q5Twah4dkCzYQ5L7l3tU9mKk1MFLo3pdlnl7uaIlMvhPe4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778713064; c=relaxed/simple;
	bh=hn1ufHJNer1+BXEOt149g4gUgb/8kDZ33kbm+jZalhg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=q63V/mRxH4ny2K4kXezXSQPeEDdJivOHKqj/5yfrBa3bG+2ZD3Nfd0N3yBkwxxdLuTjQNhPxkeNTCdUyOyzZ3rBsuizpzj9u9Xwp5iJQJ2Vg40ZIw4ZBGhSpPIwf0/SE/bMLlbdLYH0cJMQGPNwCjl8OyINkHcYdg3mma/ynXgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQJK+alR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E6F5C19425;
	Wed, 13 May 2026 22:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778713064;
	bh=hn1ufHJNer1+BXEOt149g4gUgb/8kDZ33kbm+jZalhg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=IQJK+alRQZyyiHertMkJXSkx+ECYmUOorQ9e8Nup3srwsI+T5J88S6Y+ubBXUGxqZ
	 pT7OkVIgtuvE/0iaxyOvZB+cM/d+mQX+m0kgAF/o6BZuXwUTTU11J8B0KuML9J4zAC
	 t8ljLyshtftR98fo8nSb9+rNaRooGWPHQ7mGSnKjODD6DfiumYfIke6ehzDgJZ1HM/
	 kcFqFkavI4qCSkclkNL+cuNIcJxMePmAIPH+MZ4aY5az6gJQ6c90QEFCMAmWYIeuQu
	 2Luy+iIpsY5wDP/zu7wH1ygwl77TrWbzBO8B5bTf5TtOslEX+4JfOJx6P5zpYORMoQ
	 b6/2bnYY9MPSQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 23/23] dmaengine: sdxi: Add DMA engine provider
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Lynch via B4 Relay" <devnull+nathan.lynch.amd.com@kernel.org>
Cc: Frank.Li@kernel.org, dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, vkoul@kernel.org
In-Reply-To: <20260511-sdxi-base-v2-23-889cfed17e3f@amd.com>
References: <20260511-sdxi-base-v2-23-889cfed17e3f@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 22:57:43 +0000
Message-Id: <20260513225744.2E6F5C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 0F37253BB0D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10449-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,nathan.lynch.amd.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Action: no action

Thank you for your contribution! Sashiko AI review found 13 potential issue=
(s) to consider:
- [Critical] Out-of-bounds array initialization due to TOCTOU on dma_channe=
ls module parameter.
- [Critical] DMA Use-After-Free (Memory Corruption) when sdxi_completion_po=
ll times out.
- [High] Unhandled negative error code from sdxi_alloc_akey is cast to a po=
sitive IRQ number, causing a silent failure.
- [High] Hardware ring stalls permanently if prepared descriptors are freed=
 before submission.
- [High] sdxi_dma_terminate_all fails to abort active transfers, causing Us=
e-After-Free on target buffers.
- [High] Silent early return on allocation failure in sdxi_stop_cxt leads t=
o DMA Use-After-Free.
- [High] Out-of-order completion in sdxi_tx_status breaks completed_cookie =
monotonicity and leaks descriptors.
- [High] Unhandled DMA transfer errors in sdxi_dma_cxt_irq lead to silent d=
ata corruption.
- [High] Misplaced read memory barrier in sdxi_completion_signaled risks da=
ta corruption.
- [High] Missing tasklet_kill() during channel teardown leads to Use-After-=
Free of the virt-dma tasklet.
- [Medium] sdxi_dma_terminate_all leaks descriptors by moving them to the u=
nswept desc_terminated list.
- [Medium] sdxi_dma_synchronize fails to flush tasklets on error paths.
- [Medium] umax() incorrectly evaluates wrapping hardware doorbell indices =
in sdxi_dma_issue_pending.
--

commit 17b81cc17c9b5c350d13ff97f58dfc2cf02880d1
Author: Nathan Lynch <nathan.lynch@amd.com>
Subject: dmaengine: sdxi: Add DMA engine provider

This commit adds a DMA engine provider for the Smart Data Accelerator Inter=
face
(SDXI). It registers a memory-to-memory DMA device supporting interrupt and
polled completion modes.

> diff --git a/drivers/dma/sdxi/dma.c b/drivers/dma/sdxi/dma.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/dma/sdxi/dma.c

[ ... ]

> +static void sdxi_tx_desc_free(struct virt_dma_desc *vdesc)
> +{
> +	struct sdxi_dma_desc *sddesc =3D to_sdxi_dma_desc(vdesc);
> +
> +	sdxi_completion_free(sddesc->completion);
> +	kfree(to_sdxi_dma_desc(vdesc));
> +}

If a client frees a prepared descriptor before submitting it, does
sdxi_tx_desc_free() fail to write valid NOPs to the abandoned hardware ring
slots? If the slots are left with their valid bits cleared, will the hardwa=
re
permanently stall when it reaches them?

[ ... ]

> +static enum dma_status sdxi_tx_status(struct dma_chan *chan,
> +				      dma_cookie_t cookie,
> +				      struct dma_tx_state *state)
> +{
> +	struct sdxi_dma_chan *sdchan =3D to_sdxi_dma_chan(chan);
> +	struct sdxi_dma_desc *sddesc;
> +	enum dma_status status;
> +	struct virt_dma_desc *vdesc;
> +
> +	status =3D dma_cookie_status(chan, cookie, state);
> +	if (status =3D=3D DMA_COMPLETE)
> +		return status;
> +
> +	guard(spinlock_irqsave)(&sdchan->vchan.lock);
> +
> +	vdesc =3D vchan_find_desc(&sdchan->vchan, cookie);
> +	if (!vdesc)
> +		return status;
> +
> +	sddesc =3D to_sdxi_dma_desc(vdesc);
> +
> +	if (WARN_ON_ONCE(!sddesc->completion))
> +		return DMA_ERROR;
> +
> +	if (!sdxi_completion_signaled(sddesc->completion))
> +		return DMA_IN_PROGRESS;
> +
> +	if (sdxi_completion_errored(sddesc->completion))
> +		return DMA_ERROR;
> +
> +	list_del(&vdesc->node);
> +	vchan_cookie_complete(vdesc);

If a newer descriptor is polled and completed before an older unpolled
descriptor, does calling vchan_cookie_complete() set completed_cookie forwa=
rd
and break DMA engine monotonicity? Would unpolled descriptors preceding the
polled one permanently leak in the desc_issued list?

> +
> +	return dma_cookie_status(chan, cookie, state);
> +}
> +
> +static void sdxi_dma_issue_pending(struct dma_chan *dma_chan)
> +{
> +	struct virt_dma_chan *vchan =3D to_virt_chan(dma_chan);
> +	struct virt_dma_desc *vdesc;
> +	u64 dbval =3D 0;
> +
> +	scoped_guard(spinlock_irqsave, &vchan->lock) {
> +		/*
> +		 * This can happen with racing submitters.
> +		 */
> +		if (list_empty(&vchan->desc_submitted))
> +			return;
> +
> +		list_for_each_entry(vdesc, &vchan->desc_submitted, node) {
> +			struct sdxi_dma_desc *sddesc =3D to_sdxi_dma_desc(vdesc);
> +			struct sdxi_desc *hwdesc;
> +
> +			sdxi_ring_resv_foreach(&sddesc->resv, hwdesc)
> +				sdxi_desc_make_valid(hwdesc);
> +			/*
> +			 * The reservations ought to be ordered
> +			 * ascending, but use umax() just in case.
> +			 */
> +			dbval =3D umax(sdxi_ring_resv_dbval(&sddesc->resv), dbval);

If the underlying ring index wraps around (e.g., from capacity - 1 to 0), d=
oes
umax() erroneously retain the older, larger index instead of taking the new=
er
wrapped index? Would this point the hardware doorbell backward and cause the
channel to stall?

> +		}
> +
> +		vchan_issue_pending(vchan);
> +	}
> +
> +	/*
> +	 * The implementation is required to handle out-of-order
> +	 * doorbell updates; we can do this after dropping the
> +	 * lock.
> +	 */
> +	sdxi_cxt_push_doorbell(to_sdxi_dma_chan(dma_chan)->cxt, dbval);
> +}
> +
> +static int sdxi_dma_terminate_all(struct dma_chan *dma_chan)
> +{
> +	struct virt_dma_chan *vchan =3D to_virt_chan(dma_chan);
> +	u64 dbval =3D 0;
> +
> +	/*
> +	 * Allocated and submitted txds are in the ring but not valid
> +	 * yet. Overwrite them with nops and then set their valid
> +	 * bits.
> +	 *
> +	 * The implementation may start consuming these as soon as the
> +	 * valid bits flip. sdxi_dma_synchronize() will ensure they're
> +	 * all done.
> +	 */
> +	scoped_guard(spinlock_irqsave, &vchan->lock) {
> +		struct virt_dma_desc *vdesc;
> +		LIST_HEAD(head);
> +
> +		list_splice_tail_init(&vchan->desc_allocated, &head);
> +		list_splice_tail_init(&vchan->desc_submitted, &head);

Should sdxi_dma_terminate_all() also abort transfers in the desc_issued lis=
t?
By only addressing allocated and submitted descriptors, does this leave act=
ive
hardware transfers running in the background?

> +
> +		if (list_empty(&head))
> +			return 0;
> +
> +		list_for_each_entry(vdesc, &head, node) {
> +			struct sdxi_dma_desc *sddesc =3D to_sdxi_dma_desc(vdesc);
> +			struct sdxi_desc *hwdesc;
> +
> +			sdxi_ring_resv_foreach(&sddesc->resv, hwdesc) {
> +				sdxi_serialize_nop(hwdesc);
> +				sdxi_desc_make_valid(hwdesc);
> +			}
> +
> +			dbval =3D umax(sdxi_ring_resv_dbval(&sddesc->resv), dbval);

Does umax() here also suffer from the same ring index wrapping issue as in
sdxi_dma_issue_pending()?

> +		}
> +
> +		list_splice_tail(&head, &vchan->desc_terminated);

Does moving the descriptors to desc_terminated without sweeping them result=
 in
a memory leak if a client repeatedly calls dmaengine_terminate_all() during
the channel's active lifetime?

> +	}
> +
> +	sdxi_cxt_push_doorbell(to_sdxi_dma_chan(dma_chan)->cxt, dbval);
> +
> +	return 0;
> +}
> +
> +static void sdxi_dma_synchronize(struct dma_chan *dma_chan)
> +{
> +	struct sdxi_cxt *cxt =3D to_sdxi_dma_chan(dma_chan)->cxt;
> +	struct sdxi_ring_resv resv;
> +	struct sdxi_desc *nop;
> +	int err;
> +
> +	/* Submit a single nop with fence and wait for it to complete. */
> +
> +	if (sdxi_ring_reserve(cxt->ring_state, 1, &resv))
> +		return;
> +
> +	struct sdxi_completion *comp __free(sdxi_completion) =3D sdxi_completio=
n_alloc(cxt->sdxi);
> +	if (!comp)
> +		return;

If sdxi_ring_reserve() or sdxi_completion_alloc() fails, this returns early
without calling vchan_synchronize(). Does this violate the guarantee that a=
ll
callbacks have completed, allowing the client to prematurely free memory?

> +
> +	nop =3D sdxi_ring_resv_next(&resv);
> +	sdxi_serialize_nop(nop);
> +	sdxi_completion_attach(nop, comp);
> +	sdxi_desc_set_fence(nop);
> +	sdxi_desc_make_valid(nop);
> +	sdxi_cxt_push_doorbell(cxt, sdxi_ring_resv_dbval(&resv));
> +
> +	err =3D sdxi_completion_poll(comp);

If sdxi_completion_poll() reaches its timeout and returns, the
__free(sdxi_completion) cleanup frees the DMA-mapped status block. Does the
hardware descriptor remain in the ring? If the hardware eventually processes
the descriptor, will it write to the freed block?

> +	WARN_ONCE(err, "got %d polling cst_blk", err);
> +
> +	vchan_synchronize(to_virt_chan(dma_chan));
> +}
> +
> +static irqreturn_t sdxi_dma_cxt_irq(int irq, void *data)
> +{
> +	struct sdxi_dma_chan *sdchan =3D data;
> +	struct virt_dma_chan *vchan =3D &sdchan->vchan;
> +	struct virt_dma_desc *vdesc;
> +	bool completed =3D false;
> +
> +	guard(spinlock_irqsave)(&vchan->lock);
> +
> +	while ((vdesc =3D vchan_next_desc(vchan))) {
> +		struct sdxi_dma_desc *sddesc =3D to_sdxi_dma_desc(vdesc);
> +
> +		if (!sdxi_completion_signaled(sddesc->completion))
> +			break;

The interrupt handler appears to ignore the hardware error state exposed by
sdxi_completion_errored(). Are errored descriptors unconditionally completed
via vchan_cookie_complete(), potentially masking hardware faults?

Also, looking at sdxi_completion_signaled(), it places dma_rmb() before
checking the synchronization variable (sc->cst_blk->signal =3D=3D 0). Does =
this
misplaced barrier fail to order the signal read with subsequent data reads,
allowing stale data to be consumed by the client?

> +
> +		list_del(&vdesc->node);
> +		vchan_cookie_complete(&sddesc->vdesc);
> +		completed =3D true;
> +	}
> +
> +	if (completed)
> +		sdxi_ring_wake_up(sdchan->cxt->ring_state);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int sdxi_dma_alloc_chan_resources(struct dma_chan *dma_chan)
> +{
> +	struct sdxi_dev *sdxi =3D dev_get_drvdata(dma_chan->device->dev);
> +	struct sdxi_dma_chan *sdchan =3D to_sdxi_dma_chan(dma_chan);
> +	int vector, irq, err;
> +
> +	sdchan->cxt =3D sdxi_cxt_new(sdxi);
> +	if (!sdchan->cxt)
> +		return -ENOMEM;
> +	/*
> +	 * This irq and akey setup should perhaps all be pushed into
> +	 * the context allocation.
> +	 */
> +	err =3D vector =3D sdxi_alloc_vector(sdxi);
> +	if (vector < 0)
> +		goto exit_cxt;
> +
> +	sdchan->vector =3D vector;
> +
> +	err =3D irq =3D sdxi_vector_to_irq(sdxi, vector);
> +	if (irq < 0)
> +		goto free_vector;
> +
> +	sdchan->irq =3D irq;
> +
> +	/*
> +	 * Note this akey entry is used for both the completion
> +	 * interrupt and source and destination access for copies.
> +	 */
> +	sdchan->akey =3D sdxi_alloc_akey(sdchan->cxt);
> +	if (!sdchan->akey)
> +		goto free_vector;

If sdxi_alloc_akey() fails, does the function return the positive irq value=
 in
err? If the DMA engine core considers alloc_chan_resources returning >=3D 0=
 as
a success, would this cause a silent allocation failure?

> +
> +	*sdchan->akey =3D (typeof(*sdchan->akey)) {
> +		.intr_num =3D cpu_to_le16(FIELD_PREP(SDXI_AKEY_ENT_VL, 1) |
> +					FIELD_PREP(SDXI_AKEY_ENT_IV, 1) |
> +					FIELD_PREP(SDXI_AKEY_ENT_INTR_NUM,
> +						   vector)),
> +	};
> +
> +	err =3D request_irq(sdchan->irq, sdxi_dma_cxt_irq,
> +			  IRQF_TRIGGER_NONE, "SDXI DMAengine", sdchan);
> +	if (err)
> +		goto free_akey;
> +
> +	err =3D sdxi_start_cxt(sdchan->cxt);

If sdxi_start_cxt() calls sdxi_completion_poll() and that reaches its timeo=
ut,
could it similarly leave a hardware descriptor running that will later writ=
e to
the freed status block?

> +	if (err)
> +		goto free_irq;
> +
> +	return 0;
> +free_irq:
> +	free_irq(sdchan->irq, sdchan);
> +free_akey:
> +	sdxi_free_akey(sdchan->cxt, sdchan->akey);
> +free_vector:
> +	sdxi_free_vector(sdxi, vector);
> +exit_cxt:
> +	sdxi_cxt_exit(sdchan->cxt);
> +	return err;
> +}
> +
> +static void sdxi_dma_free_chan_resources(struct dma_chan *dma_chan)
> +{
> +	struct sdxi_dma_chan *sdchan =3D to_sdxi_dma_chan(dma_chan);
> +
> +	sdxi_stop_cxt(sdchan->cxt);

If sdxi_stop_cxt() aborts early (e.g. due to sdxi_completion_alloc() return=
ing
NULL), does it fail to actually stop the hardware context? When the teardown
then proceeds to free the context and its DMA ring buffers via
sdxi_cxt_exit(), will the running hardware corrupt the freed context memory?

> +	free_irq(sdchan->irq, sdchan);
> +	sdxi_free_vector(sdchan->cxt->sdxi, sdchan->vector);
> +	sdxi_free_akey(sdchan->cxt, sdchan->akey);
> +	vchan_free_chan_resources(to_virt_chan(dma_chan));

Does sdxi_dma_free_chan_resources() miss a call to
tasklet_kill(&sdchan->vchan.task)? If the virt-dma tasklet is scheduled just
before the IRQ is freed, could it run asynchronously after the device is
unbound?

> +	sdxi_cxt_exit(sdchan->cxt);
> +}
> +
> +int sdxi_dma_register(struct sdxi_dev *sdxi)
> +{
> +	struct device *dev =3D sdxi->dev;
> +	struct sdxi_dma_dev *sddev;
> +	struct dma_device *dma_dev;
> +	int err;
> +
> +	if (!dma_channels)
> +		return 0;
> +	/*
> +	 * Note that this code assumes the device supports the
> +	 * interrupt operation group (IntrGrp), which is optional. See
> +	 * SDXI 1.0 Table 6-1 SDXI Operation Groups.
> +	 *
> +	 * TODO: check sdxi->op_grp_cap for IntrGrp support and error
> +	 * out if it's missing.
> +	 */
> +
> +	sddev =3D devm_kzalloc(dev, struct_size(sddev, sdchan, dma_channels),
> +			     GFP_KERNEL);
> +	if (!sddev)
> +		return -ENOMEM;
> +
> +	sddev->nr_channels =3D dma_channels;

Could dma_channels be modified concurrently via sysfs between the struct_si=
ze
calculation and this assignment? If so, does the subsequent initialization =
loop
write past the allocated bounds?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511-sdxi-base-=
v2-0-889cfed17e3f@amd.com?part=3D23

