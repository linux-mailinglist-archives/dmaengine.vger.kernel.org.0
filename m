Return-Path: <dmaengine+bounces-4270-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50845A2792D
	for <lists+dmaengine@lfdr.de>; Tue,  4 Feb 2025 18:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C14713A2318
	for <lists+dmaengine@lfdr.de>; Tue,  4 Feb 2025 17:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2D321660C;
	Tue,  4 Feb 2025 17:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g16CE0EP"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56EB216603;
	Tue,  4 Feb 2025 17:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738691898; cv=none; b=h9cq3NhvUEoa9QDw/3cX1q0gXtA/HXED7e2amM9ozWBOg7LnSrYxnyjgfSPRgbR/UITppC/NAMqMV1r6lei87xP1Nm3CzO3QSbxjWEMpszVtiyc9N6RzVjZmiLMDorpCQpvjOCviHsZAbuZT1HLKNAKWw4rfWxQzOdmyQk+L92I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738691898; c=relaxed/simple;
	bh=fJMyfC+FpkEe+Jc7PZhQm0cn15ZCm3XeLaHlbE+jTJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gpIVAV5iSK0RU0XXfMO7++VrYMetom9PK9e6F9IzzsasQPh0gzP67EI/V9L1X9sehNzMtNLZV7r3obJ9QllZQCWEeD6hHbt+vypOSoXi0HJ+MAD5WYL2qaag4rrqSBlXgJb6bLVJdPQgZhRfha2S7MP9xNhNB+J4PFEUp+ohrxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g16CE0EP; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43635796b48so249655e9.0;
        Tue, 04 Feb 2025 09:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738691895; x=1739296695; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DaCr7q2IZb+qDsykGK4JI38oEwvknkiA23OdMdPwp10=;
        b=g16CE0EPJ89Qocgp2G//9oXJAG4TvY2lEAvermLgFl/SIHarlt8QRCeQ3iNg+hYO8d
         OHEvoeKHNIZEygrMjs4unMWjNP1y+6qFbVbz4X9Km5cmF0/fHPncc0P2jTQFuB9Ne6Sf
         SrxJHvbMsN5FHOiO6IHP/g8tV5PRHJ5N0IHCM6KirvT2XI588ynT5KapW1G7TKm63m7y
         yVPn53MgF2LmKWD36WGsp8aaBCbHp0O24SPDCYahFIj+sPHd7RGLiJXokZHsz4zIRDxz
         0Q8R7qtu5sfG67j2GIK3hITiXLDZ4mfiqRSXP71suajI6JjRHe0287D9LE6eeDMjhTOI
         UBlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738691895; x=1739296695;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DaCr7q2IZb+qDsykGK4JI38oEwvknkiA23OdMdPwp10=;
        b=eWzdOmLhSPAtResyUayyF5dIQ95YCZDVaezqShw57SS6NRMqKweEsUFoJ+0H3y6gKm
         oyWIFrcuhaBuma48dwY9U26quM/RowyhzP+2pY49E1EheSwsBJmhe9yyWjge9FVZXFS+
         aSwGnH+wD3bOvdBZK9bWT9PIYDMsPeezK5aggmy2XrP1v94ShIMTkRvH9pwCaUT0cinC
         57GrsHE0c+D1Zz8QetcNdrH/KzSsHjJTZMIPZ94SrqKX2pGkEazhUtdM4D/TajI7cEwp
         31R2cHUXaNX08SuoywAox2BEiwzJnUcxrjGUq9BVQOXD1loISLe5s33xU0niFLR4OKPz
         SxCw==
