Return-Path: <dmaengine+bounces-12416-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IGcgI3wdVWp2kAAAu9opvQ
	(envelope-from <dmaengine+bounces-12416-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 19:16:44 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F68E74DEDC
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 19:16:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=RZJM+BDV;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12416-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12416-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56FC43026A8B
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 17:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3AD83438B2;
	Mon, 13 Jul 2026 17:12:53 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D87E224F3;
	Mon, 13 Jul 2026 17:12:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783962773; cv=none; b=UwF/VRMe1QBMTga2UC8gIdzNpX5piEEmyPK7qjFMUw5x6+5LYqR4agXKYpwF/zb0Up/SbFQ9CLrOUS7BXBDgymnwu+KOF1R+smUqgmhe7Bq2mYE4eBWnsUiQaYBo6jCeTEpmnKbq4DR44abYqUzZNLsfIKv8mP4GkUs6dU6tyvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783962773; c=relaxed/simple;
	bh=3Bxbw09lBOMGqpVJ5A0mqVJfoyU7ZsVNsp3hiuyvGhE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HJNQUFR/CHExiQ4HA5Cv8eu1Ta12o6hJfUozs0KhYvnLMVTnLd94o/OuHGbJKTdl+3EvvgJ8A4PktViUpi1fLZmB02z5QRtgtI/QmB2MMUmZlAPZTkyDKcTI8jSr+MNU4HtGqDqCrlGjkwUKYwDpQpLTifTdlqQB7jMdyqX5s1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RZJM+BDV; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03DA81F000E9;
	Mon, 13 Jul 2026 17:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783962772;
	bh=KhUce3y2u7XvTvhcfPLaAWpcIkOKc/hs25FmMFBCwoI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RZJM+BDVZ65kuyCzbDwLrdPffxbWWPQXHxj9eUT3Jg+4nRTLYit9dLVDmeh75Ji73
	 ImEUnW8zX4P+F8Ngbz86rbB7xF1q/AmQA2V5bQvShus2Gn4nHFqYqgdeYTEbQDdX67
	 14wfvyP1kEUcIG6v8I+DhAWjh5fNvhkbezZvdaD2jrTEeyLbINh/m8AcEh5PMn2jaO
	 19Y36wKo7n1rc9cKUgIz0T7Owp4buZFisCtHw+Poh6dW81X/siGZtS7nM/sepwrJfc
	 rtRsjBbTOO51c8OMwaATSFN0sHxPEP5ZVpmYiV6IYEXoz7u/h+XI2lcV1ZK0vuES4b
	 7ddngTQ8VdzyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 01/10] dmaengine: dw-edma: Move control field update
 of DMA link to the last step
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: vkoul@kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org, imx@lists.linux.dev, Frank.Li@kernel.org
In-Reply-To: <20260713-edma_ll-v7-1-6fb7498c901e@nxp.com>
References: <20260713-edma_ll-v7-0-6fb7498c901e@nxp.com>
 <20260713-edma_ll-v7-1-6fb7498c901e@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 17:12:51 +0000
