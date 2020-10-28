Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFC4329D6EC
	for <lists+dmaengine@lfdr.de>; Wed, 28 Oct 2020 23:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731678AbgJ1WTM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Oct 2020 18:19:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:60510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731725AbgJ1WRn (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:43 -0400
Received: from localhost (unknown [122.171.163.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB9A52242B;
        Wed, 28 Oct 2020 05:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603864727;
        bh=zCDc+pE193gP2/McgeiNo8AUO/9JhziUd6V7van4zwM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iXG7TCpwWIEZn2uzLwMkccoTfhhAuOB8ZeHE2ZDw8+JIiwgXh73wWbuu8jFDUFly2
         VPzTcqmoGZTQsjQlY20Q+BP4uzyMcQ0/7Py1SFY/Ag0Orm5n8EFGDa3O9/6uEqSFVd
         u7VHULIvJnAKdZX6sCGOeoTfk32aU2C0TqnOjqww=
Date:   Wed, 28 Oct 2020 11:28:43 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "Sia, Jee Heng" <jee.heng.sia@intel.com>
Cc:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
Subject: Re: [PATCH 0/4] dmaengine: dw-axi-dmac: Refactor descriptor and
 channel management
Message-ID: <20201028055843.GJ3550@vkoul-mobl>
References: <1599213094-30144-1-git-send-email-jee.heng.sia@intel.com>
 <BYAPR11MB3206E7BF9AEC346822F22CF3DA3F0@BYAPR11MB3206.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR11MB3206E7BF9AEC346822F22CF3DA3F0@BYAPR11MB3206.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 18-09-20, 02:31, Sia, Jee Heng wrote:
> Hi Vinod, Hi Paltsev,
> 
> This patch series has been sent 2 weeks ago, but yet to receive a comment. 
> This patch series have been reviewed by Andy before sent out.

Last two weeks were merge window, now that rc1 is out, I plan to review
this in a week or so (other patches are also in queue)

Please have patience wrt reviews and keep in mind things like merge
windows etc!

> 
> May I know if you have further comment on the patches?
> 
> Thanks
> Regards
> Jee Heng
> 
> > -----Original Message-----
> > From: Sia, Jee Heng <jee.heng.sia@intel.com>
> > Sent: 04 September 2020 5:52 PM
> > To: dmaengine@vger.kernel.org
> > Cc: vkoul@kernel.org; Eugeniy.Paltsev@synopsys.com; Shevchenko, Andriy
> > <andriy.shevchenko@intel.com>; Sia, Jee Heng <jee.heng.sia@intel.com>
> > Subject: [PATCH 0/4] dmaengine: dw-axi-dmac: Refactor descriptor and channel
> > management
> > 
> > The below patch series are to support AxiDMA running on Intel KeemBay SoC.
> > The base driver is dw-axi-dmac but code refactoring is needed to improve the
> > descriptor management by replacing Linked List Item (LLI) with virtual descriptor
> > management, only allocate hardware LLI memories from DMA memory pool,
> > manage DMA memory pool alloc/destroy based on channel activity and to
> > support device_sync callback.
> > 
> > Note: Intel KeemBay AxiDMA related changes and other DMA features are to be
> > submitted as we need to get the fundamental changes approved first prior to
> > add additional DMA features on top.
> > 
> > This patch series are tested on Intel KeemBay platform.
> > 
> > Sia Jee Heng (4):
> >   dt-bindings: dma: Add YAML schemas for dw-axi-dmac
> >   dmaengine: dw-axi-dmac: simplify descriptor management
> >   dmaengine: dw-axi-dmac: move dma_pool_create() to
> >     alloc_chan_resources()
> >   dmaengine: dw-axi-dmac: Add device_synchronize() callback
> > 
> >  .../devicetree/bindings/dma/snps,dw-axi-dmac.txt   |  39 -----
> >  .../devicetree/bindings/dma/snps,dw-axi-dmac.yaml  | 124 ++++++++++++++
> >  drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c     | 190 ++++++++++++------
> > ---
> >  drivers/dma/dw-axi-dmac/dw-axi-dmac.h              |  11 +-
> >  4 files changed, 245 insertions(+), 119 deletions(-)  delete mode 100644
> > Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.txt
> >  create mode 100644 Documentation/devicetree/bindings/dma/snps,dw-axi-
> > dmac.yaml
> > 
> > --
> > 1.9.1

-- 
~Vinod
