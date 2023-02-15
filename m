Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2AFD697391
	for <lists+dmaengine@lfdr.de>; Wed, 15 Feb 2023 02:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233689AbjBOBXR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Feb 2023 20:23:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233610AbjBOBXE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 14 Feb 2023 20:23:04 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C7834C0D;
        Tue, 14 Feb 2023 17:22:13 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 31B8E24E167;
        Wed, 15 Feb 2023 09:22:06 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 15 Feb
 2023 09:22:06 +0800
Received: from [192.168.125.74] (183.27.97.168) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 15 Feb
 2023 09:22:05 +0800
Message-ID: <49e31cb3-4518-1ce8-3c7e-0ea6fb3da532@starfivetech.com>
Date:   Wed, 15 Feb 2023 09:22:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v1 2/3] dma: dw-axi-dmac: Add support for StarFive DMA
Content-Language: en-US
To:     <linux-riscv@lists.infradead.org>, <dmaengine@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        <linux-kernel@vger.kernel.org>
References: <20230206113811.23133-1-walker.chen@starfivetech.com>
 <20230206113811.23133-3-walker.chen@starfivetech.com>
From:   Walker Chen <walker.chen@starfivetech.com>
In-Reply-To: <20230206113811.23133-3-walker.chen@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.97.168]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2023/2/6 19:38, Walker Chen wrote:
> Adding DMA reset operation in device probe, and using different
> registers according to the hardware handshake number.
> 
> Signed-off-by: Walker Chen <walker.chen@starfivetech.com>

Hi Eugeniy Paltsev / Emil,

Could you please help to review and provide comments on this patch series?
Any comments will be appreciated!

Best regards,
Walker Chen
