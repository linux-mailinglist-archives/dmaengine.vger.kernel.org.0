Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAF373A5FC
	for <lists+dmaengine@lfdr.de>; Thu, 22 Jun 2023 18:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjFVQWd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 22 Jun 2023 12:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjFVQW0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 22 Jun 2023 12:22:26 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D911BD8;
        Thu, 22 Jun 2023 09:22:25 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b45bc83f26so105877731fa.0;
        Thu, 22 Jun 2023 09:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687450943; x=1690042943;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e+pDIITgSeAaLsjqwXk+oPsYd8NVzQg6ju4H8uC7r0Y=;
        b=YlsiPkmCmsjr87joeRcK1h/s2aYmHotqxH7ri0mOwVnoran0MBM3Z5zfkb8+1BYkoi
         X4nPooMKkVUkL4NraQhclvMPiUADxeoJyA91GeiieHt5Q2z4LbXAQdVQCtU4qEbGKevb
         C0JLuYjfvJc8UcO5AUsb0PaOFmGGkOljtKutE5MPULuy54laxv87TvisvYDH1eKTBsPj
         omMA8rN7DN7Qx91b02La3MkA7tad43qZhZgI+BUuvtpKlL6U4X+bMCrl7vvuR6PEqZGa
         on5Z8kvjX7Hmi2z8WLJvCtacKoB93oOTmMrxkH5t/+Vl1xY2dgWmtUgGKLlyyQdpSY03
         fIyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687450943; x=1690042943;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e+pDIITgSeAaLsjqwXk+oPsYd8NVzQg6ju4H8uC7r0Y=;
        b=Wm6UTWvwhCN6mXmUd43h3L1UIrF6Dev2OJPLJvVYGS/l5mlz5j6ik1WMtNrIZXWRvD
         GpQwJR0kNMDL/YknJuLMk4H1QaWyqbWimwBJEgi0cdT5IGoaF3dqg4WgRIP4az8zkenf
         S/QlNCgAUTDEeXDAelw05G3NI4YpQprjceltASTEd3oYHBtVM/ytZMuwAVWooyMbk9N7
         QhgU2uqAkna3YuDuY96d01FgLADeHCMY4biR0YVGfD9flM8bkJyFYDYUwJ+QYddDzSkn
         nqf930ujkoT572zMXyoVavOf6A69fG9cVHhnzROM+KfGNo2QPwXCAxyswMd6/Ll8Vbsr
         ZdZw==
X-Gm-Message-State: AC+VfDyrDDivlPOlv7V6Fy/WrqMac1ckOaVxA5ETNZcDmHc1KL54+dps
        0ia6QAJcgFobMDB1e1+Oe/zXkGFLLQw=
X-Google-Smtp-Source: ACHHUZ4rnPdJ4RZrF+LbcQZ96HcRd4ukxACSqqUgjXEHMs8CGk57TfMx+wQvWjXMEtGkhWP/qxYpTQ==
X-Received: by 2002:a19:6450:0:b0:4f8:7503:203f with SMTP id b16-20020a196450000000b004f87503203fmr1872727lfj.48.1687450943249;
        Thu, 22 Jun 2023 09:22:23 -0700 (PDT)
Received: from mobilestation.baikal.int (srv1.baikalchip.ru. [87.245.175.227])
        by smtp.gmail.com with ESMTPSA id j11-20020ac2550b000000b004f13f4ec267sm1161890lfk.186.2023.06.22.09.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 09:22:22 -0700 (PDT)
