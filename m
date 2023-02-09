Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F55569145E
	for <lists+dmaengine@lfdr.de>; Fri, 10 Feb 2023 00:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjBIX0m (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 9 Feb 2023 18:26:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbjBIX0k (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 9 Feb 2023 18:26:40 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B582B66EF9;
        Thu,  9 Feb 2023 15:26:21 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id qw12so11385168ejc.2;
        Thu, 09 Feb 2023 15:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PjQEZxP8lMZ2UBLX1ynT5dUYuWcXIgYl0zrxVwqKemg=;
        b=oAc2ICH0OBXTKGpUsXh7Oa62UNpe3B12xPP3it7lQM3ghOZRi6u5IM0zUZNAoeAloe
         YorPnFV7eCM7OgtntHJbeh41+eQp+CGeiDR1nccW2d+GUkKFfSXFNanhePmAdZL+Q4rN
         V9Fjbb+XAI7eLppYpByZ7HzSP5hP2KkzaT0GS2Ysf1gxvJWkK4x8qYPlkfTlBTZNE43J
         XUKx/isye4CTsOuxGqETRO2g2dJ7MVysOfmKca9Em2BtFsgXO0hQ69qo3TUoQfNGNkWx
         zILdxBM0TRQjvHIU22W4COjTx5jN2zgHZNYRZwQ6HPP2EQHX6ZE1EGE5NkG41xBgqw4Q
         x6Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PjQEZxP8lMZ2UBLX1ynT5dUYuWcXIgYl0zrxVwqKemg=;
        b=4ADgfA4crqJCfOE2Du2Hw+VmN7Cax74/ac9ZH7kgc5NwSyi0WKiMtxN6Zn/5qbr9JA
         K5vE//yjk1GLu84cbcHVzNFVydYqBBPQKQ4eHtmoZKyTuHFoGDrIv6H2eIsqGWIPcZjA
         mvUW0NasORoaVIbtgFYGymxY4VDOkttpC57IegCZNOnWWXGBVPny2/dOUY7wTX1E+Gz0
         s3dqlblSadT27H5gZwZZodePWmD6UsZmck6VnRaIU/Gxe9r7JzD+II3+fQE/zIdxf9NS
         Sj/Uqs1FlJn1FhWp6N4cEtmG36we88OJxnWdVYCHctRoYOkpTnApXp0COhWb4lJERyG/
         DysQ==
X-Gm-Message-State: AO0yUKX6+nnf1XKhPFORLcoixt+zEtDZDVeCLxU2D9ks59SaCWf9fIYh
        yqga9+6hN3OXfi/HnJ12lWQ=
X-Google-Smtp-Source: AK7set/xzAGC3h51eCtPDzMsOJDcjSbudUO9W2gjP2kBzBAB6Ft4VbrTkpc7ja4hG/j17s9fihdzlg==
X-Received: by 2002:a17:906:1dc8:b0:878:8237:7abb with SMTP id v8-20020a1709061dc800b0087882377abbmr14406317ejh.35.1675985180235;
        Thu, 09 Feb 2023 15:26:20 -0800 (PST)
Received: from mobilestation ([83.220.236.142])
        by smtp.gmail.com with ESMTPSA id uo39-20020a170907cc2700b00887ce5caf66sm1517317ejc.59.2023.02.09.15.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 15:26:19 -0800 (PST)
Date:   Fri, 10 Feb 2023 02:26:16 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Cai Huoqing <cai.huoqing@linux.dev>,
        caihuoqing <caihuoqing@baidu.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH 1/3] dmaengine: dw-edma: Rename dw_edma_core_ops
 structure to dw_edma_plat_ops
Message-ID: <20230209232616.5zyxtxqzlmbnnzba@mobilestation>
References: <20220921064859.10328-1-cai.huoqing@linux.dev>
 <20220921064859.10328-2-cai.huoqing@linux.dev>
 <Y2UWvjNHBGa8PjBZ@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2UWvjNHBGa8PjBZ@matsya>
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

On Fri, Nov 04, 2022 at 07:12:22PM +0530, Vinod Koul wrote:
> On 21-09-22, 14:48, Cai Huoqing wrote:
> > From: caihuoqing <caihuoqing@baidu.com>
> > 
> > Rename dw_edma_core_ops structure to dw_edma_plat_ops,
> > because the 'ops' is related to platform device
> 
> Is that really a case, the device can be non platform too right?

The patchlog is misleading in the suggested naming convention. The
dw_edma_pcie_plat_ops name was supposed to refer to the platform which
the DW eDMA engine is embedded to, like PCIe end-point (accessible via
the PCIe bus) or a PCIe root port (directly accessible by CPU).
Needless to say that for them the IRQ-vector and PCI-addresses are
differently determined. The suggested name has a connection with the
kernel platform device only as a private case of the eDMA/hDMA embedded
into the DW PCI Root ports, though basically it was supposed to refer to
any platform in which the DMA hardware lives.

Anyway the renaming was necessary to distinguish two types of
the implementation callbacks:
1. DW eDMA/hDMA IP-core specific operations: device-specific CSR
setups in one or another aspect of the DMA-engine initialization.
2. DW eDMA/hDMA platform specific operations: the DMA device
environment configs like IRQs, address translation, etc.

dw_edma_pcie_core_ops is supposed to be used for the case 1, and
dw_edma_pcie_plat_ops - for the case 2.

-Serge(y)

> 
> -- 
> ~Vinod
