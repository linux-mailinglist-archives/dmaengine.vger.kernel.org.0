Return-Path: <dmaengine+bounces-3697-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D3F9C2BF4
	for <lists+dmaengine@lfdr.de>; Sat,  9 Nov 2024 11:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDB62B21BAA
	for <lists+dmaengine@lfdr.de>; Sat,  9 Nov 2024 10:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC157152166;
	Sat,  9 Nov 2024 10:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKEdsP7D"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9994D4EB38;
	Sat,  9 Nov 2024 10:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731148913; cv=none; b=fEwhlrXYOz4Jcjt5IeO99j32b1hDxEKKP/oMr8BNZJ+C4pfMKJyv3haisI5SM6d6Skx3UFYB5oZVineCkgxS6Z2SnyLxQyPiY6keJ0nqHERPSK54rK7b5IG45KMhg1DQPV4ZNXKJpGdrOMCRCVZdlcnui8RvHCvRIH0NpF/Lo1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731148913; c=relaxed/simple;
	bh=F9nLHtk4Xnp5XxSu5Mc1X6+3IMnPYrBuod537qGopi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q7N2S3BE9JHulPsoNW3DDJC6VYdB7Tz5XQoeoCi2l1zOhL55URiW/OMqQxOuoIcPaZjzqCIE5LKAr01TibitJQaePpkmUgIhf9ppzz1rd1az+CzO4lIqk1srzsgtLMGwxOUNsnbiDI48gYJXIk902JoaPojXZ8kajTUfIjx7F2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKEdsP7D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5477AC4CECE;
	Sat,  9 Nov 2024 10:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731148913;
	bh=F9nLHtk4Xnp5XxSu5Mc1X6+3IMnPYrBuod537qGopi0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MKEdsP7DISHXawLsK0qMFeUof6lNgsT0JFz1bwD6kuqbzvOkEzeWUF0Gsidk64Kfj
	 Nw8+y2OY+lmf2KapcXZNYndk6YOriZSyfFRF8BcbJRIfLqjE/wnIdaxoD2fsXT9vCj
	 oGN6ZkAQ2xJVJRif7MSbZLMNO6kr0y1zNcoagIHA9N/LoQGqXltpeN/2RZU3NjfBeW
	 /swINLyWq5bPWC5bd6D+m709hqYDsXhuVEuNvoaVI0wK1u3KT8wRhSkTk5suaLbzA5
	 gdtQmCg39AfDYO46qUhHRVAhsJjmEvdVVDbJNPvjzEqpKguzZjmXf/1bu/Qgcx/QWY
	 jfPlZEX7N18GA==
Date: Sat, 9 Nov 2024 11:41:49 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Viken Dadhaniya <quic_vdadhani@quicinc.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH 1/2] dt-bindings: dma: qcom,gpi: Add SA8775P compatible
Message-ID: <whdz5qpnd54wzm4fwn473lxp6ppcf4jhi5yoexicmlpwk2dkml@ijscxy3ax2gd>
References: <20241108-topic-sa8775_dma2-v1-0-1d3b0d08d153@oss.qualcomm.com>
 <20241108-topic-sa8775_dma2-v1-1-1d3b0d08d153@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241108-topic-sa8775_dma2-v1-1-1d3b0d08d153@oss.qualcomm.com>

On Fri, Nov 08, 2024 at 10:41:17PM +0100, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Add a compatible for the GPI DMA controller on SA8775P.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


