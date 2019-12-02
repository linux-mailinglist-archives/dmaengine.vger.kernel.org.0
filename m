Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 793F710F1DD
	for <lists+dmaengine@lfdr.de>; Mon,  2 Dec 2019 22:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbfLBVFU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 2 Dec 2019 16:05:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:56776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727212AbfLBVFT (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 2 Dec 2019 16:05:19 -0500
Subject: Re: [GIT PULL] dmaengine updates for v5.5-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575320719;
        bh=M8y4k1y9+hBPi3gj1puk33RqQ5WoOhvNGW3a89HQ9Tc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ubel3Tp1KHxP+xtQu0kOS7ji/3RUyO+nIEk+bBy8zZqlZ31+RNliiv6sT2xEloC17
         FXzPZg7UCs+SNf4T1kDUcDdnZ5PEU7I9FkpmI8x7q65fkcbMM4k3QVrc/qZ81HJFOu
         FuuYapAnPTmdL/La4tdYuuDv2pONHSSuGwk1KZuU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191129051819.GX82508@vkoul-mobl>
References: <20191129051819.GX82508@vkoul-mobl>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191129051819.GX82508@vkoul-mobl>
X-PR-Tracked-Remote: git://git.infradead.org/users/vkoul/slave-dma.git
 tags/dmaengine-5.5-rc1
X-PR-Tracked-Commit-Id: 67805a4b3c924927d9e064bca235461941f89e4a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a5255bc31673c72e264d837cd13cd3085d72cb58
Message-Id: <157532071913.29263.14219210881756670730.pr-tracker-bot@kernel.org>
Date:   Mon, 02 Dec 2019 21:05:19 +0000
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The pull request you sent on Fri, 29 Nov 2019 10:48:19 +0530:

> git://git.infradead.org/users/vkoul/slave-dma.git tags/dmaengine-5.5-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a5255bc31673c72e264d837cd13cd3085d72cb58

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
