Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9B51C27CD
	for <lists+dmaengine@lfdr.de>; Sat,  2 May 2020 20:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728505AbgEBSpI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 2 May 2020 14:45:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:60096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728411AbgEBSpH (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sat, 2 May 2020 14:45:07 -0400
Subject: Re: [GIT PULL]: dmaengine fixes for v5.7-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588445107;
        bh=mtYF0ENJLtrJn3/8qT2aJaeuQRMsZn+PB7dSIaTEsmI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=dDbFoC7hH/v5RtQlLrsYHsL+eqrnQWKu4NRu+IR1/Lcso9YSXu4+vAzVABjGF4b/c
         SprGTtgDoT57EyQTyr/pJHgE7sYh2aqnHhZHN7iy7V7xf7OF6fjjSGCYTr8ozxaoa+
         2ucBa3ktE8n6Oq+O+VX5XyIhWvzRAyTXhn1u6CwE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200502110348.GM948789@vkoul-mobl.Dlink>
References: <20200502110348.GM948789@vkoul-mobl.Dlink>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200502110348.GM948789@vkoul-mobl.Dlink>
X-PR-Tracked-Remote: git://git.infradead.org/users/vkoul/slave-dma.git
 tags/dmaengine-fix-5.7-rc4
X-PR-Tracked-Commit-Id: aa72f1d20ee973d68f26d46fce5e1cf6f9b7e1ca
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ed6889db63d24600e523ac28fbece33201906611
Message-Id: <158844510730.26966.6166803935500363489.pr-tracker-bot@kernel.org>
Date:   Sat, 02 May 2020 18:45:07 +0000
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The pull request you sent on Sat, 2 May 2020 16:33:48 +0530:

> git://git.infradead.org/users/vkoul/slave-dma.git tags/dmaengine-fix-5.7-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ed6889db63d24600e523ac28fbece33201906611

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
