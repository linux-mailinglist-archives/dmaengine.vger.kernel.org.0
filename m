Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A34B35C196
	for <lists+dmaengine@lfdr.de>; Mon, 12 Apr 2021 11:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239834AbhDLJbg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Apr 2021 05:31:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:47498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241037AbhDLJZP (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 12 Apr 2021 05:25:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 080536008E;
        Mon, 12 Apr 2021 09:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618219498;
        bh=TCBdqz9Jt9zC2Hw861Vex+DYI936M+yapiV0U4+zknY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tcwr1IFDCbgYnoWozVSWzKsaahy0JhHUG9SbeEIRNgUxMtrrMZF/BRImPv4M/Ba74
         9duWmUqccgRz9djj1TOy2G7geTarg2kbvl3PQUsl6/uWrK0eX9vn5zRY1+RM6UgzWn
         yrZyo7hykqqSFaiXdCS4wGrCpoTvJADkJQGN+ixVP+keoI/5y9jRnJcnxOoJxs+PUs
         rscSK0n/Q0I+ceXfCrnDRX3vYIFQk7Sn6NAL7iRNctwkD5zPH6FP7D3kZCf9WlogFu
         AcYd92oUSlduqGhOihtgmSCClgNIwduA5Ig+Y+HWWqVHwu2HvkBkwrME0iC7rP2sie
         SiXvCbIU3iNIw==
Date:   Mon, 12 Apr 2021 14:54:53 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Viresh Kumar <vireshk@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 1/1] dmaengine: dw: Make it dependent to HAS_IOMEM
Message-ID: <YHQR5QTzLeC8kD/i@vkoul-mobl.Dlink>
References: <20210324141757.24710-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324141757.24710-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 24-03-21, 16:17, Andy Shevchenko wrote:
> Some architectures do not provide devm_*() APIs. Hence make the driver
> dependent on HAVE_IOMEM.

Applied, thanks

-- 
~Vinod
