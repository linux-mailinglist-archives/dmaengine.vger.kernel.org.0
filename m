Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D5D7380A0
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jun 2023 13:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbjFUJpn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 21 Jun 2023 05:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbjFUJpm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 21 Jun 2023 05:45:42 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A982B6;
        Wed, 21 Jun 2023 02:45:40 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f86fbe5e4fso4565977e87.2;
        Wed, 21 Jun 2023 02:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687340739; x=1689932739;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lRIchLbzglcznaMiXbrnV14BpMEX8tlzpWVzQCWYyDE=;
        b=GwKsMflfupLfIB+PvgJCRrJjde45/10S1T0Ug+naGpdJq3r7/XwvNeGMq863wylt6Z
         BEkfPtGBcTcF9o3/SnC27wlX/AxLM48snhDJI+pJmwGA8e/bqudr7cHyprPZDPJ7hhdG
         BYXZQy9h2OO+UfsvZprN3/R07QUZYN4JSsPBd//U49l4XPa0dM4juEJWveirX/XcbENv
         f62GnByJvDVKexIvUkQBoZn/neQjmiryRbly7mEUlR7rc6USRNHIQr8c5Ia0FpU5QErh
         yqPtD00Xic/QGgv0eeTAUqJCovbhZJa9rR//KzktNaagdmEE89x5bBLHFsGvQN2HWHQo
         o44w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687340739; x=1689932739;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lRIchLbzglcznaMiXbrnV14BpMEX8tlzpWVzQCWYyDE=;
        b=Bk1bjmvIUv8JlowzbARdZfzvNIWkhQNPQMP/314xXIlj/bDYt2kZ1ebz4PAOf/Gs6T
         x50ZajnLG9EKm0qXAPG0tTGNbNWJliESv1BDZTMVjj8bk5J3X3pjXcx3W7PqGg0lvfq6
         9P9lgiNW1QiT8OhLYxlBPUQ2js4uf2lz/K45d3ElHOJNteKnS9oc4J2AfyVMlh5QthK/
         Kno8HDlLB7jyK77Cg5E1PQ3MeNUD/V55WHIHHiNwV8p3E64b9SzcRympOdKn2IcRDAGR
         3jNF0x3LIan/kpUDABNdduTExxuJ4IY4A3jUkfEWl4/OX6CUt84sjPsOtHnb/aFlVF5d
         0sRw==
X-Gm-Message-State: AC+VfDzIz/G5o+BgN9YmFIwdYV1MwLHQOy0gfBRHpmNkSF/oe0lIW8VP
        aNq+rIofSVZHo+E6a7u6pRE=
X-Google-Smtp-Source: ACHHUZ6sOQvtdk2Yz+O/fwz+0anKpAKfbLy2a6Diq3ZhOXzpsFlaSgcQp/CC0DIIhptnz1HoDkfdQA==
X-Received: by 2002:a19:6909:0:b0:4f8:6d54:72fb with SMTP id e9-20020a196909000000b004f86d5472fbmr5224505lfc.62.1687340738310;
        Wed, 21 Jun 2023 02:45:38 -0700 (PDT)
Received: from mobilestation (srv1.baikalchip.ru. [87.245.175.227])
        by smtp.gmail.com with ESMTPSA id d8-20020ac244c8000000b004f8792d2daesm719356lfm.60.2023.06.21.02.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 02:45:37 -0700 (PDT)
Date:   Wed, 21 Jun 2023 12:45:35 +0300
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
Message-ID: <qwkwtsjmfkmvsx4pmjetoxkjrpuwkndm6h6ntkpehxutz2h2jm@bmdzt7ywiuvs>
References: <20230609081654.330857-1-kory.maincent@bootlin.com>
 <20230609081654.330857-5-kory.maincent@bootlin.com>
 <20230619170201.5hbgte2optjlbx55@mobilestation.baikal.int>
 <20230619203207.694bfac6@kmaincent-XPS-13-7390>
 <tpowhctppelni47dosc27cg4vmzwdqnuvf3rukvmju2guoxzsr@wgxomqzfv6ch>
 <20230620153006.036ca3ba@kmaincent-XPS-13-7390>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230620153006.036ca3ba@kmaincent-XPS-13-7390>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Jun 20, 2023 at 03:30:06PM +0200, Köry Maincent wrote:
