Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A57B52E9954
	for <lists+dmaengine@lfdr.de>; Mon,  4 Jan 2021 16:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbhADP6k (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 4 Jan 2021 10:58:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:36110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727293AbhADP6k (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 4 Jan 2021 10:58:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0BA9520769;
        Mon,  4 Jan 2021 15:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609775880;
        bh=LoOOq2YendorTfy/uNCtlLdS5EtflOQg3elL8akGBGs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MnLcdZNUAbuVcy/SLnrspfYBnwQ5nV8/8v0QZf6twKG1pJ0joyU0zYfYCB3u3DFdd
         fbEd5+GYtOFDEaGtoVqDEHe8P6HLQOrB91KVwxRmD5O2WNRTmDvsF1UffE5mecHiPV
         7FwGQMyenSsdkZ9iZcGIHPznbx/1/8brfa5f+HlKhr4mD4JXKpTgkbGkom2u7gYnwH
         BV+e9n4Kc1ijqsHFKT4JCf+mTtryGlJhy+nnNuMm6qWpsRt/uMENKHuB79YsUF+cuw
         829zo95jN6mNak3S9zaQD8N4+NWO2QR4OExqIyGw1OANllw+1vfahMRi0Fl3otjIij
         0uBi62TmKHFWQ==
Date:   Mon, 4 Jan 2021 21:27:55 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        dmaengine@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Subject: Re: [PATCH 1/1] dmaengine: stm32-mdma: fix
 STM32_MDMA_VERY_HIGH_PRIORITY value
Message-ID: <20210104155755.GI120946@vkoul-mobl>
References: <20210104142045.25583-1-amelie.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210104142045.25583-1-amelie.delaunay@foss.st.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 04-01-21, 15:20, Amelie Delaunay wrote:
> STM32_MDMA_VERY_HIGH_PRIORITY is b11 not 0x11, so fix it with 0x3.

Applied, thanks

-- 
~Vinod
