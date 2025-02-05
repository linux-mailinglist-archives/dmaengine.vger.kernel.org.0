Return-Path: <dmaengine+bounces-4294-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C234A28B92
	for <lists+dmaengine@lfdr.de>; Wed,  5 Feb 2025 14:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 707BB3A7BB4
	for <lists+dmaengine@lfdr.de>; Wed,  5 Feb 2025 13:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DEAF524B0;
	Wed,  5 Feb 2025 13:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PuE4WyMF"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D9CA32;
	Wed,  5 Feb 2025 13:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738761891; cv=none; b=LFLQWcedKNzhyeuRVI1X77+McA/Ym5B9g/ijy5pcRTDioduL4mooIQUnXcgOUuR3bjG+Qq1TFkMTEuwK6AMS3ut34a4xzxjaKoNxougmXbCOs8ix6KtSWItpA/ixWFZRF9R5uGz+xYqCW/xFqvtlheoW0EUI8f1pqPskYS3dQrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738761891; c=relaxed/simple;
	bh=TX/A53CNvVEEz12A1wt77Ja/e/ygM3vQpad3o2RmNpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IG6cWpRhHRUmf2xumyo0xcOWjCRwN3BP+hiyyIs3ZaODtM7QDr6QsIopljqGtPPjW+83kforHIxQH5zUDOE6Lcb3g/H3ZImw1tlrc/6S45GRbMCXRtOFLOU++VS6RKexZ2IB/pIsdA0BHGiNd+s/pJtT97bPuunOa6/SiCsD4sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PuE4WyMF; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4361dc6322fso47086835e9.3;
        Wed, 05 Feb 2025 05:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738761888; x=1739366688; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TX/A53CNvVEEz12A1wt77Ja/e/ygM3vQpad3o2RmNpI=;
        b=PuE4WyMFXxdN6ea0XKCiA0DXfQo+vCdQlmDXIk0xRWPS2ayXZOKtmJyBE9hjmkvRMn
         GLWZ71K77laQ6E9c/fm/Wjk+hnE6YA9EH/hNXvG28e3SAf/v3qpVRKf6HY0o2y//a6NL
         ndujtugwRzBc+svYdBY2UpYkh8eWLlUXxG8eFUCJqvGCqFgh7e80Wjdo0+Q4gDc2lre6
         p6zXQ19t6cledcMZ05hCBtIpkYmL725MKlMMAtmvulaevLfbYVT1UXkWo59nnrQhvyxZ
         tY704XMIYbKzsGd8+k6jphO6aqzLxdHjxIK7EwI5xyCT3sJxJU17rsn8Hstz8HgM9yLi
         xuXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738761888; x=1739366688;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TX/A53CNvVEEz12A1wt77Ja/e/ygM3vQpad3o2RmNpI=;
        b=lJy2cbDd+kronm/b45CMdw4n6uXQSQ+sqHCycCb+DZyd+b3MgbKD/wMDx+aYGXQJEx
         Sh67OFagBVzHHuJjduaiPznFOabZDArrdL9I3mh/vCXHMUmZD946Fq8cJytk0SgzwwI8
         0MtnsgwCpLlymJpef1h2/ZsgpwtohdG4MDkd4pXv5XC/P7EDw0hZuW03wn7T5jaFELfs
         8z1hK2i+1VFTYAa56Aox/kEoJorPq4h4ZeIJjPY8EzXxTAvIygzeV4Z0trgFTeQLB6qI
         fAILCIlLczDPz6pHkJssa+aSCmgo7sy7hRdjpZBB2o8090tFFIpFwHi3Es0rlq6w0EyL
         QTzQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9tHO5jbhn0pbtL+uZ3EGnuE9yizncz7oEFZZZGx9L5JWeYriFlc5y/G1heyW5zFur+VpwjrcVKTQXK2E=@vger.kernel.org, AJvYcCWKbMsYHaln6d2lE2bsHC1DsKmaRCbThnNQrHvBcEd8pUBcwL4CvPPnhc1Eu7GC6ttTUy8AWsdSE+U=@vger.kernel.org, AJvYcCXVUoYieXMt5SfrIDOFLfg2sqkxX8n9mGrv0J41hFYTLeDKC4MBvXJeYzTgUtQULMlxQCm9nRI8aLVLsBcH@vger.kernel.org, AJvYcCXeqlqugdccSH7vHcDeH0rNIBjx8CTyd9SUpNZ/4kTxK7CdIoU57a0VkgJwNNNAo98j4p1KMuHc@vger.kernel.org
X-Gm-Message-State: AOJu0YzAJ2muwwTo8aPr0G/Evcau+C4j8VIwEKL8lc1KK2iCx8RX4fXf
	pj8n7J16hjSeg7TmO0vPBVC1V4BMKssk62qXtUe9exREsytn1M1DTw75UQ==
X-Gm-Gg: ASbGncuTN6BU4mhhTpZRt9tdrTMZMl0RnF++mI5eklwDNh7DlUPw5E6cRh7cOloOdWO
	7agEy+yrtVETJTfYTcM1xnqAvOu9J/rbiFHgffwvhrJIZWTPF6Aa2vtUm1k9Hf04e4Hn9ICAWTY
	o8oGxjUBlpX9leT9kQP+sMxkT0b9OEBJ7SlG7sIOK3T+JiQ3+MHLbQw8P7B3XyblyQheFwn+Sd4
	bQJHAWhG5bGBj/4lKwk0of8s8o2DKQDIxhOSadu/Y61i6y/cODS9jHV1G/+N+myOnxugWZAR3PQ
	RL/+6fssCaDKk5Km3re9uf8SJLUwHCJPBi2WGc6ZwG7K5sPN8xDybJt72Hy0FgGqElRkurmFfo0
	cHg==
X-Google-Smtp-Source: AGHT+IFE82jVXBvkVak4VyOzTmP0lzrPtT/dQwy0SQVRpv51Tz5Fz0ClKsU8KgQVLVdGyXghGlxlSQ==
X-Received: by 2002:a05:600c:b8c:b0:436:1c04:aa8e with SMTP id 5b1f17b1804b1-4390d43e91dmr26364155e9.16.1738761887504;
        Wed, 05 Feb 2025 05:24:47 -0800 (PST)
Received: from orome (p200300e41f281900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f28:1900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4390daf4592sm20809545e9.32.2025.02.05.05.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 05:24:46 -0800 (PST)
Date: Wed, 5 Feb 2025 14:24:44 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Mohan Kumar D <mkumard@nvidia.com>
Cc: Jon Hunter <jonathanh@nvidia.com>, vkoul@kernel.org, 
	dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v4 2/2] dmaengine: tegra210-adma: check for adma max page
Message-ID: <ou25ulmzei773cztbc6cj3na6xq646hpuj4l77nct5mscd5c3y@7e4tqnovx6gw>
References: <20250205033131.3920801-1-mkumard@nvidia.com>
 <20250205033131.3920801-3-mkumard@nvidia.com>
 <61a3c7e9-f3cb-4bc2-a10b-5e44fa2cdedf@nvidia.com>
 <84c4c672-fc17-4f75-b3ce-388b987d32ab@nvidia.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="y3w37waetnr7wa7m"
Content-Disposition: inline
In-Reply-To: <84c4c672-fc17-4f75-b3ce-388b987d32ab@nvidia.com>


--y3w37waetnr7wa7m
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 2/2] dmaengine: tegra210-adma: check for adma max page
MIME-Version: 1.0

