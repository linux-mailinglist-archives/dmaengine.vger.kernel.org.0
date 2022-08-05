Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2040458A493
	for <lists+dmaengine@lfdr.de>; Fri,  5 Aug 2022 03:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240513AbiHEBuP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 4 Aug 2022 21:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240511AbiHEBuM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 4 Aug 2022 21:50:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33EE2EA;
        Thu,  4 Aug 2022 18:50:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F8A261698;
        Fri,  5 Aug 2022 01:50:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BF8A3C433D6;
        Fri,  5 Aug 2022 01:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659664209;
        bh=I3FIJmRwXv0PwpsWE4a+8tewy72DkdaFxKGh4BFiR18=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Vx0UkxrcXGnNE3eN++tMvfVNunxeNLQzR6znXOdUivqAC407l8eW/bzISyr7QwfRA
         mx/95/Ih4fXD2SGxS/VSIyZgHUYHR0RYxjvWUkzw0iemqTmYY7X6lhIsE0E2OKDt8L
         wukZjGlQmoVNgv1AEBYmgGPS8pssCnFy61I0f6ebqXTQrAAwjYBd8EGIJ6/6vcZE0e
         DXEYzNScxFYTBFWgvXSjffpdL8QNly9wc2NTyMmIUgLmX54jVhiRk54GxnpDYXFMW2
         XSuAC7Qy8Nh/finhGIgEUfDI0s2mNYkLujkqT0U69E67Xzp3H1awM+rEmHMUaTG2S/
         A0+BSo9OACp+Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A372EC43142;
        Fri,  5 Aug 2022 01:50:09 +0000 (UTC)
Subject: Re: [GIT PULL]: dmaengine updates for v6.0-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YuuJNJ7/3AXzKMF7@matsya>
References: <YuuJNJ7/3AXzKMF7@matsya>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YuuJNJ7/3AXzKMF7@matsya>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-6.0-rc1
X-PR-Tracked-Commit-Id: a1873f837f9e5c1001462a635af1b0bab31aa9fd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 31be1d0fbd950395701d9fd47d8fb1f99c996f61
Message-Id: <165966420966.23541.11548246758390344065.pr-tracker-bot@kernel.org>
Date:   Fri, 05 Aug 2022 01:50:09 +0000
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The pull request you sent on Thu, 4 Aug 2022 14:24:12 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-6.0-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/31be1d0fbd950395701d9fd47d8fb1f99c996f61

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
