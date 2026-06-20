Return-Path: <dmaengine+bounces-11676-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8pLOBmjLNmrkEwcAu9opvQ
	(envelope-from <dmaengine+bounces-11676-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 19:18:32 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6162F6A958F
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 19:18:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=RySwE1PU;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11676-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11676-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27728300B9DD
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 17:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3C325782A;
	Sat, 20 Jun 2026 17:18:29 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE6224677B
	for <dmaengine@vger.kernel.org>; Sat, 20 Jun 2026 17:18:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781975908; cv=none; b=WMRc9HpT8yNYod1wjMvarsKeoNmVyJ28xtBExfRrRARIsd4nXkxvw+HoMqNJUoIIK/4Aqt2wLkLSSIgYLF6eO7sSJiqihHdlOem8JQpOweyBZXZTYiid7LH1FoHQ8f1XvzuW+iza9Gh7vldzmM+NbdHM/qNBSugOKu7CWGYr6IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781975908; c=relaxed/simple;
	bh=HEuEMtszMu4LgmAvbeN8N+OhsLV8O37cN64NUqkW6Zs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lqty9Fe9yMmXXdFi60u+tQrpisvfJxH5KLGhpxUWmX5yRxi/49JiRbGzxEm7CcSJLF20lPcBPqJEzSQDcxnXzjCt8e2sdelmKQV9MT0HMFOrUHQWlSGnYXNNJo4LYWYnj1eV7mUE+IhGaGoJjA1LX+Y2708CUxnRXLGErnxNIUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RySwE1PU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BB751F000E9;
	Sat, 20 Jun 2026 17:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781975907;
	bh=5SjoTcZGmrJpvLh53TL0HkiyBheXPoLPMO2XQM2WxuQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RySwE1PUUIPlj9UWREl+ye608jA0G2EWMGpPmd3R0wOwBYtq9PRnc0wjpcNv6wKK1
	 TAMev56GvAdtDxczUeoziQ5o5Ux+ek1rM8OOWjW2RQPRGEW3vaUvoHl3E34PbtU3nv
	 HO6zo+ihx6RltKvjHF/jUe031ZskKwnHxXr1Xb3TAaoWAifO4N3FcswcZzK4UOFlF5
	 W/pQTYZkpvkz7OppQr0cFcOkfhoXs4YyKBRPkSASdTLvV4VPT6wVJaUacTikz9BNnu
	 w0jFTztMVL+oSAJaceWRVl1g2FrXtxd56taV1k32+nt4ACItiZsfKA4lHW95GF59T0
	 vYxE6WZWJ0Pnw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/13] dmaengine: dw-edma-pcie: Add register offset
 match flag
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260620170040.3756043-11-den@valinux.co.jp>
References: <20260620170040.3756043-1-den@valinux.co.jp>
 <20260620170040.3756043-11-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 Jun 2026 17:18:27 +0000
Message-Id: <20260620171827.5BB751F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-11676-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,smtp.kernel.org:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lists.linux.dev:replyto,vger.kernel.org:from_smtp,valinux.co.jp:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6162F6A958F

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The driver adds statically defined offsets to PCI BAR mapping poin=
ters without validating them against the size of the mapped BAR, enabling o=
ut-of-bounds MMIO accesses.
--

commit ba4f6509ffb3ea527d21eedc70cede2c4bd0c13c
Author: Koichiro Den <den@valinux.co.jp>

dmaengine: dw-edma-pcie: Add register offset match flag

This commit adds a match-data flag for devices whose DMA register block
starts at an offset inside the mapped BAR. It applies this offset to the
register base during the PCIe probe.

> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-=
edma-pcie.c
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
[ ... ]
> @@ -465,6 +466,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	chip->reg_base =3D pcim_iomap_table(pdev)[dma_data->rg.bar];
>  	if (!chip->reg_base)
>  		return -ENOMEM;
> +	if (match->flags & DW_EDMA_PCIE_F_REG_OFFSET)
> +		chip->reg_base +=3D dma_data->rg.off;

[Severity: High]
This is a pre-existing issue, but since the new code adds another offset
here, could a malicious or malfunctioning PCIe device cause out-of-bounds
MMIO accesses by reporting an artificially small BAR size?

The driver maps the device BARs using pcim_iomap_regions(), which maps
exactly the size of the BAR as reported by the device during enumeration.
It then calculates pointers by adding statically defined offsets to the
mapped base address in dw_edma_pcie_probe() without bounds checks:

drivers/dma/dw-edma/dw-edma-pcie.c:dw_edma_pcie_probe() {
    ...
    ll_region->vaddr.io +=3D ll_block->off;
    ...
    dt_region->vaddr.io +=3D dt_block->off;
    ...
}

Does the driver need to verify that the mapped region is large enough to
contain the hardcoded offsets and sizes before adding them, to prevent
potential kernel panics or memory corruption when the DMA engine accesses
these pointers?

> =20
>  	for (i =3D 0; i < chip->ll_wr_cnt && !dma_data->cfg_non_ll; i++) {
>  		struct dw_edma_region *ll_region =3D &chip->ll_region_wr[i];

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260620170040.3756=
043-1-den@valinux.co.jp?part=3D10

