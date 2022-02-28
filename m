Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 865CE4C6597
	for <lists+dmaengine@lfdr.de>; Mon, 28 Feb 2022 10:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234134AbiB1JXn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 28 Feb 2022 04:23:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbiB1JXn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 28 Feb 2022 04:23:43 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1AC33A03;
        Mon, 28 Feb 2022 01:23:04 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21S9MuX9024394;
        Mon, 28 Feb 2022 03:22:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1646040176;
        bh=0Gh/zCLG/Enf8WpLjPEkq5pcQ399FuHU48P/zaDMkGQ=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=fIgy1xiEajmIWwKA/BXfmPuPawtQNUL7u77MSKTED/+Q4LZia1V5/BGmMztqAU/Cc
         HG3e/4x7N1J8mUQalcbthGHjdCp1YrLGNg9kCSxEmTnAaZjNiaQ5JcE6l0zpYa77zn
         Hb3wvQaeWwM+c4SEbKWIG5/Q9eykgX28ISdtGyz8=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21S9MuYB045213
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 28 Feb 2022 03:22:56 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 28
 Feb 2022 03:22:56 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 28 Feb 2022 03:22:56 -0600
Received: from [10.250.233.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21S9MrIV120544;
        Mon, 28 Feb 2022 03:22:54 -0600
Message-ID: <35276e1e-e37c-f8e7-c452-799f8e778465@ti.com>
Date:   Mon, 28 Feb 2022 14:52:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] dmaengine: ti: k3-udma: Avoid false error msg on chan
 teardown
Content-Language: en-US
To:     =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Jayesh Choudhary <j-choudhary@ti.com>
References: <20220215044112.161634-1-vigneshr@ti.com>
 <58fe0934-4853-714c-600d-9a2d86df5bc8@gmail.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <58fe0934-4853-714c-600d-9a2d86df5bc8@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Peter,

On 21/02/22 1:42 am, Péter Ujfalusi wrote:
> Hi Vignesh,
> 
> On 15/02/2022 06:41, Vignesh Raghavendra wrote:
>> In cyclic mode, there is no additional descriptor pushed to collect
>> outstanding data on channel teardown. Therefore no need to wait for this
>> descriptor to come back.
>>
>> Without this terminating aplay cmd outputs false error msg like:
>> [  116.402800] ti-bcdma 485c0100.dma-controller: chan1 teardown timeout!
> 
> are you sure it is aplay? It is MEM_TO_DEV, we only use the flush
> descriptor for DEV_TO_MEM. MEM_TO_DEV can 'disconnect' from the
> peripheral to flush out the FIFO.
> 

Yes, this is with aplay. You are right that MEM_TO_DEV should have
worked w/o this patch.


> I have not seen this on am654, j721e. I can not recall seeing this on
> the capture side either.
> 

I dont see it either

> The cyclic TR should be able to drain the DEV_TO_MEM by itself and the
> TR should terminate.
> 

You are right. There seems to be a trobule with McASP + BCDMA on AM62
which needs more investigation. I see

 RT c0000000 peer RT 90000000
 BCNT 5dc00, peer BCNT 46400

So there is some data stuck in pipe which prevents channel from
disabling and TDCM being signaled. My guess is McASP is no longer
requesting more data from PDMA. Any way to look at McASP FIFO state/ DMA
req enable state? Wondering what else can prevent draining of data.

One difference is that AM62 has ti,tlv320aic3106 codec (codec is the
master) where J7 uses PCM.

Regards
Vignesh


> 
>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
>> ---
>>  drivers/dma/ti/k3-udma.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
>> index 9abb08d353ca0..c9a1b2f312603 100644
>> --- a/drivers/dma/ti/k3-udma.c
>> +++ b/drivers/dma/ti/k3-udma.c
>> @@ -3924,7 +3924,7 @@ static void udma_synchronize(struct dma_chan *chan)
>>  
>>  	vchan_synchronize(&uc->vc);
>>  
>> -	if (uc->state == UDMA_CHAN_IS_TERMINATING) {
>> +	if (uc->state == UDMA_CHAN_IS_TERMINATING && !uc->cyclic) {
>>  		timeout = wait_for_completion_timeout(&uc->teardown_completed,
>>  						      timeout);
>>  		if (!timeout) {
> 