X-Forwarded-Encrypted: i=1; AJvYcCUlNBWQcxE5mkvQy1HNUoNECjD78AK68uj/yUfC+4gX5NyMSCl+Nstj59TZG4niedbsCda0RCuyU7FTuIOS@vger.kernel.org, AJvYcCUw4OcCMDFk19cNSPSRcRiD5f/oZVNxTb2do3HKQtPsZ9C1pp9b40PCzXcJUYNMckQR7YONqIFY@vger.kernel.org, AJvYcCVeuVNo4jAJBb2plx11XBs7Y/yNp/F4b8grNuwcYaudLVU6LCmz+FvegKcNx6By1yFdYBVEzo2cXqHE6zQ=@vger.kernel.org, AJvYcCVzXX0JQitANLh+3qOgStA3BzGvY9KRe7NcRmFR03+juNe8U5V5EbdiTXbCZd8AfAdoT8iF3TYcwdg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlOCv8zDjifF09jcdu8IWl/VPFXF2eJ0lsGCV5kYp60g2m3XQY
	daHBKOudbkNB2RoAUz6DLlPpsMu2Lk9xnkRdnBbufA2H9PzUS4z+Kv3olw==
X-Gm-Gg: ASbGncvmUklZhC4oN86iXvmXkWN44bB+AEFO0koknZFh+yzjQcNYbcpDUOLsn91j9Ez
	5t3FvqYqYQSL1hkETJn1xc6y2Cf8crkWLc9ofu35yi12Y6mxykCKFfj4CIiWI/XEppjQ5TwK6mH
	mG1ptSmxJEJ7WfmOCLDaZJO2r2f+anPrG5Xhy7St/9FXMWJG6SqyvlomJzhPOFmN6zW2zsEwWf1
	56en1TuB4KmZZjsFXhB8ENH/IlueDCjzVa2h7rTixXMx3AjPjrF1PdwGWyeDjrzthT2xTDXaKcP
	QlzkJLcisSo0a1Bb6HKTrhQyTHKJnnM7md7Uts/AhxnCmjDxY37eaFj5UY0wB3pqHso/YNiyJBh
	sGA==
X-Google-Smtp-Source: AGHT+IGBotAZQJEfQycHZ/2NUlQP/ZgrtfGYyoTTbSoDLtBldbC2nDEWF4vmnVBugGiq3s4Cg+ikMg==
X-Received: by 2002:a7b:c411:0:b0:434:ff08:202e with SMTP id 5b1f17b1804b1-43905f78241mr31249675e9.8.1738691894558;
        Tue, 04 Feb 2025 09:58:14 -0800 (PST)
Received: from orome (p200300e41f281900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f28:1900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c5c1cf571sm16200097f8f.82.2025.02.04.09.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 09:58:13 -0800 (PST)
Date: Tue, 4 Feb 2025 18:58:11 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Mohan Kumar D <mkumard@nvidia.com>, vkoul@kernel.org, 
	dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3 1/2] dmaengine: tegra210-adma: Fix build error due to
 64-by-32 division
Message-ID: <uboixhzbccbt3ugdv6z4wsyyn4cpviw6okjwmfeqaslecotgpj@47afypfx5xo7>
References: <20250116162033.3922252-1-mkumard@nvidia.com>
 <20250116162033.3922252-2-mkumard@nvidia.com>
 <dsxaisxdpsxecyna527cifixyurmkgo3cfaiheau5jjdl5qysp@64qquncxdmof>
 <84382200-e793-4e9a-b25a-8dc43e7a8bd0@nvidia.com>
 <52n364alceto6tgitbnjbfgtrk2lpe5ipztxi4abnuikjwgnvk@i6irrkj6fqbb>
 <c5e7e8a3-2e8e-4d68-8e06-a7a3f7fc451e@nvidia.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="np3j6rj6ep4uje44"
Content-Disposition: inline
In-Reply-To: <c5e7e8a3-2e8e-4d68-8e06-a7a3f7fc451e@nvidia.com>


--np3j6rj6ep4uje44
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 1/2] dmaengine: tegra210-adma: Fix build error due to
 64-by-32 division
MIME-Version: 1.0

On Tue, Feb 04, 2025 at 05:18:46PM +0000, Jon Hunter wrote:
>=20
> On 04/02/2025 17:03, Thierry Reding wrote:
> > On Tue, Feb 04, 2025 at 10:13:09PM +0530, Mohan Kumar D wrote:
> > >=20
> > > On 04-02-2025 21:06, Thierry Reding wrote:
> > > > On Thu, Jan 16, 2025 at 09:50:32PM +0530, Mohan Kumar D wrote:
> > > > > Kernel test robot reported the build errors on 32-bit platforms d=
ue to
> > > > > plain 64-by-32 division. Following build erros were reported.
> > > > >=20
> > > > >      "ERROR: modpost: "__udivdi3" [drivers/dma/tegra210-adma.ko] =
undefined!
> > > > >       ld: drivers/dma/tegra210-adma.o: in function `tegra_adma_pr=
obe':
> > > > >       tegra210-adma.c:(.text+0x12cf): undefined reference to `__u=
divdi3'"
> > > > >=20
> > > > > This can be fixed by using lower_32_bits() for the adma address s=
pace as
> > > > > the offset is constrained to the lower 32 bits
> > > > >=20
> > > > > Fixes: 68811c928f88 ("dmaengine: tegra210-adma: Support channel p=
age")
> > > > > Cc: stable@vger.kernel.org
> > > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > > Closes: https://lore.kernel.org/oe-kbuild-all/202412250204.GCQhdK=
e3-lkp@intel.com/
> > > > > Signed-off-by: Mohan Kumar D <mkumard@nvidia.com>
> > > > > ---
> > > > >    drivers/dma/tegra210-adma.c | 14 +++++++++++---
> > > > >    1 file changed, 11 insertions(+), 3 deletions(-)
> > > > >=20
> > > > > diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-a=
dma.c
> > > > > index 6896da8ac7ef..258220c9cb50 100644
> > > > > --- a/drivers/dma/tegra210-adma.c
> > > > > +++ b/drivers/dma/tegra210-adma.c
> > > > > @@ -887,7 +887,8 @@ static int tegra_adma_probe(struct platform_d=
evice *pdev)
> > > > >    	const struct tegra_adma_chip_data *cdata;
> > > > >    	struct tegra_adma *tdma;
> > > > >    	struct resource *res_page, *res_base;
> > > > > -	int ret, i, page_no;
> > > > > +	unsigned int page_no, page_offset;
> > > > > +	int ret, i;
> > > > >    	cdata =3D of_device_get_match_data(&pdev->dev);
> > > > >    	if (!cdata) {
> > > > > @@ -914,9 +915,16 @@ static int tegra_adma_probe(struct platform_=
device *pdev)
> > > > >    		res_base =3D platform_get_resource_byname(pdev, IORESOURCE_M=
EM, "global");
> > > > >    		if (res_base) {
> > > > > -			page_no =3D (res_page->start - res_base->start) / cdata->ch_b=
ase_offset;
> > > > > -			if (page_no <=3D 0)
> > > > > +			if (WARN_ON(lower_32_bits(res_page->start) <=3D
> > > > > +						lower_32_bits(res_base->start)))
> > > > Don't we technically also want to check that
> > > >=20
> > > > 	res_page->start <=3D res_base->start
> > > >=20
> > > > because otherwise people might put in something that's completely o=
ut of
> > > > range? I guess maybe you could argue that the DT is then just broke=
n,
> > > > but since we're checking anyway, might as well check for all corner
> > > > cases.
> > > >=20
> > > > Thierry
> > > ADMA Address range for all Tegra chip falls within 32bit range. Do yo=
u think
> > > still we need to have this extra check which seems like redundant for=
 now.
> >=20
> > No, you're right. If this is all within the lower 32 bit range, this
> > should be plenty enough. It might be worth to make it a bit more
> > explicit and store these values in variables and add a comment as to
> > why we only need the 32 bits. That would also make the code a bit
> > easier to read by making the lines shorter.
> >=20
> > 	// memory regions are guaranteed to be within the lower 4 GiB
> > 	u32 base =3D lower_32_bits(res_base->start);
> > 	u32 page =3D lower_32_bits(res_page->start);
> >=20
> > 	if (WARN_ON(page <=3D base))
> > 		...
> >=20
> > etc.
> >=20
> > Hm... on the other hand. Do we know that it's always going to stay that
> > way? What if we ever get a chip that has a very different address map?
>=20
> You mean a DMA register space that crosses a 4GB address boundary? I would
> hope not but maybe I should not assume that!

Not cross the boundary, but simply be beyond that boundary. The current
check will falsely succeed if you've got something like this:

	base: 0x00_44000000
	page: 0x01_45000000

or:

	base: 0x01_44000000
	page: 0x00_45000000

For both of them the page > base condition is true, but they are clearly
not related. Of course this would only happen in the hypothetical case
where there are multiple instances, which is not the case for ADMA, but
for other devices this could happen.

So I think it's always good to be prepared for those cases and do the
right thing regardless.

>=20
> > Maybe we can do a combination of Arnd's patch and this. In conjunction
> > with your second patch here, this could become something along these
> > lines:
> >=20
> > 	u64 offset, page;
> >=20
> > 	if (WARN_ON(res_page->start <=3D res_base->start))
> > 		return -EINVAL;
> >=20
> > 	offset =3D res_page->start - res_base->start;
> > 	page =3D div_u64(offset, cdata->ch_base_offset);
>=20
>=20
> We were trying to avoid the div_u64 because at some point we want to conv=
ert
> the result to 32-bits to avoid any further 64-bit math and we really don't
> need 64-bits for the page number.

Well, we can always safely cast page to u32 after this, or after
checking (in the second patch) that it's within an expected range. But
then again, do we really need to do 64-bit divisions using these numbers
again? As far as I can tell this is only used in
tegra186_adma_global_page_config(), where it's multiplied by 4, and that
should work just fine with a 64-bit variable. But it's also fine to just
cast to whatever ch_page_no is (unsigned int). That's ultimately what
lower_32_bits() ends up doing anyway.

Thierry

--np3j6rj6ep4uje44
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmeiVTAACgkQ3SOs138+
s6H9oRAAmejb7jcFuCXS2M0/90bBDaif6rNzrZoXUcaiiBI2DaKNqh8BGMuwYHpo
uDRDuLShJTji0dgNEkIfX3vlsB9mDIP08GSTGyUbXzWyVD2G6lafkuByBgqKPuZf
CTaKhxUnZaDHNmKoDTRTt1nL7ua5pyxVQ+6JffOFI9Q1MLMIpsiJBPmYmnMPHH5b
8NzVvEq5GklS3nilLcmDT19c/x4oEtnXP74gS+IaxUAoRDpNeE5cacpUKTapnjLZ
MRVbBu/6Xb+nonacEnzh5QkozCf99K1KscJm208cgqoN/cmgyU1/TKcYOB1rdlLm
/yCp3PaIVUjQwI+QTCy+nvF7lJTpOeOSP7Y2YVaKXd3+eOqET2WITgc3nQb87nHd
qDf3XVVMLafKpi8SFV3Lqy/scEn0l74dOEnDq0P1CrCA4ZtIoP6RN8I1rHvEGPR6
dDs+h3OA/voxtSQzT3ygDa3roK4A+YNh3ArY7FVlbByzXPQkBy3fp/SnGmnzkakY
G0PrM2T/BfiYclTwCSMhrhr9z7gOHBQyOrNEt5GHNPBLFS/44Wy3W5kdMLFZ2Iw9
mEHlvnL7BZ8Du3szZZ1Gc0W6cxhPVY9SzGfWBTBqBJck7CBFa5bQMAzfK8fmQmoN
cOlDCQZ++RA8QYuExqXMVfoYNw/JOwWAEX+ljOppcRSoQjhK4v8=
=mtwp
-----END PGP SIGNATURE-----

--np3j6rj6ep4uje44--

