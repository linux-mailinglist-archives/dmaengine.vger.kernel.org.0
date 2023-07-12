Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C100A751286
	for <lists+dmaengine@lfdr.de>; Wed, 12 Jul 2023 23:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbjGLVT1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 12 Jul 2023 17:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbjGLVTX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 12 Jul 2023 17:19:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A99B1FCD;
        Wed, 12 Jul 2023 14:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=WLD4XTxefO125s468Ge4ix9aTj+lzPXq10wHDzt44SI=; b=36dMAjh/Y0XmotmbANngsFKmd/
        QnTk3RM2qRcMxI/b+CaHMNRhfx699PG142pv/p8Vu1F58zqs2TOQe0Ti0JeTiGDIUI9xExo/Pl+e2
        40syGkS99JFHlqzwF7mwVlcYkroYekeAswvEBr0dZF0M6jt/sMzVFeol9vnKgnHD7yxQSGq6v2XYO
        TcwYkEtLkbdphWUECwqm0deRLyHrCHZqKReSisBCiK92GQ82t5RWdZgb5uznUKLBSh/LNHrTzGRk7
        +pN11QaPw4mmVRQ70+foWS3funqunNerM1BUwGfMGMSIPbpBI/LbJtNVPgdzmCn97BjgePtKQu/op
        H+Pvt+gg==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qJhEy-001HXy-1n;
        Wed, 12 Jul 2023 21:19:16 +0000
Message-ID: <5955d0ec-cd3a-5ad3-2c28-4ae819d1366d@infradead.org>
Date:   Wed, 12 Jul 2023 14:19:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RESEND PATCH V2 QDMA 1/1] dmaengine: amd: qdma: Add AMD QDMA
 driver
Content-Language: en-US
To:     Lizhi Hou <lizhi.hou@amd.com>, vkoul@kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Nishad Saraf <nishads@amd.com>, max.zhen@amd.com,
        sonal.santan@amd.com
References: <1689179104-58089-1-git-send-email-lizhi.hou@amd.com>
 <1689179104-58089-2-git-send-email-lizhi.hou@amd.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <1689179104-58089-2-git-send-email-lizhi.hou@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi--

On 7/12/23 09:25, Lizhi Hou wrote:
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index 644c188d6a11..89b26e68988a 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -85,6 +85,19 @@ config AMCC_PPC440SPE_ADMA
>  	help
>  	  Enable support for the AMCC PPC440SPe RAID engines.
>  
> +config AMD_QDMA
> +	tristate "AMD Queue-based DMA"
> +	depends on HAS_IOMEM
> +	select DMA_ENGINE
> +	select DMA_VIRTUAL_CHANNELS
> +	select REGMAP_MMIO
> +	help
> +	  Enable support for the AMD Queue-based DMA subsystem.The primary

Need a space...                                  DMA subsystem. The primary

> +	  mechanism to transfer data using the QDMA is for the QDMA engine to
> +	  operate on instructions (descriptors) provided by the host operating
> +	  system. Using the descriptors, the QDMA can move data in both the Host
> +	  to Card (H2C) direction, or the Card to Host (C2H) direction.

-- 
~Randy
