Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E8259C0E3
	for <lists+dmaengine@lfdr.de>; Mon, 22 Aug 2022 15:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbiHVNrM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Aug 2022 09:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235257AbiHVNrJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 22 Aug 2022 09:47:09 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2CC2AC41;
        Mon, 22 Aug 2022 06:47:08 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id r69so9423080pgr.2;
        Mon, 22 Aug 2022 06:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=fGiLdsou0tZYmT4+zIed2ZYLs4AlYvI3OzZQVfmavwc=;
        b=h+3b3qQoctgcRO/rt9ZE7PPQejWaX9kgO0V9vw8AlSyXw6gvGwQd88FsnnToDW6gLl
         bQODfVTayiXVYqk/c0ApqsTcpeemy2BYNu10fMpVSLihofCBj1qjV1z1gH3/cl9hZKG2
         QdFrPL9P/j+xRiBpELti3/MH0N4GmRFnFy1BoETlCCy5DIlcQLSH3DzNBuRRYu3zbzrn
         DEDZIJVpsMW05ONzFdVEWP5640Mfcz4VtIqJcREgNd/R7L2XZNX4wd14Q+pUpgd9KkVT
         e+rinr9ncoZ1Y9wHXMvcnOjYCIcO1T55KnsO6ZlKDiXw6xv4Jx+D+gIqdBd4NLCy8fyD
         29Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=fGiLdsou0tZYmT4+zIed2ZYLs4AlYvI3OzZQVfmavwc=;
        b=5J4Qv1gcJoGnmRsIEgMeJqCtALeXgFEdtsVkRC1c/F4MrqxyWslAT6r8r/kzMt5d13
         cdNzdwZc56sT0NK8qcpiKU+1keqwsm/2XAajgzMhyx4TpzqoUKql5EOgXXuBt2n85Sq+
         EVv5AGawBWDXYyMxkDSCBMpCynC5h+cQtPlL+re24zIWYWPNDwK3++6TIpheLQPcZy7a
         VZjLwbBvo8QdBdxvI9TpsR7SwwdUwbAr3HlSDGV3vOqd3slzyfT2kIf64L+WnBC33xf3
         FR5IHwp0VJUvRP467HMm04k0nd4EKjOjgVXmsB89KZnbHxMwLWqn5pkJ9gDU5PqeZANv
         Oi1w==
X-Gm-Message-State: ACgBeo0UWlFiXtheRdODKOMf7nqlayQov/wbXCG6byolQmv/tix2+mh9
        78hNPKQAoXvgHFHkfOwJn2pvlUX32ZfPCf3Xuvs=
X-Google-Smtp-Source: AA6agR4rQ4qXDgbqgDtmWJ0VuGFJUjzEoext5q06uPBFpfl1lCQP9u1dNRYKF+XyaJy4o8EJsy4bUg==
X-Received: by 2002:a65:6a0c:0:b0:429:7ade:490b with SMTP id m12-20020a656a0c000000b004297ade490bmr17105373pgu.621.1661176027666;
        Mon, 22 Aug 2022 06:47:07 -0700 (PDT)
Received: from localhost.localdomain ([182.160.5.243])
        by smtp.gmail.com with ESMTPSA id d62-20020a623641000000b0052d2cd99490sm8696820pfa.5.2022.08.22.06.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 06:47:07 -0700 (PDT)
From:   Tuo Cao <91tuocao@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, vkoul@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, 91tuocao@gmail.com
Subject: [PATCH] dmaengine: qcom: gpi: move read_lock_bh to read_lock in tasklet
Date:   Mon, 22 Aug 2022 21:46:31 +0800
Message-Id: <20220822134631.16547-1-91tuocao@gmail.com>
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

it is unnecessary to call read_lock_bh in a tasklet.

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

