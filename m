Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0127017CE4F
	for <lists+dmaengine@lfdr.de>; Sat,  7 Mar 2020 14:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgCGNKZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 7 Mar 2020 08:10:25 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:54135 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgCGNKZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 7 Mar 2020 08:10:25 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 7F4DB23058;
        Sat,  7 Mar 2020 14:10:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1583586621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1uf4sgSuEO4KOdf8x8D6sp3g7Zg8u/DJumv1+dN6104=;
        b=Sr2AX/wpTsaLJT9ULkatEcmcgDKiRWrU9g0NOoXxW654sP4fRHuho0Yjx+09Ja7OYbYoNQ
        3aJFUcdVKnlXvKwyk3tWNIwQJ5+t3Qk9ynsTlZzrpY/fHLOewLq/gaR7jDKFGTqFaU/J56
        gyDzJekCsrGrDENhzdQmEVmIlZB+Y3k=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Sat, 07 Mar 2020 14:10:19 +0100
From:   Michael Walle <michael@walle.cc>
To:     Peng Ma <peng.ma@nxp.com>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>,
        Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [EXT] [PATCH 2/2] arm64: dts: ls1028a: add "fsl,vf610-edma"
 compatible
In-Reply-To: <VI1PR04MB4431F901BEEF2EAB9AB1D7C6EDE00@VI1PR04MB4431.eurprd04.prod.outlook.com>
References: <20200306205403.29881-1-michael@walle.cc>
 <20200306205403.29881-2-michael@walle.cc>
 <VI1PR04MB44312A940BC5BFC7F13A5706EDE00@VI1PR04MB4431.eurprd04.prod.outlook.com>
 <e0be23f7d1307621151594dd66d2b8fd@walle.cc>
 <VI1PR04MB4431F901BEEF2EAB9AB1D7C6EDE00@VI1PR04MB4431.eurprd04.prod.outlook.com>
