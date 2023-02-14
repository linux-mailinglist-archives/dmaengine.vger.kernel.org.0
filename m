Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF54696DD5
	for <lists+dmaengine@lfdr.de>; Tue, 14 Feb 2023 20:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbjBNTZt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Feb 2023 14:25:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbjBNTZs (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 14 Feb 2023 14:25:48 -0500
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF41F24C89;
        Tue, 14 Feb 2023 11:25:46 -0800 (PST)
Received: by mail-oi1-f171.google.com with SMTP id 20so13851938oix.5;
        Tue, 14 Feb 2023 11:25:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bn+df8DdmGrpzR7m5yfbSuUWTBYA0OSBCs/5jaGYhiY=;
        b=zmQOZ/CzCgu7RK4+fECPmavoaxsjsUR1TMhC0NwxqzVt16BeCCbZ+WzHmCKSHVNnXx
         EoiglnMmKSjuYfDy6z4u1vy0AH9sTF69NyaTa6kMsRBdeWeSxA5d+1J0IDsB0ewcYQiE
         fT7I8CiNXManQNwWQF1HJlBDMyS4nVdXJzL8/1b3dRUCyyTRcdHYwZUNk1De7p9IV/fX
         S0e8yGYG7Yo/pah8LSKP7Gyo1a9NcaP6zXDzychnUYOy357ASV5W8552jk23lt8vRP5f
         UycqGCEImBVdwTyh6ww+E3lPr5Iz9pItQe9oD0mRLP6mNmUbp1eotZ2KBA4CMP/tZODe
         CEFA==
X-Gm-Message-State: AO0yUKXHPiaWlI3eU8e05mJCbI1lIHz+tDggArcgAz/zER0xAWAAEun0
        lkhZfl2jHSUelSGm78SxKQ==
X-Google-Smtp-Source: AK7set8zS8/fkQnK6ddoRr7Kp4k/NOTKYxnOw/8cAVWFz3Rd407+aYQLki8KiJR1UeHk83QuI6DvNw==
X-Received: by 2002:a05:6808:8fa:b0:35e:7a54:a091 with SMTP id d26-20020a05680808fa00b0035e7a54a091mr1546008oic.48.1676402746112;
        Tue, 14 Feb 2023 11:25:46 -0800 (PST)
Received: from robh_at_kernel.org (c-67-162-147-231.hsd1.co.comcast.net. [67.162.147.231])
        by smtp.gmail.com with ESMTPSA id l6-20020acabb06000000b0035418324b78sm5727363oif.11.2023.02.14.11.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 11:25:45 -0800 (PST)
Received: (nullmailer pid 37369 invoked by uid 1000);
        Tue, 14 Feb 2023 19:25:44 -0000
Date:   Tue, 14 Feb 2023 13:25:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>, Janne Grunau <j@jannau.net>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, asahi@lists.linux.dev
Subject: Re: [RFC PATCH] dt-bindings: dma: apple,sio: Add schema
Message-ID: <20230214192544.GB27025-robh@kernel.org>
References: <20230214141053.92731-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230214141053.92731-1-povik+lin@cutebit.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Feb 14, 2023 at 03:10:53PM +0100, Martin Povišer wrote:
> Describe the SIO coprocessor which serves as pretend DMA controller on
> recent Apple platforms.
> 
> Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
> ---
> 
> Since the schema mentions a loader preparing the binding appropriately,
> here's a PR with the relevant (WIP) loader code, if anyone wants to look:
> https://github.com/AsahiLinux/m1n1/pull/286
> 
>  .../devicetree/bindings/dma/apple,sio.yaml    | 129 ++++++++++++++++++
>  1 file changed, 129 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/apple,sio.yaml
> 
> diff --git a/Documentation/devicetree/bindings/dma/apple,sio.yaml b/Documentation/devicetree/bindings/dma/apple,sio.yaml
> new file mode 100644
> index 000000000000..a76cc8265e76
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/apple,sio.yaml
> @@ -0,0 +1,129 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/apple,sio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Apple SIO Coprocessor
> +
> +description: |

Don't need '|'.

> +  SIO is a coprocessor on Apple M1 and later chips (and maybe also on earlier
> +  chips). Its role is to offload SPI, UART and DisplayPort audio transfers,
> +  being a pretend DMA controller.
> +
> +maintainers:
> +  - Martin Povišer <povik+lin@cutebit.org>
> +
> +allOf:
> +  - $ref: "dma-controller.yaml#"

Drop quotes.

> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - apple,t6000-sio
> +          - apple,t8103-sio
> +      - const: apple,sio
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#dma-cells':
> +    const: 1
> +    description:
> +      DMA clients specify a single cell that corresponds to the RTKit endpoint
> +      number used for arranging the transfers in question
> +
> +  dma-channels:
> +    maximum: 128
> +
> +  mboxes:
> +    maxItems: 1
> +
> +  iommus:
> +    maxItems: 1
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  memory-region:
> +    description:
> +      A number of references to reserved memory regions among which are the DATA/TEXT
> +      sections of coprocessor executable firmware and also auxiliary firmware data
> +      describing the available DMA-enabled peripherals

Can you define some range of number of entries.

> +
> +  apple,sio-firmware-params:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description: |
> +      Parameters in the form of opaque key/value pairs that are to be sent to the SIO
> +      coprocesssor once it boots. These parameters can refer to the reserved memory
> +      regions described in 'memory-region'.
> +
> +      Note that unlike Apple's firmware, we treat the parameters, and the data they
> +      refer to, as opaque. Apple embed short data blobs into their SIO devicetree node
> +      that describe the DMA-enabled peripherals (presumably with defined semantics).
> +      Their driver processes those blobs and sets up data structure in mapped device
> +      memory, then references this memory in the parameters sent to the SIO. At the
> +      level of description we are opting for in this binding, we assume the job of
> +      constructing those data structures has been done in advance, leaving behind an
> +      opaque list of key/value parameter pairs to be sent by a prospective driver.
> +
> +      This approach is chosen for two reasons:
> +
> +       - It means we don't need to try to understand the semantics of Apple's blobs
> +         as long as we know the transformation we need to do from Apple's devicetree
> +         data to SIO data (which can be shoved away into a loader). It also means the
> +         semantics of Apple's blobs (or of something to replace them) need not be part
> +         of the binding and be kept up with Apple's firmware changes in the future.
> +
> +       - It leaves less work for the driver attaching on this binding. Instead the work
> +         is done upfront in the loader which can be better suited for keeping up with
> +         Apple's firmware changes.
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#dma-cells'
> +  - dma-channels
> +  - mboxes
> +  - iommus
> +  - power-domains
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/apple-aic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    aic: interrupt-controller {
> +      interrupt-controller;
> +      #interrupt-cells = <3>;
> +    };
> +
> +    sio_mbox: mbox@36408000 {
> +      compatible = "apple,t8103-asc-mailbox", "apple,asc-mailbox-v4";
> +      reg = <0x36408000 0x4000>;
> +      interrupt-parent = <&aic>;
> +      interrupts = <AIC_IRQ 640 IRQ_TYPE_LEVEL_HIGH>,
> +                   <AIC_IRQ 641 IRQ_TYPE_LEVEL_HIGH>,
> +                   <AIC_IRQ 642 IRQ_TYPE_LEVEL_HIGH>,
> +                   <AIC_IRQ 643 IRQ_TYPE_LEVEL_HIGH>;
> +      interrupt-names = "send-empty", "send-not-empty",
> +                        "recv-empty", "recv-not-empty";
> +      #mbox-cells = <0>;
> +      power-domains = <&ps_sio>;
> +    };

Drop. Don't need to show providers.

> +
> +    sio: dma-controller@36400000 {
> +      status = "disabled"; /* To be filled by loader */

Drop. Examples should be enabled so we can validate them.

> +      compatible = "apple,t8103-sio", "apple,sio";
> +      reg = <0x36400000 0x8000>;
> +      dma-channels = <128>;
> +      #dma-cells = <1>;
> +      mboxes = <&sio_mbox>;
> +      iommus = <&sio_dart 0>;
> +      power-domains = <&ps_sio_cpu>;
> +      memory-region = <0x0>; /* To be filled by loader */
> +      apple,sio-firmware-params = <0x0>; /* To be filled by loader */
> +    };
> -- 
> 2.33.0
