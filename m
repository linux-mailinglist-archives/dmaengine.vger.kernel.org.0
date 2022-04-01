Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947DB4EE7EA
	for <lists+dmaengine@lfdr.de>; Fri,  1 Apr 2022 07:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239737AbiDAFxD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 1 Apr 2022 01:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245197AbiDAFwx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 1 Apr 2022 01:52:53 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E65527E0
        for <dmaengine@vger.kernel.org>; Thu, 31 Mar 2022 22:51:03 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id p15so2912437lfk.8
        for <dmaengine@vger.kernel.org>; Thu, 31 Mar 2022 22:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qA1v0A7dc3FV4RuMv5ZQV+qnRwKmp9V+QFkq5cmpENY=;
        b=RMf4MzqPShODxLhq+sO4cUVTL3s/BrBvRG/EaMjOanqT3bAMiyKedu7D3sCrExpRdk
         nYKSZHJq3Y3KMEff96G8lFu3QcAjZT0UNIGroLdVSmjshBRp3CQ/VIgP+wZtFK73kk5Y
         1Gr1qpQNLItoN5zU/4GjpZlzsKTMTduLnNfTxZ/F6Y2GOiQPkeb/5071tQGXYLH2e5iQ
         Hlps5YemK2FlkjzWe0fmiMtXBDFUpmwsCqVPY8oTlM8hFaIRi42+tbLBP68BWhiIf+kH
         9pVGm4jItuyZf7pyIMruxC/4uuZSRvpMuGpySvAHCtN0fT58BvcfJQmUBmyG3Lls5Wml
         93Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qA1v0A7dc3FV4RuMv5ZQV+qnRwKmp9V+QFkq5cmpENY=;
        b=XRZgmpFuHz2S07eZeFEvgAAWQ5TywwwH3qhqvPkYUbf2XAQw1gzCLGNr9N3HhadBJO
         YknFDP1FTMrhKv+zNDivgFvJ9C5C/GDdNZzIajBsXvrENSvL7xQuSNyZtcO77Ktm01sC
         qXVwpUVfucMdjFCvKBNrnzN+Py8l7m+EP5pyfMvGL0bzTx8AczuAtTjTgyXYZtx9LssY
         9mMjp9jLM3/macv7cQ/DPPPBBxOBMiUHjlt1h4UW+Qi8cW4I9+Z/DEAWXimlixGYHwCr
         BUgD9UwW4VSp7r5bYXpsS8Sl14xX2BhwPs+GHEtdggOaiVs/GahifhI97m5vMznZ2hah
         OB/w==
X-Gm-Message-State: AOAM531Zl7qmokZ3K9EoAHBtO+AcaIe4b36UMh8TjdLHyiFrZdRu1eHL
        Rj8Syy5sGivSGtZoKnl+6qzB/Ystn+8VNqEkh4jRPIk7SUsyHw==
X-Google-Smtp-Source: ABdhPJzV5rjeNDxGrh06Y6/j6ua7W2u+B+s3R9VuN1ozC2fonLH2ANgH5N2/XarDXlE09XwQEepCNwQd97y3piadpjo=
X-Received: by 2002:a05:6512:1051:b0:44a:5dcb:3a74 with SMTP id
 c17-20020a056512105100b0044a5dcb3a74mr12761841lfb.51.1648792261524; Thu, 31
 Mar 2022 22:51:01 -0700 (PDT)
