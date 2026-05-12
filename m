Return-Path: <dmaengine+bounces-10339-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNAxNUq1AmqSvwEAu9opvQ
	(envelope-from <dmaengine+bounces-10339-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 07:06:18 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CAC519BDC
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 07:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DC2C73010BC8
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 05:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6EB024BBFD;
	Tue, 12 May 2026 05:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wg/YScQR"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924E71B87C9;
	Tue, 12 May 2026 05:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778562376; cv=none; b=HuQujthbUioNyny5RAghG83kLJu7z5gC1LPY9x195d5MMlGoJe2qDTHpWYSPcWmnYjQhMUznNxpa1H/FuvV57e5GKrBTCN49lMDMQBav+sv3h+nUODm0FnpXRGYrCsQmu2qjsRw/dvkCyxNob60iP2l8Dc6bhdllCpXrx4pQWFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778562376; c=relaxed/simple;
	bh=dr+UOCLaFPDAtPAef1gRcND9dMnR9xTCUTvLvZ9Kd8E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QUbOFv6HIjp0wcDQIZPf7mRp0JWgYVJRohOdpijayHa2XKsHjFrTo2kjkOQbpl7RErRBsY2J7eowlQ47REFeWtTl0PzBNFBvuxsW8mi/a8N1QE7xjQ9qSALN0a0ObtonufoVFFaHOKZR1LbtNngCVrwGeR20432L5uAXcDZfZ3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wg/YScQR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 035BBC2BCB0;
	Tue, 12 May 2026 05:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778562376;
	bh=dr+UOCLaFPDAtPAef1gRcND9dMnR9xTCUTvLvZ9Kd8E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Wg/YScQRfI2XODcUO5H0m4r5VKE0cDOUpdWsl37/XcQFzRWgjUn2dWkr5SC3z6HdT
	 ryihFF4C2LKonKRdY+72eD8aKuX3xZjrAbvpPj7c6VF6rpGRBAGBonB/c8HMvRf5vD
	 YenoF3ui1ZzijSvvWTAHbrPP6XIe0ay7QJC+ptZT9jaAfZ1r0Cu0KUloBH6enMOeH1
	 cYzX5iiQ4/mUZoA1jk/ObVpnn5TCREA6ck+g9cB6X+xtBlR2ZvFJGqCQGg5dKcsLSQ
	 1cS7GHY0hHhQ7qHQKYIEf6GHE50GYiwkemPwUWXuhdCyas2et6l/LRHczR3jixYqHR
	 OR0as3WMKq3FA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] dmaengine: fsl-edma: Implement
 device_prep_peripheral_dma_vec
Reply-To: sashiko@lists.linux.dev
To: =?utf-8?b?QmVub8OudCBNb25pbg==?= <benoit.monin@bootlin.com>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org, imx@lists.linux.dev
In-Reply-To: <20260511-fsl-edma-dyn-sg-v3-1-98a181775dae@bootlin.com>
References: <20260511-fsl-edma-dyn-sg-v3-1-98a181775dae@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 12 May 2026 05:06:15 +0000
Message-Id: <20260512050616.035BBC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 76CAC519BDC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,smtp.kernel.org:mid,sashiko.dev:url,lists.linux.dev:replyto,bootlin.com:email];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10339-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko@lists.linux.dev]
X-Rspamd-Action: no action

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Submitting a transfer with zero elements (nb =3D=3D 0) causes an o=
ut-of-bounds memory read and kernel oops.
- [High] Modulo by zero kernel panic for DMA_DEV_TO_DEV transfers with unal=
igned lengths.
- [High] Missing multi-FIFO support causes backward memory corruption for p=
eripheral transfers.
- [High] The nbytes burst size is never restored per loop iteration, causin=
g subsequent vectors to permanently inherit a heavily degraded burst size.
--

commit 995264f0108e475b7f259a8a9e431ac6988e4a11
Author: Beno=C3=AEt Monin <benoit.monin@bootlin.com>

dmaengine: fsl-edma: Implement device_prep_peripheral_dma_vec

Add implementation of .device_prep_peripheral_dma_vec() callback to setup
a scatter/gather DMA transfer from an array of dma_vec structures. Setup
a cyclic transfer if the DMA_PREP_REPEAT flag is set.

> diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
> index bb7531c456dfa..c10190164926a 100644
> --- a/drivers/dma/fsl-edma-common.c
> +++ b/drivers/dma/fsl-edma-common.c

[ ... ]

