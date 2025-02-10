Return-Path: <dmaengine+bounces-4384-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E635A2ED0F
	for <lists+dmaengine@lfdr.de>; Mon, 10 Feb 2025 13:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 957417A1311
	for <lists+dmaengine@lfdr.de>; Mon, 10 Feb 2025 12:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C915222258C;
	Mon, 10 Feb 2025 12:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L47QptUn"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B59E1C07E5;
	Mon, 10 Feb 2025 12:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739192385; cv=none; b=VqJE0mLDM7KrigNTUXZUg9rqwbvh56UmuZYrGqHI5c51C2OsTKImxVANJglvaGxP4SX+GJ3YN/CBRN2v86jGvhbhwhdMWVSeSKzstaiKZOlo2fUa+XnM72YPeXCIt24dq3OAUFGtLAGuffbQotXBdGzzFf1JC5pjj0lsgAepp4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739192385; c=relaxed/simple;
	bh=owpoSk7EuQEMFHDc/s6Anvm+qbdzkCtpH98wS+rR4qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ehiRnoBBL0Zy1owAgIH0u1Xpwngl6IQ0E7dStvRvOwhXiCBcFBfzDt5sf7Is2WGtQm6TcM5YXXQcAP2Rb34sxU88n9GIQeA/5dShQuoKkM8AFxLS3q1Gl+VrJxFiL98R8jf//WXmi8gxAxkN3/IRcOzvuF7pdeB3/1TY0eQ3jLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L47QptUn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A013BC4CED1;
	Mon, 10 Feb 2025 12:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739192385;
	bh=owpoSk7EuQEMFHDc/s6Anvm+qbdzkCtpH98wS+rR4qg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L47QptUnYsLmPtLriLWk/mFFeLwNiicn+sgpWdC5JUSMTLZnSmIRzeQDhotnIur3r
	 T2PuqbTS/9961JLV3JPPepnAz8kzwwutEm5mDhmRhSHxuZH4PQnHKMkrLwb3GPOjHA
	 NpPVnElP0StXHHIoZj1w22xh56585gTSbrBY7+L57cEPFC6uCdNmrFC/MUkYw3SmRK
	 n5/QSF7k6FBHTpUbZ67QqyzIKpLf4ytrKpPtTZ0N6INEXGzBtjbEYsgzZUuU7v7aIl
	 JLWU2qWBoJkLmMZNXGQyO/SdAFBFganR7Bnr2lyPsoxWxMbx6VHV2JRJ0r/cgC/OB8
	 ON23cJ8tHySjg==
Date: Mon, 10 Feb 2025 12:59:35 +0000
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
Message-ID: <0fe3416c-c3f3-44c4-a1c0-7e8262c54d4b@sirena.org.uk>
References: <20250207-ppcyaml-v2-0-8137b0c42526@posteo.net>
 <611e47da-ba87-4c21-a6b7-cf051dc88158@sirena.org.uk>
 <Z6a_f03Ct9aB7Bbn@probook>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Erlp5XHmWCbFSP4H"
Content-Disposition: inline
In-Reply-To: <Z6a_f03Ct9aB7Bbn@probook>
X-Cookie: A beer delayed is a beer denied.


--Erlp5XHmWCbFSP4H
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 08, 2025 at 02:20:47AM +0000, J. Neusch=E4fer wrote:
> On Fri, Feb 07, 2025 at 09:38:05PM +0000, Mark Brown wrote:

> > What's the story with dependencies here - why is all this stuff in one
> > series?

> The patches are independent of each other, except for the four elbc/nand
> patches. They are in the same series because they came up during the
> same project and achieve similar goals, but it isn't necessary.

Please don't do this, it just makes it harder to merge things since it
makes it look like there's cross tree merges needed when that's not the
case, complicating merging, and puts the entire series in everyone's
inbox which makes things more noisy.

--Erlp5XHmWCbFSP4H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmep+DcACgkQJNaLcl1U
h9CQGgf/VRshpAxNRM+4y4pK3dFBOw1Ky/VAXan0LIOgCUmAP8+L3qoihpm6VZoz
o6W4ioH6XERLRHTxdkiieODuhDTDhXH7sNTVvzzLejKyo4DbHvQBsMo2X0+kEZ3X
n3ZFgc8GgqMbmv9EIVATYRnbBCUhhcD7EEZlTvxDDbErDipAGaaYMYTPsbMOZ1qY
WWHWlzndWagcVtYf4Qf5bx4FjpS97qnE+VS801C6WgxbmrOFcWrTga0hXVlhQeu/
V+FDM+XojBDbeAKOvkXZkHAybyY9U37wa0h0kmq6cDBuherZ5XdAXyw0K5uvqA4W
0ywZYqZ4Ucmy7mvcfUgmcUR9E3GnMg==
=m2SC
-----END PGP SIGNATURE-----

--Erlp5XHmWCbFSP4H--

