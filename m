Return-Path: <dmaengine+bounces-9713-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PyFF01zymlQ9AUAu9opvQ
	(envelope-from <dmaengine+bounces-9713-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 14:57:49 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 198E235B662
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 14:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 821E430156F7
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 12:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B473D2FF0;
	Mon, 30 Mar 2026 12:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WfkRN5aC"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83E63D1CB3;
	Mon, 30 Mar 2026 12:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774875306; cv=none; b=hO9lBEqKp7ULnOtKYM2bjiLOipASmLO3aa8+Ncq9qLDABuvvMcJNSEucIeMVoNxM02KGq64jYQsTn+TDonwV5aXQs6rEQenBtjcRO5J5elSxfVYLqKN5zxFRYRZOvIT5w6XJWU412HWTqmUA1k4IPTVLzx95PVSV5hDk1XP3dCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774875306; c=relaxed/simple;
	bh=R3YvVBoJbN9lPtFjocI0Duh7724R1ylPOyLBNcDb1zc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jwn+LldhOQe6Ah6tAGJkaHqHeQXJIbq4TPNksU0ULjaylaQGWlHP3oM7EkS9AaNfma4nck9Meq39yOIfQMORihalQcw6rKOmzDBgFg/SySX0RKkvaAsgYwMBy7QmUWAko6ORRILB4Ni03d8hvDZlR9m6Ib5zRnGDPqWcd9EA7cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WfkRN5aC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FDD4C4CEF7;
	Mon, 30 Mar 2026 12:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774875305;
	bh=R3YvVBoJbN9lPtFjocI0Duh7724R1ylPOyLBNcDb1zc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WfkRN5aCWVLbI0R2daRo0rZ+06XRIjrYv7LxhrUjOHEvJuy9DY71yL4PDIn1ltHYn
	 oA7TQYJZMTUjC5r30E1AXuCHMB2kT5pTvdPo8jR693BYbH0XMYjKXjGnmAEs+Od1sI
	 8ELrYYr7F9Y9nVsQky8x1V0ESQ/fheGt25dOdPyKmI6V4vgkzZaOALyKx+FSRZF9TI
	 hcz8JWD03FFU5v072uUigXc+fxpgPGrFRjEjB1ig6jLllJ1O7sxLrMk2C9obw97cGL
	 kIMspojUjJAupYkVX7h0yQtCFXDYnz1D1dtXu9Ay1NAEe3s05m4f9n+GB+O+PzkjwN
	 8Bs+mc/9afXVA==
Date: Mon, 30 Mar 2026 18:24:50 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Thara Gopinath <thara.gopinath@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Udit Tiwari <quic_utiwari@quicinc.com>, 
	Md Sadre Alam <mdalam@qti.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Peter Ujfalusi <peter.ujfalusi@gmail.com>, Michal Simek <michal.simek@amd.com>, 
	Frank Li <Frank.Li@kernel.org>, dmaengine@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, brgl@kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v14 05/12] dmaengine: qcom: bam_dma: add support for BAM
 locking
