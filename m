Return-Path: <dmaengine+bounces-10622-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMNWFziuDmr6AwYAu9opvQ
	(envelope-from <dmaengine+bounces-10622-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 09:03:20 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 897E159FDA1
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 09:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C504D302009F
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 07:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62B1366836;
	Thu, 21 May 2026 07:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJAn1mMY"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE42517B43F
	for <dmaengine@vger.kernel.org>; Thu, 21 May 2026 07:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779346992; cv=none; b=oloU41nl6EMq99NtQiEMnI+PL6IRiTmXpx+s2LUYEviJA2ty2jOBB5SWxNQ9rByTGCdqm0utFKcr8uoNfGgfpCQfTUwYy1Pqrss45kjHYW6GVgIGXs8qsg2gnHJAnohh4S0QCtEmKcmMIccYSb653tG4/ChETCZQ2V64uDZrBBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779346992; c=relaxed/simple;
	bh=Us95u1/qxKPSCZqNOVgfmjPQakiqJpCY9CKG+9tsFnA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i8/y3huKnPPDmNx1Ze78rzWX++9NBVoi5oH5n62j5WZZDilb5xP+pTtd6DtatnKCuUz/a5RZcJ8I0YeYRVuNoGFNCB9JTvzo51W02uowV+ucRLcb3qvoUf3eIlETg7yS7Ypt5m8d0fo+1y8/HD1UqeY4viJXxLHiVGR6c4DX3JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJAn1mMY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CF881F000E9;
	Thu, 21 May 2026 07:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779346991;
	bh=xrwBP7oDqT+xhmvIwodlpZzrOlCgqEK5kc1DvGBDlIE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kJAn1mMYQVhEUQAidz5NsEIVH7gwjYajSmhtfuQRPaKgleE4O8DGBKfPYeHJMt/je
	 hEB5PdT9fvF7IsUKL7dWwf/xw/uEeHN++iMnWa63fSlaFHS3KVq1DC+Hkz9Gp3oZLD
	 6w6hnmTSaXYtTSxmy9lsCVungNVZIz9iSjE1KTx/rgVYj2XWbUeTAkgvxFMSR/Xm/C
	 O54+k6TjMdO3uhqMucejYDSW9FJD7onpubNYW8ljmAH6J28iH2WrOKUt2chTwt+vjT
	 dfQARhphZEQAiDwd9R37jRQvvTcB4NDcM3P3zbF6xp42Z2g7FKi+RLfoJIkRlQ/Wzd
	 018Nr4+Pw3UKQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/12] dmaengine: dw-edma-pcie: Add chip flags match
 data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: dmaengine@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260521063115.2842238-13-den@valinux.co.jp>
References: <20260521063115.2842238-13-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 07:03:10 +0000
Message-Id: <20260521070311.2CF881F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10622-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	RSPAMD_URIBL_FAIL(0.00)[sashiko.dev:query timed out];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_THREE(0.00)[4];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,sashiko.dev:url,smtp.kernel.org:mid]
X-Rspamd-Queue-Id: 897E159FDA1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing pci_free_irq_vectors() on error paths in dw_edma_pcie_prob=
e() causes IRQ resource leak.
--

commit d8cbd780b5a68286e708214b11a9459c55d2af3b
Author: Koichiro Den <den@valinux.co.jp>

dmaengine: dw-edma-pcie: Add chip flags match data

Allow PCI ID match data to pass dw_edma_chip flags into dw_edma_probe().
This keeps per-device policy in the match data instead of open-coding it
in probe().

> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-=
edma-pcie.c
> index df02b244e7487..2f752e8fb999c 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
[ ... ]
> @@ -455,6 +456,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	chip->dev =3D dev;
> =20
>  	chip->mf =3D dma_data->mf;
> +	chip->flags =3D match->chip_flags;
>  	chip->default_irq_mode =3D match->default_irq_mode;
>  	chip->nr_irqs =3D nr_irqs;
>  	chip->ops =3D match->flags & DW_EDMA_PCIE_F_RAW_SLAVE_ADDR ?

[Severity: High]
This is a pre-existing issue, but does this function leak IRQ vectors
on error paths?

In dw_edma_pcie_probe(), pci_alloc_irq_vectors() successfully allocates
MSI/MSI-X IRQ vectors. However, multiple subsequent error paths return
directly without calling pci_free_irq_vectors() to clean up.

For example, when pcim_iomap_table() fails later in the function:

	chip->reg_base =3D pcim_iomap_table(pdev)[dma_data->rg.bar];
	if (!chip->reg_base)
		return -ENOMEM;

Should these error paths call pci_free_irq_vectors() before returning
to prevent exhausting system IRQ capacity?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521063115.2842=
238-1-den@valinux.co.jp?part=3D12

