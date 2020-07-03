Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58149213E7C
	for <lists+dmaengine@lfdr.de>; Fri,  3 Jul 2020 19:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgGCRWu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 3 Jul 2020 13:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgGCRWu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 3 Jul 2020 13:22:50 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410FEC061794
        for <dmaengine@vger.kernel.org>; Fri,  3 Jul 2020 10:22:50 -0700 (PDT)
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5C2EB29E;
        Fri,  3 Jul 2020 19:22:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1593796967;
        bh=F9p7gRYOc9sD/A70oX5KrA+4TVR9iB0/lmDCkqnSlFk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y3xdWHSEczL1swX8pmDqdnzL6c4xJ7kyOx/6QUZAyEZYSQEK4fVU5vtXk0oSqePRF
         jeeeieOwnUzf3tslZtZGQQTSMIRp6u3yfLn+dtLCo+tjH6coJq/kTMLRSK5j/Jc1jt
         bIBI0iGewJY4ISksW8VcT61BW7QGaqW2xLV2le/c=
Date:   Fri, 3 Jul 2020 20:22:42 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Satish Kumar Nagireddy <SATISHNA@xilinx.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v5 3/6] dmaengine: Add support for repeating transactions
Message-ID: <20200703172242.GC14282@pendragon.ideasonboard.com>
References: <20200528025228.31638-1-laurent.pinchart@ideasonboard.com>
 <20200528025228.31638-4-laurent.pinchart@ideasonboard.com>
 <20200703171039.GO273932@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200703171039.GO273932@vkoul-mobl>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

On Fri, Jul 03, 2020 at 10:40:39PM +0530, Vinod Koul wrote:
> Hi Laurent,
> 
> On 28-05-20, 05:52, Laurent Pinchart wrote:
> 
> > @@ -176,6 +178,18 @@ struct dma_interleaved_template {
> >   * @DMA_PREP_CMD: tell the driver that the data passed to DMA API is command
> >   *  data and the descriptor should be in different format from normal
> >   *  data descriptors.
> > + * @DMA_PREP_REPEAT: tell the driver that the transaction shall be automatically
> > + *  repeated when it ends if no other transaction has been issued on the same
> > + *  channel. If other transactions have been issued, this transaction completes
> > + *  normally. This flag is only applicable to interleaved transactions and is
> > + *  ignored for all other transaction types.
> 
> 1. Let us not restrict this to only interleave (hint we can in future
> replace cyclic API)

Peter wanted to already implement support for DMA_PREP_REPEAT in other
transaction types, and you replied that you would prefer not enabling
APIs without users, waiting for the first user of DMA_PREP_REPEAT with a
non-interleaved transaction to do so. Your comment here seems to
contract that. Which way do you want to go ?

> 2. DMA_PREP_REPEAT telling the transaction shall be automatically
> repeated is okay. No issues with that
> 
> > + * @DMA_PREP_LOAD_EOT: tell the driver that the transaction shall replaced any
> 
> s/replaced/replace
> 
> > + *  active repeated (as indicated by DMA_PREP_REPEAT) transaction when the
> > + *  repeated transaction terminate. Not setting this flag when the previously
> > + *  queued transaction is marked with DMA_PREP_REPEAT will cause the new
> > + *  transaction to never be processed and stay in the issued queue forever.
> > + *  The flag is ignored if the previous transaction is not a repeated
> > + *  transaction.
> 
> I am happy with this bit, I think we dont need to specify something like
> DMA_PREP_LOAD_NEXT given the explanation here, so adding
> DMA_PREP_LOAD_EOT would mean that.

Just to clarify, does that mean I don't need to add a DMA_PREP_LOAD_NEXT
flag in the API ?

> Can we add a corresponding EOB as well to complete this

What's EOB ?

-- 
Regards,

Laurent Pinchart
