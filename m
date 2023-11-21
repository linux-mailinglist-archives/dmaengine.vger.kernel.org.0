Return-Path: <dmaengine+bounces-162-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F1D7F326F
	for <lists+dmaengine@lfdr.de>; Tue, 21 Nov 2023 16:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DFB2B2189F
	for <lists+dmaengine@lfdr.de>; Tue, 21 Nov 2023 15:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738EA5810B;
	Tue, 21 Nov 2023 15:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dzMsCZWx"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C423910C;
	Tue, 21 Nov 2023 07:36:24 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-50aab3bf71fso3664879e87.3;
        Tue, 21 Nov 2023 07:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700580983; x=1701185783; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jMwkSetSrGsH8YXWn5E9oRyhdsEgnZ0K9d+hYpnmxv8=;
        b=dzMsCZWxgovsh6RSKgcAyFKU6bRd6AYqTQHrXyT21Nntrie3+snK93/TTAGYDkT1+2
         sghYeKyH6R3mWwB3IxH4yIeGs9DX682733dmrov5YpqDJSuXDbYa4M0M4msGIWF95cbV
         7in5IA3eCPL97ltAe8+zkliyZAnx/WpXXJpU/5XBJdLrj8+KC8vq4MLGV7lfbZ4j1IYI
         fEuZNbmIg2M/viB+/QqjelF8c5fM7wENIYBM0afvVaztDpvoj8t93+PBCwrYsLzUBw5M
         HPB1lMOm+qxPyHHHM7QB51I8cftoVaH3t+VfCzaf4EEQvX/Et+w1rsdtL3jxRw+yQ231
         TEFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700580983; x=1701185783;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jMwkSetSrGsH8YXWn5E9oRyhdsEgnZ0K9d+hYpnmxv8=;
        b=IwNj0l9i7nF77bfiZ+hEz4AiTp0kbAYKbqoWRdezOexs0fTDWEIie/glCDFYABa03U
         84upDIjrWOL4AZaGn9r+xf9oJy6OHKxO9upkBIawwWNfyI/aGYeaHIlAoPG9/nAHgqNH
         GVMs7Quz6B+clgKAG2NFAh9OC8JoprZjvUqKy1UAv3xBITQK7htVsvvHQNWSFJW9R841
         MRvmhi0KyRBdzntz8HBfBovdlNmFShw3+YWzqNuIRIw3PkJGbHcojOzUQDirWh7EOfe7
         npKaxYJE4DDfq2hLCgUtIrzjIPdXr8zuzjFPoyMgJkgXSqN5kvI8g4wdBvfQt8wIjTWs
         Gp1g==
X-Gm-Message-State: AOJu0Yw3tR75+TsGrqJ+qiQ0cyINYml9av065w0ypO2q0Uob1QP0IyNM
	sO0t++RG5Ocxs84KBiViMYcVIroJ3AI=
X-Google-Smtp-Source: AGHT+IHRCdxBLO692OEhkiaKU55WtxCQjl+pJfUrUegKHw5bdVxFoiaBFuIt1BmU0vEiXd1e3r4UQA==
X-Received: by 2002:a05:6512:2033:b0:50a:a2ba:fa86 with SMTP id s19-20020a056512203300b0050aa2bafa86mr7009361lfs.15.1700580982627;
        Tue, 21 Nov 2023 07:36:22 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id c11-20020a056512074b00b0050915816a16sm1552710lfs.145.2023.11.21.07.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 07:36:22 -0800 (PST)
Date: Tue, 21 Nov 2023 18:36:19 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Kory Maincent <kory.maincent@bootlin.com>, 
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Vinod Koul <vkoul@kernel.org>, 
	Cai Huoqing <cai.huoqing@linux.dev>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Herve Codina <herve.codina@bootlin.com>
Subject: Re: [PATCH v6 0/6] Fix support of dw-edma HDMA NATIVE IP in remote
 setup
Message-ID: <bqtgnsxqmvndog4jtmyy6lnj2cp4kh7c2lcwmjjqbet53vrhhn@i6fc6vxsvbam>
References: <20231117-b4-feature_hdma_mainline-v6-0-ebf7aa0e40d7@bootlin.com>
 <20231121062629.GA3315@thinkpad>
 <js3qo4i67tdhbbcopvfaav4c7fzhz4tc2nai45rzfmbpq7l3xa@7ac2colelvnz>
 <20231121120828.GC3315@thinkpad>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231121120828.GC3315@thinkpad>

On Tue, Nov 21, 2023 at 05:38:28PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Nov 21, 2023 at 01:55:22PM +0300, Serge Semin wrote:
> > Hi Mani
> > 
> > On Tue, Nov 21, 2023 at 11:56:29AM +0530, Manivannan Sadhasivam wrote:
> > > On Fri, Nov 17, 2023 at 11:03:48AM +0100, Kory Maincent wrote:
> > > > This patch series fix the support of dw-edma HDMA NATIVE IP.
> > > > I can only test it in remote HDMA IP setup with single dma transfer, but
> > > > with these fixes it works properly.
> > > > 
> > > > Few fixes has also been added for eDMA version. Similarly to HDMA I have
> > > > tested only eDMA in remote setup.
> > > > 
> > > 
> > > Just out of curiosity, can you share how you are setting EDMA_MF_HDMA_NATIVE?
> > 
> > This topic has already been concerned on v1 (in another context
> > though):
> > https://lore.kernel.org/dmaengine/20230621151948.36125997@kmaincent-XPS-13-7390/
> > 
> > Here is the repo with the out-of-tree driver Kory said he was using
> > together with the kernel's version of the DW eDMA/hDMA driver:
> > https://github.com/Brainchip-Inc/akida_dw_edma
> > 
> 

