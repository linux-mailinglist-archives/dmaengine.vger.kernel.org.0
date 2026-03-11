Return-Path: <dmaengine+bounces-9391-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0BA7KoJtsWlVvAIAu9opvQ
	(envelope-from <dmaengine+bounces-9391-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 11 Mar 2026 14:26:26 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D16D2647AE
	for <lists+dmaengine@lfdr.de>; Wed, 11 Mar 2026 14:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B25EE3025109
	for <lists+dmaengine@lfdr.de>; Wed, 11 Mar 2026 13:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307F43191A5;
	Wed, 11 Mar 2026 13:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DUynWAV1"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B491306D26;
	Wed, 11 Mar 2026 13:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773235584; cv=none; b=M+jXENKG8JYEK6ldZ+QjnaLSMZoidr5nrdTKLlcyScnfq64MRfMUyJHO8Xol2fTkUWAbvnH2f/EddEw0REBKDnbY1rNm6JdfdkmG+6gQ45uFVE98P7zJ/6TU1sX7ismMdR6JLlUy7FDlWtvuX0ZnLyHX+DCgmmTD8KpGd7NDqVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773235584; c=relaxed/simple;
	bh=W6oCAQ/s8C2Uj48lCZ2DxWtVPPiRrun1JCvwriBxabE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D5O03yd+pGklZhTpZ8JfhoyZhM0ip1oHJg+5PIXjCYONAw767IG99weJ3GWGE0QKxDSM9QxXvFoxM6YJ03e2f+4oR1ke9UU8uupA9/dgurvfVAr81gaGkupsM7sOisn+DwP/pO/JVqOjJ0t+pZSaefULbwi3dP/vRfVEbdp5Fnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DUynWAV1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76656C19425;
	Wed, 11 Mar 2026 13:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773235583;
	bh=W6oCAQ/s8C2Uj48lCZ2DxWtVPPiRrun1JCvwriBxabE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DUynWAV1b8Gc0x1sir2egYqoYc/O0i1lGxqk2g7OKX9FVTWDHZz9PK91J+UkSiTF7
	 2UNaZq0YNOYMWNnFI7/E5obzAvM2nG4YybgJf/ADQRT9naD5Fg5A7un+5yMXZfvcMm
	 IBs2kZjr+6JXEperRFNucEK+RWjwAUJ8FLA/029zKBd/Cy73loeTiqjpJr4SALTEA9
	 Y7Eu7jyuT7aoq/GT8/lEa4c+54dzXbSRl4t0sR9S7Un8O27CuDYek6ntMsgSumDWVW
	 B74As9Iz/BiFW2hupvE8zrvK//L3NO5Rdg1gnKH6qnknXMy52vkLNPOYb/i1i/eaXW
	 zzp0hOEFaKrdw==
Date: Wed, 11 Mar 2026 18:56:07 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Thara Gopinath <thara.gopinath@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Udit Tiwari <quic_utiwari@quicinc.com>, 
	Daniel Perez-Zoghbi <dperezzo@quicinc.com>, Md Sadre Alam <mdalam@qti.qualcomm.com>, 
	Dmitry Baryshkov <lumag@kernel.org>, Peter Ujfalusi <peter.ujfalusi@gmail.com>, 
	Michal Simek <michal.simek@amd.com>, Frank Li <Frank.Li@kernel.org>, dmaengine@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org, brgl@kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v12 05/12] dmaengine: qcom: bam_dma: add support for BAM
 locking
Message-ID: <s3qjgxji5ykznryf5n53zgvxm2qc5czsamguasdurfsrxbq43o@jpjkw5o7k5fo>
References: <20260310-qcom-qce-cmd-descr-v12-0-398f37f26ef0@oss.qualcomm.com>
 <20260310-qcom-qce-cmd-descr-v12-5-398f37f26ef0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260310-qcom-qce-cmd-descr-v12-5-398f37f26ef0@oss.qualcomm.com>
