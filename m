Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC2986311
	for <lists+dmaengine@lfdr.de>; Thu,  8 Aug 2019 15:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732982AbfHHN0L (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 8 Aug 2019 09:26:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:60560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732643AbfHHN0L (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 8 Aug 2019 09:26:11 -0400
Received: from localhost (unknown [122.178.245.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B37412171F;
        Thu,  8 Aug 2019 13:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565270770;
        bh=xOthRltc9QPDcvSfY6/4aGUZsvl14aXcUqTn5d6Zb0c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wdhiSMgEUzklpKCVFzekiTPw8B+at3lhPkMlMq4SDMz7bagefPWO/3Q+YcDzoHCPg
         vY90keJnw2raAF5MHo3hox17C8WLQGi9gvALi+W9RX1r1qYdChpA4QJ93ZTn9d6Kam
         koHNlTvuUSrcY+0LQUue/knLXIFACQjNVu0A19FU=
Date:   Thu, 8 Aug 2019 18:54:56 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     dan.j.williams@intel.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, dmaengine@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma: stm32-mdma: Fix a possible null-pointer dereference
 in stm32_mdma_irq_handler()
Message-ID: <20190808132456.GA12733@vkoul-mobl.Dlink>
References: <20190729020849.17971-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729020849.17971-1-baijiaju1990@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 29-07-19, 10:08, Jia-Ju Bai wrote:
> In stm32_mdma_irq_handler(), chan is checked on line 1368.
> When chan is NULL, it is still used on line 1369:
>     dev_err(chan2dev(chan), "MDMA channel not initialized\n");
> 
> Thus, a possible null-pointer dereference may occur.
> 
> To fix this bug, "dev_dbg(mdma2dev(dmadev), ...)" is used instead.

Applied after changing subsystem name in patch title to dmaengine: ...,
Also while fixing it helps to add Fixes tag, have added

Thanks
-- 
~Vinod
