Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4196434FCF8
	for <lists+dmaengine@lfdr.de>; Wed, 31 Mar 2021 11:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234836AbhCaJeX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 31 Mar 2021 05:34:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:49082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234707AbhCaJd4 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 31 Mar 2021 05:33:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8C1C7619F0;
        Wed, 31 Mar 2021 09:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617183235;
        bh=nO6ttpQXe+OeRL88ACEvx2io7aYwd7vnwQG1o0nC6Gw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h/JuXQ8QMS62JOS9+ByXnOqyzOo1u3p8/2y0FqKbbBkFG6wtSSRN6I1ayMSxygk3j
         qldKxHUcR0scfwhsSdITKQ7+94rabU11oLcDAa1BiNj+WKDU6v94KuqL/+hOp43z3q
         gQFfkJSlxy9axVYovQHURUYVgGQ91TetD/7hoDBWL3651g2Ipd0r0N5eqyDblVv5jt
         QKCzfa6PyBL78BiutkrA8CljFwSwXHv1OCDCjsOFYera4llrAZ/r++C8x7oLnie10+
         M5/ucomuSVbT3yqgBpg6NrNhKbc6VLYxhZMXzzifGCYvRuXL5JN8CanH/SizY8lZi0
         MCw/bOOFpQPWQ==
Date:   Wed, 31 Mar 2021 15:03:51 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Benoit Parrot <bparrot@ti.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Alexandre Courbot <acourbot@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
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
Message-ID: <YGRB/42Q6aVBLoAq@vkoul-mobl.Dlink>
References: <20210330173348.30135-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330173348.30135-1-p.yadav@ti.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 30-03-21, 23:03, Pratyush Yadav wrote:
> Hi,
> 
> This series adds support for CSI2 capture on J721E. It includes some
> fixes to the Cadence CSI2RX driver, adds Rx support to Cadence DPHY
> driver, and finally adds the TI CSI2RX wrapper driver.
> 
> Tested on TI's J721E with OV5640 sensor.
> 
> Paul Kocialkowski (1):
>   phy: Distinguish between Rx and Tx for MIPI D-PHY with submodes
> 
> Pratyush Yadav (15):
>   phy: cdns-dphy: Prepare for Rx support
>   phy: cdns-dphy: Allow setting mode
>   phy: cdns-dphy: Add Rx support
>   media: cadence: csi2rx: Add external DPHY support
>   media: cadence: csi2rx: Soft reset the streams before starting capture
>   media: cadence: csi2rx: Set the STOP bit when stopping a stream
>   media: cadence: csi2rx: Fix stream data configuration
>   media: cadence: csi2rx: Turn subdev power on before starting stream
>   media: cadence: csi2rx: Add wrappers for subdev calls
>   dmaengine: ti: k3-psil-j721e: Add entry for CSI2RX
>   dt-bindings: media: Add DT bindings for TI CSI2RX driver
>   media: ti-vpe: csi2rx: Add CSI2RX support
>   dt-bindings: phy: Convert Cadence DPHY binding to YAML
>   dt-bindings: phy: cdns,dphy: make clocks optional
>   dt-bindings: phy: cdns,dphy: add power-domains property

Is there any dependency between patches to various subsystems, if not
please do consider sending a series per subsystem...

Thanks


> 
>  .../devicetree/bindings/media/ti,csi2rx.yaml  |  70 ++
>  .../devicetree/bindings/phy/cdns,dphy.txt     |  20 -
>  .../devicetree/bindings/phy/cdns,dphy.yaml    |  52 +
>  MAINTAINERS                                   |   7 +
>  drivers/dma/ti/k3-psil-j721e.c                |  10 +
>  drivers/media/platform/Kconfig                |  11 +
>  drivers/media/platform/cadence/cdns-csi2rx.c  | 269 ++++-
>  drivers/media/platform/ti-vpe/Makefile        |   1 +
>  drivers/media/platform/ti-vpe/ti-csi2rx.c     | 964 ++++++++++++++++++
>  drivers/phy/cadence/cdns-dphy.c               | 407 +++++++-
>  include/linux/phy/phy-mipi-dphy.h             |  13 +
>  11 files changed, 1754 insertions(+), 70 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/media/ti,csi2rx.yaml
>  delete mode 100644 Documentation/devicetree/bindings/phy/cdns,dphy.txt
>  create mode 100644 Documentation/devicetree/bindings/phy/cdns,dphy.yaml
>  create mode 100644 drivers/media/platform/ti-vpe/ti-csi2rx.c
> 
> --
> 2.30.0

-- 
~Vinod
