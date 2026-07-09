Return-Path: <dmaengine+bounces-12210-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JlnMDt2vT2oMmwIAu9opvQ
	(envelope-from <dmaengine+bounces-12210-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:27:41 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1EA732380
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:27:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=HxZjaAe0;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12210-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12210-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8AF943015A4D
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 14:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCBB386C0A;
	Thu,  9 Jul 2026 14:10:30 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2443385D71
	for <dmaengine@vger.kernel.org>; Thu,  9 Jul 2026 14:10:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783606230; cv=none; b=Np+lGxV/VpNxM0HmTSSHLXMtq0F/rjlURTtokCRb5bmiSpyefRisRKX4e0bUR0CoWLm7GLNkSXrhERp59QxbPWwJRTpksPB7LyJ5LqAu1uh1XQheje/vXUtmymbCQfsW8ZRPJQ5mTgi3Iik/5IfMCeW0Z2f3gYBrqf5N2wlo6aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783606230; c=relaxed/simple;
	bh=8Z1ltOCKX0F8bYFUFfE7GhlkDvQ+g/9n0sslHqbIWWg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pVREo/JCFmUzJnumb3KuFFhLwn2LZjMINj7uUpyQ0hLL5dnoEu3yIUjpgHBccOsY7hDN7RdWavG9LakTMwmYQ+T7/OhUMVTKWTxUXF/AOX7AqC8J8VmsFAZwg2x8bmI5IDW3IFkg4/OS7IJixthBfhKeOpKS1d8SShYSuU/nUS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HxZjaAe0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 335C31F00A3A;
	Thu,  9 Jul 2026 14:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783606228;
	bh=QzFea2G14lfbUJF0JZWnEj/H68Ly+feNHGDCdcx78nY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HxZjaAe0QHGWLvLAZU18TQTJ27jEf39BTVeyptdJefZ/MLpkE0wepg+NoytLj5Syh
	 QHpTraS8VJ4ICnzEbdhLl6E8HK0Ep2ULstakxaKJOp+fx55x7GL4N7P0RBQs+mKeQG
	 0IpFrzMtez1KyBqMCv/KMmkskgX1zC9kozyTd7G0lwiW+TSjhTbW7xe8XeqZ1AcDJk
	 v/AqFGEjv6Bw/8wNgDjJiyzHwAmZLeGRZyNiDcwfXi8XzcB2JT92kwtd9s+3p5tXxA
	 IOv+Tw7WJNXZye//lQ9KTKIN0cDen4uB8tx0UDo3J6j7wlfWVrq34O0VMXRTORBHEb
	 nbyZi9+PBMmAg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/26] dmaengine: mediatek-mtk-cqdma: Remove redundant
 dev_err()/dev_err_probe()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pan Chuang" <panchuang@vivo.com>
Cc: Frank.Li@kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org
In-Reply-To: <20260709135846.97972-5-panchuang@vivo.com>
References: <20260709135846.97972-1-panchuang@vivo.com>
 <20260709135846.97972-5-panchuang@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 14:10:27 +0000
Message-Id: <20260709141028.335C31F00A3A@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-12210-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:panchuang@vivo.com,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,smtp.kernel.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vivo.com:email,sashiko.dev:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9A1EA732380

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

Pre-existing issues:
- [High] IRQ is requested and enabled before tasklets are initialized, lead=
ing to a crash.
- [High] The IRQ handler accesses unallocated channel structures, causing a=
 NULL pointer dereference.
- [High] Device registers are accessed before clocks and power management a=
re enabled, due to premature device registration.
- [High] Missing OF DMA controller deregistration on hardware initializatio=
n failure.
- [High] Missing cleanup for virtual channel tasklets on the probe error pa=
th leads to a potential Use-After-Free.
- [High] Teardown asymmetry in the device removal routine allows concurrent=
 access to destroyed state.
--

--- Patch [4]: [PATCH 04/26] dmaengine: mediatek-mtk-cqdma: Remove redundan=
t dev_err()/dev_err_probe() ---
commit 04c062c96653e2015152bd44faa0dd41edc7a398
Author: Pan Chuang <panchuang@vivo.com>

dmaengine: mediatek-mtk-cqdma: Remove redundant dev_err()/dev_err_probe()

This commit removes redundant dev_err() calls when devm_request_irq() fails
in mtk_cqdma_probe(), relying on the core's built-in logging instead. It al=
so
simplifies the error path by returning -EINVAL directly.

