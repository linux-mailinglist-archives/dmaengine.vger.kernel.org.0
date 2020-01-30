Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC00414D773
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jan 2020 09:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgA3IZI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 30 Jan 2020 03:25:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:54734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726464AbgA3IZI (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 30 Jan 2020 03:25:08 -0500
Received: from localhost (unknown [117.99.87.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2739206D5;
        Thu, 30 Jan 2020 08:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580372707;
        bh=oLADHjwsZK/zmHyFtHVsSOYErltf5rGudZWVt9X53gQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P+qhIqJa76JfwK7WzQlywJzMe3cyG8N4B/5+L+1h7UrZwiDF+xemU8OYiAEEpbMSO
         gWoo1Jn5IkfyJFb3w1k/JihqxhbvXbYnSXzCrOrE8NqUn2y9MkbB3wVUI9ZpO5MLGU
         wcxyTiwbpXEqr49mtNa7oEi3kckbyOL8jL/H+f5g=
Date:   Thu, 30 Jan 2020 13:55:03 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     dmaengine@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2] dmaengine: Fix return value for dma_requrest_chan()
 in case of failure
Message-ID: <20200130082503.GD2841@vkoul-mobl>
References: <CGME20200130070850eucas1p1a7a09e2bec2f6fe652f206b61a8a04ae@eucas1p1.samsung.com>
 <20200130070834.17537-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200130070834.17537-1-m.szyprowski@samsung.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 30-01-20, 08:08, Marek Szyprowski wrote:
> Commit 71723a96b8b1 ("dmaengine: Create symlinks between DMA channels and
> slaves") changed the dma_request_chan() function flow in such a way that
> it always returns EPROBE_DEFER in case of channels that cannot be found.
> This break the operation of the devices which have optional DMA channels
> as it puts their drivers in endless deferred probe loop. Fix this by
> propagating the proper error value.

Fixed the title and Applied, thanks

-- 
~Vinod
