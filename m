Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566374D52BC
	for <lists+dmaengine@lfdr.de>; Thu, 10 Mar 2022 21:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343788AbiCJUBq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 10 Mar 2022 15:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343798AbiCJUBq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 10 Mar 2022 15:01:46 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71560190B5C;
        Thu, 10 Mar 2022 12:00:43 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id w12so11329512lfr.9;
        Thu, 10 Mar 2022 12:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cvWzDkP/UazDdzl8XOgL+ab/JYSV7GQ5duX0Ncw81yg=;
        b=dCQzPW320C+PQLw5LKxY91p2v90bIwPPHmeAYCClOqrw51A67pztm0cUAJS1dH64xQ
         wX3rUSUzLgZQaYiqaOMQfi7q/mML/4zRzRUvIo4goMUVJqD3e0VxOTpJeZvzjGpPVaMa
         O1vAQXA4EgEmfuiHaFWvCNPATTDGoVQA/LA5BgLzr2hVnU01VlAS7TmQxO2mM2Acr3At
         T9e5Ntyc9+NqGEixu7uVX02QW+yUQO8E/2zuJ87r/TkuKvOy1YrmPDnvwiz7mrry4Ri6
         Ggj8sjp8VU4CfXXUYnPbazpXrphTNM8SKSe9H/r7SSZC2li/OcY6wr2Jj6TvY0svPzwf
         IdjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cvWzDkP/UazDdzl8XOgL+ab/JYSV7GQ5duX0Ncw81yg=;
        b=XfnUVrgUqA+qzf4tkHck9nXehnhto1B0ATvyPjwTcgeTzTSGTkNWsW9efgIAqjV1wO
         K94bYSoJmNc46i4MaM+GSrD24BlthrqZGLwI+sLME1JqVCfaka1wl3vQnKr3eQq14+t/
         ttkfv8cm7ymZsfIxMFemDx7I44votlDnG6gs1eNQMX/isPM9vghcmb5QlA+Fqtz6Y0rk
         Z+eFxX8QQrbURygd0UrhC3BrzY98buHx6I+Ky7Hy74gscF1QvTu4HSV2slsjnt8XtoAM
         ZviY/zdyWazoinRjpbAVz6jg9yALlZF9uTfzJyvKR+dmxcznXhhdG7LC2nMCDXZ+iLEG
         WUag==
X-Gm-Message-State: AOAM530heZKHRyzYfqLuoNRHKRX1aNLlvusxf8M+u32DKjGvnINNxJdy
        yvFLnNhvjyyzQh5VA+kZUgE=
X-Google-Smtp-Source: ABdhPJxh1RzZKL2UICo57++LNelnVUB2GyP3ZaLUeRVAjootmJV4+46Wx0RyXeE8pzaLpM55Xf+gZg==
X-Received: by 2002:a05:6512:c08:b0:448:56a2:b936 with SMTP id z8-20020a0565120c0800b0044856a2b936mr3799353lfu.636.1646942441646;
        Thu, 10 Mar 2022 12:00:41 -0800 (PST)
Received: from mobilestation ([95.79.188.22])
        by smtp.gmail.com with ESMTPSA id k17-20020a0565123d9100b00448390e8908sm1145394lfv.124.2022.03.10.12.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 12:00:28 -0800 (PST)
Date:   Thu, 10 Mar 2022 23:00:26 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        lznuaa@gmail.com, vkoul@kernel.org, lorenzo.pieralisi@arm.com,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        shawnguo@kernel.org, manivannan.sadhasivam@linaro.org
Subject: Re: [PATCH v5 0/9] Enable designware PCI EP EDMA locally
Message-ID: <20220310200026.3isqmkqiwulojw2j@mobilestation>
References: <20220310192457.3090-1-Frank.Li@nxp.com>
 <20220310194521.g6emg63bparbjic2@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310194521.g6emg63bparbjic2@mobilestation>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On Thu, Mar 10, 2022 at 10:53:45PM +0300, Serge Semin wrote:
