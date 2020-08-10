Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDDD724065E
	for <lists+dmaengine@lfdr.de>; Mon, 10 Aug 2020 15:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgHJNG2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 10 Aug 2020 09:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbgHJNG2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 10 Aug 2020 09:06:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32628C061756
        for <dmaengine@vger.kernel.org>; Mon, 10 Aug 2020 06:06:28 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <rsc@pengutronix.de>)
        id 1k57VC-0000Hr-Uy; Mon, 10 Aug 2020 15:06:10 +0200
Received: from rsc by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <rsc@pengutronix.de>)
        id 1k57V7-0005lY-Bf; Mon, 10 Aug 2020 15:06:05 +0200
Date:   Mon, 10 Aug 2020 15:06:05 +0200
From:   Robert Schwebel <r.schwebel@pengutronix.de>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "martin.fuzzey@flowbird.group" <martin.fuzzey@flowbird.group>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "matthias.schiffer@ew.tq-group.com" 
        <matthias.schiffer@ew.tq-group.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v11 12/12] dmaengine: imx-sdma: add uart rom script
Message-ID: <20200810130605.mwruri44ebw5o4ye@pengutronix.de>
References: <1595616685-9987-1-git-send-email-yibin.gong@nxp.com>
 <1595616685-9987-13-git-send-email-yibin.gong@nxp.com>
 <89946dc6-6c0f-b3d5-9c9a-517f1ed7b5e1@kontron.de>
 <VE1PR04MB6638F057BC8F7F38E954316F89440@VE1PR04MB6638.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VE1PR04MB6638F057BC8F7F38E954316F89440@VE1PR04MB6638.eurprd04.prod.outlook.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 15:05:33 up 269 days,  4:24, 260 users,  load average: 0,22, 0,14,
 0,13
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: rsc@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Aug 10, 2020 at 10:57:42AM +0000, Robin Gong wrote:
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index 5900e32..4db55b9 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -1754,6 +1754,19 @@ static void sdma_add_scripts(struct sdma_engine *sdma,
>         for (i = 0; i < sdma->script_number; i++)
>                 if (addr_arr[i] > 0)
>                         saddr_arr[i] = addr_arr[i];
> +
> +       /*
> +        * get uart_2_mcu_addr/uartsh_2_mcu_addr rom script specially because
> +        * they are now replaced by uart_2_mcu_ram_addr/uartsh_2_mcu_ram_addr
> +        * to be compatible with legacy freescal/nxp sdma firmware, and they

freescale

> +        * are located in the bottom part of sdma_script_start_addrs which are
> +        * beyond the SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V1.
> +        */

rsc
-- 
Pengutronix e.K.                           | Dipl.-Ing. Robert Schwebel  |
Steuerwalder Str. 21                       | https://www.pengutronix.de/ |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |
