Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB0D246F3
	for <lists+dmaengine@lfdr.de>; Tue, 21 May 2019 06:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbfEUEjh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 May 2019 00:39:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:47032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726042AbfEUEjh (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 21 May 2019 00:39:37 -0400
Received: from localhost (unknown [106.201.107.13])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9148421743;
        Tue, 21 May 2019 04:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558413577;
        bh=H7+dKgf9U1QiGInh5iVvhafZtmO+M7kgnQMPzeqYjo0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KeQBu1tCKZLQG+03G9UbFYtHR9NW57lVMYWf7MPGLME2MSubFvEPCE14TsGk1cspd
         UGbdrXn/HEK1itT+UUVcGh51pJ9CQTO1Po6yIQ023X1hX8fVV4TgjPlB1mw5rCY31s
         hiUQ5/0VdmXfoL2hngULJKfmlbitS2/7OvEhCrQs=
Date:   Tue, 21 May 2019 10:09:33 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Amelie Delaunay <amelie.delaunay@st.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        dmaengine@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: stm32-dma: Fix redundant call to
 platform_get_irq
Message-ID: <20190521043933.GO15118@vkoul-mobl>
References: <1557215681-18541-1-git-send-email-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557215681-18541-1-git-send-email-amelie.delaunay@st.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 07-05-19, 09:54, Amelie Delaunay wrote:
> Commit c6504be53972 ("dmaengine: stm32-dma: Fix unsigned variable compared
> with zero") duplicated the call to platform_get_irq.
> So remove the first call to platform_get_irq.

Applied, thanks

-- 
~Vinod
