Return-Path: <dmaengine+bounces-11485-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Y6j0J2ImK2oZ3QMAu9opvQ
	(envelope-from <dmaengine+bounces-11485-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 23:19:30 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DB9675674
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 23:19:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ctYlgzbi;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11485-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11485-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 59B4D3117971
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 21:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB5232860B;
	Thu, 11 Jun 2026 21:19:24 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B7736826B
	for <dmaengine@vger.kernel.org>; Thu, 11 Jun 2026 21:19:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781212764; cv=none; b=ZXUJvIfAQLI8seYbkzYKIsQly4J38DE4S9g8PpvuSYjnJ/JMQM4GFhZi73+G47Ejh6D0jmM8l21TDcHUdgVWgDyVHsjfa6Q1OGjFTmISE9NT01S77TUi+cPLvpP10WU2aL88520Sz3EeXxO1ftzeiCxx7lUl53LqM1Io5bgxIV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781212764; c=relaxed/simple;
	bh=iuJIDsbkaFgKl7D/8OeBgI9F2X7y5T+q+c4PNXWRFHM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AIkNAIVlbfFtvU08O8Y3mYrZPgcmhlFo2USFjBXDebH80tw1flhHP+bF30k0HKOlQvj1De+pkrlI2eaHegus8SPtMAjyyndCd4Aery+PmpCGH3soS3miWSbBNbs/KE4Uq0pZPiAJcMXk2PBJGGDFhM6+SZghmZNO/C2J+A29Oy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ctYlgzbi; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9F0C1F000E9;
	Thu, 11 Jun 2026 21:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781212762;
	bh=W1BJajpSV8qXysZ1faX+9GMKGERblcWi7QPYe7YqJX4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ctYlgzbiqbKe42PPb9+sxXUTrOATlwzU+ZS+9RZ6ZzB15OZ1NegXGhJeozyb0Ibdd
	 IHKzXP4cNrGE/aK3d/nA3/QIHs+TudM+d20vCTXtRujW/qpjBpA53J1+L5tcs5f9u3
	 mNvFd5Gb77J6BWmxSqeJMUVHfCAQSL88AoDgFTtHBPYonJtN6IhKH+LaVrJKQjd8fW
	 vHuXnn4tBfQi1fE57QfMSCWa/v3pQ3C4ABpMOSO9j26Uo5CW65rONVvEav26pXh/iC
	 V+mrS82JSYSIv1qPdRFjuqZA64Njo47XczMcDYoMbedyYex1Mg/MuunaZHffE0z0ql
	 kkMSJItJIB05A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv2 5/9] dmaengine: mv_xor: use
 devm_clk_get_optional_enabled
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: Frank.Li@kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260611210721.81979-6-rosenp@gmail.com>
References: <20260611210721.81979-6-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 21:19:22 +0000
Message-Id: <20260611211922.A9F0C1F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-11485-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:Frank.Li@kernel.org,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,lists.linux.dev:replyto]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C4DB9675674

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing tasklet_kill during channel teardown leads to Use-After-Fr=
ee.
- [High] Missing .remove callback without suppress_bind_attrs leads to sysf=
s unbind Use-After-Free.
--

commit 62603263a73bd470971917dcb68b349f4ca68734
Author: Rosen Penev <rosenp@gmail.com>

dmaengine: mv_xor: use devm_clk_get_optional_enabled

Replace clk_get() + clk_prepare_enable() + clk_put() with
devm_clk_get_optional_enabled(). This eliminates the need for manual clock
cleanup in the probe error path.

> diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
> index 25ed61f1b0899..a97fa0038652d 100644
> --- a/drivers/dma/mv_xor.c
> +++ b/drivers/dma/mv_xor.c
> @@ -1359,12 +1359,9 @@ static int mv_xor_probe(struct platform_device *pd=
ev)
>  			mv_xor_conf_mbus_windows(xordev, dram);
>  	}
> =20
> -	/* Not all platforms can gate the clock, so it is not
> -	 * an error if the clock does not exists.
> -	 */
> -	xordev->clk =3D clk_get(&pdev->dev, NULL);
> -	if (!IS_ERR(xordev->clk))
> -		clk_prepare_enable(xordev->clk);
> +	xordev->clk =3D devm_clk_get_optional_enabled(&pdev->dev, NULL);

[Severity: High]
This is a pre-existing issue, but does moving to a devres-managed clock
further expose a missing .remove callback?

The platform driver mv_xor_driver lacks a .remove callback and does not set
suppress_bind_attrs =3D true. This allows the driver to be unbound via sysf=
s.

Because there is no .remove callback, the driver core performs no teardown
on unbind, leaving DMA channels registered and the interrupt active since
request_irq() is used rather than devm_request_irq().

Devres will then automatically free the mv_chan memory, unmap IO memory,
and (with this patch) disable the clock. Any subsequent interrupt or DMA
request will access the freed mv_chan memory and unmapped registers,
causing a use-after-free and system panic.

> +	if (IS_ERR(xordev->clk))
> +		return PTR_ERR(xordev->clk);
> =20
>  	/*
>  	 * We don't want to have more than one channel per CPU in

[ ... ]

> @@ -1452,11 +1449,6 @@ static int mv_xor_probe(struct platform_device *pd=
ev)
>  				irq_dispose_mapping(xordev->channels[i]->irq);
>  		}

[Severity: High]
This isn't a bug introduced by this patch, but could a pending tasklet run
after devres frees the channel memory during probe failure?

In mv_xor_channel_add() in drivers/dma/mv_xor.c, an IRQ tasklet is
initialized. If probe fails (for instance, if a self-test times out while
an interrupt fires concurrently), the error path here calls
mv_xor_channel_remove(), which uses free_irq() to disable the interrupt.

However, neither mv_xor_channel_remove() nor the err_free_irq path in
mv_xor_channel_add() calls tasklet_kill(). Because mv_chan is allocated
via devm_kzalloc(), devres will free the memory shortly after probe returns.

If the scheduled tasklet executes after the memory is freed, it will
dereference mv_chan, leading to a use-after-free.

> -	if (!IS_ERR(xordev->clk)) {
> -		clk_disable_unprepare(xordev->clk);
> -		clk_put(xordev->clk);
> -	}
> -
>  	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611210721.8197=
9-6-rosenp@gmail.com?part=3D1

