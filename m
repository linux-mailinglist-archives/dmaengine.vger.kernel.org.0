Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E7A5ACB0D
	for <lists+dmaengine@lfdr.de>; Mon,  5 Sep 2022 08:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236764AbiIEGeJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 5 Sep 2022 02:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236782AbiIEGdl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 5 Sep 2022 02:33:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35CC33367;
        Sun,  4 Sep 2022 23:33:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 821326105C;
        Mon,  5 Sep 2022 06:32:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56454C433D6;
        Mon,  5 Sep 2022 06:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662359559;
        bh=2PWpEiGi7h1zcafINQPFX2M2Hs58oHMBkt0dkA4dSrM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L+05QfbCg33gZTiXJ7ffe3LqX/7f+XmKzLDRTN+icIuOtxKK6dz3fkBKX7/HNt1YZ
         eg96No9SNnnJd7e+1LVp3DbqwdO+Am2k1niuHaWaKd4b/s/zfm0wmZBWf42otisC31
         2HYnDLPrqLPm05dUEv9np2BQmmP9ss1+mRMij26+KAKXgUFzHXxA8K1cJqgcmDsoq3
         rz0FkmGkWcRnUGSwJqUir32w77zQXu7U1Wwwei2SuUVsyKA1UqIjeOIkVOzUdGW4z3
         gnmec1x1aeizK4Wlf42qo2nns/NPl+0jOo0XBVRjnysFwur5eg34c+aWYjGsyjU22/
         Vb+oag485YJxw==
Date:   Mon, 5 Sep 2022 12:02:35 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jean Delvare <jdelvare@suse.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, dmaengine@vger.kernel.org,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: Re: [PATCH] dmaengine: dw-axi-dmac: Drop obsolete dependency on
 COMPILE_TEST
Message-ID: <YxWYA0dTKXGKHwKF@matsya>
References: <20220803223448.6f08095b@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220803223448.6f08095b@endymion.delvare>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 03-08-22, 22:34, Jean Delvare wrote:
> Since commit 0166dc11be91 ("of: make CONFIG_OF user selectable"), it
> is possible to test-build any driver which depends on OF on any
> architecture by explicitly selecting OF. Therefore depending on
> COMPILE_TEST as an alternative is no longer needed.
> 
> It is actually better to always build such drivers with OF enabled,
> so that the test builds are closer to how each driver will actually be
> built on its intended target. Building them without OF may not test
> much as the compiler will optimize out potentially large parts of the
> code. In the worst case, this could even pop false positive warnings.
> Dropping COMPILE_TEST here improves the quality of our testing and
> avoids wasting time on non-existent issues.

Applied, thanks

-- 
~Vinod
