Return-Path: <dmaengine+bounces-12229-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eNJ7FJu2T2qlnAIAu9opvQ
	(envelope-from <dmaengine+bounces-12229-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:56:27 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BCC732878
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:56:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=g1Ak8pIh;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12229-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12229-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBFE93242986
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 14:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF313002DF;
	Thu,  9 Jul 2026 14:33:11 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5283290D5
	for <dmaengine@vger.kernel.org>; Thu,  9 Jul 2026 14:33:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783607591; cv=none; b=oRJ9YVa/6zr+iN6G57DEcnS/xBviAPweEScjXLMaTopSE3hOzXziEOmp+G/TV8Seq1VcsY5kWSELbaVy1FQiRC0WMeN2INuAhVP5wobcMRMEUKE+dRWR81jtBDl3tBpJofdZkslck+Oc6P84stbYqzMnePRXjGIK1ih4wQd5NKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783607591; c=relaxed/simple;
	bh=KgfpZz1OuF3V0Yuu48fRBNQvSSFXWvNG4obMKBRc4eM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LB4sy5j9/87It3KRNijwjr8vqOpbDX1s8zSYGTbQL/EnzxjcEA65Y5F2Z/Vfdtl/FgfjcEiHxeJ5tJjybdonHOBzaCWKKKJu1GqrfElp35kAj32//Z7Eqn8yRijKSpo87YwB3M26aakV6S3WbThiaW+udR3C31JX/k0Q69ozyZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g1Ak8pIh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1F351F000E9;
	Thu,  9 Jul 2026 14:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783607590;
	bh=m5KPzB6O7cfcLIvw397wxyVwMVJ0p5tXuzIhBHWrSJE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g1Ak8pIh/7AcRWqqzbziO0AhVmWQDK+GTVt6lBkO6DnlkiftDmOJAhfAs6mh03CpL
	 Fm/kzJ/2vBNGOaeuytK4WCG4/WzyEFBwHypybyBjrdZ4KH/sjCNm5jipAEeZKHPVGd
	 6VCG/Q7uLNTFsm6mlRfP/1nfHYeB5QlZq5aC1hBR7EbdJnlNVv2rHuRCDQlr7dPP6l
	 ENjlxB1H4bS9hxs6X5ZRBqqVJjDqAFCIBJaGVh7AgPsMqDrTlyOZst0K4otrUeMoDT
	 UlDVot08vhbNZumYyoYo4XjTKATrxnDM8gc69Zk2MGbR6Y2drSHmK93JPrxUCtkCaM
	 s4YhuyTfvTmHg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 19/26] dmaengine: stm32-stm32-dma3: Remove redundant
 dev_err()/dev_err_probe()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pan Chuang" <panchuang@vivo.com>
Cc: Frank.Li@kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260709135846.97972-20-panchuang@vivo.com>
References: <20260709135846.97972-1-panchuang@vivo.com>
 <20260709135846.97972-20-panchuang@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 14:33:09 +0000
Message-Id: <20260709143309.F1F351F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-12229-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:panchuang@vivo.com,m:Frank.Li@kernel.org,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vivo.com:email,sashiko.dev:url,smtp.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,lists.linux.dev:replyto]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 93BCC732878

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The OF DMA controller is registered using the non-managed `of_dma_=
controller_register()`, but it is never freed in the driver's `remove` func=
tion, leading to a resource leak and a Use-After-Free vulnerability.
- [High] The DMA controller exposes its channels to clients before completi=
ng initialization, creating a fatal race condition if subsequent channel se=
tups fail.
- [High] Disabling the clock manually before devres cleans up devm-managed =
IRQs leaves a window where active IRQs can access unclocked hardware.
--

--- Patch [19]: [PATCH 19/26] dmaengine: stm32-stm32-dma3: Remove redundant=
 dev_err()/dev_err_probe() ---
commit 71644e471343978f46dd63e4905f5c779768528f
Author: Pan Chuang <panchuang@vivo.com>

dmaengine: stm32-stm32-dma3: Remove redundant dev_err()/dev_err_probe()

The devm_request_irq() now automatically logs detailed error messages on
failure. This eliminates the need for driver-specific dev_err() and
dev_err_probe() calls that previously printed generic messages.

> diff --git a/drivers/dma/stm32/stm32-dma3.c b/drivers/dma/stm32/stm32-dma=
3.c
> --- a/drivers/dma/stm32/stm32-dma3.c
> +++ b/drivers/dma/stm32/stm32-dma3.c
> @@ -1893,11 +1893,8 @@ static int stm32_dma3_probe(struct platform_device=
 *pdev)
> =20
>  		ret =3D devm_request_irq(&pdev->dev, chan->irq, stm32_dma3_chan_irq, 0,
>  				       dev_name(chan2dev(chan)), chan);
> -		if (ret) {
> -			dev_err_probe(&pdev->dev, ret, "Failed to request channel %s IRQ\n",
> -				      dev_name(chan2dev(chan)));
> +		if (ret)
>  			goto err_clk_disable;

[Severity: High]
This is a pre-existing issue, but by jumping to err_clk_disable here, could
we trigger a crash if an interrupt fires?

If stm32_dma3_probe() fails on a later iteration of this loop, we jump to
the manual clock disable cleanup:

err_clk_disable:
        clk_disable_unprepare(ddata->clk);

Since we used devm_request_irq() for previous channels, those IRQs remain
active until devres runs. If an interrupt fires during this window, the
handler would access unclocked registers.

[Severity: High]
This is also a pre-existing issue, but does failing here leave dangling
channel registrations?

Earlier in stm32_dma3_probe(), we called dmaenginem_async_device_register()
and dma_async_device_channel_register() before this channel initialization
loop completes.=20

If a failure occurs in this loop and we jump to the error path, any client
that has already requested the successfully registered channels could be
exposed to an asynchronous teardown, potentially accessing unclocked hardwa=
re
or freed memory.

> -		}
>  	}
> =20
>  	ret =3D of_dma_controller_register(np, stm32_dma3_of_xlate, ddata);

[Severity: High]
This is a pre-existing issue, but does this leak the DMA controller?

The of_dma_controller_register() function is used here, but looking at
stm32_dma3_remove(), there is no corresponding call to
of_dma_controller_free().

stm32_dma3_remove() simply disables runtime PM:

static void stm32_dma3_remove(struct platform_device *pdev)
{
        pm_runtime_disable(&pdev->dev);
}

If the driver is unbound, the devm-managed ddata will be freed, but the
controller remains registered. A subsequent DMA request via devicetree
would then invoke stm32_dma3_of_xlate() with a dangling ddata pointer,
causing a use-after-free.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709135846.9797=
2-1-panchuang@vivo.com?part=3D19

