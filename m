Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D38CD6E1919
	for <lists+dmaengine@lfdr.de>; Fri, 14 Apr 2023 02:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjDNAlm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 13 Apr 2023 20:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjDNAll (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 13 Apr 2023 20:41:41 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D165D2137;
        Thu, 13 Apr 2023 17:41:39 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id y35so2443470ljq.6;
        Thu, 13 Apr 2023 17:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681432898; x=1684024898;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GKQ84SOXrfy0kzXSJ/RLBtfB3PFxpBWlnGKQhidz3C0=;
        b=cHzHuoqTb78YNpn1UUXblRCLW66YGpYtX+nJyymrpvVsLritsDRcQmXHy2iwcygitn
         UdmlJY1g3JtZa8cTFXyaz5+haSSAPoaysUuiCNvzq7kQRVdhTav25YNNe42MKIqo1Pvm
         xxraPwSJ8DR8tFGF1RNzdmqPsNXLiaqAQyTw1cyv84rldGMkxhOMMu8DyQCedIU1qQY2
         G5pX70Iu7y9d6Lc7Wy0U5O2Mf8PLPmOyL+RIM+8B5ynYsncx+Ld5Wuyjsq5YkNHBDxYZ
         vueX1p2a8P2XCZNx/GFb5uqhBwT1hhpsVNiPFZrfH3JVWs4IJW5NJSIzIrcStRj1NP3+
         6Atw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681432898; x=1684024898;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GKQ84SOXrfy0kzXSJ/RLBtfB3PFxpBWlnGKQhidz3C0=;
        b=Rhqiq55hK7GHYybMEBO7GKcXe/Lweg2I+k5eYrfUEm3FkWZuZPaq1YFYTXFhRga7Q9
         E06L0HkrwIv1x4WlR82NA3VA6Fn3lEX9m5Ym4yuX4Gtnl4pSIHjBNpOxyvaemdAJEcwL
         FpsB3mSzzi2y2/OV5q/MDOV0cZGRYv2p/p8Mn3VQcMBLZoEeihF+ktjVPublq6ijMj79
         f7ohzkWLiWPAXNJNnfdUlc/6i8KNavERpv5NsgYSrnYWpLWMamePGMRXXfP40euvg2r2
         QcPe1QZMvXVeKKhH/ug31Tj/n990KROSHG1K8GJ+qXcMrbIFoQc3y7hD6DlRyMBdRV6j
         v8PQ==
X-Gm-Message-State: AAQBX9fBw5068ZAvh9RBIvWw1oB+3tjaVAqNVpzrmEsh5zRyYmXcMJZK
        RWXxNqPvbVN0z+46s16S6Zo=
X-Google-Smtp-Source: AKy350Z99G6eEj0VKBCkuGCDlxQC69+DdAqK+tJouJNYbAjwIObtJ5geJv/xOVgD2Hyymbr5nLjLng==
X-Received: by 2002:a2e:8655:0:b0:2a7:730d:a7c2 with SMTP id i21-20020a2e8655000000b002a7730da7c2mr1735780ljj.46.1681432898123;
        Thu, 13 Apr 2023 17:41:38 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id m21-20020a2e97d5000000b002945b04e1ebsm517591ljj.94.2023.04.13.17.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 17:41:37 -0700 (PDT)
Date:   Fri, 14 Apr 2023 03:41:35 +0300
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
Subject: Re: [PATCH RESEND v9 0/4] dmaengine: dw-edma: Add support for native
 HDMA
Message-ID: <20230414004135.vajewexuld7wcy6d@mobilestation>
References: <20230413033156.93751-1-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230413033156.93751-1-cai.huoqing@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Apr 13, 2023 at 11:31:51AM +0800, Cai Huoqing wrote:
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
> Tested-by: Serge Semin <fancer.lancer@gmail.com>

Two small notes in the regard of the resubmitted series:
1. On resubmission it would be nice to move the Tested-by tag to all
the patches of the series. Currently neither b4 tool nor patchwork see
it which may cause the tag missing should @Vinod apply the patch by
using these utilities and if he didn't notice it in the cover-letter.
2. Each resubmission even with no functional change implies patchset version
advance. So this patchset was supposed to be v10 with the changelog
describing that it was rebased onto the latest dmaengine-next branch
state.

Just to make sure that my tag won't be missing should this series be
applied:
Tested-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> 
> v8->v9:
>   [3/4]
>   1.Drop an empty line.
>   [4/4]
>   2.Update commit log.
>   3.Remove unused macro
> 
> v8 link:
>   https://lore.kernel.org/lkml/20230323034944.78357-1-cai.huoqing@linux.dev/
> 
>  drivers/dma/dw-edma/Makefile                 |   8 +-
>  drivers/dma/dw-edma/dw-edma-core.c           |  86 ++----
>  drivers/dma/dw-edma/dw-edma-core.h           |  58 ++++
>  drivers/dma/dw-edma/dw-edma-pcie.c           |   4 +-
>  drivers/dma/dw-edma/dw-edma-v0-core.c        |  85 +++++-
>  drivers/dma/dw-edma/dw-edma-v0-core.h        |  14 +-
>  drivers/dma/dw-edma/dw-hdma-v0-core.c        | 296 +++++++++++++++++++
>  drivers/dma/dw-edma/dw-hdma-v0-core.h        |  17 ++
>  drivers/dma/dw-edma/dw-hdma-v0-debugfs.c     | 170 +++++++++++
>  drivers/dma/dw-edma/dw-hdma-v0-debugfs.h     |  22 ++
>  drivers/dma/dw-edma/dw-hdma-v0-regs.h        | 129 ++++++++
>  drivers/pci/controller/dwc/pcie-designware.c |   2 +-
>  include/linux/dma/edma.h                     |   7 +-
>  13 files changed, 807 insertions(+), 91 deletions(-)
>  create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-core.c
>  create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-core.h
>  create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-debugfs.c
>  create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-debugfs.h
>  create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-regs.h
> 
> -- 
> 2.34.1
> 
