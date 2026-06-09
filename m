Return-Path: <dmaengine+bounces-11376-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jgv1JPqVKGosGgMAu9opvQ
	(envelope-from <dmaengine+bounces-11376-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 00:38:50 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA55A6649EE
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 00:38:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=hMvi8CAS;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11376-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11376-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6296F300A60B
	for <lists+dmaengine@lfdr.de>; Tue,  9 Jun 2026 22:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE53A3AB5DA;
	Tue,  9 Jun 2026 22:29:57 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985693749F4
	for <dmaengine@vger.kernel.org>; Tue,  9 Jun 2026 22:29:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781044197; cv=none; b=qLlVVyAoLwpmwv6IHhRjo5kwWrfJLPV71JpwxjpSdXnI9grfxDe1qQXAQ8y3fBR7by2KHcB1qYMHJrpFFKCilO2hqRMx3v0H48e0Z4wAsJeQm7cg/mWw7qTBa4I17VFxCjWIZj8anb04sV1zFdpoZA6ZBd+Te6N7Vj+TRt+11Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781044197; c=relaxed/simple;
	bh=lI942ZKud8jXnrubRqf5ayHcu4N/wDLDCVpubJROJRM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oB7mMtc4vpjS0hL8IRmsCJ07nqlTZZ8tSbm3T4fIR47GU01pyAzkl/7g/7XpkGStn8xBdxLNSdKcB7J/Ftf2SDJRb4NCYuaeumKXkt/pztz2tKYYINmbdP40v+BAZyLonFi/B6d/m7bQOfYv/iNT5R6WqCfm2HNVYdz5IetS6bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hMvi8CAS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D5641F00893;
	Tue,  9 Jun 2026 22:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781044196;
	bh=weO/REUcykQk/+ps5q3qsKmkc2VlU4cn7rifdnalcuk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hMvi8CASRewflf94NbCASqz4afjwDXS/zl8I2CwAfLvFt213yVWdQ+LclS+G0SM81
	 O6rA7mHMGs9UeWr19e3tmWBLpypwvO6ZhYw0LD613QG8qkxiktgKxAaz/UsP+Rdkym
	 UWed1ohP3s7KEqGWEGFlSz14xUp2fBxSODoTIRpoC9MDapRTvqpVExn/2VtrSDZNv5
	 bl/o8K7X0K2IEIfyVfG689EuuHBvXoqFljTrHP9x5QY4W5dL5kuFNqpugU0DfS6aOV
	 S2JEDOFVEkbnaS0uvAinPp2K80sQY6K3T9em/voXW/dJMypKObnZbCEloYNCSL1WkD
	 DmVpCoFn8y9Sw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv3 05/15] dmaengine: fsldma: check
 dma_async_device_register() return value
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: dmaengine@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260609221926.35538-6-rosenp@gmail.com>
References: <20260609221926.35538-6-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 22:29:55 +0000
Message-Id: <20260609222956.0D5641F00893@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11376-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url,vger.kernel.org:from_smtp,smtp.kernel.org:mid,lists.linux.dev:replyto]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DA55A6649EE

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] The newly added error path for `dma_async_device_register()` jumps=
 to the wrong cleanup label, failing to free requested IRQs and causing a p=
otential Use-After-Free.

Pre-existing issues:
- [High] Missing `tasklet_kill()` during channel teardown leads to Use-Afte=
r-Free if a tasklet is pending.
- [High] Synchronous device removal without waiting for an RCU grace period=
 violates RCU teardown ordering and causes a Use-After-Free.
--

commit d08450837dbda3ba937b9ef7ab8769c0d6ad7e06
Author: Rosen Penev <rosenp@gmail.com>

dmaengine: fsldma: check dma_async_device_register() return value

This patch checks the return value of dma_async_device_register() in the
probe path and propagates errors instead of silently returning success. It
addresses a potential NULL pointer dereference during device removal if
registration had failed.

> diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
> index 22d62d958abd9..0927b386ae7f7 100644
> --- a/drivers/dma/fsldma.c
> +++ b/drivers/dma/fsldma.c
[ ... ]
> @@ -1292,7 +1292,11 @@ static int fsldma_of_probe(struct platform_device =
*op)
>  		goto out_free_fdev;
>  	}
> =20
> -	dma_async_device_register(&fdev->common);
> +	err =3D dma_async_device_register(&fdev->common);
> +	if (err) {
> +		dev_err(fdev->dev, "unable to register DMA device\n");
> +		goto out_free_fdev;

[Severity: High]
Does this new error path introduce a regression by skipping the IRQ cleanup?

Looking at fsldma_of_probe(), we previously successfully called
fsldma_request_irqs(), which registers shared interrupt handlers. If
dma_async_device_register() fails, jumping directly to out_free_fdev skips
unregistering these IRQs.

Since the handlers are on a shared interrupt line, an incoming interrupt
from another device could trigger the handler. Will the handler then
dereference the freed fdev or chan pointers, resulting in a use-after-free
regression?

> +	}
>  	return 0;
> =20
>  out_free_fdev:

[Severity: High]
This isn't a regression introduced by this patch, but I noticed a potential
issue in fsl_dma_chan_remove() during channel teardown.

drivers/dma/fsldma.c:fsl_dma_chan_remove() {
	irq_dispose_mapping(chan->irq);
	list_del(&chan->common.device_node);
	iounmap(chan->regs);
	kfree(chan);
}

The driver initializes a tasklet for each channel during probe. When
fsldma_of_remove() unregisters the hardware interrupt, it synchronizes with
hardirqs but not with softirqs.

If a tasklet was scheduled right before free_irq() finished, could it still
be pending? Without a call to tasklet_kill() before kfree(chan), could the
delayed tasklet execute dma_do_tasklet and dereference the freed chan
pointer?

[Severity: High]
This is a pre-existing issue, but does synchronous device removal in
fsldma_of_remove() violate RCU teardown ordering?

drivers/dma/fsldma.c:fsldma_of_remove() {
	dma_async_device_unregister(&fdev->common);
	fsldma_free_irqs(fdev);
	...
	kfree(fdev);
}

The call to dma_async_device_unregister() removes the device from the
RCU-protected dma_device_list. However, the memory for fdev is freed
synchronously afterwards.

Could concurrent RCU readers traversing dma_device_list access the device
after it has been freed, causing a use-after-free? Should this wait for an
RCU grace period before freeing?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609221926.3553=
8-6-rosenp@gmail.com?part=3D1

