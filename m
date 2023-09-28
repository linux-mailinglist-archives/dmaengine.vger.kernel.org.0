Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA5D7B22A1
	for <lists+dmaengine@lfdr.de>; Thu, 28 Sep 2023 18:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjI1QmO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 Sep 2023 12:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjI1QmN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 28 Sep 2023 12:42:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8CF98;
        Thu, 28 Sep 2023 09:42:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1E5FC433C8;
        Thu, 28 Sep 2023 16:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695919331;
        bh=qCX4gA2PsLjQ0wAJrV2FeY8uzZUcTL/digHji8eRu2Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qA8dJHD3pA2oSwrBuEB1IFGDqarqGfklc/qZnEqesYYBF4awy/TDHyg05c2BIximd
         PsXZC8qmrRdk5WT9sEBXLKvYinYgKfAl0IiFKJj/cyXDlETOwUH5LvFmWIU7yIvuBD
         giK8pdKNnrhoajWBcVmtEFYxvTmcd4+YjhYT3iuuboAI2Lz/p5hFhj4dEYX3+a5koa
         71P40nW97MyWNB31mLOJwIFvY4NqXXza2xquYaYh4zmB6YXGERAhT8b9tfMYBgEagg
         hupJoKiKoRzztflm76vCgibANO00Jrru9xJc7ZHnsKXjCWLUd2mcCjbM3Z65uUb0X/
         uyl1RlGIRqw+w==
Date:   Thu, 28 Sep 2023 17:42:07 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Keguang Zhang <keguang.zhang@gmail.com>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v5 1/2] dt-bindings: dma: Add Loongson-1 DMA
Message-ID: <20230928-capacity-husked-305f03680834@spud>
References: <20230928121953.524608-1-keguang.zhang@gmail.com>
 <20230928121953.524608-2-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HKEqshMTTSkwIe4P"
Content-Disposition: inline
In-Reply-To: <20230928121953.524608-2-keguang.zhang@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--HKEqshMTTSkwIe4P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Thu, Sep 28, 2023 at 08:19:52PM +0800, Keguang Zhang wrote:
> Add devicetree binding document for Loongson-1 DMA.
>=20
> Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> ---
> V4 -> V5:
>    A newly added patch
>=20
>  .../bindings/dma/loongson,ls1x-dma.yaml       | 64 +++++++++++++++++++
>  1 file changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/loongson,ls1x-d=
ma.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/dma/loongson,ls1x-dma.yaml=
 b/Documentation/devicetree/bindings/dma/loongson,ls1x-dma.yaml
> new file mode 100644
> index 000000000000..51b45d998a58
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/loongson,ls1x-dma.yaml
> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/loongson,ls1x-dma.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Loongson-1 DMA Controller
> +
> +maintainers:
> +  - Keguang Zhang <keguang.zhang@gmail.com>
> +
> +description: |

This | isn't required as you have no formatting to preserve here.

> +  Loongson-1 DMA controller provides 3 independent channels for
> +  peripherals such as NAND and AC97.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - loongson,ls1b-dma
> +      - loongson,ls1c-dma

=46rom a skim of the driver, these two devices seem to be compatible,
and therefore one should fall back to the other.

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    description: Each channel has a dedicated interrupt line.
> +    minItems: 1
> +    maxItems: 3
> +
> +  interrupt-names:
> +    minItems: 1
> +    items:
> +      - pattern: ch0
> +      - pattern: ch1
> +      - pattern: ch2
> +
> +  '#dma-cells':
> +    description: The single cell represents the channel index.

This description is unnecessary.

> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-names
> +  - '#dma-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    dma: dma-controller@1fd01160 {

This label is unused.

> +        compatible =3D "loongson,ls1b-dma";
> +        reg =3D <0x1fd01160 0x18>;
> +
> +        interrupt-parent =3D <&intc0>;
> +        interrupts =3D <13 IRQ_TYPE_EDGE_RISING>,
> +        	     <14 IRQ_TYPE_EDGE_RISING>,
> +        	     <15 IRQ_TYPE_EDGE_RISING>;

Odd mixed indentation here. Bindings use spaces only.

Thanks,
Conor.

> +        interrupt-names =3D "ch0", "ch1", "ch2";
> +
> +        #dma-cells =3D <1>;
> +    };
> --=20
> 2.39.2
>=20

--HKEqshMTTSkwIe4P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRWs3wAKCRB4tDGHoIJi
0tqYAP0RZqPjF92eW6rchIJ+lDqLH3DT00cvGFjxw2cv0XjxOwEA8O86J4S7Z3Va
D+6Q7oeLGhBVVyusz4P2DyhKDk4FOgI=
=SXJF
-----END PGP SIGNATURE-----

--HKEqshMTTSkwIe4P--
