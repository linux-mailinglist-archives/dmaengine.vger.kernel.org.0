Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03F5822183D
	for <lists+dmaengine@lfdr.de>; Thu, 16 Jul 2020 01:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgGOXKE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Jul 2020 19:10:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:50616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726578AbgGOXKD (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 15 Jul 2020 19:10:03 -0400
Subject: Re: [GIT PULL] dmaengine: fixes for v5.8-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594854603;
        bh=9vYI+uE65iA16yL5Gfr4wnUTQqSLbarX0GtH0CEU72E=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=wL1XN2UctNDS8VCo+GyssKCEYnubQjdAJM8tnO3uEjazRki222FDjcqXWGOc37p1B
         u9gh/x15e8Xf6MeQSq2QGtJ4rU+CCmS5N1VJ7JohGx/Q0pNbXX0ZUGBte8Ecyg7cc5
         1XXXji73mEvLuYyHXT5q2VzBysSseWczcjAjO0YQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200715093617.GF34333@vkoul-mobl>
References: <20200715093617.GF34333@vkoul-mobl>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200715093617.GF34333@vkoul-mobl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git
 tags/dmaengine-fix-5.8-rc6
X-PR-Tracked-Commit-Id: 87730ccbddcb48478b1b88e88b14e73424130764
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0665a4e9a1d6a51b6a25d5a5de6c623d380d853b
Message-Id: <159485460357.13658.6396472328268569651.pr-tracker-bot@kernel.org>
Date:   Wed, 15 Jul 2020 23:10:03 +0000
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The pull request you sent on Wed, 15 Jul 2020 15:06:17 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-fix-5.8-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0665a4e9a1d6a51b6a25d5a5de6c623d380d853b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
