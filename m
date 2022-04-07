Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC6C4F7C97
	for <lists+dmaengine@lfdr.de>; Thu,  7 Apr 2022 12:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237318AbiDGKVI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 7 Apr 2022 06:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234397AbiDGKVH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 7 Apr 2022 06:21:07 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF8C23D76C
        for <dmaengine@vger.kernel.org>; Thu,  7 Apr 2022 03:19:07 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1ncPEA-0004DC-QT; Thu, 07 Apr 2022 12:18:58 +0200
Message-ID: <0316d3b81dda8f1de97238483758566becbbb9fc.camel@pengutronix.de>
Subject: Re: [PATCH] dmaengine: imx-sdma: fix regression with uart scripts
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Kevin Groeneveld <kgroeneveld@lenbrook.com>,
        Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Robin Gong <yibin.gong@nxp.com>, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Thu, 07 Apr 2022 12:18:57 +0200
In-Reply-To: <20220406224809.29197-1-kgroeneveld@lenbrook.com>
References: <20220406224809.29197-1-kgroeneveld@lenbrook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Am Mittwoch, dem 06.04.2022 um 18:48 -0400 schrieb Kevin Groeneveld:
> Commit b98ce2f4e32b ("dmaengine: imx-sdma: add uart rom script") broke
> uart rx on imx5 when using sdma firmware from older Freescale 2.6.35
> kernel. In this case reading addr->uartXX_2_mcu_addr was going out of
> bounds of the firmware memory and corrupting the uart script addresses.
> 
> Simply adding a bounds check before accessing addr->uartXX_2_mcu_addr
> does not work as the uartXX_2_mcu_addr members are now beyond the size
> of the older firmware and the uart addresses would never be populated
> in that case. There are other ways to fix this but overall the logic
> seems clearer to me to revert the uartXX_2_mcu_ram_addr structure
> entries back to uartXX_2_mcu_addr, change the newer entries to
> uartXX_2_mcu_rom_addr and update the logic accordingly.
> 
> Fixes: b98ce2f4e32b ("dmaengine: imx-sdma: add uart rom script")
> Signed-off-by: Kevin Groeneveld <kgroeneveld@lenbrook.com>

I clearly didn't think about this case when reviewing the breaking
change. The solution in this patch looks fine to me.

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  drivers/dma/imx-sdma.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index 70c0aa931ddf..b708d029b6e9 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -198,12 +198,12 @@ struct sdma_script_start_addrs {
>  	s32 per_2_firi_addr;
>  	s32 mcu_2_firi_addr;
>  	s32 uart_2_per_addr;
> -	s32 uart_2_mcu_ram_addr;
> +	s32 uart_2_mcu_addr;
>  	s32 per_2_app_addr;
>  	s32 mcu_2_app_addr;
>  	s32 per_2_per_addr;
>  	s32 uartsh_2_per_addr;
> -	s32 uartsh_2_mcu_ram_addr;
> +	s32 uartsh_2_mcu_addr;
>  	s32 per_2_shp_addr;
>  	s32 mcu_2_shp_addr;
>  	s32 ata_2_mcu_addr;
> @@ -232,8 +232,8 @@ struct sdma_script_start_addrs {
>  	s32 mcu_2_ecspi_addr;
>  	s32 mcu_2_sai_addr;
>  	s32 sai_2_mcu_addr;
> -	s32 uart_2_mcu_addr;
> -	s32 uartsh_2_mcu_addr;
> +	s32 uart_2_mcu_rom_addr;
> +	s32 uartsh_2_mcu_rom_addr;
>  	/* End of v3 array */
>  	s32 mcu_2_zqspi_addr;
>  	/* End of v4 array */
> @@ -1796,17 +1796,17 @@ static void sdma_add_scripts(struct sdma_engine *sdma,
>  			saddr_arr[i] = addr_arr[i];
>  
>  	/*
> -	 * get uart_2_mcu_addr/uartsh_2_mcu_addr rom script specially because
> -	 * they are now replaced by uart_2_mcu_ram_addr/uartsh_2_mcu_ram_addr
> -	 * to be compatible with legacy freescale/nxp sdma firmware, and they
> -	 * are located in the bottom part of sdma_script_start_addrs which are
> -	 * beyond the SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V1.
> +	 * For compatibility with NXP internal legacy kernel before 4.19 which
> +	 * is based on uart ram script and mainline kernel based on uart rom
> +	 * script, both uart ram/rom scripts are present in newer sdma
> +	 * firmware. Use the rom versions if they are present (V3 or newer).
>  	 */
> -	if (addr->uart_2_mcu_addr)
> -		sdma->script_addrs->uart_2_mcu_addr = addr->uart_2_mcu_addr;
> -	if (addr->uartsh_2_mcu_addr)
> -		sdma->script_addrs->uartsh_2_mcu_addr = addr->uartsh_2_mcu_addr;
> -
> +	if (sdma->script_number >= SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V3) {
> +		if (addr->uart_2_mcu_rom_addr)
> +			sdma->script_addrs->uart_2_mcu_addr = addr->uart_2_mcu_rom_addr;
> +		if (addr->uartsh_2_mcu_rom_addr)
> +			sdma->script_addrs->uartsh_2_mcu_addr = addr->uartsh_2_mcu_rom_addr;
> +	}
>  }
>  
>  static void sdma_load_firmware(const struct firmware *fw, void *context)


