Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCFE588873
	for <lists+dmaengine@lfdr.de>; Wed,  3 Aug 2022 10:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbiHCIGZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 3 Aug 2022 04:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235199AbiHCIGY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 3 Aug 2022 04:06:24 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C978220E6;
        Wed,  3 Aug 2022 01:06:21 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id m22so13481456lfl.9;
        Wed, 03 Aug 2022 01:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc;
        bh=TSlAb8QUNSWyAXVGnp8zPCHMrFa9cMCzn91LI53nZo8=;
        b=F+Ir1CBQi581OpNqvOJ9SHUtV8QZSI2B+x1iNa8Z6Nd/CgF+xd2WlCeFVF7JxRu8zG
         F+KPZisK6zCLTgA8pPctB8f4QaQqgKqvXvMT4JAbsJ2nZQO4tf7pYE5UZgOM3TDPju/q
         Q4PNb6krIwj0i0F9jrqDMxrOkJNo4dWmbK0ZJ6A1t8JdUqzy2qD7rGRusBFMMSoBkXG6
         irVoWmM2lVrLujVRr7UAtH6Biq/d2qPNeZolKjkb9FXwwkpnSODPDvxYUeGuZHGhYzKI
         LOOQL/BID6iPDuMuGVblRg+GjzvHlKMdcmOHz6mxy9los9KbZRLCl6IApaPz91aUANpK
         6/LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=TSlAb8QUNSWyAXVGnp8zPCHMrFa9cMCzn91LI53nZo8=;
        b=elMQlGC4kfdXvgCrpvMMDzXlfmCCfcL3vgFPmsRp+KCY0fsnh1071syQ0oeFKWtT8J
         kKiONuRKdtOEkTZWWTWPfCJBmmVTzeXYHJGsz55yR9YEdv8TffViWWeBTM86Pr0cFatD
         5NGAddKvVL0lRfFepo33KEgOvIfOaDRxSAaNEW6kPy5oMrQIUzouL+XnDF61UkkDc9h1
         +5I63BiROjdmf9nP3oQn7xuz5v5EKIxPQGFgvafO8ihucac8QwEQSDXLOYqgBC7NnVFV
         cyI9drPkH2X/dplChw005AYmO61kcgbwKDm0YQwPmxnWP6PGQ+EF097AfJkF+ajHjTjV
         JAGA==
X-Gm-Message-State: AJIora94nHO1nLvkLX9geD4y3AMtg3INKQBeu0PAbuakiPMFgefK8mjm
        Eu83Ng/V86k0jgDrK4NPwBxE4nMKmee1tA==
X-Google-Smtp-Source: AGRyM1tvVtEhDOQtk8IqozLo5JNRTUFSzsv1FwStjTEl+Nv54p5O3Pd3FhzdrOcI8ZSZgHIq+2l+Ig==
X-Received: by 2002:a05:6512:13a1:b0:47f:787b:4e6a with SMTP id p33-20020a05651213a100b0047f787b4e6amr8213312lfa.64.1659513979143;
        Wed, 03 Aug 2022 01:06:19 -0700 (PDT)
Received: from [10.0.0.127] (91-159-150-230.elisa-laajakaista.fi. [91.159.150.230])
        by smtp.gmail.com with ESMTPSA id o3-20020a2e9b43000000b0025e2cb58c6esm2223420ljj.37.2022.08.03.01.06.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 01:06:18 -0700 (PDT)
Message-ID: <0fa5fdeb-b633-c543-3e98-1f5e1f064c34@gmail.com>
Date:   Wed, 3 Aug 2022 11:08:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Vaishnav Achath <vaishnav.a@ti.com>, vkoul@kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     nm@ti.com, vigneshr@ti.com, j-keerthy@ti.com, m-khayami@ti.com,
        stanley_liu@ti.com
References: <20220802054835.19482-1-vaishnav.a@ti.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Subject: Re: [PATCH v3] dmaengine: ti: k3-udma: Reset UDMA_CHAN_RT byte
 counters to prevent overflow
In-Reply-To: <20220802054835.19482-1-vaishnav.a@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 02/08/2022 08:48, Vaishnav Achath wrote:
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

