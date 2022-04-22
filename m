Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB4F50AFD9
	for <lists+dmaengine@lfdr.de>; Fri, 22 Apr 2022 08:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232861AbiDVGCW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 22 Apr 2022 02:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232912AbiDVGCW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 22 Apr 2022 02:02:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8C24F9EC
        for <dmaengine@vger.kernel.org>; Thu, 21 Apr 2022 22:59:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A15A61DD2
        for <dmaengine@vger.kernel.org>; Fri, 22 Apr 2022 05:59:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33E98C385A4;
        Fri, 22 Apr 2022 05:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650607169;
        bh=C2Hj2+Z1XjiShfrUX+VbMjRZuQBKVyhIUwgYnzfGfNA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rKjcCOrbONBv9TnlvU4w0I6cqS77dO62wNez67WID+JamTtlKqihHXn3iEgDwwSZH
         PpuxrSir+6dGtBdg6eCx9e0cVA7EpuuT16AwyDFLNsuRrG6wWLFtBfUG1MAiAvzZ66
         dehFpWm0XTVHIEvu0bptLMl1vDjmQLTB/RfQc1Olj51F5t2pKbIHYUjhxZv51yWDll
         0ikkp7o6PxiXM7nZIb+DlCXC9WyofLrgCHiCJQMK3dMWWHq4Q4bHKuf8nWH3q67InB
         9KeKyJD2lupEOqOcRferqH0HcNl83dWjVWHt1BHVlPAkQCzk/63l40F7U16WuO47bL
         vPgYxMK9l7uBA==
Date:   Fri, 22 Apr 2022 11:29:25 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     dmaengine@vger.kernel.org, Sanjay R Mehta <sanju.mehta@amd.com>
Cc:     Ilya Novikov <i.m.novikov@yadro.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] dmaengine: ptdma: statify pt_tx_status
Message-ID: <YmJEPaA0R+9gTgfW@matsya>
References: <20220421052407.745637-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421052407.745637-1-vkoul@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 21-04-22, 10:54, Vinod Koul wrote:
> LKP bot reports a new warning:
> Warning:
> drivers/dma/ptdma/ptdma-dmaengine.c:262:1: warning: no previous prototype for 'pt_tx_status' [-Wmissing-prototypes]
> 
> pt_tx_status() should be static, so declare as such.

Applied, thanks

-- 
~Vinod
