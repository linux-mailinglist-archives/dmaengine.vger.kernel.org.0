Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46245A500B
	for <lists+dmaengine@lfdr.de>; Mon, 29 Aug 2022 17:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiH2PR6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 29 Aug 2022 11:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbiH2PRz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 29 Aug 2022 11:17:55 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9403E83051;
        Mon, 29 Aug 2022 08:17:53 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id q9so7976661pgq.6;
        Mon, 29 Aug 2022 08:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=4S4aGCSHz4Vj3kjY4xlroZ+QjJu7qG4QBgfFBofR0ts=;
        b=JoRczjGA3zzSk5TZIELeyYloCSmHhwFfAPIygEhaYOnBbROWLsCRTyFxEBbfaziVMa
         0Y4Y77U1wlXpIqHC9RL7lAXt5yNFBy1u+xcfKXurOLsyB8hAPGVbDw9/MCPK1yv+CZpk
         zAX4l+VB/ptzOHy3x//ZOp6tUrLXoqoPPqvqhxzTZkMPtfDkewsceDNjCgfhZ3wMDBQA
         2GQ+P7gFs5aazOhz2M1gejXib7f4lGXcTD66ze38i/hWSJhbdUbB10yLUORXooAKSx5U
         KgL9XspHkYdC1PQ97Skmjcbe29NQ1f9pwvZzRUVT0HPKbILNVNGUQwE3nlK6M6Ie14rg
         zrGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=4S4aGCSHz4Vj3kjY4xlroZ+QjJu7qG4QBgfFBofR0ts=;
        b=K60KZqgwINqJhvHjIMSR9HGAeomY+UHXdQl9fEahOZqtUtmhZEMuOHnuLp0TiWMiYp
         abFPVqG9MRsIsl63o0ghBlnu0XNTjLGGuZwFNCsYkbm9TQUsHSUPcoPlHyaWy1i2YDjh
         QOF/Ln+5aOAN2IqnqzqJWBB6jyXgZrk7vSSC0kYL60UsAe7m9QgpBLtssqHJUsikLB87
         SrG5nX3mbl3rG9PTn7g1sS5P48BKzlbpVG0gR/EXus4Z9Ir/dDycirWLW5WS1SAzb1zL
         jTuzdhxhlzahyHwi/GCNF3nROr1ksto/4dc/SaflgiemysVqjWceCehxawEtRS7gENFC
         ErDA==
X-Gm-Message-State: ACgBeo0CHOFdhFXuHVvIvIShZ/ZGl0PwxKe2yKFDYO67tlXoQVRcBSg/
        o4N6QqtzhJSP0OuwoP5wlcQ=
X-Google-Smtp-Source: AA6agR5vifeItEAfN0UZDd0WAe9m4uHYdSPgZeCJrcltqBgUdjQC7kVm47B8ZrzYzmR1KtI2xKehZg==
X-Received: by 2002:a63:d84f:0:b0:428:ee87:3769 with SMTP id k15-20020a63d84f000000b00428ee873769mr14551052pgj.212.1661786272995;
        Mon, 29 Aug 2022 08:17:52 -0700 (PDT)
Received: from localhost.localdomain ([182.160.5.243])
        by smtp.gmail.com with ESMTPSA id cp10-20020a170902e78a00b001750361f42dsm611279plb.125.2022.08.29.08.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 08:17:52 -0700 (PDT)
From:   Tuo Cao <91tuocao@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, vkoul@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, 91tuocao@gmail.com
Subject: [RESEND] dmaengine: qcom: gpi: move read_lock_bh to read_lock in tasklet
Date:   Mon, 29 Aug 2022 23:16:59 +0800
Message-Id: <20220829151659.6071-1-91tuocao@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

It has already disabled softirq in a tasklet,so it is unnecessary to
call read_lock_bh in a tasklet.

Signed-off-by: Tuo Cao <91tuocao@gmail.com>
---
 drivers/dma/qcom/gpi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
index 8f0c9c4e2efd..236005f7dd30 100644
--- a/drivers/dma/qcom/gpi.c
+++ b/drivers/dma/qcom/gpi.c
@@ -1150,9 +1150,9 @@ static void gpi_ev_tasklet(unsigned long data)
 {
 	struct gpii *gpii = (struct gpii *)data;
 
-	read_lock_bh(&gpii->pm_lock);
+	read_lock(&gpii->pm_lock);
 	if (!REG_ACCESS_VALID(gpii->pm_state)) {
-		read_unlock_bh(&gpii->pm_lock);
+		read_unlock(&gpii->pm_lock);
 		dev_err(gpii->gpi_dev->dev, "not processing any events, pm_state:%s\n",
 			TO_GPI_PM_STR(gpii->pm_state));
 		return;
@@ -1163,7 +1163,7 @@ static void gpi_ev_tasklet(unsigned long data)
 
 	/* enable IEOB, switching back to interrupts */
 	gpi_config_interrupts(gpii, MASK_IEOB_SETTINGS, 1);
-	read_unlock_bh(&gpii->pm_lock);
+	read_unlock(&gpii->pm_lock);
 }
 
 /* marks all pending events for the channel as stale */
-- 
2.17.1

