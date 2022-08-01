Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE12586804
	for <lists+dmaengine@lfdr.de>; Mon,  1 Aug 2022 13:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiHALTn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 1 Aug 2022 07:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiHALTm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 1 Aug 2022 07:19:42 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3502A734;
        Mon,  1 Aug 2022 04:19:41 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id r14so11950336ljp.2;
        Mon, 01 Aug 2022 04:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc;
        bh=cVKCQmfhIvkGCVTm3lz/sFT/n7O8Mosh0c/OeiuxeuM=;
        b=ZwSXnv4x7nD0q4YM9Sf53WgSKUUU1y4YcMxtQAW8j8LHmpeQm1MWU1nnMPD9hkwqHt
         6cqjtB+K3kdi8gWXHXWAmTo+iYDqKKU/jWLUhShPeKYcLJmzQOML6EDhDm7Hp4o2ISGI
         6ESwLaWDJhbivekjI+lr9t4+D644d2N6ij/25lzBSofxwYl/EgnsyFqIOI2t+BAOpBgr
         S6+BCslx0UP+JLS3jQKgmb2N82YnthbaWZ4sWuDm1DmMB6phkDJTrZ+UhWMuZo4BE2Pg
         2yzv5ufvzPoHxY3eoqF7xSakVggsF9ANNe023T+KdmJUd55FakCKEKYeR9k8SnPKVFN0
         9eBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=cVKCQmfhIvkGCVTm3lz/sFT/n7O8Mosh0c/OeiuxeuM=;
        b=sCsM4LFRNGzxXnuDn0LCGJxuP6AYM87j67Vx2WJoVaqff9aT81PJTA0euNGHoZwTDv
         iXfs9gQOMx7CdWjp8861Z1ruu0U6CWh6xVZSLWlV6P4ZWRtMrL6MLn8lPCgz0PYsuvBA
         BoWKtyIAqqsC6L4kppioF0VJJuO2rR+yNDSmTrT7ulRkg5RWvlSO3zZiuZHWiLg/SXNy
         UtQyeZTxW3PqqcDQ4nvKixduV9o2MtzChd89rHlsAvZulJw1PEGWx193tB9QRFp75uQv
         x3VFd24Ng35Y3ZdjwVW5GMHzbwkPjYG60CLmau18tqnfebwYiyE08FVMRyYgGZQkiwL5
         XrTg==
X-Gm-Message-State: AJIora+bw8BNGBXpY1Ow7d5erQWlEssoUs3n0yU0wiO3U8vowvtU6pJS
        vrlK3bFDEUi7dlrlEf1iRzFlIDewClVF6A==
X-Google-Smtp-Source: AGRyM1uxPvfE5Rt9VBSRXdBOXDP+CUfxTeH3fU5XELqwu1eT30Hjgdra+1ZRsxkpVweWZvWzG7lq9Q==
X-Received: by 2002:a2e:b525:0:b0:25e:115c:9021 with SMTP id z5-20020a2eb525000000b0025e115c9021mr5045505ljm.452.1659352778636;
        Mon, 01 Aug 2022 04:19:38 -0700 (PDT)
Received: from [10.0.0.42] (91-159-150-230.elisa-laajakaista.fi. [91.159.150.230])
        by smtp.gmail.com with ESMTPSA id z5-20020a2eb525000000b0025dc0adf38csm1510685ljm.61.2022.08.01.04.19.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Aug 2022 04:19:37 -0700 (PDT)
Message-ID: <3776eba2-0f36-7ba6-d49a-0f896754612e@gmail.com>
Date:   Mon, 1 Aug 2022 14:27:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Vaishnav Achath <vaishnav.a@ti.com>, vkoul@kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     nm@ti.com, vigneshr@ti.com, p.yadav@ti.com, j-keerthy@ti.com,
        m-khayami@ti.com, stanley_liu@ti.com
References: <20220727140837.25877-1-vaishnav.a@ti.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Subject: Re: [PATCH v2] dmaengine: ti: k3-udma: Reset UDMA_CHAN_RT byte
 counters to prevent overflow
In-Reply-To: <20220727140837.25877-1-vaishnav.a@ti.com>
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



On 7/27/22 17:08, Vaishnav Achath wrote:
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
> 
> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
> ---
> V1->V2 :
>         * Update bcnt reset based on uc->desc->dir
>         * change order of udma_decrement_byte_counters() to before udma_start()
>         * update subsystem tag
> 
>  drivers/dma/ti/k3-udma.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> index 2f0d2c68c93c..39b330ada200 100644
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
> +	if (uc->desc->dir == DMA_DEV_TO_MEM && uc->rchan) {

if the dir is DMA_DEV_TO_MEM then we have rchan, no need for checking it.

> +		udma_rchanrt_write(uc, UDMA_CHAN_RT_BCNT_REG, val);
> +		udma_rchanrt_write(uc, UDMA_CHAN_RT_SBCNT_REG, val);
> +		udma_rchanrt_write(uc, UDMA_CHAN_RT_PEER_BCNT_REG, val);
> +	} else if (uc->tchan) {

in other directions (MEM_TO_DEV, MEM_TO_MEM) we have tchan.

> +		udma_tchanrt_write(uc, UDMA_CHAN_RT_BCNT_REG, val);
> +		udma_tchanrt_write(uc, UDMA_CHAN_RT_SBCNT_REG, val);
> +		if (!uc->bchan)
> +			udma_tchanrt_write(uc, UDMA_CHAN_RT_PEER_BCNT_REG, val);
> +	}
> +}

Thus we only need this type of decision:

if (uc->desc->dir == DMA_DEV_TO_MEM) {
	udma_rchanrt_write(uc, UDMA_CHAN_RT_BCNT_REG, val);
	udma_rchanrt_write(uc, UDMA_CHAN_RT_SBCNT_REG, val);
	udma_rchanrt_write(uc, UDMA_CHAN_RT_PEER_BCNT_REG, val);
} else {
	udma_tchanrt_write(uc, UDMA_CHAN_RT_BCNT_REG, val);
	udma_tchanrt_write(uc, UDMA_CHAN_RT_SBCNT_REG, val);
	if (!uc->bchan)
		udma_tchanrt_write(uc, UDMA_CHAN_RT_PEER_BCNT_REG, val);
}

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
