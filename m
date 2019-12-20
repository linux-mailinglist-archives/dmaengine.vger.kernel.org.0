Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 426B2127EC0
	for <lists+dmaengine@lfdr.de>; Fri, 20 Dec 2019 15:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfLTOun (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 20 Dec 2019 09:50:43 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:52530 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727384AbfLTOum (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 20 Dec 2019 09:50:42 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBKEoTm1004532;
        Fri, 20 Dec 2019 08:50:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576853429;
        bh=HySbb/5w1zvG6YvuW9/AmHG+LPi1aw1qydYFk77daCo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=kw03c87jQHs455VkiVj5u6aeSMl9kt8Jsi+12E99G4a+l2+Czhk23UQaVbRfL7seZ
         +Fh2aaBLLxl+leNKV2nIL0WG4OtkO0sMUfHOsfYrdFWzZrZX+YJqiHIgGADyauhR1L
         Ak4/HuigWtPRdR49YEmtt0rn89JGq8xdZOorD+p4=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBKEoSQr064466
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 20 Dec 2019 08:50:29 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 20
 Dec 2019 08:50:28 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 20 Dec 2019 08:50:28 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBKEoQMa075755;
        Fri, 20 Dec 2019 08:50:27 -0600
Subject: Re: [PATCH] dmaengine: virt-dma: Fix access after free in
 vcna_complete()
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>
CC:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20191220131100.21804-1-peter.ujfalusi@ti.com>
 <0303ceda023121d9048d2508e28c0306b1871561.camel@analog.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <486093bc-b1bf-1727-0402-f07606fffd1e@ti.com>
Date:   Fri, 20 Dec 2019 16:50:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <0303ceda023121d9048d2508e28c0306b1871561.camel@analog.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 20/12/2019 16.01, Ardelean, Alexandru wrote:
> On Fri, 2019-12-20 at 15:11 +0200, Peter Ujfalusi wrote:
>> [External]
>>
>> vchan_vdesc_fini() is freeing up 'vd' so the access to vd->tx_result is
>> via already freed up memory.
>>
>> Move the vchan_vdesc_fini() after invoking the callback to avoid this.
>>
> 
> Apologies for seeing this too late: typo in title vcna_complete() ->
> vchan_complete()

Yep, I also noticed after sending it, I hope Vinod is kind enough and
fix it up when applying ;)

- Péter

>> Fixes: 09d5b702b0f97 ("dmaengine: virt-dma: store result on dma
>> descriptor")
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>>  drivers/dma/virt-dma.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/dma/virt-dma.c b/drivers/dma/virt-dma.c
>> index ec4adf4260a0..256fc662c500 100644
>> --- a/drivers/dma/virt-dma.c
>> +++ b/drivers/dma/virt-dma.c
>> @@ -104,9 +104,8 @@ static void vchan_complete(unsigned long arg)
>>  		dmaengine_desc_get_callback(&vd->tx, &cb);
>>  
>>  		list_del(&vd->node);
>> -		vchan_vdesc_fini(vd);
>> -
>>  		dmaengine_desc_callback_invoke(&cb, &vd->tx_result);
>> +		vchan_vdesc_fini(vd);
>>  	}
>>  }
>>  


Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
