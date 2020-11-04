Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 817822A6358
	for <lists+dmaengine@lfdr.de>; Wed,  4 Nov 2020 12:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgKDLcP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 Nov 2020 06:32:15 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:56776 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728700AbgKDLcP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 4 Nov 2020 06:32:15 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A4BWCP3100698;
        Wed, 4 Nov 2020 05:32:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604489532;
        bh=ztLoYX10ZTEEbpI78aHru5T6FuTRLWTP546PVk0/y/o=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=EhecplSKO6BqGDWprYkaj3oXm1VdAlSyMKyAqgcoWFTyZcyuPojHL/o0tvps+bb9y
         Oiotjck0XRknwO8N2SLU3kfBK9JITk6O0ey0XWBUICYJHI28YfzyIq7g7eQIkfpOlR
         MonYeJQi99FFwnXQaxo+rA1jxE315SNX9PuruIFk=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A4BWC4M074252
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 4 Nov 2020 05:32:12 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 4 Nov
 2020 05:32:12 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 4 Nov 2020 05:32:12 -0600
Received: from [10.250.100.73] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A4BWAAq099857;
        Wed, 4 Nov 2020 05:32:10 -0600
Subject: Re: [PATCH] dmaengine: ti: k3-udma-glue: move psi-l pairing in
 channel en/dis functions
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Vinod Koul <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC:     Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
References: <20201030203000.4281-1-grygorii.strashko@ti.com>
 <62a8dc0b-821d-c3a6-279c-97b3082b898c@ti.com>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <c9857385-1af4-55eb-722f-cd8b00512378@ti.com>
Date:   Wed, 4 Nov 2020 13:32:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <62a8dc0b-821d-c3a6-279c-97b3082b898c@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 02/11/2020 09:46, Peter Ujfalusi wrote:
> 
> 
> On 30/10/2020 22.30, Grygorii Strashko wrote:
>> The NAVSS UDMA will stuck if target IP module is disabled by PM while PSI-L
>> threads are paired UDMA<->IP and no further transfers is possible. This
>> could be the case for IPs J721E Main CPSW (cpsw9g).
>>
>> Hence, to avoid such situation do PSI-L threads pairing only when UDMA
>> channel is going to be enabled as at this time DMA consumer module expected
>> to be active already.
> 
> Is this patch on top of the AM64 (BCDMA/PKTDMA) series or not?
> Will it cause any conflict?

No. It was not based on top of AM64 series and I've not checked for conflicts.

> 
> Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> 
> 
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>> ---
>>   drivers/dma/ti/k3-udma-glue.c | 64 +++++++++++++++++++++--------------
>>   1 file changed, 38 insertions(+), 26 deletions(-)

...

-- 
Best regards,
grygorii
