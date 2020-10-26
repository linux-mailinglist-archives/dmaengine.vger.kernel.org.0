Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08C6829854B
	for <lists+dmaengine@lfdr.de>; Mon, 26 Oct 2020 02:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1421124AbgJZBYB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 25 Oct 2020 21:24:01 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2680 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1419390AbgJZBYB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 25 Oct 2020 21:24:01 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CKHDM0xlXz15LBQ;
        Mon, 26 Oct 2020 09:24:03 +0800 (CST)
Received: from [10.63.139.185] (10.63.139.185) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Mon, 26 Oct 2020 09:23:47 +0800
Subject: Re: [PATCH 07/10] dmaengine: hisi_dma: remove redundant irqsave and
 irqrestore in hardIRQ
To:     Barry Song <song.bao.hua@hisilicon.com>, <vkoul@kernel.org>,
        <dmaengine@vger.kernel.org>
References: <20201015235921.21224-1-song.bao.hua@hisilicon.com>
 <20201015235921.21224-8-song.bao.hua@hisilicon.com>
From:   Zhou Wang <wangzhou1@hisilicon.com>
Message-ID: <5F962523.9040802@hisilicon.com>
Date:   Mon, 26 Oct 2020 09:23:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20201015235921.21224-8-song.bao.hua@hisilicon.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.63.139.185]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2020/10/16 7:59, Barry Song wrote:
> Running in hardIRQ, disabling IRQ is redundant.
> 
> Cc: Zhou Wang <wangzhou1@hisilicon.com>
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>

Thanks for fixing this :)

Acked-by: Zhou Wang <wangzhou1@hisilicon.com>

> ---
>  drivers/dma/hisi_dma.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/hisi_dma.c b/drivers/dma/hisi_dma.c
> index e1a958ae7925..a259ee010e9b 100644
> --- a/drivers/dma/hisi_dma.c
> +++ b/drivers/dma/hisi_dma.c
> @@ -431,9 +431,8 @@ static irqreturn_t hisi_dma_irq(int irq, void *data)
>  	struct hisi_dma_dev *hdma_dev = chan->hdma_dev;
>  	struct hisi_dma_desc *desc;
>  	struct hisi_dma_cqe *cqe;
> -	unsigned long flags;
>  
> -	spin_lock_irqsave(&chan->vc.lock, flags);
> +	spin_lock(&chan->vc.lock);
>  
>  	desc = chan->desc;
>  	cqe = chan->cq + chan->cq_head;
> @@ -452,7 +451,7 @@ static irqreturn_t hisi_dma_irq(int irq, void *data)
>  		chan->desc = NULL;
>  	}
>  
> -	spin_unlock_irqrestore(&chan->vc.lock, flags);
> +	spin_unlock(&chan->vc.lock);
>  
>  	return IRQ_HANDLED;
>  }
> 
