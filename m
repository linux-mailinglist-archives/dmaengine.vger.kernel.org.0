Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBCCF563807
	for <lists+dmaengine@lfdr.de>; Fri,  1 Jul 2022 18:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbiGAQfu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 1 Jul 2022 12:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiGAQft (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 1 Jul 2022 12:35:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248F03FBC7;
        Fri,  1 Jul 2022 09:35:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B66B76257C;
        Fri,  1 Jul 2022 16:35:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4649BC3411E;
        Fri,  1 Jul 2022 16:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656693348;
        bh=TZguSwspOIt4L4Wa6O3+ebRs84Ga2Xv/b+fie/Hie2s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jcvK0Ldow7LDexUk8ieNY0llvi2exbIYdrUpM78qMbmzstn6SAW+ViMy/zzwMOuOa
         N1bK3FIBpRiyftr9KKHg9mINAMuFf4CGBF0/BJPJ7JgyZo8DueQV9Kr03cTZc8gea3
         ZCBOuWobVfY0ngl5lrpJd18uR4nxQhat0S9F2+/0cOHfX98PUpElWYiNAmkUXZ3Gdd
         LhxrBaaUxGYnLxskaEYsj9hzFWDGrjNcmf9PpUxOP7ZmkzndmyRCauSehsHbTKRwRf
         twHfomBcSc/cSnxUKUQGnmlMR5CRR60wq0ZDWDVxtOR6gxPmt/iODYTLYo/BjRLiTe
         ekyR5X6EftWYg==
Date:   Fri, 1 Jul 2022 22:05:42 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     dmaengine@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, joy.zou@nxp.com,
        Peng Fan <peng.fan@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH V4] dt-bindings: dma: fsl-edma: Convert to DT schema
Message-ID: <Yr8iXjJ6vuFub9Gy@matsya>
References: <20220620020002.3966343-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220620020002.3966343-1-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 20-06-22, 10:00, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Convert the eDMA controller binding to DT schema.

Applied, thanks

-- 
~Vinod
