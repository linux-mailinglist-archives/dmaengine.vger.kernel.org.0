Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D17738A36
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jun 2023 17:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbjFUP44 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 21 Jun 2023 11:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbjFUP4z (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 21 Jun 2023 11:56:55 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5EDE2;
        Wed, 21 Jun 2023 08:56:53 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b4826ba943so45771371fa.0;
        Wed, 21 Jun 2023 08:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687363012; x=1689955012;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wMsuK8QlntYRWGDpnsrj+UmBw5rNM6wty3+YGdEQtKw=;
        b=R3Sq+jyvl+Tum+XZQuPCVM8fGRR89z/CZM9t6m6AQCAiTN5gRlDVY8ryzJoVRH3jNn
         3/QFjO3EpHQOzKwdmdx4jOjBSNjEerYtSwylDwy0mbORRgtx6xHesbt0GlSxVoeroWNJ
         SxEfAEbNWMmB0GbsZ/nql9ES3451wZalVxuj/Bgc5aIytYgBfWiMdhPW7KsBUwqaMmsV
         p+jBmuiHaRzLp9Oc3M0vwoIcjtMiBqDsOSSNt28yBUJvDRbJG1B11wU7t9WrLvlM/xWZ
         0xVqzTaSVgdod8SJzBSs1x11VXAQ0FBQhadtjE69jNgC0rloXBLxDlq6YZMwMKj+qfhY
         2fYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687363012; x=1689955012;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wMsuK8QlntYRWGDpnsrj+UmBw5rNM6wty3+YGdEQtKw=;
        b=MKvtheyNLAbldVrhhYA/E2NnFYz0VTC2e5gGFP+Qx9g0yAs1oMwu0zT4UncDXFQ8Vn
         nqkkyJ/S7NngcZlXofQrlUznOIH0bDFU/jGBv5BwCWJ2iQnxLwfxSYBKbfyIg29cZyqY
         lTju+xi3ILUDHCaSHUJ/T7ArPCVlKNZzPdZzBIXCgEvXmbew+gfX1N+jcJtMuvmxMxU0
         mO2nZu1PXo4NFR+PqkcxJRdBjbYmIAku53TusYPTJ292J14Z0u4QnBDzLcRNnqfzi84l
         j+nnXjygQWKJvn4OOXOA10c+EKS/2CkvnAe0o1xm9zNKZkByCsaNDXiPN/oI0N4PqgiC
         1tjA==
X-Gm-Message-State: AC+VfDyLdWTCylq0qmfofFFY74cdirORhvcyWpgJS7o6NeFFcZwEG833
        ZSPPGc5Qk9OgGHJEUa0n+MPjTuHmv8M=
X-Google-Smtp-Source: ACHHUZ5ytXBCUG0j1Nq9RmnG4ETlwaAPTUbwsG+uKQXZTCRZHHVDlFBj2uQOPANctKYevcrxSXltLg==
X-Received: by 2002:a2e:7d09:0:b0:2b4:74a7:9606 with SMTP id y9-20020a2e7d09000000b002b474a79606mr5935868ljc.46.1687363011782;
        Wed, 21 Jun 2023 08:56:51 -0700 (PDT)
Received: from mobilestation.baikal.int (srv1.baikalchip.ru. [87.245.175.227])
        by smtp.gmail.com with ESMTPSA id v18-20020a2e7a12000000b002ad8174d025sm932677ljc.122.2023.06.21.08.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 08:56:51 -0700 (PDT)
Date:   Wed, 21 Jun 2023 18:56:49 +0300
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
Message-ID: <ti6avu3xdrw7rjwskmemuxu4tcerfq3wd3y4c4v26pbjqjcs5h@izqmikcjsv56>
References: <20230609081654.330857-1-kory.maincent@bootlin.com>
 <20230609081654.330857-5-kory.maincent@bootlin.com>
 <20230619170201.5hbgte2optjlbx55@mobilestation.baikal.int>
 <20230619203207.694bfac6@kmaincent-XPS-13-7390>
 <tpowhctppelni47dosc27cg4vmzwdqnuvf3rukvmju2guoxzsr@wgxomqzfv6ch>
 <20230620153006.036ca3ba@kmaincent-XPS-13-7390>
 <qwkwtsjmfkmvsx4pmjetoxkjrpuwkndm6h6ntkpehxutz2h2jm@bmdzt7ywiuvs>
 <20230621151948.36125997@kmaincent-XPS-13-7390>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230621151948.36125997@kmaincent-XPS-13-7390>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Jun 21, 2023 at 03:19:48PM +0200, Köry Maincent wrote:
> On Wed, 21 Jun 2023 12:45:35 +0300
> Serge Semin <fancer.lancer@gmail.com> wrote:
> 
> > > I thought that using a read will solve the issue like the gpio_nand driver
> > > (gpio_nand_dosync)   
> > 
> > AFAICS The io_sync dummy-read there is a workaround to fix the
> > bus-reordering within the SoC bus. In this case we have a PCIe bus
> > which is supposed to guarantee the strong order with the exception I
> > described above or unless there is a bug someplace in the PCIe fabric.
> > 
> > > but I didn't thought of a cache that could return the value
> > > of the read even if the write doesn't fully happen. In the case of a cache
> > > how could we know that the write is done without using a delay?   
> > 
> > MMIO mapping is platform dependent and low-level driver dependent.
> > That's why I asked many times about the platform you are using and the
> > low-level driver that probes the eDMA engine. It would be also useful
> > to know what PCIe host controller is utilized too.
> > 
> > Mainly MMIO spaces are mapped in a way to bypass the caching. But in
> > some cases it might be useful to map an MMIO space with additional
> > optimizations like Write-combining. For instance it could be
> > effectively done for the eDMA linked-list BAR mapping. Indeed why
> > would you need to send each linked-list byte/word/dword right away to
> > the device while you can combine them and send all together, then
> > flush the cache and only after that start the DMA transfer? Another
> > possible reason of the writes reordering could be in a way the PCIe
> > host outbound memory window (a memory region accesses to which are
> > translated to the PCIe bus transfers) is configured. For instance DW
> > PCIe Host controller outbound MW config CSR has a special flag which
> > enables setting a custom PCIe bus TLPs (packets) attribute. As I
> > mentioned above that attribute can affect the TLPs order: make it
> > relaxed or ID-based.
> > 
> > Of course we can't reject a possibility of having some delays hidden
> > inside your device which may cause writes to the internal memory
> > landing after the writes to the CSRs. But that seems too exotic to be
> > considered as the real one for sure until the alternatives are
> > thoroughly checked.
> > 
> > What I was trying to say that your problem can be caused by some much
> > more frequently met reason. If I were you I would have checked them
> > first and only then considered a workaround like you suggest.
> 

> Thanks for you detailed answer, this was instructive.
> I will come back with more information if TLP flags are set.
> FYI the PCIe board I am currently working with is the one from Brainchip:
> Here is the driver:
> https://github.com/Brainchip-Inc/akida_dw_edma

I've glanced at the driver a bit:

1. Nothing criminal I've noticed in the way the BARs are mapped. It's
done as it's normally done. pcim_iomap_regions() is supposed to map
with no additional optimization. So the caching seems irrelevant
in this case.

2. The probe() method performs some device iATU config:
akida_1500_setup_iatu() and akida_1000_setup_iatu(). I would have a
closer look at the way the inbound MWs setup is done.

3. akida_1000_iatu_conf_table contains comments about the APB bus. If
it's an internal device bus and both LPDDR and eDMA are accessible
over the same bus, then the re-ordering may happen there. If APB means
the well known Advanced Peripheral Bus, then it's a quite slow bus
with respect to the system interconnect and PCIe buses. If eDMA regs
and LL-memory buses are different then the last write to the LL-memory
might be indeed still pending while the doorbells update arrives.
Sending a dummy read to the LL-memory stalls the program execution
until a response arrive (PCIe MRd TLPs are non-posted - "send and wait
for response") which happens only after the last write to the
LL-memory finishes. That's probably why your fix with the dummy-read
works and why the delay you noticed is quite significant (4us).
Though it looks quite strange to put LPDDR on such slow bus.

4. I would have also had a closer look at the way the outbound MW is
configured in your PCIe host controller (whether it enables some
optimizations like Relaxed ordering and ID-based ordering).

In anyway I would have got in touch with the FPGA designers whether
any of my suppositions correct (especially regarding 3.).

-Serge(y)

> 
> Köry
