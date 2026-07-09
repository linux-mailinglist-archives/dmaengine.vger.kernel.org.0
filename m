Return-Path: <dmaengine+bounces-12219-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id R+stBl6wT2ozmwIAu9opvQ
	(envelope-from <dmaengine+bounces-12219-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:29:50 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4777323F7
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:29:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=W6548fE9;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12219-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-12219-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BC3F3303B6A8
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 14:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E730330D3B;
	Thu,  9 Jul 2026 14:23:41 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D801BBBFC
	for <dmaengine@vger.kernel.org>; Thu,  9 Jul 2026 14:23:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783607021; cv=none; b=aoIyL6sEf7s+iq5tTnOZodp1MK/nTrzyIWXvCt4nYYDk3LP22jMokzcYi53DIOvb5BeVFKQ4n6KEaLSNU5MAdns+hXDR8f7+jgo1pdIAo01JWS8Dte+vkK/QIOZ6KLULGbqqGpoHZ+RW04L5yig1Co+EPXv+B3ohTknNtQX4AnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783607021; c=relaxed/simple;
	bh=N2owLqQ+Ple1keEPEHMm5sLk/V92rsy5s/mPlrC29CQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BRFh5/buy/mjGpnTskU452OdOahlppLs2kdkLJ/v6+cEk5TkjEDl9Ef4mbjbkDhPFQICPq/b5OPGe4z9W+8PDQQRhCVIo66ajFdn4BM8FAjoYHQvzcGu2G9n+3B8HQURYMLFqNsRwqMLbjl9drnQ0GGUhhDpA1XJOkEyHMEdzSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W6548fE9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A84981F00A3E;
	Thu,  9 Jul 2026 14:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783607020;
	bh=UsNXh191FC+P1JDNVQfHz0rhp50vuU38c3VHCuRUNN0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W6548fE9IZMHgDX9Uv73jmYAHnX+Z/dlPXeOnOD+0JVuh270aRLvmCiVpv1WroTon
	 Gfyem70EjU41LKUEJ/sJwQJbVw7J90yyp1+pMDMRR1ffEPaBC3YMjsXl3z2Vi8MKlu
	 VCOdrg0U7GH5mmy2+TcznGGHDzQ9eQe7mbcm1Gf1JBI+w1fcFERmmET0M4/Msz5+ir
	 1myO7P6w0m3m23pDiEctO0u1IUudag4H0jWBwppWAk/xbgoyJZHBTMXJP3B9xPO3Ia
	 P2jE85n+/+Hv68KtE2EilYnq/fELZh5PtYEqZocKOL1pn8hS0hwyu06FsFNyKZQIc7
	 IT9mRXzgwykdQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/26] dmaengine: sh-rcar-dmac: Remove redundant
 dev_err()/dev_err_probe()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pan Chuang" <panchuang@vivo.com>
Cc: Frank.Li@kernel.org, dmaengine@vger.kernel.org, wsa+renesas@sang-engineering.com, vkoul@kernel.org
In-Reply-To: <20260709135846.97972-13-panchuang@vivo.com>
References: <20260709135846.97972-1-panchuang@vivo.com>
 <20260709135846.97972-13-panchuang@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 14:23:39 +0000
Message-Id: <20260709142339.A84981F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MISSING_MIME_VERSION(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-12219-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,smtp.kernel.org:mid,vger.kernel.org:from_smtp,sashiko.dev:url,vivo.com:email];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:panchuang@vivo.com,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:wsa+renesas@sang-engineering.com,m:vkoul@kernel.org,m:wsa@sang-engineering.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AB4777323F7

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] System crash due to unclocked register access on spurious interrupt
--

--- Patch [12]: [PATCH 12/26] dmaengine: sh-rcar-dmac: Remove redundant dev=
_err()/dev_err_probe() ---
commit 910ca9859b95c7ea2133b72448deeefa62bebf2b
Author: Pan Chuang <panchuang@vivo.com>

dmaengine: sh-rcar-dmac: Remove redundant dev_err()/dev_err_probe()

This commit removes driver-specific error logging when requesting the
channel interrupt. The logging is removed because
devm_request_threaded_irq() now automatically logs detailed error messages
on failure.

> diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
> index 44eab2d21d54f..4cd7f0189bc7b 100644
> --- a/drivers/dma/sh/rcar-dmac.c
> +++ b/drivers/dma/sh/rcar-dmac.c
> @@ -1793,11 +1793,8 @@ static int rcar_dmac_chan_probe(struct rcar_dmac *=
dmac,
>  					rcar_dmac_isr_channel,
>  					rcar_dmac_isr_channel_thread, 0,
>  					irqname, rchan);

[Severity: High]
This is a pre-existing issue, but is it safe to leave the interrupt active
when the device enters runtime suspend?

Since the IRQ is managed by devm_request_threaded_irq(), it remains
unmasked even when the power domain gates the clock (for example, after
rcar_dmac_probe() calls pm_runtime_put()).

If a spurious interrupt fires while the clock is gated, the hardirq
handler unconditionally accesses a device register:

rcar_dmac_isr_channel() {
        ...
        chcr =3D rcar_dmac_chan_read(chan, RCAR_DMACHCR);
        ...
}

Could this unclocked register read cause a synchronous external abort and
subsequent kernel panic?

A similar window appears to exist in rcar_dmac_remove(). It calls
pm_runtime_disable(), which leaves the clock disabled if the device was
already suspended, before devres unregisters the IRQ. Can a spurious
interrupt during this teardown phase also trigger the same panic?

> -	if (ret) {
> -		dev_err(dmac->dev, "failed to request IRQ %u (%d)\n",
> -			rchan->irq, ret);
> +	if (ret)
>  		return ret;
> -	}
> =20
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709135846.9797=
2-1-panchuang@vivo.com?part=3D12

