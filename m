Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4313932345F
	for <lists+dmaengine@lfdr.de>; Wed, 24 Feb 2021 00:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbhBWXqR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 23 Feb 2021 18:46:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:53212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232775AbhBWXhJ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 23 Feb 2021 18:37:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id D2A6164EB6;
        Tue, 23 Feb 2021 23:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614123385;
        bh=PXAKlcuINSnMBcJPBcUixkZc9FvKP0e9ARdLQvwcDZA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=mFCvFtzW1JqsZKRH1X5rizu93jmbfRJxZTPj4kJkknp3VIk8FPhmlvJsy4ic3reG4
         qYi65AUXrwjkCNwMeuZcHc6EZB4/zUOuTqxRL/NkhqDh9bQHx5odFGbEoi0OoJ2rAb
         AgD/wnBp0U2HIDP2ccVgY1+ZEQlKioJEAD4Vm3jtEEa5/VB42JEh2SvCxyv746z5o7
         Wa93AugCm2cESwnqxiMo0rTEENYehl6npyVusPYSTUiZoIKtHu+fSC7UeI23Cx3j8K
         cSERv45RXfxhU3XFQ1JY4Zc0tD7LbVYF4msTVnysh+8s6KbD2JB1XZewbVp7n2SO2Z
         nNC4PVGlcNELg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id CDAD760973;
        Tue, 23 Feb 2021 23:36:25 +0000 (UTC)
Subject: Re: [PULL REQUEST]: dmaengine updates for 5.12-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210223041520.GA2774@vkoul-mobl.Dlink>
References: <20210223041520.GA2774@vkoul-mobl.Dlink>
X-PR-Tracked-List-Id: <dmaengine.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210223041520.GA2774@vkoul-mobl.Dlink>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-5.12-rc1
X-PR-Tracked-Commit-Id: eda38ce482b2c88b27e3a7c8aa1ddffa646f3e7f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 143983e585073f18fbe3b7d30ed0f92cfc218cef
Message-Id: <161412338583.20258.9229173679610023018.pr-tracker-bot@kernel.org>
Date:   Tue, 23 Feb 2021 23:36:25 +0000
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The pull request you sent on Tue, 23 Feb 2021 09:45:20 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-5.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/143983e585073f18fbe3b7d30ed0f92cfc218cef

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
