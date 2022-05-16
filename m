Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED9A52848F
	for <lists+dmaengine@lfdr.de>; Mon, 16 May 2022 14:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237031AbiEPMuu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 16 May 2022 08:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243673AbiEPMuk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 16 May 2022 08:50:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748993A184
        for <dmaengine@vger.kernel.org>; Mon, 16 May 2022 05:50:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A6F661209
        for <dmaengine@vger.kernel.org>; Mon, 16 May 2022 12:50:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9259C385AA;
        Mon, 16 May 2022 12:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652705430;
        bh=1qUu96sZF5LGjHPsriDZT8AlGdnFJIhXONwWeRlKd9E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HXZBna3w3FhHxUlaiMt3BzudbsdqTSZLjj5X9NwPxgR6F+gf0HPs7dWPjTgzmuUYW
         8nW9PmnoJoRGVvAlAPhm2RroG0h7b+KvCQKlKE6y4CjvCR0gpvp2ARNfM7IINkPSl9
         BB6TWGO6eE4EIz+DmFjz6z+xZhOfEvToQV9gNqgvcMvmQXx44rLVN5s30ctoWvaEd9
         CCGBDPMwjlOixcaikUdT5QXTej5lx3cjTVAbI2fVUltBAhsrwic/U1vZwELAqFKraH
         hND/Xh7Tt0tkFhny92TUf7FlG2ZBNEFX/aGQDO/0etf4yOmM+/TBfsAIPlVEvH9ata
         e89iZwF2L8+hQ==
Date:   Mon, 16 May 2022 18:20:26 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org, jacob.jun.pan@linux.intel.com,
        baolu.lu@intel.com
Subject: Re: [PATCH] dmaengine: idxd: Separate user and kernel pasid enabling
Message-ID: <YoJIkrGkRmPaHKcM@matsya>
References: <165231431746.986466.5666862038354800551.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165231431746.986466.5666862038354800551.stgit@djiang5-desk3.ch.intel.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 11-05-22, 17:11, Dave Jiang wrote:
> The idxd driver always gated the pasid enabling under a single knob and
> this assumption is incorrect. The pasid used for kernel operation can be
> independently toggled and has no dependency on the user pasid (and vice
> versa). Split the two so they are independent "enabled" flags.

Applied, thanks

-- 
~Vinod
