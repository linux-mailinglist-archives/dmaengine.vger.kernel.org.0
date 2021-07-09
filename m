Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E19AC3C21A3
	for <lists+dmaengine@lfdr.de>; Fri,  9 Jul 2021 11:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbhGIJf6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 9 Jul 2021 05:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbhGIJf5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 9 Jul 2021 05:35:57 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D77FC0613E6
        for <dmaengine@vger.kernel.org>; Fri,  9 Jul 2021 02:33:14 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1m1msS-0007K0-TU; Fri, 09 Jul 2021 11:32:56 +0200
Message-ID: <7f6c9136db9e6cda78cc189fbdeb9db88004c5a5.camel@pengutronix.de>
Subject: Re: [PATCH v14 06/12] dmaengine: imx-sdma: add mcu_2_ecspi script
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
Date:   Fri, 09 Jul 2021 11:32:55 +0200
In-Reply-To: <1617809456-17693-7-git-send-email-yibin.gong@nxp.com>
References: <1617809456-17693-1-git-send-email-yibin.gong@nxp.com>
         <1617809456-17693-7-git-send-email-yibin.gong@nxp.com>
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
> Add mcu_2_ecspi script to fix ecspi errata ERR009165.
> 
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> Acked-by: Vinod Koul <vkoul@kernel.org>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  drivers/dma/imx-sdma.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index 78dcfe2..86bd383 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -892,6 +892,10 @@ static void sdma_get_pc(struct sdma_channel *sdmac,
>  		emi_2_per = sdma->script_addrs->mcu_2_ata_addr;
>  		break;
>  	case IMX_DMATYPE_CSPI:
> +		per_2_emi = sdma->script_addrs->app_2_mcu_addr;
> +		emi_2_per = sdma->script_addrs->mcu_2_ecspi_addr;
> +		sdmac->is_ram_script = true;
> +		break;
>  	case IMX_DMATYPE_EXT:
>  	case IMX_DMATYPE_SSI:
>  	case IMX_DMATYPE_SAI:


