Return-Path: <dmaengine+bounces-11767-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oVL8EEywO2pibQgAu9opvQ
	(envelope-from <dmaengine+bounces-11767-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 24 Jun 2026 12:24:12 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C976BD4C9
	for <lists+dmaengine@lfdr.de>; Wed, 24 Jun 2026 12:24:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=UL1YHhWC;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11767-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11767-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6F6F300D304
	for <lists+dmaengine@lfdr.de>; Wed, 24 Jun 2026 10:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31EA521A447;
	Wed, 24 Jun 2026 10:22:43 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005AF1ABEDE;
	Wed, 24 Jun 2026 10:22:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782296563; cv=none; b=IPsOmD/InUVCUN4UhoG34HXKsCH5dfoshKrXHwYY3hCR2yZKPX7kSHtlOGQmFDVN7HiU3zQX8JSfh8BffOU0QFafKRaYMN+Q3ltEi2RzTLwPU+BW8D9EblJLJCsP5yIniGZlP4XtOh3NWpiB+s4YIO4VUqm4d0IIVQ1MTQhpODk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782296563; c=relaxed/simple;
	bh=iU0QoUZzQz279p1bMy+jOUPvCQ/TUXfeCsU7R0F5wiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OZ8425dk5X0qnTk7lXaX7IAaCJHww2/Gl7TEg0sfpCSKqdL71NnKYmH2kL6N0oNmIXi/sv4pQ2A2WlIe9BFyAINWGV1YqGsNlZbXkXd2ImOXx9EZB0QcBk4oDc7uFh3ChfXJznzTf4fve7lZP8aJ/j93sCoeB44OuI8ARQ1ZOvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UL1YHhWC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA761F000E9;
	Wed, 24 Jun 2026 10:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782296561;
	bh=eMTi+MXkAIkIL88OYj8srAwPQOlTesBvtuRSKqBPNKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UL1YHhWCNrz7duXr5Q9Z7aB4XLHcVGSmyUaEHXmCwQeiRBRiPizTDhiWPP12bJEnm
	 I7agqRy18Pxxvdsu8uYfT7KqioyCCuCu5Zih4f0hUyG8NFJKyfn4i1/3w30QGgoEYo
	 GpEfbT0VIp5FXAic7nGKBzcs7JRU0gLKEc+az6757IZ3Zt6OLV3fBwJraL4UthQTsm
	 IvZzed3mySU/qISlaaAGrwucMmaGbQJrhC5jjfL3SqGS3NCxc5gh0PizRw0iLnH3xf
	 0FfDiVH2XjBMhUiHoYO7vb117XG9VaBsMbuSh0fO2HZh4jocjl75WkHhtv9PIE24EF
	 l/4a9kfu3lsGA==
Date: Wed, 24 Jun 2026 12:22:38 +0200
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
Message-ID: <ajuv2CVQ-b978cn6@orome>
References: <20260331102303.33181-1-akhilrajeev@nvidia.com>
 <20260331102303.33181-3-akhilrajeev@nvidia.com>
 <CAL_Jsq+bbYZnE=Asv=2VnvTpSsLfKtdpcLvfPzn85hyiyp85cA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dwm7nbrcy4sr3nlp"
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+bbYZnE=Asv=2VnvTpSsLfKtdpcLvfPzn85hyiyp85cA@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.76 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
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
	TAGGED_FROM(0.00)[bounces-11767-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D6C976BD4C9


--dwm7nbrcy4sr3nlp
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 02/10] arm64: tegra: Remove fallback compatible for
 GPCDMA
MIME-Version: 1.0

On Tue, Jun 23, 2026 at 09:02:39AM -0500, Rob Herring wrote:
> On Tue, Mar 31, 2026 at 5:24=E2=80=AFAM Akhil R <akhilrajeev@nvidia.com> =
wrote:
> >
> > Remove the fallback compatible string "nvidia,tegra186-gpcdma" for GPCD=
MA
> > in Tegra264. Tegra186 compatible cannot work on Tegra264 because of the
> > register offset changes and absence of the reset property.
> >
> > Fixes: 65ef237e4810 ("arm64: tegra: Add Tegra264 support")
> > Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> > ---
> >  arch/arm64/boot/dts/nvidia/tegra264.dtsi | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> Thierry, Are you going to apply this? The binding change has been
> picked up and now there's a warning.

Yes, I have this in my tree of fixes for 7.1 and plan to send it out
towards the end of this week.

Thierry

--dwm7nbrcy4sr3nlp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmo7r+4ACgkQ3SOs138+
s6FlDhAAtBK4xCaIt7mWHLLOIXDnZQJCxusEuT4sd3PTQ8JqMUDNAhrsPlVsvHNc
7ITdlNzW7dSAmavXqY0zZxpGEFvOhbzv12SxGPAeswhxbgP05VoH223fP8YYUoab
0U3CUPn/NoglW5pW+TPiDK1Wh9sXHwORac7huFS2E7445otOd/s3dKEnl7LoHtUN
IGx1EwPpVUfvh+TXn4/FBn1bOgOMZDYzCIbd1tMXKFGuGVwlQLe/zZS2xc4SNtgz
lTcpu1z800GlPKRf9ir6HpKRLtnThlLFSSXRpUWykfuGqdqUU51GnC1N0YiTSRbx
5cnz2GkXSvY82QCY6yuHB+mdi3JAyMfR4UjSshmSLbPWU6SPVzGVDx+eIMkXxELg
vrvDYcSU5/Fqb7sdjaxzM0lojPUgoTQI66lrk3dJ4mxPVY+89NVDGM0NVFMavo4r
d1dmzQHu/3HwP7V+OydeN0xhZ+DQkF/9fpAB6+n0DJgwehwJuvvEpxk8SMMG9ue9
9TigtA78G/wpRkxySZ1dDnMS8X0X4/dK4XPpZs3V0QYOTIsi+87uQgifN+LORu7g
oYO83qroG8q1WBDn2uY53b8oVBs6//KqhHjwPOuoSNi7nirAp/F0eDfsvLOhXtlg
7SXDQAKygt6eG/LpzS2/QrB0f+Vz/fowJ8UlnDbUd+ykoueTlqE=
=m45t
-----END PGP SIGNATURE-----

--dwm7nbrcy4sr3nlp--

