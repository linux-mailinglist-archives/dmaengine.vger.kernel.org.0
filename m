Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04E1016B942
	for <lists+dmaengine@lfdr.de>; Tue, 25 Feb 2020 06:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgBYFpT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 25 Feb 2020 00:45:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:37124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726019AbgBYFpT (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 25 Feb 2020 00:45:19 -0500
Received: from localhost (unknown [122.167.120.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 421E2222C2;
        Tue, 25 Feb 2020 05:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582609519;
        bh=j47OslZ9784bwULG/PPlCt7joegvFmVDiWVpyxhkBOo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GMw66R3/uvqjEjYGCq2fhzTOA1W2l6ouvKd+EQSx4Zj472u9nMo+0nEKWCsAHdkWT
         7ccU6etf4Zy7O3d3E8Psqsc3YajJkmx2m9AP0PoRpYUCbJFybI2muZOQ2DhMBTu7np
         zr3YDDKZkWx2d9lbYmIt1G2f134h89TdhzXFIXsY=
Date:   Tue, 25 Feb 2020 11:15:14 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Amelie Delaunay <amelie.delaunay@st.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        dmaengine@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Subject: Re: [PATCH 0/8] STM32 DMA driver fixes and improvements
Message-ID: <20200225054514.GG2618@vkoul-mobl>
References: <20200129153628.29329-1-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200129153628.29329-1-amelie.delaunay@st.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 29-01-20, 16:36, Amelie Delaunay wrote:
> This series brings improvements to the STM32 DMA driver, with support of
> power management and descriptor reuse. Probe function gets a cleanup and
> properties like copy_align and max_segment_size are set.
> A "sleeping function called from invalid context" bug is also fixed. And
> to avoid a race with vchan_complete, driver now adopts
> vchan_terminate_vdesc().

Applied, thanks

-- 
~Vinod
