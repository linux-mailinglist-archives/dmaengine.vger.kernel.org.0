Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7C532D937C
	for <lists+dmaengine@lfdr.de>; Mon, 14 Dec 2020 08:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733073AbgLNHEZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 14 Dec 2020 02:04:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:55676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438734AbgLNHEJ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 14 Dec 2020 02:04:09 -0500
Date:   Mon, 14 Dec 2020 12:33:24 +0530
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607929409;
        bh=CixMbn+aj7WrSx+lCSb9mfm7Fsnl2c042y3HsKThf5M=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=eUh7tsRtr5YvD8MiALMvQWMFqM8bxSLa6PvVH+lLOox9qa9TjkQ1LNguqJNOlA92L
         LMObeIWOyf3ZIVqusnLe20BY6IdVjXGO3MVzOQkYE449G3o0IPV2FCiULz+T0RqF7F
         ptJxoo9aTnzi7Y2HsiJqd7RHesqP/5MMyIy0TzM1NWMVdlvwtY+P3nC2WmEv+HsDuo
         n/EqZKC7i98iJ5W47cYAukrxs6a/E+KZlSrBkwwPvF2b1Uq/jOoJXBaXEG16SaMnbz
         Oe3GSOj2TOu8bUpLFaZ3JNl/Xeh4PXWopOAqJoCL39qTQb56wFGcFwrVxFEVPz2J3g
         VJWJwZ2mOS2Kg==
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     nm@ti.com, ssantosh@kernel.org, dan.j.williams@intel.com,
        t-kristo@ti.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        vigneshr@ti.com, grygorii.strashko@ti.com
Subject: Re: [PATCH] soc: ti: k3-ringacc: Use correct error casting in
 k3_ringacc_dmarings_init
Message-ID: <20201214070324.GE8403@vkoul-mobl>
References: <20201214065421.5138-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201214065421.5138-1-peter.ujfalusi@ti.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 14-12-20, 08:54, Peter Ujfalusi wrote:
> Use ERR_CAST() when devm_ioremap_resource() fails.
> 
> Reported-by: kernel test robot <lkp@intel.com>

Applied, thanks

-- 
~Vinod
