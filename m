Return-Path: <dmaengine+bounces-12216-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xLazAkmyT2qqmwIAu9opvQ
	(envelope-from <dmaengine+bounces-12216-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:38:01 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64501732575
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:38:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=aL9AwYxp;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12216-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12216-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B67FC30D8B03
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 14:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518A62D060B;
	Thu,  9 Jul 2026 14:18:22 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BFD1E1A3D
	for <dmaengine@vger.kernel.org>; Thu,  9 Jul 2026 14:18:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783606702; cv=none; b=MoGkaudkvmbiroL8bxWU7GMQVNoYms/LmJJfGfPXYP7ei1Tkq6fxlb1WGIoOIcFC+UdAt6dSKTCSVKQAiInh+Ujw/RQ5tGWtxnu7WTSkDHKfjyf3fUQrK1I3wEhj6RjVKyG/w23H5SiAu3Vl2RDEJHUdcXBPRiuVQkOaqvxTzvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783606702; c=relaxed/simple;
	bh=lOJPvyeP9jZRQIMFZfjHwJ7klB1pNCJFNO6dji/Q9p4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jfbCEmvAH8i2uHt+6gOsLvEO4PnMLIIK2/4gJXYtcFa8DE+utn/UmuF3VHcACTn59+atSc/2dJeCJrjDc4WBnH6ItRuA4Hjjv/dFwlj3QqsQ+G2+aEByVljnyCig1Zt5jgx/0x8HRwQTkAghXuIL0Rvm0U22sZwKZ8jWpofLsF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aL9AwYxp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69AAE1F000E9;
	Thu,  9 Jul 2026 14:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783606700;
	bh=gNeaUYZTQyGNaNyDAMN91yCPyNReOoDdNocXBKPLYOM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aL9AwYxpRexXZOTZ+1dRuyyHnoQSrk532Er6syoBN/mDHpUKkIPDXo74VlYuqIPI/
	 Hn/hj1CT2L5abXsM6/YynwH9d8DdgoVFReLQzbU/JcOrAIzvXvweQLnBEMTLJRTGnc
	 G3jZEhfxArlz9TOhKCZ8CDmASnzJiV/czTyjnUlqYsVhRuunNb1+yKb5+oj89YhYew
	 /WHISuzZraGJ0vqCaOU5aaQJHUy2T7hEw3ypDLpdgRJVrs9FVmWuDjb+8HLZafMbk2
	 wDwXgiMeMnLwrjPQbKKfc9TrkB9PPiH+i5h8hEa8/fcxnLlVK05hDDK7OAlla2eWq0
	 3WYPtQ4sWPiVQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/26] dmaengine: sf-pdma-sf-pdma: Remove redundant
 dev_err()/dev_err_probe()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pan Chuang" <panchuang@vivo.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260709135846.97972-12-panchuang@vivo.com>
References: <20260709135846.97972-1-panchuang@vivo.com>
 <20260709135846.97972-12-panchuang@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 14:18:19 +0000
Message-Id: <20260709141820.69AAE1F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-12216-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:panchuang@vivo.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,smtp.kernel.org:mid,lists.linux.dev:replyto,vivo.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 64501732575

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The driver masks standard error codes with -EINVAL, permanently br=
eaking probe deferral.
- [High] Interrupt handlers are registered before channel structures are in=
itialized, causing an immediate kernel panic on spurious interrupts.
- [High] Tasklets are not killed on probe error paths, leading to use-after=
-free list corruption.
- [High] Tasklets access `chan->desc` without checking for NULL, leading to=
 crashes when racing with channel termination.
--

--- Patch [11]: [PATCH 11/26] dmaengine: sf-pdma-sf-pdma: Remove redundant =
dev_err()/dev_err_probe() ---
commit 09662195d630e22b4643f58a4176a95df1d14255
Author: Pan Chuang <panchuang@vivo.com>

dmaengine: sf-pdma-sf-pdma: Remove redundant dev_err()/dev_err_probe()

The devm_request_irq() now automatically logs detailed error messages on
failure. This eliminates the need for driver-specific dev_err() and
dev_err_probe() calls that previously printed generic messages.

