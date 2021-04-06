Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC98355B3B
	for <lists+dmaengine@lfdr.de>; Tue,  6 Apr 2021 20:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234933AbhDFSXG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 6 Apr 2021 14:23:06 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40284 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233581AbhDFSXG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 6 Apr 2021 14:23:06 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 136IMeoX082857;
        Tue, 6 Apr 2021 13:22:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1617733360;
        bh=BzWzyZO4rBSdchh36bc8R6q6XB/FpsLa7H/7h3fCfO0=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=X+t6ct4nHTKTcKcqw+R6rdu5KTYzV85KeKcFNVubbT1CmpYr/QUqnSNEHd/aOZ4YR
         D32RV3F9n8liBYEzqbAOci/GAKpt43tu2BhHVcmlLS54Q9BZTsqXuKoVo6zoqFtLRj
         X+QnjppDCtLimSkB2QjLgKgxv/g15wFH/HPcKezg=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 136IMecG020113
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Apr 2021 13:22:40 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 6 Apr
 2021 13:22:40 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 6 Apr 2021 13:22:40 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 136IMdYM103701;
        Tue, 6 Apr 2021 13:22:39 -0500
Date:   Tue, 6 Apr 2021 23:52:38 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
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
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: Re: [PATCH 03/16] phy: cdns-dphy: Allow setting mode
Message-ID: <20210406182236.pal4o2nir6grmuir@ti.com>
References: <20210330173348.30135-1-p.yadav@ti.com>
 <20210330173348.30135-4-p.yadav@ti.com>
 <YGb0FSW5KRICftiK@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YGb0FSW5KRICftiK@pendragon.ideasonboard.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 02/04/21 01:38PM, Laurent Pinchart wrote:
> Hi Pratyush,
> 
> Thank you for the patch.
> 
> On Tue, Mar 30, 2021 at 11:03:35PM +0530, Pratyush Yadav wrote:
> > Allow callers to set the PHY mode. The main mode should always be
> > PHY_MODE_MIPI_DPHY but the submode can either be
> > PHY_MIPI_DPHY_SUBMODE_RX or PHY_MIPI_DPHY_SUBMODE_TX. Update the ops
> > based on the requested submode.
> 
> Isn't a given DPHY instance always meant to work in one particular mode
> ? I can't really imagine a single instance of this IP core being
> integrated in a way that it can be used in either RX or TX mode. It
> seems better to select the mode through DT, by describing if the DPHY is
> an RX or TX (possibly through different compatible strings).

I'm not sure if the DPHY can work in both RX and TX mode but the 
documentation for Cadence DPHY on J721E does include both RX and TX 
related registers. Also, take a look at [0] which says that the 
Allwinner A31 DPHY can work in both RX and TX mode. So apparently there 
are some DPHYs like that in the wild.

[0] https://lore.kernel.org/linux-arm-kernel/20201023174546.504028-3-paul.kocialkowski@bootlin.com/

> 
> > Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> > ---
> >  drivers/phy/cadence/cdns-dphy.c | 30 ++++++++++++++++++++++++++++++
> >  1 file changed, 30 insertions(+)
> > 
> > diff --git a/drivers/phy/cadence/cdns-dphy.c b/drivers/phy/cadence/cdns-dphy.c
> > index 8656f2102a91..7d5f7b333893 100644
> > --- a/drivers/phy/cadence/cdns-dphy.c
> > +++ b/drivers/phy/cadence/cdns-dphy.c
> > @@ -365,11 +365,41 @@ static int cdns_dphy_configure(struct phy *phy, union phy_configure_opts *opts)
> >  	return 0;
> >  }
> >  
> > +static int cdns_dphy_set_mode(struct phy *phy, enum phy_mode mode, int submode)
> > +{
> > +	struct cdns_dphy *dphy = phy_get_drvdata(phy);
> > +	const struct cdns_dphy_driver_data *ddata;
> > +
> > +	ddata = of_device_get_match_data(dphy->dev);
> > +	if (!ddata)
> > +		return -EINVAL;
> > +
> > +	if (mode != PHY_MODE_MIPI_DPHY)
> > +		return -EINVAL;
> > +
> > +	if (submode == PHY_MIPI_DPHY_SUBMODE_TX) {
> > +		if (!ddata->tx)
> > +			return -EOPNOTSUPP;
> > +
> > +		dphy->ops = ddata->tx;
> > +	} else if (submode == PHY_MIPI_DPHY_SUBMODE_RX) {
> > +		if (!ddata->rx)
> > +			return -EOPNOTSUPP;
> > +
> > +		dphy->ops = ddata->rx;
> > +	} else {
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static const struct phy_ops cdns_dphy_ops = {
> >  	.configure	= cdns_dphy_configure,
> >  	.validate	= cdns_dphy_validate,
> >  	.power_on	= cdns_dphy_power_on,
> >  	.power_off	= cdns_dphy_power_off,
> > +	.set_mode	= cdns_dphy_set_mode,
> >  };
> >  
> >  static int cdns_dphy_probe(struct platform_device *pdev)
> 
> -- 
> Regards,
> 
> Laurent Pinchart

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
