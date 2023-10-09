Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF187BD319
	for <lists+dmaengine@lfdr.de>; Mon,  9 Oct 2023 08:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345180AbjJIGMa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Oct 2023 02:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345205AbjJIGM3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 9 Oct 2023 02:12:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B8DF7;
        Sun,  8 Oct 2023 23:12:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D6A1C433C8;
        Mon,  9 Oct 2023 06:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696831943;
        bh=5f+2wJGQzlRojPEbL9LmQ2JKb0J4iRCgoHbmh6Ge8AY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=etPvgShYg/c7J1yi7u8i9OgwL1vw+pcIjTb9b38F4BBC/Yp+N1HbVuTo5qyZalDMb
         KE14h/1H8M/LSLTckJmuIBVL2Y7jfP61Wi9tYNVavCz1E3WnHYYHpG4rTrUETVOdr2
         dFl+ZTs4o43/KtRuQDKkCOND/FAXTr5ZC4sQtpNIl3GUDfb4Oh9K3gLO20SagmFhFC
         BiITolNSU5MaLSbcQXFJD5lc/7jPZyzvbFS2g7Qhh8tm3yrlzYMAyUHcq3dK0VbPIy
         RmL9b9zbt59IMg3pjH/33qNsydg6xhCPYzXxwjq0AepkoSJEaoVKJbpHJnrxZFBEOx
         E74M61gsLrnAw==
From:   Vinod Koul <vkoul@kernel.org>
To:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
In-Reply-To: <20231006213835.332848-1-robh@kernel.org>
References: <20231006213835.332848-1-robh@kernel.org>
Subject: Re: [PATCH] dmaengine: Drop unnecessary of_match_device() calls
Message-Id: <169683193991.43997.3040899490383872549.b4-ty@kernel.org>
Date:   Mon, 09 Oct 2023 11:42:19 +0530
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


On Fri, 06 Oct 2023 16:38:35 -0500, Rob Herring wrote:
> If probe is reached, we've already matched the device and in the case of
> DT matching, the struct device_node pointer will be set. Therefore, there
> is no need to call of_match_device() in probe.
> 
> 

Applied, thanks!

[1/1] dmaengine: Drop unnecessary of_match_device() calls
      commit: c48de45d4cefc5a2f0d0e4101c39884326ac704c

Best regards,
-- 
~Vinod


