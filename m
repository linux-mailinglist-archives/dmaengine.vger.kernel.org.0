Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9316C213E9D
	for <lists+dmaengine@lfdr.de>; Fri,  3 Jul 2020 19:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbgGCRhP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 3 Jul 2020 13:37:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:46474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbgGCRhP (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 3 Jul 2020 13:37:15 -0400
Received: from localhost (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E71102084C;
        Fri,  3 Jul 2020 17:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593797834;
        bh=rAlN1c9+pzDqH1+G71rlmqcMn9DAY3OuYS1v50hz2lg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n583hSgN60bJHd3GHSFTCdleXbUqcQkNr6NH6AwvCTAyic7DHh5xkFHZvBDqZF48b
         kzwfszzt6I5XQpYF+YBQc+m877LjGpHnZm/h3uSl8B4bBI1/YcHuTQ1FQT/sZmqjc3
         PlCTdMxs+46jO4GAGaN5o5KZpo/Hr+/zt1DYERUY=
Date:   Fri, 3 Jul 2020 23:07:10 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     dmaengine@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Satish Kumar Nagireddy <SATISHNA@xilinx.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v5 3/6] dmaengine: Add support for repeating transactions
Message-ID: <20200703173710.GQ273932@vkoul-mobl>
References: <20200528025228.31638-1-laurent.pinchart@ideasonboard.com>
 <20200528025228.31638-4-laurent.pinchart@ideasonboard.com>
 <20200703171039.GO273932@vkoul-mobl>
 <20200703172242.GC14282@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703172242.GC14282@pendragon.ideasonboard.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Laurent,

On 03-07-20, 20:22, Laurent Pinchart wrote:
> On Fri, Jul 03, 2020 at 10:40:39PM +0530, Vinod Koul wrote:
> > On 28-05-20, 05:52, Laurent Pinchart wrote:
> > 
> > > @@ -176,6 +178,18 @@ struct dma_interleaved_template {
> > >   * @DMA_PREP_CMD: tell the driver that the data passed to DMA API is command
> > >   *  data and the descriptor should be in different format from normal
> > >   *  data descriptors.
> > > + * @DMA_PREP_REPEAT: tell the driver that the transaction shall be automatically
> > > + *  repeated when it ends if no other transaction has been issued on the same
> > > + *  channel. If other transactions have been issued, this transaction completes
> > > + *  normally. This flag is only applicable to interleaved transactions and is
> > > + *  ignored for all other transaction types.
> > 
> > 1. Let us not restrict this to only interleave (hint we can in future
> > replace cyclic API)
> 
> Peter wanted to already implement support for DMA_PREP_REPEAT in other
> transaction types, and you replied that you would prefer not enabling
> APIs without users, waiting for the first user of DMA_PREP_REPEAT with a
> non-interleaved transaction to do so. Your comment here seems to
> contract that. Which way do you want to go ?

I would like to change the language of the explanation to not forbid
other uses, but they would be enabled in txn when we have users..

> > 2. DMA_PREP_REPEAT telling the transaction shall be automatically
> > repeated is okay. No issues with that
> > 
> > > + * @DMA_PREP_LOAD_EOT: tell the driver that the transaction shall replaced any
> > 
> > s/replaced/replace
> > 
> > > + *  active repeated (as indicated by DMA_PREP_REPEAT) transaction when the
> > > + *  repeated transaction terminate. Not setting this flag when the previously
> > > + *  queued transaction is marked with DMA_PREP_REPEAT will cause the new
> > > + *  transaction to never be processed and stay in the issued queue forever.
> > > + *  The flag is ignored if the previous transaction is not a repeated
> > > + *  transaction.
> > 
> > I am happy with this bit, I think we dont need to specify something like
> > DMA_PREP_LOAD_NEXT given the explanation here, so adding
> > DMA_PREP_LOAD_EOT would mean that.
> 
> Just to clarify, does that mean I don't need to add a DMA_PREP_LOAD_NEXT
> flag in the API ?
> 
> > Can we add a corresponding EOB as well to complete this
> 
> What's EOB ?

End of Burst, DMA would complete current burst and then terminate. I do
understand it is not applicable for your case as your hw doesn't support
it and would be unused but this is another case which would be useful so
for completeness we should add this

-- 
~Vinod