X-Rspamd-Queue-Id: 4D16D2647AE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9391-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,amd.com,vger.kernel.org,lists.infradead.org,linaro.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mani@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 04:44:19PM +0100, Bartosz Golaszewski wrote:
> Add support for BAM pipe locking. To that end: when starting DMA on an RX
> channel - prepend the existing queue of issued descriptors with an
> additional "dummy" command descriptor with the LOCK bit set. Once the
> transaction is done (no more issued descriptors), issue one more dummy
> descriptor with the UNLOCK bit.
> 
> We *must* wait until the transaction is signalled as done because we
> must not perform any writes into config registers while the engine is
> busy.
> 
> The dummy writes must be issued into a scratchpad register of the client
> so provide a mechanism to communicate the right address via descriptor
> metadata.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
>  drivers/dma/qcom/bam_dma.c       | 175 ++++++++++++++++++++++++++++++++++++++-
>  include/linux/dma/qcom_bam_dma.h |   4 +
>  2 files changed, 176 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
> index 83491e7c2f17d8c9d12a1a055baea7e3a0a75a53..627c85a2df4dcdbac247d831a4aef047c2189456 100644
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
> @@ -391,6 +395,14 @@ struct bam_chan {
>  	struct list_head desc_list;
>  
>  	struct list_head node;
> +
> +	/* BAM locking infrastructure */
> +	bool locked;

Nit: Move this boolean at the end to avoid hole in-between.

> +	phys_addr_t scratchpad_addr;
> +	struct scatterlist lock_sg;
> +	struct scatterlist unlock_sg;
> +	struct bam_cmd_element lock_ce;
> +	struct bam_cmd_element unlock_ce;
>  };
>  
>  static inline struct bam_chan *to_bam_chan(struct dma_chan *common)
> @@ -652,6 +664,27 @@ static int bam_slave_config(struct dma_chan *chan,
>  	return 0;
>  }
>  
> +static int bam_metadata_attach(struct dma_async_tx_descriptor *desc, void *data, size_t len)
> +{
> +	struct bam_chan *bchan = to_bam_chan(desc->chan);
> +	const struct bam_device_data *bdata = bchan->bdev->dev_data;
> +	struct bam_desc_metadata *metadata = data;
> +
> +	if (!data)
> +		return -EINVAL;
> +
> +	if (!bdata->pipe_lock_supported)
> +		return -EOPNOTSUPP;

I don't think you should error out if pipe lock is not supported. You can safely
return 0 so that the client can continue to do DMA. Otherwise, if the client
tries to do DMA on a non-pipe lock supported platform (a valid case), DMA will
fail.

There is also no incentive for the clients to know whether pipe lock is
supported or not as they can proceed anyway.

> +
> +	bchan->scratchpad_addr = metadata->scratchpad_addr;
> +
> +	return 0;
> +}
> +
> +static const struct dma_descriptor_metadata_ops bam_metadata_ops = {
> +	.attach = bam_metadata_attach,
> +};
> +
>  /**
>   * bam_prep_slave_sg - Prep slave sg transaction
>   *
> @@ -668,6 +701,7 @@ static struct dma_async_tx_descriptor *bam_prep_slave_sg(struct dma_chan *chan,
>  	void *context)
>  {
>  	struct bam_chan *bchan = to_bam_chan(chan);
> +	struct dma_async_tx_descriptor *tx_desc;
>  	struct bam_device *bdev = bchan->bdev;
>  	struct bam_async_desc *async_desc;
>  	struct scatterlist *sg;
> @@ -723,7 +757,12 @@ static struct dma_async_tx_descriptor *bam_prep_slave_sg(struct dma_chan *chan,
>  		} while (remainder > 0);
>  	}
>  
> -	return vchan_tx_prep(&bchan->vc, &async_desc->vd, flags);
> +	tx_desc = vchan_tx_prep(&bchan->vc, &async_desc->vd, flags);
> +	if (!tx_desc)
> +		return NULL;
> +
> +	tx_desc->metadata_ops = &bam_metadata_ops;
> +	return tx_desc;
>  }
>  
>  /**
> @@ -1012,6 +1051,112 @@ static void bam_apply_new_config(struct bam_chan *bchan,
>  	bchan->reconfigure = 0;
>  }
>  
> +static struct bam_async_desc *
> +bam_make_lock_desc(struct bam_chan *bchan, struct scatterlist *sg,
> +		   struct bam_cmd_element *ce, unsigned long flag)
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
> +	sg_init_table(sg, 1);
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
> +	bam_prep_ce_le32(ce, bchan->scratchpad_addr, BAM_WRITE_COMMAND, 0);
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
> +	if (ret)
> +		return NULL;

Why can't you pass the actual error pointer to the caller. Right now, caller
just treats all failures as -ENOMEM.

> +
> +	return async_desc;
> +}
> +
> +static int bam_do_setup_pipe_lock(struct bam_chan *bchan, bool lock)
> +{
> +	struct bam_device *bdev = bchan->bdev;
> +	const struct bam_device_data *bdata = bdev->dev_data;
> +	struct bam_async_desc *lock_desc;
> +	struct bam_cmd_element *ce;
> +	struct scatterlist *sgl;
> +	unsigned long flag;
> +
> +	lockdep_assert_held(&bchan->vc.lock);
> +
> +	if (!bdata->pipe_lock_supported || !bchan->scratchpad_addr ||
> +	    bchan->slave.direction != DMA_MEM_TO_DEV)
> +		return 0;
> +
> +	if (lock) {
> +		sgl = &bchan->lock_sg;
> +		ce = &bchan->lock_ce;
> +		flag = DESC_FLAG_LOCK;
> +	} else {
> +		sgl = &bchan->unlock_sg;
> +		ce = &bchan->unlock_ce;
> +		flag = DESC_FLAG_UNLOCK;
> +	}
> +
> +	lock_desc = bam_make_lock_desc(bchan, sgl, ce, flag);
> +	if (!lock_desc)
> +		return -ENOMEM;
> +
> +	if (lock)
> +		list_add(&lock_desc->vd.node, &bchan->vc.desc_issued);
> +	else
> +		list_add_tail(&lock_desc->vd.node, &bchan->vc.desc_issued);
> +
> +	bchan->locked = lock;
> +
> +	return 0;
> +}
> +
> +static int bam_setup_pipe_lock(struct bam_chan *bchan)
> +{
> +	return bam_do_setup_pipe_lock(bchan, true);
> +}
> +
> +static int bam_setup_pipe_unlock(struct bam_chan *bchan)
> +{
> +	return bam_do_setup_pipe_lock(bchan, false);
> +}
> +
>  /**
>   * bam_start_dma - start next transaction
>   * @bchan: bam dma channel
> @@ -1121,6 +1266,7 @@ static void bam_dma_work(struct work_struct *work)
>  	struct bam_device *bdev = from_work(bdev, work, work);
>  	struct bam_chan *bchan;
>  	unsigned int i;
> +	int ret;
>  
>  	/* go through the channels and kick off transactions */
>  	for (i = 0; i < bdev->num_channels; i++) {
> @@ -1128,6 +1274,13 @@ static void bam_dma_work(struct work_struct *work)
>  
>  		guard(spinlock_irqsave)(&bchan->vc.lock);
>  
> +		if (list_empty(&bchan->vc.desc_issued) && bchan->locked) {

I fully agree with Stephan that we cannot rely on this to ensure completion of
previous commands. But I can't help with the NWD behavior :/

> +			ret = bam_setup_pipe_unlock(bchan);

if (bam_setup_pipe_unlock())?

> +			if (ret)
> +				dev_err(bchan->vc.chan.slave,
> +					"Failed to set up the pipe unlock descriptor\n");
> +		}
> +
>  		if (!list_empty(&bchan->vc.desc_issued) && !IS_BUSY(bchan))
>  			bam_start_dma(bchan);
>  	}
> @@ -1142,9 +1295,17 @@ static void bam_dma_work(struct work_struct *work)
>  static void bam_issue_pending(struct dma_chan *chan)
>  {
>  	struct bam_chan *bchan = to_bam_chan(chan);
> +	int ret;
>  
>  	guard(spinlock_irqsave)(&bchan->vc.lock);
>  
> +	if (!bchan->locked) {
> +		ret = bam_setup_pipe_lock(bchan);

if (bam_setup_pipe_lock())?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

