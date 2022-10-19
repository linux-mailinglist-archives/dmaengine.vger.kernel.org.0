Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7ED604946
	for <lists+dmaengine@lfdr.de>; Wed, 19 Oct 2022 16:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbiJSOdl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 19 Oct 2022 10:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbiJSOdU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 19 Oct 2022 10:33:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFE750065;
        Wed, 19 Oct 2022 07:17:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 610BE618D7;
        Wed, 19 Oct 2022 14:07:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F32C433C1;
        Wed, 19 Oct 2022 14:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666188450;
        bh=pl8esxpNqVX8lumPFScOAZPmDVd4g3zGxjN4oM+8MDM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=elXVvKVvCANqxgvyrisFY6OnUAiv/lHUnN7XVt2sgJse4ey2ySjZ0dKj+O6QOtyb1
         jcyx9Dz7UWDir10q7xgJEDJkH4UnjrH+lHRZf1hBdEs57VNCmLWzI7QJXAjG20uM01
         haTJATh0+EEce8dcqk+Kix0hovrpD9kjs99jkGnCryZE7T1jgtc2c5ic55wIbgra2p
         RAiDRYdRD4BZeAG6BF7slLiL+EjpW/FWo5Y3LLQLDy0qWp6LLx+dY50JXYei6VMtk5
         m1ZklIKo1NzSbU4ZKcLlBGz0IDVJllBxYCp0vZ4jcp1hOYpfc5aSv99Tvv8MgrJAJ1
         Tm+yLdF1o/PQw==
Date:   Wed, 19 Oct 2022 19:37:26 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Cixi Geng <gengcixi@gmail.com>
Cc:     orsonzhai@gmail.com, baolin.wang@linux.alibaba.com,
        zhang.lyra@gmail.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Cixi Geng <cixi.geng1@unisoc.com>
Subject: Re: [PATCH V2] dmaengine: sprd: Support two-stage dma interrupt
Message-ID: <Y1AEngC3y9+OyG5S@matsya>
References: <20221003234929.186290-1-gengcixi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221003234929.186290-1-gengcixi@gmail.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 04-10-22, 07:49, Cixi Geng wrote:
> From: Cixi Geng <cixi.geng1@unisoc.com>
> 
> Audio need to request Audio CP global dma interrupt, so Audio CP
> DMA should support two-stage interrupt to adapte it.
> It will occur interrupt when two-stage dma channel transfer done.

The patch looks fine to me but...

> diff --git a/include/linux/dma/sprd-dma.h b/include/linux/dma/sprd-dma.h
> index d09c6f6f6da5..26de41d6d915 100644
> --- a/include/linux/dma/sprd-dma.h
> +++ b/include/linux/dma/sprd-dma.h

>  enum sprd_dma_int_type {
>  	SPRD_DMA_NO_INT,
> @@ -112,6 +120,10 @@ enum sprd_dma_int_type {
>  	SPRD_DMA_TRANS_BLK_INT,
>  	SPRD_DMA_LIST_INT,
>  	SPRD_DMA_CFGERR_INT,
> +	SPRD_DMA_SRC_CHN0_INT,
> +	SPRD_DMA_SRC_CHN1_INT,
> +	SPRD_DMA_DST_CHN0_INT,
> +	SPRD_DMA_DST_CHN1_INT,

why is sprd_dma_int_type part of driver interface. sprd_dma_int_type is
used only by this driver and should be moved into the driver..

Can you change that as well please

-- 
~Vinod
