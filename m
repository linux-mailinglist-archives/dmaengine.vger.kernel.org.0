Return-Path: <dmaengine+bounces-10517-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6P4mCxAWC2o5/wQAu9opvQ
	(envelope-from <dmaengine+bounces-10517-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 18 May 2026 15:37:20 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A101356DBF9
	for <lists+dmaengine@lfdr.de>; Mon, 18 May 2026 15:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62977303A8DA
	for <lists+dmaengine@lfdr.de>; Mon, 18 May 2026 13:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6FF481AB9;
	Mon, 18 May 2026 13:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iW0Nh3+i"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA52F481AB3;
	Mon, 18 May 2026 13:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779111270; cv=none; b=OiK9uJAMy5hyifs5u+IlhrPazZB2498BXD398TbA0nUQUD2iu2Vx1RTQMfbeMX8RLK+3lkHW8AYPleX0lOCY4NfjGEmRnK1mm+KRAUQS1AP3KLZ+gNenP6l1kDW5uH3aJFioAx0Dr9efJwBPn/EzD4p78JCW+SIwAiRPV7MgAhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779111270; c=relaxed/simple;
	bh=C5ZNdV4rGhd86tahVs7o/fg39e4HnRxfK7iI1v/MnVI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AxxDn6W1C/VKKWE+pZurGA8WxQsXboqqLhUXpFM0Afn2aoY5fmS2vqjQxeH+HqaBbWcEE+Udq7exgqzPJXKd5XWVFAcR9o/2yORT7M4kQlF3k8WxFOpMbKX+fZPmYx2xLnfkko5sSOTeZJv/CiRgml5of/yJZ1ByirVe/8nkiz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iW0Nh3+i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 896ABC2BCC7;
	Mon, 18 May 2026 13:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779111270;
	bh=C5ZNdV4rGhd86tahVs7o/fg39e4HnRxfK7iI1v/MnVI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=iW0Nh3+il/v7D299IpegHB1K4NwtXyR9agGseN8IU+fVjhVAOhKbAOzECCSk+4yd+
	 dOT/Pe0Iql6MJnN9sQ88Uv3RA0xEEOlLSuRmS2PAMVKi9DywiN3HNvRnehkvjlkFah
	 4s5FjFzZxRKO3N87cSqBu3yUEAEE/wil/amaNbRQAOMed+alb+IwG7hU9Mxzqr2gBD
	 19OkbuSyGMZTFSgmdP+p38gA5qRhE+DVlhB2Y0rIjCWQ/v4PYCT6Wt9EbZNkO7wZto
	 BPyuB3NQLY04pbomELhXDOyh199QRrrhH+TIQKWm7Vbsi1aOzDfiOl9nRWnY1uIAjV
	 MhDFpH92Wi8SA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/2] dmaengine: fsl-edma: Support dynamic
 scatter/gather chaining
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QmVub8OudCBNb25pbg==?= <benoit.monin@bootlin.com>
Cc: dmaengine@vger.kernel.org, Frank.Li@kernel.org, vkoul@kernel.org, imx@lists.linux.dev
In-Reply-To: <20260518-fsl-edma-dyn-sg-v4-2-8ce7d95b1ce9@bootlin.com>
References: <20260518-fsl-edma-dyn-sg-v4-2-8ce7d95b1ce9@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 13:34:29 +0000
Message-Id: <20260518133429.896ABC2BCC7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10517-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Queue-Id: A101356DBF9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] Dynamically linking descriptors in the .tx_submit() callback c=
auses premature execution, lost interrupts, and permanent channel stalls.
- [Critical] Relying on the asynchronous hardware DONE flag in the completi=
on handler creates a race condition leading to double-execution of DMA tran=
sfers.
- [High] Clearing the hardware DONE bit during active descriptor linking ca=
uses a Time-of-Check to Time-of-Use (TOCTOU) race that permanently deadlock=
s the DMA channel.
- [High] Modifying scatter/gather fields of an active multi-TCD descriptor =
in coherent memory without a memory barrier causes fatal DMA bus errors.
--

