Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8128249402
	for <lists+dmaengine@lfdr.de>; Wed, 19 Aug 2020 06:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbgHSE0F (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 19 Aug 2020 00:26:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:34220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725275AbgHSE0F (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 19 Aug 2020 00:26:05 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6DD420772;
        Wed, 19 Aug 2020 04:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597811164;
        bh=Nt5fvzaUfAQQHR+uBcTqixdF6Qgj4u2fQgrV8+YVptM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eTT8NCK5BBZKAcTdsIyUcBBVLfak93LlgZ99seQ5oODuO3la6Iqt48gIPN5pdB614
         53R0avWN4i9W28gBL7t+ypPODwX/GbhNer/vEQc0GjvikdnozNf3BebfHtHVt+pT9W
         46bWH5O9VeLg0DIkfFRV/toZsE/y2cA7ngZ1gTJE=
Date:   Wed, 19 Aug 2020 09:56:01 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Wei Yongjun <weiyongjun1@huawei.com>,
        Hulk Robot <hulkci@huawei.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH -next] dmaengine: xilinx: dpdma: Make symbol
 'dpdma_debugfs_reqs' static
Message-ID: <20200819042601.GB2639@vkoul-mobl>
References: <20200818112217.43816-1-weiyongjun1@huawei.com>
 <20200818234107.GC2360@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818234107.GC2360@pendragon.ideasonboard.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 19-08-20, 02:41, Laurent Pinchart wrote:
> Hi Wei,
> 
> Thank you for the patch.
> 
> On Tue, Aug 18, 2020 at 07:22:17PM +0800, Wei Yongjun wrote:
> > The sparse tool complains as follows:
> > 
> > drivers/dma/xilinx/xilinx_dpdma.c:349:37: warning:
> >  symbol 'dpdma_debugfs_reqs' was not declared. Should it be static?
> > 
> > This variable is not used outside of xilinx_dpdma.c, so this commit
> > marks it static.
> > 
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Fixes: 1d220435cab3 ("dmaengine: xilinx: dpdma: Add debugfs support")
> > Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> 
> Looks good to me.
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> Vinod, could you pick this up as a v5.9 fix ?

This is not 5.9 fix. The debugfs patch will go into next for 5.10 so
this is applied to next as well

-- 
~Vinod
