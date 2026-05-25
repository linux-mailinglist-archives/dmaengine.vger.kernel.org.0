Return-Path: <dmaengine+bounces-10843-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPUjHt3/E2quIQcAu9opvQ
	(envelope-from <dmaengine+bounces-10843-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 09:53:01 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CED335C74E0
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 09:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96C483006954
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 07:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E46F3D412D;
	Mon, 25 May 2026 07:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BFTtDtmR"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7C41AAE28
	for <dmaengine@vger.kernel.org>; Mon, 25 May 2026 07:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779695578; cv=none; b=RIut4HVNkgyEHIWrV3Of4GB7OgUwXGSVYdws0zWjnEPQ+vE4kFS7oRd8tKAgpPhhR71zpVS75X4O1GUkqyQWu8a5zDWs+BKgHbBOWOWve/cz1OwVWCoyspAEJorTqEBnfN7eUg9S7COXONuAmDLOQMVnnXjPWFVwUBVi1Oe7Ydk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779695578; c=relaxed/simple;
	bh=9wBUuwvYdUlOWsT3x6nIC0DocIeyTOR5iMBlpYSvhY4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uwbnHxMUPMt1aM5MSNM7w6SRdFO5vyoeGzUn4P6UBmEl6ZGu3SJtws8wcc0ygwz0KEPl7/hnYCoO5uMZm0eLguN9DmDfczCKQgKspQ6JOHQHAGbV7CVgk4PMuCiuJaKrJ3r54J7F/dGTQlzMnam7ed6WaA2nmTNIrO7uXYu0/U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BFTtDtmR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0A181F000E9;
	Mon, 25 May 2026 07:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779695576;
	bh=URYY0wk0N0F3d+ux7j0MOkexpGAWkgWr9HvN34g1jYU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BFTtDtmRGVr4k2f/c2WWFOtO94LEgxokObYWu5HjzMNFKXvBlbzeA9TBdej3asYEw
	 Wxfs3SyzHUverYttZScW8xb5aYaN0ZvpEeui1Y59LAxn69R9j282NSToIExykb2b95
	 Ut3YPHXm9YHvVnGZolHr8FqvXnt8I5VhmPyapBvsmCUwt6WKKuWLNRdWDFF8w2Eppt
	 UxVmzNjz/LLKZmzw+r06MJk6m8fsLQXn+l07aZquMMAx+xSS/G+kQAl7ywkoNbAloq
	 F8Q/kd9A5ZLaxt6t2yPa4kZZ5qI+66ASuUk3FZXgYbdh4hsJuWxU66q4+DbAuR9koU
	 3/Nituve+izRQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] dmaengine: dw-axi-dmac: drop redundant DMAC
 enable in block start
Reply-To: sashiko-reviews@lists.linux.dev
To: tze.yee.ng@altera.com
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <060733464e19298f670cd269d4849f2092644923.1779688569.git.tze.yee.ng@altera.com>
References: <060733464e19298f670cd269d4849f2092644923.1779688569.git.tze.yee.ng@altera.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 07:52:56 +0000
Message-Id: <20260525075256.B0A181F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10843-lists,dmaengine=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,smtp.kernel.org:mid,lists.linux.dev:replyto,altera.com:email]
X-Rspamd-Queue-Id: CED335C74E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Concurrent transfers can race on global APB registers due to lack =
of a global lock in `dw_axi_dma_set_byte_halfword`.
--

commit b6ec2512e872c5f388866aa7fdbd27c4bf168a25
Author: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>

dmaengine: dw-axi-dmac: drop redundant DMAC enable in block start

This commit removes an unnecessary call to axi_dma_enable() in
axi_chan_block_xfer_start(), as the controller is already enabled.
This avoids repeated no-op programming and keeps the transfer start
path clean.

> diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma=
/dw-axi-dmac/dw-axi-dmac-platform.c
> index 4d53f077e9d25..f7a50f470461c 100644
> --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> @@ -437,8 +437,6 @@ static void axi_chan_block_xfer_start(struct axi_dma_=
chan *chan,
>  		return;
>  	}
> =20
> -	axi_dma_enable(chan->chip);
> -
>  	config.dst_multblk_type =3D DWAXIDMAC_MBLK_TYPE_LL;
>  	config.src_multblk_type =3D DWAXIDMAC_MBLK_TYPE_LL;
>  	config.tt_fc =3D DWAXIDMAC_TT_FC_MEM_TO_MEM_DMAC;

[Severity: High]
This is a pre-existing issue, but can concurrent transfers race on the
global APB registers during this setup phase?

When this function executes for the DMA_MEM_TO_DEV direction, it calls
dw_axi_dma_set_byte_halfword(). That function performs read-modify-write
operations on the global DMAC_APB_BYTE_WR_CH_EN or=20
DMAC_APB_HALFWORD_WR_CH_EN registers, which contain configuration bits
for all channels.

Since the locking in these paths typically relies on the per-channel
chan->vc.lock, concurrent calls on different channels could interleave.
Would this lead to one channel's configuration bit being silently
overwritten and lost, potentially resulting in incorrectly configured
transfers or memory corruption?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1779688569.gi=
t.tze.yee.ng@altera.com?part=3D1

