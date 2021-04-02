Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5993529D7
	for <lists+dmaengine@lfdr.de>; Fri,  2 Apr 2021 12:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234207AbhDBKjA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 2 Apr 2021 06:39:00 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:45166 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhDBKjA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 2 Apr 2021 06:39:00 -0400
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 971302C1;
        Fri,  2 Apr 2021 12:38:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1617359937;
        bh=sZR3sSwoDUoM230emJjHnzx6XJSMp3h9iknmHtUO+6o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PnzgGaeI8fPjY7zLqQdiAZL2gQRYwL1i95ib4yqkJ7OKrubESUo8UW3CMttNCmK29
         ntUF9VYXsSqRUcUemNLmlWBwgd/RamQ8IbN2Z8g5To+DevHUPaBzPEbhKHxmtp49aZ
         /cEt+POVga0378zGBuzX4DijdKe1QJXTZ8YYaSLc=
Date:   Fri, 2 Apr 2021 13:38:13 +0300
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
Subject: Re: [PATCH 03/16] phy: cdns-dphy: Allow setting mode
Message-ID: <YGb0FSW5KRICftiK@pendragon.ideasonboard.com>
References: <20210330173348.30135-1-p.yadav@ti.com>
 <20210330173348.30135-4-p.yadav@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210330173348.30135-4-p.yadav@ti.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Pratyush,

Thank you for the patch.

On Tue, Mar 30, 2021 at 11:03:35PM +0530, Pratyush Yadav wrote:
> Allow callers to set the PHY mode. The main mode should always be
> PHY_MODE_MIPI_DPHY but the submode can either be
> PHY_MIPI_DPHY_SUBMODE_RX or PHY_MIPI_DPHY_SUBMODE_TX. Update the ops
> based on the requested submode.

Isn't a given DPHY instance always meant to work in one particular mode
? I can't really imagine a single instance of this IP core being
integrated in a way that it can be used in either RX or TX mode. It
seems better to select the mode through DT, by describing if the DPHY is
an RX or TX (possibly through different compatible strings).

> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> ---
>  drivers/phy/cadence/cdns-dphy.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/drivers/phy/cadence/cdns-dphy.c b/drivers/phy/cadence/cdns-dphy.c
> index 8656f2102a91..7d5f7b333893 100644
> --- a/drivers/phy/cadence/cdns-dphy.c
> +++ b/drivers/phy/cadence/cdns-dphy.c
> @@ -365,11 +365,41 @@ static int cdns_dphy_configure(struct phy *phy, union phy_configure_opts *opts)
>  	return 0;
>  }
>  
> +static int cdns_dphy_set_mode(struct phy *phy, enum phy_mode mode, int submode)
> +{
> +	struct cdns_dphy *dphy = phy_get_drvdata(phy);
> +	const struct cdns_dphy_driver_data *ddata;
> +
> +	ddata = of_device_get_match_data(dphy->dev);
> +	if (!ddata)
> +		return -EINVAL;
> +
> +	if (mode != PHY_MODE_MIPI_DPHY)
> +		return -EINVAL;
> +
> +	if (submode == PHY_MIPI_DPHY_SUBMODE_TX) {
> +		if (!ddata->tx)
> +			return -EOPNOTSUPP;
> +
> +		dphy->ops = ddata->tx;
> +	} else if (submode == PHY_MIPI_DPHY_SUBMODE_RX) {
> +		if (!ddata->rx)
> +			return -EOPNOTSUPP;
> +
> +		dphy->ops = ddata->rx;
> +	} else {
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
> +}
> +
>  static const struct phy_ops cdns_dphy_ops = {
>  	.configure	= cdns_dphy_configure,
>  	.validate	= cdns_dphy_validate,
>  	.power_on	= cdns_dphy_power_on,
>  	.power_off	= cdns_dphy_power_off,
> +	.set_mode	= cdns_dphy_set_mode,
>  };
>  
>  static int cdns_dphy_probe(struct platform_device *pdev)

-- 
Regards,

Laurent Pinchart
