Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95CF56BF89
	for <lists+dmaengine@lfdr.de>; Fri,  8 Jul 2022 20:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238874AbiGHRsz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 8 Jul 2022 13:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238687AbiGHRsy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 8 Jul 2022 13:48:54 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B17EE3B;
        Fri,  8 Jul 2022 10:48:52 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id os14so8642108ejb.4;
        Fri, 08 Jul 2022 10:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ShPD4wyN1AbBhQAonxsuDoDDYhIzfN54pj6aDdbJCDY=;
        b=ZUlzH77AUbSN65w9CMhs17pUGYLrrrddFD5ApateSUyz1uwPFGkHyYZJInz5hX4+9B
         1LhNbswofNSVxN7rVu8Kyrh6d0ymp/pLaAsnRm/ECa8OTqmI6djp7xj6osALsg1xtcGd
         NJG7YW+o0Ed3cq9jS7xZfp1u7vwabyFLoh9S9u9aVTmEPHBqQeGDEgN9HFjdJBAclg1m
         eGN/1BFlRgbdU6nlLGrkYlbAjVGIydbUsBVhFjphjH77T3hAuSb6wlnWgfieH2yBo9QO
         1ApTguOFUBZvYvncwjFkNDFf0s0gzDx4XwnN/MJRkFXJizE/Kr47Ywkn+6US3NZo6iNW
         cLyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ShPD4wyN1AbBhQAonxsuDoDDYhIzfN54pj6aDdbJCDY=;
        b=f1EBZ6BT6VIE3INsyJf2PufKoq2aHUhpi0xWmhJ2M2LXdG1nMFHiNvWCds2pLUw5SF
         iol3ChvxmZgKkxSfJDmChPqLdfdFVPmzf3eStpF8YR3Qz4qvpv+8rHt1kUTFRuTI7425
         zTsqkOcMcGwm331JanbB1WwVI26AnO8cGuFuiMuHExaOD23DvWL4cNrKpr52ePaazxUo
         YXN+MmxA09FkHhWw8m6rgxSCE//EYiBC2bkQKgDXOCww241nXT3s/vleToCRbrm4hWej
         0Qr8pZWmowKAy5n3AcewZJ+61v8j1XqiPV2aK9e7SVsF9RMA1T0enty+tV5pXKDCEyes
         OOFg==
X-Gm-Message-State: AJIora/InpJA8Ug3L/tXo/oZHkX0N1nSLsWgN7wV6bOidD+/kHnVkZFc
        1ypr29bqAl4z3+yU8lGr1lL9XVaEgNo=
X-Google-Smtp-Source: AGRyM1t1CJeULEb5y19pIL/pn7kkbQBeHx8US/ZVFL/uEKkB1KyC6iMgsMJIKIKtPRksInWU4lvG8Q==
X-Received: by 2002:a17:907:7349:b0:72a:4d2a:1a66 with SMTP id dq9-20020a170907734900b0072a4d2a1a66mr4638798ejc.151.1657302531072;
        Fri, 08 Jul 2022 10:48:51 -0700 (PDT)
Received: from orome (p200300e41f12c800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f12:c800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id er13-20020a056402448d00b0043a5bcf80a2sm11308849edb.60.2022.07.08.10.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 10:48:50 -0700 (PDT)
Date:   Fri, 8 Jul 2022 19:48:48 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Akhil R <akhilrajeev@nvidia.com>
Cc:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: dmaengine: Add compatible for
 Tegra234
Message-ID: <YshuAIhi2CBQecu6@orome>
References: <20220707145729.41876-1-akhilrajeev@nvidia.com>
 <20220707145729.41876-2-akhilrajeev@nvidia.com>
 <YshAt5WAG9zUkrpy@orome>
 <SJ1PR12MB6339A080E09C0CCCCB9F2E6BC0829@SJ1PR12MB6339.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TiQvvnLkTwz7kPLP"
Content-Disposition: inline
In-Reply-To: <SJ1PR12MB6339A080E09C0CCCCB9F2E6BC0829@SJ1PR12MB6339.namprd12.prod.outlook.com>
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


--TiQvvnLkTwz7kPLP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 08, 2022 at 04:10:47PM +0000, Akhil R wrote:
> > On Thu, Jul 07, 2022 at 08:27:27PM +0530, Akhil R wrote:
> > > Document the compatible string used by GPCDMA controller for Tegra234.
> > >
> > > Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> > > ---
> > >  .../devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml         | 1=
 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git
> > > a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
> > > b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
> > > index 9dd1476d1849..81f3badbc8ec 100644
> > > ---
> > > a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
> > > +++ b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.ya
> > > +++ ml
> > > @@ -23,6 +23,7 @@ properties:
> > >      oneOf:
> > >        - const: nvidia,tegra186-gpcdma
> > >        - items:
> > > +          - const: nvidia,tegra234-gpcdma
> > >            - const: nvidia,tegra194-gpcdma
> > >            - const: nvidia,tegra186-gpcdma
> >=20
> > I don't think this works because it will now fail to validate Tegra194 =
device trees.
> > You'll need to create a separate set of items for Tegra234.
>=20
> If I update it as below, would it work?
>=20
> - items:
> 	- const: nvidia,tegra234-gpcdma
> 	- const: nvidia,tegra186-gpcdma
>=20
> - items:
> 	- const: nvidia,tegra194-gpcdma
> 	- const: nvidia,tegra186-gpcdma

Yeah, that should work. You can verify that this works by running the
dtbs_check target, although this can be somewhat overwhelming right now
given that there are quite a few errors/warnings, so it's easy to miss
new ones.

According to the DTS change that you posted as part of this series, the
Tegra234 compatible string list also includes the Tegra194 compatible
string, so that should either also be updated, or you need to include it
in the binding as well, like in your original patch.

Thierry

--TiQvvnLkTwz7kPLP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmLIbf4ACgkQ3SOs138+
s6Golg/+Nr0ZI1WGzLCZf7ETOImR5DeBoFHa8yEv82uj78FtwiDZxsHGPOgJL+C3
6dunfW7CPg/RGpLbeKEAzNxdqiSEsbpmSAVni0BWdrH4idGrDrEIl2Aj/ORgNkKB
aqap/j+BjKtcVsqHgF8bauQIyFcyGRtwkjhYLwGTJGWAzxq4/NLPwcXc+ah8gCFX
+oTguWZeGbX1eXpOLW4yPtCahtZBnfjoib/B+KMu+OfYnxHGcvbxf5YLSiTE8DGI
aPCmTCiPFR/r289T+6vOfkzcseusbUDr0hbKUprR8z/eTAGm8J1HPJzTkTOyND7x
B9t7cMCz8TXF3qgfE3XBW1QlheyTWgLyLNmpzW9Ya+TwvT/eKT3f8OObLyhbY+Ef
5sAReS9chgCQsmHc5Y2CYyniKNn4m781bUQTbdu/07qKKqRWeI92VyZZttUgkMMk
omUBSpewOFnkxFjIrv33xHMDUQt48pykLKWx4tA3szfQpeHgna99uhFmVtefiNw4
WAXt/v0rg1nx8lbc8+iXo1nnf+BemuoEWrySSJKtCzMrl+vNONIeerjeOe8L4tj6
eHmiN0c0eboRZbsPbEw1G01bCVAt/qQz8qrDwwP/pDtGQFiWIZ+xXk81TXhYsVly
7xsGPz0w4+fAQhYcvQDjdHlBaff2vH5FHIxwH/YTh+5mq5SbGQg=
=Z7VR
-----END PGP SIGNATURE-----

--TiQvvnLkTwz7kPLP--
