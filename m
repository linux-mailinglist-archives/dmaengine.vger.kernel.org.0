Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 068AA352A02
	for <lists+dmaengine@lfdr.de>; Fri,  2 Apr 2021 12:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbhDBK6m (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 2 Apr 2021 06:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhDBK6l (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 2 Apr 2021 06:58:41 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B220C0613E6;
        Fri,  2 Apr 2021 03:58:41 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 197672C1;
        Fri,  2 Apr 2021 12:58:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1617361119;
        bh=o16YH/amK93o9sUsyfCF2kW9i62zSal5yr6Wff73gGw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kx4XXqd3VRUrP3Velb+mNLGyx25fqfqRT0i3xkTijHxD4jxV+YpE4yGtyfMmY2iXp
         drld9qdcUOkJ4O3aBP43rV2dslhKBZiQzvhbBfZ4juJyF9VLMTzW30TumcZpXoCuxS
         W13lxx4pdwY0THf0JbG+xp/LM/qknhEt6GSuNKSk=
Date:   Fri, 2 Apr 2021 13:57:55 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Pratyush Yadav <p.yadav@ti.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
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
Subject: Re: [PATCH 00/16] CSI2RX support on J721E
Message-ID: <YGb4s1rSuZLr3Iv0@pendragon.ideasonboard.com>
References: <20210330173348.30135-1-p.yadav@ti.com>
 <YGRB/42Q6aVBLoAq@vkoul-mobl.Dlink>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YGRB/42Q6aVBLoAq@vkoul-mobl.Dlink>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Mar 31, 2021 at 03:03:51PM +0530, Vinod Koul wrote:
> On 30-03-21, 23:03, Pratyush Yadav wrote:
> > Hi,
> > 
> > This series adds support for CSI2 capture on J721E. It includes some
> > fixes to the Cadence CSI2RX driver, adds Rx support to Cadence DPHY
> > driver, and finally adds the TI CSI2RX wrapper driver.
> > 
> > Tested on TI's J721E with OV5640 sensor.
> > 
> > Paul Kocialkowski (1):
> >   phy: Distinguish between Rx and Tx for MIPI D-PHY with submodes
> > 
> > Pratyush Yadav (15):
> >   phy: cdns-dphy: Prepare for Rx support
> >   phy: cdns-dphy: Allow setting mode
> >   phy: cdns-dphy: Add Rx support
> >   media: cadence: csi2rx: Add external DPHY support
> >   media: cadence: csi2rx: Soft reset the streams before starting capture
> >   media: cadence: csi2rx: Set the STOP bit when stopping a stream
> >   media: cadence: csi2rx: Fix stream data configuration
> >   media: cadence: csi2rx: Turn subdev power on before starting stream
> >   media: cadence: csi2rx: Add wrappers for subdev calls
> >   dmaengine: ti: k3-psil-j721e: Add entry for CSI2RX
> >   dt-bindings: media: Add DT bindings for TI CSI2RX driver
> >   media: ti-vpe: csi2rx: Add CSI2RX support
> >   dt-bindings: phy: Convert Cadence DPHY binding to YAML
> >   dt-bindings: phy: cdns,dphy: make clocks optional
> >   dt-bindings: phy: cdns,dphy: add power-domains property
> 
> Is there any dependency between patches to various subsystems, if not
> please do consider sending a series per subsystem...

Splitting the series per subsystem will facilitate merging, but for the
first versions, keeping all patches together facilitate review. I'd
prefer if we could have a v2 that still includes everything, until we
agree on the interface between the two subsystems. At that point, we can
split the series if needed.

> > 
> >  .../devicetree/bindings/media/ti,csi2rx.yaml  |  70 ++
> >  .../devicetree/bindings/phy/cdns,dphy.txt     |  20 -
> >  .../devicetree/bindings/phy/cdns,dphy.yaml    |  52 +
> >  MAINTAINERS                                   |   7 +
> >  drivers/dma/ti/k3-psil-j721e.c                |  10 +
> >  drivers/media/platform/Kconfig                |  11 +
> >  drivers/media/platform/cadence/cdns-csi2rx.c  | 269 ++++-
> >  drivers/media/platform/ti-vpe/Makefile        |   1 +
> >  drivers/media/platform/ti-vpe/ti-csi2rx.c     | 964 ++++++++++++++++++
> >  drivers/phy/cadence/cdns-dphy.c               | 407 +++++++-
> >  include/linux/phy/phy-mipi-dphy.h             |  13 +
> >  11 files changed, 1754 insertions(+), 70 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/media/ti,csi2rx.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/phy/cdns,dphy.txt
> >  create mode 100644 Documentation/devicetree/bindings/phy/cdns,dphy.yaml
> >  create mode 100644 drivers/media/platform/ti-vpe/ti-csi2rx.c

-- 
Regards,

Laurent Pinchart
