Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D13C15BF59
	for <lists+dmaengine@lfdr.de>; Thu, 13 Feb 2020 14:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729801AbgBMN3o (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 13 Feb 2020 08:29:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:60840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729588AbgBMN3o (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 13 Feb 2020 08:29:44 -0500
Received: from localhost (unknown [106.201.58.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA9DD222C2;
        Thu, 13 Feb 2020 13:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581600583;
        bh=b/vSfjvGHGTciw0MDBenTQGqezCZ4ESA01KHETJSEiE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a/dvp+DjTMOU2RXfC/YTY90NITzT7EebQINaZqkAJStRqeahxS/T7BDn/OBveeXoA
         aWykPQSFS9o3kTNF2T0hBvfmze9i4+wOGQjhI5aA3/UCIcNugIeT0dmgNx6o2LzEkU
         oi3+tA8Jf9VGMn/fWCVFH11qfeTJ0lGZgBNBs66k=
Date:   Thu, 13 Feb 2020 18:59:38 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>, dmaengine@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Satish Kumar Nagireddy <SATISHNA@xilinx.com>
Subject: Re: [PATCH v3 2/6] dmaengine: Add interleaved cyclic transaction type
Message-ID: <20200213132938.GF2618@vkoul-mobl>
References: <20200123022939.9739-1-laurent.pinchart@ideasonboard.com>
 <20200123022939.9739-3-laurent.pinchart@ideasonboard.com>
 <2f3a9e9e-9b74-7c2e-de3a-4897ab0e8205@ti.com>
 <20200123084352.GU2841@vkoul-mobl>
 <88aa9920-cdaf-97f0-c36f-66a998860ed2@ti.com>
 <20200123122304.GB13922@pendragon.ideasonboard.com>
 <20200124061047.GE2841@vkoul-mobl>
 <20200124085051.GA4842@pendragon.ideasonboard.com>
 <20200210140618.GA4727@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210140618.GA4727@pendragon.ideasonboard.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Laurent,

On 10-02-20, 16:06, Laurent Pinchart wrote:

> > >> The use case here is not to switch to a new configuration, but to switch
> > >> to a new buffer. If the transfer had to be terminated manually first,
> > >> the DMA engine would potentially miss a frame, which is not acceptable.
> > >> We need an atomic way to switch to the next transfer.
> > > 
> > > So in this case you have, let's say a cyclic descriptor with N buffers
> > > and they are cyclically capturing data and providing to client/user..
> > 
> > For the display case it's cyclic over a single buffer that is repeatedly
> > displayed over and over again until a new one replaces it, when
> > userspace wants to change the content on the screen. Userspace only has
> > to provide a new buffer when content changes, otherwise the display has
> > to keep displaying the same one.
> 
> Is the use case clear enough, or do you need more information ? Are you
> fine with the API for this kind of use case ?

So we *know* when a new buffer is being used?

IOW would it be possible for display (rather a dmaengine facing display wrapper) to detect that we are reusing an
old buffer and keep the cyclic and once detected prepare a new
descriptor, submit a new one and then terminate old one which should
trigger next transaction to be submitted

Would that make sense here?

-- 
~Vinod
