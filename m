Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 363C519174C
	for <lists+dmaengine@lfdr.de>; Tue, 24 Mar 2020 18:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbgCXRPL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 Mar 2020 13:15:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:51554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727161AbgCXRPL (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 24 Mar 2020 13:15:11 -0400
Subject: Re: [GIT PULL]: dmaengine fixes for v5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585070107;
        bh=3nGwtPclZmvQxYrp54AVxAccCNjmiKHtgqLUAaLIc5A=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Y/UxV21oAigP8vdKrzLAwK6wSJH5Q3pkXbXYBjBA3JsmJNnG9vLSz0d7vLkkaSuNF
         xrr8Iq1T98z9q6wyjUtLlWWadoU57OYpyQMGgeWZy4lR+JavhLy/L2V6puzeorZrRN
         a/WTRSoPNQJc71ttSI7ko3Al46VgeETfnduLjWko=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200324054017.GU72691@vkoul-mobl>
References: <20200324054017.GU72691@vkoul-mobl>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200324054017.GU72691@vkoul-mobl>
X-PR-Tracked-Remote: git://git.infradead.org/users/vkoul/slave-dma.git
 tags/dmaengine-fix-5.6
X-PR-Tracked-Commit-Id: 018af9be3dd54e6f24f828966bdd873f4d63ad9b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c6ac7188c1142c450eb601563ad69204bf1e9286
Message-Id: <158507010775.16590.3548326940708705089.pr-tracker-bot@kernel.org>
Date:   Tue, 24 Mar 2020 17:15:07 +0000
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The pull request you sent on Tue, 24 Mar 2020 11:10:17 +0530:

> git://git.infradead.org/users/vkoul/slave-dma.git tags/dmaengine-fix-5.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c6ac7188c1142c450eb601563ad69204bf1e9286

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
