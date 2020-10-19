Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 688F8292879
	for <lists+dmaengine@lfdr.de>; Mon, 19 Oct 2020 15:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbgJSNo4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 19 Oct 2020 09:44:56 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:42218 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728258AbgJSNoy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 19 Oct 2020 09:44:54 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 09JDicKK041911;
        Mon, 19 Oct 2020 08:44:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1603115078;
        bh=M7Tw90MP2weVbTvBiJuXT6mcfSdpgqOCnuR20G01dEQ=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=wZLiaN5krc2QMBzr1KW4uigUQQkQKWZLRGXGH0FYaKp21vnk8P1d0Nys/6mQEmice
         gKJvs2jXc85qjHdSc+AAOFpICeesGECWWOCJ8k7Wufo4Qx4IhRT4mRnBKhmt1HCxeO
         +0WXEjmVJcOqAj0Kuzxk9HCGH5Uu7qQlF5e6N6hY=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 09JDicZ0103784
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 19 Oct 2020 08:44:38 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 19
 Oct 2020 08:44:38 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 19 Oct 2020 08:44:38 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 09JDiaa6058968;
        Mon, 19 Oct 2020 08:44:37 -0500
Subject: Re: [PATCH 02/10] dmaengine: k3-udma: remove redundant irqsave and
 irqrestore in hardIRQ
To:     Barry Song <song.bao.hua@hisilicon.com>, <vkoul@kernel.org>,
        <dmaengine@vger.kernel.org>
References: <20201015235921.21224-1-song.bao.hua@hisilicon.com>
 <20201015235921.21224-3-song.bao.hua@hisilicon.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <6a4beeb9-3473-9655-5004-41ea8958b855@ti.com>
Date:   Mon, 19 Oct 2020 16:45:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
MIME-Version: 1.0
In-Reply-To: <20201015235921.21224-3-song.bao.hua@hisilicon.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 16/10/2020 2.59, Barry Song wrote:
> Running in hardIRQ, disabling IRQ is redundant.

Subject should be: dmaengine: ti: k3-udma: ...

Other than that:
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> ---
>  drivers/dma/ti/k3-udma.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> index 82cf6c77f5c9..e508280b3d70 100644
> --- a/drivers/dma/ti/k3-udma.c
> +++ b/drivers/dma/ti/k3-udma.c
> @@ -1020,13 +1020,12 @@ static irqreturn_t udma_ring_irq_handler(int irq, void *data)
>  {
>  	struct udma_chan *uc = data;
>  	struct udma_desc *d;
> -	unsigned long flags;
>  	dma_addr_t paddr = 0;
>  
>  	if (udma_pop_from_ring(uc, &paddr) || !paddr)
>  		return IRQ_HANDLED;
>  
> -	spin_lock_irqsave(&uc->vc.lock, flags);
> +	spin_lock(&uc->vc.lock);
>  
>  	/* Teardown completion message */
>  	if (cppi5_desc_is_tdcm(paddr)) {
> @@ -1077,7 +1076,7 @@ static irqreturn_t udma_ring_irq_handler(int irq, void *data)
>  		}
>  	}
>  out:
> -	spin_unlock_irqrestore(&uc->vc.lock, flags);
> +	spin_unlock(&uc->vc.lock);
>  
>  	return IRQ_HANDLED;
>  }
> @@ -1086,9 +1085,8 @@ static irqreturn_t udma_udma_irq_handler(int irq, void *data)
>  {
>  	struct udma_chan *uc = data;
>  	struct udma_desc *d;
> -	unsigned long flags;
>  
> -	spin_lock_irqsave(&uc->vc.lock, flags);
> +	spin_lock(&uc->vc.lock);
>  	d = uc->desc;
>  	if (d) {
>  		d->tr_idx = (d->tr_idx + 1) % d->sglen;
> @@ -1103,7 +1101,7 @@ static irqreturn_t udma_udma_irq_handler(int irq, void *data)
>  		}
>  	}
>  
> -	spin_unlock_irqrestore(&uc->vc.lock, flags);
> +	spin_unlock(&uc->vc.lock);
>  
>  	return IRQ_HANDLED;
>  }
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
