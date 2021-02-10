Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 098CF31712E
	for <lists+dmaengine@lfdr.de>; Wed, 10 Feb 2021 21:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbhBJUUW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 10 Feb 2021 15:20:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:44864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232802AbhBJUUF (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 10 Feb 2021 15:20:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 8DE0464EE7;
        Wed, 10 Feb 2021 20:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612988364;
        bh=A52N/E4Jr5ACqoxP7TM9+8AxbrFnGYdYr5TGb6wlYVI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CyUpSLBrVOfcZLfcx+0jj4vmle238VV1t6dmjCYKcJyssUddn1ggwtIZAFBvkNGOg
         GYcGUqWiF0b+u/5qlQ53hjNx1Et+fu/0TGN2nKWxAkaHyBa8Si4zB7fL7wSDpvSzl0
         FFxN1bQbI+bz3jHBgfEaNMuof15yG175h4dre2noGdoebNDC7EJaGoNaio69x+M+wF
         MuFIeldwG9YeRSQviZWyurCsCaM1ySf5wiHVQROUVJ/vj4L3RHyBRiYcNzzQv+mpgc
         d8/yFrdN3ggyIepD90WfPSMOXc2langhIfVVi207CQDr0AXA+UNFomMBHxGZGKmYWF
         ZisRR2MhVDqDQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 88DD2609E2;
        Wed, 10 Feb 2021 20:19:24 +0000 (UTC)
Subject: Re: [GIT PULL] dmaengine fixes for v5.11
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210210100036.GD2774@vkoul-mobl.Dlink>
References: <20210210100036.GD2774@vkoul-mobl.Dlink>
X-PR-Tracked-List-Id: <dmaengine.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210210100036.GD2774@vkoul-mobl.Dlink>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-fix2-5.11
X-PR-Tracked-Commit-Id: b6c14d7a83802046f7098e9bae78fbde23affa74
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 708c2e41814209e5dde27c61ad032f4c1ed3624b
Message-Id: <161298836455.25163.2339646608440759813.pr-tracker-bot@kernel.org>
Date:   Wed, 10 Feb 2021 20:19:24 +0000
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The pull request you sent on Wed, 10 Feb 2021 15:30:36 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-fix2-5.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/708c2e41814209e5dde27c61ad032f4c1ed3624b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
