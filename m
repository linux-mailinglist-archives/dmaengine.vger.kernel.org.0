Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDD935F92B
	for <lists+dmaengine@lfdr.de>; Wed, 14 Apr 2021 18:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbhDNQnS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 14 Apr 2021 12:43:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:43684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230488AbhDNQnR (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 14 Apr 2021 12:43:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 33BBD61154;
        Wed, 14 Apr 2021 16:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618418576;
        bh=HiaHo83UxCTv7AY9PP2ko6gjKORB1fnZL6keftudnpI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fLMbxWSNeue0x6h/GU5FhS0JATU9RhjhMUo03GlKGwukjWgbJMbhKacdibk658UyP
         p1eYHnGHEN7sj1tS2xuc2CjsjLp8g4Wr919KTq9xcx1GMNZhJ2b8JG4IKRbWpcYW6U
         VIQgmU6KOexies1ksT4Hod5bGOjxBDq1/PWPaZ3FOBBhdUznwNa19f/JiKtqEwHwG/
         UxE7bK+fWB+/pkZ8ZqqsamMilpOL4ckIUz5Cc2CG49+9ATH7MiikO2WZPjfaXYRtmA
         a1VcTy1z2C3et4luAd7R6GOqPGJOoTHGROt7EbzH09v++Ej5VPpVlfaEb49xrR5uYK
         A69uxlq+hN4Ag==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 27B4260CCF;
        Wed, 14 Apr 2021 16:42:56 +0000 (UTC)
Subject: Re: [GIT PULL]: dmaengine fixes for 5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YHcZ2Kylq+RuDzPg@vkoul-mobl.Dlink>
References: <YHcZ2Kylq+RuDzPg@vkoul-mobl.Dlink>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YHcZ2Kylq+RuDzPg@vkoul-mobl.Dlink>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-fix-5.12
X-PR-Tracked-Commit-Id: ea9aadc06a9f10ad20a90edc0a484f1147d88a7a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c17a3066b4c1acdf36fa307faaa391f558ac0420
Message-Id: <161841857610.15788.3753215321939337130.pr-tracker-bot@kernel.org>
Date:   Wed, 14 Apr 2021 16:42:56 +0000
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The pull request you sent on Wed, 14 Apr 2021 22:05:36 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-fix-5.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c17a3066b4c1acdf36fa307faaa391f558ac0420

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
