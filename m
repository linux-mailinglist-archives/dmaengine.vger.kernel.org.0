Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21FFD53229E
	for <lists+dmaengine@lfdr.de>; Tue, 24 May 2022 07:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234579AbiEXFs7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 May 2022 01:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234584AbiEXFs6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 24 May 2022 01:48:58 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F12939E5;
        Mon, 23 May 2022 22:48:56 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id l13so22356835lfp.11;
        Mon, 23 May 2022 22:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=H18/diuQsn2SRstWPJPGfq5VlI/RQJTDhHU4jrNBf84=;
        b=i5cg1d9WjX/nSo2tyvAbHSwH88Zgr1sjlSriU4zGDEhDHawS19JxonpWgNXEqIvET/
         5PwXaUiuYKUSNO1JNO8pJmJWU8okAnOGR0/7tO8HKVGYNUtyVawX+Wt2RWd9sEmBBRa2
         lfdtAsvi24+kZuHby4L2pSaIg7yC/pZVyFljuwqp6Fisqg+JWaxrtJcqIzyC4ygVUJSy
         FazI7vbhMmR3m45z3o4E5/xq29J1X3fC8Mv/id/XQF6wlxDeV7Ln8nMvGbQtape+TU7n
         6L3SEfRbt2yPjsNwSCqQQxTQphQ3v7IcuJPWeVlZGFVUi/xXJuLKy66DFDCkJwsoMt/i
         b2lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H18/diuQsn2SRstWPJPGfq5VlI/RQJTDhHU4jrNBf84=;
        b=w8q9ADBgAXJdTowlJp/pfpKwfjcV1VV6VfuZYSlYvuC64u/5RPRAmnkdGyiLK8So/Q
         7DT4V+qa5JRrBG2AZrWZocSGAnXHGzxWcxeOiTM8+6lGVZdI78anh4c3EdkasDzoadan
         g/Pqqw2Tf3xtnTarP5ESiTaEqr6NORcUZzY09g4olAcaKiUoqKpCTM92R29cweain98a
         jC8gdRU81qLMwidSKzdFuaMEtJjeR8KGimSrZFQfgJQN/Zl0eBv9R5VuEyJxX9WGXRq2
         HbW0i4bduxM0gCOUaY7MJcas0aVqc65PjiqfvkmhUSEkuIb/tR5Cj/w52AJzI/Pjqxh3
         FVUg==
X-Gm-Message-State: AOAM530DaEmOEYbfKs7Zg3c8bHsYpWLv4olaQ38asZkJ7iH9IhLXUZr5
        QHRck3RAWXAV8XAg8bH2Qc8=
X-Google-Smtp-Source: ABdhPJw9WfQDAQjPx96j0UbjRTHOgXLJAEoLKsFumpwYvKQtV30qhJezY7jgXph3RzIYEK8jVZBN0Q==
X-Received: by 2002:a05:6512:2205:b0:478:53d5:bdb1 with SMTP id h5-20020a056512220500b0047853d5bdb1mr13618801lfu.561.1653371334538;
        Mon, 23 May 2022 22:48:54 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id n12-20020ac242cc000000b00473e8c88b92sm2341977lfl.117.2022.05.23.22.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 22:48:53 -0700 (PDT)
Date:   Tue, 24 May 2022 08:48:50 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Zhi Li <lznuaa@gmail.com>, Vinod Koul <vkoul@kernel.org>,
        Frank Li <Frank.Li@nxp.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        hongxing.zhu@nxp.com, Lucas Stach <l.stach@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>, linux-pci@vger.kernel.org,
        dmaengine@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH v11 0/8] Enable designware PCI EP EDMA locally
Message-ID: <20220524054850.vrchh6icwfriszhn@mobilestation>
References: <CAHrpEqR9dXg-4pRFA89ggv4CHXXwU-pWeTb082YRdCzmOTUjVQ@mail.gmail.com>
 <20220523221256.GA221421@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523221256.GA221421@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Bjorn

