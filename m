Return-Path: <dmaengine+bounces-10620-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OZ1GCetDmr6AwYAu9opvQ
	(envelope-from <dmaengine+bounces-10620-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 08:58:47 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A7C59FC7F
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 08:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 14361300766C
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 06:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4E33368B6;
	Thu, 21 May 2026 06:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRnUkAto"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFE53546E0
	for <dmaengine@vger.kernel.org>; Thu, 21 May 2026 06:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779346529; cv=none; b=ePAMPqRNsy888TS/dBXNIerkBcgxPlvDmZRj6fPm6e0sth8YGaDjb0B8U++8xMK3eorX7XTOBhUKmfdso+iCppHXeFGx/WKAyE7Bcg92RsexB74XAJNNg4Iw74LQkWZqum50rbYDzFyG9c16b+bQIoe7SNDe+0LTnOxDx6D6pmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779346529; c=relaxed/simple;
	bh=+gmBjPHlzww0hd1H/SMUs9VGtj2VcNXYlhM2fulu3rA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VI/kchjg+ygTvu4Pe7QR0yAzUIum9YCVg5z0gAjgDiK45z4Mpa6YVk7ETGl6LTfH6to0XQnRrTCmcLRKn0RVhn/W0rWxeeVdpzkGbuUwaLUm7wltJIyQloy3Ffp7wkWX8Z8HWCFjqyJv+ndS9MJgXtjJq/Y2PACwEVjy9+iFkUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gRnUkAto; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A822B1F000E9;
	Thu, 21 May 2026 06:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779346528;
	bh=iqJojMp878TDvhZ+sXtrOjCuMyH8Cp67COil1MesxSA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gRnUkAtoAl/URW+RCgPzvudRPesl1zJDQkDbApY5I4wMXPCBtbV3YbhdRVrKA+N9T
	 0WAvX9+gtwxt710yUlUnW26Xaohc+NhOuAQeqvkE4xHiYRgzYIRCfYb48JiQ+J0E1k
	 NInw9FapAoBddSQ0EBWz+jpxGitwGfROqaSX5GBExgtH/f9oGrdviG7Rk4FiwufWGE
	 /dAP2Sbk5/5xcmxzWLAzmdJhz/S61HTKhYjvQknQNxOs1p26PizFZn1nR5f/hnzKhm
	 zXOFggGTgNdSiwxE2OjVnHEqGJ/6aJ5xp8Wl+/zd9SvC+YokimKETnsPLdBddIoXrI
	 4LPms9RK0p0ug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/12] dmaengine: dw-edma-pcie: Handle optional data
 blocks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: dmaengine@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260521063115.2842238-12-den@valinux.co.jp>
References: <20260521063115.2842238-12-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 06:55:27 +0000
Message-Id: <20260521065527.A822B1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10620-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,smtp.kernel.org:mid,sashiko.dev:url,lists.linux.dev:replyto,valinux.co.jp:email]
X-Rspamd-Queue-Id: C1A7C59FC7F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing pci_free_irq_vectors() on error paths after successful all=
ocation leaks IRQ resources.
--

commit ffb39523070415905152724035835f0ef0303b0c
Author: Koichiro Den <den@valinux.co.jp>

dmaengine: dw-edma-pcie: Handle optional data blocks

This commit updates the driver to skip data block BAR mapping and debug
output when a channel has no data block size. This allows describing
channels that only need descriptor memory exposed, with a zero-sized
data block indicating it is not present.

> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-=
edma-pcie.c
> index 2a95fb9d5fc3f..df02b244e7487 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c

[ ... ]

> @@ -483,6 +485,9 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
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
This is a pre-existing issue, but does returning directly here leak the IRQ
vectors allocated earlier?

Earlier in this function, the IRQs are allocated like this:

    nr_irqs =3D pci_alloc_irq_vectors(pdev, 1, dma_data->irqs,
                                    PCI_IRQ_MSI | PCI_IRQ_MSIX);

Should this error path, as well as the other similar error paths following
the IRQ allocation, call pci_free_irq_vectors() before returning to prevent
potentially exhausting system IRQ capacity?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521063115.2842=
238-1-den@valinux.co.jp?part=3D11

