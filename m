Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83D3A14DB6A
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jan 2020 14:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbgA3NS0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 30 Jan 2020 08:18:26 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:58398 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727142AbgA3NS0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 30 Jan 2020 08:18:26 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00UDIMfD014767;
        Thu, 30 Jan 2020 07:18:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1580390302;
        bh=YnPpRPOJrB54TzCkERn6g/npDkn6RNuSyqEisfLG/PQ=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=NjFFBuHQJKynAWsmbgOnUSKHq+khfmsy7P2YloBOh0fEjFT5zUpFH5ALlLOOm37WX
         xTYd/4FE7MKYpP66cjIBKNATY5lVxfJWK/9mqtpNCfoYY88YI+2dIA9UkYtSofVUON
         t3zmAnvThDcuYO+TXacEglIev/tSwx8wRHo03gmA=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 00UDIMbV051928
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 30 Jan 2020 07:18:22 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 30
 Jan 2020 07:18:22 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 30 Jan 2020 07:18:21 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00UDIKiZ049941;
        Thu, 30 Jan 2020 07:18:20 -0600
Subject: Re: [PATCH for-next 0/4] dmaengine: ti: k3-udma: Updates for next
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dan.j.williams@intel.com>, <grygorii.strashko@ti.com>,
        <vigneshr@ti.com>
References: <20200127132111.20464-1-peter.ujfalusi@ti.com>
 <41c53cc4-fa3e-1ab1-32b8-1d516cda7341@ti.com>
 <20200128115006.GT2841@vkoul-mobl>
 <fbe5a971-650d-de58-cee2-0a80eca5c1cd@ti.com>
Message-ID: <5d25f5f1-f6a1-0f5a-b715-0e3e0031bb99@ti.com>
Date:   Thu, 30 Jan 2020 15:19:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <fbe5a971-650d-de58-cee2-0a80eca5c1cd@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

On 28/01/2020 14.37, Peter Ujfalusi wrote:
> Hi Vinod,
> 
> On 28/01/2020 13.50, Vinod Koul wrote:
>> On 28-01-20, 12:15, Peter Ujfalusi wrote:
>>> Vinod,
>>>
>>> On 27/01/2020 15.21, Peter Ujfalusi wrote:
>>>> Hi Vinod,
>>>>
>>>> Based on customer reports we have identified two issues with the UDMA driver:
>>>>
>>>> TX completion (1st patch):
>>>> The scheduled work based workaround for checking for completion worked well for
>>>> UART, but it had significant impact on SPI performance.
>>>> The underlying issue is coming from the fact that we have split data movement
>>>> architecture.
>>>> In order to know that the transfer is really done we need to check the remote
>>>> end's (PDMA) byte counter.
>>>>
>>>> RX channel teardown with stale data in PDMA (2nd patch):
>>>> If we try to stop the RX DMA channel (teardown) then PDMA is trying to flush the
>>>> data is might received from a peripheral, but if UDMA does not have a packet to
>>>> use for this draining than it is going to push back on the PDMA and the flush
>>>> will never completes.
>>>> The workaround is to use a dummy descriptor for flush purposes when the channel
>>>> is terminated and we did not have active transfer (no descriptor for UDMA).
>>>> This allows UDMA to drain the data and the teardown can complete.
>>>>
>>>> The last two patch is to use common code to set up the TR parameters for
>>>> slave_sg, cyclic and memcpy. The setup code is the same as we used for memcpy
>>>> with the change we can handle 4.2GB sg elements and periods in case of cyclic.
>>>> It is also nice that we have single function to do the configuration.
>>>
>>> I have marked these patches as for-next as 5.5 was not released yet.
>>> Would it be possible to have these as fixes for 5.6?
>>
>> Sure but are they really fixes, why cant they go for next release :)
>>
>> They seem to improve things for sure, but do we want to call them as
>> fixes..?
> 
> I would say that the first two patch is a fix:
> TX completion check is fixing the performance hit by the early TX
> completion workaround which used jiffies+work.
> 
> The second patch is fixing a case when we have stale data during RX and
> no active transfer. For example when UART reads 1000 bytes, but the
> other end is 'streaming' the data and after the 1000 bytes the UART+PDMA
> receives data.
> Recovering from this state is not easy and it might not even succeed in
> HW level.
> 
> The last two is I agree, it is not fixing much, it does corrects the
> slave_sg TR setup (and improves the cyclic as well).
> With that I could send the ASoC platform wrapper for UDMA with
> period_bytes_max = 4.2GB ;)
> I have SZ_512K in there atm, with the old calculation SZ_64K is the
> maximum, not a big issue.

Actually this also fixes a real bug in the driver for the slave_sg_tr case:
if the sg_dma_len(sgent) is not multiple of (burst * dev_width) then we
end up with missing bits as the counters are not set up correctly.
The client driver which we tested the slave_sg_tr was always giving
sg_len == 1 and the buffer was aligned, but when I tuned the client to
pass a list, things got broken.

> 
> I think the first two patch is a fix candidate as they fix regression
> (albeit regression between the series's) and a real world channel lockup
> discovered too late for the initial driver.
> 
> - Péter
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
