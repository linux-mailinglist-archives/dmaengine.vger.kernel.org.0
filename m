Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B604C3175
	for <lists+dmaengine@lfdr.de>; Thu, 24 Feb 2022 17:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiBXQc6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Feb 2022 11:32:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbiBXQcv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 24 Feb 2022 11:32:51 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211761E6974;
        Thu, 24 Feb 2022 08:32:11 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id r20so3715145ljj.1;
        Thu, 24 Feb 2022 08:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QxdeQ03DOR4RUC1RUGZAh5JLbtSCzS9nhA1X4N35/bw=;
        b=KmC0LCs2Vxk9FBRyReMaUV3AKq9Rlbiqsam70nDmlZsqjW1y7j6LXnK9gFFcTDJlFa
         Ks+Sr2Qffjmvoj18qUVEiFXgRAUE3kcgo1wFqtq4+HHKHzRDwrnm680F3AwJ7gV3JLDq
         DN+3exlceOtVKKWiOj8ZZ0Vq7EuMw9+xyHqEXtfc/DKOJfn7/EAgqUCgNJLpMwV0IdlE
         ApRg6eggZSPjPreGaEWY+U0axCKkz54UeUK7/+pTM+D28ifoAmrMau29U+NEy6EunAGy
         9An76HikDYT9bTtymPfBDV8uQbGmVZ9LSkTqDhjZVMb7j6zia2jUv96pNZEgW+QG5gf5
         X+og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QxdeQ03DOR4RUC1RUGZAh5JLbtSCzS9nhA1X4N35/bw=;
        b=jCnGIMl9lVn1iTPVuwuuodwlT2nOM5OKAtni4bvEW6m553GeHCgVx1IL3+cF0IO75X
         4duF0xibGDyBMuYzy04M9LL12V98xiXk07AgA6Zfg8EnmJwYkhHyk6+MFx65tYbn6eQX
         HnfGdk5uw+KnPwyoErYLJEvX2G3X24t63llQnfbXP8w+/li6Tj1dCGxRtd92BNID/ctC
         13kD5V0E6u/VbU0atntPXqpa0ee8VmoJru7ZcQ7+niqf7mjQ/x0Uo99soYIszXXbLwEx
         ALZioYoJvFyNVMSoS/PYmRUdgADyAw3hITGRfjVqXGviKT2bUrimIMep/9KO8gtNExli
         vv1Q==
X-Gm-Message-State: AOAM532nLZkvnhn5v9Thsbf7lk7oxpHmxDwjkgeYEXJSDbI8YcCMVDV0
        0C24QRcVB+RktFjCBNIvbn7swNXT8IY=
X-Google-Smtp-Source: ABdhPJzGSFV9ICsyeh1MhD6IF+T1wQ5Hlmu7RGqgBZ+IBS0v6RBOWl4mje++5heJI0kcnHQt6WaXng==
X-Received: by 2002:a2e:b014:0:b0:23c:9593:f7 with SMTP id y20-20020a2eb014000000b0023c959300f7mr2397143ljk.209.1645720328197;
        Thu, 24 Feb 2022 08:32:08 -0800 (PST)
Received: from orome ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id 7sm243339lft.194.2022.02.24.08.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 08:32:06 -0800 (PST)
Date:   Thu, 24 Feb 2022 17:32:04 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Akhil R <akhilrajeev@nvidia.com>
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        jonathanh@nvidia.com, kyarlagadda@nvidia.com, ldewangan@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        p.zabel@pengutronix.de, rgumasta@nvidia.com, robh+dt@kernel.org,
        nathan@kernel.org, vkoul@kernel.org
Subject: Re: [PATCH v21 1/2] dt-bindings: dmaengine: Add doc for tegra gpcdma
Message-ID: <YhezBG9tpNDG24R6@orome>
References: <20220224123903.5020-1-akhilrajeev@nvidia.com>
 <20220224123903.5020-2-akhilrajeev@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="r/ttdRDeDVZvVJVR"
Content-Disposition: inline
In-Reply-To: <20220224123903.5020-2-akhilrajeev@nvidia.com>
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


--r/ttdRDeDVZvVJVR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 24, 2022 at 06:09:02PM +0530, Akhil R wrote:
> Add DT binding document for Nvidia Tegra GPCDMA controller.
>=20
> Signed-off-by: Rajesh Gumasta <rgumasta@nvidia.com>
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/dma/nvidia,tegra186-gpc-dma.yaml | 110 ++++++++++++++++++
>  1 file changed, 110 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/nvidia,tegra186=
-gpc-dma.yaml

Acked-by: Thierry Reding <treding@nvidia.com>

--r/ttdRDeDVZvVJVR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmIXswQACgkQ3SOs138+
s6FH/w//X7V7oWBuRIHPW4LFa+M3TSBMgEuz3noJYqm1is6ABFrLv4sdprTm/ykI
3dmEvSS5y0CoyW7VgnUDnmQ+UYwXzAGisFo/fIR7VjKdIkgIjQrejEF/hWNj4RY4
Os1OejpnpNQJXq/4LRxqO7DVe7iFPMGhzO8jrHkpMuDACDHUnz5fF95FqLLwrMBo
aJ0c0kzuCj1j3op+yfQuc900AbX07bPpYYMk2kicD5/2NhoYQUVSCo6Q7KvI6lyj
p55v0eqtqe14gNeO4QG3lE2jtGmA2KEMs/+Yn+CQ3mnkQiC5RJR+A5IS+GdCINR7
1wavUab7pQUGCVie80j1AcdOP616q8q7AmO23F+O2lahT80QLzPj1Rdl5rQOQS5z
uksopvbpGNO4ACxsL8UoUZ9IGb+9NV/kEp1iDIHuLUslURtrAQJvz2cp6vWpM+Tx
EeuO1Y0JEXdW4N1pBf73FjUut5f4lp9d2s20w9ByfMRnHfaeKyU6kPPWEWup2z9X
IQNkCtFEKwdsBbFm8w6Ftq4dSTmcA/+hmr/vl7Q5vMuYQUAYiiIpD2uyeuquNiQy
0nYX8VYWDQy9t53GzB5cj5gSgKqnaqdVEvSCcJ+/mg1tmw8tU+vxRbg8qQTy4xuy
LpMxvFWSh9Fb4hG+oQ6TL13O9tigX1vIs8pFbNHs7AlLbMxCXdg=
=7ran
-----END PGP SIGNATURE-----

--r/ttdRDeDVZvVJVR--