> Thanks Sergey, I missed it! But looks like we are not focusing on the HDMA
> integration in designware-ep.c. Have you/anyone thought about it? Was it
> discussed previously that I missed?

No. We haven't discussed that in the framework of this patchset.

> 
> HDMA is used in one of the recent Qcom SoCs (SA8775) that Qcom folks are
> bringing up and I'd like to have a common solution like we have for eDMA.

AFAICS it won't be that easy to do for HDMA. Unlike eDMA, HDMA doesn't
have a handy global config registers to determine the number of R/W
channels.  Kory also said that auto-detecting them by dummy-writing to
all the CH_EN registers didn't work either because all, even
unavailable, channels CSRs were writable. This part was discussed
earlier:
https://lore.kernel.org/lkml/20230607144014.6356a197@kmaincent-XPS-13-7390/
So if you don't come up with some more clever solution, then alas the
number of R/W channels will need to be specified by the platform
code/driver.

Regarding how to auto-detect HDMA. I can't be absolutely sure whether
it will work but if we assume that:
1. HDMA reg-space is always unrolled (mapped over a separate reg-space),
2. Lowest 16 bits of base+0x8 are RO in EDMA (DMA_CTRL_OFF) and RW in HDMA
(prefetch CSR),
then we can implement a procedure like this:

1. If iATU/xDMA reg-space is specified and it's writable at the
xDMA-base+0x8 then it's HDMA controller and amount of channels is
supposed to be pre-initialized by the low-level platform driver,
otherwise it's eDMA and the read value can be used to determine the
number of channels.
2. If iATU/xDMA reg-space isn't specified then the viewport-based eDMA
auto-detection procedure will be executed.

For all of that you'll need to fix the
dw_pcie_edma_find_chip()/dw_pcie_edma_detect() method somehow.

Alternatively, to keep things simple you can convert the
dw_pcie_edma_find_chip()/dw_pcie_edma_detect() methods to just relying
on the HDMA settings being fully specified by the low-level drivers.

-Serge(y)

> 
> - Mani
> 
> > -Serge(y)
> > 
> > > 
> > > - Mani
> > > 
> > > > Changes in v2:
> > > > - Update comments and fix typos.
> > > > - Removed patches that tackle hypothetical bug and then were not pertinent.
> > > > - Add the similar HDMA race condition in remote setup fix to eDMA IP driver.
> > > > 
> > > > Changes in v3:
> > > > - Fix comment style.
> > > > - Split a patch in two to differ bug fix and simple harmless typo.
> > > > 
> > > > Changes in v4:
> > > > - Update patch git commit message.
> > > > - Link to v3: https://lore.kernel.org/r/20231011-b4-feature_hdma_mainline-v3-0-24ee0c979c6f@bootlin.com
> > > > 
> > > > Changes in v5:
> > > > - No change
> > > > - Rebase to mainline 6.7-rc1
> > > > - Link to v4: https://lore.kernel.org/r/20231011-b4-feature_hdma_mainline-v4-0-43d417b93138@bootlin.com
> > > > 
> > > > Changes in v6:
> > > > - Fix several commit messages and comments.
> > > > - Link to v5: https://lore.kernel.org/r/20231114-b4-feature_hdma_mainline-v5-0-7bc86d83c6f7@bootlin.com
> > > > 
> > > > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> > > > ---
> > > > Kory Maincent (6):
> > > >       dmaengine: dw-edma: Fix the ch_count hdma callback
> > > >       dmaengine: dw-edma: Fix wrong interrupt bit set for HDMA
> > > >       dmaengine: dw-edma: HDMA_V0_REMOTEL_STOP_INT_EN typo fix
> > > >       dmaengine: dw-edma: Add HDMA remote interrupt configuration
> > > >       dmaengine: dw-edma: HDMA: Add sync read before starting the DMA transfer in remote setup
> > > >       dmaengine: dw-edma: eDMA: Add sync read before starting the DMA transfer in remote setup
> > > > 
> > > >  drivers/dma/dw-edma/dw-edma-v0-core.c | 17 +++++++++++++++
> > > >  drivers/dma/dw-edma/dw-hdma-v0-core.c | 39 +++++++++++++++++++++++------------
> > > >  drivers/dma/dw-edma/dw-hdma-v0-regs.h |  2 +-
> > > >  3 files changed, 44 insertions(+), 14 deletions(-)
> > > > ---
> > > > base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
> > > > change-id: 20231011-b4-feature_hdma_mainline-b6c57f8e3b5d
> > > > 
> > > > Best regards,
> > > > -- 
> > > > Köry Maincent, Bootlin
> > > > Embedded Linux and kernel engineering
> > > > https://bootlin.com
> > > > 
> > > 
> > > -- 
> > > மணிவண்ணன் சதாசிவம்
> 
> -- 
> மணிவண்ணன் சதாசிவம்

