Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48FD7A7B09
	for <lists+dmaengine@lfdr.de>; Wed,  4 Sep 2019 07:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbfIDF5E (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 Sep 2019 01:57:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:52072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbfIDF5E (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 4 Sep 2019 01:57:04 -0400
Received: from localhost (unknown [122.182.201.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD2FB23400;
        Wed,  4 Sep 2019 05:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567576623;
        bh=vHzjJabvLNobLJbAo+1Q1mNco/nbArtdiV86fXt8HaE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n97BL6VG/PiUpyRJrrHJrNi8SJ1v7450/uyMdXvkaqFJ2S47p6welwcU+R6u8OViV
         1bMaGux6SPNAokx6QEGp3U4w4V6fp22ozmM2ebl7sUKNsC4U3EBLwR+qmsT+djwXWg
         9nBzebhPlFtAzd18kU+v6fZ2bhOJDKdqV+FZgFmA=
Date:   Wed, 4 Sep 2019 11:25:55 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, eric.long@unisoc.com
Subject: Re: [PATCH] dmaengine: sprd: Fix the DMA link-list configuration
Message-ID: <20190904055555.GD2672@vkoul-mobl>
References: <77868edb7aff9d5cb12ac3af8827ef2e244441a6.1567150471.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77868edb7aff9d5cb12ac3af8827ef2e244441a6.1567150471.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 30-08-19, 15:37, Baolin Wang wrote:
> For the Spreadtrum DMA link-list mode, when the DMA engine got a slave
> hardware request, which will trigger the DMA engine to load the DMA
> configuration from the link-list memory automatically. But before the
> slave hardware request, the slave will get an incorrect residue due
> to the first node used to trigger the link-list was configured as the
> last source address and destination address.
> 
> Thus we should make sure the first node was configured the start source
> address and destination address, which can fix this issue.

Applied, thanks

-- 
~Vinod