> diff --git a/drivers/dma/sf-pdma/sf-pdma.c b/drivers/dma/sf-pdma/sf-pdma.c
> index b3cba11b62032..93611e335a075 100644
> --- a/drivers/dma/sf-pdma/sf-pdma.c
> +++ b/drivers/dma/sf-pdma/sf-pdma.c
> @@ -412,10 +412,8 @@ static int sf_pdma_irq_init(struct platform_device *=
pdev, struct sf_pdma *pdma)
> =20
>  		r =3D devm_request_irq(&pdev->dev, irq, sf_pdma_done_isr, 0,
>  				     dev_name(&pdev->dev), (void *)chan);
> -		if (r) {
> -			dev_err(&pdev->dev, "Fail to attach done ISR: %d\n", r);
> +		if (r)
>  			return -EINVAL;

[Severity: High]
This is a pre-existing issue, but does this mask standard error codes?

If platform_get_irq() or devm_request_irq() returns -EPROBE_DEFER, returning
-EINVAL will cause the driver core to treat the probe as a permanent failure
instead of deferring it. Should the original error code be propagated inste=
ad?

> =20
>  		chan->txirq =3D irq;
> =20
> @@ -425,10 +423,8 @@ static int sf_pdma_irq_init(struct platform_device *=
pdev, struct sf_pdma *pdma)
> =20
>  		r =3D devm_request_irq(&pdev->dev, irq, sf_pdma_err_isr, 0,
>  				     dev_name(&pdev->dev), (void *)chan);
> -		if (r) {
> -			dev_err(&pdev->dev, "Fail to attach err ISR: %d\n", r);
> +		if (r)
>  			return -EINVAL;

[Severity: High]
This isn't a bug introduced by this patch, but does this also drop the
actual error code returned by devm_request_irq()?

Propagating the original error code 'r' would ensure probe deferrals and
other specific failure reasons are handled correctly by the driver core.

[ ... ]

[Severity: High]
This is a pre-existing issue, but can spurious interrupts cause a panic
during probe?

In drivers/dma/sf-pdma/sf-pdma.c, sf_pdma_probe() calls sf_pdma_irq_init()
before sf_pdma_setup_chans():

sf_pdma_probe() {
    ...
    ret =3D sf_pdma_irq_init(pdev, pdma);
    if (ret)
        return ret;

    sf_pdma_setup_chans(pdma);
    ...
}

If an interrupt fires immediately after devm_request_irq(),
sf_pdma_done_isr() will read from the uninitialized chan->regs.ctrl:

sf_pdma_done_isr() {
    ...
    writel((readl(regs->ctrl)) & ~PDMA_DONE_STATUS_MASK, regs->ctrl);
    ...
}

Would it be safer to call sf_pdma_setup_chans() before requesting interrupt=
s?

[Severity: High]
This is a pre-existing issue, but do we leave tasklets running if the probe
fails later on?

If an interrupt fires during probe and schedules done_tasklet, and a
subsequent step like dma_async_device_register() fails:

sf_pdma_probe() {
    ...
err_unregister:
    dma_async_device_unregister(&pdma->dma_dev);

    return ret;
}

The devres framework will free the device memory and IRQs, but
devm_free_irq() does not kill pending tasklets. Could the scheduled tasklet
execute later using freed memory?

[Severity: High]
This isn't a bug introduced by this patch, but is there a potential NULL
pointer dereference if tasklets race with channel termination?

sf_pdma_terminate_all() frees chan->desc and sets it to NULL without
synchronizing with the tasklets:

sf_pdma_terminate_all() {
    ...
    kfree(chan->desc);
    chan->desc =3D NULL;
    ...
}

If done_tasklet runs immediately after, it acquires the lock and blindly
dereferences chan->desc:

sf_pdma_donebh_tasklet() {
    ...
    spin_lock_irqsave(&chan->vchan.lock, flags);
    list_del(&chan->desc->vdesc.node);
    ...
}

Should chan->desc be checked for NULL, or should the tasklets be killed
during termination?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709135846.9797=
2-1-panchuang@vivo.com?part=3D11

