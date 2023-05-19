Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A843709674
	for <lists+dmaengine@lfdr.de>; Fri, 19 May 2023 13:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbjESLY1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 19 May 2023 07:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbjESLYZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 19 May 2023 07:24:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26251197;
        Fri, 19 May 2023 04:24:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA9766173F;
        Fri, 19 May 2023 11:24:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 937D0C433D2;
        Fri, 19 May 2023 11:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684495457;
        bh=vmX06VEz6omqeOYpQw5Dp7ZfuSOpXePDzpnGIckooBM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k1E7i3I38ZI0Bi8GRfZbUCK1RLbV6b27Z4T2VCYJX9ImbYT2XwVgl8+xIQ859MVPI
         vnzUzBiuZw1ZNqrCuLp7DRLQLDJiZDzlRWynDnROiHJQIPL3y4rU+wXLFXccJ8h/lx
         Lqrds/wHejWNjF19SnUsseP5MfsABezNwXhx4d5rlYt5aUSbs7Pw5KnuIBkrK6ui10
         VSqbbJizgMyjvHsCujsLw4pTI6rZhNojBzHMPAZYCG8lik/R2/Oj9E3O1MqqNi5VaA
         xIGq2awVkCMuuIG9k+L2tIBbYGdAOWzQQlDPXtZjVb/duIjoa7Q0torzApRhSvaMZc
         +fe8PcSwN5hGQ==
Date:   Fri, 19 May 2023 16:54:13 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        dmaengine@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] dmaengine: at_xdmac: fix potential Oops in
 at_xdmac_prep_interleaved()
Message-ID: <ZGdcXc7GdvoYnYzD@matsya>
References: <21282b66-9860-410a-83df-39c17fcf2f1b@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21282b66-9860-410a-83df-39c17fcf2f1b@kili.mountain>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 15-05-23, 13:32, Dan Carpenter wrote:
> There are two place if the at_xdmac_interleaved_queue_desc() fails which
> could lead to a NULL dereference where "first" is NULL and we call
> list_add_tail(&first->desc_node, ...).  In the first caller, the return
> is not checked so add a check for that.  In the next caller, the return
> is checked but if it fails on the first iteration through the loop then
> it will lead to a NULL pointer dereference.

Applied, thanks

-- 
~Vinod
