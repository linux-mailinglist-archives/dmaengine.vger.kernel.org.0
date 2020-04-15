Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED9531AAC4A
	for <lists+dmaengine@lfdr.de>; Wed, 15 Apr 2020 17:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbgDOPwn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Apr 2020 11:52:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:46524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404370AbgDOPwl (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 15 Apr 2020 11:52:41 -0400
Received: from localhost (unknown [106.201.106.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C1072078B;
        Wed, 15 Apr 2020 15:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586965960;
        bh=3nhPiG14fdmwJZiNI1dN7Avf3zyfHDT6otMgRh9+gxw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WFhIiPML1IozGtYUPa2An/MB6+JNb6buwc3G4U+OwezMQpTjCBEPoOdo19RWWjiyf
         Tnq9GDI7/kqYADYrFyCTCSZdxqFF/HKpuS8U0BshsRkTo3ApsW0HUdnd3VVbmwS6P3
         5FuJ158B79eU8UgtvYQjzcszk+hGaW2XgguZt50M=
Date:   Wed, 15 Apr 2020 21:22:24 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     leonid.ravich@dell.com
Cc:     dmaengine@vger.kernel.org, lravich@gmail.com,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexios Zavras <alexios.zavras@intel.com>,
        "Alexander.Barabash@dell.com" <Alexander.Barabash@dell.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Jilayne Lovejoy <opensource@jilayne.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dmaengine: ioat: fixing chunk sizing macros
 dependency
Message-ID: <20200415155224.GS72691@vkoul-mobl>
References: <20200402092725.15121-2-leonid.ravich@dell.com>
 <20200402163356.9029-1-leonid.ravich@dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402163356.9029-1-leonid.ravich@dell.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 02-04-20, 19:33, leonid.ravich@dell.com wrote:
> From: Leonid Ravich <Leonid.Ravich@emc.com>
> 
> prepare for changing alloc size.

This does not tell what the change is doing. A patch should describe the
change... pls explain the change is size here

> 
> Acked-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Leonid Ravich <Leonid.Ravich@emc.com>
> ---
>  drivers/dma/ioat/dma.c  | 14 ++++++++------
>  drivers/dma/ioat/dma.h  | 10 ++++++----
>  drivers/dma/ioat/init.c |  2 +-
>  3 files changed, 15 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/dma/ioat/dma.c b/drivers/dma/ioat/dma.c
> index 18c011e..1e0e6c1 100644
> --- a/drivers/dma/ioat/dma.c
> +++ b/drivers/dma/ioat/dma.c
> @@ -332,8 +332,8 @@ static dma_cookie_t ioat_tx_submit_unlock(struct dma_async_tx_descriptor *tx)
>  	u8 *pos;
>  	off_t offs;
>  
> -	chunk = idx / IOAT_DESCS_PER_2M;
> -	idx &= (IOAT_DESCS_PER_2M - 1);
> +	chunk = idx / IOAT_DESCS_PER_CHUNK;
> +	idx &= (IOAT_DESCS_PER_CHUNK - 1);
>  	offs = idx * IOAT_DESC_SZ;
>  	pos = (u8 *)ioat_chan->descs[chunk].virt + offs;
>  	phys = ioat_chan->descs[chunk].hw + offs;
> @@ -370,7 +370,8 @@ struct ioat_ring_ent **
>  	if (!ring)
>  		return NULL;
>  
> -	ioat_chan->desc_chunks = chunks = (total_descs * IOAT_DESC_SZ) / SZ_2M;
> +	chunks = (total_descs * IOAT_DESC_SZ) / IOAT_CHUNK_SIZE;
> +	ioat_chan->desc_chunks = chunks;
>  
>  	for (i = 0; i < chunks; i++) {
>  		struct ioat_descs *descs = &ioat_chan->descs[i];
> @@ -382,8 +383,9 @@ struct ioat_ring_ent **
>  
>  			for (idx = 0; idx < i; idx++) {
>  				descs = &ioat_chan->descs[idx];
> -				dma_free_coherent(to_dev(ioat_chan), SZ_2M,
> -						  descs->virt, descs->hw);
> +				dma_free_coherent(to_dev(ioat_chan),
> +						IOAT_CHUNK_SIZE,
> +						descs->virt, descs->hw);
>  				descs->virt = NULL;
>  				descs->hw = 0;
>  			}
> @@ -404,7 +406,7 @@ struct ioat_ring_ent **
>  
>  			for (idx = 0; idx < ioat_chan->desc_chunks; idx++) {
>  				dma_free_coherent(to_dev(ioat_chan),
> -						  SZ_2M,
> +						  IOAT_CHUNK_SIZE,
>  						  ioat_chan->descs[idx].virt,
>  						  ioat_chan->descs[idx].hw);
>  				ioat_chan->descs[idx].virt = NULL;
> diff --git a/drivers/dma/ioat/dma.h b/drivers/dma/ioat/dma.h
> index b8e8e0b..5216c6b 100644
> --- a/drivers/dma/ioat/dma.h
> +++ b/drivers/dma/ioat/dma.h
> @@ -81,6 +81,11 @@ struct ioatdma_device {
>  	u32 msixpba;
>  };
>  
> +#define IOAT_MAX_ORDER 16
> +#define IOAT_MAX_DESCS (1 << IOAT_MAX_ORDER)
> +#define IOAT_CHUNK_SIZE (SZ_2M)
> +#define IOAT_DESCS_PER_CHUNK (IOAT_CHUNK_SIZE / IOAT_DESC_SZ)
> +
>  struct ioat_descs {
>  	void *virt;
>  	dma_addr_t hw;
> @@ -128,7 +133,7 @@ struct ioatdma_chan {
>  	u16 produce;
>  	struct ioat_ring_ent **ring;
>  	spinlock_t prep_lock;
> -	struct ioat_descs descs[2];
> +	struct ioat_descs descs[IOAT_MAX_DESCS / IOAT_DESCS_PER_CHUNK];
>  	int desc_chunks;
>  	int intr_coalesce;
>  	int prev_intr_coalesce;
> @@ -301,9 +306,6 @@ static inline bool is_ioat_bug(unsigned long err)
>  	return !!err;
>  }
>  
> -#define IOAT_MAX_ORDER 16
> -#define IOAT_MAX_DESCS 65536
> -#define IOAT_DESCS_PER_2M 32768
>  
>  static inline u32 ioat_ring_size(struct ioatdma_chan *ioat_chan)
>  {
> diff --git a/drivers/dma/ioat/init.c b/drivers/dma/ioat/init.c
> index 60e9afb..58d1356 100644
> --- a/drivers/dma/ioat/init.c
> +++ b/drivers/dma/ioat/init.c
> @@ -651,7 +651,7 @@ static void ioat_free_chan_resources(struct dma_chan *c)
>  	}
>  
>  	for (i = 0; i < ioat_chan->desc_chunks; i++) {
> -		dma_free_coherent(to_dev(ioat_chan), SZ_2M,
> +		dma_free_coherent(to_dev(ioat_chan), IOAT_CHUNK_SIZE,
>  				  ioat_chan->descs[i].virt,
>  				  ioat_chan->descs[i].hw);
>  		ioat_chan->descs[i].virt = NULL;
> -- 
> 1.9.3

-- 
~Vinod
