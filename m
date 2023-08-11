Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 907287793CE
	for <lists+dmaengine@lfdr.de>; Fri, 11 Aug 2023 18:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjHKQFB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 11 Aug 2023 12:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234001AbjHKQFB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 11 Aug 2023 12:05:01 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042D42712;
        Fri, 11 Aug 2023 09:04:59 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37BG4nFn033373;
        Fri, 11 Aug 2023 11:04:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691769889;
        bh=ohphlfsgYaSZ2qfIAR5SpTVy0Hgx6YRY680MGsCtasA=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=SuOaSxqYvugQ1A7OAETNdg3uuiaGf2SIkaA3WCqVIdr/yiptQdPoDBG14gmZHYp83
         TTowp4gM2ik/9vPIPgHZXyDS27Jd5mtPLeYExC5F8iBdGY1cHEr7g6uvq0XEkjNN0j
         JGUWPs2jKM38OFL289pBXVZZyI83Nj3MX9WhiwG0=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37BG4nFN005182
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Aug 2023 11:04:49 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 11
 Aug 2023 11:04:49 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 11 Aug 2023 11:04:49 -0500
Received: from [172.24.227.94] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37BG4km6030070;
        Fri, 11 Aug 2023 11:04:46 -0500
Message-ID: <1d2ab22e-9bbc-f876-f059-980f543551d4@ti.com>
Date:   Fri, 11 Aug 2023 21:34:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/3] dt-bindings: dma: ti: k3* : Update optional reg
 regions
Content-Language: en-US
To:     =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230810174356.3322583-1-vigneshr@ti.com>
 <9a8f06e0-b986-4434-a194-9679c82035ca@gmail.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <9a8f06e0-b986-4434-a194-9679c82035ca@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Peter,

On 11/08/23 20:46, Péter Ujfalusi wrote:
> Vignesh,
> 
> On 10/08/2023 20:43, Vignesh Raghavendra wrote:
>> DMAs on TI K3 SoCs have channel configuration registers region which are
>> usually hidden from Linux and configured via Device Manager Firmware
>> APIs. But certain early SWs like bootloader which run before Device
>> Manager is fully up would need to directly configure these registers and
>> thus require to be in DT description.
>>
>> This add bindings for such configuration regions.  Backward
>> compatibility is maintained to existing DT by only mandating existing
>> regions to be present and this new region as optional.
> 
> These regions were 'hidden' from Linux or other open coded access for a
> reason.
> If I recall the main reason is security and the need to make sure that
> the allocation of the channels not been violated.
> 
> IMho the boot loader should be no exception and it should be using the
> DM firmware to configure the DMAs.
> 
> Or has the security concern been dropped and SW can do whatever it wants?

There is been a relook at the arch post this driver was upstreamed. 
System firmware (SYSFW) is now two separate components:  TI Foundational 
Security (TIFS) running in a secure island and Device Management (DM) 
firmware (runs on boot R5 core) [0] shows boot flow diagram for AM62x.

Security critical items such as PSIL pairing, channel firewalls and 
credential configurations are under TIFS and is handled via TI SCI calls 
at all times.

But, things related to resource configuration (to ensure different cores 
dont step on each other) is under DM. Linux still needs to talk to DM 
for configuring these regions. But, when primary bootloader (R5 SPL) is 
running, there isn't a DM firmware (as it runs on the same core after R5 
SPL), it would need to configure DMA resources on its own. 

This update is mainly to aid R5 SPL to reuse kernel DT as is. 
Hope that helps


[0] https://u-boot.readthedocs.io/en/latest/board/ti/am62x_sk.html?highlight=am62#boot-flow
(Similar boot flow for rest of K3 devices barring am65 and am64)

> 
>>
>> Vignesh Raghavendra (3):
>>    dt-bindings: dma: ti: k3-bcdma: Describe cfg register regions
>>    dt-bindings: dma: ti: k3-pktdma: Describe cfg register regions
>>    dt-bindings: dma: ti: k3-udma: Describe cfg register regions
>>
>>   .../devicetree/bindings/dma/ti/k3-bcdma.yaml  | 25 +++++++++++++------
>>   .../devicetree/bindings/dma/ti/k3-pktdma.yaml | 18 ++++++++++---
>>   .../devicetree/bindings/dma/ti/k3-udma.yaml   | 14 ++++++++---
>>   3 files changed, 43 insertions(+), 14 deletions(-)
>>
> 

-- 
Regards
Vignesh
