Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 692DC3501B1
	for <lists+dmaengine@lfdr.de>; Wed, 31 Mar 2021 15:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235639AbhCaNvt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 31 Mar 2021 09:51:49 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:39568 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235758AbhCaNvo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 31 Mar 2021 09:51:44 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12VDpPqq005310;
        Wed, 31 Mar 2021 08:51:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1617198685;
        bh=se4kokRgl6S4irb4URqKn533vejtAJPSsq4RTXSyHrw=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=IShYWirWC6sj4KLKL2avRDilOY72Em5+dYvCt3jkzEbhfNLOOd+nKUGpluGm66vdt
         BTrKRPBtBW4S4YGksiq8VRdFzUnEK0QyYkXMOF32oyh+QsgfOt5o/RhO5gd7FAMVV8
         Ee+1N+QSwOOcdVi0Aokil/5pH0cx9Nj7aEbx4348=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12VDpPCp021318
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 31 Mar 2021 08:51:25 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 31
 Mar 2021 08:51:24 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 31 Mar 2021 08:51:24 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12VDpOXx129128;
        Wed, 31 Mar 2021 08:51:24 -0500
Date:   Wed, 31 Mar 2021 19:21:23 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
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
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: Re: [PATCH 00/16] CSI2RX support on J721E
Message-ID: <20210331135121.77qxxcpkyy6zm7kl@ti.com>
References: <20210330173348.30135-1-p.yadav@ti.com>
 <YGRB/42Q6aVBLoAq@vkoul-mobl.Dlink>
 <20210331114019.g4dnuhs2hno5fjdn@ti.com>
 <YGRzwboQ0sL/bAWU@vkoul-mobl.Dlink>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YGRzwboQ0sL/bAWU@vkoul-mobl.Dlink>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 31/03/21 06:36PM, Vinod Koul wrote:
> On 31-03-21, 17:10, Pratyush Yadav wrote:
> > On 31/03/21 03:03PM, Vinod Koul wrote:
> > > On 30-03-21, 23:03, Pratyush Yadav wrote:
> > > > Hi,
> > > > 
> > > > This series adds support for CSI2 capture on J721E. It includes some
> > > > fixes to the Cadence CSI2RX driver, adds Rx support to Cadence DPHY
> > > > driver, and finally adds the TI CSI2RX wrapper driver.
> > > > 
> > > > Tested on TI's J721E with OV5640 sensor.
> > > > 
> > > > Paul Kocialkowski (1):
> > > >   phy: Distinguish between Rx and Tx for MIPI D-PHY with submodes
> > > > 
> > > > Pratyush Yadav (15):
> > > >   phy: cdns-dphy: Prepare for Rx support
> > > >   phy: cdns-dphy: Allow setting mode
> > > >   phy: cdns-dphy: Add Rx support
> > > >   media: cadence: csi2rx: Add external DPHY support
> > > >   media: cadence: csi2rx: Soft reset the streams before starting capture
> > > >   media: cadence: csi2rx: Set the STOP bit when stopping a stream
> > > >   media: cadence: csi2rx: Fix stream data configuration
> > > >   media: cadence: csi2rx: Turn subdev power on before starting stream
> > > >   media: cadence: csi2rx: Add wrappers for subdev calls
> > > >   dmaengine: ti: k3-psil-j721e: Add entry for CSI2RX
> > > >   dt-bindings: media: Add DT bindings for TI CSI2RX driver
> > > >   media: ti-vpe: csi2rx: Add CSI2RX support
> > > >   dt-bindings: phy: Convert Cadence DPHY binding to YAML
> > > >   dt-bindings: phy: cdns,dphy: make clocks optional
> > > >   dt-bindings: phy: cdns,dphy: add power-domains property
> > > 
> > > Is there any dependency between patches to various subsystems, if not
> > > please do consider sending a series per subsystem...
> > 
> > Without patch 1, patch 5 and later won't build. Without patch 11, patch 
> > 13 will not work.
> 
> Cover letter is a good place to mention this! And what do you mean by
> not working, do we have compile time dependencies? I agree that for
> everything to work all the pieces need to land

I have not tried it but patch 11 is not a compile time dependency. It 
should be a run time dependency. Without it the driver will probably 
fail to acquire the DMA channels and its probe will fail.

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
