Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F7B74F5F3
	for <lists+dmaengine@lfdr.de>; Tue, 11 Jul 2023 18:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbjGKQpc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 11 Jul 2023 12:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbjGKQpF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 11 Jul 2023 12:45:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E568A1BC6;
        Tue, 11 Jul 2023 09:44:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9280161586;
        Tue, 11 Jul 2023 16:44:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABE5EC433C9;
        Tue, 11 Jul 2023 16:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689093863;
        bh=adoK2M7+Iw3xoZDKLtXMLqYtn1O0kZbvZVoFdeAYFf4=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=tdSh7uqWFLHuZmtD8XxRzyFtsSP3JQ94pY6e4dpKC2uQopQZc8X2O/iCGToLP7/Nd
         y7kTcShrjtZ1466kFofnsefZd+Z5jM1T6CkdaJTVVuc4PcTnkrWLFIKyjaUeJ2ncqP
         sPtuwwgrMFy6Nf09HwNPdGu1Uv4wbLMw0RLCgRuweIr0eul67pwkW8dhz9U23usFro
         zS/ph8JpPpoIOQVsKeFEZjQhsNtEcSEYYSu9uA7w+hA13voWNt2aDDCX4WS6A/RoCB
         vQHmqYR3i78M4NQEHBlsLur7CVCCVBleKZU9/G0wq9W7zkVwamdhs8DrIMdAfLbpOK
         x1FfP8XtMbpig==
From:   Vinod Koul <vkoul@kernel.org>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        radhey.shyam.pandey@amd.com, dmaengine@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zong Li <zong.li@sifive.com>
In-Reply-To: <20230531090141.23546-1-zong.li@sifive.com>
References: <20230531090141.23546-1-zong.li@sifive.com>
Subject: Re: [PATCH v3] dmaengine: xilinx: dma: remove arch dependency
Message-Id: <168909386029.208679.18311531305885032641.b4-ty@kernel.org>
Date:   Tue, 11 Jul 2023 22:14:20 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On Wed, 31 May 2023 09:01:41 +0000, Zong Li wrote:
> As following patches, xilinx dma is also now architecture agnostic,
> and it can be compiled for several architectures. We have verified the
> CDMA on RISC-V platform, let's remove the ARCH dependency list instead
> of adding new ARCH.
> 
> To avoid breaking the s390 build, add a dependency on HAS_IOMEM.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: xilinx: dma: remove arch dependency
      commit: 9945a80fe40886f2d0655c0c3cdee95aaecafb87

Best regards,
-- 
~Vinod


