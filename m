Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F0F52DBE8
	for <lists+dmaengine@lfdr.de>; Thu, 19 May 2022 19:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241589AbiESRvo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 19 May 2022 13:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241663AbiESRu3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 19 May 2022 13:50:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B653EB36CE;
        Thu, 19 May 2022 10:49:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3E076B825C3;
        Thu, 19 May 2022 17:49:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42F71C385AA;
        Thu, 19 May 2022 17:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652982581;
        bh=9A5+aIyuXlTlURbYrnNECxCHAE/FESaqMNCsL6/awOI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Puppa7FBRvhE6BDdhEDwhEJWvRlwJNek6upoz4Dr5kf0mDHj/ln2DX4S+ztY5+U2P
         li2U6dtnwbQWT2DzDSeUBXj1B+Ks0lur/ohsr7Zo6HPaXQl1bPK4My2L2oQURzkH61
         Wygy+6X6rvUAirXy1GXvHbF6nQKFmuDyjZIqN5p4kAYuBpNF9SkqWcBXXOR+AHZJqe
         9RM2MvzrVBwE8BZCzeLHjzSV52j2siBqjmr32q2E498BIDkVs1KlBtBF+ouXpEx1hY
         yxH1Pgb/rzdcgk2/PBiGgx/H1S/B8cVx6ZTWf79pG6NThDKRs8Tt1oWc97caOZqmcl
         eLd11ncCWxqFw==
Date:   Thu, 19 May 2022 23:19:37 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        dmaengine@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: stm32-dmamux: avoid reset of dmamux if used
 by coprocessor
Message-ID: <YoaDMTRk07ot2p7B@matsya>
References: <20220504161724.123180-1-amelie.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504161724.123180-1-amelie.delaunay@foss.st.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 04-05-22, 18:17, Amelie Delaunay wrote:
> One of the two DMA controllers managed by the DMAMUX can be used by the
> coprocessor. It is defined in the device tree with dma-masters.
> When the two DMA controllers are used by the main CPU,
> dma-masters = <&dma1, &dma2>; is specified in the device tree.
> When one of the controllers is used by coprocessor (so not managed by
> Linux), dma-masters = <&dma1>; is specified in the device tree.
> In this case, Linux driver must not reset the DMAMUX, because it could have
> been configured by the coprocessor to use the second DMA controller.
> count is the number of DMA controllers defined in dma-masters property.
> Reset only if resets property is found and valid in device tree, and if
> the two DMA controllers are under Linux control.

Applied, thanks

-- 
~Vinod