> Frank,
> 
> Please don't re-send patch so quickly. We haven't finished discussing
> and reviewing v4 yet, but you've already sent out v5 with possibly some of
> the comments missed. In addition you haven't addressed all my comments
> in the v4. Please get back there and let's finish all the discussions
> first. Regarding the resibmitting procedure see [1].
> 
> [1] Documentation/process/submitting-patches.rst: "Don't get discouraged - or impatient"

Note due to that you've missed not only my comments, but also the
Mani' ones. Like this:
https://lore.kernel.org/dmaengine/20220310075539.GD4869@thinkpad/

Please be patient. We are spending our time reviewing your patchset in
an attempt to make it better, and the kernel code/repo log to be more
readable and coherent. Skipping some comments not only wastes our time,
but looks like disregard to the work we've done.

As soon as you see all the discussions are over, and there is no need
to wait for additional comments, then you can re-spin the series.

-Sergey

> 
> -Sergey
> 
> On Thu, Mar 10, 2022 at 01:24:48PM -0600, Frank Li wrote:
> > Default Designware EDMA just probe remotely at host side.
> > This patch allow EDMA driver can probe at EP side.
> > 
> > 1. Clean up patch
> >    dmaengine: dw-edma: Detach the private data and chip info structures
> >    dmaengine: dw-edma: remove unused field irq in struct dw_edma_chip
> >    dmaengine: dw-edma: change rg_region to reg_base in struct
> >    dmaengine: dw-edma: rename wr(rd)_ch_cnt to ll_wr(rd)_cnt in struct
> > 
> > 2. Enhance EDMA driver to allow prode eDMA at EP side
> >    dmaengine: dw-edma: Add support for chip specific flags   
> >    dmaengine: dw-edma: Add DW_EDMA_CHIP_32BIT_DBI for chip specific flags
> > 
> > 3. Bugs fix at EDMA driver when probe eDMA at EP side
> >    dmaengine: dw-edma: Fix programming the source & dest addresses for ep
> >    dmaengine: dw-edma: Don't rely on the deprecated "direction" member
> > 
> > 4. change pci-epf-test to use EDMA driver to transfer data.
> >    PCI: endpoint: functions/pci-epf-test: Support PCI controller DMA
> > 
> > 5. Using imx8dxl to do test, but some EP functions still have not
> > upstream yet. So below patch show how probe eDMA driver at EP
> > controller driver.
> > https://lore.kernel.org/linux-pci/20220309120149.GB134091@thinkpad/T/#m979eb506c73ab3cfca2e7a43635ecdaec18d8097
> > 
> > 
> > 
> > Frank Li (7):
> >   dmaengine: dw-edma: Detach the private data and chip info structures
> >   dmaengine: dw-edma: remove unused field irq in struct dw_edma_chip
> >   dmaengine: dw-edma: change rg_region to reg_base in struct
> >     dw_edma_chip
> >   dmaengine: dw-edma: rename wr(rd)_ch_cnt to ll_wr(rd)_cnt in struct
> >     dw_edma_chip
> >   dmaengine: dw-edma: Add support for chip specific flags
> >   dmaengine: dw-edma: Add DW_EDMA_CHIP_32BIT_DBI for chip specific flags
> >   PCI: endpoint: functions/pci-epf-test: Support PCI controller DMA
> > 
> > Manivannan Sadhasivam (2):
> >   dmaengine: dw-edma: Fix programming the source & dest addresses for ep
> >   dmaengine: dw-edma: Don't rely on the deprecated "direction" member
> > 
> >  drivers/dma/dw-edma/dw-edma-core.c            | 131 +++++++++++-------
> >  drivers/dma/dw-edma/dw-edma-core.h            |  32 +----
> >  drivers/dma/dw-edma/dw-edma-pcie.c            |  83 +++++------
> >  drivers/dma/dw-edma/dw-edma-v0-core.c         |  46 +++---
> >  drivers/dma/dw-edma/dw-edma-v0-debugfs.c      |  10 +-
> >  drivers/pci/endpoint/functions/pci-epf-test.c | 108 +++++++++++++--
> >  include/linux/dma/edma.h                      |  56 +++++++-
> >  7 files changed, 298 insertions(+), 168 deletions(-)
> > 
> > -- 
> > 2.24.0.rc1
> > 
