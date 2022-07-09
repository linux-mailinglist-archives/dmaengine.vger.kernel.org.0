Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A505856C77B
	for <lists+dmaengine@lfdr.de>; Sat,  9 Jul 2022 08:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbiGIGMu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 9 Jul 2022 02:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiGIGMt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 9 Jul 2022 02:12:49 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A374666AEF;
        Fri,  8 Jul 2022 23:12:47 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id e12so950183lfr.6;
        Fri, 08 Jul 2022 23:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=CAr6PXij8tLxjGYasxbxW8UJNAWj4rRkL9bczqgvOqs=;
        b=ahvq0jFq/8eIsZfH5uDHlzOEH6ghI7wpdydBnQQoiLM+4CzYBQJxc1e7RuXa5sfLHJ
         m7tIi2V5kYGjmcWZ3SeD9b5FMElTRcrt5Ea/v3LT5euggeG7K+2W4+E7gbXd78JJfFAl
         R0eepQwCQ0pEI1ngZluHW2ndELCqtv+gubYEKSxLnjlleZYWPWpkYBRKTfISHtsUNQyf
         OrSwnIJqNjaUxUxrKadA50bWkjGTdlwqK3HDFiWwp5xpqcQXRKKeM37Ohl/QNbSuT2XV
         PYNkCpW5jk/Zeyh/qvpw4vd2QTQfPy46OuzNdPgvdgkgJ2wHd8qzx9jQ7dos6SKXFLCV
         ttkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=CAr6PXij8tLxjGYasxbxW8UJNAWj4rRkL9bczqgvOqs=;
        b=OfvFmjyt8OKHbOwE5w1Y/PKpXI1mNgKUigAm73WNntEvloZbQoXwzWkMQUkGPwNe8E
         eCzk2G/wYx9yMFG7nbT3wuTnY1CSMwEVc3sioQHmxEYHkLAKGFmUtL+QUUCsxCc4FLib
         //472pl17BGUZvdc0zK7/FdmjbOZdHc8A2IgrANC6xfrWPlTtNhPlaRCMJKZZKcTKJ/c
         3+qynLlEJGmoP+LABEg3mJBoSrEiZqXLzWmtmKv59wX9yWJZJgZlEZ3DO30dg2HEJYsc
         WuK3N++aZaUV7HFShi/bD4IpTYnCgGtn6e698jNsi3ZHLbnpFbfjTGZibZiHU4St+gBC
         W52w==
X-Gm-Message-State: AJIora9onrx9j2W03sDIo+uHycmo+1r7cl7SRsIqua9HnR14Oht8dfaN
        hBO86MX9f12Rl5iS9J9okuI=
X-Google-Smtp-Source: AGRyM1svFzWjmMkXTXQEktUmWBsz5LVBDPW5MKsxg52vP38p/uxv4xt/DwthtJhv1yrdkiEV056YLA==
X-Received: by 2002:a05:6512:688:b0:488:f7de:6e3 with SMTP id t8-20020a056512068800b00488f7de06e3mr4580130lfe.495.1657347165825;
        Fri, 08 Jul 2022 23:12:45 -0700 (PDT)
Received: from [10.0.0.42] (91-159-150-230.elisa-laajakaista.fi. [91.159.150.230])
        by smtp.gmail.com with ESMTPSA id b40-20020a0565120ba800b004785b66a9a4sm211984lfv.126.2022.07.08.23.12.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jul 2022 23:12:45 -0700 (PDT)
Message-ID: <ad6dcdb8-8d4d-6f8b-38de-be2756a39028@gmail.com>
Date:   Sat, 9 Jul 2022 09:20:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Vaishnav Achath <vaishnav.a@ti.com>, vkoul@kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     nm@ti.com, vigneshr@ti.com, p.yadav@ti.com, j-keerthy@ti.com,
        m-khayami@ti.com, stanley_liu@ti.com
References: <20220704111325.636-1-vaishnav.a@ti.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Subject: Re: [PATCH] dma: ti: k3-udma: Reset UDMA_CHAN_RT byte counters to
 prevent overflow
In-Reply-To: <20220704111325.636-1-vaishnav.a@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 7/4/22 14:13, Vaishnav Achath wrote:
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

Thanks for the patch,

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

In case of MEM_TO_MEM (or the not implemented DEV_TO_DEV) we use the
tchan's counter for position tracking, but we have the pair anyways (UDMA).
if ((uc->desc->dir == DMA_DEV_TO_MEM)
	rchan bcnt reset
else
	tchan bcnt reset

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

Why not before udma_start()?

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

-- 
Péter
