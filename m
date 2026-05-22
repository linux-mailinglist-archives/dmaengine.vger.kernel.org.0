Return-Path: <dmaengine+bounces-10722-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mN4NHActEGqSUgYAu9opvQ
	(envelope-from <dmaengine+bounces-10722-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 12:16:39 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5595B1DAD
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 12:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 98AD53011C42
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 10:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE763C5528;
	Fri, 22 May 2026 10:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+I5Ehaq"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80875272E56
	for <dmaengine@vger.kernel.org>; Fri, 22 May 2026 10:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779444557; cv=none; b=DBvxOEpr0r/huj84exmBRaSbQxutLdw6TWok1cQI5lbeU61N440lt5zMPOS38StbtYUb1iiUqUBZCSrMDWS82a3Y7MTjA9I8Z1+e3olrALAuaMt0TpY2xm1nPm2prj/lFtC1mqFILgQiABpMOS0a3P9mGre8yeFXu8OF3mHYiaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779444557; c=relaxed/simple;
	bh=tXc0GLTLQkLv5ed8xLAOzgZ/WOFmTaW0lEw88YWLwMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XcAb4/5Sx2XFI1hhbOrBjJXfwvL0bqNXGM6t6cdkAZKJ2IyIyxZEGZNS0+NRzg4clGALNU9eUXIrFt4oREhOe6SjoQ+1ctIMIEwKs8ARKTvp6NH2RZTncWnNLQFh4W3Q/Waftm2yLVbunawXClwPePHhBGjJ+A3lGlqy1S5fG2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j+I5Ehaq; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4903cbfad68so10413335e9.0
        for <dmaengine@vger.kernel.org>; Fri, 22 May 2026 03:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779444554; x=1780049354; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4zz81ZxdfpEspL0BWo4PKiQavHk71+JXORK+v8WVheM=;
        b=j+I5EhaqgmEyqiI/EWYUdEL4+5FRAESVrhF3MHjlg1PkuuQwj08RNRYqcOcj6kteQX
         n0Cd3nkamEak0C0cUuAqpxvlS6HEfl5aStC0Uoup/5pR2bMdTMlQm7PDDy4SF7I9UhBg
         LTAymzVm9JOXSD1PuPa5glyAZR9xAFiLEg0/S4Uy/aXQjHnslt1PC6ZD90V/E3aMlb9h
         8CLmwSeH+htPuG9i0aentvC2V3nWkotVEiXXMj0P361pkZA4iKsyQ8DSAEyrThtk2AR1
         pCvLdsePPNaBDpfdX1GufcJlD9D03cdA5dwpaYF1iF2UmBJ3Z0w5/Osu9TIS1ES8Id4a
         lGGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779444554; x=1780049354;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4zz81ZxdfpEspL0BWo4PKiQavHk71+JXORK+v8WVheM=;
        b=Y71tfl+bNjWxKxBXmIBIku2iJnm/baX+QuSJrFbcuc4DlKzYt7HA8dj+N6dkZvKf9V
         EwesnylfGlWZqaQKPioosfB7bBgAu9u680NqhABqsMEPqGreFfSp+qbFrlaX89gr+cj1
         1EZFCyfBufplLbB9lZ1zDN4GGkcnu/wB4uEguV71wyG2pD9nqtw2d/zcpPYYOrpxP16Q
         pDvLO40nYSUT6TtQpAGrRVZs11X7ssTE/HJG30pJ0CzCbUZF2N4U0v34d61PIVeLmhZn
         jO0M/bMC/A8+lnQ2DPVuZfvLRusod3rEhLFhfzI4ffidZ2Q0cxJaamSYwadYORERP5VI
         QOdw==
X-Forwarded-Encrypted: i=1; AFNElJ+jiGA5MOqs0WWsluELcdLXYoDaXui04PWEvW6xkDFTyEHoIHnTd2xWNJQmTYZxy/kqIdyyUlGgp6s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/m9g55wI49kxnw0G7pNaBCg/Cj/5T82BD3mo242wxB01/FAd5
	oV+Ye6tFJP/Fx3pzQwDUL3plHTJZoxzpES7kNREz5dP+yAj9hjpsqGrI
X-Gm-Gg: Acq92OHuphSmmJ7Cw7R6PxWu6n9r/z2mbmNnRvJ5GBdE3rV09KY4YOCFTkVHW0Uu3Y+
	+KTt1QqwESvjFORTC2uMwg1kK+QAyokGkNNxYrf1/gq7zIIJ4aPVn9TOBD1JuKtRmNIspv/+z3a
	6Je3QOL7sv582nPK4EWD7hU7OnYBXdOooQOlt/oguMR+E6kNmD+cn9z0ZLYnX70niIJlkd/Id0o
	3Y2fUKPYnMlsVsVK79Om+cQgXCDEeV8XPi995eHMy6zquo+a0dMa5oipuMldn8ILNXCiFivPww2
	+wqQOJYGcDzu4bdVZuNVO/E1CA0Xq4Rp/DmxRqEd/+S6ceFERs02rGal1e1YRagB61sY/FbHC8Q
	jhA4GNw5CVhJPqGuSbkTB+Gl+NkazLKw6Mgav6cPR94or2nzZ3rULsqhpZsPTDZIx8WvuhFggvP
	v1U2ukMqjVuBbRutlHpa2V6+m2p7T/47YEZB4Or7OwizIjd+VrsZjUX/OR0J/nrBbjDov39YRow
	mxYrXodKynLgA==
X-Received: by 2002:a05:600c:1992:b0:48a:79d8:a8d6 with SMTP id 5b1f17b1804b1-4904245f54cmr27207905e9.7.1779444553576;
        Fri, 22 May 2026 03:09:13 -0700 (PDT)
Received: from orome (p200300e41f291e00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f29:1e00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490428e03d4sm16430345e9.9.2026.05.22.03.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 03:09:11 -0700 (PDT)
Date: Fri, 22 May 2026 12:09:09 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Akhil R <akhilrajeev@nvidia.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Laxman Dewangan <ldewangan@nvidia.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 01/10] dt-bindings: dma: nvidia,tegra186-gpc-dma: Make
 reset optional
Message-ID: <ahArPRE7rddUDQxm@orome>
References: <20260331102303.33181-1-akhilrajeev@nvidia.com>
 <20260331102303.33181-2-akhilrajeev@nvidia.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cba7btxxm4dnjqoy"
Content-Disposition: inline
In-Reply-To: <20260331102303.33181-2-akhilrajeev@nvidia.com>
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10722-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thierryreding@gmail.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:email]
X-Rspamd-Queue-Id: 0A5595B1DAD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--cba7btxxm4dnjqoy
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 01/10] dt-bindings: dma: nvidia,tegra186-gpc-dma: Make
 reset optional
