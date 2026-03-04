Return-Path: <dmaengine+bounces-9242-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLx/OwZKqGnysQAAu9opvQ
	(envelope-from <dmaengine+bounces-9242-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 04 Mar 2026 16:04:38 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0342022FF
	for <lists+dmaengine@lfdr.de>; Wed, 04 Mar 2026 16:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 83B4B3057EF5
	for <lists+dmaengine@lfdr.de>; Wed,  4 Mar 2026 14:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2803B4EB2;
	Wed,  4 Mar 2026 14:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f6MmgnWD"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4881425B30D;
	Wed,  4 Mar 2026 14:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772636029; cv=none; b=oZscLGCV8Cle2GQBgN+iEoIfz6oy3aBAsJuLb2OTexOA7ImGSMkMkTan7ilOyhcrAv+dFCKp/UoLdrwGkE8TYwR2Unp4HXQ9b9cKu3wxh9SCd8AtoPm8WUQsy36vZi+i9rnU5geezLVJSAu4n0uTU0Mn5GGZ6ir6RdSN4L5wuQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772636029; c=relaxed/simple;
	bh=BQ44oQAbUgWr8U493meAVTfSHv7WjBkib8olnp0zRU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fwO0KKnpLN4Mo/AyZ9xEb5p64TP+bZW9ikbmEh22bWArykB14eOoRdLKeBeswcHZL+1Dm2ZZBOfYHYRNvJoKyWScvQMKFiegpkNbY/OZygKoVqTXEbP/1EgSU5kiM0kdc8EWCMilVLFbffh6FdOlRhvuXU4r+ryhadFWyHX2PYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f6MmgnWD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4591BC4CEF7;
	Wed,  4 Mar 2026 14:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772636028;
	bh=BQ44oQAbUgWr8U493meAVTfSHv7WjBkib8olnp0zRU8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f6MmgnWD9JwZT5Tvq6TfWT4O2Q0Ys4L4GsXTR99rvN4VdJSfEj4ZluNmAQMjsZdxp
	 V+DtoAa1YNw7+qyrec0lX+nJFl7SrGE4eD/3irtT21i9lHBv65L+TYP9+yAb5XnS2c
	 ii/X5EXVyth4FxwEx9IZk5taVpjq8CK4yhqtt7WdaaM7MW8xFIZnzobXi7X3qX+/Z0
	 VyurzjP7sF2JONPbrejSJI8uOkRAalAjh9N3ZKSMLGGDiPyWcFTMVECa3/jJjnyI0V
	 gp3jyR/fUwsIuD+Hpo/UMOBhQXYANsZpjjQDEKWr1J392kst//oRBLVVnd9k4VL5FB
	 oY+zrqBmrPvhg==
Date: Wed, 4 Mar 2026 20:23:45 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Udit Tiwari <quic_utiwari@quicinc.com>,
	Daniel Perez-Zoghbi <dperezzo@quicinc.com>,
	Md Sadre Alam <mdalam@qti.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Michal Simek <michal.simek@amd.com>, Frank Li <Frank.Li@kernel.org>,
	dmaengine@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	brgl@kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH RFC v11 12/12] dmaengine: qcom: bam_dma: add support for
 BAM locking
Message-ID: <aahHeR9j7q4_ynYK@vaman>
References: <20260302-qcom-qce-cmd-descr-v11-0-4bf1f5db4802@oss.qualcomm.com>
 <20260302-qcom-qce-cmd-descr-v11-12-4bf1f5db4802@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302-qcom-qce-cmd-descr-v11-12-4bf1f5db4802@oss.qualcomm.com>
X-Rspamd-Queue-Id: 0D0342022FF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9242-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,kernel.org,amd.com,vger.kernel.org,lists.infradead.org,linaro.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,qualcomm.com:email]
X-Rspamd-Action: no action

