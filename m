Return-Path: <dmaengine+bounces-4268-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 192FDA277C2
	for <lists+dmaengine@lfdr.de>; Tue,  4 Feb 2025 18:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 047D13A7F56
	for <lists+dmaengine@lfdr.de>; Tue,  4 Feb 2025 17:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD38F215F54;
	Tue,  4 Feb 2025 17:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxekTmU8"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A03215F74;
	Tue,  4 Feb 2025 17:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738688609; cv=none; b=acitZETcvqsxRahjcb4K79jX3ih+LoFF1TcQiA98ml5xc/u1m6DvmOCQtcRWtUpUJ5AR7sSSnm5/ME6qZN2MhswD/ZDjyMQkjhSg2Y71gVXQ/qOJ96DdadE6ORzUwO/uud0fShsxz8JGm3aS7CDSRphF4F5jP8l576AoqjofSRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738688609; c=relaxed/simple;
	bh=E8RF/l5fhDegnIKTjohFkCM7t7+gGetyChqnwBJ62gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YbkJ7z/WnnSsVEhJSAeKsiTQNAL8Ui7HpAkgSZrjIw3SHse5pExzzccECZmGqP/uleMRmYXs8WJlLPNr3w5AN5MncGP+8Y8wnrNNiVLwH0jR1zwrJfmSB+IEFLm+Vx7xg7EZTeXkPZkc5MmdyzP46SU2yw7mkQzwQeXiWiXzeY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hxekTmU8; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4363ae65100so69257545e9.0;
        Tue, 04 Feb 2025 09:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738688606; x=1739293406; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RJlXgOl2VRAjUJ8u35f0etlEcwGJNxslv3jGkMjZZIs=;
        b=hxekTmU8f8Ydm4+S3COp8MWFbJimitty9nS42T8uVLqAdL6zAcRhXTcpzyoeSUMwLf
         BGkyI7lnq96y1Sy243loyWRZJloUOaa7Eg7cN3eTwheB9+M7GBZsJmrBfJDStVwc7H2H
         X1wvQXuqmJa3z8DoxGKwxJBIXT9nTMlfvUlvOuvVFMbFHv98fs4XVYkMutpD+3ZTtKMF
         TKEVBgYFWxkAZnP3abvy6C1E3AlVA/oipV6EyDh7buLyE7q5Z50bn4W/rnczs18SHiO1
         /KlClr6/HhmXzbKl/8wK1/Uy2UA/Lp6QURFkA2kFgbZEQC6ASIRUSvfZr0B8IppF39ZE
         0Utw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738688606; x=1739293406;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RJlXgOl2VRAjUJ8u35f0etlEcwGJNxslv3jGkMjZZIs=;
        b=Dw0+lFpDWCCFO2EEsshaAga6rsDsEufyhaTwo+U+etUcH5xbSjuEV6PS1o5E/vkvA3
         941wEq4wTmzvjxiWE2eFGbVt6VFGxjjPwLks2Y/J/WyJO78/fY9SHavKpM2ezD7iY6QG
         CgYpYeaO2s+mYi0dJ0Mh2p6JjMz5svyDwDV3WvJCXGBQsyn13DyFZkdBV8BJnro7DjQx
         UPlKz73M9L6Dtwf2t16/kmavGoiUSHcoQg+nAM/1HwEO0WHvTBaWAbpgd8Y/p5YFA3xY
         0sOb1vs/IByIIn/aB0QGBEuhj0o8AzQgBG1j5bEgMF5g1Z+Af9C03FfHO81ufNv4DZ+X
         G3Dg==
X-Forwarded-Encrypted: i=1; AJvYcCUhLgOrHa4zzVnfT5kt94lovajHEWqFJcRC0KVhw2Sbw+IvdFgswT6+P/d9iV4RSmeQ5KMirmshNxb7x70=@vger.kernel.org, AJvYcCW+EkAios3VaC6w4MZyxBfHy5fLktRNpo2UUliHBekWfIb69n64r/fLaOqkCLlamS2q/Hje+kTkLC0=@vger.kernel.org, AJvYcCWNXUksUsVkxnSizG2j1a21Xb2jkTKrlwBSepNYqQ9vfuVtFNQdm7KZlUkTvkdltkxdMAik83cYBCj0ylmj@vger.kernel.org, AJvYcCXLYFUY1yhL73+KtI1vkP1YjYLwV6xiQmqjpQpw0jQ7d+/vTyjBwZJfepYkaC7f1LPDJF6fc3l9@vger.kernel.org
X-Gm-Message-State: AOJu0YwGevsDRrdoXtFXDfkfytqwU8UCvkZVzuTKovBhU1Rxu3H9f4uA
	V5lsyndhOSIAqmamnhgJMMGRhzIIWg5ieuZ3vUZRHazu/t6oiEVk
