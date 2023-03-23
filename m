Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4506C673E
	for <lists+dmaengine@lfdr.de>; Thu, 23 Mar 2023 12:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbjCWL4Q (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 23 Mar 2023 07:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbjCWLzs (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 23 Mar 2023 07:55:48 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6CB19B1;
        Thu, 23 Mar 2023 04:55:46 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32NBtbd7070313;
        Thu, 23 Mar 2023 06:55:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1679572537;
        bh=EDRAraXsrfnCC8fcfomneLhyhI3khcdDnG5K3ZiYUyI=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=eQjxQJVJsJ710M6YrIfTyoO/zfCj3c7ArxxcLyKqjHIKZeNTXPLFeWN6LYnAFbqYG
         mYOJoOcsKtdx+SNEY7LURYXADbTl/uVcUxkJInwHnuR5JOXD+qlzovq1YY189V/v1E
         mCMtwSXfp3J5gia39OIFHHRf0/h7B0UR9dquE+cQ=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32NBtbxf103130
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Mar 2023 06:55:37 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 23
 Mar 2023 06:55:37 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 23 Mar 2023 06:55:37 -0500
Received: from [172.24.145.176] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32NBtYgS114011;
        Thu, 23 Mar 2023 06:55:35 -0500
Message-ID: <2ddcbea8-d3fa-ed73-ead1-834a8f304f88@ti.com>
Date:   Thu, 23 Mar 2023 17:25:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] dma: ti: k3-udma: Workaround errata i2234
Content-Language: en-US
To:     =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
References: <20211209180715.27998-1-vigneshr@ti.com>
 <a76fcbd1-20fa-fb16-bca4-68dd90031787@gmail.com>
From:   Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <a76fcbd1-20fa-fb16-bca4-68dd90031787@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello Peter,

On 10/12/21 20:52, Péter Ujfalusi wrote:
> Hi Vignesh,
> 
> On 09/12/2021 20:07, Vignesh Raghavendra wrote:
>> Per [1], UDMA TR15 transactions may hang if ICNT0 is less than 64B
>> Work around is to set EOL flag is to 1 for ICNT0.
>>
>> Since, there is no performance penalty / side effects of setting EOL
>> flag event ICNTO > 64B, just set the flag for all UDMAP TR15
>> descriptors.
> 
> PDMAs and CSI does not send EOL? If you set it the EOL to one then when
> it arrives the remaining icnt0 is skipped...

I am planning to respin v2 for this.
Will fix this in v2.

> 
>>
>> [1] https://www.ti.com/lit/er/sprz455a/sprz455a.pdf
>> Errata doc for J721E DRA829/TDA4VM Processors Silicon Revision 1.1/1.0 (Rev. A)
>>
>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
>> ---
>>   drivers/dma/ti/k3-udma.c     | 48 +++++++++++++++++++-----------------
>>   include/linux/dma/ti-cppi5.h |  1 +
>>   2 files changed, 27 insertions(+), 22 deletions(-)
>>

[...]

>> diff --git a/include/linux/dma/ti-cppi5.h b/include/linux/dma/ti-cppi5.h
>> index efa2f0309f00..c53c0f6e3b1a 100644
>> --- a/include/linux/dma/ti-cppi5.h
>> +++ b/include/linux/dma/ti-cppi5.h
>> @@ -616,6 +616,7 @@ static inline void *cppi5_hdesc_get_swdata(struct cppi5_host_desc_t *desc)
>>   #define   CPPI5_TR_CSF_SUPR_EVT			BIT(2)
>>   #define   CPPI5_TR_CSF_EOL_ADV_SHIFT		(4U)
>>   #define   CPPI5_TR_CSF_EOL_ADV_MASK		GENMASK(6, 4)
>> +#define   CPPI5_TR_CSF_EOL_ICNT0		BIT(4)
> 
> the correct expression is: (1 << CPPI5_TR_CSF_EOL_ADV_SHIFT)

Both these expressions expands to the same value
(CPPI5_TR_CSF_EOL_ADV_SHIFT = 4U)

And according to the linux checkpatch, the usage of BIT macro
is preferred so I will keep it the same.

Warm regards,
-Jayesh

> as EOL = 1 is what you want to set.
> EOL = 2 will clear icnt0 and 1 on EOL.
> 3 will do the same for icnt 0, 1 and 2
> 4 will skip the remainin tr.
> 
>>   #define   CPPI5_TR_CSF_EOP			BIT(7)
>>   
>>   /**
>>
> 
