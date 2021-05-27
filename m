Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 977E0392FBB
	for <lists+dmaengine@lfdr.de>; Thu, 27 May 2021 15:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236474AbhE0Nbe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 27 May 2021 09:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236441AbhE0Nbd (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 27 May 2021 09:31:33 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C3BC061760;
        Thu, 27 May 2021 06:30:00 -0700 (PDT)
Received: from [192.168.1.111] (91-157-208-71.elisa-laajakaista.fi [91.157.208.71])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 09864ED;
        Thu, 27 May 2021 15:29:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1622122199;
        bh=yR/grf3p5cSL4FQsJoHO8ZzmX5PWtfRjN/6uJPBLG88=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=NlhgSUinbel7MPx12HO9bd/P/4jf+w5eh2bVQ2Qb/bOL81/PiYqcuqnwoUWC8xBpV
         lLY0TaW80I6r5gwLIfhe0pfI6QQ5cfsg/luV8Nzpi+mjmKKM04fjvVV4bPTGG21R/4
         6wDQ9T5TnA0Vabmq1aCNx5XPkyw83FShlhn7doi4=
Subject: Re: [PATCH v2 13/18] media: ti: Add CSI2RX support for J721E
To:     Pratyush Yadav <p.yadav@ti.com>,
        Maxime Ripard <mripard@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Benoit Parrot <bparrot@ti.com>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, dmaengine@vger.kernel.org
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <20210526152308.16525-1-p.yadav@ti.com>
 <20210526152308.16525-14-p.yadav@ti.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Message-ID: <5e00444a-683f-b4fa-9156-4450ca4edaf6@ideasonboard.com>
Date:   Thu, 27 May 2021 16:29:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210526152308.16525-14-p.yadav@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Pratyush,

On 26/05/2021 18:23, Pratyush Yadav wrote:
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

I noticed that my test app didn't work at all with this, and I also 
wasn't able to use v4l2-ctl to set the format.

At least for my test app the problem was that this driver doesn't 
initialize the format at all. My app first calls VIDIOC_G_FMT with 
v4l2_format.type == V4L2_BUF_TYPE_VIDEO_CAPTURE, then after the call 
modifies the fields it wants to change and calls VIDIOC_S_FMT. This 
failed, as G_FMT returned uninitialized fmt, i.e. type was 0, which my 
app didn't set again.

I believe the driver should have an initial format, something that it 
will accept if an app calls G_FMT and then S_FMT.

  Tomi