> diff --git a/drivers/dma/mediatek/mtk-cqdma.c b/drivers/dma/mediatek/mtk-=
cqdma.c
> index 80791e30aec24..4dbe84954de6b 100644
> --- a/drivers/dma/mediatek/mtk-cqdma.c
> +++ b/drivers/dma/mediatek/mtk-cqdma.c
> @@ -828,11 +828,8 @@ static int mtk_cqdma_probe(struct platform_device *p=
dev)
>  		err =3D devm_request_irq(&pdev->dev, cqdma->pc[i]->irq,
>  				       mtk_cqdma_irq, 0, dev_name(&pdev->dev),
>  				       cqdma);

[Severity: High]
This is a pre-existing issue, but is it safe to request and enable the IRQ
here before the required tasklet is initialized?

If a pending hardware interrupt fires before tasklet_setup() is called at
the end of the probe function, won't the interrupt handler mtk_cqdma_irq()
execute and call tasklet_schedule() on a zero-initialized tasklet structure?

[Severity: High]
This is also a pre-existing issue, but does the IRQ handler safely handle
unallocated channels?

Physical channels (cqdma->pc[i]) are allocated and their IRQs requested
sequentially in this loop. If an interrupt fires for an earlier channel
(e.g., i=3D0) before the loop allocates the remaining channels,
mtk_cqdma_irq() executes and blindly iterates over all channels
(0 to cqdma->dma_channels - 1) attempting to lock cqdma->pc[i]->lock.

Could this result in a NULL pointer dereference for the unallocated
channels?

> -		if (err) {
> -			dev_err(&pdev->dev,
> -				"request_irq failed with err %d\n", err);
> +		if (err)
>  			return -EINVAL;
> -		}
>  	}
> =20
>  	/* allocate resource for VCs */

While reviewing this patch, I noticed a few other pre-existing issues in
this driver:

drivers/dma/mediatek/mtk-cqdma.c:mtk_cqdma_probe() {
    ...
    err =3D dma_async_device_register(dd);
    ...
    err =3D mtk_cqdma_hw_init(cqdma);
    ...
}

[Severity: High]
This isn't a bug introduced by this patch, but are device registers accessed
before clocks and power management are enabled?

dma_async_device_register() exposes the DMA engine to clients. If a client
immediately requests a channel, mtk_cqdma_alloc_chan_resources() is called,
which invokes mtk_cqdma_hard_reset() to write to device registers.

However, mtk_cqdma_hw_init(), which enables the device clocks and power
management, is called after registration.

Can the register writes occur with disabled clocks causing a synchronous
external abort?


drivers/dma/mediatek/mtk-cqdma.c:mtk_cqdma_probe() {
    ...
    err =3D of_dma_controller_register(pdev->dev.of_node,
                                     of_dma_xlate_by_chan_id, cqdma);
    ...
err_unregister:
    dma_async_device_unregister(dd);

    return err;
}

[Severity: High]
This isn't a bug introduced by this patch, but does the error path leak the
OF DMA controller registration?

If mtk_cqdma_hw_init() fails, the code jumps to err_unregister. The error
path calls dma_async_device_unregister() but fails to call
of_dma_controller_free(pdev->dev.of_node).

Could this leave the device registered in the OF DMA list with a freed
driver context?


drivers/dma/mediatek/mtk-cqdma.c:mtk_cqdma_probe() {
    ...
    for (i =3D 0; i < cqdma->dma_requests; i++) {
        vc =3D &cqdma->vc[i];
        vc->vc.desc_free =3D mtk_cqdma_vdesc_free;
        vchan_init(&vc->vc, dd);
        init_completion(&vc->issue_completion);
    }
    ...
err_unregister:
    dma_async_device_unregister(dd);

    return err;
}

[Severity: High]
This isn't a bug introduced by this patch, but is there missing cleanup for
virtual channel tasklets on the probe error path?

vchan_init() sets up virtual channel tasklets. If a subsequent
initialization step (like mtk_cqdma_hw_init) fails, the err_unregister path
does not call tasklet_kill() for these channels.

Because the device was temporarily exposed via dma_async_device_register(),
a client could have scheduled a transaction, leaving the tasklet active.

When devres frees the device memory, could the executing tasklet trigger a
use-after-free?


drivers/dma/mediatek/mtk-cqdma.c:mtk_cqdma_remove() {
    ...
    /* internal driver state torn down here */
    ...
    dma_async_device_unregister(&cqdma->ddev);
    of_dma_controller_free(pdev->dev.of_node);
}

[Severity: High]
This isn't a bug introduced by this patch, but does the teardown asymmetry
in the device removal routine allow concurrent access to destroyed state?

In mtk_cqdma_remove(), internal driver state (tasklets and hardware
clocks/interrupts) is torn down before the subsystem interfaces
(dma_async_device_unregister and of_dma_controller_free) are unregistered.

Does this teardown inversion allow clients to issue new DMA requests while
the driver is actively being destroyed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709135846.9797=
2-1-panchuang@vivo.com?part=3D4

