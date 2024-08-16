Return-Path: <dmaengine+bounces-2875-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A1E954E42
	for <lists+dmaengine@lfdr.de>; Fri, 16 Aug 2024 17:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E676B23696
	for <lists+dmaengine@lfdr.de>; Fri, 16 Aug 2024 15:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4641BDA94;
	Fri, 16 Aug 2024 15:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WjRJPcpK"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367981BCA0B;
	Fri, 16 Aug 2024 15:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723823628; cv=none; b=kV0D0PuaYkFqaxg0XcODMBmGma0ZpomPZoYmxThSXTRQdh8Gfpqm7+N6GNj93nDDhM1/+s5ol7PCO5cCqov30eeVjASc4Wkb3pIqOQeUCzmaFH+2woZQpj8ksqhV2l8Cuwi3g9lK8lkQoNwLt0eXG8Ucz0PXurhjQYFL9799jOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723823628; c=relaxed/simple;
	bh=PXs1yvNpXJ4B/80Ijs3pk2Y5EklTN/J2qxy/CEUCfXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=De8k+OEugV+XuYglanK4IhOYU8vuvKghrHOVjfszZHe7Hr0EOlL4vkVTJUVf2RnuVi7cx9nIA15LOZzpFGtkT3KLx0Tu6XzEj2bG5Gbc+tjZYYjVnwz3Jw75SHo0PcF28MINxWb5584IAq8p5yI5FQZgyWtbCfmjLifPEk0ZlNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WjRJPcpK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DD17C32782;
	Fri, 16 Aug 2024 15:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723823627;
	bh=PXs1yvNpXJ4B/80Ijs3pk2Y5EklTN/J2qxy/CEUCfXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WjRJPcpKMxppcvQz+suRPJEnUvDDc6ntt1GjCJbnBTS+pUO187baNazkebgMziGLx
	 m/1wMEINM48iP2oCElDok3lJX9lw3fTzqmXIJmFXaxqVO1neVB/VS3Nod94/l22k3c
	 IgOB/jNld6frJEwjHzE7kZxMtOaKzY2IUi78Di2y6tR1U6QFm+826IK4oN4lSe1ghS
	 kpvMxhiwfK1GshiMoLpm7UwmjWF8cBSxemIJy9u+oy33khErQYj5/Tk5ig9bmn9YKb
	 380b5QL+E5z7K/T6SHbhXPi4MbWza+VC/r5P1GzixTqwEHyabcqN9gJpRV5ixrxpRy
	 v5g4qM1+N6jPw==
Date: Fri, 16 Aug 2024 10:53:44 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: vkoul@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, konradybcio@kernel.org, thara.gopinath@gmail.com, 
	herbert@gondor.apana.org.au, davem@davemloft.net, gustavoars@kernel.org, 
	u.kleine-koenig@pengutronix.de, kees@kernel.org, agross@kernel.org, 
	linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, quic_srichara@quicinc.com, 
	quic_varada@quicinc.com, quic_utiwari@quicinc.com
Subject: Re: [PATCH v2 01/16] dt-bindings: dma: qcom,bam: Add bam pipe lock
Message-ID: <7kgah2aajgyybdmpwfzgd25mi2lc4v6xv2k3mif576wo7bw2wn@i43mt2c34chg>
References: <20240815085725.2740390-1-quic_mdalam@quicinc.com>
 <20240815085725.2740390-2-quic_mdalam@quicinc.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815085725.2740390-2-quic_mdalam@quicinc.com>

On Thu, Aug 15, 2024 at 02:27:10PM GMT, Md Sadre Alam wrote:
> BAM having pipe locking mechanism. The Lock and Un-Lock bit
> should be set on CMD descriptor only. Upon encountering a
> descriptor with Lock bit set, the BAM will lock all other
> pipes not related to the current pipe group, and keep
> handling the current pipe only until it sees the Un-Lock
> set.

This describes the mechanism for mutual exclusion, but not really what
the patch does.

https://docs.kernel.org/process/submitting-patches.html#the-canonical-patch-format
states that you have 75 characters for your commit message, use them.

> 
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> ---
> 
> Change in [v2]
> 
> * Added initial support for dt-binding
> 
> Change in [v1]
> 
> * This patch was not included in [v1]
> 
>  Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
> index 3ad0d9b1fbc5..91cc2942aa62 100644
> --- a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
> +++ b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
> @@ -77,6 +77,12 @@ properties:
>        Indicates that the bam is powered up by a remote processor but must be
>        initialized by the local processor.
>  
> +  qcom,bam_pipe_lock:

'_' is not a valid character in node names or properties.

> +    type: boolean
> +    description:
> +      Indicates that the bam pipe needs locking or not based on client driver
> +      sending the LOCK or UNLOK bit set on command descriptor.

Missing 'C'?

Regards,
Bjorn

> +
>    reg:
>      maxItems: 1
>  
> @@ -92,6 +98,8 @@ anyOf:
>        - qcom,powered-remotely
>    - required:
>        - qcom,controlled-remotely
> +  - required:
> +      - qcom,bam_pipe_lock
>    - required:
>        - clocks
>        - clock-names
> -- 
> 2.34.1
> 

