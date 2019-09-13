Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC92B1B9A
	for <lists+dmaengine@lfdr.de>; Fri, 13 Sep 2019 12:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbfIMKiD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 13 Sep 2019 06:38:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:38240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726266AbfIMKiD (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 13 Sep 2019 06:38:03 -0400
Received: from localhost (unknown [117.99.85.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1FB2208C0;
        Fri, 13 Sep 2019 10:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568371081;
        bh=oU3a12NfiJIjFSxgc9/S51/UO/lBe7aSHfdp9MwruCc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PrfDIWI0vMkjyCoUzAs7y/Epi9QYxrZm5xewcu7xyMYQ6L8vW4yyTbgfC8vj8P46w
         ZEdi3urijZJlSaO/OqSIuZrgnjlEajtQTqgvtz2YhJxwMiCXD6Tl6cVRQBhO6AAWkN
         SFADjoVPuqQopGJ5dtvjMZe7yNqyN3aHNdayYbd8=
Date:   Fri, 13 Sep 2019 16:06:54 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     robh+dt@kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, dan.j.williams@intel.com,
        devicetree@vger.kernel.org
Subject: Re: [RFC 1/3] dt-bindings: dma: Add documentation for DMA domains
Message-ID: <20190913103654.GE4392@vkoul-mobl>
References: <20190906141816.24095-1-peter.ujfalusi@ti.com>
 <20190906141816.24095-2-peter.ujfalusi@ti.com>
 <961d30ea-d707-1120-7ecf-f51c11c41891@ti.com>
 <20190908121058.GL2672@vkoul-mobl>
 <a452cd06-79ca-424d-b259-c8d60fc59772@ti.com>
 <20190912170312.GD4392@vkoul-mobl>
 <1992ccdd-78b3-f248-3d4d-76b5e6d4cb37@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1992ccdd-78b3-f248-3d4d-76b5e6d4cb37@ti.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 13-09-19, 10:21, Peter Ujfalusi wrote:
> 
> 
> On 12/09/2019 20.03, Vinod Koul wrote:
> > On 09-09-19, 09:30, Peter Ujfalusi wrote:
> > 
> >>>> or domain-dma-controller?
> >>>
> >>> I feel dma-domain-controller sounds fine as we are defining domains for
> >>> dmaengine. Another thought which comes here is that why not extend this to
> >>> slave as well and define dma-domain-controller for them as use that for
> >>> filtering, that is what we really need along with slave id in case a
> >>> specific channel is to be used by a peripheral
> >>>
> >>> Thoughts..?
> >>
> >> I have thought about this, we should be able to drop the phandle to the
> >> dma controller from the slave binding just fine.
> >>
> >> However we have the dma routers for the slave channels and there is no
> >> clear way to handle them.
> >> They are not needed for non slave channels as there is no trigger to
> >> route. In DRA7 for example we have an event router for EDMA and another
> >> one for sDMA. If a slave device is to be serviced by EDMA, the EDMA
> >> event router needs to be specified, for sDMA clients should use the sDMA
> >> event router.
> > 
> > So you have dma, xbar and client? And you need to use a specfic xbar,
> > did i get that right?
> 
> At the end yes.

:)

> EDMA have dedicated crossbar
> sDMA have dedicated crossbar

So the domain mapping should point to crossbar.

> Slave devices must use the crossbar to request channel from the DMA
> controllers. Non slave request are directed to the controllers directly
> (no DT binding).

The clients for these are different right, if so slave clients will
point to domain xbar and non slave will point to domain controller (to
make everyone use domains). Non domain get any channel ... (fallback as
well)


> At minimum we would need a new property for DMA routers.
> dma-domain-router perhaps which is pointing to the xbar.

Precisely!

> A slave channel request would first look for dma-domain-router, if it is
> there, the request goes via that.
> If not then look for dma-domain-controller and use it for the request.
> The DMA binding can drop the phandle to the xbar/dma.
> Request for not slave channel would only look for dma-domain-controller.
>
> 
> But...
> 
> - If we have one dedicated memcpy DMA and one for slave usage.
> In top we declare dma-domain-controller = <&m2m_dma>;
> 
> Then you have  a slave client somewhere
> client1: peripheral@42 {
> 	dma-domain-controller = <&slave_dma>;
> 	dmas = <6>, <7>;
> 	dma-names = "tx", "rx";
> };
> 
> This is fine I guess. But what would we do if the driver for client1
> needs additional memcpy channel? By the definition of the binding the
> non slave channel should be taken from the closest dma-domain-controller
> which is not what we want. We want the channel from m2m_dma.

I would not envision same controller needs both memcpy or slave
channels. If so, that should be represented as something like dma-names
and represent two sets of dmas one for domain1 and another for domain2.

I would generalize it and not call it memcpy/slave but just domains and
have a controller use multiple domains (if we have a super controller
which can do that :D)

client1: peripheral@42 {
        dma-domain-names = "memcpy", "slave";
        dma-domains = <&mem_dma>, <&slave_dma>;
        ...
};


> 
> And no, we can not start looking for the dma-domain-controller starting
> from the root as in most cases the dma-domain-controller closer to the
> client is what we really want and not the globally best controller.
> 
> - How to handle the transition?
>
> If neither dma-domain-controller/router is found, assume that the first
> argument in the binding is a phandle to the dma/router?
> We need to carry the support for what we have today for a long time. The
> kernel must boot with old DT blob.
> 
> - Will it make things cleaner? Atm it is pretty easy to see which
> controller/router is used for which device.
> 
> - Also to note that the EDMA and sDMA bindings are different, so we can
> not just swap dma-domain-controller/router underneath, we also need to
> modify the client's dmas line as well.
> 
> - Péter
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

-- 
~Vinod
