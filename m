Return-Path: <dmaengine+bounces-11603-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dB2QG9F9M2rICgYAu9opvQ
	(envelope-from <dmaengine+bounces-11603-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 07:10:41 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F3869DA3F
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 07:10:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=NKd2FRcF;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11603-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11603-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB24F3011126
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 05:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2658137E2E5;
	Thu, 18 Jun 2026 05:10:37 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC3737E2E2;
	Thu, 18 Jun 2026 05:10:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781759437; cv=none; b=TwZQitTZXOe0ZU5bzAidR9p64kIiDm9y01ER8jWj8dxxuA7qbmQGMMOJZaFw0Mv0gF8qbsdIhCoKVL68gwUj5i0P5ThaslTi0u/zZeZcqh2Sf745VkaxVP3lWyPRh1UaAO0yZXMQpakh8EiuTuYV+oGc8HVAee6TPxg5kmn6B1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781759437; c=relaxed/simple;
	bh=yb7gmUkJRD/NPDFgu7vaqHfC7v8OYWtmzzshEX9CjPE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f318kZGrul1UsGJ/MXr4lr2oFo25HLUVh3NMAC9c5UopOswsQkaaM4nxFjFhDjbM8vhjmYBjmd6wdqMetmX1iXSSZi136vpMORTypTi1rVE9VkT0+44v8s9ehxK0MGNEvEUYMXjntiMdgaHMkir3/8HGpCsn0lTROthv9pDUo3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NKd2FRcF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 675601F000E9;
	Thu, 18 Jun 2026 05:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781759435;
	bh=L8yDpLryHHHFlQA+V504Avl+bMV1mqW/Jc/Pager9Xw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NKd2FRcFmCQ9DB10o5Py0qxpwqsiIkhV4z09f5xnuMWcFz2KFwGqy/nfaa+iQyZNB
	 Ccypqhr7fanI/WUt34pTT5adz2ATxzKGZb9mZZGs+vAczEwKNfHPFiJS6Nz3e070Fd
	 DRA1U9NZJrz6xJmrFc6s6DAtSo7GwhRdkJInKdW1x013bC23K/84nvYu4R1ZHeHx3o
	 b+nvmQY0cyf2rNFPKRf7MwFctc+hD4LNH+6yU0Y+znGemXmXk/qBO81GfZb9oGFW1w
	 9yh6AHby7h/06NjOcD0zjTfYa3Dn3BuhDsWRaJeb5lS4waAQ1dd97gyRiQCuZDhyjv
	 +JtWh/bBeHHIQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/11] pmdomain: st: ux500: Implement more power domains
Reply-To: sashiko-reviews@lists.linux.dev
To: "Linus Walleij" <linusw@kernel.org>
Cc: robh@kernel.org, devicetree@vger.kernel.org, vkoul@kernel.org, conor+dt@kernel.org, dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org, Frank.Li@kernel.org
In-Reply-To: <20260618-ux500-power-domains-v7-1-v1-3-eb5e50b1a588@kernel.org>
References: <20260618-ux500-power-domains-v7-1-v1-0-eb5e50b1a588@kernel.org>
 <20260618-ux500-power-domains-v7-1-v1-3-eb5e50b1a588@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 05:10:35 +0000
Message-Id: <20260618051035.675601F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-11603-lists,dmaengine=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linusw@kernel.org,m:robh@kernel.org,m:devicetree@vger.kernel.org,m:vkoul@kernel.org,m:conor+dt@kernel.org,m:dmaengine@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:Frank.Li@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sashiko.dev:url,lists.linux.dev:replyto,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 07F3869DA3F

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The comment regarding Vape_esram0_pwr contradicts the implementatio=
n of ux500_pm_domain_esram_12.
--

commit e7c9ddf5e852fa7ba6bbf083dd8b845efaaf86e5
Author: Linus Walleij <linusw@kernel.org>

pmdomain: st: ux500: Implement more power domains

This starts to implement the power domains that are just skeleton
implementations right now.

> diff --git a/drivers/pmdomain/st/ste-ux500-pm-domain.c b/drivers/pmdomain=
/st/ste-ux500-pm-domain.c
> index 6896cb4a7b716..7230010046908 100644
> --- a/drivers/pmdomain/st/ste-ux500-pm-domain.c
> +++ b/drivers/pmdomain/st/ste-ux500-pm-domain.c
> @@ -41,14 +41,137 @@ static int pd_power_on(struct generic_pm_domain *dom=
ain)
>  	return 0;
>  }
> =20
> +/*
> + * Apart from these voltage domains there is also VSAFE which is always
> + * on. Vape_esram0_pwr for eSRAM0 is connected to VSAFE.
> + */
>  static struct generic_pm_domain ux500_pm_domain_vape =3D {

[ ... ]

> +static struct generic_pm_domain ux500_pm_domain_b2r2_mcde =3D {
> +	/* Vape_DSS_pwr DSS (display subsystem) */
> +	.name =3D "B2R2_MCDE",
> +	.power_off =3D pd_power_off,
> +	.power_on =3D pd_power_on,
> +};
> +
> +static struct generic_pm_domain ux500_pm_domain_esram_12 =3D {
> +	/* Vape_esram0_pwr, Vape_esram1_pwr */
> +	.name =3D "ESRAM_12",

[Severity: Low]
Is this comment accurate? An earlier comment states that Vape_esram0_pwr for
eSRAM0 is connected to the always-on VSAFE domain, but it is listed here as
part of the switchable ESRAM_12 power domain. Should this comment refer to
Vape_esram1_pwr and Vape_esram2_pwr instead?

> +	.power_off =3D pd_power_off,
> +	.power_on =3D pd_power_on,
> +};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618-ux500-powe=
r-domains-v7-1-v1-0-eb5e50b1a588@kernel.org?part=3D3

