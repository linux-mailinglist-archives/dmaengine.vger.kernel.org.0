Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1C9395451
	for <lists+dmaengine@lfdr.de>; Mon, 31 May 2021 06:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbhEaEKA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 May 2021 00:10:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:56794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229471AbhEaEJ7 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 31 May 2021 00:09:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 94085611CA;
        Mon, 31 May 2021 04:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622434099;
        bh=louUzdPLVIYhYNoA/nrGNy48FfajCJNyOsQ9+ZzUtqg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cghkyJiugnmLA89Iu4xI53c4rx4/J8AQHTqb94NekWPhNYdUhbV7ZwIGxV2kqPRj4
         U5U9qiESiaQLsfKxhSuHRv6cQg4+6G0m/eUaFEdThleBridgLwYMqhkZuWh8NxoYVp
         SK0zCKFpZfMl1uF0RjT0cxixXtKFHlzQK2NJRtxjj4Hw1KDmnvJ1++/l0HSBAMfddj
         Jjdah/mfgLmOPV9uduUygJS16Dx5WK2PfB4GOSeq+vdptl2DSoiTqvZl8KVh57H+1L
         XUaY5k6qMweAtqTilRA4KRzLkUoUzFnteu6aqf/2jhYI5I8YoJlZ15r+UkkDJaX8pS
         yyOfcNgN5V2Xw==
Date:   Mon, 31 May 2021 09:38:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     dmaengine@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>,
        Jianqiang Chen <jianqian@xilinx.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/4] dmaengine: xilinx: dpdma: Fix freeze after 64k frames
Message-ID: <YLRhLx69o2L+Ugrw@vkoul-mobl.Dlink>
References: <20210520152420.23986-1-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210520152420.23986-1-laurent.pinchart@ideasonboard.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 20-05-21, 18:24, Laurent Pinchart wrote:
> Hello,
> 
> This patch series addresses an issue in the Xilixn ZynqMP DPDMA driver
> that causes a display freeze after 65536 frames. The first three patches
> include a small compilation breakage issue (1/4) and enhancements to the
> messages logged by the driver (2/4 and 3/4). The last patch fixes the
> freeze bug. Please see individual patches for details.

Applied, thanks

While at it please keep fixes at the top of the series, easier to apply
to fixes rather than next

Thanks
-- 
~Vinod