Message-Id: <20260713171252.03DA81F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12416-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,smtp.kernel.org:mid,nxp.com:email,vger.kernel.org:from_smtp,lists.linux.dev:replyto];
	FORGED_RECIPIENTS(0.00)[m:Frank.Li@oss.nxp.com,m:vkoul@kernel.org,m:linux-pci@vger.kernel.org,m:dmaengine@vger.kernel.org,m:imx@lists.linux.dev,m:Frank.Li@kernel.org,s:lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2F68E74DEDC

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Non-atomic update of the DMA descriptor trigger field (`control`=
) due to `__packed` struct layout and lack of `WRITE_ONCE()`, which undermi=
nes the safe concurrent DMA updates intended by the patch.
--

--- Patch [1]: [PATCH v7 01/10] dmaengine: dw-edma: Move control field upda=
te of DMA link to the last step ---
commit bd1de63f1d8dc07b26abcdf63111eb18b82af133
Author: Frank Li <Frank.Li@nxp.com>

dmaengine: dw-edma: Move control field update of DMA link to the last step

This patch reorders the initialization of the DMA link list entries to write
the control field last, followed by a dma_wmb() barrier. This is intended
to safely signal readiness to the hardware and prepare the driver for updat=
ing
descriptors while the DMA is actively running.

> diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/=
dw-edma-v0-core.c
> index cfdd6463252e6..ee5c3c317557b 100644
> --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> @@ -284,17 +284,18 @@ static void dw_edma_v0_write_ll_data(struct dw_edma=
_chunk *chunk, int i,
>  	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
>  		struct dw_edma_v0_lli *lli =3D chunk->ll_region.vaddr.mem + ofs;
> =20
> -		lli->control =3D control;
>  		lli->transfer_size =3D size;
>  		lli->sar.reg =3D sar;
>  		lli->dar.reg =3D dar;
> +		dma_wmb();
> +		lli->control =3D control;

[Severity: Medium]
Will this assignment safely guarantee an atomic update for the hardware?

Since struct dw_edma_v0_lli is defined as __packed, the compiler might emit
byte-wise stores or tear the write instead of doing a single 32-bit store.
Without WRITE_ONCE(), the compiler could also potentially reorder or split
the store.

If the goal is to safely update descriptors while the DMA is running, does
this need to use WRITE_ONCE() (along with ensuring proper alignment) so the
hardware doesn't observe a partially updated control field?

>  	} else {
>  		struct dw_edma_v0_lli __iomem *lli =3D chunk->ll_region.vaddr.io + ofs;
> =20
> -		writel(control, &lli->control);
>  		writel(size, &lli->transfer_size);
>  		writeq(sar, &lli->sar.reg);
>  		writeq(dar, &lli->dar.reg);
> +		writel(control, &lli->control);
>  	}
>  }

[ ... ]

> @@ -306,13 +307,14 @@ static void dw_edma_v0_write_ll_link(struct dw_edma=
_chunk *chunk,
>  	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
>  		struct dw_edma_v0_llp *llp =3D chunk->ll_region.vaddr.mem + ofs;
> =20
> -		llp->control =3D control;
>  		llp->llp.reg =3D pointer;
> +		dma_wmb();
> +		llp->control =3D control;

[Severity: Medium]
Would this also need WRITE_ONCE() since struct dw_edma_v0_llp is a __packed
struct?

[ ... ]

> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/=
dw-hdma-v0-core.c
> index 632abb8b481cf..1201f1ab5f359 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> @@ -160,17 +160,18 @@ static void dw_hdma_v0_write_ll_data(struct dw_edma=
_chunk *chunk, int i,
>  	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
>  		struct dw_hdma_v0_lli *lli =3D chunk->ll_region.vaddr.mem + ofs;
> =20
> -		lli->control =3D control;
>  		lli->transfer_size =3D size;
>  		lli->sar.reg =3D sar;
>  		lli->dar.reg =3D dar;
> +		dma_wmb();
> +		lli->control =3D control;

[Severity: Medium]
Similar to the v0_lli struct above, dw_hdma_v0_lli is also __packed. Could =
this
store tear and cause the DMA hardware to observe an incomplete control fiel=
d?

>  	} else {
>  		struct dw_hdma_v0_lli __iomem *lli =3D chunk->ll_region.vaddr.io + ofs;
> =20
> -		writel(control, &lli->control);
>  		writel(size, &lli->transfer_size);
>  		writeq(sar, &lli->sar.reg);
>  		writeq(dar, &lli->dar.reg);
> +		writel(control, &lli->control);
>  	}
>  }

[ ... ]

> @@ -182,13 +183,14 @@ static void dw_hdma_v0_write_ll_link(struct dw_edma=
_chunk *chunk,
>  	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
>  		struct dw_hdma_v0_llp *llp =3D chunk->ll_region.vaddr.mem + ofs;
> =20
> -		llp->control =3D control;
>  		llp->llp.reg =3D pointer;
> +		dma_wmb();
> +		llp->control =3D control;

[Severity: Medium]
Could this assignment to the __packed dw_hdma_v0_llp struct tear as well?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713-edma_ll-v7=
-0-6fb7498c901e@nxp.com?part=3D1

