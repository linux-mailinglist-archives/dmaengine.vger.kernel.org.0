Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E35A74F5DB
	for <lists+dmaengine@lfdr.de>; Tue, 11 Jul 2023 18:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233253AbjGKQoc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 11 Jul 2023 12:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbjGKQoI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 11 Jul 2023 12:44:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF261BE8;
        Tue, 11 Jul 2023 09:43:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E0FBD61426;
        Tue, 11 Jul 2023 16:43:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE8F1C433C9;
        Tue, 11 Jul 2023 16:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689093834;
        bh=YWbs68UIgZRzU1siQoXBAlJn+q/gZ5KT+J9UVrgDd8k=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=o7rpzdvW3SfZVmcm+fcan04N/XVrO+5kVWagZNCg8nI3li5UYSHWeWBX+eFqjlPD+
         U9jWTNObax5fAwbtBfcHjrCBSwmUu3HhqLAzlvbKrtrhlzxptFcBA/AYMPDE+t/L2J
         M2A7Fp4pEFR+va4a0K+LLmh6kkLDExKzlR+P7NGF0COhOpnPCNjse8TEYsae3f+NK7
         K5IQL7js96lOsuoPbG7h2qI6rla6wvmlLnSHyGJcbrJoh43ARwNqxr+MrQoqhtYVhS
         vXyiH0qhIw9ejMuJ+FioLsfgUwylD8OFNOGdrj2H+ZChbIL67an8qGaJxsqym1Kmsd
         SnVQySdlW9usg==
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Yangtao Li <frank.li@vivo.com>
Cc:     linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230705081856.13734-1-frank.li@vivo.com>
References: <20230705081856.13734-1-frank.li@vivo.com>
Subject: Re: [PATCH 1/5] dmaengine: qcom: gpi: Use
 devm_platform_get_and_ioremap_resource()
Message-Id: <168909383153.208679.15343948792914219046.b4-ty@kernel.org>
Date:   Tue, 11 Jul 2023 22:13:51 +0530
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


On Wed, 05 Jul 2023 16:18:52 +0800, Yangtao Li wrote:
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> 

Applied, thanks!

[1/5] dmaengine: qcom: gpi: Use devm_platform_get_and_ioremap_resource()
      commit: d9313d9f1fbc14cae5147c5130bea54aa76ad65f
[2/5] dmaengine: qcom_hidma: Use devm_platform_get_and_ioremap_resource()
      commit: a189107deb574fd08018bbf2fe5cd86450a54b13
[3/5] dmaengine: qcom: hidma_mgmt: Use devm_platform_get_and_ioremap_resource()
      commit: fe6c2622473f3756a09bd6c42cffca6fbdce391c
[4/5] dmaengine: shdmac: Convert to devm_platform_ioremap_resource()
      commit: 0976421c5a339b1b1a89cfba4471a6de761130ed
[5/5] dmaengine: stm32-dma: Use devm_platform_get_and_ioremap_resource()
      commit: b402a7eeaa35aaa3300a4ba6bd5b381112ae183c

Best regards,
-- 
~Vinod