MIME-Version: 1.0

On Tue, Mar 31, 2026 at 03:52:54PM +0530, Akhil R wrote:
> On Tegra264, GPCDMA reset control is not exposed to Linux and is handled
> by the boot firmware.
>=20
> Although reset was not exposed in Tegra234 as well, the firmware supported
> a dummy reset which just returns success on reset without doing an actual
> reset. This is also not supported in Tegra264 BPMP. Therefore mark 'reset'
> and 'reset-names' properties as required only for devices prior to
> Tegra264.
>=20
> This also necessitates that the Tegra264 compatible be standalone and
> cannot have the fallback compatible of Tegra186. Since there is no
> functional impact, we keep reset as required for Tegra234 to avoid
> breaking the ABI.
>=20
> Fixes: bb8c97571db5 ("dt-bindings: dma: Add Tegra264 compatible string")
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../bindings/dma/nvidia,tegra186-gpc-dma.yaml | 23 +++++++++++++------
>  1 file changed, 16 insertions(+), 7 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--cba7btxxm4dnjqoy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmoQK0UACgkQ3SOs138+
s6EvWw//RWCFZQ9T5C4dp8mVROoGcJewvvJHj46nkOp0utsLoYqLxlyBAndZ4kjp
EXuaATKAZbfG2HAMtwunnvWgwGfFYzQzNqfO4bqXAKGltGU8X5NPai06UZ4ljxYR
WTsV0ZexSKoOXL4jaKU/ZRabzsXm63ldoMpfJv4ahxyoWH6Y2kOqILa7FLlb7GHS
FvCyV9lb6CWA+QA5opFdz3qqC+WxhYaKET1F4q5xbFD5PagVYShaEaYt8MRv0iil
AMyn/NwaX6lOjGTL1CpvJ/jnmlf2Gu7temInUkZANF8wJzYY0xVU4J00bzryvsXO
eSzZwAemjwGTyLF1hsMbmSyqjLLHe7eDq/Y4DEKX3xFGVSd8zKy/vN+zUhFp+9HQ
oxRLORiWrIC8nCgMC7weCZ3ufNIf9Oh+IMxcx9bYghGkOFcwPw/mQB29LmZ7zuyi
IqY9bdEILNNqnTXrULGByqQ2ywvZkZItadnWV1WgXeHRHdLNLzgy7ZfaQsdnBG+w
6WrRkzN8o26x3rtL8umBdxgUrjPomamGU0F97/zy8+aHzrT8/AvL03008euSMliV
sF5OyIHPVRCgyKhe1nuOWXX56BT9+R66zECG68/tWN9OBU25SNy5Q8pYH7x577Xf
IxAPlE5nxcOYxP4CAZfTCnEoq7uYRM/zhhLM/ocmPMkvwZchP7g=
=T5zQ
-----END PGP SIGNATURE-----

--cba7btxxm4dnjqoy--

