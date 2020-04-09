Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 733061A2F6A
	for <lists+dmaengine@lfdr.de>; Thu,  9 Apr 2020 08:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgDIGpO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 9 Apr 2020 02:45:14 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:60640 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgDIGpN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 9 Apr 2020 02:45:13 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0396ix9U027169;
        Thu, 9 Apr 2020 01:44:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1586414699;
        bh=vdhHAqjD6KP/c72S1QR0R+EvzV4ffIQ2S0zwlWNW4fI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=IPfcJLrPfAQJk2ml4I0UtMDVqPON9fKBS/4V5zp26L/WrhwTcjxlQ0j2Dodf37xem
         ljRWxQJe6iEb63WgvnS6PwK3aDUrBFQNOOqOtTtl2bZWPwJvx9Y6J/CVg1pthsIQI7
         /8WaOvK3ygzM1KWGHNp2D/+9Utz3HurOPNDuCCpI=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0396ixNK088950
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 9 Apr 2020 01:44:59 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 9 Apr
 2020 01:44:58 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 9 Apr 2020 01:44:58 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0396iu6b123222;
        Thu, 9 Apr 2020 01:44:56 -0500
Subject: Re: [PATCH] dmaengine: ti: k3-psil: fix deadlock on error path
To:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        <dmaengine@vger.kernel.org>
CC:     Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20200408185501.30776-1-grygorii.strashko@ti.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <d4a71f25-8a25-76bc-bbf7-749e20268339@ti.com>
Date:   Thu, 9 Apr 2020 09:45:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200408185501.30776-1-grygorii.strashko@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 08/04/2020 21.55, Grygorii Strashko wrote:
> The mutex_unlock() is missed on error path of psil_get_ep_config()
> which causes deadlock, so add missed mutex_unlock().

Ah, you are right, thanks for catching it!

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> Fixes: 8c6bb62f6b4a ("dmaengine: ti: k3 PSI-L remote endpoint configuration")
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
>  drivers/dma/ti/k3-psil.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/dma/ti/k3-psil.c b/drivers/dma/ti/k3-psil.c
> index d7b965049ccb..fb7c8150b0d1 100644
> --- a/drivers/dma/ti/k3-psil.c
> +++ b/drivers/dma/ti/k3-psil.c
> @@ -27,6 +27,7 @@ struct psil_endpoint_config *psil_get_ep_config(u32 thread_id)
>  			soc_ep_map = &j721e_ep_map;
>  		} else {
>  			pr_err("PSIL: No compatible machine found for map\n");
> +			mutex_unlock(&ep_map_mutex);
>  			return ERR_PTR(-ENOTSUPP);
>  		}
>  		pr_debug("%s: Using map for %s\n", __func__, soc_ep_map->name);
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
