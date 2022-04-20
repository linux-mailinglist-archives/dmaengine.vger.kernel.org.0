Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832CB50843E
	for <lists+dmaengine@lfdr.de>; Wed, 20 Apr 2022 10:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351198AbiDTI6p (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Apr 2022 04:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351513AbiDTI62 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 20 Apr 2022 04:58:28 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2D5275F6;
        Wed, 20 Apr 2022 01:55:43 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id w5so1139978lji.4;
        Wed, 20 Apr 2022 01:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TApnnOk49bznf7nS/pO6YXmwSrM65zNNRoE0LsS+6Cg=;
        b=oJ16xqKIn/hdHrCjEfqcYSejmULG9AlbIt3z3/cM+gdZ1kK3T/Iwv9foQvcWWdS7tP
         A+qccV40M4m8MzS+VFOttc1xqk2Pw6yBWnbo5L5YDTZ6Ex1MWIgnQkSOn6RmZspzWmn4
         17P3Ace2/iYzIRErQ3XCNVnUUwp3lLmEfIJ/LV9isfOl6OfLYPO2fY8TAvgz3AB10Swx
         erh7+01Smj+QYEulza67Nc39S5xUqEoFssbg1g0fJMFMFrtKt7OvbI0c+9k+LnXEN6Lu
         XHCJzwcgzyWo5FTy4FoWIpp2KGNYcnij6j4lFvFNgJeUplDMGBArUqRGsyklzh9HG8Xk
         gnJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TApnnOk49bznf7nS/pO6YXmwSrM65zNNRoE0LsS+6Cg=;
        b=18PKWqTutvRg1Lo4+UJBlkBqIUILLpraoaY6M0N0H/kBraoQBxteoXvN8fVJQJ+Scc
         WfqHjfAazNfz2OV5scvBW0ADIprV0BA+hvMBSm/y+UcA/fZTloytG+UzPYaVzBO6XhOK
         4kaxInYbnub20h/lD5pRZ3Em4GuKZE0wREY1f/M7hO8So0BiA9GmFzLrRMpaFyh+eOpM
         39X06+UydjTqIHaosgVr3RS3eqPllVNnJex95zRBMgSyC+XfpEcitZb31qOc2aWBwQlQ
         5TjEntieTNkoy8/HvMLysbS2Sd4KQ7z7XPI/hwZ+6H9m4Nm/iRlTzc0l3ZXNy6eAMlno
         nUvA==
X-Gm-Message-State: AOAM531WxC/GwW/WXTbGjaHVn2NLebQUfA9hXaH54jFx5UpttCySjA6M
        3uAAl0MYzd7pi0E9yJP6dAw=
X-Google-Smtp-Source: ABdhPJyKyJ+u2S17+IotOm0b/2FyzpxuQuznRj9JHVocQh8Ri+xRlCZkxkHJvQpRWZ2M1zZXo5kgvg==
X-Received: by 2002:a2e:8811:0:b0:24d:c4ac:1249 with SMTP id x17-20020a2e8811000000b0024dc4ac1249mr5353893ljh.307.1650444941188;
        Wed, 20 Apr 2022 01:55:41 -0700 (PDT)
Received: from mobilestation ([95.79.134.149])
        by smtp.gmail.com with ESMTPSA id a8-20020a19fc08000000b0046bc1c21ec5sm1757401lfi.1.2022.04.20.01.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 01:55:40 -0700 (PDT)
Date:   Wed, 20 Apr 2022 11:55:38 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: Re: [PATCH 03/25] dma-direct: take dma-ranges/offsets into account
 in resource mapping
Message-ID: <20220420085538.imgibqcyupvvjpaj@mobilestation>
References: <20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru>
 <20220324014836.19149-4-Sergey.Semin@baikalelectronics.ru>
 <0baff803-b0ea-529f-095a-897398b4f63f@arm.com>
 <20220417224427.drwy3rchwplthelh@mobilestation>
 <20220420071217.GA5152@lst.de>
 <20220420083207.pd3hxbwezrm2ud6x@mobilestation>
 <20220420084746.GA11606@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420084746.GA11606@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Apr 20, 2022 at 10:47:46AM +0200, Christoph Hellwig wrote:
> I can't really comment on the dma-ranges exlcusion for P2P mappings,
> as that predates my involvedment, however:

My example wasn't specific to the PCIe P2P transfers, but about PCIe
devices reaching some platform devices over the system interconnect
bus.

> 
> On Wed, Apr 20, 2022 at 11:32:07AM +0300, Serge Semin wrote:
> > See, if I get to map a virtual memory address to be accessible by any
> > PCIe peripheral device, then the dma_map_sg/dma_map_page/etc
> > procedures will take the PCIe host controller dma-ranges into account.
> > It will work as expected and the PCIe devices will see the memory what
> > I specified. But if I get to pass the physical address of the same
> > page or a physical address of some device of the DEVs space to the
> > dma_map_resource(), then the PCIe dma-ranges won't be taken into
> > account, and the result mapping will be incorrect. That's why the
> > current dma_map_resource() implementation seems very confusing to me.
> > As I see it phys_addr_t is the type of the Interconnect address space,
> > meanwhile dma_addr_t describes the PCIe, DEVs address spaces.
> > 
> > Based on what I said here and in my previous email could you explain
> > what do I get wrong?
> 

> You simply must not use dma_map_resource for normal kernel memory.
> So while the exclusion might be somewhat confusing, that confusion
> really should not matter for any proper use of the API.

What if I get to have a physical address of a platform device and want
have that device being accessed by a PCIe peripheral device? The
dma_map_resource() seemed very much suitable for that. But considering
what you say it isn't.

-Sergey

