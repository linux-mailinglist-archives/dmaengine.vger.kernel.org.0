Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C866C4BD136
	for <lists+dmaengine@lfdr.de>; Sun, 20 Feb 2022 21:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242563AbiBTUNQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 20 Feb 2022 15:13:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiBTUNP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 20 Feb 2022 15:13:15 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A2537032;
        Sun, 20 Feb 2022 12:12:54 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id j7so14937263lfu.6;
        Sun, 20 Feb 2022 12:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=slr76XQUTxzYBC1o6cR0FOwPw3f0Exd0zf9J+QvjWVU=;
        b=JlHidUfS/aWU3sI5AxY3hGnAwL/rwQrFGXZ+altfj8ewkyzEkxpRpfrvv1rVTzURpe
         10zBMQCLMPz146hvRm7YJoejQUkTSKdvCPX3gqNMucgHQPPHACia7/O8bLZdWHIZSWDd
         JEDaFvP08/mg8no/7uX7arqP5GzigEO6DzEDMCLf3TXx7o5rTIjAz/76kZtnJ2O9HeVD
         tmdUQkj27pmYoJZr4s4QpmIwS2Y++bY5nb4bW4KYQAAzDaFAgLMGHo13e8GEcBp28nKg
         DeMDRBViyF1OtD1XxWf75Z0ouuuJSvWYfQRPCac7JT22bxY6KYmiWueC9maZjeEwLOKI
         LHug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=slr76XQUTxzYBC1o6cR0FOwPw3f0Exd0zf9J+QvjWVU=;
        b=lAUipvBgsFDCJqD8d6B/8hOvNL2iziDmdyH62ngHwcSlb4h6q9SQEZxM72+rpCC8mU
         Vd/mUva9JZQaH2FpstK7n7XXv3Z7Iml3lpPDu1IlArYtslMUYEv5FrOcZVeIbhcw4POJ
         3qL5WFFthbxr3NgmZ3QTrxxOJ7bBVo7U0IT0tCgyzIxUS3RHkPOJg35xTfNpBTjdVLwE
         fXslelbBNxR9I6xQsZnzq8Z75sk7LtE6Th1nB2D4USEMdEDsi6Dvv2wi7SjqaJC4imJ3
         BXgzzAgch94C5mqcc9nKJkbgHc+GwtFxZOgcnPeebISAJ9hwTZtzfqkVuWBoiFAfLbQs
         m+IA==
X-Gm-Message-State: AOAM530AAVhfAve+Sw6PbFvtaakudM/vStgB/uAzSfZ3+1oQzkyGJzJD
        7mO69cMJL8o3FOjQYrvNoYfP1TIRsyitUQ==
X-Google-Smtp-Source: ABdhPJzf9zSUENkTDU6owmZjmORSfh0e+4XYWzurjJEBUUNfP6cE90HeltIY4n+dJ82BPT/gX56jkg==
X-Received: by 2002:a05:6512:20c2:b0:443:ee7c:2f42 with SMTP id u2-20020a05651220c200b00443ee7c2f42mr1313427lfr.612.1645387972279;
        Sun, 20 Feb 2022 12:12:52 -0800 (PST)
Received: from [10.0.0.127] (91-153-170-164.elisa-laajakaista.fi. [91.153.170.164])
        by smtp.gmail.com with ESMTPSA id d9sm905902lfv.271.2022.02.20.12.12.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Feb 2022 12:12:51 -0800 (PST)
Message-ID: <542af98b-d94e-3ab9-eb35-3660ddab7635@gmail.com>
Date:   Sun, 20 Feb 2022 22:13:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] dma: ti: cleanup comments
Content-Language: en-US
To:     trix@redhat.com, vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220217182546.3266909-1-trix@redhat.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <20220217182546.3266909-1-trix@redhat.com>
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



On 17/02/2022 20:25, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> Remove the second 'the'
> 
> Replacements
> completetion to completion
> seens to seen
> pendling to pending
> atleast to at least
> tranfer to transfer
> multibple to a multiple
> transfering to transferring

Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>

> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/dma/ti/cppi41.c   |  6 +++---
>  drivers/dma/ti/edma.c     | 10 +++++-----
>  drivers/dma/ti/omap-dma.c |  2 +-
>  3 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/dma/ti/cppi41.c b/drivers/dma/ti/cppi41.c
> index 8c2f7ebe998c..062bd9bd4de0 100644
> --- a/drivers/dma/ti/cppi41.c
> +++ b/drivers/dma/ti/cppi41.c
> @@ -315,7 +315,7 @@ static irqreturn_t cppi41_irq(int irq, void *data)
>  		val = cppi_readl(cdd->qmgr_mem + QMGR_PEND(i));
>  		if (i == QMGR_PENDING_SLOT_Q(first_completion_queue) && val) {
>  			u32 mask;
> -			/* set corresponding bit for completetion Q 93 */
> +			/* set corresponding bit for completion Q 93 */
>  			mask = 1 << QMGR_PENDING_BIT_Q(first_completion_queue);
>  			/* not set all bits for queues less than Q 93 */
>  			mask--;
> @@ -703,7 +703,7 @@ static int cppi41_tear_down_chan(struct cppi41_channel *c)
>  	 * transfer descriptor followed by TD descriptor. Waiting seems not to
>  	 * cause any difference.
>  	 * RX seems to be thrown out right away. However once the TearDown
> -	 * descriptor gets through we are done. If we have seens the transfer
> +	 * descriptor gets through we are done. If we have seen the transfer
>  	 * descriptor before the TD we fetch it from enqueue, it has to be
>  	 * there waiting for us.
>  	 */
> @@ -747,7 +747,7 @@ static int cppi41_stop_chan(struct dma_chan *chan)
>  		struct cppi41_channel *cc, *_ct;
>  
>  		/*
> -		 * channels might still be in the pendling list if
> +		 * channels might still be in the pending list if
>  		 * cppi41_dma_issue_pending() is called after
>  		 * cppi41_runtime_suspend() is called
>  		 */
> diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
> index 08e47f44d325..3ea8ef7f57df 100644
> --- a/drivers/dma/ti/edma.c
> +++ b/drivers/dma/ti/edma.c
> @@ -118,10 +118,10 @@
>  
>  /*
>   * Max of 20 segments per channel to conserve PaRAM slots
> - * Also note that MAX_NR_SG should be atleast the no.of periods
> + * Also note that MAX_NR_SG should be at least the no.of periods
>   * that are required for ASoC, otherwise DMA prep calls will
>   * fail. Today davinci-pcm is the only user of this driver and
> - * requires atleast 17 slots, so we setup the default to 20.
> + * requires at least 17 slots, so we setup the default to 20.
>   */
>  #define MAX_NR_SG		20
>  #define EDMA_MAX_SLOTS		MAX_NR_SG
> @@ -976,7 +976,7 @@ static int edma_config_pset(struct dma_chan *chan, struct edma_pset *epset,
>  		 * and quotient respectively of the division of:
>  		 * (dma_length / acnt) by (SZ_64K -1). This is so
>  		 * that in case bcnt over flows, we have ccnt to use.
> -		 * Note: In A-sync tranfer only, bcntrld is used, but it
> +		 * Note: In A-sync transfer only, bcntrld is used, but it
>  		 * only applies for sg_dma_len(sg) >= SZ_64K.
>  		 * In this case, the best way adopted is- bccnt for the
>  		 * first frame will be the remainder below. Then for
> @@ -1203,7 +1203,7 @@ static struct dma_async_tx_descriptor *edma_prep_dma_memcpy(
>  		 * slot2: the remaining amount of data after slot1.
>  		 *	  ACNT = full_length - length1, length2 = ACNT
>  		 *
> -		 * When the full_length is multibple of 32767 one slot can be
> +		 * When the full_length is a multiple of 32767 one slot can be
>  		 * used to complete the transfer.
>  		 */
>  		width = array_size;
> @@ -1814,7 +1814,7 @@ static void edma_issue_pending(struct dma_chan *chan)
>   * This limit exists to avoid a possible infinite loop when waiting for proof
>   * that a particular transfer is completed. This limit can be hit if there
>   * are large bursts to/from slow devices or the CPU is never able to catch
> - * the DMA hardware idle. On an AM335x transfering 48 bytes from the UART
> + * the DMA hardware idle. On an AM335x transferring 48 bytes from the UART
>   * RX-FIFO, as many as 55 loops have been seen.
>   */
>  #define EDMA_MAX_TR_WAIT_LOOPS 1000
> diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
> index 7cb577e6587b..8e52a0dc1f78 100644
> --- a/drivers/dma/ti/omap-dma.c
> +++ b/drivers/dma/ti/omap-dma.c
> @@ -1442,7 +1442,7 @@ static int omap_dma_pause(struct dma_chan *chan)
>  	 * A source-synchronised channel is one where the fetching of data is
>  	 * under control of the device. In other words, a device-to-memory
>  	 * transfer. So, a destination-synchronised channel (which would be a
> -	 * memory-to-device transfer) undergoes an abort if the the CCR_ENABLE
> +	 * memory-to-device transfer) undergoes an abort if the CCR_ENABLE
>  	 * bit is cleared.
>  	 * From 16.1.4.20.4.6.2 Abort: "If an abort trigger occurs, the channel
>  	 * aborts immediately after completion of current read/write

-- 
Péter
