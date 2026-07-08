Return-Path: <dmaengine+bounces-12140-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HgpIAj6bTmoPQgIAu9opvQ
	(envelope-from <dmaengine+bounces-12140-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 20:47:26 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B0A729AD9
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 20:47:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=MgvSochV;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12140-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-12140-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0B9803007500
	for <lists+dmaengine@lfdr.de>; Wed,  8 Jul 2026 18:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770493C5528;
	Wed,  8 Jul 2026 18:47:24 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A933C3C19;
	Wed,  8 Jul 2026 18:47:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783536444; cv=none; b=rdHCONPIaiM8AhIldybmy5WCOvyZBpoXmD3P4nqI/W5msGtJNm+PqPzLfrfm+2q0rndggwL0RVjV2vWvEgXZ2xOfQLqIIL5Ced4Kq3dw1KmRnE+mqiQFrMlH18kw7wesWr4zzqNKiGuGKuL9105b7XIkgt6cWu0qsPfI+2XH8SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783536444; c=relaxed/simple;
	bh=7LQLeV41DzW3QMMpofP8idSv7vDpH9Uie0dUSX6gyds=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OUhfDTJYURcz78d0PoY+dr2pDI/tPcSv55QRQkRgCuQkeLDaFt90pGn4nh9c/IAaMUaehAZJ9MP/p6YezW0YM6ZGGD24CnmOjgScGmNU+wNx1QsdwKUW0FfEe44MC6xuHHZO5fjcl0EOPqtUKdDUMpzn2WpriiIxwUHA8GjIOrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MgvSochV; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 925E81F000E9;
	Wed,  8 Jul 2026 18:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783536442;
	bh=dikXtWBDo5SMKR6Te2NzkEJMhWuM7bvbrXP9M3ZWEmk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MgvSochV9lpgDlOCqfuD1iM/u6lvvCeba/wrVYHZpvfU6wz/A/NmAp9giOSPc5Ztk
	 az9xBcJnQV+4Ga9M8RrINrfZQY4f2S1WdCDWugPCpTpxFsjmGi3Kfo4Ztt0pGGxTcU
	 SMIvtNkjsjVfpQr0CqOy9Mr/OduV4xVcIVHf/eQV2BDwJrJNsBRAIC1rde8LKsfMJ8
	 bDijj4DTopvLfEMThLxI4sWWfq2SsoDboOOnhf9sgrHBStwAH6JUhSEQ53vbnTkXma
	 z9bITlilxEeNmPlF+3Xija8jQnumB4j8rqzM+DeXPYICToRqwuXypeywHGkMaUJVdJ
	 KjYt+M1LJiwMw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 01/10] dmaengine: dw-edma: Move control field update
 of DMA link to the last step
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: Frank.Li@kernel.org, linux-pci@vger.kernel.org, imx@lists.linux.dev, dmaengine@vger.kernel.org, vkoul@kernel.org
In-Reply-To: <20260708-edma_ll-v4-1-cc128f0afb61@nxp.com>
References: <20260708-edma_ll-v4-0-cc128f0afb61@nxp.com>
 <20260708-edma_ll-v4-1-cc128f0afb61@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 18:47:21 +0000
Message-Id: <20260708184721.925E81F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12140-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,smtp.kernel.org:mid,nxp.com:email,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lists.linux.dev:replyto];
	FORGED_RECIPIENTS(0.00)[m:Frank.Li@oss.nxp.com,m:Frank.Li@kernel.org,m:linux-pci@vger.kernel.org,m:imx@lists.linux.dev,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,s:lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 90B0A729AD9

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The lockless update to the `control` field in the local DMA desc=
riptor is vulnerable to compiler tearing due to the `__packed` attribute, u=
ndermining the hardware synchronization intended by this patch.
--

--- Patch [1]: [PATCH v4 01/10] dmaengine: dw-edma: Move control field upda=
te of DMA link to the last step ---
commit baf2c8f9cfe7a0520e9aa385d467515afdd0b585
Author: Frank Li <Frank.Li@nxp.com>
dmaengine: dw-edma: Move control field update of DMA link to the last step

This commit modifies the initialization order of DMA link list entries
so that the control field, which includes the ready bit, is written last
after a dma_wmb(). This prepares the driver to support updating link
entries while the DMA is actively running.

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
Since struct dw_edma_v0_lli is marked as __packed, is it possible for the
compiler to tear this lli->control assignment into multiple byte-sized
stores on some architectures with strict alignment rules?

If the DMA engine is running and observes a torn write, it could read a
partially updated control word. While the commit message notes concurrent
updates aren't enabled yet, would using WRITE_ONCE() (along with any
necessary casting to avoid packed-member warnings) ensure this
synchronization flag is written indivisibly once concurrent hardware access
is enabled?

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
Does this llp->control assignment have the same tearing vulnerability
due to struct dw_edma_v0_llp being __packed?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-edma_ll-v4=
-0-cc128f0afb61@nxp.com?part=3D1

