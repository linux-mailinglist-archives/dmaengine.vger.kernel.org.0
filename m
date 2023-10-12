Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA257C69C3
	for <lists+dmaengine@lfdr.de>; Thu, 12 Oct 2023 11:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234163AbjJLJf4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 12 Oct 2023 05:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjJLJfz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 12 Oct 2023 05:35:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5E791;
        Thu, 12 Oct 2023 02:35:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97825C433C8;
        Thu, 12 Oct 2023 09:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697103353;
        bh=niTCfJ5nIaIV1WZUxp0TKmnQ2v5iDejGCa7Cmf/1Jwg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NbRLNQNfMtsTH4iIze3Y5b3OZNLq/K1qI1XUxP39RvQLX6are82KYxLxhQIJskbhv
         Ntg622Ldzc8WCpGRa43myfybdwUngfgDa9W+DUXImpShUMC0BP4++8C387I4uoSukI
         1yxtGJ07H91Cq0Ao+k9hivZzCIqrxKXrwvZokNf+NSuk+NQ0l9acbLGYYoNO3WRi8G
         1nP7oAwYb5SpO4L1tFoXSsdmt8QdGZipRhFnKlg/KnLPkUBsRLtItwoWeisxkLxFUM
         S/dn/FwJiBY4ZJwEgTCS+me6LDQWB50N3qcbvDOpDw2lxgXX0GWcHY8GpLDDf2mU1I
         7aTKv13Qc7rXQ==
Date:   Thu, 12 Oct 2023 10:35:48 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Shravan.Chippa@microchip.com
Cc:     robh@kernel.org, green.wan@sifive.com, vkoul@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, conor+dt@kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nagasuresh.Relli@microchip.com, Praveen.Kumar@microchip.com,
        Conor.Dooley@microchip.com
Subject: Re: [PATCH v2 2/4] dt-bindings: dma: sf-pdma: add new compatible name
Message-ID: <20231012-yippee-squid-9fce27a4d84e@spud>
References: <20231003042215.142678-1-shravan.chippa@microchip.com>
 <20231003042215.142678-3-shravan.chippa@microchip.com>
 <20231004133021.GB2743005-robh@kernel.org>
 <20231005-wanted-plausible-71dae05ccc7b@spud>
 <PH0PR11MB5611CDD7C66363B9F2367C2881D3A@PH0PR11MB5611.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ejP92r94GEiwuG/C"
Content-Disposition: inline
In-Reply-To: <PH0PR11MB5611CDD7C66363B9F2367C2881D3A@PH0PR11MB5611.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--ejP92r94GEiwuG/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 12, 2023 at 09:22:17AM +0000, Shravan.Chippa@microchip.com wrot=
e:
> Hi,
>=20
> > -----Original Message-----
> > From: Conor Dooley <conor@kernel.org>
> > Sent: Thursday, October 5, 2023 4:24 PM
> > To: Rob Herring <robh@kernel.org>
> > Cc: shravan Chippa - I35088 <Shravan.Chippa@microchip.com>;
> > green.wan@sifive.com; vkoul@kernel.org; krzysztof.kozlowski+dt@linaro.o=
rg;
> > palmer@dabbelt.com; paul.walmsley@sifive.com; conor+dt@kernel.org;
> > dmaengine@vger.kernel.org; devicetree@vger.kernel.org; linux-
> > riscv@lists.infradead.org; linux-kernel@vger.kernel.org; Nagasuresh Rel=
li - I67208
> > <Nagasuresh.Relli@microchip.com>; Praveen Kumar - I30718
> > <Praveen.Kumar@microchip.com>; Conor Dooley - M52691
> > <Conor.Dooley@microchip.com>
> > Subject: Re: [PATCH v2 2/4] dt-bindings: dma: sf-pdma: add new compatib=
le
> > name
> >=20
> > On Wed, Oct 04, 2023 at 08:30:21AM -0500, Rob Herring wrote:
> > > On Tue, Oct 03, 2023 at 09:52:13AM +0530, shravan chippa wrote:
> > > > From: Shravan Chippa <shravan.chippa@microchip.com>
> > > >
> > > > Add new compatible name microchip,mpfs-pdma to support out of order
> > > > dma transfers
> > > >
> > > > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > > > Signed-off-by: Shravan Chippa <shravan.chippa@microchip.com>
> > > > ---
> > > >  .../bindings/dma/sifive,fu540-c000-pdma.yaml         | 12 ++++++++=
----
> > > >  1 file changed, 8 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git
> > > > a/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
> > > > b/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
> > > > index a1af0b906365..974467c4bacb 100644
> > > > ---
> > > > a/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
> > > > +++ b/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.y
> > > > +++ aml
> > > > @@ -27,10 +27,14 @@ allOf:
> > > >
> > > >  properties:
> > > >    compatible:
> > > > -    items:
> > > > -      - enum:
> > > > -          - sifive,fu540-c000-pdma
> > > > -      - const: sifive,pdma0
> > > > +    oneOf:
> > > > +      - items:
> > > > +          - const: microchip,mpfs-pdma # Microchip out of order DM=
A transfer
> > > > +          - const: sifive,fu540-c000-pdma # Sifive in-order DMA
> > > > + transfer
> >=20
> > IIRC I asked for the comments here to be removed on the previous versio=
n, and
> > my r-b was conditional on that.
> > The device specific compatible has merit outside of the ordering, which=
 may just
