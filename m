Return-Path: <dmaengine+bounces-4274-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 691BAA27BBA
	for <lists+dmaengine@lfdr.de>; Tue,  4 Feb 2025 20:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1D8B161601
	for <lists+dmaengine@lfdr.de>; Tue,  4 Feb 2025 19:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C90D21A44A;
	Tue,  4 Feb 2025 19:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qGHOEtxq"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E44219A67;
	Tue,  4 Feb 2025 19:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738698204; cv=none; b=ew3s54lLhof+djjCpGnw7AAfCDhJRldvq9h741684tV6yVvB0R4fha960OWfhwU8fdNBzLf1Shd3OoHcN0e4LSjsOTaXDqA6p3HRz3hZo2kzZqxc3LpSlHPYGfr9L6d5bU1lDbttEGDkwwugrfVQpKlJAXSQiV+R+AoDEdr6CAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738698204; c=relaxed/simple;
	bh=OxLFZkpOuKi4mROW2vapDOhHxudyF5mRfONiow0CF+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rm/9IWGPvubEyCxNk4s7G2Pg9Z+OQwcnROxDhzCIxLtosakLf0ppHKS371I+DzZdmr17cBz+P6tEfwm10egu4K1JiT5kWZZrBCvYRIC17rxSEd5P3ir2dWq8JeOykuEjuQ3fB/ib+dbU1ONDIwB/HAm5nDlDfV9Ke+FbrGjby3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qGHOEtxq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAF8BC4CEDF;
	Tue,  4 Feb 2025 19:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738698203;
	bh=OxLFZkpOuKi4mROW2vapDOhHxudyF5mRfONiow0CF+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qGHOEtxqdAQU8YotL4e98GbgQmk7mPn18e+HS3j6b5SYDPEmtFhS1t1QJRGhr0vEP
	 Ik7PncdOwgFyb3/fMybjSURGqxAr63XYXOXlJthV9hmGNtgFCcpN9yVVYVr+LwiZJ1
	 E8DeD4JjJ0r2M2VLQ2B1l6Vgrz+hTzfQ1+ic/HBGx8EjWv0p4XUEgjSzDZ6cveWIuZ
	 BSM7Hs2bAuiMjCblqFJ2aucIrDsydT+E8apE2TJkXZj8EuHj4YysrGa74LHFLsMu4U
	 ImMuWIrnVNsAZEw7OYi3Ra/tuz3ZoF95u5u7w1WetNCQ+uol2+2oe5F0EWIK7FNNq7
	 BxSbEwYdTnnSA==
Date: Tue, 4 Feb 2025 19:43:14 +0000
From: Conor Dooley <conor@kernel.org>
To: Michal Simek <michal.simek@amd.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
	git@xilinx.com, Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Conor Dooley <conor+dt@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Harini Katakam <harini.katakam@amd.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Mark Brown <broonie@kernel.org>,
	Michael Tretter <m.tretter@pengutronix.de>,
	Michael Turquette <mturquette@baylibre.com>,
	Mubin Sayyed <mubin.sayyed@amd.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Niklas Cassel <cassel@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" <dmaengine@vger.kernel.org>,
	"moderated list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	"open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
	"open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" <linux-ide@vger.kernel.org>,
	"open list:XILINX AMS DRIVER" <linux-iio@vger.kernel.org>,
	"open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
	"open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>
Subject: Re: [PATCH 0/2] arm64: zynqmp: Move firmware constants from binding
 to platform
Message-ID: <20250204-onto-gliding-465a003ae66a@spud>
References: <cover.1738600745.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="myTze9WqxmEx6DIV"
Content-Disposition: inline
In-Reply-To: <cover.1738600745.git.michal.simek@amd.com>


--myTze9WqxmEx6DIV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 03, 2025 at 05:39:09PM +0100, Michal Simek wrote:
> Hi,
>=20
> Based on discussion done long time ago
> https://lore.kernel.org/all/5353872c-56a3-98f9-7f22-ec1f6c2ccdc8@linaro.o=
rg/
> it is better to deprecate firmware contants which are not used in any code
> and it's only purpose is to use macros in dt files.
>=20
> There is no reason to be the part of dt bindings but it should be kept
> there with adding deprecated warning.
>=20
> I want to see if this is the right way to go. If yes, I will also do the
> same changes in other headers which contain only constans which are not
> used in any code.

Ye, I think this is a good approach to take.
Acked-by: Conor Dooley <conor.dooley@microchip.com>

--myTze9WqxmEx6DIV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ6Jt0gAKCRB4tDGHoIJi
0iwjAQDHM3pyWDtIVQUJpum7sJq5YpFWOQPxf+3QWxHiauCquQEA83V6o0+XcqG0
ckSZUheRIaEO1eK0Y6KNH88lItDmUAE=
=SMqC
-----END PGP SIGNATURE-----

--myTze9WqxmEx6DIV--

