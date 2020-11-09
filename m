Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 280D42AB7C5
	for <lists+dmaengine@lfdr.de>; Mon,  9 Nov 2020 13:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729243AbgKIMI1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Nov 2020 07:08:27 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:34520 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728927AbgKIMI1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 9 Nov 2020 07:08:27 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A9C8KGF016562;
        Mon, 9 Nov 2020 06:08:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604923700;
        bh=VvLPSZfpwiHAjS3GjsrVd0qPrDT6hWWzu3IfDCtXXms=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=pkP2c8rMzFhKqVzAynG2FpOYK+a7qBCpdIe0YYlj5r10gRe/+yqZgrrTZeULg8dYV
         riIdbvJYa5DbekCDMRjZK8131epQtypXjzZnYM+EccDAGs8DHKzDqZHLO8CFVbXD77
         cf1Ahi9kMjfjcb/LkjIrHClMD0JPeP45Iao//n40=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A9C8Kjg031614
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 9 Nov 2020 06:08:20 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 9 Nov
 2020 06:08:19 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 9 Nov 2020 06:08:19 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A9C8Hb6012848;
        Mon, 9 Nov 2020 06:08:17 -0600
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
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <7a7cb455-dd09-b71f-6ecc-fd6108d37051@ti.com>
Date:   Mon, 9 Nov 2020 14:09:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.1
MIME-Version: 1.0
In-Reply-To: <20201109114534.GH3171@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

On 09/11/2020 13.45, Vinod Koul wrote:
>> Without a channel number I can not do anything.
>> It is close to a chicken and egg problem.
> 
> We get 'channel' in xlate, so wont that help? I think I am still missing
> something here :(

Yes, we get channel in xlate, but we get the channel after
ofdma->of_dma_route_allocate()

of_dma_route_allocate() si the place where DMA routers create the
dmaspec for the DMA controller to get a channel and they up until BCDMA
did also the HW configuration to get the event routed.

For a BCDMA channel we can have three triggers:
Global trigger 0 for the channel
Global trigger 1 for the channel
Local trigger for the channel

Every BCDMA channel have these triggers and for all of them they are the
same (from the channel's pow).
bchan0 can be triggered by global trigger 0
bchan1 can be triggered by global trigger 0

But these triggers are not the same ones, the real trigger depends on
the router, which of it's input is converted to send out an event to
trigger bchan0_trigger0 or to trigger bchan1_trigger0.

When we got the channel with the dmaspec from the router driver then we
need to tell the router driver that it needs to send a given event in
order to trigger the channel that we got.

We can not have traditional binding for BCDMA either where we would tell
the bchan index to be used because depending on the resource allocation
done within sysfw that exact channel might not be even available for us.

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
