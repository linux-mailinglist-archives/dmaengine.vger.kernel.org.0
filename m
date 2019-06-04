Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C532B3466C
	for <lists+dmaengine@lfdr.de>; Tue,  4 Jun 2019 14:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbfFDMTZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 4 Jun 2019 08:19:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:50728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727377AbfFDMTY (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 4 Jun 2019 08:19:24 -0400
Received: from localhost (unknown [117.99.94.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EC95247F9;
        Tue,  4 Jun 2019 12:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559650764;
        bh=5mDhuWW9AhtrNyi3+kKWCarCqtJksnkX7XioSL9hjMQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vHCMyNsNztRQezlvHEmUk9aqrMCdYbMy0Mdyfos6pISt0WgXVGPcBTDQqAEruEflY
         BsWnL1h5qIH90UBz4tpmenjYSZYYgFGgYl+y4rxhPf1geZsPdf6rX2Ld0JToHN7uvP
         FaK2332k1zX7wk9PeLuoCWFNj79Ebqi+LQ1OZNeU=
Date:   Tue, 4 Jun 2019 17:46:16 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] dmaengine: tegra-apb: Error out if DMA_PREP_INTERRUPT
 flag is unset
Message-ID: <20190604121616.GX15118@vkoul-mobl>
References: <20190529214355.15339-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529214355.15339-1-digetx@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 30-05-19, 00:43, Dmitry Osipenko wrote:
> Apparently driver was never tested with DMA_PREP_INTERRUPT flag being
> unset since it completely disables interrupt handling instead of skipping
> the callbacks invocations, hence putting channel into unusable state.
> 
> The flag is always set by all of kernel drivers that use APB DMA, so let's
> error out in otherwise case for consistency. It won't be difficult to
> support that case properly if ever will be needed.

Applied, thanks

-- 
~Vinod