MIME-Version: 1.0
References: <mhng-c6a04a4f-1e85-49e9-baee-b56b0e78c602@palmer-ri-x1c9> <mhng-5afad1be-9b06-4cd1-95e3-c21605b9086a@palmer-mbp2014>
In-Reply-To: <mhng-5afad1be-9b06-4cd1-95e3-c21605b9086a@palmer-mbp2014>
From:   Zong Li <zong.li@sifive.com>
Date:   Fri, 1 Apr 2022 13:50:50 +0800
Message-ID: <CANXhq0oJKRVV2QyzJ2WV1fjcw3piyoKeiR5U-=DqsyDayixTGA@mail.gmail.com>
Subject: Re: [PATCH v8 0/4] Determine the number of DMA channels by
 'dma-channels' property
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Vinod <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Bin Meng <bin.meng@windriver.com>,
        Green Wan <green.wan@sifive.com>,
        dmaengine <dmaengine@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Apr 1, 2022 at 6:42 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Wed, 30 Mar 2022 22:54:47 PDT (-0700), Palmer Dabbelt wrote:
> > On Wed, 30 Mar 2022 22:21:56 PDT (-0700), vkoul@kernel.org wrote:
> >> On 30-03-22, 20:15, Palmer Dabbelt wrote:
> >>> On Mon, 28 Mar 2022 02:52:21 PDT (-0700), zong.li@sifive.com wrote:
> >>> > The PDMA driver currently assumes there are four channels by default, it
> >>> > might cause the error if there is actually less than four channels.
> >>> > Change that by getting number of channel dynamically from device tree.
> >>> > For backwards-compatible, it uses the default value (i.e. 4) when there
> >>> > is no 'dma-channels' information in dts.
> >>> >
> >>> > This patch set contains the dts and dt-bindings change.
> >>> >
> >>> > Changed in v8:
> >>> >  - Rebase on master
> >>> >  - Remove modification of microchip-mpfs.dtsi
> >>> >  - Rename DMA node name of fu540-c000.dtsi
> >>> >
> >>> > Changed in v7:
> >>> >  - Rebase on tag v5.17-rc7
> >>> >  - Modify the subject of patch
> >>> >
> >>> > Changed in v6:
> >>> >  - Rebase on tag v5.17-rc6
> >>> >  - Change sf_pdma.chans[] to a flexible array member.
> >>> >
> >>> > Changed in v5:
> >>> >  - Rebase on tag v5.17-rc3
> >>> >  - Fix typo in dt-bindings and commit message
> >>> >  - Add PDMA versioning scheme for compatible
> >>> >
> >>> > Changed in v4:
> >>> >  - Remove cflags of debug use reported-by: kernel test robot <lkp@intel.com>
> >>> >
> >>> > Changed in v3:
> >>> >  - Fix allocating wrong size
> >>> >  - Return error if 'dma-channels' is larger than maximum
> >>> >
> >>> > Changed in v2:
> >>> >  - Rebase on tag v5.16
> >>> >  - Use 4 as default value of dma-channels
> >>> >
> >>> > Zong Li (4):
> >>> >   dt-bindings: dma-engine: sifive,fu540: Add dma-channels property and
> >>> >     modify compatible
> >>> >   riscv: dts: Add dma-channels property and modify compatible
> >>> >   riscv: dts: rename the node name of dma
> >>> >   dmaengine: sf-pdma: Get number of channel by device tree
> >>> >
> >>> >  .../bindings/dma/sifive,fu540-c000-pdma.yaml  | 19 +++++++++++++--
> >>> >  arch/riscv/boot/dts/sifive/fu540-c000.dtsi    |  5 ++--
> >>> >  drivers/dma/sf-pdma/sf-pdma.c                 | 24 ++++++++++++-------
> >>> >  drivers/dma/sf-pdma/sf-pdma.h                 |  8 ++-----
> >>> >  4 files changed, 38 insertions(+), 18 deletions(-)
> >>>
> >>> Thanks, these are on for-next.
> >>
> >> The drivers/dma/ should go thru dmaengine tree. During merge window I
> >> dont apply the patches
> >
> > OK, I can drop this from my tree if you'd like?
>
> Just to follow up from IRC: I'm dropping these from my tree.

Hi Palmer and Vinod,
Many thanks for your help. As all you suggested, let's go this
patchset by the dmaengine tree. Thanks a lot!
