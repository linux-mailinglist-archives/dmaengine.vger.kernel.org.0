Return-Path: <dmaengine+bounces-182-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 844BD7F4DF5
	for <lists+dmaengine@lfdr.de>; Wed, 22 Nov 2023 18:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B11F7B20C88
	for <lists+dmaengine@lfdr.de>; Wed, 22 Nov 2023 17:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2BC4E629;
	Wed, 22 Nov 2023 17:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r/4JHaKW"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921734BA89
	for <dmaengine@vger.kernel.org>; Wed, 22 Nov 2023 17:12:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 558D5C433C8;
	Wed, 22 Nov 2023 17:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700673177;
	bh=HUTD8xpMc9WU9D9MA+DlhRXxHESV5HWBP+wnlIUOgnM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r/4JHaKWX3NX08PYu39vHlovyPaDQ4fHpqxslpOa4cryj6YVwAKcwiiuHxArmrcdV
	 GJ9Wr7rszHIBdkeT9R4ACDJwyNBXR5Lf2K5rpPHPep9B42hF/UB4MST18MjCBL6FUo
	 mCNNMw9eEs+zExC4meYNQNNTTCrOmAHbsAX1ERYlPOJz/j/YV4oCVM2DfROZdDyfLm
	 Tyvu+f7a/k7ab+ZdtS3CEo6U5bMCbP6nh98FrO0D2mltWAcoyhKfN3W9+e+o9WHE+4
	 lXhzYS9TME8YFp44qIilQwA/qqHt5GyHKTbeIMRcbrj+RbnrhefzlOFPG0h9XVw6j0
	 nCoeupnkIsyTw==
Date: Wed, 22 Nov 2023 22:42:42 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>, Cai Huoqing <cai.huoqing@linux.dev>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	Herve Codina <herve.codina@bootlin.com>
Subject: Re: [PATCH v6 0/6] Fix support of dw-edma HDMA NATIVE IP in remote
 setup
Message-ID: <20231122171242.GA266396@thinkpad>
References: <20231117-b4-feature_hdma_mainline-v6-0-ebf7aa0e40d7@bootlin.com>
 <20231121062629.GA3315@thinkpad>
 <js3qo4i67tdhbbcopvfaav4c7fzhz4tc2nai45rzfmbpq7l3xa@7ac2colelvnz>
 <20231121120828.GC3315@thinkpad>
 <bqtgnsxqmvndog4jtmyy6lnj2cp4kh7c2lcwmjjqbet53vrhhn@i6fc6vxsvbam>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bqtgnsxqmvndog4jtmyy6lnj2cp4kh7c2lcwmjjqbet53vrhhn@i6fc6vxsvbam>

On Tue, Nov 21, 2023 at 06:36:19PM +0300, Serge Semin wrote:
> On Tue, Nov 21, 2023 at 05:38:28PM +0530, Manivannan Sadhasivam wrote:
> > On Tue, Nov 21, 2023 at 01:55:22PM +0300, Serge Semin wrote:
> > > Hi Mani
> > > 
> > > On Tue, Nov 21, 2023 at 11:56:29AM +0530, Manivannan Sadhasivam wrote:
> > > > On Fri, Nov 17, 2023 at 11:03:48AM +0100, Kory Maincent wrote:
> > > > > This patch series fix the support of dw-edma HDMA NATIVE IP.
> > > > > I can only test it in remote HDMA IP setup with single dma transfer, but
> > > > > with these fixes it works properly.
> > > > > 
> > > > > Few fixes has also been added for eDMA version. Similarly to HDMA I have
> > > > > tested only eDMA in remote setup.
> > > > > 
> > > > 
> > > > Just out of curiosity, can you share how you are setting EDMA_MF_HDMA_NATIVE?
> > > 
> > > This topic has already been concerned on v1 (in another context
> > > though):
> > > https://lore.kernel.org/dmaengine/20230621151948.36125997@kmaincent-XPS-13-7390/
> > > 
> > > Here is the repo with the out-of-tree driver Kory said he was using
> > > together with the kernel's version of the DW eDMA/hDMA driver:
> > > https://github.com/Brainchip-Inc/akida_dw_edma
> > > 
> > 
> 
> > Thanks Sergey, I missed it! But looks like we are not focusing on the HDMA
> > integration in designware-ep.c. Have you/anyone thought about it? Was it
> > discussed previously that I missed?
> 
> No. We haven't discussed that in the framework of this patchset.
> 
> > 
> > HDMA is used in one of the recent Qcom SoCs (SA8775) that Qcom folks are
> > bringing up and I'd like to have a common solution like we have for eDMA.
> 
> AFAICS it won't be that easy to do for HDMA. Unlike eDMA, HDMA doesn't
> have a handy global config registers to determine the number of R/W
> channels.  Kory also said that auto-detecting them by dummy-writing to
> all the CH_EN registers didn't work either because all, even
> unavailable, channels CSRs were writable. This part was discussed
> earlier:
> https://lore.kernel.org/lkml/20230607144014.6356a197@kmaincent-XPS-13-7390/
> So if you don't come up with some more clever solution, then alas the
> number of R/W channels will need to be specified by the platform
> code/driver.
> 
> Regarding how to auto-detect HDMA. I can't be absolutely sure whether
> it will work but if we assume that:
> 1. HDMA reg-space is always unrolled (mapped over a separate reg-space),
> 2. Lowest 16 bits of base+0x8 are RO in EDMA (DMA_CTRL_OFF) and RW in HDMA
> (prefetch CSR),
> then we can implement a procedure like this:
> 
> 1. If iATU/xDMA reg-space is specified and it's writable at the
> xDMA-base+0x8 then it's HDMA controller and amount of channels is
> supposed to be pre-initialized by the low-level platform driver,
> otherwise it's eDMA and the read value can be used to determine the
> number of channels.
> 2. If iATU/xDMA reg-space isn't specified then the viewport-based eDMA
> auto-detection procedure will be executed.
> 
> For all of that you'll need to fix the
> dw_pcie_edma_find_chip()/dw_pcie_edma_detect() method somehow.
> 
> Alternatively, to keep things simple you can convert the
> dw_pcie_edma_find_chip()/dw_pcie_edma_detect() methods to just relying
> on the HDMA settings being fully specified by the low-level drivers.
> 