commit c846f40d8bb27c4bedc449b94402c8b84f93b59c
Author: Beno=C3=AEt Monin <benoit.monin@bootlin.com>

dmaengine: fsl-edma: Support dynamic scatter/gather chaining

Implement dynamic linking of scatter/gather transfers to enable chaining
multiple DMA descriptors without stopping the channel.

> diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
> index c10190164926a..6e5820051f292 100644
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

Could this DONE flag check lead to a race condition where a chained DMA=20
transfer is executed twice?

If descriptor A is chained to descriptor B, and both A and B complete in=20
hardware before the CPU services A's completion interrupt, the hardware=20
will halt and set the DONE flag.

The interrupt handler for A would then see the DONE flag set, assume the=20
channel cleanly stopped after A, and set the status to DMA_COMPLETE. Later=
=20
in the same handler, fsl_edma_xfer_desc() will fetch descriptor B from the=
=20
virtual channel and, seeing the DMA_COMPLETE status, unconditionally write=
=20
B's TCD into the hardware and restart the channel, causing B to execute=20
a second time.

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
> +	vdesc =3D list_last_entry_or_null(&fsl_chan->vchan.desc_submitted,
> +					struct virt_dma_desc, node);
> +	if (!vdesc)
> +		vdesc =3D list_last_entry_or_null(&fsl_chan->vchan.desc_issued,
> +						struct virt_dma_desc, node);
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

Is a memory barrier needed between updating dlast_sga and updating the csr=
=20
to set EDMA_TCD_CSR_E_SG?

Since this descriptor is in DMA coherent memory and actively visible to the=
=20
hardware, the CPU or memory subsystem might reorder these writes. If the eD=
MA=20
engine fetches the TCD while E_SG is set but dlast_sga is still stale or=20
uninitialized, it might fetch the next descriptor from an invalid physical=
=20
address and trigger a fatal bus error.

> +
> +	if (prev_desc =3D=3D fsl_chan->edesc && prev_desc->n_tcds =3D=3D 1) {
> +		if (flags & FSL_EDMA_DRV_CLEAR_DONE_E_SG)
> +			edma_writel_chreg(fsl_chan, edma_readl_chreg(fsl_chan, ch_csr), ch_cs=
r);

Does this read and write-back of ch_csr introduce a race condition that can=
=20
deadlock the channel?

If the hardware transfer completes just before the channel lock is acquired=
,=20
the channel becomes idle and the DONE bit is set. The driver then implicitl=
y=20
clears the write-1-to-clear DONE bit and sets E_SG, but setting E_SG on an=
=20
already halted channel will not restart it.

When the delayed completion interrupt runs, it will read ch_csr, see that=20
DONE is 0, incorrectly assume the channel seamlessly continued, and leave=20
the status as DMA_IN_PROGRESS. This would prevent fsl_edma_xfer_desc() from
enabling the hardware request, leaving the channel stopped indefinitely.

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
> +	cookie =3D dma_cookie_assign(tx);
> +	list_move_tail(&vd->node, &vc->desc_submitted);
> +
> +	return cookie;
> +}

Can calling fsl_edma_link_sg() directly from the tx_submit callback lead to=
=20
premature execution and lost interrupts?

By modifying the active hardware TCD to link the new descriptor before the=
=20
client calls dma_async_issue_pending(), the hardware can transition to and=
=20
start executing the newly submitted descriptor automatically.

If the completion interrupt for the previous descriptor fires before=20
issue_pending() is called, vchan_next_desc() won't find the new descriptor=
=20
because it is still sitting in the desc_submitted list rather than the=20
desc_issued list.

This would leave fsl_chan->edesc as NULL, meaning when the new descriptor=20
finishes, its completion interrupt is dropped. When issue_pending() is=20
finally called, the channel may either permanently stall or mistakenly=20
restart the descriptor and execute it a second time.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518-fsl-edma-d=
yn-sg-v4-0-8ce7d95b1ce9@bootlin.com?part=3D2

