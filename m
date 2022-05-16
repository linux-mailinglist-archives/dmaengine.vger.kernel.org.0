Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC0C52848D
	for <lists+dmaengine@lfdr.de>; Mon, 16 May 2022 14:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243082AbiEPMuq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 16 May 2022 08:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243572AbiEPMuh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 16 May 2022 08:50:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEAB39B95
        for <dmaengine@vger.kernel.org>; Mon, 16 May 2022 05:50:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1AEDFB811CE
        for <dmaengine@vger.kernel.org>; Mon, 16 May 2022 12:50:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53748C385B8;
        Mon, 16 May 2022 12:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652705412;
        bh=WQP4oumO35xVjS7uk8XLqF3ehCAmsCxDXFYKc7Plni0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OFUiSdJF+1+smm9SnNo+/tBP0EHVAE2Wpvb7SlzYC3vnBR+CKd1WfHWsMTJyjA+uq
         TS1mSPHEJ3ptoA/oY+aiIT8DM9uhUvbwBs1/pajmTW0TSNYV57nuIYaR2stRHrK3uJ
         BClC7lQkj1afKwHIQlkrsMkZ7hczHFX6kqGl4CuYMdZlmKdgHnYuC/m0mLfIgL3HZ0
         vig5FobK3iLTS55g99gsAyvAlSaLIoUuq+H8UJNeBJQ18BvGNZ0P1FconxLPpQJIAB
         RyRwM1iQWKmO9U2e3hcWoWB1MtbveA46txgIGkV4iVXfAb+Y7xZToJ3xxaHHhhjZTt
         xzmkC99BUJNWQ==
Date:   Mon, 16 May 2022 18:20:09 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: free irq before wq type is reset
Message-ID: <YoJIgZPxZdvj3YJs@matsya>
References: <165231367316.986407.11001767338124941736.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165231367316.986407.11001767338124941736.stgit@djiang5-desk3.ch.intel.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 11-05-22, 17:01, Dave Jiang wrote:
> Call idxd_wq_free_irq() in the drv_disable_wq() function before
> idxd_wq_reset() is called. Otherwise the wq type is reset and the irq does
> not get freed.

Applied, thanks

-- 
~Vinod
