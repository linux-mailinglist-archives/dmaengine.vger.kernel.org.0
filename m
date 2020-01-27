Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C02114AA49
	for <lists+dmaengine@lfdr.de>; Mon, 27 Jan 2020 20:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbgA0TPI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Jan 2020 14:15:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:48738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729159AbgA0TPH (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 27 Jan 2020 14:15:07 -0500
Subject: Re: [GIT PULL]: dmaengine updates for v5.6-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580152507;
        bh=d6PDGyoZupDhjEjLM9gB+lbi2WUqJj0VApiJBLR8Z+I=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=IukIQtWim8d120obvFjCBMczPM3c79jF81mmb+jy+0ni3EFgVpqa4qWeDFV2Mqe8a
         Lr4spQEdRZoMWzn2gYelC9tPuqkbG4g4R6Ynk2XExkmh8OwukaIWfPbKPfhGu0m407
         bWda1Iq5SRVH0aH3U8hRShU6AVknmJoFoLLAhtTE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200127145835.GI2841@vkoul-mobl>
References: <20200127145835.GI2841@vkoul-mobl>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200127145835.GI2841@vkoul-mobl>
X-PR-Tracked-Remote: git://git.infradead.org/users/vkoul/slave-dma.git
 tags/dmaengine-5.6-rc1
X-PR-Tracked-Commit-Id: 71723a96b8b1367fefc18f60025dae792477d602
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a5b871c91d470326eed3ae0ebd2fc07f3aee9050
Message-Id: <158015250749.1024.11601911779192777243.pr-tracker-bot@kernel.org>
Date:   Mon, 27 Jan 2020 19:15:07 +0000
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The pull request you sent on Mon, 27 Jan 2020 20:28:35 +0530:

> git://git.infradead.org/users/vkoul/slave-dma.git tags/dmaengine-5.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a5b871c91d470326eed3ae0ebd2fc07f3aee9050

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
