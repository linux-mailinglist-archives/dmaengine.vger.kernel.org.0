Return-Path: <dmaengine+bounces-11666-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id A9z2Ix7KNmqwEwcAu9opvQ
	(envelope-from <dmaengine+bounces-11666-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 19:13:02 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F4F6A954F
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 19:13:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=e8+BSNJR;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11666-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11666-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 117F0301547E
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 17:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F80A2D595D;
	Sat, 20 Jun 2026 17:11:05 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DD322D7B9
	for <dmaengine@vger.kernel.org>; Sat, 20 Jun 2026 17:11:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781975465; cv=none; b=fb/9FJ41fvTBfD12Z2pvhCnVpt0HgdwatVGLjtbT9xANbcMFuKIVeCwPjMCepj3nCdH4jK3cf6jXXwy0rWkTmfZJBtKKriGsdP1f2Qv+/WUgpwOF1Lk+e4C0OY3auZY69a3JOJYogtR9D7gAh4DaG8Yo11PBGyGhc+82oCRvN6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781975465; c=relaxed/simple;
	bh=CNhXdzdIB3Qq083gwC+QHWq+K79pStY0ebvsbfddzqs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=go4UdV+UUPcODxk6B1gXybUsg9IR3CmDqPS/J7Im+NvAakRsiWlS+ULnYRDGBRq6jGn0OS1YvO5aPPD2beTJj6mNitSQxl5DYh3k2NfWM8GVDf1+u++FlSjgwucyauO6kFvcr73wtk2rYlVcrlHeD91/sLOwrcI8qg/m3n3DZa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e8+BSNJR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98EE71F000E9;
	Sat, 20 Jun 2026 17:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781975463;
	bh=ZeIizC75LAxcvi2RhTO/1KRpyNCFCSbAY5IYpZ7v6Hg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e8+BSNJRrWo0MPwU358WCdTslYTrNkc0T2rxcTNpSH0uZFpqIYU2gwSNdcyg2GlYb
	 FXg2bABohrhs8/c2n7NPdknaMEMDyFNZMmbqeIlyifdye4aiqtqKVSrM31mIHbuS4q
	 Op3coddxUl1VjOrZs9agPbvKUtW9uEiivRMHcX6ylFLkogh9rH9Ulf6Qv5QF3N3USJ
	 QnbbhToB5xwEenBRvOBl3jzTsJx6KCAXFNdOxYyMq2N+sP2Qgo2TdgVeO/m6wiyAfA
	 bf9czLWo9c2lkQ+A7COlJkoJ7+ufkIcbriNVXfYg2wB0VCD1aXrsaZOADr9I6LucSr
	 jp+Tp0zafKSSg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 08/13] dmaengine: dw-edma-pcie: Rename vsec_data to
 dma_data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260620170040.3756043-9-den@valinux.co.jp>
References: <20260620170040.3756043-1-den@valinux.co.jp>
 <20260620170040.3756043-9-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 Jun 2026 17:11:03 +0000
Message-Id: <20260620171103.98EE71F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11666-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:den@valinux.co.jp,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lists.linux.dev:replyto,vger.kernel.org:from_smtp,valinux.co.jp:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E0F4F6A954F

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing pci_free_irq_vectors() cleanup on error paths in dw_edma_p=
cie_probe().
--

commit de019354672cdd91d71c2d84fb752c9367dce2c3
Author: Koichiro Den <den@valinux.co.jp>

dmaengine: dw-edma-pcie: Rename vsec_data to dma_data

This commit renames the local variable vsec_data to dma_data in
dw_edma_pcie_probe() to reflect that DMA layout data can now be obtained
from device-specific capabilities, not just VSEC.

> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-=
edma-pcie.c
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c

[ ... ]

> @@ -454,24 +452,24 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	/* Data structure initialization */
>  	chip->dev =3D dev;
> =20
> -	chip->mf =3D vsec_data->mf;
> +	chip->mf =3D dma_data->mf;
>  	chip->irq_mode =3D DW_EDMA_CH_IRQ_REMOTE;
>  	chip->nr_irqs =3D nr_irqs;
>  	chip->ops =3D &dw_edma_pcie_plat_ops;
> -	chip->cfg_non_ll =3D vsec_data->cfg_non_ll;
> +	chip->cfg_non_ll =3D dma_data->cfg_non_ll;
> =20
> -	chip->ll_wr_cnt =3D vsec_data->wr_ch_cnt;
> -	chip->ll_rd_cnt =3D vsec_data->rd_ch_cnt;
> +	chip->ll_wr_cnt =3D dma_data->wr_ch_cnt;
> +	chip->ll_rd_cnt =3D dma_data->rd_ch_cnt;
> =20
> -	chip->reg_base =3D pcim_iomap_table(pdev)[vsec_data->rg.bar];
> +	chip->reg_base =3D pcim_iomap_table(pdev)[dma_data->rg.bar];
>  	if (!chip->reg_base)
>  		return -ENOMEM;

[Severity: High]
This is a pre-existing issue, but does this error path leak the IRQ
vectors allocated earlier in the function?

The function dw_edma_pcie_probe() successfully allocates IRQ vectors using
pci_alloc_irq_vectors() before reaching this point, but returning directly
here leaves those resources stranded.=20

Are there other error paths further down in this function, such as when
pci_dev_msi_enabled() fails or dw_edma_probe() returns an error, that
might also need a pci_free_irq_vectors() cleanup before returning?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260620170040.3756=
043-1-den@valinux.co.jp?part=3D8

