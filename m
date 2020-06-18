Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68C541FF0C0
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2020 13:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729501AbgFRLgE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 18 Jun 2020 07:36:04 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40520 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727825AbgFRLgC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 18 Jun 2020 07:36:02 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05IBZxPM048674;
        Thu, 18 Jun 2020 06:35:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1592480159;
        bh=kSYJjlw8+DJVBxfj+7egszQXQsCmWblTSs7qw30kf0U=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=d7fFOhzuGGJk5CRNt+H8DEs5AyXkmKf7LOvPJpd6A9KJsoeJU8GrFbe3dFIhuBHOq
         8xTKqZdmuxONXlOzc59EO3GDpMYei/Nj053vh5oAINvmxwKvfDfCbQ+9Y7V3srMxvf
         Fs0w9jN6UoK99GpxUz5t9Vy1YK4E7kQ2G62QA3fs=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 05IBZxe0066798
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 18 Jun 2020 06:35:59 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 18
 Jun 2020 06:35:59 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 18 Jun 2020 06:35:59 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05IBZv1E021871;
        Thu, 18 Jun 2020 06:35:58 -0500
Subject: Re: [PATCH] dmaengine: ti: k3-udma: Fix delayed_work usage for tx
 drain workaround
To:     Vinod Koul <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <dan.j.williams@intel.com>,
        <tomi.valkeinen@ti.com>
References: <20200520112233.26807-1-peter.ujfalusi@ti.com>
 <20200617135528.GT2324254@vkoul-mobl>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
X-Pep-Version: 2.0
Message-ID: <cf2d48c6-16e9-4494-2e5d-c3349f507870@ti.com>
Date:   Thu, 18 Jun 2020 14:36:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200617135528.GT2324254@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 17/06/2020 16.55, Vinod Koul wrote:
> On 20-05-20, 14:22, Peter Ujfalusi wrote:
>> INIT_DELAYED_WORK_ONSTACK() must be used with on-stack delayed work, w=
hich
>> is not the case here.
>> Use normal delayed_work for the channels instead.
>>
>> Fixes: 25dcb5dd7b7c ("dmaengine: ti: New driver for K3 UDMA")
>=20
> Is this a fix or an optimization?

It is a fix.

>> Reported-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>=20
> No sob!

Oops. I'll resend in a second

>=20
>> ---
>>  drivers/dma/ti/k3-udma.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
>> index c91e2dc1bb72..87554e093a3b 100644
>> --- a/drivers/dma/ti/k3-udma.c
>> +++ b/drivers/dma/ti/k3-udma.c
>> @@ -1906,8 +1906,6 @@ static int udma_alloc_chan_resources(struct dma_=
chan *chan)
>> =20
>>  	udma_reset_rings(uc);
>> =20
>> -	INIT_DELAYED_WORK_ONSTACK(&uc->tx_drain.work,
>> -				  udma_check_tx_completion);
>>  	return 0;
>> =20
>>  err_irq_free:
>> @@ -3019,7 +3017,6 @@ static void udma_free_chan_resources(struct dma_=
chan *chan)
>>  	}
>> =20
>>  	cancel_delayed_work_sync(&uc->tx_drain.work);
>> -	destroy_delayed_work_on_stack(&uc->tx_drain.work);
>> =20
>>  	if (uc->irq_num_ring > 0) {
>>  		free_irq(uc->irq_num_ring, uc);
>> @@ -3711,6 +3708,7 @@ static int udma_probe(struct platform_device *pd=
ev)
>>  		tasklet_init(&uc->vc.task, udma_vchan_complete,
>>  			     (unsigned long)&uc->vc);
>>  		init_completion(&uc->teardown_completed);
>> +		INIT_DELAYED_WORK(&uc->tx_drain.work, udma_check_tx_completion);
>>  	}
>> =20
>>  	ret =3D dma_async_device_register(&ud->ddev);
>> --=20
>> Peter
>>
>> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
>> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
>=20

- P=C3=A9ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

