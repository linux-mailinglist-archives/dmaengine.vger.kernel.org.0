Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C3E4D1079
	for <lists+dmaengine@lfdr.de>; Tue,  8 Mar 2022 07:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243214AbiCHGuy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 8 Mar 2022 01:50:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240464AbiCHGux (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 8 Mar 2022 01:50:53 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E10F21E2C;
        Mon,  7 Mar 2022 22:49:58 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id ge19-20020a17090b0e1300b001bcca16e2e7so1378729pjb.3;
        Mon, 07 Mar 2022 22:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=stuWRE0fpV+3ocvFzIL+5jqWnax7n9BxoKZw/kt5w9s=;
        b=oxGaiEBcfwWHbVvp3IFQUeN7hyLS6AXjzlWejiDsHxawo0sP2VMBimKyr998lAGaVF
         GoBjrG5hySVY79T043Vc5joODZYEPkRd8d/WOtNM4sFQkDDmQCPgzbNIZM9u2SfWxLCr
         0jp8nyBJ/egmQYF5RFoY0ck/fHosVg2FNQ6Jq28tQiIlJNNLFKmz4TXd5ToQE2Iu7YUb
         MAWw2ASjf3LY15lsQjmiSXO8rSR9yxfDuEb4TusIZAO/KyfFhKksibgsvconX32s56dj
         Gb44QGPB3ryFKftZubJqss1awGVMnnZFhAllSPeDwZzmEMTFqVe5WFZua0vUC8k8WSgG
         //8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=stuWRE0fpV+3ocvFzIL+5jqWnax7n9BxoKZw/kt5w9s=;
        b=NKt7n9U4tWfj6OyZ/kbbxq00pU2fUWUIm/CAtWg/wK18TRPBht4dBH1M5E3CrWD91O
         wXL4wQj0WYG7f9G6JEIevvHi2xAmlnQ1p/gw9clifL47h8kotPeq64OHVJ2PAva5R9nP
         lGZrm4gRBeDZ/Qk9leuk4SPB5R0mlMU8CWcbgpCuX09L44uM/l6XmNrU0ERaVWROj36Z
         9BTVlaoryX90ruIYBRg87ZhY+ajJ3Chwxvu6fKbEh0pqUhGOSFMAl2LDPzW6Zpk0DODU
         NhalRnekz3+fMzGdQzHTcCMKXf1PUJc4xkuLQp2r/bb8LB8MwS7QcxtfZ2zkGXya9HlJ
         RaOw==
X-Gm-Message-State: AOAM531q+kfMiME7rvfpU6WJO0XOVdl4oU6zu2gZUtLTVwUBTtu0GenA
        E3H89NaBd6X4XRWUzu4WsFk=
X-Google-Smtp-Source: ABdhPJwKmhYpZGUB3BAzsBmM83UVCHwA6d9ECoD/UUlYxDz3NYGSljEOnbghv4mMyZkTHx+wvv8S1g==
X-Received: by 2002:a17:903:40c3:b0:151:c8a2:1c46 with SMTP id t3-20020a17090340c300b00151c8a21c46mr16203301pld.141.1646722197624;
        Mon, 07 Mar 2022 22:49:57 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id 23-20020a17090a0d5700b001bc3c650e01sm2342391pju.1.2022.03.07.22.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 22:49:57 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Zidan Wang <zidan.wang@freescale.com>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] dmaengine: imx-sdma: Fix error checking in sdma_event_remap
Date:   Tue,  8 Mar 2022 06:49:51 +0000
Message-Id: <20220308064952.15743-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

of_parse_phandle() returns NULL on errors, rather than error
pointers. Using NULL check on grp_np to fix this.

Fixes: d078cd1b4185 ("dmaengine: imx-sdma: Add imx6sx platform support")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/dma/imx-sdma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 75ec0754d4ad..0be1171610af 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1869,7 +1869,7 @@ static int sdma_event_remap(struct sdma_engine *sdma)
 	u32 reg, val, shift, num_map, i;
 	int ret = 0;
 
-	if (IS_ERR(np) || IS_ERR(gpr_np))
+	if (IS_ERR(np) || !gpr_np)
 		goto out;
 
 	event_remap = of_find_property(np, propname, NULL);
@@ -1917,7 +1917,7 @@ static int sdma_event_remap(struct sdma_engine *sdma)
 	}
 
 out:
-	if (!IS_ERR(gpr_np))
+	if (gpr_np)
 		of_node_put(gpr_np);
 
 	return ret;
-- 
2.17.1

