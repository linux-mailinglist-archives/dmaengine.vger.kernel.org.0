Return-Path: <dmaengine+bounces-12450-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Vg+2DFa5VWoNsAAAu9opvQ
	(envelope-from <dmaengine+bounces-12450-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 06:21:42 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFD8750CB6
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 06:21:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=YyLAgoZS;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12450-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-12450-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 718B6301BA44
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 04:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC7B145B3F;
	Tue, 14 Jul 2026 04:21:39 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2761E277007
	for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2026 04:21:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784002899; cv=none; b=ZFtAmH7kkA15rOz+UyQPJfp0OHkwD/T20IQhQKLq5jcByEjjiRyTo2fiClHe5BGdx1yCAwneNcs6SQywTJq0aWPLhA7elMX7Aw7QVq0xSTnC5MWwqmBNRfbvpHkSo2cdBp2ohmj3IZWmiVmsDFsGJlj6SCpWJiK9AYh0UbvsQdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784002899; c=relaxed/simple;
	bh=zSM3JHTrb0IcsoITrmhwNked2k1cVg9xfkasiEaXYp0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WW6irEYZOUGfIfvXHxHd62y/pgssskk1lotqVueizM2rH95lc1wSa4c29FA+6RYylJil29VvgN96HqFrOilsyC/IHTTm6RxxgamTzp45d8h/cUnxfWHVjCdHKJIZMUHoPVKjBjZXBerGaX8QKSuk4p5hi37RXnXqJIzCO6DB1LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YyLAgoZS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C6E01F000E9;
	Tue, 14 Jul 2026 04:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784002897;
	bh=XDM5zu06wki8KiTXhE2jc95MInJd6/AyTp0+3pWvG64=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YyLAgoZSF1eWSSGymLENcKEwdB7o0Pmb4Y42A5lvsKZH67WGIFWzkpvlXvI8oE5Hf
	 ZCvePPe9bJ61dQAB2jtO16AORJoWPJNkPV8prPWeogiheJNYxePFdvlZZzhde0XG+/
	 WUaTMHKhNwmLxoycW3kDD2q+Ssi+JY8ph1sBROUbBilCiGz5lx2hWyg7HSglinQsYL
	 uJzj0hyi03eQRV6+J1jzLqPRQPAQIJMpdDSXfWaNfks6aWw9DzfJv9+s002DBS6trn
	 wugtrUNxHz6oOpxf48Eyvof5qbQP75WP5gALHRQAb4jNm/skS6xKDq8tgmrIBZ6g0G
	 Tuol//XSujcxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] crypto: iaa - use bounce buffer for multi-sg
 decompress input
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vinicius Costa Gomes" <vinicius.gomes@intel.com>
Cc: Frank.Li@kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org
In-Reply-To: <20260713-iaa-crypto-fixes-zswap-v1-4-65cac23c684d@intel.com>
References: <20260713-iaa-crypto-fixes-zswap-v1-0-65cac23c684d@intel.com>
 <20260713-iaa-crypto-fixes-zswap-v1-4-65cac23c684d@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 04:21:36 +0000
Message-Id: <20260714042137.4C6E01F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-12450-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:vinicius.gomes@intel.com,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,lists.linux.dev:replyto,intel.com:email,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6CFD8750CB6

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Software fallback decompression writes directly to `req->dst` =
from the CPU while it is still mapped for DMA (`DMA_FROM_DEVICE`), causing =
silent data corruption if SWIOTLB (bounce buffers) is active.
--

--- Patch [4]: [PATCH 4/4] crypto: iaa - use bounce buffer for multi-sg dec=
ompress input ---
commit b4edd2dc0b34db120356af61156eef630f99393a
Author: Giovanni Cabiddu <giovanni.cabiddu@intel.com>

crypto: iaa - use bounce buffer for multi-sg decompress input

This patch introduces a pre-allocated bounce page to linearize small=20
multi-entry source scatterlists for the IAA hardware. This allows the=20
driver to decompress these requests in hardware instead of falling back=20
to software decompression.

> diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c b/drivers/crypto/=
intel/iaa/iaa_crypto_main.c
> index 8f68b1478476e..54bde11c454c9 100644
> --- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
> +++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c

[ ... ]

> @@ -1124,7 +1147,7 @@ static void iaa_desc_complete(struct idxd_desc *idx=
d_desc,
>  	}
>  err:
>  	dma_unmap_sg(dev, ctx->req->dst, sg_nents(ctx->req->dst), DMA_FROM_DEVI=
CE);
> -	dma_unmap_sg(dev, ctx->req->src, sg_nents(ctx->req->src), DMA_TO_DEVICE=
);
> +	iaa_unmap_src(dev, ctx->req);

[Severity: Critical]
This is a pre-existing issue, but does the software fallback mechanism in
iaa_desc_complete() risk silent data corruption if SWIOTLB bounce buffers
are active?

When a decompression request fails in hardware (for example, with an
IAA_ANALYTICS_ERROR), the completion handler falls back to software by
calling deflate_generic_decompress(). This software fallback correctly=20
writes the decompressed data into the req->dst scatterlist using the CPU.

However, req->dst is still actively mapped for DMA_FROM_DEVICE. When the
code progresses to this error path and calls dma_unmap_sg() with
DMA_FROM_DEVICE, will SWIOTLB physically copy the contents of the device
bounce buffer (which holds the failed hardware output) over the CPU buffer?=
=20

If so, this would overwrite the successfully decompressed data, which could=
=20
lead to memory corruption if used with subsystems like zswap. Does req->dst=
=20
need to be unmapped prior to invoking deflate_generic_decompress()?

>  out:
>  	if (ret !=3D 0)
>  		dev_dbg(dev, "asynchronous compress failed ret=3D%d\n", ret);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713-iaa-crypto=
-fixes-zswap-v1-0-65cac23c684d@intel.com?part=3D4

