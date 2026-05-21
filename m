Return-Path: <dmaengine+bounces-10677-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JZAKqYrD2q3HQYAu9opvQ
	(envelope-from <dmaengine+bounces-10677-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 17:58:30 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C92A5A8CA7
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 17:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 72EEA30673AB
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 15:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F9133BBCD;
	Thu, 21 May 2026 15:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tfuw/CFN"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B1333BBAD
	for <dmaengine@vger.kernel.org>; Thu, 21 May 2026 15:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779376506; cv=none; b=tWUNGVUZCxW2RC16D6cztvieho26QDwHqASDQzOPG/79HXG5oxu+cYNegDO07K+Qyt7f1v62qBsIzHl3afw0CiGtaf3ND1eTC3bX5nMfiN6fuYcbkxnWJK98pm7cDU1u7KMDA3A5/WR6Pn66qxaZ7QxwBeUnhuByhnAsHSZDzIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779376506; c=relaxed/simple;
	bh=EoEPQk0QpfbFm1F0j6rNZCSGtMBWQsjOxqCgh1eN+RY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ugSb8aCq1JAdZtjowhbfN570lfG2iaSYnCK7yD3po/JHeF2437fO+WZUgcO0jrLLQq/MPAl8RU7MpJeJXC0vvXCXFm/NfvdSy8+cDdiO1NCGnFNNlvLJSXwULWcXIjx69KuGwckWHLte0ngOOtgUrUao5XZwPOufF1BGAY42uog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tfuw/CFN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69BA61F00A3D;
	Thu, 21 May 2026 15:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779376505;
	bh=K/gVFyMretjnojXoZzAUxrcWQdiF30fmFbQgv5c/dk0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Tfuw/CFN+39vjEdmNEBN5327mwTiwe/1oKYKmbREwnEP536IeoWpoRGVjXhUhYZfR
	 geAHyJLmSBB/hMDjL2L0cUoijavWme44FoSwTEoeNtufQdR+xdoBU0pLUbu5cswQ8D
	 GcDUuuv5/Qb7xZmz0O4KCLl++wMmrpfO3KHbk7O4KWEli/Z4y41Ux3daHcOCtLNAoO
	 PeWG1Qmcw6HM0UaOLqz0xY/Nm7SDIJwlWQgnMhoN7p9ZbxCEErNj6pWD7Up3ap6huF
	 AseI6XzW9hnUhxxjc99gSv7mHc5mRq8IOGMHKcGP0zF4diPgySJ7A4xR0V06ieAasQ
	 aVorfQ6r0/lEA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] dmaengine: dw-edma-pcie: Reject devices without
 driver data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260521142153.2957432-3-den@valinux.co.jp>
References: <20260521142153.2957432-3-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 15:15:03 +0000
Message-Id: <20260521151504.69BA61F00A3D@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10677-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:email,lists.linux.dev:replyto,sashiko.dev:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,smtp.kernel.org:mid]
X-Rspamd-Queue-Id: 4C92A5A8CA7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Mixing goto-based error handling with scope-based cleanup (__fre=
e) in the same function.

Pre-existing issues:
- [High] Missing bounds check for the hardware-provided BAR index when acce=
ssing the `pcim_iomap_table()` array.
--

commit 451669b3f83e6d7ef131e591fd15b9e144ab9005
Author: Koichiro Den <den@valinux.co.jp>
Subject: dmaengine: dw-edma-pcie: Reject devices without driver data

This commit adds a check to reject devices without driver data during
dw_edma_pcie_probe. This prevents a NULL pointer dereference when a device
bound dynamically via sysfs matches the driver without that data.

> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-=
edma-pcie.c
> index 87c31d01fb102..c2024fa824e03 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -314,6 +314,9 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	int i, mask;
>  	bool non_ll =3D false;
> =20
> +	if (!pdata)
> +		return -ENODEV;
> +
>  	struct dw_edma_pcie_data *vsec_data __free(kfree) =3D
>  		kmalloc_obj(*vsec_data);

[Severity: Medium]
The kernel's cleanup subsystem guidelines state that goto-based error
handling and scope-based cleanup should not be mixed in the same function.

Since dw_edma_pcie_probe() uses goto-based cleanup labels on failure paths
like goto err_free_irq_vectors, could mixing them with the __free attribute
here lead to confusing ownership semantics or resource tracking bugs?

Would it be better to either convert all cleanups in this function to
scope-based guards, or avoid using the __free attribute entirely?

[ ... ]

>  	chip->ll_wr_cnt =3D vsec_data->wr_ch_cnt;
>  	chip->ll_rd_cnt =3D vsec_data->rd_ch_cnt;
> =20
>  	chip->reg_base =3D pcim_iomap_table(pdev)[vsec_data->rg.bar];

[Severity: High]
This is a pre-existing issue, but does this code properly validate the
hardware-provided BAR index before using it as an array index?

The value for vsec_data->rg.bar is extracted from the PCIe VSEC
capabilities, which can yield values up to 7. However,
pcim_iomap_table(pdev) returns a pointer to an array of size
PCI_STD_NUM_BARS, which is 6.

If a misconfigured or malicious device provides a BAR index of 6 or 7,
could accessing this array result in an out-of-bounds memory read and
crash the kernel when the resulting invalid pointer is dereferenced?

>  	if (!chip->reg_base) {
>  		err =3D -ENOMEM;
>  		goto err_free_irq_vectors;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521142153.2957=
432-1-den@valinux.co.jp?part=3D2

