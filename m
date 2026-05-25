Return-Path: <dmaengine+bounces-10830-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IK8bH77yE2puHwcAu9opvQ
	(envelope-from <dmaengine+bounces-10830-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 08:57:02 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DE45C6D06
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 08:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 069A43057E2A
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 06:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2730D3ACA45;
	Mon, 25 May 2026 06:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ljL0IjUo"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A5A3ABDA4
	for <dmaengine@vger.kernel.org>; Mon, 25 May 2026 06:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779691978; cv=none; b=aFTrkiMe3iEeNY+6I09mo09SoggRYxJlxBSUvJj4H2+i2e0wHm3XWn2KFlze6Pb53a7/SiJNoRGBQ8KQjP50d/e+s2/Dm29bo3SNWMv7HUbk/dHDSDZMLhILUsdjVjRXkKEcYpzXYe1xJQ8TXmHsHtM1z7NQGR0hp2is60TdjgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779691978; c=relaxed/simple;
	bh=bCUH4sWDuk8uVOqA78wmrU2KFqfQHh2xgnKXzKUS40Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XKWPP0Wz3UP3kMy8DhrpgfOcK18Vs9z8p+7Yf/XyFUKsapJJCZiZXslBhhTP21Z4a7FW3mONw+SsQJY2WBpFSQViidQnPBnc4rDBkQqk+TDaNBpCAz+2RczEL6TqqxpxZLA1+ly4UOBZ9r3aKGrUNJy+rFv4+rPpBFX4tnwprl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ljL0IjUo; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E83B41F000E9;
	Mon, 25 May 2026 06:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779691968;
	bh=ts/0B2PVnjx3rIr5tsJ0g7ybAkemBOjAT1vkLbw7Lb0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ljL0IjUoFHLxHMKqvesIXayMAT3iYxrZVioFDYy6XPIDk7HcJe+SSmnUU/Ch+J1tI
	 BoURer2ZgrQStwTAZNbnEH7PuHGmZuuqf/9I1vpvUxNdMYBApNxbnhIiDXeMKESvRn
	 Z5dPbWB6Lr+lTB1Ix06fSSYBGZZ9fKiv25/UbgsS8+sLRqapd9YaXN51LOSuHe2Wlw
	 /uZ+FYNQOStwXqrwlqh8jt0bG0/ED7J0+Q8RXRQ+cnoZ9pXuuw2mltaReZbMQkFDG6
	 0bQ8CQhFkgvFRokNtUOu700NCXKzmQVYAGUneWK7QlC/4fmo/Y0PvZdlzN6BAizagm
	 hAkRCs5pqp0+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/12] dmaengine: dw-edma-pcie: Track non-LL mode in
 DMA data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: dmaengine@vger.kernel.org, Frank.Li@kernel.org, vkoul@kernel.org
In-Reply-To: <20260525062420.3315904-5-den@valinux.co.jp>
References: <20260525062420.3315904-5-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 06:52:47 +0000
Message-Id: <20260525065247.E83B41F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-10830-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,smtp.kernel.org:mid,lists.linux.dev:replyto,sashiko.dev:url]
X-Rspamd-Queue-Id: D8DE45C6D06
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing NULL check for `pid->driver_data` causes a kernel oops on =
dynamic PCI ID binding.
- [High] Explicitly calling `pci_free_irq_vectors()` on a devres-managed PC=
I device causes a double-free.
--

commit f1e766f286645c5319afe5ac384ae9be593381da
Author: Koichiro Den <den@valinux.co.jp>
Subject: dmaengine: dw-edma-pcie: Track non-LL mode in DMA data

This patch updates the dw-edma-pcie driver to track the non-LL mode status
in the dw_edma_pcie_data copy rather than a local variable. This prepares
for keeping capability parsing behind match data without a separate output
parameter.

> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-=
edma-pcie.c
> index 0b30ce1385036..e92ff5dc6f674 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
[ ... ]
> @@ -312,7 +313,6 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	struct dw_edma_chip *chip;
>  	int err, nr_irqs;
>  	int i, mask;
> -	bool non_ll =3D false;
> =20
>  	struct dw_edma_pcie_data *vsec_data __free(kfree) =3D
>  		kmalloc_obj(*vsec_data);

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing the probe
function, I noticed a potential regression with dynamic PCI ID binding.

Does the driver safely handle cases where a new PCI ID is dynamically added
via the /sys/bus/pci/drivers/dw-edma-pcie/new_id sysfs interface without
specifying the driver_data field? In this scenario, pid->driver_data will
be NULL.

Since the probe function unconditionally casts pid->driver_data to a pointer
and dereferences it during setup:

static int dw_edma_pcie_probe(struct pci_dev *pdev,
                              const struct pci_device_id *pid)
{
        struct dw_edma_pcie_data *pdata =3D (void *)pid->driver_data;
        ...
        memcpy(vsec_data, pdata, sizeof(struct dw_edma_pcie_data));

Could this result in a direct NULL pointer dereference and a kernel oops?

[Severity: High]
This is also a pre-existing issue, but I noticed a potential concern with
how IRQ vectors are cleaned up during device removal.

The driver enables the PCI device using pcim_enable_device(pdev), which
activates automatic devres management for IRQ vectors. As explicitly warned
in the pci_free_irq_vectors() API documentation, drivers using
pcim_enable_device() must not call pci_free_irq_vectors() because the
vectors are automatically freed via pcim_msi_release().

Since the driver's dw_edma_pcie_remove() function explicitly calls
pci_free_irq_vectors(), will this lead to a double-free when devres later
performs its automatic cleanup?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525062420.3315=
904-1-den@valinux.co.jp?part=3D4

