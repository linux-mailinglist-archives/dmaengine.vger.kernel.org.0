Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4235B3D8892
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jul 2021 09:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbhG1HKG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Jul 2021 03:10:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:46982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233187AbhG1HKE (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 28 Jul 2021 03:10:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6F6A860F01;
        Wed, 28 Jul 2021 07:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627456203;
        bh=spLJJp0kWz4iiYPQWcebOS6VyUZYt/YL7QyUP4C3ddM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E0laffxtaI1HhSySNQxdxufyAYMnAPLjZQZV49FZYIXIvj3UbgqWcdon+/gFdqQ1d
         pX5PaZzNCUHW+LCm3rUShTuC03O61V6p6ipvirO1n/mZvCUwVfCLZEJTyQU8yWYFwx
         Dw+3czxSk9Q6v6chLBuzyOhVJoKTXsgBjYLGpG9M6l3AZNcxKuLoCWcLFR7jYNi8v1
         C20765URrLmDb/mFtAlq6NbLYkEELeCG1ip8XyxAzd90AG7zKHJiDdhgLqGVVbksCc
         eF50NtP4Eb7iwcnEswfGKkctd1jM0Q56vSP8NNjWB2cd2ORu65yX7S0WaTzra02rg4
         Ey9/++NCxMelA==
Date:   Wed, 28 Jul 2021 12:39:57 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pierre-Yves Mordret <pierre-yves.mordret@foss.st.com>
Subject: Re: [PATCH 0/2] STM32 DMA alternative REQ/ACK protocol support
Message-ID: <YQECxSZqa9aHw6CB@matsya>
References: <20210624093959.142265-1-amelie.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210624093959.142265-1-amelie.delaunay@foss.st.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 24-06-21, 11:39, Amelie Delaunay wrote:
> Default REQ/ACK protocol consists in maintaining ACK signal up to the
> removal of REQuest and the transfer completion.
> In case of alternative REQ/ACK protocol, ACK de-assertion does not wait the
> removal of the REQuest, but only the transfer completion.
> Due to a possible DMA stream lock when transferring data to/from STM32
> USART/UART, add support to select alternative REQ/ACK protocol.

Applied, thanks

-- 
~Vinod
