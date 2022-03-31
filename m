Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B78C4ED12B
	for <lists+dmaengine@lfdr.de>; Thu, 31 Mar 2022 03:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352229AbiCaBIW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 30 Mar 2022 21:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343946AbiCaBIW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 30 Mar 2022 21:08:22 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF95766203
        for <dmaengine@vger.kernel.org>; Wed, 30 Mar 2022 18:06:34 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id p15so38765636lfk.8
        for <dmaengine@vger.kernel.org>; Wed, 30 Mar 2022 18:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=pQin6zzGAuRacO9FVhrB5u1rqYNKK0HG35yvZRfDw/0=;
        b=LoZF0VUPCeyR0nPwrZ7ben+plaiet+DBjQmDF1p7B+WWSESHbWu9AsK7Zc43BNgN/w
         9AdEkpPqx5fOG+1e/cyBfU/ZYawfrMeJp95XaDhxSMkxVQXpqVmt4uq2hSevQzxorIA9
         wmZlE2Esg9QY3W6cjtFed7CZRvYiSKgDcIfnPCq+bKP3rj0M4V3IVZ6/OfiPyApAzmpF
         OafI3BTBfz0QF5VovF7+W35/N0qXM9WfYzYOpufuFo0RDKDgA7lsUQNv8WFuE3NCbA9+
         K2kEJTmO+4d89le22vJNdOXGCvFYybh3xqSMLzhQ6qRNuRno8rDIDiMCNbvcrSUceuC/
         qXAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=pQin6zzGAuRacO9FVhrB5u1rqYNKK0HG35yvZRfDw/0=;
        b=uZpMQZRqVaMJnWMLLT35cBizJbA7yX8uukDKp6OiqlHVGpJ99kPGww/W6LBzb6MCSW
         BQuH4ReCUlDV31WJz3cIUKI5vPqqy5A+qV6ASWPc7X3JLn7+8VU0/Mz5ovpf6iCTuZW/
         BSr8USsRNJVbr0NkMvjgMop9DkbRukILt3gi4EeNmAJIrnLeqjL4q+Pooz2hMVIFcyUx
         AlU/Nm2RtTzRd+YmSjU4keJa4/JdUK0xrLssE6OolBOJa8lMU4+CZFHQEr9JHP4sWAYV
         VUxQfm9SOKQiiY5CLVrclt0ozorSun9kT0hBuId2nA/Ihv1eqcnI8SbWDZzNhBI5X4EL
         OBfQ==
X-Gm-Message-State: AOAM531fy822sULfuYXG/HfXnoUc730T+OfXf1a/JsHkyHplLTE/8p60
        YzMDa4q08UOHzegzUW8y4zBH3hekEPOBD+lM+oWXlQ==
X-Google-Smtp-Source: ABdhPJwRI/M8FbLpqXsPZDNWG2rFpgPuua67WqFCLmYKJgq6Z/6FsQGUHVJQ/05ReOq1eRD1RvJQ664QpAYl0Yz3Fus=
X-Received: by 2002:a19:c20e:0:b0:44a:375c:6eb0 with SMTP id
 l14-20020a19c20e000000b0044a375c6eb0mr8919131lfc.5.1648688793121; Wed, 30 Mar
 2022 18:06:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1648461096.git.zong.li@sifive.com>
In-Reply-To: <cover.1648461096.git.zong.li@sifive.com>
From:   Zong Li <zong.li@sifive.com>
Date:   Thu, 31 Mar 2022 09:06:22 +0800
Message-ID: <CANXhq0oRB6dEHM8of6pySWM-6CkJ3WZVsqDC5J1fKuFzJnVJKw@mail.gmail.com>
Subject: Re: [PATCH v8 0/4] Determine the number of DMA channels by
 'dma-channels' property
To:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Bin Meng <bin.meng@windriver.com>,
        Green Wan <green.wan@sifive.com>, Vinod <vkoul@kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod and Palmer,
This patchset got some reviewed-by and acked-by, if it is good to you
as well, are you willing to help me to pick them? Thanks.

On Mon, Mar 28, 2022 at 5:52 PM Zong Li <zong.li@sifive.com> wrote:
>
> The PDMA driver currently assumes there are four channels by default, it
> might cause the error if there is actually less than four channels.
> Change that by getting number of channel dynamically from device tree.
> For backwards-compatible, it uses the default value (i.e. 4) when there
> is no 'dma-channels' information in dts.
>
> This patch set contains the dts and dt-bindings change.
>
> Changed in v8:
>  - Rebase on master
>  - Remove modification of microchip-mpfs.dtsi
>  - Rename DMA node name of fu540-c000.dtsi
>
> Changed in v7:
>  - Rebase on tag v5.17-rc7
>  - Modify the subject of patch
>
> Changed in v6:
>  - Rebase on tag v5.17-rc6
>  - Change sf_pdma.chans[] to a flexible array member.
>
> Changed in v5:
>  - Rebase on tag v5.17-rc3
>  - Fix typo in dt-bindings and commit message
>  - Add PDMA versioning scheme for compatible
>
> Changed in v4:
>  - Remove cflags of debug use reported-by: kernel test robot <lkp@intel.com>
>
> Changed in v3:
>  - Fix allocating wrong size
>  - Return error if 'dma-channels' is larger than maximum
>
> Changed in v2:
>  - Rebase on tag v5.16
>  - Use 4 as default value of dma-channels
>
> Zong Li (4):
>   dt-bindings: dma-engine: sifive,fu540: Add dma-channels property and
>     modify compatible
>   riscv: dts: Add dma-channels property and modify compatible
>   riscv: dts: rename the node name of dma
>   dmaengine: sf-pdma: Get number of channel by device tree
>
>  .../bindings/dma/sifive,fu540-c000-pdma.yaml  | 19 +++++++++++++--
>  arch/riscv/boot/dts/sifive/fu540-c000.dtsi    |  5 ++--
>  drivers/dma/sf-pdma/sf-pdma.c                 | 24 ++++++++++++-------
>  drivers/dma/sf-pdma/sf-pdma.h                 |  8 ++-----
>  4 files changed, 38 insertions(+), 18 deletions(-)
>
> --
> 2.35.1
>
