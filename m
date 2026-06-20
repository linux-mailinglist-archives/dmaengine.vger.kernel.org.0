Return-Path: <dmaengine+bounces-11670-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qfIVDZrKNmrOEwcAu9opvQ
	(envelope-from <dmaengine+bounces-11670-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 19:15:06 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 888BE6A956E
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 19:15:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Q3YujUOR;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11670-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11670-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 976AC300A392
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 17:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2403723E324;
	Sat, 20 Jun 2026 17:14:36 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B122405E1
	for <dmaengine@vger.kernel.org>; Sat, 20 Jun 2026 17:14:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781975676; cv=none; b=MhHNjEhmGzYV065MWwFKm5A4D/z0ff1ZfKdwHBIpuiaf0QdqZb5+zLB15j5Y/nIWQUOYhu9TrwRBiqdqhtHiJoVd+AG0B25+NM0HUzAK0X1EMFp6PlG4+9eBuw14uTOXOJMOLbNMiGfhLsh0clF6L4+E9UwzU/RZqzyK818Rv2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781975676; c=relaxed/simple;
	bh=qXAbHhrrFyoR+ztK7xSjPSIu1vyi79lUHo6x/b7Tug4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YFG0yCvGKLNNTa6NujwBtldSvYE4eP5T1Hw/alhQ6ImnpH+yCkLgY6N9udeJ5ZdoUbmtT9aIKeMpzoE8EFZgvGcS3q81ElA0LHiV40VjwC1SoJbMZLc4aADrhGLFGoP0a5xD9De+msfVxMQRKTkBWhhupfkAk+DQE3DDd7RkvJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q3YujUOR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A9B91F000E9;
	Sat, 20 Jun 2026 17:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781975674;
	bh=YRe6D4PcwSYeXviRHD63pW/y9a1ZxzWl67uz/TvmvIw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q3YujUORbnjbIcR8rURKoGHjD7bOnNOWnB5sNhvvdQhUByg0wNMma3kcFIcM30w+G
	 nec2h3sHUKwmBmlEmqZ1Nj43fUVQBlhsPxhX1kGsRUW40hdv2RhB0YlNjdT1mZSxLw
	 TgB1hT6NrZOERW6NakPFAZYmlh3v0JAO0fXFm60LOl+s8fGRvscnOK27HzcKKYda/t
	 8to6QZ4pZo9cT3jE6EbG5d//ksirpFxj67kqvN9fLRIW4HBWOXmmO53mZfcXxVs6Hu
	 H1u00lrl0bf5t4EuzRuNiQEUA402n16a1BFOM6BMEfFT9BXe4tGAUxuSG+lARbRjmc
	 cKyfMaEFi23eg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 12/13] dmaengine: dw-edma-pcie: Handle optional data
 blocks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260620170040.3756043-13-den@valinux.co.jp>
References: <20260620170040.3756043-1-den@valinux.co.jp>
 <20260620170040.3756043-13-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 Jun 2026 17:14:34 +0000
Message-Id: <20260620171434.8A9B91F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11670-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:den@valinux.co.jp,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,m:Frank.Li@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lists.linux.dev:replyto,vger.kernel.org:from_smtp,valinux.co.jp:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 888BE6A956E

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing pci_free_irq_vectors() in error paths after successful pci=
_alloc_irq_vectors() causes IRQ resource leaks.
--

commit 4c520b14ae411615c26fba953ffdb3c7f374c19a
Author: Koichiro Den <den@valinux.co.jp>

dmaengine: dw-edma-pcie: Handle optional data blocks

This commit skips data block BAR mapping and debug output when a channel
has no data block size. This prepares the driver for future metadata
providers where a zero-sized data block indicates it is not present.

> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-=
edma-pcie.c
> index 62740c8c3f939..622ec974a521e 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
[ ... ]
> @@ -498,6 +500,9 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  							  ll_block);
>  		ll_region->sz =3D ll_block->sz;
> =20
> +		if (!dt_block->sz)
> +			continue;
> +
>  		dt_region->vaddr.io =3D pcim_iomap_table(pdev)[dt_block->bar];
>  		if (!dt_region->vaddr.io)
>  			return -ENOMEM;

[Severity: High]
This isn't a bug introduced by this patch, but does this error path (and
several others in this function) leak IRQ vectors?

Earlier in dw_edma_pcie_probe(), pci_alloc_irq_vectors() is called to alloc=
ate
the IRQ vectors. However, multiple subsequent error paths, such as this ret=
urn
when pcim_iomap_table(pdev) returns NULL, return an error directly without
cleaning up the allocated IRQ vectors.

There are also similar error paths later in the function that fail to call
pci_free_irq_vectors(), such as:

	if (!pci_dev_msi_enabled(pdev)) {
		pci_err(pdev, "enable interrupt failed\n");
		return -EPERM;
	}

and:

	err =3D dw_edma_probe(chip);
	if (err) {
		pci_err(pdev, "eDMA probe failed\n");
		return err;
	}

Since the driver manually frees these vectors in dw_edma_pcie_remove(), sho=
uld
the probe function also perform its own cleanup on failure to prevent IRQ
resource exhaustion?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260620170040.3756=
043-1-den@valinux.co.jp?part=3D12

