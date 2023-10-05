Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D547BA2A8
	for <lists+dmaengine@lfdr.de>; Thu,  5 Oct 2023 17:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbjJEPpS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 5 Oct 2023 11:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232999AbjJEPoz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 5 Oct 2023 11:44:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB4B13C80;
        Thu,  5 Oct 2023 07:32:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5903BC32782;
        Thu,  5 Oct 2023 10:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696503274;
        bh=r9QAN25ECg8YV7rovLkgwPyjjglMxbc27XwhgPj0p2k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jylTMHbvJxFAMVfEx+/VTWJ5qLSXYONVK3QwgUliTNxTLcVa8fp1LiFRhv8pXAEiG
         c6IiyFrR/PMIZPxfaWHGeiEjHY7WqILh+Dz+ukbT78vExFr+jS34I+5LH3isMfZ44S
         qJKlRR8+urhiXnx8GpuqU0JHlw2ssmvVraMs/zIj7WyVlj3504YyoTfBlXUEIySbmG
         7SRdbQEUn0OJ7UxE9O9zzI0SzobLyNc1nPSIQU4xE3oVxKEOkYDjFgN/iuu3G0Cxqh
         H/3Q+LOeLDOYEiQ3Jx6lKEWtH40Fo7GS0K4LLz7c4KaAka3U16sUdq0wM80Xwsg+9q
         9RYFeYnWmN0Zw==
Date:   Thu, 5 Oct 2023 11:54:29 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     shravan chippa <shravan.chippa@microchip.com>,
        green.wan@sifive.com, vkoul@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, conor+dt@kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        nagasuresh.relli@microchip.com, praveen.kumar@microchip.com,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: dma: sf-pdma: add new compatible name
Message-ID: <20231005-wanted-plausible-71dae05ccc7b@spud>
References: <20231003042215.142678-1-shravan.chippa@microchip.com>
 <20231003042215.142678-3-shravan.chippa@microchip.com>
 <20231004133021.GB2743005-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FXxfjJNs6siMoTeZ"
Content-Disposition: inline
In-Reply-To: <20231004133021.GB2743005-robh@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--FXxfjJNs6siMoTeZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 04, 2023 at 08:30:21AM -0500, Rob Herring wrote:
> On Tue, Oct 03, 2023 at 09:52:13AM +0530, shravan chippa wrote:
> > From: Shravan Chippa <shravan.chippa@microchip.com>
> >=20
> > Add new compatible name microchip,mpfs-pdma to support
> > out of order dma transfers
> >=20
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > Signed-off-by: Shravan Chippa <shravan.chippa@microchip.com>
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

IIRC I asked for the comments here to be removed on the previous
version, and my r-b was conditional on that.
The device specific compatible has merit outside of the ordering, which
may just be a software policy decision.

> This doesn't really make sense. microchip,mpfs-pdma is compatible with=20
> sifive,fu540-c000-pdma and sifive,fu540-c000-pdma is compatible with=20
> sifive,pdma0, but microchip,mpfs-pdma is not compatible with=20
> sifive,pdma0? (Or replace "compatible with" with "a superset of")

TBH, I am not sure why it was done this way. Probably because the driver
contains both sifive,pdma0 and sifive,fu540-c000-pdma. Doing
compatible =3D "microchip,mpfs-pdma", "sifive,fu540-c000-pdma", "sifive,pdm=
a0";
thing would be fine.

> Any fallback is only useful if an OS only understanding the fallback=20
> will work with the h/w. Does this h/w work without the driver changes?

Yes.=20
I've been hoping that someone from SiFive would come along, and in
response to this patchset, tell us _why_ the driver does not make use of
out-of-order transfers to begin with.

Thanks,
Conor.

--FXxfjJNs6siMoTeZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZR6V5AAKCRB4tDGHoIJi
0oX1AP4gvbx/YYM63FggUSYmU1/62CsJzHKn0+mB5T85IMCFwgD/cOxS4ARE5fEz
L4ddVpARkl5OfnTsKxySy+l9cZjbFgc=
=hzTR
-----END PGP SIGNATURE-----

--FXxfjJNs6siMoTeZ--
