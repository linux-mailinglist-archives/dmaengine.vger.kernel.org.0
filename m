Return-Path: <dmaengine+bounces-10826-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHhbNU7vE2qmHgcAu9opvQ
	(envelope-from <dmaengine+bounces-10826-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 08:42:22 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB645C6A4D
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 08:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D4480300147F
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 06:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07D2313532;
	Mon, 25 May 2026 06:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PeLk3ss2"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18E672627
	for <dmaengine@vger.kernel.org>; Mon, 25 May 2026 06:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779691340; cv=none; b=NkqVLzlYmp88ifmbfy4SMvQeOLvNMiGwOvNdMT1D9dgnG4Iq23AQdjWRUG3RT+XMVXpEKVA7idOzXBoeOw77Q0TW3XLgoAV5b3DCTdDbuaBCG6MPswmoiejamVAPb0iOk4+kQvTLtIUvQd7ajWZtCyaWZtOukYRTHNQA9frLW0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779691340; c=relaxed/simple;
	bh=9WzADrZdjdUfH12/+qDWM3o4Ogj8BkrLi/iCGgVDX24=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cwGZV0b+3+/ZSegcucWJIN8FSNnFJi1iTqAWVadBlKKHK9FEA8CwR0W+G1r8Skm2gCmnaP5hTgU/n0eNbLOFef0Pdn1mJTNKWiult6Hfd7zUl2MtEUQT1n6Z/Zzy8tul/Rv7gclf1RjlLUiPPYtyzIQpXsEI8iiPfJITR4xP1ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PeLk3ss2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0ECC1F000E9;
	Mon, 25 May 2026 06:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779691339;
	bh=bCdgkH9nmAyRn0yQWFmQu8U4I2xX4E8tFs1CsZyoCCw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PeLk3ss2DX2B6SqLkgcSSE/T4mIzOVkF3cRbTeT5YHYQI1nt0sFoR3HGnjQZEnLoE
	 AcCfH/cl6ujaGHMRmRUdID4TuiSZkSRUVd1gBVKVHM1idz65Qa1kaIQ2l2jGDUgngY
	 ZFPD/S2imEgt5PXSvlELehfxovv+eyn02o4TE494dds4sei73sasB9kmNjaGIBsfgP
	 8tsV3sLmh4lzOx3FJ/gbeNVYEliKrFsIpPBwJCZDfCx9lCHO6jkfVhM+CAaXq327CU
	 S3J3Lj0pqZppZT6rVHE1vTtbMFbi6B1n81zVPlLAaIWysmmpbzZfH6T/A4iyz+7dTU
	 g0LTUvb5ukyZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/12] dmaengine: dw-edma-pcie: Rename vsec_data to
 dma_data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260525062420.3315904-7-den@valinux.co.jp>
References: <20260525062420.3315904-7-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 06:42:18 +0000
Message-Id: <20260525064218.E0ECC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10826-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,sashiko.dev:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,valinux.co.jp:email,lists.linux.dev:replyto]
X-Rspamd-Queue-Id: 6FB645C6A4D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing pci_free_irq_vectors() cleanup in error paths after succes=
sful IRQ vector allocation.
--

commit 604d26e7f01e5ab8ae5de683ae38cd18428a8d21
Author: Koichiro Den <den@valinux.co.jp>

dmaengine: dw-edma-pcie: Rename vsec_data to dma_data

This commit renames the local data copy from vsec_data to dma_data in
dw_edma_pcie_probe() before adding endpoint DMA BAR metadata discovery.

> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-=
edma-pcie.c
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c

[ ... ]

> @@ -422,7 +420,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  		return -ENOMEM;
> =20
>  	/* IRQs allocation */
> -	nr_irqs =3D pci_alloc_irq_vectors(pdev, 1, vsec_data->irqs,
> +	nr_irqs =3D pci_alloc_irq_vectors(pdev, 1, dma_data->irqs,
>  					PCI_IRQ_MSI | PCI_IRQ_MSIX);
>  	if (nr_irqs < 1) {
>  		pci_err(pdev, "fail to alloc IRQ vector (number of IRQs=3D%u)\n",

[ ... ]

> -	chip->reg_base =3D pcim_iomap_table(pdev)[vsec_data->rg.bar];
> +	chip->reg_base =3D pcim_iomap_table(pdev)[dma_data->rg.bar];
>  	if (!chip->reg_base)
>  		return -ENOMEM;

[Severity: High]
This is a pre-existing issue, but does this function leak IRQ resources
on error paths?

It appears pci_alloc_irq_vectors() is successfully called earlier, but if
subsequent steps fail (such as the pcim_iomap_table() lookups returning NULL
here, or dw_edma_probe() failing later on), the function returns directly
without calling pci_free_irq_vectors().

Should these error paths be updated to ensure the allocated vectors are
properly cleaned up before returning?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525062420.3315=
904-1-den@valinux.co.jp?part=3D6

