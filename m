Return-Path: <dmaengine+bounces-11768-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lMiQHELPO2ocdggAu9opvQ
	(envelope-from <dmaengine+bounces-11768-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 24 Jun 2026 14:36:18 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6069D6BE301
	for <lists+dmaengine@lfdr.de>; Wed, 24 Jun 2026 14:36:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=lnokHhaT;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11768-lists+dmaengine=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="dmaengine+bounces-11768-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 943E33028BCE
	for <lists+dmaengine@lfdr.de>; Wed, 24 Jun 2026 12:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75BFB2750E6;
	Wed, 24 Jun 2026 12:35:38 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518BB214A9B;
	Wed, 24 Jun 2026 12:35:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782304538; cv=none; b=BxnIvmbSpkzWdMnnfrlej+sfm8WFIzzITNZvto74UsgdP20naebOk4SFw8FaalpcuzTbBt/td3bn51Jw27H96CVp9QjHd9sKEPhgU/r7fAamt20TbOSI6jyKjHZEzxjo9KqyQ5PMUL+TatFh7jb10ini/yop1bCJXYbFq8T3VP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782304538; c=relaxed/simple;
	bh=sMD+VoJ/M1Dun+eKUJ2ZUbi2H5WgbUfqJrUZ/uDiABM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EfiAz7sd61UTm7hWR8N4z8FyulXpxILH1QSDVvSNPrN3AwAmZSE+LZQ8L/frYBHKs23xsjooQz1T4rTkYfvxkptMBO3FjvWUB2ZixXozLCT/v8acjf5VD/yVyozHpCITOf9yBwO3TZvUwIHvmkgqDD094ZDTqAv3f/NkQ4Q0z2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lnokHhaT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 627131F00A3A;
	Wed, 24 Jun 2026 12:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782304537;
	bh=KYe8KXKhsDb1PCTR/KPk+k4imUnbbHApzaUF747CiF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lnokHhaTl+EJFvXmfjsA9uSyTwWPE3TsO2AWPz1ERsGVbIYHDHb4KK3NdQayLmJLR
	 Of1F/2Pl8mgpvy8+QpvAFpt161PmZHIvmF5ASIuE88CkdZPSH8RKp5EOIz8fiU9jE2
	 UMkwlDXvKFVbAUZ5OPzBzFUKea/krH9+DB+HTaL5jBD3cUDA+340RNqerKiOVF3hZV
	 1XGL9IqyHP6RKQYHXARjIEjHGx12ljKQ0YUkGAxFEZgXBW58rEitVir0Dayj9d2hId
	 g7Bm/R7q5qlCvkSaSdpBV9FMRdtQ4dpMDjk3APMYF28SXjH3gmpC+H5RkpXxgHrXEy
	 N0rO/3gZgZRtw==
Date: Wed, 24 Jun 2026 14:35:34 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Akhil R <akhilrajeev@nvidia.com>, 
	Thierry Reding <thierry.reding@gmail.com>, Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 02/10] arm64: tegra: Remove fallback compatible for
 GPCDMA
Message-ID: <ajvPBgztRULr_BaP@orome>
References: <20260331102303.33181-1-akhilrajeev@nvidia.com>
 <20260331102303.33181-3-akhilrajeev@nvidia.com>
 <CAL_Jsq+bbYZnE=Asv=2VnvTpSsLfKtdpcLvfPzn85hyiyp85cA@mail.gmail.com>
 <ajuv2CVQ-b978cn6@orome>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2q53vcxt4flxsr3o"
Content-Disposition: inline
In-Reply-To: <ajuv2CVQ-b978cn6@orome>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.76 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[thierry.reding@kernel.org,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS(0.00)[m:robh@kernel.org,m:akhilrajeev@nvidia.com,m:thierry.reding@gmail.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:jonathanh@nvidia.com,m:ldewangan@nvidia.com,m:p.zabel@pengutronix.de,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-tegra@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:thierryreding@gmail.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11768-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thierry.reding@kernel.org,dmaengine@vger.kernel.org];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,kernel.org,pengutronix.de,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,orome:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6069D6BE301


--2q53vcxt4flxsr3o
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 02/10] arm64: tegra: Remove fallback compatible for
 GPCDMA
MIME-Version: 1.0

On Wed, Jun 24, 2026 at 12:22:38PM +0200, Thierry Reding wrote:
> On Tue, Jun 23, 2026 at 09:02:39AM -0500, Rob Herring wrote:
> > On Tue, Mar 31, 2026 at 5:24=E2=80=AFAM Akhil R <akhilrajeev@nvidia.com=
> wrote:
> > >
> > > Remove the fallback compatible string "nvidia,tegra186-gpcdma" for GP=
CDMA
> > > in Tegra264. Tegra186 compatible cannot work on Tegra264 because of t=
he
> > > register offset changes and absence of the reset property.
> > >
> > > Fixes: 65ef237e4810 ("arm64: tegra: Add Tegra264 support")
> > > Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> > > ---
> > >  arch/arm64/boot/dts/nvidia/tegra264.dtsi | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > Thierry, Are you going to apply this? The binding change has been
> > picked up and now there's a warning.
>=20
> Yes, I have this in my tree of fixes for 7.1 and plan to send it out
> towards the end of this week.

Sorry, fixes for 7.2-rc1, that is.

Thierry

--2q53vcxt4flxsr3o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmo7zxYACgkQ3SOs138+
s6GTSg/8CNPG2eW/kJ2CLMzaTtQ1b4jDvBL/xiLISQVsAQdrv5Vq2kTXNU+ta/oy
lEURZsk2GTsS2mBI/yHp8hNhi3KKZnM74B3DJiZXyaRtq4EAXYuindR8nTuO7tnJ
hVnorN148KaG8Ahm2Niz2UgVq+dXC/OAPtJE7x6eZiCyQdidxunx8vYlfQuLd2N6
HuoSUr9Ls+HSDezt1OfvH95Tllkr8zB7IE+Y0MJpwBUR/Vgb2q97wKJoRr1APpn8
2nISBlzf8wMnyXczdNUfv7xB+q8GW8fKyYvRobaRsnaRsVka1aY0u65dRm1n7i5g
96zzsvh6RpXj6z43p3UwVWK8j6SL4UdCppKrR6TAlFPoRH/89NvYtfWEC8kdKbtZ
CKvjsxjLU7hi6up5Tp5u576IE4RZvC5Nuk4K5JZVGMVzjS3Z2lZnSdW9zr18SHga
Z4c+7G0vWtL21zT0Rur+i+Cs5QzXONoQAqokNkWhmznRMd0srkFV4ALTwIPEZ7WS
F+Zx4CK4d4OG3xQ0B4ijGMV8CI5Pl3W7/Jz6tdeCM8cDauqyDYHhUzL/u7Cp2c83
rU93WW0ywIHRptnaA5pf1iQdZVuzoSJK5fuzN7Xtgqg6OnI05VpKTEI9wiJ1ePiq
76zVaSINvhRikkmYDggdQDhgd8Vv7k4HFny9hVRDys2mbfqdHXY=
=GQlD
-----END PGP SIGNATURE-----

--2q53vcxt4flxsr3o--

