Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D92976A3E5
	for <lists+dmaengine@lfdr.de>; Tue,  1 Aug 2023 00:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbjGaWGe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Jul 2023 18:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbjGaWGd (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 Jul 2023 18:06:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0553BE7;
        Mon, 31 Jul 2023 15:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=ketqReBvJsRBFtro5d+3LKRuMcaInOO+GFbve1ZBwt0=; b=J1WK/1ov8jl5KU3EVv8d8fGOlb
        8HAVAttBj87/x4mxAFPFm6c8vqfvcdh+jVdRKOAeiR+WISQvvCTBw+wXFgAgajKa0Rkip5Kgr6Xr+
        oRyiLnBIml2huAjZJ+1aVU9Hv1Y4JbMZbQtfpqjdP2jASNIRcZm0MhlDwyFek9HE1MPMw48TZLMEb
        yPWDZM3OR3b3zxBt0VG0+3u4C/VJHZN8gWAh6U8ZZxS+RB2/l4Ay0ElxQ1Vo/2csEtvnrFIAhTR/3
        TpXfmy8uV9HJ8aAKTB/UKswFi4PAifCsTQpNxJNF+Uj1jjcHq73LkJcNzNQIXIrDowHfhD8VFVLkL
        bj6lkLew==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qQb25-00HTBq-2h;
        Mon, 31 Jul 2023 22:06:29 +0000
Message-ID: <0a548fac-9ba3-fdfe-f33a-3adf029af1b9@infradead.org>
Date:   Mon, 31 Jul 2023 15:06:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V3 1/1] dmaengine: amd: qdma: Add AMD QDMA driver
Content-Language: en-US
To:     Lizhi Hou <lizhi.hou@amd.com>, vkoul@kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Nishad Saraf <nishads@amd.com>, nishad.saraf@amd.com,
        sonal.santan@amd.com, max.zhen@amd.com
References: <1690823535-22524-1-git-send-email-lizhi.hou@amd.com>
 <1690823535-22524-2-git-send-email-lizhi.hou@amd.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <1690823535-22524-2-git-send-email-lizhi.hou@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 7/31/23 10:12, Lizhi Hou wrote:
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index 644c188d6a11..3646fe1ab347 100644
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
> +	  Enable support for the AMD Queue-based DMA subsystem. The primary
> +	  mechanism to transfer data using the QDMA is for the QDMA engine to
> +	  operate on instructions (descriptors) provided by the host operating
> +	  system. Using the descriptors, the QDMA can move data in both the Host

	                                                           either

> +	  to Card (H2C) direction, or the Card to Host (C2H) direction.

	                         ^ drop the comma.

-- 
~Randy
