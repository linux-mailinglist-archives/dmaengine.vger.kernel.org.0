Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8F3149A1A
	for <lists+dmaengine@lfdr.de>; Tue, 18 Jun 2019 09:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfFRHNm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Jun 2019 03:13:42 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40570 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfFRHNm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Jun 2019 03:13:42 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1E30B6090E; Tue, 18 Jun 2019 07:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1560842021;
        bh=XTiimhV+n9VzS1rZyfIwb9pLvIYzN1Osq4PZikeOl/4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=B5HKKSVZtAPIdRyC3FIXb3LV8KFcX+dbVBp1rqarNtbdm/clH0IKb80cSXpOfP0pa
         mwN25N8RhWG8ungDBKCrG6de/pRJeMCTcZkulUrln5kgwdq650TOGqxvIFVySUzrpd
         I1udRLOjLEzlNUSn4rnWuLoKwEQpWcjj+wPsOO7o=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from [10.201.2.161] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sricharan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 30887602BC;
        Tue, 18 Jun 2019 07:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1560842019;
        bh=XTiimhV+n9VzS1rZyfIwb9pLvIYzN1Osq4PZikeOl/4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=atN1Si4hNIPPz+RxguhRNz9bE9uWQZ1ukCyEbAdtLm1WsHgFACS5aWiBBY39HnJt0
         OhThHmAdJxVJLbzajmtEBFRzm9kDHG5gxRLrEmhI/bFVQ5+qGOLFqmzl5V6s6ZHJOY
         zyG2oH9rQ/3R4SEVodbGQb6IcbTrAICXmajFolpM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 30887602BC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
Subject: Re: [PATCH] dmaengine: qcom-bam: fix circular buffer handling
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20190614142012.31384-1-srinivas.kandagatla@linaro.org>
From:   Sricharan R <sricharan@codeaurora.org>
Message-ID: <f4522b78-b406-954c-57b7-923e6ab31f96@codeaurora.org>
Date:   Tue, 18 Jun 2019 12:43:35 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190614142012.31384-1-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Srini,

On 6/14/2019 7:50 PM, Srinivas Kandagatla wrote:
> For some reason arguments to most of the circular buffers
> macros are used in reverse, tail is used for head and vice versa.
> 
> This leads to bam thinking that there is an extra descriptor at the
> end and leading to retransmitting descriptor which was not scheduled
> by any driver. This happens after MAX_DESCRIPTORS (4096) are scheduled
> and done, so most of the drivers would not notice this, unless they are
> heavily using bam dma. Originally found this issue while testing
> SoundWire over SlimBus on DB845c which uses DMA very heavily for
> read/writes.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/dma/qcom/bam_dma.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
> index cb860cb53c27..43d7b0a9713a 100644
> --- a/drivers/dma/qcom/bam_dma.c
> +++ b/drivers/dma/qcom/bam_dma.c
> @@ -350,8 +350,8 @@ static const struct reg_offset_data bam_v1_7_reg_info[] = {
>  #define BAM_DESC_FIFO_SIZE	SZ_32K
>  #define MAX_DESCRIPTORS (BAM_DESC_FIFO_SIZE / sizeof(struct bam_desc_hw) - 1)
>  #define BAM_FIFO_SIZE	(SZ_32K - 8)
> -#define IS_BUSY(chan)	(CIRC_SPACE(bchan->tail, bchan->head,\
> -			 MAX_DESCRIPTORS + 1) == 0)
> +#define IS_BUSY(chan)	(CIRC_SPACE(bchan->head, bchan->tail,\
> +			 MAX_DESCRIPTORS) == 0)
>  
>  struct bam_chan {
>  	struct virt_dma_chan vc;
> @@ -806,7 +806,7 @@ static u32 process_channel_irqs(struct bam_device *bdev)
>  		offset /= sizeof(struct bam_desc_hw);
>  
>  		/* Number of bytes available to read */
> -		avail = CIRC_CNT(offset, bchan->head, MAX_DESCRIPTORS + 1);
> +		avail = CIRC_CNT(bchan->head, offset, MAX_DESCRIPTORS);
>
 one question, so MAX_DESCRIPTORS is already a mask,
    #define MAX_DESCRIPTORS (BAM_DESC_FIFO_SIZE / sizeof(struct bam_desc_hw) - 1)

 CIRC_CNT/SPACE macros also does a size - 1, so would it not be a problem if we
 just pass MAX_DESCRIPTORS ?

Regards,
 Sricharan
  
>  		list_for_each_entry_safe(async_desc, tmp,
>  					 &bchan->desc_list, desc_node) {
> @@ -997,8 +997,7 @@ static void bam_start_dma(struct bam_chan *bchan)
>  			bam_apply_new_config(bchan, async_desc->dir);
>  
>  		desc = async_desc->curr_desc;
> -		avail = CIRC_SPACE(bchan->tail, bchan->head,
> -				   MAX_DESCRIPTORS + 1);
> +		avail = CIRC_SPACE(bchan->head, bchan->tail, MAX_DESCRIPTORS);
>  
>  		if (async_desc->num_desc > avail)
>  			async_desc->xfer_len = avail;
> 

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
