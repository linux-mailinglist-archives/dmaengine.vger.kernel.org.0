Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3523A979C
	for <lists+dmaengine@lfdr.de>; Wed, 16 Jun 2021 12:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbhFPKio (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 16 Jun 2021 06:38:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:51024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231922AbhFPKin (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 16 Jun 2021 06:38:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ED88960FF4;
        Wed, 16 Jun 2021 10:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623839797;
        bh=3oTb/1+XDcFsTnzsrZvYuutb3J6p97qLHaHtThQAkqc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IFSOjzgUTgRVG+msUdDw2KENqBmzvBhpu7O5BIhA3opNeq215BrJnOxmlXZMRZ0av
         7kEGyZsLzKzKy5HCXAzl6+TROnko29I3j2HZ9rA7scbnrIRMlStxTumWl/UnrIKgVY
         L3oRPnh4SRv/5s258GLwl8hm7DDcBdOHhOfwjEz+dzW6rjuRWfV9BxY2+hsFGvZysu
         aQsKIDvJEhS4YBlb5puVpz7EgEN4LE2M7dkaQqt84XDN+xzNuFyuEwIT3SelMipH+U
         /dKshZ/hc6tOYokOCDJiPjri2GgP3WqgLD1vhFP5ku1kqek3nRP53wa2MKsabB10Sc
         AIz5jQ3fCWlfg==
Date:   Wed, 16 Jun 2021 16:06:34 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: dmaengine: qcom: gpi: add compatible
 for sm8250
Message-ID: <YMnUMuUahJM/9KTA@vkoul-mobl>
References: <20210614235358.444834-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614235358.444834-1-konrad.dybcio@somainline.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 15-06-21, 01:53, Konrad Dybcio wrote:
> No functional changes, just adding a new compatible for a different
> SoC.

Applied 1 & 2, thanks

-- 
~Vinod
