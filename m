Return-Path: <dmaengine+bounces-11606-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CbDyF9B+M2pBCwYAu9opvQ
	(envelope-from <dmaengine+bounces-11606-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 07:14:56 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C76C969DA78
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 07:14:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=GvjZvsAD;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11606-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11606-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D191E30588A4
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 05:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5194637EFFB;
	Thu, 18 Jun 2026 05:14:53 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1C11F30BB;
	Thu, 18 Jun 2026 05:14:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781759693; cv=none; b=fbVK60n7u7JXrkrUgg2p8PHGTzdgZ5DY2RBCdt+h+p68dXjCFkMjuSYbS8U1yjZ2+mktNmWzQz6hXu/v3LaN/K4ia3SvzUyJI+KA2aQ8jN48zk13zdkcYxO0/EwMgvtsqVRS6UJvLnrvda0rVxYvOKN0PD+F78izMm1aVpIy5qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781759693; c=relaxed/simple;
	bh=9mfGawct8LLCFnZ6auyGFmN8+f4yLVMLFa+ZP5PN+u4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V4XDoOcqZg0ZltAnpg/tS2FgLzktIyuddvlmKlQ1VtETMpZNT1wRfYBF1de/FSA4gZrZBIj/4kU+UKi1NU5JzVqq8Sv4mmcX19+MBs2RqVZFlm/+Oya14X+uRzg2iAmZL8/aOrOClXXAB5cLbgVTOeH1tJ1r7iQtfZTFPwv/3Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GvjZvsAD; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F0AA1F000E9;
	Thu, 18 Jun 2026 05:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781759691;
	bh=RoglodZMn4outYdAyCSJRFXV2SdQJ5MaOF7RpmfT594=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GvjZvsAD44HiM0MAaF1pe3unCaNdl+z9HpzHswHROeHDqk/qYghdpIuRHiQ/V4VH0
	 sm059PvV4FrTyHn1UqtKe4UGQG8BFJN9oh9BHqjrsFx2oCHcIOHwRqJcM8y+uXZcIU
	 PVKl2Q6HYSlUpfxlHABDSAYJfncG0jJy+DwOBYcJhXtFqZKfYnr+eojh5TjKKdPknT
	 B0DXNEYYzipcSxx6Ug2n3HR0JU8WctUbIRUkWk5aaXJIm36f64iPWm/yCG2XtitPAH
	 OSMemanmNJkZmjjV6fEEUzktA24T4ACWx+SJldq3zKlxxsi6g7lmZ6uc7LfRvYnJCe
	 mOf+m2MFuf8HA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/11] ARM: dts: ux500: Add power domains
Reply-To: sashiko-reviews@lists.linux.dev
To: "Linus Walleij" <linusw@kernel.org>
Cc: robh@kernel.org, dri-devel@lists.freedesktop.org, conor+dt@kernel.org, devicetree@vger.kernel.org, Frank.Li@kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260618-ux500-power-domains-v7-1-v1-5-eb5e50b1a588@kernel.org>
References: <20260618-ux500-power-domains-v7-1-v1-0-eb5e50b1a588@kernel.org>
 <20260618-ux500-power-domains-v7-1-v1-5-eb5e50b1a588@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 05:14:51 +0000
Message-Id: <20260618051451.6F0AA1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-11606-lists,dmaengine=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linusw@kernel.org,m:robh@kernel.org,m:dri-devel@lists.freedesktop.org,m:conor+dt@kernel.org,m:devicetree@vger.kernel.org,m:Frank.Li@kernel.org,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,sashiko.dev:url,vger.kernel.org:from_smtp,smtp.kernel.org:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C76C969DA78

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The `clocks` node is incorrectly assigned to `DOMAIN_VPLL` instead=
 of `DOMAIN_VAPE` and includes an unresolved `CHECKME` comment.
- [Medium] Adding `power-domains` to nodes whose binding schemas do not all=
ow it will cause `dtbs_check` validation errors.
--

commit 57cdb12b349af07637860b10a8f8232b9e2930bc
Author: Linus Walleij <linusw@kernel.org>

ARM: dts: ux500: Add power domains

Add the actual power domains to all the SoC peripherals.

> diff --git a/arch/arm/boot/dts/st/ste-dbx5x0.dtsi b/arch/arm/boot/dts/st/=
ste-dbx5x0.dtsi
> index d76a65da70111..a6fef302c994e 100644
> --- a/arch/arm/boot/dts/st/ste-dbx5x0.dtsi
> +++ b/arch/arm/boot/dts/st/ste-dbx5x0.dtsi

[ ... ]

> @@ -334,6 +340,7 @@ L2: cache-controller {
>  			compatible =3D "arm,pl310-cache";
>  			reg =3D <0xa0412000 0x1000>;
>  			interrupts =3D <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
> +			power-domains =3D <&pm_domains DOMAIN_VARM>;

[Severity: Medium]
Will adding power-domains here cause dtbs_check validation errors?

The l2c2x0.yaml binding schema (along with others modified in this patch li=
ke
arm/pmu.yaml, stericsson,u8500-clks.yaml, arm,twd-timer.yaml,
arm,twd-wdt.yaml, and ste,mcde.yaml) does not include power-domains in its
list of allowed properties.

Do these bindings need to be updated to document the power-domains capabili=
ty
before it can be used?

>  			cache-unified;
>  			cache-level =3D <2>;
>  		};

[ ... ]

> @@ -357,6 +365,7 @@ clocks {
>  			reg =3D <0x8012f000 0x1000>, <0x8011f000 0x1000>,
>  			    <0x8000f000 0x1000>, <0xa03ff000 0x1000>,
>  			    <0xa03cf000 0x1000>;
> +			power-domains =3D <&pm_domains DOMAIN_VPLL>; /* CHECKME: correct doma=
in? */

[Severity: High]
Should this be DOMAIN_VAPE instead of DOMAIN_VPLL?

The PRCC registers mapped here for peripheral groups 1, 2, 3, 5, and 6 resi=
de
in the VAPE power domain alongside the peripherals they clock.

If the clock controller is assigned to DOMAIN_VPLL, the power domain framew=
ork
won't guarantee DOMAIN_VAPE is powered on when accessing these registers,
which could cause a synchronous external abort.

Also, is the CHECKME comment intended to be resolved before merging?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618-ux500-powe=
r-domains-v7-1-v1-0-eb5e50b1a588@kernel.org?part=3D5

