Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA7F3210AC9
	for <lists+dmaengine@lfdr.de>; Wed,  1 Jul 2020 14:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730497AbgGAMM4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 1 Jul 2020 08:12:56 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:48060 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730190AbgGAMMz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 1 Jul 2020 08:12:55 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 061CCqVI114140;
        Wed, 1 Jul 2020 07:12:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1593605572;
        bh=ujTJUKsmBwUaVQ8CAH63MRy30qquq/EoyVehAK2SpD4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=BoqkqhP3kzDxqer2mSFyun7ws9C616eq+YzlVBzhBXmrXBe09OH83b/bRWyME8JWI
         1kk0Qy6SQX7T9dUds/bh645w41Gl1EgpWCabOtzvM5yHWIv1cebb4jKLj+AKdqPtAE
         sd5Q5JR0IMw4EWkiF5ndE7wCmvF/u5LXLlptBcZ0=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 061CCq9q064176
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 1 Jul 2020 07:12:52 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 1 Jul
 2020 07:12:52 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 1 Jul 2020 07:12:51 -0500
Received: from [10.250.100.73] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 061CCnaV121802;
        Wed, 1 Jul 2020 07:12:49 -0500
Subject: Re: [PATCH next 4/6] soc: ti: k3-ringacc: add request pair of rings
 api.
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>
CC:     Sekhar Nori <nsekhar@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <dmaengine@vger.kernel.org>
References: <20200701103030.29684-1-grygorii.strashko@ti.com>
 <20200701103030.29684-5-grygorii.strashko@ti.com>
 <7e334685-7d98-9896-ef5b-3a2dfeb100a9@ti.com>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <e3936c3c-eb60-35a5-6413-ceba273cdf1c@ti.com>
Date:   Wed, 1 Jul 2020 15:12:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <7e334685-7d98-9896-ef5b-3a2dfeb100a9@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 01/07/2020 14:54, Peter Ujfalusi wrote:
> Hi Grygorii,
> 
> On 01/07/2020 13.30, Grygorii Strashko wrote:
>> Add new API k3_ringacc_request_rings_pair() to request pair of rings at
>> once, as in the most cases Rings are used with DMA channels, which need to
>> request pair of rings - one to feed DMA with descriptors (TX/RX FDQ) and
>> one to receive completions (RX/TX CQ). This will allow to simplify Ringacc
>> API users.
>>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>> ---
>>   drivers/soc/ti/k3-ringacc.c       | 24 ++++++++++++++++++++++++
>>   include/linux/soc/ti/k3-ringacc.h |  4 ++++
>>   2 files changed, 28 insertions(+)
>>
>> diff --git a/drivers/soc/ti/k3-ringacc.c b/drivers/soc/ti/k3-ringacc.c
>> index 8a8f31d59e24..4cf1150de88e 100644
>> --- a/drivers/soc/ti/k3-ringacc.c
>> +++ b/drivers/soc/ti/k3-ringacc.c
>> @@ -322,6 +322,30 @@ struct k3_ring *k3_ringacc_request_ring(struct k3_ringacc *ringacc,
>>   }
>>   EXPORT_SYMBOL_GPL(k3_ringacc_request_ring);
>>   
>> +int k3_ringacc_request_rings_pair(struct k3_ringacc *ringacc,
>> +				  int fwd_id, int compl_id,
>> +				  struct k3_ring **fwd_ring,
>> +				  struct k3_ring **compl_ring)
> 
> Would you consider re-arranging the parameter list to:
> int k3_ringacc_request_rings_pair(struct k3_ringacc *ringacc,
> 				  struct k3_ring **fwd_ring, int fwd_id,
> 				  struct k3_ring **compl_ring, int compl_id)
> 

i think it's more common to have input parameters first.

>> +{
>> +	int ret = 0;
>> +
>> +	if (!fwd_ring || !compl_ring)
>> +		return -EINVAL;
>> +
>> +	*fwd_ring = k3_ringacc_request_ring(ringacc, fwd_id, 0);
>> +	if (!(*fwd_ring))
>> +		return -ENODEV;
>> +
>> +	*compl_ring = k3_ringacc_request_ring(ringacc, compl_id, 0);
>> +	if (!(*compl_ring)) {
>> +		k3_ringacc_ring_free(*fwd_ring);
>> +		ret = -ENODEV;
>> +	}
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(k3_ringacc_request_rings_pair);
>> +



-- 
Best regards,
grygorii
