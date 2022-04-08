Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43AAE4F9057
	for <lists+dmaengine@lfdr.de>; Fri,  8 Apr 2022 10:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiDHIFk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 8 Apr 2022 04:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbiDHIFi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 8 Apr 2022 04:05:38 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8907A1B7BF
        for <dmaengine@vger.kernel.org>; Fri,  8 Apr 2022 01:03:34 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id d40so6165231lfv.11
        for <dmaengine@vger.kernel.org>; Fri, 08 Apr 2022 01:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J1QVpP3nerTWKa1cyXGMgzBZ9LJVJEdqC7pjfww4Eh0=;
        b=IeHertmL2Qe+vuZ8bL1egILsY7UVK9i7WmMVBevq7VhIsjazs1pJ+Ube2AyCXTxyLx
         kPIMhbh0ndj9+nSc9CyU7BM9LpmGocVAs1rADnKyDy8c6JuYZ+cKpmbwwLq3sIQjW4xG
         2WqhW5ZdCysAjQZtB6lo1phb0nqgzgv6uVjFnREhiOttLuIKWNk1mSvSPx061KIJJgVQ
         9JDvEoyEJV5+YdTQPoficS4rT+6Rsd9Llr2uKJ7lwes/Nir2gNcr5XPsU8rc94bWOCHQ
         4NSR1q6+Tenym6U0iGBZigdZPrnYdalm9sEJUnagjyHXi+oocrTVrRqx3TRq2Gkq/bSZ
         gEuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J1QVpP3nerTWKa1cyXGMgzBZ9LJVJEdqC7pjfww4Eh0=;
        b=FUAQF6wzwMAV72sMTMPOfQ08cSo9a3YDK+a7ooZNDqoHxHWqtLLzoaeCmVuTQiVaJ+
         g1I/yeVSkhDqoTk9xGyVULzwiYThK5gQhoPBUbKqFh9iP3i11jf7tyIiJ6Wyd16yfakT
         ZGsurHr5EsWcN8G3ok86JBY4Yr8f+/UgYsoXkHDGtSIYKz3Ue+VnN+VOsWnt8R+SId4X
         AVVgYxnt0oilRVWTuc1M+UqNGr3pPTLv1OqDAUIFG+LYQ+IbhmaJGu0M0VUBJB30PBUO
         +ZZFUTv81JF/t/VvGF1i0R5iNdcUYn8vqGyh6/vb5criC/5D1LwJqqaL3zgN9WLIdo1j
         4aTA==
X-Gm-Message-State: AOAM533cirYvU42iGz1mBMju3DcYqStDfigs+rs7Y8I+hR4oqskP7oM1
        EhMorDtqNCho8h08bYadm5LrabLq/ks2xFT9mT6czw==
X-Google-Smtp-Source: ABdhPJytOGV4FV7cxGl9JWBImAtlMB4k8mvHiIAddgBXq11/Fmeb9upmp/zsxOMs5V3rbsnaBv4P8xhZXt/X//ewaMk=
X-Received: by 2002:ac2:4834:0:b0:45d:519d:933 with SMTP id
 20-20020ac24834000000b0045d519d0933mr12035301lft.5.1649405012705; Fri, 08 Apr
 2022 01:03:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1648461096.git.zong.li@sifive.com> <mhng-6ddf988e-9f86-4f3e-8b6a-6be65f384829@palmer-ri-x1c9>
 <YkU6dPFNPkD0Jay+@matsya>
In-Reply-To: <YkU6dPFNPkD0Jay+@matsya>
From:   Zong Li <zong.li@sifive.com>
Date:   Fri, 8 Apr 2022 16:03:22 +0800
Message-ID: <CANXhq0oz_zNHJEaWxk9QFy=sDf1cKmrJROn3pEfQWo0AF2Cetw@mail.gmail.com>
Subject: Re: [PATCH v8 0/4] Determine the number of DMA channels by
 'dma-channels' property
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Mar 31, 2022 at 1:22 PM Vinod Koul <vkoul@kernel.org> wrote:
>
> On 30-03-22, 20:15, Palmer Dabbelt wrote:
> > On Mon, 28 Mar 2022 02:52:21 PDT (-0700), zong.li@sifive.com wrote:
> > > The PDMA driver currently assumes there are four channels by default, it
> > > might cause the error if there is actually less than four channels.
> > > Change that by getting number of channel dynamically from device tree.
> > > For backwards-compatible, it uses the default value (i.e. 4) when there
> > > is no 'dma-channels' information in dts.
> > >
> > > This patch set contains the dts and dt-bindings change.
> > >
> > > Changed in v8:
> > >  - Rebase on master
> > >  - Remove modification of microchip-mpfs.dtsi
> > >  - Rename DMA node name of fu540-c000.dtsi
> > >
> > > Changed in v7:
> > >  - Rebase on tag v5.17-rc7
> > >  - Modify the subject of patch
> > >
> > > Changed in v6:
> > >  - Rebase on tag v5.17-rc6
> > >  - Change sf_pdma.chans[] to a flexible array member.
> > >
> > > Changed in v5:
> > >  - Rebase on tag v5.17-rc3
> > >  - Fix typo in dt-bindings and commit message
> > >  - Add PDMA versioning scheme for compatible
> > >
> > > Changed in v4:
> > >  - Remove cflags of debug use reported-by: kernel test robot <lkp@intel.com>
> > >
> > > Changed in v3:
> > >  - Fix allocating wrong size
> > >  - Return error if 'dma-channels' is larger than maximum
> > >
> > > Changed in v2:
> > >  - Rebase on tag v5.16
> > >  - Use 4 as default value of dma-channels
> > >
> > > Zong Li (4):
> > >   dt-bindings: dma-engine: sifive,fu540: Add dma-channels property and
> > >     modify compatible
> > >   riscv: dts: Add dma-channels property and modify compatible
> > >   riscv: dts: rename the node name of dma
> > >   dmaengine: sf-pdma: Get number of channel by device tree
> > >
> > >  .../bindings/dma/sifive,fu540-c000-pdma.yaml  | 19 +++++++++++++--
> > >  arch/riscv/boot/dts/sifive/fu540-c000.dtsi    |  5 ++--
> > >  drivers/dma/sf-pdma/sf-pdma.c                 | 24 ++++++++++++-------
> > >  drivers/dma/sf-pdma/sf-pdma.h                 |  8 ++-----
> > >  4 files changed, 38 insertions(+), 18 deletions(-)
> >
> > Thanks, these are on for-next.
>
> The drivers/dma/ should go thru dmaengine tree. During merge window I
> dont apply the patches
>
> --
> ~Vinod

Hi Vinod,
Many thanks for considering this patchset :)  Could I know if there is
an opportunity to pick this into the following few -rc kernels?
