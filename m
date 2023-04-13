Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00E76E03B0
	for <lists+dmaengine@lfdr.de>; Thu, 13 Apr 2023 03:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjDMB3h (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 12 Apr 2023 21:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjDMB3g (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 12 Apr 2023 21:29:36 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3373A5FFC;
        Wed, 12 Apr 2023 18:29:33 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 751497FE0;
        Thu, 13 Apr 2023 09:29:25 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 13 Apr
 2023 09:29:25 +0800
Received: from [192.168.125.109] (183.27.97.249) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 13 Apr
 2023 09:29:24 +0800
Message-ID: <d68488a0-ad83-1d46-2143-eda557fcd20f@starfivetech.com>
Date:   Thu, 13 Apr 2023 09:29:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v6 0/4] Add DMA driver for StarFive JH7110 SoC
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
 <ZDbp8IVpIwFvNgFv@matsya>
Content-Language: en-US
From:   Walker Chen <walker.chen@starfivetech.com>
In-Reply-To: <ZDbp8IVpIwFvNgFv@matsya>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.97.249]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 2023/4/13 1:27, Vinod Koul wrote:
> On 22-03-23, 17:48, Walker Chen wrote:
>> Hello,
>> 
>> This patch series adds dma support for the StarFive JH7110 RISC-V
>> SoC. The first patch adds device tree binding. The second patch includes
>> dma driver. The last patch adds device node of dma to JH7110 dts.
>> 
>> The series has been tested on the VisionFive 2 board which equip with
>> JH7110 SoC and works normally.
> 
> Applied 1-3, thanks
> 
Vinod, thank you very much!

Best regards,
Walker
