Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC4460224B
	for <lists+dmaengine@lfdr.de>; Tue, 18 Oct 2022 05:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbiJRDMY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 17 Oct 2022 23:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbiJRDK5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 17 Oct 2022 23:10:57 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71779B850;
        Mon, 17 Oct 2022 20:07:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 80D49CE1B19;
        Tue, 18 Oct 2022 03:07:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 044C6C43141;
        Tue, 18 Oct 2022 03:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666062446;
        bh=ZpMmgT8oQQ40zKYleh0BmEb9DnJKp+eyoY+CIYOGN0E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W5PHA9YL0CNMKQ24BZgKgGScefveW/SoKFTBhD/W+khnqCiPD3RRa62lWp9ptBgda
         oGizIXFVCAksNmzxgsi8DiSq38J3WxCelbqfLgXzKlAWHa64mgPxAg1jB/PM1gs6W6
         wHjuAUkdFXhKQjD5MslrY9pPpCN5yhifMUXam5xq10CtY+0gu/qDhF/xePmNrR4vh6
         frOTR0q0Eg+GeP2Zu/ZGpFEybkZdXmdmkHufrZxDOtz8p5xuyPN3KZnWIQvuQtyX03
         gT4weZGVKfW7JBlG/HhgeMBKgHvI5ZgRMiPzoVt1PEJucdzQ9JDNUsQLsutLgVpCgR
         7QqsvUMMzdysA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-arm-msm@vger.kernel.org, mailingradian@gmail.com
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        vkoul@kernel.org, robh+dt@kernel.org, agross@kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: (subset) [PATCH v4 0/4] SDM670 GPI DMA support
Date:   Mon, 17 Oct 2022 22:05:59 -0500
Message-Id: <166606235840.3553294.10065837804679889388.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221001211934.62511-1-mailingradian@gmail.com>
References: <20221001211934.62511-1-mailingradian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sat, 1 Oct 2022 17:19:30 -0400, Richard Acayan wrote:
> Changes since v3:
>  - keep other compatible strings in driver and add comment
>  - accumulate review tags
> 
> Changes since v2:
>  - change fallback to sdm845 compat string (and keep compat string in
>    driver)
>  - fallback now only affects two SoCs + SDM670
> 
> [...]

Applied, thanks!

[3/4] arm64: dts: qcom: add gpi-dma fallback compatible
      commit: e7e24786cf904e22e0472ac9a5ad35bcbd3fb7a3

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
