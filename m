Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E92B73655E0
	for <lists+dmaengine@lfdr.de>; Tue, 20 Apr 2021 12:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbhDTKJT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Apr 2021 06:09:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:46190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231313AbhDTKJT (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 20 Apr 2021 06:09:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C91AC61168;
        Tue, 20 Apr 2021 10:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618913323;
        bh=UTi/P0BDHFW7iXbF4EJlskMZrQW2zE8w2Rl+7IDEyfE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HtUjueDfJz7yoHYYmrl/dCXT0ku5HUKpHRtDj5Jmip0wJdiXb8p6YtMx5Befhq1vS
         uGxjRlec29XXEJQxWHHQTmUvQbzL6btEodu/Vsbd8XNwRdcwWaoXp6zGN7I8dgMKp8
         e+7h2uRmqdzE/jnD6zLZpFS0SWobknmMs+81Chh05KczuYcxGwWsuomB6G7sJ/h64i
         aNv3jqHn7otxSfBJRZYcxrUeDzpaNxmU99wORlsB1iAVzI0vOt+Kl/Zkd71kbg/gbt
         uVispfrLtTvEi97uPjdMLCaIiuFucilmFTxYRSngH9hLiXgLnOM+xANX25tEUB1rES
         7O7lheSV55PGQ==
Date:   Tue, 20 Apr 2021 15:38:39 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Felipe Balbi <felipe.balbi@microsoft.com>
Subject: Re: [PATCH v2 1/2] DMA: qcom: gpi: add compatible for sm8150
Message-ID: <YH6oJwyPDDRei0rg@vkoul-mobl.Dlink>
References: <20210417061951.2105530-1-balbi@kernel.org>
 <20210417061951.2105530-2-balbi@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210417061951.2105530-2-balbi@kernel.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 17-04-21, 09:19, Felipe Balbi wrote:
> From: Felipe Balbi <felipe.balbi@microsoft.com>
> 
> No functional changes, just adding a new compatible for a diferent
> SoC.

Applied after fixing subsystem name, thanks

-- 
~Vinod
