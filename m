Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A90A339B48C
	for <lists+dmaengine@lfdr.de>; Fri,  4 Jun 2021 10:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhFDIGS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 4 Jun 2021 04:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbhFDIGS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 4 Jun 2021 04:06:18 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20FFC06174A;
        Fri,  4 Jun 2021 01:04:32 -0700 (PDT)
Received: from [192.168.1.111] (91-157-208-71.elisa-laajakaista.fi [91.157.208.71])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 20039A52;
        Fri,  4 Jun 2021 10:04:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1622793871;
        bh=j1SXMbUoe/8w0rZ6UdZfNhuo9qc6ocoxoJrTdQSBoU0=;
        h=To:Cc:References:From:Subject:Date:In-Reply-To:From;
        b=NNsF2Qc6TuwHZ1QwuxlAt3dWSJMADIbpLyeKjMAaTOQxq2XiyGUBVurqN218ePdZK
         2YJwDUslifIOVMLazpGhUZn5VwmWXmkrVmS8vgqO88+NV3Y11jWrC+k1i37UV8oBif
         2DlZlXlr9W6tCyT5C30McrP1EHCXS0awnpACQbEQ=
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Benoit Parrot <bparrot@ti.com>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, dmaengine@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <20210526152308.16525-1-p.yadav@ti.com>
 <20210526152308.16525-14-p.yadav@ti.com>
 <5e00444a-683f-b4fa-9156-4450ca4edaf6@ideasonboard.com>
 <20210603124920.5o34klhlhjg5phlj@ti.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: Re: [PATCH v2 13/18] media: ti: Add CSI2RX support for J721E
Message-ID: <b930c6e5-1210-5b13-2e29-25ffaa99519d@ideasonboard.com>
Date:   Fri, 4 Jun 2021 11:04:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210603124920.5o34klhlhjg5phlj@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 03/06/2021 15:49, Pratyush Yadav wrote:
> On 27/05/21 04:29PM, Tomi Valkeinen wrote:
>> Hi Pratyush,
>>
>> On 26/05/2021 18:23, Pratyush Yadav wrote:
>>> TI's J721E uses the Cadence CSI2RX and DPHY peripherals to facilitate
>>> capture over a CSI-2 bus.
>>>
>>> The Cadence CSI2RX IP acts as a bridge between the TI specific parts and
>>> the CSI-2 protocol parts. TI then has a wrapper on top of this bridge
>>> called the SHIM layer. It takes in data from stream 0, repacks it, and
>>> sends it to memory over PSI-L DMA.
>>>
>>> This driver acts as the "front end" to V4L2 client applications. It
>>> implements the required ioctls and buffer operations, passes the
>>> necessary calls on to the bridge, programs the SHIM layer, and performs
>>> DMA via the dmaengine API to finally return the data to a buffer
>>> supplied by the application.
>>>
>>> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
>>
>> I noticed that my test app didn't work at all with this, and I also wasn't
>> able to use v4l2-ctl to set the format.
> 
> I have not used v4l2-ctl, but I can see yavta works fine. What command
> did you use for setting format via v4l2-ctl?
> 
>>
>> At least for my test app the problem was that this driver doesn't initialize
>> the format at all. My app first calls VIDIOC_G_FMT with v4l2_format.type ==
>> V4L2_BUF_TYPE_VIDEO_CAPTURE, then after the call modifies the fields it
>> wants to change and calls VIDIOC_S_FMT. This failed, as G_FMT returned
>> uninitialized fmt, i.e. type was 0, which my app didn't set again.
>>
>> I believe the driver should have an initial format, something that it will
>> accept if an app calls G_FMT and then S_FMT.
> 
> Right. This is a bug. The question is what should the initial format be?
> It is more or less arbitrary since there is no configuration made yet
> and we don't know what the camera can or will send. So for example, what
> if I use UYVY 640x480? The camera might not support it at all. Is it
> still OK to have it as the default?

I think it doesn't really matter what the initial format is, as long as 
it's valid for the subdev itself. There are two separate things:

1) Subdev config, where the subdev is considered independently from the 
other subdevs. E.g. the formats in the input pads and output pads should 
be valid, taking into account the capabilities of the subdev. The subdev 
driver has to take care of these, i.e. if the user sets a format on a 
pad, the driver must adjust the other pads (if needed) to keep the 
subdev config valid.

2) pipeline validation, where all the subdevs in the pipeline are looked 
at and validated that the settings are compatible.

We're talking about 1) here, and it doesn't matter if the camera 
supports the csirx initial format or not.

  Tomi
