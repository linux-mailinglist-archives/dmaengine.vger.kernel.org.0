Return-Path: <dmaengine+bounces-11675-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cfADCPnKNmrZEwcAu9opvQ
	(envelope-from <dmaengine+bounces-11675-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 19:16:41 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 711B26A9583
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 19:16:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=mDXaLJiF;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11675-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11675-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39594300C91C
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 17:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2C224677B;
	Sat, 20 Jun 2026 17:16:38 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE18525782A
	for <dmaengine@vger.kernel.org>; Sat, 20 Jun 2026 17:16:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781975798; cv=none; b=uofxW1OY/crf4QKfobwZ49ldSNv8c+WlJnpiICkuGsbBHSN3oVxCFTl06vnfYS0v3X+ZHLfuHppaczbYW07DzRg2gCtw8orJbIPgCyFqWOAx04ejIIYeblG8/C/1L+w/1o+uVYN8V1kmQPGtP5qjtYNOor6qlkV8jHU9wYr1Ugw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781975798; c=relaxed/simple;
	bh=GQMESPQATU1jqWCiKgbBlZmXC0tvKJk0Yb8Kk4B22kM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LA9B3QQzDx+ed5agbfXUVmLLrg34ex3/AbD8AhaS1xflj7H65BTQKTmMNCr7qax94/ks7i5GZw9nVp+PrlHhG7m5b/9Y55fbvV0mh/WxLYCzkatyjQBZ2Z5tgm5OWWcyf0r/z3ikVY//kU1z2fQLV3C3p6WzXts69Fxa5oKBPOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mDXaLJiF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E6C81F000E9;
	Sat, 20 Jun 2026 17:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781975797;
	bh=jmwId0xVZQaL9XqvBeFH2of+qmTeANS9kNRaVGMigFI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mDXaLJiFxpsbQzm9q3vHbUHSYiThDA5yjfOT9LgNAg84YKr081Um6BxqEMr/g6ez8
	 0fdrH19GjiskvuWcSueznoFKqjEEBrZEAySnrYveGYmSwmCaJxt3VWKrgENUy/n4f7
	 8Za3/sHQjplX/bBqgc9a8AjbGSLWowKGPYK/xxRK0OyCP9Na3L5xjx2KgtRWhX39Ed
	 kui/QFqp9TYIIDcmOOMX/73tffFBK+4u8Wdi3bJCHSkm/e011/l9GlakDx6rFqMcJ1
	 1yEj+vbEvNMPLak9Og8iuAY9d9sXefKC9Hxzp+ASY5jV6KhEKG8fRXlA868vvkJk2A
	 H/eBxUWX3BRfA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 04/13] dmaengine: dw-edma: Initialize IRQ data before
 requesting IRQs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: Frank.Li@kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260620170040.3756043-5-den@valinux.co.jp>
References: <20260620170040.3756043-1-den@valinux.co.jp>
 <20260620170040.3756043-5-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 Jun 2026 17:16:37 +0000
Message-Id: <20260620171637.7E6C81F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11675-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lists.linux.dev:replyto,vger.kernel.org:from_smtp,valinux.co.jp:email,smtp.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 711B26A9583

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The `dw_edma_device_terminate_all()` function fails to immediately=
 halt the DMA hardware, leading to memory corruption or IOMMU faults when c=
lients subsequently unmap and free DMA memory.
--

commit e17b2c11b8213371ac3e2d7a92dfd8d2c53290ea
Author: Koichiro Den <den@valinux.co.jp>

dmaengine: dw-edma: Initialize IRQ data before requesting IRQs

This patch fixes a potential NULL pointer dereference in the dw-edma driver
by setting the dw back pointer in struct dw_edma_irq before installing
the IRQ handlers. This ensures the pointer is valid if a shared interrupt
triggers immediately after request_irq().

> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-=
edma-core.c
> index ca0504eac1fca..c782eaa12021e 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -943,7 +943,6 @@ static int dw_edma_channel_setup(struct dw_edma *dw, =
u32 wr_alloc, u32 rd_alloc)
>  		else
>  			irq->rd_mask |=3D BIT(chan->id);
> =20
> -		irq->dw =3D dw;

[Severity: High]
This is a pre-existing issue, but does dw_edma_device_terminate_all() fail
to immediately halt the DMA hardware?

drivers/dma/dw-edma/dw-edma-core.c:dw_edma_device_terminate_all() {
    ...
	} else {
		chan->request =3D EDMA_REQ_STOP;
	}

	return err;
}

The dmaengine_terminate_sync() API mandates that a DMA channel is
synchronously stopped, or that the driver implements device_synchronize to
wait for completion.

However, dw_edma_device_terminate_all() sets chan->request =3D EDMA_REQ_STOP
and returns 0 without writing to the hardware to halt the transfer or
implementing device_synchronize.

If the DMA engine client assumes the channel is stopped, might it proceed
to unmap and free the DMA memory while the DMA hardware continues to read
or write to this unmapped physical memory?

Could this lead to use-after-free and memory corruption or IOMMU faults?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260620170040.3756=
043-1-den@valinux.co.jp?part=3D4

