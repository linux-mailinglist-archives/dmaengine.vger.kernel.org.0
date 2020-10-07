Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 815FA286285
	for <lists+dmaengine@lfdr.de>; Wed,  7 Oct 2020 17:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728785AbgJGPqi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 7 Oct 2020 11:46:38 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46136 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728019AbgJGPqi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 7 Oct 2020 11:46:38 -0400
Received: by mail-oi1-f193.google.com with SMTP id u126so2853351oif.13;
        Wed, 07 Oct 2020 08:46:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rQHCXCV/i+kaGlmPVLS4FFOvSgdOWuMGT9TwEXcskOQ=;
        b=Hz2Ok0HWgjcwr+A0z3oh4o8Kk3xAFFUiDs9FngHt6CgjJ5uCrGbzUBCJ1VoNpFgiJ7
         cQRnBxtK5xZfErIqmswT6b0wy4H0npMcWgVBQidegV/axs7O1PC/PTye8wuIFqviDl/L
         tOWzgimciWNBW8S77IPYIARwgHcCkmQeHtbu32DtLw5coIGk72HoDiHmam3w1TLkQUXg
         vgd8GQdx/7EBDIrj7wPzadl/aZQVInxUh0JEJ/yE6TA8NsgU1ZOhDRmDJQQth77kxx6u
         Tna/LgytbApc32uNM+Y/BdlIj0Cv5ziW/HB4MTN1P9BgZOrtA0r3EIHWZVJj3Uv0JQML
         +llA==
X-Gm-Message-State: AOAM5323B9sNKrINnaVKEmyM3xrEFgYBiQSBwSjTL/UTd+oDa5AXjerb
        TDmAp3qdDuOQpV1unGcJUw==
X-Google-Smtp-Source: ABdhPJzDk8KVgVgZu26G0OLEbj+MCjqT8zp2WyE6DHWNle1MsgOmCTzlodkyKJvl4XZQhj7iUJBhxw==
X-Received: by 2002:aca:bc8b:: with SMTP id m133mr2436812oif.10.1602085597093;
        Wed, 07 Oct 2020 08:46:37 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o9sm2452289oop.1.2020.10.07.08.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 08:46:36 -0700 (PDT)
Received: (nullmailer pid 278714 invoked by uid 1000);
        Wed, 07 Oct 2020 15:46:35 -0000
Date:   Wed, 7 Oct 2020 10:46:35 -0500
From:   Rob Herring <robh@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     vkoul@kernel.org, nm@ti.com, ssantosh@kernel.org, vigneshr@ti.com,
        dan.j.williams@intel.com, t-kristo@ti.com, lokeshvutla@ti.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH 09/18] dt-bindings: dma: ti: Add document for K3 BCDMA
Message-ID: <20201007154635.GA273523@bogus>
References: <20200930091412.8020-1-peter.ujfalusi@ti.com>
 <20200930091412.8020-10-peter.ujfalusi@ti.com>
 <20201006192909.GA2679155@bogus>
 <bc054ef7-dcd7-dde2-13f8-4900a33b1377@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc054ef7-dcd7-dde2-13f8-4900a33b1377@ti.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Oct 07, 2020 at 12:09:06PM +0300, Peter Ujfalusi wrote:
> 
> 
> On 06/10/2020 22.29, Rob Herring wrote:
> > On Wed, Sep 30, 2020 at 12:14:03PM +0300, Peter Ujfalusi wrote:
> >> New binding document for
> >> Texas Instruments K3 Block Copy DMA (BCDMA).
> >>
> >> BCDMA is introduced as part of AM64.
> >>
> 
> ...
> 
> > 
> >> +  ti,sci:
> >> +    description: phandle to TI-SCI compatible System controller node
> >> +    allOf:
> >> +      - $ref: /schemas/types.yaml#/definitions/phandle
> >> +
> >> +  ti,sci-dev-id:
> >> +    description: TI-SCI device id of BCDMA
> >> +    allOf:
> >> +      - $ref: /schemas/types.yaml#/definitions/uint32
> > 
> > We have a common definition for these.
> 
> Yes, in arm/keystone/ti,k3-sci-common.yaml, but I could not get to use
> that as reference.
> 
> I can not list it under the topmost allOf and drop the ti,sci and
> ti,sci-dev-id like this:
> 
> allOf:
>   - $ref: /schemas/dma/dma-controller.yaml#
>   - $ref: /schemas/arm/keystone/ti,k3-sci-common.yaml#
> 
> It results:
>   CHKDT   Documentation/devicetree/bindings/processed-schema-examples.json
>   DTEX    Documentation/devicetree/bindings/dma/ti/k3-bcdma.example.dts
>   SCHEMA  Documentation/devicetree/bindings/processed-schema-examples.json
>   DTC     Documentation/devicetree/bindings/dma/ti/k3-bcdma.example.dt.yaml
>   CHECK   Documentation/devicetree/bindings/dma/ti/k3-bcdma.example.dt.yaml
> Documentation/devicetree/bindings/dma/ti/k3-bcdma.example.dt.yaml:
> dma-controller@485c0100: 'ti,sci', 'ti,sci-dev-id' do not match any of
> the regexes: 'pinctrl-[0-9]+'
>         From schema: Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml
> 
> If I remove the "additionalProperties: false" from the schema file, then
> it compiles fine.

Yeah, you have to do 'unevaluatedProperties: false' which doesn't 
actually do anything yet, but can 'see' into $ref's.


> >> +  ti,asel:
> >> +    description: ASEL value for non slave channels
> >> +    allOf:
> > 
> > You no longer need 'allOf' here.
> 
> OK, I changed it in all instances.
> 
> > 
> >> +      - $ref: /schemas/types.yaml#/definitions/uint32
> >> +
> >> +  ti,sci-rm-range-bchan:
> >> +    description: |
> >> +      Array of BCDMA block-copy channel resource subtypes for resource
> >> +      allocation for this host
> >> +    allOf:
> >> +      - $ref: /schemas/types.yaml#/definitions/uint32-array
> >> +    minItems: 1
> >> +    # Should be enough
> >> +    maxItems: 255
> > 
> > Are there constraints for the individual elements?
> 
> In practice the subtype ID is 6bits number.
> Should I add limits to individual elements?

Yes:

items:
  maximum: 0x3f

> 
> >> +
> >> +  ti,sci-rm-range-tchan:
> >> +    description: |
> >> +      Array of BCDMA split tx channel resource subtypes for resource allocation
> >> +      for this host
> >> +    allOf:
> >> +      - $ref: /schemas/types.yaml#/definitions/uint32-array
> >> +    minItems: 1
> >> +    # Should be enough
> >> +    maxItems: 255
> >> +
> >> +  ti,sci-rm-range-rchan:
> >> +    description: |
> >> +      Array of BCDMA split rx channel resource subtypes for resource allocation
> >> +      for this host
> >> +    allOf:
> >> +      - $ref: /schemas/types.yaml#/definitions/uint32-array
> >> +    minItems: 1
> >> +    # Should be enough
> >> +    maxItems: 255
> >> +
> >> +required:
> >> +  - compatible
> >> +  - "#address-cells"
> >> +  - "#size-cells"
> >> +  - "#dma-cells"
> >> +  - reg
> >> +  - reg-names
> >> +  - msi-parent
> >> +  - ti,sci
> >> +  - ti,sci-dev-id
> >> +  - ti,sci-rm-range-bchan
> >> +  - ti,sci-rm-range-tchan
> >> +  - ti,sci-rm-range-rchan
> >> +
> >> +additionalProperties: false
> >> +
> >> +examples:
> >> +  - |+
> >> +    cbass_main {
> >> +        #address-cells = <2>;
> >> +        #size-cells = <2>;
> >> +
> >> +        main_dmss {
> >> +            compatible = "simple-mfd";
> > 
> > IMO, if it is memory-mapped, then you should be using 'simple-bus'.
> 
> We had the same discussion when I introduced the k3-udma binding and we
> have concluded on the simple-mfd as DMSS is not a bus, but contains
> different peripherals.

Ok.

Rob
