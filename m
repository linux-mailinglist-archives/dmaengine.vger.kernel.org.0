Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE910355BD6
	for <lists+dmaengine@lfdr.de>; Tue,  6 Apr 2021 20:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235664AbhDFSzP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 6 Apr 2021 14:55:15 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:38844 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239795AbhDFSzJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 6 Apr 2021 14:55:09 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 136Ishfb009079;
        Tue, 6 Apr 2021 13:54:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1617735283;
        bh=kQbNzrF7H82xGpKlMst9m3Fs0xnlp9w54dXKEwPlWBE=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=kFP+EYPVCuDhQNXUoQs8jCFmvH3/BA2IOptP/4ITP2Z3zPwHXf7BausRsRkgRdYgQ
         bf6RZMQlumFq3iacbU0a3NcEggo2zdHPgRLysQ8BN0YQyHH4585/GmkfanxrOe5w4C
         D0MuSZ3jQyJ1VJqrpv4w2hCyv8D9jb8AeFmdGjD0=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 136Ishgr087495
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Apr 2021 13:54:43 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 6 Apr
 2021 13:54:43 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 6 Apr 2021 13:54:43 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 136IsgCU034245;
        Tue, 6 Apr 2021 13:54:42 -0500
Date:   Wed, 7 Apr 2021 00:24:41 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Benoit Parrot <bparrot@ti.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Alexandre Courbot <acourbot@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Helen Koike <helen.koike@collabora.com>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Peter Chen <peter.chen@nxp.com>, <linux-media@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <dmaengine@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: Re: [PATCH 05/16] media: cadence: csi2rx: Add external DPHY support
Message-ID: <20210406185439.6o5hkejtinq7y7sy@ti.com>
References: <20210330173348.30135-1-p.yadav@ti.com>
 <20210330173348.30135-6-p.yadav@ti.com>
 <1617182653.2752.9.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1617182653.2752.9.camel@mhfsdcap03>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 31/03/21 05:24PM, Chunfeng Yun wrote:
