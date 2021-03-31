Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A53834F881
	for <lists+dmaengine@lfdr.de>; Wed, 31 Mar 2021 08:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233653AbhCaGG4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 31 Mar 2021 02:06:56 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:53490 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhCaGGk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 31 Mar 2021 02:06:40 -0400
Received: from [192.168.1.111] (91-157-208-71.elisa-laajakaista.fi [91.157.208.71])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 801F38DA;
        Wed, 31 Mar 2021 08:06:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1617170797;
        bh=VILbDV1g0gxNqONJ/YaXNqbdVu6oy81uJAYmz2A735k=;
        h=To:Cc:References:From:Subject:Date:In-Reply-To:From;
        b=Zp00r5q6OLXWjlSuXKr+hxYs0jNggnJa6qp4kkhVrgkOaL2nBl7oG2OcAL+w03Xgd
         37Ohb1Si1LYdjkshfbgFZGdAFIhDYTLyD9z7odYtbc2DphDpHkgh0N/ABFSz4w1b7E
         OpKx+5OplgF7UtIBMfX2e8RfT7flEyA6j1aEpswQ=
To:     Pratyush Yadav <p.yadav@ti.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
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
        Peter Chen <peter.chen@nxp.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        dmaengine@vger.kernel.org
Cc:     Vignesh Raghavendra <vigneshr@ti.com>
References: <20210330173348.30135-1-p.yadav@ti.com>
 <20210330173348.30135-14-p.yadav@ti.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: Re: [PATCH 13/16] media: ti-vpe: csi2rx: Add CSI2RX support
Message-ID: <91bbf2a9-9d27-7f9b-1c17-ad6544a828f1@ideasonboard.com>
Date:   Wed, 31 Mar 2021 09:06:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210330173348.30135-14-p.yadav@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

On 30/03/2021 20:33, Pratyush Yadav wrote:
> TI's J721E uses the Cadence CSI2RX and DPHY peripherals to facilitate
> capture over a CSI-2 bus.
> 
> The Cadence CSI2RX IP acts as a bridge between the TI specific parts and
> the CSI-2 protocol parts. TI then has a wrapper on top of this bridge
> called the SHIM layer. It takes in data from stream 0, repacks it, and
> sends it to memory over PSI-L DMA.
> 
> This driver acts as the "front end" to V4L2 client applications. It
> implements the required ioctls and buffer operations, passes the
> necessary calls on to the bridge, programs the SHIM layer, and performs
> DMA via the dmaengine API to finally return the data to a buffer
> supplied by the application.
> 
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> ---
>   MAINTAINERS                               |   7 +
>   drivers/media/platform/Kconfig            |  11 +
>   drivers/media/platform/ti-vpe/Makefile    |   1 +
>   drivers/media/platform/ti-vpe/ti-csi2rx.c | 964 ++++++++++++++++++++++
>   4 files changed, 983 insertions(+)
>   create mode 100644 drivers/media/platform/ti-vpe/ti-csi2rx.c

Some quick comments:

"ti-vpe" directory is not correct, this has nothing to do with VPE. That 
said, the directory has already been abused by having CAL driver there, 
perhaps we should rename the directory just to "ti". But if we do that, 
I think we should have subdirs for cal, vpe and this new one.

"ti-csi2rx" is rather generic name. TI has had CSI-2 RX IPs before (CAL) 
and probably will also have new ones in the future. If there's no clear 
model name for the IP, as I think is the case here, it's probably best 
to just use the SoC model in the name. E.g. the DSS on J7 is "ti,j721e-dss".

This driver implements the legacy video API. I think it would be better 
(and easier to maintain) to only implement the media-controller API, 
unless you specifically need to support the legacy API for existing 
userspace.

  Tomi
