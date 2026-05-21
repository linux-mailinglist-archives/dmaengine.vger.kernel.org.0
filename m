Return-Path: <dmaengine+bounces-10613-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6O9BO2OqDmr6AwYAu9opvQ
	(envelope-from <dmaengine+bounces-10613-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 08:46:59 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 546B959F9C8
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 08:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3596630053C9
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 06:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0E71A6806;
	Thu, 21 May 2026 06:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJ6v27pY"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF46292B4B
	for <dmaengine@vger.kernel.org>; Thu, 21 May 2026 06:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779345987; cv=none; b=rjrd2vvbFkp7Hc4FThZwTJcT1P8A5zEfSH/qcIMXCi7eDrpFN1RvnrV/MihKRDfYdNeyEPQxkzWVcB/D0uM81Vo/0hnH4IUG63RLf6lDEZ1jW3EmvobDuaXy1BSfCz1ewOlAcl9oXuaOAMmLTxGLMU+XACobmPVC0oMlg9qYR3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779345987; c=relaxed/simple;
	bh=+TM7cOL/ranbeb2jJKKtq9npfjoKYPs/mmlN6qMssvQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NiZbcawjr28m5cAiTm+CUS9lsFwZTQCEa7FZbFKnuqiF+nHNplmf63Ll7FFpy2KguQcmtUhMM4iWoVn35uQbvK61Q/GCAOyC9s3SXJztJET0cHHxXqH6fCEFl9vymednGojxPeeR1mMEWTR8lZnh8pdbi93A5avfEEulQHJBWeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJ6v27pY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A77D61F000E9;
	Thu, 21 May 2026 06:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779345986;
	bh=I0y8RUF3Mg0zVzmC8FtDq+tEfq5RazMWfXyppvfK4/s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eJ6v27pYxHBvGCbKnqGUlHzoKfqaP/GXHsUDbcXGJCZ3NhkSiN6zDVfVskI2915Ca
	 z7/yX/vkCfY/TLgCpylohQXrIb0zRDJ7nB42kNEyc9qHn4V+cMfSLMqAdbLj0nkaS+
	 +VRBPenCuaa146wjYEKWbYJHpXFejbT5bbzF3K0dXhmokKc8ZaQMLIAiyzl1L0qT4F
	 v6ClAF+NRUp0fLOVfdOSkKUeEQ30mIlk280OiUuO3XUWphD8M89SK4Mw4aDbFI9MQ4
	 Z4N/TJA4u8xR6ZzD+oEkgDkAtS6ZTkqfX/ZPElvOremX2g0zhzfZz1bKwT0W3t1h8B
	 LUY6mmiczAyaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/12] dmaengine: dw-edma-pcie: Add register offset
 match flag
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: Frank.Li@kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org
In-Reply-To: <20260521063115.2842238-10-den@valinux.co.jp>
References: <20260521063115.2842238-10-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 06:46:25 +0000
Message-Id: <20260521064625.A77D61F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-10613-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,valinux.co.jp:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 546B959F9C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Failure to call pci_free_irq_vectors() in error paths after succes=
sful allocation in dw_edma_pcie_probe().
--

commit b1a3bd1859bef8f97300ebe53456cdf2659af1d6
Author: Koichiro Den <den@valinux.co.jp>

dmaengine: dw-edma-pcie: Add register offset match flag

This commit adds a match-data flag that enables devices to specify an offset
for the DMA register block inside the mapped BAR. Existing match data entri=
es
keep using the BAR mapping base directly without functional changes.

> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-=
edma-pcie.c
> index 651269708cc54..6b375a58c5508 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c

[ ... ]

> @@ -450,6 +451,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	chip->reg_base =3D pcim_iomap_table(pdev)[dma_data->rg.bar];
>  	if (!chip->reg_base)
>  		return -ENOMEM;

[Severity: High]
This isn't a bug introduced by this patch, but does returning directly here
leak IRQ resources?

Earlier in dw_edma_pcie_probe(), pci_alloc_irq_vectors() is successfully
called to allocate resources:

    nr_irqs =3D pci_alloc_irq_vectors(pdev, 1, dma_data->irqs,
                                    PCI_IRQ_MSI | PCI_IRQ_MSIX);

It appears that failing to call pci_free_irq_vectors() in this error path
(and several other error paths further down in the function) could prevent
future allocations and exhaust system IRQ capacity.

> +	if (match->flags & DW_EDMA_PCIE_F_REG_OFFSET)
> +		chip->reg_base +=3D dma_data->rg.off;
> =20
>  	for (i =3D 0; i < chip->ll_wr_cnt && !non_ll; i++) {
>  		struct dw_edma_region *ll_region =3D &chip->ll_region_wr[i];

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521063115.2842=
238-1-den@valinux.co.jp?part=3D9

