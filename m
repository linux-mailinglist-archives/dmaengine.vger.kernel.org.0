Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9405F362838
	for <lists+dmaengine@lfdr.de>; Fri, 16 Apr 2021 21:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236141AbhDPTFB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 16 Apr 2021 15:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235998AbhDPTFB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 16 Apr 2021 15:05:01 -0400
X-Greylist: delayed 509 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 16 Apr 2021 12:04:36 PDT
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [IPv6:2001:4b7a:2000:18::171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B365C061574
        for <dmaengine@vger.kernel.org>; Fri, 16 Apr 2021 12:04:36 -0700 (PDT)
Received: from [192.168.1.101] (abae68.neoplus.adsl.tpnet.pl [83.6.168.68])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id C079C3E984;
        Fri, 16 Apr 2021 20:56:03 +0200 (CEST)
Subject: Re: [PATCH 2/2] arm64: boot: dts: qcom: sm8150: Add DMA nodes
To:     Felipe Balbi <balbi@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        Felipe Balbi <felipe.balbi@microsoft.com>
References: <20210416133133.2067467-1-balbi@kernel.org>
 <20210416133133.2067467-3-balbi@kernel.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
Message-ID: <0bb8e50d-9ea1-f616-6493-20fcb4e09e31@somainline.org>
Date:   Fri, 16 Apr 2021 20:56:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210416133133.2067467-3-balbi@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

>one little note. This was for a quick test. I can either remove, keep it
>or complete with the rest of the SPIs in this same patch. Let me know

>what y'all prefer :-)


Yeah, please remove it from this one and send in a separate patch, preferably adding dmas to all the QUPs :)


Aaand since I already asked you to re-send, you might as well fix up the properties order under the nodes (compatible first, then reg, with #dma-cells somewhere at the bottom) and the unit name (should be "dma-controller@...").


Konrad


