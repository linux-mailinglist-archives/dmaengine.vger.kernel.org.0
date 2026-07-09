Return-Path: <dmaengine+bounces-12235-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HJC3Ftu3T2oHnQIAu9opvQ
	(envelope-from <dmaengine+bounces-12235-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 17:01:47 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A153073296A
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 17:01:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=TzpVxyHu;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12235-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12235-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BE9E310A4EC
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 14:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889411A0BF1;
	Thu,  9 Jul 2026 14:40:00 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C941374A13
	for <dmaengine@vger.kernel.org>; Thu,  9 Jul 2026 14:39:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783608000; cv=none; b=UvtvNXlBuxFoVzfQbAyKqiL1JUTUf1C6oi2k+BZOLXB4K6v20DuCu8wRDebNN2qPpRttJdg5Vh52uWfxHU/Ismx91L4RLM+DOXZxk0Dk1CHCybAuYL+a+PWXQ9hTyu09REsyA/aXrSUHftV3AtETzzOJ8fNpa/g43M/dgNKr7to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783608000; c=relaxed/simple;
	bh=BgzufcxHPRrjI0cM38t3OqmEKf87MQHOZYJAm3YHIiY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f5vhT++Fr1m85lJh14jPj7dm4N6R1yO5suEVJPS6ALQR1pGA4hF73GmGB/isbT+PCVeM+WSRICPrRLF4RRchBax6DbR/+i49IlMUs965Ujz5pV67pJiu3STJ1iIrOYGgpettMPt4bIzKToUfLAx1XHzhOBEAh8d0sM4Mq94XYW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TzpVxyHu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D7991F000E9;
	Thu,  9 Jul 2026 14:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783607998;
	bh=bXBtR9yCTHFzWIBVVnulUcahdVS++mr8VGqbE/qAgYY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TzpVxyHu3EmdvA2k+trI5WV0ZDPNqH6mDolsBMy4Pz0uPKAx5nJ5FdQ3HdGFPuWQy
	 Y36TzmyE/fLoAW9kx25m2P7usJXv1iC0kJy/VqHOjd5ERRXXbtOQhLqU+dCG3atGM0
	 rrYh+oz1T/8SLcCHYxnUKQt4j2Z2lshUCmew26u0pJeuVH6SGHpcgnc0jmyoa4etoS
	 CE2NVpyNxzRJZ9tOWu/CKkjAKzu2rowo2GOvXew0qjqZrgQrY78WZUcvC0+9g71j4y
	 kbGtAlwiqF4sXH4nGLbHHaFy2HyfoTy12nKjR+5dyR4aPtqiGIRWmBFeAi0cHA50f6
	 +cIUa1VO4ljKQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 26/26] dmaengine: xgene-dma: Remove redundant
 dev_err()/dev_err_probe()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pan Chuang" <panchuang@vivo.com>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260709135846.97972-27-panchuang@vivo.com>
References: <20260709135846.97972-1-panchuang@vivo.com>
 <20260709135846.97972-27-panchuang@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 14:39:58 +0000
Message-Id: <20260709143958.8D7991F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-12235-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:panchuang@vivo.com,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,m:Frank.Li@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,vger.kernel.org:from_smtp,lists.linux.dev:replyto,sashiko.dev:url,vivo.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A153073296A

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Medium] Incomplete removal of redundant error messages for `devm_request=
_irq()` failures.

Pre-existing issues:
- [High] Incorrect channel index used during IRQ rollback path in `xgene_dm=
a_request_irqs()`, leading to multiple kernel warnings and failed rollback.
- [High] Race condition in probe sequence causes NULL pointer dereference v=
ia uninitialized tasklet.
- [High] Probe error path fails to disable DMA hardware, leading to potenti=
al memory corruption.
--

--- Patch [26]: [PATCH 26/26] dmaengine: xgene-dma: Remove redundant dev_er=
r()/dev_err_probe() ---
commit b27e7ae82dbb69011f33590c87faea09bb044017
Author: Pan Chuang <panchuang@vivo.com>

dmaengine: xgene-dma: Remove redundant dev_err()/dev_err_probe()

The devm_request_irq() now automatically logs detailed error messages on
failure. This eliminates the need for driver-specific dev_err() and
dev_err_probe() calls that previously printed generic messages.

