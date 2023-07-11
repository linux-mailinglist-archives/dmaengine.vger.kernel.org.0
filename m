Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0DC174F5E2
	for <lists+dmaengine@lfdr.de>; Tue, 11 Jul 2023 18:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233318AbjGKQo6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 11 Jul 2023 12:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233180AbjGKQoZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 11 Jul 2023 12:44:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017EBE7E;
        Tue, 11 Jul 2023 09:44:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60FB961588;
        Tue, 11 Jul 2023 16:43:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0151CC433C8;
        Tue, 11 Jul 2023 16:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689093838;
        bh=XPdsAGiEPx8LS4Mu1bmVB/QfPhgxV5Ysm0ud6Ue433c=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=d/6lbVlI1Zo52XgNX8PhpZ8e0o0ptDzqUESOEUltbK7ZtNgJcQLEHr60pciywEALb
         CWybNTmgifc4HYMzp/Dcwc4fXTACLeDsSdvyuEY/nuy35n5fbT+dHkbt/ARpB5NOu+
         v7R4TV2OO5Ho8feaCEVw0mr0AYPIH69uqtRa1ZhL/Dq2ZIBeyZuDZuyW3i48kCHbEM
         HPUy/+SkaMCliaIanaEkSdTq7qUGQe3gMBOSpo1Boy/WNcBI3Q5RU/PyxnmO/5jQKs
         w2xH9KuagPnkKjhdrIilGLV8GAvA5KO0GueMywqlPfQ0PvrZibfhi2KmTwKgMM/2+p
         aMhnkBkt9XfTA==
From:   Vinod Koul <vkoul@kernel.org>
To:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        bhupesh.linux@gmail.com, agross@kernel.org,
        konrad.dybcio@linaro.org, conor+dt@kernel.org, robh+dt@kernel.org
In-Reply-To: <20230630082230.2264698-1-bhupesh.sharma@linaro.org>
References: <20230630082230.2264698-1-bhupesh.sharma@linaro.org>
Subject: Re: [PATCH v9 0/2] dt-bindings: dma: Add support for SM6115 and
 QCM2290 SoCs
Message-Id: <168909383458.208679.6618239187680530710.b4-ty@kernel.org>
Date:   Tue, 11 Jul 2023 22:13:54 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On Fri, 30 Jun 2023 13:52:28 +0530, Bhupesh Sharma wrote:
> Add support for SM6115 and QCM2290 SoCs in qcom,bam-dma bindings.
> Also increase iommu maxItems for BAM DMA to 6 which is the number
> required on sm8250 SoC.
> 
> This patchset is rebased on linux-next/master.
> 
> Changes since v8:
> -----------------
> - v8 can be viewed here: https://www.spinics.net/lists/linux-crypto/msg72349.html
> - As rest of the patches from v8 have been applied to linux-next, dropped them from v9.
> - Added dma list and maintainer in Cc again as the Cc list got messed up while
>   sending out v8.
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: dma: Add support for SM6115 and QCM2290 SoCs
      commit: 80159ca4314224f5778d5fa8ded24d6ef7876c53
[2/2] dt-bindings: dma: Increase iommu maxItems for BAM DMA
      commit: ffcde05811d97e9320358674625f28002102f7c9

Best regards,
-- 
~Vinod


