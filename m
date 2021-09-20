Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 789274114D8
	for <lists+dmaengine@lfdr.de>; Mon, 20 Sep 2021 14:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238775AbhITMtS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 20 Sep 2021 08:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237095AbhITMtI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 20 Sep 2021 08:49:08 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1AB0C061574;
        Mon, 20 Sep 2021 05:47:41 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5B38BE57;
        Mon, 20 Sep 2021 14:47:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1632142057;
        bh=sUHy5mI48lLJfk0k+EUA5Q2mX9cYsAejPY8yjVUg2ks=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=msjI+3iUrWdFQ0rNpQ9h1aEphCugLPzQGK+AvdqcX51vj4ctb8kiB26dSBp/iwEvw
         qwEqmoZfKEXornPDuVtejK5URA38OVvGakD/wefgsjEzoSSlxEJD/E/pcDTzvekBaY
         1pC2bixWM3bGWoPPFeQ3CJZr5Z/q1kyOunX34bTs=
Date:   Mon, 20 Sep 2021 15:47:07 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Hyun Kwon <hyun.kwon@xilinx.com>, Vinod Koul <vkoul@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Sanjay R Mehta <sanju.mehta@amd.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jianqiang Chen <jianqiang.chen@xilinx.com>,
        Quanyang Wang <quanyang.wang@windriver.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Allen Pais <apais@linux.microsoft.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: remove debugfs #ifdef
Message-ID: <YUiCy7A9cXTDGx6s@pendragon.ideasonboard.com>
References: <20210920122017.205975-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210920122017.205975-1-arnd@kernel.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Arnd,

Thank you for the patch.

On Mon, Sep 20, 2021 at 02:20:07PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The ptdma driver has added debugfs support, but this fails to build
> when debugfs is disabled:
> 
> drivers/dma/ptdma/ptdma-debugfs.c: In function 'ptdma_debugfs_setup':
> drivers/dma/ptdma/ptdma-debugfs.c:93:54: error: 'struct dma_device' has no member named 'dbg_dev_root'
>    93 |         debugfs_create_file("info", 0400, pt->dma_dev.dbg_dev_root, pt,
>       |                                                      ^
> drivers/dma/ptdma/ptdma-debugfs.c:96:55: error: 'struct dma_device' has no member named 'dbg_dev_root'
>    96 |         debugfs_create_file("stats", 0400, pt->dma_dev.dbg_dev_root, pt,
>       |                                                       ^
> drivers/dma/ptdma/ptdma-debugfs.c:102:52: error: 'struct dma_device' has no member named 'dbg_dev_root'
>   102 |                 debugfs_create_dir("q", pt->dma_dev.dbg_dev_root);
>       |                                                    ^
>
> Remove the #ifdef in the header, as this only saves a few bytes,
> but would require ugly #ifdefs in each driver using it.
> Simplify the other user while we're at it.
> 
> Fixes: e2fb2e2a33fa ("dmaengine: ptdma: Add debugfs entries for PTDMA")
> Fixes: 26cf132de6f7 ("dmaengine: Create debug directories for DMA devices")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/dma/xilinx/xilinx_dpdma.c | 15 +--------------
>  include/linux/dmaengine.h         |  2 --
>  2 files changed, 1 insertion(+), 16 deletions(-)
> 
> diff --git a/drivers/dma/xilinx/xilinx_dpdma.c b/drivers/dma/xilinx/xilinx_dpdma.c
> index b280a53e8570..ce5c66e6897d 100644
> --- a/drivers/dma/xilinx/xilinx_dpdma.c
> +++ b/drivers/dma/xilinx/xilinx_dpdma.c
> @@ -271,9 +271,6 @@ struct xilinx_dpdma_device {
>  /* -----------------------------------------------------------------------------
>   * DebugFS
>   */
> -
> -#ifdef CONFIG_DEBUG_FS
> -

It's only a few bytes of data in struct dma_device, but a bit more in
.text here. Is the simplification really required in this driver ?

>  #define XILINX_DPDMA_DEBUGFS_READ_MAX_SIZE	32
>  #define XILINX_DPDMA_DEBUGFS_UINT16_MAX_STR	"65535"
>  
> @@ -299,7 +296,7 @@ struct xilinx_dpdma_debugfs_request {
>  
>  static void xilinx_dpdma_debugfs_desc_done_irq(struct xilinx_dpdma_chan *chan)
>  {
> -	if (chan->id == dpdma_debugfs.chan_id)
> +	if (IS_ENABLED(CONFIG_DEBUG_FS) && chan->id == dpdma_debugfs.chan_id)
>  		dpdma_debugfs.xilinx_dpdma_irq_done_count++;
>  }
>  
> @@ -462,16 +459,6 @@ static void xilinx_dpdma_debugfs_init(struct xilinx_dpdma_device *xdev)
>  		dev_err(xdev->dev, "Failed to create debugfs testcase file\n");
>  }
>  
> -#else
> -static void xilinx_dpdma_debugfs_init(struct xilinx_dpdma_device *xdev)
> -{
> -}
> -
> -static void xilinx_dpdma_debugfs_desc_done_irq(struct xilinx_dpdma_chan *chan)
> -{
> -}
> -#endif /* CONFIG_DEBUG_FS */
> -
>  /* -----------------------------------------------------------------------------
>   * I/O Accessors
>   */
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index e5c2c9e71bf1..9000f3ffce8b 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -944,10 +944,8 @@ struct dma_device {
>  	void (*device_issue_pending)(struct dma_chan *chan);
>  	void (*device_release)(struct dma_device *dev);
>  	/* debugfs support */
> -#ifdef CONFIG_DEBUG_FS
>  	void (*dbg_summary_show)(struct seq_file *s, struct dma_device *dev);
>  	struct dentry *dbg_dev_root;
> -#endif
>  };
>  
>  static inline int dmaengine_slave_config(struct dma_chan *chan,

-- 
Regards,

Laurent Pinchart
