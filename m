Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E96B4EE44D
	for <lists+dmaengine@lfdr.de>; Fri,  1 Apr 2022 00:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242637AbiCaWnv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 31 Mar 2022 18:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242605AbiCaWnu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 31 Mar 2022 18:43:50 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CB022D64A
        for <dmaengine@vger.kernel.org>; Thu, 31 Mar 2022 15:42:02 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id y6so906724plg.2
        for <dmaengine@vger.kernel.org>; Thu, 31 Mar 2022 15:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=yv9Wzw03+NukkaSaVZZG3A+e/UbaRsd8qeLIgoxYYGI=;
        b=aLtSxaTzBBfLrrs6Yqf07PKFqBsmzaPzZr4oCPxsKElf8kiRNH12fyraf+9osQPlA6
         nWW0TdKR12qeZa5fqH+vC9HP/3odKQ6hI1oAxbayxR9vaf3F1KGyttkH5lX4i6VksxXu
         0xTvzKY3GYCmzhee9Cl/y5RMFqT1DmqCZRziWA8NF3naBvhnmTQWsjPxf6EmQPRB3k44
         yPQc8Z2d9rbZTnN7tnNdq3BqES9JSP/Gno/o8Rc1w4eD3F0uNfqj6mCScR/H9U9Xbbes
         e0CBI6ZpomHJG4s4WiA4H1eBQuW+kw1whOvqnA0jEoZ7imEhea5GKa5Uo6qClnjrplAr
         vJyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=yv9Wzw03+NukkaSaVZZG3A+e/UbaRsd8qeLIgoxYYGI=;
        b=DUFkbNCukMX0jPiuZxXNqapPIWiclKt8JOGqo8igeYOkSSbHKCe7SP8Xr++9FPvGsE
         4WmCeW/vhwy/GCdgzySX/AYZp72sXsBcvi+qyrJv21qG40fHnEMkDYFCoYRa4PIAXh6n
         k8xmdo1Tb3p0eNuU+Q8WccfHyaSkW6s4qOo8pHwfDmyRkAG82l5SPHTCnN4JIT6bkIKi
         MwjDnGx0Qn/nxcluqSEOqXQZ8OT2OWbaKbxmm/UDMKAlGRCH8LPFQE3yRamCYciDVo0u
         cW3+rwte5pYOjpSYFfPSNaBUOfSzwZ4jknFmY5fgJDSZJlMIXN5fqAcUrlc+a96beZHs
         D7rg==
X-Gm-Message-State: AOAM530jkz2NL9T3XgLpDYqYBEMjCiC5wmlRoo8hzz+hHgdKCoeh39FP
        v85fD4rwPMZ8KNMCJKhccZhtwA==
X-Google-Smtp-Source: ABdhPJxnnPsasTSwvvvGeMWLk7XXYDekjDntq0m5UMM6IsliYxKEdKVMexqOiT84oCZZ+WVMGKn/sg==
X-Received: by 2002:a17:903:18c:b0:154:9ee:cedc with SMTP id z12-20020a170903018c00b0015409eecedcmr44211037plg.123.1648766522196;
        Thu, 31 Mar 2022 15:42:02 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id u11-20020a056a00158b00b004fb07effe2esm510368pfk.130.2022.03.31.15.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 15:42:00 -0700 (PDT)
Date:   Thu, 31 Mar 2022 15:42:00 -0700 (PDT)
X-Google-Original-Date: Thu, 31 Mar 2022 15:41:57 PDT (-0700)
Subject:     Re: [PATCH v8 0/4] Determine the number of DMA channels by 'dma-channels' property
In-Reply-To: <mhng-c6a04a4f-1e85-49e9-baee-b56b0e78c602@palmer-ri-x1c9>
CC:     zong.li@sifive.com, robh+dt@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, krzysztof.kozlowski@canonical.com,
        conor.dooley@microchip.com, geert@linux-m68k.org,
        bin.meng@windriver.com, green.wan@sifive.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     vkoul@kernel.org
Message-ID: <mhng-5afad1be-9b06-4cd1-95e3-c21605b9086a@palmer-mbp2014>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, 30 Mar 2022 22:54:47 PDT (-0700), Palmer Dabbelt wrote:
> On Wed, 30 Mar 2022 22:21:56 PDT (-0700), vkoul@kernel.org wrote:
>> On 30-03-22, 20:15, Palmer Dabbelt wrote:
>>> On Mon, 28 Mar 2022 02:52:21 PDT (-0700), zong.li@sifive.com wrote:
>>> > The PDMA driver currently assumes there are four channels by default, it
>>> > might cause the error if there is actually less than four channels.
>>> > Change that by getting number of channel dynamically from device tree.
>>> > For backwards-compatible, it uses the default value (i.e. 4) when there
>>> > is no 'dma-channels' information in dts.
>>> >
>>> > This patch set contains the dts and dt-bindings change.
>>> >
>>> > Changed in v8:
>>> >  - Rebase on master
>>> >  - Remove modification of microchip-mpfs.dtsi
>>> >  - Rename DMA node name of fu540-c000.dtsi
>>> >
>>> > Changed in v7:
>>> >  - Rebase on tag v5.17-rc7
>>> >  - Modify the subject of patch
>>> >
>>> > Changed in v6:
>>> >  - Rebase on tag v5.17-rc6
>>> >  - Change sf_pdma.chans[] to a flexible array member.
>>> >
>>> > Changed in v5:
>>> >  - Rebase on tag v5.17-rc3
>>> >  - Fix typo in dt-bindings and commit message
>>> >  - Add PDMA versioning scheme for compatible
>>> >
>>> > Changed in v4:
>>> >  - Remove cflags of debug use reported-by: kernel test robot <lkp@intel.com>
>>> >
>>> > Changed in v3:
>>> >  - Fix allocating wrong size
>>> >  - Return error if 'dma-channels' is larger than maximum
>>> >
>>> > Changed in v2:
>>> >  - Rebase on tag v5.16
>>> >  - Use 4 as default value of dma-channels
>>> >
>>> > Zong Li (4):
>>> >   dt-bindings: dma-engine: sifive,fu540: Add dma-channels property and
>>> >     modify compatible
>>> >   riscv: dts: Add dma-channels property and modify compatible
>>> >   riscv: dts: rename the node name of dma
>>> >   dmaengine: sf-pdma: Get number of channel by device tree
>>> >
>>> >  .../bindings/dma/sifive,fu540-c000-pdma.yaml  | 19 +++++++++++++--
>>> >  arch/riscv/boot/dts/sifive/fu540-c000.dtsi    |  5 ++--
>>> >  drivers/dma/sf-pdma/sf-pdma.c                 | 24 ++++++++++++-------
>>> >  drivers/dma/sf-pdma/sf-pdma.h                 |  8 ++-----
>>> >  4 files changed, 38 insertions(+), 18 deletions(-)
>>>
>>> Thanks, these are on for-next.
>>
>> The drivers/dma/ should go thru dmaengine tree. During merge window I
>> dont apply the patches
>
> OK, I can drop this from my tree if you'd like?

Just to follow up from IRC: I'm dropping these from my tree.
