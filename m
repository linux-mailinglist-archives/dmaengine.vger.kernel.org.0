Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55286915FB
	for <lists+dmaengine@lfdr.de>; Fri, 10 Feb 2023 02:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjBJBAS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 9 Feb 2023 20:00:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbjBJBAB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 9 Feb 2023 20:00:01 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD6B3644F;
        Thu,  9 Feb 2023 16:59:56 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id v17so5862761lfd.7;
        Thu, 09 Feb 2023 16:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TbRsX+QftKVwDhfh4wqvBv6T4LndEVTeDJlOctN0KIg=;
        b=OPpVr4rpEWUjKSHG/REcA7uXu5qPf+I84pFkz10UqUk22SmU1hpBH6vh+O8j6WI8ys
         e3xe10TOnaN+metw26ovZ992s/hqUka2tOBTCuXjUC8HdDBRR4nUWLxgZ53p/alq1TFG
         HavlE/JAoYjDvAw07zpLXsiGvxXa8zylrgywgeGmJmtOH4sxLfSr2LO4aUaidRcUv35A
         TdVxqKIkKqxJf0C4HB8TmXyDu5PCcKhEEQYMfH7MRfLWpKaubJwwrRxufX9sHN2YhWbx
         P4+5IBoc0s8hsbvYIKSRba9V5qaAwMXQKWdgzniCrDXM6ySPhIaX+QU1x2tVF7FWw9ky
         VwfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TbRsX+QftKVwDhfh4wqvBv6T4LndEVTeDJlOctN0KIg=;
        b=wyxoCwowXj/J1m7MTX5bI1EYkIwqtzpzec9/VZgIlh3y78njL26hf/wYtYzYjqIHzF
         751J3JyOTe8eKjNestsDjZnjlExCIvScq67OJO9qQc1Bo8wp0kBgjrgnez8u8oDBUr9L
         UqVLBeRe0ezrD06L2YVY19klMPmNotl4qgxLcH6q9IurqhT8LMrIo+VMC3J2dLN0CL+K
         jpfIHRHnm0Q5JRC5pr3BfKSo3v19pPMnU7QyrI+uywh/OHf8BoRRIRYLOXut8nh8jR+C
         tiYCKHagf242DxQGQUX6sfE7nLpBT17GE9U1xgZDI9Kkuul/24nLGABAuMC2QpULU6Za
         WCiw==
X-Gm-Message-State: AO0yUKUeBRnIhyShxoTLY9paAaGuAAKibH86wL8t4iqy/YJzMoD0kbKy
        ojdSuzMzuojrIsP3+yNYnEvF3hZheM8=
X-Google-Smtp-Source: AK7set+cT82jAeItu1v0FJg2+pIjln1yv4Kd6F/wIUhkPQsbaMGKVBgo1WZIuPU9MhtZQd8mBei4sg==
X-Received: by 2002:ac2:530d:0:b0:4da:f64b:cca0 with SMTP id c13-20020ac2530d000000b004daf64bcca0mr2479665lfh.8.1675990794504;
        Thu, 09 Feb 2023 16:59:54 -0800 (PST)
Received: from mobilestation ([91.193.176.251])
        by smtp.gmail.com with ESMTPSA id u10-20020ac24c2a000000b004cc8207741fsm165406lfq.93.2023.02.09.16.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 16:59:54 -0800 (PST)
Date:   Fri, 10 Feb 2023 03:59:51 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Cai Huoqing <cai.huoqing@linux.dev>,
        caihuoqing <caihuoqing@baidu.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH 0/3] dmaengine: dw-edma: Add support for native HDMA
Message-ID: <20230210005951.3l67twgbdxoiwnr6@mobilestation>
References: <20220921064859.10328-1-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921064859.10328-1-cai.huoqing@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod

On Wed, Sep 21, 2022 at 02:48:49PM +0800, Cai Huoqing wrote:
> From: caihuoqing <caihuoqing@baidu.com>
> 
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
> the next read channel to be serviced.
> The same applies when you have multiple write channels.
> 
> The native HDMA driver also supports a maximum of 16 independent
> channels (8 write + 8 read), which can run simultaneously.
> Both SAR (Source Address Register) and DAR (Destination Address Register)
> are alignmented to byte.dmaengine: dw-edma: Add support for native HDMA
> 
> These series based on the series
> https://lore.kernel.org/dmaengine/20220822185332.26149-1-Sergey.Semin@baikalelectronics.ru/

Please note this patchset is a refactored version of the patch
submitted by Cai a while ago
https://lore.kernel.org/dmaengine/20220824140146.29140-1-cai.huoqing@linux.dev/
The main design aspects implemented here were discussed in the
framework of that thread.

-Serge(y)

> 
> Cai Huoqing (3):
>   dmaengine: dw-edma: Rename dw_edma_core_ops structure to
>     dw_edma_plat_ops
>   dmaengine: dw-edma: Create a new dw_edma_core_ops structure to
>     abstract controller operation
>   dmaengine: dw-edma: Add support for native HDMA
> 
>  drivers/dma/dw-edma/Makefile             |   6 +-
>  drivers/dma/dw-edma/dw-edma-core.c       |  65 ++---
>  drivers/dma/dw-edma/dw-edma-core.h       |  19 ++
>  drivers/dma/dw-edma/dw-edma-pcie.c       |   4 +-
>  drivers/dma/dw-edma/dw-edma-v0-core.c    |  90 ++++++-
>  drivers/dma/dw-edma/dw-edma-v0-core.h    |  14 +-
>  drivers/dma/dw-edma/dw-hdma-v0-core.c    | 304 +++++++++++++++++++++++
>  drivers/dma/dw-edma/dw-hdma-v0-core.h    |  17 ++
>  drivers/dma/dw-edma/dw-hdma-v0-debugfs.c | 150 +++++++++++
>  drivers/dma/dw-edma/dw-hdma-v0-debugfs.h |  22 ++
>  drivers/dma/dw-edma/dw-hdma-v0-regs.h    |  98 ++++++++
>  include/linux/dma/edma.h                 |   7 +-
>  12 files changed, 725 insertions(+), 71 deletions(-)
>  create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-core.c
>  create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-core.h
>  create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-debugfs.c
>  create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-debugfs.h
>  create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-regs.h
> 
> -- 
> 2.25.1
> 
