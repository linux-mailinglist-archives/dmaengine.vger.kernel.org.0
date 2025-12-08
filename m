Return-Path: <dmaengine+bounces-7528-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5017BCAC115
	for <lists+dmaengine@lfdr.de>; Mon, 08 Dec 2025 06:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E69D300A9FD
	for <lists+dmaengine@lfdr.de>; Mon,  8 Dec 2025 05:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25317302CD0;
	Mon,  8 Dec 2025 05:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fFt/cUZE"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F5C3019A5;
	Mon,  8 Dec 2025 05:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765171059; cv=none; b=bUfEqHU7U9GmOGUwoNjL1La2vdsAXgERQvBsRMsMAjnb+ae+9QajEVKRcMIIg5BltOKD7f0hg3bSml98ljOceSnDqDYMeGBmS1sZrDs4gOVzDEmDfmqdBHrMT6jPvGuudZ04Gy0ghePgcZDb8bbfBa9BuXaUxPAqRJS4oFaMBvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765171059; c=relaxed/simple;
	bh=dIQPDU004t1ro/2+dmnCAgT168o65+nKDS1wEyYnVfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UWFGd+Chi36wEqP5cXwvIoU3EMKfoLODXp9ayBBL+/AmIBeArTzqsc4SVjyA0w9Nvhw2DlmezBO4lh4hwN9SD+H3dbofCLghhr5mVtbfWmOaFg+I6zyo7SlXAgch5h4pLcr5qVP0EQH+AcaEgp6pt38z4wfoAzBsKSjYYfjauFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fFt/cUZE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 155DCC4CEF1;
	Mon,  8 Dec 2025 05:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765171059;
	bh=dIQPDU004t1ro/2+dmnCAgT168o65+nKDS1wEyYnVfs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fFt/cUZEiaKQLQPFte3Um+eVGw9t0iugvfOYeY6G1ysYeIxwUNuYfa1/6uL9LTHdw
	 zOgpPZPzdsZHbmT4ovqohzHlRbUuYMEAjJg96X1B4qOUxyIeynqpd1yTiQOOYRnh7x
	 57YL06rq1xZ4fV/tpMkdR8EwKbcRueUq+7hWvzCH8xCyIOLrh3PXsy9zP85jFmuFgZ
	 fV2X64gudeZ6C79Hw+yhTax6QNegBR/9aYE6YXhqK+GUfrMW2NNp/hllMxMmBJxXXK
	 QiO607Sca4fw9U5d4LrQem0uM6JcKDiqdUFQejfiOkq7DJmKWCQhgzaBnIcPhSHjVD
	 yl/CMmI3ciy0Q==
Date: Mon, 8 Dec 2025 14:17:31 +0900
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: dw-edma: Fix confusing cleanup.h syntax
Message-ID: <jbaurqrdhdgj4jw6jupcbxrs4w7xceyjd2ilfhtcr42hdj4etl@z4uyjmzypsti>
References: <20251208020729.4654-2-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251208020729.4654-2-krzysztof.kozlowski@oss.qualcomm.com>

On Mon, Dec 08, 2025 at 03:07:30AM +0100, Krzysztof Kozlowski wrote:
> Initializing automatic __free variables to NULL without need (e.g.
> branches with different allocations), followed by actual allocation is
> in contrary to explicit coding rules guiding cleanup.h:
> 
> "Given that the "__free(...) = NULL" pattern for variables defined at
> the top of the function poses this potential interdependency problem the
> recommendation is to always define and assign variables in one statement
> and not group variable definitions at the top of the function when
> __free() is used."
> 
> Code does not have a bug, but is less readable and uses discouraged
> coding practice, so fix that by moving declaration to the place of
> assignment.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
>  drivers/dma/dw-edma/dw-edma-pcie.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> index 3371e0a76d3c..e9caf8adca1f 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -161,13 +161,13 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  			      const struct pci_device_id *pid)
>  {
>  	struct dw_edma_pcie_data *pdata = (void *)pid->driver_data;
> -	struct dw_edma_pcie_data *vsec_data __free(kfree) = NULL;
>  	struct device *dev = &pdev->dev;
>  	struct dw_edma_chip *chip;
>  	int err, nr_irqs;
>  	int i, mask;
>  
> -	vsec_data = kmalloc(sizeof(*vsec_data), GFP_KERNEL);
> +	struct dw_edma_pcie_data *vsec_data __free(kfree) =
> +		kmalloc(sizeof(*vsec_data), GFP_KERNEL);
>  	if (!vsec_data)
>  		return -ENOMEM;
>  
> -- 
> 2.51.0
> 

-- 
மணிவண்ணன் சதாசிவம்

