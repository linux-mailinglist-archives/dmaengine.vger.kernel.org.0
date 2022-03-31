Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B134ED392
	for <lists+dmaengine@lfdr.de>; Thu, 31 Mar 2022 07:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbiCaF4g (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 31 Mar 2022 01:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiCaF4f (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 31 Mar 2022 01:56:35 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729EE673C7
        for <dmaengine@vger.kernel.org>; Wed, 30 Mar 2022 22:54:48 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id p17so22465962plo.9
        for <dmaengine@vger.kernel.org>; Wed, 30 Mar 2022 22:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=LsQ2rHdZ2Pn2SWmoHtGM/9EAvT94L/VPQneu88cPzwo=;
        b=fhBB4NNDdLmXkeTPANq7lsyDMOfX1/D0yapXetf68Ih585qlMXbjQk4w73YtHMyRA/
         y7UIy8BR72on4QPmShIlonIzpPK3aFXq4jOAfItwroot+BWxIIVdbLbjlXJMdvU9vaul
         KHrXRGClA2Jty1lY1c+R4Lq+cwHfraSVxaBqiIJYVad/MRTYNp1nE3aJ6j2d+eelUNlu
         lc55fFYROwp6EwpJb0A+jUi9aMxQjAsa1yJGAm4QlrVXgD8nqkqA+znMAtAoAuO29Gky
         aPF0tGurLWfqxxP7LEiVp3TXDehEdpApwcsKTt38YnfGW2NsR9SJUW/IdAL62n63Ci/X
         OhCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=LsQ2rHdZ2Pn2SWmoHtGM/9EAvT94L/VPQneu88cPzwo=;
        b=n/T8Pat2AxEq0/fwa7My9QsZVAKwXPQBXngGAR8bELFj7EIYC/NAKLQNuHywVYnlb7
         otJ2a/cBVpKBhWZYp27Pdzk5rnLn6lwOA2kxDHY0CYmaygtysdb8ErTcvtuoLuSxQTLY
         hL98GNVg2QimsATIzL3SyfiXCZR8wxSrPLj3imwr1BvHnE4+WXF24N1t1rgI8H1Xfqmb
         UGTJGRolchOcjmZXxD7F6k41QPok9GBVlgeDC3dRVqC7Kr/6pGo7+j/BND//etKihpUV
         7Ks4ajzAvejZ+vZpY6jEjrmXpRLPT75MCYhn493pQe/1WuzqmuZ/4qK7ybhQtHMVHICF
         yGLg==
X-Gm-Message-State: AOAM532ivStijjqVsDeNAFp3F+thFxaZsLdGGvfUdIi7Vs46uTfuYRna
        w9XlUPLjbszALGjQws3wgZo6Ig==
X-Google-Smtp-Source: ABdhPJxioxYkaYts7CBDktycPVgQ0mhkwygWeeK4NEwWpOUCxx3LDEExO74HzKZgGeLU2iVMjn30sw==
X-Received: by 2002:a17:902:8306:b0:14f:a386:6a44 with SMTP id bd6-20020a170902830600b0014fa3866a44mr3661884plb.140.1648706087889;
        Wed, 30 Mar 2022 22:54:47 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id pc13-20020a17090b3b8d00b001c775679f58sm8661466pjb.37.2022.03.30.22.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 22:54:47 -0700 (PDT)
Date:   Wed, 30 Mar 2022 22:54:47 -0700 (PDT)
X-Google-Original-Date: Wed, 30 Mar 2022 22:54:44 PDT (-0700)
Subject:     Re: [PATCH v8 0/4] Determine the number of DMA channels by 'dma-channels' property
In-Reply-To: <YkU6dPFNPkD0Jay+@matsya>
CC:     zong.li@sifive.com, robh+dt@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, krzysztof.kozlowski@canonical.com,
        conor.dooley@microchip.com, geert@linux-m68k.org,
        bin.meng@windriver.com, green.wan@sifive.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     vkoul@kernel.org
Message-ID: <mhng-c6a04a4f-1e85-49e9-baee-b56b0e78c602@palmer-ri-x1c9>
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

On Wed, 30 Mar 2022 22:21:56 PDT (-0700), vkoul@kernel.org wrote:
> On 30-03-22, 20:15, Palmer Dabbelt wrote:
>> On Mon, 28 Mar 2022 02:52:21 PDT (-0700), zong.li@sifive.com wrote:
>> > The PDMA driver currently assumes there are four channels by default, it
>> > might cause the error if there is actually less than four channels.
>> > Change that by getting number of channel dynamically from device tree.
>> > For backwards-compatible, it uses the default value (i.e. 4) when there
>> > is no 'dma-channels' information in dts.
>> >
>> > This patch set contains the dts and dt-bindings change.
>> >
>> > Changed in v8:
>> >  - Rebase on master
>> >  - Remove modification of microchip-mpfs.dtsi
>> >  - Rename DMA node name of fu540-c000.dtsi
>> >
>> > Changed in v7:
>> >  - Rebase on tag v5.17-rc7
>> >  - Modify the subject of patch
>> >
>> > Changed in v6:
>> >  - Rebase on tag v5.17-rc6
>> >  - Change sf_pdma.chans[] to a flexible array member.
>> >
>> > Changed in v5:
>> >  - Rebase on tag v5.17-rc3
>> >  - Fix typo in dt-bindings and commit message
>> >  - Add PDMA versioning scheme for compatible
>> >
>> > Changed in v4:
>> >  - Remove cflags of debug use reported-by: kernel test robot <lkp@intel.com>
>> >
>> > Changed in v3:
>> >  - Fix allocating wrong size
>> >  - Return error if 'dma-channels' is larger than maximum
>> >
>> > Changed in v2:
>> >  - Rebase on tag v5.16
>> >  - Use 4 as default value of dma-channels
>> >
>> > Zong Li (4):
>> >   dt-bindings: dma-engine: sifive,fu540: Add dma-channels property and
>> >     modify compatible
>> >   riscv: dts: Add dma-channels property and modify compatible
>> >   riscv: dts: rename the node name of dma
>> >   dmaengine: sf-pdma: Get number of channel by device tree
>> >
>> >  .../bindings/dma/sifive,fu540-c000-pdma.yaml  | 19 +++++++++++++--
>> >  arch/riscv/boot/dts/sifive/fu540-c000.dtsi    |  5 ++--
>> >  drivers/dma/sf-pdma/sf-pdma.c                 | 24 ++++++++++++-------
>> >  drivers/dma/sf-pdma/sf-pdma.h                 |  8 ++-----
>> >  4 files changed, 38 insertions(+), 18 deletions(-)
>>
>> Thanks, these are on for-next.
>
> The drivers/dma/ should go thru dmaengine tree. During merge window I
> dont apply the patches

OK, I can drop this from my tree if you'd like?
