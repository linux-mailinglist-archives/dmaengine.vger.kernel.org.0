Return-Path: <dmaengine+bounces-2879-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D8B954F07
	for <lists+dmaengine@lfdr.de>; Fri, 16 Aug 2024 18:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E362D28457F
	for <lists+dmaengine@lfdr.de>; Fri, 16 Aug 2024 16:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14671BE85F;
	Fri, 16 Aug 2024 16:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bx8PDUEW"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755621BDA82;
	Fri, 16 Aug 2024 16:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723826442; cv=none; b=D6iQMBXOa1HqchvNoxeLJfOf2tQjQW9AOFEvqA5K41hk+BLKvWMW4UAPXlH9cHvLKMuk3GtIUzIiN8yZjFr1IhcLF8xXKadzIMRHph4PiT3RZ8TUjLHuFV8GYPYrT7+AR66TT3LuiNDmvJ1rkwlb/8k39gpRd4EFXejZDkV+kVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723826442; c=relaxed/simple;
	bh=BGu9Em/D4e6K7dXhfPgKpkjZwmJfH6pzeSu5bH6pCAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8cmQqBNMyXsDjMgfvsaBT2lRsZbfhRo/RX7lhwHpeF9qiK8QDFzka/tEzqyJU05kZ03gO3FgMSAVplSE7DIHqh8HnnfpqvuGWg7WlGjXb/usrc3MgzlmYpfS38qOap/AxrJiIJnEXDntiGQlSOjjMc1zX4awNwGPomFPTg9pGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bx8PDUEW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B70FC32782;
	Fri, 16 Aug 2024 16:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723826442;
	bh=BGu9Em/D4e6K7dXhfPgKpkjZwmJfH6pzeSu5bH6pCAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bx8PDUEWSBbiXN+J/oaqDxDOwNEu/sWGaL/5CKpETphOZte+boC0QMPsfc9cdAqNG
	 HZOPq27/wfPB3GKiOcypObakigPyl1rAc+5uKcyrXycyvUQTuJSU/z4MHfKsWHsIF2
	 25EVk14M4OyjOSYyaBe43JtPH/mQIuDk9jvHTLbCOdvfsAYMSlVnGk+BnVuoHsA0+T
	 yAFcqa7LrnNkSbXimbM/LReSglZBz2Dp8ja9c2xLxugHZcnOVE1xyNd9L80owvRaDy
	 zVwfO5fy/kLANyaTJBa6LPEUjDW9Ww1SMTomhVscX7wV7sphD9QrIZ1N1f7xCQJ5ae
	 GCaGCcPa7J0VQ==
Date: Fri, 16 Aug 2024 11:40:38 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: vkoul@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, konradybcio@kernel.org, thara.gopinath@gmail.com, 
	herbert@gondor.apana.org.au, davem@davemloft.net, gustavoars@kernel.org, 
	u.kleine-koenig@pengutronix.de, kees@kernel.org, agross@kernel.org, 
	linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, quic_srichara@quicinc.com, 
	quic_varada@quicinc.com, quic_utiwari@quicinc.com
Subject: Re: [PATCH v2 14/16] arm64: dts: qcom: ipq9574: enable bam pipe
 locking/unlocking
Message-ID: <lr53irikxjjoiks2utckyt5bsflxm52r2nlospkv3id6qwkfih@pycrjkeibx4g>
References: <20240815085725.2740390-1-quic_mdalam@quicinc.com>
 <20240815085725.2740390-15-quic_mdalam@quicinc.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815085725.2740390-15-quic_mdalam@quicinc.com>

On Thu, Aug 15, 2024 at 02:27:23PM GMT, Md Sadre Alam wrote:
> enable bam pipe locking/unlocking for ipq9507 SoC.

Note that the commit messages for the other non-dts commits will not
show up in the git history for this file. So, please follow
https://docs.kernel.org/process/submitting-patches.html#describe-your-changes
and give some indication of "problem description", to give future
readers an idea why this is here.

> 
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> ---
> 
> Change in [v2]
> 
> * enabled locking/unlocking support for ipq9574
> 
> Change in [v1]
> 
> * This patch was not included in [v1]
> 
>  arch/arm64/boot/dts/qcom/ipq9574.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> index 48dfafea46a7..dacaec62ec39 100644
> --- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> @@ -262,6 +262,7 @@ cryptobam: dma-controller@704000 {
>  			#dma-cells = <1>;
>  			qcom,ee = <1>;
>  			qcom,controlled-remotely;
> +			qcom,bam_pipe_lock;

Per the question before about what does this actually lock. Is this a
property of the BAM controller, or the crypto channel?

Regards,
Bjorn

>  		};
>  
>  		crypto: crypto@73a000 {
> -- 
> 2.34.1
> 

