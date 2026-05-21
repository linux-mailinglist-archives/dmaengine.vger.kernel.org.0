Return-Path: <dmaengine+bounces-10621-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EC3bBVyuDmr6AwYAu9opvQ
	(envelope-from <dmaengine+bounces-10621-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 09:03:56 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7207559FDBA
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 09:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3DF83308CD1C
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 06:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDBA394797;
	Thu, 21 May 2026 06:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l77/bIPD"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00161D5AD4
	for <dmaengine@vger.kernel.org>; Thu, 21 May 2026 06:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779346702; cv=none; b=hnTm7qjFM7usrjxXExFRJVtNjvc3yQRbWT0biZKxJA2MeRNRBTMgy0J301T8iO6nV1jNIduNRgYXei/ZjL774r7SG05kzGPRAohyf0DsH3rHbZUyeB63TRJX9LBK6RoCvLK7tsexRYiGWLDTmqiG8KzSDlYPaCqD5VAxhJvxkhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779346702; c=relaxed/simple;
	bh=aeD6ARHKMAczWDMkwvE2/U4K8E344voTJXh9Uq9I8W4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GLmIKw9ni06GXvGo6AgC4z8xW/IQOQg7YwtpjTxapwgwy9I5Ww9mqT9rbY//73oPErUlm5e5P7hWFa2L/2IVa4nql80IMKy4qSxgtaY4eFs/WWV5qA3CV49RW8YGt4KOniSm0N2L6GdnFu5LEXFRD5iE7YLpuKVoIEmz8SKvv3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l77/bIPD; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 376191F000E9;
	Thu, 21 May 2026 06:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779346701;
	bh=pmAJJrhH6qs+ZplmK//pqN9O3OGJVaNhHrjAbIj7EaE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l77/bIPDTDFeGoxJ3IUrMOg41m/Z50U/Na/pK5BJNG42r9KC/6slE9geA6JQuF3XP
	 pBl1aK4IEKpiwm5Y/44EcGspv7Qe0wMVIAJ0WNsPzXnp+0zd7O5s4eJW30SNRCI9X9
	 USLssBaWIQb/cpV5/aIrhM9YEweM0n8/Oj+yoQ3RP28Mm7YIYqqCCrIO6OE9Maxg9W
	 UAdUWsr93xi/AfytbS/ANho3pBWR1dnWvhtN4CdNG7Yghmh7kV+VEfuFxVXAwsvMcK
	 UJ6enQklzTAE0Jc5X5FAFld5+RMT32RHaZIVuahZEARcQ0uJh3cXyu0BkDAurewRhl
	 FKyCOhNfFboFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/12] dmaengine: dw-edma-pcie: Factor descriptor block
 addresses
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260521063115.2842238-11-den@valinux.co.jp>
References: <20260521063115.2842238-11-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 06:58:20 +0000
Message-Id: <20260521065821.376191F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-10621-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,smtp.kernel.org:mid,sashiko.dev:url,valinux.co.jp:email]
X-Rspamd-Queue-Id: 7207559FDBA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing pci_free_irq_vectors() in error paths after successful all=
ocation.
--

commit 74626deb81195f155f5f491b3bc17f8702eeb0bd
Author: Koichiro Den <den@valinux.co.jp>

dmaengine: dw-edma-pcie: Factor descriptor block addresses

This commit adds an optional physical address override to struct dw_edma_bl=
ock.
It also introduces a helper to compute descriptor block addresses, falling =
back
to the previous behavior when the override is unset.

> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-=
edma-pcie.c
> index 6b375a58c5508..2a95fb9d5fc3f 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c

[ ... ]

> @@ -475,9 +488,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  			return -ENOMEM;

[Severity: High]
This isn't a bug introduced by this patch, but does this error path leak the
IRQ vectors allocated earlier in the probe function?

Looking at dw_edma_pcie_probe(), pci_alloc_irq_vectors() is called before
this point, but returning -ENOMEM here bypasses calling
pci_free_irq_vectors(). It looks like there are several error paths after
the IRQ allocation that return directly without cleanup.

> =20
>  		dt_region->vaddr.io +=3D dt_block->off;
> -		dt_region->paddr =3D dw_edma_get_phys_addr(pdev, match,
> -							 dma_data, dt_block->bar);
> -		dt_region->paddr +=3D dt_block->off;
> +		dt_region->paddr =3D dw_edma_get_block_addr(pdev, match, dma_data,
> +							  dt_block);
>  		dt_region->sz =3D dt_block->sz;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521063115.2842=
238-1-den@valinux.co.jp?part=3D10

