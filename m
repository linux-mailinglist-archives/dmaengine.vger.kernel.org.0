Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85095A5824
	for <lists+dmaengine@lfdr.de>; Tue, 30 Aug 2022 01:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbiH2Xs1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 29 Aug 2022 19:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiH2Xrp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 29 Aug 2022 19:47:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5415AA6C6C;
        Mon, 29 Aug 2022 16:46:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9884DB815E2;
        Mon, 29 Aug 2022 23:46:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3246C43155;
        Mon, 29 Aug 2022 23:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661816799;
        bh=EVU5NmsfBTMH8Ihcr+TbZu9oO7irjNeV+Eh3Zx85vdw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GRqUe1/RVZbQ5Q+kSv2PsqNeAgwLUpCbQKy8vpv3dafEwUcMhQF5DqrY3Zgqif6UK
         pU0hcJa66a/YlV23TXIMH0ZypAlNOcRjU0f5yxLkMW8DrOhsljVmuSVzxjpdf0qpO9
         +y9NsYMr1QkuyO9/KxjXhjU/qF6WChyv2sif6XMLgUFuNAWz6JPeI5dqSL0keBcRZi
         r4MOWYFUYbpyy4LHJAxNujlZdQTgeJYsB595HPj1WUV75YASdk7oBp73ijdGdj/xJm
         zQH4aW4NtJEVtaQccotNoTp7GP2ewuQFH+cdVTzPwFp1w2PqwKixaDktHdu5advhev
         sTA9nsIz3yqlA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-arm-msm@vger.kernel.org, luca.weiss@fairphone.com
Cc:     vkoul@kernel.org, dmaengine@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-kernel@vger.kernel.org, konrad.dybcio@somainline.org,
        phone-devel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH 0/3] Add GPI DMA support for SM6350
Date:   Mon, 29 Aug 2022 18:46:01 -0500
Message-Id: <166181675978.322065.10581898444404760964.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220812082721.1125759-1-luca.weiss@fairphone.com>
References: <20220812082721.1125759-1-luca.weiss@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, 12 Aug 2022 10:27:18 +0200, Luca Weiss wrote:
> This series hooks up GPI DMA support for the SM6350 I2C.
> 
> It has been tested using himax,hxcommon driver that I forward-ported
> from the original vendor kernel on fairphone-fp4 - previously I have
> used i2c-gpio bitbang in my tree.
> 
> This also requires the fix from Robin[0] that has already been
> accepted into linux-next, otherwise I2C communication fails to work.
> 
> [...]

Applied, thanks!

[3/3] arm64: dts: qcom: sm6350: Add GPI DMA nodes
      commit: 9f0149caf0dc1c1261a612b0653d31d998f80596

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
