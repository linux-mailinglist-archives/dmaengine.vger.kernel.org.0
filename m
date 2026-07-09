Return-Path: <dmaengine+bounces-12251-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9URdODnFT2qRoAIAu9opvQ
	(envelope-from <dmaengine+bounces-12251-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 17:58:49 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE630733365
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 17:58:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=LFf8kizI;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12251-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12251-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AA921305AF81
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 15:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4148C36A375;
	Thu,  9 Jul 2026 15:44:27 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D132E7373;
	Thu,  9 Jul 2026 15:44:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783611867; cv=none; b=NDDkVgIAEbYoEhgFAuW1HdGSrUbzJRHtG6oTW30cLW8GSJWtfttP7c4Qm2bO6oaVcF9/FUwthl5VwykMGTguIF3p5y9G6ixFFQg6wTxAXSVLLrJhWMTaZRU9Qfym9dEKMm8QsUpAgrO3UuYU7Z4yJWJvt7VEPFKa8edcopgplTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783611867; c=relaxed/simple;
	bh=TmBaWxsFRcXQozNfj0x4RR83E1vKa4lPcGTdjd//sUI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=q1VCBtbXBnJZUQc/4m9NtkL1U2KOk+XPzpOe6Zv6QbAVFhE2VfCymTgo7Vv6mx3sMIah8qgJR3z4d9EXFSMMC7KE2L0cP9HbHnZOy4Ba9wHG4YIJ2i8C3KlkDYk+Ztzwg3+4vdN1+gynjoodbYr1GwSlMT6vcrpaCxXIeQVx0sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LFf8kizI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 270B71F000E9;
	Thu,  9 Jul 2026 15:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783611865;
	bh=4Kttj66JbGjZxb/CmYuNjyqQcLRbuDOyZvCzdv9O21U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LFf8kizIY6AN1hDbOzSssvjs3gvkgpWL2RvvTJSHogdbsX7H9xWsfBHXGS9GtT3/t
	 4CTjDBVccQ8PGTzP88gCPCqBv2kPcIweDslxoFOSQbwj1orMznncimNNrn1imc8j5e
	 6FZV8FsA3EkCxtkS3734u5w3Ywy1SEYbtGDqMsx3DK2Vm/2iQq4EhMF57rc/csyxA1
	 VE3M5ZfO4Y6qkXoGTKQkMACOWRL9qL23ipoEfdPjpetGQtMWVINPNVe8oVpREWctbC
	 806eYkrZASkT+TSdyeK7bF79Cu1VbYZzFmA8qA6jvzu9XYxCDRM72dBzriEad9+FCq
	 QjOA9pC3F55BQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 01/10] dmaengine: dw-edma: Move control field update
 of DMA link to the last step
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: vkoul@kernel.org, imx@lists.linux.dev, Frank.Li@kernel.org, dmaengine@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260709-edma_ll-v5-1-e199053d4300@nxp.com>
References: <20260709-edma_ll-v5-0-e199053d4300@nxp.com>
 <20260709-edma_ll-v5-1-e199053d4300@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 15:44:24 +0000
Message-Id: <20260709154425.270B71F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12251-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nxp.com:email,vger.kernel.org:from_smtp,lists.linux.dev:replyto,sashiko.dev:url];
	FORGED_RECIPIENTS(0.00)[m:Frank.Li@oss.nxp.com,m:vkoul@kernel.org,m:imx@lists.linux.dev,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:linux-pci@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DE630733365

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Non-atomic plain C assignment to a `__packed` struct member intr=
oduces store tearing, breaking the intended synchronization.
--

--- Patch [1]: [PATCH v5 01/10] dmaengine: dw-edma: Move control field upda=
te of DMA link to the last step ---
commit cd43406fa1746a861753879aacc2a23e61b13ce6
Author: Frank Li <Frank.Li@nxp.com>
Subject: dmaengine: dw-edma: Move control field update of DMA link to the l=
ast step

This commit moves the control field update of the DMA link list entry to the
end of the sequence. It adds a dma_wmb() barrier to ensure correct memory
write ordering, which prepares the driver for supporting link entry updates
during DMA operation.

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
Could this assignment tear on strict-alignment architectures?

Since struct dw_edma_v0_lli is defined as __packed without an __aligned()
attribute, the compiler may assume an alignment of 1. This means a plain C
assignment could be compiled into multiple byte-sized stores (such as strb =
on
ARM).

If the store tears, could the hardware observe the CB bit as ready before t=
he
rest of the control word is fully written, leading to a corrupted control
state being processed?

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
Are we facing the same store tearing issue here since struct dw_edma_v0_llp
is also __packed?

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
Might this assignment also tear on strict-alignment architectures, as
struct dw_hdma_v0_lli is marked as __packed?

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
Would this assignment also be susceptible to store tearing due to
struct dw_hdma_v0_llp being __packed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-edma_ll-v5=
-0-e199053d4300@nxp.com?part=3D1

