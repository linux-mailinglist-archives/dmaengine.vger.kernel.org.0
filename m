Return-Path: <dmaengine+bounces-2876-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF2E954E59
	for <lists+dmaengine@lfdr.de>; Fri, 16 Aug 2024 18:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 978DA283B96
	for <lists+dmaengine@lfdr.de>; Fri, 16 Aug 2024 16:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B95C1BF309;
	Fri, 16 Aug 2024 16:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qqxa+zDY"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474B11BE87A;
	Fri, 16 Aug 2024 16:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723824098; cv=none; b=lDiDLEB3Jcpi1gZdKZXxyKLqbGgcF1XXJA8oFfEa9zVn7QmhHDQ681tS9C4PnPM8ow3tecS8QUPGqLyFCSt4Ij+TXK0A2Ssbt7rSdincmgAkbsl8/wSJFJbXzewMLzw9UOa2M+imI6wmALtuEMi8mdmyp+pbG7zATLO+oywu0tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723824098; c=relaxed/simple;
	bh=OvCWp5XhqJ8jljZ2uZz4DriEyBAtWKpz6285nOgMkmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nGkuXTot2dEHyimRXNiC6eQCauyNikVAsWKCXJXmqI88voio5axFfBZ10TMiEXFNPVkgMTMqRWs/S30kjMJruk6AVh3EJi0nw7/QLjpJZHv2UxsEqNLgQKv55PmLgdLCurT9Ml7LULaJingSRmO2NgMNPQssZt1xJChb9VH+n8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qqxa+zDY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24FFAC4AF09;
	Fri, 16 Aug 2024 16:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723824097;
	bh=OvCWp5XhqJ8jljZ2uZz4DriEyBAtWKpz6285nOgMkmQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qqxa+zDYpGwyKNRdjTmZdxvdNlk5G4TonrjIj/e1NpJ9NYm+9nxeXN16Afg1cRIU6
	 gLNjl2rTzlxtKaDm4Q3/uyjDc2buHEjoatNOABtdxY2AVpwqYM/HI/ESW+dJ+t4hH8
	 J40lkX1JKraNwU5zKB4wgjMN29nng7TJOewk1KMkDP8ngUyYzuGCkBUk0OfQBBC/aT
	 qcs3gqtlaaZxotrkjtw62v1X5Sg5Ef9A62Qc+Uz+quuyKg9vwACmHQ/8RM+MtrYtVa
	 zKTc9gyF/Cq4Ehsexd42gwVp0M/tJAVKSVNxRuPc/OjKhvXI1O6JDTGGkox2yoNBsR
	 XH2Gfe1+Yr5wg==
Date: Fri, 16 Aug 2024 11:01:34 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: vkoul@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, konradybcio@kernel.org, thara.gopinath@gmail.com, 
	herbert@gondor.apana.org.au, davem@davemloft.net, gustavoars@kernel.org, 
	u.kleine-koenig@pengutronix.de, kees@kernel.org, agross@kernel.org, 
	linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, quic_srichara@quicinc.com, 
	quic_varada@quicinc.com, quic_utiwari@quicinc.com
Subject: Re: [PATCH v2 00/16] Add cmd descriptor support
Message-ID: <3p43hay67bofcddnar7wm2bsods5zqbylnjhnd22gcbniztymn@2zziltxxbaiv>
References: <20240815085725.2740390-1-quic_mdalam@quicinc.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815085725.2740390-1-quic_mdalam@quicinc.com>

On Thu, Aug 15, 2024 at 02:27:09PM GMT, Md Sadre Alam wrote:
> This series of patches will add command descriptor
> support to read/write crypto engine register via
> BAM/DMA
> 
> We need this support because if there is multiple EE's
> (Execution Environment) accessing the same CE then there
> will be race condition. To avoid this race condition
> BAM HW hsving LOC/UNLOCK feature on BAM pipes and this
> LOCK/UNLOCK will be set via command descriptor only.
> 
> Since each EE's having their dedicated BAM pipe, BAM allows
> Locking and Unlocking on BAM pipe. So if one EE's requesting
> for CE5 access then that EE's first has to LOCK the BAM pipe
> while setting LOCK bit on command descriptor and then access
> it. After finishing the request EE's has to UNLOCK the BAM pipe
> so in this way we race condition will not happen.
> 
> tested with "tcrypt.ko" and "kcapi" tool.
> 
> Need help to test these all the patches on msm platform
> 
> v2:
>  * Addressed all the comments from v1

Please describe the actual changes you're making between your versions.

>  * Added the dt-binding
>  * Added locking/unlocking mechanism in bam driver

Seems to me that this was already part of v1, as patch 6/11?

Regards,
Bjorn

> 
> v1:
>  * https://lore.kernel.org/lkml/20231214114239.2635325-1-quic_mdalam@quicinc.com/
>  * Initial set of patches for cmd descriptor support
> 
> Md Sadre Alam (16):
>   dt-bindings: dma: qcom,bam: Add bam pipe lock
>   dmaengine: qcom: bam_dma: add bam_pipe_lock dt property
>   dmaengine: qcom: bam_dma: add LOCK & UNLOCK flag support
>   crypto: qce - Add support for crypto address read
>   crypto: qce - Add bam dma support for crypto register r/w
>   crypto: qce - Convert register r/w for skcipher via BAM/DMA
>   crypto: qce - Convert register r/w for sha via BAM/DMA
>   crypto: qce - Convert register r/w for aead via BAM/DMA
>   crypto: qce - Add LOCK and UNLOCK flag support
>   crypto: qce - Add support for lock aquire,lock release api.
>   crypto: qce - Add support for lock/unlock in skcipher
>   crypto: qce - Add support for lock/unlock in sha
>   crypto: qce - Add support for lock/unlock in aead
>   arm64: dts: qcom: ipq9574: enable bam pipe locking/unlocking
>   arm64: dts: qcom: ipq8074: enable bam pipe locking/unlocking
>   arm64: dts: qcom: ipq6018: enable bam pipe locking/unlocking
> 
>  .../devicetree/bindings/dma/qcom,bam-dma.yaml |   8 +
>  arch/arm64/boot/dts/qcom/ipq6018.dtsi         |   1 +
>  arch/arm64/boot/dts/qcom/ipq8074.dtsi         |   1 +
>  arch/arm64/boot/dts/qcom/ipq9574.dtsi         |   1 +
>  drivers/crypto/qce/aead.c                     |   4 +
>  drivers/crypto/qce/common.c                   | 142 +++++++----
>  drivers/crypto/qce/core.c                     |  13 +-
>  drivers/crypto/qce/core.h                     |  12 +
>  drivers/crypto/qce/dma.c                      | 232 ++++++++++++++++++
>  drivers/crypto/qce/dma.h                      |  26 +-
>  drivers/crypto/qce/sha.c                      |   4 +
>  drivers/crypto/qce/skcipher.c                 |   4 +
>  drivers/dma/qcom/bam_dma.c                    |  14 +-
>  include/linux/dmaengine.h                     |   6 +
>  14 files changed, 424 insertions(+), 44 deletions(-)
> 
> -- 
> 2.34.1
> 

