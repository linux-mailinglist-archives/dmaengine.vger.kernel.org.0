Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFA8A7A18
	for <lists+dmaengine@lfdr.de>; Wed,  4 Sep 2019 06:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbfIDEl4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 Sep 2019 00:41:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:50558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbfIDEl4 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 4 Sep 2019 00:41:56 -0400
Received: from localhost (unknown [122.182.201.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A30022CED;
        Wed,  4 Sep 2019 04:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567572115;
        bh=Y3SgjdI4eTUWwvUoaem0J4TTnC5iUZrRH8WOPdvvpp0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qprynB9AGH9qA25g6oG7NVhLbnrtnuUd3wQ1EMSI6lTWdifZYUGC9P3+PjwcyAzSu
         z8wlY3zIdNXnYsOFfey3c4ZnxLVsFqh80Rv1zs2BfYzUIk6YuXc3OwwSehoNCBA1DW
         zvPPY7JU5f6UyvCB0erYVoO1bbRwBb3khRt6rrjM=
Date:   Wed, 4 Sep 2019 10:10:47 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH] dmaengine: ti: omap-dma: Remove 'Assignment in if
 condition'
Message-ID: <20190904044047.GT2672@vkoul-mobl>
References: <20190730132015.2863-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730132015.2863-1-peter.ujfalusi@ti.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 30-07-19, 16:20, Peter Ujfalusi wrote:
> While the compiler does not have problem with how it is implemented,
> checkpatch does give en ERROR for this arrangement.

Applied, thanks

-- 
~Vinod
