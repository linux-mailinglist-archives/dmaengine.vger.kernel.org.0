Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9DC0251683
	for <lists+dmaengine@lfdr.de>; Tue, 25 Aug 2020 12:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729680AbgHYKTJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 25 Aug 2020 06:19:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:36600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729695AbgHYKTI (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 25 Aug 2020 06:19:08 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9FB82068F;
        Tue, 25 Aug 2020 10:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598350747;
        bh=5xZhSvt4U4TXbhdzmUtBM/YQjxPreSPjKWA/W5ACt+w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mK9C5XCL1V7FTP4/wWfxE4nv1SKQCF3m6NLJN9cbTyc0YTPJjUp/owdtLJxgvpN6o
         JA4AcjhckaWVfcEzhT3rLASvuVVIsKiuIsYfB8g2QIM20aBQVuBlcvOY3AHVN5D4SQ
         lWMVwaR6hnv8/7nPhxTlrQCRaAID0JD5xfDsnLLE=
Date:   Tue, 25 Aug 2020 15:49:03 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sugar Zhang <sugar.zhang@rock-chips.com>, lkp@intel.com
Subject: Re: [PATCH] dmaengine: pl330: Fix burst length if burst size is
 smaller than bus width
Message-ID: <20200825101903.GC2639@vkoul-mobl>
References: <CGME20200825064623eucas1p2d8ba8813794fe18ddd246b9a4789ed93@eucas1p2.samsung.com>
 <20200825064617.16193-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825064617.16193-1-m.szyprowski@samsung.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 25-08-20, 08:46, Marek Szyprowski wrote:
> Move the burst len fixup after setting the generic value for it. This
> finally enables the fixup introduced by commit 137bd11090d8 ("dmaengine:
> pl330: Align DMA memcpy operations to MFIFO width"), which otherwise was
> overwritten by the generic value.

Applied, thanks

-- 
~Vinod
