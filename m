Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD5562E7A3
	for <lists+dmaengine@lfdr.de>; Thu, 17 Nov 2022 23:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235128AbiKQWCU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 17 Nov 2022 17:02:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241233AbiKQWCB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 17 Nov 2022 17:02:01 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6188A786C2;
        Thu, 17 Nov 2022 14:00:32 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id m22so8489785eji.10;
        Thu, 17 Nov 2022 14:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r2NN6hDPyAfdU/sCDR9woVn5JiNmxnVWFqIdPt4vm9g=;
        b=WB+cuyaUAG3RwZfb0HzRk96fSQcsLypuQJD6hWX6nb3V2Ltv8FbauDkohEm5cevBr6
         nCSz5p++gLv5EQ8Oxk4hv+KfslrF9EPBa0bN1y2d0s/HHfidM0qc2T/DNVE2F7yxZ+w0
         wTHkBufQQJ5vYxQjlpzAV6RULDw8ODEHNRjidh0ruvy7T6VAkfhVC9lsmOrIoV4K2pLK
         3j9VozwjYh9YNHOs+OJfd5jFKDV5IV/oSbV+6ma20qOV9D095lkE0/HPnp03Vc0xIjyN
         bEA2mQnX5iVcDU1AR9nVNjppOcAHsBtvgpRsrI0fD6uIS7DQ1W4KEOb8t3yM3LuD04Dc
         7eJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r2NN6hDPyAfdU/sCDR9woVn5JiNmxnVWFqIdPt4vm9g=;
        b=CRP1zc9BlsdQ4gGs5cAWxoNq36sDkKxQlOJL5zu0F6sO5WbsAV7fvL4V3iRenOD9HD
         3S+zU1EqWYSr72+JKcn9FfNYrGI6XM+QkUjFTkYu+VJwGGXKXrYguCLkM7iajHpPbCUr
         4trLSYGK5YucmTDM6ZBJI4Cjl20w/7s8G+EfeDfQUJYe5u0uY13KMLZDdqO/3lAJk2W7
         cQSaN87G0Q4sa/EBkIRWD5p9v2X28NPrFkh98bCX54IUrSLbzXvcWUUOszrs6nDlLYSY
         qgh0ZitY88o+aBcOo2Ll80G1T3TyETi0Xt3if36p/VOlCRu4UqVkxW32XpAUJ8Oy3BL2
         dEZw==
X-Gm-Message-State: ANoB5plOaY7aygaKXilkAK7sz/t+1iS1CIR44goClMoIehX5IIZ5Df9u
        56uOOBmojiryBdzvmk5Sxkm48KgTu6s=
X-Google-Smtp-Source: AA0mqf7Jnsueov1Xt8U8EcqPyumX0lXIYYByfa7zJaBq+nR2U0ltaQPELB/dKHN/dM7NZJ1sk1a3tw==
X-Received: by 2002:a17:906:95c3:b0:78e:975:5e8 with SMTP id n3-20020a17090695c300b0078e097505e8mr3766822ejy.82.1668722430898;
        Thu, 17 Nov 2022 14:00:30 -0800 (PST)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id f26-20020a17090631da00b007b27aefc578sm861531ejf.126.2022.11.17.14.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 14:00:30 -0800 (PST)
Date:   Thu, 17 Nov 2022 23:00:28 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Akhil R <akhilrajeev@nvidia.com>
Cc:     ldewangan@nvidia.com, jonathanh@nvidia.com, vkoul@kernel.org,
        p.zabel@pengutronix.de, dmaengine@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sfr@canb.auug.org.au
Subject: Re: [PATCH v4 2/3] arm64: tegra: Add dma-channel-mask in GPCDMA node
Message-ID: <Y3au/AHGcWoqfkU+@orome>
References: <20221110171748.40304-1-akhilrajeev@nvidia.com>
 <20221110171748.40304-3-akhilrajeev@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4NqMONeQWKrx0m0s"
Content-Disposition: inline
In-Reply-To: <20221110171748.40304-3-akhilrajeev@nvidia.com>
User-Agent: Mutt/2.2.8 (2022-11-05)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--4NqMONeQWKrx0m0s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 10, 2022 at 10:47:47PM +0530, Akhil R wrote:
> Add dma-channel-mask property in Tegra GPCDMA device tree node.
>=20
> The property would help to specify the channels to be used in
> kernel and reserve few for the firmware. This was previously
> achieved by limiting the channel number to 31 in the driver.
> This is wrong and does not align with the hardware. Correct this
> and update the interrupts property to list all 32 interrupts.
>=20
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra186.dtsi | 4 +++-
>  arch/arm64/boot/dts/nvidia/tegra194.dtsi | 4 +++-
>  arch/arm64/boot/dts/nvidia/tegra234.dtsi | 4 +++-
>  3 files changed, 9 insertions(+), 3 deletions(-)

Applied, thanks.

Thierry

--4NqMONeQWKrx0m0s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmN2rvwACgkQ3SOs138+
s6FR4A/7B0/Rwe1mbvhxjZHE3yhPrHVXuKtngxwlPnrl4KkMVER3QN1BrP0ojduS
zqn/8VyIxknH9R6uostVEhy8kPJHkYUaSVEzd7kSS1oPvQ61qAbqwNalYNCO90yr
3AgWhiIWflrrTTMtMfnvYr6yFlAHnlPaYpdirNrhZyXKu0ZUdcBs51aimS2pYNZj
6OvUEq2h0iLZw/NwFbZqXRWZuH31+bB89QNIqFo/y7laGVWDcAry54Fv4aUPYbrt
307Cl6ak4/Kv0M5xtA9prt6sVYFT/QfJ4jnzoxMg7la7L5ERlmOnWDkURBPz4O4e
cWHB5DuKrKO/XxbIVnR+kDbFqTtWCrjcU9qxL38jNJRmiB/lRHQ5T8zPYVjjQaFR
eWfy6r5ASUSuJ2W+KsbatH/VeCgc5nYdmviAyAPje8BUu+l/6TajdC94lo9j63l1
egfAyJmXpx3f4l4Krhlc+Uu0owBz5IVNtdDCxJPPSl5fAKo8ioWEw7mBkuWj9utl
bTzE77TuFxd3/zZmtwQkCNJMPNANbczBPMpc82ySLjX4L2QbWdYu7zzBUeVOGsjF
KF7RE4Qla9GBsoKuWuC6oXfFKd3NXOwWgSalpYgakCuKMIW5oR54EICbw9vus5Hk
FNLbnRl4W2p0p0f2LhTB5QDAulc9+UF+Nia+/4XIrwsw6sxydsE=
=JZC7
-----END PGP SIGNATURE-----

--4NqMONeQWKrx0m0s--
