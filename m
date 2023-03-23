Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C7C6C642D
	for <lists+dmaengine@lfdr.de>; Thu, 23 Mar 2023 10:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbjCWJ4R (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 23 Mar 2023 05:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjCWJzm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 23 Mar 2023 05:55:42 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C80166E9;
        Thu, 23 Mar 2023 02:54:12 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id q16so16070237lfe.10;
        Thu, 23 Mar 2023 02:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679565250;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0tVCZBCJv2d7cSIpsrdtw8DV0WbNUEeuwS4mdQmplBo=;
        b=luwLnWiuaLRsWGWhBiRj/0fxk1Xt5NiAivQORQHyTPOsqXa4K7yHcXA5oLWWdKneAF
         pps/xEn9p59xBNqLK7CFa9jb5eGLmEBAiR1fjSRbt9CrBmVAhIwiF9SJCkTB8e+yX7Gx
         e3+GGs11MPTOZTMr+bpt/8fAgcFUammWIDn8UTOv1aQioK3JrIePkeR56/44ovArKj64
         j0KPd4Uoj7j3ndOd1Hhv7uQdF4jII+mn9FelWFumsw11C6QUm6EHIW6g3rDxFzv6zoqx
         gxGAonodv/IWh5Yo7nyg+VgWy7/P11UxTB2h3XbwM0DwQV00Ps24pupySWsbNXltbI6e
         /2zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679565250;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0tVCZBCJv2d7cSIpsrdtw8DV0WbNUEeuwS4mdQmplBo=;
        b=d068bfDT2ACVFQ7U8RoXo9SlG8sJ8YoqOFBnu9nyiWQxfDKPpKyg2t9jTxolwXB4uG
         Euy+67xElf8TyyWOBdTAJEPouqmLfVlMjZMBpL0MD01+tYYDyeZvOtU4Rb0lpx1hZivx
         0Zx2x8nguw0xdx/OUj7YOW8ChR9HDhcvE5HP53EJYjWG1SWKmDGda4JWQYnfcA4zBxvv
         nZx5M4mUWSbnWTeGoOacvyWrPnNbIdTld/DUbcKcR+6nIuAb+LQSQ17EE5fpz+EmgVaI
         gLnPN3th7/XvX8pAAiHoPH8DZq5ZvSzdFxE2+nG5Dxc8EXggfHPpqqAzGaNiktPDziEo
         WwVg==
X-Gm-Message-State: AO0yUKUs9uY4bojaK6KWkFDzgyYWI9bgnInTICjzbwinJ7nRKHCkhX3a
        sn1UOVS69MmAz6ghmhpr2Fo=
X-Google-Smtp-Source: AK7set+t2eX8luzW2eS/454QfxAFXz2HWnp26AataZ5tGbf5h5YdPZrw9s4pFcCdnEsCmbzUerNibA==
X-Received: by 2002:a05:6512:1285:b0:4e8:3cfe:98c7 with SMTP id u5-20020a056512128500b004e83cfe98c7mr1614167lfs.4.1679565250323;
        Thu, 23 Mar 2023 02:54:10 -0700 (PDT)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id e19-20020a2e9853000000b002935005f782sm2974922ljj.57.2023.03.23.02.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 02:54:09 -0700 (PDT)
Date:   Thu, 23 Mar 2023 12:54:07 +0300
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
Subject: Re: [PATCH v8 0/4] dmaengine: dw-edma: Add support for native HDMA
Message-ID: <20230323095407.2axtbkepktrgozmj@mobilestation>
References: <20230323034944.78357-1-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323034944.78357-1-cai.huoqing@linux.dev>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Mar 23, 2023 at 11:49:37AM +0800, Cai Huoqing wrote:
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
> 
> Cai Huoqing (1):
>   dmaengine: dw-edma: Add support for native HDMA
> 
> Cai huoqing (3):
>   dmaengine: dw-edma: Rename dw_edma_core_ops structure to
>     dw_edma_plat_ops
>   dmaengine: dw-edma: Create a new dw_edma_core_ops structure to
>     abstract controller operation
>   dmaengine: dw-edma: Add HDMA DebugFS support
> 
> v7->v8:
>   1.Remove the [5/5] patch in v7.
>   [3/4]
>   2.Get back the static methods: dw_hdma_v0_core_clear_done_int(),
>     dw_hdma_v0_core_clear_abort_int() and dw_hdma_v0_core_status_int().
>   [4/4]
>   3.Drop some unused field in dw_hdma_debugfs_entry.

The whole series looking good now except a few nitpicks which can be
fixed should v9 is required (see patches #3 and #4).

I've got the patchset tested on DW PCIe Root Port v4.60a with eDMA
engine embedded. A dummy read/write DMA-streams from/to a remote PCIe
VGA adapter memory was performed as expected. So feel free to add to
the entire series:
Tested-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> 
> v7 link:
>   https://lore.kernel.org/lkml/20230315012840.6986-1-cai.huoqing@linux.dev/
> 
>  drivers/dma/dw-edma/Makefile                 |   8 +-
>  drivers/dma/dw-edma/dw-edma-core.c           |  86 ++----
>  drivers/dma/dw-edma/dw-edma-core.h           |  58 ++++
>  drivers/dma/dw-edma/dw-edma-pcie.c           |   4 +-
>  drivers/dma/dw-edma/dw-edma-v0-core.c        |  85 +++++-
>  drivers/dma/dw-edma/dw-edma-v0-core.h        |  14 +-
>  drivers/dma/dw-edma/dw-hdma-v0-core.c        | 296 +++++++++++++++++++
>  drivers/dma/dw-edma/dw-hdma-v0-core.h        |  17 ++
>  drivers/dma/dw-edma/dw-hdma-v0-debugfs.c     | 173 +++++++++++
>  drivers/dma/dw-edma/dw-hdma-v0-debugfs.h     |  22 ++
>  drivers/dma/dw-edma/dw-hdma-v0-regs.h        | 130 ++++++++
>  drivers/pci/controller/dwc/pcie-designware.c |   2 +-
>  include/linux/dma/edma.h                     |   7 +-
>  13 files changed, 811 insertions(+), 91 deletions(-)
>  create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-core.c
>  create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-core.h
>  create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-debugfs.c
>  create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-debugfs.h
>  create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-regs.h
> 
> -- 
> 2.34.1
> 
