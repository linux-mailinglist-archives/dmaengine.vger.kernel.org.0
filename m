Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DABE418D27E
	for <lists+dmaengine@lfdr.de>; Fri, 20 Mar 2020 16:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbgCTPLP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 20 Mar 2020 11:11:15 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40310 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727406AbgCTPLO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 20 Mar 2020 11:11:14 -0400
Received: by mail-wr1-f67.google.com with SMTP id f3so7902733wrw.7;
        Fri, 20 Mar 2020 08:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GEeQsGMUIbDWdrJ0PurnRyyG/X4DzrMw+Jy+G5v05Lk=;
        b=DrM6Uvrr4yG2ojFhmZP+K3Hwb7ld2ajUhZKogPVBaIxr1nPKp2IkynDKICIqDbG2T4
         aquRC+io0h+6Qi4+nGjRn+LiuGletmcyG47b9eAX+xDvUbh6ZnUQqTV6wmuZh1l9BCdJ
         FjF/vp9FZw0TZga72t9K4ZEEOeRfStbAPfo7ZpodlFw/6+aGcqP0juK1Aot6WOLDPx1w
         YxJ47xgPEbgxuYNs19KM6zRNqjN5Ju3Olp/n/t8dVAtmEQyHZkg0+so5m20ak0ZERAVO
         RwI45sduuSx6NsxCweMhSjIE2yBH3ztPAPxvkebvVYWKAHbee4hEqLfmuEBOWHVcBRWh
         7+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GEeQsGMUIbDWdrJ0PurnRyyG/X4DzrMw+Jy+G5v05Lk=;
        b=ob6mOioIRY2b44pIN/rOR57eQ8Z5G4JUIcMShrwurVb40TZICghLBrWLT8IaWha/qi
         RuzgZKDOO2idGgdBn0xxe7HwnusOGnzLvcHsAVkBTyz39hsYkupVyhB68kro8e1z+zCg
         ngBvJidWsDTofTSdkuV1ST0MKXpdPvtobKWh0dQm2/YIHPCzNso0ymeN6SEUDfQIJrQC
         TYV8fVV5cSua2IOuB3tSWLma43U613Pvot9eGM+OqK7f+UT0SgRn4V0Pzs8sTReDHzdQ
         ozA+uGhqpJ6P46WCQeYpzaRCSdPE43tEuMmW8AoAplO05SYKQf77nM/qqW3zC7SjOa3T
         VV9A==
X-Gm-Message-State: ANhLgQ3eP6GanqZFWRvEY7QmLLksLuJ06AbVU2Myr15aXk666gtZVTFp
        J35NCGi6dZK3eKXKrT3sR7I=
X-Google-Smtp-Source: ADFU+vtmZap7B9ypiCw/Z1DhSQsc7/xrxoSlR9TI7USdDaDETP9o8L73Kco0hBRg4cLgZ82X+AUZPg==
X-Received: by 2002:adf:d0c2:: with SMTP id z2mr11428476wrh.223.1584717072042;
        Fri, 20 Mar 2020 08:11:12 -0700 (PDT)
Received: from localhost (pD9E51CDC.dip0.t-ipconnect.de. [217.229.28.220])
        by smtp.gmail.com with ESMTPSA id b67sm8131576wmh.29.2020.03.20.08.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 08:11:11 -0700 (PDT)
Date:   Fri, 20 Mar 2020 16:11:10 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     ldewangan@nvidia.com, jonathanh@nvidia.com,
        dan.j.williams@intel.com, vkoul@kernel.org, swarren@wwwdotorg.org,
        dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, digetx@gmail.com
Subject: Re: [PATCH -next] dmaengine: tegra-apb: mark PM functions as
 __maybe_unused
Message-ID: <20200320151110.GC3706404@ulmo>
References: <20200320071337.59756-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="c3bfwLpm8qysLVxt"
Content-Disposition: inline
In-Reply-To: <20200320071337.59756-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--c3bfwLpm8qysLVxt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2020 at 03:13:37PM +0800, YueHaibing wrote:
> When CONFIG_PM is disabled, gcc warning this:
>=20
> drivers/dma/tegra20-apb-dma.c:1587:12: warning: 'tegra_dma_runtime_resume=
' defined but not used [-Wunused-function]
> drivers/dma/tegra20-apb-dma.c:1578:12: warning: 'tegra_dma_runtime_suspen=
d' defined but not used [-Wunused-function]
>=20
> Make it as __maybe_unused to fix the warnings,
> also remove unneeded function declarations.
>=20
> Fixes: ec8a1586780c ("dma: tegra: add dmaengine based dma driver")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/dma/tegra20-apb-dma.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--c3bfwLpm8qysLVxt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl503Q4ACgkQ3SOs138+
s6G5HA//VBGymZPSAr4/KCkQAWaeqfla9+xr0XFMeT78df0ogJwPDwCa9r+AHPDj
ZplxW9b0SuqpA1+KyQRFqR5MAq3epvDgPKx6gRPxMHbWENnoPg2NrrR79gwHlPUM
D9glmHmhV+JtQ3TWyRqpEGaJwoWe9kCHze7IkIPR4EIV2zIKcYf4Cj3z+brGcu4E
wIEQkLRpvbvsIJ9wv2w2M6/lX0E0qVjCJEhox2kkwucw+DWeC5vzCtBWCp1cF+dc
0t+i5ZxmcNHSw48UItWlaT3jrF6JYyhgvy91XPTwyb+svKbSBR89c5hUObIJ6T3m
tiau23ebzYHgrBodc26Xt/R+APpQQbMriN2AGk9IR4q8UAuC4CntzjQ7ZZa60uA9
IGhNEgTXp99BmXjsKQLoYH9q50xZfmRYQwh42SjFnPpRUGC6o/5/1Uq0KuqC3qBC
6ezFx9qU5WluQqyy3JG1tfyPKBTU2185+eIrvMXFXo/SAUMfWzq8get22A7TY7PT
ZepRAFZ0m2K4zS3Ke4/Aiw3c4OwrSACEMneHl3pctRjN3BnOFTla2EbjlbBxsvs8
WELgeyQhlnwnxb08t3df90L2tlODllK+D+OTEZXwq6A75nYgKsAL2uLZECgO1k+L
GiqR3BstSazfR7ViZi41+GVMBhtqRPYnnu2H1iEizVa69o7WruU=
=Dnsf
-----END PGP SIGNATURE-----

--c3bfwLpm8qysLVxt--
