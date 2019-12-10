Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A26FE118962
	for <lists+dmaengine@lfdr.de>; Tue, 10 Dec 2019 14:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbfLJNQ5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 Dec 2019 08:16:57 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:47618 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbfLJNQ5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 10 Dec 2019 08:16:57 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBADGk4t034681;
        Tue, 10 Dec 2019 07:16:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1575983807;
        bh=+9dhGSfHLOA7rXBc4Xlr8mMK0v5WGUNIIPWZXmwBRxA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=fXaCMbdsOrF1O9xndHnxJ1sgeTkOTvkTjktJpeoVU9DPUCkdz2s+kM4euyUhSNYfv
         PliBCckXRWguBMHr++F0wB6u6uaKJy7C2qLfDZepbu+9A+WcMiBq/Uhe7rfix4RVz/
         wqe+Nu30UqrBp4bivW28sH01lRQICncrrR0hDoh8=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBADGke2119436
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 10 Dec 2019 07:16:46 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 10
 Dec 2019 07:16:44 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 10 Dec 2019 07:16:44 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBADGgtL009904;
        Tue, 10 Dec 2019 07:16:43 -0600
Subject: Re: [PATCH 2/6] dmaengine: virt-dma: Add missing locking around list
 operations
To:     Sascha Hauer <s.hauer@pengutronix.de>, <dmaengine@vger.kernel.org>
CC:     Vinod Koul <vkoul@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
References: <20191210123352.7555-1-s.hauer@pengutronix.de>
 <20191210123352.7555-3-s.hauer@pengutronix.de>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <6fd01a9e-9eda-b1a3-88e3-893d2c3ee70a@ti.com>
Date:   Tue, 10 Dec 2019 15:16:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191210123352.7555-3-s.hauer@pengutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 10/12/2019 14.33, Sascha Hauer wrote:
> All list operations are protected by &vc->lock. As vchan_vdesc_fini()
> is called unlocked add the missing locking around the list operations.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/dma/virt-dma.h | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/virt-dma.h b/drivers/dma/virt-dma.h
> index e213137b6bc1..e9f5250fbe4d 100644
> --- a/drivers/dma/virt-dma.h
> +++ b/drivers/dma/virt-dma.h
> @@ -113,10 +113,15 @@ static inline void vchan_vdesc_fini(struct virt_dma_desc *vd)
>  {
>  	struct virt_dma_chan *vc = to_virt_chan(vd->tx.chan);
>  
> -	if (dmaengine_desc_test_reuse(&vd->tx))
> +	if (dmaengine_desc_test_reuse(&vd->tx)) {
> +		unsigned long flags;
> +
> +		spin_lock_irqsave(&vc->lock, flags);
>  		list_add(&vd->node, &vc->desc_allocated);
> -	else
> +		spin_unlock_irqrestore(&vc->lock, flags);
> +	} else {

If we add:
		list_del(&vd->node);

here, then the list_del() can be removed from vchan_complete() before
vchan_vdesc_fini() is called and as a plus the
vchan_dma_desc_free_list() can be as simple as:

list_for_each_entry_safe(vd, _vd, head, node)
	vchan_vdesc_fini(vd);

But only if we don't care about the debug print in there, if we care
then the vchan_synchronize() could use the very same simple loop to free
up only the descriptors from the desc_terminated list.


>  		vc->desc_free(vd);
> +	}
>  }
>  
>  /**
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
