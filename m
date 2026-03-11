Return-Path: <dmaengine+bounces-9390-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFGcAz1msWnsugIAu9opvQ
	(envelope-from <dmaengine+bounces-9390-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 11 Mar 2026 13:55:25 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E01263F2E
	for <lists+dmaengine@lfdr.de>; Wed, 11 Mar 2026 13:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AFD623043D39
	for <lists+dmaengine@lfdr.de>; Wed, 11 Mar 2026 12:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A90272803;
	Wed, 11 Mar 2026 12:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ryr9cbb7"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FA122A1D4;
	Wed, 11 Mar 2026 12:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773233584; cv=none; b=IOdaRr/F/SeEaB+SWzyjzHO7q4qWYmRXhL3hSE4v3YCpjp4BM2DsdDICqbVBul9aOSEtZFjH9UO3YDouYArh+F5cgtt7k1BDCVJBP9TATKIpVsKppTYQ6aRWycElLSX6++1wawos5e74/XAYqHEkIZXRyZbKNB7LPkbSafcL3Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773233584; c=relaxed/simple;
	bh=pvTPwUETRgoaK2FYBnK3TRkvTzw8K62R4/XYbZAjHLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xb/mdvyq+n/uhIVGeI+m7wogfWzyvnfBYk+w99u5zXqP3peLgLqGAEMTqQBUPdu0Swp1bZ4QSabdawUBytagrjhwuX/09Mf8ol7q6CsuVU6aLwmj3GZ2Ydtq31w8z2EN7Wtr4sR0/dtxp+pzpMzxZbhBuimHQ4fl56wsUZWus7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ryr9cbb7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C2E8C4CEF7;
	Wed, 11 Mar 2026 12:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773233584;
	bh=pvTPwUETRgoaK2FYBnK3TRkvTzw8K62R4/XYbZAjHLk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ryr9cbb7ve9YMPMrvLP3BAvTRE9krLN3poqx1YUPjtaZH3anOyvrYuyu7OGsZZ6Wh
	 jrRCw63Nmc71hW7PwmHPlfdmAMCffYTP7cedDdrliyUxMJxpjvbjpQ3BAH33GPPeyz
	 8fPCTyKE1E9wmfrQXLCj1wFzFlfgICFSPBM840dvj5A5kjFgFWpl9Ik3qXOK9qo0Uc
	 NeHBUNA5YB04I0ygQhhRY2wswKS3xrHpAcPABKEkk3sQXQrC+Ripg/SlY0DxExNBql
	 g2EoOkXHdv67rh6hhn7ItoC0t+GRy+oeWM3BxOQgHToKwOiZhd4rQDTnc6QBF9J/vl
	 pMx5hK2xtr/bw==
Date: Wed, 11 Mar 2026 18:22:14 +0530
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
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH v12 04/12] dmaengine: qcom: bam_dma: Add
 pipe_lock_supported flag support
Message-ID: <mf3nlrbu3h2iage5nd2tydhcruf3es7bs5e6ozv5udpymyci3v@dgcn5tgo3p3a>
References: <20260310-qcom-qce-cmd-descr-v12-0-398f37f26ef0@oss.qualcomm.com>
 <20260310-qcom-qce-cmd-descr-v12-4-398f37f26ef0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260310-qcom-qce-cmd-descr-v12-4-398f37f26ef0@oss.qualcomm.com>
X-Rspamd-Queue-Id: A2E01263F2E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9390-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,amd.com,vger.kernel.org,lists.infradead.org,linaro.org,oss.qualcomm.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mani@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linaro.org:email]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 04:44:18PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Extend the device match data with a flag indicating whether the IP
> supports the BAM lock/unlock feature. Set it to true on BAM IP versions
> 1.4.0 and above.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Nit: I'd move setting 'pipe_lock_supported = true' part after next patch so that
the order becomes, add pipe lock support in the driver and enable it for the
supported versions.

- Mani

> ---
>  drivers/dma/qcom/bam_dma.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
> index 8f6d03f6c673b57ed13aeca6c8331c71596d077b..83491e7c2f17d8c9d12a1a055baea7e3a0a75a53 100644
> --- a/drivers/dma/qcom/bam_dma.c
> +++ b/drivers/dma/qcom/bam_dma.c
> @@ -115,6 +115,7 @@ struct reg_offset_data {
>  
>  struct bam_device_data {
>  	const struct reg_offset_data *reg_info;
> +	bool pipe_lock_supported;
>  };
>  
>  static const struct reg_offset_data bam_v1_3_reg_info[] = {
> @@ -181,6 +182,7 @@ static const struct reg_offset_data bam_v1_4_reg_info[] = {
>  
>  static const struct bam_device_data bam_v1_4_data = {
>  	.reg_info = bam_v1_4_reg_info,
> +	.pipe_lock_supported = true,
>  };
>  
>  static const struct reg_offset_data bam_v1_7_reg_info[] = {
> @@ -214,6 +216,7 @@ static const struct reg_offset_data bam_v1_7_reg_info[] = {
>  
>  static const struct bam_device_data bam_v1_7_data = {
>  	.reg_info = bam_v1_7_reg_info,
> +	.pipe_lock_supported = true,
>  };
>  
>  /* BAM CTRL */
> 
> -- 
> 2.47.3
> 

-- 
மணிவண்ணன் சதாசிவம்

