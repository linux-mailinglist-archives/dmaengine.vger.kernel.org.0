Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08DE6C283B
	for <lists+dmaengine@lfdr.de>; Tue, 21 Mar 2023 03:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjCUCcP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 20 Mar 2023 22:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjCUCcO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 20 Mar 2023 22:32:14 -0400
Received: from out-41.mta0.migadu.com (out-41.mta0.migadu.com [91.218.175.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660A5399EC;
        Mon, 20 Mar 2023 19:31:53 -0700 (PDT)
Date:   Tue, 21 Mar 2023 10:31:47 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1679365911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vH8g1u/isyRONRi7xFZiLBJKBxPjGqE0tRMeBX5v3EI=;
        b=d6b8zRinkJjb6+k0mGh5XeaoO4+JSi5euPs8baVtYhIAP9YVFg+DpdDTjwYHNkeik6dVkF
        41qzIBxUiQrY5CR/bnxZLMqg/WrvCijvnuHKUqflXWfOBHTy+qbtAWkxctIN5Zg7Xvvxzh
        /tLc62XEko12D/AsqOtyHq4gZDJCp04=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Cai Huoqing <cai.huoqing@linux.dev>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v7 0/5] dmaengine: dw-edma: Add support for native HDMA
Message-ID: <ZBkXEzoZZlIy18xB@chq-MS-7D45>
References: <20230315012840.6986-1-cai.huoqing@linux.dev>
 <20230320121401.zkcjbqmghzacpffh@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230320121401.zkcjbqmghzacpffh@mobilestation>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 20 3月 23 15:14:01, Serge Semin wrote:
> Hi Cai
> 
> On Wed, Mar 15, 2023 at 09:28:31AM +0800, Cai Huoqing wrote:
> > Add support for HDMA NATIVE, as long the IP design has set
> > the compatible register map parameter-HDMA_NATIVE,
> > which allows compatibility for native HDMA register configuration.
> > 
> > The HDMA Hyper-DMA IP is an enhancement of the eDMA embedded-DMA IP.
> > And the native HDMA registers are different from eDMA,
> > so this patch add support for HDMA NATIVE mode.
> > 
> > HDMA write and read channels operate independently to maximize
> > the performance of the HDMA read and write data transfer over
> > the link When you configure the HDMA with multiple read channels,
> > then it uses a round robin (RR) arbitration scheme to select
> > the next read channel to be serviced.The same applies when
> > youhave multiple write channels.
> > 
> > The native HDMA driver also supports a maximum of 16 independent
> > channels (8 write + 8 read), which can run simultaneously.
> > Both SAR (Source Address Register) and DAR (Destination Address Register)
> > are aligned to byte.
> 
> It seems like we are getting towards the series finalization. I'll
> test it out on my HW after v8 is submitted. Meanwhile could you please
> clarify whether you have a real device with DW HDMA engine on board?

Our hardware is an AI Accelerartor(PCIE Card).

The device pci.ids is 1d22:3864
in https://github.com/pciutils/pciids/blob/master/pci.ids
line 24737,

"1d22  Baidu Technology
        3684  Kunlun AI Accelerator
        3685  Kunlun2 AI Accelerator [VF]"

And our device driver is not ready to upstream(will cost serveral

months to port DRM etc.),

but I have taken this DW eDMA core into our driver test.

Thanks
Cai-

> You keep submitting the DW eDMA driver core update, but there is no
> glue-driver or low-level device driver patch for a real device which
> would set the EDMA_MF_HDMA_NATIVE mapping.
> 
> -Serge(y)
> 
> > 
> > Cai Huoqing (2):
> >   dmaengine: dw-edma: Add support for native HDMA
> >   dmaengine: dw-edma: Optimization in dw_edma_v0_core_handle_int
> > 
> > Cai huoqing (3):
> >   dmaengine: dw-edma: Rename dw_edma_core_ops structure to
> >     dw_edma_plat_ops
> >   dmaengine: dw-edma: Create a new dw_edma_core_ops structure to
> >     abstract controller operation
> >   dmaengine: dw-edma: Add HDMA DebugFS support
> > 
> > v6->v7:
> >   [1/5]
> >   1.Update the commit log.
> >   [2/5]
> >   2.Revert dw_edma_core_handle_int back to dw-edma-core.h.
> >   3.Fix code style.
> >   [3/5]
> >   4.Move the change of register file from patch[4/5] to patch[3/5].
> >   5.Fix code style.
> > 
> > v6 link:
> >   https://lore.kernel.org/lkml/20230310032342.17395-1-cai.huoqing@linux.dev/
> > 
> >  drivers/dma/dw-edma/Makefile                 |   8 +-
> >  drivers/dma/dw-edma/dw-edma-core.c           |  86 ++----
> >  drivers/dma/dw-edma/dw-edma-core.h           |  58 ++++
> >  drivers/dma/dw-edma/dw-edma-pcie.c           |   4 +-
> >  drivers/dma/dw-edma/dw-edma-v0-core.c        |  91 ++++--
> >  drivers/dma/dw-edma/dw-edma-v0-core.h        |  14 +-
> >  drivers/dma/dw-edma/dw-hdma-v0-core.c        | 277 +++++++++++++++++++
> >  drivers/dma/dw-edma/dw-hdma-v0-core.h        |  17 ++
> >  drivers/dma/dw-edma/dw-hdma-v0-debugfs.c     | 176 ++++++++++++
> >  drivers/dma/dw-edma/dw-hdma-v0-debugfs.h     |  22 ++
> >  drivers/dma/dw-edma/dw-hdma-v0-regs.h        | 130 +++++++++
> >  drivers/pci/controller/dwc/pcie-designware.c |   2 +-
> >  include/linux/dma/edma.h                     |   7 +-
> >  13 files changed, 785 insertions(+), 107 deletions(-)
> >  create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-core.c
> >  create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-core.h
> >  create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-debugfs.c
> >  create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-debugfs.h
> >  create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > 
> > -- 
> > 2.34.1
> > 
