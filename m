Return-Path: <dmaengine+bounces-10369-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEIuNftNA2pq3AEAu9opvQ
	(envelope-from <dmaengine+bounces-10369-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 17:57:47 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DC047524346
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 17:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9FEC63001CC4
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 15:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55DD3BB661;
	Tue, 12 May 2026 15:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="b150Oe6o"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDC32D7DEA;
	Tue, 12 May 2026 15:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778601012; cv=none; b=pmm7RfnjyNh1yuQFmlztV0rIHI+CoZiJjWKXgVGF97g1GckcQs28Gg23S1k2s117Qp1URuSfJYjcuNhNepc0nYWo/eVKYrLhPTPkI/cwkGf+fUxEHYhMEIkEqPywy44cUPRLj7QSb1GMWtqf8n1Y6RWSiwDcutZGoK5MEKa8m5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778601012; c=relaxed/simple;
	bh=ghAzNXjcOg3CcSpezIn+HV12JVV2N54z1fBcE+a4oVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=txrnHpS1efRrEppxHol3w7WU6uFteyFz7v+GcWi4XwyHr6HVZBu4gHOyrY5FdqIGqu/MhBJNmCVb4mz+wZd+5K5KCx0OG5KfDaG/I56+ael7aVgVe83Fjq/RTCs5yNv6hhV1CHUEiDwdqO/oABVkjeY31P9n44XJIg9MT7fzOig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=b150Oe6o; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 59EB34E42C00;
	Tue, 12 May 2026 15:50:09 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 25C1A60646;
	Tue, 12 May 2026 15:50:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6488211AF8D37;
	Tue, 12 May 2026 17:50:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778601008; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=5qb1+45jPjsQXuMCQGSSy81a0HXA2hwtFwzTyRTb4S8=;
	b=b150Oe6o6PDjMjplkjK5ycX0bAQZhrN5pksHh/NGtajwOnb8xcdaJyrxfD68cMtmznKDng
	gyY0zyQ4zHiVFYwS/K204QAsTAIsrSA+3tE/86aMiPhZD0/GF2F1H6TgqRrXFtGajFl53E
	kbGL/pikFfggGnHbWNVY32SAYnpVxfC0uHWvrCFQZnuM9fkXoad0mccdFTCq1SV0wPfnvz
	hFgjT6hpSOtm6hxiB0TveQ+6H+GAtDcrVIgVmgaC0gjP2V3DX6COpE+0dQPRhY02HhnhE/
	M5LD+s6/9peU9iuzyUcygHXprYrZtahg7VHRD/ywBXUVOzZli9c8H3Kf8Ai6ag==
From: =?UTF-8?B?QmVub8OudA==?= Monin <benoit.monin@bootlin.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Frank Li <Frank.Li@kernel.org>, imx@lists.linux.dev,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v3 2/2] dmaengine: fsl-edma: Support dynamic scatter/gather
 chaining
