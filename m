Return-Path: <dmaengine+bounces-10618-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGEvN+mrDmqmBAYAu9opvQ
	(envelope-from <dmaengine+bounces-10618-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 08:53:29 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FF659FB55
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 08:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73813301D6A8
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 06:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6564385D78;
	Thu, 21 May 2026 06:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+o9UBsB"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A521A6806
	for <dmaengine@vger.kernel.org>; Thu, 21 May 2026 06:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779346392; cv=none; b=ODsq5LHggULgSPfhZ63e7uSTrLR/VGwObxn5c9WlLvyDLs/rYamp0H7fwUV8lMqh2hchLsmOtDC4e3KnHg/KTZPNQ9oO7vh3JhwVNOXxaFKAow9dpJrbmeainXG3Vbr7nvs+9sRIJjb/rbXk7S5Hc0IZ6PTyEe+SIFA5ByfFth8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779346392; c=relaxed/simple;
	bh=hksHo7yYGOxk/Q+Us3BJnqA+1iCNDQ0PYeFYaVAATm0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XtDAeP6rBijABh+zJpdCGnuA08ttijN0QRKVjhnkPB5AyW4L+BsHbWrP9moOh3LpjzyrQstMdOvzAxPnEsh9u1IOjiOGLxgCidHw7vQ3PDnq2aovJj5b874vVVMO+56BDVmADsk37gL3sJLw+rhYeU9d7qUPc5OtAb0X0x7mf+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+o9UBsB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D13AD1F000E9;
	Thu, 21 May 2026 06:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779346391;
	bh=Y4UhoZqKpWwJnU0ZzVtpgdDaa+H3ap8EHZA8mFIg+vs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U+o9UBsBvGQHcewcnCGNGG/j62rVgWtZySW4uM0ReEgQ+/Igv7jTu0Tmj00gQ0gwq
	 +t8BTQnGxhgf4L63J5S6LhT8hKr7jce9ff+P2U2zZdXrQjV5FkQ97YHKAvULp5Zo5R
	 G+iXGDmWq13ZCm6KMgjw6ISf9uNNvuPMlSpgmF3fhkiw9rAbfuNYtCWu7sZ3gh1Xm8
	 PTWwC/lC6t+vAdYJVdbfrwL0rkEEXM+iL+aoYrDBH6/Hbf8q2wJ23jNWyXq5jjuQ7P
	 TSPFPcbmvukiGDueP/2/fgvX2ClrrdBVH78vQ0v9Ls1WNjQF+yh7xqIqfdvmcOKdqz
	 mi3EvMkdCtqMw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/12] dmaengine: dw-edma-pcie: Rename DMA data copy
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: Frank.Li@kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260521063115.2842238-7-den@valinux.co.jp>
References: <20260521063115.2842238-7-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 06:53:10 +0000
Message-Id: <20260521065310.D13AD1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10618-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lists.linux.dev:replyto,sashiko.dev:url,valinux.co.jp:email,smtp.kernel.org:mid]
X-Rspamd-Queue-Id: 41FF659FB55
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Failing to call pci_free_irq_vectors() in error paths leaks alloca=
ted IRQ resources.
--

commit 0a5096c2a8013c9330299acbbf7d9d940741c47c
Author: Koichiro Den <den@valinux.co.jp>

dmaengine: dw-edma-pcie: Rename DMA data copy

dw_edma_pcie_probe() now obtains DMA layout data through device-specific
capability callbacks, not only from PCIe Vendor-Specific Extended
Capabilities. Rename the local data copy from vsec_data to dma_data
before adding endpoint DMA BAR metadata discovery.

> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-=
edma-pcie.c
> index 043a7f73bf798..8ae164169c7e1 100644
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

> @@ -433,23 +431,23 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	/* Data structure initialization */
>  	chip->dev =3D dev;
> =20
> -	chip->mf =3D vsec_data->mf;
> +	chip->mf =3D dma_data->mf;
>  	chip->nr_irqs =3D nr_irqs;
>  	chip->ops =3D &dw_edma_pcie_plat_ops;
>  	chip->cfg_non_ll =3D non_ll;
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
This is a pre-existing issue, but does this error path (and others later in
the function) leak the allocated IRQ vectors?

pci_alloc_irq_vectors() was called earlier, but we are returning directly
without calling pci_free_irq_vectors() first. As stated in the PCI subsystem
guide, failing to call pci_free_irq_vectors() before returning on these
error paths permanently leaks IRQ resources.=20

Repeated transient failures during probe could potentially exhaust the
system's IRQ capacity, preventing other devices from allocating interrupts.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521063115.2842=
238-1-den@valinux.co.jp?part=3D6

