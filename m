Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3E6D5A7F
	for <lists+dmaengine@lfdr.de>; Mon, 14 Oct 2019 07:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbfJNFDT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 14 Oct 2019 01:03:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:42994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbfJNFDT (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 14 Oct 2019 01:03:19 -0400
Received: from localhost (unknown [122.167.124.160])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 088582083B;
        Mon, 14 Oct 2019 05:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571029398;
        bh=mS3CctfHD5469kRjRuKvd4vU4oRhuSk3zV0oFGa4ofA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VbJ9AGyAQP8GZ230tH1AG7Q+XwfKF/s5qTtLar9YnWluOrL9C77A7pwWqlTaLufPc
         VlYpkRbD+uJaciceRpH7QjnUAvITd67hF44RNJBmyfaCxG5VwjOI9YsQI3jCcouyF5
         jb1S7qh+8XUws3v6TYsdGvS4K6pD/iIA9pvUV6pk=
Date:   Mon, 14 Oct 2019 10:33:13 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, eric.long@unisoc.com,
        zhenfang.wang@unisoc.com
Subject: Re: [PATCH] dmaengine: sprd: Fix the link-list pointer register
 configuration issue
Message-ID: <20191014050313.GG27950@vkoul-mobl>
References: <eadfe9295499efa003e1c344e67e2890f9d1d780.1568267061.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eadfe9295499efa003e1c344e67e2890f9d1d780.1568267061.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 12-09-19, 13:47, Baolin Wang wrote:
> From: Zhenfang Wang <zhenfang.wang@unisoc.com>
> 
> We will set the link-list pointer register point to next link-list
> configuration's physical address, which can load DMA configuration
> from the link-list node automatically.
> 
> But the link-list node's physical address can be larger than 32bits,
> and now Spreadtrum DMA driver only supports 32bits physical address,
> which may cause loading a incorrect DMA configuration when starting
> the link-list transfer mode. According to the DMA datasheet, we can
> use SRC_BLK_STEP register (bit28 - bit31) to save the high bits of the
> link-list node's physical address to fix this issue.

Applied, thanks

-- 
~Vinod
