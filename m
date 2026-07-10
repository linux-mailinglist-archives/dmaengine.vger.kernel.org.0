Return-Path: <dmaengine+bounces-12318-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3PP6FqrlUGpq8AIAu9opvQ
	(envelope-from <dmaengine+bounces-12318-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 14:29:30 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B28BE73AC81
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 14:29:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="WPFLlFb/";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12318-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-12318-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EB7F230021DE
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 12:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E7E41CB3B;
	Fri, 10 Jul 2026 12:24:01 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026BA22097;
	Fri, 10 Jul 2026 12:24:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783686241; cv=none; b=u1yLaPVr85ujnpRo5GgfK+lVC8c/DqFkHn6TCf64AGMUsN5QijkveJ2OHTtvnyCJkiO0PZEJFe53760o/CbOkKJeaIV9Yyg45T5HOv4x89S52zMnpqy/Kv0mlqRiaMQrFET89srD8MJIwQlnaLm1KcbUU0OD8uFLJvN+WgosCuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783686241; c=relaxed/simple;
	bh=hVc/B1svHTP8EAJNeTMhg+8KwMwaHI2XhsUZDgamRSY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qaBGUli3XPsssBnOEM8kF00o31WRiotpAtsuK/iWVOCtlHTqlDEoSLyL8Zs98NSUCYVrdl28Za9+ln921KEzRTstPfr6qaDDhBb5P1Qjm16HBQjIYp9Dh8UPbIcdTTbR94ayUKcir/508rpJ+Bu0ykyhglbfHtF9Z8D2ci2eOZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WPFLlFb/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 674951F000E9;
	Fri, 10 Jul 2026 12:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783686239;
	bh=X0MzYYhXsYkWBbyvi2u6dYHxS/oEFzLOCJ5JgyIgDRw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WPFLlFb/2aDWJdd8AG6lVf8OLvGLZrr5oOWe6T3XHAs5VHWH10wFPd0U6mWScDF4g
	 PNZ9NdaEW6KLD9ja4UWL2hRYci09y5svlM/iaSwJ1f0eddC/fQ4KrSN/jJpjnamViQ
	 fnB80lu/JgROx7r4RUiBSqFsNTHWNtHYkVSCrg351hK1LI8aTCnQ2wUmIwywSZr8Jt
	 mJZF5YfFRGKOT/aT5MOp21/bYg4q5qcpUfthD8rjWQgso4tTxS+cI1U/m3gCgE4jxn
	 nGC64sLigiZdfraViXGFrICzZHG0VI1eAr8BJzPqkBgwvGK08qqF2BCdSHWCsX2wI2
	 hj37a3UAb8tyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/2] dmaengine: fsl-edma: Implement
 device_prep_peripheral_dma_vec
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QmVub8OudCBNb25pbg==?= <benoit.monin@bootlin.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org, imx@lists.linux.dev
In-Reply-To: <20260710-fsl-edma-dyn-sg-v6-1-831b96be3f31@bootlin.com>
References: <20260710-fsl-edma-dyn-sg-v6-0-831b96be3f31@bootlin.com>
 <20260710-fsl-edma-dyn-sg-v6-1-831b96be3f31@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 12:23:58 +0000
Message-Id: <20260710122359.674951F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12318-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,sashiko.dev:url,bootlin.com:email,lists.linux.dev:replyto];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:benoit.monin@bootlin.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:imx@lists.linux.dev,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B28BE73AC81

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [High] Missing validation for maximum segment transfer length causes sile=
nt 16-bit truncation of the loop iteration count.

Pre-existing issues:
- [Critical] Unconditional division and modulo by zero occur during DMA_DEV=
_TO_DEV transfers due to hardcoded zero offsets.
- [Critical] Missing `is_multi_fifo` and `port_window_size` handling causes=
 the peripheral address pointer to permanently walk backwards.
- [High] Missing validation for `nb =3D=3D 0` leads to a zero-length flexib=
le array allocation and a subsequent out-of-bounds access.
- [High] Missing validation for slave configuration parameters allows clien=
ts to trigger a divide-by-zero crash.
- [High] Calling `dma_map_resource` with `DMA_NONE` triggers a BUG_ON in th=
e DMA mapping subsystem.
--

