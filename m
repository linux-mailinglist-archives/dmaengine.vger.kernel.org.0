Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C15C016AC21
	for <lists+dmaengine@lfdr.de>; Mon, 24 Feb 2020 17:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbgBXQuR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 24 Feb 2020 11:50:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:49724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727177AbgBXQuQ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 24 Feb 2020 11:50:16 -0500
Received: from localhost (unknown [122.182.199.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74E0F20637;
        Mon, 24 Feb 2020 16:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582563016;
        bh=GUn4MNd/CYw0+WpEjK/beMt3O/nBhBrB0RzoGtzcI8E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JF4umC8CRxfeuYkpdniHpcft7/Jjj5SFyBNEyJJI0OQX2Vtn6yqOvqNnG1KebGkyu
         UwBybDebLapoJuPaZ5eh9raqocKdq8+ey1hVmwZQdZneolm3YIGA8FLPGBtEfrtdDk
         Rrfh/v71QseZ5QGSxWrsF3XHXXjWedXhOm7hbA8A=
Date:   Mon, 24 Feb 2020 22:20:12 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Amelie Delaunay <amelie.delaunay@st.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        dmaengine@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Subject: Re: [PATCH 0/6] STM32 MDMA driver fixes and improvements
Message-ID: <20200224165012.GB2618@vkoul-mobl>
References: <20200127085334.13163-1-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200127085334.13163-1-amelie.delaunay@st.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 27-01-20, 09:53, Amelie Delaunay wrote:
> This series brings improvements to the MDMA driver, with support of power
> management and descriptor reuse. Probe function gets a cleanup and to avoid
> a race with vchan_complete, driver now adopts vchan_terminate_vdesc().

Applied, thanks

-- 
~Vinod
