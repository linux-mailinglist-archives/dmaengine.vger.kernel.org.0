Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A888744BAF
	for <lists+dmaengine@lfdr.de>; Sun,  2 Jul 2023 01:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjGAXDS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 1 Jul 2023 19:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjGAXDR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 1 Jul 2023 19:03:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC32210DC;
        Sat,  1 Jul 2023 16:03:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0001460A29;
        Sat,  1 Jul 2023 23:03:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07DE2C433C7;
        Sat,  1 Jul 2023 23:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688252595;
        bh=mt6r8UFPAN4tDG96jEynlaqTUBoJG9qJ6uaWu2oLhFc=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=S5wa8azmV3YtUbJzzbB3djgUw3PV3KeEZWnV51I3p6rwFYDhTGd+Sn/Mt0b/iO/Lf
         ogBXDkNy67736NmHzoZMI7r1ZO5bhoUHwMv+y2W5wKCP+PGClckuF+uD1WJZtXmq2u
         QMpNpnhP/CUm/rkAng8f11FeC74FXx00cR6Sx1w2X8vLz1y6h9f6aBOnjhWQ1T/B0s
         G7pymFjt4s0iWOEi5wZmll7Rn4KCeT8DS/MWhi5SwmI4uChlOueuebXW43bHpdLTvG
         vCRhnnFY9o7UhwJXOv2e284x0MBy5OP6wDk7qDNCHjyGQizoCaLlla/tDDdzk4o+lO
         qNo3Jg8rm6u2w==
Date:   Sun, 2 Jul 2023 00:03:10 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Walker Chen <walker.chen@starfivetech.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v6 4/4] riscv: dts: starfive: add dma controller node
Message-ID: <20230702-scallop-unsafe-9a02b511c95d@spud>
References: <20230322094820.24738-1-walker.chen@starfivetech.com>
 <20230322094820.24738-5-walker.chen@starfivetech.com>
 <ZKCiOQ0IuptKO8kr@aurel32.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="96nw6xgaB1M0jdl2"
Content-Disposition: inline
In-Reply-To: <ZKCiOQ0IuptKO8kr@aurel32.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--96nw6xgaB1M0jdl2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 02, 2023 at 12:01:29AM +0200, Aurelien Jarno wrote:
> On 2023-03-22 17:48, Walker Chen wrote:
> > Add the dma controller node for the Starfive JH7110 SoC.
> >=20
> > Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> > Signed-off-by: Walker Chen <walker.chen@starfivetech.com>
> > ---
> >  arch/riscv/boot/dts/starfive/jh7110.dtsi | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >=20
> > diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot=
/dts/starfive/jh7110.dtsi
> > index 17220576b21c..b503b6137743 100644
> > --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> > +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> > @@ -510,6 +510,24 @@
> >  			#gpio-cells =3D <2>;
> >  		};
> > =20
> > +		dma: dma-controller@16050000 {
> > +			compatible =3D "starfive,jh7110-axi-dma";
> > +			reg =3D <0x0 0x16050000 0x0 0x10000>;
> > +			clocks =3D <&stgcrg JH7110_STGCLK_DMA1P_AXI>,
> > +				 <&stgcrg JH7110_STGCLK_DMA1P_AHB>;
> > +			clock-names =3D "core-clk", "cfgr-clk";
> > +			resets =3D <&stgcrg JH7110_STGRST_DMA1P_AXI>,
> > +				 <&stgcrg JH7110_STGRST_DMA1P_AHB>;
> > +			interrupts =3D <73>;
> > +			#dma-cells =3D <1>;
> > +			dma-channels =3D <4>;
> > +			snps,dma-masters =3D <1>;
> > +			snps,data-width =3D <3>;
> > +			snps,block-size =3D <65536 65536 65536 65536>;
> > +			snps,priority =3D <0 1 2 3>;
> > +			snps,axi-max-burst-len =3D <16>;
> > +		};
> > +
> >  		aoncrg: clock-controller@17000000 {
> >  			compatible =3D "starfive,jh7110-aoncrg";
> >  			reg =3D <0x0 0x17000000 0x0 0x10000>;
>=20
> It appears that this patch has never been applied, although the rest of
> the series has already been merged.

Correct. I can't apply it because the stgcrg it depends on is still
pending.

> Unfortunately it doesn't apply
> anymore due to other changes to that file.
>=20
> Could you please rebase and repost it?


--96nw6xgaB1M0jdl2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZKCwrgAKCRB4tDGHoIJi
0sJFAQCnplDzaTop7ez/Pr9QBVITVUVlMtt0v7fU5DSZnt0IHwD/ZjpCO+cq0H7W
P/Oxe8VydOaHPtSZ+KQFMCHpMsAR5AE=
=RdNo
-----END PGP SIGNATURE-----

--96nw6xgaB1M0jdl2--
