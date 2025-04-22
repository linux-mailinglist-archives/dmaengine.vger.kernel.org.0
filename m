Return-Path: <dmaengine+bounces-4960-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55363A9783E
	for <lists+dmaengine@lfdr.de>; Tue, 22 Apr 2025 23:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2E317AB9F7
	for <lists+dmaengine@lfdr.de>; Tue, 22 Apr 2025 21:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E27625C816;
	Tue, 22 Apr 2025 21:10:43 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC3C25C80B
	for <dmaengine@vger.kernel.org>; Tue, 22 Apr 2025 21:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745356243; cv=none; b=s67BlJDodIsB/lXR1Tjq8cx/i/1Yr/hATSfm/QN2AFDK3AC4o4DYI0qKrWpBZTrRgblMYmgLItysYz3yR06ckIphDwvGR6AJ/YmACeSBTv0FTqnNDtNPpaUUt2bx6Tli2ZwiTInF3ymzmMy4OosfpHKa/Py/SCz9oiBWx0Cc4Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745356243; c=relaxed/simple;
	bh=nHLAmBP6RNdP/EyjW2eqnHDPzOUXOLr826wf78n7bZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xl6miMcpelXhOddseZjSss1poPXm0omzCg+xObE5+2mRZmxepZqsvBNhmilGm+fkyKYobeZ9bbbFu8VM4cw3xfATG/Fo4ccbnGL7A/tbYclJWQP2zmCD5kZDYUE6IpwpB9uBYweWeMUsQMlcDC75QalO9g549EVXeLqLj9IvB40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 22 Apr 2025 17:10:32 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ben Collins <bcollins@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fsldma: Support 40 bit DMA addresses where capable
Message-ID: <2025042216-hungry-hound-77ecae@boujee-and-buff>
Mail-Followup-To: Arnd Bergmann <arnd@arndb.de>, dmaengine@vger.kernel.org, 
	Vinod Koul <vkoul@kernel.org>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <2025042122-bizarre-ibex-b7ed42@boujee-and-buff>
 <fb0b5293-1cf3-4fcc-be9c-b5fe83f32325@app.fastmail.com>
 <2025042202-uncovered-mongrel-aee116@boujee-and-buff>
 <ace8c85d-6dec-499f-8a8a-35d4672c181d@app.fastmail.com>
 <2025042204-apricot-tarsier-b7f5a1@boujee-and-buff>
 <29bdb7e0-6db9-445e-986f-b29af8369c69@app.fastmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ttjcfkvyttnwvorf"
Content-Disposition: inline
In-Reply-To: <29bdb7e0-6db9-445e-986f-b29af8369c69@app.fastmail.com>
X-Migadu-Flow: FLOW_OUT


--ttjcfkvyttnwvorf
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] fsldma: Support 40 bit DMA addresses where capable
MIME-Version: 1.0

On Tue, Apr 22, 2025 at 11:25:40AM -0500, Arnd Bergmann wrote:
> On Tue, Apr 22, 2025, at 10:56, Ben Collins wrote:
> > On Tue, Apr 22, 2025 at 09:59:42AM -0500, Arnd Bergmann wrote:
> >>=20
> >> Right, but this could just mean that they end up using SWIOTLB
> >> to bounce the high DMA pages or use an IOMMU rather than actually
> >> translating the physical address to a dma address.
> >
> > There's a few things going on. The Local Address Window can shift
> > anywhere in the 64-bit address space and be as wide as the physical
> > address (40-bit on T4240, 36-bit on P4080). I think this is mainly for
> > IO to PCIe and RapidIO, though.
>=20
> There are usually two sets of registers, not sure which one the Local
> Address Window refers to:
>=20
> - Translation of MMIO addresses (PCI BAR and device registers) when
>   accessed from CPU and possibly from P2P DMA, these are represented
>   by the 'ranges' property in DT.
>=20
> - Translation of physical memory when accessed from a DMA bus master,
>   represented by the 'dma-ranges' property.
>=20
> The latter is what the dma-mapping API needs. This code has changed
> a lot over the years, but in the current version the idea is that
> the limit enforced by the driver through dma_set_mask() is independent
> of the limit enforced by the platform bus based on the dma-ranges
> property.=20

LAWs translate physical addresses to IOVA (PCIe/RapidIO/SoC resources)
and are used for all master level translations (CPU, DMA, PCIe, DDR,
RapidIO). This is at the interconnect level.

I believe LAWs cover both of these cases.

> >> > I'll check on this, but I think it's a seperate issue. The main thin=
g is
> >> > just to configure the dma hw correctly.
> >>=20
> >> I think it's still important to check this before changing the
> >> driver: if the larger mask doesn't actually have any effect now
> >> because the DT caps the DMA at 4GB, then it might break later
> >> when someone adds the correct dma-ranges properties.
> >
> > I'm adding dma-ranges to my dt for testing.
>=20
> Ok. The other thing you can try is to printk() the dev->bus_dma_limit
> to see if it even tries to use >32bit addressing.

Did that. Every combination of IOMMU on/off and dma-ranges in my dt always
showed bus_dma_limit as 0x0.

As an aside, if you could give this a quick check, I can send the revised
patch. Appreciate the feedback.

https://github.com/benmcollins/linux/commit/2f2946b33294ebff2fdaae6d1eadc97=
6147470d6

--=20
 Ben Collins
 https://libjwt.io
 https://github.com/benmcollins
 --
 3EC9 7598 1672 961A 1139  173A 5D5A 57C7 242B 22CF

--ttjcfkvyttnwvorf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEPsl1mBZylhoRORc6XVpXxyQrIs8FAmgIBcgACgkQXVpXxyQr
Is/arg//YUK1btd32Isj+g5BizDLDVu8sjSPgzzwW/6/50sCuEOFLFR+mnfwytO4
2ksisWOIXnb+riN+JwOqEiRmtskhQCkoHsCQzjGMcLqByME5xOr6GaEpvc7ap6tY
TlSyTyVLbruwfOH1JufT0/PI8EQVkhyDiD0ypwuzWAxD8yy/M2LG2RfvAZa2YX1o
TcXsmxTii3vC3ksM0VhUBjjgJ3Hm3MzmAXZmKPrJnY1+CS5bI/IsI+HPftKK44gH
E7xLgLjSd8oAUDtL+SWyP7RjBOu194HeupXAjW7oEwlRoCLqwu3L/NIqoqvmJvJO
rqU3bnRxt74BF46FwA1O5N1Vq6AD5MSFZsNcmt9UYB3bNTaOk2BsEnmqnNaf+QAb
bC3OC85mWUlBwBoTs3ijE1JcNanEZXVHDrBNGda2KEUrk2LQ9Kir00Cj2Q+RCuMj
/CBg4wCdhNUeRf2B/qeClRTUdoT8mQn26Np8eLSpD5+9EW9s5tmKKAtZsEmSHWd8
Mww8lkO1UmdnoxOBdmX4IlOw+UaeeazdAxMG42bpzwzaCtAidDSETXEwxQir5E6U
OpJwLFJZhrtHx1G8G4i7SXUmWnEMgkqbqCmFcGfxi+/K9ybirouKLniqqa+Xnoc6
OhqYd25DsSaia04tpWYvmaPJ0oDz5/RoIHJlhutHdxeYXayYcuo=
=L2gn
-----END PGP SIGNATURE-----

--ttjcfkvyttnwvorf--