X-Gm-Gg: ASbGncugTiNdxdeusLyC8M/up58zhHZK1OnBj7aw8wXnSV6/lGR4+4U/WsDC8r0hmPy
	P30DKaLXlnWp2J2Qm/2cnkoy78RQSkyPFomiXwG5n7Zmjig6rouiCz3evo1POXiH1Zpc/M4LCJR
	RsMi0fCsU+ViC+y471tlB2s7qe9UJECP1qTMhbC+4Gudt7xg6IPoBDjcUjOjOScQnEEF/JTWcWI
	4PBEEw+PX4EBduQ2KIy/GR/C4YOLGD4x937xx/uvqUzUsFB9Yb+wWjP9Q8eZ9X0zOsrIXlYBKuo
	eED0hL2Wqk/Qw8du5qOBOC8FnB3N2rPLOgJGC5dy/yyO/eSFR56ofU2ukqleGwK4QAqJsQOBUU7
	lhA==
X-Google-Smtp-Source: AGHT+IFuYLVNYZ98Q10JnMDLiyK6TyIQLXJ2SpGRGUPbmSrXDHm0ww9KWQ7sxRxXVNELVQNtb8I39w==
X-Received: by 2002:a05:600c:4713:b0:434:a852:ba77 with SMTP id 5b1f17b1804b1-438dc3cadf9mr278808005e9.15.1738688605335;
        Tue, 04 Feb 2025 09:03:25 -0800 (PST)
Received: from orome (p200300e41f281900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f28:1900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438e23de880sm194577805e9.12.2025.02.04.09.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 09:03:24 -0800 (PST)
Date: Tue, 4 Feb 2025 18:03:22 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Mohan Kumar D <mkumard@nvidia.com>
Cc: vkoul@kernel.org, jonathanh@nvidia.com, dmaengine@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3 1/2] dmaengine: tegra210-adma: Fix build error due to
 64-by-32 division
Message-ID: <52n364alceto6tgitbnjbfgtrk2lpe5ipztxi4abnuikjwgnvk@i6irrkj6fqbb>
References: <20250116162033.3922252-1-mkumard@nvidia.com>
 <20250116162033.3922252-2-mkumard@nvidia.com>
 <dsxaisxdpsxecyna527cifixyurmkgo3cfaiheau5jjdl5qysp@64qquncxdmof>
 <84382200-e793-4e9a-b25a-8dc43e7a8bd0@nvidia.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vyjr3c2wmimjx3vo"
Content-Disposition: inline
In-Reply-To: <84382200-e793-4e9a-b25a-8dc43e7a8bd0@nvidia.com>


--vyjr3c2wmimjx3vo
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 1/2] dmaengine: tegra210-adma: Fix build error due to
 64-by-32 division
MIME-Version: 1.0

On Tue, Feb 04, 2025 at 10:13:09PM +0530, Mohan Kumar D wrote:
>=20
> On 04-02-2025 21:06, Thierry Reding wrote:
> > On Thu, Jan 16, 2025 at 09:50:32PM +0530, Mohan Kumar D wrote:
> > > Kernel test robot reported the build errors on 32-bit platforms due to
> > > plain 64-by-32 division. Following build erros were reported.
> > >=20
> > >     "ERROR: modpost: "__udivdi3" [drivers/dma/tegra210-adma.ko] undef=
ined!
> > >      ld: drivers/dma/tegra210-adma.o: in function `tegra_adma_probe':
> > >      tegra210-adma.c:(.text+0x12cf): undefined reference to `__udivdi=
3'"
> > >=20
> > > This can be fixed by using lower_32_bits() for the adma address space=
 as