Date:   Thu, 22 Jun 2023 19:22:20 +0300
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
Message-ID: <phrpjn5dtqfo2fwjlkrsepjl4mgmjc24skpvcjo43g3p5sjv3g@mfzvfz7ygdad>
References: <20230609081654.330857-1-kory.maincent@bootlin.com>
 <20230609081654.330857-5-kory.maincent@bootlin.com>
 <20230619170201.5hbgte2optjlbx55@mobilestation.baikal.int>
 <20230619203207.694bfac6@kmaincent-XPS-13-7390>
 <tpowhctppelni47dosc27cg4vmzwdqnuvf3rukvmju2guoxzsr@wgxomqzfv6ch>
 <20230620153006.036ca3ba@kmaincent-XPS-13-7390>
 <qwkwtsjmfkmvsx4pmjetoxkjrpuwkndm6h6ntkpehxutz2h2jm@bmdzt7ywiuvs>
 <20230621151948.36125997@kmaincent-XPS-13-7390>
 <ti6avu3xdrw7rjwskmemuxu4tcerfq3wd3y4c4v26pbjqjcs5h@izqmikcjsv56>
 <20230622171203.6857b918@kmaincent-XPS-13-7390>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230622171203.6857b918@kmaincent-XPS-13-7390>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Jun 22, 2023 at 05:12:03PM +0200, Köry Maincent wrote:
> On Wed, 21 Jun 2023 18:56:49 +0300
> Serge Semin <fancer.lancer@gmail.com> wrote:
> 
> > > Thanks for you detailed answer, this was instructive.
> > > I will come back with more information if TLP flags are set.
> > > FYI the PCIe board I am currently working with is the one from Brainchip:
> > > Here is the driver:
> > > https://github.com/Brainchip-Inc/akida_dw_edma  
> > 
> > I've glanced at the driver a bit:
> > 
> > 1. Nothing criminal I've noticed in the way the BARs are mapped. It's
> > done as it's normally done. pcim_iomap_regions() is supposed to map
> > with no additional optimization. So the caching seems irrelevant
> > in this case.
> > 
> > 2. The probe() method performs some device iATU config:
> > akida_1500_setup_iatu() and akida_1000_setup_iatu(). I would have a
> > closer look at the way the inbound MWs setup is done.
> > 
> > 3. akida_1000_iatu_conf_table contains comments about the APB bus. If
> > it's an internal device bus and both LPDDR and eDMA are accessible
> > over the same bus, then the re-ordering may happen there. If APB means
> > the well known Advanced Peripheral Bus, then it's a quite slow bus
> > with respect to the system interconnect and PCIe buses. If eDMA regs
> > and LL-memory buses are different then the last write to the LL-memory
> > might be indeed still pending while the doorbells update arrives.
> > Sending a dummy read to the LL-memory stalls the program execution
> > until a response arrive (PCIe MRd TLPs are non-posted - "send and wait
> > for response") which happens only after the last write to the
> > LL-memory finishes. That's probably why your fix with the dummy-read
> > works and why the delay you noticed is quite significant (4us).
> > Though it looks quite strange to put LPDDR on such slow bus.
> > 
> > 4. I would have also had a closer look at the way the outbound MW is
> > configured in your PCIe host controller (whether it enables some
> > optimizations like Relaxed ordering and ID-based ordering).
> > 
> > In anyway I would have got in touch with the FPGA designers whether
> > any of my suppositions correct (especially regarding 3.).
> 

> Alright, thanks for your instructive review!
> 
> In the HDMA driver point of view we can not know if the eDMA regs and the
> LL-memory will be in same bus in whatever future implementation. Of course it
> is the hardware designers who should be careful about having a fast bus and
> memory for the LL, but wouldn't it be more cautious to have this read?
> Just a small thought!

If we get assured that hardware with such problem exists (if you'll get
confirmation about the supposition 3. above) then we'll need to
activate your trick for that hardware only. Adding dummy reads for all
the remote eDMA setups doesn't look correct since it adds additional
delay to the execution path and especially seeing nobody has noticed
and reported such problem so far (for instance Gustavo didn't see the
problem on his device otherwise he would have fixed it).

So if assumption 3. is correct then I'd suggest the next
implementation: add a new dw_edma_chip_flags flag defined (a.k.a
DW_EDMA_SLOW_MEM), have it specified via the dw_edma_chip.flags field
in the Akida device probe() method and activate your trick only if
that flag is set.

-Serge(y)

> 
> Köry
