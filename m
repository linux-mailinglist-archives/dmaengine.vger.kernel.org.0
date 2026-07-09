Return-Path: <dmaengine+bounces-12209-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Kv7gGLuuT2rOmgIAu9opvQ
	(envelope-from <dmaengine+bounces-12209-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:22:51 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CAC7322B8
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:22:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=DifG4LyN;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12209-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12209-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 487ED32598A2
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 14:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7FD3815D6;
	Thu,  9 Jul 2026 14:10:04 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F45312825
	for <dmaengine@vger.kernel.org>; Thu,  9 Jul 2026 14:10:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783606203; cv=none; b=UmYC4QO42hbAY8ir8YR7+KmJMdIL1BaKlNp6ge7YmrTTWi7jIpFo74Nltj42j913P9Vz9OTQKwqo4ohAN9adW9oLbKs/EStDiuw8YY+/LKzGOs3iNCz2G4AElNWToupFra7h3kC/A+FB50FTSZem1zvKvsE73z7B7ynFDw3wi/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783606203; c=relaxed/simple;
	bh=vvv5f0MhI3z4jS35la29yTDgCe8pubamk9bWTViGtbY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PMKAIKQSopZrmqrbvhPwEPap8OOs3OPCVQAYwiLhGD+YL2xLj3UhxRKmiTXh6nqHgafS36Gt4bqqjs6SNwah/TybUpu8/r/u1ACLQijCjqHesOv2g4rXICFXz/6dygRkTYMD72K4Lo9hLmslQYYpTekbqNzDCdxLdU8xXd+kJiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DifG4LyN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 379F91F000E9;
	Thu,  9 Jul 2026 14:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783606202;
	bh=1SZezc/rHvEXzjKDR0U9OaclA4N2lEcD9DQ7Cd8ToOE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DifG4LyNuvIHQKIBskq0GXu/s+In7pDLDNRXE1TjOfAdn/aYAebg63xcJvRWmx9JR
	 freDLWF5VSobYAl7Rm3O60PLA9YKzJGqbbmFbMaVdwT1Zz16qBSyJW7CK6CtU4jTTL
	 GS+gTtGS3pEVG/DPCUY/PwAeCMiYdCtZCm1JUPr6pGErurel8AV+bjxLAA5qNKPtS+
	 dDkH31tFJZmavvbwkrnqjD/FSqftmGfMFtVtInQdtprwdIafQhGkLZ2VoW+OgoonEz
	 jpq9aFpLt6nELS29q+OodzVxCZJ73K2891OsiwttvohsW67tgU6LiYxeyuHJPML5Af
	 K7yUudimlNcUQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/26] dmaengine: mediatek-mtk-hsdma: Remove redundant
 dev_err()/dev_err_probe()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pan Chuang" <panchuang@vivo.com>
Cc: Frank.Li@kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org
In-Reply-To: <20260709135846.97972-6-panchuang@vivo.com>
References: <20260709135846.97972-1-panchuang@vivo.com>
 <20260709135846.97972-6-panchuang@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 14:10:01 +0000
Message-Id: <20260709141002.379F91F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-12209-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,smtp.kernel.org:mid,vivo.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A9CAC7322B8

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The DMA controller is registered and exposed to clients before har=
dware initialization and IRQ setup, causing race conditions and Use-After-F=
ree vulnerabilities on probe failure.
- [High] The return value of mtk_hsdma_hw_init() is ignored, masking clock =
initialization failures and leading to hardware lockups and leaked PM runti=
me references.
- [Medium] In mtk_hsdma_remove(), the DMA engine is unregistered after inte=
rnal resources are disabled, creating a window where clients can access unc=
locked hardware.
--

--- Patch [5]: [PATCH 05/26] dmaengine: mediatek-mtk-hsdma: Remove redundan=
t dev_err()/dev_err_probe() ---
commit 572ded362561924159b30085ea17ce96e1c47b86
Author: Pan Chuang <panchuang@vivo.com>

dmaengine: mediatek-mtk-hsdma: Remove redundant dev_err()/dev_err_probe()

This commit removes redundant error messages after devm_request_irq() in
the MediaTek HSDMA driver. The core subsystem now handles logging detailed
error messages automatically on failure.

> diff --git a/drivers/dma/mediatek/mtk-hsdma.c b/drivers/dma/mediatek/mtk-=
hsdma.c
> index a43412ff5eddc..6ee8911c12e0f 100644
> --- a/drivers/dma/mediatek/mtk-hsdma.c
> +++ b/drivers/dma/mediatek/mtk-hsdma.c
> @@ -988,11 +988,8 @@ static int mtk_hsdma_probe(struct platform_device *p=
dev)
>  	err =3D devm_request_irq(&pdev->dev, hsdma->irq,
>  			       mtk_hsdma_irq, 0,
>  			       dev_name(&pdev->dev), hsdma);
> -	if (err) {
> -		dev_err(&pdev->dev,
> -			"request_irq failed with err %d\n", err);
> +	if (err)
>  		goto err_free;

[Severity: High]
This is a pre-existing issue, but is it safe to ignore the return value of
mtk_hsdma_hw_init() called just before devm_request_irq()?

If clk_prepare_enable() fails inside mtk_hsdma_hw_init(), it returns an
error but mtk_hsdma_probe() proceeds anyway. If devm_request_irq() then
fails here, the error path calls mtk_hsdma_hw_deinit(), which writes to a
DMA register with the clock disabled. Might this crash the system with a
bus fault?

[Severity: High]
This isn't a bug introduced by this patch, but does this error path leave
dangling pointers if it fails?

The DMA controller is registered globally via dma_async_device_register()
earlier in mtk_hsdma_probe(), making channels visible to clients. If a
client acquires a channel and then devm_request_irq() fails here, the probe
aborts and devres frees the mtk_hsdma_device structure.

Since dma_async_device_unregister() doesn't forcefully revoke channels held
by clients, could the client be left with a dangling pointer to freed
memory?

Looking at mtk_hsdma_remove() in the same file:

drivers/dma/mediatek/mtk-hsdma.c:mtk_hsdma_remove() {
        ...
        /* Disable hardware */
        mtk_hsdma_hw_deinit(hsdma);

        dma_async_device_unregister(&hsdma->ddev);
        ...
}

[Severity: Medium]
This is a pre-existing issue, but could there be a race condition during
device removal?

The hardware is disabled via mtk_hsdma_hw_deinit() before the DMA
controller is unregistered. If a client attempts to use a DMA channel
while the driver is being unbound, could it issue a request after clocks
are disabled but before the device is unregistered?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709135846.9797=
2-1-panchuang@vivo.com?part=3D5

