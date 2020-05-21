Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C73541DD8F5
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2020 22:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730327AbgEUUzE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 May 2020 16:55:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:35534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728778AbgEUUzD (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 21 May 2020 16:55:03 -0400
Subject: Re: [GIT PULL]: dmaengine fixes for v5.7-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590094503;
        bh=7iGNOrc13huB/bF3AMhbWuoQe34FHKR2s4DsvfhVVgA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=FxF0RSEVSzWcLDnC0mUonYVZ726tZQkyEyNXsA2n/LW0kghzbqpCe4IeMbp/8Zvsk
         lsPlNN9gM2pkVbBB9dv/RJ1p1DI3s8f610PYmRyUbDG5CNNQxtYh8K/ZZqprahB4Rp
         qsUUIxXtop96PtMRtlD8Ium+UA4JE6AaIQMCENJw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200521143521.GC374218@vkoul-mobl.Dlink>
References: <20200521143521.GC374218@vkoul-mobl.Dlink>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200521143521.GC374218@vkoul-mobl.Dlink>
X-PR-Tracked-Remote: git://git.infradead.org/users/vkoul/slave-dma.git
 tags/dmaengine-fix-5.7-rc7
X-PR-Tracked-Commit-Id: 3a5fd0dbd87853f8bd2ea275a5b3b41d6686e761
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cedd54f713368d32c902befc3714b91afdec1084
Message-Id: <159009450355.9071.17759578303074194234.pr-tracker-bot@kernel.org>
Date:   Thu, 21 May 2020 20:55:03 +0000
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The pull request you sent on Thu, 21 May 2020 20:05:21 +0530:

> git://git.infradead.org/users/vkoul/slave-dma.git tags/dmaengine-fix-5.7-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cedd54f713368d32c902befc3714b91afdec1084

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
