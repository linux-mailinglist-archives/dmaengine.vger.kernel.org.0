Return-Path: <dmaengine+bounces-10825-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJmaLy/vE2qmHgcAu9opvQ
	(envelope-from <dmaengine+bounces-10825-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 08:41:51 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5898A5C6A46
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 08:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A9E163001A6F
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 06:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447A772627;
	Mon, 25 May 2026 06:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTGsk3YU"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25415313532
	for <dmaengine@vger.kernel.org>; Mon, 25 May 2026 06:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779691305; cv=none; b=Si8+2t0kdRF8WhNW5sMCBRPoXAWZllvO3q1DBdvQa3mgGj3I70DYQ4ZuoUILp+ooh+avAx+r5lVhCbwHohld4CTtNLmxusnKE4MXAfnZmzYdq3i88bnFptANrcu3CTPCL4qV9vh1x7HRb+udiKubEKYkRpn3DIB06MT6VGwq7do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779691305; c=relaxed/simple;
	bh=7tM0B9XvFK/E5BhVtyeJ2gQALLxiSovjX/MoaSnyF2g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QIhU1AiMbBPZYhp4KPnYKGvmMn0eT2P100/MYcQtYnI01kNXlc3p+lYJ00nuQJzsqRJHauB/SBfE2rouRFlva4n/A7uok9Iceq+dpwYpNY/Kt2nYARxtv1a/XbF033f1gotRSXikwhVcts6kLKpAGBogNBF40grGC5/Ru0PprFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QTGsk3YU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 966AB1F000E9;
	Mon, 25 May 2026 06:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779691303;
	bh=SMbmPUHI9aajHTpqMtISQ3IoNVLRtFjOWCNMDn4vtJk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QTGsk3YUl0DmLYQMGlK6g1dCQboEVIRxIE2OB1Uz4mZy2qHEH4swkGYOyiWaSLWGk
	 JjB0PoShF02b7e8K6a6nC98UqSqlV4AYOghm5g9Z5TpFGFud7H351Dq51QCy/WXHDK
	 TPr0ly9aPUD1qrzrZmKBHNnSDbEm45qQ/IpcBHpxBtffHFyHBfR0/kAQa4C3CgnLqw
	 UDYx5Y6xAYfphtKN/k1GaSaKmv8GgWK9WzI0CNkFq63iUm8IXhkXi3oGCwRVb9uv9u
	 kodJZfW79fh42LdsbUgVCGU6n223krnyhMS0UvKCeNFP1Prk1GwVCDbaXL0TVlsEPc
	 3VO7wiZStqM7w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/12] dmaengine: dw-edma-pcie: Add capability match
 data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: dmaengine@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260525062420.3315904-6-den@valinux.co.jp>
References: <20260525062420.3315904-6-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 06:41:43 +0000
Message-Id: <20260525064143.966AB1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10825-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,valinux.co.jp:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,sashiko.dev:url,smtp.kernel.org:mid]
X-Rspamd-Queue-Id: 5898A5C6A46
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing pci_free_irq_vectors() on error paths in dw_edma_pcie_prob=
e().
--

commit 48d4b511212a933d1db52415cfad336029849db0
Author: Koichiro Den <den@valinux.co.jp>

dmaengine: dw-edma-pcie: Add capability match data

Move device-specific capability parsing behind per-device match data. Split
static template decisions from device-specific capability parsers to allow
discovery via match data.

> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-=
edma-pcie.c
> index e92ff5dc6f674..5a6f5af358d0f 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c

[ ... ]

> @@ -424,8 +456,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  			return -ENOMEM;

[Severity: High]
This isn't a bug introduced by this patch, but does returning here (and in
other error paths in this function) leak the IRQ vectors allocated earlier?

Looking at dw_edma_pcie_probe(), pci_alloc_irq_vectors() is called
successfully, but if later steps like pcim_iomap_table() fail or
dw_edma_probe() returns an error, the function returns directly without
calling pci_free_irq_vectors().

Should all error paths after IRQ allocation call pci_free_irq_vectors() to
prevent exhausting system IRQ capacity?

> =20
>  		ll_region->vaddr.io +=3D ll_block->off;
> -		ll_region->paddr =3D dw_edma_get_phys_addr(pdev, vsec_data,
> -							 ll_block->bar);
> +		ll_region->paddr =3D dw_edma_get_phys_addr(pdev, match,
> +							 vsec_data, ll_block->bar);
>  		ll_region->paddr +=3D ll_block->off;
>  		ll_region->sz =3D ll_block->sz;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525062420.3315=
904-1-den@valinux.co.jp?part=3D5

