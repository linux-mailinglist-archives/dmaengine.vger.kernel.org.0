Return-Path: <dmaengine+bounces-11906-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id n0K/LzN/RGpavwoAu9opvQ
	(envelope-from <dmaengine+bounces-11906-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 01 Jul 2026 04:45:07 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA046E94AA
	for <lists+dmaengine@lfdr.de>; Wed, 01 Jul 2026 04:45:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Cq3a2cjF;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11906-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11906-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 645233010F27
	for <lists+dmaengine@lfdr.de>; Wed,  1 Jul 2026 02:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85146363C50;
	Wed,  1 Jul 2026 02:45:01 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D15D21257F;
	Wed,  1 Jul 2026 02:45:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782873901; cv=none; b=WR5/VJzHra4CYwNEksKumpTC3VGwt8Z2Tmf/3KbEPq0r7t55j8g7T+0nu/M3a4e5jKPaBWWzaRAKbTbbuL0ZVAUQwQ0K6bd19eTlTWascMCVLlTFHysm2WqvXZMBL2FLgpLjymzeb2mqg5vyVeSBBbESyTcaZrAAv4cAcTxL+Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782873901; c=relaxed/simple;
	bh=RF4euZ9RIPjwdIKIeQUbBgDQhrOuuYC1NTJwKJqG4/w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Kk7hcBaB5IDkYOBybAx2Q5vN1/MmB/PoJ3eU+3AuCliy608W6fj6B+i0HlNRHT4+LFME4iF44TVHla9TYeWYpP8MtCyUP1lUi7npnwFBKBbuB8rI6VGVhT5KIE4O3i9s4QVclXO5Df8ELRX7Jvv+6RHb3p4GWCMdrrBqX3u2Avg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cq3a2cjF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB321F000E9;
	Wed,  1 Jul 2026 02:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782873900;
	bh=/Bnrg1WoliTLxopCnz1bWMqddLrP6tGgpk2T3QZ6FEw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Cq3a2cjFpeqyQwj/UBotOuN8RFTF1MBb/KtmPNKBdKN+hNeZwNG7B5/q/hQ2elK4/
	 3x2S0nR45q9UkSUaYAHrjEWmxUVs+78k0kPACMw8u7SsKuXpueC4CcdtGIVGuyhdEx
	 hIeNFpWQ2REwjTmL+1MIp2yY7aHSh25dO+/pMGTTuPcigFRSNCDqU/GDngnoEstYFX
	 1C7HPxxnlDroZoAWK5dVALuPK9W+MZhFwmMZoZK23ULiXZOA9TYfuSG0ZgFK3kGGTF
	 oP9KuSlcEXhEIqXioa9h9dQaEr/GbVXHbQHPkR9ZkAHpMDCRkDk7IHS3DnbJBggBD7
	 V8LfH5BQb23Rg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dt-bindings: altr,msgdma: update maintainer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Adrian Ng Ho Yin" <adrian.ho.yin.ng@altera.com>
Cc: Frank.Li@kernel.org, conor+dt@kernel.org, robh@kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260701023455.36330-1-adrian.ho.yin.ng@altera.com>
References: <20260701023455.36330-1-adrian.ho.yin.ng@altera.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 02:44:58 +0000
Message-Id: <20260701024459.AEB321F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-11906-lists,dmaengine=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:adrian.ho.yin.ng@altera.com,m:Frank.Li@kernel.org,m:conor+dt@kernel.org,m:robh@kernel.org,m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:devicetree@vger.kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,smtp.kernel.org:mid,sashiko.dev:url,altera.com:email,lists.linux.dev:replyto,vger.kernel.org:from_smtp,get_maintainer.pl:url,devicetree.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7DA046E94AA

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The commit updates the maintainer in the DT binding YAML file bu=
t fails to update the corresponding entry in the global MAINTAINERS file.
--

commit db17ec175a921c83db0dc0de95284d7a5faee871
Author: Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>

dt-bindings: altr,msgdma: update maintainer

This commit updates the maintainer for the Altera mSGDMA IP core from
Olivier Dautricourt to Adrian Ng Ho Yin in the device tree binding file.

> diff --git a/Documentation/devicetree/bindings/dma/altr,msgdma.yaml b/Doc=
umentation/devicetree/bindings/dma/altr,msgdma.yaml
> index 391bf58386025..bea302b894534 100644
> --- a/Documentation/devicetree/bindings/dma/altr,msgdma.yaml
> +++ b/Documentation/devicetree/bindings/dma/altr,msgdma.yaml
> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: Altera mSGDMA IP core
> =20
>  maintainers:
> -  - Olivier Dautricourt <olivierdautricourt@gmail.com>
> +  - Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>

[Severity: Medium]
Does the global MAINTAINERS file also need to be updated to reflect this
change?

Currently, the MAINTAINERS file still points to the previous maintainer:

MAINTAINERS:
ALTERA MSGDMA IP CORE DRIVER
M:	Olivier Dautricourt <olivierdautricourt@gmail.com>
R:	Stefan Roese <sr@denx.de>

Without updating this global file, get_maintainer.pl will still return the
previous maintainer for patches touching the driver code.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701023455.3633=
0-1-adrian.ho.yin.ng@altera.com?part=3D1