> On Tue, 20 Jun 2023 14:45:40 +0300
> Serge Semin <fancer.lancer@gmail.com> wrote:
> 
> > On Mon, Jun 19, 2023 at 08:32:07PM +0200, Köry Maincent wrote:
> > > On Mon, 19 Jun 2023 20:02:01 +0300
> > > Serge Semin <fancer.lancer@gmail.com> wrote:
> > >   
> > > > On Fri, Jun 09, 2023 at 10:16:49AM +0200, Köry Maincent wrote:  
> > > > > From: Kory Maincent <kory.maincent@bootlin.com>
> > > > >     
> > > >   
> > > > > The Linked list element and pointer are not stored in the same memory as
> > > > > the HDMA controller register. If the doorbell register is toggled before
> > > > > the full write of the linked list a race condition error can appears.
> > > > > In remote setup we can only use a readl to the memory to assured the
> > > > > full write has occurred.
> > > > > 
> > > > > Fixes: e74c39573d35 ("dmaengine: dw-edma: Add support for native HDMA")
> > > > > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>    
> > > > 
> > > > Is this a hypothetical bug? Have you actually experienced the
> > > > described problem? If so are you sure that it's supposed to be fixed
> > > > as you suggest?  
> > >   
> > 
> > > I do experienced this problem and this patch fixed it.  
> > 
> > Could you give more details of how often does it happen? Is it stably
> > reproducible or does it happen at very rare occasion?
> 
> I have a test example that run DMA stress transfer in 3 threads and
> the issue appear in only few transfers but each time I run my test.
> 
> 
> > > > I am asking because based on the kernel doc
> > > > (Documentation/memory-barriers.txt):
> > > > 
> > > > *    1. All readX() and writeX() accesses to the same peripheral are
> > > > ordered
> > > > *       with respect to each other. This ensures that MMIO register
> > > > accesses
> > > > *       by the same CPU thread to a particular device will arrive in
> > > > program
> > > > *       order.
> > > > * ...
> > > > * The ordering properties of __iomem pointers obtained with non-default
> > > > * attributes (e.g. those returned by ioremap_wc()) are specific to the
> > > > * underlying architecture and therefore the guarantees listed above cannot
> > > > * generally be relied upon for accesses to these types of mappings.
> > > > 
> > > > the IOs performed by the accessors are supposed to arrive in the
> > > > program order. Thus SET_CH_32(..., HDMA_V0_DOORBELL_START) performed
> > > > after all the previous SET_CH_32(...) are finished looks correct with
> > > > no need in additional barriers. The results of the later operations
> > > > are supposed to be seen by the device (in our case it's a remote DW
> > > > eDMA controller) before the doorbell update from scratch. From that
> > > > perspective your problem looks as if the IO operations preceding the
> > > > doorbell CSR update aren't finished yet. So you are sure that the LL
> > > > memory is mapped with no additional flags like Write-Combine or some
> > > > caching optimizations? Are you sure that the PCIe IOs are correctly
> > > > implemented in your platform?  
> > > 
> > > No, I don't know if there is extra flags or optimizations.  
> > 
> > Well, I can't know that either.) The only one who can figure it out is
> > you, at least at this stage (I doubt Gustavo will ever get back to
> > reviewing and testing the driver on his remote eDMA device). I can
> > help if you provide some more details about the platform you are
> > using, about the low-level driver (is it
> > drivers/dma/dw-edma/dw-edma-pcie.o?) which gets to detect the DW eDMA
> > remote device and probes it by the DW eDMA core.
> 

> No it is another custom driver but also communicating through PCIe. In fact I
> have a contact to the FPGA designer, I will ask them.

Then if I were your I would have checked the way the driver maps the
BARs first. In additional I would have asked FPGA designer whether
it's possible to have the writes re-ordering or some significant
delays during the LL BAR writes inside the eDMA end-point itself.

> 
> > 
> > * Though I don't have hardware with the remote DW eDMA setup to try to
> > reproduce and debug the problem discovered by you.
> > 
> > >   
> > > > 
> > > > I do understand that the eDMA CSRs and the LL memory are mapped by
> > > > different BARs in the remote eDMA setup. But they still belong to the
> > > > same device. So the IO accessors semantic described in the kernel doc
> > > > implies no need in additional barrier.  
> > > 
> > > Even if they are on the same device it is two type of memory.  
> > 
> > What do you mean by "two types of memory"? From the CPU perspective
> > they are the same. Both are mapped via MMIO by means of a PCIe Root
> > Port outbound memory window.
> 

