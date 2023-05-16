Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403C970442A
	for <lists+dmaengine@lfdr.de>; Tue, 16 May 2023 05:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjEPD6O (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 15 May 2023 23:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjEPD6K (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 15 May 2023 23:58:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56DBE5587;
        Mon, 15 May 2023 20:58:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DEC4B63486;
        Tue, 16 May 2023 03:58:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB56EC433D2;
        Tue, 16 May 2023 03:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684209488;
        bh=V7vpH1adPrbGX1hn5u1aSIghV5mFiE194ihfRsJnhzk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K+ks0eGWVTThM8o3pK7bewrcyUdvRgWkTOcGkzGZJt+jxUJ/3rPg0szoNoDP0AKu9
         FZapW/Jbp9PFWkJllThkZ2mXrc7dsxR8QeMlkCNyAJY03VRgOlsmLbbEmsqNt2XiS9
         0YGlQujIymzqTh8vpd8eWAszx1GGJxkPZjXfRCGA=
Date:   Tue, 16 May 2023 05:58:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-arm-msm@vger.kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 6/6] dt-bindings: thermal: tsens: Add QCM2290
Message-ID: <2023051654-dinner-shanty-ac34@gregkh>
References: <20230314-topic-2290_compats-v1-0-47e26c3c0365@linaro.org>
 <20230314-topic-2290_compats-v1-6-47e26c3c0365@linaro.org>
 <8a5d13e2-b06a-417e-5d8b-1db749efb0cd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a5d13e2-b06a-417e-5d8b-1db749efb0cd@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, May 16, 2023 at 03:08:19AM +0200, Konrad Dybcio wrote:
> 
> 
> On 14.03.2023 13:53, Konrad Dybcio wrote:
> > Add the TSENS v2.x controller found on QCM2290.
> > 
> > Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > ---
> <bump>
> This one got lost!

Then it should be resent.
