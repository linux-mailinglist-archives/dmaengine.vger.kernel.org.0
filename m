Return-Path: <dmaengine+bounces-11605-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ERs/CbV+M2ouCwYAu9opvQ
	(envelope-from <dmaengine+bounces-11605-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 07:14:29 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A4069DA6B
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 07:14:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=P5hhP7TZ;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11605-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11605-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F146F3015D6F
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 05:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3080837F005;
	Thu, 18 Jun 2026 05:14:22 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D8237EFF8;
	Thu, 18 Jun 2026 05:14:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781759662; cv=none; b=gKvsWfArgwE5lg9tKo0L92FKPIp3moXrwiddti7ql7SIBU63Y0d7EmAIcFLkxrzBXcKSRhlgrqbur/Zfoach3VatHBaEmN47EEtq5UYMOF6cPWR2ySUqKMusVowXgBFaEBIJhzxcwHQ1oiTVoO+2lOgcCp+89nVPwaLxxfggHqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781759662; c=relaxed/simple;
	bh=rI9V8GfJkq5ve8aSKXENgHG+YQCs0PcZEkZZhUKlosw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fyXVggFQ2j+txatF/0gG1j4v5H4IBQTMwD9MMz8LlxbxM3HM0oLSR7YDoS6mWeEty6p/j5vnvICdAXHU1rMotCIsXw4HNw5JO/UwYc2pOOHdvhzz8Ld+gq81DJYCPhyCJXwwHFBgcfcNb/1cJGM5yNkMZ+CnJPFvDZ8nUC2VrWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5hhP7TZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 861C31F000E9;
	Thu, 18 Jun 2026 05:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781759660;
	bh=3398tdurdkCJe2odCLbGCin5/Ale8kLa2C6uuKmFS3U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P5hhP7TZ4iFQJM9OWe3V6KC/ge1u58i3M6daxZmIUd2OVgcv1x3CxpcEIKbVl652y
	 7eHz50sOqQNeMgafWnOS04FcnjE2IZr0dvh/mTqHs4QVTU0leYQMxM1kJ7UrV0k3BW
	 FzXPlGWT0MAYz252V6Bc/4W+AT8f6msACNXUlCrRBDehS1uQoWfkgpBR4e2yJ8JRuC
	 36voUdn5xvIBycxbTWgPc58OPbohIqROy9Gc5Plw3vWAP7uW4n44QfmhX5ZNhAKoIU
	 VqpaxhxQHr2kLPfpwQaOcQn5qk54q5KCTmg/G1s17a1EeSIHnW4Duhx7QswAV+fDKn
	 Uy8HrdugI2dyg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/11] pmdomain: st: ux500: Control DB8500 EPODs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Linus Walleij" <linusw@kernel.org>
Cc: devicetree@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org, conor+dt@kernel.org, robh@kernel.org
In-Reply-To: <20260618-ux500-power-domains-v7-1-v1-6-eb5e50b1a588@kernel.org>
References: <20260618-ux500-power-domains-v7-1-v1-0-eb5e50b1a588@kernel.org>
 <20260618-ux500-power-domains-v7-1-v1-6-eb5e50b1a588@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 05:14:20 +0000
Message-Id: <20260618051420.861C31F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-11605-lists,dmaengine=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linusw@kernel.org,m:devicetree@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:conor+dt@kernel.org,m:robh@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,smtp.kernel.org:mid,sashiko.dev:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 18A4069DA6B

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Probe error path leaks dynamically allocated memory, fails to unre=
gister PM domains, and lacks rollback for partially added subdomains.
- [High] Hardware RAM retention capabilities are entirely lost, rendering r=
elated state handling logic dead code.
- [Medium] Bisection breakage: Disabling REGULATOR_DB8500_PRCMU causes cons=
umer devices expecting `v-ape-supply` to permanently fail to probe.
--

commit 26ccd884add2c876cdf4c876688df7b868a2fa06
Author: Linus Walleij <linusw@kernel.org>

pmdomain: st: ux500: Control DB8500 EPODs

Move the DB8500 EPOD state handling into the Ux500 power-domain driver.
Keep the old regulator driver mutually exclusive with the pmdomain driver.

> diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
> --- a/arch/arm/mach-ux500/Kconfig
> +++ b/arch/arm/mach-ux500/Kconfig
[ ... ]
> @@ -26,7 +26,7 @@ menuconfig ARCH_U8500
>  	select PL310_ERRATA_753970 if CACHE_L2X0
>  	select PM_GENERIC_DOMAINS if PM
>  	select REGULATOR
> -	select REGULATOR_DB8500_PRCMU
> +	select UX500_PM_DOMAIN
>  	select REGULATOR_FIXED_VOLTAGE
>  	select SOC_BUS
>  	select RESET_CONTROLLER

[Severity: Medium]
Does this break git bisect by disabling the regulator provider before consu=
mer
devices are updated?

Consumer devices depending on v-ape-supply may receive -EPROBE_DEFER
indefinitely if the regulator driver is disabled here. I see this is fixed =
in
a later commit ("regulator: db8500: Add power domain regulators"), but is it
possible to reorder the changes to avoid breaking bisection?

> diff --git a/drivers/pmdomain/st/ste-ux500-pm-domain.c b/drivers/pmdomain=
/st/ste-ux500-pm-domain.c
> --- a/drivers/pmdomain/st/ste-ux500-pm-domain.c
> +++ b/drivers/pmdomain/st/ste-ux500-pm-domain.c
[ ... ]
> +static int disable_epod(u16 epod_id, bool ramret)
> +{
> +	int ret;
> +
> +	if (ramret) {
> +		if (!epod_on[epod_id]) {
> +			ret =3D prcmu_set_epod(epod_id, EPOD_STATE_OFF);
> +			if (ret < 0)
> +				return ret;
> +		}
> +		epod_ramret[epod_id] =3D false;
> +	} else {
> +		if (epod_ramret[epod_id]) {
> +			ret =3D prcmu_set_epod(epod_id, EPOD_STATE_RAMRET);

[Severity: High]
Is the hardware RAM retention capability effectively lost here?

The struct dbx500_powerdomain_info defines is_ramret, but none of the
newly defined domains initialize it to true (e.g., for SVAMMDSP or SIAMMDSP=
).
Because ramret is always false, epod_ramret[] is never set, making
the EPOD_STATE_RAMRET state unreachable. Does this dead code need to
be activated by setting is_ramret on the appropriate domains?

[ ... ]
> +static int ux500_pm_domains_probe(struct platform_device *pdev)
>  {
>  	struct device_node *np =3D pdev->dev.of_node;
>  	struct genpd_onecell_data *genpd_data;
>  	int i;
> +	int ret;
> =20
>  	if (!np)
>  		return -ENODEV;
[ ... ]
>  	for (i =3D 0; i < ARRAY_SIZE(ux500_pm_domains); ++i)
> -		pm_genpd_init(ux500_pm_domains[i], NULL, false);
> +		pm_genpd_init(ux500_pm_domains[i], NULL, true);
> +
> +	ret =3D ux500_pm_domains_add_subdomains();
> +	if (ret)
> +		return ret;

[Severity: High]
Does this error path leak memory and leave the power domains registered?

If ux500_pm_domains_add_subdomains() fails, it returns an error directly.
This leaves genpd_data allocated and the domains initialized and linked into
the global gpd_list via pm_genpd_init().

If a driver unbind/rebind occurs, could INIT_LIST_HEAD be invoked on elemen=
ts
already in the list, potentially corrupting the doubly linked list and caus=
ing
a kernel panic?

Should pm_genpd_remove() be called for initialized domains, and the added
subdomains be rolled back with pm_genpd_remove_subdomain() before returning?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618-ux500-powe=
r-domains-v7-1-v1-0-eb5e50b1a588@kernel.org?part=3D6

