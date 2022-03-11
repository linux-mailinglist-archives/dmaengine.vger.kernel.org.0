Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0CC74D5ECB
	for <lists+dmaengine@lfdr.de>; Fri, 11 Mar 2022 10:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235117AbiCKJwi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 11 Mar 2022 04:52:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbiCKJwi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 11 Mar 2022 04:52:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94C11B9899;
        Fri, 11 Mar 2022 01:51:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7FE75B82854;
        Fri, 11 Mar 2022 09:51:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0CC5C340E9;
        Fri, 11 Mar 2022 09:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646992293;
        bh=GgeVWzigsW0ZPmr8VdhWGO1YRsLbRV7QEtBKeJ2FhJM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qKFkgRowKCjGVBPs2b4KkC6r3lzOa6nfChakVBU1Y/hcU22frFiF2m3UFF8CtAgMW
         3VaLITCkVM5rKjf+nGpJeMBxusyJWWOTZz8ye/01nDL7ZOqlH1WNO1HiKHbRyVqeUC
         9qySmTZ52iKBhtY9Zm6GzgK6Wc4ZLRbkHZl4otzDv0k5YIhkUoT8H3LxrK+yTbrhci
         SWq4o0J2tLk7LwP6NAaxHyc4/dLITzyvHCDb8WnCSqKpahjY8xy4YWiNLYXUVvh+sR
         p9JCIz8Iq/GZW1RxErnSeEZG0QrLmR1+LScbyFxmbYNh95lhbNNg/UDcYhjKujuBUb
         WT387zltDl4EA==
Date:   Fri, 11 Mar 2022 15:21:29 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Dave Jiang <dave.jiang@intel.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: Remove useless DMA-32 fallback
 configuration
Message-ID: <YisboSIXfVVfGOyN@matsya>
References: <009c80294dba72858cd8a6ed2ed81041df1b1e82.1642231430.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <009c80294dba72858cd8a6ed2ed81041df1b1e82.1642231430.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 15-01-22, 08:24, Christophe JAILLET wrote:
> As stated in [1], dma_set_mask() with a 64-bit mask never fails if
> dev->dma_mask is non-NULL.
> So, if it fails, the 32 bits case will also fail for the same reason.
> 
> Simplify code and remove some dead code accordingly.

Applied, thanks

-- 
~Vinod
