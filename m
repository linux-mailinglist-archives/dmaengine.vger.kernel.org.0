Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C49DA57CBF8
	for <lists+dmaengine@lfdr.de>; Thu, 21 Jul 2022 15:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiGUNcT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Jul 2022 09:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiGUNcT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 21 Jul 2022 09:32:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5653F56B8A;
        Thu, 21 Jul 2022 06:32:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC7B261EF0;
        Thu, 21 Jul 2022 13:32:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4A10C3411E;
        Thu, 21 Jul 2022 13:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658410337;
        bh=N3B07w30dnSg04EkW/NAVWxOqfOJmS+tXeIF3ZJMdXY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CDz0A9x6ppgymsaczvjhf/5F4UQLbbpSoJKH/XXMu9VfaEwG7d2XYUbj7oeQYbknL
         9MdWKRGBgP24S2comvU8xK8pc7aS5WUzLEXq4rFHIkjrY/laggmKb1P5dx/TkwHOUR
         F5mR/VYg4/RUUU7vHNeTnTCfuluKg6wEHkW9aNCa7bCgx0kLJftqGxIh94DiiygFFS
         qnkk8v6F3UYpftxkxXTdkXrjHzggNVhkKH18/sswj1w9BCPeC+/2c7tcyO3WY/9Mc6
         Sw4Xu6rw51wgzPuLNIW7gY+QO88kQU8zcsziN/wgpnoYiR1PMJb6wxcuOu4SWxN2f+
         hh2EEXJVzEgew==
Date:   Thu, 21 Jul 2022 19:02:13 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Vaishnav Achath <vaishnav.a@ti.com>
Cc:     peter.ujfalusi@gmail.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, nm@ti.com, vigneshr@ti.com,
        p.yadav@ti.com, j-keerthy@ti.com, m-khayami@ti.com,
        stanley_liu@ti.com
Subject: Re: [PATCH] dma: ti: k3-udma: Reset UDMA_CHAN_RT byte counters to
 prevent overflow
Message-ID: <YtlVXX9x37S/cWF9@matsya>
References: <20220704111325.636-1-vaishnav.a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220704111325.636-1-vaishnav.a@ti.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 04-07-22, 16:43, Vaishnav Achath wrote:
> UDMA_CHAN_RT_*BCNT_REG stores the real-time channel bytecount statistics.
> These registers are 32-bit hardware counters and the driver uses these
> counters to monitor the operational progress status for a channel, when
> transferring more than 4GB of data it was observed that these counters
> overflow and completion calculation of a operation gets affected and the
> transfer hangs indefinitely.
> 
> This commit adds changes to decrease the byte count for every complete
> transaction so that these registers never overflow and the proper byte
> count statistics is maintained for ongoing transaction by the RT counters.
> 
> Earlier uc->bcnt used to maintain a count of the completed bytes at driver
> side, since the RT counters maintain the statistics of current transaction
> now, the maintenance of uc->bcnt is not necessary.

Along with Peter's comment, pls fix the subsystem tag!

> 
> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
> ---
>  drivers/dma/ti/k3-udma.c | 27 +++++++++++++++++++--------
>  1 file changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> index 2f0d2c68c93c..0f91a3e47c19 100644
> --- a/drivers/dma/ti/k3-udma.c
> +++ b/drivers/dma/ti/k3-udma.c
> @@ -300,8 +300,6 @@ struct udma_chan {
>  
>  	struct udma_tx_drain tx_drain;
>  
> -	u32 bcnt; /* number of bytes completed since the start of the channel */
> -
>  	/* Channel configuration parameters */
>  	struct udma_chan_config config;
>  
> @@ -757,6 +755,22 @@ static void udma_reset_rings(struct udma_chan *uc)
>  	}
>  }
>  
> +static void udma_decrement_byte_counters(struct udma_chan *uc, u32 val)
> +{
> +	if (uc->tchan) {
> +		udma_tchanrt_write(uc, UDMA_CHAN_RT_BCNT_REG, val);
> +		udma_tchanrt_write(uc, UDMA_CHAN_RT_SBCNT_REG, val);
> +		if (!uc->bchan)
> +			udma_tchanrt_write(uc, UDMA_CHAN_RT_PEER_BCNT_REG, val);
> +	}
> +
> +	if (uc->rchan) {
> +		udma_rchanrt_write(uc, UDMA_CHAN_RT_BCNT_REG, val);
> +		udma_rchanrt_write(uc, UDMA_CHAN_RT_SBCNT_REG, val);
> +		udma_rchanrt_write(uc, UDMA_CHAN_RT_PEER_BCNT_REG, val);
> +	}
> +}
> +
>  static void udma_reset_counters(struct udma_chan *uc)
>  {
>  	u32 val;
> @@ -790,8 +804,6 @@ static void udma_reset_counters(struct udma_chan *uc)
>  		val = udma_rchanrt_read(uc, UDMA_CHAN_RT_PEER_BCNT_REG);
>  		udma_rchanrt_write(uc, UDMA_CHAN_RT_PEER_BCNT_REG, val);
>  	}
> -
> -	uc->bcnt = 0;
>  }
>  
>  static int udma_reset_chan(struct udma_chan *uc, bool hard)
> @@ -1115,8 +1127,8 @@ static void udma_check_tx_completion(struct work_struct *work)
>  		if (uc->desc) {
>  			struct udma_desc *d = uc->desc;
>  
> -			uc->bcnt += d->residue;
>  			udma_start(uc);
> +			udma_decrement_byte_counters(uc, d->residue);
>  			vchan_cookie_complete(&d->vd);
>  			break;
>  		}
> @@ -1168,8 +1180,8 @@ static irqreturn_t udma_ring_irq_handler(int irq, void *data)
>  				vchan_cyclic_callback(&d->vd);
>  			} else {
>  				if (udma_is_desc_really_done(uc, d)) {
> -					uc->bcnt += d->residue;
>  					udma_start(uc);
> +					udma_decrement_byte_counters(uc, d->residue);
>  					vchan_cookie_complete(&d->vd);
>  				} else {
>  					schedule_delayed_work(&uc->tx_drain.work,
> @@ -1204,7 +1216,7 @@ static irqreturn_t udma_udma_irq_handler(int irq, void *data)
>  			vchan_cyclic_callback(&d->vd);
>  		} else {
>  			/* TODO: figure out the real amount of data */
> -			uc->bcnt += d->residue;
> +			udma_decrement_byte_counters(uc, d->residue);
>  			udma_start(uc);
>  			vchan_cookie_complete(&d->vd);
>  		}
> @@ -3809,7 +3821,6 @@ static enum dma_status udma_tx_status(struct dma_chan *chan,
>  			bcnt = udma_tchanrt_read(uc, UDMA_CHAN_RT_BCNT_REG);
>  		}
>  
> -		bcnt -= uc->bcnt;
>  		if (bcnt && !(bcnt % uc->desc->residue))
>  			residue = 0;
>  		else
> -- 
> 2.17.1

-- 
~Vinod
