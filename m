Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C780D393DAC
	for <lists+dmaengine@lfdr.de>; Fri, 28 May 2021 09:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234998AbhE1HYk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 28 May 2021 03:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234536AbhE1HYh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 28 May 2021 03:24:37 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D536C061574;
        Fri, 28 May 2021 00:23:03 -0700 (PDT)
Received: from [192.168.1.111] (91-157-208-71.elisa-laajakaista.fi [91.157.208.71])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B54078C7;
        Fri, 28 May 2021 09:23:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1622186582;
        bh=OPKpiNkI7EGdOfEcOnlnMpofa22CpOcKc0Jo6JviSDg=;
        h=To:Cc:References:From:Subject:Date:In-Reply-To:From;
        b=FzuGPMehtGZleUXxI3tRKvFZsYqki6dSuO0FugzpAJ78NnD9Z8/sZlnzmum5YyBO8
         TMHwkdR1eT4IZhXuioEZEZ03ciZMH20dKC3wsgZKGMv4gz/RqPTEqdISX7PQBQR90o
         NXusfAqtSVqPp6qqzyHDwJRAwYq/1WmMOR2ZDM8o=
To:     Pratyush Yadav <p.yadav@ti.com>,
        Maxime Ripard <mripard@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Benoit Parrot <bparrot@ti.com>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, dmaengine@vger.kernel.org
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <20210526152308.16525-1-p.yadav@ti.com>
 <20210526152308.16525-7-p.yadav@ti.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: Re: [PATCH v2 06/18] media: cadence: csi2rx: Add external DPHY
 support
Message-ID: <cebc1dc8-3e7a-16d2-a59a-6963f5886b64@ideasonboard.com>
Date:   Fri, 28 May 2021 10:23:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210526152308.16525-7-p.yadav@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 26/05/2021 18:22, Pratyush Yadav wrote:
> Some platforms like TI's J721E can have the CSI2RX paired with an
> external DPHY. Add support to enable and configure the DPHY using the
> generic PHY framework.
> 
> Get the pixel rate and bpp from the subdev and pass them on to the DPHY
> along with the number of lanes. All other settings are left to their
> default values.
> 
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> 
> ---
> 
> Changes in v2:
> - Use phy_pm_runtime_get_sync() and phy_pm_runtime_put() before making
>    calls to set PHY mode, etc. to make sure it is ready.
> 
>   drivers/media/platform/cadence/cdns-csi2rx.c | 158 +++++++++++++++++--
>   1 file changed, 148 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
> index c68a3eac62cd..459326de2eff 100644
> --- a/drivers/media/platform/cadence/cdns-csi2rx.c
> +++ b/drivers/media/platform/cadence/cdns-csi2rx.c
> @@ -30,6 +30,12 @@
>   #define CSI2RX_STATIC_CFG_DLANE_MAP(llane, plane)	((plane) << (16 + (llane) * 4))
>   #define CSI2RX_STATIC_CFG_LANES_MASK			GENMASK(11, 8)
>   
> +#define CSI2RX_DPHY_LANE_CTRL_REG		0x40
> +#define CSI2RX_DPHY_CL_RST			BIT(16)
> +#define CSI2RX_DPHY_DL_RST(i)			BIT((i) + 12)
> +#define CSI2RX_DPHY_CL_EN			BIT(4)
> +#define CSI2RX_DPHY_DL_EN(i)			BIT(i)
> +
>   #define CSI2RX_STREAM_BASE(n)		(((n) + 1) * 0x100)
>   
>   #define CSI2RX_STREAM_CTRL_REG(n)		(CSI2RX_STREAM_BASE(n) + 0x000)
> @@ -54,6 +60,11 @@ enum csi2rx_pads {
>   	CSI2RX_PAD_MAX,
>   };
>   
> +struct csi2rx_fmt {
> +	u32				code;
> +	u8				bpp;
> +};
> +
>   struct csi2rx_priv {
>   	struct device			*dev;
>   	unsigned int			count;
> @@ -85,6 +96,52 @@ struct csi2rx_priv {
>   	int				source_pad;
>   };
>   
> +static const struct csi2rx_fmt formats[] = {
> +	{
> +		.code	= MEDIA_BUS_FMT_YUYV8_2X8,
> +		.bpp	= 16,
> +	},
> +	{
> +		.code	= MEDIA_BUS_FMT_UYVY8_2X8,
> +		.bpp	= 16,
> +	},
> +	{
> +		.code	= MEDIA_BUS_FMT_YVYU8_2X8,
> +		.bpp	= 16,
> +	},
> +	{
> +		.code	= MEDIA_BUS_FMT_VYUY8_2X8,
> +		.bpp	= 16,
> +	},
> +};
> +
> +static u8 csi2rx_get_bpp(u32 code)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(formats); i++) {
> +		if (formats[i].code == code)
> +			return formats[i].bpp;
> +	}
> +
> +	return 0;
> +}
> +
> +static s64 csi2rx_get_pixel_rate(struct csi2rx_priv *csi2rx)
> +{
> +	struct v4l2_ctrl *ctrl;
> +
> +	ctrl = v4l2_ctrl_find(csi2rx->source_subdev->ctrl_handler,
> +			      V4L2_CID_PIXEL_RATE);
> +	if (!ctrl) {
> +		dev_err(csi2rx->dev, "no pixel rate control in subdev: %s\n",
> +			csi2rx->source_subdev->name);
> +		return -EINVAL;
> +	}
> +
> +	return v4l2_ctrl_g_ctrl_int64(ctrl);
> +}
> +
>   static inline
>   struct csi2rx_priv *v4l2_subdev_to_csi2rx(struct v4l2_subdev *subdev)
>   {
> @@ -101,6 +158,66 @@ static void csi2rx_reset(struct csi2rx_priv *csi2rx)
>   	writel(0, csi2rx->base + CSI2RX_SOFT_RESET_REG);
>   }
>   
> +static int csi2rx_configure_external_dphy(struct csi2rx_priv *csi2rx)
> +{
> +	union phy_configure_opts opts = { };
> +	struct phy_configure_opts_mipi_dphy *cfg = &opts.mipi_dphy;
> +	struct v4l2_subdev_format sd_fmt;
> +	s64 pixel_rate;
> +	int ret;
> +	u8 bpp;
> +	bool got_pm = true;
> +
> +	sd_fmt.which = V4L2_SUBDEV_FORMAT_ACTIVE;
> +	sd_fmt.pad = 0;
> +
> +	ret = v4l2_subdev_call(csi2rx->source_subdev, pad, get_fmt, NULL,
> +			       &sd_fmt);
> +	if (ret)
> +		return ret;
> +
> +	bpp = csi2rx_get_bpp(sd_fmt.format.code);
> +	if (!bpp)
> +		return -EINVAL;
> +
> +	pixel_rate = csi2rx_get_pixel_rate(csi2rx);
> +	if (pixel_rate < 0)
> +		return pixel_rate;
> +
> +	ret = phy_mipi_dphy_get_default_config(pixel_rate, bpp,
> +					       csi2rx->num_lanes, cfg);
> +	if (ret)
> +		return ret;

I guess the above code works for now, but with multiple streams it 
won't. There's no (single) pixel rate or bpp with multiple streams, and 
the link freq is the one that needs to be used. There's 
v4l2_get_link_freq() helper which makes it easier to support both pixel 
rate and link freq.

  Tomi
