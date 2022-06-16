Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662A154E28B
	for <lists+dmaengine@lfdr.de>; Thu, 16 Jun 2022 15:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376717AbiFPNyT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Jun 2022 09:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233677AbiFPNyT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 16 Jun 2022 09:54:19 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC57344DD;
        Thu, 16 Jun 2022 06:54:18 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id m25so1557965lji.11;
        Thu, 16 Jun 2022 06:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V3mny4Rlaxu8y1WiiU4DYMEI7ypOoMST3TYufskABFQ=;
        b=ZEJH5jt73IHHnROUxKw5DdM22VMsmuSrVU5Bey0FkCluJARjVcnYfibfxIfvEygEgn
         EsIEGOP+zR3O2X8ibTU8L4sbtzQfAVurNY4qC5wRR7DnNGYUpFMxT3ioDDFfmukzMKWx
         fPJKF8ecQzGQoN8D8NhmErsi9BnSNu2zA255gu6vBerE1v8mk1N/4Z3fjF8BuzR8agAH
         bU377WzELdR9Uuiu/bBubH1JpKAOkfyL89rG0fcmlB3U2Jen7aVHIX0U8Aepqbo2sg7U
         uzZQQMzELqI6A4oPkdOCmj1278DvWSIbRJwLIaV25bXbF3JkRVx/yQwoq9P/W7IUApEp
         rLnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V3mny4Rlaxu8y1WiiU4DYMEI7ypOoMST3TYufskABFQ=;
        b=Jtf1veQWLaxO8TjUHPEbOoMAwmYJvFcifezvasGGfa6f5ACZ50a+OppwvhErZHcEnR
         otJ5FmtWckYWUJNj1JA3QV0PzCZpE8N67Ax+CLBArzAfqEP8GnABAG7suvaNhT0aa9aS
         4wiTsFlUIuDGL51DqqeJX42bMVqRdIr8QA5tgANNQSkz8dkHhR50s9ulpfGkn49x9gTM
         KU/RM/hshQE7UdKwmsmG7hoHo1NV3hzX0OD1gI4i37zmhPgL00TrqG0xrYiL2cTxm3P4
         WeMZGHobV02XT5IevGGh6r1vhbTl4mwITfcqeRGKiAMObsL8kjQL+RktSgOmEHhL7vUc
         bmrw==
X-Gm-Message-State: AJIora8HjdbDUKvFx0plsR5IDgAudoGXH3GNGYgZk50V1Q9Ao70iV9FA
        tRrHq9+2VtwddO+N139Wj/s=
X-Google-Smtp-Source: AGRyM1uSNOKbGunGmeP3JOL8AaWWLPzWQ2HZtj5X4uFNbzWZZgIf5pqPkwuF6MMYRDCpTvN2G5EMXw==
X-Received: by 2002:a05:651c:549:b0:255:bbd2:fb8 with SMTP id q9-20020a05651c054900b00255bbd20fb8mr2577718ljp.305.1655387656285;
        Thu, 16 Jun 2022 06:54:16 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id e8-20020a2eb1c8000000b00255cb942318sm255354lja.110.2022.06.16.06.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 06:54:15 -0700 (PDT)
Date:   Thu, 16 Jun 2022 16:54:13 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Frank Li <Frank.Li@nxp.com>, gustavo.pimentel@synopsys.com,
        hongxing.zhu@nxp.com, l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        lznuaa@gmail.com, helgaas@kernel.org, kishon@ti.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, manivannan.sadhasivam@linaro.org,
        Sergey.Semin@baikalelectronics.ru
Subject: Re: [PATCH v12 0/8] Enable designware PCI EP EDMA locally
Message-ID: <20220616135413.a4jmljwgzgpkp2uc@mobilestation>
References: <20220524152159.2370739-1-Frank.Li@nxp.com>
 <Yqs1e4RMpc6ynVDN@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yqs1e4RMpc6ynVDN@matsya>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Jun 16, 2022 at 06:51:55AM -0700, Vinod Koul wrote:
> On 24-05-22, 10:21, Frank Li wrote:
> > Default Designware EDMA just probe remotely at host side.
> > This patch allow EDMA driver can probe at EP side.
> > 
> > 1. Clean up patch
> >    dmaengine: dw-edma: Detach the private data and chip info structures
> >    dmaengine: dw-edma: Remove unused field irq in struct dw_edma_chip
> >    dmaengine: dw-edma: Change rg_region to reg_base in struct
> >    dmaengine: dw-edma: rename wr(rd)_ch_cnt to ll_wr(rd)_cnt in struct
> > 
> > 2. Enhance EDMA driver to allow prode eDMA at EP side
> >    dmaengine: dw-edma: Add support for chip specific flags
> >    dmaengine: dw-edma: Add DW_EDMA_CHIP_32BIT_DBI for chip specific
> > flags (this patch removed at v11 because dma tree already have fixed
> > patch)
> > 
> > 3. Bugs fix at EDMA driver when probe eDMA at EP side
> >    dmaengine: dw-edma: Fix programming the source & dest addresses for
> > ep
> >    dmaengine: dw-edma: Don't rely on the deprecated "direction" member
> > 
> > 4. change pci-epf-test to use EDMA driver to transfer data.
> >    PCI: endpoint: Add embedded DMA controller test
> > 
> > 5. Using imx8dxl to do test, but some EP functions still have not
> > upstream yet. So below patch show how probe eDMA driver at EP
> > controller driver.
> > https://lore.kernel.org/linux-pci/20220309120149.GB134091@thinkpad/T/#m979eb506c73ab3cfca2e7a43635ecdaec18d8097
> 

> Applied to dmaengine-next, thanks

Vinoud, this was supposed to be merged in through PCIe repo.( I asked
many times of that. Bjorn also agreed to merge it in. Could drop it
from yout repo?

-Sergey

> 
> -- 
> ~Vinod
