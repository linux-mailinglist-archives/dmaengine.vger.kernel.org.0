Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6C333529FC
	for <lists+dmaengine@lfdr.de>; Fri,  2 Apr 2021 12:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234902AbhDBK4W (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 2 Apr 2021 06:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbhDBK4W (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 2 Apr 2021 06:56:22 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C36C0613E6;
        Fri,  2 Apr 2021 03:56:20 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0A83D2C1;
        Fri,  2 Apr 2021 12:56:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1617360979;
        bh=6eYqrEyZZU/9oqYbn/7t26/s8F+2OY3y3ACoAKZHSa4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mr4LNeAhc1IVzQf9Ok/ScczcYUQN9fFhw8fhDTO/Ku0XHqINqDEYB/+GKBD0gbDKc
         lALpd6EuwdIQK3ITfoLiZfOgSH/d6w/Cuq3cW08DEh4VIQbN7rRBNMmDdWOjcSIsd8
         yrUjjw9JBjwP4nAp0MRN1ywmg3QYpnLsnvSdO96k=
Date:   Fri, 2 Apr 2021 13:55:35 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Benoit Parrot <bparrot@ti.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Alexandre Courbot <acourbot@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Helen Koike <helen.koike@collabora.com>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Peter Chen <peter.chen@nxp.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        dmaengine@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: Re: [PATCH 09/16] media: cadence: csi2rx: Turn subdev power on
 before starting stream
Message-ID: <YGb4J5q9N0ExOgn9@pendragon.ideasonboard.com>
References: <20210330173348.30135-1-p.yadav@ti.com>
 <20210330173348.30135-10-p.yadav@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210330173348.30135-10-p.yadav@ti.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Pratyush,

Thank you for the patch.

On Tue, Mar 30, 2021 at 11:03:41PM +0530, Pratyush Yadav wrote:
> The subdevice power needs to be turned on before the stream is started.
> Otherwise it might not be in the proper state to stream the data. Turn
> it off when stopping the stream.

The .s_power() operation is deprecated. Subdev drivers should control
power internally in their .s_stream() operation, and they should use
runtime PM to do so (this will allow usage of runtime PM autosuspend, to
avoid expensive power off/on cycles when stopping and restarting video
capture).

> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> ---
>  drivers/media/platform/cadence/cdns-csi2rx.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
> index 7d1ac51e0698..3385e1bc213e 100644
> --- a/drivers/media/platform/cadence/cdns-csi2rx.c
> +++ b/drivers/media/platform/cadence/cdns-csi2rx.c
> @@ -256,6 +256,10 @@ static int csi2rx_start(struct csi2rx_priv *csi2rx)
>  
>  	writel(reg, csi2rx->base + CSI2RX_STATIC_CFG_REG);
>  
> +	ret = v4l2_subdev_call(csi2rx->source_subdev, core, s_power, true);
> +	if (ret && ret != -ENOIOCTLCMD)
> +		goto err_disable_pclk;
> +
>  	ret = v4l2_subdev_call(csi2rx->source_subdev, video, s_stream, true);
>  	if (ret)
>  		goto err_disable_pclk;
> @@ -358,6 +362,10 @@ static void csi2rx_stop(struct csi2rx_priv *csi2rx)
>  	if (v4l2_subdev_call(csi2rx->source_subdev, video, s_stream, false))
>  		dev_warn(csi2rx->dev, "Couldn't disable our subdev\n");
>  
> +	ret = v4l2_subdev_call(csi2rx->source_subdev, core, s_power, false);
> +	if (ret && ret != -ENOIOCTLCMD)
> +		dev_warn(csi2rx->dev, "Couldn't power off subdev\n");
> +
>  	if (csi2rx->dphy) {
>  		writel(0, csi2rx->base + CSI2RX_DPHY_LANE_CTRL_REG);
>  

-- 
Regards,

Laurent Pinchart
