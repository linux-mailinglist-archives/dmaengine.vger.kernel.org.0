Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4EA52DC14
	for <lists+dmaengine@lfdr.de>; Thu, 19 May 2022 19:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236279AbiESR4s (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 19 May 2022 13:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243623AbiESR4n (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 19 May 2022 13:56:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7342C8BF6
        for <dmaengine@vger.kernel.org>; Thu, 19 May 2022 10:56:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51AF760B8F
        for <dmaengine@vger.kernel.org>; Thu, 19 May 2022 17:56:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D31C34113;
        Thu, 19 May 2022 17:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652983001;
        bh=h+ItqMw3FsV7M3NANuS45MAb2v2tD4iG16rJQGLuGxY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mb84rMTgyGyXhnic4g7x9JV4eELogywhE197fx7S5KAz3uyvRuBP5MhG4RWxph8mR
         rirkwQXXHLOdFgarQ+dUQO11nbdTv4KM5TcQvHg+ZEOhFxtY9CgWqN1ey7HB3BPXOj
         t8zWLfBEey4NQtzFRRC/bgn/KefdCtLEN6Lx+3PeyJYg0QqQ9v5t+Bb32n187QNB+M
         /ergowdW+L3rAWZdCfpkOCqwjxcKYajMZCTOCmjxhvV9dpgdtZcDIPzuVzHmaD8NFg
         rhdFykffCuITQghMeBBl2LRvfj208BebBBx2pktMKdXVU4QwxArqdL9rn3GFveoI7K
         7npMu/GrMBv+g==
Date:   Thu, 19 May 2022 23:26:37 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: make idxd_wq_enable() return 0 if wq is
 already enabled
Message-ID: <YoaE1fQ63jscSLib@matsya>
References: <165090980906.1378449.1939401700832432886.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165090980906.1378449.1939401700832432886.stgit@djiang5-desk3.ch.intel.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 25-04-22, 11:03, Dave Jiang wrote:
> When calling idxd_wq_enable() and wq is already enabled, code should return 0
> and indicate function is successful instead of return error code and fail.
> This should also put idxd_wq_enable() in sync with idxd_wq_disable() where
> it returns 0 if wq is already disabled.

Applied, thanks

-- 
~Vinod
