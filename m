Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEC31AA92E
	for <lists+dmaengine@lfdr.de>; Wed, 15 Apr 2020 15:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2636327AbgDON4I (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Apr 2020 09:56:08 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34289 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2633784AbgDON4G (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 15 Apr 2020 09:56:06 -0400
Received: by mail-oi1-f193.google.com with SMTP id x10so4081668oie.1;
        Wed, 15 Apr 2020 06:56:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ycmja0tn+Pn7vcKVk65rYKrikV3ltcIPp9BfsofNNbg=;
        b=R2/23nZpNeN4EgtKIHpqctVFgjTiMPJmhHhU2MgkLxaSXI02gVMoayRjhL6ImgfzJN
         SRcc7H3Zra7OmWX/qz5ZFe6SBMZktp2E1TEqy4CHeMYp18kLN6TxmbaorYuGBmurXA2y
         k3lVSfZadeK/XaNsKVKCRGNqEKS/Km25DKK26haJ7k0pXIhIcTi3Wy8jd0YRHsJcVfNA
         dn8bW2/dg3gkRFCWlVDiwLYr660U6s9Eu5nyAZBNHznwzG8V5885Ql9Xv4YNtwqVoa0T
         vf48n/uxxXbJGcE22q2+0CrtxpeVwJbRXi7WQaglhr525wkpjv6p9qD2iM1X1o+fSLsV
         BddA==
X-Gm-Message-State: AGi0PuaPCJfWdySgMXZzK1hiV6BRlGhRpmBEg4sWkpthF6L3ntLk35YI
        T2VFM3Luen81GNFp+37XouYYSoCxiFlKKAxgT7I=
X-Google-Smtp-Source: APiQypL7nrkHKdmMMjvyL/FTQSDq6xqx4ePXjuN5H/3sf4TBX10XlflSzg1fmpoXaLSyRw8IHWZ6Lq4ABAW5GQnpB7k=
X-Received: by 2002:aca:cdd1:: with SMTP id d200mr18214461oig.153.1586958965024;
 Wed, 15 Apr 2020 06:56:05 -0700 (PDT)
MIME-Version: 1.0
References: <1586512923-21739-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1586512923-21739-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1586512923-21739-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 15 Apr 2020 15:55:53 +0200
Message-ID: <CAMuHMdWziQYKFeZZt7ZOCYMEWxD8e3mjqf+x0xsAcA7XDzZHWQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: dma: renesas,usb-dmac: convert bindings
 to json-schema
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Vinod <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Shimoda-san,

On Fri, Apr 10, 2020 at 12:02 PM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> Convert Renesas R-Car USB-DMA Controller bindings documentation
> to json-schema.
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Thanks for your patch!

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/renesas,usb-dmac.yaml
> @@ -0,0 +1,99 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/renesas,usb-dmac.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas USB DMA Controller
> +
> +maintainers:
> +  - Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> +
> +allOf:
> +  - $ref: "dma-controller.yaml#"
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - renesas,r8a7743-usb-dmac  # RZ/G1M
> +          - renesas,r8a7744-usb-dmac  # RZ/G1N
> +          - renesas,r8a7745-usb-dmac  # RZ/G1E
> +          - renesas,r8a77470-usb-dmac # RZ/G1C
> +          - renesas,r8a774a1-usb-dmac # RZ/G2M
> +          - renesas,r8a774b1-usb-dmac # RZ/G2N
> +          - renesas,r8a774c0-usb-dmac # RZ/G2E
> +          - renesas,r8a7790-usb-dmac  # R-Car H2
> +          - renesas,r8a7791-usb-dmac  # R-Car M2-W
> +          - renesas,r8a7793-usb-dmac  # R-Car M2-N
> +          - renesas,r8a7794-usb-dmac  # R-Car E2
> +          - renesas,r8a7795-usb-dmac  # R-Car H3
> +          - renesas,r8a7796-usb-dmac  # R-Car M3-W
> +          - renesas,r8a77961-usb-dmac # R-Car M3-W+
> +          - renesas,r8a77965-usb-dmac # R-Car M3-N
> +          - renesas,r8a77990-usb-dmac # R-Car E3
> +          - renesas,r8a77995-usb-dmac # R-Car D3
> +      - const: renesas,usb-dmac
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 2

Is there a use case for specifying a single interrupt?

> +
> +  interrupt-names:
> +    maxItems: 2
> +    items:
> +      - pattern: "^ch[0-1]$"
> +      - pattern: "^ch[0-1]$"

Would it make sense to list the (two) actual channel names instead?

> +
> +  clocks:
> +    maxItems: 1
> +
> +  '#dma-cells':
> +    const: 1
> +    description:
> +      The cell specifies the channel number of the DMAC port connected to
> +      the DMA client.
> +
> +  dma-channels:
> +    maximum: 2

Is there a use case for specifying a single channel?

> +
> +  iommus:
> +    maxItems: 2

Likewise?

> +
> +  power-domains:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-names
> +  - clocks
> +  - '#dma-cells'
> +  - dma-channels

Shouldn't "power-domains" and "resets" be mandatory, too?
All covered SoCS have them.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
