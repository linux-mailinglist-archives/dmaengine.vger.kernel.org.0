Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06C113722DC
	for <lists+dmaengine@lfdr.de>; Tue,  4 May 2021 00:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbhECWHb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 3 May 2021 18:07:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:39554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229497AbhECWHa (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 3 May 2021 18:07:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2A3B4610FC;
        Mon,  3 May 2021 22:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620079597;
        bh=6b/U8Seq5uofAuhoy2eEbBzUlcdWBAkxOW6Z/HujxnU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=J6/TxQDzklxOuba6XTDFeoj8ulloUfn4K1aTn3IW2+FLy/oPa58LESNqOH9oYxeX7
         eFxIw8tkCMjAybbPPaDOKl0rIl7NqSkJggLUZ2NuWa0UsbjZ6AQobDlsOPYox8bcmH
         jTMv0wr0lUAXSz0r1B63FiUp17r5t6/4yG5PQodYcPdBu14c2RcfeYbakoNEy/RbSr
         sG8gLw7+E4R0bs1ko8PWhws8mTQJLjx7M4I7E8OYEeiWDUNRNt3Lnt/BeCFv2Egm2M
         R+9QeZ+IxVeRNIU8ABxZDrQWurIYbIHFoGJQyDNxL4DrzHz34UEaFF/SlXb/i8ZXyc
         kl+FVIjEuk8pw==
Received: by mail-ed1-f43.google.com with SMTP id e7so8132636edu.10;
        Mon, 03 May 2021 15:06:37 -0700 (PDT)
X-Gm-Message-State: AOAM532cwYXuKpunaNfJIOoD8GiOZL7sUsiwk53LVHVCCMgOPgArAMNx
        8opbbAweUzdwcGlFN9v2AEOcTTGs3rBMoSMWPg==
X-Google-Smtp-Source: ABdhPJw+i4aK04IeE/ccNTgCMAXtyvNb57tOJTCXaITCldFzEumSKUvT2WxfUUabDek/J0g022bwANQtx03q0z4KFg0=
X-Received: by 2002:a05:6402:84b:: with SMTP id b11mr22728486edz.289.1620079595815;
 Mon, 03 May 2021 15:06:35 -0700 (PDT)
MIME-Version: 1.0
References: <YIq/qObuYw+8ikxg@orolia.com>
In-Reply-To: <YIq/qObuYw+8ikxg@orolia.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 3 May 2021 17:06:23 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJc=EDhXNcb4QZbmD1Ukh94hqLhk4YvN4SoCdt32TGMSg@mail.gmail.com>
Message-ID: <CAL_JsqJc=EDhXNcb4QZbmD1Ukh94hqLhk4YvN4SoCdt32TGMSg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: dma: add schema for altr,msgdma
To:     Olivier Dautricourt <olivier.dautricourt@orolia.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Stefan Roese <sr@denx.de>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Apr 29, 2021 at 9:16 AM Olivier Dautricourt
<olivier.dautricourt@orolia.com> wrote:
>
> - add schema for Altera mSGDMA bindings in devicetree.
> - add myself as 'Odd fixes' maintainer for this driver

While I guess valid, the tools (b4) don't like the '/' in your
message-id. Lore will escape it fine, but then you have to escape the
url. Would be nice to avoid all that, but maybe this is Exchange's
doing?

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

Needs an SoC specific compatible.

> +
> +  reg:
> +    description:
> +      csr, desc, resp resgisters

Expand what each region is:

reg:
  items:
    - description: ...
    - description: ...
    - description: ...

> +    maxItems: 3
> +    minItems: 3

And then drop this.

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
> @@ -782,6 +782,13 @@ M: Ley Foon Tan <ley.foon.tan@intel.com>
>  S:     Maintained
>  F:     drivers/mailbox/mailbox-altera.c
>
> +ALTERA MSGDMA IP CORE DRIVER
> +M:     Olivier Dautricourt <olivier.dautricourt@orolia.com>
> +L:     dmaengine@vger.kernel.org
> +S:     Odd Fixes
> +F:     Documentation/devicetree/bindings/dma/altr,msgdma.yaml
> +F:     drivers/dma/altera-msgdma.c
> +
>  ALTERA PIO DRIVER
>  M:     Joyce Ooi <joyce.ooi@intel.com>
>  L:     linux-gpio@vger.kernel.org
> --
> 2.31.0.rc2
>
