Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 343B4245BD3
	for <lists+dmaengine@lfdr.de>; Mon, 17 Aug 2020 07:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbgHQFOF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 17 Aug 2020 01:14:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:43156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbgHQFOF (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 17 Aug 2020 01:14:05 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDA2A2072E;
        Mon, 17 Aug 2020 05:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597641244;
        bh=77Rm1fGtPTOXYyKtAN3oFCpTJOZdKNpRD/Ale7YoeX0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nu+PLLbTsUgZAKnti/ShRTe4i+RlzLnX5fZLv1S+/hnvVoxG2+oCM0CMhYQ75LFvV
         Snu8X9YZZwVY+mk4kYrwDJt0hFJzj7VZfHcFAVJZvyxb3vfiSDayg5zLjX5jWHaMxa
         Enq7YPfeeRp+pwvPO2Zs76QOXpwr2RIY/KSpZDHg=
Date:   Mon, 17 Aug 2020 10:43:59 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: ti: omap-dma: Drop of_match_ptr to fix
 -Wunused-const-variable
Message-ID: <20200817051359.GE2639@vkoul-mobl>
References: <20200728170939.28278-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728170939.28278-1-krzk@kernel.org>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 28-07-20, 19:09, Krzysztof Kozlowski wrote:
> The of_device_id is included unconditionally by of.h header and used
> in the driver as well.  Remove of_match_ptr to fix W=1 compile test
> warning with !CONFIG_OF:
> 
>     drivers/dma/ti/omap-dma.c:1892:34: warning: 'omap_dma_match' defined but not used [-Wunused-const-variable=]
>      1892 | static const struct of_device_id omap_dma_match[] = {

Applied, thanks

-- 
~Vinod
