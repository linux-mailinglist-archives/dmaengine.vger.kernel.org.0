Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E62723529E1
	for <lists+dmaengine@lfdr.de>; Fri,  2 Apr 2021 12:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234161AbhDBKsB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 2 Apr 2021 06:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhDBKr6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 2 Apr 2021 06:47:58 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5B2C0613E6;
        Fri,  2 Apr 2021 03:47:57 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id A1D892C1;
        Fri,  2 Apr 2021 12:47:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1617360475;
        bh=1M9MbEtoPz4Eibg+WiqbztDFfFygAjrnU0pezCLoxLA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Oq/kH/lpnd1eoUemU796c4+rV2rmOdk7Vkvo+Wv1eKf3Mz8AHF09p4EKVGT/KnXly
         vnmZcjLEFa6h0gdpYS9X1YvplUADARP0mdd7tXbL/yw0xpcVwvlU5RGnyXU75F/4br
         poFZETlkyzJZRr8eE39Wgpep5BfDUjrh2n1CVkwg=
Date:   Fri, 2 Apr 2021 13:47:11 +0300
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
Subject: Re: [PATCH 10/16] media: cadence: csi2rx: Add wrappers for subdev
 calls
Message-ID: <YGb2L7dq0fBma1or@pendragon.ideasonboard.com>
References: <20210330173348.30135-1-p.yadav@ti.com>
 <20210330173348.30135-11-p.yadav@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210330173348.30135-11-p.yadav@ti.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Pratyush,

Thank you for the patch.

On Tue, Mar 30, 2021 at 11:03:42PM +0530, Pratyush Yadav wrote:
> When this bridge driver is being user by another platform driver, it
> might want to call subdev operations like getting format, setting
> format, enumerating format codes, etc. Add wrapper functions that pass
> that call through to the sensor.
> 
> Currently wrappers are added only for the ops used by TI's platform
> driver. More can be added later as needed.

This isn't the direction we want to take. For new platforms, propagation
of subdev configuration should be handled by userspace, using the V4L2
userspace subdev API. This subdev should not call any subdev operation
from its source other than .s_stream().

> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> ---
>  drivers/media/platform/cadence/cdns-csi2rx.c | 77 ++++++++++++++++++++
>  1 file changed, 77 insertions(+)
> 
> diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
> index 3385e1bc213e..2e8bbc53cb8b 100644
> --- a/drivers/media/platform/cadence/cdns-csi2rx.c
> +++ b/drivers/media/platform/cadence/cdns-csi2rx.c
> @@ -408,12 +408,89 @@ static int csi2rx_s_stream(struct v4l2_subdev *subdev, int enable)
>  	return ret;
>  }
>  
> +static int csi2rx_g_frame_interval(struct v4l2_subdev *subdev,
> +				   struct v4l2_subdev_frame_interval *fi)
> +{
> +	struct csi2rx_priv *csi2rx = v4l2_subdev_to_csi2rx(subdev);
> +
> +	return v4l2_subdev_call(csi2rx->source_subdev, video, g_frame_interval,
> +				fi);
> +}
> +
> +static int csi2rx_s_frame_interval(struct v4l2_subdev *subdev,
> +				   struct v4l2_subdev_frame_interval *fi)
> +{
> +	struct csi2rx_priv *csi2rx = v4l2_subdev_to_csi2rx(subdev);
> +
> +	return v4l2_subdev_call(csi2rx->source_subdev, video, s_frame_interval,
> +				fi);
> +}
> +
> +static int csi2rx_enum_mbus_code(struct v4l2_subdev *subdev,
> +				 struct v4l2_subdev_pad_config *cfg,
> +				 struct v4l2_subdev_mbus_code_enum *code)
> +{
> +	struct csi2rx_priv *csi2rx = v4l2_subdev_to_csi2rx(subdev);
> +
> +	return v4l2_subdev_call(csi2rx->source_subdev, pad, enum_mbus_code,
> +				cfg, code);
> +}
> +
> +static int csi2rx_get_fmt(struct v4l2_subdev *subdev,
> +			  struct v4l2_subdev_pad_config *cfg,
> +			  struct v4l2_subdev_format *fmt)
> +{
> +	struct csi2rx_priv *csi2rx = v4l2_subdev_to_csi2rx(subdev);
> +
> +	return v4l2_subdev_call(csi2rx->source_subdev, pad, get_fmt, cfg, fmt);
> +}
> +
> +static int csi2rx_set_fmt(struct v4l2_subdev *subdev,
> +			  struct v4l2_subdev_pad_config *cfg,
> +			  struct v4l2_subdev_format *fmt)
> +{
> +	struct csi2rx_priv *csi2rx = v4l2_subdev_to_csi2rx(subdev);
> +
> +	return v4l2_subdev_call(csi2rx->source_subdev, pad, set_fmt, cfg, fmt);
> +}
> +
> +static int csi2rx_enum_frame_size(struct v4l2_subdev *subdev,
> +				  struct v4l2_subdev_pad_config *cfg,
> +				  struct v4l2_subdev_frame_size_enum *fse)
> +{
> +	struct csi2rx_priv *csi2rx = v4l2_subdev_to_csi2rx(subdev);
> +
> +	return v4l2_subdev_call(csi2rx->source_subdev, pad, enum_frame_size,
> +				cfg, fse);
> +}
> +
> +static int csi2rx_enum_frame_interval(struct v4l2_subdev *subdev,
> +				      struct v4l2_subdev_pad_config *cfg,
> +				      struct v4l2_subdev_frame_interval_enum *fie)
> +{
> +	struct csi2rx_priv *csi2rx = v4l2_subdev_to_csi2rx(subdev);
> +
> +	return v4l2_subdev_call(csi2rx->source_subdev, pad, enum_frame_interval,
> +				cfg, fie);
> +}
> +
>  static const struct v4l2_subdev_video_ops csi2rx_video_ops = {
>  	.s_stream	= csi2rx_s_stream,
> +	.g_frame_interval = csi2rx_g_frame_interval,
> +	.s_frame_interval = csi2rx_s_frame_interval,
> +};
> +
> +static const struct v4l2_subdev_pad_ops csi2rx_pad_ops = {
> +	.enum_mbus_code = csi2rx_enum_mbus_code,
> +	.get_fmt	= csi2rx_get_fmt,
> +	.set_fmt	= csi2rx_set_fmt,
> +	.enum_frame_size = csi2rx_enum_frame_size,
> +	.enum_frame_interval = csi2rx_enum_frame_interval,
>  };
>  
>  static const struct v4l2_subdev_ops csi2rx_subdev_ops = {
>  	.video		= &csi2rx_video_ops,
> +	.pad		= &csi2rx_pad_ops,
>  };
>  
>  static int csi2rx_async_bound(struct v4l2_async_notifier *notifier,

-- 
Regards,

Laurent Pinchart
