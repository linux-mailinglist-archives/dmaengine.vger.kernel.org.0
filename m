Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 954184F9BDA
	for <lists+dmaengine@lfdr.de>; Fri,  8 Apr 2022 19:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238236AbiDHRlY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 8 Apr 2022 13:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238241AbiDHRlX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 8 Apr 2022 13:41:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3ACB7DE22;
        Fri,  8 Apr 2022 10:39:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50A70621AF;
        Fri,  8 Apr 2022 17:39:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3EC5C385A3;
        Fri,  8 Apr 2022 17:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649439558;
        bh=fjDvDzKQXH+2sFBYV36rZ198m6vn8t2q+ypSTCZ4aME=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JvU4Z2WMU3WoPbly6wMJrkt5PXY/SJ+eZIPSfgdrwg4qTAediv2I9luAlRDxhNIcv
         jv0LPCiKKQ+/17WNyoyioViRu36JIF+yOCN4tch7QW1u+OztYBF28hgjClKUFgwtPZ
         9KsvkE9Gu9rBQHTvLrOs2MU4QzKF8EBh7aAyFjK1rKAVudvDiYgHi78P1RT2BkFBlq
         1rfq/yD/hwiaJZ1qbcm54CL+Ui8I8WJYG/NcHZgnWbOp3peJ7M7NFp3Yd3yQZmEGFA
         y0dHFQG+tdwxf2ZvTZ0YJo0wjC5iPmGeWO02uS5JrpA5kt4i1Bj9h0pW1tI5hPlLpG
         2+DQvByP+Sa4g==
Date:   Fri, 8 Apr 2022 23:09:14 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Kevin Groeneveld <kgroeneveld@lenbrook.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Robin Gong <yibin.gong@nxp.com>, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: imx-sdma: fix regression with uart scripts
Message-ID: <YlBzQpWEqMHz/HsU@matsya>
References: <20220406224809.29197-1-kgroeneveld@lenbrook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406224809.29197-1-kgroeneveld@lenbrook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 06-04-22, 18:48, Kevin Groeneveld wrote:
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

1. Patch title should reflect the change introduced, so the title is not
apt, pls revise
2. Is this in response to rmk's report, if so, please add reported-by
3. Lastly, I would like to see some tested by for this patch..

> 
> Fixes: b98ce2f4e32b ("dmaengine: imx-sdma: add uart rom script")

cc: stable ?

> Signed-off-by: Kevin Groeneveld <kgroeneveld@lenbrook.com>
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
> -- 
> 2.17.1

-- 
~Vinod
