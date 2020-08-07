Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7E223F3E2
	for <lists+dmaengine@lfdr.de>; Fri,  7 Aug 2020 22:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgHGUkI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 7 Aug 2020 16:40:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:33292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbgHGUkH (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 7 Aug 2020 16:40:07 -0400
Subject: Re: [GIT PULL]: dmaengine updates for v5.9-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596832807;
        bh=ffF7pgb5CC9QZjtpFziZVf95m1p+QOe2xbYxCPDIVMk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=zUA+vcgDLJYJBbIMy6ruCjhkzE8FJ2asYjGguPYP9YLhATWLE0IgZ5WHKRkXyo2L9
         QTBOZ1vKZBX+ON37ZLJIv15f2Cn90FGTtjnfm3QIWlfa2pmrFTGbHGiDgx/ZQx0Pm7
         uVRFODb3rkmrOill+QcZ5fumd+jyCJESisa9faVU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200807060551.GL12965@vkoul-mobl>
References: <20200807060551.GL12965@vkoul-mobl>
X-PR-Tracked-List-Id: <dmaengine.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200807060551.GL12965@vkoul-mobl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-5.9-rc1
X-PR-Tracked-Commit-Id: 00043a2689232631f39ebbf6719d545b1d799086
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ce615f5c1f73537c8267035d58b3d0c70e19b8da
Message-Id: <159683280755.2860.12124200925415454292.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Aug 2020 20:40:07 +0000
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dma <dmaengine@vger.kernel.org>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The pull request you sent on Fri, 7 Aug 2020 11:35:51 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-5.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ce615f5c1f73537c8267035d58b3d0c70e19b8da

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
