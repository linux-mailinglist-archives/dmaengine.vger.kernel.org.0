Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E810B46F149
	for <lists+dmaengine@lfdr.de>; Thu,  9 Dec 2021 18:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239471AbhLIROe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 9 Dec 2021 12:14:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239053AbhLIROa (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 9 Dec 2021 12:14:30 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C73C0617A1;
        Thu,  9 Dec 2021 09:10:56 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id i12so4757503wmq.4;
        Thu, 09 Dec 2021 09:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Eey3ZpemVIQey3aUEzHauqKMAedPhaSMvKYTLO4vJR4=;
        b=Qr3xahMG7jgbSv1CijjihRMn2tiI3uX2hR/Gkaf/95cs09uLEwDwKhlBxwc6pVw1vh
         4CRnzMxg878ulkS/uKwKFyds2J0OIOmS45QKqBFNhii84FJO5Fpx/ZhV+/G0a5RBpukV
         pKeQD5arDVdJaCNyZ1LegrU9/sxVSzi1B2R1sLN+yDSlEiCHt+RsmFah+W9J2utelPj3
         d3SrFVfAR4moqxHbJNlwGIve7w/XnP6/ELecyY5YS7wKd38IV+KCvGPZJgPjOJH5Ar6L
         Tz4+FmbMFpajSuO9eCUcMpsCfb+rL/u/WquNC7DRyB2leWQRL6kv8l68Cj3HQsjuECZV
         OHDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Eey3ZpemVIQey3aUEzHauqKMAedPhaSMvKYTLO4vJR4=;
        b=I8R7OeACJxezrmy38mq5p/drxF/coaOCno2YMqNGb0/N7wknstZ0v3/HUZbVUwHvuB
         Zv+Sdu3huCQyi7gPsr5BtEZLvdh634ix9AutrFbADZsym5ylptJnOhBxDgNleBUJcDSN
         heMijvHzh9s4nCpD9bM1Cmw+cUK1pbjQZK+QTkndPUOW2jpL/RZeux6/BTP2KylaweYQ
         hoImmaQGdPw0baqwj/wD/OxQHo5T0HH7QcDz7Mvr4TnXs+xWdQPlu/tl5zbQ9Lzpegrb
         ZYyz2I3P9AtbmuU6S0TVrzaRQdaHqxcJL/usKdmPmimIFjWb30ULmffQQarh1v7acNoy
         68HQ==
X-Gm-Message-State: AOAM532wDGAvdWYm7pedd31txIQxH9fVJDuFNkZVQDnzWN2Q9JTll6ho
        HE1sLAJ8MkocWnhu4SoYRMQ=
X-Google-Smtp-Source: ABdhPJxHfxQx2i1K4jKrLcQ+S1rdfCLHuZD0YQJBWS/cYW5VUOZTrDT446KMNTbFtpsPPGA6oOJLBA==
X-Received: by 2002:a05:600c:1d01:: with SMTP id l1mr9141930wms.44.1639069854820;
        Thu, 09 Dec 2021 09:10:54 -0800 (PST)
Received: from orome ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id z8sm275504wrh.54.2021.12.09.09.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 09:10:53 -0800 (PST)
Date:   Thu, 9 Dec 2021 18:10:50 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Akhil R <akhilrajeev@nvidia.com>
Cc:     dan.j.williams@intel.com, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org, jonathanh@nvidia.com,
        kyarlagadda@nvidia.com, ldewangan@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        p.zabel@pengutronix.de, rgumasta@nvidia.com, robh+dt@kernel.org,
        vkoul@kernel.org, Pavan Kunapuli <pkunapuli@nvidia.com>
Subject: Re: [PATCH v14 2/4] dmaengine: tegra: Add tegra gpcdma driver
Message-ID: <YbI4mtV3npK87c26@orome>
References: <1638795639-3681-1-git-send-email-akhilrajeev@nvidia.com>
 <1638795639-3681-3-git-send-email-akhilrajeev@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7mqnZnHDnajOmsOv"
Content-Disposition: inline
In-Reply-To: <1638795639-3681-3-git-send-email-akhilrajeev@nvidia.com>
User-Agent: Mutt/2.1.3 (987dde4c) (2021-09-10)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--7mqnZnHDnajOmsOv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 06, 2021 at 06:30:37PM +0530, Akhil R wrote:
> Adding GPC DMA controller driver for Tegra186 and Tegra194. The driver
> supports dma transfers between memory to memory, IO peripheral to memory
> and memory to IO peripheral.
>=20
> Signed-off-by: Pavan Kunapuli <pkunapuli@nvidia.com>
> Signed-off-by: Rajesh Gumasta <rgumasta@nvidia.com>
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  drivers/dma/Kconfig            |   12 +
>  drivers/dma/Makefile           |    1 +
>  drivers/dma/tegra186-gpc-dma.c | 1284 ++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 1297 insertions(+)
>  create mode 100644 drivers/dma/tegra186-gpc-dma.c
>=20
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index 80c2c03..35095ae 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -629,6 +629,18 @@ config TXX9_DMAC
>  	  Support the TXx9 SoC internal DMA controller.  This can be
>  	  integrated in chips such as the Toshiba TX4927/38/39.
> =20
> +config TEGRA186_GPC_DMA
> +	tristate "NVIDIA Tegra GPC DMA support"
> +	depends on ARCH_TEGRA_186_SOC || ARCH_TEGRA_194_SOC || COMPILE_TEST

I wonder if we want to maybe make this depend on ARCH_TEGRA instead to
avoid having to add dependencies on newer SoCs (presumably Tegra234 will
feature this GPC DMA as well).

Not worth a respin, but perhaps something to consider when adding
Tegra234 support.

Thierry

--7mqnZnHDnajOmsOv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmGyOJoACgkQ3SOs138+
s6FQLw//YQbWddZFUUepCv0b7YpjZTW7Vbd3JWuPDsETBN2QinnTKblQ/sAwEPcd
Szvbiym/rYEjolSaVq0LMnE8N6Yt4UYGNpPpZYygbfzQGXZDMLwWkSv5u9SYGxbC
89erpmqFUUEFmJWqtW9AnsiUCacYyOuLbNJHbjPQnP5ogpOu/AHCcD5iKn9guF+4
cpYDuo6+8Ywwt4E5fa8WjgoKSoDWeGbGdhF8Ysac6b6ImI+6MFbZUJUDSxvfn9wa
IVH5zl5eB01o0AD7DPtTRaKGKIIukylqg2UxYKROdMUWLP3L0YdgPF8ekNI8oz4J
bcsSdYt0Sw2kcYzVVOqQrF3cFdYvf18XrO+UOUQA0r2B/hyopqsBKXQ9+5HOToj9
ynQBSNcvj72AGc87pnjYmZPD63UO4kw1Zz7O77WVQClpIj/KKCFKRMLUSyk2QteI
XHPiLLFBFkyueptQpeaAWXZCNbnE4b2BYk/DuMjfdyB7awww82GnMDD1Lj/pjguZ
0JntM8RHgCSRSTx6rmEHnWrcmHvX0vmUseAVjTaK03rH5AqIRMmEJuaaypvseYqV
pHHKnSs2obuHaQ0UVl95LFvjJaNhWISwdvteLhjvEOWqQd5zNClWHVA427MOwF74
tGtvLslwUzPBjbtPps5ebvJwiURyfrAP9J+3ntTV83JEw3qgweU=
=za4a
-----END PGP SIGNATURE-----

--7mqnZnHDnajOmsOv--
