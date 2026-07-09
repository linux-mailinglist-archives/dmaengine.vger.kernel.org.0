Return-Path: <dmaengine+bounces-12218-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rxXjMhWyT2qdmwIAu9opvQ
	(envelope-from <dmaengine+bounces-12218-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:37:09 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BCE1732542
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:37:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=QNx1ZKFb;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12218-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12218-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83A023034281
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 14:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42219199D8;
	Thu,  9 Jul 2026 14:20:43 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1162C1A6805
	for <dmaengine@vger.kernel.org>; Thu,  9 Jul 2026 14:20:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783606843; cv=none; b=CQCJeP37tCfUimiXLgLl69nOatlLKRRjos9NV7wg8zOwtxaDJivU3MCLfqHJDy+Io3o+mn5IS2PA6e7plwsqpTsrl6GkSC1KUIFEdlb+d4mit2rr6I+IyoiFHI4sAgCoMSmScYtB7qYV27oJ3tp9GSD9bIzf+QO9dVOrci5TUBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783606843; c=relaxed/simple;
	bh=tFBmDe+dfNYZMAyXZhi47FLlbJe8/efssumw08JUWuA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CsXkMngSRR1p09PF0n/+BkS6l2rWRGfP0MfgPLUD7ZYx36psPkP0txQn+z+6DUcrBQq4cbiXFCwItL16aK8QmQLdsATUtNvvuLUjrgeqYt5h3VnQYvtTI3RKezVzrEwRV9tAXyTwQo6XCHSTng+V3rcc6RGC1YNWL3K3HWDKGAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QNx1ZKFb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5B881F00A3D;
	Thu,  9 Jul 2026 14:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783606842;
	bh=xSvcifL1DcuREpRjLOHDUfU1Kdq49V/qwpeat9PIJ2w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QNx1ZKFbjGRFBb2Jt9pHbROeuxbqUE/7nOmcDHnTUq7cHvRX/rRRc3IwJMPf97/96
	 sL0IU6M0ZuRsLqdSL8wSnuXu11YIqbhTAVRoOKfYbwj2605WntZqF86+U1Vt9bJ0wb
	 86vnBugzhV85w+YvhO3P/VXQL8P71kXRCR+tMwP6MqfyYq99jQtjisNPK7fOLp7/mi
	 NVaiJZq2MxSmnSpqZiL+4LckdYL3g9aoOiCv6Wg2PBbkd0f0p5iIwAP6PBaj/6bA6S
	 uFeWy+X/V5iDxofrzijVwRWF1JnUHircW5ZKAfGwsHpgGag9lmaFd5a90V9qewpZdo
	 rjTl8yEvj7MzA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/26] dmaengine: pxa_dma: Remove redundant
 dev_err()/dev_err_probe()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pan Chuang" <panchuang@vivo.com>
Cc: Frank.Li@kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org
In-Reply-To: <20260709135846.97972-10-panchuang@vivo.com>
References: <20260709135846.97972-1-panchuang@vivo.com>
 <20260709135846.97972-10-panchuang@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 14:20:41 +0000
Message-Id: <20260709142041.A5B881F00A3D@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-12218-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vivo.com:email,sashiko.dev:url,vger.kernel.org:from_smtp,lists.linux.dev:replyto,smtp.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2BCE1732542

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The shared interrupt handler panics on `BUG_ON(!chan)` for spuriou=
s or shared interrupts.
- [High] Tasklets are not explicitly destroyed if `of_dma_controller_regist=
er()` fails, leading to a potential use-after-free.
--

--- Patch [9]: [PATCH 09/26] dmaengine: pxa_dma: Remove redundant dev_err()=
/dev_err_probe() ---
commit f2ce223752ea303da12586b72cd70a589be5a08b
Author: Pan Chuang <panchuang@vivo.com>

dmaengine: pxa_dma: Remove redundant dev_err()/dev_err_probe()

The devm_request_irq() now automatically logs detailed error messages on
failure. This eliminates the need for driver-specific dev_err() and
dev_err_probe() calls that previously printed generic messages.

> diff --git a/drivers/dma/pxa_dma.c b/drivers/dma/pxa_dma.c
> index fa2ee0b3e09f8..7bdcc5e6a3d8f 100644
> --- a/drivers/dma/pxa_dma.c
> +++ b/drivers/dma/pxa_dma.c
> @@ -1260,12 +1260,8 @@ static int pxad_init_phys(struct platform_device *=
op,
>  			ret =3D devm_request_irq(&op->dev, irq0,
>  					       pxad_int_handler,
>  					       IRQF_SHARED, "pxa-dma", pdev);
> -		if (ret) {
> -			dev_err(pdev->slave.dev,
> -				"%s(): can't request irq %d:%d\n", __func__,
> -				irq, ret);
> +		if (ret)
>  			return ret;

[Severity: High]
This isn't a bug introduced by this patch, but registering the IRQ handlers
with IRQF_SHARED exposes a potential kernel panic.

If another device sharing the IRQ line generates an interrupt, or if a
spurious interrupt occurs, the kernel calls pxad_chan_handler():

drivers/dma/pxa_dma.c:pxad_chan_handler() {
    struct pxad_phy *phy =3D dev_id;
    struct pxad_chan *chan =3D phy->vchan;
    ...
    BUG_ON(!chan);
    ...
}

If no DMA transfers are currently active, phy->vchan is NULL, leading to a
deterministic kernel panic.=20

Should the shared interrupt handler return IRQ_NONE instead of panicking
when the device has not generated an interrupt?


[Severity: High]
This is another pre-existing issue, but returning directly on failure here
or in the probe function can cause a use-after-free.

During probe, the driver exposes DMA channels by calling
dmaenginem_async_device_register() inside pxad_init_dmadev(). If the
subsequent of_dma_controller_register() call fails, it returns directly:

drivers/dma/pxa_dma.c:pxad_probe() {
    ...
    ret =3D pxad_init_dmadev(op, pdev, dma_channels, nb_requestors);
    if (ret) { ... }

    if (op->dev.of_node) {
        ret =3D of_dma_controller_register(op->dev.of_node,
                                         pxad_dma_xlate, pdev);
        if (ret < 0) {
            dev_err(pdev->slave.dev,
                "of_dma_controller_register failed\n");
            return ret;
        }
    ...
}

Because the DMA engine was temporarily registered, a concurrent non-DT
client could have requested a channel and scheduled its tasklet. When devres
automatically frees the struct pxad_chan memory upon probe failure, the
scheduled tasklet remains on the system's tasklet list.

When the tasklet executes, it will access the freed channel structure.=20

Does the error path need an explicit call to pxad_free_channels() to kill
the tasklets, similar to what is done in pxad_remove()?

> -		}
>  	}
> =20
>  	return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709135846.9797=
2-1-panchuang@vivo.com?part=3D9

