Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 622EF27FE2D
	for <lists+dmaengine@lfdr.de>; Thu,  1 Oct 2020 13:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731767AbgJALPA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 1 Oct 2020 07:15:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:43252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726992AbgJALPA (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 1 Oct 2020 07:15:00 -0400
Received: from localhost (unknown [122.167.37.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DCD72087D;
        Thu,  1 Oct 2020 11:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601550899;
        bh=cxQnqQEDntZ0aFpinDWrTCtr5C68zBwmYfLs04V0NQ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1QmK0tqBrnzWdIfBjfeBwjFFwSWLDU31/OzJYfN/8MDFjcSmf7CNJHaHtYVmggGNx
         FRL+PrW8PPZrD3WrYbEKebFarwzn/o+IvnnYvo913WWC5FrQEXa4Giq2FDs6IHANr2
         tj1lirpAhlfroTcv6n5pGac9O3a7fUl0Ze0ifJcE=
Date:   Thu, 1 Oct 2020 16:44:54 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     dmaengine@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: dmaengine: Document qcom,gpi dma
 binding
Message-ID: <20201001111454.GW2968@vkoul-mobl>
References: <20200923063410.3431917-1-vkoul@kernel.org>
 <20200923063410.3431917-2-vkoul@kernel.org>
 <20200929184424.GA935309@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929184424.GA935309@bogus>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Rob,

On 29-09-20, 13:44, Rob Herring wrote:

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
> > +      - qcom,gpi-dma
> 
> Should be SoC specific.

Okay, will add

> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    description:
> > +      Interrupt lines for each GPII instance
> 
> GPII or GPI?

Hw uses GPII as "GPI Instance" :) so will update this

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
> > +    maxItems: 1
> 
> Not an array. Is there a maximum number of channels or 2^32 is valid?

I have not seen any max limit put, but we can be assured that it will
not go to 2^32, we can put a reasonable limit ..

Will add maximum :)

> > +
> > +  dma-channel-mask:
> > +    maxItems: 1
> 
> So up to 32 channels?

yep!

-- 
~Vinod
