Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E78C1A7A05
	for <lists+dmaengine@lfdr.de>; Wed,  4 Sep 2019 06:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbfIDEhl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 Sep 2019 00:37:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:50002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbfIDEhl (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 4 Sep 2019 00:37:41 -0400
Received: from localhost (unknown [122.182.201.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8313722CED;
        Wed,  4 Sep 2019 04:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567571861;
        bh=Y3SgjdI4eTUWwvUoaem0J4TTnC5iUZrRH8WOPdvvpp0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xFePtaN1wIDo7sT4SSHslCc3QyfQEQHite+Op3AxxXVaQ9cOP4qqukb6X/Fl9BJ8k
         pIAkYF3DY7/cxjbwipby6+PBht2SRSlcsZmrnYwF6vGtYjeiACg7l9DOMvDYU0J3Nz
         8Po2Dxu7SeCnYR1mKQfh60NzL8YgFWpRuZCewYzQ=
Date:   Wed, 4 Sep 2019 10:06:31 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH] dmaengine: ti: edma: Remove 'Assignment in if condition'
Message-ID: <20190904043631.GS2672@vkoul-mobl>
References: <20190730132006.2790-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730132006.2790-1-peter.ujfalusi@ti.com>
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
