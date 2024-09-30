Return-Path: <dmaengine+bounces-3244-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDD698ACC5
	for <lists+dmaengine@lfdr.de>; Mon, 30 Sep 2024 21:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8BE31F224CD
	for <lists+dmaengine@lfdr.de>; Mon, 30 Sep 2024 19:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C828183CC5;
	Mon, 30 Sep 2024 19:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="MdOZX2ge"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7AB1991B2
	for <dmaengine@vger.kernel.org>; Mon, 30 Sep 2024 19:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727724334; cv=none; b=QRBQHVfz3lENaynWj/8e/MqOKvrhsxmvslTylty0z6HOvds+W3SH0MAXg/LMxELY1BwxBfGfaQdcZ7dwm52StlcfprSdbI5RlAHnZ4Px/nUwBYhc0bTn/UbU9xFRe731HcTasPyhAPdNAGUCYsxIkr0ft/QGYh2OV98Wk8lZO7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727724334; c=relaxed/simple;
	bh=L7QD/EaGALOGZTImASN+DK0MxucUUyeD1PLwumfkSDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rrllNDLk4CAmmoK7cY5wQPRijyQVigqlQk/00ET7fzpJUU0cDCBSJd0+tj8c51ueP5KFEeFP3jvht9IB2+46lXmMYQpTWcWtePTM4TK2cW4/lu2GQ/+fU3guXmjlOIF0adWcPLelNXqn91vIgfwWQHka2a2qaPV+1/UBHHtiLao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=MdOZX2ge; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=L7QD
	/EaGALOGZTImASN+DK0MxucUUyeD1PLwumfkSDU=; b=MdOZX2geaZ6qFUXFLENX
	0e63NJOj4fvdjZ1LuT3G8CMiklLt++0BKqw4P73Eau0FG60QekTnPrcIy21Z67R2
	cXZiBGeDmar+vE2oVHUJ/b5+Hpfemjtrhd3LGfNZOuvbcomdzM/HjBXYtudCOv8C
	F1ygkU2Ib8VCo0zAfqZyR7cQPAiQM+a1m+sc36BF2CVuxxLGBeOarzwzbvbQ8eUm
	oG37NB7UA9z9KVJfy60mRWM8fpmM433r2IW1dH8W356Vl99RITn2mm3AjKy+mgCf
	ADWXFenPfaNgKOFzCxk9RKbB6uXJlliKeepPlzisb8CjfsrR1PHzwucgH47t6pY6
	SA==
Received: (qmail 2282876 invoked from network); 30 Sep 2024 21:25:30 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 30 Sep 2024 21:25:30 +0200
X-UD-Smtp-Session: l3s3148p1@Gxf1KlsjiOwgAQnoAH/eAHsKVyf407fR
Date: Mon, 30 Sep 2024 21:25:29 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Subject: Re: [PATCH 1/3] dmaengine: sh: rz-dmac: handle configs where one
 address is zero
Message-ID: <Zvr7Keg9bPu6aUJM@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
References: <20240930145955.4248-1-wsa+renesas@sang-engineering.com>
 <20240930145955.4248-2-wsa+renesas@sang-engineering.com>
 <TY3PR01MB11346F2C786FD343B7B382CF386762@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0uRZHlrMWoEqPh3m"
Content-Disposition: inline
In-Reply-To: <TY3PR01MB11346F2C786FD343B7B382CF386762@TY3PR01MB11346.jpnprd01.prod.outlook.com>


--0uRZHlrMWoEqPh3m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Now both code paths are identical, not sure may be introducing a helper
> by passing channel, CHCFG_FILL_*_MASK and *_addr_width
> will save some code??

I had a look and I don't think so because we'd need to pass so many
parameters to the helper, that it doesn't really save anything, I'd say.

> Anyway, current code LGTM. So,
>=20
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

Thanks!


--0uRZHlrMWoEqPh3m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmb6+ykACgkQFA3kzBSg
KbY1UxAAtOtbEJczKRYU9KJloMilNEss33sUfX12niW8FB7f1PscSc+fyD3Gs/GE
IrBPVGU0zpwKC75FWTLGSNqWgmeQMFGTHVOKpQdVqWpe3K6iPZGqjdt/DY3DUCUT
CLbBPry6Q7v5q4ycK2Nj/miBVJulmLR+Ks0lN/WKeTqlmRFzQBFCGql5TpgQ1kWx
nj3u8WxlRgDoT0zcNu45nVCfUQauPy1PvVu2JfVdHrOQmigrVFdvjmH5c3nY0MDX
29fHPbHmfn+CwgFcuBJE+P2lK6XExTWY/tDbO7iwDTLiH85uFOTpp8Eija66Eruy
NRMcmG6DAjAYGMQ8z7+/P/xMjYfypflAFSXBwVFz79I/gRmqngRrxDGRw9k1NyA5
b5YMTmMgH1MHiEdkK64533jxxuRLnWGmkon1Q2Q2CXShaxCMYEb95jCpLQxHM24o
iptjofU6ftG7qCNfIg0E188FGJiHTdMnzbybG/X6cQa20feUi+FqS5lNIyZKEdU/
qRNWkxtzyV0mytCbLEahc5to9qIpMiM9F+0qOvbuD0O2fjdjiX+ZddqGOy+FiArs
YqjtIC2jVhTOZ4hl8qErV4uS/YPzOT9a5mtB8e2AW0/t4zZCqnyUZWDiBCg72c3m
Qxr8CLueBxoVQ41JakPoz7A01VZ5lXoFnSk99ppB+bOnjmv7Gp4=
=Xh6/
-----END PGP SIGNATURE-----

--0uRZHlrMWoEqPh3m--

