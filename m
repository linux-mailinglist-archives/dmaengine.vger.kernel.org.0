Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A44A6BEF97
	for <lists+dmaengine@lfdr.de>; Fri, 17 Mar 2023 18:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjCQRYQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Mar 2023 13:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjCQRYO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 17 Mar 2023 13:24:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3362A3BC58;
        Fri, 17 Mar 2023 10:24:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C0413B8263D;
        Fri, 17 Mar 2023 17:24:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E06C433EF;
        Fri, 17 Mar 2023 17:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679073845;
        bh=q1ov1xk0U4do5di1Twf4O7l40oHoIVwEUbGW7/GLBrU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tul2MrWIiA8qWqpQ0mpkZFbX1EfW+tpHKc59rTX4Am4lq/tlg2sBHtk4YJtyqJ8ZJ
         Z41S4Dn1/BjtiLgJ+40xFricwrNrBVJw50ZmFT6Z6TQ2Ze5uQmaZAEhUwpceB0b3lE
         tUhu0AzxaUEzfyR4dmpHKLE6TI7CDk1OoPtLDdYW+iBx7GtU5kQGrHgZtUHWNXts2s
         zvGKn9cobB7ntyjL67OQTc8KVbyuNmjCUquCKflmIy9iLR3YoFzVhkhHkojtsrPiIy
         ahvLsjPxyxpT1iKQZfOTLCyPgMra5pBIy1dvpEI9ibZ5Zd0n0atqVA45zJ9pMhgwXq
         uXcKBadNMEIIA==
Date:   Fri, 17 Mar 2023 22:54:00 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Subject: Re: [PATCH 2/6] dt-bindings: dmaengine: qcom: gpi: Add QCM2290 GPI
 DMA
Message-ID: <ZBSiMAuX4qiUF06k@matsya>
References: <20230314-topic-2290_compats-v1-0-47e26c3c0365@linaro.org>
 <20230314-topic-2290_compats-v1-2-47e26c3c0365@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314-topic-2290_compats-v1-2-47e26c3c0365@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 14-03-23, 13:52, Konrad Dybcio wrote:
> Add a compatible for the single GPI DMA controller on QCM2290. It uses
> the same 0x10000 offset as SM6350.

Applied, thanks

-- 
~Vinod
