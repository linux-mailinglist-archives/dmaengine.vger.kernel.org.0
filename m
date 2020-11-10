Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEE312AD694
	for <lists+dmaengine@lfdr.de>; Tue, 10 Nov 2020 13:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgKJMpE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 Nov 2020 07:45:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:38274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726462AbgKJMpE (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 10 Nov 2020 07:45:04 -0500
Received: from localhost (unknown [122.179.121.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2352120781;
        Tue, 10 Nov 2020 12:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605012304;
        bh=6clsNc7To2+8MGKmzfoTX+VHpQ16flF8HOSXruyAiJU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RSE5xZWmbqmEPdbCulM/SBS59fmwaY06BEO69+J4ZTWBb1i+crYPPuGF7UG1e7/gu
         Myd0yUubkKpfH49Q+1vZ8Wf8QA6ct0JGZIA3NpOFS8+nxGlOag/lrCCu/YsoKxchkj
         mYzUhqHlek1Qk8QvqHgJde6jOfGVxRA9XkWLCy9U=
Date:   Tue, 10 Nov 2020 18:14:59 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     linux-omap@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] dmaengine: ti: omap-dma: Block PM if SDMA is busy to fix
 audio
Message-ID: <20201110124459.GA161013@vkoul-mobl>
References: <20201109154013.11950-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201109154013.11950-1-tony@atomide.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 09-11-20, 17:40, Tony Lindgren wrote:
> We now use cpu_pm for saving and restoring device context for deeper SoC
> idle states. But for omap3, we must also block idle if SDMA is busy.
> 
> If we don't block idle when SDMA is busy, we eventually end up saving and
> restoring SDMA register state on PER domain idle while SDMA is active and
> that causes at least audio playback to fail.


Grabbed the patch with b4 and looks good, so applied now

-- 
~Vinod
