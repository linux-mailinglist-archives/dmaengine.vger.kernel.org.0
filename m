Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1D225175B
	for <lists+dmaengine@lfdr.de>; Tue, 25 Aug 2020 13:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729910AbgHYLVO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 25 Aug 2020 07:21:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:34822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728117AbgHYLVM (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 25 Aug 2020 07:21:12 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7453620706;
        Tue, 25 Aug 2020 11:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598354471;
        bh=gKhV2+vHVml11hPxpE6g99RzbP9Ikk/XDV6czeRZWJo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OCD70bXXXE8HaVxTxmOEEB9JAODla8x0GLBHcc8xWxwI02RUalAKVJxwLxBmmWh7m
         1TQ+h6jpA0MJf+IRcq0coHh5oZEzJ0NONB4pAWqvf91AXH11SBjufk2+h3yqHJco24
         4Ccq49oBxjrZz7zFX9DMvhGMIVfjXb5fVadAZrYk=
Date:   Tue, 25 Aug 2020 16:51:07 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "Reddy, MallikarjunaX" <mallikarjunax.reddy@linux.intel.com>
Cc:     Rob Herring <robh@kernel.org>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, chuanhua.lei@linux.intel.com,
        malliamireddy009@gmail.com
Subject: Re: [PATCH v5 1/2] dt-bindings: dma: Add bindings for intel LGM SOC
Message-ID: <20200825112107.GN2639@vkoul-mobl>
References: <cover.1597381889.git.mallikarjunax.reddy@linux.intel.com>
 <68c77fd2ffb477aa4a52a58f8a26bfb191d3c5d1.1597381889.git.mallikarjunax.reddy@linux.intel.com>
 <20200814203222.GA2674896@bogus>
 <7cdc0587-8b4f-4360-a303-1541c9ad57b2@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7cdc0587-8b4f-4360-a303-1541c9ad57b2@linux.intel.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 18-08-20, 15:00, Reddy, MallikarjunaX wrote:

> > > +
> > > +            intel,chans:
> > > +              $ref: /schemas/types.yaml#/definitions/uint32-array
> > > +              description:
> > > +                 The channels included on this port. Format is channel start
> > > +                 number and how many channels on this port.
> > Why does this need to be in DT? This all seems like it can be in the dma
> > cells for each client.
> (*ABC)
> Yes. We need this.
> for dma0(lgm-cdma) old SOC supports 16 channels and the new SOC supports 22
> channels. and the logical channel mapping for the peripherals also differ
> b/w old and new SOCs.
> 
> Because of this hardware limitation we are trying to configure the total
> channels and port-channel mapping dynamically from device tree.
> 
> based on port name we are trying to configure the default values for
> different peripherals(ports).
> Example: burst length is not same for all ports, so using port name to do
> default configurations.

Sorry that does not make sense to me, why not specify the values to be
used here instead of defining your own name scheme!

Only older soc it should create 16 channels and new 22 (hint this is hw
description so perfectly okay to specify in DT or in using driver_data
and compatible for each version

> > 
> > > +
> > > +          required:
> > > +            - reg
> > > +            - intel,name
> > > +            - intel,chans
> > > +
> > > +
> > > + ldma-channels:
> > > +    type: object
> > > +    description:
> > > +       This sub-node must contain a sub-node for each DMA channel.
> > > +    properties:
> > > +      '#address-cells':
> > > +        const: 1
> > > +      '#size-cells':
> > > +        const: 0
> > > +
> > > +    patternProperties:
> > > +      "^ldma-channels@[0-15]+$":
> > > +          type: object
> > > +
> > > +          properties:
> > > +            reg:
> > > +              items:
> > > +                - enum: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]
> > > +              description:
> > > +                 Which channel this node refers to.
> > > +
> > > +            intel,desc_num:
> > > +              $ref: /schemas/types.yaml#/definitions/uint32
> > > +              description:
> > > +                 Per channel maximum descriptor number. The max value is 255.
> > > +
> > > +            intel,hdr-mode:
> > > +              $ref: /schemas/types.yaml#/definitions/uint32-array
> > > +              description:
> > > +                 The first parameter is header mode size, the second
> > > +                 parameter is checksum enable or disable. If enabled,
> > > +                 header mode size is ignored. If disabled, header mode
> > > +                 size must be provided.
> > > +
> > > +            intel,hw-desc:
> > > +              $ref: /schemas/types.yaml#/definitions/uint32-array
> > > +              description:
> > > +                 Per channel dma hardware descriptor configuration.
> > > +                 The first parameter is descriptor physical address and the
> > > +                 second parameter hardware descriptor number.
> > Again, this all seems like per client information for dma cells.
>  Ok, if we move all these attributes to 'dmas' then 'dma-channels' child
> node is not needed in dtsi.
> #dma-cells number i am already using 7. If we move all these attributes to
> 'dmas' then integer cells will increase.
> 
> Is there any limitation in using a number of integer cells & as determined
> by the #dma-cells property?

No I dont think there is but it needs to make sense :-)

-- 
~Vinod
