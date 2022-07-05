Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D4D5677B3
	for <lists+dmaengine@lfdr.de>; Tue,  5 Jul 2022 21:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiGETXN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 5 Jul 2022 15:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiGETXM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 5 Jul 2022 15:23:12 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5567D21835;
        Tue,  5 Jul 2022 12:23:11 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id z191so12073155iof.6;
        Tue, 05 Jul 2022 12:23:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H5eyFsH62ZCOMR5j44c7qDXl+L0Xiqo5oRXL7/M/n9U=;
        b=jqPCqs1xAayb9f2/qRAD01d6yorVOORpJVhGyri1td7hztkeRQRUEH+8wAS/k+iUQ8
         eAUl9SA1ZIPJdNPasHM0apZkarLadz+MXU69Ufi80k9qZejAyqNBFXLG4ODoeKHLcL7t
         EuNqJ6/xEVysv/amtKOal88TCHs3695ZZEEq2/tTxFpFYAgaIuWDxm7M+8oJwWk/lkwm
         6GG2BgBbqBfyTUOwiRpyPvL335ap/IgGXIdQ7BWBxZkz2by2pK8OtmaX3Yd2RthNGLKF
         3V7N8MONracVn1C0TQeEHlTOGO/u3Mu4agg7VzzuppY1UsBTMLZBS/TDDjK6oFHe91Zb
         0Utw==
X-Gm-Message-State: AJIora+pTVBPSepMtXrHTM9AMReHMEcQIV0rM3pObrbnl4XSBhwfwoML
        cU/EGsN5L/g42G2iS1YeLA==
X-Google-Smtp-Source: AGRyM1u0fHCnFee1kEPRUg0SqoCFPI8COBha8zPrSVGZ62b76/VvOoRH5cPG5r4Gv3xkb5zkrF1YIg==
X-Received: by 2002:a05:6638:3014:b0:317:9daf:c42c with SMTP id r20-20020a056638301400b003179dafc42cmr22147925jak.10.1657048990513;
        Tue, 05 Jul 2022 12:23:10 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id c1-20020a6bfd01000000b00675139dbff9sm14725537ioi.48.2022.07.05.12.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 12:23:10 -0700 (PDT)
Received: (nullmailer pid 2477219 invoked by uid 1000);
        Tue, 05 Jul 2022 19:23:07 -0000
Date:   Tue, 5 Jul 2022 13:23:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Dillon Min <dillon.minfei@gmail.com>,
        Jose Abreu <joabreu@synopsys.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 05/14] dt-bindings: memory-controllers: add canaan
 k210 sram controller
Message-ID: <20220705192307.GA2471961-robh@kernel.org>
References: <20220701192300.2293643-1-conor@kernel.org>
 <20220701192300.2293643-6-conor@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701192300.2293643-6-conor@kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Jul 01, 2022 at 08:22:51PM +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> The k210 U-Boot port has been using the clocks defined in the
> devicetree to bring up the board's SRAM, but this violates the
> dt-schema. As such, move the clocks to a dedicated node with
> the same compatible string & document it.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../memory-controllers/canaan,k210-sram.yaml  | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/canaan,k210-sram.yaml
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/canaan,k210-sram.yaml b/Documentation/devicetree/bindings/memory-controllers/canaan,k210-sram.yaml
> new file mode 100644
> index 000000000000..82be32757713
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/memory-controllers/canaan,k210-sram.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/memory-controllers/canaan,k210-sram.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Canaan K210 SRAM memory controller
> +
> +description: |

Don't need '|'.

> +  The Canaan K210 SRAM memory controller is initialised and programmed by
> +  firmware, but an OS might want to read its registers for error reporting
> +  purposes and to learn about the DRAM topology.

How the OS going to do that? You don't have any way defined to access 
the registers.

Also, where is the SRAM address itself defined?

> +
> +maintainers:
> +  - Conor Dooley <conor@kernel.org>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - canaan,k210-sram
> +
> +  clocks:
> +    minItems: 1
> +    items:
> +      - description: sram0 clock
> +      - description: sram1 clock
> +      - description: aisram clock
> +
> +  clock-names:
> +    minItems: 1
> +    items:
> +      - const: sram0
> +      - const: sram1
> +      - const: aisram
> +
> +required:
> +  - compatible
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/k210-clk.h>
> +    memory-controller {
> +        compatible = "canaan,k210-sram";
> +        clocks = <&sysclk K210_CLK_SRAM0>,
> +                 <&sysclk K210_CLK_SRAM1>,
> +                 <&sysclk K210_CLK_AI>;
> +        clock-names = "sram0", "sram1", "aisram";
> +    };
> -- 
> 2.37.0
> 
> 
