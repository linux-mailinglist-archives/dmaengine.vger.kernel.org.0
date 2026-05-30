Return-Path: <dmaengine+bounces-11049-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPBlIo7FGmpw8QgAu9opvQ
	(envelope-from <dmaengine+bounces-11049-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 30 May 2026 13:10:06 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E2160C5DE
	for <lists+dmaengine@lfdr.de>; Sat, 30 May 2026 13:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CBA75301E82A
	for <lists+dmaengine@lfdr.de>; Sat, 30 May 2026 11:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280883A9628;
	Sat, 30 May 2026 11:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWDd+KJE"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B90639B489;
	Sat, 30 May 2026 11:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780139400; cv=none; b=u8DOdP8rTtleQhG/Ee/T2rv99vdsniWWiN/cQRt7+DguG3M/MReICZNcVD0G3D2V1tzAiYUVESQHBujh4MXDLLKHD0sV4wIHhH48VvOQaNAvw0kU3D4J+tEbWSrnMKT67jomyJyLVG1yVoqTA3hQzO71GKFH8OtE5GDeNXupN0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780139400; c=relaxed/simple;
	bh=jm3kZo7bW4gzmcu/kVo2hLrOlzRCF++AvI58T7KmNXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BfeFMcxPNidSCnP3+gudu7ifsKFfXQ6n0Aob3xHxE78mfzJAoUtxo4HjjOqzDtgewDIEOp0J35KynMBBbv+qtRttjtrPt837Ar528YxQqxKzqC6A41mEXMPnBM6bc5n6uKQ57OG6+m9KwYjT83rIcLaLqgtQxShGpRc5GvGWNj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aWDd+KJE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FA301F00893;
	Sat, 30 May 2026 11:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780139398;
	bh=v4ihZnRH/LQIFrFDKge6RyOV01oVokJMm3Pfpv1IMAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aWDd+KJEO5/mmvKBtgLY06r+wsbTxuKn9TQoE5o7ZlEVnX/9NURNnVFfBlTeget8A
	 1HnqyqT/JgFtTL8KMDIg3ST/Xr8y2kjjMWSe3jYukcTMx/rypxGe+0h6ZDvgpXzzq2
	 jQMhV3GPEI/FzEnKooOXTWbYV57wOgf2sPB/EBv7OKmm+cIyEBwwhx2ZG1RmUWiysz
	 8a3y0SCbmUZzc5MONHzjBu2p48KKfp9IF6m2NRsykxZfsT2iAyngR/hvYynqknioEU
	 GEmKPTbIjsliE1MhJICps2Y1DlIiqCsaVhyvVLw3O/GZ6rHsi3PHtuWES+vx9mAwpo
	 PerjTqht0UIYg==
Date: Sat, 30 May 2026 13:09:56 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Georgi Djakov <djakov@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>
Subject: Re: [PATCH 07/16] arm64: dts: qcom: shikra: Add CPU OPP tables to
 scale DDR/L3
Message-ID: <20260530-roaring-auburn-asp-70a0d7@quoll>
References: <20260525-shikra-dt-m1-v1-0-f51a9838dbaa@oss.qualcomm.com>
 <20260525-shikra-dt-m1-v1-7-f51a9838dbaa@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260525-shikra-dt-m1-v1-7-f51a9838dbaa@oss.qualcomm.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11049-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,0.0.0.0:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 29E2160C5DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 25, 2026 at 01:19:11AM +0530, Komal Bajaj wrote:
> From: Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>
> 
> Add OPP tables required to scale DDR and L3 per freq-domain on
> Shikra SoC.
> 
> Signed-off-by: Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>
> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/shikra.dtsi | 84 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
> index ebdb4bc15d76..bb1821e95248 100644
> --- a/arch/arm64/boot/dts/qcom/shikra.dtsi
> +++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
> @@ -48,6 +48,11 @@ cpu0: cpu@0 {
>  			clocks = <&cpufreq_hw 0>;
>  			qcom,freq-domain = <&cpufreq_hw 0>;
>  			#cooling-cells = <2>;
> +			operating-points-v2 = <&cpu0_opp_table>;
> +			interconnects = <&mem_noc MASTER_AMPSS_M0 RPM_ACTIVE_TAG
> +					 &mc_virt SLAVE_EBI_CH0 RPM_ACTIVE_TAG>,
> +					<&epss_l3 MASTER_EPSS_L3_APPS
> +					 &epss_l3 SLAVE_EPSS_L3_SHARED>;

No. This is not a separate commit.

Best regards,
Krzysztof


