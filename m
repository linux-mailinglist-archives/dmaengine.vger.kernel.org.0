Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7058A2AB85B
	for <lists+dmaengine@lfdr.de>; Mon,  9 Nov 2020 13:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729697AbgKIMgP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Nov 2020 07:36:15 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:51170 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729693AbgKIMgN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 9 Nov 2020 07:36:13 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A9Ca6jS002188;
        Mon, 9 Nov 2020 06:36:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604925366;
        bh=95DTtXkfRsBVcuCi7o8HWOM6vEleEq3iPsJLfzylSFw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=cABhk27F9dcCrPbnbsUSmtQl5A3/oVFXPewl4+t8S5gnSmitofhnmOy/K6HkUt8Qc
         vOUeYUqSvL22k+HVYDS3WRKq4+fO7Zr8h+WNhp/bkMsCmUOOR5/PgIB9I0qeYGLVNT
         FdHsapsUQNBx/ETdJeDCzo7klRTHzyGHOhrB7pSI=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A9Ca6Gn069552
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 9 Nov 2020 06:36:06 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 9 Nov
 2020 06:36:06 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 9 Nov 2020 06:36:06 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A9Ca3s9035270;
        Mon, 9 Nov 2020 06:36:03 -0600
Subject: Re: [PATCH 01/18] dmaengine: of-dma: Add support for optional router
 configuration callback
To:     Vinod Koul <vkoul@kernel.org>
CC:     <nm@ti.com>, <ssantosh@kernel.org>, <robh+dt@kernel.org>,
        <vigneshr@ti.com>, <dan.j.williams@intel.com>, <t-kristo@ti.com>,
        <lokeshvutla@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <dmaengine@vger.kernel.org>
References: <20200930091412.8020-1-peter.ujfalusi@ti.com>
 <20200930091412.8020-2-peter.ujfalusi@ti.com>
 <20201007054404.GR2968@vkoul-mobl>
 <be615881-1eb4-f8fe-a32d-04fabb6cb27b@ti.com>
 <20201007155533.GZ2968@vkoul-mobl>
 <45adb88b-1ef8-1fbf-08c1-9afc6ea4c6f0@ti.com>
 <20201028055531.GH3550@vkoul-mobl>
 <cf3d3de0-223b-4846-bd9f-b78654ae2d08@ti.com>
 <20201109114534.GH3171@vkoul-mobl>
 <7a7cb455-dd09-b71f-6ecc-fd6108d37051@ti.com>
 <20201109122306.GO3171@vkoul-mobl>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <dffd3284-de4c-eb27-b6cf-1b4acc3cb79d@ti.com>
Date:   Mon, 9 Nov 2020 14:36:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.1
MIME-Version: 1.0
In-Reply-To: <20201109122306.GO3171@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 09/11/2020 14.23, Vinod Koul wrote:
> HI Peter,
> 
> On 09-11-20, 14:09, Peter Ujfalusi wrote:
>> Hi Vinod,
>>
>> On 09/11/2020 13.45, Vinod Koul wrote:
>>>> Without a channel number I can not do anything.
>>>> It is close to a chicken and egg problem.
>>>
>>> We get 'channel' in xlate, so wont that help? I think I am still missing
>>> something here :(
>>
>> Yes, we get channel in xlate, but we get the channel after
>> ofdma->of_dma_route_allocate()
> 
> That is correct, so you need this info in allocate somehow..

To know the event number the router must send to trigger the channel I
need the router to 'craft' the dmaspec which can be used to request the
channel.

To request a bcdma channel to be triggered by global trigger 0:

[A]
<&main_bcdma 1 0 15>

main_bcdma - phandle to BCDMA
1 - triggered by global trigger0
0 - ignored
15 - ASEL value

A peripheral can not really use this binding directly as we need to
configure the get the event to be sent to the given channel's trigger0.
The binding for the router (l2g if INTA in this case):

[B]
<&inta_l2g 21 0 15>

inta_l2g - phandle to therouter
21 - local event index (input event/signal)
0 - event detection mode (pulsed/rising)
15 - ASEL value

The of_dma_router_xlate() receives the dmaspec for [B}, the router
driver creates the dmaspec for [A].

The xlate can not request the channel first as it needs the dmaspec from
the router to do so.

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
