Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07A4D24730
	for <lists+dmaengine@lfdr.de>; Tue, 21 May 2019 06:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725794AbfEUE6z (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 May 2019 00:58:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:54268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbfEUE6z (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 21 May 2019 00:58:55 -0400
Received: from localhost (unknown [106.201.107.13])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4207121019;
        Tue, 21 May 2019 04:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558414735;
        bh=w0PrRhb/VLNDP5E1yQloNmbdNQpf/jLdu2sJYIQzoqU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wmWkLTPAQGqtWF4/jrOD7kyg84A83fKHEk6yU+xZ3MeatGBuQ2XTplO2ASwvXXW8f
         jSHwl6zOpH+h2vhWkCJjY/v3sVd31AGKwC5TZF/oL7TM6CS/ifXpKaeoIdx2pEpNnN
         PQlVn0vCEPAoBikbm3TbaIf0ZkRVki+DzGy6e0B0=
Date:   Tue, 21 May 2019 10:28:51 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Shun-Chih Yu <shun-chih.yu@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dmaengine@vger.kernel.org, linux-mediatek@lists.infradead.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] dmaengine: mediatek-cqdma: sleeping in atomic context
Message-ID: <20190521045851.GR15118@vkoul-mobl>
References: <20190509100923.GA7024@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509100923.GA7024@mwanda>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 09-05-19, 13:09, Dan Carpenter wrote:
> The mtk_cqdma_poll_engine_done() function takes a true/false parameter
> where true means it's called from atomic context.  There are a couple
> places where it was set to false but it's actually in atomic context
> so it should be true.
> 
> All the callers for mtk_cqdma_hard_reset() are holding a spin_lock and
> in mtk_cqdma_free_chan_resources() we take a spin_lock before calling
> the mtk_cqdma_poll_engine_done() function.

Applied, thanks

> 
> Fixes: b1f01e48df5a ("dmaengine: mediatek: Add MediaTek Command-Queue DMA controller for MT6765 SoC")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> The "atomic" parameter is always true so the temptation was to just
> remove it entirely.

a patch is welcome :)

-- 
~Vinod
