Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8320F43E744
	for <lists+dmaengine@lfdr.de>; Thu, 28 Oct 2021 19:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbhJ1R1h (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 Oct 2021 13:27:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:43956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230256AbhJ1R1h (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 28 Oct 2021 13:27:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 469D060C40;
        Thu, 28 Oct 2021 17:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635441910;
        bh=m5tiuZ88Ar7Fi31/sLuEMKQBVQgSQxBJA/46ouGMdWc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jZKIvlEEinFgUyk/7O5PYdzSp+AkLdSIam1VbfKrIwun7bLdI5fIrrlWoxCuUOdYA
         xpBj755C6ymHqwUGXT3ouXEEN3nn8wovzhmVROslYxrASA1pKxbhRatuCZhD5dRPhw
         kmwxIvO/pJNJDjMckYWhH+WyZnWH1b5RCeiWH9wcPdv0GqqCYbztTjgso6ogNcW4bD
         luLRLHpEegmLw/Bc1jX2no81WpbtnRBaDrfDczKJnLJIGf7xohAV3H2OyDyNQjhghj
         5WWLz6YH0P0o4hEBLPMSYqs+vMJvnYC5xNvG4FfS0MZcEiY2uuJS4dgY7dzKaVN1Zu
         if4TmGWJJTH3A==
Date:   Thu, 28 Oct 2021 22:55:05 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: idxd: fix resource leak on dmaengine
 driver disable
Message-ID: <YXrc8d+FxCMzgujm@matsya>
References: <163517405099.3484556.12521975053711345244.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163517405099.3484556.12521975053711345244.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 25-10-21, 08:01, Dave Jiang wrote:
> The wq resources needs to be released before the kernel type is reset by
> __drv_disable_wq(). With dma channels unregistered and wq quiesced, all the
> wq resources for dmaengine can be freed. There is no need to wait until wq
> is disabled. With the wq->type being reset to "unknown", the driver is
> skipping the freeing of the resources.

Applied, thanks

-- 
~Vinod
