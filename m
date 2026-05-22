Return-Path: <dmaengine+bounces-10727-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGN2Ae0yEGqVUwYAu9opvQ
	(envelope-from <dmaengine+bounces-10727-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 12:41:49 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B92D5B258A
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 12:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35693301324B
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 10:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634A83CB2DC;
	Fri, 22 May 2026 10:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QsGyobdb"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D805E3CAA54
	for <dmaengine@vger.kernel.org>; Fri, 22 May 2026 10:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779445990; cv=none; b=K8RmUAH0y5n62t3NJtxpVNH/E5HEDGyQgXSj0rVolfVKGfqaTd2G9DFEDPPoq9SvjYyprOGVi9PqcJVvOVCsriU4EVuOgxFx2AZySnmeThhGlTk9BQFx+sZ+0Kn68ddAzIQiuz63VFi38NQ+LSh9MWCl+181mi58/lxfYDpw5w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779445990; c=relaxed/simple;
	bh=F5+bYp75dLwqsO8ATPAhZJ09tDeZlxwdzzmDbqqQhkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pFACr4ccoEm8gdA4/RTmaIq5D72fRa/rv7jsntqOxpxFIkJJepfjCt4YIpFznm2k64xCV4ExvZeeqJ/hLRy9MaCQAwWDG5DTBNhhJUYR7DMfyDEIVRk+ZrasVfowF+l7PU9Q1RrTLOApB4NBvfXEZCqYJOOkXdyEAlTuHF3UWbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QsGyobdb; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2f0d3e07e30so23888448eec.0
        for <dmaengine@vger.kernel.org>; Fri, 22 May 2026 03:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779445988; x=1780050788; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tbJ3W/Hs4fnZBWxpx6xx736nJ3SrWK5q7n6mrDaFR5Y=;
        b=QsGyobdbjXsAoOOfPiO8hdzvRmabwK9fAayAvKjuMXdLecjXjsnVQqZKuiU5r8khKx
         EXJgVVunBZistgHJ3Nxb3KAjajVzTBPSyZTszLIhICRvcroPHAaHf6ZJzEP8AiphVp1g
         5gkohB2FlkOlC4UWB5qIwU1Fp8J32Whdt1cG/n5VD8ZpD0KHJfWFxsp8UpOeSZePwO9s
         mQA9lHXqMPX3/vb1fE8AcYbXQFEJvZ7bx1Tp1/ZK6oaSoBgVY/G+/SXf03/16Bm970gj
         Q4KSTKJOEhBRxf4uBvh51BfmKCUlc6r6SwLK/hbdRaB+qyTN6gdr+fc9Qr4RPzTnqqJ7
         QkJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779445988; x=1780050788;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tbJ3W/Hs4fnZBWxpx6xx736nJ3SrWK5q7n6mrDaFR5Y=;
        b=ZznAdngARAPGrVZKcFTT6SrVGearD6op8rJbIYmN44VwtJQaXIxWapkJIeB/ziQsW7
         EQ1IDDYRghzJjdhwQ6GgBiV2m7Kv0Io+yP7anbOVVcpoKQBOIF/stmXp+mDVP88mY9SR
         D7Bo8fQDlD8yn3tCAyaeezLe2o54u5eCWuMbnEMTeMMMpXkUdKKowQuuBpoxUiSdcJdp
         M1nXwae7gO1Co5ZQYNF51tviRQ8DkRKn3owRRODhDksz34AlID0k3gwPmTIvLdGrrpOf
         La0QpfXh1YitsF9DXZL33kfE4zCEWZ1tdGSAZuHahJNHzIElsscEbatGELlaH9UwK+Qk
         PLcw==
X-Forwarded-Encrypted: i=1; AFNElJ+CuBi21hgfG93fNJYCLm4bptYVqxG6sFfax4yObO79bR1k4FI/arF0tn9m0+8yBTN1PXjwD9PrxX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YylOwSFF0SQB2XrVQRJoKKZXXta+aCxTqoHGgtgwPY3ej7vOZBC
	Fo1laQo9W1a/TX5/2VB00soaDeHl960kr3Q2xMc7xrV1M8XYcXtS3d8H
X-Gm-Gg: Acq92OG2rI4Ns0oYPNl415tQoYzkSGMD+s4EjBZLlambxpjroGWFsAmjEJvbEKjaaV3
	JQNnccS4iGW7Ru2fe9P+0fu4RYUJUO1Q/WW9HZvS+Tn6qBZw47H8taIk+AiLjmaW6IdO45qBxnY
	XzX9GlWJhUT1Pwj3UWwDbhqBkX3mrXhoUJlSBgGFHUs4UzYEyTZXvxYPFmrBTNjrWeDfGoHJ4SC
	tYfi8kEeKG1X5Epqhnc0SH0H9/sRlQGKAGOTHtOolQiKGTEsIMQXmBn/VWX4FIhzpyzkbsfN+Az
	czP6cIBB/Hw9Qy6VrgnMPWHvUBAI4nbZey3u9I0YSVRwmnq7JrHwrEJIWFqa9pXWWtp1pZERjay
	MLFF3IIK0GfY7r1o1no9PCVYb6GPhjVS7tQA0W/oVOJMZJcGYuHL46DvL0FDZSMCD5J13laBGpq
	nnm7+V3yJ/vkrsr7o8NmID54VS4wUzpb5rkpTzQWv8sfi8wOlOfQaVTwNgLoETr1XUpsqf6gbtG
	OIeoXUqQFpB2Q==
X-Received: by 2002:a05:693c:2285:b0:2f1:6252:f8ef with SMTP id 5a478bee46e88-30448fbf20cmr1670968eec.1.1779445987943;
        Fri, 22 May 2026 03:33:07 -0700 (PDT)
Received: from orome (p200300e41f291e00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f29:1e00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30452230f1bsm682548eec.14.2026.05.22.03.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 03:33:06 -0700 (PDT)
Date: Fri, 22 May 2026 12:33:00 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Akhil R <akhilrajeev@nvidia.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Laxman Dewangan <ldewangan@nvidia.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Frank Li <frank.li@nxp.com>
Subject: Re: [PATCH v6 07/10] dmaengine: tegra: Use managed DMA controller
 registration
Message-ID: <ahAw1VCTJoaEmroM@orome>
References: <20260331102303.33181-1-akhilrajeev@nvidia.com>
 <20260331102303.33181-8-akhilrajeev@nvidia.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cj653ttobpimpez4"
Content-Disposition: inline
In-Reply-To: <20260331102303.33181-8-akhilrajeev@nvidia.com>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10727-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thierryreding@gmail.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 7B92D5B258A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--cj653ttobpimpez4
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 07/10] dmaengine: tegra: Use managed DMA controller
 registration
MIME-Version: 1.0

On Tue, Mar 31, 2026 at 03:53:00PM +0530, Akhil R wrote:
> Switch to managed registration in probe. This simplifies the error
> paths in the probe and also removes the requirement of the driver
> remove function.
>=20
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> Suggested-by: Frank Li <frank.li@nxp.com>
> ---
>  drivers/dma/tegra186-gpc-dma.c | 19 ++++---------------
>  1 file changed, 4 insertions(+), 15 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--cj653ttobpimpez4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmoQMNwACgkQ3SOs138+
s6GQhBAAsvpZ/a4+gxBycPq7p8C/aXJliOUikyLpa248fU8368LVnJp+ZTQJjwHD
p55Iikt8GKfhaLT8AbR5sbfWvyWOfMyMw66iUWr5kGY+viIT0OMkzhGhWaL/jfT8
Ztm7MeUL9sP1/p1FZ+V2Uvp2KVsBfp/BeOqrvsT2lQa17bBtyNZ65oBoe+jTSSGK
frf+j0jf9Xv6GRlXq/o3OOnfAlrmkiouxT8zIJwul8Hbjmvz6dsskvGMdM0kP/EX
QzK6nZKTW+ZjIB2cRRqdUryNEXjhYc+Ulpb36X8eBp8xHqdPo8CkZA/lX+ZbKcGr
T+QSIDtFhNE+Mu3TxcBPyP7IZ9HxgzfAu69a+RZEa6/TC+SF1S9CsEW6VTYM+qO5
XSwrAGUtuRwTKasCZAUPGPANN+RD2e8v1A+OnD/Qua1xum0T3HLdbSvIXRZ4tYAR
w+bGxvFRjVO1jUaiOlo62wRIhJST7mPHz2z4/7/4bbYPdor+ElEKJQZ6MCR6HFFI
FVFETgwJFHGdGMHZyFp9Uj8rMS8paYBqDZAez5GPnqMsH37evT0W6js4/CpBuML/
wIAbfJdCPGWER+DRD5y6bGebt0Ad1GrMgRgvMYZoqVaDf7GV60CxANF70XnK8Bh6
J+wMpmxzXvXqiBr3idcQIn7E7dezARxPVGn+2yEypCaBM2T1US0=
=5ptg
-----END PGP SIGNATURE-----

--cj653ttobpimpez4--

