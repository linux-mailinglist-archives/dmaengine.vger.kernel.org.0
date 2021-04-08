Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDB91357DFC
	for <lists+dmaengine@lfdr.de>; Thu,  8 Apr 2021 10:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbhDHIXB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 8 Apr 2021 04:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhDHIXA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 8 Apr 2021 04:23:00 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B98C061760;
        Thu,  8 Apr 2021 01:22:49 -0700 (PDT)
Received: from [192.168.1.111] (91-157-208-71.elisa-laajakaista.fi [91.157.208.71])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2CDE356B;
        Thu,  8 Apr 2021 10:22:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1617870166;
        bh=9Y48FVCQ7OA5kE/6R3rADBnFYJauO/Gx6bLXLzC/EyE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=jrQyOxxUOZLlCK0woqbLVaPl6eeD0sPHAggGcfSrlPiV9aZ6m5dOaAeqOJrDb47Q9
         B+RIPlISPkgjlpRmQAQv92HY8/lPqH1K1t1w+QSxu7Qh8WCErc9Ua61LyRsiDEOUJr
         tOh3zpxAvCRa7h8S5aOLCOOSpOIM+CD2VvpFW9sY=
Subject: Re: [PATCH 05/16] media: cadence: csi2rx: Add external DPHY support
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Pratyush Yadav <p.yadav@ti.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
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
        Peter Chen <peter.chen@nxp.com>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, dmaengine@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>
References: <20210330173348.30135-1-p.yadav@ti.com>
 <20210330173348.30135-6-p.yadav@ti.com> <1617182653.2752.9.camel@mhfsdcap03>
 <20210406185439.6o5hkejtinq7y7sy@ti.com>
 <1617869638.10189.15.camel@mhfsdcap03>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Message-ID: <3553b46d-31a4-548b-af1a-12760d9dea9a@ideasonboard.com>
