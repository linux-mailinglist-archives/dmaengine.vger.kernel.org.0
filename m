Return-Path: <dmaengine+bounces-9714-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id hUb8FI92ymnk9AUAu9opvQ
	(envelope-from <dmaengine+bounces-9714-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 15:11:43 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C813935BB32
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 15:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1FC6F301F7BA
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 13:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88993D3338;
	Mon, 30 Mar 2026 13:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="td4OboJY"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9391F3CCA19;
	Mon, 30 Mar 2026 13:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774876139; cv=none; b=jA5lU0eqhxICY8ywS3Wbvn242VyUfaoovX9THpbwiFdyHJcIIHwp4pnHtzl3hDUd2XzvHKCaLeWbCcFWJf4nvAq6EvYqcIyIcweRzHJYcdpZ/5O6AE3REA/pxyPLgJZgkLxu6VBiabOpzojob6kp5myzX77GosJT9GgGZnAlpV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774876139; c=relaxed/simple;
	bh=P1BpTbax6M73OF8zBNBNgT5xJc7xmzDy4nLO8K3ghYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r+gWIXdHw/4AiL70vispAulOjWR8TVltAanBlaseeujTqD0dAvhv2LM3QsaOaVU2guSzxnc6RMk/kEZJfc4G3+QfV4WUyj853UtN4P6nKG8VR0VGb2UVoW1XO6eTdOVPHVugFW8x905MvRboyf6LlW9cbUfEeDdEIZRN1Sfb/Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=td4OboJY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4B45C4CEF7;
	Mon, 30 Mar 2026 13:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774876139;
	bh=P1BpTbax6M73OF8zBNBNgT5xJc7xmzDy4nLO8K3ghYg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=td4OboJY+ln55L4NUvUODmhBu39Dimkrrq4qJnQPPyVlo4pZgunTMbNlewXD7OSLr
	 xMjBanH41pEHlZET1+PrkS1eFIOrzhNQntvEDLo4bjsTY+gaNK9zsWuAtFIMD8D1pY
	 hDkaCQqjJ+DsxbxBg11HXCeneLdXtvKiVbUX6vkQLdk80M460PuzorTKAPax2ajPwQ
	 jCEM4dZUyD3oYT9PieAihlA4TkpCr8UmGJsIL8DqAbcNW5GK7Vg+GFIc4s38OxVpSG
	 G1st0jI7Op4Gno/QH8c28BJXKQaitnqX6/uJ7ehzU+LK5/8iGoTdwKFCQpru6rUqtE
	 QnI3GS83xtMSg==
Date: Mon, 30 Mar 2026 18:38:45 +0530
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
Subject: Re: [PATCH v14 12/12] crypto: qce - Communicate the base physical
 address to the dmaengine
Message-ID: <ulhiioxcb5opf4ab2qqqs7lkekkfv6nmmywq2gwbrxl6vgmx36@k3iwiw4cxl4x>
References: <20260323-qcom-qce-cmd-descr-v14-0-f323af411274@oss.qualcomm.com>
 <20260323-qcom-qce-cmd-descr-v14-12-f323af411274@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260323-qcom-qce-cmd-descr-v14-12-f323af411274@oss.qualcomm.com>
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
	TAGGED_FROM(0.00)[bounces-9714-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email]
X-Rspamd-Queue-Id: C813935BB32
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 04:17:18PM +0100, Bartosz Golaszewski wrote:
> In order to communicate to the BAM DMA engine which address should be
> used as a scratchpad for dummy writes related to BAM pipe locking,
> fill out and attach the provided metadata struct to the descriptor as
> well as mark the RX channel as such using the slave config struct.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
>  drivers/crypto/qce/dma.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/crypto/qce/dma.c b/drivers/crypto/qce/dma.c
> index 5c42fc7ddf01e11a6562d272ba7c90c906e0e312..635208947668667765e6accf9ef02100746c0f9a 100644
> --- a/drivers/crypto/qce/dma.c
> +++ b/drivers/crypto/qce/dma.c
> @@ -11,6 +11,7 @@
>  
>  #include "core.h"
>  #include "dma.h"
> +#include "regs-v5.h"
>  
>  #define QCE_IGNORE_BUF_SZ		(2 * QCE_BAM_BURST_SIZE)
>  #define QCE_BAM_CMD_SGL_SIZE		128
> @@ -43,6 +44,7 @@ void qce_clear_bam_transaction(struct qce_device *qce)
>  
>  int qce_submit_cmd_desc(struct qce_device *qce)
>  {
> +	struct bam_desc_metadata meta = { .scratchpad_addr = qce->base_phys + REG_VERSION };
>  	struct qce_desc_info *qce_desc = qce->dma.bam_txn->desc;
>  	struct qce_bam_transaction *bam_txn = qce->dma.bam_txn;
>  	struct dma_async_tx_descriptor *dma_desc;
> @@ -64,6 +66,12 @@ int qce_submit_cmd_desc(struct qce_device *qce)
>  		return -ENOMEM;
>  	}
>  
> +	ret = dmaengine_desc_attach_metadata(dma_desc, &meta, 0);
> +	if (ret) {
> +		dma_unmap_sg(qce->dev, bam_txn->wr_sgl, bam_txn->wr_sgl_cnt, DMA_TO_DEVICE);
> +		return ret;
> +	}
> +
>  	qce_desc->dma_desc = dma_desc;
>  	cookie = dmaengine_submit(qce_desc->dma_desc);
>  
> @@ -107,7 +115,9 @@ void qce_write_dma(struct qce_device *qce, unsigned int offset, u32 val)
>  int devm_qce_dma_request(struct qce_device *qce)
>  {
>  	struct qce_dma_data *dma = &qce->dma;
> +	struct dma_slave_config cfg = { };
>  	struct device *dev = qce->dev;
> +	int ret;
>  
>  	dma->txchan = devm_dma_request_chan(dev, "tx");
>  	if (IS_ERR(dma->txchan))
> @@ -119,6 +129,11 @@ int devm_qce_dma_request(struct qce_device *qce)
>  		return dev_err_probe(dev, PTR_ERR(dma->rxchan),
>  				     "Failed to get RX DMA channel\n");
>  
> +	cfg.direction = DMA_MEM_TO_DEV;
> +	ret = dmaengine_slave_config(dma->rxchan, &cfg);
> +	if (ret)
> +		return ret;
> +

I don't think this part is necessary. You are already passing the metadata above
and that should be sufficient for the BAM DMA driver to get the scratchpad
address. If any client drivers call dmaengine_slave_config() without
dmaengine_desc_attach_metadata(), and if the BAM DMA supports locking, then the
BAM driver should fail. Otherwise, continuing so would cause race conditions
among the BAM clients, which we are seeing right now on Qcom SDX targets with
both NAND driver in Linux and Modem trying to access NAND memory over BAM.

So please drop this and just use dmaengine_desc_attach_metadata().

- Mani

-- 
மணிவண்ணன் சதாசிவம்

