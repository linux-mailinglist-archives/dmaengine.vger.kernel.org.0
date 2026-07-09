Return-Path: <dmaengine+bounces-12234-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id M2wmAAG0T2oPnAIAu9opvQ
	(envelope-from <dmaengine+bounces-12234-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:45:21 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB227326C5
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:45:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=exOhwayM;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12234-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12234-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C65C030082A8
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 14:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3682E36DA1C;
	Thu,  9 Jul 2026 14:38:16 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA6A1C84CB
	for <dmaengine@vger.kernel.org>; Thu,  9 Jul 2026 14:38:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783607896; cv=none; b=M2tLxJU3ckvUS3xbSY7uEOnvMVjA0US9jyd5yWJ5iZx0nPq3ou2GutuvHb7SqdEeYKSawRfAFSooAJ93IC6LTeovwkfxHCisP/uDhLW4rDAhwv62Kc65VhLNNjkMkUDWaIav/NEnxlOzhqyCdubvnN3A11w3x3OC9Fvc5FSfEuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783607896; c=relaxed/simple;
	bh=2ZMTssOBqnwOzne4MfHFVQkqDSyqO1osZtyE5nmCO8o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FOvjxZvUNvJEknh62Zzp47/zde+F+3SII/OI+CLGX0nKpLe8aaGJI6etGM966D6tpSNc0fwuE4bPCS8b1LbxYdrn7d3OlgcXTfUD6mVN59NhtJExhSx/FvPYTB3lh2E8GFOJJBlSGzpH5r51ZzbOhhgnl6bRcMbiWjMFZ7gW7xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=exOhwayM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D5181F000E9;
	Thu,  9 Jul 2026 14:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783607894;
	bh=/7FsAgaG74n+/wXOBZRi8XxzLTV4jzuURfa51p1j0xs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=exOhwayMSET2dhE5t9Lou+N3ygPTOSSG2K7nakBiohPuyxteuaBqxeRdFqs8bPl96
	 rzqvIVu0JQZij4TeBVXZpe2Cmrle0yZ5EIVXNmhLlcmaDl+BOqwPRSmlxIm93FUPpg
	 uPn3fYTX4ECcHeiRr+ySvfpXi4jtqZcV4zsYY9uqlXvznScjo4ig29hak/DXKvX0dl
	 FlkTjXOKAA1pNZ8glOkoVMIOwYQ1ZuR36nssgrm2LqwHvk6asmxpF9pr/pLJzzu+JG
	 lDrJQCZrikKqXLjNDHvI5RABvlLutByQRpnRIWfoX6a4mENj//w44oXuvueO4dxmRe
	 dFVsMwAIamilg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 24/26] dmaengine: ti-edma: Remove redundant
 dev_err()/dev_err_probe()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pan Chuang" <panchuang@vivo.com>
Cc: Frank.Li@kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org
In-Reply-To: <20260709135846.97972-25-panchuang@vivo.com>
References: <20260709135846.97972-1-panchuang@vivo.com>
 <20260709135846.97972-25-panchuang@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 14:38:14 +0000
Message-Id: <20260709143814.9D5181F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-12234-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,lists.linux.dev:replyto,smtp.kernel.org:mid,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5AB227326C5

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unhandled probe deferral from `platform_get_irq_byname` causes the=
 driver to silently probe without interrupts.
--

--- Patch [24]: [PATCH 24/26] dmaengine: ti-edma: Remove redundant dev_err(=
)/dev_err_probe() ---
commit 3f067543fc6aa46c8b00f2557e8220b1465e86e3
Author: Pan Chuang <panchuang@vivo.com>

dmaengine: ti-edma: Remove redundant dev_err()/dev_err_probe()

The commit removes redundant dev_err() logging around devm_request_irq()
calls. The devm_request_irq() function now automatically logs detailed error
messages on failure, eliminating the need for driver-specific messages.

> diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
> index d97db5af35555..e023ca9640dec 100644
> --- a/drivers/dma/ti/edma.c
> +++ b/drivers/dma/ti/edma.c
> @@ -2415,10 +2415,8 @@ static int edma_probe(struct platform_device *pdev)
> =20
>  	irq =3D platform_get_irq_byname(pdev, "edma3_ccint");
>  	if (irq < 0 && node)
>  		irq =3D irq_of_parse_and_map(node, 0);
> =20
>  	if (irq > 0) {
>  		irq_name =3D devm_kasprintf(dev, GFP_KERNEL, "%s_ccint",
>  					  dev_name(dev));
>  		if (!irq_name) {
>  			ret =3D -ENOMEM;
>  			goto err_disable_pm;
>  		}
> =20
>  		ret =3D devm_request_irq(dev, irq, dma_irq_handler, 0, irq_name,
>  				       ecc);
> -		if (ret) {
> -			dev_err(dev, "CCINT (%d) failed --> %d\n", irq, ret);
> +		if (ret)
>  			goto err_disable_pm;
> -		}
>  		ecc->ccint =3D irq;
>  	}

[Severity: High]
This is a pre-existing issue, but does this logic handle probe deferrals
correctly?

If platform_get_irq_byname() returns -EPROBE_DEFER, the irq value is
either overwritten to 0 by irq_of_parse_and_map(), or remains -EPROBE_DEFER.
In both scenarios, the if (irq > 0) check fails, causing the driver to
silently skip interrupt setup and successfully complete the probe without
interrupts.

Could this lead to dependent devices hanging or experiencing timeouts
because DMA completions are never signaled?

[ ... ]

> @@ -2436,10 +2434,8 @@ static int edma_probe(struct platform_device *pdev)
> =20
>  	irq =3D platform_get_irq_byname(pdev, "edma3_ccerrint");
>  	if (irq < 0 && node)
>  		irq =3D irq_of_parse_and_map(node, 2);
> =20
>  	if (irq > 0) {
>  		irq_name =3D devm_kasprintf(dev, GFP_KERNEL, "%s_ccerrint",
>  					  dev_name(dev));
>  		if (!irq_name) {
>  			ret =3D -ENOMEM;
>  			goto err_disable_pm;
>  		}
> =20
>  		ret =3D devm_request_irq(dev, irq, dma_ccerr_handler, 0, irq_name,
>  				       ecc);
> -		if (ret) {
> -			dev_err(dev, "CCERRINT (%d) failed --> %d\n", irq, ret);
> +		if (ret)
>  			goto err_disable_pm;
> -		}
>  		ecc->ccerrint =3D irq;
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but the error interrupt setup
appears to suffer from the same problem.

Would an unhandled probe deferral from platform_get_irq_byname() result
in silently swallowed errors here as well?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709135846.9797=
2-1-panchuang@vivo.com?part=3D24

