Return-Path: <dmaengine+bounces-9585-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKShEZECwWlUPgQAu9opvQ
	(envelope-from <dmaengine+bounces-9585-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 10:06:25 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 038012EEABC
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 10:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D815C302D58B
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 09:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E853859DA;
	Mon, 23 Mar 2026 09:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EYrZFK5s"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DF838552A;
	Mon, 23 Mar 2026 09:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774256589; cv=none; b=DcWBe+9XA8NLFVZwQ/4aYJ1WgKVbdztKyRI3ySnYFNJcRCagBFeJUaLH8EGA+2xTudvDacdxyx8sqjSQFOCz0dVt6uybEo3fUjHGH/d1wX55lRlrxu9HMoYmVRSATd/WwNuCYl/bkH55WKdhwmyEWukDWeHZ77zRi4XK3B48LkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774256589; c=relaxed/simple;
	bh=IEWz/yDGTqNpb9yF4r5qDEyb/sGLpVM6hsRHTY8svVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HrWHqrgde830bN/6vbiZVDSOaSGmRnzasQ2pZHJnjHypVk+FKCnWGAENcUwbg3Cfpn85xwL9yMucOk4K3a6DIyWyI6n7/+H190Tz/mTyTlN5yytQv0VAcW8fdh9dQuh1LoweXT3rqilghqpgfVsL8UkGDSEg3lhPgyVgbDPNXzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EYrZFK5s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B02A9C2BC9E;
	Mon, 23 Mar 2026 09:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774256588;
	bh=IEWz/yDGTqNpb9yF4r5qDEyb/sGLpVM6hsRHTY8svVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EYrZFK5sh4eEIon27+KRCuxRRlO+nCshQb3BJJSDa057fK9I2qx5BaZzEAnJPsDXD
	 OWtaco5xO42HLCMofsfuJI0VUvPfv82XiE4HbrrkqGxbdKQQoepzxUmM2iiVTEr6qR
	 NMDuAFoKsJBNsh/k9uOQ3VpSiYkNctpMtKQzu5b/eCBnB3qylq4ryKQRyCeUsipsft
	 SIsrvYMfmsPGADl3ITVarsrX6obTFGU1W+FOrV83mEyFeXPKm9dlO5uak6vi4diqoG
	 UBMdzDRq7xV9WdeV900A+cP+XDNj1+miTSeg/4E2epFIeO84bXq5Q30Ps9LvSUXXfa
	 ZsoO7G/XnXFpA==
Date: Mon, 23 Mar 2026 14:32:57 +0530
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
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH v13 04/12] dmaengine: qcom: bam_dma: Add
 pipe_lock_supported flag support
Message-ID: <ak4ktv4qjmjkiodahqees46gmyt3yabbd3r5f7kcf3ufq3oikm@yirezure7rlh>
References: <20260317-qcom-qce-cmd-descr-v13-0-0968eb4f8c40@oss.qualcomm.com>
 <20260317-qcom-qce-cmd-descr-v13-4-0968eb4f8c40@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260317-qcom-qce-cmd-descr-v13-4-0968eb4f8c40@oss.qualcomm.com>
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
	TAGGED_FROM(0.00)[bounces-9585-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,linaro.org,amd.com,vger.kernel.org,lists.infradead.org,oss.qualcomm.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linaro.org:email,qualcomm.com:email]
X-Rspamd-Queue-Id: 038012EEABC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 03:02:11PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Extend the device match data with a flag indicating whether the IP
> supports the BAM lock/unlock feature. Set it to true on BAM IP versions
> 1.4.0 and above.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

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

