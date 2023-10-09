Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD8FA7BD325
	for <lists+dmaengine@lfdr.de>; Mon,  9 Oct 2023 08:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345202AbjJIGNJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Oct 2023 02:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345250AbjJIGNB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 9 Oct 2023 02:13:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B7CC5;
        Sun,  8 Oct 2023 23:12:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 466E2C433C8;
        Mon,  9 Oct 2023 06:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696831972;
        bh=Y3aPPA/Uz59BqLA+bMigC55yHKyVdJyWquDM4i6a01o=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=vH15VrEzkmvSK9goSKxnj2/xW763xAdTg47ySmpP5UFyiznUZhT9JFpySbMAznxdc
         8I+HDfyKhpvaOD8Y3+9eI3e5ahPk/V1lcqFomxc/FtdBnSTNoJkYo8Ht+dGyqhoZtO
         eQrDEl7FkwQtuexJDi0l6M9Z2CBJReGTQNfD+2iAj1qIAJV/IPs+n9VaS90E8qJP26
         Wy26h1HDfQBmXxYI3LPui8JKYYu0VhKPxf7abQr6d4SLvNdG+LERs/VWPut8GyUArU
         QFShUzYYCLVq5k9ncgoXK4c3LGnUTerojUoZiCmWNqm7QVSGN1u3yeKt82MUsL4Jmb
         WQRfLRAiCnUvQ==
From:   Vinod Koul <vkoul@kernel.org>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc:     stable@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231004155024.2609531-1-amelie.delaunay@foss.st.com>
References: <20231004155024.2609531-1-amelie.delaunay@foss.st.com>
Subject: Re: [PATCH 1/2] dmaengine: stm32-dma: fix stm32_dma_prep_slave_sg
 in case of MDMA chaining
Message-Id: <169683196986.44135.1324779584069715200.b4-ty@kernel.org>
Date:   Mon, 09 Oct 2023 11:42:49 +0530
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


On Wed, 04 Oct 2023 17:50:23 +0200, Amelie Delaunay wrote:
> Current Target (CT) have to be reset when starting an MDMA chaining use
> case, as Double Buffer mode is activated. It ensures the DMA will start
> processing the first memory target (pointed with SxM0AR).
> 
> 

Applied, thanks!

[1/2] dmaengine: stm32-dma: fix stm32_dma_prep_slave_sg in case of MDMA chaining
      commit: 2df467e908ce463cff1431ca1b00f650f7a514b4
[2/2] dmaengine: stm32-dma: fix residue in case of MDMA chaining
      commit: 67e13e89742c3b21ce177f612bf9ef32caae6047

Best regards,
-- 
~Vinod


