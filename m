Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18D612DDA70
	for <lists+dmaengine@lfdr.de>; Thu, 17 Dec 2020 21:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731488AbgLQU6q (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 17 Dec 2020 15:58:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:45178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731468AbgLQU6q (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 17 Dec 2020 15:58:46 -0500
Subject: Re: [GIT PULL]: dmaengine update for v5.11-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608238685;
        bh=mrBLX+cK6VCW6FcHITR3WVuyKE87cU3HxvbfVPh8g1s=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=lrr+14Po8WY9ICPdR8kNvVHwR6HGxsieW2wZULSBbXmOBTDR4w6N5AzZHtgzFPzVi
         1gsLSSnRKxPsPue0wepfmsn8wdGDawr62ppTVXjspY7rfAmowuEDHBYygnY/Jk9WUq
         4aV6fZf3Y/1qyVY7X5s1r7JaH64+9iXOGCb+dBRYjRrn/Ym6/DTkFBE1pbwHwx7cgS
         hZ7ekGQKLFjJWBTzrjj4MxDqEIk95yE3SL35DihHzohIdNZodDGFnCzHzlMjgkAbl9
         fbPMWHF+/d0YjU9pE5lEfNbABBX94IAdifpA5URYQhJPt+/kS1oZWnXGnJslni6GYW
         usZ/kK9mjF3SQ==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201217172427.GG8403@vkoul-mobl>
References: <20201217172427.GG8403@vkoul-mobl>
X-PR-Tracked-List-Id: <dmaengine.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201217172427.GG8403@vkoul-mobl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-5.11-rc1
X-PR-Tracked-Commit-Id: 115ff12aecfd55376d704fa2c0a2d117e5827f9f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6daa90439e91bb9a71864b02f7d0af8587ea889a
Message-Id: <160823868538.27370.7017031706746627158.pr-tracker-bot@kernel.org>
Date:   Thu, 17 Dec 2020 20:58:05 +0000
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dma <dmaengine@vger.kernel.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The pull request you sent on Thu, 17 Dec 2020 22:54:27 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-5.11-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6daa90439e91bb9a71864b02f7d0af8587ea889a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