On Mon, May 23, 2022 at 05:12:56PM -0500, Bjorn Helgaas wrote:
> On Mon, May 23, 2022 at 01:41:48PM -0500, Zhi Li wrote:
> > On Mon, May 23, 2022 at 1:02 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Mon, May 23, 2022 at 02:06:47PM +0300, Serge Semin wrote:
> > > > Hello Vinod,
> > > >
> > > > On Tue, May 17, 2022 at 10:19:07AM -0500, Frank Li wrote:
> > > > > Default Designware EDMA just probe remotely at host side.
> > > > > This patch allow EDMA driver can probe at EP side.
> > > > >
> > > > > 1. Clean up patch
> > > > >    dmaengine: dw-edma: Detach the private data and chip info structures
> > > > >    dmaengine: dw-edma: Remove unused field irq in struct dw_edma_chip
> > > > >    dmaengine: dw-edma: Change rg_region to reg_base in struct
> > > > >    dmaengine: dw-edma: rename wr(rd)_ch_cnt to ll_wr(rd)_cnt in struct
> > > > >
> > > > > 2. Enhance EDMA driver to allow prode eDMA at EP side
> > > > >    dmaengine: dw-edma: Add support for chip specific flags
> > > > >    dmaengine: dw-edma: Add DW_EDMA_CHIP_32BIT_DBI for chip specific
> > > > > flags (this patch removed at v11 because dma tree already have fixed
> > > > > patch)
> > > > >
> > > > > 3. Bugs fix at EDMA driver when probe eDMA at EP side
> > > > >    dmaengine: dw-edma: Fix programming the source & dest addresses for
> > > > > ep
> > > > >    dmaengine: dw-edma: Don't rely on the deprecated "direction" member
> > > > >
> > > > > 4. change pci-epf-test to use EDMA driver to transfer data.
> > > > >    PCI: endpoint: Add embedded DMA controller test
> > > > >
> > > > > 5. Using imx8dxl to do test, but some EP functions still have not
> > > > > upstream yet. So below patch show how probe eDMA driver at EP
> > > > > controller driver.
> > > > > https://lore.kernel.org/linux-pci/20220309120149.GB134091@thinkpad/T/#m979eb506c73ab3cfca2e7a43635ecdaec18d8097
> > > >
> > > > The series has been hanging out on review for over three months now.
> > > > It has got to v11 and has been tested on at least two platforms. The
> > > > original driver maintainer has been silent for all that time (most
> > > > likely Gustavo dropped the driver maintaining role). Could you please
> > > > merge it in seeing no comments have been posted for the last several
> > > > weeks? The PCI Host/EP controller drivers maintainer suggested to get
> > > > this series via the DMA-engine tree:
> > > > https://lore.kernel.org/linux-pci/YnqlRShJzvma2SKM@lpieralisi/
> > > > which is obviously right seeing it mainly concerns the DW eDMA driver.
> > > > Though after that Lorenzo disappeared as quickly as popped up.)
> > > >
> > > > There is one more series depending on the changes in this
> > > > patchset:
> > > > https://lore.kernel.org/linux-pci/20220503225104.12108-1-Sergey.Semin@baikalelectronics.ru/
> > > > Me and Frank already settled all the conflicts and inter-dependencies,
> > > > so at least his series is more than ready to be merged in into the
> > > > kernel repo. It would be very good to get it accepted on this merge
> > > > window so to have the kernel v5.19 with all this changes available.
> > >

> > > Since the v5.19 merge window is already open, it seems doubtful that
> > > anybody would merge this so late in the cycle.

In this case it would be safer to merge this whole series through your
repo. See my series:
"[PATCH v2 00/26] dmaengine: dw-edma: Add RP/EP local DMA controllers support"
https://lore.kernel.org/linux-pci/20220503225104.12108-1-Sergey.Semin@baikalelectronics.ru/
depends in the Frank' patchset. Meanwhile my patchset is also based on the
DW PCIe modifications introduced in the set of the series:
"[PATCH v2 00/17] PCI: dwc: Add dma-ranges/YAML-schema/Baikal-T1 support"
https://lore.kernel.org/linux-pci/20220503214638.1895-1-Sergey.Semin@baikalelectronics.ru/
and
"[PATCH v3 00/13] PCI: dwc: Various fixes and cleanups"
https://lore.kernel.org/linux-pci/20220517125058.18488-1-Sergey.Semin@baikalelectronics.ru/

So to speak in order to have more coherent repos with least merge,
logical problems the next order of the merging would be preferable:
1) Frank's patchset (ready to be merged in):
[PATCH v11 0/8] Enable designware PCI EP EDMA locally
https://lore.kernel.org/linux-pci/20220517151915.2212838-1-Frank.Li@nxp.com
2) My series (ready to be merged in):
[PATCH v3 00/13] PCI: dwc: Various fixes and cleanups
https://lore.kernel.org/linux-pci/20220517125058.18488-1-Sergey.Semin@baikalelectronics.ru/
3) My series (still in review, I need to fix some Rob' and Manivannan' notes)
[PATCH v2 00/17] PCI: dwc: Add dma-ranges/YAML-schema/Baikal-T1 support
https://lore.kernel.org/linux-pci/20220503214638.1895-1-Sergey.Semin@baikalelectronics.ru/
4) Me series (ready to be merged in, but depends on the prev patchsets):
https://lore.kernel.org/linux-pci/20220503225104.12108-1-Sergey.Semin@baikalelectronics.ru/

Seeing the Frank patches won't make it into the mainline repo on
this merge window, it would be great to collect all the changes in a
single repository. Seeing Lorenzo disappeared as fast as popped up
your repo is the best candidate since the DW eDMA block is a part of
the DW PCIe controller.

> > >
> > > If Gustavo isn't available or willing to merge it, it looks like Vinod
> > > (maintainer of drivers/dma) would be the next logical candidate.
> > 
> > I think the last patch should not block other patches from merging.
> > The last patch about pci-epf-test.c is totally independent from other patches.
> > 
> > I prefer to merge all the dma patches first.
> 
> Absolutely.  
> 

> Given an ack from Kishon, it would make sense for Vinod to merge them
> all together since they're logically related, but I have no objection
> to merging any of the drivers/dma patches separately.

Please see my comment above.

Thanks
-Sergey

> 
> Bjorn