> diff --git a/drivers/dma/xgene-dma.c b/drivers/dma/xgene-dma.c
> --- a/drivers/dma/xgene-dma.c
> +++ b/drivers/dma/xgene-dma.c
> @@ -1436,11 +1436,8 @@ static int xgene_dma_request_irqs(struct xgene_dma=
 *pdma)
>  	/* Register DMA error irq */
>  	ret =3D devm_request_irq(pdma->dev, pdma->err_irq, xgene_dma_err_isr,
>  			       0, "dma_error", pdma);
> -	if (ret) {
> -		dev_err(pdma->dev,
> -			"Failed to register error IRQ %d\n", pdma->err_irq);
> +	if (ret)
>  		return ret;
> -	}
> =20
>  	/* Register DMA channel rx irq */
>  	for (i =3D 0; i < XGENE_DMA_MAX_CHANNEL; i++) {
>  		chan =3D &pdma->chan[i];
>  		irq_set_status_flags(chan->rx_irq, IRQ_DISABLE_UNLAZY);
>  		ret =3D devm_request_irq(chan->dev, chan->rx_irq,
>  				       xgene_dma_chan_ring_isr,
>  				       0, chan->name, chan);
>  		if (ret) {
>  			chan_err(chan, "Failed to register Rx IRQ %d\n",
>  				 chan->rx_irq);

[Severity: Medium]
The commit message states that the patch eliminates driver-specific error
logs for devm_request_irq failures because the core now logs them
automatically.

While the patch removes the dev_err for the global error IRQ above, it
appears to miss this chan_err macro for the Rx IRQ registration failure.

Should this chan_err also be removed to fully align with the commit message?

>  			devm_free_irq(pdma->dev, pdma->err_irq, pdma);
> =20
>  			for (j =3D 0; j < i; j++) {
>  				chan =3D &pdma->chan[i];

[Severity: High]
This is a pre-existing issue, but there appears to be a typo in the rollback
loop in xgene_dma_request_irqs.

It assigns chan using the outer loop index i instead of the inner loop
index j. Will this cause devm_free_irq to be called multiple times on an
unregistered IRQ and fail to clear the IRQ_DISABLE_UNLAZY flag for the
successfully registered ones?

>  				irq_clear_status_flags(chan->rx_irq, IRQ_DISABLE_UNLAZY);
>  				devm_free_irq(chan->dev, chan->rx_irq, chan);
>  			}
> =20
>  			return ret;
>  		}
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but looking at the probe sequence
in xgene_dma_probe:

drivers/dma/xgene-dma.c:xgene_dma_probe() {
    ...
    ret =3D xgene_dma_request_irqs(pdma);
    if (ret)
        goto err_request_irq;

    /* Configure and enable DMA engine */
    xgene_dma_init_hw(pdma);

    /* Register DMA device with linux async framework */
    ret =3D xgene_dma_init_async(pdma);
    ...
}

The function xgene_dma_request_irqs is called before the hardware is unmask=
ed
in xgene_dma_init_hw. If a hardware interrupt fires immediately after
xgene_dma_init_hw, xgene_dma_chan_ring_isr will execute and unconditionally
schedule the tasklet:

drivers/dma/xgene-dma.c:xgene_dma_chan_ring_isr() {
    ...
    tasklet_schedule(&chan->tasklet);
}

However, chan->tasklet is not set up until xgene_dma_init_async runs later
in the probe sequence. Can this trigger a NULL pointer dereference by
scheduling an uninitialized tasklet?

[Severity: High]
This is also a pre-existing issue, but looking at the error handling path
in xgene_dma_probe:

drivers/dma/xgene-dma.c:xgene_dma_probe() {
    ...
err_async_init:
    xgene_dma_free_irqs(pdma);

err_request_irq:
    for (i =3D 0; i < XGENE_DMA_MAX_CHANNEL; i++)
        xgene_dma_delete_chan_rings(&pdma->chan[i]);
    ...
}

If xgene_dma_init_async fails, the code jumps to err_async_init and frees
software resources and DMA descriptor ring buffers.

This path does not appear to call xgene_dma_disable or
xgene_dma_mask_interrupts. Could this leave the DMA controller actively
running and pointing at freed memory, potentially causing memory corruption
if the hardware continues to process descriptors?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709135846.9797=
2-1-panchuang@vivo.com?part=3D26

