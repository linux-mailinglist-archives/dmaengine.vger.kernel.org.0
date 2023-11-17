Return-Path: <dmaengine+bounces-127-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5C27EED04
	for <lists+dmaengine@lfdr.de>; Fri, 17 Nov 2023 08:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C989280D90
	for <lists+dmaengine@lfdr.de>; Fri, 17 Nov 2023 07:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9551EDDDC;
	Fri, 17 Nov 2023 07:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oSG40eVf"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EEBDDC4
	for <dmaengine@vger.kernel.org>; Fri, 17 Nov 2023 07:58:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30ECDC433C8;
	Fri, 17 Nov 2023 07:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700207895;
	bh=0B36TljQhHtg1dBTuFEPa+Be8tJ2CYT0Ridvxuqjnuw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oSG40eVfVNnxf2w6tvLsPOx9cMgntkfr9kiTiRJBk38Jko8P+ss8EBbcHJ8pDtQRx
	 gn6s/7mXoXllIs4NtpGIaoptlJdOV5yT3o/5A9J96UX9Ebhd2W2dneO4AA7U9WSHu8
	 UPxJGLDs2sNegRXvzTCnzEiN9HQodc51Re3m+CJGffobrkO3q9D+1AC8JxoaWW3IcQ
	 OFor8yWrR5ddjtwYxcLuu1bTUurRQ/HupRZEESe0AW5/G7zc1k8JNZzZRlVTaKsb03
	 wgVGn1QG81Mfs61ZUeeWvzXskTBhQpv+6j5gEL6v76A/X5bmOhOQ2cIpqvGMeRhy2n
	 gHaWxmrzX0Vxw==
Date: Fri, 17 Nov 2023 13:28:09 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Vinod Koul <vkoul@kernel.org>, Cai Huoqing <cai.huoqing@linux.dev>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	Herve Codina <herve.codina@bootlin.com>
Subject: Re: [PATCH v5 3/6] dmaengine: dw-edma: Typo fix
Message-ID: <20231117075809.GC10361@thinkpad>
References: <20231114-b4-feature_hdma_mainline-v5-0-7bc86d83c6f7@bootlin.com>
 <20231114-b4-feature_hdma_mainline-v5-3-7bc86d83c6f7@bootlin.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231114-b4-feature_hdma_mainline-v5-3-7bc86d83c6f7@bootlin.com>

On Tue, Nov 14, 2023 at 03:51:56PM +0100, Kory Maincent wrote:

Please mention what typo it is in the subject.

> Fix "HDMA_V0_REMOTEL_STOP_INT_EN" typo error
> 
> Fixes: e74c39573d35 ("dmaengine: dw-edma: Add support for native HDMA")
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

With that,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> ---
> 
> Changes in v3:
> - Split the patch in two to differ bug fix and simple harmless typo.
> ---
>  drivers/dma/dw-edma/dw-hdma-v0-regs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-regs.h b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> index a974abdf8aaf..eab5fd7177e5 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> @@ -15,7 +15,7 @@
>  #define HDMA_V0_LOCAL_ABORT_INT_EN		BIT(6)
>  #define HDMA_V0_REMOTE_ABORT_INT_EN		BIT(5)
>  #define HDMA_V0_LOCAL_STOP_INT_EN		BIT(4)
> -#define HDMA_V0_REMOTEL_STOP_INT_EN		BIT(3)
> +#define HDMA_V0_REMOTE_STOP_INT_EN		BIT(3)
>  #define HDMA_V0_ABORT_INT_MASK			BIT(2)
>  #define HDMA_V0_STOP_INT_MASK			BIT(0)
>  #define HDMA_V0_LINKLIST_EN			BIT(0)
> 
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்

