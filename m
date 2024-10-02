Return-Path: <dmaengine+bounces-3259-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF2498CD3E
	for <lists+dmaengine@lfdr.de>; Wed,  2 Oct 2024 08:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10A231C21C0E
	for <lists+dmaengine@lfdr.de>; Wed,  2 Oct 2024 06:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F3D12DD90;
	Wed,  2 Oct 2024 06:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="Etdwc9+K"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB26412C491
	for <dmaengine@vger.kernel.org>; Wed,  2 Oct 2024 06:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727851077; cv=none; b=VeChpL4SScuvjuvXj9Z79Yn0fZMh9SY1It28+IcybPzCdssaW76Mav32upOHRFd+DjQdRgEEXgu2p2Ae4rEzHvvPpmaOR29wq9k7vn/Bj/1nkJTaqfQIFyIwc7icbdwpjXyiGsOvt21UiOzOLqNMYWQeRcyRZmV8yIF5I1pWUlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727851077; c=relaxed/simple;
	bh=1dHkcvQgJSnNHV9nsMxjAHl3O3rq2uNwZn8/8dbv2jQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qbqSTmdaECGWj7KB5gYVAf+LCXBnzIhOFuJZHbIEjBmP4weFKa9bWj+XdTT/PdSalhICRWv+JHKoC+PsGXSwQ+HPOv/ogBQWQ9/O/ZIlhUr/1jSxRwt3c0fn7mF7zIuAuR+3jHfT8Wh9GvsIOiiNBcNmmX/O5sTLB4ArnJKqdR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=Etdwc9+K; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=1dHk
	cvQgJSnNHV9nsMxjAHl3O3rq2uNwZn8/8dbv2jQ=; b=Etdwc9+K1wBhOVV4lWdU
	jWiyEKBMcypav6y5jDmAoS7Xny3s2goJ96rHbc5frp5T0O7TmLoYgKPFXQ9vCzJR
	B1zHY2kFf7ukc5N986+Qp48zw8issnC/0lU83SQVDZSudei+QkocsCCTnLzM4In3
	cTU/C/r7QP2c0XBFo1jjTBC/ph1yfSlrLhW4P2ekiVg4J7ni+aL3E++QoqR6Yed0
	WNeGc6W+Lh0Tx9oqX6/sRfFoaWZ5wHYQQbLNJE+kM1zYy9D6q0fNtq0zc77Lm8B0
	PCmErdX0d3PEhkkE8cPuXrLvNlb/aHSz84NGBVvOZkuFf4FzQVFF0MwZGmaS+nqt
	HA==
Received: (qmail 2756738 invoked from network); 2 Oct 2024 08:37:50 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 2 Oct 2024 08:37:50 +0200
X-UD-Smtp-Session: l3s3148p1@IgtIrXgjnqMujnuV
Date: Wed, 2 Oct 2024 08:37:50 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-renesas-soc@vger.kernel.org,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: dma: rz-dmac: Document RZ/A1H SoC
Message-ID: <ZvzqPkUPmurHf-fu@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-renesas-soc@vger.kernel.org,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org
References: <20241001124310.2336-1-wsa+renesas@sang-engineering.com>
 <20241001124310.2336-3-wsa+renesas@sang-engineering.com>
 <qifp4hpndfhe6jlmzjmngr7uolfzvj663donhjg5x7kmeb4ey3@a2a66w5l35zf>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2jTu04x4xCLlMS1r"
Content-Disposition: inline
In-Reply-To: <qifp4hpndfhe6jlmzjmngr7uolfzvj663donhjg5x7kmeb4ey3@a2a66w5l35zf>


--2jTu04x4xCLlMS1r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Does not require or does not have? What does it mean that device does
> not require clocks? It has its own, internal clock oscillator? But then

You are right, it requires "clocks" but not "clock-names". Seems I got
carried away when removing the reset properties :(

Thanks!


--2jTu04x4xCLlMS1r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmb86joACgkQFA3kzBSg
KbbTiQ/8DgBhjfNeeFMxQZdP9fHlmw4M79ssyaYHUWp5lyKtM+D01r1ZEFA1lpw3
ltqSLbtHJHLndn4gX//BMVWwGh8ZLW5ZVd51Q3c2VXyjHH6IS2+DviFEb60q42HC
O20zOlYzR1eM+6to+7+ERTH5XSPs/MCuF2XW39vZZj4XWqEPakveJ2HL3c2XmlAv
fM+XMw4SZ394Pg0EtQLm6Tz800C932Y3vHuoHJeS1tO4ysBTqilW+YF/r8N0Q3rO
6EFiNWHKyr7dgD+yE37E39EgMc3PUjPmvbYtHmVXbT05fhryUU5mv402nCyvT3P+
lZ9ZjJFo9SE2tQwZnsl5VaD27oaDvqr7ITDTF4vcwIPj6xLKYFDMD2hrXeOY0cnG
GvyDhubePd0uCJfhUQDMNTWFr3gR2GmxksCH5ngE281tm0RAh1iQVmTr4J7vNgWm
BPIsnO9Js0XhXcjYsGxkcLDSYETzjK4xZaavKan9i6Rb/eb/51psTDgoAVLGjm1Y
e6RoveO0ZTcYi4zUglvsV3SIQg6LdsYa9f/McbN+1r5EdGlzBcJnktSjxDeHOuIv
A+Q85R2MP1V/hV1a0EinCmkYsJIYETmN3YUsLZN98mNos7RRFTbRRCb/Yo8oSPtV
1Z/XwENwMtxoFSNJy+MWQinfEOPj3Nw+S7dj4VY9TYrN1XH8zM8=
=k5N8
-----END PGP SIGNATURE-----

--2jTu04x4xCLlMS1r--

