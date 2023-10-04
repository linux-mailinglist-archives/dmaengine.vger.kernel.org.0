Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B20037B824C
	for <lists+dmaengine@lfdr.de>; Wed,  4 Oct 2023 16:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242686AbjJDO3S (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 Oct 2023 10:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242685AbjJDO3R (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 4 Oct 2023 10:29:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2498BE5;
        Wed,  4 Oct 2023 07:29:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A804FC433CA;
        Wed,  4 Oct 2023 14:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696429753;
        bh=G2t/tELToH3tlrri1yGgmWDNrvWlh8vra9XR/FFSihE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=SxKbuo1GUGKibRkX1BxYVjaWa5l/peCkNxLGuIPWMVyvlQzf+bVj5sOzVRjpKN0Ex
         DVIuJHU+LQ+H9WJeoayZIkVUf0v6M5xqlvpMbvj5PVfDhfZF+Xto/5Ho977Dpbznin
         Y2gKrgPxP2iqmSBT7dfbluUIRZ/t28UZFeKAyhfGTwyCTZLhJTjbJ2K4wDLVeMq74l
         A2ykhqNvVUlqLsr6xRUuz8heegou3Q/OeTDZRUl+PDPGkiMuV2vvJ50kYxEXB6PQ0U
         QxM8U+taq7mFJSBilh4X1nyQ/KvB41P3YsLu44qRhPYNEIC7nFd0UcCfN8KsMkiQBR
         wVDT+HrDp2Fug==
From:   Vinod Koul <vkoul@kernel.org>
To:     Sinan Kaya <okaya@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andi Shyti <andi.shyti@kernel.org>
In-Reply-To: <20230810100000.123515-1-krzysztof.kozlowski@linaro.org>
References: <20230810100000.123515-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/2] dmaengine: qcom: fix Wvoid-pointer-to-enum-cast
 warning
Message-Id: <169642975023.440009.5007970606847296155.b4-ty@kernel.org>
Date:   Wed, 04 Oct 2023 19:59:10 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On Thu, 10 Aug 2023 11:59:59 +0200, Krzysztof Kozlowski wrote:
> 'cap' is an enum, thus cast of pointer on 64-bit compile test with W=1
> causes:
> 
>   hidma.c:748:8: error: cast to smaller integer type 'enum hidma_cap' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]
> 
> 

Applied, thanks!

[1/2] dmaengine: qcom: fix Wvoid-pointer-to-enum-cast warning
      commit: 9a2136b60cc1a5ba9c5878f08a41f41271c4cd17
[2/2] dmaengine: mmp: fix Wvoid-pointer-to-enum-cast warning
      commit: 094f9ee5fb547c31486801a017a07d7f1c1e7881

Best regards,
-- 
~Vinod


