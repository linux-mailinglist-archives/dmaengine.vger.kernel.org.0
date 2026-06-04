Return-Path: <dmaengine+bounces-11159-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id p3SmBBdXIWrrEAEAu9opvQ
	(envelope-from <dmaengine+bounces-11159-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 04 Jun 2026 12:44:39 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC0263F259
	for <lists+dmaengine@lfdr.de>; Thu, 04 Jun 2026 12:44:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=APpqF0qT;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11159-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11159-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3581630830A5
	for <lists+dmaengine@lfdr.de>; Thu,  4 Jun 2026 10:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDEC34F46D;
	Thu,  4 Jun 2026 10:31:22 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91AE3CC315
	for <dmaengine@vger.kernel.org>; Thu,  4 Jun 2026 10:31:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780569082; cv=none; b=QiDw71Lm6dgZQRka3Ly0BNeL0MVkDZw2HK/VhfcjDIWXyf2SYEOYLGHHUSrj6NZFz3XVN0+1bPEahxfGHOGsBbGTATT2HWigniHrni+6l9j/EfqPO8ZNuIqNDQobsa62RvulJ5JPDrAvWj4Z9qjLiTgeIIwTbDMHnXEq32LtY0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780569082; c=relaxed/simple;
	bh=ZW6Rn7g+XSHrWD+T5Y7fbMOIgOKoUy1q2wQvSs80i58=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TMLVSmGs1OS1+ZgQom7FDKTAG6ZNkhKoSn60Zz5tXbt1S7obi2EwWJc+ZYQ7S9dZUFOCrTsgJYv5CFQUaylDyyn7tuPi/jlDxeD+K0QC8hJCqr/s+bHZZDXjbkd9DI+DvmyVD01C3xwOMXt5Wo8vLG+PxjmYDxd35YXp5G3mEVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=APpqF0qT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41E631F00893;
	Thu,  4 Jun 2026 10:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780569081;
	bh=8D8t8Ma08zYin46M5DKkMsYtnbRyZZ7eKJ7F+BXH7Ro=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=APpqF0qT5fTTGI2hIgtKjTH+y5mRpRUDG8BqySUz7H3gUj5YbXrhFzLW5+xYzfaPN
	 jbOuW/HRvXRlCahqV6PIoVB3QMcyzu5M+CUbFCUIVbQZEN9q0D0tEQxWDEC4aSr4D2
	 W+uwGcwrKkaYubim6eLM01USWtHDSZNwIsowBqaeGyOP+xa0AFhm2EotGkOGPky1ev
	 W8jMEhVa5W5yze6nJ8+i5fWmQQDaIsLQDHB/vXhB/rp0aGGK/LSCBYiGtwfU5foOGL
	 YmKSQjUwlfzFdeY6HMTCprIPzwUHDTrEXFKsu6HQV75DHVITHzopVFzvP7KalrhAMg
	 iQOZ7wPphNSrw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] dma: at_hdmac: Fix use-after-free by proper tasklet
 cleanup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hongling Zeng" <zenghongling@kylinos.cn>
Cc: Frank.Li@kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260604101912.318118-1-zenghongling@kylinos.cn>
References: <20260604101912.318118-1-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 10:31:20 +0000
Message-Id: <20260604103121.41E631F00893@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11159-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:zenghongling@kylinos.cn,m:Frank.Li@kernel.org,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0EC0263F259

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Incorrect teardown order in the probe error path leaves the driver=
 vulnerable to Use-After-Free and pool corruption.
- [Low] Unused local variables `chan` and `_chan` are left in `at_dma_remov=
e()`, which will cause compiler warnings.
--

commit 2676b9fc85315dd8a64edbcb2460a143edbcb102
Author: Hongling Zeng <zenghongling@kylinos.cn>

dma: at_hdmac: Fix use-after-free by proper tasklet cleanup
   =20
This commit fixes a use-after-free vulnerability by properly ordering the
teardown path to free IRQs before killing tasklets and freeing other
resources.

Closes: https://lore.kernel.org/all/20260604073945.54B311F00898@smtp.kernel=
.org/

> diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
> index e5b30a57c477a..9048b56b082f4 100644
> --- a/drivers/dma/at_hdmac.c
> +++ b/drivers/dma/at_hdmac.c
[ ... ]
> @@ -2109,6 +2122,8 @@ static int __init at_dma_probe(struct platform_devi=
ce *pdev)
>  err_memset_pool_create:
>  	dma_pool_destroy(atdma->lli_pool);
>  err_desc_pool_create:
> +	if (atdma->dma_device.channels.next !=3D NULL)
> +		at_dma_cleanup_channels(atdma);
>  	free_irq(platform_get_irq(pdev, 0), atdma);

[Severity: High]
Does this sequence in the probe error path violate the cleanup order mentio=
ned
in the commit message?

The commit message states that free_irq() should happen first, then tasklets
should be killed, and finally other resources should be freed.

In this error path, if probe fails at dma_async_device_register(), we call
dma_pool_destroy() on both pools, then at_dma_cleanup_channels() kills the
tasklets, and free_irq() is called last:

err_dma_async_device_register:
	dma_pool_destroy(atdma->memset_pool);
err_memset_pool_create:
	dma_pool_destroy(atdma->lli_pool);
err_desc_pool_create:
	if (atdma->dma_device.channels.next !=3D NULL)
		at_dma_cleanup_channels(atdma);
	free_irq(platform_get_irq(pdev, 0), atdma);

Could an active IRQ handler still fire and schedule tasklets, causing a
use-after-free on the already-destroyed pool memory?

>  err_irq:
>  	clk_disable_unprepare(atdma->clk);
> @@ -2125,16 +2140,11 @@ static void at_dma_remove(struct platform_device =
*pdev)
>  		of_dma_controller_free(pdev->dev.of_node);
>  	dma_async_device_unregister(&atdma->dma_device);
> =20
> -	dma_pool_destroy(atdma->memset_pool);
> -	dma_pool_destroy(atdma->lli_pool);
>  	free_irq(platform_get_irq(pdev, 0), atdma);

[Severity: Low]
This isn't a bug, but does at_dma_remove() still declare the local variables
chan and _chan after this refactoring?

The loop previously using these variables was moved to
at_dma_cleanup_channels(), so leaving them declared at the top of
at_dma_remove() might cause -Wunused-variable compiler warnings:

static void at_dma_remove(struct platform_device *pdev)
{
	struct at_dma		*atdma =3D platform_get_drvdata(pdev);
	struct dma_chan		*chan, *_chan;

> +	at_dma_cleanup_channels(atdma);
> =20
> -	list_for_each_entry_safe(chan, _chan, &atdma->dma_device.channels,
> -			device_node) {
> -		/* Disable interrupts */
> -		atc_disable_chan_irq(atdma, chan->chan_id);
> -		list_del(&chan->device_node);
> -	}
> +	dma_pool_destroy(atdma->memset_pool);
> +	dma_pool_destroy(atdma->lli_pool);
> =20
>  	clk_disable_unprepare(atdma->clk);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604101912.3181=
18-1-zenghongling@kylinos.cn?part=3D1

