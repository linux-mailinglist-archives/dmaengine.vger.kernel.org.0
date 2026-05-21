Return-Path: <dmaengine+bounces-10616-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KILzAoerDmr6AwYAu9opvQ
	(envelope-from <dmaengine+bounces-10616-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 08:51:51 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6155059FAE3
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 08:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C1A33009516
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 06:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1063368B6;
	Thu, 21 May 2026 06:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YIrDtHB4"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12AF346A1D
	for <dmaengine@vger.kernel.org>; Thu, 21 May 2026 06:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779346307; cv=none; b=dR/vEWcQl9oFebKcEex08w8v6zW07+POFMtZQHAYiMoCCUN5xlqTGBM5OJGmT5pHXWSV78uX1sPb8FFu9+/nDhVxVu1gXEG0s89NmSMOSGHAwRBMoe8Eu1XSv0RpdfA9WeNjOUdoa2+DnkhM33GLoiVzeGPtoJ/YHFoPBTMAPiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779346307; c=relaxed/simple;
	bh=EJrXQIZOKFKOSYJP+gXy9/i3CfzGt+FM65SeMy7RL4E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kQpvtW1T8dpX0CmyTM45azskG+swLrSx+6TIzOlqfP/ftketOSvgi4PUvdebc68zu9aTR0wTqFySycAg4g3ANA2tV/u2BZUsqTs8SGfbnEKMTfxYUg6bIJ4vM9SZif/9GiprzDyGED6YCajqF3FG+ONE3DVaqpuMiSI1FaBn3lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YIrDtHB4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C5F91F000E9;
	Thu, 21 May 2026 06:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779346306;
	bh=KfLEv4F8jS2vuDAfQpMeBo86+mdAic2CSx2JdLWyJS0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YIrDtHB4/hucGhdz/cd4GkisoMJ/yKa6tIP3FY/nz7Y4InFsBQMz9rTEiwvVy836U
	 aEfD84GGbeY0Qs46Okh9je8iXwY2OF9aVZlcGM3XxD2QE0Zbf/qlWkMDCo91e3QZiz
	 eAaN6yrCnH9Y64PJp5O++5wovPPm4vrjMtS4vYzLYqCK7fQcTCHA/k1quIv+nK6Mzn
	 NmwkwLsSOkQJhV8EejtVyNhMi9HwuvSX9z3bNQ4kuHnYId4tymBMCOKtxYVur9FaHB
	 wq5Zmw+Iht5Ntrk6afqyfXkkm4+rVJtues2kG1fv/ZV0TixcEHX/jvPxoMZMfWohsi
	 XvpMZOqtmNkJg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/12] dmaengine: dw-edma-pcie: Add capability match
 data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: Frank.Li@kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org
In-Reply-To: <20260521063115.2842238-6-den@valinux.co.jp>
References: <20260521063115.2842238-6-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 06:51:45 +0000
Message-Id: <20260521065146.3C5F91F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10616-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lists.linux.dev:replyto,valinux.co.jp:email,smtp.kernel.org:mid]
X-Rspamd-Queue-Id: 6155059FAE3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing pci_free_irq_vectors() cleanup in multiple error paths wit=
hin dw_edma_pcie_probe().
- [High] Unchecked dereference of the driver_data pointer can cause a kerne=
l panic if the driver is dynamically bound via sysfs.
--

commit 1a656dcd04018171f5ee1ff87e07601cfc437921
Author: Koichiro Den <den@valinux.co.jp>

dmaengine: dw-edma-pcie: Add capability match data

Move device-specific capability parsing behind per-device match data.

The existing probe path mixes two decisions: which static template a PCI
ID uses, and which device-specific capability parser adjusts that
template. Split those decisions so device-specific discovery can be
added through match data instead of adding more vendor checks to
dw_edma_pcie_probe().

> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-=
edma-pcie.c
> index 0b30ce1385036..043a7f73bf798 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
[ ... ]
> @@ -295,19 +308,61 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct=
 pci_dev *pdev,
[ ... ]
>  static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  			      const struct pci_device_id *pid)
>  {
> -	struct dw_edma_pcie_data *pdata =3D (void *)pid->driver_data;
> +	const struct dw_edma_pcie_match_data *match =3D (void *)pid->driver_dat=
a;
> +	const struct dw_edma_pcie_data *pdata =3D match->data;

[Severity: High]
This isn't a bug introduced by this patch, but does this lack of validation
for pid->driver_data risk a kernel panic if the driver is dynamically bound
via sysfs?

If a user dynamically binds the device (e.g., writing to the new_id file),
pid->driver_data defaults to NULL, which would cause a NULL pointer
dereference when accessing match->data.

>  	struct device *dev =3D &pdev->dev;
>  	struct dw_edma_chip *chip;
>  	int err, nr_irqs;
[ ... ]
> @@ -424,8 +456,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  			return -ENOMEM;

[Severity: High]
This is a pre-existing issue, but does returning directly here leak the IRQ
vectors allocated earlier?

The probe function successfully allocates IRQ vectors using
pci_alloc_irq_vectors() prior to this point. Failing to free IRQ vectors on
error paths leaks IRQ resources and can potentially exhaust system IRQ
capacity.

There are multiple other error returns after this point (such as failures
from pci_dev_msi_enabled() or dw_edma_probe()) that also appear to miss
calling pci_free_irq_vectors() before returning.

>  		ll_region->vaddr.io +=3D ll_block->off;
> -		ll_region->paddr =3D dw_edma_get_phys_addr(pdev, vsec_data,
> -							 ll_block->bar);
> +		ll_region->paddr =3D dw_edma_get_phys_addr(pdev, match,
> +							 vsec_data, ll_block->bar);
>  		ll_region->paddr +=3D ll_block->off;
>  		ll_region->sz =3D ll_block->sz;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521063115.2842=
238-1-den@valinux.co.jp?part=3D5

