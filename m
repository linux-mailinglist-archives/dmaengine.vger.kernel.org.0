Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E226563223
	for <lists+dmaengine@lfdr.de>; Fri,  1 Jul 2022 13:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234753AbiGALEK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 1 Jul 2022 07:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234650AbiGALEJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 1 Jul 2022 07:04:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C09C3AA51;
        Fri,  1 Jul 2022 04:04:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2BBA6250D;
        Fri,  1 Jul 2022 11:04:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CF6DC3411E;
        Fri,  1 Jul 2022 11:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656673447;
        bh=+ABAnANVQ/DhXXLzXAs7MdYrtbtEhES8rL57K6aHPcs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=skacddQvgwz+Q5tHSdriEwEb3vmAoRpC1qMhzWo47UcfeDfecvCKO1bIc8KpEqyBu
         vQL6cxIfVkbdfMn7/uHvw7C+wmvqKiuDRwsR+QccJ8K6n4XHAO79H0p+WnapeJj0b5
         9gOiwEeiyUmDRXxe/d2rFiwydAb6uQF805ZuoGW2ya1gROxpjFD7Iw7N1Y8tl+qUP7
         jt5Rwjptvya/J82QFEotvwxrieUfj0GPJR0+luamILZueWaJOSk5DINEFfpeAQkR9o
         Iw9X+IpftnPAwoWNyfzaOO6oR81FA95NJUnnJeNWKtjfZ1t/d+mv/r4IeYTQwaRATP
         QSha7eCbfAS2A==
Date:   Fri, 1 Jul 2022 16:34:02 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Caleb Connolly <caleb.connolly@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [RESEND PATCH v2] dmaengine: qcom: bam_dma: fix runtime PM
 underflow
Message-ID: <Yr7Uonyo49XNWb9V@matsya>
References: <20220629140559.118537-1-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629140559.118537-1-caleb.connolly@linaro.org>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 29-06-22, 15:06, Caleb Connolly wrote:
> Commit dbad41e7bb5f ("dmaengine: qcom: bam_dma: check if the runtime pm enabled")
> caused unbalanced pm_runtime_get/put() calls when the bam is
> controlled remotely. This commit reverts it and just enables pm_runtime
> in all cases, the clk_* functions already just nop when the clock is NULL.
> 
> Also clean up a bit by removing unnecessary bamclk null checks.

Applied, thanks

-- 
~Vinod
