Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9E5F372FBE
	for <lists+dmaengine@lfdr.de>; Tue,  4 May 2021 20:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbhEDSbI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 4 May 2021 14:31:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:34166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232252AbhEDSbD (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 4 May 2021 14:31:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 3043D61164;
        Tue,  4 May 2021 18:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620153008;
        bh=WZ19CPiUvauP5vec+PmmiBjmaoX4QTxP9u3o4IH6YB4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=kM+dzKhkqrv5+N1zq6iHFIcoZsZ0BbfDp2d5IoLTXP7evpjAYgN7ZsqbQtA9mJqeH
         p132yRYdq6wFxSZ7D6ckXLp5eapPEOBLskrmIh5a6P5TX/R/ytTQ2Kkevbi8TsJ+p4
         pdbVstxSVy1WvfpRe5cWKYGV0dpfb5zOIQmFB1BjnfvnHMrL1zgNjuDuTv0/8hy1Jx
         AfjcBsDKNiFdoYMsJ4SbKCtG9vjpjd5ko8hh3nKz3eSXg88f9GLcmrijelDiZv8onY
         a9IzIrk0Pu9f/2Wc2Y9huqoEmwuN6OyT39Mm7YmEsbc8mLax3CkBIC/+AhHpl2EhF/
         p4IMXKBFcfYJw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 29CC560987;
        Tue,  4 May 2021 18:30:08 +0000 (UTC)
Subject: Re: [GIT PULL]: dmaengine updates for v5.13-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YJF4nAJ/XXY9qUuI@vkoul-mobl.Dlink>
References: <YJF4nAJ/XXY9qUuI@vkoul-mobl.Dlink>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YJF4nAJ/XXY9qUuI@vkoul-mobl.Dlink>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-5.13-rc1
X-PR-Tracked-Commit-Id: 0bde4444ec44b8e64bbd4af72fcaef58bcdbd4ce
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e4adffb8daf476a01e7b4a55f586dc8c26e81392
Message-Id: <162015300816.4220.12306215502197225721.pr-tracker-bot@kernel.org>
Date:   Tue, 04 May 2021 18:30:08 +0000
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dma <dmaengine@vger.kernel.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The pull request you sent on Tue, 4 May 2021 22:08:52 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-5.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e4adffb8daf476a01e7b4a55f586dc8c26e81392

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
