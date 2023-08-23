Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEF978606D
	for <lists+dmaengine@lfdr.de>; Wed, 23 Aug 2023 21:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238072AbjHWTOg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 23 Aug 2023 15:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237937AbjHWTOZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 23 Aug 2023 15:14:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349DC10C3;
        Wed, 23 Aug 2023 12:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=rTj1IElYNKOTSmBMYjpxrfdSx9LbepvWtxSNuEiKNdw=; b=hHYRdJ7m4WSrKp4bO0ErMQbX5Y
        jI/RK4zD9Qm8SHN3Sc/fxT1nh7BAEJmaCHiT9LYPb/AuRmqrrB2x6q1ZENmhHp+KaYftwDwpY7rsZ
        qP63np7rFNVdMBDRjxwtmws+ETdzyAAqbkHCx+KzTuJgGzqRgX0ruvB1veuRos3Dolr9sMKe4Szv9
        nlkbxwq+OW2EtbTOpekrnwBtSmPCIgT5xAcKKspW6IJs4KARjdRSOTuVtLjoY2bPEUATK/tUmJ3/y
        vem3xVrn3Rrfj9LaZrFIhDHUrH5cDKmtx8Q6HxFPtLxDqBnwQLYX2IYsHFeHflkvBNZNq5JX9MDLl
        uw4npG5A==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qYtJ5-001OUT-34;
        Wed, 23 Aug 2023 19:14:20 +0000
Message-ID: <3e7ec5cf-2e51-c999-d71d-86bfebda8ceb@infradead.org>
Date:   Wed, 23 Aug 2023 12:14:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/1] MAINTAINERS: Add entries for NXP(Freescale) eDMA
 drivers
Content-Language: en-US
To:     Frank Li <Frank.Li@nxp.com>, vkoul@kernel.org
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        imx@lists.linux.dev, joy.zou@nxp.com, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, shenwei.wang@nxp.com
References: <20230823184439.2618694-1-Frank.Li@nxp.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230823184439.2618694-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 8/23/23 11:44, Frank Li wrote:
> Add the MAINTAINERS entries for NXP(Freescale) eDMA drivers
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 23eafda02056..eba417bb5ffb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8228,6 +8228,14 @@ L:	linuxppc-dev@lists.ozlabs.org
>  S:	Maintained
>  F:	drivers/dma/fsldma.*
>  
> +FREESCALE eDMA DRIVER
> +M:	Frank Li <Frank.Li@nxp.com>
> +L:	imx@lists.linux.dev
> +L:	dmaengine@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/dma/fsl,edma.yaml
> +F:	drivers/dma/fsl-edma*.*
> +

This new entry should be after the following entry to maintain
alphabetical order.

>  FREESCALE DSPI DRIVER
>  M:	Vladimir Oltean <olteanv@gmail.com>
>  L:	linux-spi@vger.kernel.org

-- 
~Randy
