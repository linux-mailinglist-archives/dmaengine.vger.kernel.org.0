Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4F1EF1090
	for <lists+dmaengine@lfdr.de>; Wed,  6 Nov 2019 08:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731398AbfKFHoo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 6 Nov 2019 02:44:44 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:34396 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731136AbfKFHon (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 6 Nov 2019 02:44:43 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xA67idae109132;
        Wed, 6 Nov 2019 01:44:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573026279;
        bh=f1NEPFJjClLNi2nXj2/pBImQn0eR1YY7EU9xYbARDFY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=UfWy7760YyHkaT2NRw59cyv7eFBBc2ElZuZ6711GeQI2LpkxxKIyIS3gXR6ZtbZkH
         33ZDi+aNXJ4bf65emhVovprynkAAbxDvLzQUfUo3kbLVVnmtBLVUM2XqL6N89fyTQj
         u9ya/lWygS+943byIWb9IArzdpVGWfpJIXB1X5p0=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xA67idbQ084075
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 6 Nov 2019 01:44:39 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 6 Nov
 2019 01:44:37 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 6 Nov 2019 01:44:22 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xA67iZjb063767;
        Wed, 6 Nov 2019 01:44:36 -0600
Subject: Re: [PATCH v4 0/3] dmaengine: bindings/edma: dma-channel-mask to
 array
To:     Vinod Koul <vkoul@kernel.org>
CC:     <robh+dt@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dan.j.williams@intel.com>,
        <devicetree@vger.kernel.org>
References: <20190930114055.29315-1-peter.ujfalusi@ti.com>
 <20191105165145.GB952516@vkoul-mobl>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <fc83b096-f737-4d90-cb3e-0d8eb43c7f12@ti.com>
Date:   Wed, 6 Nov 2019 09:45:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191105165145.GB952516@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

On 05/11/2019 18.51, Vinod Koul wrote:
> On 30-09-19, 14:40, Peter Ujfalusi wrote:
>> Hi,
>>
>> Changes since v3:
>> - Update the dma-common.yaml and edma binding documentation according to Rob's
>>   suggestion
>>
>> Changes since v2:
>> - Fix dma-common.yaml documentation patch and extend the description of the
>>   dma-channel-mask array
>> - The edma documentation now includes information on the dma-channel-mask array
>>   size for EDMAs with 32 or 64 channels
>>
>> Changes since v1:
>> - Extend the common dma-channel-mask to uint32-array to be usable for
>>   controllers with more than 32 channels
>> - Use the dma-channel-mask instead custom property for available channels for
>>   EDMA.
>>
>> The original patch was part of the EDMA multicore usage series.
>>
>> Rob: I'm not sure if I got the dma-common.yaml update correctly...
>>
>> EDMAs can have 32 or 64 channels depending on the SoC, the dma-channel-mask
>> needs to be an array to be usable for the driver.
> 
> Applied, thanks
> 
> There was a conflict on patch3, I have reolved it, please check.

Looks good, I wonder what caused the conflict. The patch looks identical
in your vinod/next and in my linux-next-wip.

Oh, this is v4 and you have picked the v5. That explains.

Thank you,
- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
