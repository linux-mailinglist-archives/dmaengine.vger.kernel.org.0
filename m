Return-Path: <dmaengine+bounces-12222-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id keUhBWGxT2psmwIAu9opvQ
	(envelope-from <dmaengine+bounces-12222-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:34:09 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F267324CA
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:34:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Z1FPGfke;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12222-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-12222-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4078630AC1EC
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 14:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1838331221;
	Thu,  9 Jul 2026 14:27:23 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C41B21E098
	for <dmaengine@vger.kernel.org>; Thu,  9 Jul 2026 14:27:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783607243; cv=none; b=X2gAQxBnKlSG3TsMfQ3+KgKFb2AX5TyBzBZx6aFSr8DrmvEf6rdmofncUgG4Q0KHqPYnun+K6G3W35sGLIo2Qmb6IUtCCF5DlYSDUywRXWZQW6oQ4a0UqW1iJP/AC2AkLyMODhaRUE20vhinY8HMiVOVUmHMlqXHhx4A1I/aFYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783607243; c=relaxed/simple;
	bh=H6/qbqV0WR+zDqO7c4AVc/AAVgk7x8lisJ7jcq8q58s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HlHlmgL0zh0wXaljy3UdUIHog7ug6iTYE1+kkGeUmk7dRTPwjWGjSxLwDbeHI9J9kI3bGkSeFScBgWtD3A/pGsyXkJM8MOtjUDMH42YDf2cFdp5Hup4BgDiALXcFv8Q6FZxcd2uTogf3svc/8gpXJSazT79Agc8AzFu9hF6kCDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z1FPGfke; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7B5B1F000E9;
	Thu,  9 Jul 2026 14:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783607242;
	bh=4cPwqMXe5ru6DI3zXqkI2kfGZc9TXf/4nOgjPPit324=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z1FPGfkepIP2N1qqmlbQYNjgsgEXweNAudMwGcjiyJKjUuMZGOTjM7sS7eV6GWMtF
	 UIYwCZ5V5+/7k2uqxMjRE6NFtfCf/5urfxg3cesIIUxxiTFYjeTlmAETdaWeiacnr8
	 NjhPdFofaMmfl/YaitaSf993krd/g5ou/Pho86pWZqnr3j7EFAOXioIEV7LXpmcFME
	 Jr9Cr4i+64aINs61lOPLL86zqVCnX5Fujquks4+RiC5i+dZ25bWrgwS03BWte46LsG
	 jPvIVZhlOKa1XnHLvygCtXCTRX+qkFEVnPh++5LJVqHmmtlRYbEKO8axtm0oe0X5bR
	 96kcfJxRiZh6A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 15/26] dmaengine: sh-usb-dmac: Remove redundant
 dev_err()/dev_err_probe()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pan Chuang" <panchuang@vivo.com>
Cc: dmaengine@vger.kernel.org, Frank.Li@kernel.org, vkoul@kernel.org
In-Reply-To: <20260709135846.97972-16-panchuang@vivo.com>
References: <20260709135846.97972-1-panchuang@vivo.com>
 <20260709135846.97972-16-panchuang@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 14:27:21 +0000
Message-Id: <20260709142721.A7B5B1F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-12222-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:panchuang@vivo.com,m:dmaengine@vger.kernel.org,m:Frank.Li@kernel.org,m:vkoul@kernel.org,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lists.linux.dev:replyto,vger.kernel.org:from_smtp,sashiko.dev:url,vivo.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 39F267324CA

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The driver unconditionally replaces the error code from `platform_=
get_irq_byname` with `-ENODEV`, breaking probe deferral.
- [High] Shared interrupt is requested before `vchan_init` initializes the =
channel's spinlock and lists.
- [High] Missing IRQ cleanup in the probe error path leaves shared interrup=
ts registered while device clocks are disabled.
- [High] The driver fails to cancel the `vchan` tasklets during channel tea=
rdown and device removal, which can lead to a Use-After-Free if a tasklet e=
xecutes after the device memory is freed.
- [High] If `pm_runtime_get_sync()` fails in `usb_dmac_alloc_chan_resources=
()`, the newly allocated DMA descriptors and the PM runtime usage counter a=
re permanently leaked.
--

--- Patch [15]: [PATCH 15/26] dmaengine: sh-usb-dmac: Remove redundant dev_=
err()/dev_err_probe() ---
commit 26b5ad26e29c18063b36a1a20ac48c474a74b7b1
Author: Pan Chuang <panchuang@vivo.com>