Thanks for the updates:

Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>

btw: did you encountered issues with cyclic (audio, ADC) regarding to
wrapping of the counters? S16_LE, stereo, 48KHz should wrap around
22.369 hours.
It is a bit trickier as we might be running without interrupts, so we
can not rely on the same trick.

> 
> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
> ---
> V2->V3 :
> 		* Remove unnecessary checks for uc->tchan and uc->rchan in 
> 		udma_decrement_byte_counters()
> V1->V2 :
> 		* Update bcnt reset based on uc->desc->dir
> 		* change order of udma_decrement_byte_counters() to before udma_start()
> 		* update subsystem tag
> 
>  drivers/dma/ti/k3-udma.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> index 2f0d2c68c93c..fcfcde947b30 100644
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
> @@ -757,6 +755,20 @@ static void udma_reset_rings(struct udma_chan *uc)
>  	}
>  }
>  
> +static void udma_decrement_byte_counters(struct udma_chan *uc, u32 val)
> +{
> +	if (uc->desc->dir == DMA_DEV_TO_MEM) {
> +		udma_rchanrt_write(uc, UDMA_CHAN_RT_BCNT_REG, val);
> +		udma_rchanrt_write(uc, UDMA_CHAN_RT_SBCNT_REG, val);
> +		udma_rchanrt_write(uc, UDMA_CHAN_RT_PEER_BCNT_REG, val);
> +	} else {
> +		udma_tchanrt_write(uc, UDMA_CHAN_RT_BCNT_REG, val);
> +		udma_tchanrt_write(uc, UDMA_CHAN_RT_SBCNT_REG, val);
> +		if (!uc->bchan)
> +			udma_tchanrt_write(uc, UDMA_CHAN_RT_PEER_BCNT_REG, val);
> +	}
> +}
> +
>  static void udma_reset_counters(struct udma_chan *uc)
>  {
>  	u32 val;
> @@ -790,8 +802,6 @@ static void udma_reset_counters(struct udma_chan *uc)
>  		val = udma_rchanrt_read(uc, UDMA_CHAN_RT_PEER_BCNT_REG);
>  		udma_rchanrt_write(uc, UDMA_CHAN_RT_PEER_BCNT_REG, val);
>  	}
> -
> -	uc->bcnt = 0;
>  }
>  
>  static int udma_reset_chan(struct udma_chan *uc, bool hard)
> @@ -1115,7 +1125,7 @@ static void udma_check_tx_completion(struct work_struct *work)
>  		if (uc->desc) {
>  			struct udma_desc *d = uc->desc;
>  
> -			uc->bcnt += d->residue;
> +			udma_decrement_byte_counters(uc, d->residue);
>  			udma_start(uc);
>  			vchan_cookie_complete(&d->vd);
>  			break;
> @@ -1168,7 +1178,7 @@ static irqreturn_t udma_ring_irq_handler(int irq, void *data)
>  				vchan_cyclic_callback(&d->vd);
>  			} else {
>  				if (udma_is_desc_really_done(uc, d)) {
> -					uc->bcnt += d->residue;
> +					udma_decrement_byte_counters(uc, d->residue);
>  					udma_start(uc);
>  					vchan_cookie_complete(&d->vd);
>  				} else {
> @@ -1204,7 +1214,7 @@ static irqreturn_t udma_udma_irq_handler(int irq, void *data)
>  			vchan_cyclic_callback(&d->vd);
>  		} else {
>  			/* TODO: figure out the real amount of data */
> -			uc->bcnt += d->residue;
> +			udma_decrement_byte_counters(uc, d->residue);
>  			udma_start(uc);
>  			vchan_cookie_complete(&d->vd);
>  		}
> @@ -3809,7 +3819,6 @@ static enum dma_status udma_tx_status(struct dma_chan *chan,
>  			bcnt = udma_tchanrt_read(uc, UDMA_CHAN_RT_BCNT_REG);
>  		}
>  
> -		bcnt -= uc->bcnt;
>  		if (bcnt && !(bcnt % uc->desc->residue))
>  			residue = 0;
>  		else

-- 
Péter
