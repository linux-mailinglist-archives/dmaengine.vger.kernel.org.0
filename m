Return-Path: <dmaengine+bounces-11023-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHvBHGbaGGpDoAgAu9opvQ
	(envelope-from <dmaengine+bounces-11023-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 29 May 2026 02:14:30 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D185FBA59
	for <lists+dmaengine@lfdr.de>; Fri, 29 May 2026 02:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1E6B130074E1
	for <lists+dmaengine@lfdr.de>; Fri, 29 May 2026 00:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BDF44F5E0;
	Fri, 29 May 2026 00:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OriaXuDY"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEFA35966
	for <dmaengine@vger.kernel.org>; Fri, 29 May 2026 00:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780013662; cv=none; b=mjKfKTlZfgwtV7ST3WUpato+D3QlQqAEkGSRUBl90Aac9/SqipTuCTRiY6cZniTgylewX2DhKTtpXnVk5lCd1cJKrkyOmvdku3auidEqGF9Otuj7yusrBKXvLxrMs2uHiLAiWRby+T/OAE45GdBN8tn7Coh4BZkU6aRZTENjBac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780013662; c=relaxed/simple;
	bh=OAfBOpD3nCIri+ml/6sODtP8Lk+soLwkRzQyjrNZkUc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EfFau9CVG8OylzgjMGBgSaRLnE7kIqbe4zsF4ropm3IqDcxxDvpQQKVsGVwIRGAaf29Z3AR+wsjD6wpROIWpVhKEbtIGvTBAmKsyo1b2WNyexy1niWKJUAlkhyqgUadieSLZVX5iKQ72aR1gbWWHa1vlypwmdUty2yQTJa0T5CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OriaXuDY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B4951F000E9;
	Fri, 29 May 2026 00:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780013660;
	bh=aq5MvAAFQXKoiDWJPE5n8gWrPB3SYlr6e0kYxRJfytI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OriaXuDY6337K5vHzlQH8JBAZNv4/BSmDllJQn6i00lm4pXc09gVc5NQtNZgTWwhZ
	 Kd6ss+rhYxwDEF6TU6f38/uEnC+9FfDPJaNixfSiT/PQQHWLBSo5zdQIa3YRvzcU6R
	 emSVC9V9Q5BOWaC1x7n+U5YaKf/FppS47ZXiWj7YRm6txKXV86bGlVfRebkb6sv4H7
	 3DzBv2Spa1EZkYFjj8/aE0Nu4QLZ/bLwd93RhH9qSr518DDPKWB028L/hFO7ZA2BNu
	 lY66P6m/EOkp8JGd0khgaA6UU3oboHuU1pdLXhK6sfjQLysmK6sf8BGfvbtIvkDBB2
	 t1ZYlfksUZgsg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv3] dmaengine: ti: omap-dma: turn lch_map into a flexible
 array
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260528233507.305178-1-rosenp@gmail.com>
References: <20260528233507.305178-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 00:14:19 +0000
Message-Id: <20260529001420.1B4951F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11023-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Queue-Id: 83D185FBA59
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Freeing the shared IRQ handler before properly disabling hardware =
interrupts can cause an interrupt storm.
- [High] The late error path in probe frees channels while the shared IRQ h=
andler is active, leading to UAF.
- [High] Destroying the descriptor pool before killing virt-dma tasklets ca=
uses a UAF when tasklets free memory.
--

commit b8aab98ec296892e7aaf7bec47814ddd0493ced7
Author: Rosen Penev <rosenp@gmail.com>

dmaengine: ti: omap-dma: turn lch_map into a flexible array

Convert the separately-allocated lch_map pointer array to a C99
flexible array member at the end of struct omap_dmadev and annotate it
with __counted_by(lch_count). This patch also adds fixes for a missing
return, a needs_busy_check, and a free_irq ordering issue.

> diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
> index 55ece7fd0d99a..7c46be2755be7 100644
> --- a/drivers/dma/ti/omap-dma.c
> +++ b/drivers/dma/ti/omap-dma.c
[ ... ]
> @@ -1828,6 +1828,7 @@ static int omap_dma_probe(struct platform_device *p=
dev)
>  			if (od->ll123_supported)
>  				dma_pool_destroy(od->desc_pool);
>  			omap_dma_free(od);
> +			return rc;
>  		}
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but does destroying the descript=
or
pool before freeing the channels lead to a use-after-free?

omap_dma_free() kills the virt-dma tasklets:

drivers/dma/ti/omap-dma.c:omap_dma_free() {
	while (!list_empty(&od->ddev.channels)) {
        ...
		tasklet_kill(&c->vc.task);
		kfree(c);
	}
}

Because tasklets can run concurrently until they are explicitly killed, cou=
ld a
pending tasklet invoke omap_dma_desc_free() and attempt to return memory to=
 the
already destroyed od->desc_pool?

[Severity: High]
This is also a pre-existing issue, but is it safe to free the channels while
the shared IRQ handler is still active?

The IRQ handler was registered with devm_request_irq() earlier in probe(), =
so
it remains active during this error path since devres hasn't cleaned it up =
yet.

If a shared interrupt fires, could omap_dma_irq() dereference the freed cha=
nnel
pointers in od->lch_map?

[ ... ]
> @@ -1852,17 +1853,18 @@ static void omap_dma_remove(struct platform_devic=
e *pdev)
>  	struct omap_dmadev *od =3D platform_get_drvdata(pdev);
>  	int irq;
> =20
> -	if (od->cfg->may_lose_context)
> +	if (od->cfg->needs_busy_check || od->cfg->may_lose_context)
>  		cpu_pm_unregister_notifier(&od->nb);
> =20
>  	if (pdev->dev.of_node)
>  		of_dma_controller_free(pdev->dev.of_node);
> =20
> -	irq =3D platform_get_irq(pdev, 1);
> -	devm_free_irq(&pdev->dev, irq, od);
> -
>  	dma_async_device_unregister(&od->ddev);
> =20
> +	irq =3D platform_get_irq(pdev, 1);
> +	if (irq > 0)
> +		devm_free_irq(&pdev->dev, irq, od);
> +
>  	if (!omap_dma_legacy(od)) {
>  		/* Disable all interrupts */
>  		omap_dma_glbl_write(od, IRQENABLE_L0, 0);

[Severity: High]
This isn't a bug introduced by this patch, but does freeing the shared IRQ
handler before disabling hardware interrupts create a window for an interru=
pt
storm?

Since the IRQ is requested with IRQF_SHARED, if the handler is freed before
the hardware stops asserting the interrupt, the unhandled interrupt might c=
ause
the kernel to permanently disable the shared IRQ line.

Additionally, probe() configures IRQENABLE_L1 to enable interrupts, but this
code attempts to disable them by writing to IRQENABLE_L0. Does this mean the
hardware interrupts may not actually be disabled here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528233507.3051=
78-1-rosenp@gmail.com?part=3D1

