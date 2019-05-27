Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5692B102
	for <lists+dmaengine@lfdr.de>; Mon, 27 May 2019 11:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfE0JIZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 May 2019 05:08:25 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38203 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfE0JIZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 27 May 2019 05:08:25 -0400
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1hVBc7-0004fQ-KN; Mon, 27 May 2019 11:08:15 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1hVBc6-0001ZE-VS; Mon, 27 May 2019 11:08:14 +0200
Date:   Mon, 27 May 2019 11:08:14 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     yibin.gong@nxp.com
Cc:     robh@kernel.org, shawnguo@kernel.org, festevam@gmail.com,
        mark.rutland@arm.com, vkoul@kernel.org, dan.j.williams@intel.com,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v2 4/7] dmaengine: fsl-edma-common: version check for v2
 instead
Message-ID: <20190527090814.qfjiksqi24x2jrs3@pengutronix.de>
References: <20190527085118.40423-1-yibin.gong@nxp.com>
 <20190527085118.40423-5-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527085118.40423-5-yibin.gong@nxp.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 11:07:14 up 9 days, 15:25, 72 users,  load average: 0.12, 0.20, 0.16
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, May 27, 2019 at 04:51:15PM +0800, yibin.gong@nxp.com wrote:
> From: Robin Gong <yibin.gong@nxp.com>
> 
> The next v3 i.mx7ulp edma is based on v1, so change version
> check logic for v2 instead.
> 
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> ---
>  drivers/dma/fsl-edma-common.c | 40 ++++++++++++++++++++--------------------
>  1 file changed, 20 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
> index bb24251..45d70d3 100644
> --- a/drivers/dma/fsl-edma-common.c
> +++ b/drivers/dma/fsl-edma-common.c
> @@ -657,26 +657,26 @@ void fsl_edma_setup_regs(struct fsl_edma_engine *edma)
>  	edma->regs.erql = edma->membase + EDMA_ERQ;
>  	edma->regs.eeil = edma->membase + EDMA_EEI;
>  
> -	edma->regs.serq = edma->membase + ((edma->version == v1) ?
> -			EDMA_SERQ : EDMA64_SERQ);
> -	edma->regs.cerq = edma->membase + ((edma->version == v1) ?
> -			EDMA_CERQ : EDMA64_CERQ);
> -	edma->regs.seei = edma->membase + ((edma->version == v1) ?
> -			EDMA_SEEI : EDMA64_SEEI);
> -	edma->regs.ceei = edma->membase + ((edma->version == v1) ?
> -			EDMA_CEEI : EDMA64_CEEI);
> -	edma->regs.cint = edma->membase + ((edma->version == v1) ?
> -			EDMA_CINT : EDMA64_CINT);
> -	edma->regs.cerr = edma->membase + ((edma->version == v1) ?
> -			EDMA_CERR : EDMA64_CERR);
> -	edma->regs.ssrt = edma->membase + ((edma->version == v1) ?
> -			EDMA_SSRT : EDMA64_SSRT);
> -	edma->regs.cdne = edma->membase + ((edma->version == v1) ?
> -			EDMA_CDNE : EDMA64_CDNE);
> -	edma->regs.intl = edma->membase + ((edma->version == v1) ?
> -			EDMA_INTR : EDMA64_INTL);
> -	edma->regs.errl = edma->membase + ((edma->version == v1) ?
> -			EDMA_ERR : EDMA64_ERRL);
> +	edma->regs.serq = edma->membase + ((edma->version == v2) ?
> +			EDMA64_SERQ : EDMA_SERQ);
> +	edma->regs.cerq = edma->membase + ((edma->version == v2) ?
> +			EDMA64_CERQ : EDMA_CERQ);
> +	edma->regs.seei = edma->membase + ((edma->version == v2) ?
> +			EDMA64_SEEI : EDMA_SEEI);
> +	edma->regs.ceei = edma->membase + ((edma->version == v2) ?
> +			EDMA64_CEEI : EDMA_CEEI);
> +	edma->regs.cint = edma->membase + ((edma->version == v2) ?
> +			EDMA64_CINT : EDMA_CINT);
> +	edma->regs.cerr = edma->membase + ((edma->version == v2) ?
> +			EDMA64_CERR : EDMA_CERR);
> +	edma->regs.ssrt = edma->membase + ((edma->version == v2) ?
> +			EDMA64_SSRT : EDMA_SSRT);
> +	edma->regs.cdne = edma->membase + ((edma->version == v2) ?
> +			EDMA64_CDNE : EDMA_CDNE);
> +	edma->regs.intl = edma->membase + ((edma->version == v2) ?
> +			EDMA64_INTL : EDMA_INTR);
> +	edma->regs.errl = edma->membase + ((edma->version == v2) ?
> +			EDMA64_ERRL : EDMA_ERR);

Following to what I have said to 6/7 you can put the register offsets
into that new struct aswell.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