On Wed, Feb 05, 2025 at 06:28:34PM +0530, Mohan Kumar D wrote:
>=20
> On 05-02-2025 17:10, Jon Hunter wrote:
> >=20
> >=20
> > On 05/02/2025 03:31, Mohan Kumar D wrote:
> > > Have additional check for max channel page during the probe
> > > to cover if any offset overshoot happens due to wrong DT
> > > configuration.
> > >=20
> > > Fixes: 68811c928f88 ("dmaengine: tegra210-adma: Support channel page")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Mohan Kumar D <mkumard@nvidia.com>
> > > ---
> > > =C2=A0 drivers/dma/tegra210-adma.c | 7 ++++++-
> > > =C2=A0 1 file changed, 6 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
> > > index a0bd4822ed80..801740ad8e0d 100644
> > > --- a/drivers/dma/tegra210-adma.c
> > > +++ b/drivers/dma/tegra210-adma.c
> > > @@ -83,7 +83,9 @@ struct tegra_adma;
> > > =C2=A0=C2=A0 * @nr_channels: Number of DMA channels available.
> > > =C2=A0=C2=A0 * @ch_fifo_size_mask: Mask for FIFO size field.
> > > =C2=A0=C2=A0 * @sreq_index_offset: Slave channel index offset.
> > > + * @max_page: Maximum ADMA Channel Page.
> > > =C2=A0=C2=A0 * @has_outstanding_reqs: If DMA channel can have outstan=
ding
> > > requests.
> > > + * @set_global_pg_config: Global page programming.
> > > =C2=A0=C2=A0 */
> > > =C2=A0 struct tegra_adma_chip_data {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int (*adma_get_burst_config)(=
unsigned int burst_size);
> > > @@ -99,6 +101,7 @@ struct tegra_adma_chip_data {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int nr_channels;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int ch_fifo_size_mask;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int sreq_index_offset;
> > > +=C2=A0=C2=A0=C2=A0 unsigned int max_page;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool has_outstanding_reqs;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void (*set_global_pg_config)(struct te=
gra_adma *tdma);
> > > =C2=A0 };
> > > @@ -854,6 +857,7 @@ static const struct tegra_adma_chip_data
> > > tegra210_chip_data =3D {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .nr_channels=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 =3D 22,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .ch_fifo_size_mask=C2=A0=C2=A0=C2=A0 =
=3D 0xf,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .sreq_index_offset=C2=A0=C2=A0=C2=A0 =
=3D 2,
> > > +=C2=A0=C2=A0=C2=A0 .max_page=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 =3D 0,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .has_outstanding_reqs=C2=A0=C2=A0=C2=
=A0 =3D false,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .set_global_pg_config=C2=A0=C2=A0=C2=
=A0 =3D NULL,
> > > =C2=A0 };
> > > @@ -871,6 +875,7 @@ static const struct tegra_adma_chip_data
> > > tegra186_chip_data =3D {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .nr_channels=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 =3D 32,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .ch_fifo_size_mask=C2=A0=C2=A0=C2=A0 =
=3D 0x1f,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .sreq_index_offset=C2=A0=C2=A0=C2=A0 =
=3D 4,
> > > +=C2=A0=C2=A0=C2=A0 .max_page=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 =3D 4,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .has_outstanding_reqs=C2=A0=C2=A0=C2=
=A0 =3D true,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .set_global_pg_config=C2=A0=C2=A0=C2=
=A0 =3D tegra186_adma_global_page_config,
> > > =C2=A0 };
> > > @@ -921,7 +926,7 @@ static int tegra_adma_probe(struct
> > > platform_device *pdev)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 page_offset =3D res_page->start - res_base->start;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 page_no =3D div_u64(page_offset, cdata->ch_base_offset);
> > > =C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if (WARN_ON(page_no =3D=3D 0))
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i=
f (WARN_ON(page_no =3D=3D 0 || page_no > cdata->max_page))
> >=20
> > So no one should ever specify the 'page' region for Tegra210, correct?
> > If they did then this would always fail. I don't know if it is also
> > worth checking if someone has a 'page' region for a device that has
> > max_page =3D=3D 0?
> Yes, DT binding specifies "page" should not be used for Tegra210 and above
> conditions takes care. I believe above condition should suffice.

Yes, if you get this wrong, the DT validation should already catch it.
We could always make it very clear by adding an explicit check and a
corresponding error message, but I'm not sure it's really worth it in
this case. If we do, then maybe we should add error messages to these
other cases as well.

Thierry

--y3w37waetnr7wa7m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmejZpwACgkQ3SOs138+
s6E+ig//fu1ELazoLZIM8eDT1Pyt/YDyXb9HAr4pPljpP8jK0F9XRFg+FLbhU8iH
+rCXnfG9rehTMmvK+fmU9Xvr5wKV61rfBHxPqXBGrtXfSgV432cZDQlZdsaOvh/6
cgv2d4HS4iuZiO0uc2FHf/Xz0AbQRJvuGUz5jAAPqkR8795U9RU3wYUxeB8Cfdeh
PWqQhTU3HZ23FGr2I0JrYgIPTe0c35RshPla4+DVtLzhkrw/jNfdAUL8+iaqaPhP
NB/DCl+Wj8d7rMFRyTukPhlp76ZJzYq6QYkBt5jYoDWIWBhN1WnkzQxq/T0oqEjw
55nG2Ol1WMuB/6uNTOy+TTLe92g61UKJgv1eAIFfA1FX9lcHyeqaDoDjkOnlRiMs
BlDzTX5WKOORRi+kHhwPxg+8qwKM6AuwtfKRR8JET4Dasb2p3wVbUKxdI3JE93bp
jlf3+PToOxbOTyTTmPhFxASu473I6QECEMCwf11IMOxKG/CxYD+rcSNKJ6qyZEFp
mqs52IzYyBDwdqolHfEGyiiaY/6HJGNXJSEfgVln9zdOh5pP/zN0QdneklYmClAW
0iTUMB+snmq+qLEPY7OjfoMyHgCGb9DRJboD0muIKdiIO3Ds+bHfvRRK/Bc3Olrc
Hojz8Vjakx+OSMOZsU3DX1jupsX0ObWWU1kQnJjfDRgrQYPJ1+Q=
=naHb
-----END PGP SIGNATURE-----

--y3w37waetnr7wa7m--

