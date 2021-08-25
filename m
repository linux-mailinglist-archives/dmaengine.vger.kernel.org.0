Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC6A73F745F
	for <lists+dmaengine@lfdr.de>; Wed, 25 Aug 2021 13:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239022AbhHYLbn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 25 Aug 2021 07:31:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:60730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232304AbhHYLbl (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 25 Aug 2021 07:31:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 55F9D610E8;
        Wed, 25 Aug 2021 11:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629891056;
        bh=JcZZLBdpO8qUcwhRFW/lAWPV8tm/6SN6LluqohSw/Ig=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DLsG8XEmXdhQ5iEe5gmztJ+RmELEms+Jb3iBa5qm5JicHMS4frumDb0xdT8mquC2n
         n2PLRAuj1c1l2lRKYJVsZ93plA5Hq52sSAUMysTrf0fu/8RKKeJ2k/RJwmRMNE+WnV
         dDYS3zDfIx29FUfMC4IywSmEqJxM2CKhQT2U//WrYAq+BUHiZrEc1aZGkUEke1F3cl
         n9HOEYCwWu+P2AN/+x67Yy/dOEq8rejxQQJZqQycetgExV8WyHnSU70Reb9WiFLc5r
         j9KsCJwpDbEkpmr2D+SI/7G2j1IzlsTMID6Z6K8CmZCh4EVrYxrFYEyE9PQ5B1A0hu
         rEUfOEx3rMbEQ==
Date:   Wed, 25 Aug 2021 17:00:52 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: set descriptor allocation size to
 threshold for swq
Message-ID: <YSYp7EPdWJXQb0Ab@matsya>
References: <162827151733.3459223.3829837172226042408.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162827151733.3459223.3829837172226042408.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 06-08-21, 10:38, Dave Jiang wrote:
> Since submission is sent to limited portal, the actual wq size for shared
> wq is set by the threshold rather than the wq size. When the wq type is
> shared, set the allocated descriptors to the threshold.

Applied, thanks

-- 
~Vinod
