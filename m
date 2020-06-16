Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E861E1FBBB6
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jun 2020 18:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730423AbgFPQ2q (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 16 Jun 2020 12:28:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:57920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730400AbgFPQ2o (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 16 Jun 2020 12:28:44 -0400
Received: from localhost (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC7182067B;
        Tue, 16 Jun 2020 16:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592324923;
        bh=29jFwKiIIgqZkXKr2IfJ+hG/0Vn3NzY1TO01FO8yPws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GK42u53HxtCS48AnVFNjsjHVgXNdS/ChuuU3AXmX170K4L889xg89QO/sEWeHZXt1
         tpDGkCre0XK2OwUBTRlNVFi7zngVxO1qz/ZSRpfkgEDnliVQ/7eG2l4sUBc9FrJux6
         lt3Zvl7geXfaz+8r7ZuJ3rSpTeK0qaoAKlPATZIg=
Date:   Tue, 16 Jun 2020 21:58:39 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] dmaengine: mmp_tdma: share the IRQ line
Message-ID: <20200616162839.GL2324254@vkoul-mobl>
References: <20200601192252.172773-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200601192252.172773-1-lkundrak@v3.sk>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 01-06-20, 21:22, Lubomir Rintel wrote:
> On a MMP2, the DMA interrupt is shared by all channels of the peripheral
> DMA controller and the audio DMA controller. Both drivers can identify
> their interrupts, but only the PDMA driver marks the line shared:
> 
>   [    1.185782] mmp-pdma d4000000.dma: initialized 16 channels
>   [    1.186808] mmp-tdma d42a0800.adma: IRQ index 1 not found
>   [    1.194317] genirq: Flags mismatch irq 64. 00000000 (tdma) vs. 00000080 (pdma)
>   [    1.197894] mmp-tdma: probe of d42a0800.adma failed with error -16
> 
> Let's turn on IRQF_SHARED in the ADMA driver as well.

Applied, thanks

-- 
~Vinod
