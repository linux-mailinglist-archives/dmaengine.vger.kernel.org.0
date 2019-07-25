Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEA2374B8D
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jul 2019 12:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729066AbfGYK11 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 25 Jul 2019 06:27:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:48804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728603AbfGYK11 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 25 Jul 2019 06:27:27 -0400
Received: from localhost (unknown [106.200.241.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB5CF2190F;
        Thu, 25 Jul 2019 10:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564050446;
        bh=yIW36v6BxYIlCrKZEEkenceCjMmchU/hjIQC0JWlt2w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VnjJ+w7vveNogrQ+DajuMqa6r0vuSfC8fxf2AegJEBwFQSMTqsEIQrwAZoTAvV2nf
         9b1UcA68LP207iBHUcnx1MlXMqZ/GxOwFVpSu9O223mHVtKriQhlqdpdmLCbdIgViI
         clegjpyuCGGN+fIAM8IczxNWh1hJqiE1uETDIC/A=
Date:   Thu, 25 Jul 2019 15:56:13 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] dmaengine: tegra-apb: Support per-burst residue
 granularity
Message-ID: <20190725102613.GT12733@vkoul-mobl.Dlink>
References: <20190705150519.18171-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190705150519.18171-1-digetx@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 05-07-19, 18:05, Dmitry Osipenko wrote:
> Tegra's APB DMA engine updates words counter after each transferred burst
> of data, hence it can report transfer's residual with more fidelity which
> may be required in cases like audio playback. In particular this fixes
> audio stuttering during playback in a chromium web browser. The patch is
> based on the original work that was made by Ben Dooks and a patch from
> downstream kernel. It was tested on Tegra20 and Tegra30 devices.

Applied, thanks

-- 
~Vinod
