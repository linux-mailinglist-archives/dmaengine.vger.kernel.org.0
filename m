Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C697F52DB1C
	for <lists+dmaengine@lfdr.de>; Thu, 19 May 2022 19:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbiESRYR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 19 May 2022 13:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242572AbiESRYO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 19 May 2022 13:24:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89BFA5A8C;
        Thu, 19 May 2022 10:24:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65FBD6172C;
        Thu, 19 May 2022 17:24:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C63BAC385AA;
        Thu, 19 May 2022 17:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652981051;
        bh=kT8t0KGLk/kGWkkzDUvWH9F3UM1N/oMuLdlF691IFpE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZS3TtNgRTSIepBdC9J9Jw5fizX6k9FMaHVxwZFP4is9OjoJdVx+h6F6sy7HhPsHLW
         eEljxdDUKsYPfokPqXPq3BkSY5ydqUzi15yPi/mYsEQTyMDNvDJphFTA5tw63ESgrh
         HOClkB2nQMjXDMUQ09DI4HfRwNiPeryx6hdVlopcp3nH/7M+zj5vjwLyTr/b1TK5OB
         g6+0hlWBeyJBFZVEWwz45FU+yCB/eakX+uq0FWdVMg/q5RTJz9lwhNbd8dZLhQRfsT
         6zN4Qsggu9ZBQeo4LtJoXMtLKyaiF2o5Vb9P/qcDvfnsrHr1VX18gSP3eos0uO+AFk
         XepqzOkKIvT/A==
Date:   Thu, 19 May 2022 22:54:06 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/4] dmaengine/ARM: pxa/mmp: use proper
 'dma-channels/requests' properties
Message-ID: <YoZ9Ng4RmcMrnd2o@matsya>
References: <20220503065407.52188-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503065407.52188-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 03-05-22, 08:54, Krzysztof Kozlowski wrote:
> Hi,
> 
> The core DT schema defines generic 'dma-channels' and 'dma-requests'
> properties, so in preparation to moving bindings to DT schema, convert
> existing users of '#dma-channels' and '#dma-requests' to the generic
> variant.

Applied 1-3, thanks

-- 
~Vinod
