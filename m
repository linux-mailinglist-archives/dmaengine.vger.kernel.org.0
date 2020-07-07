Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE3A42165B7
	for <lists+dmaengine@lfdr.de>; Tue,  7 Jul 2020 07:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbgGGFBX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 Jul 2020 01:01:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:40932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726906AbgGGFBX (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 7 Jul 2020 01:01:23 -0400
Received: from localhost (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 193D620708;
        Tue,  7 Jul 2020 05:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594098083;
        bh=r12jwIA0OjzQxW2L6i8sHLRsffit0nNc/F9l1mb4PCc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fx08UDxpuxMg85BTKQxVyBAq/cFTBeqvLMJqMwkL5l/tryo/4MCHrIncZXFsd/pHk
         ORZRCwkXOkmvJijCaAjXk18bjqUGki9zsf1vFZ0mVSim96p6f/ZMgxn4OSK1SmYruN
         V/7Q8E+VopzbLck322rBXlKihvWLW7a9jwb5MlsA=
Date:   Tue, 7 Jul 2020 10:31:18 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: fix incorrect return value for
 dma_request_chan()
Message-ID: <20200707050118.GC676979@vkoul-mobl>
References: <159404871194.45151.3076873396834992441.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159404871194.45151.3076873396834992441.stgit@djiang5-desk3.ch.intel.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 06-07-20, 08:18, Dave Jiang wrote:
> dma_request_chan() is expected to return ERR_PTR rather than NULL. This
> triggered a crash in pl011_dma_probe() when dma_device_list is empty
> and returning NULL. Fix return of NULL ptr to ERR_PTR(-ENODEV).
> 
> Fixes: deb9541f5052 ("dmaengine: check device and channel list for empty")
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Applied after updating the correct reported to Naresh

thanks
-- 
~Vinod
