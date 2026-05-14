Return-Path: <dmaengine+bounces-10455-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4D0uLGMaBWrOSQIAu9opvQ
	(envelope-from <dmaengine+bounces-10455-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2026 02:42:11 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA9B53C6AA
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2026 02:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 978C1304741B
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2026 00:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C059828C2DD;
	Thu, 14 May 2026 00:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXukHeo+"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D45322A4EE
	for <dmaengine@vger.kernel.org>; Thu, 14 May 2026 00:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778719326; cv=none; b=JKH/oEDf6AvzvuAteG58905aEBWhVo75uJexiNuOjX3rQZ5I4osKN+BSnMvdUaXvchozM3SeT/ZcpQprChgYBf/LzktLOG78vLFvGXab6l0fI5pmxYIbOfzrYb0E6yiGFTdt/dx4sa+neL0vnulZUpiPKhl5TYKegT3BahReOEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778719326; c=relaxed/simple;
	bh=C5YhN5Dsmx1eemADfx/wOD4kkpVCm5UvUK7e0SMj8Ns=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qAHxg8uAk/S9+Yx0MWn5Zw8wSrrBs0XsTnJSsIIzb+8O9pEex4gJ6k47WkRT4i/mPIbuvIFt8uADAeJ3w7UaqX9xXXadGWvvJxpGmOZXkokWM1cE3v52zU4Yo+6rv8jjtMKVrh3K1HbdYv6SCySjvKfHeK4b6GwmVZiFbOKvDmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DXukHeo+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16205C19425;
	Thu, 14 May 2026 00:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778719326;
	bh=C5YhN5Dsmx1eemADfx/wOD4kkpVCm5UvUK7e0SMj8Ns=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=DXukHeo+Naw83Tk+NACes361BeTVqL4t4G8AAZf8MvVv4BqEUJkx/rbTJPx+Bj7RN
	 /XW25N/ECtzGKRR5CQrNgui+UaZ8kHKID4SJEwX1AoMvTSEvM3nP0GrRRnlaixvmar
	 5swdcnH9zXZ2yMnidMqmOvucQHHhdIlx9xBsJun2dfQtLGd3dItfAcO6pyTJOq+NSG
	 0tzdXSaN0sd7sD6uVABc7tphUdxY/wmVNbzxtzVgwG6y0dMHP0vSbUKSX1HClOgXfT
	 9XTZLFhjXqfX1lswSkHIU3emSjcGgN9pkMMpeArwaK7QPheeLE/viyiUqUhGebDAnF
	 YAJekec2lAu4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 09/17] dmaengine: sh: rz-dmac: Use virt-dma APIs for
 channel descriptor processing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Beznea" <claudiu.beznea.uj@bp.renesas.com>
Cc: vkoul@kernel.org, wsa+renesas@sang-engineering.com, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260512121219.216159-10-claudiu.beznea.uj@bp.renesas.com>
References: <20260512121219.216159-10-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 00:42:05 +0000
Message-Id: <20260514004206.16205C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 0AA9B53C6AA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10455-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,smtp.kernel.org:mid,renesas.com:email,lists.linux.dev:replyto];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Action: no action

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Active descriptor (`channel->desc`) is leaked in `rz_dmac_free_c=
han_resources()` if the channel is not explicitly terminated.
--

commit 215fec8fbe90c070b8a33e790b492a28153d2d70
Author: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

dmaengine: sh: rz-dmac: Use virt-dma APIs for channel descriptor processing

This commit refactors the rz-dmac driver to fully utilize virt-dma APIs for
descriptor management. It replaces the internal ld_queue and ld_active lists
with virt-dma equivalents, and introduces channel->desc to track the curren=
tly
processing descriptor.

> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> index 042f85e58a799..53ee9fe652614 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
[ ... ]
> @@ -494,8 +485,6 @@ static void rz_dmac_free_chan_resources(struct dma_ch=
an *chan)
>  	rz_lmdesc_setup(channel, channel->lmdesc.base);
> =20
>  	rz_dmac_disable_hw(channel);
> -	list_splice_tail_init(&channel->ld_active, &channel->ld_free);
> -	list_splice_tail_init(&channel->ld_queue, &channel->ld_free);

Does this leak the active descriptor if the channel is freed without being
explicitly terminated?

The original code moved the active descriptors back to ld_free for cleanup.
With the new code using channel->desc for the active transfer, if a client
releases the channel without calling dmaengine_terminate_sync(),
channel->desc could remain non-NULL.

Since channel->desc is detached from all virt-dma lists and the driver's
ld_free list, neither vchan_free_chan_resources() nor the subsequent kfree
loop over ld_free will free it, preventing channel->descs_allocated from
decrementing correctly.

> =20
>  	if (channel->mid_rid >=3D 0) {
>  		clear_bit(channel->mid_rid, dmac->modules);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512121219.2161=
59-1-claudiu.beznea.uj@bp.renesas.com?part=3D9

