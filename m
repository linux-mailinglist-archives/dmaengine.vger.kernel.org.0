Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18ADB6A3E49
	for <lists+dmaengine@lfdr.de>; Mon, 27 Feb 2023 10:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjB0J13 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Feb 2023 04:27:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjB0J12 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 27 Feb 2023 04:27:28 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF2826BC;
        Mon, 27 Feb 2023 01:27:26 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 4440B24E320;
        Mon, 27 Feb 2023 17:27:19 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 27 Feb
 2023 17:27:19 +0800
Received: from [192.168.125.93] (113.72.145.171) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 27 Feb
 2023 17:27:18 +0800
Message-ID: <68f322ce-437a-1bd6-cf49-e6d485d4edfd@starfivetech.com>
Date:   Mon, 27 Feb 2023 17:27:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v2 2/3] dmaengine: dw-axi-dmac: Add support for StarFive
 JH7110 DMA
Content-Language: en-US
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>
CC:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
References: <20230221140424.719-1-walker.chen@starfivetech.com>
 <20230221140424.719-3-walker.chen@starfivetech.com>
 <CAJM55Z_buj_CBKtJw=n_K-Ma4ZGP9pmy_uM20nLpJhTMNh=bJQ@mail.gmail.com>
From:   Walker Chen <walker.chen@starfivetech.com>
In-Reply-To: <CAJM55Z_buj_CBKtJw=n_K-Ma4ZGP9pmy_uM20nLpJhTMNh=bJQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.145.171]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 2023/2/26 22:25, Emil Renner Berthing wrote:
> On Tue, 21 Feb 2023 at 15:04, Walker Chen <walker.chen@starfivetech.com> wrote:
>>
>> Add DMA reset operation in device probe and use different configuration
>> on CH_CFG registers according to compatible string.
>>
>> Signed-off-by: Walker Chen <walker.chen@starfivetech.com>
>> ---
>>  .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 19 +++++++++++++++++--
>>  drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  3 +++
>>  2 files changed, 20 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
>> index bf85aa0979ec..858c4337650f 100644
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
>>         cfg_lo = (config->dst_multblk_type << CH_CFG_L_DST_MULTBLK_TYPE_POS |
>>                   config->src_multblk_type << CH_CFG_L_SRC_MULTBLK_TYPE_POS);
>> -       if (chan->chip->dw->hdata->reg_map_8_channels) {
>> +       if (chan->chip->dw->hdata->reg_map_8_channels &&
>> +           !chan->chip->dw->hdata->use_cfg2) {
>>                 cfg_hi = config->tt_fc << CH_CFG_H_TT_FC_POS |
>>                          config->hs_sel_src << CH_CFG_H_HS_SEL_SRC_POS |
>>                          config->hs_sel_dst << CH_CFG_H_HS_SEL_DST_POS |
>> @@ -1142,7 +1144,7 @@ static int dma_chan_terminate_all(struct dma_chan *dchan)
>>         axi_chan_disable(chan);
>>
>>         ret = readl_poll_timeout_atomic(chan->chip->regs + DMAC_CHEN, val,
>> -                                       !(val & chan_active), 1000, 10000);
>> +                                       !(val & chan_active), 1000, DMAC_TIMEOUT_US);
>>         if (ret == -ETIMEDOUT)
>>                 dev_warn(dchan2dev(dchan),
>>                          "%s failed to stop\n", axi_chan_name(chan));
>> @@ -1416,6 +1418,18 @@ static int dw_probe(struct platform_device *pdev)
>>         if (IS_ERR(chip->cfgr_clk))
>>                 return PTR_ERR(chip->cfgr_clk);
>>
>> +       if (of_device_is_compatible(node, "starfive,jh7110-axi-dma")) {
>> +               chip->resets = devm_reset_control_array_get_exclusive(&pdev->dev);
>> +               if (IS_ERR(chip->resets))
>> +                       return PTR_ERR(chip->resets);
>> +
>> +               ret = reset_control_deassert(chip->resets);
>> +               if (ret)
>> +                       return ret;
>> +
>> +               chip->dw->hdata->use_cfg2 = true;
>> +       }
>> +
> 
> In the future it would be great to use match data rather than all the
> calls to of_device_is_compatible.

Thanks, about this point, I will follow your advice.

> 
>>         ret = parse_device_properties(chip);
>>         if (ret)
>>                 return ret;
>> @@ -1560,6 +1574,7 @@ static const struct dev_pm_ops dw_axi_dma_pm_ops = {
>>  static const struct of_device_id dw_dma_of_id_table[] = {
>>         { .compatible = "snps,axi-dma-1.01a" },
>>         { .compatible = "intel,kmb-axi-dma" },
>> +       { .compatible = "starfive,jh7110-axi-dma" },
>>         {}
>>  };
>>  MODULE_DEVICE_TABLE(of, dw_dma_of_id_table);
>> diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
>> index e9d5eb0fd594..761d95691c02 100644
>> --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
>> +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
>> @@ -21,6 +21,7 @@
>>  #define DMAC_MAX_CHANNELS      16
>>  #define DMAC_MAX_MASTERS       2
>>  #define DMAC_MAX_BLK_SIZE      0x200000
>> +#define DMAC_TIMEOUT_US                200000
>>
>>  struct dw_axi_dma_hcfg {
>>         u32     nr_channels;
>> @@ -33,6 +34,7 @@ struct dw_axi_dma_hcfg {
>>         /* Register map for DMAX_NUM_CHANNELS <= 8 */
>>         bool    reg_map_8_channels;
>>         bool    restrict_axi_burst_len;
>> +       bool    use_cfg2;
>>  };
>>
>>  struct axi_dma_chan {
>> @@ -70,6 +72,7 @@ struct axi_dma_chip {
>>         struct clk              *core_clk;
>>         struct clk              *cfgr_clk;
>>         struct dw_axi_dma       *dw;
>> +       struct reset_control    *resets;
> 
> This added field only seems to be written, but not read from anywhere.

Reset initialization will be encapsulated in match data.

> With that fixed:
> 
> Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

Thanks for your review and comment very much!

Best regards,
Walker
