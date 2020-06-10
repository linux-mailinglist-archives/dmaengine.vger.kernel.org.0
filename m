Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 742491F5B90
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2020 20:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729669AbgFJSzW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 10 Jun 2020 14:55:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:39058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727924AbgFJSzV (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 10 Jun 2020 14:55:21 -0400
Subject: Re: [GIT PULL]: dmaengine updates for v5.8-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591815321;
        bh=Vz1GxnRwLFJdzK0i6jVyDiAJuDb8ghpGyCC4M3PJAR0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=jWHiNtA8WDcXTcTF0tkEwOq7NZmFsqkfApwhLE4VITSGQ4/Ad2CtmSf0HhVY3KEZC
         o6LQDZmWhAcce61+uXywwXBCerkeY+6cSaF9o0TUV6Jy6Lmiuvl0Qs2rrAaUmVND3r
         xVTtMR1rxBYmLbxFWn64wiwvhtaReKpRjKnyMA1U=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200609115416.GC1084979@vkoul-mobl>
References: <20200609115416.GC1084979@vkoul-mobl>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200609115416.GC1084979@vkoul-mobl>
X-PR-Tracked-Remote: git://git.infradead.org/users/vkoul/slave-dma.git
 tags/dmaengine-5.8-rc1
X-PR-Tracked-Commit-Id: be4cf718cd9929e867ed1ff06d23fb4d08cc2d36
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c90e7945e3a39c50c07e63a5892e65ecfde374a9
Message-Id: <159181532141.20525.15523745656815138448.pr-tracker-bot@kernel.org>
Date:   Wed, 10 Jun 2020 18:55:21 +0000
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The pull request you sent on Tue, 9 Jun 2020 17:24:16 +0530:

> git://git.infradead.org/users/vkoul/slave-dma.git tags/dmaengine-5.8-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c90e7945e3a39c50c07e63a5892e65ecfde374a9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
