Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E33A22F49FB
	for <lists+dmaengine@lfdr.de>; Wed, 13 Jan 2021 12:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbhAMLWT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 13 Jan 2021 06:22:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:43950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbhAMLWS (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 13 Jan 2021 06:22:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CDAA62336F;
        Wed, 13 Jan 2021 11:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610536898;
        bh=EggYq6wuwwH0lRrHpU74Cm7tyux54OWhkraFooh7AGQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=otMtiQT338TVUD+EuBT9iUhd46X16JT7yz/8HrszkYDc+0cnbxkNz3qLMeYYy62KB
         5dA3brkTlMvabkodCaiOFhC3cEocaMLpfsbF7XLaAr2Vwv6tUC9oQ8OtsC/9DsDonj
         kF2l+9vwW6/hgj2l8RFsDMMvLRl2o3m2Kp8tTnlMDydlcJFHn0pKy19NhnjhFXRMg9
         Q336dZbHbsl4eKn2NIZclONETvNwi5VigLMXi9vRxUyy7+JfektnIpQ3I5p4ZFOtnx
         Omlj98W2Y/RLUOApPdengfvipshDT5x8AXYDIjdshrncAsU/TzvE2A2HnzomwWPiWy
         5wHr1+4xiJO5w==
Date:   Wed, 13 Jan 2021 16:51:32 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] dmaengine: qcom: Always inline gpi_update_reg
Message-ID: <20210113112132.GA2771@vkoul-mobl>
References: <20210112191214.1264793-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112191214.1264793-1-natechancellor@gmail.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 12-01-21, 12:12, Nathan Chancellor wrote:
> When building with CONFIG_UBSAN_UNSIGNED_OVERFLOW, clang decides not to
> inline gpi_update_reg, which causes a linkage failure around __bad_mask:
> 
> ld.lld: error: undefined symbol: __bad_mask
> >>> referenced by bitfield.h:119 (include/linux/bitfield.h:119)
> >>>               dma/qcom/gpi.o:(gpi_update_reg) in archive drivers/built-in.a
> >>> referenced by bitfield.h:119 (include/linux/bitfield.h:119)
> >>>               dma/qcom/gpi.o:(gpi_update_reg) in archive drivers/built-in.a
> 
> If gpi_update_reg is not inlined, the mask value will not be known at
> compile time so the check in field_multiplier stays in the final
> object file, causing the above linkage failure. Always inline
> gpi_update_reg so that this check can never fail.

Applied, thanks

-- 
~Vinod
