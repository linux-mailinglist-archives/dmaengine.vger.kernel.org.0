Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2DB3C21F7
	for <lists+dmaengine@lfdr.de>; Fri,  9 Jul 2021 11:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbhGIJ6F (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 9 Jul 2021 05:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232049AbhGIJ6E (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 9 Jul 2021 05:58:04 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66814C0613DD
        for <dmaengine@vger.kernel.org>; Fri,  9 Jul 2021 02:55:21 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1m1nDu-0001Ye-4D; Fri, 09 Jul 2021 11:55:06 +0200
Message-ID: <b0e381cb536dceeda2f0ac9ee3dcd16ddeb0c961.camel@pengutronix.de>
Subject: Re: [PATCH v14 11/12] dmaengine: imx-sdma: add uart rom script
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Robin Gong <yibin.gong@nxp.com>, vkoul@kernel.org,
        mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, will.deacon@arm.com, shawnguo@kernel.org,
        festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com,
        frieder.schrempf@kontron.de, m.felsch@pengutronix.de,
        xiaoning.wang@nxp.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Date:   Fri, 09 Jul 2021 11:55:03 +0200
In-Reply-To: <1617809456-17693-12-git-send-email-yibin.gong@nxp.com>
References: <1617809456-17693-1-git-send-email-yibin.gong@nxp.com>
         <1617809456-17693-12-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.1 (3.40.1-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Am Mittwoch, dem 07.04.2021 um 23:30 +0800 schrieb Robin Gong:
> For the compatibility of NXP internal legacy kernel before 4.19 which
> is based on uart ram script and upstreaming kernel based on uart rom
> script, add both uart ram/rom script in latest sdma firmware. By default
> uart rom script used.
> Besides, add two multi-fifo scripts for SAI/PDM on i.mx8m/8mm and add
> back qspi script miss for v4(i.mx7d/8m/8mm family, but v3 is for i.mx6).
> 
> rom script:
>         uart_2_mcu_addr
> 	uartsh_2_mcu_addr /* through spba bus */
> am script:
> 	uart_2_mcu_ram_addr
> 	uartsh_2_mcu_ram_addr /* through spba bus */
> 
> Please get latest sdma firmware from the below and put them into the path
> (/lib/firmware/imx/sdma/):
> https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git
> /tree/imx/sdma
> 
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> Acked-by: Vinod Koul <vkoul@kernel.org>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  drivers/dma/imx-sdma.c                     | 17 +++++++++++++++--
>  include/linux/platform_data/dma-imx-sdma.h |  8 ++++++--
>  2 files changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index af85116..9519b41 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -1696,8 +1696,8 @@ static void sdma_issue_pending(struct dma_chan *chan)
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
> @@ -1721,6 +1721,19 @@ static void sdma_add_scripts(struct sdma_engine *sdma,
>  	for (i = 0; i < sdma->script_number; i++)
>  		if (addr_arr[i] > 0)
>  			saddr_arr[i] = addr_arr[i];
> +
> +	/*
> +	 * get uart_2_mcu_addr/uartsh_2_mcu_addr rom script specially because
> +	 * they are now replaced by uart_2_mcu_ram_addr/uartsh_2_mcu_ram_addr
> +	 * to be compatible with legacy freescale/nxp sdma firmware, and they
> +	 * are located in the bottom part of sdma_script_start_addrs which are
> +	 * beyond the SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V1.
> +	 */
> +	if (addr->uart_2_mcu_addr)
> +		sdma->script_addrs->uart_2_mcu_addr = addr->uart_2_mcu_addr;
> +	if (addr->uartsh_2_mcu_addr)
> +		sdma->script_addrs->uartsh_2_mcu_addr = addr->uartsh_2_mcu_addr;
> +
>  }
>  
>  static void sdma_load_firmware(const struct firmware *fw, void *context)
> diff --git a/include/linux/platform_data/dma-imx-sdma.h b/include/linux/platform_data/dma-imx-sdma.h
> index 725602d..91dac29 100644
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
> @@ -52,6 +52,10 @@ struct sdma_script_start_addrs {
>  	s32 zcanfd_2_mcu_addr;
>  	s32 zqspi_2_mcu_addr;
>  	s32 mcu_2_ecspi_addr;
> +	s32 mcu_2_sai_addr;
> +	s32 sai_2_mcu_addr;
> +	s32 uart_2_mcu_addr;
> +	s32 uartsh_2_mcu_addr;
>  	/* End of v3 array */
>  	s32 mcu_2_zqspi_addr;
>  	/* End of v4 array */


