Return-Path: <dmaengine+bounces-4405-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D11A2F30E
	for <lists+dmaengine@lfdr.de>; Mon, 10 Feb 2025 17:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 085D83A26C6
	for <lists+dmaengine@lfdr.de>; Mon, 10 Feb 2025 16:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3077E2580DB;
	Mon, 10 Feb 2025 16:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O9PX+r4/"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B022580C8;
	Mon, 10 Feb 2025 16:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739204407; cv=none; b=iV64aRtO/wcuMhYRDqVX1qrDa3odZhAhBFj1KdAtuuGLJwiQOaKx7Wl79s0oIGd7bd5Sm5E+Q4CG4API6rMQFnqa7/s5qt349ksd9sPO/oWp2YdFlcyabo0xql5XMJljdtAtfk+cXUULTUCAgU8RLPJ3yc7x2AVjyzg4S50FCMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739204407; c=relaxed/simple;
	bh=NWngG/kFcyT8WtXP/QQ25Wit1MvMYs4YLqlxYuAuRm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DSOdNIl7mE6U9IIIlPyn0s47K2PxshHJ2OvASIOr5pF8r692UZD5d3UjUS/y3tRF2R9JEUTVO80OvCkNFgHH3HGIe6MmQ1x0b+Cxd1Rba9aBz2xu/1M/FZ2YEWnny4ZpLMAR/kVqXxK5zS2C7ODhfU6CDizINcfgmsS1fxWeCcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O9PX+r4/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74E92C4CED1;
	Mon, 10 Feb 2025 16:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739204406;
	bh=NWngG/kFcyT8WtXP/QQ25Wit1MvMYs4YLqlxYuAuRm0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O9PX+r4//9gugSEWU7m1K8ZM3qhMdimRiJbSiYe86/w+9bR4X4/MhCjFvOn6jCtWl
	 vB28xXU/PEd8OdGhiVaNzDs/FBXWoLFRH4kptOE8xbXpq2qGI6a1OOZVnXI0ym83jq
	 LnGs4AcqzboBOb0532JVxtDrX12IZ6wn//naY2MVFJBPlNYsR41f8I13OeonC84QCk
	 69CbLAibibKHMCZuy3S8PjUceMx28EdXjIP8T0trrzPnKbKuzKWElzT2zR5LGP78Nt
	 r0Zexk9OTbCG39S9//bUNzD+y+hVdVaV0KhwIcQGWehOvV4XsKy2wNZZpg0KLnYd2E
	 5bjdCF+rvXDcw==
Date: Mon, 10 Feb 2025 16:19:56 +0000
From: Mark Brown <broonie@kernel.org>
To: =?iso-8859-1?Q?J=2E_Neusch=E4fer?= <j.ne@posteo.net>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Krzysztof Kozlowski <krzk@kernel.org>, imx@lists.linux.dev,
	Scott Wood <oss@buserror.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>, Lee Jones <lee@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2 00/12] YAML conversion of several Freescale/PowerPC DT
 bindings
Message-ID: <8087f0dc-8c79-48a2-abf4-f78636c23be6@sirena.org.uk>
References: <20250207-ppcyaml-v2-0-8137b0c42526@posteo.net>
 <611e47da-ba87-4c21-a6b7-cf051dc88158@sirena.org.uk>
 <Z6a_f03Ct9aB7Bbn@probook>
 <0fe3416c-c3f3-44c4-a1c0-7e8262c54d4b@sirena.org.uk>
 <Z6oh9t2QQzz17Yt6@probook>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dFkCMkVIcP+mIwAz"
Content-Disposition: inline
In-Reply-To: <Z6oh9t2QQzz17Yt6@probook>
X-Cookie: A beer delayed is a beer denied.


--dFkCMkVIcP+mIwAz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 03:57:42PM +0000, J. Neusch=E4fer wrote:
> On Mon, Feb 10, 2025 at 12:59:35PM +0000, Mark Brown wrote:

> > Please don't do this, it just makes it harder to merge things since it
> > makes it look like there's cross tree merges needed when that's not the
> > case, complicating merging, and puts the entire series in everyone's
> > inbox which makes things more noisy.

> How should I proceed with this series, in your opinion?
> I see potential advantages (less of the issues you describe) and
> disadvantages (somewhat harder to track patches) of splitting it up
> before sending v3.

I'd rather that at least the SPI stuff were sent separately (well,
ideally what you've done already is fine and it doesn't need a resend at
all).

--dFkCMkVIcP+mIwAz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmeqJysACgkQJNaLcl1U
h9DNKQf/fZPJSroWubfTO8FLkUiOu5OAUNqM92OSlaM82yLjpcppqTwDH2c/TMS7
uzik6Kqwe9iL95z0VpO/SEQh2gEiVVotP2LwUfc0VHm6Mj0CYUhJVu5CFspP2PTu
H7A2qsXCPw2ASwOg8ZA+oH0PpNAI2mBdDeb7Dii4r186WNPit5Xunpx8I+9DoEyr
Zr6lOUeCFVfJVy6oNc7ZCQUhRljOVtlyRzPVMTpsyaMzgT22K+F+CHvQR/XatQQF
/2ywiEFKi5u2DSNtEgro0CF6bJ4U/ZtRMGcnEq9r6RmhpAINqFJhS0dysaqOIJfS
37TAqV/OvijdnS0RGY+GC+jyvnaoJA==
=DC91
-----END PGP SIGNATURE-----

--dFkCMkVIcP+mIwAz--

