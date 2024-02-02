Return-Path: <dmaengine+bounces-928-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 900BC8469D5
	for <lists+dmaengine@lfdr.de>; Fri,  2 Feb 2024 08:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2EBD1C2641E
	for <lists+dmaengine@lfdr.de>; Fri,  2 Feb 2024 07:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9360C17BD8;
	Fri,  2 Feb 2024 07:54:15 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7610D1775E;
	Fri,  2 Feb 2024 07:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706860455; cv=none; b=jGodFYUGIWcsQYzS7B5wmwQQ8HBCtQ3qlPmEeFr95rwnxXq3hYAZtXuIFEEu35mOv5+q0YDSH2338Eq0T8A9/6PjMb7L0tDyxee6KsXBF1y9+TGWZdEbX6Pnr0WgZoa65XvNAmf2Xq3McShcTig2gi5tQKypcypZ+mOcFuM4iEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706860455; c=relaxed/simple;
	bh=w4xTyhUs6hnT2Oqe8oeFy8xVNAsxkW8LLq4nQWxQ6tE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tl6A4/r5PI14D2nufdY7xrVQTQKvxAr/ggQ+diBzvbEuq70IhpPtJcAxiH4OFhYs4Zz+94pltDWnUYmMV69bqPyNEPimHJU1/pXLOjTVZhAwnCeDKA8L4SCJWkLwpreFUi7z/Twi4CPjK9l/3+yJVe9xNajau5co1/sYcNZ3c5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52DB6C433F1;
	Fri,  2 Feb 2024 07:54:10 +0000 (UTC)
Date: Fri, 2 Feb 2024 13:24:06 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Vinod Koul <vkoul@kernel.org>,
	Kory Maincent <kory.maincent@bootlin.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Cai Huoqing <cai.huoqing@linux.dev>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	Herve Codina <herve.codina@bootlin.com>
Subject: Re: [PATCH v7 0/6] Fix support of dw-edma HDMA NATIVE IP in remote
 setup
Message-ID: <20240202075406.GB2961@thinkpad>
References: <20240129-b4-feature_hdma_mainline-v7-0-8e8c1acb7a46@bootlin.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240129-b4-feature_hdma_mainline-v7-0-8e8c1acb7a46@bootlin.com>

On Mon, Jan 29, 2024 at 05:25:56PM +0100, Kory Maincent wrote:
> This patch series fix the support of dw-edma HDMA NATIVE IP.
> I can only test it in remote HDMA IP setup with single dma transfer, but
> with these fixes it works properly.
> 
> Few fixes has also been added for eDMA version. Similarly to HDMA I have
> tested only eDMA in remote setup.
> 

Vinod, could you please merge this series for v6.9? This already missed previous
release.

- Mani

> Changes in v2:
> - Update comments and fix typos.
> - Removed patches that tackle hypothetical bug and then were not pertinent.
> - Add the similar HDMA race condition in remote setup fix to eDMA IP driver.
> 
> Changes in v3:
> - Fix comment style.
> - Split a patch in two to differ bug fix and simple harmless typo.
> 
> Changes in v4:
> - Update patch git commit message.
> - Link to v3: https://lore.kernel.org/r/20231011-b4-feature_hdma_mainline-v3-0-24ee0c979c6f@bootlin.com
> 
> Changes in v5:
> - No change
> - Rebase to mainline 6.7-rc1
> - Link to v4: https://lore.kernel.org/r/20231011-b4-feature_hdma_mainline-v4-0-43d417b93138@bootlin.com
> 
> Changes in v6:
> - Fix several commit messages and comments.
> - Link to v5: https://lore.kernel.org/r/20231114-b4-feature_hdma_mainline-v5-0-7bc86d83c6f7@bootlin.com
> 
> Changes in v7:
> - No change, ready for merge
> - Rebase to mainline 6.8-rc2
> - Link to v6: https://lore.kernel.org/r/20231117-b4-feature_hdma_mainline-v6-0-ebf7aa0e40d7@bootlin.com
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
> Kory Maincent (6):
>       dmaengine: dw-edma: Fix the ch_count hdma callback
>       dmaengine: dw-edma: Fix wrong interrupt bit set for HDMA
>       dmaengine: dw-edma: HDMA_V0_REMOTEL_STOP_INT_EN typo fix
>       dmaengine: dw-edma: Add HDMA remote interrupt configuration
>       dmaengine: dw-edma: HDMA: Add sync read before starting the DMA transfer in remote setup
>       dmaengine: dw-edma: eDMA: Add sync read before starting the DMA transfer in remote setup
> 
>  drivers/dma/dw-edma/dw-edma-v0-core.c | 17 +++++++++++++++
>  drivers/dma/dw-edma/dw-hdma-v0-core.c | 39 +++++++++++++++++++++++------------
>  drivers/dma/dw-edma/dw-hdma-v0-regs.h |  2 +-
>  3 files changed, 44 insertions(+), 14 deletions(-)
> ---
> base-commit: 41bccc98fb7931d63d03f326a746ac4d429c1dd3
> change-id: 20231011-b4-feature_hdma_mainline-b6c57f8e3b5d
> 
> Best regards,
> -- 
> Köry Maincent, Bootlin
> Embedded Linux and kernel engineering
> https://bootlin.com
> 

-- 
மணிவண்ணன் சதாசிவம்

