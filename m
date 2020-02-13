Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60AD015C00B
	for <lists+dmaengine@lfdr.de>; Thu, 13 Feb 2020 15:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730078AbgBMOHO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 13 Feb 2020 09:07:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:43290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730036AbgBMOHO (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 13 Feb 2020 09:07:14 -0500
Received: from localhost (unknown [106.201.58.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08DD720873;
        Thu, 13 Feb 2020 14:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581602833;
        bh=0JOk0SlXCMfOGC0DVQDmWlACtQJ+W9919nH92HCgd8w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pAtN0WMGa5NoK2y+F8Xi0XuoKh5sLDTD+61ITGQsnUUSvWNGyS3IWiaWtP35s+Qg3
         6UyJadSToVDzUyd+ib+bPLYEnilgwrkQM8RD28lHS0K01Q5TuewFQEFkVwpQA391cV
         7VliE+V5Sx3Y2/3x6/rXIUKXwzjbLZVxLVdYt7tA=
Date:   Thu, 13 Feb 2020 19:37:09 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>, dmaengine@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Satish Kumar Nagireddy <SATISHNA@xilinx.com>
Subject: Re: [PATCH v3 2/6] dmaengine: Add interleaved cyclic transaction type
Message-ID: <20200213140709.GH2618@vkoul-mobl>
References: <20200123022939.9739-3-laurent.pinchart@ideasonboard.com>
 <2f3a9e9e-9b74-7c2e-de3a-4897ab0e8205@ti.com>
 <20200123084352.GU2841@vkoul-mobl>
 <88aa9920-cdaf-97f0-c36f-66a998860ed2@ti.com>
 <20200123122304.GB13922@pendragon.ideasonboard.com>
 <20200124061047.GE2841@vkoul-mobl>
 <20200124085051.GA4842@pendragon.ideasonboard.com>
 <20200210140618.GA4727@pendragon.ideasonboard.com>
 <20200213132938.GF2618@vkoul-mobl>
 <20200213134843.GG4833@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213134843.GG4833@pendragon.ideasonboard.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 13-02-20, 15:48, Laurent Pinchart wrote:
> Hi Vinod,
> 
> On Thu, Feb 13, 2020 at 06:59:38PM +0530, Vinod Koul wrote:
> > On 10-02-20, 16:06, Laurent Pinchart wrote:
> > 
> > > > >> The use case here is not to switch to a new configuration, but to switch
> > > > >> to a new buffer. If the transfer had to be terminated manually first,
> > > > >> the DMA engine would potentially miss a frame, which is not acceptable.
> > > > >> We need an atomic way to switch to the next transfer.
> > > > > 
> > > > > So in this case you have, let's say a cyclic descriptor with N buffers
> > > > > and they are cyclically capturing data and providing to client/user..
> > > > 
> > > > For the display case it's cyclic over a single buffer that is repeatedly
> > > > displayed over and over again until a new one replaces it, when
> > > > userspace wants to change the content on the screen. Userspace only has
> > > > to provide a new buffer when content changes, otherwise the display has
> > > > to keep displaying the same one.
> > > 
> > > Is the use case clear enough, or do you need more information ? Are you
> > > fine with the API for this kind of use case ?
> > 
> > So we *know* when a new buffer is being used?
> 
> The user of the DMA engine (the DRM DPSUB driver in this case) knows
> when a new buffer needs to be used, as it receives it from userspace. In
> response, it prepares a new interleaved cyclic transaction and queues
> it. At the next IRQ, the DMA engine driver switches to the new
> transaction (the implementation is slightly more complex to handle race
> conditions, but that's the idea).
> 
> > IOW would it be possible for display (rather a dmaengine facing
> > display wrapper) to detect that we are reusing an old buffer and keep
> > the cyclic and once detected prepare a new descriptor, submit a new
> > one and then terminate old one which should trigger next transaction
> > to be submitted
> 
> I'm not sure to follow you. Do you mean that the display driver should
> submit a non-cyclic transaction for every frame, reusing the same buffer
> for every transaction, until a new buffer is available ? The issue with
> this is that if the CPU load gets high, we may miss a frame, and the
> display will break. The DPDMA hardware implements cyclic support for
> this reason, and we want to use that feature to comply with the real
> time requirements.

Sorry to cause confusion :) I mean cyclic

So, DRM DPSUB get first buffer
A.1 Prepare cyclic interleave txn
A.2 Submit the txn (it doesn't start here)
A.3 Invoke issue_pending (that starts the txn)

DRM DPSUB gets next buffer:
B.1 Prepare cyclic interleave txn
B.2 Submit the txn
B.3 Call terminate for current cyclic txn (we need an updated terminate
which terminates the current txn, right now we have terminate_all which
is a sledge hammer approach)
B.4 Next txn would start once current one is started

Does this help and make sense in your case

Thanks
-- 
~Vinod
