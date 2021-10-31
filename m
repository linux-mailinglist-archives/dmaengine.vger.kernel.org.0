Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19892440C92
	for <lists+dmaengine@lfdr.de>; Sun, 31 Oct 2021 04:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbhJaDMm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 30 Oct 2021 23:12:42 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:39866 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbhJaDMl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 30 Oct 2021 23:12:41 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 19V3A8hQ114700;
        Sat, 30 Oct 2021 22:10:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1635649808;
        bh=DWo8TDJ7cus5B/NT60Nid2seeZE2zrPpBwR61JTQ7Fo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=HCFtNk0JUF2205cdPnVDcRW4BTbr6hvKB6gTw2nGXf3QTrwu0LncH68NX6/3lAWpC
         //xxDPpTQML5KMWImEppLfX297PjDfOMKlcvMF8FSk5OlMagGfm6e6wMuwToF27xpx
         qCmc4O3sP4FAAVfjIPj7FQHr/v0w7b9JieJy+zyw=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 19V3A8j3013799
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 30 Oct 2021 22:10:08 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Sat, 30
 Oct 2021 22:10:08 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Sat, 30 Oct 2021 22:10:08 -0500
Received: from [10.250.232.66] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 19V3A5Qt098765;
        Sat, 30 Oct 2021 22:10:06 -0500
Subject: Re: [PATCH v3 0/2] dmaengine: ti: k3-udma: Fix NULL pointer
 dereference error
To:     =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
References: <20211029151251.26421-1-kishon@ti.com>
 <87082448-0670-4fee-fc7b-8ead415180da@gmail.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <7aeb5d55-7622-683f-bf9f-cd7eed3cc838@ti.com>
Date:   Sun, 31 Oct 2021 08:40:04 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87082448-0670-4fee-fc7b-8ead415180da@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Peter,

On 30/10/21 12:15 pm, Péter Ujfalusi wrote:
> Hi Kishon,
> 
> On 29/10/2021 18:12, Kishon Vijay Abraham I wrote:
>> NULL pointer de-reference error was observed when all the PCIe endpoint
>> functions (22 function in J721E) request a DMA channel. The issue was
>> specfically observed when using mem-to-mem copy.
>>
>> Changes from v2:
>> 1) Fix commit subject and commit log to mention bchan/rchan/tchan to NULL
>>    suggested by Peter.
> 
> Looks good, however the second patch also fixes the rflow. It is
> mentioned in the commit message itself.
> 
> I suppose the reason for a split is that the UDMA part
> (rchan/tchan/rflow) could be backported as fix for older kernel since
> the bchan came later with BCDMA/PKTDMA support?
> 
> Can you find a good Fixes tag for these?

I'll now add "Cc: <Stable@vger.kernel.org>" so that it gets merged to 5.14. It
doesn't apply cleanly to any of the other stable kernel.
> 
>>
>> Changes from v1:
>> 1) Split the patch for BCDMA and PKTDMA separately
>> 2) Fixed the return value of udma_get_rflow() to 0.
>> 3) Removed the fixes tag as the patches does not directly apply to the
>> commits.
>>
>> v1 => https://lore.kernel.org/r/20210209090036.30832-1-kishon@ti.com
>> v2 => https://lore.kernel.org/r/20211027055625.11150-1-kishon@ti.com
>>
>> Kishon Vijay Abraham I (2):
>>   dmaengine: ti: k3-udma: Set bchan to NULL if a channel request fail
>>   dmaengine: ti: k3-udma: Set rchan/tchan to NULL if a channel request
>>     fail
> 
> dmaengine: ti: k3-udma: Set r/tchan or rflow to NULL if request fail
> 
> would have bee a better subject line, if you feel you can send an update.
> 
> Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>

Thank You! Will fix and resend.

Best Regards,
Kishon
