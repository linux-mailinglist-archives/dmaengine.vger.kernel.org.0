Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8853AA0DA
	for <lists+dmaengine@lfdr.de>; Wed, 16 Jun 2021 18:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234511AbhFPQJK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 16 Jun 2021 12:09:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:35138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234603AbhFPQJG (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 16 Jun 2021 12:09:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id E2646610A0;
        Wed, 16 Jun 2021 16:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623859619;
        bh=MfLY5pA8NkxXhmHUzct5mKaHg2b+WWu8jg9BXogUvVc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=g1anxOxyIGTp8kvhE5ti9opBJP/bsTz9F+zjIdH7AOYjfJdke6TIMQ7EzUAeILwpT
         6Zu6kMuSaYX6CeO39IlzU+cys+SnwtZNBhsXYi2h4v5RuaqdkjMUeTe9fVMVxFg9A1
         +OHrWJ8FeMZ3NF4V3egrAZ4noAdCcrGig9wQaCgPtxUgz8O8U/rqM8U4uFWIRlhh1N
         sKzhhyf2R3P7vOpExK4ceOPQhH+yYkre6j+EBSUsUFeGd0iFZq1RuL2v7TS9EJJXBe
         iHluQMLGk5EqDuw7crEowCrJ3iA2XL17HOKbRUd9KxJSgaCA/1Ot34kSJzemKNNAyj
         aYI4Chko6Wxdg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id CE0AF60953;
        Wed, 16 Jun 2021 16:06:59 +0000 (UTC)
Subject: Re: [GIT PULL]: dmaengine fixes for v5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YMn1xTAqhOUI5sle@vkoul-mobl>
References: <YMn1xTAqhOUI5sle@vkoul-mobl>
X-PR-Tracked-List-Id: <dmaengine.vger.kernel.org>
X-PR-Tracked-Message-Id: <YMn1xTAqhOUI5sle@vkoul-mobl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-fix-5.13
X-PR-Tracked-Commit-Id: 9041575348b21ade1fb74d790f1aac85d68198c7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6b00bc639f1f2beeff3595e1bab9faaa51d23b01
Message-Id: <162385961978.26862.12670467491333586773.pr-tracker-bot@kernel.org>
Date:   Wed, 16 Jun 2021 16:06:59 +0000
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The pull request you sent on Wed, 16 Jun 2021 18:29:49 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-fix-5.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6b00bc639f1f2beeff3595e1bab9faaa51d23b01

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
