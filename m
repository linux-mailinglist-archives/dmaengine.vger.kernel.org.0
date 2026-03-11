Return-Path: <dmaengine+bounces-9389-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNPZFX9ksWnsugIAu9opvQ
	(envelope-from <dmaengine+bounces-9389-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 11 Mar 2026 13:47:59 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD0F263D33
	for <lists+dmaengine@lfdr.de>; Wed, 11 Mar 2026 13:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D39B930069BF
	for <lists+dmaengine@lfdr.de>; Wed, 11 Mar 2026 12:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D898239E88;
	Wed, 11 Mar 2026 12:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/Gewi9T"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5822E23507B;
	Wed, 11 Mar 2026 12:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773233273; cv=none; b=F099z3m5uTFJ/8R7l/XuXjGWa+78OInEgeNoiL3h545IeVHgnzgzdRoB8lfoDs0B2ejIzQJ5yK4mTjrsWkBzNcmKMxai7kO9q3uQJtKv7rIkJz0ZXAxjFmRUs1QaIE4rtA/e8Qy/+hKPXrrPXuwciJzcZBMUjEnGRzoUOrCOQJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773233273; c=relaxed/simple;
	bh=PIiavc9jPdYxa+h6JEjPhU/eVDBwYycw0YXQ9LHcE4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FkfiGhD5swKkh71cBFdUISKZCzj4AMEag4ownkkdM31nUgeqw+9OAcJGf05z47Y4afAg0YIXcnZ1pn+uLCX0mVauqwW5shckN5PZwWWtkCskevI5HCKqcm/YmHjCffPUpG2QzUqFfDQNEiH9/dzi9FqYRtvQ1D85vBKViRpK+dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/Gewi9T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0034C4CEF7;
	Wed, 11 Mar 2026 12:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773233272;
	bh=PIiavc9jPdYxa+h6JEjPhU/eVDBwYycw0YXQ9LHcE4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W/Gewi9Tau8wfkkFOAxix27ZpFQU6BOOnPQwRA2QBXxtu08of/6K/Hee40ybDSg2H
	 rHSBbQwDoQDljstn+yCnRsz6+oYuBFWP7d8EUpek2VkdmE6eh2xukmG+EZgPKKfyDc
	 C49twpv93A2ltBONobj+i53xr6qXoVApMdOVxirviTlUTSHqfKZ+r+XCt95C3TfRoc
	 TIrJHx+jQ6id+pCWZvmN7zUad74wGDi21rGCk8WPPFzQ0ZMrqJDK0yI+VzladSWZ+L
	 Z7nF3kK84978nzhHJvIqoTGhaNbUmoTvaKbRfFYYsUFIHXTypD1v8qTJUL8SEmehDN
	 u77oB8O5P7p2g==
Date: Wed, 11 Mar 2026 18:17:38 +0530
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
Subject: Re: [PATCH v12 03/12] dmaengine: qcom: bam_dma: Extend the driver's
 device match data
Message-ID: <5bj7xmtgag5yfocitg3x7jpkom4icxma25dsz55wj4uhagqxiv@a7edsmzrxcv5>
References: <20260310-qcom-qce-cmd-descr-v12-0-398f37f26ef0@oss.qualcomm.com>
 <20260310-qcom-qce-cmd-descr-v12-3-398f37f26ef0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260310-qcom-qce-cmd-descr-v12-3-398f37f26ef0@oss.qualcomm.com>
X-Rspamd-Queue-Id: 4DD0F263D33
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9389-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,qualcomm.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 04:44:17PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> In preparation for supporting the pipe locking feature flag, extend the
> amount of information we can carry in device match data: create a
> separate structure and make the register information one of its fields.
> This way, in subsequent patches, it will be just a matter of adding a
> new field to the device data.
> 

Nit: s/patches/commits

> Reviewed-by: Dmitry Baryshkov <lumag@kernel.org>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
>  drivers/dma/qcom/bam_dma.c | 28 ++++++++++++++++++++++------
>  1 file changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
> index c8601bac555edf1bb4384fd39cb3449ec6e86334..8f6d03f6c673b57ed13aeca6c8331c71596d077b 100644
> --- a/drivers/dma/qcom/bam_dma.c
> +++ b/drivers/dma/qcom/bam_dma.c
> @@ -113,6 +113,10 @@ struct reg_offset_data {
>  	unsigned int pipe_mult, evnt_mult, ee_mult;
>  };
>  
> +struct bam_device_data {
> +	const struct reg_offset_data *reg_info;
> +};
> +
>  static const struct reg_offset_data bam_v1_3_reg_info[] = {
>  	[BAM_CTRL]		= { 0x0F80, 0x00, 0x00, 0x00 },
>  	[BAM_REVISION]		= { 0x0F84, 0x00, 0x00, 0x00 },
> @@ -142,6 +146,10 @@ static const struct reg_offset_data bam_v1_3_reg_info[] = {
>  	[BAM_P_FIFO_SIZES]	= { 0x1020, 0x00, 0x40, 0x00 },
>  };
>  
> +static const struct bam_device_data bam_v1_3_data = {
> +	.reg_info = bam_v1_3_reg_info,
> +};
> +
>  static const struct reg_offset_data bam_v1_4_reg_info[] = {
>  	[BAM_CTRL]		= { 0x0000, 0x00, 0x00, 0x00 },
>  	[BAM_REVISION]		= { 0x0004, 0x00, 0x00, 0x00 },
> @@ -171,6 +179,10 @@ static const struct reg_offset_data bam_v1_4_reg_info[] = {
>  	[BAM_P_FIFO_SIZES]	= { 0x1820, 0x00, 0x1000, 0x00 },
>  };
>  
> +static const struct bam_device_data bam_v1_4_data = {
> +	.reg_info = bam_v1_4_reg_info,
> +};
> +
>  static const struct reg_offset_data bam_v1_7_reg_info[] = {
>  	[BAM_CTRL]		= { 0x00000, 0x00, 0x00, 0x00 },
>  	[BAM_REVISION]		= { 0x01000, 0x00, 0x00, 0x00 },
> @@ -200,6 +212,10 @@ static const struct reg_offset_data bam_v1_7_reg_info[] = {
>  	[BAM_P_FIFO_SIZES]	= { 0x13820, 0x00, 0x1000, 0x00 },
>  };
>  
> +static const struct bam_device_data bam_v1_7_data = {
> +	.reg_info = bam_v1_7_reg_info,
> +};
> +
>  /* BAM CTRL */
>  #define BAM_SW_RST			BIT(0)
>  #define BAM_EN				BIT(1)
> @@ -393,7 +409,7 @@ struct bam_device {
>  	bool powered_remotely;
>  	u32 active_channels;
>  
> -	const struct reg_offset_data *layout;
> +	const struct bam_device_data *dev_data;
>  
>  	struct clk *bamclk;
>  	int irq;
> @@ -411,7 +427,7 @@ struct bam_device {
>  static inline void __iomem *bam_addr(struct bam_device *bdev, u32 pipe,
>  		enum bam_reg reg)
>  {
> -	const struct reg_offset_data r = bdev->layout[reg];
> +	const struct reg_offset_data r = bdev->dev_data->reg_info[reg];
>  
>  	return bdev->regs + r.base_offset +
>  		r.pipe_mult * pipe +
> @@ -1205,9 +1221,9 @@ static void bam_channel_init(struct bam_device *bdev, struct bam_chan *bchan,
>  }
>  
>  static const struct of_device_id bam_of_match[] = {
> -	{ .compatible = "qcom,bam-v1.3.0", .data = &bam_v1_3_reg_info },
> -	{ .compatible = "qcom,bam-v1.4.0", .data = &bam_v1_4_reg_info },
> -	{ .compatible = "qcom,bam-v1.7.0", .data = &bam_v1_7_reg_info },
> +	{ .compatible = "qcom,bam-v1.3.0", .data = &bam_v1_3_data },
> +	{ .compatible = "qcom,bam-v1.4.0", .data = &bam_v1_4_data },
> +	{ .compatible = "qcom,bam-v1.7.0", .data = &bam_v1_7_data },
>  	{}
>  };
>  
> @@ -1231,7 +1247,7 @@ static int bam_dma_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  	}
>  
> -	bdev->layout = match->data;
> +	bdev->dev_data = match->data;
>  
>  	bdev->regs = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(bdev->regs))
> 
> -- 
> 2.47.3
> 

-- 
மணிவண்ணன் சதாசிவம்

