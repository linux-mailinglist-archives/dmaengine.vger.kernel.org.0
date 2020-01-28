Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1657614B441
	for <lists+dmaengine@lfdr.de>; Tue, 28 Jan 2020 13:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbgA1MhE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Jan 2020 07:37:04 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:36824 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbgA1MhE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 28 Jan 2020 07:37:04 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00SCavOl087487;
        Tue, 28 Jan 2020 06:36:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1580215017;
        bh=eH6ZEc8wDkBWw7j1581yfbj0sCQVGFuszERkTW7GjVU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=OIJ94549IqV40CP6iuX5VVhQRVLONgCD52xu14iRolMQTZBG93syReoCxImpzrdwG
         gn6A9RzHex1iia9r5Y6aLYgYXb7k/Pj0QeShxbSKcMbAZQKCfX1nINKrrGUN6MoPCh
         8Bkq34crJ3aHiC7LbO3+d58LjcgGMPrctItRT6LE=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00SCav3P118973;
        Tue, 28 Jan 2020 06:36:57 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 28
 Jan 2020 06:36:56 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 28 Jan 2020 06:36:56 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00SCasvD049933;
        Tue, 28 Jan 2020 06:36:55 -0600
Subject: Re: [PATCH for-next 0/4] dmaengine: ti: k3-udma: Updates for next
To:     Vinod Koul <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dan.j.williams@intel.com>, <grygorii.strashko@ti.com>,
        <vigneshr@ti.com>
References: <20200127132111.20464-1-peter.ujfalusi@ti.com>
 <41c53cc4-fa3e-1ab1-32b8-1d516cda7341@ti.com>
 <20200128115006.GT2841@vkoul-mobl>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <fbe5a971-650d-de58-cee2-0a80eca5c1cd@ti.com>
Date:   Tue, 28 Jan 2020 14:37:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200128115006.GT2841@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

On 28/01/2020 13.50, Vinod Koul wrote:
> On 28-01-20, 12:15, Peter Ujfalusi wrote:
>> Vinod,
>>
>> On 27/01/2020 15.21, Peter Ujfalusi wrote:
>>> Hi Vinod,
>>>
>>> Based on customer reports we have identified two issues with the UDMA driver:
>>>
>>> TX completion (1st patch):
>>> The scheduled work based workaround for checking for completion worked well for
>>> UART, but it had significant impact on SPI performance.
>>> The underlying issue is coming from the fact that we have split data movement
>>> architecture.
>>> In order to know that the transfer is really done we need to check the remote
>>> end's (PDMA) byte counter.
>>>
>>> RX channel teardown with stale data in PDMA (2nd patch):
>>> If we try to stop the RX DMA channel (teardown) then PDMA is trying to flush the
>>> data is might received from a peripheral, but if UDMA does not have a packet to
>>> use for this draining than it is going to push back on the PDMA and the flush
>>> will never completes.
>>> The workaround is to use a dummy descriptor for flush purposes when the channel
>>> is terminated and we did not have active transfer (no descriptor for UDMA).
>>> This allows UDMA to drain the data and the teardown can complete.
>>>
>>> The last two patch is to use common code to set up the TR parameters for
>>> slave_sg, cyclic and memcpy. The setup code is the same as we used for memcpy
>>> with the change we can handle 4.2GB sg elements and periods in case of cyclic.
>>> It is also nice that we have single function to do the configuration.
>>
>> I have marked these patches as for-next as 5.5 was not released yet.
>> Would it be possible to have these as fixes for 5.6?
> 
> Sure but are they really fixes, why cant they go for next release :)
> 
> They seem to improve things for sure, but do we want to call them as
> fixes..?

I would say that the first two patch is a fix:
TX completion check is fixing the performance hit by the early TX
completion workaround which used jiffies+work.

The second patch is fixing a case when we have stale data during RX and
no active transfer. For example when UART reads 1000 bytes, but the
other end is 'streaming' the data and after the 1000 bytes the UART+PDMA
receives data.
Recovering from this state is not easy and it might not even succeed in
HW level.

The last two is I agree, it is not fixing much, it does corrects the
slave_sg TR setup (and improves the cyclic as well).
With that I could send the ASoC platform wrapper for UDMA with
period_bytes_max = 4.2GB ;)
I have SZ_512K in there atm, with the old calculation SZ_64K is the
maximum, not a big issue.

I think the first two patch is a fix candidate as they fix regression
(albeit regression between the series's) and a real world channel lockup
discovered too late for the initial driver.

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
