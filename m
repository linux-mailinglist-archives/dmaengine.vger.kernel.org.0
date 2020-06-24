Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8153A206C01
	for <lists+dmaengine@lfdr.de>; Wed, 24 Jun 2020 07:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388854AbgFXFzj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Jun 2020 01:55:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:58948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388280AbgFXFzj (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 24 Jun 2020 01:55:39 -0400
Received: from localhost (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DDBC2073E;
        Wed, 24 Jun 2020 05:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592978139;
        bh=IDDIJV22a3Ovbw0bQoQy+zWJH8exNEIrWuN8w5nfDyI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uSWDiNYHDNs0J7RovY7qEJn4LzLzZaQsEA2w9mwAByWOtumiE89EjMbgKjNJTT/P5
         1gcBxf9bVYZRa+uFtZgudQ90iIEU5VPoZchGhAajrb9/DivCTomqoRUlySL08YVsAi
         hU79tghugxBDWVk5NrPakizX3ljxQt8g8/RfKDlM=
Date:   Wed, 24 Jun 2020 11:25:35 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH][next] dmaengine: ti: k3-udma: Use struct_size() in
 kzalloc()
Message-ID: <20200624055535.GX2324254@vkoul-mobl>
References: <20200619224334.GA7857@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619224334.GA7857@embeddedor>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 19-06-20, 17:43, Gustavo A. R. Silva wrote:
> Make use of the struct_size() helper instead of an open-coded version
> in order to avoid any potential type mistakes.
> 
> This code was detected with the help of Coccinelle and, audited and
> fixed manually.
> 
> Addresses-KSPP-ID: https://github.com/KSPP/linux/issues/83
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/dma/ti/k3-udma.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> index 0d5fb154b8e2..411c54b86ba8 100644
> --- a/drivers/dma/ti/k3-udma.c
> +++ b/drivers/dma/ti/k3-udma.c
> @@ -2209,7 +2209,7 @@ udma_prep_slave_sg_pkt(struct udma_chan *uc, struct scatterlist *sgl,
>  	u32 ring_id;
>  	unsigned int i;
>  
> -	d = kzalloc(sizeof(*d) + sglen * sizeof(d->hwdesc[0]), GFP_NOWAIT);
> +	d = kzalloc(struct_size(d, hwdesc, sglen), GFP_NOWAIT);

struct_size() is a * b + c but here we need, a + b * c.. the trailing
struct is N times here..


>  	if (!d)
>  		return NULL;
>  
> @@ -2525,7 +2525,7 @@ udma_prep_dma_cyclic_pkt(struct udma_chan *uc, dma_addr_t buf_addr,
>  	if (period_len >= SZ_4M)
>  		return NULL;
>  
> -	d = kzalloc(sizeof(*d) + periods * sizeof(d->hwdesc[0]), GFP_NOWAIT);
> +	d = kzalloc(struct_size(d, hwdesc, periods), GFP_NOWAIT);
>  	if (!d)
>  		return NULL;
>  
> -- 
> 2.27.0

-- 
~Vinod
