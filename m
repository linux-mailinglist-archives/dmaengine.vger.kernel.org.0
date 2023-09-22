Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 760217AAF16
	for <lists+dmaengine@lfdr.de>; Fri, 22 Sep 2023 12:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjIVKGT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 22 Sep 2023 06:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbjIVKGS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 22 Sep 2023 06:06:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2108F;
        Fri, 22 Sep 2023 03:06:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 891B8C433C7;
        Fri, 22 Sep 2023 10:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695377172;
        bh=ZSJfD7k/VQUpXo2+TnOmQVi22abLU8ZmEK3CpkrD6cA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OdBZHf0Djsq5PqRRpd7L0wJmE8UqPNz5KSWCssaBxCFoCnhj+UXwx3sSfYPBV70DZ
         6dJj2pZyZE9bxhT0if0UBkQg7XyyBLxcCpIhiRtWS8fpgMbrvZc9ElREPbTDNOp0f+
         oBhtXrLoDoQGk+ZCVnLjDxpzlA4CrpTbQEurUxodCMPQ4thn4YjIc69psxo8rpD5Uc
         KMcaeewjKUag9gtI2aZ/jsSPbre7Lb5jpcyZ11oQWD/yhhBAPf9I42NeX2CZ8M5Kt4
         8t3k5wQSSfIsg4wNLqQW3VlGF3RwnkxtdavKvG8PWuyNO7DL4LS4cjs64E4By/tW8r
         /xQVuXujJDqyQ==
Date:   Fri, 22 Sep 2023 11:06:07 +0100
From:   Conor Dooley <conor@kernel.org>
To:     shravan chippa <shravan.chippa@microchip.com>
Cc:     green.wan@sifive.com, vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, conor+dt@kernel.org, palmer@sifive.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        nagasuresh.relli@microchip.com, praveen.kumar@microchip.com,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v1 2/3] dt-bindings: dma: sf-pdma: add new compatible name
Message-ID: <20230922-front-transport-84ad558d64f6@spud>
References: <20230922095039.74878-1-shravan.chippa@microchip.com>
 <20230922095039.74878-3-shravan.chippa@microchip.com>
 <20230922-gray-zebra-a0ea451cc5cc@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gzc29qjm4irtKiMm"
Content-Disposition: inline
In-Reply-To: <20230922-gray-zebra-a0ea451cc5cc@spud>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--gzc29qjm4irtKiMm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Me again,

On Fri, Sep 22, 2023 at 10:59:52AM +0100, Conor Dooley wrote:
> On Fri, Sep 22, 2023 at 03:20:38PM +0530, shravan chippa wrote:
> > From: Shravan Chippa <shravan.chippa@microchip.com>
> >=20
> > add new compatible name microchip,mpfs-pdma to support out of order dma
> > transfers this will improve the dma throughput for mem-to-mem transfer
> >=20
> > Signed-off-by: Shravan Chippa <shravan.chippa@microchip.com>
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
>=20
> I would appreciate if you would drop any vendor tree related tags when
> submitting patches upstream, especially for dt-bindings where it
> actually means something to have my R-b on them.

> > ---
> >  .../bindings/dma/sifive,fu540-c000-pdma.yaml         | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pd=
ma.yaml b/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
> > index a1af0b906365..974467c4bacb 100644
> > --- a/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
> > +++ b/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
> > @@ -27,10 +27,14 @@ allOf:
> > =20
> >  properties:
> >    compatible:
> > -    items:
> > -      - enum:
> > -          - sifive,fu540-c000-pdma
> > -      - const: sifive,pdma0
> > +    oneOf:
> > +      - items:
> > +          - const: microchip,mpfs-pdma # Microchip out of order DMA tr=
ansfer
> > +          - const: sifive,fu540-c000-pdma # Sifive in-order DMA transf=
er

Whoops, I meant to say - I'm okay with the soc-specific compatible being
added (we should have done that from the start), but I think the
comments here about software behaviour should be removed. With that, you
can re-add
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> > +      - items:
> > +          - enum:
> > +              - sifive,fu540-c000-pdma
> > +          - const: sifive,pdma0
> >      description:
> >        Should be "sifive,<chip>-pdma" and "sifive,pdma<version>".
> >        Supported compatible strings are -
> > --=20
> > 2.34.1
> >=20



--gzc29qjm4irtKiMm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQ1nDwAKCRB4tDGHoIJi
0iu4AP9ftHlaLWLxGFrMqLyZkNySjR5Lx2yS6qbidQENPtdz9gD/ZKy6v/mYBTbo
hzCnrlwwv1prOZBIV5HG90XKlkmbrQo=
=/fcK
-----END PGP SIGNATURE-----

--gzc29qjm4irtKiMm--
