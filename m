Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C25028FED6
	for <lists+dmaengine@lfdr.de>; Fri, 16 Oct 2020 09:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394401AbgJPHGY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 16 Oct 2020 03:06:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:43014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394374AbgJPHGY (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 16 Oct 2020 03:06:24 -0400
Received: from localhost (unknown [122.182.237.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59CC320720;
        Fri, 16 Oct 2020 07:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602831983;
        bh=bg+YekF+PjfIIMGx3SUCBgRM+vVNcEeNxcknchyB36I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=waMS4eMW7q+rFjqGaN2EZQEXLMHgOLzBfrw7R6RdwAlfEB9/n6PIpsBs6jZaf5kzm
         2Nij6X6vzV1QsD0xXWb0KQY8b/r7YvHbR4q1jZiaay/qJJAL94oXDVdZ1eMKIaUhp1
         pAYHtsjCh5KuL4SWxHy9T6cy9pClC/O1CtIKggNM=
Date:   Fri, 16 Oct 2020 12:36:18 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Eugen.Hristev@microchip.com
Cc:     robh@kernel.org, Tudor.Ambarus@microchip.com,
        Ludovic.Desroches@microchip.com, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Nicolas.Ferre@microchip.com
Subject: Re: [PATCH 6/7] dt-bindings: dmaengine: at_xdmac: add optional
 microchip,m2m property
Message-ID: <20201016070618.GW2968@vkoul-mobl>
References: <20200914140956.221432-1-eugen.hristev@microchip.com>
 <20200914140956.221432-7-eugen.hristev@microchip.com>
 <20200922233327.GA3474555@bogus>
 <6f305564-e91c-794b-0025-de805f1d1a58@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f305564-e91c-794b-0025-de805f1d1a58@microchip.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Eugen,

On 16-10-20, 06:45, Eugen.Hristev@microchip.com wrote:
> On 23.09.2020 02:33, Rob Herring wrote:
> 
> > On Mon, Sep 14, 2020 at 05:09:55PM +0300, Eugen Hristev wrote:
> >> Add optional microchip,m2m property that specifies if a controller is
> >> dedicated to memory to memory operations only.
> >>
> >> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> >> ---
> >>   Documentation/devicetree/bindings/dma/atmel-xdma.txt | 6 ++++++
> >>   1 file changed, 6 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/dma/atmel-xdma.txt b/Documentation/devicetree/bindings/dma/atmel-xdma.txt
> >> index 510b7f25ba24..642da6b95a29 100644
> >> --- a/Documentation/devicetree/bindings/dma/atmel-xdma.txt
> >> +++ b/Documentation/devicetree/bindings/dma/atmel-xdma.txt
> >> @@ -15,6 +15,12 @@ the dmas property of client devices.
> >>       interface identifier,
> >>       - bit 30-24: PERID, peripheral identifier.
> >>
> >> +Optional properties:
> >> +- microchip,m2m: this controller is connected on AXI only to memory and it's
> >> +     dedicated to memory to memory DMA operations. If this option is
> >> +     missing, it's assumed that the DMA controller is connected to
> >> +     peripherals, thus it's a per2mem and mem2per.
> > 
> > Wouldn't 'dma-requests = <0>' cover this case?
> > 
> > Rob
> > 
> 
> Hi Rob,
> 
> I do not think so. With requests = 0, it means that actually the DMA 
> controller is unusable ?
> Since you suggest requests = 0, it means that it cannot take requests at 
> all ?
> I do not find another example in current DT with this property set to zero.

Not really, dma-requests implies "request signals supported" which are
used for peripheral cases. m2m does not need request signals, so it is
very reasonable to conclude that dma-requests = <0> would imply no
peripheral support and only m2m support.

Thanks
-- 
~Vinod
