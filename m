Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAE430A1C8
	for <lists+dmaengine@lfdr.de>; Mon,  1 Feb 2021 07:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbhBAGCs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 1 Feb 2021 01:02:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:58062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231838AbhBAF6t (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 1 Feb 2021 00:58:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 90C6164DD8;
        Mon,  1 Feb 2021 05:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612159084;
        bh=HWMMxPxHWxeE2U2BkjlG/ZUO4RaVY6Fvf8MiVRsg+h4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tdH3oyvwOneB2CVx0WGybfgByh8+XL5CL1hNlNBEiSiUFJUGyl2ViB3W2gWMpc7he
         N2xquotPY53tyQtw9dVctKloxwGuEkRsUvdCwY6dxd0R9iY8jSYtZUcDfQfLS1pZ6o
         nD8kYtLlOlJWohvPaV2it4/dF+q+x1vSiEeHC49+y7d0QAz7bs7wW6EQi/U7YFg1la
         PPmYzf75zfuyZcu5t9ip6FR4lyJJfH81NnnLZMs8HTctQc9rZK1Wl6wEQrWPjmbqNK
         nZ8TFgLUyaOWNzTIK6Dvmx0fc3GBAA/M09F5wcMmyBlCUmh+HgA5owi38vMg2Illfh
         tFkY1pM9moWNQ==
Date:   Mon, 1 Feb 2021 11:27:59 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Amireddy Mallikarjuna reddy 
        <mallikarjunax.reddy@linux.intel.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: INTEL_LDMA should depend on X86
Message-ID: <20210201055759.GI2771@vkoul-mobl>
References: <20210129131702.2656060-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210129131702.2656060-1-geert+renesas@glider.be>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 29-01-21, 14:17, Geert Uytterhoeven wrote:
> The Intel Lightning Mountain (LGM) DMA controller is only present on
> Intel Lightning Mountain SoCs.  Hence add a dependency on X86, to
> prevent asking the user about this driver when configuring a kernel
> without Intel Lightning Mountain platform support.
> 
> While at it, fix a misspelling of "Intel".

:D

Applied, thanks

-- 
~Vinod
