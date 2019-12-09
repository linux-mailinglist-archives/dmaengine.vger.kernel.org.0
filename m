Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 642F6116796
	for <lists+dmaengine@lfdr.de>; Mon,  9 Dec 2019 08:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfLIHiX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Dec 2019 02:38:23 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40098 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfLIHiX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 9 Dec 2019 02:38:23 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xB97cCvB065492;
        Mon, 9 Dec 2019 01:38:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1575877092;
        bh=OElIG5LMZuOsqn8ukFVxaVNXGeLlQFb4+8JTaf86QlI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=CtyGzkCrxJH89u+7/zFmsx8oLbLeyiLP9paEAJAfY3hk1qLwHxvRgIaY+gTPFnHPH
         LL9j5VH+gKgOT/7upWG+wF+8M+Wn+0x2f7Du9bGQBiDQDHdNxrVC6R3KZ53qGCUOdk
         GuiMLks9z9xdtXYdQg1K/oydY+JymMcBNJ21J4t4=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xB97cCAV112228
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 9 Dec 2019 01:38:12 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 9 Dec
 2019 01:38:11 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 9 Dec 2019 01:38:11 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB97c9kO003091;
        Mon, 9 Dec 2019 01:38:09 -0600
Subject: Re: [PATCH 1/5] dmaengine: virt-dma: Add missing locking around list
 operations
To:     Sascha Hauer <s.hauer@pengutronix.de>, <dmaengine@vger.kernel.org>
CC:     Vinod Koul <vkoul@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
References: <20191206135344.29330-1-s.hauer@pengutronix.de>
 <20191206135344.29330-2-s.hauer@pengutronix.de>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <2da64628-20e5-b12d-798e-b47cf025badc@ti.com>
Date:   Mon, 9 Dec 2019 09:38:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191206135344.29330-2-s.hauer@pengutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Sascha,

On 06/12/2019 15.53, Sascha Hauer wrote:
> All list operations are protected by &vc->lock. As vchan_vdesc_fini()
> is called unlocked add the missing locking around the list operations.

At this commit the vhcan_vdesc_fini() _is_ called when the lock is held
via vchan_terminate_vdesc() which must be called with the lock held...

Swap patch 1 and 2.

> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/dma/virt-dma.h | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/virt-dma.h b/drivers/dma/virt-dma.h
> index ab158bac03a7..41883ee2c29f 100644
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
>  		vc->desc_free(vd);
> +	}
>  }
>  
>  /**
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
