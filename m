Return-Path: <dmaengine+bounces-9240-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMeLGetEqGkfsAAAu9opvQ
	(envelope-from <dmaengine+bounces-9240-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 04 Mar 2026 15:42:51 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 27BB1201CEB
	for <lists+dmaengine@lfdr.de>; Wed, 04 Mar 2026 15:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C7ADB30B62DC
	for <lists+dmaengine@lfdr.de>; Wed,  4 Mar 2026 14:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68CF43ACF07;
	Wed,  4 Mar 2026 14:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZKU8NqA"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43435310779;
	Wed,  4 Mar 2026 14:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772635190; cv=none; b=UCkSQye1H4iVQRQeKjRymxgS7C9lkHH6p51gmYK4qXs1yB6wwc1DjQcwhZv3iMGYitQ+EH52rwuBj8RUrJ6eNrFwc2Cz46aqWc3pHTzNwLPq5h94Pcq15FStglV8+vchqa3QJ33TFsXODn7VUOMfUff0IOe5Ac1u5ouc44Na6mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772635190; c=relaxed/simple;
	bh=c9P1MJrJ5iSgDeKJm2NK7T0A2RucQmD2Vtmr+HlkX3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s/2rQraPlSf3o64aVONeAP1xuN+9kR9XokXI8xbyeKO4+qf0xw2TnV++w1TY6EaaK6gpTbECCBqMEaoI7FvCRSsPT56Dg2CxZobB1mB2dYNvXbyISu3peD/9qjG0pjGGHRl3YL2dbUdFww4VEMg8CaVh8Bz13KF1l76PwCXD1fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZKU8NqA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F371C2BC9E;
	Wed,  4 Mar 2026 14:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772635189;
	bh=c9P1MJrJ5iSgDeKJm2NK7T0A2RucQmD2Vtmr+HlkX3Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SZKU8NqA2W9FxhntXn0JhnExzE2aPOPFnhX203q5ThWEX3Jvx4XduNtRzD/QksrPa
	 oMZ+/mMEeXN6hqUmheqwvSrgdEdh3PzriZ68n353S4FvbSMqzipYmBlnVPRBhI6pNE
	 kdxLjT3tLl1SfLcsJ1jh+46HLzdU66Ey4yP6I1i+brkPoar3PWRX0V0sJ7oWim0F/8
	 JAk8HbtQ1mXHUTRZQgBrCEAsi08vAgbdqHzlnKhDXpC75w+/rsEsGvNWYKlCmZ/Xt9
	 1mCD1AjNcjak/1lTyXyJt5KjtzPezIyuihcVM89GKR4sZGSXmTJ0S7rVbWMP3mB+nm
	 lmm+UaOtjWHmw==
Date: Wed, 4 Mar 2026 20:09:46 +0530
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
Subject: Re: [PATCH RFC v11 07/12] crypto: qce - Communicate the base
 physical address to the dmaengine
Message-ID: <aahEMjjBRINXL5zC@vaman>
References: <20260302-qcom-qce-cmd-descr-v11-0-4bf1f5db4802@oss.qualcomm.com>
 <20260302-qcom-qce-cmd-descr-v11-7-4bf1f5db4802@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302-qcom-qce-cmd-descr-v11-7-4bf1f5db4802@oss.qualcomm.com>
X-Rspamd-Queue-Id: 27BB1201CEB
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-9240-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 02-03-26, 16:57, Bartosz Golaszewski wrote:
> In order to let the BAM DMA engine know which address is used for
> register I/O, call dmaengine_slave_config() after requesting the RX
> channel and use the config structure to pass that information to the
> dmaengine core. This is done ahead of extending the BAM driver with
> support for pipe locking, which requires performing dummy writes when
> passing the lock/unlock flags alongside the command descriptors.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
>  drivers/crypto/qce/core.c | 3 ++-
>  drivers/crypto/qce/dma.c  | 8 ++++++++
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
> index 2667fcd67fee826a44080da8f88a3e2abbb9b2cf..f6363d2a1231dcee0176824135389c42bec02153 100644
> --- a/drivers/crypto/qce/core.c
> +++ b/drivers/crypto/qce/core.c
> @@ -211,6 +211,8 @@ static int qce_crypto_probe(struct platform_device *pdev)
>  	if (IS_ERR(qce->base))
>  		return PTR_ERR(qce->base);
>  
> +	qce->base_phys = res->start;
> +
>  	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
>  	if (ret < 0)
>  		return ret;
> @@ -260,7 +262,6 @@ static int qce_crypto_probe(struct platform_device *pdev)
>  	qce->dma_size = resource_size(res);
>  	qce->base_dma = dma_map_resource(dev, res->start, qce->dma_size,
>  					 DMA_BIDIRECTIONAL, 0);
> -	qce->base_phys = res->start;
>  	ret = dma_mapping_error(dev, qce->base_dma);
>  	if (ret)
>  		return ret;
> diff --git a/drivers/crypto/qce/dma.c b/drivers/crypto/qce/dma.c
> index ba7a52fd4c6349d59c075c346f75741defeb6034..86f22c9a11f8a9e055c243dd8beaf1ded6f88bb9 100644
> --- a/drivers/crypto/qce/dma.c
> +++ b/drivers/crypto/qce/dma.c
> @@ -109,7 +109,9 @@ void qce_write_dma(struct qce_device *qce, unsigned int offset, u32 val)
>  int devm_qce_dma_request(struct qce_device *qce)
>  {
>  	struct qce_dma_data *dma = &qce->dma;
> +	struct dma_slave_config cfg = { };
>  	struct device *dev = qce->dev;
> +	int ret;
>  
>  	dma->txchan = devm_dma_request_chan(dev, "tx");
>  	if (IS_ERR(dma->txchan))
> @@ -121,6 +123,12 @@ int devm_qce_dma_request(struct qce_device *qce)
>  		return dev_err_probe(dev, PTR_ERR(dma->rxchan),
>  				     "Failed to get RX DMA channel\n");
>  
> +	cfg.dst_addr = qce->base_phys;
> +	cfg.direction = DMA_MEM_TO_DEV;

So is this the address of crypto engine address where dma data is
supposed to be pushed to..?

-- 
~Vinod

