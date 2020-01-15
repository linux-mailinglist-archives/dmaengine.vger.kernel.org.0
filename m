Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3146A13BCCC
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jan 2020 10:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729598AbgAOJtm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Jan 2020 04:49:42 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:2256 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729596AbgAOJtm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 15 Jan 2020 04:49:42 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e1ee0200000>; Wed, 15 Jan 2020 01:49:20 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 15 Jan 2020 01:49:41 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 15 Jan 2020 01:49:41 -0800
Received: from [10.21.133.51] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 15 Jan
 2020 09:49:38 +0000
Subject: Re: [PATCH v4 08/14] dmaengine: tegra-apb: Fix coding style problems
To:     Dmitry Osipenko <digetx@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200112173006.29863-1-digetx@gmail.com>
 <20200112173006.29863-9-digetx@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <844c4ace-d043-a908-823d-545b5b753008@nvidia.com>
Date:   Wed, 15 Jan 2020 09:49:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200112173006.29863-9-digetx@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1579081761; bh=wXVPa46cP+pROyKCHqR3kAtKischKYlkPmCIfUOgxpk=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=lPfLb18xer6SwCHkluAqfvFN1c8TMNV6FBZ/RGWSHU193XF3x+8rf2Qw/iZDdG9DD
         vHD7ybwwyTKmba7bsORGFkcnuLA4kMX4S7co6um27kXJIAi6MO98SA2wExx/09WoYi
         htGNvXU9URDYqqzeBFv8Lvv1EqaNzaaUKlDDnqgKbTH2/MhBxN5AwTwxftvQ2lkBXM
         6M1tYg1AhKdQQjhnbvOqj6lx4WbOebUSglil6AV9fCmQhgbF7gJnSVyCjN8JpX1SDu
         CACJdxY3IruWtQQv2eK7Zg66rpmnQKNDvdI+Uw5jy8KK0veZdhC7qJWwZ1OGs/hBVH
         pr7D6TApQVDsw==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 12/01/2020 17:30, Dmitry Osipenko wrote:
> This patch fixes few dozens of coding style problems reported by
> checkpatch and prettifies code where makes sense.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/dma/tegra20-apb-dma.c | 276 ++++++++++++++++++----------------
>  1 file changed, 144 insertions(+), 132 deletions(-)
> 
> diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
> index dff21e80ffa4..7158bd3145c4 100644
> --- a/drivers/dma/tegra20-apb-dma.c
> +++ b/drivers/dma/tegra20-apb-dma.c

...

