Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E117F45010C
	for <lists+dmaengine@lfdr.de>; Mon, 15 Nov 2021 10:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235058AbhKOJWP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 15 Nov 2021 04:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235130AbhKOJWO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 15 Nov 2021 04:22:14 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1E6C061746;
        Mon, 15 Nov 2021 01:19:11 -0800 (PST)
Received: from pendragon.ideasonboard.com (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C9F1E9CA;
        Mon, 15 Nov 2021 10:19:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1636967950;
        bh=DyMiGF8dYpIO7sFrfkTrEHyV1KL7y6BUoG/PpdzWVzI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IazgGZ0N2QKgbD2xiliOgSKM/Wh6Ku2e/ttwUbC+gF1dv3N9Q27dBA+K+YHkhhn3f
         128fjkKnCXSOo6RM9eqPTMGb4Rdwc+4oI3NFochnUeHBJsqlLB6JXS7U5djKpnhGrr
         6nHRXJmkdxcDwrNkgsOFzaGTd+Zdnc73MAIEaL64=
Date:   Mon, 15 Nov 2021 11:18:47 +0200
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
Subject: Re: [PATCH 11/11] dmaengine: remove slave_id config field
Message-ID: <YZIl92Akt2QEqad9@pendragon.ideasonboard.com>
References: <20211115085403.360194-1-arnd@kernel.org>
 <20211115085403.360194-12-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211115085403.360194-12-arnd@kernel.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Arnd,

Thank you for the patch.

On Mon, Nov 15, 2021 at 09:54:03AM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> All references to the slave_id field have been removed, so
> remove the field as well to prevent new references from
> creeping in again.

A rationale to explain why the slave_id field shouldn't be used would be
nice.

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  include/linux/dmaengine.h | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index 9000f3ffce8b..0349b35235e6 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -418,9 +418,6 @@ enum dma_slave_buswidth {
>   * @device_fc: Flow Controller Settings. Only valid for slave channels. Fill
>   * with 'true' if peripheral should be flow controller. Direction will be
>   * selected at Runtime.
> - * @slave_id: Slave requester id. Only valid for slave channels. The dma
> - * slave peripheral will have unique id as dma requester which need to be
> - * pass as slave config.
>   * @peripheral_config: peripheral configuration for programming peripheral
>   * for dmaengine transfer
>   * @peripheral_size: peripheral configuration buffer size
> @@ -448,7 +445,6 @@ struct dma_slave_config {
>  	u32 src_port_window_size;
>  	u32 dst_port_window_size;
>  	bool device_fc;
> -	unsigned int slave_id;
>  	void *peripheral_config;
>  	size_t peripheral_size;
>  };

-- 
Regards,

Laurent Pinchart
