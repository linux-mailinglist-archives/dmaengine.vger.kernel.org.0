Return-Path: <dmaengine+bounces-4935-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FFCA9636A
	for <lists+dmaengine@lfdr.de>; Tue, 22 Apr 2025 11:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DCD41695C4
	for <lists+dmaengine@lfdr.de>; Tue, 22 Apr 2025 08:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F336225522B;
	Tue, 22 Apr 2025 08:56:10 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467709476
	for <dmaengine@vger.kernel.org>; Tue, 22 Apr 2025 08:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745312170; cv=none; b=aapXgW4M740RMLNWKnu4dTXffmCPyEQXHYPl6DyPx2+sjzdignWU8flTefeCkcTm0lcq6Drb7KQuPd8eHZA34JlNd7iSgik18lNdVePHpKEsS+gLOAxcRTI8qKzcl2QjOX2Eq9dFE8Ufmy6ZWhu3q4U6j0X7U3abP4dy8fylj5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745312170; c=relaxed/simple;
	bh=KfrcJp90mLH/oPioQRdtTME45LSOkSzp3PFEGOdY9Co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bdcxL8GQL2Ptv1i47JrpW+akgpFndPA1ZTJS+5QB9FtWdEqkx7ch1j1bIkC8jbAmZ3EWlh1xJNv6hXUz+7Ph1B03T1E3LY3gTG/4HDCtDx/Uq3OnX501t/fFZuTW85Q0g8VU/6UIYNu2FOh2XuzBwFq+T7ozVqnN1Eyr16fKGss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 22 Apr 2025 04:56:01 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ben Collins <bcollins@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: dmaengine@vger.kernel.org, Zhang Wei <zw@zh-kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fsldma: Support 40 bit DMA addresses where capable
Message-ID: <2025042204-apricot-tarsier-b7f5a1@boujee-and-buff>
Mail-Followup-To: Arnd Bergmann <arnd@arndb.de>, dmaengine@vger.kernel.org, 
	Zhang Wei <zw@zh-kernel.org>, Vinod Koul <vkoul@kernel.org>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
References: <2025042122-bizarre-ibex-b7ed42@boujee-and-buff>
 <fb0b5293-1cf3-4fcc-be9c-b5fe83f32325@app.fastmail.com>
 <2025042202-uncovered-mongrel-aee116@boujee-and-buff>
 <ace8c85d-6dec-499f-8a8a-35d4672c181d@app.fastmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wop522mmefnoma4a"
Content-Disposition: inline
In-Reply-To: <ace8c85d-6dec-499f-8a8a-35d4672c181d@app.fastmail.com>
X-Migadu-Flow: FLOW_OUT


--wop522mmefnoma4a
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] fsldma: Support 40 bit DMA addresses where capable
MIME-Version: 1.0

On Tue, Apr 22, 2025 at 09:59:42AM -0500, Arnd Bergmann wrote:
> On Tue, Apr 22, 2025, at 09:12, Ben Collins wrote:
> > On Tue, Apr 22, 2025 at 08:34:55AM -0500, Arnd Bergmann wrote:
> >>=20
> >> - SoCs that don't set a dma-ranges property in the parent bus
> >>   are normally still capped to 32 bit DMA. I don't see those
> >>   properties, so unless there is a special hack on those chips,
> >>   you get 32 bit DMA regardless of what DMA mask the driver
> >>   requests
> >
> > I've yet to see a dma-ranges property in any of the Freescale PowerPC
> > device trees.
>=20
> Right, but this could just mean that they end up using SWIOTLB
> to bounce the high DMA pages or use an IOMMU rather than actually
> translating the physical address to a dma address.

There's a few things going on. The Local Address Window can shift
anywhere in the 64-bit address space and be as wide as the physical
address (40-bit on T4240, 36-bit on P4080). I think this is mainly for
IO to PCIe and RapidIO, though.

