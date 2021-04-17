Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33341362DFF
	for <lists+dmaengine@lfdr.de>; Sat, 17 Apr 2021 08:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbhDQGVY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 17 Apr 2021 02:21:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:35454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230241AbhDQGVU (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sat, 17 Apr 2021 02:21:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 918676113D;
        Sat, 17 Apr 2021 06:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618640454;
        bh=Q4KFfPv586B4UjtwDb7POoscxtWCue6WwTVATgdWwGw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=m7l6G9JzIv13lDgiDWIZas/9sKlC/sV6PQnIcRoKSTaD3DqrY7ZdU1h/c+2rUVhsr
         6To2Oy1sF8aQ+OFSYuERF9kjzgCBnv+gNOu2fn+X7QUZS8izzo3DkY8fvTPoezLQeW
         LvM3CNYaPziYHEVLY5P2TpfNx37CFUuylRgy6+jJqHzIc+kNmwVGQxvTiP37h7vctn
         4amB1EHHir8hrX1/xjDy+Mb6gds7xdAHaA5toSqLe2Qv43gh6Qnfn2izbHuJswuZLW
         CsezrWhjhTEktUYYSR5mMtMkB0Fr5wm2Nr/f3CPdCrTraQZOPf9kSwt2cB2dQckURP
         7VZpnVWYDlepQ==
From:   Felipe Balbi <balbi@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        Felipe Balbi <felipe.balbi@microsoft.com>
Subject: Re: [PATCH 2/2] arm64: boot: dts: qcom: sm8150: Add DMA nodes
In-Reply-To: <0bb8e50d-9ea1-f616-6493-20fcb4e09e31@somainline.org>
References: <20210416133133.2067467-1-balbi@kernel.org>
 <20210416133133.2067467-3-balbi@kernel.org>
 <0bb8e50d-9ea1-f616-6493-20fcb4e09e31@somainline.org>
Date:   Sat, 17 Apr 2021 09:20:50 +0300
Message-ID: <87mttxmny5.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


Hi,

(looks like your email client is still refusing to break lines at 80 columns)

Konrad Dybcio <konrad.dybcio@somainline.org> writes:

>>one little note. This was for a quick test. I can either remove, keep it
>>or complete with the rest of the SPIs in this same patch. Let me know
>
>>what y'all prefer :-)
>
>
> Yeah, please remove it from this one and send in a separate patch, preferably
> adding dmas to all the QUPs :)

done

> Aaand since I already asked you to re-send, you might as well fix up the
> properties order under the nodes (compatible first, then reg, with #dma-cells
> somewhere at the bottom) and the unit name (should be "dma-controller@...").

done and done :-)

-- 
balbi
