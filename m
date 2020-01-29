Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E715114C937
	for <lists+dmaengine@lfdr.de>; Wed, 29 Jan 2020 12:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbgA2LDP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 29 Jan 2020 06:03:15 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:18362 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgA2LDO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 29 Jan 2020 06:03:14 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e3166620007>; Wed, 29 Jan 2020 03:02:58 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 29 Jan 2020 03:03:13 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 29 Jan 2020 03:03:13 -0800
Received: from [10.21.133.51] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 29 Jan
 2020 11:03:10 +0000
Subject: Re: [PATCH v5 08/14] dmaengine: tegra-apb: Fix coding style problems
To:     Dmitry Osipenko <digetx@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200123230325.3037-1-digetx@gmail.com>
 <20200123230325.3037-9-digetx@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <f724fd45-aa91-face-a267-5ea4caf6d8d5@nvidia.com>
Date:   Wed, 29 Jan 2020 11:03:09 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200123230325.3037-9-digetx@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580295778; bh=eXcasMxnEc7kq7pJ8X16W3TxEU9HluT89apQ11LWk6M=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=d/JKTV3NqmFDOwxGcKh7UvUrhvJnGSSfN+k/kncN4d7mjpu2e2OGKmYN6fplj4bGx
         BB8mw97WRAN8lnUhNTdUC/+v13YdKRgvfJdJDY5uwpGPDguvQUuNcwpdt9pMvxQs+p
         cf9g3R8nTKwi7SR3aPKcggZ4mK1Oe9cOjtIP7NSSN6kkofUM73nilBMGoxn55RkFNQ
         6UfL6bqLIKk0ho1HiKllJDU9Pyt2FcqdBJHy4l8KnDPynO8WEwqLHWx27om/ul5bHN
         hxC95MSC0cERB3Aglbgk1Xs9F/ZhcELVZvCugFCbXuSV4R6xe+5BariEf7n87qWAFh
         fW82N9F2t6qXQ==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 23/01/2020 23:03, Dmitry Osipenko wrote:
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
> @@ -59,7 +59,7 @@
>  #define TEGRA_APBDMA_STATUS_COUNT_MASK		0xFFFC
>  
>  #define TEGRA_APBDMA_CHAN_CSRE			0x00C
> -#define TEGRA_APBDMA_CHAN_CSRE_PAUSE		(1 << 31)
> +#define TEGRA_APBDMA_CHAN_CSRE_PAUSE		BIT(31)
>  
>  /* AHB memory address */
>  #define TEGRA_APBDMA_CHAN_AHBPTR		0x010
> @@ -120,21 +120,21 @@ struct tegra_dma;
>   * @support_separate_wcount_reg: Support separate word count register.
>   */
>  struct tegra_dma_chip_data {
> -	int nr_channels;
> -	int channel_reg_size;
> -	int max_dma_count;
> +	unsigned int nr_channels;
> +	unsigned int channel_reg_size;
> +	unsigned int max_dma_count;
>  	bool support_channel_pause;
>  	bool support_separate_wcount_reg;
>  };
>  
>  /* DMA channel registers */
>  struct tegra_dma_channel_regs {
> -	unsigned long	csr;
> -	unsigned long	ahb_ptr;
> -	unsigned long	apb_ptr;
> -	unsigned long	ahb_seq;
> -	unsigned long	apb_seq;
> -	unsigned long	wcount;
> +	u32 csr;
> +	u32 ahb_ptr;
> +	u32 apb_ptr;
> +	u32 ahb_seq;
> +	u32 apb_seq;
> +	u32 wcount;
>  };
>  
>  /*
> @@ -168,7 +168,7 @@ struct tegra_dma_desc {
>  	struct list_head		node;
>  	struct list_head		tx_list;
>  	struct list_head		cb_node;
> -	int				cb_count;
> +	unsigned int			cb_count;
>  };
>  
>  struct tegra_dma_channel;
> @@ -181,7 +181,7 @@ struct tegra_dma_channel {
>  	struct dma_chan		dma_chan;
>  	char			name[12];
>  	bool			config_init;
> -	int			id;
> +	unsigned int		id;
>  	void __iomem		*chan_addr;
>  	spinlock_t		lock;
>  	bool			busy;
> @@ -201,7 +201,7 @@ struct tegra_dma_channel {
>  	/* Channel-slave specific configuration */
>  	unsigned int slave_id;
>  	struct dma_slave_config dma_sconfig;
> -	struct tegra_dma_channel_regs	channel_reg;
> +	struct tegra_dma_channel_regs channel_reg;
>  };
>  
>  /* tegra_dma: Tegra DMA specific information */
> @@ -239,7 +239,7 @@ static inline u32 tdma_read(struct tegra_dma *tdma, u32 reg)
>  }
>  
>  static inline void tdc_write(struct tegra_dma_channel *tdc,
> -		u32 reg, u32 val)
> +			     u32 reg, u32 val)
>  {
>  	writel(val, tdc->chan_addr + reg);
>  }
> @@ -254,8 +254,8 @@ static inline struct tegra_dma_channel *to_tegra_dma_chan(struct dma_chan *dc)
>  	return container_of(dc, struct tegra_dma_channel, dma_chan);
>  }
>  
> -static inline struct tegra_dma_desc *txd_to_tegra_dma_desc(
> -		struct dma_async_tx_descriptor *td)
> +static inline struct tegra_dma_desc *
> +txd_to_tegra_dma_desc(struct dma_async_tx_descriptor *td)
>  {
>  	return container_of(td, struct tegra_dma_desc, txd);
>  }
> @@ -270,8 +270,7 @@ static int tegra_dma_runtime_suspend(struct device *dev);
>  static int tegra_dma_runtime_resume(struct device *dev);
>  
>  /* Get DMA desc from free list, if not there then allocate it.  */
> -static struct tegra_dma_desc *tegra_dma_desc_get(
> -		struct tegra_dma_channel *tdc)
> +static struct tegra_dma_desc *tegra_dma_desc_get(struct tegra_dma_channel *tdc)
>  {
>  	struct tegra_dma_desc *dma_desc;
>  	unsigned long flags;
> @@ -298,11 +297,12 @@ static struct tegra_dma_desc *tegra_dma_desc_get(
>  	dma_async_tx_descriptor_init(&dma_desc->txd, &tdc->dma_chan);
>  	dma_desc->txd.tx_submit = tegra_dma_tx_submit;
>  	dma_desc->txd.flags = 0;
> +
>  	return dma_desc;
>  }
>  
>  static void tegra_dma_desc_put(struct tegra_dma_channel *tdc,
> -		struct tegra_dma_desc *dma_desc)
> +			       struct tegra_dma_desc *dma_desc)
>  {
>  	unsigned long flags;
>  
> @@ -313,29 +313,29 @@ static void tegra_dma_desc_put(struct tegra_dma_channel *tdc,
>  	spin_unlock_irqrestore(&tdc->lock, flags);
>  }
>  
> -static struct tegra_dma_sg_req *tegra_dma_sg_req_get(
> -		struct tegra_dma_channel *tdc)
> +static struct tegra_dma_sg_req *
> +tegra_dma_sg_req_get(struct tegra_dma_channel *tdc)
>  {
> -	struct tegra_dma_sg_req *sg_req = NULL;
> +	struct tegra_dma_sg_req *sg_req;
>  	unsigned long flags;
>  
>  	spin_lock_irqsave(&tdc->lock, flags);
>  	if (!list_empty(&tdc->free_sg_req)) {
> -		sg_req = list_first_entry(&tdc->free_sg_req,
> -					typeof(*sg_req), node);
> +		sg_req = list_first_entry(&tdc->free_sg_req, typeof(*sg_req),
> +					  node);
>  		list_del(&sg_req->node);
>  		spin_unlock_irqrestore(&tdc->lock, flags);
>  		return sg_req;
>  	}
>  	spin_unlock_irqrestore(&tdc->lock, flags);
>  
> -	sg_req = kzalloc(sizeof(struct tegra_dma_sg_req), GFP_NOWAIT);
> +	sg_req = kzalloc(sizeof(*sg_req), GFP_NOWAIT);
>  
>  	return sg_req;
>  }
>  
>  static int tegra_dma_slave_config(struct dma_chan *dc,
> -		struct dma_slave_config *sconfig)
> +				  struct dma_slave_config *sconfig)
>  {
>  	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
>  
> @@ -352,11 +352,12 @@ static int tegra_dma_slave_config(struct dma_chan *dc,
>  		tdc->slave_id = sconfig->slave_id;
>  	}
>  	tdc->config_init = true;
> +
>  	return 0;
>  }
>  
>  static void tegra_dma_global_pause(struct tegra_dma_channel *tdc,
> -	bool wait_for_burst_complete)
> +				   bool wait_for_burst_complete)
>  {
>  	struct tegra_dma *tdma = tdc->tdma;
>  
> @@ -391,13 +392,13 @@ static void tegra_dma_global_resume(struct tegra_dma_channel *tdc)
>  }
>  
>  static void tegra_dma_pause(struct tegra_dma_channel *tdc,
> -	bool wait_for_burst_complete)
> +			    bool wait_for_burst_complete)
>  {
>  	struct tegra_dma *tdma = tdc->tdma;
>  
>  	if (tdma->chip_data->support_channel_pause) {
>  		tdc_write(tdc, TEGRA_APBDMA_CHAN_CSRE,
> -				TEGRA_APBDMA_CHAN_CSRE_PAUSE);
> +			  TEGRA_APBDMA_CHAN_CSRE_PAUSE);
>  		if (wait_for_burst_complete)
>  			udelay(TEGRA_APBDMA_BURST_COMPLETE_TIME);
>  	} else {
> @@ -409,17 +410,15 @@ static void tegra_dma_resume(struct tegra_dma_channel *tdc)
>  {
>  	struct tegra_dma *tdma = tdc->tdma;
>  
> -	if (tdma->chip_data->support_channel_pause) {
> +	if (tdma->chip_data->support_channel_pause)
>  		tdc_write(tdc, TEGRA_APBDMA_CHAN_CSRE, 0);
> -	} else {
> +	else
>  		tegra_dma_global_resume(tdc);
> -	}
>  }
>  
>  static void tegra_dma_stop(struct tegra_dma_channel *tdc)
>  {
> -	u32 csr;
> -	u32 status;
> +	u32 csr, status;
>  
>  	/* Disable interrupts */
>  	csr = tdc_read(tdc, TEGRA_APBDMA_CHAN_CSR);
> @@ -440,7 +439,7 @@ static void tegra_dma_stop(struct tegra_dma_channel *tdc)
>  }
>  
>  static void tegra_dma_start(struct tegra_dma_channel *tdc,
> -		struct tegra_dma_sg_req *sg_req)
> +			    struct tegra_dma_sg_req *sg_req)
>  {
>  	struct tegra_dma_channel_regs *ch_regs = &sg_req->ch_regs;
>  
> @@ -454,11 +453,11 @@ static void tegra_dma_start(struct tegra_dma_channel *tdc,
>  
>  	/* Start DMA */
>  	tdc_write(tdc, TEGRA_APBDMA_CHAN_CSR,
> -				ch_regs->csr | TEGRA_APBDMA_CSR_ENB);
> +		  ch_regs->csr | TEGRA_APBDMA_CSR_ENB);
>  }
>  
>  static void tegra_dma_configure_for_next(struct tegra_dma_channel *tdc,
> -		struct tegra_dma_sg_req *nsg_req)
> +					 struct tegra_dma_sg_req *nsg_req)
>  {
>  	unsigned long status;
>  
> @@ -492,9 +491,9 @@ static void tegra_dma_configure_for_next(struct tegra_dma_channel *tdc,
>  	tdc_write(tdc, TEGRA_APBDMA_CHAN_AHBPTR, nsg_req->ch_regs.ahb_ptr);
>  	if (tdc->tdma->chip_data->support_separate_wcount_reg)
>  		tdc_write(tdc, TEGRA_APBDMA_CHAN_WCOUNT,
> -						nsg_req->ch_regs.wcount);
> +			  nsg_req->ch_regs.wcount);
>  	tdc_write(tdc, TEGRA_APBDMA_CHAN_CSR,
> -				nsg_req->ch_regs.csr | TEGRA_APBDMA_CSR_ENB);
> +		  nsg_req->ch_regs.csr | TEGRA_APBDMA_CSR_ENB);
>  	nsg_req->configured = true;
>  	nsg_req->words_xferred = 0;
>  
> @@ -508,8 +507,7 @@ static void tdc_start_head_req(struct tegra_dma_channel *tdc)
>  	if (list_empty(&tdc->pending_sg_req))
>  		return;
>  
> -	sg_req = list_first_entry(&tdc->pending_sg_req,
> -					typeof(*sg_req), node);
> +	sg_req = list_first_entry(&tdc->pending_sg_req, typeof(*sg_req), node);
>  	tegra_dma_start(tdc, sg_req);
>  	sg_req->configured = true;
>  	sg_req->words_xferred = 0;
> @@ -518,34 +516,35 @@ static void tdc_start_head_req(struct tegra_dma_channel *tdc)
>  
>  static void tdc_configure_next_head_desc(struct tegra_dma_channel *tdc)
>  {
> -	struct tegra_dma_sg_req *hsgreq;
> -	struct tegra_dma_sg_req *hnsgreq;
> +	struct tegra_dma_sg_req *hsgreq, *hnsgreq;
>  
>  	if (list_empty(&tdc->pending_sg_req))
>  		return;
>  
>  	hsgreq = list_first_entry(&tdc->pending_sg_req, typeof(*hsgreq), node);
>  	if (!list_is_last(&hsgreq->node, &tdc->pending_sg_req)) {
> -		hnsgreq = list_first_entry(&hsgreq->node,
> -					typeof(*hnsgreq), node);
> +		hnsgreq = list_first_entry(&hsgreq->node, typeof(*hnsgreq),
> +					   node);
>  		tegra_dma_configure_for_next(tdc, hnsgreq);
>  	}
>  }
>  
> -static inline int get_current_xferred_count(struct tegra_dma_channel *tdc,
> -	struct tegra_dma_sg_req *sg_req, unsigned long status)
> +static inline unsigned int
> +get_current_xferred_count(struct tegra_dma_channel *tdc,
> +			  struct tegra_dma_sg_req *sg_req,
> +			  unsigned long status)
>  {
>  	return sg_req->req_len - (status & TEGRA_APBDMA_STATUS_COUNT_MASK) - 4;
>  }
>  
>  static void tegra_dma_abort_all(struct tegra_dma_channel *tdc)
>  {
> -	struct tegra_dma_sg_req *sgreq;
>  	struct tegra_dma_desc *dma_desc;
> +	struct tegra_dma_sg_req *sgreq;
>  
>  	while (!list_empty(&tdc->pending_sg_req)) {
> -		sgreq = list_first_entry(&tdc->pending_sg_req,
> -						typeof(*sgreq), node);
> +		sgreq = list_first_entry(&tdc->pending_sg_req, typeof(*sgreq),
> +					 node);
>  		list_move_tail(&sgreq->node, &tdc->free_sg_req);
>  		if (sgreq->last_sg) {
>  			dma_desc = sgreq->dma_desc;
> @@ -555,7 +554,7 @@ static void tegra_dma_abort_all(struct tegra_dma_channel *tdc)
>  			/* Add in cb list if it is not there. */
>  			if (!dma_desc->cb_count)
>  				list_add_tail(&dma_desc->cb_node,
> -							&tdc->cb_desc);
> +					      &tdc->cb_desc);
>  			dma_desc->cb_count++;
>  		}
>  	}
> @@ -563,9 +562,10 @@ static void tegra_dma_abort_all(struct tegra_dma_channel *tdc)
>  }
>  
>  static bool handle_continuous_head_request(struct tegra_dma_channel *tdc,
> -		struct tegra_dma_sg_req *last_sg_req, bool to_terminate)
> +					   struct tegra_dma_sg_req *last_sg_req,
> +					   bool to_terminate)
>  {
> -	struct tegra_dma_sg_req *hsgreq = NULL;
> +	struct tegra_dma_sg_req *hsgreq;
>  
>  	if (list_empty(&tdc->pending_sg_req)) {
>  		dev_err(tdc2dev(tdc), "DMA is running without req\n");
> @@ -589,14 +589,15 @@ static bool handle_continuous_head_request(struct tegra_dma_channel *tdc,
>  	/* Configure next request */
>  	if (!to_terminate)
>  		tdc_configure_next_head_desc(tdc);
> +
>  	return true;
>  }
>  
>  static void handle_once_dma_done(struct tegra_dma_channel *tdc,
> -	bool to_terminate)
> +				 bool to_terminate)
>  {
> -	struct tegra_dma_sg_req *sgreq;
>  	struct tegra_dma_desc *dma_desc;
> +	struct tegra_dma_sg_req *sgreq;
>  
>  	tdc->busy = false;
>  	sgreq = list_first_entry(&tdc->pending_sg_req, typeof(*sgreq), node);
> @@ -622,10 +623,10 @@ static void handle_once_dma_done(struct tegra_dma_channel *tdc,
>  }
>  
>  static void handle_cont_sngl_cycle_dma_done(struct tegra_dma_channel *tdc,
> -		bool to_terminate)
> +					    bool to_terminate)
>  {
> -	struct tegra_dma_sg_req *sgreq;
>  	struct tegra_dma_desc *dma_desc;
> +	struct tegra_dma_sg_req *sgreq;
>  	bool st;
>  
>  	sgreq = list_first_entry(&tdc->pending_sg_req, typeof(*sgreq), node);
> @@ -657,13 +658,13 @@ static void tegra_dma_tasklet(unsigned long data)
>  	struct tegra_dma_channel *tdc = (struct tegra_dma_channel *)data;
>  	struct dmaengine_desc_callback cb;
>  	struct tegra_dma_desc *dma_desc;
> +	unsigned int cb_count;
>  	unsigned long flags;
> -	int cb_count;
>  
>  	spin_lock_irqsave(&tdc->lock, flags);
>  	while (!list_empty(&tdc->cb_desc)) {
> -		dma_desc  = list_first_entry(&tdc->cb_desc,
> -					typeof(*dma_desc), cb_node);
> +		dma_desc = list_first_entry(&tdc->cb_desc, typeof(*dma_desc),
> +					    cb_node);
>  		list_del(&dma_desc->cb_node);
>  		dmaengine_desc_get_callback(&dma_desc->txd, &cb);
>  		cb_count = dma_desc->cb_count;
> @@ -681,8 +682,8 @@ static void tegra_dma_tasklet(unsigned long data)
>  static irqreturn_t tegra_dma_isr(int irq, void *dev_id)
>  {
>  	struct tegra_dma_channel *tdc = dev_id;
> -	unsigned long status;
>  	unsigned long flags;
> +	u32 status;
>  
>  	spin_lock_irqsave(&tdc->lock, flags);
>  
> @@ -697,8 +698,9 @@ static irqreturn_t tegra_dma_isr(int irq, void *dev_id)
>  	}
>  
>  	spin_unlock_irqrestore(&tdc->lock, flags);
> -	dev_info(tdc2dev(tdc),
> -		"Interrupt already served status 0x%08lx\n", status);
> +	dev_info(tdc2dev(tdc), "Interrupt already served status 0x%08x\n",
> +		 status);
> +
>  	return IRQ_NONE;
>  }
>  
> @@ -714,6 +716,7 @@ static dma_cookie_t tegra_dma_tx_submit(struct dma_async_tx_descriptor *txd)
>  	cookie = dma_cookie_assign(&dma_desc->txd);
>  	list_splice_tail_init(&dma_desc->tx_list, &tdc->pending_sg_req);
>  	spin_unlock_irqrestore(&tdc->lock, flags);
> +
>  	return cookie;
>  }
>  
> @@ -747,11 +750,10 @@ static void tegra_dma_issue_pending(struct dma_chan *dc)
>  static int tegra_dma_terminate_all(struct dma_chan *dc)
>  {
>  	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
> -	struct tegra_dma_sg_req *sgreq;
>  	struct tegra_dma_desc *dma_desc;
> +	struct tegra_dma_sg_req *sgreq;
>  	unsigned long flags;
> -	unsigned long status;
> -	unsigned long wcount;
> +	u32 status, wcount;
>  	bool was_busy;
>  
>  	spin_lock_irqsave(&tdc->lock, flags);
> @@ -777,8 +779,8 @@ static int tegra_dma_terminate_all(struct dma_chan *dc)
>  	tegra_dma_stop(tdc);
>  
>  	if (!list_empty(&tdc->pending_sg_req) && was_busy) {
> -		sgreq = list_first_entry(&tdc->pending_sg_req,
> -					typeof(*sgreq), node);
> +		sgreq = list_first_entry(&tdc->pending_sg_req, typeof(*sgreq),
> +					 node);
>  		sgreq->dma_desc->bytes_transferred +=
>  				get_current_xferred_count(tdc, sgreq, wcount);
>  	}
> @@ -788,12 +790,13 @@ static int tegra_dma_terminate_all(struct dma_chan *dc)
>  	tegra_dma_abort_all(tdc);
>  
>  	while (!list_empty(&tdc->cb_desc)) {
> -		dma_desc  = list_first_entry(&tdc->cb_desc,
> -					typeof(*dma_desc), cb_node);
> +		dma_desc = list_first_entry(&tdc->cb_desc, typeof(*dma_desc),
> +					    cb_node);
>  		list_del(&dma_desc->cb_node);
>  		dma_desc->cb_count = 0;
>  	}
>  	spin_unlock_irqrestore(&tdc->lock, flags);
> +
>  	return 0;
>  }
>  
> @@ -807,7 +810,7 @@ static void tegra_dma_synchronize(struct dma_chan *dc)
>  static unsigned int tegra_dma_sg_bytes_xferred(struct tegra_dma_channel *tdc,
>  					       struct tegra_dma_sg_req *sg_req)
>  {
> -	unsigned long status, wcount = 0;
> +	u32 status, wcount = 0;
>  
>  	if (!list_is_first(&sg_req->node, &tdc->pending_sg_req))
>  		return 0;
> @@ -864,7 +867,8 @@ static unsigned int tegra_dma_sg_bytes_xferred(struct tegra_dma_channel *tdc,
>  }
>  
>  static enum dma_status tegra_dma_tx_status(struct dma_chan *dc,
> -	dma_cookie_t cookie, struct dma_tx_state *txstate)
> +					   dma_cookie_t cookie,
> +					   struct dma_tx_state *txstate)
>  {
>  	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
>  	struct tegra_dma_desc *dma_desc;
> @@ -911,11 +915,12 @@ static enum dma_status tegra_dma_tx_status(struct dma_chan *dc,
>  
>  	trace_tegra_dma_tx_status(&tdc->dma_chan, cookie, txstate);
>  	spin_unlock_irqrestore(&tdc->lock, flags);
> +
>  	return ret;
>  }
>  
> -static inline int get_bus_width(struct tegra_dma_channel *tdc,
> -		enum dma_slave_buswidth slave_bw)
> +static inline unsigned int get_bus_width(struct tegra_dma_channel *tdc,
> +					 enum dma_slave_buswidth slave_bw)
>  {
>  	switch (slave_bw) {
>  	case DMA_SLAVE_BUSWIDTH_1_BYTE:
> @@ -928,16 +933,17 @@ static inline int get_bus_width(struct tegra_dma_channel *tdc,
>  		return TEGRA_APBDMA_APBSEQ_BUS_WIDTH_64;
>  	default:
>  		dev_warn(tdc2dev(tdc),
> -			"slave bw is not supported, using 32bits\n");
> +			 "slave bw is not supported, using 32bits\n");
>  		return TEGRA_APBDMA_APBSEQ_BUS_WIDTH_32;
>  	}
>  }
>  
> -static inline int get_burst_size(struct tegra_dma_channel *tdc,
> -	u32 burst_size, enum dma_slave_buswidth slave_bw, int len)
> +static inline unsigned int get_burst_size(struct tegra_dma_channel *tdc,
> +					  u32 burst_size,
> +					  enum dma_slave_buswidth slave_bw,
> +					  u32 len)
>  {
> -	int burst_byte;
> -	int burst_ahb_width;
> +	unsigned int burst_byte, burst_ahb_width;
>  
>  	/*
>  	 * burst_size from client is in terms of the bus_width.
> @@ -964,9 +970,12 @@ static inline int get_burst_size(struct tegra_dma_channel *tdc,
>  }
>  
>  static int get_transfer_param(struct tegra_dma_channel *tdc,
> -	enum dma_transfer_direction direction, unsigned long *apb_addr,
> -	unsigned long *apb_seq,	unsigned long *csr, unsigned int *burst_size,
> -	enum dma_slave_buswidth *slave_bw)
> +			      enum dma_transfer_direction direction,
> +			      u32 *apb_addr,
> +			      u32 *apb_seq,
> +			      u32 *csr,
> +			      unsigned int *burst_size,
> +			      enum dma_slave_buswidth *slave_bw)
>  {
>  	switch (direction) {
>  	case DMA_MEM_TO_DEV:
> @@ -987,13 +996,15 @@ static int get_transfer_param(struct tegra_dma_channel *tdc,
>  
>  	default:
>  		dev_err(tdc2dev(tdc), "DMA direction is not supported\n");
> -		return -EINVAL;
> +		break;
>  	}
> +
>  	return -EINVAL;
>  }
>  
>  static void tegra_dma_prep_wcount(struct tegra_dma_channel *tdc,
> -	struct tegra_dma_channel_regs *ch_regs, u32 len)
> +				  struct tegra_dma_channel_regs *ch_regs,
> +				  u32 len)
>  {
>  	u32 len_field = (len - 4) & 0xFFFC;
>  
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

Please put this in a separate patch. It is easily overlooked in this big
change.

Jon

-- 
nvpublic
