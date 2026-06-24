Return-Path: <dmaengine+bounces-11765-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id P55jHJuVO2oSaAgAu9opvQ
	(envelope-from <dmaengine+bounces-11765-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 24 Jun 2026 10:30:19 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6686B6BC921
	for <lists+dmaengine@lfdr.de>; Wed, 24 Jun 2026 10:30:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=CNIRkMfg;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11765-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11765-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7C8F8300808F
	for <lists+dmaengine@lfdr.de>; Wed, 24 Jun 2026 08:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CCCF395AF1;
	Wed, 24 Jun 2026 08:30:14 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1CF3ABD88
	for <dmaengine@vger.kernel.org>; Wed, 24 Jun 2026 08:30:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782289814; cv=none; b=HMwm+Fx3aU757GnA92RrjpT7fo/hGJLwOFi5ftn+QXika7ff+6oJiaqfWm8EvoIDSxvNUMLkLVkEENdye+BBGKoiEluyizAyP68pI+F/fvG9gMTSdqAWYMY9iimSiqWoU0bztPG8D6aa0FT0Jl/I0x6+5aAOdsZfOc/ecCNYpVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782289814; c=relaxed/simple;
	bh=tNBXnqjFTWGSkJOGfj6pLb2UPyEZQKMBv2/jRKCHxxk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RvrkY62CM9bB4AryOlyn+iLwfT6rvetHrHkGBT9o1C3ZuXLt5Opnpb3UPn6Hpv0nOEW33WGc7N4SMGllBJJItHnQNJvGagrTLXlk55huOKwOKSD4DydW/Lg+F5s/3pko9dRT8ABbCZWUIHiCqj6z+fAoe+ByV7YNNdcdVDFuMvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNIRkMfg; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCC7C1F000E9;
	Wed, 24 Jun 2026 08:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782289813;
	bh=4Wc+X8Tola34kwUvA5Sl0W3nE/zAYM95BYAdJrZOahk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CNIRkMfgy7sr6h2xM+dxfEgFCsG821f3u8P4eYv2C8blaRcXsX8Ht9XjwTEo9HDz5
	 S2I6Njwslp4YhUc8vLffqXjg3cbbGAH8uvqapsiLGFUMseQP5n7hX4HAo/0RGfv4lK
	 PAP9KnTloCW2F8WZOzy64cURSJd2KdCQDAxZCb4sSSbeqBbu8kDnIJaYz6q6QDcf7O
	 qpmq2LLZuGy6Kz6Ohy+An9TtxfLkEwnYHgX06yUuxh4rexMoe/YgHooiAIyVOXCEEq
	 73V4h8U6TklRDYZBD6+PeEmvH4wjmkfcQLopCjIotIqIODVkA+qiIA/utfUa0HtPcU
	 IEyncIUodxjCQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dmaengine: mediatek: hsdma: fix runtime PM leak on init
 failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Myeonghun Pak" <mhun512@gmail.com>
Cc: dmaengine@vger.kernel.org, Frank.Li@kernel.org, vkoul@kernel.org
In-Reply-To: <20260624081701.19358-1-mhun512@gmail.com>
References: <20260624081701.19358-1-mhun512@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 08:30:12 +0000
Message-Id: <20260624083012.BCC7C1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11765-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mhun512@gmail.com,m:dmaengine@vger.kernel.org,m:Frank.Li@kernel.org,m:vkoul@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6686B6BC921

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Premature DMA controller registration exposes uninitialized hardwa=
re to consumers.
- [High] Hardware and clocks are disabled before the DMA engine is unregist=
ered during teardown, causing unclocked accesses.
- [High] Unsafe `tasklet_kill()` ordering in `remove` allows tasklets to be=
 rescheduled, leading to Use-After-Free.
- [High] Manual channel list deletion subverts the DMA subsystem's cleanup,=
 leaking sysfs entries.
--

commit a02c13cb6b6d7dd4b66478026a93c3fbb55427ef
Author: Myeonghun Pak <mhun512@gmail.com>

dmaengine: mediatek: hsdma: fix runtime PM leak on init failure

mtk_hsdma_hw_init() enables runtime PM and gets a runtime PM reference
before enabling the HSDMA clock. It currently ignores failures from
pm_runtime_get_sync(); if runtime resume fails, the usage count remains
held. If clk_prepare_enable() then fails, runtime PM is left enabled with
the usage count held.

Use pm_runtime_resume_and_get() so resume failures do not leak the usage
count, and unwind runtime PM when clk_prepare_enable() fails.

> diff --git a/drivers/dma/mediatek/mtk-hsdma.c b/drivers/dma/mediatek/mtk-=
hsdma.c
> index a43412ff5eddc..31f05d5d04151 100644
> --- a/drivers/dma/mediatek/mtk-hsdma.c
> +++ b/drivers/dma/mediatek/mtk-hsdma.c

[ ... ]

> @@ -983,7 +992,9 @@ static int mtk_hsdma_probe(struct platform_device *pd=
ev)
>  		goto err_unregister;
>  	}
> =20
> -	mtk_hsdma_hw_init(hsdma);
> +	err =3D mtk_hsdma_hw_init(hsdma);
> +	if (err)
> +		goto err_free;