Date:   Thu, 8 Apr 2021 11:22:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1617869638.10189.15.camel@mhfsdcap03>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 08/04/2021 11:13, Chunfeng Yun wrote:
> On Wed, 2021-04-07 at 00:24 +0530, Pratyush Yadav wrote:
>> On 31/03/21 05:24PM, Chunfeng Yun wrote:
>>> On Tue, 2021-03-30 at 23:03 +0530, Pratyush Yadav wrote:
>>>> Some platforms like TI's J721E can have the CSI2RX paired with an
>>>> external DPHY. Add support to enable and configure the DPHY using the
>>>> generic PHY framework.
>>>>
>>>> Get the pixel rate and bpp from the subdev and pass them on to the DPHY
>>>> along with the number of lanes. All other settings are left to their
>>>> default values.
>>>>
>>>> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
>>>> ---
>>>>   drivers/media/platform/cadence/cdns-csi2rx.c | 147 +++++++++++++++++--
>>>>   1 file changed, 137 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
>>>> index c68a3eac62cd..31bd80e3f780 100644
>>>> --- a/drivers/media/platform/cadence/cdns-csi2rx.c
>>>> +++ b/drivers/media/platform/cadence/cdns-csi2rx.c
>>>> @@ -30,6 +30,12 @@
>>>>   #define CSI2RX_STATIC_CFG_DLANE_MAP(llane, plane)	((plane) << (16 + (llane) * 4))
>>>>   #define CSI2RX_STATIC_CFG_LANES_MASK			GENMASK(11, 8)
>>>>   
>>>> +#define CSI2RX_DPHY_LANE_CTRL_REG		0x40
>>>> +#define CSI2RX_DPHY_CL_RST			BIT(16)
>>>> +#define CSI2RX_DPHY_DL_RST(i)			BIT((i) + 12)
>>>> +#define CSI2RX_DPHY_CL_EN			BIT(4)
>>>> +#define CSI2RX_DPHY_DL_EN(i)			BIT(i)
>>>> +
>>>>   #define CSI2RX_STREAM_BASE(n)		(((n) + 1) * 0x100)
>>>>   
>>>>   #define CSI2RX_STREAM_CTRL_REG(n)		(CSI2RX_STREAM_BASE(n) + 0x000)
>>>> @@ -54,6 +60,11 @@ enum csi2rx_pads {
>>>>   	CSI2RX_PAD_MAX,
>>>>   };
>>>>   
>>>> +struct csi2rx_fmt {
>>>> +	u32				code;
>>>> +	u8				bpp;
>>>> +};
>>>> +
>>>>   struct csi2rx_priv {
>>>>   	struct device			*dev;
>>>>   	unsigned int			count;
>>>> @@ -85,6 +96,52 @@ struct csi2rx_priv {
>>>>   	int				source_pad;
>>>>   };
>>>>   
>>>> +static const struct csi2rx_fmt formats[] = {
>>>> +	{
>>>> +		.code	= MEDIA_BUS_FMT_YUYV8_2X8,
>>>> +		.bpp	= 16,
>>>> +	},
>>>> +	{
>>>> +		.code	= MEDIA_BUS_FMT_UYVY8_2X8,
>>>> +		.bpp	= 16,
>>>> +	},
>>>> +	{
>>>> +		.code	= MEDIA_BUS_FMT_YVYU8_2X8,
>>>> +		.bpp	= 16,
>>>> +	},
>>>> +	{
>>>> +		.code	= MEDIA_BUS_FMT_VYUY8_2X8,
>>>> +		.bpp	= 16,
>>>> +	},
>>>> +};
>>>> +
>>>> +static u8 csi2rx_get_bpp(u32 code)
>>>> +{
>>>> +	int i;
>>>> +
>>>> +	for (i = 0; i < ARRAY_SIZE(formats); i++) {
>>>> +		if (formats[i].code == code)
>>>> +			return formats[i].bpp;
>>>> +	}
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static s64 csi2rx_get_pixel_rate(struct csi2rx_priv *csi2rx)
>>>> +{
>>>> +	struct v4l2_ctrl *ctrl;
>>>> +
>>>> +	ctrl = v4l2_ctrl_find(csi2rx->source_subdev->ctrl_handler,
>>>> +			      V4L2_CID_PIXEL_RATE);
>>>> +	if (!ctrl) {
>>>> +		dev_err(csi2rx->dev, "no pixel rate control in subdev: %s\n",
>>>> +			csi2rx->source_subdev->name);
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +	return v4l2_ctrl_g_ctrl_int64(ctrl);
>>>> +}
>>>> +
>>>>   static inline
>>>>   struct csi2rx_priv *v4l2_subdev_to_csi2rx(struct v4l2_subdev *subdev)
>>>>   {
>>>> @@ -101,6 +158,55 @@ static void csi2rx_reset(struct csi2rx_priv *csi2rx)
>>>>   	writel(0, csi2rx->base + CSI2RX_SOFT_RESET_REG);
>>>>   }
>>>>   
>>>> +static int csi2rx_configure_external_dphy(struct csi2rx_priv *csi2rx)
>>>> +{
>>>> +	union phy_configure_opts opts = { };
>>>> +	struct phy_configure_opts_mipi_dphy *cfg = &opts.mipi_dphy;
>>>> +	struct v4l2_subdev_format sd_fmt;
>>>> +	s64 pixel_rate;
>>>> +	int ret;
>>>> +	u8 bpp;
>>>> +
>>>> +	sd_fmt.which = V4L2_SUBDEV_FORMAT_ACTIVE;
>>>> +	sd_fmt.pad = 0;
>>>> +
>>>> +	ret = v4l2_subdev_call(csi2rx->source_subdev, pad, get_fmt, NULL,
>>>> +			       &sd_fmt);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	bpp = csi2rx_get_bpp(sd_fmt.format.code);
>>>> +	if (!bpp)
>>>> +		return -EINVAL;
>>>> +
>>>> +	pixel_rate = csi2rx_get_pixel_rate(csi2rx);
>>>> +	if (pixel_rate < 0)
>>>> +		return pixel_rate;
>>>> +
>>>> +	ret = phy_mipi_dphy_get_default_config(pixel_rate, bpp,
>>>> +					       csi2rx->num_lanes, cfg);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	ret = phy_set_mode_ext(csi2rx->dphy, PHY_MODE_MIPI_DPHY,
>>>> +			       PHY_MIPI_DPHY_SUBMODE_RX);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	ret = phy_power_on(csi2rx->dphy);
>>>> +	if (ret)
>>>> +		return ret;
>>> Seems phy_power_on, then phy_set_mode_ext?
>>
>> Shouldn't the mode be set before the PHY is powered on so the correct
>> power on procedure can be performed based on the mode of operation?
> Of course, it is fine for cnds-dphy.
> But it depends on HW design and also phy driver;
> if the mode is controlled in PHY IP register, we can't access it before
> phy_power_on if no phy_init called (e.g. clock/power is not enabled).
> 
> Just let you pay attention on the phy sequence.

I don't think the phy configuration should depend on phy_power_on, but 
the runtime PM.

I guess this could be solved with:

phy_pm_runtime_get_sync();
phy_set_mode_ext();
phy_power_on();
phy_pm_runtime_put();

  Tomi
