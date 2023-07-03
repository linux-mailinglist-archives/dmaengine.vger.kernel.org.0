Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A117453A0
	for <lists+dmaengine@lfdr.de>; Mon,  3 Jul 2023 03:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjGCBgH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 2 Jul 2023 21:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGCBgG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 2 Jul 2023 21:36:06 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A5C12E;
        Sun,  2 Jul 2023 18:36:02 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 50EA48086;
        Mon,  3 Jul 2023 09:35:49 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 3 Jul
 2023 09:35:49 +0800
Received: from [192.168.125.124] (113.72.144.31) by EXMBX068.cuchost.com
 (172.16.6.68) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 3 Jul
 2023 09:35:47 +0800
Message-ID: <d490987c-0d58-b38a-1886-decba64ba6a0@starfivetech.com>
Date:   Mon, 3 Jul 2023 09:35:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v6 4/4] riscv: dts: starfive: add dma controller node
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "Emil Renner Berthing" <emil.renner.berthing@canonical.com>,
        <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
References: <20230322094820.24738-1-walker.chen@starfivetech.com>
 <20230322094820.24738-5-walker.chen@starfivetech.com>
 <ZKCiOQ0IuptKO8kr@aurel32.net>
Content-Language: en-US
From:   Walker Chen <walker.chen@starfivetech.com>
In-Reply-To: <ZKCiOQ0IuptKO8kr@aurel32.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.144.31]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX068.cuchost.com
 (172.16.6.68)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 2023/7/2 6:01, Aurelien Jarno wrote:
> On 2023-03-22 17:48, Walker Chen wrote:
>> Add the dma controller node for the Starfive JH7110 SoC.
>> 
>> Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
>> Signed-off-by: Walker Chen <walker.chen@starfivetech.com>
>> ---
>>  arch/riscv/boot/dts/starfive/jh7110.dtsi | 18 ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>> 
>> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
>> index 17220576b21c..b503b6137743 100644
>> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
>> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
>> @@ -510,6 +510,24 @@
>>  			#gpio-cells = <2>;
>>  		};
>>  
>> +		dma: dma-controller@16050000 {
>> +			compatible = "starfive,jh7110-axi-dma";
>> +			reg = <0x0 0x16050000 0x0 0x10000>;
>> +			clocks = <&stgcrg JH7110_STGCLK_DMA1P_AXI>,
>> +				 <&stgcrg JH7110_STGCLK_DMA1P_AHB>;
>> +			clock-names = "core-clk", "cfgr-clk";
>> +			resets = <&stgcrg JH7110_STGRST_DMA1P_AXI>,
>> +				 <&stgcrg JH7110_STGRST_DMA1P_AHB>;
>> +			interrupts = <73>;
>> +			#dma-cells = <1>;
>> +			dma-channels = <4>;
>> +			snps,dma-masters = <1>;
>> +			snps,data-width = <3>;
>> +			snps,block-size = <65536 65536 65536 65536>;
>> +			snps,priority = <0 1 2 3>;
>> +			snps,axi-max-burst-len = <16>;
>> +		};
>> +
>>  		aoncrg: clock-controller@17000000 {
>>  			compatible = "starfive,jh7110-aoncrg";
>>  			reg = <0x0 0x17000000 0x0 0x10000>;
> 
> It appears that this patch has never been applied, although the rest of
> the series has already been merged. Unfortunately it doesn't apply
> anymore due to other changes to that file.
> 
> Could you please rebase and repost it?
> 
Of course I will repost it, but this depends on whether the stg clock is merged.

Regards,
Walker
