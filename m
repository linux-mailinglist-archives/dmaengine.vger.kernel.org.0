Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C328F3E2F48
	for <lists+dmaengine@lfdr.de>; Fri,  6 Aug 2021 20:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243008AbhHFS1e (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 6 Aug 2021 14:27:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:41386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241541AbhHFS1b (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 6 Aug 2021 14:27:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 0BF3561186;
        Fri,  6 Aug 2021 18:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628274435;
        bh=Gd5VYs8Xefz+uIWTI75YeI+t3r2vF1GcVdLexLpxbaU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=G2YjaLfuYNKIZhNJGSyeX5NKWPCm0hBB0UdeAAo0UNB7DdNfF1Es4QobQ5a3IJgk+
         pnciEX+lYBwXpxMg+51yoDTq797/50eDiLGsFpMFx/88nOC3/G8sEBBLVOmJ/H/58v
         oJgGo29fSpMCbg2QSpnZmkDHkiiXMfG+1ybjXhafytC80Uo9m5jkhW6lc2iSGx0Bd2
         TOzHfObSSrbmEp6/wcCh7qP9DHutPxcGyJiAhXyOyqMVKmazIBTv04Iasp9Z2AXrDw
         ghho7s5QL1Z3EKveT/PoFGacWICsq4kw69TPZ26COySdXhPshAbfbrk+Yq4lJ1HUjS
         bMk7p+GfSiV6A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 06232609F1;
        Fri,  6 Aug 2021 18:27:15 +0000 (UTC)
Subject: Re: [GIT PULL]: dmaengine fixes for v5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YQ1BhK0C9utGOOIn@matsya>
References: <YQ1BhK0C9utGOOIn@matsya>
X-PR-Tracked-List-Id: <dmaengine.vger.kernel.org>
X-PR-Tracked-Message-Id: <YQ1BhK0C9utGOOIn@matsya>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-fix-5.14
X-PR-Tracked-Commit-Id: 7199ddede9f0f2f68d41e6928e1c6c4bca9c39c0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4f1be39638a538f6495c0a29e648255fb8c54f8b
Message-Id: <162827443501.9282.11129555084175274541.pr-tracker-bot@kernel.org>
Date:   Fri, 06 Aug 2021 18:27:15 +0000
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dma <dmaengine@vger.kernel.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The pull request you sent on Fri, 6 Aug 2021 19:34:52 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-fix-5.14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4f1be39638a538f6495c0a29e648255fb8c54f8b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
