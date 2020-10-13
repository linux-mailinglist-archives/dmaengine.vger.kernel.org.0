Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E65F828C8ED
	for <lists+dmaengine@lfdr.de>; Tue, 13 Oct 2020 09:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389837AbgJMHCg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Oct 2020 03:02:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:46274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389813AbgJMHCe (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 13 Oct 2020 03:02:34 -0400
Received: from localhost (unknown [122.171.192.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CEB820678;
        Tue, 13 Oct 2020 07:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602572553;
        bh=CdGLyzoceA7IR6xBCuhHfMXfwiqH0FI40eWrZh6vN8E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=obJm+8kbS5+6mrjArdd0VtzEKE8xfL48hSr7fFvT+NcCRiOiH/Hs9Gi9IkPPEgy6Z
         1XOMSHY/FCCDe/IWN5YV3RrwC+tbkvh6Xkme9VrtZiGUcjb70KxFhB5ypKifn3ZhRn
         m5Tic5NStQOSnhQ46AMBmdR9Gi2yyIvVCbxUjpFg=
Date:   Tue, 13 Oct 2020 12:32:26 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     dmaengine@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: dmaengine: Document qcom,gpi dma
 binding
Message-ID: <20201013070226.GO2968@vkoul-mobl>
References: <20201008123151.764238-1-vkoul@kernel.org>
 <20201008123151.764238-2-vkoul@kernel.org>
 <20201012185737.GA1905980@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012185737.GA1905980@bogus>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 12-10-20, 13:57, Rob Herring wrote:
> On Thu, Oct 08, 2020 at 06:01:49PM +0530, Vinod Koul wrote:
> > Add devicetree binding documentation for GPI DMA controller
> > implemented on Qualcomm SoCs
> > 
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > ---
> >  .../devicetree/bindings/dma/qcom,gpi.yaml     | 86 +++++++++++++++++++
> >  include/dt-bindings/dma/qcom-gpi.h            | 11 +++
> >  2 files changed, 97 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/dma/qcom,gpi.yaml
> >  create mode 100644 include/dt-bindings/dma/qcom-gpi.h
> > 
> > diff --git a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
> > new file mode 100644
> > index 000000000000..4470c1b2fd6c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
> > @@ -0,0 +1,86 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/dma/qcom,gpi.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Qualcomm Technologies Inc GPI DMA controller
> > +
> > +maintainers:
> > +  - Vinod Koul <vkoul@kernel.org>
> > +
> > +description: |
> > +  QCOM GPI DMA controller provides DMA capabilities for
> > +  peripheral buses such as I2C, UART, and SPI.
> > +
> > +allOf:
> > +  - $ref: "dma-controller.yaml#"
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - qcom,sdm845-gpi-dma
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    description:
> > +      Interrupt lines for each GPI instance
> > +    maxItems: 13
> > +
> > +  "#dma-cells":
> > +    const: 3
> > +    description: >
> > +      DMA clients must use the format described in dma.txt, giving a phandle
> > +      to the DMA controller plus the following 3 integer cells:
> > +      - channel: if set to 0xffffffff, any available channel will be allocated
> > +        for the client. Otherwise, the exact channel specified will be used.
> > +      - seid: serial id of the client as defined in the SoC documentation.
> > +      - client: type of the client as defined in dt-bindings/dma/qcom-gpi.h
> > +
> > +  iommus:
> > +    maxItems: 1
> > +
> > +  dma-channels:
> > +    maximum: 31
> > +
> > +  dma-channel-mask:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - "#dma-cells"
> > +  - iommus
> > +  - dma-channels
> > +  - dma-channel-mask
> 
> additionalProperties: false
> 
> With that,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks will update while applying ... after merge window

-- 
~Vinod
