Return-Path: <dmaengine+bounces-12165-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2eGOFCt4T2o8hQIAu9opvQ
	(envelope-from <dmaengine+bounces-12165-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 12:30:03 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B7072F9AC
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 12:30:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=jcPmKgpx;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12165-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-12165-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D985E3108521
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 10:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B2837F8CC;
	Thu,  9 Jul 2026 10:11:25 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FEA3F54C3
	for <dmaengine@vger.kernel.org>; Thu,  9 Jul 2026 10:11:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783591885; cv=none; b=LLzgzcO/+RYoF3X1qgyQdDkWCI73HJITSgpnxIgpM3rDV50xtQ5d+OlANm2L6+x0AX2lXfF4AHHl2rOxf0svOaUt37XwsnJHBHVCPlxIh/e8xjlfdLzjM/dCcZuLz0QixZsDMW7llmY66KPo+yWKJmUhNGQVbkXCCkATqHJ3gyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783591885; c=relaxed/simple;
	bh=CFxqPinoD8hr0KlsMn8fy25bL4RtUl8inQgipYRiejA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jvZzLU1x5ffmGDV4Yzntp/j/OFBe2y1Ggymz8dTbyjrMbaItCTggk1X9qCjD6Or/KROJZ+t+ZgRQmey+4LjaFQ1hqnD3flryaeP1qI/VEfIwkaDLCwp4D3fAlm2rFe+MwXjvV046ANgmHFQqhIDjGuWY7tbfl2SC1dnOChKioRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jcPmKgpx; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 375A41F00A3A;
	Thu,  9 Jul 2026 10:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783591883;
	bh=12K4hKVWLyKbIIhiBglXDKaMHkj7UmRbo/sqLo7LKvg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jcPmKgpx8ODxBIVaDoxm6zyDjbyJm/mAxdfSEWn7f7Dt2JUoxijx2o/Hk8bq3pIdB
	 +b/Si1+3t9Xz0N3S578p8EUwJkx3ulGvLVZarQFlKUjxrTzAYm2J6xoxTIiP/JqlGy
	 nIHf3OY84szYO84jNDd9sCChdlmUN3C5rd8k128zzq8F9H51xQfC62LgzevOXCnLz3
	 5DT6/4kYIqo1UMVll5d5IHItiF7qwP3kGXwTlXg5GoVjFiTRR8Ayr/G4OoVOrCw6pL
	 9olxnYAIH0h5rlS7zJryQBRGGKlWgZKd1EfhEAUs/l8+hzZQ0yfTr8Elv1XO3dEe+3
	 4ERK46P8ER+MA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V3 3/4] net: xilinx: axienet: Derive RX frame length
 from DMA residue
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srinivas Neeli" <srinivas.neeli@amd.com>
Cc: Frank.Li@kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260708100652.603074-4-srinivas.neeli@amd.com>
References: <20260708100652.603074-1-srinivas.neeli@amd.com>
 <20260708100652.603074-4-srinivas.neeli@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 10:11:22 +0000
Message-Id: <20260709101123.375A41F00A3A@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-12165-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:srinivas.neeli@amd.com,m:Frank.Li@kernel.org,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,sashiko.dev:url,amd.com:email,smtp.kernel.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 78B7072F9AC

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Pending SKBs and DMA mappings are completely leaked during device =
stop when using dmaengine.
- [High] TX ring head/tail desynchronization on DMA mapping failure leads t=
o use-after-free and double-free in the TX callback.
--

--- Patch [3]: [PATCH V3 3/4] net: xilinx: axienet: Derive RX frame length =
from DMA residue ---
commit 0ead77c343fc9310122738aba9dee99007a10e45
Author: Srinivas Neeli <srinivas.neeli@amd.com>

net: xilinx: axienet: Derive RX frame length from DMA residue

The dmaengine RX path previously determined the received frame length by
reading APP word 4 of the DMA descriptor metadata. This patch updates the
code to use the standard dmaengine residue mechanism instead, allowing the
driver to work on designs without the AXI4-Stream status/control interface.

> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/=
net/ethernet/xilinx/xilinx_axienet_main.c
> index fcf517069d161..67d1b8e91d683 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> @@ -53,7 +53,6 @@
>  #define TX_BD_NUM_MAX			4096
>  #define RX_BD_NUM_MAX			4096
>  #define DMA_NUM_APP_WORDS		5
> -#define LEN_APP				4
>  #define RX_BUF_NUM_DEFAULT		128
> =20
>  /* Must be shorter than length of ethtool_drvinfo.driver field to fit */

[ ... ]

drivers/net/ethernet/xilinx/xilinx_axienet_main.c:axienet_stop() {
    ...
		for (i =3D 0; i < TX_BD_NUM_MAX; i++)
			kfree(lp->tx_skb_ring[i]);
		kfree(lp->tx_skb_ring);
		for (i =3D 0; i < RX_BUF_NUM_DEFAULT; i++)
			kfree(lp->rx_skb_ring[i]);
		kfree(lp->rx_skb_ring);
    ...
}

[Severity: High]
This isn't a bug introduced by this patch, but are pending SKBs and DMA
mappings leaked during device stop when using dmaengine?

The descriptor wrapper objects are freed here without first unmapping the
associated DMA addresses or freeing the encapsulated SKBs.

Since the driver loses all pointers to previously allocated SKBs and their =
DMA
mappings, could this exhaust IOMMU space and leak memory each time the inte=
rface
is brought down?


drivers/net/ethernet/xilinx/xilinx_axienet_main.c:axienet_start_xmit_dmaeng=
ine() {
    ...
	lp->tx_ring_head++;
	sg_init_table(skbuf_dma->sgl, sg_len);
	ret =3D skb_to_sgvec(skb, skbuf_dma->sgl, 0, skb->len);
	if (ret < 0)
		goto xmit_error_drop_skb;

	ret =3D dma_map_sg(lp->dev, skbuf_dma->sgl, sg_len, DMA_TO_DEVICE);
	if (!ret)
		goto xmit_error_drop_skb;
    ...
}

drivers/net/ethernet/xilinx/xilinx_axienet_main.c:axienet_dma_tx_cb() {
    ...
	skbuf_dma =3D axienet_get_tx_desc(lp, lp->tx_ring_tail++);
	len =3D skbuf_dma->skb->len;
	txq =3D skb_get_tx_queue(lp->ndev, skbuf_dma->skb);
    ...
	dev_consume_skb_any(skbuf_dma->skb);
    ...
}

[Severity: High]
This is a pre-existing issue, but does this lead to a TX ring head and tail
desynchronization on DMA mapping failure?

In axienet_start_xmit_dmaengine(), the tx_ring_head is advanced before the
failure points, and the error path does not roll it back or submit a dummy
descriptor.

If skb_to_sgvec() or dma_map_sg() fails, and a subsequent packet successful=
ly
completes, axienet_dma_tx_cb() will unconditionally increment tx_ring_tail.

Would it then incorrectly operate on the out-of-sync tail index, dereferenc=
ing
and freeing the SKB pointer of the previously failed mapping?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708100652.6030=
74-1-srinivas.neeli@amd.com?part=3D3

