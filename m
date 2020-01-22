Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB56145374
	for <lists+dmaengine@lfdr.de>; Wed, 22 Jan 2020 12:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729566AbgAVLJR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Jan 2020 06:09:17 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:35514 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbgAVLJR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 Jan 2020 06:09:17 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00MB9C23110570;
        Wed, 22 Jan 2020 05:09:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1579691352;
        bh=QiTKBCrOrs/Oulx9bRiWu/vkDu5PxUpL8so9E0WLCc4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=u8NPj5axgMQ263rEbZ+NH/ZsY+pejCWmkhntBoAG28oVeMPpXbohMB6q6/Lt6U//t
         Z8Z1PNKU2z93PJbxoIW05vvxHvyv7eM35rEjccn048JIEEtQigBxmPJxw7NcqxtkUc
         kB6Yg+Xu5afIiCtUAFV2Cf7onmzbzO9ZgKPqD0BY=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 00MB9Cxw115954
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 22 Jan 2020 05:09:12 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 22
 Jan 2020 05:09:10 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 22 Jan 2020 05:09:10 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00MB986c035872;
        Wed, 22 Jan 2020 05:09:09 -0600
Subject: Re: [PATCH][next] dmaengine: ti: k3-udma: fix spelling mistake
 "limted" -> "limited"
To:     Colin King <colin.king@canonical.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        <dmaengine@vger.kernel.org>
CC:     <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200122093818.2800743-1-colin.king@canonical.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <e642e0c4-b712-a3de-1444-0c7de6243284@ti.com>
Date:   Wed, 22 Jan 2020 13:09:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200122093818.2800743-1-colin.king@canonical.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Colin,

On 22/01/2020 11.38, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There are spelling mistakes in dev_err messages. Fix them.

This slipped through, thanks for catching it!

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/dma/ti/k3-udma.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> index 9974e72cdc50..ea79c2df28e0 100644
> --- a/drivers/dma/ti/k3-udma.c
> +++ b/drivers/dma/ti/k3-udma.c
> @@ -2300,7 +2300,7 @@ udma_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
>  	/* static TR for remote PDMA */
>  	if (udma_configure_statictr(uc, d, dev_width, burst)) {
>  		dev_err(uc->ud->dev,
> -			"%s: StaticTR Z is limted to maximum 4095 (%u)\n",
> +			"%s: StaticTR Z is limited to maximum 4095 (%u)\n",
>  			__func__, d->static_tr.bstcnt);
>  
>  		udma_free_hwdesc(uc, d);
> @@ -2483,7 +2483,7 @@ udma_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr, size_t buf_len,
>  	/* static TR for remote PDMA */
>  	if (udma_configure_statictr(uc, d, dev_width, burst)) {
>  		dev_err(uc->ud->dev,
> -			"%s: StaticTR Z is limted to maximum 4095 (%u)\n",
> +			"%s: StaticTR Z is limited to maximum 4095 (%u)\n",
>  			__func__, d->static_tr.bstcnt);
>  
>  		udma_free_hwdesc(uc, d);
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
