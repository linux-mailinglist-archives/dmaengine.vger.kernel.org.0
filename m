Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CEC9531D07
	for <lists+dmaengine@lfdr.de>; Mon, 23 May 2022 22:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiEWTAu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 23 May 2022 15:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233887AbiEWTAI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 23 May 2022 15:00:08 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C54A7DE2F;
        Mon, 23 May 2022 11:42:00 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id h186so14407422pgc.3;
        Mon, 23 May 2022 11:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yKoU1SJPqVpbgU8oAxdSADtWsICRDctcrh0KswD9pRY=;
        b=DQASFIfdXwuVc8F8WYDnrbPBw9jlW7//o6irEVOd8pJzVSWW5mTqox1zxGqHbzHMKS
         01YGpqOOky15xFhNFshHGW7OG5wtI5LsnBo14fGwLurdOdLL1ptkMMCA4p5B6VdUwkqp
         p5Bb4+t+qjv/pM574HMBja/gq7VVqDT5Se5Jh0tCyLsi7bcTzG/sLnO2pI1v6TaCJJqQ
         7CPYoANXG9YcK7U41DWwMPAEsYyG6Ctg+zmiZPoY81neax48bmoDRJqZlviRGhvmGziS
         awRleU0rM+/RrHtO1Svo+BO9Z6kum0KIeaKzxPVTZKPenEAjD537TsL/sq9tMm46h2Oj
         DGbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yKoU1SJPqVpbgU8oAxdSADtWsICRDctcrh0KswD9pRY=;
        b=2PSYVrYmwm7mizKeMVrBGfpUrqhNs9++Vzgue0T2Dx7/DJMw1FM8FslXSZimuEREjG
         S3P0kuXQzxsTbx4KEuN3AyKRtERlW1CZRdIYGm5Y614xxFHbB5F7gED/fBDRyfMzLWVw
         5YZziOSOBFDZuOImEz02wbFblylOYJDfOf8N5DTmJ4dWNRe2yMXrAPiJnvqZVqYXb5+N
         vyqhrgBjWFYwykkjOLgReBZQC56AmN1lHnNPrRtE4cFJGKOEDbT+I3f+sJYbkxxb39P5
         zrJ9Pga2tlrH+fjzhDqxB8AKwbBkAdn9vDmkCD9djSVXRxDOTkKRxupy09MUHPtnKbkN
         QZOA==
X-Gm-Message-State: AOAM533UIppY4Iv/9ia1rLRZbbe+4AXQqJuAQRyv9KnEUswPH9MtRMRH
        OXUA8uQ4y0EXNdzXsAR+bmgBL4hnCQ1CM1U2hjQ=
X-Google-Smtp-Source: ABdhPJxrDpZf8N+PAG6bSWcS32Zs47lLTmHevOUS4J9gT1+lZQfrcwNHtowjc13dHtuYxwbbOcOwROkRwLnUWRr6yyU=
X-Received: by 2002:a05:6a00:22c3:b0:518:6a98:b06 with SMTP id
 f3-20020a056a0022c300b005186a980b06mr18616129pfj.3.1653331319596; Mon, 23 May
 2022 11:41:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220523110647.ndhijpwgtaf2rkar@mobilestation> <20220523180219.GA168248@bhelgaas>
In-Reply-To: <20220523180219.GA168248@bhelgaas>
From:   Zhi Li <lznuaa@gmail.com>
Date:   Mon, 23 May 2022 13:41:48 -0500
Message-ID: <CAHrpEqR9dXg-4pRFA89ggv4CHXXwU-pWeTb082YRdCzmOTUjVQ@mail.gmail.com>
Subject: Re: [PATCH v11 0/8] Enable designware PCI EP EDMA locally
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        hongxing.zhu@nxp.com, Lucas Stach <l.stach@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>, linux-pci@vger.kernel.org,
        dmaengine@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, May 23, 2022 at 1:02 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Mon, May 23, 2022 at 02:06:47PM +0300, Serge Semin wrote:
> > Hello Vinod,
> >
> > On Tue, May 17, 2022 at 10:19:07AM -0500, Frank Li wrote:
> > > Default Designware EDMA just probe remotely at host side.
> > > This patch allow EDMA driver can probe at EP side.
> > >
> > > 1. Clean up patch
> > >    dmaengine: dw-edma: Detach the private data and chip info structures
> > >    dmaengine: dw-edma: Remove unused field irq in struct dw_edma_chip
> > >    dmaengine: dw-edma: Change rg_region to reg_base in struct
> > >    dmaengine: dw-edma: rename wr(rd)_ch_cnt to ll_wr(rd)_cnt in struct
> > >
> > > 2. Enhance EDMA driver to allow prode eDMA at EP side
> > >    dmaengine: dw-edma: Add support for chip specific flags
> > >    dmaengine: dw-edma: Add DW_EDMA_CHIP_32BIT_DBI for chip specific
> > > flags (this patch removed at v11 because dma tree already have fixed
> > > patch)
> > >
> > > 3. Bugs fix at EDMA driver when probe eDMA at EP side
> > >    dmaengine: dw-edma: Fix programming the source & dest addresses for
> > > ep
> > >    dmaengine: dw-edma: Don't rely on the deprecated "direction" member
> > >
> > > 4. change pci-epf-test to use EDMA driver to transfer data.
> > >    PCI: endpoint: Add embedded DMA controller test
> > >
> > > 5. Using imx8dxl to do test, but some EP functions still have not
> > > upstream yet. So below patch show how probe eDMA driver at EP
> > > controller driver.
> > > https://lore.kernel.org/linux-pci/20220309120149.GB134091@thinkpad/T/#m979eb506c73ab3cfca2e7a43635ecdaec18d8097
> >
> > The series has been hanging out on review for over three months now.
> > It has got to v11 and has been tested on at least two platforms. The
> > original driver maintainer has been silent for all that time (most
> > likely Gustavo dropped the driver maintaining role). Could you please
> > merge it in seeing no comments have been posted for the last several
> > weeks? The PCI Host/EP controller drivers maintainer suggested to get
> > this series via the DMA-engine tree:
> > https://lore.kernel.org/linux-pci/YnqlRShJzvma2SKM@lpieralisi/
> > which is obviously right seeing it mainly concerns the DW eDMA driver.
> > Though after that Lorenzo disappeared as quickly as popped up.)
> >
> > There is one more series depending on the changes in this
> > patchset:
> > https://lore.kernel.org/linux-pci/20220503225104.12108-1-Sergey.Semin@baikalelectronics.ru/
> > Me and Frank already settled all the conflicts and inter-dependencies,
> > so at least his series is more than ready to be merged in into the
> > kernel repo. It would be very good to get it accepted on this merge
> > window so to have the kernel v5.19 with all this changes available.
>
> Since the v5.19 merge window is already open, it seems doubtful that
> anybody would merge this so late in the cycle.
>
> If Gustavo isn't available or willing to merge it, it looks like Vinod
> (maintainer of drivers/dma) would be the next logical candidate.

I think the last patch should not block other patches from merging.
The last patch about pci-epf-test.c is totally independent from other patches.

I prefer to merge all the dma patches first.

best regards
Frank Li

>
> I suspect Vinod would appreciate an ack or reviewed-by from Kishon for
> the last patch because he maintains pci-epf-test.c.
>
> I have a couple trivial comments on the pci-epf-test.c (I'll respond
> there), but I'm not qualified to ack it.
>
> Bjorn
