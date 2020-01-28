Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9224214B3E8
	for <lists+dmaengine@lfdr.de>; Tue, 28 Jan 2020 13:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgA1MFd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Jan 2020 07:05:33 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40938 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbgA1MFd (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 28 Jan 2020 07:05:33 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00SC5TVA092253;
        Tue, 28 Jan 2020 06:05:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1580213129;
        bh=qf6KoXV0NoeksHSlsz3CR71z99ZWbFKtw2snxt6n0lc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Yw7ngQxxqR4p+V3Sw71LWhsQV8tildeltY2ELeDlnLfFm4do5VAhMClpAexp4sg4h
         Jh/EtSVd7frGZ3SXbmn4wXqWCVMzI7sN99xjt6naXDtsNyCZcDRCcrVB8LatiO8KVl
         pbqj0OsRfozyxeloWloK3UhWJXdiEXWLb3DkmlU4=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 00SC5TpV008173
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 28 Jan 2020 06:05:29 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 28
 Jan 2020 06:05:28 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 28 Jan 2020 06:05:28 -0600
Received: from [172.24.217.206] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00SC5Pbg031998;
        Tue, 28 Jan 2020 06:05:26 -0600
Subject: Re: [PATCH for-next 1/4] dmaengine: ti: k3-udma: Use
 ktime/usleep_range based TX completion check
To:     Vinod Koul <vkoul@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dan.j.williams@intel.com>, <grygorii.strashko@ti.com>
References: <20200127132111.20464-1-peter.ujfalusi@ti.com>
 <20200127132111.20464-2-peter.ujfalusi@ti.com>
 <20200128114820.GS2841@vkoul-mobl>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <d968f32d-dc5f-0567-5aa4-faf318025c23@ti.com>
Date:   Tue, 28 Jan 2020 17:35:25 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200128114820.GS2841@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

On 1/28/2020 5:18 PM, Vinod Koul wrote:
> On 27-01-20, 15:21, Peter Ujfalusi wrote:
>> From: Vignesh Raghavendra <vigneshr@ti.com>
>>
>> In some cases (McSPI for example) the jiffie and delayed_work based
>> workaround can cause big throughput drop.
>>
>> Switch to use ktime/usleep_range based implementation to be able
>> to sustain speed for PDMA based peripherals.
>>
>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>>  drivers/dma/ti/k3-udma.c | 80 ++++++++++++++++++++++++++--------------
>>  1 file changed, 53 insertions(+), 27 deletions(-)
>>
>> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
>> index ea79c2df28e0..fb59c869a6a7 100644
>> --- a/drivers/dma/ti/k3-udma.c
>> +++ b/drivers/dma/ti/k3-udma.c
>> @@ -5,6 +5,7 @@
>>   */
>>  
>>  #include <linux/kernel.h>
>> +#include <linux/delay.h>
>>  #include <linux/dmaengine.h>
>>  #include <linux/dma-mapping.h>
>>  #include <linux/dmapool.h>
>> @@ -169,7 +170,7 @@ enum udma_chan_state {
>>  
>>  struct udma_tx_drain {
>>  	struct delayed_work work;
>> -	unsigned long jiffie;
>> +	ktime_t tstamp;
>>  	u32 residue;
>>  };
>>  
>> @@ -946,9 +947,10 @@ static bool udma_is_desc_really_done(struct udma_chan *uc, struct udma_desc *d)
>>  	peer_bcnt = udma_tchanrt_read(uc->tchan, UDMA_TCHAN_RT_PEER_BCNT_REG);
>>  	bcnt = udma_tchanrt_read(uc->tchan, UDMA_TCHAN_RT_BCNT_REG);
>>  
>> +	/* Transfer is incomplete, store current residue and time stamp */
>>  	if (peer_bcnt < bcnt) {
>>  		uc->tx_drain.residue = bcnt - peer_bcnt;
>> -		uc->tx_drain.jiffie = jiffies;
>> +		uc->tx_drain.tstamp = ktime_get();
> 
> Any reason why ktime_get() is better than jiffies..?

Resolution of jiffies is 4ms. ktime_t is has better resolution (upto ns
scale). With jiffies, I observed that code was either always polling DMA
progress counters (which affects HW data transfer speed) or sleeping too
long, both causing performance loss. Switching to ktime_t provides
better prediction of how long transfer takes to complete.

Regards
Vignesh

