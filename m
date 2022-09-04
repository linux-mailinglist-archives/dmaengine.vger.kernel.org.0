Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D295AC554
	for <lists+dmaengine@lfdr.de>; Sun,  4 Sep 2022 18:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbiIDQQX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 4 Sep 2022 12:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiIDQQW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 4 Sep 2022 12:16:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E525D33413;
        Sun,  4 Sep 2022 09:16:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A1487B80DB0;
        Sun,  4 Sep 2022 16:16:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44ECAC433C1;
        Sun,  4 Sep 2022 16:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662308179;
        bh=ioirwzbZiPQ7VgdEXiCCyTMGA78pAPKV73LLMp9+KVg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X1UVsGo/daFLPHA40lz2S1If89p7G1mwT+NvZGHUirlaZdIU1NZHegqd/rrLUEocA
         j+kRHhh4J+JZPdGCMhBMiq5GVaYVvgtr7jS2ON5rHzOg91L6vYe2GD/oi9i6ddO9ue
         QalDvJy2q4g2fisPpAJNI51dEcMbVyJulKiB1p7BDYA6NxnmJ9auZpTvIiG74GwmZp
         wxb1qS1cmLGHER5CPtPI3Ga/aUzy2ksa8sH5LVpD1GaHvYqrb6nBilKojmlD2ar3PI
         +/4T/QYdQkP+iwxgv2Or1D9jCPR9zTBPapmn5wNKE8fA7PhNnV2SUm4PhOFl1iht5r
         dzoqoYrtdC/1Q==
Date:   Sun, 4 Sep 2022 21:46:14 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Joy Zou <joy.zou@nxp.com>
Cc:     krzysztof.kozlowski@linaro.org, shengjiu.wang@nxp.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 2/4] dmaengine: imx-sdma: support hdmi audio
Message-ID: <YxTPTnrJst9aNpsl@matsya>
References: <20220901020059.50099-1-joy.zou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901020059.50099-1-joy.zou@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 01-09-22, 10:00, Joy Zou wrote:
> Add hdmi audio support in sdma.

Pls make sure you thread your patches properly! They are broken threads!

-- 
~Vinod
