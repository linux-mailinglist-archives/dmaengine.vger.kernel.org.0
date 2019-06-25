Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B70DC559A2
	for <lists+dmaengine@lfdr.de>; Tue, 25 Jun 2019 23:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbfFYVFY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 25 Jun 2019 17:05:24 -0400
Received: from static.187.34.201.195.clients.your-server.de ([195.201.34.187]:39560
        "EHLO sysam.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725290AbfFYVFX (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 25 Jun 2019 17:05:23 -0400
X-Greylist: delayed 542 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Jun 2019 17:05:22 EDT
Received: from localhost (localhost [127.0.0.1])
        by sysam.it (Postfix) with ESMTP id 522653FE8F;
        Tue, 25 Jun 2019 22:56:19 +0200 (CEST)
Received: from sysam.it ([127.0.0.1])
        by localhost (mail.sysam.it [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id RZOjAEBv86Q3; Tue, 25 Jun 2019 22:56:19 +0200 (CEST)
Received: from jerusalem (host105-54-dynamic.182-80-r.retail.telecomitalia.it [80.182.54.105])
        by sysam.it (Postfix) with ESMTPSA id 6B6373FE8A;
        Tue, 25 Jun 2019 22:56:18 +0200 (CEST)
Date:   Tue, 25 Jun 2019 22:56:17 +0200
From:   Angelo Dureghello <angelo@sysam.it>
To:     yibin.gong@nxp.com
Cc:     robh@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, mark.rutland@arm.com, vkoul@kernel.org,
        dan.j.williams@intel.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH v5 0/6] add edma2 for i.mx7ulp
Message-ID: <20190625205617.GA24968@jerusalem>
References: <20190625094324.19196-1-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625094324.19196-1-yibin.gong@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Robin,

On Tue, Jun 25, 2019 at 05:43:18PM +0800, yibin.gong@nxp.com wrote:
> From: Robin Gong <yibin.gong@nxp.com>
> 
> This patch set add new version of edma for i.mx7ulp, the main changes
> are as belows:
>  1. only one dmamux.
>  2. another clock dma_clk except dmamux clk.
>  3. 16 independent interrupts instead of only one interrupt for
>     all channels
> For the first change, need modify fsl-edma-common.c and mcf-edma,
> so create the first two patches to prepare without any function impact.
> 
> For the third change, need request single irq for every channel with
> the legacy handler. But actually 2 dma channels share one interrupt(16
> channel interrupts, but 32 channels.),ch0/ch16,ch1/ch17... For now, just
> simply request irq without IRQF_SHARED flag, since 16 channels are enough
> on i.mx7ulp whose M4 domain own some peripherals.
> 
> change from v1:
>   1. check .data of 'of_device_id' in probe instead of compatible name.
> 
> change from v2:
>   1. move the difference between edma and edma2 into driver data so that
>      no need version checking in fsl-edma.c.
> 
> change from v3:
>   1. remove duplicated 'version' and 'dmamux_nr' in 'struct fsl_edma_engine'
>      since they are included in drvdata already.
>   2. downgrade print log level.
>   3. address some minor indent issues raised by Vinod.
> 
> change from v4:
>   1. correct typo.
> 
> Robin Gong (6):
>   dmaengine: fsl-edma: add drvdata for fsl-edma
>   dmaengine: fsl-edma-common: move dmamux register to another single
>     function
>   dmaengine: fsl-edma-common: version check for v2 instead
>   dt-bindings: dma: fsl-edma: add new i.mx7ulp-edma
>   dmaengine: fsl-edma: add i.mx7ulp edma2 version support
>   ARM: dts: imx7ulp: add edma device node
> 
>  Documentation/devicetree/bindings/dma/fsl-edma.txt |  44 ++++++++-
>  arch/arm/boot/dts/imx7ulp.dtsi                     |  28 ++++++
>  drivers/dma/fsl-edma-common.c                      |  83 ++++++++++------
>  drivers/dma/fsl-edma-common.h                      |  14 ++-
>  drivers/dma/fsl-edma.c                             | 109 ++++++++++++++++++---
>  drivers/dma/mcf-edma.c                             |  11 ++-
>  6 files changed, 239 insertions(+), 50 deletions(-)
> 

I tested the patch-set on ColdFire mcf5441x (stmark2 board), all works fine.

Tested-by: Angelo Dureghello <angelo@sysam.it>


Regards,
Angelo

> -- 
> 2.7.4
> 
