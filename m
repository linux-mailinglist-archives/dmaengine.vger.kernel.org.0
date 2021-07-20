Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F37B43CF98C
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jul 2021 14:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237755AbhGTLoG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Jul 2021 07:44:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:34000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237933AbhGTLn4 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 20 Jul 2021 07:43:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0EFFA6113C;
        Tue, 20 Jul 2021 12:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626783874;
        bh=IZ5fhQBw8lF0jQ4KZtvtrkcrPT0qfOGp7+3yoW724r8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mvabbFBt+0+ugsNUpYDAJJZix9b2PjrxN33kYiEDL8Q8N7nIQaF4aE84M1GRDaeJ1
         rHT07bcYrpBZ9FGulOJf2QDy6s6qYKB51qU7fgVULaWaI5ZxYZER5vFyL82yc8Ud0j
         hdFo0dM2csjbZ08++HcpEYyiVkf8EUEl9Te+Dm01svees7+S7P9hmA+irfGluJMdOF
         GKZk0vq7GjV4FGzUwIbGajYBZWTJOi5iWcsL+Zrq/5YEzJ2oDxXpA+RDgNr3Wo2vFN
         vcM4irgBNJG388/BuOPD4x+zfraVt5FWd5EbKOTy2pb1qPpQHKvq0yroOC6R6K8v44
         4Lp3UVNwQ8dpg==
Date:   Tue, 20 Jul 2021 17:54:31 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "N, Pandith" <pandith.n@intel.com>
Cc:     "Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Pan, Kris" <kris.pan@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "Thokala, Srikanth" <srikanth.thokala@intel.com>
Subject: Re: [linux-drivers-review] [PATCH V2 1/1] dmaengine: dw-axi-dmac:
 support parallel memory <--> peripheral transfers
Message-ID: <YPbAf6zd3uI61ZbM@matsya>
References: <20210709095133.26867-1-pandith.n@intel.com>
 <YO5tAlVshNLat2jt@matsya>
 <BYAPR11MB35282B43582FAB4C6619790EE1139@BYAPR11MB3528.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR11MB35282B43582FAB4C6619790EE1139@BYAPR11MB3528.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 14-07-21, 12:45, N, Pandith wrote:
> Hi Vinod,
> 
> Thanks for review, Please check for in-line response for the comments

Pls do not *top post*

> 
> Regards
> Pandith
> 
> > -----Original Message-----
> > From: Vinod Koul <vkoul@kernel.org>
> > Sent: Wednesday, July 14, 2021 10:20 AM
> > To: N, Pandith <pandith.n@intel.com>
> > Cc: Eugeniy.Paltsev@synopsys.com; dmaengine@vger.kernel.org; Raja
> > Subramanian, Lakshmi Bai <lakshmi.bai.raja.subramanian@intel.com>; Pan, Kris
> > <kris.pan@intel.com>; Sangannavar, Mallikarjunappa
> > <mallikarjunappa.sangannavar@intel.com>; Thokala, Srikanth
> > <srikanth.thokala@intel.com>
> > Subject: Re: [linux-drivers-review] [PATCH V2 1/1] dmaengine: dw-axi-dmac:
> > support parallel memory <--> peripheral transfers
> > 
> > On 09-07-21, 15:21, pandith.n@intel.com wrote:
> > > From: Pandith N <pandith.n@intel.com>
> > >
> > > Added support for multiple DMA_MEM_TO_DEV, DMA_DEV_TO_MEM
> > transfers in
> > > parallel. This is required for peripherals using DMA for transmit and
> > > receive operations at the same time. APB slot number needs to be
> > > programmed in channel hardware handshaking interface.
> > >
> > > Removed free slot check algorithm in dw_axi_dma_set_hw_channel. For 8
> > > DMA channels, use respective handshake slot in DMA_HS_SEL APB register.
> > 
> > and why was that removed, maybe a different patch for that?
> > 
> For every channel, an dedicated slot is provided in  hardware handshake register.
> Peripheral source number is programmed in respective channel slots.

Pls explain that in the log as well

> 
> > >
> > > Burst length, DMA HW capability set in dt-binding is now used in driver.
> > 
> > Another patch...
> > 
> > So, too many changes below for the description above, pls split
> > 
> I will split the changes as separate patches in next version.

ok

-- 
~Vinod
