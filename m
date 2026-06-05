Return-Path: <dmaengine+bounces-11211-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gdDRD89LI2r1oAEAu9opvQ
	(envelope-from <dmaengine+bounces-11211-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 00:21:03 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1E464B9D1
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 00:21:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cp+MlgoY;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11211-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-11211-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8285830205C6
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jun 2026 22:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D5722FF22;
	Fri,  5 Jun 2026 22:16:08 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFB230C145
	for <dmaengine@vger.kernel.org>; Fri,  5 Jun 2026 22:16:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780697768; cv=none; b=MxiE1fS0vWNNDAsTFd2JcF5AQM+xdcIIzoK4lW8ljDceVzr5BjzpCbRuJCJZXcHbEnwYnkARU0PUV5j4Y8Tqnnu3y1uI1uKofq9DVSMAjFVjDl2OxT7Dv0urqYUUqMBs3xVJsz6g0q8RRIvq9BoGVSCaxpSFLe7rPyirYdv7LbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780697768; c=relaxed/simple;
	bh=tbK91ollcnkGfJYB0EhjefgKEdBAyGoZfKrOySyLMrI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bKM37U2942FkAd861AWVaQ/+popNrtKar7OgAc8P52ByT42W9rWXBeOoy4mrIpvDvDJhVcLWd9ZvcxAL23vIKucek2RIlJKdWu2q2sh84DVQVIKpmi+T3aZLhbOFP8eyBA2Iyk0uGmbBREZ+GSUTJUC5k2L31lUeyDQCbHd5x+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cp+MlgoY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F5751F00893;
	Fri,  5 Jun 2026 22:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780697766;
	bh=yOPAR4n4qG2tEsYPTO0AhaCKYA+11F4QnSVGmnZ00CA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cp+MlgoYT1N0fANQ7swcxg9QKMVlAaptbPWzWex/e+sGM6Zn374HDpELdhd7qGNhr
	 8+bBuky1YAGrtuU3Rcxmetv1s5p+Wk26WYlGw8snOUetgRTb7VG9vkjh9kmVSrtI4G
	 BmDL51PPI72eE1UHgAk41NRSz5lsN9Mg2Rb3eGg6eVUdUfjxqdG/X6729x17AboPdx
	 K7s0Q65r1wdT4w4w+K+d+njRu44DNMSt+82frhsOZymOZpvVrCQ4c+kjbJUqgKPEm0
	 tw8zdAPl1IjWgBWiqIXmJKcQgbYxgb0mqGtX5IpLtHiCTc53A5ArS3QOI3QXEnZJZh
	 P9N+AMKB/MW0g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/10] dmaengine: fsldma: convert to devm_kzalloc and
 fix error path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260605220134.43295-5-rosenp@gmail.com>
References: <20260605220134.43295-5-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 22:16:05 +0000
Message-Id: <20260605221606.4F5751F00893@smtp.kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11211-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sashiko.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lists.linux.dev:replyto,smtp.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8D1E464B9D1

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The DMA device object is freed before its reference count reaches =
zero during unbind, causing a Use-After-Free.
--

commit bb63aa80e614c90735ef23a9a63a8a58c655050a
Author: Rosen Penev <rosenp@gmail.com>

dmaengine: fsldma: convert to devm_kzalloc and fix error path

Convert fdev allocation from kzalloc_obj to devm_kzalloc to simplify
the probe error and remove paths by dropping the explicit kfree.

> diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
> index 0d28f8299bf88..2efa16d12679a 100644
> --- a/drivers/dma/fsldma.c
> +++ b/drivers/dma/fsldma.c
> @@ -1213,18 +1213,17 @@ static void fsl_dma_chan_remove(struct fsldma_cha=
n *chan)
> =20
>  static int fsldma_of_probe(struct platform_device *op)
>  {
> +	struct device *dev =3D &op->dev;
>  	struct fsldma_device *fdev;

[ ... ]

> @@ -1335,7 +1330,6 @@ static void fsldma_of_remove(struct platform_device=
 *op)
>  	}
> =20
>  	iounmap(fdev->regs);
> -	kfree(fdev);
>  }

[Severity: High]
This isn't a bug introduced by this patch, but does relying on devres to
free the fdev structure leave the driver vulnerable to a use-after-free
during device unbind?

The DMA framework uses a reference count (fdev->common.ref) to track the
lifetime of the dma_device structure and requires drivers to provide a
device_release callback to free it only when the count drops to zero.

Since this driver does not provide a device_release callback, devres will
free the fdev memory synchronously immediately after fsldma_of_remove()
completes. If a DMA client still holds a reference to a channel when the
device is unbound via sysfs, the core framework will eventually drop its
reference and access the freed fdev memory, triggering a use-after-free.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605220134.4329=
5-1-rosenp@gmail.com?part=3D4

