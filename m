Return-Path: <dmaengine+bounces-126-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 614197EECF6
	for <lists+dmaengine@lfdr.de>; Fri, 17 Nov 2023 08:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12C151F25B99
	for <lists+dmaengine@lfdr.de>; Fri, 17 Nov 2023 07:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8810DF4D;
	Fri, 17 Nov 2023 07:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J9JVd9eW"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9A9D302
	for <dmaengine@vger.kernel.org>; Fri, 17 Nov 2023 07:48:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5431EC433C8;
	Fri, 17 Nov 2023 07:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700207303;
	bh=ukM1FaZyX2KkvDHmJF4BJ4FC+i2tJ29lL0pzGMHUfQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J9JVd9eWOdz4JY2OJv1s6OK5arnsvJclV8598sR1djt5tvPp/1IsSO6yf2/Kk5GsW
	 lQ485Rfl4VzCtP6SZiYQQp9r7xIW15o1WYWFdIHdjm1ou7r2maduV/+IBVxyNaYMT+
	 jhZ6E9312O+fhmgOQesynrkwxot5Q2zRAYBp1H8iOGB+Q8BhUFJqGHiCmL3KcihfLM
	 LamLl/6KSkrV1etAE7pW/vsltr6kuL5GwYRvTTH/ON11Q/uEp9mTLCQ99hth8gO2Z/
	 HEI1mxxmH/s5fJFlr47KKg257+e1AKePcowTyf6zrz/lNq1OtQEMOSPsaidkI9vJvS
	 py2eLnO+fIm9A==
Date: Fri, 17 Nov 2023 13:18:16 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Vinod Koul <vkoul@kernel.org>, Cai Huoqing <cai.huoqing@linux.dev>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	Herve Codina <herve.codina@bootlin.com>
Subject: Re: [PATCH v5 2/6] dmaengine: dw-edma: Fix wrong interrupt bit set
Message-ID: <20231117074816.GB10361@thinkpad>
References: <20231114-b4-feature_hdma_mainline-v5-0-7bc86d83c6f7@bootlin.com>
 <20231114-b4-feature_hdma_mainline-v5-2-7bc86d83c6f7@bootlin.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231114-b4-feature_hdma_mainline-v5-2-7bc86d83c6f7@bootlin.com>

On Tue, Nov 14, 2023 at 03:51:55PM +0100, Kory Maincent wrote:

Subject should reflect HDMA:

"dmaengine: dw-edma: Fix wrong interrupt bit set for HDMA"

> Fix "HDMA_V0_LOCAL_STOP_INT_EN" to "HDMA_V0_LOCAL_ABORT_INT_EN" as the STOP
> bit is already set in the same line.
> 

How about:

"Instead of setting HDMA_V0_LOCAL_ABORT_INT_EN bit, HDMA_V0_LOCAL_STOP_INT_EN
bit got set twice, due to which the abort interrupt is not getting generated for
HDMA. Fix it by setting the correct interrupt enable bit."

> Fixes: e74c39573d35 ("dmaengine: dw-edma: Add support for native HDMA")
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

With the above changes,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> ---
> 
> Changes in v3:
> - Split the patch in two to differ bug fix and simple harmless typo.
> ---
>  drivers/dma/dw-edma/dw-hdma-v0-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> index 1f4cb7db5475..108f9127aaaa 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> @@ -236,7 +236,7 @@ static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
>  		/* Interrupt enable&unmask - done, abort */
>  		tmp = GET_CH_32(dw, chan->dir, chan->id, int_setup) |
>  		      HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK |
> -		      HDMA_V0_LOCAL_STOP_INT_EN | HDMA_V0_LOCAL_STOP_INT_EN;
> +		      HDMA_V0_LOCAL_STOP_INT_EN | HDMA_V0_LOCAL_ABORT_INT_EN;
>  		SET_CH_32(dw, chan->dir, chan->id, int_setup, tmp);
>  		/* Channel control */
>  		SET_CH_32(dw, chan->dir, chan->id, control1, HDMA_V0_LINKLIST_EN);
> 
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்

