Return-Path: <dmaengine+bounces-12516-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2iAXFlasVmr//wAAu9opvQ
	(envelope-from <dmaengine+bounces-12516-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 23:38:30 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B49759042
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 23:38:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=hVixZyfX;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12516-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-12516-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB10C30185AB
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 21:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744D4429CFA;
	Tue, 14 Jul 2026 21:38:26 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5406541B8D5;
	Tue, 14 Jul 2026 21:38:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784065106; cv=none; b=s2tCBuZ3vsRJc5Wo47UP5SB6bRwrkoM/aOPUgYv3ajvbKcrexXy7Xfs2kGvWk5l57ErwYLLB8zHT3peVWYPkMs4Mc5UQMxjK7U55bWxDJ7EdAY5XE0iqcg3GL/3topIrfJJof5jRYIAMWOFZZWlovJG8cy0n+tRN19fLqkP/4PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784065106; c=relaxed/simple;
	bh=YNZe7bkLY+jOLoSSjzsh97+RhoNdEb4n1ZSzwQzz3cY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jMSAP+C1KZqxrsJLCHRFWu1GJU28Z5uOnW8lqrlf0tCaR5DsgDivQPoMXnZYqSVdT0by+7BYyiFj1zKDHZd18uT8ycWsz4fk6zQcvfcbycoYuYnEidnAXGu8yzACcR+1n/21GUFUS5net/Ow/F8I9oM1vs/0mrXZ4IV9sc5qP94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hVixZyfX; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F201F000E9;
	Tue, 14 Jul 2026 21:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784065105;
	bh=gbUMoymbvRFHrgw6C9Gh2HpGDh6ph5b/zi6O3Yya9dM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hVixZyfXiuuH4AKfflaPPdYCop2VEgMoORviQT8nt69+PNkImHxJE4IKO9gy2C+PR
	 pC5rhyUzlEgjiWxmW+MnV5N4ffKOA/tZYEw5NYehfF6FKUU4EZ2G7OmvlwljUXp/Ne
	 5Cd5r5KBvCnINuFjwrkHPyMPOsSWGP+QFbakjiKDgH0Q+HagJEHSiVDA9tfLn6mO8S
	 n4inFXvxYxPRODls/u1aVzHbHeUQFd7VUxmSjSQkEjCEUGKke11GaQfx6lda6jafmV
	 0T/+1dmKYm0I0BTgfp3lVPM98mnhgHcTFScEucmUFGWzBtdhq0BIKlVzpRpTCWllO1
	 2FzTYyFC4rZZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 3/3] PCI: Add PCI1008 to switchtec NTB DMA alias
 quirk
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>
Cc: linux-pci@vger.kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org
In-Reply-To: <20260714212010.230606-4-logang@deltatee.com>
References: <20260714212010.230606-1-logang@deltatee.com>
 <20260714212010.230606-4-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 21:38:24 +0000
Message-Id: <20260714213824.A2F201F000E9@smtp.kernel.org>
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
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-12516-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lists.linux.dev:replyto,vger.kernel.org:from_smtp,smtp.kernel.org:mid,deltatee.com:email,sashiko.dev:url];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:logang@deltatee.com,m:linux-pci@vger.kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B8B49759042

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incorrect pointer arithmetic when reading the upper 32 bits of `ep=
_map` results in reading from the wrong MMIO offset.
--

--- Patch [3]: [PATCH v1 3/3] PCI: Add PCI1008 to switchtec NTB DMA alias q=
uirk ---
commit 7f63ba41929ba7abb0f74f406090b22d57b6bc5e
Author: Logan Gunthorpe <logang@deltatee.com>
PCI: Add PCI1008 to switchtec NTB DMA alias quirk

Add the PCI1008 device ID to the quirk_switchtec_ntb_dma_alias
PCI fixup table. Without it, DMA transactions from a PCI1008 switch's
NTB function are not given the correct requester ID alias, which can
misdirect them under an IOMMU.

> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index b09f27f7846fc..44ccee48349c3 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -6090,6 +6090,7 @@ SWITCHTEC_PCI100X_QUIRK(0x1003);  /* PCI1003XG4 */
>  SWITCHTEC_PCI100X_QUIRK(0x1004);  /* PCI1004XG4 */
>  SWITCHTEC_PCI100X_QUIRK(0x1005);  /* PCI1005XG4 */
>  SWITCHTEC_PCI100X_QUIRK(0x1006);  /* PCI1006XG4 */
> +SWITCHTEC_PCI100X_QUIRK(0x1008);  /* PCI1008XG4 */

[Severity: High]
This isn't a bug introduced by this patch, but while looking at the function
triggered by this quirk (quirk_switchtec_ntb_dma_alias()), I noticed an
incorrect pointer arithmetic issue.

In drivers/pci/quirks.c:quirk_switchtec_ntb_dma_alias():

	partition_map =3D ioread32(&mmio_ntb->ep_map);
	partition_map |=3D ((u64) ioread32(&mmio_ntb->ep_map + 4)) << 32;

Since mmio_ntb->ep_map is a u64, does the + 4 advance the pointer by 32
bytes (4 * sizeof(u64)) instead of the intended 4 bytes?

Looking at struct ntb_info_regs, this would read from offset 36
(target_part_low) instead of the upper 32 bits of ep_map at offset 8. This
populates the upper 32 bits of partition_map with unintended data, causing
the device initialization loop to process invalid partition IDs, which
could potentially access out-of-bounds MMIO registers or create incorrect
DMA aliases.

Could this read be corrected to avoid scaling by the type size?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714212010.2306=
06-1-logang@deltatee.com?part=3D3