Message-ID: <ho3e26nrbz6ppxvs6cq2q76i2h6zpbbrssyekvuzc6e3koupvs@fpajvjgb2qjq>
References: <20260323-qcom-qce-cmd-descr-v14-0-f323af411274@oss.qualcomm.com>
 <20260323-qcom-qce-cmd-descr-v14-5-f323af411274@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260323-qcom-qce-cmd-descr-v14-5-f323af411274@oss.qualcomm.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9713-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,linaro.org,amd.com,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mani@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 198E235B662
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 04:17:11PM +0100, Bartosz Golaszewski wrote:
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

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
>  drivers/dma/qcom/bam_dma.c       | 165 ++++++++++++++++++++++++++++++++++++++-
>  include/linux/dma/qcom_bam_dma.h |  10 +++
>  2 files changed, 171 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
> index 83491e7c2f17d8c9d12a1a055baea7e3a0a75a53..309681e798d2e44992e3d20679c3a7564ad8f29e 100644
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
> @@ -391,6 +395,13 @@ struct bam_chan {
>  	struct list_head desc_list;
>  
>  	struct list_head node;
> +
> +	/* BAM locking infrastructure */
> +	phys_addr_t scratchpad_addr;
> +	struct scatterlist lock_sg;
> +	struct scatterlist unlock_sg;
> +	struct bam_cmd_element lock_ce;
> +	struct bam_cmd_element unlock_ce;
>  };
>  
>  static inline struct bam_chan *to_bam_chan(struct dma_chan *common)
> @@ -652,6 +663,32 @@ static int bam_slave_config(struct dma_chan *chan,
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
> +		/*
> +		 * The client wants to use locking but this BAM version doesn't
> +		 * support it. Don't return an error here as this will stop the
> +		 * client from using DMA at all for no reason.
> +		 */
> +		return 0;
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
> @@ -668,6 +705,7 @@ static struct dma_async_tx_descriptor *bam_prep_slave_sg(struct dma_chan *chan,
>  	void *context)
>  {
>  	struct bam_chan *bchan = to_bam_chan(chan);
> +	struct dma_async_tx_descriptor *tx_desc;
>  	struct bam_device *bdev = bchan->bdev;
>  	struct bam_async_desc *async_desc;
>  	struct scatterlist *sg;
> @@ -723,7 +761,12 @@ static struct dma_async_tx_descriptor *bam_prep_slave_sg(struct dma_chan *chan,
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
> @@ -1012,13 +1055,116 @@ static void bam_apply_new_config(struct bam_chan *bchan,
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
> +		return ERR_PTR(-ENOMEM);
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
> +		return ERR_PTR(-ENOMEM);
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
> +	if (ret) {
> +		dma_unmap_sg(chan->slave, sg, 1, DMA_TO_DEVICE);
> +		kfree(async_desc);
> +		return ERR_PTR(ret);
> +	}
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
> +	if (IS_ERR(lock_desc))
> +		return PTR_ERR(lock_desc);
> +
> +	if (lock)
> +		list_add(&lock_desc->vd.node, &bchan->vc.desc_issued);
> +	else
> +		list_add_tail(&lock_desc->vd.node, &bchan->vc.desc_issued);
> +
> +	return 0;
> +}
> +
> +static void bam_setup_pipe_lock(struct bam_chan *bchan)
> +{
> +	if (bam_do_setup_pipe_lock(bchan, true) || bam_do_setup_pipe_lock(bchan, false))
> +		dev_err(bchan->vc.chan.slave, "Failed to setup BAM pipe lock descriptors");
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
>  	struct bam_async_desc *async_desc = NULL;
>  	struct bam_desc_hw *desc;
> @@ -1030,6 +1176,9 @@ static void bam_start_dma(struct bam_chan *bchan)
>  
>  	lockdep_assert_held(&bchan->vc.lock);
>  
> +	bam_setup_pipe_lock(bchan);
> +
> +	vd = vchan_next_desc(&bchan->vc);
>  	if (!vd)
>  		return;
>  
> @@ -1157,8 +1306,15 @@ static void bam_issue_pending(struct dma_chan *chan)
>   */
>  static void bam_dma_free_desc(struct virt_dma_desc *vd)
>  {
> -	struct bam_async_desc *async_desc = container_of(vd,
> -			struct bam_async_desc, vd);
> +	struct bam_async_desc *async_desc = container_of(vd, struct bam_async_desc, vd);
> +	struct bam_desc_hw *desc = async_desc->desc;
> +	struct dma_chan *chan = vd->tx.chan;
> +	struct bam_chan *bchan = to_bam_chan(chan);
> +
> +	if (le16_to_cpu(desc->flags) & DESC_FLAG_LOCK)
> +		dma_unmap_sg(chan->slave, &bchan->lock_sg, 1, DMA_TO_DEVICE);
> +	else if (le16_to_cpu(desc->flags) & DESC_FLAG_UNLOCK)
> +		dma_unmap_sg(chan->slave, &bchan->unlock_sg, 1, DMA_TO_DEVICE);
>  
>  	kfree(async_desc);
>  }
> @@ -1350,6 +1506,7 @@ static int bam_dma_probe(struct platform_device *pdev)
>  	bdev->common.device_terminate_all = bam_dma_terminate_all;
>  	bdev->common.device_issue_pending = bam_issue_pending;
>  	bdev->common.device_tx_status = bam_tx_status;
> +	bdev->common.desc_metadata_modes = DESC_METADATA_CLIENT;
>  	bdev->common.dev = bdev->dev;
>  
>  	ret = dma_async_device_register(&bdev->common);
> diff --git a/include/linux/dma/qcom_bam_dma.h b/include/linux/dma/qcom_bam_dma.h
> index 68fc0e643b1b97fe4520d5878daa322b81f4f559..5f0d2a27face8223ecb77da33d9e050c1ff2622f 100644
> --- a/include/linux/dma/qcom_bam_dma.h
> +++ b/include/linux/dma/qcom_bam_dma.h
> @@ -34,6 +34,16 @@ enum bam_command_type {
>  	BAM_READ_COMMAND,
>  };
>  
> +/**
> + * struct bam_desc_metadata - DMA descriptor metadata specific to the BAM driver.
> + *
> + * @scratchpad_addr: Physical address to use for dummy write operations when
> + *                   queuing command descriptors with LOCK/UNLOCK bits set.
> + */
> +struct bam_desc_metadata {
> +	phys_addr_t scratchpad_addr;
> +};
> +
>  /*
>   * prep_bam_ce_le32 - Wrapper function to prepare a single BAM command
>   * element with the data already in le32 format.
> 
> -- 
> 2.47.3
> 

-- 
மணிவண்ணன் சதாசிவம்

