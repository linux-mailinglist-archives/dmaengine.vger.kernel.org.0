Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71DF657A314
	for <lists+dmaengine@lfdr.de>; Tue, 19 Jul 2022 17:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234057AbiGSPbN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Jul 2022 11:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233950AbiGSPbM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Jul 2022 11:31:12 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7809E5885F;
        Tue, 19 Jul 2022 08:31:11 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26JFS1Ep030938;
        Tue, 19 Jul 2022 17:30:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=StPFKjyHQ6JloIb+PfGZXvKA/3ATMA/f8rEmiAG937w=;
 b=fl6q9Zf+v/AGGlfuFTPXasDWrUhSoE+j6VgYcJmn8GCP3tz/2iou1Mw3mKkIa6Kl1VxS
 WeWnvZGlik7J44IVqyNa9PHq8EV7bkWVH5twzT40Y5Rp4Umi5NBx0IYfrzLS0gX67RK/
 pqVlJz41MvN+PceULVZUX/XjEw7zQkjzw+KwYnmhYV4iVTkoUpLPWbZ3WkchwCbxBno/
 mPg/1jSvG9W0kQ87qzMdevuAoiCu/6EmLnXXrTmvTng5EO0FglMqVZ51T15ShWsNK70a
 Zt/Tk91EGKuJPPiWwBlAbx/1ZWETI9PgkgFuIIDK5oF3SOCMWEqzZFUGfv+56ukcx+zl 5w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3hbnhy0kkf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Jul 2022 17:30:55 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 655F510002A;
        Tue, 19 Jul 2022 17:30:54 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 45BDD22AFE7;
        Tue, 19 Jul 2022 17:30:54 +0200 (CEST)
Received: from [10.201.20.208] (10.75.127.45) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Tue, 19 Jul
 2022 17:30:50 +0200
Message-ID: <d46e5eee-c8ae-545f-e69e-1dd2f2e71323@foss.st.com>
Date:   Tue, 19 Jul 2022 17:30:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 3/4] dmaengine: stm32-dma: add support to trigger STM32
 MDMA
Content-Language: en-US
To:     Marek Vasut <marex@denx.de>, Jonathan Corbet <corbet@lwn.net>,
        Vinod Koul <vkoul@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <linux-doc@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20220713142148.239253-1-amelie.delaunay@foss.st.com>
 <20220713142148.239253-4-amelie.delaunay@foss.st.com>
 <e1fbf7cf-1bb7-6583-3713-7dbd58a4898e@denx.de>
From:   Amelie Delaunay <amelie.delaunay@foss.st.com>
In-Reply-To: <e1fbf7cf-1bb7-6583-3713-7dbd58a4898e@denx.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_04,2022-07-19_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Marek,

Thanks for reviewing.

On 7/14/22 21:02, Marek Vasut wrote:
> On 7/13/22 16:21, Amelie Delaunay wrote:
> 
> [...]
> 
>> diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
>> index adb25a11c70f..3916295fe154 100644
>> --- a/drivers/dma/stm32-dma.c
>> +++ b/drivers/dma/stm32-dma.c
>> @@ -142,6 +142,8 @@
>>   #define STM32_DMA_DIRECT_MODE_GET(n)    (((n) & 
>> STM32_DMA_DIRECT_MODE_MASK) >> 2)
>>   #define STM32_DMA_ALT_ACK_MODE_MASK    BIT(4)
>>   #define STM32_DMA_ALT_ACK_MODE_GET(n)    (((n) & 
>> STM32_DMA_ALT_ACK_MODE_MASK) >> 4)
>> +#define STM32_DMA_MDMA_STREAM_ID_MASK    GENMASK(19, 16)
>> +#define STM32_DMA_MDMA_STREAM_ID_GET(n) (((n) & 
>> STM32_DMA_MDMA_STREAM_ID_MASK) >> 16)
> 
> Try FIELD_GET() from include/linux/bitfield.h
> 
> [...]
> 

Yes, but not only on this new line. I'll add a prior patch to the 
patchset to use FIELD_{GET,PREP}() helpers every where custom macros are 
used.

>> @@ -1630,6 +1670,20 @@ static int stm32_dma_probe(struct 
>> platform_device *pdev)
>>           chan->id = i;
>>           chan->vchan.desc_free = stm32_dma_desc_free;
>>           vchan_init(&chan->vchan, dd);
>> +
>> +        chan->mdma_config.ifcr = res->start;
>> +        chan->mdma_config.ifcr += (chan->id & 4) ? STM32_DMA_HIFCR : 
>> STM32_DMA_LIFCR;
>> +
>> +        chan->mdma_config.tcf = STM32_DMA_TCI;
>> +        /*
>> +         * bit0 of chan->id represents the need to left shift by 6
>> +         * bit1 of chan->id represents the need to extra left shift 
>> by 16
>> +         * TCIF0, chan->id = b0000; TCIF4, chan->id = b0100: left 
>> shift by 0*6 + 0*16
>> +         * TCIF1, chan->id = b0001; TCIF5, chan->id = b0101: left 
>> shift by 1*6 + 0*16
>> +         * TCIF2, chan->id = b0010; TCIF6, chan->id = b0110: left 
>> shift by 0*6 + 1*16
>> +         * TCIF3, chan->id = b0011; TCIF7, chan->id = b0111: left 
>> shift by 1*6 + 1*16
>> +         */
>> +        chan->mdma_config.tcf <<= (6 * (chan->id & 0x1) + 16 * 
>> ((chan->id & 0x2) >> 1));
> 
> Some sort of symbolic macros instead of open-coded constants could help 
> readability here.
> 

I agree. As the same kind of computation is done in 
stm32_dma_irq_status() and stm32_dma_irq_clear(), I'll add another prior 
patch to the patchset to introduce new macro helpers to get ISR/IFCR 
offset depending on channel id, and to get channel flags mask depending 
on channel id.

> [...]

Regards,
Amelie
