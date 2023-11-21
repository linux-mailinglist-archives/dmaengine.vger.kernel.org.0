Return-Path: <dmaengine+bounces-160-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 077EF7F2B0A
	for <lists+dmaengine@lfdr.de>; Tue, 21 Nov 2023 11:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3771E1C20B6B
	for <lists+dmaengine@lfdr.de>; Tue, 21 Nov 2023 10:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E502D603;
	Tue, 21 Nov 2023 10:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3VmgU9h"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5154CA;
	Tue, 21 Nov 2023 02:55:26 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-507cd62472dso6752846e87.0;
        Tue, 21 Nov 2023 02:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700564125; x=1701168925; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=f2/S1llZHvvLIHKm122xsgCS2RIget7hRyW8qLwZ7ko=;
        b=C3VmgU9hdt70XM7CdHoFJwadDy7MeEFhZ7ZV79GfKP6Z9MDCPEATJczDVLj81FoIh8
         oXBG2WDujh5CBPHf1Rb8Kk71cCtVcQY4pBWSlKQCSZiw6uYBkN2oe3DawYQ0luSRILAz
         8qlY6kq+5xz44B/BexRajzn8/cie3krfxcl0JtGlqus0lgt4Adtcz8KP1RS4NzxjmfNI
         Hp8ybJXh+hPp4TDveDZDUISSSwzO4oMnWz1nEZgTG5xo0i9tlVAhiwDq2nB4K0Kzt3Mo
         CfeTrr6MsPhPqUn6vCN3wz+WUPk/YMwaCvjISkX3wr8PQcN+PIfV+yi4JVbMp9MEWHdx
         XlIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700564125; x=1701168925;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f2/S1llZHvvLIHKm122xsgCS2RIget7hRyW8qLwZ7ko=;
        b=BG0fmjqAaayMpCtaVefQ5NKDX6wQG8LEW5dM0alyorSqTZVN0dJZM4bDOJOZemu2PZ
         jqU4cNJrOKdbV5zmH+xC9oyX4x7+2g4pcfhUgbj+Pi80X1/CY0DX3puSQ9wJfkXhE+6x
         5p97DUDPDANGwCmdcD4Ddy7b7iSqiLm5BNKTkZWxwvwBFo+G7SG6zB14hq5VQzPa8mui
         HbUxMkagqK9xetKo1wn/7TBR71WxlPT4UTq1JopIZLMEz4VWJ5+fGy/7FYRBdsFzz+qC
         l0nDY89IQuxrFz6DXwyQhm6xa7061/fRxafwB394V6Fy+ZhrsR2rMiywz5NFgDWIY5wE
         l9Mg==
X-Gm-Message-State: AOJu0YwPcsDDvgms/FK2p/X4jh4sEve65snO9v+tTPGP0FLgSjjWxYa/
	GFcKcQvc+H3ltgF2Z3FMUic=
X-Google-Smtp-Source: AGHT+IE3e2ZL/XJPgYOysbMx3oskqnrP6wW9vghbONMzCPL1lixksnEQv/+aEJh2lbAn6+Znd3txAA==
X-Received: by 2002:a05:6512:e9c:b0:506:8b41:7e31 with SMTP id bi28-20020a0565120e9c00b005068b417e31mr851408lfb.6.1700564124765;
        Tue, 21 Nov 2023 02:55:24 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id e13-20020ac24e0d000000b0050a3e7e718dsm1471530lfr.189.2023.11.21.02.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 02:55:24 -0800 (PST)
Date: Tue, 21 Nov 2023 13:55:22 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Kory Maincent <kory.maincent@bootlin.com>, 
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Vinod Koul <vkoul@kernel.org>, 
	Cai Huoqing <cai.huoqing@linux.dev>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Herve Codina <herve.codina@bootlin.com>
Subject: Re: [PATCH v6 0/6] Fix support of dw-edma HDMA NATIVE IP in remote
 setup
Message-ID: <js3qo4i67tdhbbcopvfaav4c7fzhz4tc2nai45rzfmbpq7l3xa@7ac2colelvnz>
References: <20231117-b4-feature_hdma_mainline-v6-0-ebf7aa0e40d7@bootlin.com>
 <20231121062629.GA3315@thinkpad>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231121062629.GA3315@thinkpad>

Hi Mani

On Tue, Nov 21, 2023 at 11:56:29AM +0530, Manivannan Sadhasivam wrote:
> On Fri, Nov 17, 2023 at 11:03:48AM +0100, Kory Maincent wrote:
> > This patch series fix the support of dw-edma HDMA NATIVE IP.
> > I can only test it in remote HDMA IP setup with single dma transfer, but
> > with these fixes it works properly.
> > 
> > Few fixes has also been added for eDMA version. Similarly to HDMA I have
> > tested only eDMA in remote setup.
> > 
> 
> Just out of curiosity, can you share how you are setting EDMA_MF_HDMA_NATIVE?

This topic has already been concerned on v1 (in another context
though):
https://lore.kernel.org/dmaengine/20230621151948.36125997@kmaincent-XPS-13-7390/

Here is the repo with the out-of-tree driver Kory said he was using
together with the kernel's version of the DW eDMA/hDMA driver:
https://github.com/Brainchip-Inc/akida_dw_edma

-Serge(y)

> 
> - Mani
> 
> > Changes in v2:
> > - Update comments and fix typos.
> > - Removed patches that tackle hypothetical bug and then were not pertinent.
> > - Add the similar HDMA race condition in remote setup fix to eDMA IP driver.
> > 
> > Changes in v3:
> > - Fix comment style.
> > - Split a patch in two to differ bug fix and simple harmless typo.
> > 
> > Changes in v4:
> > - Update patch git commit message.
> > - Link to v3: https://lore.kernel.org/r/20231011-b4-feature_hdma_mainline-v3-0-24ee0c979c6f@bootlin.com
> > 
> > Changes in v5:
> > - No change
> > - Rebase to mainline 6.7-rc1
> > - Link to v4: https://lore.kernel.org/r/20231011-b4-feature_hdma_mainline-v4-0-43d417b93138@bootlin.com
> > 
> > Changes in v6:
> > - Fix several commit messages and comments.
> > - Link to v5: https://lore.kernel.org/r/20231114-b4-feature_hdma_mainline-v5-0-7bc86d83c6f7@bootlin.com
> > 
> > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> > ---
> > Kory Maincent (6):
> >       dmaengine: dw-edma: Fix the ch_count hdma callback
> >       dmaengine: dw-edma: Fix wrong interrupt bit set for HDMA
> >       dmaengine: dw-edma: HDMA_V0_REMOTEL_STOP_INT_EN typo fix
> >       dmaengine: dw-edma: Add HDMA remote interrupt configuration
> >       dmaengine: dw-edma: HDMA: Add sync read before starting the DMA transfer in remote setup
> >       dmaengine: dw-edma: eDMA: Add sync read before starting the DMA transfer in remote setup
> > 
> >  drivers/dma/dw-edma/dw-edma-v0-core.c | 17 +++++++++++++++
> >  drivers/dma/dw-edma/dw-hdma-v0-core.c | 39 +++++++++++++++++++++++------------
> >  drivers/dma/dw-edma/dw-hdma-v0-regs.h |  2 +-
> >  3 files changed, 44 insertions(+), 14 deletions(-)
> > ---
> > base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
> > change-id: 20231011-b4-feature_hdma_mainline-b6c57f8e3b5d
> > 
> > Best regards,
> > -- 
> > Köry Maincent, Bootlin
> > Embedded Linux and kernel engineering
> > https://bootlin.com
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்

