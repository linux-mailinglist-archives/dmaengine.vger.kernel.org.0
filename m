Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 760666C031
	for <lists+dmaengine@lfdr.de>; Wed, 17 Jul 2019 19:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387726AbfGQRPT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 17 Jul 2019 13:15:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:42264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387720AbfGQRPT (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 17 Jul 2019 13:15:19 -0400
Subject: Re: [GIT PULL] dmaengine updates for v5.3-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563383718;
        bh=g+qn77hPeIxnuaI1kjpl4LDt4j0trpyKZzrxMwLgJ5A=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=KT8j6XOVxcsNd0gbYmwI7ObNQlRMN8Y0Zk/lcGcXr0oBD+jsgnJz0hEVITOwiY5ht
         7FMJtpGtpDMSvDWwTcQFoPctTmmxh8OLX257eGXzR2tOM6vtaiDpDjuF190EsK8kP5
         tHl/3vsZ3TU6RWXBZ++oEEwwZ6xw7qV5P+xgDhYk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190716093657.GD12733@vkoul-mobl.Dlink>
References: <20190716093657.GD12733@vkoul-mobl.Dlink>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190716093657.GD12733@vkoul-mobl.Dlink>
X-PR-Tracked-Remote: git://git.infradead.org/users/vkoul/slave-dma.git
 tags/dmaengine-5.3-rc1
X-PR-Tracked-Commit-Id: 5c274ca4cfb22a455e880f61536b1894fa29fd17
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 47ebe00b684c2bc183a766bc33c8b5943bc0df85
Message-Id: <156338371889.30487.9555344021679795718.pr-tracker-bot@kernel.org>
Date:   Wed, 17 Jul 2019 17:15:18 +0000
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The pull request you sent on Tue, 16 Jul 2019 15:06:57 +0530:

> git://git.infradead.org/users/vkoul/slave-dma.git tags/dmaengine-5.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/47ebe00b684c2bc183a766bc33c8b5943bc0df85

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