dmaengine: sh-usb-dmac: Remove redundant dev_err()/dev_err_probe()

The devm_request_irq() now automatically logs detailed error messages on
failure. This eliminates the need for driver-specific dev_err() and
dev_err_probe() calls that previously printed generic messages.

> diff --git a/drivers/dma/sh/usb-dmac.c b/drivers/dma/sh/usb-dmac.c
> index 16509be0d3608..17b385d857930 100644
> --- a/drivers/dma/sh/usb-dmac.c
> +++ b/drivers/dma/sh/usb-dmac.c
> @@ -726,11 +726,8 @@ static int usb_dmac_chan_probe(struct usb_dmac *dmac,
> =20
>  	ret =3D devm_request_irq(dmac->dev, uchan->irq, usb_dmac_isr_channel,
>  			       IRQF_SHARED, irqname, uchan);

[Severity: High]
This is a pre-existing issue, but is the shared interrupt requested too
early?

devm_request_irq() is called with IRQF_SHARED before vchan_init()
initializes the channel's spinlock and lists. If another device sharing
the IRQ line fires an interrupt immediately, the registered ISR
usb_dmac_isr_channel() will execute and unconditionally acquire the
uninitialized chan->vc.lock:

drivers/dma/sh/usb-dmac.c:usb_dmac_isr_channel() {
    ...
    spin_lock(&chan->vc.lock);
    ...
}

Could this lead to a lockdep splat or kernel panic on platforms where this
IRQ line is shared with another active device?

> -	if (ret) {
> -		dev_err(dmac->dev, "failed to request IRQ %u (%d)\n",
> -			uchan->irq, ret);
> +	if (ret)
>  		return ret;
> -	}
> =20
>  	uchan->vc.desc_free =3D usb_dmac_virt_desc_free;
>  	vchan_init(&uchan->vc, &dmac->engine);

[Severity: High]
This is a pre-existing issue, but does the unconditional return of
-ENODEV earlier in usb_dmac_chan_probe() break probe deferral?

drivers/dma/sh/usb-dmac.c:usb_dmac_chan_probe() {
    ...
    uchan->irq =3D platform_get_irq_byname(pdev, pdev_irqname);
    if (uchan->irq < 0)
        return -ENODEV;
    ...
}

If the interrupt controller is probed after the DMA controller,
platform_get_irq_byname() would return -EPROBE_DEFER, which gets
incorrectly replaced with -ENODEV. Will this cause the driver to
permanently fail to probe?


[Severity: High]
This is a pre-existing issue, but does the probe error path leave shared
interrupts active while device clocks are disabled?

drivers/dma/sh/usb-dmac.c:usb_dmac_probe() {
    ...
error:
    of_dma_controller_free(pdev->dev.of_node);
error_pm:
    pm_runtime_put(&pdev->dev);
    pm_runtime_disable(&pdev->dev);
    return ret;
}

If dma_async_device_register() fails, the error path disables PM runtime.
However, the shared IRQs for successfully probed channels remain active
until devres cleans them up after the function returns. If a shared
interrupt fires in this window, could the ISR access device registers
with stopped clocks and cause an imprecise external abort?


[Severity: High]
This is a pre-existing issue, but does the channel teardown logic fail to
cancel the vchan tasklets?

drivers/dma/sh/usb-dmac.c:usb_dmac_chan_remove() {
    usb_dmac_chan_halt(uchan);
    devm_free_irq(dmac->dev, uchan->irq, uchan);
}

If the driver is unbound or fails during probe while a vchan tasklet is
scheduled, devres will free the DMA controller memory containing the
tasklet structure. If the tasklet subsequently executes, will it access
freed memory? Should tasklet_kill(&uchan->vc.task) be called here?


[Severity: High]
This is a pre-existing issue, but does this leak resources if
pm_runtime_get_sync() fails?

drivers/dma/sh/usb-dmac.c:usb_dmac_alloc_chan_resources() {
    ...
    return pm_runtime_get_sync(chan->device->dev);
}

If it returns a negative error, it leaves the PM runtime usage counter
incremented and the previously allocated DMA descriptors are not freed.
The dmaengine core abandons the channel without calling
device_free_chan_resources(), which appears to result in a permanent leak
preventing the device from entering runtime suspend.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709135846.9797=
2-1-panchuang@vivo.com?part=3D15

