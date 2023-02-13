Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2375B694696
	for <lists+dmaengine@lfdr.de>; Mon, 13 Feb 2023 14:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjBMNJI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Feb 2023 08:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjBMNJH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 13 Feb 2023 08:09:07 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86A19004;
        Mon, 13 Feb 2023 05:09:03 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id BCBCB24E154;
        Mon, 13 Feb 2023 21:08:47 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 13 Feb
 2023 21:08:47 +0800
Received: from [192.168.125.74] (183.27.97.168) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 13 Feb
 2023 21:08:46 +0800
Message-ID: <7152f39a-5220-63a0-3e13-ef165b0ab0c1@starfivetech.com>
Date:   Mon, 13 Feb 2023 21:08:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v1 2/3] dma: dw-axi-dmac: Add support for StarFive DMA
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>
CC:     <linux-riscv@lists.infradead.org>, <dmaengine@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        <linux-kernel@vger.kernel.org>
References: <20230206113811.23133-1-walker.chen@starfivetech.com>
 <20230206113811.23133-3-walker.chen@starfivetech.com>
 <Y+YHa7jVpTs9Qg73@matsya>
From:   Walker Chen <walker.chen@starfivetech.com>
In-Reply-To: <Y+YHa7jVpTs9Qg73@matsya>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.97.168]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2023/2/10 16:59, Vinod Koul wrote:
> On 06-02-23, 19:38, Walker Chen wrote:
>> Adding DMA reset operation in device probe, and using different
>> registers according to the hardware handshake number.
> 
> subsystem tag is dmaengine: xxx

OK, the tag will be changed to dmaengine.

> 
>> 
>> Signed-off-by: Walker Chen <walker.chen@starfivetech.com>
>> ---
>>  .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 25 ++++++++++++++++---
>>  drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  3 +++
>>  2 files changed, 24 insertions(+), 4 deletions(-)
>> 
>> diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
>> index a183d93bd7e2..3581810033d2 100644
>> --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
>> +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
>> @@ -25,6 +25,7 @@
>>  #include <linux/platform_device.h>
>>  #include <linux/pm_runtime.h>
>>  #include <linux/property.h>
>> +#include <linux/reset.h>
>>  #include <linux/slab.h>
>>  #include <linux/types.h>
>>  
>> @@ -86,7 +87,8 @@ static inline void axi_chan_config_write(struct axi_dma_chan *chan,
>>  
>>  	cfg_lo = (config->dst_multblk_type << CH_CFG_L_DST_MULTBLK_TYPE_POS |
>>  		  config->src_multblk_type << CH_CFG_L_SRC_MULTBLK_TYPE_POS);
>> -	if (chan->chip->dw->hdata->reg_map_8_channels) {
>> +	if (chan->chip->dw->hdata->reg_map_8_channels &&
>> +	    !chan->chip->dw->hdata->use_cfg2) {
> 
> what about older/other platforms that dont have use_cfg2?

The use_cfg2 variable's default value is false, the original logic will not be affected.
Rob herring gave a suggestion that it is assigned according to compatible string, like that:
if (of_device_is_compatible(node, "starfive,jh7110-axi-dma")) {
	...
	chip->dw->hdata->use_cfg2 = true;
}

> 
>>  		cfg_hi = config->tt_fc << CH_CFG_H_TT_FC_POS |
>>  			 config->hs_sel_src << CH_CFG_H_HS_SEL_SRC_POS |
>>  			 config->hs_sel_dst << CH_CFG_H_HS_SEL_DST_POS |
>> @@ -541,8 +543,6 @@ static void dw_axi_dma_set_hw_channel(struct axi_dma_chan *chan, bool set)
>>  			(chan->id * DMA_APB_HS_SEL_BIT_SIZE));
>>  	reg_value |= (val << (chan->id * DMA_APB_HS_SEL_BIT_SIZE));
>>  	lo_hi_writeq(reg_value, chip->apb_regs + DMAC_APB_HW_HS_SEL_0);
>> -
>> -	return;
>>  }
>>  

Thanks

Best regards,
Walker

