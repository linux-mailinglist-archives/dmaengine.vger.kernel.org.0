Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2B04369892
	for <lists+dmaengine@lfdr.de>; Fri, 23 Apr 2021 19:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243410AbhDWRkG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 23 Apr 2021 13:40:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:36520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243404AbhDWRkF (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 23 Apr 2021 13:40:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C91EE60232;
        Fri, 23 Apr 2021 17:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619199568;
        bh=fwcJuWKNIExUkvFFloFqUj721nVs/XArhGaxpNyiC4o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fu6KF2QVfq5vOj7jmOZA/fGT1MVcyOSJxszS0ubpGys06qLF6dgcSwz1rIQa02prb
         WOYecGE92VKD/kKpaV/nUfNlGVHo/geZG0EDyoghmVz8n5aBgQiO8rzX1RybxRwFGX
         MNQSl/gh7ekitZB1UUXXNvRt/VA0zW2flEEUezcyrIS0NeXWhXCQolQQEJ63H7QEre
         KOv/Fw7IHUi34ba5P8XyCz+rNkc3aUDc3ZkWPT5+tcOHUt2+2hp76URsh23LeXhfjU
         z+PM8966Vzo6wA+vHGQb4EMfKnfyYApf3LU6nBem0wA0NcBikkDjHZxifcZskGC2ZB
         KBE9FMiP4QLzg==
Date:   Fri, 23 Apr 2021 23:09:23 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Sanjay Kumar <sanjay.k.kumar@intel.com>, dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: device cmd should use dedicated lock
Message-ID: <YIMGSw/1SorfYm1O@vkoul-mobl.Dlink>
References: <161894525685.3210132.16160045731436382560.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161894525685.3210132.16160045731436382560.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 20-04-21, 12:00, Dave Jiang wrote:
> Create a dedicated lock for device command operations. Put the device
> command operation under finer grained locking instead of using the
> idxd->dev_lock.

Applied, thanks

-- 
~Vinod