Message-ID: <433418e889347784bc74f3c22c23e644@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.10
X-Spamd-Bar: +
X-Spam-Level: *
X-Rspamd-Server: web
X-Spam-Status: No, score=1.40
X-Spam-Score: 1.40
X-Rspamd-Queue-Id: 7F4DB23058
X-Spamd-Result: default: False [1.40 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[11];
         NEURAL_HAM(-0.00)[-0.568];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,kernel.org,arm.com,nxp.com,gmail.com];
         MID_RHS_MATCH_FROM(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


Hi Peng,

Am 2020-03-07 11:32, schrieb Peng Ma:
>> -----Original Message-----
>> From: Michael Walle <michael@walle.cc>
>> Sent: 2020年3月7日 17:26
>> To: Peng Ma <peng.ma@nxp.com>
>> Cc: dmaengine@vger.kernel.org; devicetree@vger.kernel.org;
>> linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; 
>> Vinod Koul
>> <vkoul@kernel.org>; Rob Herring <robh+dt@kernel.org>; Mark Rutland
>> <mark.rutland@arm.com>; Shawn Guo <shawnguo@kernel.org>; Leo Li
>> <leoyang.li@nxp.com>
>> Subject: Re: [EXT] [PATCH 2/2] arm64: dts: ls1028a: add 
>> "fsl,vf610-edma"
>> compatible
>> 
>> Caution: EXT Email
>> 
>> Hi Peng,
>> 
>> Am 2020-03-07 03:09, schrieb Peng Ma:
>>>> -----Original Message-----
>>>> From: Michael Walle <michael@walle.cc>
>>>> Sent: 2020年3月7日 4:54
>>>> To: dmaengine@vger.kernel.org; devicetree@vger.kernel.org;
>>>> linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org
>>>> Cc: Vinod Koul <vkoul@kernel.org>; Rob Herring <robh+dt@kernel.org>;
>>>> Mark Rutland <mark.rutland@arm.com>; Shawn Guo
>> <shawnguo@kernel.org>;
>>>> Leo Li <leoyang.li@nxp.com>; Peng Ma <peng.ma@nxp.com>; Michael 
>>>> Walle
>>>> <michael@walle.cc>
>>>> Subject: [EXT] [PATCH 2/2] arm64: dts: ls1028a: add "fsl,vf610-edma"
>>>> compatible
>>>> 
>>>> Caution: EXT Email
>>>> 
>>>> The bootloader does the IOMMU fixup and dynamically adds the 
>>>> "iommus"
>>>> property to devices according to its compatible string. In case of
>>>> the eDMA controller this property is missing. Add it. After that the
>>>> IOMMU will work with the eDMA core.
>>>> 
>>>> Signed-off-by: Michael Walle <michael@walle.cc>
>>>> ---
>>>> arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 2 +-
>>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>> 
>>>> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
>>>> b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
>>>> index b152fa90cf5c..aa467bff2209 100644
>>>> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
>>>> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
>>>> @@ -447,7 +447,7 @@
>>>> 
>>>>                edma0: dma-controller@22c0000 {
>>>>                        #dma-cells = <2>;
>>>> -                       compatible = "fsl,ls1028a-edma";
>>>> +                       compatible = "fsl,ls1028a-edma",
>>>> + "fsl,vf610-edma";
>>> Hi Michael,
>>> 
>>> You should change it on bootloader instead of kernel, Some Reg of
>>> LS1028a is different from others, So we used compatible
>>> "fsl,ls1028a-edm" to distinguish "
>>> fsl,vf610-edma".
>> 
>> Yes this might be the right thing to do. So since it is NXPs 
>> bootloader feel free to
>> fix that ;) Looking at the u-boot code right now, I don't even know it 
>> that is the
>> right fix at all. The fixup code in u-boot is SoC independent (its in 
>> fsl_icid.h and is
>> enabled with CONFIG_LSCH3, ie your chassis version). For example, the 
>> sdhc
>> fixup will scan the nodes for "compatible = fsl,esdhc", which is also 
>> the
>> secondary compatible for the "ls1028a-esdhc" compatible.
>> 
>> And here is another reason to have it this way: we need backwards 
>> compatibility,
>> the are already boards out there whose bootloader will fix-up the 
>> "old" node.
>> Thus I don't see any other possibilty.
>> 
> [Peng Ma] OK, There is non fixed on uboot.
> I will fix it on uboot, if you want to use now, please change the
> uboot as below:

As I told you, I cannot be changed for shipped bootloaders. While it can 
be
changed for newer ones, I would really like to retain backwards 
compatibility.
And so should you.

That being said, I don't see a problem in having both compatibles. Linux
will use the ls1028a-emda one and u-boot will fix up the "older"
vf610-edma one.

Unfortunately, this patch will not only affect eDMA but all other 
drivers
which uses eDMA, eg. sound, lpuart, i2c and maybe DSPI.

-michael

> 
> diff --git a/arch/arm/cpu/armv8/fsl-layerscape/ls1028_ids.c
> b/arch/arm/cpu/armv8/fsl-layerscape/ls1028_ids.c
> index d9d125e8ba..db9dd69548 100644
> --- a/arch/arm/cpu/armv8/fsl-layerscape/ls1028_ids.c
> +++ b/arch/arm/cpu/armv8/fsl-layerscape/ls1028_ids.c
> @@ -14,7 +14,7 @@ struct icid_id_table icid_tbl[] = {
>         SET_SDHC_ICID(1, FSL_SDMMC_STREAM_ID),
>         SET_SDHC_ICID(2, FSL_SDMMC2_STREAM_ID),
>         SET_SATA_ICID(1, "fsl,ls1028a-ahci", FSL_SATA1_STREAM_ID),
> -       SET_EDMA_ICID(FSL_EDMA_STREAM_ID),
> +       SET_EDMA_ICID_LS1028(FSL_EDMA_STREAM_ID),
>         SET_QDMA_ICID("fsl,ls1028a-qdma", FSL_DMA_STREAM_ID),
>         SET_GPU_ICID("fsl,ls1028a-gpu", FSL_GPU_STREAM_ID),
>         SET_DISPLAY_ICID(FSL_DISPLAY_STREAM_ID),
> diff --git a/arch/arm/include/asm/arch-fsl-layerscape/fsl_icid.h
> b/arch/arm/include/asm/arch-fsl-layerscape/fsl_icid.h
> index 37e2fe4e66..15d0b60dbe 100644
> --- a/arch/arm/include/asm/arch-fsl-layerscape/fsl_icid.h
> +++ b/arch/arm/include/asm/arch-fsl-layerscape/fsl_icid.h
> @@ -144,6 +144,10 @@ extern int fman_icid_tbl_sz;
>         SET_GUR_ICID("fsl,vf610-edma", streamid, spare3_amqr,\
>                 EDMA_BASE_ADDR)
> 
> +#define SET_EDMA_ICID_LS1028(streamid) \
> +       SET_GUR_ICID("fsl,ls1028a-edma", streamid, spare3_amqr,\
> +               EDMA_BASE_ADDR)
> +
>  #define SET_GPU_ICID(compat, streamid) \
>         SET_GUR_ICID(compat, streamid, misc1_amqr,\
>                 GPU_BASE_ADDR)
> 
> BR,
> Peng
>> -michael
>> 
>>> 
>>> Thanks,
>>> Peng
>>>>                        reg = <0x0 0x22c0000 0x0 0x10000>,
>>>>                              <0x0 0x22d0000 0x0 0x10000>,
>>>>                              <0x0 0x22e0000 0x0 0x10000>;
>>>> --
>>>> 2.20.1
