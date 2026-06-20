Return-Path: <dmaengine+bounces-11674-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 01eDJOnKNmrYEwcAu9opvQ
	(envelope-from <dmaengine+bounces-11674-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 19:16:25 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6CC6A9580
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 19:16:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=gYh5OeoK;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11674-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-11674-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EB8353006524
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 17:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8732224E4C3;
	Sat, 20 Jun 2026 17:16:22 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFB8245012
	for <dmaengine@vger.kernel.org>; Sat, 20 Jun 2026 17:16:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781975782; cv=none; b=hhIDpqAbBLbjAZn4/zYOFjafz+dg9C5sYMa4kQIpBNr/Vh6Z0//iFIajiHKNevoN5tbDij0zcsQi3Wak3/h5N2pdD85L/G1zD6QySvewxmrB7fQQHlH1QheADmNuplWCQKwuXWmiLBtdVk03nlY8TtwMvxRSRGo472MJmLSwUAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781975782; c=relaxed/simple;
	bh=T679RIwvr6+pNq7B6Kmtcj1U7hrJLkDUIGBq3abaJJY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bSLMJAVHGD2a7TrKt0mp6vEWXQWVlquXqepXgoeVr85qh6buM+7LnyfRBMjFaxxJckkBQk/bp8Hj/dGojbmsg/vnp0BT8MS83p7G/7IuC6RosUshXGhiJzt2WCIa1zLR46VSsCcl0QHv5+Iceprulle5RN9FYLMf1AARcfVMugE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYh5OeoK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A90751F000E9;
	Sat, 20 Jun 2026 17:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781975780;
	bh=MO5N//2s25W6GXp/Z6lDi806onbDRvEJiMAC8M8WnVg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gYh5OeoKp1oJA05namsjYHifVtwXDZl7FdKSjOeaT+4C0M9wO0ZXdsHXmMid4xNnq
	 dlyaIeR/aiP9x82sTfM4t7P1rW+LT9ZmnXydsNYaWLdexvV4BR2k0hsA6WtZdLg/dw
	 rlete/blQbGVp0tOlGj2t9/H/IWcMSbmsUnUBpxW5SRfDh235IvHrPLE9lPM/EtuqO
	 knCz0o6g7asOZdoQ5aiKc/1Q1RCnuMTJojjYkmuosXiCmkkWWR9AKSu2iW61hJgqxx
	 2hSjYOmPumQQVRA+UEPu+r59hiVPmGRecig0lWgIMzrLIzAczu1xxlrAPVDR2iPKKZ
	 Q1S/9svzT6QeA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 13/13] dmaengine: dw-edma-pcie: Add chip flags to
 match data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: Frank.Li@kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260620170040.3756043-14-den@valinux.co.jp>
References: <20260620170040.3756043-1-den@valinux.co.jp>
 <20260620170040.3756043-14-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 Jun 2026 17:16:20 +0000
Message-Id: <20260620171620.A90751F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11674-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:den@valinux.co.jp,m:Frank.Li@kernel.org,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:email,sashiko.dev:url,lists.linux.dev:replyto,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EA6CC6A9580

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing pci_free_irq_vectors() on error paths after successful pci=
_alloc_irq_vectors() allocation.
--

commit 47790820d57ed923e44318e08b431eee242c2796
Author: Koichiro Den <den@valinux.co.jp>

dmaengine: dw-edma-pcie: Add chip flags to match data

This commit allows PCI ID match data to pass dw_edma_chip flags into
dw_edma_probe(). It keeps per-device policy in the match data instead of
open-coding it in the probe function.

> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-=
edma-pcie.c
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c

[ ... ]

> @@ -471,6 +472,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	chip->dev =3D dev;
> =20
>  	chip->mf =3D dma_data->mf;
> +	chip->flags =3D match->chip_flags;
>  	chip->irq_mode =3D DW_EDMA_CH_IRQ_REMOTE;
>  	chip->nr_irqs =3D nr_irqs;
>  	chip->ops =3D match->plat_ops;

[Severity: High]
This is a pre-existing issue, but does dw_edma_pcie_probe() leak IRQ
resources on error paths?

Earlier in dw_edma_pcie_probe(), IRQ vectors are successfully allocated:

    nr_irqs =3D pci_alloc_irq_vectors(pdev, 1, dma_data->irqs,
                                    PCI_IRQ_MSI | PCI_IRQ_MSIX);

However, multiple subsequent error paths return directly without calling
pci_free_irq_vectors(), for instance when mapping fails:

    chip->reg_base =3D pcim_iomap_table(pdev)[dma_data->rg.bar];
    if (!chip->reg_base)
            return -ENOMEM;

Another instance occurs further down if dw_edma_probe() fails, returning
the error without freeing the vectors.=20

Should these error paths be updated to call pci_free_irq_vectors() before
returning to prevent IRQ resource exhaustion?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260620170040.3756=
043-1-den@valinux.co.jp?part=3D13

