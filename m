Return-Path: <dmaengine+bounces-11672-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8odNHcHKNmrTEwcAu9opvQ
	(envelope-from <dmaengine+bounces-11672-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 19:15:45 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 005D36A9577
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 19:15:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=XmR0Ij6J;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11672-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11672-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA179300361B
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 17:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885043246FE;
	Sat, 20 Jun 2026 17:15:43 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD46322A2E
	for <dmaengine@vger.kernel.org>; Sat, 20 Jun 2026 17:15:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781975743; cv=none; b=p0oP0loD0y5+m4axA44TsTID2/pp0fNX8at7WLzxYDxjEJ1d4C9JqQA72Ie0Yrr0sbPHdd3Ey3aBPxoY65YxqwdMskrAVu5W7ByvXpmyIDHQGmwMpkRBkY7Wt0zMANEirpazstggvejEBW20tAU4PngYemxg5P5TqciHlkcklpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781975743; c=relaxed/simple;
	bh=HnT4nSd3cox0MjBYQ3y3APK8LUhPUqagkReezFWKHdE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FtPTWybI+W1qaOWNdGjy0usXtuPiJQnpZadG7H5wDFWiFnoxzxrPt6tthmWcfIusHVguBX4ZFtvO2iv1AfdPlnPH4tLrvR6uvXu+TlyjBLS4kzrsmMV+58muynzRRh3JQZm7mXR6wB999HJeOYKFgILHx+Vv8RcxrvgxSEnw+as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XmR0Ij6J; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E59501F000E9;
	Sat, 20 Jun 2026 17:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781975742;
	bh=Bc389PPrRDKYz7AjPIUtMVLEhS1a/TWc+tJK6Wq71x0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XmR0Ij6JUY5NKpYkrdbNd7mTqHAml5qKtTKe572MmIGSY1l7Kttr77sYlzGgEDImY
	 T2UdJxoiPj51TskygDh7PWwXLcIFpfarCZ3sx4zs0lraeMch0iHFl/9OQHkZFpGdoo
	 6t8qU0MdhDupuKkc22mfikKIUzmKb1ko0h5nQQUYvRx3juVpnPNk0oOyTl2GWvnlym
	 /MEEwc9F+++X/X0eYC1bmd6g1vdZ5zkl9RGeejWKqwP4qKl6BVp/fUbmbV23bnAy+s
	 cWvbww7+ZdsMkJNfoGw/CDZuWS/h4y2BQrp6L4l1DMaYJ8q4CBjkvZBOd1SVWWkoiK
	 JCdKEHUlveK9w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 06/13] dmaengine: dw-edma-pcie: Track non-LL mode in
 DMA data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: dmaengine@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260620170040.3756043-7-den@valinux.co.jp>
References: <20260620170040.3756043-1-den@valinux.co.jp>
 <20260620170040.3756043-7-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 Jun 2026 17:15:41 +0000
Message-Id: <20260620171541.E59501F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-11672-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:den@valinux.co.jp,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:email,vger.kernel.org:from_smtp,lists.linux.dev:replyto,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 005D36A9577

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Calling pci_free_irq_vectors() in remove() violates API guidelines=
 for devices enabled with pcim_enable_device() and leads to a double free.
--

commit 4807e012ff4fafc258bc7806f34cdce5751bf7bf
Author: Koichiro Den <den@valinux.co.jp>
Subject: dmaengine: dw-edma-pcie: Track non-LL mode in DMA data

The dw-edma-pcie driver copies static template data into a mutable
dw_edma_pcie_data instance before applying capability-derived updates. This
commit keeps the derived non-LL mode in that copy as well.

> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-=
edma-pcie.c
> index 70ea031147d18..0ea8d59782b44 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c

[ ... ]

> @@ -326,7 +327,6 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	struct dw_edma_chip *chip;
>  	int err, nr_irqs;
>  	int i, mask;
> -	bool non_ll =3D false;
> =20
>  	if (!pdata)
>  		return -ENODEV;

This is a pre-existing issue, but I noticed a potential problem in how this
driver handles IRQ cleanup.

[Severity: High]
Does dw_edma_pcie_remove() result in a double-free of the IRQ vectors?

This driver calls pcim_enable_device() in dw_edma_pcie_probe(), which marks
the PCI device as managed. Later in the probe function,
pci_alloc_irq_vectors() is called, which automatically registers a devres
action to free the vectors on device detach.

However, dw_edma_pcie_remove() manually calls pci_free_irq_vectors():

drivers/dma/dw-edma/dw-edma-pcie.c:dw_edma_pcie_remove() {
	...
	/* Freeing IRQs */
	pci_free_irq_vectors(pdev);
}

Since the devres action remains registered, will it attempt to free the IRQs
again, causing a double-free on driver unload?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260620170040.3756=
043-1-den@valinux.co.jp?part=3D6

