Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFB9B2DFDF5
	for <lists+dmaengine@lfdr.de>; Mon, 21 Dec 2020 17:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725780AbgLUQWu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 21 Dec 2020 11:22:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:49442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725777AbgLUQWu (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 21 Dec 2020 11:22:50 -0500
Date:   Mon, 21 Dec 2020 21:52:04 +0530
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608567729;
        bh=c5e9kv2CWQ7bd+h1GL/uiMtw0E7B4lFHSg2MPCHNceI=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=UVsah/RoAPbt38ekKKumayJX+d4O7brSnagL4TInafSpFBt/9Bkgvbur1S9CQU3yU
         WCzzlnzF4dWSgK/nLcVFFvkPvANn20X9v5QNfZKGDFGH5gvyvuhOoBotQd3B8EJfG9
         TLTyWUVh2Bri0WDlu+ysTVKcaFJNeCWJOaRkXtE0U2H7OvqvKjmy8p/CSA5BezDpQX
         Jku4owEsBlAxrP8obE4WMrknmL7ONKwouZWb8zbmjV7lG+xvshNtP6gae3i4ehA2k8
         BR/Mdk4bhbz30OKSXOJpwU77GQrQNuuLFCdoZnR66CEMta2GbmLHWvD4uPq7lDmLV/
         P/vcfrZWRL1Ww==
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, vigneshr@ti.com,
        grygorii.strashko@ti.com
Subject: Re: [PATCH] dmaengine: ti: k3-udma: Fix pktdma rchan TPL level setup
Message-ID: <20201221162204.GG3323@vkoul-mobl>
References: <20201216154833.20821-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201216154833.20821-1-peter.ujfalusi@ti.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 16-12-20, 17:48, Peter Ujfalusi wrote:
> Instead of initializing the rchan_tpl the initial commit re-initialized
> the tchan_tpl.

Applied, thanks

-- 
~Vinod
