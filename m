Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0883C3DD0CA
	for <lists+dmaengine@lfdr.de>; Mon,  2 Aug 2021 08:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbhHBGvs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 2 Aug 2021 02:51:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:47050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229734AbhHBGvr (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 2 Aug 2021 02:51:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1098160F5A;
        Mon,  2 Aug 2021 06:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627887098;
        bh=m1Kt0QP09U7GzNUAEizvJUrlr2fNMArG/kHdGMKQJfc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kMKSTPypgktYtbcMdQg9duXmYifOWPBBhT0W3Y7rrL0V7c04Emqpwjsuxs41qU67Q
         dKhG707vip0QzyT9FwC+kBoHwd2ZhxAm7N3+n47ahnNeShCGhTLu2PjMQW2NV8Waj9
         4gfWRKztHK0lLMGPgB3WAZkKbKhLHpo+OgevKAJw7FWA7+hRz6BTPRFXfH825FtcZZ
         brQ1efQRlZ7htz6u/HD6rEDITOkxW3269inuZc7IXKYOvUjvVKU0n9pf3zjQ1XOHu5
         BRIziDAcbAYuTnRSTS6b+lnI+vDpzwItRomjg+PGvtRKcR0omoe5I+WEi6B11RPzfl
         lq4LNNCgnMzgQ==
Date:   Mon, 2 Aug 2021 12:21:34 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] dmaengine: acpi: Avoid comparison GSI with Linux
 vIRQ
Message-ID: <YQeV9ozxgFMAsUln@matsya>
References: <20210730202715.24375-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210730202715.24375-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 30-07-21, 23:27, Andy Shevchenko wrote:
> Currently the CRST parsing relies on the fact that on most of x86 devices
> the IRQ mapping is 1:1 with Linux vIRQ. However, it may be not true for
> some. Fix this by converting GSI to Linux vIRQ before checking it.

Applied, thanks

-- 
~Vinod