On 02-03-26, 16:57, Bartosz Golaszewski wrote:
> Add support for BAM pipe locking. To that end: when starting the DMA on
> an RX channel - wrap the already issued descriptors with additional
> command descriptors performing dummy writes to the base register
> supplied by the client via dmaengine_slave_config() (if any) alongside
> the lock/unlock HW flags.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
>  drivers/dma/qcom/bam_dma.c | 100 ++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 99 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
> index 83491e7c2f17d8c9d12a1a055baea7e3a0a75a53..b149cbe9613f0bdc8e26cae4f0cc6922997480d5 100644
> --- a/drivers/dma/qcom/bam_dma.c
> +++ b/drivers/dma/qcom/bam_dma.c
> @@ -28,11 +28,13 @@
>  #include <linux/clk.h>
>  #include <linux/device.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/dma/qcom_bam_dma.h>
>  #include <linux/dmaengine.h>
>  #include <linux/init.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/kernel.h>
> +#include <linux/lockdep.h>
>  #include <linux/module.h>
>  #include <linux/of_address.h>
>  #include <linux/of_dma.h>
> @@ -60,6 +62,8 @@ struct bam_desc_hw {
>  #define DESC_FLAG_EOB BIT(13)
>  #define DESC_FLAG_NWD BIT(12)
>  #define DESC_FLAG_CMD BIT(11)
> +#define DESC_FLAG_LOCK BIT(10)
> +#define DESC_FLAG_UNLOCK BIT(9)
>  
>  struct bam_async_desc {
>  	struct virt_dma_desc vd;
> @@ -391,6 +395,12 @@ struct bam_chan {
>  	struct list_head desc_list;
>  
>  	struct list_head node;
> +
> +	/* BAM locking infrastructure */
> +	struct scatterlist lock_sg;
> +	struct scatterlist unlock_sg;
> +	struct bam_cmd_element lock_ce;
> +	struct bam_cmd_element unlock_ce;
>  };
>  
>  static inline struct bam_chan *to_bam_chan(struct dma_chan *common)
> @@ -1012,14 +1022,92 @@ static void bam_apply_new_config(struct bam_chan *bchan,
>  	bchan->reconfigure = 0;
>  }
>  
> +static struct bam_async_desc *
> +bam_make_lock_desc(struct bam_chan *bchan, struct scatterlist *sg,
> +		   struct bam_cmd_element *ce, unsigned int flag)
> +{
> +	struct dma_chan *chan = &bchan->vc.chan;
> +	struct bam_async_desc *async_desc;
> +	struct bam_desc_hw *desc;
> +	struct virt_dma_desc *vd;
> +	struct virt_dma_chan *vc;
> +	unsigned int mapped;
> +	dma_cookie_t cookie;
> +	int ret;
> +
> +	async_desc = kzalloc_flex(*async_desc, desc, 1, GFP_NOWAIT);
> +	if (!async_desc) {
> +		dev_err(bchan->bdev->dev, "failed to allocate the BAM lock descriptor\n");
> +		return NULL;
> +	}
> +
> +	async_desc->num_desc = 1;
> +	async_desc->curr_desc = async_desc->desc;
> +	async_desc->dir = DMA_MEM_TO_DEV;
> +
> +	desc = async_desc->desc;
> +
> +	bam_prep_ce_le32(ce, bchan->slave.dst_addr, BAM_WRITE_COMMAND, 0);
> +	sg_set_buf(sg, ce, sizeof(*ce));
> +
> +	mapped = dma_map_sg_attrs(chan->slave, sg, 1, DMA_TO_DEVICE, DMA_PREP_CMD);
> +	if (!mapped) {
> +		kfree(async_desc);
> +		return NULL;
> +	}
> +
> +	desc->flags |= cpu_to_le16(DESC_FLAG_CMD | flag);
> +	desc->addr = sg_dma_address(sg);
> +	desc->size = sizeof(struct bam_cmd_element);
> +
> +	vc = &bchan->vc;
> +	vd = &async_desc->vd;
> +
> +	dma_async_tx_descriptor_init(&vd->tx, &vc->chan);
> +	vd->tx.flags = DMA_PREP_CMD;
> +	vd->tx.desc_free = vchan_tx_desc_free;
> +	vd->tx_result.result = DMA_TRANS_NOERROR;
> +	vd->tx_result.residue = 0;
> +
> +	cookie = dma_cookie_assign(&vd->tx);
> +	ret = dma_submit_error(cookie);

I am not sure I understand this.

At start you add a descriptor in the queue, ideally which should be
queued after the existing descriptors are completed!

Also I thought you want to append Pipe cmd to descriptors, why not do
this while preparing the descriptors and add the pipe cmd and start and
end of the sequence when you prepare... This was you dont need to create
a cookie like this


> +	if (ret)
> +		return NULL;
> +
> +	return async_desc;
> +}
> +
> +static int bam_setup_pipe_lock(struct bam_chan *bchan)
> +{
> +	struct bam_async_desc *lock_desc, *unlock_desc;
> +
> +	lock_desc = bam_make_lock_desc(bchan, &bchan->lock_sg,
> +				       &bchan->lock_ce, DESC_FLAG_LOCK);
> +	if (!lock_desc)
> +		return -ENOMEM;
> +
> +	unlock_desc = bam_make_lock_desc(bchan, &bchan->unlock_sg,
> +					 &bchan->unlock_ce, DESC_FLAG_UNLOCK);
> +	if (!unlock_desc) {
> +		kfree(lock_desc);
> +		return -ENOMEM;
> +	}
> +
> +	list_add(&lock_desc->vd.node, &bchan->vc.desc_issued);
> +	list_add_tail(&unlock_desc->vd.node, &bchan->vc.desc_issued);
> +
> +	return 0;
> +}
> +
>  /**
>   * bam_start_dma - start next transaction
>   * @bchan: bam dma channel
>   */
>  static void bam_start_dma(struct bam_chan *bchan)
>  {
> -	struct virt_dma_desc *vd = vchan_next_desc(&bchan->vc);
> +	struct virt_dma_desc *vd;
>  	struct bam_device *bdev = bchan->bdev;
> +	const struct bam_device_data *bdata = bdev->dev_data;
>  	struct bam_async_desc *async_desc = NULL;
>  	struct bam_desc_hw *desc;
>  	struct bam_desc_hw *fifo = PTR_ALIGN(bchan->fifo_virt,
> @@ -1030,6 +1118,16 @@ static void bam_start_dma(struct bam_chan *bchan)
>  
>  	lockdep_assert_held(&bchan->vc.lock);
>  
> +	if (bdata->pipe_lock_supported && bchan->slave.dst_addr &&
> +	    bchan->slave.direction == DMA_MEM_TO_DEV) {
> +		ret = bam_setup_pipe_lock(bchan);
> +		if (ret) {
> +			dev_err(bdev->dev, "Failed to set up the BAM lock\n");
> +			return;
> +		}
> +	}
> +
> +	vd = vchan_next_desc(&bchan->vc);
>  	if (!vd)
>  		return;
>  
> 
> -- 
> 2.47.3

-- 
~Vinod

