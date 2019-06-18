Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1154A46D
	for <lists+dmaengine@lfdr.de>; Tue, 18 Jun 2019 16:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbfFROtx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Jun 2019 10:49:53 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52395 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729337AbfFROtx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Jun 2019 10:49:53 -0400
Received: by mail-wm1-f65.google.com with SMTP id s3so3640741wms.2
        for <dmaengine@vger.kernel.org>; Tue, 18 Jun 2019 07:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Bw9Az1sDvYftv6OoenbcNn/WFNLrPeZPeUya6SiZhJE=;
        b=udv6A62ft/6+VkDzxa/PEOUwv3/ZITu7g/8w9iRR9ReSzG9lypxa62Pi4r9SN/Hhll
         FxiwNMpXKfogjWbeqkzE2jV1lTTjRsI5u2Ncn8o1StwJg3GwNsiQ0HTrn5K0u/7RXh8S
         e1Q4tcAQsalTh9bGi3YD4OfZYOGVt+uw3PnER43NYbFCThzlpqmKHcTqPQw3ZVPe9tWG
         PH1NVJSU5xUCVBCrz1s0Olr29daX709FTtmsAxJ+DWL2f1e3r2fWhIlvai+QmhWcokqz
         +sesl3yqFuJNNFqf70VfLr0azantLnGN1l0EabSUQ1F3+PVqxu2f2zGH9FeOGs9C6sdr
         aP+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Bw9Az1sDvYftv6OoenbcNn/WFNLrPeZPeUya6SiZhJE=;
        b=h3J9bESZw2z8hnyoakBOLZiix00vZzzHudNPXz97uR8MJoBF4y+84CP2kwevXOz6gC
         j1EO576qOMP+Itbztqr60dE+m58CYGAfWAQGjO7D8V1cHDEfFtFeNbTpDXV34eWM7Wnt
         tTzk/PLNbqp9tYVsbaELikgEsxQn/cSYlnwXBjXHx5CxhdaB5ZLUt4YBstQO2Xso5Xaw
         TtAkkVuWnpayzVhhlBn6aMyJBYmAm7TT/j95RsElgw/pQPtU3aYL9pGVNhIDxrpjIrgV
         BZooriQEvus9WoI2tLUFuY4rAbhFqgqHlmxTyWQmoPr6xdFHMeBKYG2XZchzWIWyEMdI
         9HOQ==
X-Gm-Message-State: APjAAAVAu1lrLFEI3hXTW0Q4wICPtwJLLMzQzxzrW/cEc5I7Qh5o3SN0
        x4m1O7DDbdTJQ5M9rQoLWqX3WA==
X-Google-Smtp-Source: APXvYqy81kOsWTfc3qI9cyUFMvjSdlsf4pF4JIm5L+OGMDjbnEgEg9Dfd3m/D9WpbJsDGd8xvzXW1Q==
X-Received: by 2002:a7b:c74a:: with SMTP id w10mr3834115wmk.99.1560869390770;
        Tue, 18 Jun 2019 07:49:50 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id j189sm3881237wmb.48.2019.06.18.07.49.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 07:49:50 -0700 (PDT)
Subject: Re: [PATCH] dmaengine: qcom-bam: fix circular buffer handling
To:     Sricharan R <sricharan@codeaurora.org>, vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20190614142012.31384-1-srinivas.kandagatla@linaro.org>
 <f4522b78-b406-954c-57b7-923e6ab31f96@codeaurora.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <ab29c08b-d509-a275-f208-ace1041a27af@linaro.org>
Date:   Tue, 18 Jun 2019 15:49:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <f4522b78-b406-954c-57b7-923e6ab31f96@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Sricharan,

On 18/06/2019 08:13, Sricharan R wrote:
> Hi Srini,
> 
> On 6/14/2019 7:50 PM, Srinivas Kandagatla wrote:
>> For some reason arguments to most of the circular buffers
>> macros are used in reverse, tail is used for head and vice versa.
>>
>> This leads to bam thinking that there is an extra descriptor at the
>> end and leading to retransmitting descriptor which was not scheduled
>> by any driver. This happens after MAX_DESCRIPTORS (4096) are scheduled
>> and done, so most of the drivers would not notice this, unless they are
>> heavily using bam dma. Originally found this issue while testing
>> SoundWire over SlimBus on DB845c which uses DMA very heavily for
>> read/writes.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   drivers/dma/qcom/bam_dma.c | 9 ++++-----
>>   1 file changed, 4 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
>> index cb860cb53c27..43d7b0a9713a 100644
>> --- a/drivers/dma/qcom/bam_dma.c
>> +++ b/drivers/dma/qcom/bam_dma.c
>> @@ -350,8 +350,8 @@ static const struct reg_offset_data bam_v1_7_reg_info[] = {
>>   #define BAM_DESC_FIFO_SIZE	SZ_32K
>>   #define MAX_DESCRIPTORS (BAM_DESC_FIFO_SIZE / sizeof(struct bam_desc_hw) - 1)
>>   #define BAM_FIFO_SIZE	(SZ_32K - 8)
>> -#define IS_BUSY(chan)	(CIRC_SPACE(bchan->tail, bchan->head,\
>> -			 MAX_DESCRIPTORS + 1) == 0)
>> +#define IS_BUSY(chan)	(CIRC_SPACE(bchan->head, bchan->tail,\
>> +			 MAX_DESCRIPTORS) == 0)
>>   
>>   struct bam_chan {
>>   	struct virt_dma_chan vc;
>> @@ -806,7 +806,7 @@ static u32 process_channel_irqs(struct bam_device *bdev)
>>   		offset /= sizeof(struct bam_desc_hw);
>>   
>>   		/* Number of bytes available to read */
>> -		avail = CIRC_CNT(offset, bchan->head, MAX_DESCRIPTORS + 1);
>> +		avail = CIRC_CNT(bchan->head, offset, MAX_DESCRIPTORS);
>>
>   one question, so MAX_DESCRIPTORS is already a mask,
>      #define MAX_DESCRIPTORS (BAM_DESC_FIFO_SIZE / sizeof(struct bam_desc_hw) - 1)
> 
>   CIRC_CNT/SPACE macros also does a size - 1, so would it not be a problem if we
>   just pass MAX_DESCRIPTORS ?

Thanks for looking at this,
TBH, usage of CIRC_* macros is only valid for power-of-2 buffers,
In bam case MAX_DESCRIPTORS is 4095.
Am really not sure why 8 bytes have been removed from fifo data buffer size.
So basically usage of these macros is incorrect in bam case, this need 
to be fixed properly.

Do you agree?

Vinod, can you hold off with this patch, I will try to find some time 
this week to cook up a better patch removing the usage of these macros.



thanks,
srini

> 
> Regards,
>   Sricharan
>    
>>   		list_for_each_entry_safe(async_desc, tmp,
>>   					 &bchan->desc_list, desc_node) {
>> @@ -997,8 +997,7 @@ static void bam_start_dma(struct bam_chan *bchan)
>>   			bam_apply_new_config(bchan, async_desc->dir);
>>   
>>   		desc = async_desc->curr_desc;
>> -		avail = CIRC_SPACE(bchan->tail, bchan->head,
>> -				   MAX_DESCRIPTORS + 1);
>> +		avail = CIRC_SPACE(bchan->head, bchan->tail, MAX_DESCRIPTORS);
>>   
>>   		if (async_desc->num_desc > avail)
>>   			async_desc->xfer_len = avail;
>>
> 
