Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDFC239B45E
	for <lists+dmaengine@lfdr.de>; Fri,  4 Jun 2021 09:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbhFDH4A (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 4 Jun 2021 03:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbhFDHz7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 4 Jun 2021 03:55:59 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8932C06174A;
        Fri,  4 Jun 2021 00:54:13 -0700 (PDT)
Received: from [192.168.1.111] (91-157-208-71.elisa-laajakaista.fi [91.157.208.71])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C29CDA52;
        Fri,  4 Jun 2021 09:54:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1622793250;
        bh=ID6cE11tXic6xVbni7ARCJyiry3HhzMUrxQrto7JjFY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ZgV/h2AydYDNQILNmqxagvf+go0bZ9gvQFYXka1bTME7wwrFP02SaahMt6qaIBcPT
         MSaD+4eMtDy4/IBWzNm7hA2tUGTRVO52j19HARsjxG8jy37yNX7fs0IhG+SVW1TikK
         5t7fyV5TLYUMnzmgNSrelPW1q9dvHcubb1KYxw0w=
Subject: Re: [PATCH v2 00/18] CSI2RX support on J721E
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
 <83bcd60a-2a45-59b2-8ebe-26ad5d828965@ideasonboard.com>
 <20210603125251.nmzibyvfzkkxfbtj@ti.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Message-ID: <5f837a2d-69ba-ff43-1a8d-f7b975eeacdb@ideasonboard.com>
Date:   Fri, 4 Jun 2021 10:54:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210603125251.nmzibyvfzkkxfbtj@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 03/06/2021 15:52, Pratyush Yadav wrote:
> On 27/05/21 04:23PM, Tomi Valkeinen wrote:
>> Hi Pratyush,
>>
>> On 26/05/2021 18:22, Pratyush Yadav wrote:
>>> Hi,
>>>
>>> This series adds support for CSI2 capture on J721E. It includes some
>>> fixes to the Cadence CSI2RX driver, adds Rx support to Cadence DPHY
>>> driver, and finally adds the TI CSI2RX wrapper driver.
>>>
>>> Tested on TI's J721E with OV5640 sensor.
>>
>> I also see this after a few captures:
> 
> Can you share the application/command you are using to test? I used
> yavta to test and didn't see any problems after leaving the stream on
> for around 10 minutes.

You need to have CONFIG_DMA_API_DEBUG enabled. I think that's not 
enabled by default on TI configs.

  Tomi
