Return-Path: <dmaengine+bounces-10340-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EgFA1LFAmp7wQEAu9opvQ
	(envelope-from <dmaengine+bounces-10340-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 08:14:42 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A7151ACAF
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 08:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B6789322CC26
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 05:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87163CFF41;
	Tue, 12 May 2026 05:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UTUxUrUC"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7C63D7D87;
	Tue, 12 May 2026 05:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778564969; cv=none; b=SdAKICfTJJM79IeNR5y7MxUGDVmq/Ltz4oYRH4jhOaoLRQm3XEfPROkwqY2on9sExCO7HbedRQZhOKmjVv9Kh9aXikxyqoePJEk8RoJtFKUWIVXFcV2hDwr/lPOXflfx2eOqC4MYydWVW2FBaWG4DZFVm9E4kL/6MUOuzNq8+Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778564969; c=relaxed/simple;
	bh=Q65TO1rQfRL6O7q8oidi7Dfsx4Yk8cOPu4mQ582VQbM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=H8H66QVFof6AozHQXzZgx3guGvT6lbMj4hmYPmRWGZ+OIQajQ85oMgrQAECwhhOdqDJm9Sqw4esDE+kC1X4g+r6JLi2870zCrNOOb8wxGRB5wOstsjVUemKnL0SZNB0eUHT9pp5Zbp7A83jFQKepi8Jca0nG422luvl60MPAxEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UTUxUrUC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE1FFC2BCB0;
	Tue, 12 May 2026 05:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778564968;
	bh=Q65TO1rQfRL6O7q8oidi7Dfsx4Yk8cOPu4mQ582VQbM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=UTUxUrUCAowt/CBaPTnuAyKqfjEWpuQ/8ffhMublkcGj3xsELLcTaOfWo4Umqhs8V
	 +/f//v95aeZ5bpaUzbnMdQObZvNtZvi9oDG21yIPZgPVlv82RwYqJcRk53obyUXwfd
	 pYrQ8Lt/Ix25p+4AGBhtgaTuH0/adCDjUQdwSNkhw1S61FxrrtojLzatpKe5gJrocq
	 kt6DZr/4ePTB1U30qIOWYUn12fprCJc9/XAynmc9t11f+CF7VeaGdQ/VxVWIsyP8sn
	 bRw+/RL6BVq3sIkyx3QkizC9nku+ITQOyYuXhRecUWUn0dMA0+wk3tWtlkarrG9e3D
	 SuHP6y+86zl+g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] dmaengine: fsl-edma: Support dynamic
 scatter/gather chaining
Reply-To: sashiko@lists.linux.dev
To: =?utf-8?b?QmVub8OudCBNb25pbg==?= <benoit.monin@bootlin.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org, imx@lists.linux.dev
In-Reply-To: <20260511-fsl-edma-dyn-sg-v3-2-98a181775dae@bootlin.com>
References: <20260511-fsl-edma-dyn-sg-v3-2-98a181775dae@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 12 May 2026 05:49:27 +0000
Message-Id: <20260512054927.CE1FFC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 78A7151ACAF
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lists.linux.dev:replyto,bootlin.com:email];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10340-lists,dmaengine=lfdr.de];
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
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko@lists.linux.dev]
X-Rspamd-Action: no action

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Critical] Hardware executes dynamically linked descriptors before issue_=
pending() is called, causing missed interrupts and double execution.
- [Critical] TOCTOU race condition with the channel DONE bit in the interru=
pt handler causes double execution of chained descriptors.
- [High] Incorrect list check order in fsl_edma_link_sg() drops intermediat=
e descriptors from the hardware scatter-gather chain.
- [High] Clearing the channel DONE bit during dynamic linking causes a perm=
anent DMA channel stall.
- [High] Missing memory barrier when updating in-memory scatter-gather link=
s risks torn hardware reads and system bus errors.
--

commit 09e7fbe06b869eaaa82c7821bd60464f115cd6b5
Author: Beno=C3=AEt Monin <benoit.monin@bootlin.com>

dmaengine: fsl-edma: Support dynamic scatter/gather chaining

This commit implements dynamic linking of scatter/gather transfers to enable
chaining multiple DMA descriptors without stopping the channel. It adds
fsl_edma_link_sg() which is called during tx_submit() to link the new
descriptor to the previously submitted one.

> diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
> index c10190164926a..b83d1b91dca2b 100644
> --- a/drivers/dma/fsl-edma-common.c
> +++ b/drivers/dma/fsl-edma-common.c
> @@ -58,7 +58,10 @@ void fsl_edma_tx_chan_handler(struct fsl_edma_chan *fs=
l_chan)
>  		list_del(&fsl_chan->edesc->vdesc.node);
>  		vchan_cookie_complete(&fsl_chan->edesc->vdesc);
>  		fsl_chan->edesc =3D NULL;
> -		fsl_chan->status =3D DMA_COMPLETE;
> +		if (!(fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_SPLIT_REG) ||
> +		    (edma_readl_chreg(fsl_chan, ch_csr) & EDMA_V3_CH_CSR_DONE)) {
> +			fsl_chan->status =3D DMA_COMPLETE;
> +		}

