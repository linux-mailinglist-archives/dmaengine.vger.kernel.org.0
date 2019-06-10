Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D51853B589
	for <lists+dmaengine@lfdr.de>; Mon, 10 Jun 2019 14:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389859AbfFJM6q (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 10 Jun 2019 08:58:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:44314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389309AbfFJM6p (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 10 Jun 2019 08:58:45 -0400
Received: from localhost (unknown [122.167.93.80])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E91820859;
        Mon, 10 Jun 2019 12:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560171524;
        bh=ori1GFesj1z5JPxLlfpKYaJLocajgiy9syaphmuaIwM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GnWLKFhA5w0ZZr8qk8930e1Mxl1MClV2NU90ZUGw1xN1H1olHZ1Zuds0d/1CcT0sU
         uKoklkGofDHQKG9rXaEggUhFaLjU90713fBXOcPyevwLPc7pgNOq0FiDDJJzPeRsiS
         38x557aSB/KmmgqA1uJHj15FMIsdHkMZoIhKlDt8=
Date:   Mon, 10 Jun 2019 18:25:34 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     yibin.gong@nxp.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, broonie@kernel.org,
        festevam@gmail.com, dan.j.williams@intel.com,
        u.kleine-koenig@pengutronix.de, catalin.marinas@arm.com,
        l.stach@pengutronix.de, will.deacon@arm.com,
        linux-spi@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 15/15] dmaengine: imx-sdma: add uart rom script
Message-ID: <20190610125534.GQ9160@vkoul-mobl.Dlink>
References: <20190610081753.11422-1-yibin.gong@nxp.com>
 <20190610081753.11422-16-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610081753.11422-16-yibin.gong@nxp.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 10-06-19, 16:17, yibin.gong@nxp.com wrote:
> From: Robin Gong <yibin.gong@nxp.com>
> 
> For the compatibility of NXP internal legacy kernel before 4.19 which
> is based on uart ram script and upstreaming kernel based on uart rom
> script, add both uart ram/rom script in latest sdma firmware. By default
> uart rom script used.
> Besides, add two multi-fifo scripts for SAI/PDM on i.mx8m/8mm and add
> back qspi script miss for v4(i.mx7d/8m/8mm family, but v3 is for i.mx6).
> 
> rom script:
> 	uart_2_mcu_addr
> 	uartsh_2_mcu_addr /* through spba bus */
> ram script:
> 	uart_2_mcu_ram_addr
> 	uartsh_2_mcu_ram_addr /* through spba bus */
> 
> Please get latest sdma firmware from the below and put them into the path
> (/lib/firmware/imx/sdma/):
> https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git
> /tree/imx/sdma

How does this work with folks have older firmware?

> 
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> ---
>  drivers/dma/imx-sdma.c                     |  4 ++--
>  include/linux/platform_data/dma-imx-sdma.h | 10 ++++++++--
>  2 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index f7c150d..deea9aa 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -1733,8 +1733,8 @@ static void sdma_issue_pending(struct dma_chan *chan)
>  
>  #define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V1	34
>  #define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V2	38
> -#define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V3	41
> -#define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V4	42
> +#define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V3	45
> +#define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V4	46
>  
>  static void sdma_add_scripts(struct sdma_engine *sdma,
>  		const struct sdma_script_start_addrs *addr)
> diff --git a/include/linux/platform_data/dma-imx-sdma.h b/include/linux/platform_data/dma-imx-sdma.h
> index f794fee..e12d2e8 100644
> --- a/include/linux/platform_data/dma-imx-sdma.h
> +++ b/include/linux/platform_data/dma-imx-sdma.h
> @@ -20,12 +20,12 @@ struct sdma_script_start_addrs {
>  	s32 per_2_firi_addr;
>  	s32 mcu_2_firi_addr;
>  	s32 uart_2_per_addr;
> -	s32 uart_2_mcu_addr;
> +	s32 uart_2_mcu_ram_addr;
>  	s32 per_2_app_addr;
>  	s32 mcu_2_app_addr;
>  	s32 per_2_per_addr;
>  	s32 uartsh_2_per_addr;
> -	s32 uartsh_2_mcu_addr;
> +	s32 uartsh_2_mcu_ram_addr;
>  	s32 per_2_shp_addr;
>  	s32 mcu_2_shp_addr;
>  	s32 ata_2_mcu_addr;
> @@ -52,7 +52,13 @@ struct sdma_script_start_addrs {
>  	s32 zcanfd_2_mcu_addr;
>  	s32 zqspi_2_mcu_addr;
>  	s32 mcu_2_ecspi_addr;
> +	s32 mcu_2_sai_addr;
> +	s32 sai_2_mcu_addr;
> +	s32 uart_2_mcu_addr;
> +	s32 uartsh_2_mcu_addr;
>  	/* End of v3 array */
> +	s32 mcu_2_zqspi_addr;
> +	/* End of v4 array */
>  };
>  
>  /**
> -- 
> 2.7.4

-- 
~Vinod
