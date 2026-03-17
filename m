Return-Path: <dmaengine+bounces-9468-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kISGD0k4uWk8vgEAu9opvQ
	(envelope-from <dmaengine+bounces-9468-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 12:17:29 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF422A8982
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 12:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A060300B478
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 11:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950F93AA1A7;
	Tue, 17 Mar 2026 11:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BN4OvIHs"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705113A7F61;
	Tue, 17 Mar 2026 11:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773746001; cv=none; b=IOykh/usfmX+lGgQRsiOSn8Wn8bnFqf3TUc6+Yv1c3zWKHaUWcrzUXG2w0LoHBaSdCvG/T1YoMiVvnjEh/awx570M3Wy4IfHI6KX95tYbBZayNGpi1qxhdZMjji6ZothkDgd+UkMyOECCo7eQ0KbVhMEzuTO2JY2Gnkbvy4OWs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773746001; c=relaxed/simple;
	bh=A4k44UqySYK9sBzDZ65HlwjIbkEi1C81mQWx6Wneq/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QrLvMDPCnYNJzy1bqUgtSPVWBb3kxkamJoYyzM9EbCaooWScJcpfyRSjlzNXc9j+KdcTQDZlkBjsvnTFrkFJhroJKu9LJ2nrPKTdNtpS9DkSBJDmKtGLcVtucpw47ZcYqmM5PSIw9tCnDZ9/7F2cur9BU8nxtdLFM2sTTrSUJzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BN4OvIHs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9747DC4CEF7;
	Tue, 17 Mar 2026 11:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773746001;
	bh=A4k44UqySYK9sBzDZ65HlwjIbkEi1C81mQWx6Wneq/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BN4OvIHsgbwLgRezuXX+qMCFE0z812uNPJ9isuRxchmBDsKjWaXzTUTLVWnM7Bfdd
	 vMfHaG1KT8/XVIs1YNXau89CSWykOVGhdZcx+SITNe+aSiluskaWz4L7FDs0iyC/jW
	 k0wyksijDe55/zUnE17hXYiYnQ1IDq1JU4NT4A36NApXlJcPWC/KShcBdgPE/QF4vn
	 aUp+XeV0TFVyAd+0z6CkDTAzZLMbRGX499M4KyuWK4dtulyX9vIydWTzp6aPJU4+Ch
	 W8BsjoO1wcKst8WwmJGQy8edFc82Kb6/mjnRFmqf1fiuG3Cb3gQ/GE/Jp458V2HcXx
	 l5cgK8BH7vEqg==
Date: Tue, 17 Mar 2026 16:43:17 +0530
From: Vinod Koul <vkoul@kernel.org>
To: xianwei.zhao@amlogic.com
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, linux-amlogic@lists.infradead.org,
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v6 2/3] dmaengine: amlogic: Add general DMA driver for A9
Message-ID: <abk3TUTaov3zIfFm@vaman>
References: <20260309-amlogic-dma-v6-0-63349d23bd4b@amlogic.com>
 <20260309-amlogic-dma-v6-2-63349d23bd4b@amlogic.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309-amlogic-dma-v6-2-63349d23bd4b@amlogic.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9468-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amlogic.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9EF422A8982
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 09-03-26, 06:33, Xianwei Zhao via B4 Relay wrote:
> From: Xianwei Zhao <xianwei.zhao@amlogic.com>

> +static dma_cookie_t aml_dma_tx_submit(struct dma_async_tx_descriptor *tx)
> +{
> +	return dma_cookie_assign(tx);
> +}

You lost tx, why was it not saved into a queue?

> +static struct dma_async_tx_descriptor *aml_dma_prep_slave_sg
> +		(struct dma_chan *chan, struct scatterlist *sgl,
> +		unsigned int sg_len, enum dma_transfer_direction direction,
> +		unsigned long flags, void *context)
> +{
> +	struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
> +	struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
> +	struct aml_dma_sg_link *sg_link;
> +	struct scatterlist *sg;
> +	int idx = 0;
> +	u64 paddr;
> +	u32 reg, link_count, avail, chan_id;
> +	u32 i;
> +
> +	if (aml_chan->direction != direction) {
> +		dev_err(aml_dma->dma_device.dev, "direction not support\n");
> +		return NULL;
> +	}
> +
> +	switch (aml_chan->status) {
> +	case DMA_IN_PROGRESS:
> +		dev_err(aml_dma->dma_device.dev, "not support multi tx_desciptor\n");
> +		return NULL;

And why is that. You are preparing a descriptor and keep it ready and
submit after the current one finishes


> +
> +	case DMA_COMPLETE:
> +		aml_chan->data_len = 0;
> +		chan_id = aml_chan->chan_id;
> +		reg = (direction == DMA_DEV_TO_MEM) ? WCH_INT_MASK : RCH_INT_MASK;
> +		regmap_set_bits(aml_dma->regmap, reg, BIT(chan_id));
> +
> +		break;
> +	default:
> +		dev_err(aml_dma->dma_device.dev, "status error\n");
> +		return NULL;
> +	}
> +
> +	link_count = sg_nents_for_dma(sgl, sg_len, SG_MAX_LEN);
> +
> +	if (link_count > DMA_MAX_LINK) {
> +		dev_err(aml_dma->dma_device.dev,
> +			"maximum number of sg exceeded: %d > %d\n",
> +			sg_len, DMA_MAX_LINK);
> +		aml_chan->status = DMA_ERROR;
> +		return NULL;
> +	}
> +
> +	aml_chan->status = DMA_IN_PROGRESS;
> +
> +	for_each_sg(sgl, sg, sg_len, i) {
> +		avail = sg_dma_len(sg);
> +		paddr = sg->dma_address;
> +		while (avail > SG_MAX_LEN) {
> +			sg_link = &aml_chan->sg_link[idx++];
> +			/* set dma address and len  to sglink*/
> +			sg_link->address = paddr;
> +			sg_link->ctl = FIELD_PREP(LINK_LEN, SG_MAX_LEN);
> +			paddr = paddr + SG_MAX_LEN;
> +			avail = avail - SG_MAX_LEN;
> +		}
> +		sg_link = &aml_chan->sg_link[idx++];
> +		/* set dma address and len  to sglink*/
> +		sg_link->address = paddr;
> +		sg_link->ctl = FIELD_PREP(LINK_LEN, avail);
> +
> +		aml_chan->data_len += sg_dma_len(sg);
> +	}
> +	aml_chan->sg_link_cnt = idx;

There is no descriptor management here. You are directly writing to
channel. This is _very_ inefficient and defeats the use of dmaengine.

Please revise the driver. Implement queues to manage multiple txns and
we have vchan to help you implement these, so take use of that

-- 
~Vinod

