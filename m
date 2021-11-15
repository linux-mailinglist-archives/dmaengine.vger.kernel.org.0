Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE5534500DE
	for <lists+dmaengine@lfdr.de>; Mon, 15 Nov 2021 10:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbhKOJNU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 15 Nov 2021 04:13:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbhKOJNS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 15 Nov 2021 04:13:18 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631CBC061746;
        Mon, 15 Nov 2021 01:10:21 -0800 (PST)
Received: from pendragon.ideasonboard.com (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2837F9CA;
        Mon, 15 Nov 2021 10:10:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1636967417;
        bh=bs5FwrGJKmZiUyJUhZtsFFkCbThCR2+MNX7sYGLdInI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dnjNnE+BxQubVBzyvt35tp9eSPunAc+NOuowzVjMVfnO6jqLw3nMEngEl53CjbMh0
         UYxBQSy9hDC4AXM+j7bivGr1bDYL75caLR3Kpvgip4jQNeMxX1tvkF1//Xh3honHLn
         XZyCAuT51XsudJZ+zXrp60OeLJ0gprUub8NgbGw0=
Date:   Mon, 15 Nov 2021 11:09:54 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Andy Gross <agross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jon Hunter <jonathanh@nvidia.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Scott Branden <sbranden@broadcom.com>,
        Takashi Iwai <tiwai@suse.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        alsa-devel@alsa-project.org, bcm-kernel-feedback-list@broadcom.com,
        dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH 04/11] dmaengine: shdma: remove legacy slave_id parsing
Message-ID: <YZIj4iKUsj/QQ+BH@pendragon.ideasonboard.com>
References: <20211115085403.360194-1-arnd@kernel.org>
 <20211115085403.360194-5-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211115085403.360194-5-arnd@kernel.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Arnd,

Thank you for the patch.

On Mon, Nov 15, 2021 at 09:53:56AM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The slave device is picked through either devicetree or a filter
> function, and any remaining out-of-tree drivers would have warned
> about this usage since 2015.
> 
> Stop interpreting the field finally so it can be removed from
> the interface.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/dma/sh/shdma-base.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/dma/sh/shdma-base.c b/drivers/dma/sh/shdma-base.c
> index 7f72b3f4cd1a..41c6bc650fa3 100644
> --- a/drivers/dma/sh/shdma-base.c
> +++ b/drivers/dma/sh/shdma-base.c
> @@ -786,14 +786,6 @@ static int shdma_config(struct dma_chan *chan,
>  	if (!config)
>  		return -EINVAL;
>  
> -	/*
> -	 * overriding the slave_id through dma_slave_config is deprecated,
> -	 * but possibly some out-of-tree drivers still do it.
> -	 */
> -	if (WARN_ON_ONCE(config->slave_id &&
> -			 config->slave_id != schan->real_slave_id))
> -		schan->real_slave_id = config->slave_id;
> -
>  	/*
>  	 * We could lock this, but you shouldn't be configuring the
>  	 * channel, while using it...

-- 
Regards,

Laurent Pinchart
