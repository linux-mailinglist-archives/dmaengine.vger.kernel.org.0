Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8478A11895C
	for <lists+dmaengine@lfdr.de>; Tue, 10 Dec 2019 14:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfLJNMx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 Dec 2019 08:12:53 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:58498 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727420AbfLJNMw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 10 Dec 2019 08:12:52 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBADCfSS114999;
        Tue, 10 Dec 2019 07:12:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1575983561;
        bh=j9uoSdC4ltx05rCgWTwHPgb4NIYZjEh5QIl0ORnDOaI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=eZc/G/FzY2FhdRrEnd8+3BheWX2iYPhOPRpZL3fqGBX87GtxWBWExWZ3b4OPXiWiw
         NwGgClUYdaFt5tz5r/7ickwO1WsM3KpCuUdsLYnrhTOh2H4nCL/TyciPpRCUKnLy3k
         e2ggYbJO/G4QMPwGyoi+hBbqJORvGm/OpWSKz4qw=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBADCfN2108481;
        Tue, 10 Dec 2019 07:12:41 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 10
 Dec 2019 07:12:40 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 10 Dec 2019 07:12:40 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBADCcFf126496;
        Tue, 10 Dec 2019 07:12:38 -0600
Subject: Re: [PATCH 1/6] dmaengine: virt-dma: Do not call desc_free() under a
 spin_lock
To:     Sascha Hauer <s.hauer@pengutronix.de>, <dmaengine@vger.kernel.org>
CC:     Vinod Koul <vkoul@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
References: <20191210123352.7555-1-s.hauer@pengutronix.de>
 <20191210123352.7555-2-s.hauer@pengutronix.de>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <7f8c4ae6-88f9-7818-a9d6-cc55bcf62bd5@ti.com>
Date:   Tue, 10 Dec 2019 15:12:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191210123352.7555-2-s.hauer@pengutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 10/12/2019 14.33, Sascha Hauer wrote:
> vchan_vdesc_fini() shouldn't be called under a spin_lock. This is done
> in two places, once in vchan_terminate_vdesc() and once in
> vchan_synchronize(). Instead of freeing the vdesc right away, collect
> the aborted vdescs on a separate list and free them along with the other
> vdescs. The terminated descs are also freed in vchan_synchronize as done
> before this patch.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/dma/virt-dma.c |  1 +
>  drivers/dma/virt-dma.h | 18 +++++++++---------
>  2 files changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/dma/virt-dma.c b/drivers/dma/virt-dma.c
> index ec4adf4260a0..02c0a8885a53 100644
> --- a/drivers/dma/virt-dma.c
> +++ b/drivers/dma/virt-dma.c
> @@ -135,6 +135,7 @@ void vchan_init(struct virt_dma_chan *vc, struct dma_device *dmadev)
>  	INIT_LIST_HEAD(&vc->desc_submitted);
>  	INIT_LIST_HEAD(&vc->desc_issued);
>  	INIT_LIST_HEAD(&vc->desc_completed);
> +	INIT_LIST_HEAD(&vc->desc_terminated);
>  
>  	tasklet_init(&vc->task, vchan_complete, (unsigned long)vc);
>  
> diff --git a/drivers/dma/virt-dma.h b/drivers/dma/virt-dma.h
> index ab158bac03a7..e213137b6bc1 100644
> --- a/drivers/dma/virt-dma.h
> +++ b/drivers/dma/virt-dma.h
> @@ -31,9 +31,9 @@ struct virt_dma_chan {
>  	struct list_head desc_submitted;
>  	struct list_head desc_issued;
>  	struct list_head desc_completed;
> +	struct list_head desc_terminated;
>  
>  	struct virt_dma_desc *cyclic;
> -	struct virt_dma_desc *vd_terminated;
>  };
>  
>  static inline struct virt_dma_chan *to_virt_chan(struct dma_chan *chan)
> @@ -141,11 +141,8 @@ static inline void vchan_terminate_vdesc(struct virt_dma_desc *vd)
>  {
>  	struct virt_dma_chan *vc = to_virt_chan(vd->tx.chan);
>  
> -	/* free up stuck descriptor */
> -	if (vc->vd_terminated)
> -		vchan_vdesc_fini(vc->vd_terminated);
> +	list_add_tail(&vd->node, &vc->desc_terminated);
>  
> -	vc->vd_terminated = vd;
>  	if (vc->cyclic == vd)
>  		vc->cyclic = NULL;
>  }
> @@ -179,6 +176,7 @@ static inline void vchan_get_all_descriptors(struct virt_dma_chan *vc,
>  	list_splice_tail_init(&vc->desc_submitted, head);
>  	list_splice_tail_init(&vc->desc_issued, head);
>  	list_splice_tail_init(&vc->desc_completed, head);
> +	list_splice_tail_init(&vc->desc_terminated, head);
>  }
>  
>  static inline void vchan_free_chan_resources(struct virt_dma_chan *vc)
> @@ -207,16 +205,18 @@ static inline void vchan_free_chan_resources(struct virt_dma_chan *vc)
>   */
>  static inline void vchan_synchronize(struct virt_dma_chan *vc)
>  {
> +	LIST_HEAD(head);
>  	unsigned long flags;
>  
>  	tasklet_kill(&vc->task);
>  
>  	spin_lock_irqsave(&vc->lock, flags);
> -	if (vc->vd_terminated) {
> -		vchan_vdesc_fini(vc->vd_terminated);
> -		vc->vd_terminated = NULL;
> -	}
> +
> +	list_splice_tail_init(&vc->desc_terminated, &head);
> +
>  	spin_unlock_irqrestore(&vc->lock, flags);
> +
> +	vchan_dma_desc_free_list(vc, &head);

My only issue with the vchan_dma_desc_free_list() is that it prints with
dev_dbg() for each descriptor it is freeing up.
The 'stuck' descriptor happens quite frequently if you start/stop audio
for example.

This is why I proposed a local

list_for_each_entry_safe(vd, _vd, &head, node) {
	list_del(&vd->node);
	vchan_vdesc_fini(vd);
}

On the other hand what vchan_dma_desc_free_list() is doing is exactly
the same thing as this loop is doing with the addition of the debug print.

I'm not sure how useful that debug print is, not sure if anyone would
miss if it is gone?

If not, than see my comment on patch 2.

>  }
>  
>  #endif
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
