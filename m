Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F525B8A34
	for <lists+dmaengine@lfdr.de>; Wed, 14 Sep 2022 16:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiINOUn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 14 Sep 2022 10:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiINOUn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 14 Sep 2022 10:20:43 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0CF4507F;
        Wed, 14 Sep 2022 07:20:42 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id sb3so5445070ejb.9;
        Wed, 14 Sep 2022 07:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=rQJchlp98LSRkNYT0Y3HEFD0d/jl10aOIqzKMpMh29o=;
        b=AE+QONsRRVmf1CQraIvgeDAs4Orl2PYlDMwTN/2xAYYVjDXITuqaoLdIFCBywjwQVi
         0WsYGglrXXYDKgVg0EDsBMQLPgg3PHyryWQrJE5JCLTVo0CLsf4/VwnLvC2Yq50AXMUJ
         4esTbONxzIc+6Qju/qHpWIPB3PJLU1Wf0F04rvtoliKkutgiEEy+5hyL5BgQ2h0YxLFj
         mEtBfyvi0pD6eSlfFtbYdkxGMkxEuAjuIHYYkfunn5VipcDgn8uDi0VVQfVdmV0xZlXC
         l5xlQsHnwQGv455LOGefHEqEJQsiSNbwqjM1FmWkljymlb1urHLe8msqQWkFyY8rT8Yj
         lP5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=rQJchlp98LSRkNYT0Y3HEFD0d/jl10aOIqzKMpMh29o=;
        b=CCPXPt7BhMN6RWyHKHbenM/a8rLNSk/SuQMIPXzL5nMchlCgb7xO2UDY/QtatoAn2j
         tV3noHFcDvYXW70qToJpy9nkEqUE+0+nKHVxVf3FCXOBhAq2bKrYIo7izJwbu1Kj0Q0u
         TS9i0HwABS7vVLuSUhrt8+yDCsgD8eNb2wfeEETUMBADVaADomjGomUxyO31V6f7rH9b
         YMpczZiQGvYnlbQVucjpeMhXxmLvARNovwg9xZjSXRYDbNdvn88yozEDjWvCn88Pe6/H
         lBdaZpNoTTbxZukjXHQaku5DU1uO4Z9Esa6OFgEHS20UuG5R4KKZgfD0Mzdf/vHzpUR1
         RuMA==
X-Gm-Message-State: ACgBeo04dxt5VeTHrHPV5mG2G5OSHW8wqwVzeNO/2dmSbJAgGbblNcz4
        MXwKDG9TransADp3RmxKcLI=
X-Google-Smtp-Source: AA6agR7OvPSTBl/G5oWm8qZW5U3e90EFCy/rAGm8UfgS/vXXw+IRsocVCoe4/VnWFJZOtHYvEnJQ1g==
X-Received: by 2002:a17:907:a0c7:b0:77c:b9cb:be17 with SMTP id hw7-20020a170907a0c700b0077cb9cbbe17mr11861287ejc.335.1663165240929;
        Wed, 14 Sep 2022 07:20:40 -0700 (PDT)
Received: from orome (p200300e41f12c800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f12:c800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id bo24-20020a0564020b3800b0044e8ecb9d25sm9814186edb.52.2022.09.14.07.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 07:20:39 -0700 (PDT)
Date:   Wed, 14 Sep 2022 16:20:37 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Akhil R <akhilrajeev@nvidia.com>
Cc:     ldewangan@nvidia.com, jonathanh@nvidia.com, vkoul@kernel.org,
        p.zabel@pengutronix.de, dmaengine@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: dmaengine: Add dma-channel-mask to
 Tegra GPCDMA
Message-ID: <YyHjNfk8ZMx+O96e@orome>
References: <20220913155251.59375-1-akhilrajeev@nvidia.com>
 <20220913155251.59375-2-akhilrajeev@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="u68pok3Ii3D4oT+4"
Content-Disposition: inline
In-Reply-To: <20220913155251.59375-2-akhilrajeev@nvidia.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--u68pok3Ii3D4oT+4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 13, 2022 at 09:22:49PM +0530, Akhil R wrote:
> Add dma-channel-mask property in Tegra GPCDMA document.
>=20
> The property would help to specify the channels to be used in
> kernel and reserve few for the firmware. This was previously
> achieved by limiting the channel number to 31 in the driver.
> Now since we can list all 32 channels, update the interrupts
> property as well to list all 32 interrupts.
>=20
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> ---
>  .../devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml   | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Seems fine:

Acked-by: Thierry Reding <treding@nvidia.com>

--u68pok3Ii3D4oT+4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmMh4zMACgkQ3SOs138+
s6HIwxAAnV8HckodonLxHxHC2GVwz4llfzXyru2YUhFSnnIgW9gdtEVLw0NVW9Mn
h4b41JPZoGofX/8BCSkcrP53CZl5HOzRp3lBBjcvoMZfjwtCRYNJXxCsETgyoFpt
+X1RJphVPk2928w/S4jgPzw3HVeDdvJPhupxMu1dxT/maKFmGe1jyXrPH1BSoTPi
OBpvLDEMegZDhbHraE/KTJbIhuW/DJPTm5w/Y20xdVf3RhNujtSEa3kIkdoQgWvC
O19xCBbsfw3o+7L4WsZTlUGAseGwu4Q3wqc9gLldlJb9mBGsQ0BFM73prf2ciYqC
NLYw37RtimQUW+qPvoFrG2SznClJRSTvDWsbUQXQ0PyU5nOtk1NzpNHdW+hh2Lh/
gfZdPqfBOp4vqke3Zh+KU9RQ5e1Wtac9DUzSsYv6d35bd0hYT32LjqJ1nmLKXzul
16t4pH/qQVoFygdk+BjGhTd0LwuoGKbGi501H68TuTGx1FRFyrr4g8XTfhh1Q+rC
uryV9tuOgBdbG94SmUIIn1QauBjGbje+9ljrxXrBJD4cNxJzAPeH+9Oc+PeyMZM/
3G6AIkvRJsdRK4PVfZDfwOBiYIyqeByNiLG0ibWLacuicJ5rkNqHuV6g4jq49jEg
YQHkK4DxCfmGUfddIPyVvs0HNSCH5KFfzZGDmstFDuRsE7fVEPs=
=jbaz
-----END PGP SIGNATURE-----

--u68pok3Ii3D4oT+4--
