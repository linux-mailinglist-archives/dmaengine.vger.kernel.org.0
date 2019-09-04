Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5C8A7A1B
	for <lists+dmaengine@lfdr.de>; Wed,  4 Sep 2019 06:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbfIDEmd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 Sep 2019 00:42:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:50720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbfIDEmd (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 4 Sep 2019 00:42:33 -0400
Received: from localhost (unknown [122.182.201.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5B8322CED;
        Wed,  4 Sep 2019 04:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567572152;
        bh=m4F5Q8UfN0GHnykOXwLzKXVq4D8Xmr2BgfunVwAekLA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p9N+ebYnuInXthVBf8+7lSgEarA1XZzh3V5v07ou3zmIu2gSHGfzwfR5q8iyaQ90t
         HWtL/vfegjydUewdmaYFzLv8Sa2lxMKKadKoipkNbt1sEdg8o62krINQlB8QMroGOh
         /TbNsE3tj9o2cXlUGA3sqEs0eRapN+C2uVvTqPKI=
Date:   Wed, 4 Sep 2019 10:11:24 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH] dmaengine: ti: omap-dma: Remove variable override in
 omap_dma_tx_status()
Message-ID: <20190904044124.GU2672@vkoul-mobl>
References: <20190730132029.2971-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730132029.2971-1-peter.ujfalusi@ti.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 30-07-19, 16:20, Peter Ujfalusi wrote:
> There is no need to fetch local omap_desc since the desc we have is the
> correct one already when we need to check the channel status.

Applied, thanks

-- 
~Vinod
