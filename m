Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E10CB598F
	for <lists+dmaengine@lfdr.de>; Wed, 18 Sep 2019 04:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbfIRCPY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 17 Sep 2019 22:15:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:60456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728010AbfIRCPV (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 17 Sep 2019 22:15:21 -0400
Subject: Re: [GIT PULL] dmaengine updates for v5.4-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568772921;
        bh=dGDHoAFjaw37bcJWLL5f8w7hNAn4l2MgbNF9zXd6DHI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=OblEvgBRx6GIG73L4KcmmxmplolIi63QaLhW5xLzmAhHq6du+f9kSBs5ewt2wYI+a
         LLYgGgTx5XyU3MKBSwJBu+9Z9iixWMSAza75CjzPRmpKniFLhPF2gdeHyFabLPi+xm
         78G8Sij13t7MHtljZzIyHTGwMKJlnXgv4B8idUHQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190917093229.GL4392@vkoul-mobl>
References: <20190917093229.GL4392@vkoul-mobl>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190917093229.GL4392@vkoul-mobl>
X-PR-Tracked-Remote: git://git.infradead.org/users/vkoul/slave-dma.git
 tags/dmaengine-5.4-rc1
X-PR-Tracked-Commit-Id: c5c6faaee6e0c374c7dfaf053aa23750f5a68e20
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 04cbfba6208592999d7bfe6609ec01dc3fde73f5
Message-Id: <156877292129.2898.8164983077176436756.pr-tracker-bot@kernel.org>
Date:   Wed, 18 Sep 2019 02:15:21 +0000
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The pull request you sent on Tue, 17 Sep 2019 15:02:29 +0530:

> git://git.infradead.org/users/vkoul/slave-dma.git tags/dmaengine-5.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/04cbfba6208592999d7bfe6609ec01dc3fde73f5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
