Return-Path: <dmaengine+bounces-12078-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fGaBExsvTWoMwQEAu9opvQ
	(envelope-from <dmaengine+bounces-12078-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 07 Jul 2026 18:53:47 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 833CA71E04A
	for <lists+dmaengine@lfdr.de>; Tue, 07 Jul 2026 18:53:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=XICRTeFy;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12078-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12078-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A85D300C58D
	for <lists+dmaengine@lfdr.de>; Tue,  7 Jul 2026 16:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F8F22A1D4;
	Tue,  7 Jul 2026 16:53:43 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98ED22541C
	for <dmaengine@vger.kernel.org>; Tue,  7 Jul 2026 16:53:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783443223; cv=none; b=WVqj1oU57Eev1lqqi9pZGrIJVa0AF970PTCK/jMouq++jOpBmlmO4T2uXMx2ab1mnsEE//gwKAmHqpXpy0zhno67LpDRv9J+uUkfmSC0E5nOWqRCfDVPRHMW4qiGZaffE1ss3AuSf8/6gWq/ITjy2Sm9Fn/vkFTUMSFFZNxPZis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783443223; c=relaxed/simple;
	bh=I3HjI9VbyAA/rHKmskzOxJESbocpJaji1aplQNLFIAA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eWgqay9pTvKrrB0Iz5yItp15nU/SXpsmzlGFOT+ul5UCk9JOLHdlhBRflk/TnRvLcVjAcJMwtGhHcVftYOMvNKMoGHxNN+Dczp5JRgSZigAv7mSQy2xhSX19Hy1IRsyPM/IqwabCjM0G6t/XJl7lm1mD8n8SpYARLMLqqJrSwiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XICRTeFy; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CFF41F00A3D;
	Tue,  7 Jul 2026 16:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783443222;
	bh=sqz6tpl2bhNxc7A+2YO2jb67n785rvC/jFcjjXfI0ZI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XICRTeFy1y71O6Q5mFzd3EnkCGWkPn13R2D/CaZSKRBcWSGRS5CReSkwLRszXLALO
	 0aUffGs9lAxdKKDH4rN5JVIURgQJyr3E/20vTRPZztPXDCJCwEeNTas1aubIfFu1W4
	 s61VQcRFRBItEhHbfsiNEexSIEi6KFaga26S7iz/1c9rEZHbMR0S3hWn/fLztBTw3H
	 1YV/YdQ3aumoAWritrFSYbGefIVFICscPfxdNi/lWvAmlSZkLfZXKZ0QyAK5xomFbu
	 CBYVoSXSHwtLsWAKSuklCnU9j+JqCYxaS5dnh7bSd8IV5F1wfSe2WZ/SxyTxjBz5DM
	 qyGchrJNHCUqw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 5/5] dmaengine: switchtec-dma: Add PCI1008 device ID
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>
Cc: Frank.Li@kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org
In-Reply-To: <20260707162045.23910-6-logang@deltatee.com>
References: <20260707162045.23910-1-logang@deltatee.com>
 <20260707162045.23910-6-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 16:53:41 +0000
Message-Id: <20260707165342.3CFF41F00A3D@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-12078-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:logang@deltatee.com,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,lists.linux.dev:replyto,deltatee.com:email,smtp.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 833CA71E04A

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The new PCI1008 device ID is added to the switchtec-dma driver b=
ut is missing from the main switchtec management driver.
--

--- Patch [5]: [PATCH v1 5/5] dmaengine: switchtec-dma: Add PCI1008 device =
ID ---
commit 2cb21123b320b7cdd1842ad29a28e1934555c74a
Author: Logan Gunthorpe <logang@deltatee.com>

dmaengine: switchtec-dma: Add PCI1008 device ID

Add the missing PC1008 device ID for switchtec-dma.

> diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
> index 2ac43eb58995a..0a268b6a3ccc0 100644
> --- a/drivers/dma/switchtec_dma.c
> +++ b/drivers/dma/switchtec_dma.c
> @@ -1764,6 +1764,7 @@ static const struct pci_device_id switchtec_dma_pci=
_tbl[] =3D {
>  	SW_ID(PCI_VENDOR_ID_EFAR,      0x1004), /* PCI1004 16XG4 */
>  	SW_ID(PCI_VENDOR_ID_EFAR,      0x1005), /* PCI1005 16XG4 */
>  	SW_ID(PCI_VENDOR_ID_EFAR,      0x1006), /* PCI1006 16XG4 */
> +	SW_ID(PCI_VENDOR_ID_EFAR,      0x1008), /* PCI1008 16XG4 */

[Severity: Medium]
Should the PCI1008 device ID also be added to the core switchtec management
driver's PCI ID table?

Without adding it there, it appears the core management endpoint won't be
bound by the switchtec driver, potentially preventing userspace tools from
configuring or monitoring the switch and leaving NTB functionality
unavailable.

For example, other PCI100X variants are included in switchtec_pci_tbl:

drivers/pci/switch/switchtec.c:switchtec_pci_tbl[] =3D {
	...
	SWITCHTEC_PCI100X_DEVICE(0x1005, SWITCHTEC_GEN4),  /* PCI1005 16XG4 */
	SWITCHTEC_PCI100X_DEVICE(0x1006, SWITCHTEC_GEN4),  /* PCI1006 16XG4 */
	...
};

>  	{0}
>  };
>  MODULE_DEVICE_TABLE(pci, switchtec_dma_pci_tbl);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707162045.2391=
0-1-logang@deltatee.com?part=3D5

