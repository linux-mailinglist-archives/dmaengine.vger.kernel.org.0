Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB84405D0C
	for <lists+dmaengine@lfdr.de>; Thu,  9 Sep 2021 20:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242328AbhIIS4P (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 9 Sep 2021 14:56:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:33048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242417AbhIIS4P (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 9 Sep 2021 14:56:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 60EE16113E;
        Thu,  9 Sep 2021 18:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631213705;
        bh=7SvczpszirmtlTywpIOahQEFZcqDt/yHh4r5WJTP+iY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=sKSLTgjM4SfZ4L1no6e2a+6Xu2kAokeqpFTXkS7T+Tvsty2f+9WW7B5wFrrNM3Lg8
         6qcyCwQterTWsFWYmfjNJShuY3zS8Yu2zrfQrwRgmNRxYURjFpghA+NmINzxYlWpjw
         folWjYJrCxvz6J1ssHv0UQ0lShyYb0qtlh9mmkCSvbRzbk2i0uGBPOprGy/wRIauHr
         MGZJ1wObO5Lobh4m2jmlb4CMUQ0WJrKiokwIMA5RkVf8hY7CvNa6E9fAmJPdv4xVAd
         nDOsCpeYXlYoCXehoiNOuCk5OsEBnMqOKZqrvHgRO6DARlknTxvhnfwu1foCPyMeOh
         4CYa4RFwsuTUA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 5934E60978;
        Thu,  9 Sep 2021 18:55:05 +0000 (UTC)
Subject: Re: [GIT PULL]: dmaengine updates for v5.15-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YTg+csY9wy4mk035@matsya>
References: <YTg+csY9wy4mk035@matsya>
X-PR-Tracked-List-Id: <dmaengine.vger.kernel.org>
X-PR-Tracked-Message-Id: <YTg+csY9wy4mk035@matsya>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-5.15-rc1
X-PR-Tracked-Commit-Id: 11a427be2c4749954e8b868ef5301dc65ca5a14b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0aa2516017123a7c35a2c0c35c4dc7727579b8a3
Message-Id: <163121370535.14164.16687061404078666435.pr-tracker-bot@kernel.org>
Date:   Thu, 09 Sep 2021 18:55:05 +0000
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The pull request you sent on Wed, 8 Sep 2021 10:09:14 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-5.15-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0aa2516017123a7c35a2c0c35c4dc7727579b8a3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
