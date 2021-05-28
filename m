Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 581F0393DFC
	for <lists+dmaengine@lfdr.de>; Fri, 28 May 2021 09:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235781AbhE1HhL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 28 May 2021 03:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234393AbhE1Hgy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 28 May 2021 03:36:54 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C0FC061574;
        Fri, 28 May 2021 00:35:14 -0700 (PDT)
Received: from [192.168.1.111] (91-157-208-71.elisa-laajakaista.fi [91.157.208.71])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 225F58C7;
        Fri, 28 May 2021 09:35:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1622187313;
        bh=v59I+aspDAoguV3+zhGsiwb5BmCSVCIir5aArBl3q8A=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=uK7HMacL1qIMoVO4F8224jwEhBdmXzpVqgmoUuTF1ul/7nr9bNUf/jP9PkCSsuNHP
         Yy5pgtd7DZ6ndlF0gppvq6d6+mUW5Sm9nhfi4Z1R4tTQuSiIWzTb5bDpsbXfgq+3ZS
         dD/BI6WOtL1f/Qk2sKSs2HrBkiyRN5I2uFW0NHro=
Subject: Re: [PATCH v2 10/18] media: cadence: csi2rx: Populate subdev devnode
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
 <20210526152308.16525-11-p.yadav@ti.com>
 <9c38a72c-18e8-1e54-b3b4-85ff5d47857a@ideasonboard.com>
 <20210528072401.2vdrtjdiepnr72vv@ti.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Message-ID: <e36baf77-6de8-595d-b440-92bcfcdd8467@ideasonboard.com>
Date:   Fri, 28 May 2021 10:35:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210528072401.2vdrtjdiepnr72vv@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 28/05/2021 10:24, Pratyush Yadav wrote:
> On 28/05/21 10:16AM, Tomi Valkeinen wrote:
>> On 26/05/2021 18:23, Pratyush Yadav wrote:
>>> The devnode can be used by media-ctl and other userspace tools to
>>> perform configurations on the subdev. Without it, media-ctl returns
>>> ENOENT when setting format on the sensor subdev.
>>>
>>> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
>>> ---
>>>
>>> (no changes since v1)
>>>
>>>    drivers/media/platform/cadence/cdns-csi2rx.c | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
>>> index 1df21f462f3c..49bed63d5faa 100644
>>> --- a/drivers/media/platform/cadence/cdns-csi2rx.c
>>> +++ b/drivers/media/platform/cadence/cdns-csi2rx.c
>>> @@ -613,6 +613,7 @@ static int csi2rx_probe(struct platform_device *pdev)
>>>    	csi2rx->pads[CSI2RX_PAD_SINK].flags = MEDIA_PAD_FL_SINK;
>>>    	for (i = CSI2RX_PAD_SOURCE_STREAM0; i < CSI2RX_PAD_MAX; i++)
>>>    		csi2rx->pads[i].flags = MEDIA_PAD_FL_SOURCE;
>>> +	csi2rx->subdev.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
>>>    	ret = media_entity_pads_init(&csi2rx->subdev.entity, CSI2RX_PAD_MAX,
>>>    				     csi2rx->pads);
>>>
>>
>> I don't understand this one. There's nothing to configure in cdns-csi2rx
>> from userspace, as far as I can see, so why is the dev node needed? And why
>> would the lack of csi2rx dev node cause sensor subdev config to fail?
> 
> Sensor config does not fail. But when I run media-ctl to set the format
> on /dev/media0, I get an error message that comes because the devnode
> for the bridge does not exist. I was not 100% sure about this patch but
> I figured if media-ctl expects it then it should be exposed.
> 
> I don't mind dropping this patch. Just want to make sure what the right
> thing to do here is. Should every element of the pipeline have a devnode
> or not?

Tbh, I don't know. But I don't see why they should have. Also, my test 
works fine if I remove the devnode here.

What media-ctl parameters did you use which fails?

  Tomi
