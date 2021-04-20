Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 963513655E5
	for <lists+dmaengine@lfdr.de>; Tue, 20 Apr 2021 12:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbhDTKKO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Apr 2021 06:10:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:46540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230408AbhDTKKM (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 20 Apr 2021 06:10:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9267161168;
        Tue, 20 Apr 2021 10:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618913381;
        bh=g73EIW0wDomTiC3ksKUkVvvo2f0x1bhXX73LEKA12Hs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ft0/lzNa7jqpZ0wauO7PTZKEkEpL1NtKYMcQbomZU1gAz7nV4qIErnt5BUY30UueS
         lZMSnIWgJKOdqhXc7nEbQzbcM1oZHMd+zd1gvaK+Bq59iB5RFS3IanLX72Rf+mgeOu
         YJjprd3XpExPBo9h3KBuWKHKmpCjR9mic21opmgVj3T1YeBnzUag7bSKH9Y+CNqIlg
         GI61IAjIv9KVAM5G2A+oSxcU+nnuH4MlV1iELZaL2fUwfkPPIra6TNOiWgje45HnWf
         0uLvbFXdrUKbBvQRzlwH+kceK40p2RD6gSAX5GncWhemHv/am9wY1f2Qymbj22n1i6
         FJQpT1c6jU3Bw==
Date:   Tue, 20 Apr 2021 15:39:37 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Felipe Balbi <felipe.balbi@microsoft.com>
Subject: Re: [PATCH v2 2/2] arm64: boot: dts: qcom: sm8150: Add DMA nodes
Message-ID: <YH6oYY/Q6o1GKofO@vkoul-mobl.Dlink>
References: <20210417061951.2105530-1-balbi@kernel.org>
 <20210417061951.2105530-3-balbi@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210417061951.2105530-3-balbi@kernel.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 17-04-21, 09:19, Felipe Balbi wrote:
> From: Felipe Balbi <felipe.balbi@microsoft.com>
> 
> With this patch, DMA has a chance of probing and doing something
> useful.

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
