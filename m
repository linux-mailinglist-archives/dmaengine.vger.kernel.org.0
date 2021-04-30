Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5A636F769
	for <lists+dmaengine@lfdr.de>; Fri, 30 Apr 2021 10:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbhD3I4t (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 30 Apr 2021 04:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbhD3I4t (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 30 Apr 2021 04:56:49 -0400
X-Greylist: delayed 100386 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 30 Apr 2021 01:56:01 PDT
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [IPv6:2001:67c:2050:1::465:107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C777C06174A;
        Fri, 30 Apr 2021 01:56:01 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4FWmRx73FvzQjp3;
        Fri, 30 Apr 2021 10:55:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id Tl5rxeJGiWZH; Fri, 30 Apr 2021 10:55:53 +0200 (CEST)
Subject: Re: [PATCH v4 1/2] dt-bindings: dma: add schema for altr,msgdma
To:     Olivier Dautricourt <olivier.dautricourt@orolia.com>,
        Rob Herring <robh+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <YIq/qObuYw+8ikxg@orolia.com>
From:   Stefan Roese <sr@denx.de>
Message-ID: <1c112356-ebfd-bcf0-6cee-60903c171b9b@denx.de>
Date:   Fri, 30 Apr 2021 10:55:52 +0200
MIME-Version: 1.0
In-Reply-To: <YIq/qObuYw+8ikxg@orolia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -7.83 / 15.00 / 15.00
X-Rspamd-Queue-Id: 761031882
X-Rspamd-UID: a3f292
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 29.04.21 16:16, Olivier Dautricourt wrote:
> - add schema for Altera mSGDMA bindings in devicetree.
> - add myself as 'Odd fixes' maintainer for this driver
> 
> Signed-off-by: Olivier Dautricourt <olivier.dautricourt@orolia.com>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
> 
> Notes:
>      Changes in v2:
>       - fix reg size in dt example
>       - fix dt_binding check warning
>       - add list in MAINTAINERS entry
> 
>      Changes from v2 to v3:
>       none
> 
>      Changes from v3 to v4:
>       none
> 
>   .../devicetree/bindings/dma/altr,msgdma.yaml  | 62 +++++++++++++++++++
>   MAINTAINERS                                   |  7 +++
>   2 files changed, 69 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/dma/altr,msgdma.yaml
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
>   S:	Maintained
>   F:	drivers/mailbox/mailbox-altera.c
> 
> +ALTERA MSGDMA IP CORE DRIVER
> +M:	Olivier Dautricourt <olivier.dautricourt@orolia.com>
> +L:	dmaengine@vger.kernel.org
> +S:	Odd Fixes
> +F:	Documentation/devicetree/bindings/dma/altr,msgdma.yaml
> +F:	drivers/dma/altera-msgdma.c
> +
>   ALTERA PIO DRIVER
>   M:	Joyce Ooi <joyce.ooi@intel.com>
>   L:	linux-gpio@vger.kernel.org
> --
> 2.31.0.rc2
> 


Viele Grüße,
Stefan

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
