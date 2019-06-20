Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D94E4C9B0
	for <lists+dmaengine@lfdr.de>; Thu, 20 Jun 2019 10:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725925AbfFTIrS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 20 Jun 2019 04:47:18 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38082 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfFTIrS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 20 Jun 2019 04:47:18 -0400
Received: by mail-wm1-f65.google.com with SMTP id s15so2243582wmj.3;
        Thu, 20 Jun 2019 01:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5GCO7ZYT99Ki0xYemo3RK6CqmnGlA3SPqu9SbbMTgRw=;
        b=P8UG6MFbkhkh5xnDC+Ul1XG0D8BKw5yVSO9gsFv1JDfEpJMcgtbDig6UrF1b9tgD9r
         2n/BvJeD3d0WT4tuE6zFc+CoSTVjNeHfIhdnVy6E+u8dTChJeGVSOl1cuEqvnSaSxBxg
         2ONnhNPGFczZ+PUarDxcQZOEEq9egFmGwFFTZN3ofWBheFKfWrDM1+pVP3jjxryS9xKD
         dtrI0YBJEH5mdwtPQjkieMbrYBcQMR0bGkeWDPc6WDT13UMtbLhU1I5gQiV28SCX9yOW
         9P1uk5ts7ohVSQ7yeFndxL3bG2OsuI00R2AtQT7cacv7+3sBhvUJZes428wXseb7ccsD
         LSaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5GCO7ZYT99Ki0xYemo3RK6CqmnGlA3SPqu9SbbMTgRw=;
        b=oJe/yLL+Qbl2WdVc+uP58ToHSLezqTYbZ7vIaLMrA1q3HjOPvBJl/OdONDkt+Rat2D
         m2l0pL3qBJJYFfJXoM+NzFpPNzsnE2TPX7Kxp0bvq5mwvLGrlttHjb/Tp1L+7PdQZi1z
         wNSeq/QY/dZX3UBFXMHLq4mMpSZrktUtfQIA+FZAYqtlD0VM3b0+hoetJHpOf4qMx5ZS
         orBDfBzeb7Sx0r77MQLaBqfXtK3SVlD//3mYsON5EBksLiY7zbk7ZJQcGXhNFwayDtZl
         K3ViV1Wt2QIiSum7lncD7CQkNNp5+bWbOEgWptuLd69TRT1uBrlTiJfmZd6ftigO10Ho
         sFqg==
X-Gm-Message-State: APjAAAW1a1crHXL/iqyF3Wj8w/271H72PVOXrUo6kQd4sm6AO6puax7u
        kzuKx14w711DRT+5CK5wtjiROVTd9nQ=
X-Google-Smtp-Source: APXvYqzxxE2sWgW5TbpKSVdzCsEc3j3wGfepWqXrrWfTSjvPS6O57iuuAtzSDZC1pjX4/YhKNoNoPg==
X-Received: by 2002:a1c:4041:: with SMTP id n62mr1875231wma.100.1561020435315;
        Thu, 20 Jun 2019 01:47:15 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id y6sm4534133wmd.16.2019.06.20.01.47.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 01:47:14 -0700 (PDT)
Date:   Thu, 20 Jun 2019 10:47:13 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-tegra@vger.kernel.org, Sameer Pujar <spujar@nvidia.com>
Subject: Re: [PATCH] dmaengine: tegra210-adma: Don't program FIFO threshold
Message-ID: <20190620084713.GA26689@ulmo>
References: <20190620075424.14795-1-jonathanh@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
In-Reply-To: <20190620075424.14795-1-jonathanh@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2019 at 08:54:24AM +0100, Jon Hunter wrote:
> From: Jonathan Hunter <jonathanh@nvidia.com>
>=20
> The Tegra210 ADMA supports two modes for transferring data to a FIFO
> which are ...
>=20
> 1. Transfer data to/from the FIFO as soon as a single burst can be
>    transferred.
> 2. Transfer data to/from the FIFO based upon FIFO thresholds, where
>    the FIFO threshold is specified in terms on multiple bursts.
>=20
> Currently, the ADMA driver programs the FIFO threshold values in the
> FIFO_CTRL register, but never enables the transfer mode that uses
> these threshold values. Given that these have never been used so far,
> simplify the ADMA driver by removing the programming of these threshold
> values.
>=20
> Signed-off-by: Jonathan Hunter <jonathanh@nvidia.com>
> ---
>  drivers/dma/tegra210-adma.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl0LSAwACgkQ3SOs138+
s6FiOhAAu0+Kphi5/85mxAbW9vW4ealuleXGpCh6n/u6+yEX23t2UBjioPLCsr8F
wfq+mVEfaM3mr7Ew7T6Gq9T0CdNTGvj1Ou/9vUMbHYpgaOgA7ut6jVywG6YP13Jd
vmjmBmxiFRn2Cs0jFTIwyTOyBMZv5fccj1xQnMd6t8H5L8b3qkAvFwL0vxyjIdDe
L3ZMRbcEwfF58pHzW6YuiLCuBGJbfUTmwaoDQ5lQ6wYJ3QoJCjWeEGHm8olOB6wB
8HeFyL6So6wNw+XL4qZKYa4DsLqCZa8B5vK+HueJPKyD6LPBLFEimv17/AN5HB0R
fsFNumbmESGJD9+mJdMRjed3UeDAA/BXOIJz1DYTzOmTAR9jwUu0qQX8MRBHwpMS
fFf2COh2/Eaf2Sek8jaRk6RYX9SloCI1dUdN2HBc6KDRKGmNx/oHWuVLfXYMaeeY
STw9qtnWf2VeOEl7GLlzfIhjtoyWuqQbISom0mV6ok8a64QOTyxwVGe4JBIZdzz6
S3+2koUNvyeU2EjylFsloY2SH6Eu4Gnlv0eoAj+cAukQRYEPsVyNE7tZbsJXcjll
PUEeLc44bXdLqUBsr7QunwTLa1dpVFiWfluXQlWpxdPmTV0ozL6fwPs+WO88dvbm
EKGrvcYmYORUbvHCb5tiK0SsTcYrJQVtRXwNv+KqZGHGQxbrj4g=
=ukxb
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