--- Patch [1]: [PATCH v6 1/2] dmaengine: fsl-edma: Implement device_prep_pe=
ripheral_dma_vec ---
commit 70924f5c721616d3d99a0c89b36974c0edfc571b
Author: Beno=C3=AEt Monin <benoit.monin@bootlin.com>

dmaengine: fsl-edma: Implement device_prep_peripheral_dma_vec

Add implementation of .device_prep_peripheral_dma_vec() callback to setup
a scatter/gather DMA transfer from an array of dma_vec structures. Setup
a cyclic transfer if the DMA_PREP_REPEAT flag is set.

> diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
> index bb7531c456dfa..c10190164926a 100644
> --- a/drivers/dma/fsl-edma-common.c
> +++ b/drivers/dma/fsl-edma-common.c
> @@ -673,6 +673,115 @@ struct dma_async_tx_descriptor *fsl_edma_prep_dma_c=
yclic(
>  	return vchan_tx_prep(&fsl_chan->vchan, &fsl_desc->vdesc, flags);
>  }
> =20
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

[Severity: High]
This isn't a bug introduced by this patch, but does calling
fsl_edma_prep_slave_dma() with DMA_DEV_TO_DEV trigger a BUG_ON()?

fsl_edma_prep_slave_dma() translates DEV_TO_DEV to DMA_NONE, which is then
passed to dma_map_resource(). The DMA subsystem enforces a BUG_ON for
invalid directions like DMA_NONE, which would crash the kernel.

> +
> +	fsl_desc =3D fsl_edma_alloc_desc(fsl_chan, nb);
> +	if (!fsl_desc)
> +		return NULL;

[Severity: High]
This isn't a bug introduced by this patch, but is it possible for nb to be
0 here?

If so, fsl_edma_alloc_desc() will allocate a descriptor with a 0-length
tcd flexible array, and later fsl_edma_xfer_desc() might dereference it
out of bounds.

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

[Severity: High]
This is a pre-existing issue, but what happens if the client misconfigures
dst_maxburst or dst_addr_width and leaves them at 0?

It looks like nbytes evaluates to 0, which would cause a divide-by-zero
kernel panic later when evaluating vecs[i].len % nbytes.

[ ... ]
> +	for (i =3D 0; i < nb; i++) {
> +		if (direction =3D=3D DMA_MEM_TO_DEV) {
> +			src_addr =3D vecs[i].addr;
> +			dst_addr =3D fsl_chan->dma_dev_addr;
> +			soff =3D fsl_chan->cfg.dst_addr_width;
> +			doff =3D 0;
> +		} else if (direction =3D=3D DMA_DEV_TO_MEM) {
> +			src_addr =3D fsl_chan->dma_dev_addr;
> +			dst_addr =3D vecs[i].addr;
> +			soff =3D 0;
> +			doff =3D fsl_chan->cfg.src_addr_width;

[Severity: Critical]
This isn't a bug introduced by this patch, but doesn't the lack of
is_multi_fifo and port_window_size handling here cause the address to
permanently walk backwards?

fsl_edma_fill_tcd() applies a negative minor loop offset if these are
enabled, but since doff and soff are hardcoded to 0 here, the address doesn=
't
increment during the minor loop and still gets subtracted at the end.

[ ... ]
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

[Severity: Critical]
This is a pre-existing issue copied from fsl_edma_prep_slave_sg(), but
could this cause a divide-by-zero panic during a DMA_DEV_TO_DEV transfer?

For DEV_TO_DEV, both soff and doff are hardcoded to 0 earlier in the loop,
so width becomes 0. If the vector length isn't a multiple of nbytes,
this modulo operation will divide by zero.

> +					nbytes =3D j * width;
> +					break;
> +				}
> +			}
> +			/* Set burst size as 1 if there's no suitable one */
> +			if (j =3D=3D 1)
> +				nbytes =3D width;
> +		}
> +
> +		iter =3D vecs[i].len / nbytes;

[Severity: High]
Does this properly handle vectors that exceed the hardware's maximum segment
size?

The dma_vec API passes raw vector lengths directly from the client, and
iter is a u16. If vecs[i].len / nbytes exceeds 65535, will this silently
truncate and lead to a partial transfer and data corruption?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710-fsl-edma-d=
yn-sg-v6-0-831b96be3f31@bootlin.com?part=3D1

