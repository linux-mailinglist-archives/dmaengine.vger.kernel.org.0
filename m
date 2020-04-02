Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F20119C568
	for <lists+dmaengine@lfdr.de>; Thu,  2 Apr 2020 17:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388823AbgDBPET (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 Apr 2020 11:04:19 -0400
Received: from mga07.intel.com ([134.134.136.100]:29393 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389021AbgDBPET (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 2 Apr 2020 11:04:19 -0400
IronPort-SDR: k7gMs2+9dx7Y55vayDZbRrf01y42JaHOJxmcrNur1mwMZ4hFZclTeztM77vgYYtB5A1ec5SF+m
 An12Jtk3/ItQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2020 08:04:18 -0700
IronPort-SDR: p2OD5L73VwSZPR+Yi+4vPdY3DiobioS8qNDc+iHxR/o47Vmlu7chaa3pkDO5jdbrNtIn8Hwo7L
 FuQfjZkBt6lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,336,1580803200"; 
   d="scan'208";a="284806507"
Received: from ccui-mobl1.amr.corp.intel.com (HELO [10.134.85.228]) ([10.134.85.228])
  by fmsmga002.fm.intel.com with ESMTP; 02 Apr 2020 08:04:16 -0700
Subject: Re: [PATCH 1/2] dmaengine: ioat: fixing chunk sizing macros
 dependency
To:     leonid.ravich@dell.com, dmaengine@vger.kernel.org
Cc:     lravich@gmail.com, Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexios Zavras <alexios.zavras@intel.com>,
        "Alexander.Barabash@dell.com" <Alexander.Barabash@dell.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Jilayne Lovejoy <opensource@jilayne.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org
References: <20200402092725.15121-1-leonid.ravich@dell.com>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <3d4f393d-95ef-385c-6486-d1d0f8bfbd24@intel.com>
Date:   Thu, 2 Apr 2020 08:04:15 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200402092725.15121-1-leonid.ravich@dell.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 4/2/2020 2:27 AM, leonid.ravich@dell.com wrote:
> From: Leonid Ravich <Leonid.Ravich@emc.com>
> 
> prepare for changing alloc size.
> 
> Signed-off-by: Leonid Ravich <Leonid.Ravich@emc.com>

I'm ok with the changes in the series. Were you able to test this on 
hardware? A few formating nits below

> ---
>   drivers/dma/ioat/dma.c  | 14 ++++++++------
>   drivers/dma/ioat/dma.h  | 10 ++++++----
>   drivers/dma/ioat/init.c |  2 +-
>   3 files changed, 15 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/dma/ioat/dma.c b/drivers/dma/ioat/dma.c
> index 18c011e..1e0e6c1 100644
> --- a/drivers/dma/ioat/dma.c
> +++ b/drivers/dma/ioat/dma.c
> @@ -332,8 +332,8 @@ static dma_cookie_t ioat_tx_submit_unlock(struct dma_async_tx_descriptor *tx)
>   	u8 *pos;
>   	off_t offs;
>   
> -	chunk = idx / IOAT_DESCS_PER_2M;
> -	idx &= (IOAT_DESCS_PER_2M - 1);
> +	chunk = idx / IOAT_DESCS_PER_CHUNK;
> +	idx &= (IOAT_DESCS_PER_CHUNK - 1);
>   	offs = idx * IOAT_DESC_SZ;
>   	pos = (u8 *)ioat_chan->descs[chunk].virt + offs;
>   	phys = ioat_chan->descs[chunk].hw + offs;
> @@ -370,7 +370,8 @@ struct ioat_ring_ent **
>   	if (!ring)
>   		return NULL;
>   
> -	ioat_chan->desc_chunks = chunks = (total_descs * IOAT_DESC_SZ) / SZ_2M;
> +	chunks = (total_descs * IOAT_DESC_SZ) / IOAT_CHUNK_SIZE;
> +	ioat_chan->desc_chunks = chunks;
>   
>   	for (i = 0; i < chunks; i++) {
>   		struct ioat_descs *descs = &ioat_chan->descs[i];
> @@ -382,8 +383,9 @@ struct ioat_ring_ent **
>   
>   			for (idx = 0; idx < i; idx++) {
>   				descs = &ioat_chan->descs[idx];
> -				dma_free_coherent(to_dev(ioat_chan), SZ_2M,
> -						  descs->virt, descs->hw);
> +				dma_free_coherent(to_dev(ioat_chan),
> +						IOAT_CHUNK_SIZE,
> +						descs->virt, descs->hw);
>   				descs->virt = NULL;
>   				descs->hw = 0;
>   			}
> @@ -404,7 +406,7 @@ struct ioat_ring_ent **
>   
>   			for (idx = 0; idx < ioat_chan->desc_chunks; idx++) {
>   				dma_free_coherent(to_dev(ioat_chan),
> -						  SZ_2M,
> +						  IOAT_CHUNK_SIZE,
>   						  ioat_chan->descs[idx].virt,
>   						  ioat_chan->descs[idx].hw);
>   				ioat_chan->descs[idx].virt = NULL;
> diff --git a/drivers/dma/ioat/dma.h b/drivers/dma/ioat/dma.h
> index b8e8e0b..535aba9 100644
> --- a/drivers/dma/ioat/dma.h
> +++ b/drivers/dma/ioat/dma.h
> @@ -81,6 +81,11 @@ struct ioatdma_device {
>   	u32 msixpba;
>   };
>   
> +#define IOAT_MAX_ORDER 16
> +#define IOAT_MAX_DESCS (1 << IOAT_MAX_ORDER)
> +#define IOAT_CHUNK_SIZE (SZ_2M)
> +#define IOAT_DESCS_PER_CHUNK (IOAT_CHUNK_SIZE/IOAT_DESC_SZ)

(IOAT_CHUNK_SIZE / IOAT_DESC_SZ)

> +
>   struct ioat_descs {
>   	void *virt;
>   	dma_addr_t hw;
> @@ -128,7 +133,7 @@ struct ioatdma_chan {
>   	u16 produce;
>   	struct ioat_ring_ent **ring;
>   	spinlock_t prep_lock;
> -	struct ioat_descs descs[2];
> +	struct ioat_descs descs[IOAT_MAX_DESCS/IOAT_DESCS_PER_CHUNK];

IOAT_MAX_DESCS / IOAT_DESCS_PER_CHUNK

>   	int desc_chunks;
>   	int intr_coalesce;
>   	int prev_intr_coalesce;
> @@ -301,9 +306,6 @@ static inline bool is_ioat_bug(unsigned long err)
>   	return !!err;
>   }
>   
> -#define IOAT_MAX_ORDER 16
> -#define IOAT_MAX_DESCS 65536
> -#define IOAT_DESCS_PER_2M 32768
>   
>   static inline u32 ioat_ring_size(struct ioatdma_chan *ioat_chan)
>   {
> diff --git a/drivers/dma/ioat/init.c b/drivers/dma/ioat/init.c
> index 60e9afb..58d1356 100644
> --- a/drivers/dma/ioat/init.c
> +++ b/drivers/dma/ioat/init.c
> @@ -651,7 +651,7 @@ static void ioat_free_chan_resources(struct dma_chan *c)
>   	}
>   
>   	for (i = 0; i < ioat_chan->desc_chunks; i++) {
> -		dma_free_coherent(to_dev(ioat_chan), SZ_2M,
> +		dma_free_coherent(to_dev(ioat_chan), IOAT_CHUNK_SIZE,
>   				  ioat_chan->descs[i].virt,
>   				  ioat_chan->descs[i].hw);
>   		ioat_chan->descs[i].virt = NULL;
> 
