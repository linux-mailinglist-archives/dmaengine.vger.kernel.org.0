Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2868E393DF0
	for <lists+dmaengine@lfdr.de>; Fri, 28 May 2021 09:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234984AbhE1Hc1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 28 May 2021 03:32:27 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:34966 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233521AbhE1Hc0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 28 May 2021 03:32:26 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14S7UgnD058131;
        Fri, 28 May 2021 02:30:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1622187042;
        bh=fj4Wg8bYjClk+uZVckvh5wq3SzIHk7KlPEgUX57pBc0=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=ezAlq8j4AgctHcmSNqvIn36/UwqAcwkBl784CkkIqrM2opxWrbSntXwFUnQigMXml
         cuItzLWUA7l+94V3awdTZpwDSlGq5XX7Pyw3sQdm5eKT0DieL6IWZwD1C1paHji757
         469inA1ueAdlWUBpi1j62b0eZg7uVl+cq2qjvaa0=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14S7UgKp016239
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 May 2021 02:30:42 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 28
 May 2021 02:30:41 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 28 May 2021 02:30:41 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14S7UeWl051413;
        Fri, 28 May 2021 02:30:41 -0500
Date:   Fri, 28 May 2021 13:00:40 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
CC:     Maxime Ripard <mripard@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Benoit Parrot <bparrot@ti.com>, <linux-media@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <dmaengine@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v2 06/18] media: cadence: csi2rx: Add external DPHY
 support
Message-ID: <20210528073038.thoqbug5l76cyk7y@ti.com>
References: <20210526152308.16525-1-p.yadav@ti.com>
 <20210526152308.16525-7-p.yadav@ti.com>
 <cebc1dc8-3e7a-16d2-a59a-6963f5886b64@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cebc1dc8-3e7a-16d2-a59a-6963f5886b64@ideasonboard.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 28/05/21 10:23AM, Tomi Valkeinen wrote:
> On 26/05/2021 18:22, Pratyush Yadav wrote:
> > Some platforms like TI's J721E can have the CSI2RX paired with an
> > external DPHY. Add support to enable and configure the DPHY using the
> > generic PHY framework.
> > 
> > Get the pixel rate and bpp from the subdev and pass them on to the DPHY
> > along with the number of lanes. All other settings are left to their
> > default values.
> > 
> > Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> > 
> > ---
> > 
> > Changes in v2:
> > - Use phy_pm_runtime_get_sync() and phy_pm_runtime_put() before making
> >    calls to set PHY mode, etc. to make sure it is ready.
> > 
> >   drivers/media/platform/cadence/cdns-csi2rx.c | 158 +++++++++++++++++--
> >   1 file changed, 148 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
> > index c68a3eac62cd..459326de2eff 100644
> > --- a/drivers/media/platform/cadence/cdns-csi2rx.c
> > +++ b/drivers/media/platform/cadence/cdns-csi2rx.c
> > @@ -30,6 +30,12 @@
> >   #define CSI2RX_STATIC_CFG_DLANE_MAP(llane, plane)	((plane) << (16 + (llane) * 4))
> >   #define CSI2RX_STATIC_CFG_LANES_MASK			GENMASK(11, 8)
> > +#define CSI2RX_DPHY_LANE_CTRL_REG		0x40
> > +#define CSI2RX_DPHY_CL_RST			BIT(16)
> > +#define CSI2RX_DPHY_DL_RST(i)			BIT((i) + 12)
> > +#define CSI2RX_DPHY_CL_EN			BIT(4)
> > +#define CSI2RX_DPHY_DL_EN(i)			BIT(i)
> > +
> >   #define CSI2RX_STREAM_BASE(n)		(((n) + 1) * 0x100)
> >   #define CSI2RX_STREAM_CTRL_REG(n)		(CSI2RX_STREAM_BASE(n) + 0x000)
> > @@ -54,6 +60,11 @@ enum csi2rx_pads {
> >   	CSI2RX_PAD_MAX,
> >   };
> > +struct csi2rx_fmt {
> > +	u32				code;
> > +	u8				bpp;
> > +};
> > +
> >   struct csi2rx_priv {
> >   	struct device			*dev;
> >   	unsigned int			count;
> > @@ -85,6 +96,52 @@ struct csi2rx_priv {
> >   	int				source_pad;
> >   };
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
> >   static inline
> >   struct csi2rx_priv *v4l2_subdev_to_csi2rx(struct v4l2_subdev *subdev)
> >   {
> > @@ -101,6 +158,66 @@ static void csi2rx_reset(struct csi2rx_priv *csi2rx)
> >   	writel(0, csi2rx->base + CSI2RX_SOFT_RESET_REG);
> >   }
> > +static int csi2rx_configure_external_dphy(struct csi2rx_priv *csi2rx)
> > +{
> > +	union phy_configure_opts opts = { };
> > +	struct phy_configure_opts_mipi_dphy *cfg = &opts.mipi_dphy;
> > +	struct v4l2_subdev_format sd_fmt;
> > +	s64 pixel_rate;
> > +	int ret;
> > +	u8 bpp;
> > +	bool got_pm = true;
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
> 
> I guess the above code works for now, but with multiple streams it won't.
> There's no (single) pixel rate or bpp with multiple streams, and the link
> freq is the one that needs to be used. There's v4l2_get_link_freq() helper
> which makes it easier to support both pixel rate and link freq.

Ok. I will use it instead. The less changes needed when adding 
multistream support the better.

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