Date: Tue, 12 May 2026 17:50:06 +0200
Message-ID: <Unndqc1KRZGMMQbK0XrAyw@bootlin.com>
In-Reply-To: <agIr7wqV3jIFp-dC@lizhi-Precision-Tower-5810>
References:
 <20260511-fsl-edma-dyn-sg-v3-0-98a181775dae@bootlin.com>
 <20260511-fsl-edma-dyn-sg-v3-2-98a181775dae@bootlin.com>
 <agIr7wqV3jIFp-dC@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: DC047524346
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10369-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benoit.monin@bootlin.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,bootlin.com:mid,bootlin.com:url,bootlin.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Monday, 11 May 2026 at 21:20:15 CEST, Frank Li wrote:
> On Mon, May 11, 2026 at 03:57:20PM +0200, Beno=C3=AEt Monin wrote:
> > Implement dynamic linking of scatter/gather transfers to enable
> > chaining multiple DMA descriptors without stopping the channel.
> > This avoids waiting for the channel to go idle if there is another
> > transaction already issued.
> >
> > Add fsl_edma_link_sg() to dynamically link the last TCD of a previously
> > submitted descriptor to the first TCD of a new descriptor by setting
> > the scatter/gather address and the E_SG flag, and keeping the channel
> > active by clearing the DREQ bit.
> >
> > Linking is done when the transaction is submitted by fsl_edma_tx_submit=
().
> > To do so, the .tx_submit() callback is overridden for non-cyclic
> > transactions prepared by fsl_edma_prep_peripheral_dma_vec() and
> > fsl_edma_prep_slave_sg(). This ensures that transactions are linked
> > in the order they are submitted.
> >
> > Update fsl_edma_xfer_desc() to avoid re-initializing the hardware when a
> > transfer is already in progress, allowing seamless chaining of descript=
ors.
> >
> > Modify the transfer completion handler to check the DONE flag in the
> > channel CSR before marking the transfer complete. Since this flag is
> > only available on SoC with the split registers layout, we only link
> > transactions for DMA controllers flagged with FSL_EDMA_DRV_SPLIT_REG.
> >
> > Add trace event for scatter/gather linking operations.
> >
> > Signed-off-by: Beno=C3=AEt Monin <benoit.monin@bootlin.com>
> > ---
> >  drivers/dma/fsl-edma-common.c | 90 +++++++++++++++++++++++++++++++++++=
++++----
> >  drivers/dma/fsl-edma-trace.h  |  5 +++
> >  2 files changed, 88 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-commo=
n.c
> > index c10190164926..b83d1b91dca2 100644
> > --- a/drivers/dma/fsl-edma-common.c
> > +++ b/drivers/dma/fsl-edma-common.c
> > @@ -58,7 +58,10 @@ void fsl_edma_tx_chan_handler(struct fsl_edma_chan *=
fsl_chan)
> >  		list_del(&fsl_chan->edesc->vdesc.node);
> >  		vchan_cookie_complete(&fsl_chan->edesc->vdesc);
> >  		fsl_chan->edesc =3D NULL;
> > -		fsl_chan->status =3D DMA_COMPLETE;
> > +		if (!(fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_SPLIT_REG) ||
> > +		    (edma_readl_chreg(fsl_chan, ch_csr) & EDMA_V3_CH_CSR_DONE)) {
> > +			fsl_chan->status =3D DMA_COMPLETE;
>=20
> Does fsl_edma_desc_residue() needs to update?
>=20
I don't think so. Computing the residue of one vdesc is not modified by the
fact that is it linked to another transaction.

> > +		}
> >  	} else {
> >  		vchan_cyclic_callback(&fsl_chan->edesc->vdesc);
> >  	}
> > @@ -673,6 +676,68 @@ struct dma_async_tx_descriptor *fsl_edma_prep_dma_=
cyclic(
> >  	return vchan_tx_prep(&fsl_chan->vchan, &fsl_desc->vdesc, flags);
> >  }
> >
> > +static void fsl_edma_link_sg(struct fsl_edma_chan *fsl_chan, struct fs=
l_edma_desc *fsl_desc)
> > +{
> > +	u32 flags =3D fsl_edma_drvflags(fsl_chan);
> > +	struct fsl_edma_hw_tcd *last_tcd;
> > +	struct fsl_edma_desc *prev_desc;
> > +	struct virt_dma_desc *vdesc;
> > +	u16 csr;
> > +
> > +	lockdep_assert_held(&fsl_chan->vchan.lock);
> > +
> > +	if (!(flags & FSL_EDMA_DRV_SPLIT_REG))
> > +		return;
> > +
> > +	vdesc =3D list_last_entry_or_null(&fsl_chan->vchan.desc_issued,
> > +					struct virt_dma_desc, node);
> > +	if (!vdesc)
> > +		vdesc =3D list_last_entry_or_null(&fsl_chan->vchan.desc_submitted,
> > +						struct virt_dma_desc, node);
> > +	if (!vdesc)
> > +		return;
>=20
> Suppose you only check submit queue,
>=20
> issue transfer will move submit queue to issue queue.
>=20
Right, It's the other way around. I should first look for the last submitted
entry, then check the issued list. Will fix.

Best regards,
=2D-=20
Beno=C3=AEt Monin, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com




