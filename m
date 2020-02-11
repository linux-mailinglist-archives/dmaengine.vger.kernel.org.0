Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF209158C77
	for <lists+dmaengine@lfdr.de>; Tue, 11 Feb 2020 11:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbgBKKN5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 11 Feb 2020 05:13:57 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:40178 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728154AbgBKKN5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 11 Feb 2020 05:13:57 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01BADnsq041177;
        Tue, 11 Feb 2020 04:13:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1581416029;
        bh=Ab19tWANqLz4W0BIfQpv5yDQrKNtAPUTkU+NkqUXqRw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=RhMzGbJYhtVdiTbgfJe8SzC3v7cVRd/6fVu44qXlxTeInoTUFfiZh5CbpW7+YD7qq
         IrdnapR1koxUifUS+sPrnyG2fSoZRoCUnG/pE1hX5dQq/3M+vkuLNJwn8EWgObHjMa
         fbuDVKNHWUFJS3s0ioCGaou6D7ONSDPTWRDdS0G4=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01BADnMO007640;
        Tue, 11 Feb 2020 04:13:49 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 11
 Feb 2020 04:13:49 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 11 Feb 2020 04:13:49 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01BADlRO027902;
        Tue, 11 Feb 2020 04:13:48 -0600
Subject: Re: [PATCH for-next 1/4] dmaengine: ti: k3-udma: Use
 ktime/usleep_range based TX completion check
To:     Vinod Koul <vkoul@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dan.j.williams@intel.com>, <grygorii.strashko@ti.com>
References: <20200127132111.20464-1-peter.ujfalusi@ti.com>
 <20200127132111.20464-2-peter.ujfalusi@ti.com>
 <20200128114820.GS2841@vkoul-mobl>
 <d968f32d-dc5f-0567-5aa4-faf318025c23@ti.com>
 <20200128124403.GV2841@vkoul-mobl>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <f6f6b1ca-03ee-c2f0-ffeb-c274e787706c@ti.com>
Date:   Tue, 11 Feb 2020 12:13:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200128124403.GV2841@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 28/01/2020 14.44, Vinod Koul wrote:
> On 28-01-20, 17:35, Vignesh Raghavendra wrote:
> 
>>>> +	/* Transfer is incomplete, store current residue and time stamp */
>>>>  	if (peer_bcnt < bcnt) {
>>>>  		uc->tx_drain.residue = bcnt - peer_bcnt;
>>>> -		uc->tx_drain.jiffie = jiffies;
>>>> +		uc->tx_drain.tstamp = ktime_get();
>>>
>>> Any reason why ktime_get() is better than jiffies..?
>>
>> Resolution of jiffies is 4ms. ktime_t is has better resolution (upto ns
>> scale). With jiffies, I observed that code was either always polling DMA
>> progress counters (which affects HW data transfer speed) or sleeping too
>> long, both causing performance loss. Switching to ktime_t provides
>> better prediction of how long transfer takes to complete.
> 
> Thanks for explanation, i think it is good info to add in changelog.

It turns out that this patch causes lockup with UART stress testing.
The strange thing is that we have identical patch in production with
4.19 without issues.

I'll send two series for UDMA update as we have found a way to induce a
kernel crash with experimental UART patches.
One with patches as must bug fixes for 5.6 and another one with lower
priority fixes.

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
