Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD6E524A7C
	for <lists+dmaengine@lfdr.de>; Thu, 12 May 2022 12:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347482AbiELKkC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 12 May 2022 06:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiELKkC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 12 May 2022 06:40:02 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4A15EDDF;
        Thu, 12 May 2022 03:40:00 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 4so5915339ljw.11;
        Thu, 12 May 2022 03:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Wzyr02LBMhdQTusCnd1t3WsMuC5rvPxv7Sz+P69gyT8=;
        b=PWTwmij20E3Mx8kkcN6UdjugtIl0wEDuYlA5F658FkTar2PMXMqP+YesyMptZYicJu
         g4Ljgi6Jv+sdLvdOVGM46CQKxPXA8J6YIn4y0PbbbaLiYhYEtuz7RvkUBdQ+proIUlcP
         F++7e+Pv29niDsIPpEBe35M7iLmeN1wcaEQgPtsm6O1fCtZTUzhwCpf6Oq6RKEPNMmdQ
         WSi+o+YFYVHCBBocnPS1guewxtjmg7ovaZSOFF7DJ8Dw9oe4n1sYaRV6wmbSi3Qe85VZ
         AweZ7HjY1vNRzcGMLJD9lUmw+UZnHT52DKBRvPuYSt2u0juIrY7RDM1wCBPtoee+6hrU
         SBzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wzyr02LBMhdQTusCnd1t3WsMuC5rvPxv7Sz+P69gyT8=;
        b=dEm7WEGOuw0kntPmPHE5xKVFxa3bzqPumux+HL5qzjufld8oibQXQAcToHN7GEqZ1f
         lM3GMu6eqdrxT70YG1UD0+9SBC91OazEkLRo8DECJwWnaSE+Tl6H2gxB41xKibSUXIL7
         CGsdwfzQRC6n+KgFEYSvpFGhvy6vlgtbBOaeazOquyMG4cAblm3uhWcndQws8XEfvboN
         IIcSU1jwNQvBIpQMzw2HKTQfvAoVEq/UZ2NY/OXLGKKtt2DW3x87732nR68mTdDNrNNq
         k1Bm363Qx7mV8MMrn5AKpsgD6mrjgqIah/bveGDJr7QWeNQm+RM6WYisa1I2t1GkPLQk
         uj3A==
X-Gm-Message-State: AOAM530/jfe3coj/ENAOKJgXoAwarFK1LbjVFkxTi2U4WDfE2Pm4qW+O
        wMLXAOfzVTzlHaiRdEck4QXdE0uCfnjGFg==
X-Google-Smtp-Source: ABdhPJwkJNGIfXjYmaDvHSqQtwOxoCRn8Ovhnhsa7HeK1ShpaVly4CF8TTokFz3Cv20eexjHM+Nhjg==
X-Received: by 2002:a2e:b895:0:b0:250:6797:9e07 with SMTP id r21-20020a2eb895000000b0025067979e07mr20457510ljp.306.1652351998394;
        Thu, 12 May 2022 03:39:58 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id 76-20020a2e054f000000b0024f3d1dae98sm824665ljf.32.2022.05.12.03.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 03:39:57 -0700 (PDT)
Date:   Thu, 12 May 2022 13:39:55 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Ruiqi Li <guywithanaxe42@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        gustavo.pimentel@synopsys.com, vkoul@kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] dmaengine: dw-edma: Removed redundant #ifdef check
 for 64-bit
Message-ID: <20220512103955.abihluliakytznae@mobilestation>
References: <20220510163117.1761625-1-guywithanaxe42@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510163117.1761625-1-guywithanaxe42@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello Ruiqu

On Tue, May 10, 2022 at 11:31:17AM -0500, Ruiqi Li wrote:
> Commit at 8fc5133d fixed unaligned memory access, which caused both 32
> and 64 bit to be the same.
> 
>     #ifdef CONFIG_64BIT
>     /* llp is not aligned on 64bit -> keep 32bit accesses */
>     SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
>               lower_32_bits(chunk->ll_region.paddr));
>     SET_CH_32(dw, chan->dir, chan->id, llp.msb,
>               upper_32_bits(chunk->ll_region.paddr));
>     #else /* CONFIG_64BIT */
>     SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
>               lower_32_bits(chunk->ll_region.paddr));
>     SET_CH_32(dw, chan->dir, chan->id, llp.msb,
>               upper_32_bits(chunk->ll_region.paddr));
>     #endif /* CONFIG_64BIT */
> 
> This patch removes redundant preprocessor check for 64 bit.

A similar fix but with another reasoning has already been submitted:
Link: https://lore.kernel.org/linux-pci/20220503225104.12108-21-Sergey.Semin@baikalelectronics.ru/
So not only the denoted but all 64BIT-ifdef's will be dropped from the
driver.

-Sergey

> 
> Signed-off-by: Ruiqi Li <guywithanaxe42@gmail.com>
> ---
>  drivers/dma/dw-edma/dw-edma-v0-core.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> index 33bc1e6c4cf2..d34f344a094b 100644
> --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> @@ -415,18 +415,11 @@ void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
>  			  (DW_EDMA_V0_CCS | DW_EDMA_V0_LLE));
>  		/* Linked list */
>  
> -		#ifdef CONFIG_64BIT
>  		/* llp is not aligned on 64bit -> keep 32bit accesses */
>  		SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
>  			  lower_32_bits(chunk->ll_region.paddr));
>  		SET_CH_32(dw, chan->dir, chan->id, llp.msb,
>  			  upper_32_bits(chunk->ll_region.paddr));
> -		#else /* CONFIG_64BIT */
> -		SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
> -			  lower_32_bits(chunk->ll_region.paddr));
> -		SET_CH_32(dw, chan->dir, chan->id, llp.msb,
> -			  upper_32_bits(chunk->ll_region.paddr));
> -		#endif /* CONFIG_64BIT */
>  	}
>  	/* Doorbell */
>  	SET_RW_32(dw, chan->dir, doorbell,
> -- 
> 2.36.1
> 
