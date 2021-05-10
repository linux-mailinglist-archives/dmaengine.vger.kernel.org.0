Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 061D4379378
	for <lists+dmaengine@lfdr.de>; Mon, 10 May 2021 18:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbhEJQQA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 10 May 2021 12:16:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:57426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231144AbhEJQPs (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 10 May 2021 12:15:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 567F26145C;
        Mon, 10 May 2021 16:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620663283;
        bh=dPqTcD1DJqahaa/l4cq5r1NgXdaAm5DnNU9ZoumjkIM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JNl4sn7htEeQlT0UXykoxmLbUn5B2pLm+xXcGWxYbv5fxoioNGCMBBtcHRguADybJ
         s7Y7C/xUjWRQj9gkODcrltJwq+Xbt/99rXc1sHCYdyTjo3YNWAB46bdgj7yreFa29Q
         0cvzwoBCSZ5qrr9TH06wpZtRf1sSXVvMV7PKC86bFuC7pZdAzCzeh00Xl4TH1h7Pa1
         f/JhZtAgGAlHGHH5ua8feU2/zX9fy/PtULXbeRScNXnbjLiMJfN7eSuQwrsPhnGsnX
         UfGnathZE/rgR1dA9L/3KqOo96c2+fddPHMrrU9xwlOeEJCX0fyfIIo7a2nz6omEmJ
         DsbpL1MxeHt4g==
Date:   Mon, 10 May 2021 21:44:39 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Olivier Dautricourt <olivier.dautricourt@orolia.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Stefan Roese <sr@denx.de>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: dma: add schema for altr,msgdma
Message-ID: <YJlb78AmvHdoqCG3@vkoul-mobl.Dlink>
References: <YIq/qObuYw+8ikxg@orolia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIq/qObuYw+8ikxg@orolia.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 29-04-21, 16:16, Olivier Dautricourt wrote:
> - add schema for Altera mSGDMA bindings in devicetree.
> - add myself as 'Odd fixes' maintainer for this driver

These should be two separate patches... Also threading in your patches
in broken and the 2/2 patch doesnt appear along with this in thread, pls
fix that as well

> 
> Signed-off-by: Olivier Dautricourt <olivier.dautricourt@orolia.com>
> ---
> 
> Notes:
>     Changes in v2:
>      - fix reg size in dt example
>      - fix dt_binding check warning
>      - add list in MAINTAINERS entry
> 
>     Changes from v2 to v3:
>      none
> 
>     Changes from v3 to v4:
>      none
> 
>  .../devicetree/bindings/dma/altr,msgdma.yaml  | 62 +++++++++++++++++++
>  MAINTAINERS                                   |  7 +++
>  2 files changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/altr,msgdma.yaml
> 
> diff --git a/Documentation/devicetree/bindings/dma/altr,msgdma.yaml b/Documentation/devicetree/bindings/dma/altr,msgdma.yaml
> new file mode 100644
> index 000000000000..295e46c84bf9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/altr,msgdma.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/altr,msgdma.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Altera mSGDMA IP core
> +
> +maintainers:
> +  - Olivier Dautricourt <olivier.dautricourt@orolia.com>
> +
> +description: |
> +  Altera / Intel modular Scatter-Gather Direct Memory Access (mSGDMA)
> +  intellectual property (IP)
> +
> +allOf:
> +  - $ref: "dma-controller.yaml#"
> +
> +properties:
> +  compatible:
> +    const: altr,msgdma
> +
> +  reg:
> +    description:
> +      csr, desc, resp resgisters
> +    maxItems: 3
> +    minItems: 3
> +
> +  reg-names:
> +    items:
> +      - const: csr
> +      - const: desc
> +      - const: resp
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  "#dma-cells":
> +    description: |
> +      The dma controller discards the argument but one must be specified
> +      to keep compatibility with dma-controller schema.

we can skip this

> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - interrupts
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    msgdma_controller: dma-controller@ff200b00 {
> +        compatible = "altr,msgdma";
> +        reg = <0xff200b00 0x100>, <0xff200c00 0x100>, <0xff200d00 0x100>;
> +        reg-names = "csr", "desc", "resp";
> +        interrupts = <0 67 IRQ_TYPE_LEVEL_HIGH>;
> +        #dma-cells = <1>;
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5c90148f0369..359ab4877024 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -782,6 +782,13 @@ M:	Ley Foon Tan <ley.foon.tan@intel.com>
>  S:	Maintained
>  F:	drivers/mailbox/mailbox-altera.c
> 
> +ALTERA MSGDMA IP CORE DRIVER
> +M:	Olivier Dautricourt <olivier.dautricourt@orolia.com>
> +L:	dmaengine@vger.kernel.org
> +S:	Odd Fixes
> +F:	Documentation/devicetree/bindings/dma/altr,msgdma.yaml
> +F:	drivers/dma/altera-msgdma.c
> +
>  ALTERA PIO DRIVER
>  M:	Joyce Ooi <joyce.ooi@intel.com>
>  L:	linux-gpio@vger.kernel.org
> --
> 2.31.0.rc2

-- 
~Vinod