[Severity: High]
This isn't a bug introduced by this patch, but I noticed that premature DMA
controller registration exposes uninitialized hardware to consumers.

In drivers/dma/mediatek/mtk-hsdma.c:mtk_hsdma_probe(),
dma_async_device_register() and of_dma_controller_register() are invoked
before mtk_hsdma_hw_init(). A consumer device probing concurrently can
request a channel via the device tree.

The consumer will then trigger mtk_hsdma_alloc_chan_resources(), which
accesses MTK_HSDMA_GLO to configure the hardware. Because the clock is not
yet enabled by mtk_hsdma_hw_init(), this unclocked access crashes the
system.

Could we initialize the hardware before registering the DMA controller to
avoid this race condition?

> =20
>  	err =3D devm_request_irq(&pdev->dev, hsdma->irq,
>  			       mtk_hsdma_irq, 0,
> @@ -991,7 +1002,7 @@ static int mtk_hsdma_probe(struct platform_device *p=
dev)
>  	if (err) {
>  		dev_err(&pdev->dev,
>  			"request_irq failed with err %d\n", err);
> -		goto err_free;
> +		goto err_deinit;
>  	}
> =20
>  	platform_set_drvdata(pdev, hsdma);
> @@ -1000,8 +1011,9 @@ static int mtk_hsdma_probe(struct platform_device *=
pdev)
> =20
>  	return 0;
> =20
> -err_free:
> +err_deinit:
>  	mtk_hsdma_hw_deinit(hsdma);
> +err_free:
>  	of_dma_controller_free(pdev->dev.of_node);
>  err_unregister:
>  	dma_async_device_unregister(dd);

[Severity: High]
This is a pre-existing issue, but hardware and clocks are disabled before
the DMA engine is unregistered during teardown, which can cause unclocked
accesses.

In the probe error path (err_deinit) and in mtk_hsdma_remove(),
mtk_hsdma_hw_deinit() is called before dma_async_device_unregister().
mtk_hsdma_hw_deinit() disables the device clocks.

Since the DMA controller is still registered and active, consumers might
still attempt to use the channels or release them. Releasing a channel
calls mtk_hsdma_free_chan_resources(), which accesses MTK_HSDMA_GLO. With
the clock disabled, this results in an external abort.

Should dma_async_device_unregister() be called before disabling the
hardware?

While reviewing this driver, I also noticed a couple of pre-existing issues
in drivers/dma/mediatek/mtk-hsdma.c:mtk_hsdma_remove():

mtk_hsdma_remove() {
    ...
    list_del(&vc->vc.chan.device_node);
    tasklet_kill(&vc->vc.task);
    ...
    mtk_dma_write(hsdma, MTK_HSDMA_INT_ENABLE, 0);
    synchronize_irq(hsdma->irq);
    ...
    dma_async_device_unregister(&hsdma->ddev);
}

[Severity: High]
This is a pre-existing issue, but the unsafe tasklet_kill() ordering in
mtk_hsdma_remove() allows tasklets to be rescheduled, leading to a potential
use-after-free.

tasklet_kill() is called to stop the tasklets for all virtual channels
before disabling the DMA interrupt (MTK_HSDMA_INT_ENABLE) and synchronizing
IRQs.

If an interrupt fires after the tasklet is killed, the IRQ handler
(mtk_hsdma_irq) will execute, calling vchan_cookie_complete(), which
explicitly schedules the tasklet via tasklet_schedule().

After mtk_hsdma_remove() returns, the device memory is freed by devres,
but the tasklet remains queued and will execute on the freed memory.

Can we disable and synchronize the interrupts before killing the tasklets?


[Severity: High]
This is another pre-existing issue in mtk_hsdma_remove(), but manual channel
list deletion seems to subvert the DMA subsystem's cleanup, leaking sysfs
entries.

The driver manually loops over the channels and calls
list_del(&vc->vc.chan.device_node).

When it subsequently calls dma_async_device_unregister(), the DMA core
subsystem loops over &device->channels to unregister each channel's sysfs
devices (via __dma_async_device_channel_unregister()).

Because the list was prematurely emptied by the driver, the core sees an
empty list, skips the cleanup, and leaks the sysfs structures.

Is it safe to remove the manual list_del() calls so the DMA core can
properly clean up the channels?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624081701.1935=
8-1-mhun512@gmail.com?part=3D1

