Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A43F64FBA13
	for <lists+dmaengine@lfdr.de>; Mon, 11 Apr 2022 12:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242682AbiDKKvM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Apr 2022 06:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239480AbiDKKvL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 Apr 2022 06:51:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E614443EE0;
        Mon, 11 Apr 2022 03:48:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79AAD61518;
        Mon, 11 Apr 2022 10:48:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04C2CC385A3;
        Mon, 11 Apr 2022 10:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649674133;
        bh=PYoKjVNaZaP85+VTrMLYd0+rrD4W9IKBqmtGHK94kPQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HvadtOZf2dSKdYcMt3y9aytIYryVH5LRSa5Fg3QzHVo7zMhoMIbIoWHUw0D2Q6cTR
         lFpn6Pd6Tfvy787XXpjYzoQ5jPr7tkKYUJ5u//qj2oylMh4c4SpP4EmkiHzMfgXEU2
         vE0+1Ky6rrslhjr+I/OVminEeEwR5ZJoE/xN0etO+JP3RS9mpR2NxiOp8Zpf8cehIC
         xZsZ9TyuAxN04MOn5YleIngCXUbax5qRVXIYuyCBlf7dq/TOMou09benIqN+vCTx+p
         i8GAfm8ToTMmhlz+Ov/cZImsojQ9mdLJv5u8xmJHuIWRqPl6MpWuyVFUIiTis5V2zy
         lFU4EgDZDEP3Q==
Date:   Mon, 11 Apr 2022 16:18:49 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Zong Li <zong.li@sifive.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
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
Subject: Re: [PATCH v8 0/4] Determine the number of DMA channels by
 'dma-channels' property
Message-ID: <YlQHkeZhHvC/n0G5@matsya>
References: <cover.1648461096.git.zong.li@sifive.com>
 <YlA1DwdIMoQ1dXZS@matsya>
 <CANXhq0ramPvr=CL2oPsPAnWiF9X0eYVt8HGAVWPE9mZ5PfhG7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANXhq0ramPvr=CL2oPsPAnWiF9X0eYVt8HGAVWPE9mZ5PfhG7A@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 11-04-22, 10:51, Zong Li wrote:
> On Fri, Apr 8, 2022 at 9:13 PM Vinod Koul <vkoul@kernel.org> wrote:
> >
> > On 28-03-22, 17:52, Zong Li wrote:
> > > The PDMA driver currently assumes there are four channels by default, it
> > > might cause the error if there is actually less than four channels.
> > > Change that by getting number of channel dynamically from device tree.
> > > For backwards-compatible, it uses the default value (i.e. 4) when there
> > > is no 'dma-channels' information in dts.
> >
> > Applied patch 1 & 4 to dmaengine-next, thanks
> 
> Hi Vinod,
> Thanks for your help and review. For patch 2 and 3, does it mean that
> we should go through the riscv tree?

Yes

-- 
~Vinod
