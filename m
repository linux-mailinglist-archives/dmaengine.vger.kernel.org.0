Return-Path: <dmaengine+bounces-4932-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C54A95F0B
	for <lists+dmaengine@lfdr.de>; Tue, 22 Apr 2025 09:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1F383A9AC1
	for <lists+dmaengine@lfdr.de>; Tue, 22 Apr 2025 07:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515AA22F3AB;
	Tue, 22 Apr 2025 07:12:52 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A586F1990C4;
	Tue, 22 Apr 2025 07:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745305972; cv=none; b=E065YXl0kyHBCV2fZgal/e41Hc2mcwtqI2LpJAtsNCkrqtJZrjlXQewq9cL7ZfvcXmbpRPeU8lVkydaL96Y5vAAFDJZujiOwhNRoyjF2JgM7ub38h5lUc1mZuwoJVykCFQwEz8tfZUVwbLKP+46WhYBfcoVre7Bmrsv2abaMfkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745305972; c=relaxed/simple;
	bh=Clkahm9wy0a3lcKG7XWwyYkG7qsrEXbxWavI6+56VNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g3PZKlB1BRdpnSwU2R9B6nNi7rOTg0qpmLc9F1vwtNzhcxOAIsZ386A4Hgg2BdJbBmyJVxIQpO2xi+DnnSN+BFDR7Q0QBYBpjJzMkxXX79nfHU3qb67F52QCiwJTcTsd/idRDeMf/mHja5uBk2ZCab9bT42X9HRtWUQiZwosI8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 22 Apr 2025 03:12:43 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ben Collins <bcollins@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: dmaengine@vger.kernel.org, Zhang Wei <zw@zh-kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fsldma: Support 40 bit DMA addresses where capable
Message-ID: <2025042202-uncovered-mongrel-aee116@boujee-and-buff>
Mail-Followup-To: Arnd Bergmann <arnd@arndb.de>, dmaengine@vger.kernel.org, 
	Zhang Wei <zw@zh-kernel.org>, Vinod Koul <vkoul@kernel.org>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
References: <2025042122-bizarre-ibex-b7ed42@boujee-and-buff>
 <fb0b5293-1cf3-4fcc-be9c-b5fe83f32325@app.fastmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ibrmx66igfcorlg4"
Content-Disposition: inline
In-Reply-To: <fb0b5293-1cf3-4fcc-be9c-b5fe83f32325@app.fastmail.com>
X-Migadu-Flow: FLOW_OUT


--ibrmx66igfcorlg4
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] fsldma: Support 40 bit DMA addresses where capable
MIME-Version: 1.0

On Tue, Apr 22, 2025 at 08:34:55AM -0500, Arnd Bergmann wrote:
> On Tue, Apr 22, 2025, at 04:49, Ben Collins wrote:
> > On 64-bit QorIQ platforms like T4240, the CPU supports 40-bit addressing
> > and memory configurations > 64GiB. The fsldma driver is limiting itself
> > to only 64GiB in all Elo configurations.
> >
> > Setup fsldma driver to make use of the full 40-bit addressing space,
> > specifically on the e5500 and e6500 CPUs.
>
=2E..
>=20
> - The driver just writes the DMA address as a 64-bit register,
>   so most likely the DMA device can in fact do wider addressing,
>   and any limitation is either in the bus or the available
>   memory
>=20
> - SoCs that don't set a dma-ranges property in the parent bus
>   are normally still capped to 32 bit DMA. I don't see those
>   properties, so unless there is a special hack on those chips,
>   you get 32 bit DMA regardless of what DMA mask the driver
>   requests

I've yet to see a dma-ranges property in any of the Freescale PowerPC
device trees.

I'll check on this, but I think it's a seperate issue. The main thing is
just to configure the dma hw correctly.

> - If there are chips that have more than 64GB of RAM installed
>   but have a limitation in the way the DMA engine is wired
>   up to 36 bits, that should be reflected in the dma-ranges
>   property, not the device driver.
>=20
> - If the limitation is indeed specific to the version of the
>   IP block, this would normally need to be detected based on
>   the compatible string of the DMA engine itself, not a compile
>   time setting.

So a little research shows that these 3 compatible strings in
the fsldma are:

fsl,elo3-dma:		40-bit
fsl,eloplus-dma:	36-bit
fsl,elo-dma:		32-bit

I'll rework it so addressing is based on the compatible string.

--=20
 Ben Collins
 https://libjwt.io
 https://github.com/benmcollins
 --
 3EC9 7598 1672 961A 1139  173A 5D5A 57C7 242B 22CF

--ibrmx66igfcorlg4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEPsl1mBZylhoRORc6XVpXxyQrIs8FAmgHQWsACgkQXVpXxyQr
Is9OBhAApnJBeKJ4ASuaAIAefdwxjwHiccr/SM7ZbzHesQxOQmonqT6U0//RHjJu
aaHhcwOPfBnSvpdylugW67fLi5F96vE4RtVlrli55lm98XL3xnGdhJcDTGXALz2h
omEHO+NlQYcaVj73HzeT7mlrMY5akw0pryfidJii+jx17JIV8eIyR3pjCPXfaDbT
m6FB/n84fcuRhwhsCIC2NGV8sIe1jBw8gxY2Non1HG8j7tLHmOzRPblu8c31qbMC
seeDW61e9JgH7r5Pj1Y9zvNVsJkXstyA+AWGz2TAB2n3jw4DgorQSFZt924Hwh4P
rdVjqH+/AxqN8+xLDAIVvvH+JsIwC6GA8Z4E9N565ntR8knxfk+kLWoRCNiyGizK
cl4ZTU6sXcyF7tR24hI4ma1ozwaoXf5W/vN6qx1gy2v/FQCD0m2BhzbfWxcwK3Cg
QrFI3IXyzU7d1W6ZVMaCwz1AvN6ZJNxNSF4fzexMUKEDLYu5PnT8dnFDpTfJsWrB
T8gskXv868OOIkaHkj5ujOgYUtLx9EURcG8Lc56kB9p4CL/J1Rzz/org8XYqClDL
J0/aDQ8Fy8RmPaEgzbPaBtRztG5jaVc/PsDVsT0+jKOVWd1C62uxBC+9bIUlR7S+
5rcwfAnkZF9T6Q0qs5inHlRyG6QeVZa14ZKeEejSQnDVc2oJ/70=
=UA0A
-----END PGP SIGNATURE-----

--ibrmx66igfcorlg4--

