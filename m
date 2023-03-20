Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC0556C119F
	for <lists+dmaengine@lfdr.de>; Mon, 20 Mar 2023 13:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbjCTMOL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 20 Mar 2023 08:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbjCTMOI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 20 Mar 2023 08:14:08 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CA01FDA;
        Mon, 20 Mar 2023 05:14:05 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id a11so1340287lji.6;
        Mon, 20 Mar 2023 05:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679314444;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t9LnjLbPanhFFeBnqt4/w6DoMU3P/cWwvDYe1wNCVYA=;
        b=WoCxGdyRQUoaFeRCl2SxcsyXe8gXqBTSOAxx8j/EKrQ4iGU2PnPw7UjGmcFYMF5mNN
         3EsbLQM8ZbWQaiNyXWTZZ+b7DHmk/EhfW3VeiqhpOCj1l8k4mYUS9LBEk/jFEwEPH03+
         /8g075PpJceFOkTNij/58fUUZteuDVIrr2LFo2gschYPQb1T/YzT3hIQ1fOJRBMWfG7R
         gzPxVsQJcRK/uZhFWZG3CGR6RD/bmauOPQgAByZ04Ha7FLpih16uEQST5/8SyxE/yd8o
         J1/WY3tlOcE5yD9sZt0i7xmBTP0RQIElOkORYOKDI/EAUUQOv9dUXc80pIWCmeUOMms5
         9qqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679314444;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t9LnjLbPanhFFeBnqt4/w6DoMU3P/cWwvDYe1wNCVYA=;
        b=7f59ZEK0TJZMuh5RBQc659WDipw90K9YZHm03Ugb9hPpNFKwEfbrKoC64WMK7ATeiK
         LZIISp891E9nPEMU5jZmGhG7s6QshGFlMNgEScTKpp2VNd99fqUdooh9AM0VnoE6oRWo
         OwCd2dkIg+PoYwHfhnlXuZfjBdzVudfDfhNZIarpVtRTm/CKt5V3zHQ4cxeDISNsqafl
         5sBsylAR6Eg3w4ZXintuBHiEc1luG5aR/KamoaNjKKb2qBJbAmEM0ASp/vNdZFEvyPFI
         bK63t/l+Zpc9gyoDjvUBYPwwiEKECv8FrMkNjiVQH/VWYFLfaVCGXTtfA1O2kXp0QD+u
         PfpA==
X-Gm-Message-State: AO0yUKW8gAPi1k2uPDqr45E0jTrMMLd2wISYA71kv07cIJOUZgQHiJqO
        97T64TZ5CCm6BFXL58YlxCQ=
X-Google-Smtp-Source: AK7set/yWX5zDIOxdnEBzeOKx+t3YMNYMsGjravxokl7smUIBtcuptxPbjKE9nhED9ZxC5OoaFu/rQ==
X-Received: by 2002:a2e:300e:0:b0:29e:5dc2:903a with SMTP id w14-20020a2e300e000000b0029e5dc2903amr684918ljw.23.1679314444011;
        Mon, 20 Mar 2023 05:14:04 -0700 (PDT)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id y21-20020a2e9d55000000b002989fc0a69csm1700190ljj.124.2023.03.20.05.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 05:14:03 -0700 (PDT)
Date:   Mon, 20 Mar 2023 15:14:01 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Cai Huoqing <cai.huoqing@linux.dev>
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
Message-ID: <20230320121401.zkcjbqmghzacpffh@mobilestation>
References: <20230315012840.6986-1-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315012840.6986-1-cai.huoqing@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Cai

On Wed, Mar 15, 2023 at 09:28:31AM +0800, Cai Huoqing wrote:
> Add support for HDMA NATIVE, as long the IP design has set
> the compatible register map parameter-HDMA_NATIVE,
> which allows compatibility for native HDMA register configuration.
> 
> The HDMA Hyper-DMA IP is an enhancement of the eDMA embedded-DMA IP.
> And the native HDMA registers are different from eDMA,
> so this patch add support for HDMA NATIVE mode.
> 
> HDMA write and read channels operate independently to maximize
> the performance of the HDMA read and write data transfer over
> the link When you configure the HDMA with multiple read channels,
> then it uses a round robin (RR) arbitration scheme to select
> the next read channel to be serviced.The same applies when
> youhave multiple write channels.
> 
> The native HDMA driver also supports a maximum of 16 independent
> channels (8 write + 8 read), which can run simultaneously.
> Both SAR (Source Address Register) and DAR (Destination Address Register)
> are aligned to byte.

It seems like we are getting towards the series finalization. I'll
test it out on my HW after v8 is submitted. Meanwhile could you please
clarify whether you have a real device with DW HDMA engine on board?
You keep submitting the DW eDMA driver core update, but there is no
glue-driver or low-level device driver patch for a real device which
would set the EDMA_MF_HDMA_NATIVE mapping.

-Serge(y)

> 
> Cai Huoqing (2):
>   dmaengine: dw-edma: Add support for native HDMA
>   dmaengine: dw-edma: Optimization in dw_edma_v0_core_handle_int
> 
> Cai huoqing (3):
>   dmaengine: dw-edma: Rename dw_edma_core_ops structure to
>     dw_edma_plat_ops
>   dmaengine: dw-edma: Create a new dw_edma_core_ops structure to
>     abstract controller operation
>   dmaengine: dw-edma: Add HDMA DebugFS support
> 
> v6->v7:
>   [1/5]
>   1.Update the commit log.
>   [2/5]
>   2.Revert dw_edma_core_handle_int back to dw-edma-core.h.
>   3.Fix code style.
>   [3/5]
>   4.Move the change of register file from patch[4/5] to patch[3/5].
>   5.Fix code style.
> 
> v6 link:
>   https://lore.kernel.org/lkml/20230310032342.17395-1-cai.huoqing@linux.dev/
> 
>  drivers/dma/dw-edma/Makefile                 |   8 +-
>  drivers/dma/dw-edma/dw-edma-core.c           |  86 ++----
>  drivers/dma/dw-edma/dw-edma-core.h           |  58 ++++
>  drivers/dma/dw-edma/dw-edma-pcie.c           |   4 +-
>  drivers/dma/dw-edma/dw-edma-v0-core.c        |  91 ++++--
>  drivers/dma/dw-edma/dw-edma-v0-core.h        |  14 +-
>  drivers/dma/dw-edma/dw-hdma-v0-core.c        | 277 +++++++++++++++++++
>  drivers/dma/dw-edma/dw-hdma-v0-core.h        |  17 ++
>  drivers/dma/dw-edma/dw-hdma-v0-debugfs.c     | 176 ++++++++++++
>  drivers/dma/dw-edma/dw-hdma-v0-debugfs.h     |  22 ++
>  drivers/dma/dw-edma/dw-hdma-v0-regs.h        | 130 +++++++++
>  drivers/pci/controller/dwc/pcie-designware.c |   2 +-
>  include/linux/dma/edma.h                     |   7 +-
>  13 files changed, 785 insertions(+), 107 deletions(-)
>  create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-core.c
>  create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-core.h
>  create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-debugfs.c
>  create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-debugfs.h
>  create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-regs.h
> 
> -- 
> 2.34.1
> 
