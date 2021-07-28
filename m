Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C87B33D8DC1
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jul 2021 14:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234881AbhG1M1R (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Jul 2021 08:27:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:36008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234701AbhG1M1Q (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 28 Jul 2021 08:27:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 63AA160C3E;
        Wed, 28 Jul 2021 12:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627475235;
        bh=t+nU/aT+Actj0ZQSNo7HBdq1WeJA6uNcgaqbUHluBO8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m5jt1grDmk8lAyVIWnvn9/3ut7pOzAkl7mmlhenW8bEEp7UsvSyf9eoV1YfYCDsTI
         ADKzYlyGSVFbmFEWuL95qzm7/ROnsNTq1W80QFhN04lcH203zLac/qOn6LhyuWHImP
         X9lCrYtnpL4RFjydWl4EALU5Rp6cTq7U4czW4oqgEr8GPGXSk1wHwXk8nQ6lzBsJ3B
         2D8V8O6Th/iQ9cvcoCfe05gjOHEzodqGmDibzLJ+7QaDc4zeb1M/xUjpQUi3gUex7C
         J0qFpajU2mDDnuIlyqaNG6FU+Nf9FD6m4DZW2FIMJhzTmYGE2tyA9hmXUN0l5evhx4
         Nt60q9xrhlDLg==
Date:   Wed, 28 Jul 2021 17:57:10 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: rotate portal address for better
 performance
Message-ID: <YQFNHjGoW8Ah+iv8@matsya>
References: <162681372446.1968485.10634280461681015569.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162681372446.1968485.10634280461681015569.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 20-07-21, 13:42, Dave Jiang wrote:
> The device submission portal is on a 4k page and any of those 64bit aligned
> address on the page can be used for descriptor submission. By rotating the
> offset through the 4k range and prevent successive writes to the same MMIO
> address, performance improvement is observed through testing.

Applied, thanks

-- 
~Vinod
