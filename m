Return-Path: <dmaengine+bounces-11260-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8qTXAntqI2rstQEAu9opvQ
	(envelope-from <dmaengine+bounces-11260-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 02:31:55 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FF364C032
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 02:31:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ccG6mr6Z;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11260-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11260-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E10CB3019820
	for <lists+dmaengine@lfdr.de>; Sat,  6 Jun 2026 00:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F166199EAD;
	Sat,  6 Jun 2026 00:31:52 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360EA4071C4;
	Sat,  6 Jun 2026 00:31:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780705912; cv=none; b=Bc2L29XGX63hC8qCrc5FsUWe97oIaMmof34EyZGkCrrnxUVCd6qfFniQNVNblsWNFwiLR6ANmvC7llIrXkfbGWFv61BW1GxxEbmk8Znirk/RykR+FnHaZcCgfn/BPB88pEuz4oFjzbQM4+9AFOMjIRB6xiDXPK4uEJoou5izu3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780705912; c=relaxed/simple;
	bh=j1rkB5jUKY7kvX0rKcAFSs14WPSWA2GBs4AXyeKTjnY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tHIg/vodARmV0E9MPzayzBri5EbU43xhr4IvdlUgfsZGTBbx6iSyZgOrXQwWAqgimRyXu3HPTOLE0wZ6YBIzj/3snnLWhs+AWgh01tPvYuGy1phV6WGKK12HMZymN3pAOqRhUN6E5L7m2jHntMS1K++Jh4wQCGwLbtOYk6tJUvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ccG6mr6Z; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A0B1F00893;
	Sat,  6 Jun 2026 00:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780705910;
	bh=ueenNJZ32KCUP/AO5ooFoWLtBF6mK8ELU52O9XLT22A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ccG6mr6ZnLwP3iO9UnMGWYbe4YV8pIkkV1TxgjjY9USfU8/CydW9E8ISvyp0RIhn0
	 u9mnj5eWGHGdZZgBeNc/P/x4BGvwwpi+3brFlTdinsh1ROA1YR3DJRjYPRwY355U3D
	 HNaFv+33uRJ+Ib+d2nuGqCNfwpUTHDujjwG83hqiqnn8EnPRwQhrE4mDM2d0rEoWR9
	 5GJsDqNc/Z6Zzpd6QND9PW7bJnKzVJrENSWVVrPJvlPIHcWEVnNz5Q5Hvh1VJrK71r
	 k7iZB96ksYKzNdffPFoKJdgS6Pdwtmnb6fur5yc9ED8DDcNtFlxhKGj5MkSkT/TIaM
	 AKAgNSUGqwebg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 22/23] dmaengine: sdxi: MSI/MSI-X vector allocation
 and mapping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Lynch via B4 Relay" <devnull+nathan.lynch.amd.com@kernel.org>
Cc: linux-pci@vger.kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260605-sdxi-base-v3-22-4d38ca2bdffe@amd.com>
References: <20260605-sdxi-base-v3-22-4d38ca2bdffe@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 00:31:50 +0000
Message-Id: <20260606003150.92A0B1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lists.linux.dev:replyto,smtp.kernel.org:mid,vger.kernel.org:from_smtp,sashiko.dev:url];
	TAGGED_FROM(0.00)[bounces-11260-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:devnull+nathan.lynch.amd.com@kernel.org,m:linux-pci@vger.kernel.org,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:devnull@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine,nathan.lynch.amd.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 49FF364C032

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Failure to check the return value of dma_set_mask_and_coherent().

Pre-existing issues:
- [Critical] Teardown ordering risks Use-After-Free: Software tracking stru=
ctures and DMA memory are destroyed before the hardware is stopped.
--

commit 31c552b5f89a074f21648e62e100ec4d29388cf3
Author: Nathan Lynch <nathan.lynch@amd.com>

dmaengine: sdxi: MSI/MSI-X vector allocation and mapping

During PCI probe, allocate a vector per context supported by the
function as reported by the capability register, plus one for the
error log interrupt. Introduce wrapper functions for vector
allocation, freeing, and translation to IRQ numbers.

> diff --git a/drivers/dma/sdxi/device.c b/drivers/dma/sdxi/device.c
> --- a/drivers/dma/sdxi/device.c
> +++ b/drivers/dma/sdxi/device.c
[ ... ]
> @@ -355,6 +357,8 @@ void sdxi_unregister(struct device *dev)
>  		sdxi_cxt_exit(cxt);
>  	xa_destroy(&sdxi->client_cxts);
> =20
> +	ida_destroy(&sdxi->vectors);
> +
>  	sdxi_dev_stop(sdxi);
>  }

[Severity: Critical]
This isn't a bug introduced by this patch, but does this teardown ordering
risk a use-after-free?

In sdxi_unregister(), the driver destroys all client contexts and their
DMA descriptor rings before sdxi_dev_stop() is called to quiesce the
hardware.

Because the hardware is still active, could it write to the freed status
rings or generate interrupts, causing sdxi_dma_cxt_irq() to dereference
freed memory?

Additionally, since the DMA engine framework is unregistered after
sdxi_unregister() completes during devres cleanup, could a client freeing
a channel in that phase cause sdxi_dma_free_chan_resources() to double-free
the already destroyed context?

> diff --git a/drivers/dma/sdxi/pci.c b/drivers/dma/sdxi/pci.c
> --- a/drivers/dma/sdxi/pci.c
> +++ b/drivers/dma/sdxi/pci.c
> @@ -29,7 +31,8 @@ static int sdxi_pci_init(struct sdxi_dev *sdxi)
>  {
>  	struct pci_dev *pdev =3D sdxi_to_pci_dev(sdxi);
>  	struct device *dev =3D &pdev->dev;
> -	int ret;
> +	unsigned int cap1_max_cxt;
> +	int vecs, ret;
> =20
>  	ret =3D pcim_enable_device(pdev);
>  	if (ret)

[Severity: High]
Does this function need to check the return value of
dma_set_mask_and_coherent()?

Looking at sdxi_pci_init(), it unconditionally configures a 64-bit DMA mask:

    dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));

If the platform or bus rejects the 64-bit mask, could the driver proceed
to allocate and map DMA buffers under the false assumption that 64-bit
addressing is supported, resulting in silently truncated physical addresses
or IOMMU faults?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605-sdxi-base-=
v3-0-4d38ca2bdffe@amd.com?part=3D22

