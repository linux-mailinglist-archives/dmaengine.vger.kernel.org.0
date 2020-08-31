Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6098257B7A
	for <lists+dmaengine@lfdr.de>; Mon, 31 Aug 2020 16:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbgHaOrO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Aug 2020 10:47:14 -0400
Received: from mga01.intel.com ([192.55.52.88]:19989 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726384AbgHaOrO (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 31 Aug 2020 10:47:14 -0400
IronPort-SDR: CvO0Pq5JlEIWDVmPYvcaatfdBov9gWBoZXUCI9rt3P0nKr3iwrl+DG5/ORIeHIxCziTU+1CVuj
 SBFdC3XYShCA==
X-IronPort-AV: E=McAfee;i="6000,8403,9730"; a="175029716"
X-IronPort-AV: E=Sophos;i="5.76,376,1592895600"; 
   d="scan'208";a="175029716"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2020 07:47:13 -0700
IronPort-SDR: MBfmcz8N/bCud5pZN69WPp0pNmE8uH7RKIElLi+EagdY4m0V/51e3wC5E26GIBE55vQkObsDqU
 s4BGW75la4GQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,376,1592895600"; 
   d="scan'208";a="301065222"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.212.162.99]) ([10.212.162.99])
  by orsmga006.jf.intel.com with ESMTP; 31 Aug 2020 07:47:11 -0700
Subject: Re: [PATCH v3 09/35] dmaengine: ioat: convert tasklets to use new
 tasklet_setup() API
To:     Allen Pais <allen.lkml@gmail.com>, vkoul@kernel.org
Cc:     linus.walleij@linaro.org, vireshk@kernel.org, leoyang.li@nxp.com,
        zw@zh-kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        sean.wang@mediatek.com, matthias.bgg@gmail.com,
        logang@deltatee.com, agross@kernel.org, jorn.andersson@linaro.org,
        green.wan@sifive.com, baohua@kernel.org, mripard@kernel.org,
        wens@csie.org, dmaengine@vger.kernel.org,
        Romain Perier <romain.perier@gmail.com>
References: <20200831103542.305571-1-allen.lkml@gmail.com>
 <20200831103542.305571-10-allen.lkml@gmail.com>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <476c5571-8856-fe7e-628c-7328368a82fc@intel.com>
Date:   Mon, 31 Aug 2020 07:47:10 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200831103542.305571-10-allen.lkml@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 8/31/2020 3:35 AM, Allen Pais wrote:
> In preparation for unconditionally passing the
> struct tasklet_struct pointer to all tasklet
> callbacks, switch to using the new tasklet_setup()
> and from_tasklet() to pass the tasklet pointer explicitly.
> 
> Signed-off-by: Romain Perier <romain.perier@gmail.com>
> Signed-off-by: Allen Pais <allen.lkml@gmail.com>

Acked-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/dma/ioat/dma.c  | 6 +++---
>   drivers/dma/ioat/dma.h  | 2 +-
>   drivers/dma/ioat/init.c | 4 +---
>   3 files changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/dma/ioat/dma.c b/drivers/dma/ioat/dma.c
> index a814b200299b..bfcf67febfe6 100644
> --- a/drivers/dma/ioat/dma.c
> +++ b/drivers/dma/ioat/dma.c
> @@ -165,7 +165,7 @@ void ioat_stop(struct ioatdma_chan *ioat_chan)
>   	tasklet_kill(&ioat_chan->cleanup_task);
>   
>   	/* final cleanup now that everything is quiesced and can't re-arm */
> -	ioat_cleanup_event((unsigned long)&ioat_chan->dma_chan);
> +	ioat_cleanup_event(&ioat_chan->cleanup_task);
>   }
>   
>   static void __ioat_issue_pending(struct ioatdma_chan *ioat_chan)
> @@ -690,9 +690,9 @@ static void ioat_cleanup(struct ioatdma_chan *ioat_chan)
>   	spin_unlock_bh(&ioat_chan->cleanup_lock);
>   }
>   
> -void ioat_cleanup_event(unsigned long data)
> +void ioat_cleanup_event(struct tasklet_struct *t)
>   {
> -	struct ioatdma_chan *ioat_chan = to_ioat_chan((void *)data);
> +	struct ioatdma_chan *ioat_chan = from_tasklet(ioat_chan, t, cleanup_task);
>   
>   	ioat_cleanup(ioat_chan);
>   	if (!test_bit(IOAT_RUN, &ioat_chan->state))
> diff --git a/drivers/dma/ioat/dma.h b/drivers/dma/ioat/dma.h
> index f7f31fdf14cf..140cfe3782fb 100644
> --- a/drivers/dma/ioat/dma.h
> +++ b/drivers/dma/ioat/dma.h
> @@ -393,7 +393,7 @@ int ioat_reset_hw(struct ioatdma_chan *ioat_chan);
>   enum dma_status
>   ioat_tx_status(struct dma_chan *c, dma_cookie_t cookie,
>   		struct dma_tx_state *txstate);
> -void ioat_cleanup_event(unsigned long data);
> +void ioat_cleanup_event(struct tasklet_struct *t);
>   void ioat_timer_event(struct timer_list *t);
>   int ioat_check_space_lock(struct ioatdma_chan *ioat_chan, int num_descs);
>   void ioat_issue_pending(struct dma_chan *chan);
> diff --git a/drivers/dma/ioat/init.c b/drivers/dma/ioat/init.c
> index 8a53f5c96b16..191b59279007 100644
> --- a/drivers/dma/ioat/init.c
> +++ b/drivers/dma/ioat/init.c
> @@ -767,8 +767,6 @@ ioat_init_channel(struct ioatdma_device *ioat_dma,
>   		  struct ioatdma_chan *ioat_chan, int idx)
>   {
>   	struct dma_device *dma = &ioat_dma->dma_dev;
> -	struct dma_chan *c = &ioat_chan->dma_chan;
> -	unsigned long data = (unsigned long) c;
>   
>   	ioat_chan->ioat_dma = ioat_dma;
>   	ioat_chan->reg_base = ioat_dma->reg_base + (0x80 * (idx + 1));
> @@ -778,7 +776,7 @@ ioat_init_channel(struct ioatdma_device *ioat_dma,
>   	list_add_tail(&ioat_chan->dma_chan.device_node, &dma->channels);
>   	ioat_dma->idx[idx] = ioat_chan;
>   	timer_setup(&ioat_chan->timer, ioat_timer_event, 0);
> -	tasklet_init(&ioat_chan->cleanup_task, ioat_cleanup_event, data);
> +	tasklet_setup(&ioat_chan->cleanup_task, ioat_cleanup_event);
>   }
>   
>   #define IOAT_NUM_SRC_TEST 6 /* must be <= 8 */
> 