> On Tue, 2021-03-30 at 23:03 +0530, Pratyush Yadav wrote:
> > Some platforms like TI's J721E can have the CSI2RX paired with an
> > external DPHY. Add support to enable and configure the DPHY using the
> > generic PHY framework.
> > 
> > Get the pixel rate and bpp from the subdev and pass them on to the DPHY
> > along with the number of lanes. All other settings are left to their
> > default values.
> > 
> > Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> > ---
> >  drivers/media/platform/cadence/cdns-csi2rx.c | 147 +++++++++++++++++--
> >  1 file changed, 137 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
> > index c68a3eac62cd..31bd80e3f780 100644
> > --- a/drivers/media/platform/cadence/cdns-csi2rx.c
> > +++ b/drivers/media/platform/cadence/cdns-csi2rx.c
> > @@ -30,6 +30,12 @@
> >  #define CSI2RX_STATIC_CFG_DLANE_MAP(llane, plane)	((plane) << (16 + (llane) * 4))
> >  #define CSI2RX_STATIC_CFG_LANES_MASK			GENMASK(11, 8)
> >  
> > +#define CSI2RX_DPHY_LANE_CTRL_REG		0x40
> > +#define CSI2RX_DPHY_CL_RST			BIT(16)
> > +#define CSI2RX_DPHY_DL_RST(i)			BIT((i) + 12)
> > +#define CSI2RX_DPHY_CL_EN			BIT(4)
> > +#define CSI2RX_DPHY_DL_EN(i)			BIT(i)
> > +
> >  #define CSI2RX_STREAM_BASE(n)		(((n) + 1) * 0x100)
> >  
> >  #define CSI2RX_STREAM_CTRL_REG(n)		(CSI2RX_STREAM_BASE(n) + 0x000)
> > @@ -54,6 +60,11 @@ enum csi2rx_pads {
> >  	CSI2RX_PAD_MAX,
> >  };
> >  
> > +struct csi2rx_fmt {
> > +	u32				code;
> > +	u8				bpp;
> > +};
> > +
> >  struct csi2rx_priv {
> >  	struct device			*dev;
> >  	unsigned int			count;
> > @@ -85,6 +96,52 @@ struct csi2rx_priv {
> >  	int				source_pad;
> >  };
> >  
> > +static const struct csi2rx_fmt formats[] = {
> > +	{
> > +		.code	= MEDIA_BUS_FMT_YUYV8_2X8,
> > +		.bpp	= 16,
> > +	},
> > +	{
> > +		.code	= MEDIA_BUS_FMT_UYVY8_2X8,
> > +		.bpp	= 16,
> > +	},
> > +	{
> > +		.code	= MEDIA_BUS_FMT_YVYU8_2X8,
> > +		.bpp	= 16,
> > +	},
> > +	{
> > +		.code	= MEDIA_BUS_FMT_VYUY8_2X8,
> > +		.bpp	= 16,
> > +	},
> > +};
> > +
> > +static u8 csi2rx_get_bpp(u32 code)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(formats); i++) {
> > +		if (formats[i].code == code)
> > +			return formats[i].bpp;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static s64 csi2rx_get_pixel_rate(struct csi2rx_priv *csi2rx)
> > +{
> > +	struct v4l2_ctrl *ctrl;
> > +
> > +	ctrl = v4l2_ctrl_find(csi2rx->source_subdev->ctrl_handler,
> > +			      V4L2_CID_PIXEL_RATE);
> > +	if (!ctrl) {
> > +		dev_err(csi2rx->dev, "no pixel rate control in subdev: %s\n",
> > +			csi2rx->source_subdev->name);
> > +		return -EINVAL;
> > +	}
> > +
> > +	return v4l2_ctrl_g_ctrl_int64(ctrl);
> > +}
> > +
> >  static inline
> >  struct csi2rx_priv *v4l2_subdev_to_csi2rx(struct v4l2_subdev *subdev)
> >  {
> > @@ -101,6 +158,55 @@ static void csi2rx_reset(struct csi2rx_priv *csi2rx)
> >  	writel(0, csi2rx->base + CSI2RX_SOFT_RESET_REG);
> >  }
> >  
> > +static int csi2rx_configure_external_dphy(struct csi2rx_priv *csi2rx)
> > +{
> > +	union phy_configure_opts opts = { };
> > +	struct phy_configure_opts_mipi_dphy *cfg = &opts.mipi_dphy;
> > +	struct v4l2_subdev_format sd_fmt;
> > +	s64 pixel_rate;
> > +	int ret;
> > +	u8 bpp;
> > +
> > +	sd_fmt.which = V4L2_SUBDEV_FORMAT_ACTIVE;
> > +	sd_fmt.pad = 0;
> > +
> > +	ret = v4l2_subdev_call(csi2rx->source_subdev, pad, get_fmt, NULL,
> > +			       &sd_fmt);
> > +	if (ret)
> > +		return ret;
> > +
> > +	bpp = csi2rx_get_bpp(sd_fmt.format.code);
> > +	if (!bpp)
> > +		return -EINVAL;
> > +
> > +	pixel_rate = csi2rx_get_pixel_rate(csi2rx);
> > +	if (pixel_rate < 0)
> > +		return pixel_rate;
> > +
> > +	ret = phy_mipi_dphy_get_default_config(pixel_rate, bpp,
> > +					       csi2rx->num_lanes, cfg);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = phy_set_mode_ext(csi2rx->dphy, PHY_MODE_MIPI_DPHY,
> > +			       PHY_MIPI_DPHY_SUBMODE_RX);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = phy_power_on(csi2rx->dphy);
> > +	if (ret)
> > +		return ret;
> Seems phy_power_on, then phy_set_mode_ext?

Shouldn't the mode be set before the PHY is powered on so the correct 
power on procedure can be performed based on the mode of operation?

> 
> > +
> > +	ret = phy_configure(csi2rx->dphy, &opts);
> > +	if (ret) {
> > +		/* Can't do anything if it fails. Ignore the return value. */
> > +		phy_power_off(csi2rx->dphy);
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static int csi2rx_start(struct csi2rx_priv *csi2rx)
> >  {
> >  	unsigned int i;
> > @@ -139,6 +245,17 @@ static int csi2rx_start(struct csi2rx_priv *csi2rx)
> >  	if (ret)
> >  		goto err_disable_pclk;
> >  
> > +	/* Enable DPHY clk and data lanes. */
> > +	if (csi2rx->dphy) {
> > +		reg = CSI2RX_DPHY_CL_EN | CSI2RX_DPHY_CL_RST;
> > +		for (i = 0; i < csi2rx->num_lanes; i++) {
> > +			reg |= CSI2RX_DPHY_DL_EN(csi2rx->lanes[i] - 1);
> > +			reg |= CSI2RX_DPHY_DL_RST(csi2rx->lanes[i] - 1);
> > +		}
> > +
> > +		writel(reg, csi2rx->base + CSI2RX_DPHY_LANE_CTRL_REG);
> > +	}
> > +
> >  	/*
> >  	 * Create a static mapping between the CSI virtual channels
> >  	 * and the output stream.
> > @@ -169,10 +286,21 @@ static int csi2rx_start(struct csi2rx_priv *csi2rx)
> >  	if (ret)
> >  		goto err_disable_pixclk;
> >  
> > +	if (csi2rx->dphy) {
> > +		ret = csi2rx_configure_external_dphy(csi2rx);
> > +		if (ret) {
> > +			dev_err(csi2rx->dev,
> > +				"Failed to configure external DPHY: %d\n", ret);
> > +			goto err_disable_sysclk;
> > +		}
> > +	}
> > +
> >  	clk_disable_unprepare(csi2rx->p_clk);
> >  
> >  	return 0;
> >  
> > +err_disable_sysclk:
> > +	clk_disable_unprepare(csi2rx->sys_clk);
> >  err_disable_pixclk:
> >  	for (; i > 0; i--)
> >  		clk_disable_unprepare(csi2rx->pixel_clk[i - 1]);
> > @@ -200,6 +328,13 @@ static void csi2rx_stop(struct csi2rx_priv *csi2rx)
> >  
> >  	if (v4l2_subdev_call(csi2rx->source_subdev, video, s_stream, false))
> >  		dev_warn(csi2rx->dev, "Couldn't disable our subdev\n");
> > +
> > +	if (csi2rx->dphy) {
> > +		writel(0, csi2rx->base + CSI2RX_DPHY_LANE_CTRL_REG);
> > +
> > +		if (phy_power_off(csi2rx->dphy))
> > +			dev_warn(csi2rx->dev, "Couldn't power off DPHY\n");
> > +	}
> >  }
> >  
> >  static int csi2rx_s_stream(struct v4l2_subdev *subdev, int enable)
> > @@ -306,15 +441,6 @@ static int csi2rx_get_resources(struct csi2rx_priv *csi2rx,
> >  		return PTR_ERR(csi2rx->dphy);
> >  	}
> >  
> > -	/*
> > -	 * FIXME: Once we'll have external D-PHY support, the check
> > -	 * will need to be removed.
> > -	 */
> > -	if (csi2rx->dphy) {
> > -		dev_err(&pdev->dev, "External D-PHY not supported yet\n");
> > -		return -EINVAL;
> > -	}
> > -
> >  	clk_prepare_enable(csi2rx->p_clk);
> >  	dev_cfg = readl(csi2rx->base + CSI2RX_DEVICE_CFG_REG);
> >  	clk_disable_unprepare(csi2rx->p_clk);
> > @@ -339,7 +465,7 @@ static int csi2rx_get_resources(struct csi2rx_priv *csi2rx,
> >  	 * FIXME: Once we'll have internal D-PHY support, the check
> >  	 * will need to be removed.
> >  	 */
> > -	if (csi2rx->has_internal_dphy) {
> > +	if (!csi2rx->dphy && csi2rx->has_internal_dphy) {
> >  		dev_err(&pdev->dev, "Internal D-PHY not supported yet\n");
> >  		return -EINVAL;
> >  	}
> > @@ -460,6 +586,7 @@ static int csi2rx_probe(struct platform_device *pdev)
> >  	dev_info(&pdev->dev,
> >  		 "Probed CSI2RX with %u/%u lanes, %u streams, %s D-PHY\n",
> >  		 csi2rx->num_lanes, csi2rx->max_lanes, csi2rx->max_streams,
> > +		 csi2rx->dphy ? "external" :
> >  		 csi2rx->has_internal_dphy ? "internal" : "no");
> >  
> >  	return 0;
> 

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
