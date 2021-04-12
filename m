Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7C035C0F7
	for <lists+dmaengine@lfdr.de>; Mon, 12 Apr 2021 11:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239871AbhDLJSd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Apr 2021 05:18:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:40644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241507AbhDLJQ2 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 12 Apr 2021 05:16:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4CB766008E;
        Mon, 12 Apr 2021 09:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618218969;
        bh=RMjnwYaxOGyngT25MepYQNBhYrijY6vI/bc9pvaqH/o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J2rR4C6I8vLpprKl1KFFv04TjKCarvcoSmx0hO3rsKil9crLqPOZ/HnYcSJokwLGm
         Ss1u18mX3Lm1dvjTx+yC7Md8UxxNKoZI8XxGYrRgjVAFCHz9i2o48uAF77XWMiPNFz
         bHkUR47g4Y2E6eU7zhAI/VI38vwx0Tw1/dTWl5ekLq5cGcuhT6PE5c5wldn1cLUyVl
         ezC+xCw9uaJNRZcEFJ1HqHah7kdzb/tTt0wjxDWILnJX/qOh1soqOcIpANhFLPRT0I
         n4lLC/hMV9afi4G8Zq9LK3+QZY5ZQV2+xNf2Tk4vVBHeTZ+rVGAxUG76viy+KxJtzj
         USyjRa9azfY4Q==
Date:   Mon, 12 Apr 2021 14:46:04 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: clear MSIX permission entry on shutdown
Message-ID: <YHQP1JRc/EOYkK2P@vkoul-mobl.Dlink>
References: <161782552272.107458.7071922172526550640.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161782552272.107458.7071922172526550640.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 07-04-21, 12:58, Dave Jiang wrote:
> Add disabling/clearing of MSIX permission entries on device shutdown to
> mirror the enabling of the MSIX entries on probe. Current code left the
> MSIX enabled and the pasid entries still programmed at device shutdown.

This fails to apply for me

-- 
~Vinod
