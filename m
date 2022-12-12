Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0EF649869
	for <lists+dmaengine@lfdr.de>; Mon, 12 Dec 2022 05:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbiLLEim (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 11 Dec 2022 23:38:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbiLLEi1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 11 Dec 2022 23:38:27 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B727D65CD;
        Sun, 11 Dec 2022 20:38:26 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2BC4cDNu020658;
        Sun, 11 Dec 2022 22:38:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1670819893;
        bh=iDu+h6IgJO+eUAlJ1QIlreHvnmj+PrIQ7ZXav/B5jlI=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=LMwAt9v+O9RAY5EHA6TReJSGEhhWnaMMlbm9IMZkNyY9af6v6SBFWcmh/QEso4C6b
         J5d9+jeL7Q0+YCn8V0qnZi7QIf7kMQXHkBlAE2EerJ56jhAVz7T3MJlXNzECgCPpX/
         6MqDtUU5Ib8Pl1KgsrHvE1KcoOaDTqUjiBxzMi2s=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2BC4cDBS026139
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 11 Dec 2022 22:38:13 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Sun, 11
 Dec 2022 22:38:12 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Sun, 11 Dec 2022 22:38:12 -0600
Received: from [172.24.145.182] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2BC4cAwO022872;
        Sun, 11 Dec 2022 22:38:10 -0600
Message-ID: <b2a1a6df-0a8a-20af-7fea-33504735d328@ti.com>
Date:   Mon, 12 Dec 2022 10:08:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 2/5] dmaengine: ti: k3-udma: Fix BCDMA for case w/o BCHAN
Content-Language: en-US
To:     =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221206043554.1521522-1-vigneshr@ti.com>
 <20221206043554.1521522-3-vigneshr@ti.com>
 <c56e89a3-3a35-8a5a-8f39-a4e82b19a092@gmail.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <c56e89a3-3a35-8a5a-8f39-a4e82b19a092@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Peter,

On 10/12/22 13:54, Péter Ujfalusi wrote:
> 
> 
> On 12/6/22 06:35, Vignesh Raghavendra wrote:
>> Reusing loop iterator fails if BCHAN is not present as iterator is
>> uninitialized
>>
>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
>> ---
>>  drivers/dma/ti/k3-udma.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
>> index ce8b80bb34d7..791cf6354946 100644
>> --- a/drivers/dma/ti/k3-udma.c
>> +++ b/drivers/dma/ti/k3-udma.c
>> @@ -4758,6 +4758,7 @@ static int bcdma_setup_resources(struct udma_dev *ud)
>>  		}
>>  	}
>>  
>> +	i = 0;
> 
> I think this would be more appropriate:
> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> index ce8b80bb34d7..7f8737da3613 100644
> --- a/drivers/dma/ti/k3-udma.c
> +++ b/drivers/dma/ti/k3-udma.c
> @@ -4774,6 +4774,8 @@ static int bcdma_setup_resources(struct udma_dev *ud)
>  				irq_res.desc[i].num = rm_res->desc[i].num;
>  			}
>  		}
> +	} else {
> +		i = 0;
>  	}
>  	if (ud->tchan_cnt) {
>  		rm_res = tisci_rm->rm_ranges[RM_RANGE_TCHAN];
> 
> 

Agreed, will update in v2.

>>  	irq_res.desc = kcalloc(irq_res.sets, sizeof(*irq_res.desc), GFP_KERNEL);
>>  	if (!irq_res.desc)
>>  		return -ENOMEM;
> 
> 

-- 
Regards
Vignesh
