Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404727BC6CE
	for <lists+dmaengine@lfdr.de>; Sat,  7 Oct 2023 12:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343795AbjJGKeH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 7 Oct 2023 06:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343765AbjJGKeG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 7 Oct 2023 06:34:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35BB92;
        Sat,  7 Oct 2023 03:34:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA727C433C8;
        Sat,  7 Oct 2023 10:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696674845;
        bh=h8vx4z1MJn6Xg4V0FZ5iIw9Vqe+NhY8gHjO+UERrT0o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JjhkLD7m0SpMPLTTfVV3BHBL46xSgdqcJTOmzENTlQnrGS9yKxtbhtNrX/mgFGvNo
         KBR3Y4kFd3CObVJFSlScQbUOtQhqVArp1HkLLzFhx0MaPQsd7A4NB+x7dAZyUCP4yW
         cjflLW/xt83L6AKqikNKf+ErUNepmkSwc+JTqh6LmfcBKSUB4u5QV1J4BpMZaZ4cyT
         6spPS+DR83q0lHfMY0fi5cWaMqXjkJzIhG84m5WCDnSdx54q9hLabk2NFRR8u6tH4P
         nv3B8FSf4gmhy7Vroz8LbrEeppFAsaNlCE2x8CRmPSJ5ecOxKE1RevmB/NqAQOFjUF
         9ayTjREculhug==
Date:   Sat, 7 Oct 2023 11:34:01 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Keguang Zhang <keguang.zhang@gmail.com>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v5 1/2] dt-bindings: dma: Add Loongson-1 DMA
Message-ID: <20231007-untapped-masses-01f80b7c13c7@spud>
References: <20230928121953.524608-1-keguang.zhang@gmail.com>
 <20230928121953.524608-2-keguang.zhang@gmail.com>
 <20230928-capacity-husked-305f03680834@spud>
 <CAJhJPsVT371gPN++UNK-cggb8uVxWqpJAoEbFGV8+syxfvnGAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pkowK5kK8UfqjnMn"
Content-Disposition: inline
In-Reply-To: <CAJhJPsVT371gPN++UNK-cggb8uVxWqpJAoEbFGV8+syxfvnGAQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--pkowK5kK8UfqjnMn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 07, 2023 at 01:45:23PM +0800, Keguang Zhang wrote:
> On Fri, Sep 29, 2023 at 12:42=E2=80=AFAM Conor Dooley <conor@kernel.org> =
wrote:
> >
> > Hey,
> >
> > On Thu, Sep 28, 2023 at 08:19:52PM +0800, Keguang Zhang wrote:
> > > Add devicetree binding document for Loongson-1 DMA.
> > >
> > > Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> > > ---
> > > V4 -> V5:
> > >    A newly added patch
> > >
> > >  .../bindings/dma/loongson,ls1x-dma.yaml       | 64 +++++++++++++++++=
++
> > >  1 file changed, 64 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/dma/loongson,ls=
1x-dma.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/dma/loongson,ls1x-dma.=
yaml b/Documentation/devicetree/bindings/dma/loongson,ls1x-dma.yaml
> > > new file mode 100644
> > > index 000000000000..51b45d998a58
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/dma/loongson,ls1x-dma.yaml
> > > @@ -0,0 +1,64 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/dma/loongson,ls1x-dma.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Loongson-1 DMA Controller
> > > +
> > > +maintainers:
> > > +  - Keguang Zhang <keguang.zhang@gmail.com>
> > > +
> > > +description: |
> >
> > This | isn't required as you have no formatting to preserve here.
> >
> Will remove '|'.
>=20
> > > +  Loongson-1 DMA controller provides 3 independent channels for
> > > +  peripherals such as NAND and AC97.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - loongson,ls1b-dma
> > > +      - loongson,ls1c-dma
> >
> > From a skim of the driver, these two devices seem to be compatible,
> > and therefore one should fall back to the other.
> >
> Got it. How about changing to one const?
>   compatible:
>     const: loongson,ls1-dma

No, keep the compatibles you have & set up a fallback please.
Too many of these loongson bindings have got in with overly generic
compatibles...

--pkowK5kK8UfqjnMn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZSE0GQAKCRB4tDGHoIJi
0uTzAP93/jJpexiSebL/3MJDtEQmLCQQ/S1iMZzDwIVicXNBuAD/dC0GaspLD+/4
LvDML2oJxJpiYFJJhGSyyC0Pkj79iAQ=
=3tOl
-----END PGP SIGNATURE-----

--pkowK5kK8UfqjnMn--
