Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33821216902
	for <lists+dmaengine@lfdr.de>; Tue,  7 Jul 2020 11:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgGGJ1P (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 Jul 2020 05:27:15 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:34836 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727908AbgGGJ1L (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 7 Jul 2020 05:27:11 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0679R7t3054895;
        Tue, 7 Jul 2020 04:27:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1594114027;
        bh=9PiAvcd9rTvJB8L/MQUQpHiUr/oFJzby4/z+whuEy+U=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=bKeOuclqXe9jJ6WA9gJuWgYESMxrSSKhKTKUdIKOfl1Q9rKjBe+0p/lBDuvHfJdTA
         aEaPyTQCtSXDzGLesb5RaqxGbKKcYU82KDbYqrqHJOtGnSODMnY+8A3e0yYqgMkw26
         lMZW6Pf6gsaQCTnpgE+rYWUqRX7NWjHCVzDBp4vU=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0679R7ig101764
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 Jul 2020 04:27:07 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 7 Jul
 2020 04:27:07 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 7 Jul 2020 04:27:07 -0500
Received: from [10.250.100.73] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0679R6xV074281;
        Tue, 7 Jul 2020 04:27:06 -0500
Subject: Re: [PATCH 5/5] dmaengine: ti: k3-udma: Use udma_chan instead of
 tchan/rchan for IO functions
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>, <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <dan.j.williams@intel.com>
References: <20200707091031.10411-1-peter.ujfalusi@ti.com>
 <20200707091031.10411-6-peter.ujfalusi@ti.com>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <3539fa39-b61f-ea38-4bb4-60f85102efc3@ti.com>
Date:   Tue, 7 Jul 2020 12:27:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200707091031.10411-6-peter.ujfalusi@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 07/07/2020 12:10, Peter Ujfalusi wrote:
> Move the uc->tchan/rchan checks to the IO wrappers itself instead of
> calling the functions with tchan/rchan directly.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>   drivers/dma/ti/k3-udma.c | 163 +++++++++++++++++++--------------------
>   1 file changed, 78 insertions(+), 85 deletions(-)
> 
> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> index 7eae3a3d0703..8b9a3829abc2 100644
> --- a/drivers/dma/ti/k3-udma.c
> +++ b/drivers/dma/ti/k3-udma.c
> @@ -282,51 +282,49 @@ static inline void udma_update_bits(void __iomem *base, int reg,
>   }
>   
>   /* TCHANRT */
> -static inline u32 udma_tchanrt_read(struct udma_tchan *tchan, int reg)
> +static inline u32 udma_tchanrt_read(struct udma_chan *uc, int reg)
>   {
> -	if (!tchan)
> +	if (!uc || !uc->tchan)
>   		return 0;

In general I have no objections, but
do you need those checks at all? can it ever happen?

[...]

-- 
Best regards,
grygorii
