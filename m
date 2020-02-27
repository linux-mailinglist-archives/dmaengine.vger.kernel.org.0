Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09811171186
	for <lists+dmaengine@lfdr.de>; Thu, 27 Feb 2020 08:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbgB0Hdg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 27 Feb 2020 02:33:36 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:60780 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbgB0Hdf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 27 Feb 2020 02:33:35 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01R7XTIT040474;
        Thu, 27 Feb 2020 01:33:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582788809;
        bh=abTfs0WCkipC+5DpyvzMs7iFbPPM4oI7lFIyUfPaM0I=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=cigMLSyBzxnMQd2VmFMe0UPTF7EAE4d9p6K6ZwsOd/RVG50BazAZCzR4jSN9fOeT4
         8dKTqv8bZYOkz/rF7oikBsbTK1UFxnlYcz+KUllFZqAAHsBIdiCHBTWJMMaDSK5ZLk
         P7D8J9RpG5DkqVZbwHXGWgVd5TiVCvSPcgE9mQus=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01R7XSVe075275
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 Feb 2020 01:33:29 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 27
 Feb 2020 01:33:28 -0600
Received: from localhost.localdomain (10.64.41.19) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 27 Feb 2020 01:33:28 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by localhost.localdomain (8.15.2/8.15.2) with ESMTP id 01R7XQek104387;
        Thu, 27 Feb 2020 01:33:26 -0600
Subject: Re: [PATCH][next] dmaengine: ti: edma: fix null dereference because
 of a typo in pointer name
To:     Colin King <colin.king@canonical.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC:     <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200226185921.351693-1-colin.king@canonical.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <d7b23176-2e0c-e771-74a7-432123f74dcb@ti.com>
Date:   Thu, 27 Feb 2020 09:33:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200226185921.351693-1-colin.king@canonical.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Colin,

On 26/02/2020 20.59, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently there is a dereference of the null pointer m_ddev.  This appears
> to be a typo on the pointer, I believe s_ddev should be used instead.
> Fix this by using the correct pointer.

Thank you for catching it!
This is a mostly unused case to keep supporting the legacy EDMA binding
which should be gone by now for some time, but there might be boards out
there still booting in that way...

I have copied the dma_cap_set() line from the testable code path.

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> Addresses-Coverity: ("Explicit null dereferenced")
> Fixes: eb0249d50153 ("dmaengine: ti: edma: Support for interleaved mem to mem transfer")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/dma/ti/edma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
> index 2b1fdd438e7f..c4a5c170c1f9 100644
> --- a/drivers/dma/ti/edma.c
> +++ b/drivers/dma/ti/edma.c
> @@ -1992,7 +1992,7 @@ static void edma_dma_init(struct edma_cc *ecc, bool legacy_mode)
>  			 "Legacy memcpy is enabled, things might not work\n");
>  
>  		dma_cap_set(DMA_MEMCPY, s_ddev->cap_mask);
> -		dma_cap_set(DMA_INTERLEAVE, m_ddev->cap_mask);
> +		dma_cap_set(DMA_INTERLEAVE, s_ddev->cap_mask);
>  		s_ddev->device_prep_dma_memcpy = edma_prep_dma_memcpy;
>  		s_ddev->device_prep_interleaved_dma = edma_prep_dma_interleaved;
>  		s_ddev->directions = BIT(DMA_MEM_TO_MEM);
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
