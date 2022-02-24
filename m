Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575654C317E
	for <lists+dmaengine@lfdr.de>; Thu, 24 Feb 2022 17:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiBXQcc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Feb 2022 11:32:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiBXQc3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 24 Feb 2022 11:32:29 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446D21A39D5;
        Thu, 24 Feb 2022 08:31:51 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id j7so4839791lfu.6;
        Thu, 24 Feb 2022 08:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5aE/iHLOxxEvHamBNnvq9wqYb701oZWMJ2F0lcAzezA=;
        b=D2ESp2dlylmeLfUpN8f+mocgrL+BWO0a3HESFV4q9P8Wi2mS2Tpp9y66kobD4eoU7p
         mhCw9GPXo48gIW9KmVHuWyx5QIXBOaff/8i8P/R5lUUAf4dkn51/g5QJDWt4UjTsQ2kb
         u/j9xwP+JYOnsZeCseXIvw2QvmL9xGNK+1fg9hNAg1wqtuQjfHRFOQNHybg3eo2heGtg
         Vzcc6jiZnLBHLvgZ68Ln5vwgtQvvOORmysdgD/seTUr4w0RUVVYCo9sWgweFQTQBBbDi
         NGaXjOnQgAFCVP6GV8m3ajCge/LtffJOaYI1Mtj9+rTrC4jdjpAfavowG9NLDK+JdYm/
         MP0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5aE/iHLOxxEvHamBNnvq9wqYb701oZWMJ2F0lcAzezA=;
        b=Kb9m3axMCrV8Aq6hTDgDJcmQWpNAwnulcqejao4meqWb+4yUc+PcAgEpjjYS353j5x
         R6u2cIwiAuPUPBrXqh/h5kt0kbKY0jyj56mEdnJqrNYlMcdNEoJ0l/MKkapreGUWd3MC
         bICEhKkvQxFRyBz7gZcBK1V8+9863Bb2alrj+cBiUQgipJOggs/oWPncryRAxOI81Tjo
         0SAXPyrWf5+rIUq0UlK0PLrxCehNxN854jak30/195pZgCdwJoXvYWBYHVwrzdDf6qHl
         mUiS9h2MDgMn1c3qZemFD7ojpc8WoOqvvD0NqxMFnafXPISRBcIwSFqADNFCTB+6szzW
         y2Tw==
X-Gm-Message-State: AOAM5309yXz2gJRWTc3b1XXQfLVxkPJinIqsYTFV/daB+P+g971JXoxW
        FK+lXrXWUD/VmNKQFfBQU7s=
X-Google-Smtp-Source: ABdhPJzyfUGIeLzk9sZAZgr9pKY/N3VuKh73uLnB4XFxDC0MGPBTMXEPvemcDesRwXABt3iH9c2gYg==
X-Received: by 2002:ac2:518e:0:b0:442:bb6f:b54b with SMTP id u14-20020ac2518e000000b00442bb6fb54bmr2383877lfi.72.1645720309430;
        Thu, 24 Feb 2022 08:31:49 -0800 (PST)
Received: from orome ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id bf31-20020a2eaa1f000000b0024637000209sm9065ljb.10.2022.02.24.08.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 08:31:48 -0800 (PST)
Date:   Thu, 24 Feb 2022 17:31:45 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Akhil R <akhilrajeev@nvidia.com>
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        jonathanh@nvidia.com, kyarlagadda@nvidia.com, ldewangan@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        p.zabel@pengutronix.de, rgumasta@nvidia.com, robh+dt@kernel.org,
        nathan@kernel.org, vkoul@kernel.org,
        Pavan Kunapuli <pkunapuli@nvidia.com>
Subject: Re: [PATCH v21 2/2] dmaengine: tegra: Add tegra gpcdma driver
Message-ID: <Yhey8ZVhMq398lVh@orome>
References: <20220224123903.5020-1-akhilrajeev@nvidia.com>
 <20220224123903.5020-3-akhilrajeev@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="L+K3fn9+MFCiXEpi"
Content-Disposition: inline
In-Reply-To: <20220224123903.5020-3-akhilrajeev@nvidia.com>
User-Agent: Mutt/2.2.1 (c8109e14) (2022-02-19)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--L+K3fn9+MFCiXEpi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 24, 2022 at 06:09:03PM +0530, Akhil R wrote:
> Adding GPC DMA controller driver for Tegra. The driver supports dma
> transfers between memory to memory, IO peripheral to memory and
> memory to IO peripheral.
>=20
> Co-developed-by: Pavan Kunapuli <pkunapuli@nvidia.com>
> Signed-off-by: Pavan Kunapuli <pkunapuli@nvidia.com>
> Co-developed-by: Rajesh Gumasta <rgumasta@nvidia.com>
> Signed-off-by: Rajesh Gumasta <rgumasta@nvidia.com>
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/dma/Kconfig            |   11 +
>  drivers/dma/Makefile           |    1 +
>  drivers/dma/tegra186-gpc-dma.c | 1507 ++++++++++++++++++++++++++++++++
>  3 files changed, 1519 insertions(+)
>  create mode 100644 drivers/dma/tegra186-gpc-dma.c

Acked-by: Thierry Reding <treding@nvidia.com>

--L+K3fn9+MFCiXEpi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmIXsu8ACgkQ3SOs138+
s6E/UxAAqMZS6fydwRuQ8aFCl3ss11O+kmXVQ9V3IGYvPhJyUwOAjJxGHFxD/1VW
vOFNeiP5rjRvrbHdR+U2qvXaFTCtBEOkb0Ql5QNdM6tUMEoJFbPeU/5xnSd6n8gf
JI6L7Wz1IJQgoUgw2DQDjhv7C08jdNeEY8KgzAMPiI5hsZfvS5VO55tA6O+uMA89
e2Z2Zq0khy8/beUO3bJsT6jlnxoXMR7/Ce9pGnbgDbZwe8cWFGhAV5ecWI5rO50v
gLxroMXd4gMlYfvj+DDk+bZi5Hel3pYU8agyqoDWggC975BTIZalLHeOOVy0fGuh
eGhs7HlUQfEx/Y+b4qHHMOcosGS0+o42cFfrtg+lOWZvTcfWMTyVf3itpgPLirqT
izETzgp4h0j2/+hYjlIi8UdoYT7yx2xroQECffzcmfRsdUUxazSjpJ8x98dMOOwY
jh9Tuht+XRm9an/GgjEEcZkzbhD22yV5mo65mLRchmtpfwTXvWREcsf8c2R1beTe
j7UNNxbuOnV3tEyiVsk7bw/md67r241u5o7cYov/ceq8d5cGdRRJjl1qX4ds4bJU
E2ddA4NRQ6n1jRFrU3h7joCqldLit+K/B4X1XrUOzrzDpO/PCXMMZe14cyQFh6rL
y9pKH1tV7TYZzlqyWz0zg8qRIpiajGvNDIOD9Twvkpt4PsPnuVw=
=kGd9
-----END PGP SIGNATURE-----

--L+K3fn9+MFCiXEpi--
