Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C34EFB132A
	for <lists+dmaengine@lfdr.de>; Thu, 12 Sep 2019 19:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731089AbfILREU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 12 Sep 2019 13:04:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:36470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731067AbfILREU (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 12 Sep 2019 13:04:20 -0400
Received: from localhost (unknown [117.99.85.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CD0D2081B;
        Thu, 12 Sep 2019 17:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568307859;
        bh=WfnIOTHHePxhKxrFtGHlrl53zHUSmfXSu0kmiCkwyOA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mXNE/u6UvfnaDeSnwEVQ4IHgTnhUlCvp2ShHPoTKL+IFA3nrvHlOT5jYZlU/OfQll
         cS7hs8yK1pXOu+T2/iq5boJhLu95IfWeoTDi3dprf2uKYotdUHrxeYCoBLkTYTmbYO
         f0l06M5DZ+MY3A5TO2K3t2kPJ7CRwBLpeOBljp8o=
Date:   Thu, 12 Sep 2019 22:33:12 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     robh+dt@kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, dan.j.williams@intel.com,
        devicetree@vger.kernel.org
Subject: Re: [RFC 1/3] dt-bindings: dma: Add documentation for DMA domains
Message-ID: <20190912170312.GD4392@vkoul-mobl>
References: <20190906141816.24095-1-peter.ujfalusi@ti.com>
 <20190906141816.24095-2-peter.ujfalusi@ti.com>
 <961d30ea-d707-1120-7ecf-f51c11c41891@ti.com>
 <20190908121058.GL2672@vkoul-mobl>
 <a452cd06-79ca-424d-b259-c8d60fc59772@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a452cd06-79ca-424d-b259-c8d60fc59772@ti.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 09-09-19, 09:30, Peter Ujfalusi wrote:

> >> or domain-dma-controller?
> > 
> > I feel dma-domain-controller sounds fine as we are defining domains for
> > dmaengine. Another thought which comes here is that why not extend this to
> > slave as well and define dma-domain-controller for them as use that for
> > filtering, that is what we really need along with slave id in case a
> > specific channel is to be used by a peripheral
> > 
> > Thoughts..?
> 
> I have thought about this, we should be able to drop the phandle to the
> dma controller from the slave binding just fine.
> 
> However we have the dma routers for the slave channels and there is no
> clear way to handle them.
> They are not needed for non slave channels as there is no trigger to
> route. In DRA7 for example we have an event router for EDMA and another
> one for sDMA. If a slave device is to be serviced by EDMA, the EDMA
> event router needs to be specified, for sDMA clients should use the sDMA
> event router.

So you have dma, xbar and client? And you need to use a specfic xbar,
did i get that right?

> In DRA7 case we don't really have DMA controllers for domains, but we
> use the DMA which can service the peripheral better (sDMA is better to
> be used for UART, but can not be used for McASP for example)
> 
> Then we have the other type of DMA router for daVinci/am33xx/am43xx
> where the crossbar is not for the whole EDMA controller like in DRA7,
> but we have small crossbars for some channels.
> 
> Other vendors have their own dma router topology..
> 
> Too many variables to handle the cases without gotchas, which would need
> heavy churn in the core or in drivers.

-- 
~Vinod