> The only special case I see for freescale powerpc chips is the
> PCI dma_set_mask() handler that does
>=20
> static void fsl_pci_dma_set_mask(struct device *dev, u64 dma_mask)
> {
>         /*
>          * Fix up PCI devices that are able to DMA to the large inbound
>          * mapping that allows addressing any RAM address from across PCI.
>          */
>         if (dev_is_pci(dev) && dma_mask >=3D pci64_dma_offset * 2 - 1) {
>                 dev->bus_dma_limit =3D 0;
>                 dev->archdata.dma_offset =3D pci64_dma_offset;
>         }
> }
>=20
> but that should not apply here because this is not a PCI device.

Right.

> > I'll check on this, but I think it's a seperate issue. The main thing is
> > just to configure the dma hw correctly.
>=20
> I think it's still important to check this before changing the
> driver: if the larger mask doesn't actually have any effect now
> because the DT caps the DMA at 4GB, then it might break later
> when someone adds the correct dma-ranges properties.

I'm adding dma-ranges to my dt for testing.

> > So a little research shows that these 3 compatible strings in
> > the fsldma are:
> >
> > fsl,elo3-dma:		40-bit
> > fsl,eloplus-dma:	36-bit
> > fsl,elo-dma:		32-bit
> >
> > I'll rework it so addressing is based on the compatible string.
>=20
> Sounds good, yes. Just to clarify: where did you find those
> limits? Are you sure those are not just the maximum addressable
> amounts of physical RAM on the chips that use the respective
> controllers?

This is where things might be more interesting. The P4080RM and T4240RM
is where I got this information. Register "cdar" in the fsldma code. This
makes up 0x08 and 0x0c registers.

In the RM 0x08 is the extended address register. On P4080 it says this
holds the top 4 bits of the 36-bit address, and on T4240 it says the top
8 bits of the 40-bit address. So the asynx_tx physical address needs to
be masked to the 36-bit or 40-bit.

--=20
 Ben Collins
 https://libjwt.io
 https://github.com/benmcollins
 --
 3EC9 7598 1672 961A 1139  173A 5D5A 57C7 242B 22CF

--wop522mmefnoma4a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEPsl1mBZylhoRORc6XVpXxyQrIs8FAmgHWaEACgkQXVpXxyQr
Is+YXA//ZCVfP2Vcf2wN9DmzGexCKVQoLJGySna4HgS0fL7x+pMQusccWOqf4rUs
eLipGkYQXlTr5X+iW0SU7x6xWaHjXbaqXNgvypoGEdI/SGCd4rP5JbDmCgGcl197
L3L3aSkaC7Ofo2ACXQKAubuhtoC7g9R29+0QEyxCOk5nX8BVKHk0lq/IxpVxNzGo
2P72w9dVpryukut3bjsrvyVxJVwow49W/v2K9nzB+YIyEy+1XApkd2pnMgeeLLwV
PqobZumgvDp/sDFFl2eUsNR+vjJxw2Z4d799D8df5s6YhvUEkRcZWNnNr4iLLGg4
IikePsfOFFRPPIElGi4JCVlRfvxm4rElJh1dR0OyK6JvzNvBbEEQWm0afaE/oCmi
7uuH1hbCMr/6Ynfdvw4Br7HzMN4A2uK9v/gui/7rM3JcXUOSHClEZIcKxOKoINsh
qe7cRXa7ZYVa14c+DLhl5rbmc3/PHZUzyeYA1V1hL3eITH7iOo+ud3AXzXLnM+ZT
BGhf1OGz+QRXV6bCx8q5onrMggRPOD+J4/nh4eYgAI34Tn5rNSbarh9kqx5U7NqY
7BPd8k6q9DTTiApN9imyOhoyksIHl14kCmvDQLGalFX/KtGmsElgyxtujEjLR9Mu
s7vMBCzPu6G2TIe0f9xyWhu8iHVvrry+JiYOszwFEMjFlLmFr6o=
=IUWG
-----END PGP SIGNATURE-----

--wop522mmefnoma4a--

