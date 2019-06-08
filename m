Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96E753A1DA
	for <lists+dmaengine@lfdr.de>; Sat,  8 Jun 2019 22:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbfFHUKL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 8 Jun 2019 16:10:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:55840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727529AbfFHUKK (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sat, 8 Jun 2019 16:10:10 -0400
Subject: Re: [GIT PULL]: dmaengine fixes for v5.2-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560024610;
        bh=e41rfQaiWoPSf8/VYP9FBqSWR3ch1R4DlKwSfIquJgE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=UrW3THNPjpM8pV1vvSDYajvffBD6rhSWx1Rc5OEbaXfTOz8VGPgF3jDzovHdHhw86
         V5L5/tKaxlE/UVJywySib8251vIDUhpudYpUb8W7pYWpcarJF/ae+koRm1SrSqFKg9
         KQ7AladMX/bHDFxPdvwWVyV5PHQdGjk5sAf0g7XE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190608090908.GE9160@vkoul-mobl.Dlink>
References: <20190608090908.GE9160@vkoul-mobl.Dlink>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190608090908.GE9160@vkoul-mobl.Dlink>
X-PR-Tracked-Remote: git://git.infradead.org/users/vkoul/slave-dma.git
 tags/dmaengine-fix-5.2-rc4
X-PR-Tracked-Commit-Id: 9bb9fe0cfbe0aa72fed906ade0590e1702815e5d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 66b59f2b5e48969de862908c2d32c8b3d3724738
Message-Id: <156002460995.1563.8560580065037824824.pr-tracker-bot@kernel.org>
Date:   Sat, 08 Jun 2019 20:10:09 +0000
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The pull request you sent on Sat, 8 Jun 2019 14:39:08 +0530:

> git://git.infradead.org/users/vkoul/slave-dma.git tags/dmaengine-fix-5.2-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/66b59f2b5e48969de862908c2d32c8b3d3724738

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
