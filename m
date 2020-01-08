Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11F2E133C1D
	for <lists+dmaengine@lfdr.de>; Wed,  8 Jan 2020 08:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbgAHHUS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 8 Jan 2020 02:20:18 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:60138 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgAHHUS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 8 Jan 2020 02:20:18 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0087K943109419;
        Wed, 8 Jan 2020 01:20:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1578468009;
        bh=FJ3teLAvbwRM2WJYAekO+RSHLFywCtxF35xCkLlqUqA=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=oGAl/IP9zA5+AA3lnIQXAMcyQpL+eu/kArxP+VD4NTwXFbNTwIhm6YATsayn7EwpE
         2/td1lP8Q7dURdFSxtFUJGY9uSApx1tZUP/reEUibOJnWP+/ydFWJtz63ZKCDMR+/o
         JOIOxzBpoB3WYnkCl0UTw1RVL64uHUNlivVOmEZk=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0087K8bU058642
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 8 Jan 2020 01:20:08 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 8 Jan
 2020 01:20:08 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 8 Jan 2020 01:20:08 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0087K6Pf005166;
        Wed, 8 Jan 2020 01:20:07 -0600
Subject: Re: [PATCH][next] dmaengine: ti: omap-dma: don't allow a null
 od->plat pointer to be dereferenced
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     Colin King <colin.king@canonical.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Tony Lindgren <tony@atomide.com>, <dmaengine@vger.kernel.org>
CC:     <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200106122325.39121-1-colin.king@canonical.com>
 <b7200998-c8e7-0841-ce91-ad3834c63cae@ti.com>
Message-ID: <f6b24302-a90e-7aa5-b2e8-3c459e6d0598@ti.com>
Date:   Wed, 8 Jan 2020 09:20:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <b7200998-c8e7-0841-ce91-ad3834c63cae@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Colin, Tony,

On 07/01/2020 13.59, Peter Ujfalusi wrote:
> Colin,
> 
> On 06/01/2020 14.23, Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> Currently when the call to dev_get_platdata returns null the driver issues
>> a warning and then later dereferences the null pointer.  Avoid this issue
>> by returning -EPROBE_DEFER errror rather when the platform data is null.
> 
> Thank you for noticing it!
> 
> Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> 
>> Addresses-Coverity: ("Dereference after null check")
>> Fixes: 211010aeb097 ("dmaengine: ti: omap-dma: Pass sdma auxdata to driver and use it")
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>> ---
>>  drivers/dma/ti/omap-dma.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
>> index fc8f7b2fc7b3..335c3fa7a3b1 100644
>> --- a/drivers/dma/ti/omap-dma.c
>> +++ b/drivers/dma/ti/omap-dma.c
>> @@ -1658,8 +1658,10 @@ static int omap_dma_probe(struct platform_device *pdev)
>>  	if (conf) {
>>  		od->cfg = conf;
>>  		od->plat = dev_get_platdata(&pdev->dev);
>> -		if (!od->plat)
>> +		if (!od->plat) {
>>  			dev_warn(&pdev->dev, "no sdma auxdata needed?\n");
>> +			return -EPROBE_DEFER;

I think we should make the print as dev_err("&pdev->dev,
"omap_system_dma_plat_info is missing") and return with -ENODEV. The
omap_system_dma_plat_info is _needed_ and if we have booted with device
tree it is not going to appear later.

Tony, what do you think?

>> +		}
>>  	} else {
>>  		od->cfg = &default_cfg;
>>  
>>

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
