Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74B7544A673
	for <lists+dmaengine@lfdr.de>; Tue,  9 Nov 2021 06:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238225AbhKIFxe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 9 Nov 2021 00:53:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:50960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230364AbhKIFxd (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 9 Nov 2021 00:53:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id ABB45610F7;
        Tue,  9 Nov 2021 05:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636437048;
        bh=7wrdFm6RXmCeAdIpuwIhaiDDfnkWbf0prf/NE/auG6w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SWcwkwwOuRWxpUwx5oLLfgnruxI10Dj/1xdBUkCOvWtEQVVOXTkcFlencWpXw2QQL
         tsrE4ykafAy7yYPw65LaX6u3ULiwkHniVZY/P1zm0hTCY5GSdYpW9mNnnSyTAIsjQ2
         KvnDz39VlTBWnwpJC3SOr0xoNPcJVPaFvakHkCH6yjMDCb/Ar+JDkzjs3H4HL6fc1I
         HGb//Gz44Fr98Pt8SCsubaVrHOR0lLBa/o1UIXTlsd/Nac1eg7xAUvc4UWuawfRyM5
         fjg623QJQSGSW8IdBce5nHDGV1s/GSZfs8a66S/N1ExVa3uB58R/0f1/sMbfzWpROu
         RZdFu3tCZ8Kzg==
Date:   Tue, 9 Nov 2021 11:20:43 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        dmaengine@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 1/1] dmaengine: stm32-dma: avoid 64-bit division in
 stm32_dma_get_max_width
Message-ID: <YYoMM5RnQ+G7RtFw@matsya>
References: <20211103153312.41483-1-amelie.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211103153312.41483-1-amelie.delaunay@foss.st.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 03-11-21, 16:33, Amelie Delaunay wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Using the % operator on a 64-bit variable is expensive and can
> cause a link failure:
> 
> arm-linux-gnueabi-ld: drivers/dma/stm32-dma.o: in function `stm32_dma_get_max_width':
> stm32-dma.c:(.text+0x170): undefined reference to `__aeabi_uldivmod'
> arm-linux-gnueabi-ld: drivers/dma/stm32-dma.o: in function `stm32_dma_set_xfer_param':
> stm32-dma.c:(.text+0x1cd4): undefined reference to `__aeabi_uldivmod'
> 
> As we know that we just want to check the alignment in
> stm32_dma_get_max_width(), there is no need for a full division, and
> using a simple mask is a faster replacement.
> 
> Same in stm32_dma_set_xfer_param(), change this to only allow burst
> transfers if the address is a multiple of the length.
> stm32_dma_get_best_burst just after will take buf_len into account to fix
> burst in case of misalignment.

Applied, thanks

-- 
~Vinod