> I was meaning hardware memory. Yes they are mapped via MMIO, but they are
> mapped to two different BAR which may map the CSRs or the memory where LL
> are stored. According to you the write should be ordered but is there a way
> to know that the write has succeed? 

No. Normal writes are posted in PCIe bus. That is "send and forget".

> 
> 
> > > I am not an PCIe expert but I suppose the PCIe controller of the board is
> > > sending to both memory and if one of them (LL memory here) is slower in the
> > > write process then we faced this race issue. We can not find out that the
> > > write to LL memory has finished before the CSRs even if the write command
> > > has been sent earlier.  
> > 
> > From your description there is no guarantee that reading from the
> > remote device solves the race for sure. If writes have been collected
> > in a cache, then the intermediate read shall return a data from the
> > cache with no data being flushed to the device memory. It might be
> > possible that in your case the read just adds some delay enough for
> > some independent activity to flush the cache. Thus the problem you
> > discovered may get back in some other circumstance. Moreover based on
> > the PCI Express specification "A Posted Request must not pass another
> > Posted Request unless a TLP has RO (Relaxed ordering) or IDO (ID-based
> > ordering) flag set." So neither intermediate PCIe switches nor the
> > PCIe host controller is supposed to re-order simple writes unless the
> > Root Port outbound MW is configure to set the denoted flags. In anyway
> > all of that is platform specific. So in order to have it figured out
> > we need more details from the platform from you.
>
 
> I thought that using a read will solve the issue like the gpio_nand driver
> (gpio_nand_dosync) 

AFAICS The io_sync dummy-read there is a workaround to fix the
bus-reordering within the SoC bus. In this case we have a PCIe bus
which is supposed to guarantee the strong order with the exception I
described above or unless there is a bug someplace in the PCIe fabric.

> but I didn't thought of a cache that could return the value
> of the read even if the write doesn't fully happen. In the case of a cache how
> could we know that the write is done without using a delay? 

MMIO mapping is platform dependent and low-level driver dependent.
That's why I asked many times about the platform you are using and the
low-level driver that probes the eDMA engine. It would be also useful
to know what PCIe host controller is utilized too.

Mainly MMIO spaces are mapped in a way to bypass the caching. But in
some cases it might be useful to map an MMIO space with additional
optimizations like Write-combining. For instance it could be
effectively done for the eDMA linked-list BAR mapping. Indeed why
would you need to send each linked-list byte/word/dword right away to
the device while you can combine them and send all together, then
flush the cache and only after that start the DMA transfer? Another
possible reason of the writes reordering could be in a way the PCIe
host outbound memory window (a memory region accesses to which are
translated to the PCIe bus transfers) is configured. For instance DW
PCIe Host controller outbound MW config CSR has a special flag which
enables setting a custom PCIe bus TLPs (packets) attribute. As I
mentioned above that attribute can affect the TLPs order: make it
relaxed or ID-based.

Of course we can't reject a possibility of having some delays hidden
inside your device which may cause writes to the internal memory
landing after the writes to the CSRs. But that seems too exotic to be
considered as the real one for sure until the alternatives are
thoroughly checked.

What I was trying to say that your problem can be caused by some much
more frequently met reason. If I were you I would have checked them
first and only then considered a workaround like you suggest.

-Serge(y)

> 
> > 
> > Meanwhile:
> > 
> > Q1 are you sure that neither dma_wmb() nor io_stop_wc() help to solve
> > the problem in your case?
> 
> dma_wmb is like wmb and is called by the writel function of the doorbell.
> io_stop_wc is doing nothing except or arm64.
> Both of these function won't change anything.
> 
> > Q2 Does specifying a delay instead of the dummy read before the
> > doorbell update solve the problem?
> 
> Delaying it for at least 4 us before toggling doorbell solves also the issue.
> This seems long for an equivalent of the readl function right?
> Wouldn't using a read after the write ask to the PCIe controller to check the
> write has happen? It should be written in the PCIe protocol but not sure I want
> to open the full protocol description document.
> 
> Köry
