Return-Path: <dmaengine+bounces-10527-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMFkJRkXDGrrVwUAu9opvQ
	(envelope-from <dmaengine+bounces-10527-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 09:54:01 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3DE579783
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 09:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1939F301A513
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 07:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1086B3DDDA8;
	Tue, 19 May 2026 07:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ysv+tUU6"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19353DD526
	for <dmaengine@vger.kernel.org>; Tue, 19 May 2026 07:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779177175; cv=none; b=ltmrEYwTzo7UxLBrZKN4je+a9CdxQma/YPyEjGWeSBqU03AY8JyN42iVshjMILO1De4UWKFNdWH7jf1TZOXcQzFSlDQKGifsTMP9y/nLx6GzVfkqcfHSCEfhx+byZ/FvRG0+W9Nzg2FEvyCeYzDXYWB/XNnFUjZv89FTFJo7lUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779177175; c=relaxed/simple;
	bh=abyoPmHd5XuELUGN6pX8Gfzed2tpt3aaoMhK7d51tBM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mHxyul59BU0c+EbZX900yLlYlkPkcI1lBzffSnffra5KDL/hydfLsS74v0LH9ossuNAc7+qhibwb7g4Q2VnrZNa+XXH4vqwDCk/zT5dILtdm2ywYYWLC/o04dJbyFWHIOSdSZnzfhEbwR8mn8o+Jd9skOjhDFvdKPVoRyfWDxQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ysv+tUU6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C106C2BCC6;
	Tue, 19 May 2026 07:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779177174;
	bh=abyoPmHd5XuELUGN6pX8Gfzed2tpt3aaoMhK7d51tBM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Ysv+tUU6V0Gg7cRYjlz0335Ol4gxDFZueS6+AnkSltNT/MYQd02gU9UHH8YCTgJEX
	 TW3G1gm8vB/xCTb6BbQE0foVtWVX0fkoBI/6e+s4DZVSnHH2pDoNeDE36uau/kys+C
	 1JrvhZOnpTqB9UidjmVS6E0oidFr78QFxz1R8ZLG1UgerE+yKNSufpws1pP4O7y/f0
	 vJ0oRUYHUyc77kyQzr9pw9tuFJfocYrR9ItBhrRo/ujPLLMoyJdiIfRnF4551/N3XY
	 UeqYMqb3pBMByn7kXrN6hS8U676A1cvo9ObWlxiT1RDZGAWWAOI+BMbIWCwK9eNKbh
	 X0e5/U6lp4EKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dmaengine: dw-axi-dmac: drop redundant DMAC enable in
 block start
Reply-To: sashiko-reviews@lists.linux.dev
To: tze.yee.ng@altera.com
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <060733464e19298f670cd269d4849f2092644923.1779172907.git.tze.yee.ng@altera.com>
References: <060733464e19298f670cd269d4849f2092644923.1779172907.git.tze.yee.ng@altera.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 May 2026 07:52:53 +0000
Message-Id: <20260519075254.4C106C2BCC6@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10527-lists,dmaengine=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,smtp.kernel.org:mid,lists.linux.dev:replyto]
X-Rspamd-Queue-Id: 9A3DE579783
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Unsafe hardware access due to asynchronous PM resume and unhandled=
 system suspend.
--

commit 823715a527c6539be45619d2d6221a23e6baa766
Author: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>

dmaengine: dw-axi-dmac: drop redundant DMAC enable in block start

This commit removes a redundant axi_dma_enable() call from
axi_chan_block_xfer_start(), as the controller is expected to be already
enabled before a transfer starts.

> diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma=
/dw-axi-dmac/dw-axi-dmac-platform.c
> --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> @@ -437,8 +437,6 @@ static void axi_chan_block_xfer_start(struct axi_dma_=
chan *chan,
>  		return;
>  	}
> =20
> -	axi_dma_enable(chan->chip);
> -

Will removing this cause a regression with system suspend?

The driver currently appears to rely only on SET_RUNTIME_PM_OPS and lacks
system sleep PM operations. If the system suspends while a channel is
allocated, the runtime PM usage count remains greater than zero, but power
to the controller may be cut. On resume, the hardware state such as
DMAC_CFG is reset.

Because there are no system sleep callbacks like pm_runtime_force_suspend
and pm_runtime_force_resume to call axi_dma_resume(), the hardware seems
to remain disabled after a suspend/resume cycle.

Previously, this axi_dma_enable() call in axi_chan_block_xfer_start()
inadvertently restored the DMAC_EN_MASK bit for the next transfer. With it
removed, will this cause a regression where the hardware silently remains
disabled after system resume?

While looking at the power management here, is it safe for channel
allocation to use pm_runtime_get()?

drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:dma_chan_alloc_chan_resource=
s() {
    ...
    pm_runtime_get(chip->dev);
    ...
}

Since pm_runtime_get() queues an asynchronous resume and returns
immediately, a client could allocate a channel and immediately issue a
transfer. This would cause axi_chan_block_xfer_start() to execute and
unconditionally write to APB hardware registers:

drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:axi_chan_block_xfer_start() {
    ...
    axi_chan_config_write(chan, &config);
    ...
}

If the background PM worker hasn't yet completed axi_dma_runtime_resume()
to enable the core clocks, could these register accesses trigger an external
bus abort? Does dma_chan_alloc_chan_resources() need to use
pm_runtime_get_sync() instead to avoid a regression here?

>  	config.dst_multblk_type =3D DWAXIDMAC_MBLK_TYPE_LL;
>  	config.src_multblk_type =3D DWAXIDMAC_MBLK_TYPE_LL;
>  	config.tt_fc =3D DWAXIDMAC_TT_FC_MEM_TO_MEM_DMAC;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/060733464e19298f670=
cd269d4849f2092644923.1779172907.git.tze.yee.ng@altera.com?part=3D1

