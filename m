Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 635C34310C0
	for <lists+dmaengine@lfdr.de>; Mon, 18 Oct 2021 08:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbhJRGpP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 18 Oct 2021 02:45:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:51374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229847AbhJRGpP (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 18 Oct 2021 02:45:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BB27C608FE;
        Mon, 18 Oct 2021 06:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634539384;
        bh=HvA7sdtODjF605T2AShplSQpt01oLgTaIN5yUBN0Hn0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S/lwuF9vxQ4Pf/KlvCkqhisJ81nzGcwbB5Nng2HvyV+7ePw48c7mw2sYpUZQXKkE4
         EGHlbnXGR28vzSXt/KOQ2CpamAjI4WDXdweFqB6pSXrTIDsPStFkmb7LW4K2WDDwPF
         H/ftDwem1GQM/BxwfilDarMmlkFejJdRGUvmNzg1d5nRR1GW8wDf8aUbohDgbk94Bj
         dQMIQ+YtOIcWBKED5CqKzudlM+umDi32PLrzCBZ/c6xCW2yCCVxEev1Tz3lfVNpaBU
         E7r1BnHsD/f61lnKyyDJt0ab3JeZAic7rWoNnPGbpDKjsnDlQ5wtouJLJhqarVpfUw
         Su/dKfmzKbsRQ==
Date:   Mon, 18 Oct 2021 12:13:00 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        dmaengine@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pierre-Yves Mordret <pierre-yves.mordret@foss.st.com>
Subject: Re: [PATCH 0/3] dmaengine: stm32-dma: some corner case fixes
Message-ID: <YW0XdFbiZztiJ8EN@matsya>
References: <20211011094259.315023-1-amelie.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211011094259.315023-1-amelie.delaunay@foss.st.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 11-10-21, 11:42, Amelie Delaunay wrote:
> This patchset brings some fixes to STM32 DMA driver.
> It fixes undefined behaviour of STM32 DMA controller when an unaligned address
> is used.
> It also prevents accidental repeated completion using dma_cookie_complete() in
> terminate_all().

Applied, thanks

-- 
~Vinod
