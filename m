Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6AE134E675
	for <lists+dmaengine@lfdr.de>; Tue, 30 Mar 2021 13:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbhC3Lnj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 Mar 2021 07:43:39 -0400
Received: from foss.arm.com ([217.140.110.172]:58452 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231829AbhC3Lni (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 30 Mar 2021 07:43:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F0231FB;
        Tue, 30 Mar 2021 04:43:38 -0700 (PDT)
Received: from [10.57.27.121] (unknown [10.57.27.121])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6DF003F694;
        Tue, 30 Mar 2021 04:43:36 -0700 (PDT)
Subject: Re: [PATCH 24/30] Kconfig: Change Synopsys to Synopsis
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, iommu@lists.linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org, dave.jiang@intel.com,
        dan.j.williams@intel.com
Cc:     rdunlap@infradead.org, linux-kernel@vger.kernel.org
References: <cover.1616971780.git.unixbhaskar@gmail.com>
 <1262e9e62498f961e5172205e66a9ef7c6f0f69d.1616971780.git.unixbhaskar@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <8f80fb1b-b2d0-b66a-24b0-bd92dc6cd4b6@arm.com>
Date:   Tue, 30 Mar 2021 12:43:31 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1262e9e62498f961e5172205e66a9ef7c6f0f69d.1616971780.git.unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2021-03-29 00:53, Bhaskar Chowdhury wrote:
> s/Synopsys/Synopsis/  .....two different places.

Erm, that is definitely not a typo... :/

> ..and for some unknown reason it introduce a empty line deleted and added
> back.

Presumably your editor is configured to trim trailing whitespace on save.

Furthermore, there are several instances in the other patches where your 
"corrections" are grammatically incorrect, I'm not sure what the deal is 
with patch #14, and you've also used the wrong subsystem name (it should 
be "dmaengine"). It's great to want to clean things up, but please pay a 
bit of care and attention to what you're actually doing.

Robin.

> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>   drivers/dma/Kconfig | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index 0c2827fd8c19..30e8cc26f43b 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -170,15 +170,15 @@ config DMA_SUN6I
>   	  Support for the DMA engine first found in Allwinner A31 SoCs.
> 
>   config DW_AXI_DMAC
> -	tristate "Synopsys DesignWare AXI DMA support"
> +	tristate "Synopsis DesignWare AXI DMA support"
>   	depends on OF || COMPILE_TEST
>   	depends on HAS_IOMEM
>   	select DMA_ENGINE
>   	select DMA_VIRTUAL_CHANNELS
>   	help
> -	  Enable support for Synopsys DesignWare AXI DMA controller.
> +	  Enable support for Synopsis DesignWare AXI DMA controller.
>   	  NOTE: This driver wasn't tested on 64 bit platform because
> -	  of lack 64 bit platform with Synopsys DW AXI DMAC.
> +	  of lack 64 bit platform with Synopsis DW AXI DMAC.
> 
>   config EP93XX_DMA
>   	bool "Cirrus Logic EP93xx DMA support"
> @@ -394,7 +394,7 @@ config MOXART_DMA
>   	select DMA_VIRTUAL_CHANNELS
>   	help
>   	  Enable support for the MOXA ART SoC DMA controller.
> -
> +
>   	  Say Y here if you enabled MMP ADMA, otherwise say N.
> 
>   config MPC512X_DMA
> --
> 2.26.3
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 