> +struct dma_async_tx_descriptor *
> +fsl_edma_prep_peripheral_dma_vec(struct dma_chan *chan, const struct dma=
_vec *vecs,
> +				 size_t nb, enum dma_transfer_direction direction,
> +				 unsigned long flags)
> +{
> +	struct fsl_edma_chan *fsl_chan =3D to_fsl_edma_chan(chan);
> +	dma_addr_t src_addr, dst_addr, last_sg;
> +	struct fsl_edma_desc *fsl_desc;
> +	u16 soff, doff, iter;
> +	u32 nbytes;
> +	int i;
> +
> +	if (!is_slave_direction(direction))
> +		return NULL;
> +
> +	if (!fsl_edma_prep_slave_dma(fsl_chan, direction))
> +		return NULL;
> +
> +	fsl_desc =3D fsl_edma_alloc_desc(fsl_chan, nb);

This problem wasn't introduced by this patch, but does this function need to
validate that nb > 0?

If nb =3D=3D 0 is provided, fsl_edma_alloc_desc() allocates a descriptor wi=
th
zero tcd structures in its flexible array. When the DMA engine later attemp=
ts
to execute it in fsl_edma_xfer_desc(), it unconditionally dereferences
fsl_chan->edesc->tcd[0].vtcd. This reads a garbage pointer from adjacent he=
ap
memory and leads to an immediate kernel oops when trying to write to the DMA
hardware registers.

Additionally, the subsequent patch Support dynamic scatter/gather chaining
introduces prev_desc->n_tcds - 1, which underflows to UINT_MAX when nb =3D=
=3D 0,
guaranteeing another out-of-bounds crash on tx_submit().

> +	if (!fsl_desc)
> +		return NULL;
> +	fsl_desc->iscyclic =3D flags & DMA_PREP_REPEAT;
> +	fsl_desc->dirn =3D direction;
> +
> +	if (direction =3D=3D DMA_MEM_TO_DEV) {
> +		if (!fsl_chan->cfg.src_addr_width)
> +			fsl_chan->cfg.src_addr_width =3D fsl_chan->cfg.dst_addr_width;
> +		fsl_chan->attr =3D
> +			fsl_edma_get_tcd_attr(fsl_chan->cfg.src_addr_width,
> +					      fsl_chan->cfg.dst_addr_width);
> +		nbytes =3D fsl_chan->cfg.dst_addr_width * fsl_chan->cfg.dst_maxburst;
> +	} else {
> +		if (!fsl_chan->cfg.dst_addr_width)
> +			fsl_chan->cfg.dst_addr_width =3D fsl_chan->cfg.src_addr_width;
> +		fsl_chan->attr =3D
> +			fsl_edma_get_tcd_attr(fsl_chan->cfg.src_addr_width,
> +					      fsl_chan->cfg.dst_addr_width);
> +		nbytes =3D fsl_chan->cfg.src_addr_width * fsl_chan->cfg.src_maxburst;
> +	}
> +
> +	for (i =3D 0; i < nb; i++) {

This isn't a regression from this patch, but does nbytes need to be restored
to its default optimal value at the start of each loop iteration?

If vecs[i].len is not a multiple of nbytes, nbytes is permanently reduced to
a smaller valid multiple (or down to width). However, because nbytes is not
reset to its default optimal value at the start of each loop iteration, all
remaining vectors in the array will be forced to use the heavily degraded
burst size, even if they are perfectly aligned.

This exponentially increases the number of hardware DMA requests (minor loo=
ps)
for the remainder of the transfer, which can cause peripheral FIFO overruns
on fast data streams.

> +		if (direction =3D=3D DMA_MEM_TO_DEV) {
> +			src_addr =3D vecs[i].addr;
> +			dst_addr =3D fsl_chan->dma_dev_addr;
> +			soff =3D fsl_chan->cfg.dst_addr_width;
> +			doff =3D 0;

This problem wasn't introduced by this patch, but should soff and doff hand=
le
multi-FIFO support here?

Unlike fsl_edma_prep_dma_cyclic(), which correctly assigns doff and soff to
support multi-FIFO (e.g., doff =3D fsl_chan->is_multi_fifo ? 4 : 0), this
function unconditionally hardcodes doff =3D 0 and soff =3D 0 for device add=
resses.

However, fsl_edma_fill_tcd() still applies a negative Minor Loop Offset
(MLOFF) at the end of the minor loop if is_multi_fifo or port_window_size a=
re
enabled on the channel. Because the address never incrementally advanced
during the minor loop, applying MLOFF forces the device address to step
backwards continuously, severely corrupting system memory or registers loca=
ted
before the target device address.

> +		} else if (direction =3D=3D DMA_DEV_TO_MEM) {
> +			src_addr =3D fsl_chan->dma_dev_addr;
> +			dst_addr =3D vecs[i].addr;
> +			soff =3D 0;
> +			doff =3D fsl_chan->cfg.src_addr_width;
> +		} else {
> +			/* DMA_DEV_TO_DEV */
> +			src_addr =3D fsl_chan->cfg.src_addr;
> +			dst_addr =3D fsl_chan->cfg.dst_addr;
> +			soff =3D 0;
> +			doff =3D 0;
> +		}
> +
> +		/*
> +		 * Choose the suitable burst length if dma_vec length is not
> +		 * multiple of burst length so that the whole transfer length is
> +		 * multiple of minor loop(burst length).
> +		 */
> +		if (vecs[i].len % nbytes) {
> +			u32 width =3D (direction =3D=3D DMA_DEV_TO_MEM) ? doff : soff;
> +			u32 burst =3D (direction =3D=3D DMA_DEV_TO_MEM) ?
> +						fsl_chan->cfg.src_maxburst :
> +						fsl_chan->cfg.dst_maxburst;
> +			int j;
> +
> +			for (j =3D burst; j > 1; j--) {
> +				if (!(vecs[i].len % (j * width))) {

This problem wasn't introduced by this patch, but can this cause a modulo by
zero kernel panic for DMA_DEV_TO_DEV transfers?

For DMA_DEV_TO_DEV transfers, both soff and doff are explicitly set to 0. If
vecs[i].len is not divisible by the initial burst size nbytes, the driver
assigns width =3D soff, which evaluates to 0.

The loop then evaluates if (!(vecs[i].len % (j * width))), causing an
immediate modulo by zero panic.

Furthermore, if the loop finishes with j =3D=3D 1, nbytes is set to width (=
0),
and iter =3D vecs[i].len / nbytes triggers another division by zero.

> +					nbytes =3D j * width;
> +					break;
> +				}
> +			}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511-fsl-edma-d=
yn-sg-v3-0-98a181775dae@bootlin.com?part=3D1

