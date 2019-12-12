Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26DF711D4CA
	for <lists+dmaengine@lfdr.de>; Thu, 12 Dec 2019 19:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730235AbfLLSB4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 12 Dec 2019 13:01:56 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:59362 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730148AbfLLSB4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 12 Dec 2019 13:01:56 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBCI1jCj040670;
        Thu, 12 Dec 2019 12:01:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576173705;
        bh=7umw+lZFi1BHRxJtoDG/pDfGYt2ivKM2wzztYeraSx4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=mjvuyE5K/ua8woRHztS9LAAhCdNoMODmSggKIAY96KJd9xga6vMDt0Ew+yRwo/ZB7
         SujM4u8gfg0mmJzOqJ84dskQkiPjTeJmEmm7h1U/gqHPlCP/inKNXYtxri06JWnqdU
         4jI9RWOPrPp8n783qi+xF3rmI3BEPYxYXtOrVzgc=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBCI1jMa094685
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 12 Dec 2019 12:01:45 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 12
 Dec 2019 12:01:44 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 12 Dec 2019 12:01:44 -0600
Received: from [10.250.100.73] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBCI1fIu110459;
        Thu, 12 Dec 2019 12:01:42 -0600
Subject: Re: [PATCH v7 00/12] dmaengine/soc: Add Texas Instruments UDMA
 support
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>, <vkoul@kernel.org>,
        <robh+dt@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lokeshvutla@ti.com>, <t-kristo@ti.com>, <tony@atomide.com>,
        <j-keerthy@ti.com>, <vigneshr@ti.com>
References: <20191209094332.4047-1-peter.ujfalusi@ti.com>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <24491d96-df44-de64-73cb-2f67e6581629@ti.com>
Date:   Thu, 12 Dec 2019 20:01:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191209094332.4047-1-peter.ujfalusi@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 09/12/2019 11:43, Peter Ujfalusi wrote:
> Hi,
> 
> Vinod, Nishanth, Tero, Santosh: the ti_sci patch in this series was sent
> upstream over a month ago:
> https://lore.kernel.org/lkml/20191025084715.25098-1-peter.ujfalusi@ti.com/
> 
> I'm still waiting on it's fate (Tero has given his r-b).
> The ti_sci patch did not made it to 5.5-rc1, but I included it in the series and
> let the maintainers decide if it can go via DMAengine for 5.6 or to later
> releases (5.6 probably for the ti_sci and 5.7 for the UDMA driver patch).
> 
> Changes since v6:
> (https://patchwork.kernel.org/project/linux-dmaengine/list/?series=209455&state=*)
> 
> - UDMAP DMAengine driver:
>   - Squashed the split patches
>   - Squashed the early TX completion handling update
>     (https://patchwork.kernel.org/project/linux-dmaengine/list/?series=210713&state=*)
>   - Hard reset fix for RX channels to avoid channel lockdown
>   - Correct completed descriptor's residue value
> 

Thank you Peter,
Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>

-- 
Best regards,
grygorii
