Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98E1718137
	for <lists+dmaengine@lfdr.de>; Wed, 31 May 2023 15:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236367AbjEaNQE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 31 May 2023 09:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236351AbjEaNQA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 31 May 2023 09:16:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5AD132;
        Wed, 31 May 2023 06:15:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17EA963990;
        Wed, 31 May 2023 13:15:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE6E4C433D2;
        Wed, 31 May 2023 13:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685538954;
        bh=vOTa5MUOhxTH37zrJH/3NXFRmUhlyERnZdSp2zEDzMw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MohAVbsLBjUuF5j7mcmA9YUSlj8iSsNTlEp/4CErRWscq4hgDdCdQosJYH1VX4OD6
         8NljKsV5mGEhUd1bhty4MryUDP67j/72hfE9RwsOyvQKPDxb4XJeZmBxrcwM5yItv9
         w75Pwt1QP+4/+B92+4gwUkipydak26QdEsMhkWtVUC5CET8Nf6ledh09d2yH4Jw5vm
         vAbMHe3wzZOSz09HLRiInoRz2Qbd/JEN22sFPp6ueeZX8bBcto/W2TATKoS5IcrHOZ
         v8EUAeAV3boQ0COyFoMKckHuXwnhD7UO9cjN04I7opo7rzwIuf65Spo8+nsPb6wA+5
         mSHMBTxXIddGA==
Date:   Wed, 31 May 2023 14:15:49 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Binbin Zhou <zhoubinbin@loongson.cn>
Cc:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Huacai Chen <chenhuacai@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
        Yingkun Meng <mengyingkun@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH 1/2] dt-bindings: dmaengine: Add Loongson LS2X APB DMA
 controller
Message-ID: <20230531-quicksand-enviable-75a070860077@spud>
References: <cover.1685448898.git.zhoubinbin@loongson.cn>
 <23536e4dcd5a839e932901b7c66a15d1f5465c4d.1685448898.git.zhoubinbin@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qc6F2OFGFNda1XWa"
Content-Disposition: inline
In-Reply-To: <23536e4dcd5a839e932901b7c66a15d1f5465c4d.1685448898.git.zhoubinbin@loongson.cn>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--qc6F2OFGFNda1XWa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 31, 2023 at 04:50:04PM +0800, Binbin Zhou wrote:
> Add Loongson LS2X APB DMA controller binding with DT schema
> format using json-schema.
>=20
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
>  .../bindings/dma/loongson,ls2x-apbdma.yaml    | 61 +++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/loongson,ls2x-a=
pbdma.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/dma/loongson,ls2x-apbdma.y=
aml b/Documentation/devicetree/bindings/dma/loongson,ls2x-apbdma.yaml
> new file mode 100644
> index 000000000000..9df32dd98aaf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/loongson,ls2x-apbdma.yaml
> @@ -0,0 +1,61 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/loongson,ls2x-apbdma.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Loongson LS2X APB DMA controller
> +
> +description: |

As a minor nit, the | shouldn't be required here.

> +  The Loongson LS2X APB DMA controller is used for transferring data
> +  between system memory and the peripherals on the APB bus.
> +
> +maintainers:
> +  - Binbin Zhou <zhoubinbin@loongson.cn>
> +
> +allOf:
> +  - $ref: dma-controller.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: loongson,ls2k1000-apbdma
> +      - items:
> +          - const: loongson,ls2k0500-apbdma
> +          - const: loongson,ls2k1000-apbdma

Sweet, good to see fallbacks in use here ;)

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  "#dma-cells":
> +    const: 1
> +
> +  dma-channels:
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - "#dma-cells"
> +  - dma-channels
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    apbdma0: dma-controller@1fe00c00 {

Nothing references the apbdma0 label so it can be dropped.
Otherwise,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> +        compatible =3D "loongson,ls2k1000-apbdma";
> +        reg =3D <0x1fe00c00 0x8>;
> +        interrupt-parent =3D <&liointc1>;
> +        interrupts =3D <12 IRQ_TYPE_LEVEL_HIGH>;
> +        #dma-cells =3D <1>;
> +        dma-channels =3D <1>;
> +    };
> +
> +...
> --=20
> 2.39.1
>=20

--qc6F2OFGFNda1XWa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHdIhQAKCRB4tDGHoIJi
0tOrAP9Cl0SsiSBLexNeoIQe71NHkgQQJYYL6Bkmn5tX+RRFUQEAkGeOMq9MYEdb
GxJXw1qKzqK4800lDfFBhRMJaIMligk=
=3DRW
-----END PGP SIGNATURE-----

--qc6F2OFGFNda1XWa--
