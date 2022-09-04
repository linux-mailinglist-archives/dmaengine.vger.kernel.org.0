Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B2A5AC5A7
	for <lists+dmaengine@lfdr.de>; Sun,  4 Sep 2022 19:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234493AbiIDRSy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 4 Sep 2022 13:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234216AbiIDRSw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 4 Sep 2022 13:18:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B0833E27;
        Sun,  4 Sep 2022 10:18:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6DBB360F6B;
        Sun,  4 Sep 2022 17:18:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B243C433D6;
        Sun,  4 Sep 2022 17:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662311900;
        bh=mrk5pkJcHTTsmwCZFN9V23o4HfG3eXfOH8HbEbJtxJk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nptjcenw/XHolTmJsfu437e63yq4FMUbBY1rW3hXzrzuqDuUBiqktWBlw4h9sg9kh
         0ASWXE5IYedKw/F1BTPgeKgHnsjWPKUl7hav+YWDGfAKlQJn+TSu5a5Tcu9l8E68x9
         T5JcNbMzHly1AG1sLTu0i2KjcUgxzstMwVQqgWoVspq31qEfo4d4M1jLHFj+a5BitX
         DNF0lV/ZMYL6Fu4sJ5MJLCgvPO57T3JgE2DlEuI/b04Av9PJRcFxip2JK7JKRtjpbk
         DYNSW8GGGnrcLjFVoa11pATgpI3MyEVMV9JNpE8yN/UVWgr5S7CJoTAlb9ZUXqhd4u
         J3pfF82X0paMg==
Date:   Sun, 4 Sep 2022 22:48:14 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-doc@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marek Vasut <marex@denx.de>
Subject: Re: [RESEND PATCH v3 0/6] STM32 DMA-MDMA chaining feature
Message-ID: <YxTd1jBS3xk/YT6m@matsya>
References: <20220829154646.29867-1-amelie.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829154646.29867-1-amelie.delaunay@foss.st.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 29-08-22, 17:46, Amelie Delaunay wrote:
> This patchset (re)introduces STM32 DMA-MDMA chaining feature.
> 
> As the DMA is not able to generate convenient burst transfer on the DDR,
> it penalises the AXI bus when accessing the DDR. While it accesses
> optimally the SRAM. The DMA-MDMA chaining then consists in having an SRAM
> buffer between DMA and MDMA, so the DMA deals with peripheral and SRAM,
> and the MDMA with SRAM and DDR.
> 
> The feature relies on the fact that DMA channel Transfer Complete signal
> can trigger a MDMA channel transfer and MDMA can clear the DMA request by
> writing to DMA Interrupt Clear register.
> 
> A deeper introduction can be found in patch 1.
> 
> Previous implementation [1] has been dropped as nacked.
> Unlike this previous implementation (where all the stuff was embedded in
> stm32-dma driver), the user (in peripheral drivers using dma) has now to
> configure the MDMA channel.

Applied, thanks

-- 
~Vinod
