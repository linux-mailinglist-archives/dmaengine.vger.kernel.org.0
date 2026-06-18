Return-Path: <dmaengine+bounces-11615-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id S1c8HkicM2ryEAYAu9opvQ
	(envelope-from <dmaengine+bounces-11615-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 09:20:40 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADEF69E0A9
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 09:20:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=kZAjktbS;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11615-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-11615-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8313F300788D
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 07:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CB33C456B;
	Thu, 18 Jun 2026 07:20:36 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF893C4548;
	Thu, 18 Jun 2026 07:20:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781767236; cv=none; b=nHYiEZGs61CRV4Y3SXInDZZLVbGQZECq3juWUclv9hBSPFuWwPFmCSn9JWTK7AchPKwKVQkH4xe+1cLaJ+Mi2QvOsdacVN53ZyapysZ/bOk8geAXrX2vD9TC2AAHNwmWu++Cod7zgSQPYmM0a8VKh9ZvE8PgsaHHrQP4pbD0F+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781767236; c=relaxed/simple;
	bh=Jxc1Xt87zK7PJTud6+AF4387hglSIhjNt2Aq/CyZxAc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lNOn1UWrPFmHzL/G5+lvZoClmrtPJzkpMbUrm4UD/G+eMr9FLjVYP3XjUt44qBoG8zo46qP6dR+YNHLqBtkr3DCau+Rg1RHSBXcQSCZASI1JtNEaOYwMmgHT7U6TekG/8GrfPV1ghlOuL20c6HM7iK8Rt1DX9pdUiFuNHFaLuBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZAjktbS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20A481F000E9;
	Thu, 18 Jun 2026 07:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781767234;
	bh=As0/LnI6+OcaBsgMP7BjAXMFViZQzf0n7GoqXvf85vc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kZAjktbSuXsFAOziR6q5OgbQNAz+l6OAWeWAhiA3bnRNJxiMKtTSm3vlevOVUPXHq
	 /N750WW3zg5fPqnxPFwGysaEQkBsXTEbnNJnh2eGkaBsygZGhvYYT4OvIwivozM3Xr
	 R72A+jeb/YU1bJL61RqNcbyQP8PA8RIGGV6jPQdfkUsgNawKqsot69kQ/jGObKkUFj
	 JZ6G+n2AMTk+fd8Ory4dC65kODzv2bhrWCA3VQpwAKsK3Cu1FEYe/On2FM0w1izh+m
	 +oLGUipZ7ViWIh+GqCYYsdgb1LWlJQe5F+xh1KEqxFrLeiJWgybc9zPhdiBropTkKk
	 Uqy6PCnp9UxPQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/11] ARM: dts: ux500: Remove DB8500 EPOD regulators
Reply-To: sashiko-reviews@lists.linux.dev
To: "Linus Walleij" <linusw@kernel.org>
Cc: dmaengine@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, vkoul@kernel.org, Frank.Li@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260618-ux500-power-domains-v7-1-v1-11-eb5e50b1a588@kernel.org>
References: <20260618-ux500-power-domains-v7-1-v1-0-eb5e50b1a588@kernel.org>
 <20260618-ux500-power-domains-v7-1-v1-11-eb5e50b1a588@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 07:20:33 +0000
Message-Id: <20260618072034.20A481F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-11615-lists,dmaengine=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linusw@kernel.org,m:dmaengine@vger.kernel.org,m:robh@kernel.org,m:devicetree@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:conor+dt@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,smtp.kernel.org:mid,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1ADEF69E0A9

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Removing the EPOD regulator nodes and consumer supply properti=
es breaks backwards compatibility with older kernels.
- [Low] Removed EPOD regulators and `epod-supply` property are still marked=
 as required in their respective YAML binding schemas, causing `make dtbs_c=
heck` to fail.
--

commit cc40a973d5076813fb2d1de31c4ef7f4d0231e78
Author: Linus Walleij <linusw@kernel.org>

ARM: dts: ux500: Remove DB8500 EPOD regulators

This commit deletes the obsolete DB8500 EPOD regulator nodes from the device
tree. It retains only the VAPE and VSMPS2 compatibility regulators.

> diff --git a/arch/arm/boot/dts/st/ste-dbx5x0.dtsi b/arch/arm/boot/dts/st/=
ste-dbx5x0.dtsi
> index fd6a075e4c93c..18727953a8630 100644
> --- a/arch/arm/boot/dts/st/ste-dbx5x0.dtsi
> +++ b/arch/arm/boot/dts/st/ste-dbx5x0.dtsi
> @@ -663,97 +663,17 @@ thermal: thermal@801573c0 {
>  				#thermal-sensor-cells =3D <0>;
>  			};
> =20
> -			/*
> -			 * TODO: Delete these bogus regulators and replace with power
> -			 * domains.
> -			 */
>  			db8500-prcmu-regulators {
>  				compatible =3D "stericsson,db8500-prcmu-regulator";

[Severity: Low]
Does this commit also need to update the YAML binding schemas?=20

It appears that Documentation/devicetree/bindings/mfd/stericsson,db8500-prc=
mu.yaml
still mandates the presence of deleted EPOD nodes (e.g., db8500_varm, db850=
0_sga)=20
in its required: block, which could cause dtbs_check to fail.

[ ... ]

> @@ -1215,8 +1127,6 @@ gpu@a0300000 {
>  			clocks =3D <&prcmu_clk PRCMU_ACLK>, <&prcmu_clk PRCMU_SGACLK>;
>  			clock-names =3D "bus", "core";
>  			power-domains =3D <&pm_domains DOMAIN_SGA>;
> -			/* TODO: delete and replace with power-domain handling */
> -			mali-supply =3D <&db8500_sga_reg>;
>  		};

[Severity: Critical]
Does removing the mali-supply property and its target regulator break=20
backwards compatibility with older kernels?=20

Device trees are considered a stable ABI, and older kernels lacking the upd=
ated
ste-ux500-pm-domain driver might rely entirely on the legacy=20
db8500-prcmu-regulator driver to power these components.=20

By aggressively removing these regulators, older kernels might fall back to=
 dummy
regulators and leave the physical hardware unpowered, leading to crashes wh=
en
drivers attempt to access unclocked and unpowered hardware registers.

> =20
>  		mcde@a0350000 {
> @@ -1224,8 +1134,6 @@ mcde@a0350000 {
>  			reg =3D <0xa0350000 0x1000>;
>  			interrupts =3D <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
>  			power-domains =3D <&pm_domains DOMAIN_B2R2_MCDE>;
> -			/* TODO: delete and replace with power-domain handling */
> -			epod-supply =3D <&db8500_b2r2_mcde_reg>;

[Severity: Critical]
Similar to the mali-supply removal above, does dropping the epod-supply=20
property break the display subsystem power management on older kernels that=
=20
rely on it?

[Severity: Low]
Additionally, is epod-supply still required by the display subsystem bindin=
g=20
schema? Documentation/devicetree/bindings/display/ste,mcde.yaml seems to st=
ill=20
mandate epod-supply in its required: block.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618-ux500-powe=
r-domains-v7-1-v1-0-eb5e50b1a588@kernel.org?part=3D11

