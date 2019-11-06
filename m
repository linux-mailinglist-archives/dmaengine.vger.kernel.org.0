Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5FBF109A
	for <lists+dmaengine@lfdr.de>; Wed,  6 Nov 2019 08:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731592AbfKFHpJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 6 Nov 2019 02:45:09 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:49236 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731425AbfKFHpI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 6 Nov 2019 02:45:08 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xA67j4bf098986;
        Wed, 6 Nov 2019 01:45:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573026304;
        bh=3QYMKEUjgYKhBdSdP2qag3H2Be3e+nUu5MFS1L0YuzE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=qsv82tH3JMICrFhOnAkXxD4FlLI/Q6SJFUM/qGmokKoSTpdBmHZV2jg3kr2Mua8NJ
         XV3ZbeCAYvANRS/9cA7Wkai24DkAe+jbJadoikz5XhViWAeRTDVJaksRFiHn7/tSNu
         o+54m+DMZ1WMhchNozlG5QmD7HYeif/mTWNKHthQ=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xA67j4OY014026
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 6 Nov 2019 01:45:04 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 6 Nov
 2019 01:44:47 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 6 Nov 2019 01:44:47 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xA67j0kv010832;
        Wed, 6 Nov 2019 01:45:01 -0600
Subject: Re: [PATCH v5 0/3] dmaengine: bindings/edma: dma-channel-mask to
 array
To:     Vinod Koul <vkoul@kernel.org>
CC:     <robh+dt@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dan.j.williams@intel.com>,
        <devicetree@vger.kernel.org>
References: <20191025073056.25450-1-peter.ujfalusi@ti.com>
 <20191105170101.GE952516@vkoul-mobl>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <1dbaa288-06b6-7ba4-e1ee-d76202c6be8b@ti.com>
Date:   Wed, 6 Nov 2019 09:46:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191105170101.GE952516@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 05/11/2019 19.01, Vinod Koul wrote:
> On 25-10-19, 10:30, Peter Ujfalusi wrote:
>> Hi,
>>
>> Changes since v4:
>> - Rebased on next to make it apply cleanly
>> - Added Reviewed-by from Rob for the DT documentation patches
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
>> EDMAs can have 32 or 64 channels depending on the SoC, the dma-channel-mask
>> needs to be an array to be usable for the driver.
> 
> And now I saw this and have applied these and dropped the ones I fixed
> up manually!

OK, thank you for picking these up! - Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