> @@ -1003,20 +1014,23 @@ static void tegra_dma_prep_wcount(struct tegra_dma_channel *tdc,
>  		ch_regs->csr |= len_field;
>  }
>  
> -static struct dma_async_tx_descriptor *tegra_dma_prep_slave_sg(
> -	struct dma_chan *dc, struct scatterlist *sgl, unsigned int sg_len,
> -	enum dma_transfer_direction direction, unsigned long flags,
> -	void *context)
> +static struct dma_async_tx_descriptor *
> +tegra_dma_prep_slave_sg(struct dma_chan *dc,
> +			struct scatterlist *sgl,
> +			unsigned int sg_len,
> +			enum dma_transfer_direction direction,
> +			unsigned long flags,
> +			void *context)
>  {
>  	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
> +	struct tegra_dma_sg_req *sg_req = NULL;
> +	u32 csr, ahb_seq, apb_ptr, apb_seq;
> +	enum dma_slave_buswidth slave_bw;
>  	struct tegra_dma_desc *dma_desc;
> -	unsigned int i;
> -	struct scatterlist *sg;
> -	unsigned long csr, ahb_seq, apb_ptr, apb_seq;
>  	struct list_head req_list;
> -	struct tegra_dma_sg_req  *sg_req = NULL;
> -	u32 burst_size;
> -	enum dma_slave_buswidth slave_bw;
> +	struct scatterlist *sg;
> +	unsigned int burst_size;
> +	unsigned int i;

This is not really consistent with the rest of the changes by having 'i'
and 'burst_size' on separate lines.

>  
>  	if (!tdc->config_init) {
>  		dev_err(tdc2dev(tdc), "DMA channel is not configured\n");
> @@ -1028,7 +1042,7 @@ static struct dma_async_tx_descriptor *tegra_dma_prep_slave_sg(
>  	}
>  
>  	if (get_transfer_param(tdc, direction, &apb_ptr, &apb_seq, &csr,
> -				&burst_size, &slave_bw) < 0)
> +			       &burst_size, &slave_bw) < 0)
>  		return NULL;
>  
>  	INIT_LIST_HEAD(&req_list);
> @@ -1074,7 +1088,7 @@ static struct dma_async_tx_descriptor *tegra_dma_prep_slave_sg(
>  		len = sg_dma_len(sg);
>  
>  		if ((len & 3) || (mem & 3) ||
> -				(len > tdc->tdma->chip_data->max_dma_count)) {
> +		    len > tdc->tdma->chip_data->max_dma_count) {
>  			dev_err(tdc2dev(tdc),
>  				"DMA length/memory address is not supported\n");
>  			tegra_dma_desc_put(tdc, dma_desc);
> @@ -1126,20 +1140,21 @@ static struct dma_async_tx_descriptor *tegra_dma_prep_slave_sg(
>  	return &dma_desc->txd;
>  }
>  
> -static struct dma_async_tx_descriptor *tegra_dma_prep_dma_cyclic(
> -	struct dma_chan *dc, dma_addr_t buf_addr, size_t buf_len,
> -	size_t period_len, enum dma_transfer_direction direction,
> -	unsigned long flags)
> +static struct dma_async_tx_descriptor *
> +tegra_dma_prep_dma_cyclic(struct dma_chan *dc, dma_addr_t buf_addr,
> +			  size_t buf_len,
> +			  size_t period_len,
> +			  enum dma_transfer_direction direction,
> +			  unsigned long flags)
>  {
>  	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
> -	struct tegra_dma_desc *dma_desc = NULL;
>  	struct tegra_dma_sg_req *sg_req = NULL;
> -	unsigned long csr, ahb_seq, apb_ptr, apb_seq;
> -	int len;
> -	size_t remain_len;
> -	dma_addr_t mem = buf_addr;
> -	u32 burst_size;
> +	u32 csr, ahb_seq, apb_ptr, apb_seq;
>  	enum dma_slave_buswidth slave_bw;
> +	struct tegra_dma_desc *dma_desc;
> +	dma_addr_t mem = buf_addr;
> +	unsigned int burst_size;
> +	size_t len, remain_len;
>  
>  	if (!buf_len || !period_len) {
>  		dev_err(tdc2dev(tdc), "Invalid buffer/period len\n");
> @@ -1173,13 +1188,13 @@ static struct dma_async_tx_descriptor *tegra_dma_prep_dma_cyclic(
>  
>  	len = period_len;
>  	if ((len & 3) || (buf_addr & 3) ||
> -			(len > tdc->tdma->chip_data->max_dma_count)) {
> +	    len > tdc->tdma->chip_data->max_dma_count) {
>  		dev_err(tdc2dev(tdc), "Req len/mem address is not correct\n");
>  		return NULL;
>  	}
>  
>  	if (get_transfer_param(tdc, direction, &apb_ptr, &apb_seq, &csr,
> -				&burst_size, &slave_bw) < 0)
> +			       &burst_size, &slave_bw) < 0)
>  		return NULL;
>  
>  	ahb_seq = TEGRA_APBDMA_AHBSEQ_INTR_ENB;
> @@ -1269,7 +1284,6 @@ static int tegra_dma_alloc_chan_resources(struct dma_chan *dc)
>  	int ret;
>  
>  	dma_cookie_init(&tdc->dma_chan);
> -	tdc->config_init = false;

Why is this removed? Does not seem to belong in this patch.

Cheers
Jon

-- 
nvpublic
