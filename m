Return-Path: <dmaengine+bounces-3245-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2B198ACCD
	for <lists+dmaengine@lfdr.de>; Mon, 30 Sep 2024 21:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 918131F22022
	for <lists+dmaengine@lfdr.de>; Mon, 30 Sep 2024 19:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F1F1991B2;
	Mon, 30 Sep 2024 19:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="bDY6ffSH"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E779199396
	for <dmaengine@vger.kernel.org>; Mon, 30 Sep 2024 19:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727724391; cv=none; b=gGHzURmnPQLHMHXDKQGBAybBNE1cXZOS7xFtiofsRuF8SOEb7TqqvNVOzmcwzRLjZ/GAtA1NqgFoaezGTUoBwt5zz2+b59cc5jp6ikkRHk//xn8slSR6NZNmiyXuARDS1DM/typqYipH74WVt++xP5FSTKbTqt9kF9IaG2koVig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727724391; c=relaxed/simple;
	bh=e+aBS0EcIqQCeva20AFIcVDMGO3E3D/ovwze6Otvzzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HB7N6arvQFaIvkh/d2TZXQ69H6pwZndYqJ4IUN9yTqs2D+txaVFp0p88HhjJJlJUfJXnZv16ai6x7BEas+OMfyet/EeEcBI8GSnE64iH19zgyIQGQ5OrQMm7GL4kNCL7QW8An5fjWsiO/6pHfWl9PPX4+v5S4QXrF2npNCV7ogI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=bDY6ffSH; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=e+aB
	S0EcIqQCeva20AFIcVDMGO3E3D/ovwze6Otvzzk=; b=bDY6ffSHazKiPWB6Sh+P
	oJSEeli87P3KKBXYMHL2P5qNjIXoaWznKnPQWe+YLznl+7YUnyZSFD3gDWWNq3zW
	37YyJ3Xi5TPOZHQ0IIfNZvU6doO/kimDhJzJAa/NgkNRvpLD/eV2/u2nu9LAKBtd
	rwEQQyQFn49Q+VWzafXAPVQk1jvWGGsgQshAF/6kqqNAhTIRv5m5eu3F3zU3XkJZ
	O71kJZmJHgpFSzv4Sgj0CHk1l8n8ko36bqo0VrYQUWpR2EVaZCfmaZqPjzOIHSjp
	keoPsTot1NAOBL41AELqzDnk6MQg2OTM9jFtZq6NIGXCfHJm1KLoVCH0f9no6ngM
	GA==
Received: (qmail 2283075 invoked from network); 30 Sep 2024 21:26:27 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 30 Sep 2024 21:26:27 +0200
X-UD-Smtp-Session: l3s3148p1@naFdLlsjiNUgAQnoAH/eAHsKVyf407fR
Date: Mon, 30 Sep 2024 21:26:27 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-renesas-soc@vger.kernel.org,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: dma: rz-dmac: Document RZ/A1L SoC
Message-ID: <Zvr7Y6PxV9CqcbHF@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-renesas-soc@vger.kernel.org,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org
References: <20240930145955.4248-1-wsa+renesas@sang-engineering.com>
 <20240930145955.4248-3-wsa+renesas@sang-engineering.com>
 <CAMuHMdWa7QXU+Ka6FipF6sbcn=UOnVtYa-+an4F7thprNt6ALQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="O5tKaXQq4nFrPMWf"
Content-Disposition: inline
In-Reply-To: <CAMuHMdWa7QXU+Ka6FipF6sbcn=UOnVtYa-+an4F7thprNt6ALQ@mail.gmail.com>


--O5tKaXQq4nFrPMWf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Document the Renesas RZ/A1L DMAC block. This one does not require clocks
>=20
> RZ/A1H

Argh, I managed to mix it up again. Thanks!

> > -title: Renesas RZ/{G2L,G2UL,V2L} DMA Controller
> > +title: Renesas RZ/{A1L,G2L,G2UL,V2L} DMA Controller

I'd vote for your suggestion. Biju?


--O5tKaXQq4nFrPMWf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmb6+2IACgkQFA3kzBSg
KbYxmRAAkqlKzlctfTkc55OxsPvtDx6CM71Cgmzr0KtTO/Rfk4Wq2GRNKPWMvnrj
oeQ/hUYtHSSmpyXHPyCxLuUG4zBNk208jETRzHrIu55a43HScI88ZCD28npCuGNq
IE9FXODjy3RhJVuoxKOi2XSi6bzIDpgg4ypkg529yBAlifkeJegG13MChK5aBfuN
EuaVbJMPk59phDJc2+3gjgBjMTiAdFj0KFzMjYCQsK/tbdBPvwL2Y9L+4IqSM5Fl
OwWW0Rytq87Gk6jxBrikNHdAbZgKE86mXS/I/cINX8AC/gqJvo/o1ugzqmU1lgal
lpaQOQ6UfE5vakvjW+qJZCtzcBRxKRw3DMu6WGSshq67Lbe8rPY+eleSUUNvsDVM
QiCSyMiriPz2Pa7YMIPzfsRMIDYqjKuhUPpCb/zGGhlrXogcEdwpW3yp7wZSFUHd
mJUwS4oVnQEsQHR9g7X3nRe9f8aByHFlRe8ZT85Mgw9+mIJXptuACyKj4eHL3N+p
UF2kovphE9j9J0NyZKCo1eLocre1DfDfJH+5Dg/Mgz1nIYNP7X1jjjE8mtYCzBBV
rh5F8bqHAaNV2UpmIjtAqyEOTdN6wBBFFed2m7kPwH3tc3SfHW+tiFGyROZJM0N8
CaNOOymGbm8hxZuqGJWUQrxLzGqLqzZzzz5pKx+o5av0aiCfa/A=
=eUwp
-----END PGP SIGNATURE-----

--O5tKaXQq4nFrPMWf--

