Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53248784D8
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jul 2019 08:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbfG2GLZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 29 Jul 2019 02:11:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:44282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbfG2GLZ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 29 Jul 2019 02:11:25 -0400
Received: from localhost (unknown [122.178.221.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEBB8204FD;
        Mon, 29 Jul 2019 06:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564380684;
        bh=nMKUNWZ9yoS62/Zd9AxV9+IUb4TvSPx7bEbfZkPkxOA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gpfJbMluyoxSsI8ETGPCvW/rNJLyFllQggJeLqu9lmBhW+0TuiqxwIjFjWj5P6Ugz
         GXdIrfZUyIRbjCXABBbeztbRQToVhI7Mi162rijjxYuSqYzlhmGvjQuSfJmvcHerCJ
         MZZnAO/EG7QMJNzBSHpF9a2wQCLWkHM/gstRhCn0=
Date:   Mon, 29 Jul 2019 11:40:10 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>, dan.j.williams@intel.com,
        tiwai@suse.com, jonathanh@nvidia.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, sharadg@nvidia.com,
        rlokhande@nvidia.com, dramesh@nvidia.com, mkumard@nvidia.com
Subject: Re: [PATCH] [RFC] dmaengine: add fifo_size member
Message-ID: <20190729061010.GC12733@vkoul-mobl.Dlink>
References: <b7e28e73-7214-f1dc-866f-102410c88323@nvidia.com>
 <20190613044352.GC9160@vkoul-mobl.Dlink>
 <09929edf-ddec-b70e-965e-cbc9ba4ffe6a@nvidia.com>
 <20190618043308.GJ2962@vkoul-mobl>
 <23474b74-3c26-3083-be21-4de7731a0e95@nvidia.com>
 <20190624062609.GV2962@vkoul-mobl>
 <e9e822da-1cb9-b510-7639-43407fda8321@nvidia.com>
 <75be49ac-8461-0798-b673-431ec527d74f@nvidia.com>
 <20190719050459.GM12733@vkoul-mobl.Dlink>
 <3e7f795d-56fb-6a71-b844-2fc2b85e099e@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e7f795d-56fb-6a71-b844-2fc2b85e099e@nvidia.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 23-07-19, 11:24, Sameer Pujar wrote:
> 
> On 7/19/2019 10:34 AM, Vinod Koul wrote:
> > On 05-07-19, 11:45, Sameer Pujar wrote:
> > > Hi Vinod,
> > > 
> > > What are your final thoughts regarding this?
> > Hi sameer,
> > 
> > Sorry for the delay in replying
> > 
> > On this, I am inclined to think that dma driver should not be involved.
> > The ADMAIF needs this configuration and we should take the path of
> > dma_router for this piece and add features like this to it
> 
> Hi Vinod,
> 
> The configuration is needed by both ADMA and ADMAIF. The size is
> configurable
> on ADMAIF side. ADMA needs to know this info and program accordingly.

Well I would say client decides the settings for both DMA, DMAIF and
sets the peripheral accordingly as well, so client communicates the two
sets of info to two set of drivers

> Not sure if dma_router can help to achieve this.
> 
> I checked on dma_router. It would have been useful when a configuration
> exported
> via ADMA, had to be applied to ADMAIF. Please correct me if I am wrong here.

router was added for such a senario, if you feel that it doesn't serve
your purpose, feel free to send up update for it, if that is the case.

Thanks

-- 
~Vinod
