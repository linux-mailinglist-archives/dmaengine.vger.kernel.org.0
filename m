Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B089C707F4D
	for <lists+dmaengine@lfdr.de>; Thu, 18 May 2023 13:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjERLbB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 18 May 2023 07:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbjERLau (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 18 May 2023 07:30:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB283273A;
        Thu, 18 May 2023 04:30:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F39E64E6B;
        Thu, 18 May 2023 11:29:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE5E7C433D2;
        Thu, 18 May 2023 11:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684409385;
        bh=9LI7Eie4pR+440TeZJdiGBPFtoSK4gvgmTsDZmYKKFQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Le3Kna3snPDKjpmB1zmAwiiW1VvfTzhGf4sAoLzuUl7HOm56O+mPASd9b6E5BzqTA
         dXKi0PrnxW3yvADZzJzOvD3SbhWCr6/6hteVb/YwNwXsqnvjoGiZ0xldWAVHEFNEop
         8l1qaQrzaGQORoiGExX223xDTu4Xjbjq294030AbknxOXdJtgWRgN01PswI3YKept4
         rRu+zCv9CgpXvL94n9egxrH3BqePxw7h3bdO4WRZD85iS77yCm8pwfH9U+jsEN6cZT
         g086H1rn8PQCoQl3Sz0jJoaJQTCcbimbDxBM2JCuYQdxV61IkcxIE/vtZHEqFlVOMN
         kIwPuaZONj/wA==
Date:   Thu, 18 May 2023 16:59:41 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: ste_dma40: use proper format string for
 resource_size_t
Message-ID: <ZGYMJWoOYL0ddPBg@matsya>
References: <20230517201951.619693-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517201951.619693-1-arnd@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 17-05-23, 22:19, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When LPAE is set, both the dma_addr_t and resource_size_t become 64 bit
> wide, causing a warning about the format string:
> 
> drivers/dma/ste_dma40.c: In function 'd40_probe':
> drivers/dma/ste_dma40.c:3539:23: error: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'resource_size_t' {aka 'long long unsigned int'} [-Werror=format=]
>  3539 |         dev_info(dev, "found LCPA SRAM at 0x%08x, size 0x%08x\n",
> 
> Change both to the special %pap and %pap helpers for these types.

Already posted [1] and applied now

[1]: https://lore.kernel.org/r/20230517064434.141091-1-vkoul@kernel.org


-- 
~Vinod