If the hardware dynamically chains from descriptor A to descriptor B, it
still raises an interrupt for A. If the CPU is delayed and the hardware
finishes executing B and halts, setting the DONE bit, won't the ISR for A
see the DONE bit set here, set the status to DMA_COMPLETE, and then later
explicitly re-enable the channel to execute B again, causing memory
corruption?

>  	} else {
>  		vchan_cyclic_callback(&fsl_chan->edesc->vdesc);
>  	}

[ ... ]

> @@ -673,6 +676,68 @@ struct dma_async_tx_descriptor *fsl_edma_prep_dma_cy=
clic(
>  	return vchan_tx_prep(&fsl_chan->vchan, &fsl_desc->vdesc, flags);
>  }
> =20
> +static void fsl_edma_link_sg(struct fsl_edma_chan *fsl_chan, struct fsl_=
edma_desc *fsl_desc)
> +{
> +	u32 flags =3D fsl_edma_drvflags(fsl_chan);
> +	struct fsl_edma_hw_tcd *last_tcd;
> +	struct fsl_edma_desc *prev_desc;
> +	struct virt_dma_desc *vdesc;
> +	u16 csr;
> +
> +	lockdep_assert_held(&fsl_chan->vchan.lock);
> +
> +	if (!(flags & FSL_EDMA_DRV_SPLIT_REG))
> +		return;
> +
> +	vdesc =3D list_last_entry_or_null(&fsl_chan->vchan.desc_issued,
> +					struct virt_dma_desc, node);
> +	if (!vdesc)
> +		vdesc =3D list_last_entry_or_null(&fsl_chan->vchan.desc_submitted,
> +						struct virt_dma_desc, node);

If desc_issued is not empty but there are also descriptors in
desc_submitted, this will link against the tail of desc_issued instead of
the newest descriptor at the tail of desc_submitted. Will this cause the
hardware to skip intermediate submissions and corrupt the transfer sequence?

> +	if (!vdesc)
> +		return;
> +
> +	prev_desc =3D to_fsl_edma_desc(vdesc);
> +	last_tcd =3D prev_desc->tcd[prev_desc->n_tcds - 1].vtcd;
> +
> +	csr =3D fsl_edma_get_tcd_to_cpu(fsl_chan, last_tcd, csr);
> +	if (!(csr & EDMA_TCD_CSR_D_REQ))
> +		return;
> +
> +	fsl_edma_set_tcd_to_le(fsl_chan, last_tcd, fsl_desc->tcd[0].ptcd, dlast=
_sga);
> +
> +	csr &=3D ~EDMA_TCD_CSR_D_REQ;
> +	csr |=3D EDMA_TCD_CSR_E_SG;
> +	fsl_edma_set_tcd_to_le(fsl_chan, last_tcd, csr, csr);

Is a write memory barrier like dma_wmb() needed between updating dlast_sga
and setting the E_SG bit in the csr? If the CPU or compiler reorders these
writes, could the actively running eDMA controller observe the E_SG bit set
with a stale dlast_sga pointer and trigger a bus error?

> +
> +	if (prev_desc =3D=3D fsl_chan->edesc && prev_desc->n_tcds =3D=3D 1) {
> +		if (flags & FSL_EDMA_DRV_CLEAR_DONE_E_SG)
> +			edma_writel_chreg(fsl_chan, edma_readl_chreg(fsl_chan, ch_csr), ch_cs=
r);

If the hardware has just finished executing the transfer and halted before
this register access, the DONE bit is already set. Writing it back clears
it. Will the subsequent completion interrupt ISR then wrongly assume the
channel chained successfully, leaving the state as DMA_IN_PROGRESS and
causing a permanent channel stall?

> +
> +		edma_cp_tcd_to_reg(fsl_chan, last_tcd, dlast_sga);
> +		edma_cp_tcd_to_reg(fsl_chan, last_tcd, csr);
> +	}
> +
> +	trace_edma_link_sg(fsl_chan, last_tcd);
> +}
> +
> +static dma_cookie_t fsl_edma_tx_submit(struct dma_async_tx_descriptor *t=
x)
> +{
> +	struct virt_dma_desc *vd =3D container_of(tx, struct virt_dma_desc, tx);
> +	struct fsl_edma_chan *fsl_chan =3D to_fsl_edma_chan(tx->chan);
> +	struct fsl_edma_desc *fsl_desc =3D to_fsl_edma_desc(vd);
> +	struct virt_dma_chan *vc =3D to_virt_chan(tx->chan);
> +	dma_cookie_t cookie;
> +
> +	guard(spinlock_irqsave)(&fsl_chan->vchan.lock);
> +
> +	fsl_edma_link_sg(fsl_chan, fsl_desc);

By dynamically chaining the new descriptor to the currently running hardware
here, the hardware could start executing it before dma_async_issue_pending()
is called.

If the hardware completes the new descriptor while it is still in the
desc_submitted list, could the interrupt handler ignore its completion
because it only processes desc_issued?

If so, would this result in double execution later when issue_pending() is
finally called and the software explicitly restarts the already-completed
descriptor?

> +	cookie =3D dma_cookie_assign(tx);
> +	list_move_tail(&vd->node, &vc->desc_submitted);
> +
> +	return cookie;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511-fsl-edma-d=
yn-sg-v3-0-98a181775dae@bootlin.com?part=3D2

