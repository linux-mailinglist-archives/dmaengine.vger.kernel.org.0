Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E04D64E8AD
	for <lists+dmaengine@lfdr.de>; Fri, 16 Dec 2022 10:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbiLPJef (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 16 Dec 2022 04:34:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiLPJeb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 16 Dec 2022 04:34:31 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A163527B16;
        Fri, 16 Dec 2022 01:34:28 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id g14so1536829ljh.10;
        Fri, 16 Dec 2022 01:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ajS60FHCOraRSy8GVeM0KvjRVHlpoPWjTxbDEzWh1vs=;
        b=eL9aRNvcRFyAvtODMuo8DH3M6KHRE3k7BVK4DcKbTnv3i+zndzEpu0+f4FOs+QtMfT
         xxCuOQa2fRmo3BjQgl8UQFKCY3CWR0MWISiG40LgWuF1HKTdLqURz0SP7NJ0OIB6H8u2
         3l+38eLpf5vEN1o9YOq2OCr0qGYfsd340mxszFMYwZQy/aWcvwmdZxW/YXYvO/TQDV9s
         AIKxz1FHytsy06LGH+fWsECA09lwk3c5hCWEk9n45fm22+ebtFgERO3I3VaUS6zRsgsZ
         Avy5AwOAg+LygYI1D1OWEElF6S2ItA+L4BIeUrBiyZlKvtHekMwLbF/ZY3ZIVQd2JJba
         fKyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ajS60FHCOraRSy8GVeM0KvjRVHlpoPWjTxbDEzWh1vs=;
        b=iacemoKEQ62fgJ5QD7LMaQSGjU7RrerFB5jNtqdeSr7t/J2QgXKoigCo/NH+BIwEjg
         tzk8zmZyXA8W+ixwssJ0O9389O1J9Q1jAIiZ/o91SEZJJKK10j/FNp9Oui5mAvfd4D0w
         uUzkIR4Xsv3k94bLXmETiJBC6J2H8AZ9epQzbwZWFpVak8OLWINbaAvf3Us6YLpGhXIj
         vEcCNJEZdQiYs2XtpRGEzYQjdJZ5bDLOEInfmysNgl8LKPJFfsONovmQQwhWB/Qm2kkz
         Wep6QF17/Hoq5dryhIqJ8QbOg593d0YXZ+zaQ3LMJ2eBgp9ceEMjOMAdsFv7wTlIq9kr
         ha6g==
X-Gm-Message-State: ANoB5pl5xcslIqRvy+2wPokkHX/S64CPBVWvoeRS+eR9RyajjFg+JAM5
        4+zixG/Lli+jKM20eNLNXfI=
X-Google-Smtp-Source: AA0mqf4E67l6f7gi3gDkTu9VweV0mymHXT5HP1zlpF8KWBziLDVOiPxiLA7VHWoUWV5KzKjmOGo0oQ==
X-Received: by 2002:a2e:a90c:0:b0:26f:db35:2e93 with SMTP id j12-20020a2ea90c000000b0026fdb352e93mr13448674ljq.5.1671183266880;
        Fri, 16 Dec 2022 01:34:26 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id f26-20020a05651c03da00b0026c42f67eb8sm109335ljp.7.2022.12.16.01.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 01:34:26 -0800 (PST)
Date:   Fri, 16 Dec 2022 12:34:23 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Jingoo Han <jingoohan1@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        caihuoqing <caihuoqing@baidu.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 23/25] PCI: dwc: Restore DMA-mask after MSI-data
 allocation
Message-ID: <20221216093423.4bettdxisserdzsh@mobilestation>
References: <20221214235305.31744-1-Sergey.Semin@baikalelectronics.ru>
 <20221214235305.31744-24-Sergey.Semin@baikalelectronics.ru>
 <Y5rJJfZeVqliA5Rg@infradead.org>
 <20221215092721.tvz3hpaql3kotgnu@mobilestation>
 <07ec7610-f1be-9b5c-416d-17781a22427d@arm.com>
 <20221215235218.wsuwy5uckqfxjnb6@mobilestation>
 <Y5wgvdnMWQDxkUd+@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5wgvdnMWQDxkUd+@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Dec 15, 2022 at 11:39:41PM -0800, Christoph Hellwig wrote:
> On Fri, Dec 16, 2022 at 02:52:18AM +0300, Serge Semin wrote:
> > Got it. Thanks for clarification. I'll resubmit the series with only
> > the streaming DMA mask restoration.
> 
> Note that even for that we need to make sure there are no outstanding
> mappings when you change the mask.
> 

What about instead of save/restore pattern I'll just change the
dma_set_mask_and_coherent() method with the dma_set_coherent_mask()
function call? It seems cleaner. Like this:

< --- a/drivers/pci/controller/dwc/pcie-designware-host.c
< +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
< @@ -366,10 +366,10 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
<  						    dw_chained_msi_isr, pp);
<  	}
<  
< -	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
< +	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
<  	if (ret)
<  		dev_warn(dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");
<  
<  	msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
<  					GFP_KERNEL);

Thus the platform-specific streaming DMA mask would be preserved.
Since it's PCIe then having the streaming DMA-mask less than 32-bits
wide is very much improbable. Moreover DW PCIe AXI-interface can be
synthesize only with one out of two address bus widths: 32 and 64.

-Serge(y)
