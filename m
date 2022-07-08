Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 196D256BBDA
	for <lists+dmaengine@lfdr.de>; Fri,  8 Jul 2022 16:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238085AbiGHOfl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 8 Jul 2022 10:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237974AbiGHOfk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 8 Jul 2022 10:35:40 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D432823BC9;
        Fri,  8 Jul 2022 07:35:39 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id h17so17674879wrx.0;
        Fri, 08 Jul 2022 07:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ppR38sJTn4e6UkCiroOOj/awvQOastGoKzwCSCjDPkk=;
        b=NABPHaAvOVdVUD2XiOt4+I646KM6yqphbI9sKrSh1qyNVdO8wYiFlfVF2B5NttT5hi
         dqLBTHiGRj4gHsGsDJSiuWA483+IZLD69AtENs5wFWWSOW5EpJPRPkT9H0YZhBtfZInu
         Ei4jqBXjFRG/bI3B1v9+BTSHzYJ0hhsVczCungcC12DZ+p6JEy4yvZCQ6lP53WT2iPEk
         bWALtLRLHsIbnKqu6PnYMJ5Jc4u8BbwfhN4ZniMutnG/u5j7q8eO+sKfpbyDG8XQeRSO
         64KwOZt1t87EBfJgbQsbzyBVuu8+7Tnrhg1p9SxwAg4NRerUf1WpsUwp29EmeyG311PJ
         vWdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ppR38sJTn4e6UkCiroOOj/awvQOastGoKzwCSCjDPkk=;
        b=x2nxvHRmv/zOqENBm3qEI+dXhBQV/JhbGMzzzk2X4PIDIVbH7Fr07AmPH5jfsEfdbB
         hyA8BPg0GqYWelTBLRLM02JlYbrCJRn0SidE/V6T6hNf6Anm6DicMeluR6fcn4A+lLg8
         HZplb3GUSip6zgpSgwo/98rSN5kRcZGnFX3lbz1NhUPOq95dX71r1nLy4tn+sb+T8MQ/
         mhvLjsyq350jCPoFJg87E0/XkEL+okc2SzXNercHgPzOsy/+Ls536S8uBAv7ABi0RzaJ
         WeQ58jIuEfyX5Uc9MLOrNog1yRttYFUiyoOijOVF1s4vJltLb6NG5UbCCu8svQGQh88j
         ztMA==
X-Gm-Message-State: AJIora8ikQDJDT/IMWwfnS6RrOwerU2JvNYqtCkBNcZpESbqhiJOSaO1
        uU5bYphUTDk/oiv2rHvlkhgdNQZN51U=
X-Google-Smtp-Source: AGRyM1u2Oee3xZ5+iHTTliZq8AEVz1GxAmAFO24MCgJdXMTKbP/oBsD1BCUuJ7kWEAccbCqwmsjInQ==
X-Received: by 2002:a05:6000:25a:b0:21d:727b:5017 with SMTP id m26-20020a056000025a00b0021d727b5017mr3570510wrz.184.1657290938309;
        Fri, 08 Jul 2022 07:35:38 -0700 (PDT)
Received: from orome (p200300e41f12c800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f12:c800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id c9-20020a05600c0a4900b0039c4ba160absm11292953wmq.2.2022.07.08.07.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 07:35:37 -0700 (PDT)
Date:   Fri, 8 Jul 2022 16:35:35 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Akhil R <akhilrajeev@nvidia.com>
Cc:     dmaengine@vger.kernel.org, jonathanh@nvidia.com,
        ldewangan@nvidia.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, p.zabel@pengutronix.de,
        vkoul@kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: dmaengine: Add compatible for
 Tegra234
Message-ID: <YshAt5WAG9zUkrpy@orome>
References: <20220707145729.41876-1-akhilrajeev@nvidia.com>
 <20220707145729.41876-2-akhilrajeev@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7KrFkS22rogEsCYQ"
Content-Disposition: inline
In-Reply-To: <20220707145729.41876-2-akhilrajeev@nvidia.com>
User-Agent: Mutt/2.2.6 (2022-06-05)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--7KrFkS22rogEsCYQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 07, 2022 at 08:27:27PM +0530, Akhil R wrote:
> Document the compatible string used by GPCDMA controller for Tegra234.
>=20
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> ---
>  .../devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml         | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dm=
a.yaml b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
> index 9dd1476d1849..81f3badbc8ec 100644
> --- a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
> +++ b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
> @@ -23,6 +23,7 @@ properties:
>      oneOf:
>        - const: nvidia,tegra186-gpcdma
>        - items:
> +          - const: nvidia,tegra234-gpcdma
>            - const: nvidia,tegra194-gpcdma
>            - const: nvidia,tegra186-gpcdma

I don't think this works because it will now fail to validate Tegra194
device trees. You'll need to create a separate set of items for
Tegra234.

Thierry

--7KrFkS22rogEsCYQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmLIQLcACgkQ3SOs138+
s6F9wA/+PevJYM9sYGjtbmt0Td1G/xEVvLlkGtAzYtC2f2I9YJl43ag4RwxvG3ok
/i366YAeBcA61nBwuLsnPflTivsKa8W6MXUGByTJOCBsNYq5S3LGsqSi0KlsD1Xr
ARLkiz3WDyncUohNXOOBxGEzEOrO/YT/7Itb8dwr1ig5T+W0PtumgVnAH86iX+DM
mpiwLHuWFqMwU/tziEiR+JyzK6EYAwS3STDuCeaiGw7siF+cuf08Z8zmvwNU47sv
iIwwdPaSDvKVPyKRbl/YwJbbMkas4lF1itH0DhImspBbUEZIGTjcf1U7G8mrVSKL
HAj+S6rmhHM7cP1V99zcAQIDamEaWko9rGtrE7ihKpWG0R5Q+6+7qyZ08g6HeZ7S
aAA/uEhPU+SCy7Bc4wp13/fupQsSLmekewcNUSBSQXO1ZiQ6P9Lx+tkzNVT+xuk5
wev7ncXsqG8k2p1uv/EhvlA/LvHZ5V0obqcmhJB63tlDyncgdr+YmB4r3XHG4uB2
DseZSKeX6xqAhTOSC9FRmDcuNVoK6kllfbvY4xqpxiPmIc6drbEKan8FdqQVsKi+
YO3W+4fvigR+Bx9k7oCvTlSLko6iUkvlifessg4Du9zZW23+/FT7svBxL4uHSwEx
ozKor/mOpEdsHoe1FE8TQ38KpV9+XWzc9J7mjPc1LiFclEZ85a0=
=fR/G
-----END PGP SIGNATURE-----

--7KrFkS22rogEsCYQ--
