Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59CBC3500EA
	for <lists+dmaengine@lfdr.de>; Wed, 31 Mar 2021 15:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235646AbhCaNGi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 31 Mar 2021 09:06:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:46378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235461AbhCaNGN (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 31 Mar 2021 09:06:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9699760C41;
        Wed, 31 Mar 2021 13:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617195973;
        bh=Gv6lEJ0fn89KoyjqIPpCwCbRxnqQTj/4wgxCn1DsqVc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nwREw8fz3HaVl+ZPBbD6j9lstJa1hFwemniqrsKPXPq8DprocOSn7iqT7szpe7/Qr
         Qrpjxout4rmmXwEwVlD5weNdDenC7K9Jvu7+fyv/2s4CJAmXx4eUF61qHa0a7OHqw0
         gcN2oRIqtGwrFeuJEbWCMURAdFV+7lQoAhJTEbeXAP9GkQWGs2lMwJAl8NCrKncl5Y
         lv9CAZYU/EqDRaJdVIZLahGx164mPStZgFb4fV8necyXXOtGuf/WmNpQ7WUGkaq2lz
         MBLfI4J0m32wur93oG9qRerdjegoLb+z7N1BP1f8tUOVYglJ74JvzWUKHOOBaEGfvl
         I42O0udR2lKrQ==
Date:   Wed, 31 Mar 2021 18:36:09 +0530
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
Message-ID: <YGRzwboQ0sL/bAWU@vkoul-mobl.Dlink>
References: <20210330173348.30135-1-p.yadav@ti.com>
 <YGRB/42Q6aVBLoAq@vkoul-mobl.Dlink>
 <20210331114019.g4dnuhs2hno5fjdn@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331114019.g4dnuhs2hno5fjdn@ti.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 31-03-21, 17:10, Pratyush Yadav wrote:
> On 31/03/21 03:03PM, Vinod Koul wrote:
> > On 30-03-21, 23:03, Pratyush Yadav wrote:
> > > Hi,
> > > 
> > > This series adds support for CSI2 capture on J721E. It includes some
> > > fixes to the Cadence CSI2RX driver, adds Rx support to Cadence DPHY
> > > driver, and finally adds the TI CSI2RX wrapper driver.
> > > 
> > > Tested on TI's J721E with OV5640 sensor.
> > > 
> > > Paul Kocialkowski (1):
> > >   phy: Distinguish between Rx and Tx for MIPI D-PHY with submodes
> > > 
> > > Pratyush Yadav (15):
> > >   phy: cdns-dphy: Prepare for Rx support
> > >   phy: cdns-dphy: Allow setting mode
> > >   phy: cdns-dphy: Add Rx support
> > >   media: cadence: csi2rx: Add external DPHY support
> > >   media: cadence: csi2rx: Soft reset the streams before starting capture
> > >   media: cadence: csi2rx: Set the STOP bit when stopping a stream
> > >   media: cadence: csi2rx: Fix stream data configuration
> > >   media: cadence: csi2rx: Turn subdev power on before starting stream
> > >   media: cadence: csi2rx: Add wrappers for subdev calls
> > >   dmaengine: ti: k3-psil-j721e: Add entry for CSI2RX
> > >   dt-bindings: media: Add DT bindings for TI CSI2RX driver
> > >   media: ti-vpe: csi2rx: Add CSI2RX support
> > >   dt-bindings: phy: Convert Cadence DPHY binding to YAML
> > >   dt-bindings: phy: cdns,dphy: make clocks optional
> > >   dt-bindings: phy: cdns,dphy: add power-domains property
> > 
> > Is there any dependency between patches to various subsystems, if not
> > please do consider sending a series per subsystem...
> 
> Without patch 1, patch 5 and later won't build. Without patch 11, patch 
> 13 will not work.

Cover letter is a good place to mention this! And what do you mean by
not working, do we have compile time dependencies? I agree that for
everything to work all the pieces need to land

-- 
~Vinod
