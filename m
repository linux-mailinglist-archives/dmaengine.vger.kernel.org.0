Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D161027D4B3
	for <lists+dmaengine@lfdr.de>; Tue, 29 Sep 2020 19:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729937AbgI2RoO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 29 Sep 2020 13:44:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:40370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728959AbgI2RoJ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 29 Sep 2020 13:44:09 -0400
Subject: Re: [GIT PULL]: dmaengine late fixes for v5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601401449;
        bh=oBSAKC0VapuxUOsH74OiAhYzijvz991BP/wJW5O2NA0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=dTJHDZ5N7gd2eS8a+Ab8jDb9I7h3rvH3g8jKfXX66KXqvwjMFgE7Z5wbR5pL8JHUB
         7SXZW16YZLg/ty4QqLiPZFl2dBGQBnv/UeemcZywM917mEq7td/gNfIMBbop0YV2Wo
         lL6vLlkGEl/b9SV47UEa3N1D7d7cXcDLEmS/VJig=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200929134443.GL2968@vkoul-mobl>
References: <20200929134443.GL2968@vkoul-mobl>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200929134443.GL2968@vkoul-mobl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-fix-5.9
X-PR-Tracked-Commit-Id: ce65d55f92a67e247f4d799e581cf9fed677871c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ccc1d052eff9f3cfe59d201263903fe1d46c79a5
Message-Id: <160140144938.29614.13358017661965830254.pr-tracker-bot@kernel.org>
Date:   Tue, 29 Sep 2020 17:44:09 +0000
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The pull request you sent on Tue, 29 Sep 2020 19:14:43 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-fix-5.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ccc1d052eff9f3cfe59d201263903fe1d46c79a5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
