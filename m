Return-Path: <dmaengine+bounces-10827-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOl6N4rvE2qmHgcAu9opvQ
	(envelope-from <dmaengine+bounces-10827-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 08:43:22 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D8D5C6AAA
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 08:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 438EE30058FB
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 06:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91283A8755;
	Mon, 25 May 2026 06:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RpJ0ihhR"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6E13A7F55
	for <dmaengine@vger.kernel.org>; Mon, 25 May 2026 06:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779691390; cv=none; b=bN9PY+MF1t4lzPbHjSwZTvvwnrpZQzW9c1Ak2Xdwy1Wm6D6pS8MS+VcLBeQmCBj9Jy3apRM98Tv5oEpMEkWit7Rhr4/J/rxAE0SbQ0IOHXjrJkm1+w46z5lTtx3xvBy1Dn/uQ9NA4YQ1lB6NNyQG6bIL6Xr2QFEk2V44XX4KMhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779691390; c=relaxed/simple;
	bh=bEifnqMs+q3xsUGdauiRWMI7e/HSm46XnQXhNYIl8iU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IhbaO16+Dr78bfiDocHdt2VDu0U5k5asxpZq6M4vpw1uBRwnzCdVlqoaGZ1Mm9QKFHow/C2FESPS+ULY4P0iDkehCAbeBLl6yVB+XzCCCTREntuJafb72ijg5no6gE8rW5/t2sqdu45cK/f7vWID+tEe9TbWHR36aOB/2P8t1n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RpJ0ihhR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F28051F000E9;
	Mon, 25 May 2026 06:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779691385;
	bh=w/9ujnYWoZ5+Q/2yTVRM7nzDTQ7TqJVtabEP9kxMDIw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RpJ0ihhRX7VCPrp95N1Uei3L7UExH77GW8IRLxsUc4nbypPmbPK3Dw06UGBvPyn2K
	 37C1rLAClWrm4220NFpjEOg+tuAMLM2plSz6o6MTN0psmwSwFHzI2iN+HJt1JWG4OS
	 CIR04efMbZIPZ2GTUPqJsvgdFzGAk0lUwOqTLToSqWe014F+LT0TyE5BoTEz9+O4Be
	 meTTn2W9o8GvN0Al/f29rJH1JVWyM7Wx6V3FotHGEsePokiLrf7Vz3Gy3qdwZPd/wg
	 NkQXC6hNSWJa99o+m33yOnxlDHXFZaH6rIyL2+FxJ/qs+ve07u6huaBqbC0VX41XTE
	 gFuZKDSRagqyg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/12] dmaengine: dw-edma-pcie: Add platform ops to
 match data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260525062420.3315904-9-den@valinux.co.jp>
References: <20260525062420.3315904-9-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 06:43:04 +0000
Message-Id: <20260525064304.F28051F000E9@smtp.kernel.org>
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
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10827-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,smtp.kernel.org:mid,sashiko.dev:url,lists.linux.dev:replyto]
X-Rspamd-Queue-Id: 84D8D5C6AAA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unconditional dereference of `match` when derived from `pid->drive=
r_data`, which can be NULL if bound via the sysfs `new_id` interface.
- [High] Double-free risk of IRQ vectors due to explicitly calling `pci_fre=
e_irq_vectors()` while using managed `pcim_enable_device()`.
--

commit 071f84626ae62c03bf1cfe1223de5d9ebdcd55e6
Author: Koichiro Den <den@valinux.co.jp>

dmaengine: dw-edma-pcie: Add platform ops to match data
   =20
Move the platform ops pointer into match data. Existing EDDA/MDB matches
keep using dw_edma_pcie_plat_ops.

> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-=
edma-pcie.c
> index 9aed1005854dc..1d63b07723f93 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
[ ... ]
> @@ -383,7 +384,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  		return -ENOMEM;
> =20
>  	/* Let device-specific discovery override the static template data. */
> -	if (!match->parse_caps)
> +	if (!match->parse_caps || !match->plat_ops)

[Severity: High]
This is a pre-existing issue, but since this patch adds new dereferences
of match, what happens if the driver is bound via the sysfs new_id interfac=
e?

If a user dynamically binds the driver without providing the optional=20
driver_data field, pid->driver_data defaults to 0. The probe function
derives match from this and dereferences it, which could lead to a NULL
pointer dereference.

[ ... ]
> @@ -577,11 +578,13 @@ static void dw_edma_pcie_remove(struct pci_dev *pde=
v)
> =20

[Severity: High]
This isn't a bug introduced by this patch, but is there a double-free risk
for IRQ vectors during removal?

The probe function initializes the PCI device using pcim_enable_device():

drivers/dma/dw-edma/dw-edma-pcie.c:dw_edma_pcie_probe() {
	/* Enable PCI device */
	err =3D pcim_enable_device(pdev);
...
}

This automatically configures IRQ vector cleanup via devres. However,
the driver explicitly calls pci_free_irq_vectors(pdev) in
dw_edma_pcie_remove().

Could this lead to a double-free issue when the devres cleanup also attempts
to release the IRQ vectors?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525062420.3315=
904-1-den@valinux.co.jp?part=3D8

