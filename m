Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C00C736B5C
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jun 2023 13:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232673AbjFTLqM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Jun 2023 07:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbjFTLp7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 20 Jun 2023 07:45:59 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3631BC8;
        Tue, 20 Jun 2023 04:45:45 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f871c93a5fso2805747e87.2;
        Tue, 20 Jun 2023 04:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687261543; x=1689853543;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0iwoXCLY7rYQ+Ak1ourPXpO19PkvpuhqSpoWlG2eDc4=;
        b=c9Aj5pPFiBu7bgr+dk585VXJAGQdiE1ZW8xmClLlzabao8j5axa0sibKfdvLjbzrS2
         YwCIB1yhQSw76BVQADJiWxFiYaXH0opmAXOHN4oHZHdisjkLKRMEjGyq2AcvSa+JOGD8
         UVVZXrLT/HxVX87stzjc5wdaGhBJ9SVgmbfW8RyB/kYpi2vOWmGpaLGAEpc8RuDFAuNV
         BF/HXCYhQmhq22DFkYjCqHSvKiTQGw2ZvAmAYUBzB/wKM/Bf7Io5v93RA43g54Fy1fP3
         3PuMQgJonbAJOE+SFpOkF9Sa6Sl9LFWL4mqUt/Zr/GPuJFPOQOW36KP0vIHO/mElWYH3
         uHkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687261543; x=1689853543;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0iwoXCLY7rYQ+Ak1ourPXpO19PkvpuhqSpoWlG2eDc4=;
        b=ArYVHlvsZDdt3s2hA0tevBgIRsUUb/elprg8n6NQYzklUG3RDVqORQAhNNGXLfEqQp
         lBm6pjp3cgKL81fbeuJLrYwk2nuiOrywWFXc3rFuMDyVwvLg+AuR8rCRejtWEtvH7ox1
         piPvNY8zyv0iwuNAdFzlYLAeX9RcXM5/KupzBW1zE8kVrAT7K0zA9P/bEBAlUfZZ/u26
         Msink08vtvvdZIV1TnLGd46668Svg7JR4QCBtAdiibZChYGP/F+fn5izczIn2/JtXi93
         Dw8ZAume/ndKMDiSdn7JGPgoYQ5DJ7WeU5wqNIL6sCyKPsxqNSn2tCNj/2Udw7U/rNnc
         8eyw==
X-Gm-Message-State: AC+VfDzsYgpMyf8jbNqSBVfOcTNo/Ka+/L8EJ7kjzUkSNN9J3r/Y4ttY
        Ky8EXigkmYjUQNJ+v60sb+gUPN6L52U=
X-Google-Smtp-Source: ACHHUZ6OjIYaD2GyUjeh5GtNXs+8DYN5lRtt58Vk74YFK2NtGeLYimYTb0tAxynG70Ttyr44gTEnSg==
X-Received: by 2002:ac2:5bda:0:b0:4f8:64f5:f595 with SMTP id u26-20020ac25bda000000b004f864f5f595mr4671036lfn.60.1687261543187;
        Tue, 20 Jun 2023 04:45:43 -0700 (PDT)
Received: from mobilestation.baikal.int (srv1.baikalchip.ru. [87.245.175.227])
        by smtp.gmail.com with ESMTPSA id d12-20020ac2544c000000b004f84162e08bsm331384lfn.185.2023.06.20.04.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 04:45:42 -0700 (PDT)
Date:   Tue, 20 Jun 2023 14:45:40 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     =?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
Cc:     Cai Huoqing <cai.huoqing@linux.dev>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>
Subject: Re: [PATCH 4/9] dmaengine: dw-edma: HDMA: Add memory barrier before
 starting the DMA transfer in remote setup
Message-ID: <tpowhctppelni47dosc27cg4vmzwdqnuvf3rukvmju2guoxzsr@wgxomqzfv6ch>
References: <20230609081654.330857-1-kory.maincent@bootlin.com>
 <20230609081654.330857-5-kory.maincent@bootlin.com>
 <20230619170201.5hbgte2optjlbx55@mobilestation.baikal.int>
 <20230619203207.694bfac6@kmaincent-XPS-13-7390>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230619203207.694bfac6@kmaincent-XPS-13-7390>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Jun 19, 2023 at 08:32:07PM +0200, Köry Maincent wrote:
> On Mon, 19 Jun 2023 20:02:01 +0300
> Serge Semin <fancer.lancer@gmail.com> wrote:
> 
> > On Fri, Jun 09, 2023 at 10:16:49AM +0200, Köry Maincent wrote:
> > > From: Kory Maincent <kory.maincent@bootlin.com>
> > >   
> > 
> > > The Linked list element and pointer are not stored in the same memory as
> > > the HDMA controller register. If the doorbell register is toggled before
> > > the full write of the linked list a race condition error can appears.
> > > In remote setup we can only use a readl to the memory to assured the full
> > > write has occurred.
> > > 
> > > Fixes: e74c39573d35 ("dmaengine: dw-edma: Add support for native HDMA")
> > > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>  
> > 
> > Is this a hypothetical bug? Have you actually experienced the
> > described problem? If so are you sure that it's supposed to be fixed
> > as you suggest?
> 

> I do experienced this problem and this patch fixed it.

Could you give more details of how often does it happen? Is it stably
reproducible or does it happen at very rare occasion?

> 
> > 
> > I am asking because based on the kernel doc
> > (Documentation/memory-barriers.txt):
> > 
> > *    1. All readX() and writeX() accesses to the same peripheral are ordered
> > *       with respect to each other. This ensures that MMIO register accesses
> > *       by the same CPU thread to a particular device will arrive in program
> > *       order.
> > * ...
> > * The ordering properties of __iomem pointers obtained with non-default
> > * attributes (e.g. those returned by ioremap_wc()) are specific to the
> > * underlying architecture and therefore the guarantees listed above cannot
> > * generally be relied upon for accesses to these types of mappings.
> > 
> > the IOs performed by the accessors are supposed to arrive in the
> > program order. Thus SET_CH_32(..., HDMA_V0_DOORBELL_START) performed
> > after all the previous SET_CH_32(...) are finished looks correct with
> > no need in additional barriers. The results of the later operations
> > are supposed to be seen by the device (in our case it's a remote DW
> > eDMA controller) before the doorbell update from scratch. From that
> > perspective your problem looks as if the IO operations preceding the
> > doorbell CSR update aren't finished yet. So you are sure that the LL
> > memory is mapped with no additional flags like Write-Combine or some
> > caching optimizations? Are you sure that the PCIe IOs are correctly
> > implemented in your platform?
> 
> No, I don't know if there is extra flags or optimizations.

Well, I can't know that either.) The only one who can figure it out is
you, at least at this stage (I doubt Gustavo will ever get back to
reviewing and testing the driver on his remote eDMA device). I can
help if you provide some more details about the platform you are
using, about the low-level driver (is it
drivers/dma/dw-edma/dw-edma-pcie.o?) which gets to detect the DW eDMA
remote device and probes it by the DW eDMA core.

* Though I don't have hardware with the remote DW eDMA setup to try to
reproduce and debug the problem discovered by you.

> 
> > 
> > I do understand that the eDMA CSRs and the LL memory are mapped by
> > different BARs in the remote eDMA setup. But they still belong to the
> > same device. So the IO accessors semantic described in the kernel doc
> > implies no need in additional barrier.
> 
> Even if they are on the same device it is two type of memory.

What do you mean by "two types of memory"? From the CPU perspective
they are the same. Both are mapped via MMIO by means of a PCIe Root
Port outbound memory window.

> I am not an PCIe expert but I suppose the PCIe controller of the board is
> sending to both memory and if one of them (LL memory here) is slower in the
> write process then we faced this race issue. We can not find out that the write
> to LL memory has finished before the CSRs even if the write command has been
> sent earlier.

From your description there is no guarantee that reading from the
remote device solves the race for sure. If writes have been collected
in a cache, then the intermediate read shall return a data from the
cache with no data being flushed to the device memory. It might be
possible that in your case the read just adds some delay enough for
some independent activity to flush the cache. Thus the problem you
discovered may get back in some other circumstance. Moreover based on
the PCI Express specification "A Posted Request must not pass another
Posted Request unless a TLP has RO (Relaxed ordering) or IDO (ID-based
ordering) flag set." So neither intermediate PCIe switches nor the
PCIe host controller is supposed to re-order simple writes unless the
Root Port outbound MW is configure to set the denoted flags. In anyway
all of that is platform specific. So in order to have it figured out
we need more details from the platform from you.

Meanwhile:

Q1 are you sure that neither dma_wmb() nor io_stop_wc() help to solve
the problem in your case?

Q2 Does specifying a delay instead of the dummy read before the
doorbell update solve the problem?

-Serge(y)

> 
> Köry,
