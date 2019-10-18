Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFA4DBF44
	for <lists+dmaengine@lfdr.de>; Fri, 18 Oct 2019 10:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407640AbfJRICq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 18 Oct 2019 04:02:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:39644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729376AbfJRICq (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 18 Oct 2019 04:02:46 -0400
Received: from localhost (unknown [106.200.243.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B98542089C;
        Fri, 18 Oct 2019 08:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571385765;
        bh=Ntm+G7UaaAAt6/MZrn+mvHAfZaYTK61Q3hCldEAMCXE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HYDITSsAr18ZLEicyiGmnMITuZH5dimDuhrDrGRJnQmx5Jv6clGFtsQhOoI1zbNyX
         kSuaR1+xdgzJ1edTxqgrCvY1Iq1Uc/7mpsW73fxzWz2Q+k7KI//k9MvcjDKrgIVeMy
         DehetQMb+tjGg4ayL4sArL33nJXRrJ8QcudHohec=
Date:   Fri, 18 Oct 2019 13:32:41 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     jassisinghbrar@gmail.com
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, masami.hiramatsu@linaro.org,
        orito.takao@socionext.com, Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH v3 0/2] Add support for AXI DMA controller on Milbeaut
 series
Message-ID: <20191018080241.GQ2654@vkoul-mobl>
References: <20191015033116.14580-1-jassisinghbrar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015033116.14580-1-jassisinghbrar@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 14-10-19, 22:31, jassisinghbrar@gmail.com wrote:
> From: Jassi Brar <jaswinder.singh@linaro.org>
> 
> The following series adds AXI DMA (XDMAC) controller support on Milbeaut series.
> This controller is capable of only Mem<->MEM transfers. Number of channels is
> configurable {2,4,8}

Applied, thanks

-- 
~Vinod
