Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2EF64ED334
	for <lists+dmaengine@lfdr.de>; Thu, 31 Mar 2022 07:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbiCaFXw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 31 Mar 2022 01:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiCaFXv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 31 Mar 2022 01:23:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D2E27FC9;
        Wed, 30 Mar 2022 22:22:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 408826157E;
        Thu, 31 Mar 2022 05:22:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0C93C340F0;
        Thu, 31 Mar 2022 05:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648704121;
        bh=mcpxMkNMcpIlYQUa58BATurZoUD7VVJ6ZND97kCSnXU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pRdzYTk6mAg1IM92bAPvM2X6NqMt8fQbd+EcDDdzUwqaRA+5L+czyvNXrdTrYEezA
         jeSUz011ZrWkRFWJ6oddYzbd1zLRd7FwrLuGThxbqQ3kUwbUAW95ln1ncBeWQSqIAn
         vvHkIDjEprrq5dsyE6rtexyPNNrrYGdEMqiWNlQ0+mqkpz+X5L+aHpDKEQ8xP6t5xC
         9T6nc/2ivi7v9di4JB4Moc2aG+gw3KIGm93qSoC8aI3uv/mc1PmfEeNzaYVHRb5oD4
         SVLIj/lKRmv6m6FsKhbHnzSkjm8W7Y4MY1MohKdebDq53yqNGp8aAbvtBITSXYNy1t
         2+oDmVp+ZBMNA==
Date:   Thu, 31 Mar 2022 10:51:56 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     zong.li@sifive.com, robh+dt@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, krzysztof.kozlowski@canonical.com,
        conor.dooley@microchip.com, geert@linux-m68k.org,
        bin.meng@windriver.com, green.wan@sifive.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v8 0/4] Determine the number of DMA channels by
 'dma-channels' property
Message-ID: <YkU6dPFNPkD0Jay+@matsya>
References: <cover.1648461096.git.zong.li@sifive.com>
 <mhng-6ddf988e-9f86-4f3e-8b6a-6be65f384829@palmer-ri-x1c9>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-6ddf988e-9f86-4f3e-8b6a-6be65f384829@palmer-ri-x1c9>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 30-03-22, 20:15, Palmer Dabbelt wrote:
> On Mon, 28 Mar 2022 02:52:21 PDT (-0700), zong.li@sifive.com wrote:
> > The PDMA driver currently assumes there are four channels by default, it
> > might cause the error if there is actually less than four channels.
> > Change that by getting number of channel dynamically from device tree.
> > For backwards-compatible, it uses the default value (i.e. 4) when there
> > is no 'dma-channels' information in dts.
> > 
> > This patch set contains the dts and dt-bindings change.
> > 
> > Changed in v8:
> >  - Rebase on master
> >  - Remove modification of microchip-mpfs.dtsi
> >  - Rename DMA node name of fu540-c000.dtsi
> > 
> > Changed in v7:
> >  - Rebase on tag v5.17-rc7
> >  - Modify the subject of patch
> > 
> > Changed in v6:
> >  - Rebase on tag v5.17-rc6
> >  - Change sf_pdma.chans[] to a flexible array member.
> > 
> > Changed in v5:
> >  - Rebase on tag v5.17-rc3
> >  - Fix typo in dt-bindings and commit message
> >  - Add PDMA versioning scheme for compatible
> > 
> > Changed in v4:
> >  - Remove cflags of debug use reported-by: kernel test robot <lkp@intel.com>
> > 
> > Changed in v3:
> >  - Fix allocating wrong size
> >  - Return error if 'dma-channels' is larger than maximum
> > 
> > Changed in v2:
> >  - Rebase on tag v5.16
> >  - Use 4 as default value of dma-channels
> > 
> > Zong Li (4):
> >   dt-bindings: dma-engine: sifive,fu540: Add dma-channels property and
> >     modify compatible
> >   riscv: dts: Add dma-channels property and modify compatible
> >   riscv: dts: rename the node name of dma
> >   dmaengine: sf-pdma: Get number of channel by device tree
> > 
> >  .../bindings/dma/sifive,fu540-c000-pdma.yaml  | 19 +++++++++++++--
> >  arch/riscv/boot/dts/sifive/fu540-c000.dtsi    |  5 ++--
> >  drivers/dma/sf-pdma/sf-pdma.c                 | 24 ++++++++++++-------
> >  drivers/dma/sf-pdma/sf-pdma.h                 |  8 ++-----
> >  4 files changed, 38 insertions(+), 18 deletions(-)
> 
> Thanks, these are on for-next.

The drivers/dma/ should go thru dmaengine tree. During merge window I
dont apply the patches

-- 
~Vinod
