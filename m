Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D85C438ED4
	for <lists+dmaengine@lfdr.de>; Mon, 25 Oct 2021 07:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbhJYFcG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 Oct 2021 01:32:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:34858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230030AbhJYFcD (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 25 Oct 2021 01:32:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C48660E96;
        Mon, 25 Oct 2021 05:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635139782;
        bh=7jzXzbilTsgAdsDDAasWdFYeY43wzm/4G7JHSQp2gpM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qe1/6C2jsbpZ4bAoRtTWN3R21loX6jRSWch7i6U5gtAmTHbAZYCQuvdViV8oHlTAg
         T4xSY5c5P0ytLbd9fidtKRtLwnokybBBR7W17eRy9wSUI1XhSGk5aBiHWDDzbbBRGs
         W8hwtDaRG866wqUU6Z+wIsteOJTtEdQJR23+LfRAQsoLeoHVet/H5acP/99x3QyN+m
         skBbt1VK/7xkG0x9Qo9rFNdTQBb3nUSu6SKHTzty+RrHZGwfcjaDxcBxGAjoZ/hkyJ
         n5LGWQxoS4nqOdLHWAMFvwKsasCH0+F2qK7J2pfjTCNN09k+C6LDkBclSgB8PCpjyx
         9+pcZp7eldJ+g==
Date:   Mon, 25 Oct 2021 10:59:37 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: fix resource leak on dmaengine driver
 disable
Message-ID: <YXZAwQyfjk+WFUmR@matsya>
References: <163467611628.2417298.12883771242741055128.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163467611628.2417298.12883771242741055128.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 19-10-21, 13:41, Dave Jiang wrote:
> The wq resources needs to be released before the kernel type is reset by
> __drv_disable_wq(). With dma channels unregistered and wq quiesced, all the
> wq resources for dmaengine can be freed. There is no need to wait until wq
> is disabled. With the wq->type being reset to "unknown", the driver is
> skipping the freeing of the resources.

Doesnt apply, i guess needs rebase

-- 
~Vinod
