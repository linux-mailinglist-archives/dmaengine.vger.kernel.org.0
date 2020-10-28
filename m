Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 025BD29E2D1
	for <lists+dmaengine@lfdr.de>; Thu, 29 Oct 2020 03:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbgJ2CWp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Oct 2020 22:22:45 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:54084 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbgJ2CWd (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 28 Oct 2020 22:22:33 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 09S9tXta013681;
        Wed, 28 Oct 2020 04:55:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1603878933;
        bh=WpuJwseW9Svtj2469VNX15rvKbOCv8Gz8AEwmGmjtCs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=BvLZx2fanDkinac8xdr0njtShv+mu4FLt05OMKwhH25MI1cVVvM0ZBtbL7nxS7Ck3
         UI5r0Mp2NJcmBGuh9J1AIQNTbxT5+3ZQeIjIagBISC2NKZMY/6dlDhnylFmCNYwsYe
         xxSipmfFNMOkPK3+2DhOQpd98Xxtajm4MGHDx0N4=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 09S9tXtE062968
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 28 Oct 2020 04:55:33 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 28
 Oct 2020 04:55:33 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 28 Oct 2020 04:55:33 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 09S9tUVg061254;
        Wed, 28 Oct 2020 04:55:31 -0500
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
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <cf3d3de0-223b-4846-bd9f-b78654ae2d08@ti.com>
Date:   Wed, 28 Oct 2020 11:56:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201028055531.GH3550@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

On 28/10/2020 7.55, Vinod Koul wrote:

>> To summarize:
>> In of_dma_route_allocate() the router does not yet know the channel we
>> are going to get.
>> In of_dma_xlate() the DMA driver does not yet know if the channel will
>> use router or not.
>> I need to tell the router the event number it has to send, which is
>> based on the channel number I got.
> 
> Sounds reasonable, btw why not pass this information in xlate. Router
> will have a different xlate rather than non router right, or is it same.

Yes, the router's have their separate xlate, but in that xlate we do not
yet have a channel. I don't know what is the event I need to send from
the router to trigger the channel.

> If this information is anyway available in DT might be better to get it
> and use from DT

Without a channel number I can not do anything.
It is close to a chicken and egg problem.

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