> > be a software policy decision.
> >=20
> > > This doesn't really make sense. microchip,mpfs-pdma is compatible with
> > > sifive,fu540-c000-pdma and sifive,fu540-c000-pdma is compatible with
> > > sifive,pdma0, but microchip,mpfs-pdma is not compatible with
> > > sifive,pdma0? (Or replace "compatible with" with "a superset of")
> >=20
> > TBH, I am not sure why it was done this way. Probably because the driver
> > contains both sifive,pdma0 and sifive,fu540-c000-pdma. Doing compatible=
 =3D
> > "microchip,mpfs-pdma", "sifive,fu540-c000-pdma", "sifive,pdma0"; thing =
would
> > be fine.
> >=20
> > > Any fallback is only useful if an OS only understanding the fallback
> > > will work with the h/w. Does this h/w work without the driver changes?
> >=20
> > Yes.
> > I've been hoping that someone from SiFive would come along, and in resp=
onse to
> > this patchset, tell us _why_ the driver does not make use of out-of-ord=
er transfers
> > to begin with.
> >=20
>=20
> I am also expecting a replay someone from SiFive
> The out-of-order should work with other RISC-V platforms also.
>=20
> I will try to send V3 with the below changes (just adding a new compatibl=
e name)
>=20
> ****************************
> --- a/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
> +++ b/Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
> @@ -29,6 +29,7 @@ properties:
>    compatible:
>      items:
>        - enum:
> +          - microchip,mpfs-pdma
>            - sifive,fu540-c000-pdma
>        - const: sifive,pdma0
>      description:
> ***************************
>=20
> Device tree patch
> *****************************
> --- a/arch/riscv/boot/dts/microchip/mpfs.dtsi
> +++ b/arch/riscv/boot/dts/microchip/mpfs.dtsi
> @@ -221,7 +221,7 @@ plic: interrupt-controller@c000000 {
>                 };
>                 pdma: dma-controller@3000000 {
> -                       compatible =3D "sifive,fu540-c000-pdma", "sifive,=
pdma0";
> +                       compatible =3D "microchip,mpfs-pdma", "sifive,fu5=
40-c000-pdma", "sifive,pdma0";

This is gonna produce dtbs_check complaints. Your binding change only
permits `compatible =3D "microchip,mpfs-pdma", "sifive,pdma0";`

Cheers,
Conor.

>                         reg =3D <0x0 0x3000000 0x0 0x8000>;
>                         interrupt-parent =3D <&plic>;
>                         interrupts =3D <5 6>, <7 8>, <9 10>, <11 12>;
> ***************************

--ejP92r94GEiwuG/C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZSe99AAKCRB4tDGHoIJi
0vQ9AQCbY9hLUCrnbF9LvnoMPy66j2uiLwr8OKI1eDpwHw4mOAD+PukoSXw/50R3
traIq92KfBKrNnBYqcteMG5oDxT8CQ4=
=2bIJ
-----END PGP SIGNATURE-----

--ejP92r94GEiwuG/C--
