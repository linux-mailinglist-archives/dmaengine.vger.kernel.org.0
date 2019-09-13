Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7423AB2124
	for <lists+dmaengine@lfdr.de>; Fri, 13 Sep 2019 15:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389691AbfIMNeX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 13 Sep 2019 09:34:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:40056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389172AbfIMNeW (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 13 Sep 2019 09:34:22 -0400
Received: from localhost (unknown [106.51.107.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AB30205ED;
        Fri, 13 Sep 2019 13:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568381661;
        bh=ena8FGoa/yE4ul4093QZR0zMnN1OaRh0oMqi3gLLeIg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dLa1oq0UwfvKlyWRccDy0PwkCZ2tnNgnNB1nTg2FctHyJ3zsArLkPOM0T8aDEOigu
         reYzbSkRwwzXM+fBwajRMINlEl8QxMIxAg8thRkhLzu5QPBjaNU3OeAZM8IpYZFxd3
         nHnHVc9gJLxzw40KiL+y8m+xX6V5W/2vku4S8Cns=
Date:   Fri, 13 Sep 2019 19:03:13 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     robh+dt@kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, dan.j.williams@intel.com,
        devicetree@vger.kernel.org
Subject: Re: [RFC 1/3] dt-bindings: dma: Add documentation for DMA domains
Message-ID: <20190913133313.GF4392@vkoul-mobl>
References: <20190906141816.24095-1-peter.ujfalusi@ti.com>
 <20190906141816.24095-2-peter.ujfalusi@ti.com>
 <961d30ea-d707-1120-7ecf-f51c11c41891@ti.com>
 <20190908121058.GL2672@vkoul-mobl>
 <a452cd06-79ca-424d-b259-c8d60fc59772@ti.com>
 <20190912170312.GD4392@vkoul-mobl>
 <1992ccdd-78b3-f248-3d4d-76b5e6d4cb37@ti.com>
 <20190913103654.GE4392@vkoul-mobl>
 <12accd8e-a8ad-1ac6-d394-6f4d90011c9f@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <12accd8e-a8ad-1ac6-d394-6f4d90011c9f@ti.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 13-09-19, 15:19, Peter Ujfalusi wrote:
> Vinod,
> 
> On 13/09/2019 13.36, Vinod Koul wrote:
> >>> So you have dma, xbar and client? And you need to use a specfic xbar,
> >>> did i get that right?
> >>
> >> At the end yes.
> > 
> > :)
> > 
> >> EDMA have dedicated crossbar
> >> sDMA have dedicated crossbar
> > 
> > So the domain mapping should point to crossbar.
> > 
> >> Slave devices must use the crossbar to request channel from the DMA
> >> controllers. Non slave request are directed to the controllers directly
> >> (no DT binding).
> > 
> > The clients for these are different right, if so slave clients will
> > point to domain xbar and non slave will point to domain controller (to
> > make everyone use domains). Non domain get any channel ... (fallback as
> > well)
> > 
> > 
> >> At minimum we would need a new property for DMA routers.
> >> dma-domain-router perhaps which is pointing to the xbar.
> > 
> > Precisely!
> 
> After some thinking at the end we have two main type of DMA channels:
> slave channels: Hw triggered channels
> non-slave channels: SW triggered channels w/o DMA request lines
> 
> right?

yes and no

You are correct in saying this but I would like to move away from the
two concepts and generalize them a bit, it is long overdue.

So from domain point of view, we have channels (memcpy/slave) specifying
one or more domains to use or no domain (memcpy, any channel)

> Slave channels must be described in DT as we need to specify the DMA
> request number/line/trigger, whatever it is called on different platforms.

So in the cases where a specific channel/request/trigger is required, we
would be required to specify that in DT as we do currently, but more
modern controllers which uses muxes wont need this to be specified,
pointing to domain (which can be controller/xbar) would do the trick!


> non-slave channels on the other hand can be requested from any
> controllers which can execute it. Or in the scope of this series, from
> the controller which is best suited to service the device or module.

Right which takes care of your new requirement as well as older ones

> If we really want to move to similar binding structure as interrupts
> opposed to what we have atm (gpio, pwm, leds, etc uses the same
> principle), then
> 
> dma-slave-controller: can point to a dma controller or dma router which
> should be used from the node it is presented inherited by it's child
> nodes for slave channels.
> 
> dma-nonslave-controller: can point to a dma controller which should be
> used from the node it is presented inherited by it's child nodes for non
> slave channels.
> 
> DMA routers have the phandle for the dma controller they are attached
> to, so this should be fine, I guess.
> 
> Based on the topology of the SoC, these can be added in higher level in
> the tree to divert from the higher level controller selection.

Looks interesting to me and doable. But as I said earlier, lets do a bit
more generalization in concepts please

> >> A slave channel request would first look for dma-domain-router, if it is
> >> there, the request goes via that.
> >> If not then look for dma-domain-controller and use it for the request.
> >> The DMA binding can drop the phandle to the xbar/dma.
> >> Request for not slave channel would only look for dma-domain-controller.
> >>
> >>
> >> But...
> >>
> >> - If we have one dedicated memcpy DMA and one for slave usage.
> >> In top we declare dma-domain-controller = <&m2m_dma>;
> >>
> >> Then you have  a slave client somewhere
> >> client1: peripheral@42 {
> >> 	dma-domain-controller = <&slave_dma>;
> >> 	dmas = <6>, <7>;
> >> 	dma-names = "tx", "rx";
> >> };
> >>
> >> This is fine I guess. But what would we do if the driver for client1
> >> needs additional memcpy channel? By the definition of the binding the
> >> non slave channel should be taken from the closest dma-domain-controller
> >> which is not what we want. We want the channel from m2m_dma.
> > 
> > I would not envision same controller needs both memcpy or slave
> > channels. If so, that should be represented as something like dma-names
> > and represent two sets of dmas one for domain1 and another for domain2.
> > 
> > I would generalize it and not call it memcpy/slave but just domains and
> > have a controller use multiple domains (if we have a super controller
> > which can do that :D)
> > 
> > client1: peripheral@42 {
> >         dma-domain-names = "memcpy", "slave";
> >         dma-domains = <&mem_dma>, <&slave_dma>;
> >         ...
> > };
> 
> Right, similar thing should work, I guess.
> 
> / {
> 	/* DDR to DDR is used in main_udmap */
> 	dma-domain-names = "memcpy";
> 	dma-domains = <&main_udmap>;
> 
> 	cbass_main {
> 		/* memcpy is from main_udmap and slaves also */
> 		dma-domain-names = "slave";
> 		dma-domains = <&main_udmap>;
> 
> 		cbass_mcu {
> 			/* memcpy is from mcu_udmap and slaves also */
> 			dma-domain-names = "memcpy", "slave";
> 			dma-domains = <&mcu_udmap>, <&mcu_udmap>;
> 
> 		};
> 	};
> };
> 
> or
> 
> / {
> 	/* memcpy is from edma and slaves also */
> 	dma-domain-names = "memcpy", "slave";
> 	dma-domains = <&edma>, <&edma>;
> 
> 	edma_xbar1 xbar@0 {
> 		/*
> 		 * DMA router on front of edma,
> 		 * optionally can be explicitly tell the DMA controller
> 		 * to be used with the router if needed.
> 		 */
> 
> 		dma-domain-names = "slave";
> 		dma-domains = <&main_udmap>;
> 	};
> 
> 	mcbsp muxed_dma@0 {
> 		/* memcpy is from edma and slaves from edma_xbar1 */
> 		dma-domain-names = "slave";
> 		dma-domains = <&edma_xbar1>;
> 	};
> 
> 	voice muxed_dma@1 {
> 		/* memcpy is from edma and slaves from edma_xbar1 */
> 		dma-domain-names = "slave";
> 		dma-domains = <&edma_xbar1>;
> 	};
> 
> 	something not_muxed@0 {
> 		/* memcpy is from edma and slaves also */
> 	};
> };
> 
> Even the DMA router binding can be changed to look for the "slave"
> domain it belongs to?
> 
> The the dmas can drop the phandle to the controller/router
> 
> Internal API wise, things could use
> dmaengine_get_slave_domain(struct device *client_dev);
> if we get a domain, we know the the binding does not include the phandle
> for the controller.
> 
> and
> dmaengine_get_nonslave_domain(struct device *client_dev);
> 
> The DMA routers and drivers might need to be changed, not sure if they
> would notice the drop of the first phandle from the binding...
> 
> >>
> >> And no, we can not start looking for the dma-domain-controller starting
> >> from the root as in most cases the dma-domain-controller closer to the
> >> client is what we really want and not the globally best controller.
> >>
> >> - How to handle the transition?
> >>
> >> If neither dma-domain-controller/router is found, assume that the first
> >> argument in the binding is a phandle to the dma/router?
> >> We need to carry the support for what we have today for a long time. The
> >> kernel must boot with old DT blob.
> >>
> >> - Will it make things cleaner? Atm it is pretty easy to see which
> >> controller/router is used for which device.
> 
> Is this big change worth to push for?
> 
> 
> >> - Also to note that the EDMA and sDMA bindings are different, so we can
> >> not just swap dma-domain-controller/router underneath, we also need to
> >> modify the client's dmas line as well.
> >>
> >> - Péter
> >>
> >> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> >> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> > 
> 
> - Péter
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

-- 
~Vinod
