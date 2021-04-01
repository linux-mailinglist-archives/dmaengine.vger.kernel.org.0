Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0256E35185E
	for <lists+dmaengine@lfdr.de>; Thu,  1 Apr 2021 19:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234560AbhDARpp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 1 Apr 2021 13:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234764AbhDARjr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 1 Apr 2021 13:39:47 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2334FC02D568;
        Thu,  1 Apr 2021 08:52:08 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id c16so2234767oib.3;
        Thu, 01 Apr 2021 08:52:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VCJBZCXzAN+MxhllMnbhP5O5FvIPxJsE/5NIO5Ghwkc=;
        b=KDPuG1BeodZ8SthOC7zoM+8VONfwwJlEXqETMz7NETaJ/pJZxRQcr4PRNnEd2slwJc
         g1quqAt6W+V69ME6XW7lf40Nzu4NXC2t0Wo+EuiwkxvNmf+9WrdJwi/wuPU9tspBjn17
         lWSerHrsLqTML0jIQIvV4hDnIMxP3tsPlchDRETS7yruDmcWrbgP18GlQNELti/K4p+t
         ewHVSwCZnGMsQW29DumXY1JOFaFS2SpFYlF+xZyVpthpx46sQRLUza4KtJc40fcY4K9Z
         J+4XYCwOOUe8BzTrBTmLEeZ+BKc7kncCMpVUdJOp//FSDzEgORUtDYTcr0wa8xl69C8N
         UsQg==
X-Gm-Message-State: AOAM532wPoC1Hso9vad2yBGVcG/us4i3Gql3nKdzHzuIc1kbzoOH9NVM
        VBLSkYVorzcuuOKoBEVbZQ==
X-Google-Smtp-Source: ABdhPJxO9AoojIw/ebyZy4l8CETZvf8HZLdBQLapN1YEqr92AAk3qapozPuPsyUw7Xyz7HD7HnFZEw==
X-Received: by 2002:aca:4e55:: with SMTP id c82mr6392280oib.43.1617292325284;
        Thu, 01 Apr 2021 08:52:05 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s21sm1178599oos.5.2021.04.01.08.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 08:52:03 -0700 (PDT)
Received: (nullmailer pid 496890 invoked by uid 1000);
        Thu, 01 Apr 2021 15:52:01 -0000
Date:   Thu, 1 Apr 2021 10:52:01 -0500
From:   Rob Herring <robh@kernel.org>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Benoit Parrot <bparrot@ti.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Alexandre Courbot <acourbot@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Helen Koike <helen.koike@collabora.com>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Peter Chen <peter.chen@nxp.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        dmaengine@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: Re: [PATCH 12/16] dt-bindings: media: Add DT bindings for TI CSI2RX
 driver
Message-ID: <20210401155201.GA488101@robh.at.kernel.org>
References: <20210330173348.30135-1-p.yadav@ti.com>
 <20210330173348.30135-13-p.yadav@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330173348.30135-13-p.yadav@ti.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Mar 30, 2021 at 11:03:44PM +0530, Pratyush Yadav wrote:
> TI's J721E uses the Cadence CSI2RX and DPHY peripherals to facilitate
> capture over a CSI-2 bus. The TI CSI2RX platform driver glues all the
> parts together.
> 
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> ---
>  .../devicetree/bindings/media/ti,csi2rx.yaml  | 70 +++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/ti,csi2rx.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/ti,csi2rx.yaml b/Documentation/devicetree/bindings/media/ti,csi2rx.yaml
> new file mode 100644
> index 000000000000..ebd894364391
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/ti,csi2rx.yaml
> @@ -0,0 +1,70 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/ti,csi2rx.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI CSI2RX Wrapper Device Tree Bindings
> +
> +maintainers:
> +  - Pratyush Yadav <p.yadav@ti.com>
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: ti,csi2rx
> +
> +  dmas:
> +    description: RX DMA Channel 0

items:
  - description: RX DMA Channel 0

Or just 'maxItems: 1'

> +
> +  dma-names:
> +    items:
> +      - const: rx0
> +
> +  reg:
> +    maxItems: 1
> +    description: Base address and size of the TI wrapper registers.

That's all 'reg' properties, drop 'description'.

> +
> +  power-domains:
> +    maxItems: 1
> +    description:
> +      PM domain provider node and an args specifier containing
> +      the device id value.

Drop.

> +
> +  ranges: true
> +
> +  "#address-cells":
> +    const: 2
> +
> +  "#size-cells":
> +    const: 2
> +
> +patternProperties:
> +  "csi-bridge@":

"^csi-bridge@"

> +    type: object
> +    description: CSI2 bridge node.

Just an empty node?

> +
> +required:
> +  - compatible
> +  - reg
> +  - dmas
> +  - dma-names
> +  - power-domains
> +  - "#address-cells"
> +  - "#size-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/soc/ti,sci_pm_domain.h>
> +
> +    ti_csi2rx0: ticsi2rx {
> +        compatible = "ti,csi2rx";
> +        dmas = <&main_udmap 0x4940>;
> +        dma-names = "rx0";
> +        reg = <0x0 0x4500000 0x0 0x1000>;
> +        power-domains = <&k3_pds 26 TI_SCI_PD_EXCLUSIVE>;
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +    };
> -- 
> 2.30.0
> 