This looks like the best possible solution at the moment. Thanks for the
insight!

I will post the patches together with the HDMA enablement ones.

- Mani

> -Serge(y)
> 
> > 
> > - Mani
> > 
> > > -Serge(y)
> > > 
> > > > 
> > > > - Mani
> > > > 
> > > > > Changes in v2:
> > > > > - Update comments and fix typos.
> > > > > - Removed patches that tackle hypothetical bug and then were not pertinent.
> > > > > - Add the similar HDMA race condition in remote setup fix to eDMA IP driver.
> > > > > 
> > > > > Changes in v3:
> > > > > - Fix comment style.
> > > > > - Split a patch in two to differ bug fix and simple harmless typo.
> > > > > 
> > > > > Changes in v4:
> > > > > - Update patch git commit message.
> > > > > - Link to v3: https://lore.kernel.org/r/20231011-b4-feature_hdma_mainline-v3-0-24ee0c979c6f@bootlin.com
> > > > > 
> > > > > Changes in v5:
> > > > > - No change
> > > > > - Rebase to mainline 6.7-rc1
> > > > > - Link to v4: https://lore.kernel.org/r/20231011-b4-feature_hdma_mainline-v4-0-43d417b93138@bootlin.com
> > > > > 
> > > > > Changes in v6:
> > > > > - Fix several commit messages and comments.
> > > > > - Link to v5: https://lore.kernel.org/r/20231114-b4-feature_hdma_mainline-v5-0-7bc86d83c6f7@bootlin.com
> > > > > 
> > > > > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> > > > > ---
> > > > > Kory Maincent (6):
> > > > >       dmaengine: dw-edma: Fix the ch_count hdma callback
> > > > >       dmaengine: dw-edma: Fix wrong interrupt bit set for HDMA
> > > > >       dmaengine: dw-edma: HDMA_V0_REMOTEL_STOP_INT_EN typo fix
> > > > >       dmaengine: dw-edma: Add HDMA remote interrupt configuration
> > > > >       dmaengine: dw-edma: HDMA: Add sync read before starting the DMA transfer in remote setup
> > > > >       dmaengine: dw-edma: eDMA: Add sync read before starting the DMA transfer in remote setup
> > > > > 
> > > > >  drivers/dma/dw-edma/dw-edma-v0-core.c | 17 +++++++++++++++
> > > > >  drivers/dma/dw-edma/dw-hdma-v0-core.c | 39 +++++++++++++++++++++++------------
> > > > >  drivers/dma/dw-edma/dw-hdma-v0-regs.h |  2 +-
> > > > >  3 files changed, 44 insertions(+), 14 deletions(-)
> > > > > ---
> > > > > base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
> > > > > change-id: 20231011-b4-feature_hdma_mainline-b6c57f8e3b5d
> > > > > 
> > > > > Best regards,
> > > > > -- 
> > > > > Köry Maincent, Bootlin
> > > > > Embedded Linux and kernel engineering
> > > > > https://bootlin.com
> > > > > 
> > > > 
> > > > -- 
> > > > மணிவண்ணன் சதாசிவம்
> > 
> > -- 
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்

