Return-Path: <dmaengine+bounces-11965-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GKYNKYdhRmokSQsAu9opvQ
	(envelope-from <dmaengine+bounces-11965-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 15:03:03 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B65E6F814F
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 15:03:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="B/xySY5/";
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11965-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11965-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 444F830241CB
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jul 2026 12:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8BB478E3A;
	Thu,  2 Jul 2026 12:45:54 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E3C425CC3;
	Thu,  2 Jul 2026 12:45:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782996354; cv=none; b=spKzK0sPo4Ia31SDb9TgjffukSXcB+I3xeRO6QODX+6JOJx9Acj6psVlbF3mFfW9ZoBfMiYCOBuNTKJBe+jhtBP29s+E9p6weJd5esjXHBYLCudnF/AjgMQQtUovK4ClKSDO66B4PRuGQn0nXvlskufMBx8LLUhGxmw+3gSgbqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782996354; c=relaxed/simple;
	bh=cn8Y1ibPkGUR8O5ahiyZ/NhHzrwNhd/VxLOpXMDUsRg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mgFKQdf76TUJaFBfhL7I82cC3d8xj2jMVHHqkx64pOknF9enR7CgaiJwwZBDt5BQ02NYVxxenPPdVNQel6FZCOH5pWj6ZUl6m6nUWaK3w4iDMGoCCJsSoR3L4Ipq0SGFXAZuwfnumAdhfwsYTvz7s6uc1D+TSpkXlmbwgU725o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/xySY5/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E52F1F000E9;
	Thu,  2 Jul 2026 12:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782996353;
	bh=xlPgKR4qhyCAdf2pCrG48OG54U+F2r6RBeSvAn4YoY8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B/xySY5/WH9G0pgmAkAfIXGpjDBr4LmPtdARW9wy10/HLWMMRhppJvlXIqWZNubci
	 HmFqWf6+shJJMYwhIPryLvWpCQHsi1zZiJ6QyXLcfDvi2SbdVJU+hWr7hmL3Q9Tkz9
	 PRm+TptTk3CSvovlYH7f5uXzkv9NIIr4BFsap9GPrL+VuM2NpPwXDkeIet0/LNYWdU
	 Y78MaRf1KndA+4B1XBt52JNab3P5vwCEVGcqtSQzquKr5LJERkesArYWI+LYcgzJAt
	 Ql5XztNkZo6INLFLDk9bkYjeRp2rYNDAQXPDGPp18uF/tOCphjb7UjBB8gWWjKmuXT
	 gaCmIV9CKP0JQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/2] dmaengine: fsl-edma: Support dynamic
 scatter/gather chaining
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QmVub8OudCBNb25pbg==?= <benoit.monin@bootlin.com>
Cc: Frank.Li@kernel.org, imx@lists.linux.dev, vkoul@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260702-fsl-edma-dyn-sg-v5-2-16787185be49@bootlin.com>
References: <20260702-fsl-edma-dyn-sg-v5-0-16787185be49@bootlin.com>
 <20260702-fsl-edma-dyn-sg-v5-2-16787185be49@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 12:45:52 +0000
Message-Id: <20260702124553.3E52F1F000E9@smtp.kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11965-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,smtp.kernel.org:mid,lists.linux.dev:replyto,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,bootlin.com:email];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:benoit.monin@bootlin.com,m:Frank.Li@kernel.org,m:imx@lists.linux.dev,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3B65E6F814F

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Double-execution of DMA descriptors due to state machine desyn=
c when interrupts coalesce.
- [Critical] Channel deadlock due to dynamic descriptor linking bypassing `=
issue_pending()`.
--

commit a67c20eb8f20e15fe2cadb092322588069fe328e
Author: Beno=C3=AEt Monin <benoit.monin@bootlin.com>

dmaengine: fsl-edma: Support dynamic scatter/gather chaining

Implement dynamic linking of scatter/gather transfers to enable
chaining multiple DMA descriptors without stopping the channel.
This avoids waiting for the channel to go idle if there is another
transaction already issued.

> diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
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

[Severity: Critical]
Does checking the channel-global DONE flag here cause chained descriptors
to execute twice if interrupts coalesce?

For example, if descriptors A and B are chained and the hardware finishes
both before the interrupt handler runs, won't the handler complete A,
see DONE is set, and mark the channel DMA_COMPLETE?

If that happens, wouldn't fsl_edma_xfer_desc() then fetch B from the
issued list and restart the hardware, executing B a second time?

[ ... ]

> @@ -673,6 +676,68 @@ struct dma_async_tx_descriptor *fsl_edma_prep_dma_cy=
clic(
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

[Severity: Critical]
Can this cause a channel deadlock by executing unissued descriptors?

Since hardware linking happens in fsl_edma_tx_submit() rather than waiting
for the issue_pending() callback, if the hardware completes the newly linked
descriptor before the client calls issue_pending(), won't the interrupt
handler fire but find edesc is NULL?

In fsl_edma_tx_chan_handler():

    if (!fsl_chan->edesc) {
        /* terminate_all called before */
        spin_unlock(&fsl_chan->vchan.lock);
        return;
    }

Wouldn't this drop the completion and leave the channel stuck when
issue_pending() is eventually called, since the channel status is still left
as DMA_IN_PROGRESS?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702-fsl-edma-d=
yn-sg-v5-0-16787185be49@bootlin.com?part=3D2

