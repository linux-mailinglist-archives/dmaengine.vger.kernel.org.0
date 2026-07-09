Return-Path: <dmaengine+bounces-12236-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SKXtKi24T2oSnQIAu9opvQ
	(envelope-from <dmaengine+bounces-12236-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 17:03:09 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E4173298B
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 17:03:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=LMiNMNjL;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12236-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12236-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54193317DE2E
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 14:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DE037A4BA;
	Thu,  9 Jul 2026 14:41:28 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F6B370AF6
	for <dmaengine@vger.kernel.org>; Thu,  9 Jul 2026 14:41:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783608088; cv=none; b=enzyS4CghsPsxJ2F7zXUUinxgLQ/ZCVT2vdiKQ+idqU988TUQS+YwTpMEK/JaFIL1xYKeOJWefrjJLWBJmfuykyf4B+llNb4BW8qAmp/7KiusZOEhaUJIcOShG6zVMgoi2gurEDW369wQY/vRnbPT6DvnZKlEU7V8CeOuTFoZd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783608088; c=relaxed/simple;
	bh=iihl51QF8+AfXAraDj48kxgUDZcYcJ1lFPrrSc7oOCs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mIULjjN0v5Qlrl4TvsU3Wea0ANH6FPo7SsMki1fsrN2UI62vs7ufkIk6HU8cZd5409r3tfcjJsIInh7wNtloM5Gfzjw0phnosBtOU1W+PB2G4SGKDkD0Aq23A4HJykCE1HP/H8ppFkPuQQqNsLEYvmkVJn5+TrCTJbT63Wz+q8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LMiNMNjL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA0F11F000E9;
	Thu,  9 Jul 2026 14:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783608087;
	bh=9hqJT7RtWjVjlf5Bg8NR0FuO/8yQZjD6pXbzWh6KRiI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LMiNMNjLv/Ba4Urm1aOntjQIeMlxU1qyFDI6JN0QdzbzdvUZL8ldHOJ9ZH1EEdF1i
	 lgvi9Zyq/vv8ibMBBPxhNwJxvceC/A0ZSNY0mxhrRE+fKYpqLFXmuHmwO15uU0Tvc8
	 ROe6lM/VONI9lQHm/YYiGVERkRUisNU6PEiJyq+9LdL92zXchP9lX16ZqMySzM5yPW
	 TSWfdZzEJ6z0Eh6l/wBww+DN9e4UScPfm89nRgnYZ2jM9ENVhB0PYdwMYQXuwaSrE+
	 UL0F6FQ+Xp2o5XhSlU3pMlqKW5SNvACjSI4c/T8zCDCHhrjgaSWrHTcBs7iIJZb29m
	 wGCmcjJ2BSWDA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 25/26] dmaengine: uniphier-xdmac: Remove redundant
 dev_err()/dev_err_probe()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pan Chuang" <panchuang@vivo.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260709135846.97972-26-panchuang@vivo.com>
References: <20260709135846.97972-1-panchuang@vivo.com>
 <20260709135846.97972-26-panchuang@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 14:41:26 +0000
Message-Id: <20260709144126.EA0F11F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-12236-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lists.linux.dev:replyto,smtp.kernel.org:mid,vivo.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 76E4173298B

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Returning early from uniphier_xdmac_remove() if a channel fails to=
 terminate leaves the device registered with the DMA engine while devres fr=
ees its underlying memory, causing a Use-After-Free.
- [Medium] The shared IRQ handler unconditionally returns IRQ_HANDLED, whic=
h breaks the kernel's spurious interrupt detection.
--

--- Patch [25]: [PATCH 25/26] dmaengine: uniphier-xdmac: Remove redundant d=
ev_err()/dev_err_probe() ---
commit d83da39937d839c163b8d27546ec157138f20ec2
Author: Pan Chuang <panchuang@vivo.com>

dmaengine: uniphier-xdmac: Remove redundant dev_err()/dev_err_probe()

The devm_request_irq() now automatically logs detailed error messages on
failure. This eliminates the need for driver-specific dev_err() and
dev_err_probe() calls that previously printed generic messages.

> diff --git a/drivers/dma/uniphier-xdmac.c b/drivers/dma/uniphier-xdmac.c
> index 120c0d4f12dda..b23d61bf7fd5b 100644
> --- a/drivers/dma/uniphier-xdmac.c
> +++ b/drivers/dma/uniphier-xdmac.c
> @@ -532,10 +532,8 @@ static int uniphier_xdmac_probe(struct platform_devi=
ce *pdev)
> =20
>  	ret =3D devm_request_irq(dev, irq, uniphier_xdmac_irq_handler,
>  			       IRQF_SHARED, "xdmac", xdev);

[Severity: Medium]
This is a pre-existing issue, but since we are registering this handler with
IRQF_SHARED here, does unconditionally returning IRQ_HANDLED break the
kernel's spurious interrupt detection?

Looking at uniphier_xdmac_irq_handler():

static irqreturn_t uniphier_xdmac_irq_handler(int irq, void *dev_id)
{
	struct uniphier_xdmac_device *xdev =3D dev_id;
	int i;

	for (i =3D 0; i < xdev->nr_chans; i++)
		uniphier_xdmac_chan_irq(&xdev->channels[i]);

	return IRQ_HANDLED;
}

If a shared interrupt line experiences an interrupt storm or unhandled
interrupt from another device, and no channels here have pending interrupts
(uniphier_xdmac_chan_irq does nothing), this driver will still claim to have
handled it. Will this prevent the kernel from disabling the broken line,
ultimately leading to a system hang?

> -	if (ret) {
> -		dev_err(dev, "Failed to request IRQ\n");
> +	if (ret)
>  		return ret;
> -	}
> =20
>  	ret =3D dma_async_device_register(ddev);

[Severity: High]
This is a pre-existing issue, but concerning the device registration here,
what happens during teardown if dmaengine_terminate_sync() fails?

drivers/dma/uniphier-xdmac.c:uniphier_xdmac_remove() {
	...
	list_for_each_entry(chan, &ddev->channels, device_node) {
		ret =3D dmaengine_terminate_sync(chan);
		if (ret) {
			dev_alert(&pdev->dev, "Failed to terminate...");
			return;
		}
		...
	}

	of_dma_controller_free(pdev->dev.of_node);
	dma_async_device_unregister(ddev);
}

If we return early because of a termination failure,
dma_async_device_unregister() is skipped. Because the xdev structure is
managed by devm_kzalloc, devres will automatically free the memory when the
unbind completes. Will this leave a dangling pointer in the global DMA
device list, leading to a use-after-free if the subsystem accesses the
freed memory?

>  	if (ret) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709135846.9797=
2-1-panchuang@vivo.com?part=3D25