> > > the offset is constrained to the lower 32 bits
> > >=20
> > > Fixes: 68811c928f88 ("dmaengine: tegra210-adma: Support channel page")
> > > Cc: stable@vger.kernel.org
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes: https://lore.kernel.org/oe-kbuild-all/202412250204.GCQhdKe3-l=
kp@intel.com/
> > > Signed-off-by: Mohan Kumar D <mkumard@nvidia.com>
> > > ---
> > >   drivers/dma/tegra210-adma.c | 14 +++++++++++---
> > >   1 file changed, 11 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
> > > index 6896da8ac7ef..258220c9cb50 100644
> > > --- a/drivers/dma/tegra210-adma.c
> > > +++ b/drivers/dma/tegra210-adma.c
> > > @@ -887,7 +887,8 @@ static int tegra_adma_probe(struct platform_devic=
e *pdev)
> > >   	const struct tegra_adma_chip_data *cdata;
> > >   	struct tegra_adma *tdma;
> > >   	struct resource *res_page, *res_base;
> > > -	int ret, i, page_no;
> > > +	unsigned int page_no, page_offset;
> > > +	int ret, i;
> > >   	cdata =3D of_device_get_match_data(&pdev->dev);
> > >   	if (!cdata) {
> > > @@ -914,9 +915,16 @@ static int tegra_adma_probe(struct platform_devi=
ce *pdev)
> > >   		res_base =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "=
global");
> > >   		if (res_base) {
> > > -			page_no =3D (res_page->start - res_base->start) / cdata->ch_base_=
offset;
> > > -			if (page_no <=3D 0)
> > > +			if (WARN_ON(lower_32_bits(res_page->start) <=3D
> > > +						lower_32_bits(res_base->start)))
> > Don't we technically also want to check that
> >=20
> > 	res_page->start <=3D res_base->start
> >=20
> > because otherwise people might put in something that's completely out of
> > range? I guess maybe you could argue that the DT is then just broken,
> > but since we're checking anyway, might as well check for all corner
> > cases.
> >=20
> > Thierry
> ADMA Address range for all Tegra chip falls within 32bit range. Do you th=
ink
> still we need to have this extra check which seems like redundant for now.

No, you're right. If this is all within the lower 32 bit range, this
should be plenty enough. It might be worth to make it a bit more
explicit and store these values in variables and add a comment as to
why we only need the 32 bits. That would also make the code a bit
easier to read by making the lines shorter.

	// memory regions are guaranteed to be within the lower 4 GiB
	u32 base =3D lower_32_bits(res_base->start);
	u32 page =3D lower_32_bits(res_page->start);

	if (WARN_ON(page <=3D base))
		...

etc.

Hm... on the other hand. Do we know that it's always going to stay that
way? What if we ever get a chip that has a very different address map?

Maybe we can do a combination of Arnd's patch and this. In conjunction
with your second patch here, this could become something along these
lines:

	u64 offset, page;

	if (WARN_ON(res_page->start <=3D res_base->start))
		return -EINVAL;

	offset =3D res_page->start - res_base->start;
	page =3D div_u64(offset, cdata->ch_base_offset);

	if (WARN_ON(page =3D=3D 0 || page > cdata->max_page))
		return -EINVAL;

Thierry

> >=20
> > > +				return -EINVAL;
> > > +
> > > +			page_offset =3D lower_32_bits(res_page->start) -
> > > +						lower_32_bits(res_base->start);
> > > +			page_no =3D page_offset / cdata->ch_base_offset;
> > > +			if (page_no =3D=3D 0)
> > >   				return -EINVAL;
> > > +
> > >   			tdma->ch_page_no =3D page_no - 1;
> > >   			tdma->base_addr =3D devm_ioremap_resource(&pdev->dev, res_base);
> > >   			if (IS_ERR(tdma->base_addr))
> > > --=20
> > > 2.25.1
> > >=20

--vyjr3c2wmimjx3vo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmeiSFYACgkQ3SOs138+
s6FXgg/+OgEAmRJyuiiCJEuxPu0JoocxmNbYfeIKN366eLTOIlbJkC52bDvBos7J
0P6ROn5X35GRY9LGhDDBPS9W0j8ylF35pGvZh2KtmI3gY2n0K1QyFsR5e4kgP64W
RcjAQUmC+kfvCD1vvUekxMJfvxeJISpE3hYlL+kySqprjrVnWIAWq05f8rBdSADo
Sb0Giit5nfrdnvlhSy4FpJ60UutakcWtooeQz55cyKGer//chdexMsJ7Rc7Gph+z
oxKMOKIreEnSfYilIOcJweKlrVWPSss6SaM8k3zDm8kPgfkOxspDRvqORDAAUJMk
jYNX5yUKuwn1yEj2YhsHcpCW3HOamYaspoMxsGDE3auTBfDzo3ELSFrvBnCPY93N
79MVZwEUh5NFCiYZ7l7pY0ggAYRLuqtOFoGtoTTJ+OiL0SjrbxWuyHXNKjG32Pjx
l/r8O6/aTE90zTL4EJk6MPhk32U2XfmdBS1+ai5N81cd5uv9xsRTNzGgZfYpUWmy
aY0x95uigpzUGUqQ8ZJn6VWOnibzcLGDHrFhleZJWoyyqdUfdQfgw6SqnM84l0ft
BhRw97sBiRRJNFgv0qkMKEMSscSxThLRWXCVL0BUX6OaOeSfk8z0YLCP7k+tnFax
1mc3QWw+3i6F42o4sbE7pilbSzLksEJIrsjIoU0kBeUYgA+zyZ4=
=12cW
-----END PGP SIGNATURE-----

--vyjr3c2wmimjx3vo--

