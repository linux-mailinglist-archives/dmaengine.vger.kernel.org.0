Return-Path: <dmaengine+bounces-4388-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1539A2EF15
	for <lists+dmaengine@lfdr.de>; Mon, 10 Feb 2025 14:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 994363A1A7D
	for <lists+dmaengine@lfdr.de>; Mon, 10 Feb 2025 13:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F98225A25;
	Mon, 10 Feb 2025 13:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X3eotT5X"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2B71DF744
	for <dmaengine@vger.kernel.org>; Mon, 10 Feb 2025 13:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739195990; cv=none; b=ORuSUOifn5bLTziKhF0W+1wSI5PsxittS8kdrnr9dv7SlfvoygYz14sMV/Ox8vm7GTvh4RtYb2zpP4Vyu7u7GYjWdJzLhRHMxY92L7uCz/f3KrB/BsoZbSbvOfw03qsXUGzGf7SKU0DfoPW0CsBa9L8CCEHzgSw8PJfjaUnn47Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739195990; c=relaxed/simple;
	bh=DRNcxdOefk1HkJG+dsbu+QO0S01R3mC60nOeuVst1CA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cGuLwd5N2OiO+QDgH6nk0qQgKYnVTdNEt0xajXxI2sLZbZjUkORLl6+XnqyPyp8ywvs+4rT/i/m1ScbjIK+2ZEFPTO+99VYnBj7dwT0QBVN1VaYFauPngPpQOB0y1XZCu4+nyz3m72TdscF9nK+3rXNjPeSKMA2FCrigWq4YNwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X3eotT5X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09E3DC4CED1;
	Mon, 10 Feb 2025 13:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739195989;
	bh=DRNcxdOefk1HkJG+dsbu+QO0S01R3mC60nOeuVst1CA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X3eotT5X9K2OLRonMlwoQNLkGTX2CqWI+jqcKg0GL+DSpRCvs2iCEepqQOiKbA2pI
	 7n7UpyWqhzrHwRsWg4uy3sAU5IyB3fMKknw6AVquLFyod5gfzXrectFM7zf9E0bEW8
	 17M0UK+GL6Q84zGGog6v/j+a1EDM6Os9I7lQkEz6pAamGWzchtYlx24l+KGqMfZZDP
	 LUxfmM6Vfl19CiXEI/UmPgucflPNoDYHuUVhven0kqWhwKIt3ytmbg3y5LjeU3GLy5
	 p+qts5adn1HjwrYTXY5X2QnvH8IxuIeAlFNOmkXQYcTdhm5pVhgRJ+rgVN6Gmndxeg
	 Nesp4m3KgDh+Q==
Date: Mon, 10 Feb 2025 19:29:45 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Cc: dmaengine@vger.kernel.org
Subject: Re: [PATCH 1/3] dmaengine: ae4dma: Remove deprecated PCI IDs
Message-ID: <Z6oGUao+26rThmub@vaman>
References: <20250203162511.911946-1-Basavaraj.Natikar@amd.com>
 <20250203162511.911946-2-Basavaraj.Natikar@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203162511.911946-2-Basavaraj.Natikar@amd.com>

On 03-02-25, 21:55, Basavaraj Natikar wrote:
> Two previously used PCI IDs are deprecated and should not be used for
> AE4DMA. Hence, remove as they are unsupported for AE4DMA.
> 
> Fixes: 90a30e268d9b ("dmaengine: ae4dma: Add AMD ae4dma controller driver")

Why is this a fix?

> Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
> ---
>  drivers/dma/amd/ae4dma/ae4dma-pci.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/dma/amd/ae4dma/ae4dma-pci.c b/drivers/dma/amd/ae4dma/ae4dma-pci.c
> index aad0dc4294a3..7f96843f5215 100644
> --- a/drivers/dma/amd/ae4dma/ae4dma-pci.c
> +++ b/drivers/dma/amd/ae4dma/ae4dma-pci.c
> @@ -137,8 +137,6 @@ static void ae4_pci_remove(struct pci_dev *pdev)
>  }
>  
>  static const struct pci_device_id ae4_pci_table[] = {
> -	{ PCI_VDEVICE(AMD, 0x14C8), },
> -	{ PCI_VDEVICE(AMD, 0x14DC), },
>  	{ PCI_VDEVICE(AMD, 0x149B), },
>  	/* Last entry must be zero */
>  	{ 0, }
> -- 
> 2.25.1

-- 
~Vinod

