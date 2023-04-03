Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E9C6D4420
	for <lists+dmaengine@lfdr.de>; Mon,  3 Apr 2023 14:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbjDCMHf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 3 Apr 2023 08:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbjDCMHf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 3 Apr 2023 08:07:35 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB7FA9;
        Mon,  3 Apr 2023 05:07:31 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 1625724E38D;
        Mon,  3 Apr 2023 20:07:22 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 3 Apr
 2023 20:07:22 +0800
Received: from [192.168.125.145] (183.27.97.179) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 3 Apr
 2023 20:07:21 +0800
Message-ID: <8128d57b-17cd-8307-ed8c-2611a5658e18@starfivetech.com>
Date:   Mon, 3 Apr 2023 20:07:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v6 2/4] dmaengine: dw-axi-dmac: Add support for StarFive
 JH7110 DMA
To:     Vinod Koul <vkoul@kernel.org>
CC:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "Emil Renner Berthing" <emil.renner.berthing@canonical.com>,
        <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
References: <20230322094820.24738-1-walker.chen@starfivetech.com>
 <20230322094820.24738-3-walker.chen@starfivetech.com>
 <ZCbMRdSCf5vKUk/c@matsya>
Content-Language: en-US
From:   Walker Chen <walker.chen@starfivetech.com>
In-Reply-To: <ZCbMRdSCf5vKUk/c@matsya>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.97.179]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.3 required=5.0 tests=NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 2023/3/31 20:04, Vinod Koul wrote:
> On 22-03-23, 17:48, Walker Chen wrote:
>> Add DMA reset operation in device probe and use different configuration
>> on CH_CFG registers according to match data. Update all uses of
>> of_device_is_compatible with of_device_get_match_data.
>> 
>> Signed-off-by: Walker Chen <walker.chen@starfivetech.com>
>> ---
>>  .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 38 ++++++++++++++++---
>>  drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  1 +
>>  2 files changed, 34 insertions(+), 5 deletions(-)
>> 
>> diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
>> index 4169e1d7d5ca..6cfcb541d8c3 100644
>> --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
>> +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
>> @@ -21,10 +21,12 @@
>>  #include <linux/kernel.h>
>>  #include <linux/module.h>
>>  #include <linux/of.h>
>> +#include <linux/of_device.h>
>>  #include <linux/of_dma.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/pm_runtime.h>
>>  #include <linux/property.h>
>> +#include <linux/reset.h>
>>  #include <linux/slab.h>
>>  #include <linux/types.h>
>>  
>> @@ -46,6 +48,10 @@
>>  	DMA_SLAVE_BUSWIDTH_32_BYTES	| \
>>  	DMA_SLAVE_BUSWIDTH_64_BYTES)
>>  
>> +#define AXI_DMA_FLAG_HAS_APB_REGS	BIT(0)
>> +#define AXI_DMA_FLAG_HAS_RESETS		BIT(1)
>> +#define AXI_DMA_FLAG_USE_CFG2		BIT(2)
>> +
>>  static inline void
>>  axi_dma_iowrite32(struct axi_dma_chip *chip, u32 reg, u32 val)
>>  {
>> @@ -86,7 +92,8 @@ static inline void axi_chan_config_write(struct axi_dma_chan *chan,
>>  
>>  	cfg_lo = (config->dst_multblk_type << CH_CFG_L_DST_MULTBLK_TYPE_POS |
>>  		  config->src_multblk_type << CH_CFG_L_SRC_MULTBLK_TYPE_POS);
>> -	if (chan->chip->dw->hdata->reg_map_8_channels) {
>> +	if (chan->chip->dw->hdata->reg_map_8_channels &&
>> +	    !chan->chip->dw->hdata->use_cfg2) {
> 
> I think this will break existing users.. 
> 
> This is set for reg_map_8_channels && use_cfg2, latter being set only
> for new controller, so what about existing users of these bits?

Firstly thank you for your comments!
There is a statement 'use_cfg2 = !!(flags & AXI_DMA_FLAG_USE_CFG2);' to be added in dw_probe function.
Assuming older/existing platform run this code block, e.g. when compatible is "snps,axi-dma-1.01a", 
the value of variable 'use_cfg2' is still false, the original logic will not be broken. So other existing
users are not affected by this.
Looking forward to your more comments. Thanks!

Best regards,
Walker

