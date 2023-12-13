Return-Path: <dmaengine+bounces-509-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F947810C41
	for <lists+dmaengine@lfdr.de>; Wed, 13 Dec 2023 09:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A742428174D
	for <lists+dmaengine@lfdr.de>; Wed, 13 Dec 2023 08:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071161D553;
	Wed, 13 Dec 2023 08:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cIz8afNP"
X-Original-To: dmaengine@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F3CF5;
	Wed, 13 Dec 2023 00:19:44 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BD8JeSL009458;
	Wed, 13 Dec 2023 02:19:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1702455580;
	bh=RDDNoCNLrnjnW4tX2j6u4vJDko9IfxbGoJ7f1LTFe14=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=cIz8afNPtLB4na8GFoa6lCce0ErAttPZmDFM0ahzWN0Kk88Er/9lfdhpLMUvvM7mM
	 nUkKoY+djbnqWApUl02pKCDUO9mnuJ6Nz8o2EuZZduadSPIX1Da8nwM6XbG2q3MP/Z
	 3r/rLBLqbHv6etOwt4B48JoOGWh/TXCT1T0d9FgM=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BD8Jeb9032208
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 13 Dec 2023 02:19:40 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 13
 Dec 2023 02:19:40 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 13 Dec 2023 02:19:40 -0600
Received: from [10.24.69.141] ([10.24.69.141])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BD8Jc4x043359;
	Wed, 13 Dec 2023 02:19:38 -0600
Message-ID: <6ed9778c-d792-5481-144c-905a0cf12d61@ti.com>
Date: Wed, 13 Dec 2023 13:49:37 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] dmaengine: ti: k3-udma: Add PSIL threads for AM62P
To: Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
        Peter
 Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DMA Engine
	<dmaengine@vger.kernel.org>
References: <20231212203655.3155565-2-bb@ti.com>
 <1f4bed4e-12e0-4c82-a4fe-a8dee7053a1b@ti.com>
Content-Language: en-US
From: Vaishnav Achath <vaishnav.a@ti.com>
In-Reply-To: <1f4bed4e-12e0-4c82-a4fe-a8dee7053a1b@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Vignesh,

On 13/12/23 11:32, Vignesh Raghavendra wrote:
> 
> 
> On 13/12/23 2:06 am, Bryan Brattlof wrote:
>> From: Vignesh Raghavendra <vigneshr@ti.com>
>>
>> Add PSIL and PDMA data for AM62P.
>>
>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
>> Signed-off-by: Bryan Brattlof <bb@ti.com>
>> ---
>>  drivers/dma/ti/Makefile        |   3 +-
>>  drivers/dma/ti/k3-psil-am62p.c | 196 +++++++++++++++++++++++++++++++++
> 
> Does this also include J722s data? I prefer if we could introduce both
> SoC support together as one is superset of the other. Vaishav?
> 

This did not include J722S data and also CSI2RX data for both devices, I have
added those and sent a V2 for this patch:
https://lore.kernel.org/all/20231213081318.26203-1-vaishnav.a@ti.com/

Thanks and Regards,
Vaishnav

> Regards
> Vignesh
> 
> [...]

