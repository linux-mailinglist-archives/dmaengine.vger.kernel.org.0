Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3A8811683A
	for <lists+dmaengine@lfdr.de>; Mon,  9 Dec 2019 09:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbfLIIdm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Dec 2019 03:33:42 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:43868 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfLIIdm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 9 Dec 2019 03:33:42 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xB98XUKc010592;
        Mon, 9 Dec 2019 02:33:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1575880410;
        bh=cW7BsdBNZhtXFLz5PGwyzG5oXN5V9R/xuNBSnm2eIvA=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=ylcqeKmmrs6ZMUxJeRgmKkF+jz+W4Gwo40sAGwxJWAS/Nk8Hc7eCc+m6Sxjm+nuzT
         L85PLAUa3nS6Z0kK5goQGDNZjnhcJprb0Qor45FCXBz76QZi5LzTTl8maeoCeztkJC
         EqopKsy1Iq0zOEJHfv8dR9g4ER+T1fPtUEqRv2zU=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xB98XUjE099371
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 9 Dec 2019 02:33:30 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 9 Dec
 2019 02:33:30 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 9 Dec 2019 02:33:30 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB98XSNa084019;
        Mon, 9 Dec 2019 02:33:29 -0600
Subject: Re: [PATCH 2/5] dmaengine: virt-dma: Do not call desc_free() under a
 spin_lock
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>, <dmaengine@vger.kernel.org>
CC:     Vinod Koul <vkoul@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
References: <20191206135344.29330-1-s.hauer@pengutronix.de>
 <20191206135344.29330-3-s.hauer@pengutronix.de>
 <65b923ed-4370-089c-1d6c-ce7efac176e6@ti.com>
Message-ID: <c0839f58-9f85-4b23-59cc-75f7bdb98c18@ti.com>
Date:   Mon, 9 Dec 2019 10:33:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <65b923ed-4370-089c-1d6c-ce7efac176e6@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 09/12/2019 9.48, Peter Ujfalusi wrote:
> Hi Sascha,
> 
> 
> On 06/12/2019 15.53, Sascha Hauer wrote:
>> vchan_vdesc_fini() shouldn't be called under a spin_lock. This is done
>> in two places, once in vchan_terminate_vdesc() and once in
>> vchan_synchronize(). Instead of freeing the vdesc right away, collect
>> the aborted vdescs on a separate list and free them along with the other
>> vdescs.
>>
>> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
>> ---
>>  drivers/dma/virt-dma.c |  1 +
>>  drivers/dma/virt-dma.h | 17 +++--------------
>>  2 files changed, 4 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/dma/virt-dma.c b/drivers/dma/virt-dma.c
>> index ec4adf4260a0..87d5bd53c98b 100644
>> --- a/drivers/dma/virt-dma.c
>> +++ b/drivers/dma/virt-dma.c
>> @@ -135,6 +135,7 @@ void vchan_init(struct virt_dma_chan *vc, struct dma_device *dmadev)
>>  	INIT_LIST_HEAD(&vc->desc_submitted);
>>  	INIT_LIST_HEAD(&vc->desc_issued);
>>  	INIT_LIST_HEAD(&vc->desc_completed);
>> +	INIT_LIST_HEAD(&vc->desc_aborted);
> 
> Can we keep the terminated term instead of aborted: desc_terminated
> 
>>  
>>  	tasklet_init(&vc->task, vchan_complete, (unsigned long)vc);
>>  
>> diff --git a/drivers/dma/virt-dma.h b/drivers/dma/virt-dma.h
>> index 41883ee2c29f..6cae93624f0d 100644
>> --- a/drivers/dma/virt-dma.h
>> +++ b/drivers/dma/virt-dma.h
>> @@ -31,9 +31,9 @@ struct virt_dma_chan {
>>  	struct list_head desc_submitted;
>>  	struct list_head desc_issued;
>>  	struct list_head desc_completed;
>> +	struct list_head desc_aborted;
>>  
>>  	struct virt_dma_desc *cyclic;
>> -	struct virt_dma_desc *vd_terminated;
>>  };
>>  
>>  static inline struct virt_dma_chan *to_virt_chan(struct dma_chan *chan)
>> @@ -146,11 +146,8 @@ static inline void vchan_terminate_vdesc(struct virt_dma_desc *vd)
>>  {
>>  	struct virt_dma_chan *vc = to_virt_chan(vd->tx.chan);
>>  
>> -	/* free up stuck descriptor */
>> -	if (vc->vd_terminated)
>> -		vchan_vdesc_fini(vc->vd_terminated);
>> +	list_add_tail(&vd->node, &vc->desc_aborted);
>>  
>> -	vc->vd_terminated = vd;
>>  	if (vc->cyclic == vd)
>>  		vc->cyclic = NULL;
>>  }
>> @@ -184,6 +181,7 @@ static inline void vchan_get_all_descriptors(struct virt_dma_chan *vc,
>>  	list_splice_tail_init(&vc->desc_submitted, head);
>>  	list_splice_tail_init(&vc->desc_issued, head);
>>  	list_splice_tail_init(&vc->desc_completed, head);
>> +	list_splice_tail_init(&vc->desc_aborted, head);
>>  }
>>  
>>  static inline void vchan_free_chan_resources(struct virt_dma_chan *vc)
>> @@ -212,16 +210,7 @@ static inline void vchan_free_chan_resources(struct virt_dma_chan *vc)
>>   */
>>  static inline void vchan_synchronize(struct virt_dma_chan *vc)
>>  {
>> -	unsigned long flags;
>> -
>>  	tasklet_kill(&vc->task);
>> -
>> -	spin_lock_irqsave(&vc->lock, flags);
>> -	if (vc->vd_terminated) {
>> -		vchan_vdesc_fini(vc->vd_terminated);
>> -		vc->vd_terminated = NULL;
>> -	}
>> -	spin_unlock_irqrestore(&vc->lock, flags);
> 
> We don't want the terminated descriptors to accumulate until the channel
> is freed up.

Well, most DMA driver will clean it up in their terminate_all, but it is
better to do it in synchronize as well.

> 
> spin_lock_irqsave(&vc->lock, flags);
> list_splice_tail_init(&vc->desc_terminated, &head);
> spin_unlock_irqrestore(&vc->lock, flags);
> 
> list_for_each_entry_safe(vd, _vd, &head, node) {
> 	list_del(&vd->node);
> 	vchan_vdesc_fini(vd);
> }
> 
> 
>>  }
>>  
>>  #endif
>>
> 
> - Péter
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
