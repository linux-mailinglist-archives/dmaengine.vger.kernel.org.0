Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74FCF7B1B7C
	for <lists+dmaengine@lfdr.de>; Thu, 28 Sep 2023 13:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbjI1L4Z (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 Sep 2023 07:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232179AbjI1L4Y (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 28 Sep 2023 07:56:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0024B122;
        Thu, 28 Sep 2023 04:56:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D7E6C433C7;
        Thu, 28 Sep 2023 11:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695902182;
        bh=HlVb6KvrY32WHyaOFqIwYRhmxfd0p63UtxsXodhfazw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=E7saClIM2kz8OQdxPj8fdk3EndOTt8S6PvoWE1IlIIJI3C/uL5Vmfktx0wHkfIUVb
         pe6Sdsr+yubGGnN2H14126lhDChCW3WFxY3PVerfeNj+67lzk0ZYiVwHzQI3VqJks3
         G0frhOV3lrY8MzkvLpdpuEePXOeyiOPNKpOROUjwaN6qN1p4eQ22o5KCi0x2MvzqMi
         6KQNhtyt3cnbHryl5s+atXI5JX2kIb82CD3q6rfVr9kTtE/xHnQVRnTRYEpWrvFQ0g
         YN8gzkIJP5bYj/cwXJeAzoMSMCwMZrFnawjcmZSpNTEEw3YE76kdUNbULbeKksMaul
         GZy/RAhlrdivw==
From:   Vinod Koul <vkoul@kernel.org>
To:     frank.li@nxp.com, Frank Li <Frank.Li@nxp.com>
Cc:     dmaengine@vger.kernel.org, gregkh@linuxfoundation.org,
        imx@lists.linux.dev, linux-kernel@vger.kernel.org, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev, rafael@kernel.org
In-Reply-To: <20230921150144.3260231-1-Frank.Li@nxp.com>
References: <20230921150144.3260231-1-Frank.Li@nxp.com>
Subject: Re: [PATCH v4 0/3] dmaengine: fsl_edma: add trace and debugfs
 support
Message-Id: <169590217975.152265.11376979671569668186.b4-ty@kernel.org>
Date:   Thu, 28 Sep 2023 17:26:19 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On Thu, 21 Sep 2023 11:01:41 -0400, Frank Li wrote:
> Change from v3 to v4
> - Fix build warning
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202309210500.owiirl4c-lkp@intel.com/
> 
> [...]

Applied, thanks!

[1/3] debugfs_create_regset32() support 8/16/64 bit width registers
      commit: 09289d0ad1226c4735f8d9f68c9c3e54cbaba3d4
[2/3] dmaengine: fsl-emda: add debugfs support
      commit: 105c148c66fa06ca2a375edacfa3139c814af9d1
[3/3] dmaengine: fsl-edma: add trace event support
      commit: c8fde7598064fc9b94a53264b1e0c605a140fedb

Best regards,
-- 
~Vinod


