Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03EFF76BCC9
	for <lists+dmaengine@lfdr.de>; Tue,  1 Aug 2023 20:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjHASpW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 1 Aug 2023 14:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjHASpU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 1 Aug 2023 14:45:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15DEE2683;
        Tue,  1 Aug 2023 11:45:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FBE361680;
        Tue,  1 Aug 2023 18:45:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19130C433C9;
        Tue,  1 Aug 2023 18:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690915508;
        bh=dfqg0pIWUMMAdJehGVs1TLzTNY1ZG4A/VuMAO+Wuz+g=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=TuiFbB+nDIndAT/R+VESSBliJYqBnWrElB7j7By6aLv8BOMUd+c3aD780M2YpZkzm
         HvM10TwX/mqrsptRufl8MNIZw1QK0DOQKpgjsqWetZepWEkx24K6G40U2vBAzdTCf8
         0fVpZS7GR+N7nCcGhd5+1nuEdDszlgdqtb2LmawRZ02U5GwEq/+yuV9qICXgogZZH5
         8Fu3/thBbErnlKKCTFQ7seKgtbEXtlSwSFPr4y3YMsw0VSxoYkErLwlgxgkvSMJgE6
         Ww6M3EreQ6Cf/eTte3tldZWpS4O2uw00fAhUXSYzMvAHlk9qgsTamrXQ5oAie1yHU/
         i7ujG88sj5D1g==
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Cc:     dmaengine@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20230712174436.3435088-1-fenghua.yu@intel.com>
References: <20230712174436.3435088-1-fenghua.yu@intel.com>
Subject: Re: [PATCH 1/2] dmaengine: idxd: Simplify WQ attribute visibility
 checks
Message-Id: <169091550668.69468.6039812012184401839.b4-ty@kernel.org>
Date:   Wed, 02 Aug 2023 00:15:06 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On Wed, 12 Jul 2023 10:44:35 -0700, Fenghua Yu wrote:
> The functions that check if WQ attributes are invisible are almost
> duplicate. Define a helper to simplify these functions and future
> WQ attribute visibility checks as well.
> 
> 

Applied, thanks!

[1/2] dmaengine: idxd: Simplify WQ attribute visibility checks
      commit: 97b1185fe54c8ce94104e3c7fa4ee0bbedd85920
[2/2] dmaengine: idxd: Expose ATS disable knob only when WQ ATS is supported
      commit: 62b41b656666d2d35890124df5ef0881fe6d6769

Best regards,
-- 
~Vinod


