Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6446C17AE62
	for <lists+dmaengine@lfdr.de>; Thu,  5 Mar 2020 19:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbgCESpH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 5 Mar 2020 13:45:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:45712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726007AbgCESpG (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 5 Mar 2020 13:45:06 -0500
Subject: Re: [GIT PULL]: dmaengine fixes for v5.6-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583433906;
        bh=U0CsulG0KR9S7mXPcMNAR1Zo+aU00ZDiFT4nfyMvi38=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=GLSFagPbVOmGADE8UNHOSYNouVXpBf6aCcTyqwERp4mQv/7M005eBS8fTYAUS86Kg
         X17EfkJaoRTHxhES5OU5d6P+/gII0Y8GZ6N9SUBTF6ngaFth627bfDFK4gl87Msvam
         OaseQXlumSaoCLWW/ykKLtXO7ckkUbSJM5ynqKTI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200305084304.GY4148@vkoul-mobl>
References: <20200305084304.GY4148@vkoul-mobl>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200305084304.GY4148@vkoul-mobl>
X-PR-Tracked-Remote: git://git.infradead.org/users/vkoul/slave-dma.git
 tags/dmaengine-fix-5.6-rc5
X-PR-Tracked-Commit-Id: 25962e1a7f1d522f1b57ead2f266fab570042a70
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6fd145da21af43dd069463d83d89aefcc6675eba
Message-Id: <158343390636.15864.9207705971798256638.pr-tracker-bot@kernel.org>
Date:   Thu, 05 Mar 2020 18:45:06 +0000
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dma <dmaengine@vger.kernel.org>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The pull request you sent on Thu, 5 Mar 2020 14:13:04 +0530:

> git://git.infradead.org/users/vkoul/slave-dma.git tags/dmaengine-fix-5.6-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6fd145da21af43dd069463d83d89aefcc6675eba

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
