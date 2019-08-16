Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42C518FB44
	for <lists+dmaengine@lfdr.de>; Fri, 16 Aug 2019 08:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfHPGnM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 16 Aug 2019 02:43:12 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:32782 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbfHPGnM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 16 Aug 2019 02:43:12 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x7G6gqoW057168;
        Fri, 16 Aug 2019 01:42:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1565937772;
        bh=MyW/FA21sez8YFN7BQYBrU9Mj4bCGTkDBKyMAqfmR3o=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=x4CXROTMsj1hqnRJM2dIca6NGZ/8RZ54IG5tme6aY4YSS8UsqPqXiSYAr4eNPRr/Z
         0qkXUtQhwiUNS5g10/4vufMGiBXLuUrb96chyNiLT9ggL69fMxsbhqNqZ3RkGuFP1M
         Xxcg5K3nOoTm/K3hn39Mzs12uGdIBX3AT7bSud8A=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x7G6gqOh046652
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 16 Aug 2019 01:42:52 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 16
 Aug 2019 01:42:51 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 16 Aug 2019 01:42:52 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x7G6gnqH052171;
        Fri, 16 Aug 2019 01:42:50 -0500
Subject: Re: [PATCH] dmaengine: ti: Fix a memory leak bug
To:     Wenwen Wang <wenwen@cs.uga.edu>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, Enrico Weigelt <info@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1565936603-7046-1-git-send-email-wenwen@cs.uga.edu>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <f6ddbed6-581c-cf0b-515a-52f9fb4f4fa2@ti.com>
Date:   Fri, 16 Aug 2019 09:43:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1565936603-7046-1-git-send-email-wenwen@cs.uga.edu>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 16/08/2019 9.23, Wenwen Wang wrote:
> In ti_dra7_xbar_probe(), 'rsv_events' is allocated through kcalloc(). Then
> of_property_read_u32_array() is invoked to search for the property.
> However, if this process fails, 'rsv_events' is not deallocated, leading to
> a memory leak bug. To fix this issue, free 'rsv_events' before returning
> the error.

Can you change the subject to:
"dmaengine: ti: dma-crossbar: Fix a memory leak bug" ?

Otherwise: Thank you, and
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> 
> Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
> ---
>  drivers/dma/ti/dma-crossbar.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/ti/dma-crossbar.c b/drivers/dma/ti/dma-crossbar.c
> index ad2f0a4..f255056 100644
> --- a/drivers/dma/ti/dma-crossbar.c
> +++ b/drivers/dma/ti/dma-crossbar.c
> @@ -391,8 +391,10 @@ static int ti_dra7_xbar_probe(struct platform_device *pdev)
>  
>  		ret = of_property_read_u32_array(node, pname, (u32 *)rsv_events,
>  						 nelm * 2);
> -		if (ret)
> +		if (ret) {
> +			kfree(rsv_events);
>  			return ret;
> +		}
>  
>  		for (i = 0; i < nelm; i++) {
>  			ti_dra7_xbar_reserve(rsv_events[i][0], rsv_events[i][1],
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
