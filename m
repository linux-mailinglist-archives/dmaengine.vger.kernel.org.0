Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3862D60EF66
	for <lists+dmaengine@lfdr.de>; Thu, 27 Oct 2022 07:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234437AbiJ0FPS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 27 Oct 2022 01:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234369AbiJ0FPD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 27 Oct 2022 01:15:03 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13AE574CCC;
        Wed, 26 Oct 2022 22:15:01 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id b29so390705pfp.13;
        Wed, 26 Oct 2022 22:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mOGRH9NXdrfqgbNenNuBmO6i+ru+iWERjL2qQ8bxKOc=;
        b=GGl2VErwxlzjseiEoId4PZOsXmsgVi2Udhz+DvniQ41BY8OPcCl1DVdKnUs8R7cY71
         sS4is/og8XoTndtqK9zcSUX8Ek/9GYYe163+5S6qZUAhGz7hDIA73bhnXCTusQ6tppnQ
         Cw15UZ2XJaiqZlWNlfl56JtY8QJ8523iRbkBii3Qnhagc1nTeUWNdlz0HkgJAKcanEvW
         2fSNowmzImpuC1sa0tih6zRYsZlmGo+iCy1wDmyf9LMXKi9qucQYjiV0oguqFuwJRZL1
         fRt1QEh2+W8uhteWX4b6LBfgKyIgKVi1kmvKxuDQMthf72CFVPtEG+WV7Mh4fn8vbIbv
         xLIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mOGRH9NXdrfqgbNenNuBmO6i+ru+iWERjL2qQ8bxKOc=;
        b=C4+Dp2A/stO9NN6kq1qjqGMnicgufOAkUAnE3X2y21tNisgoBaU+HFyTuaCv5+Lj30
         aWtTi8RliSPEad4xF9a+4N00LPfdBrZsiX3Lw0jIrVUfZl6ETgzxGOTkHyicYrf6nusu
         bAawtwYnF+KnUrPsDHDkdLrgCmMfz1YJZU5S6ekhgMiq78xEhIHQsNuA7kWQc2EY9rkD
         VnHHoivQ1ATCj9ZuAowNyKS2W23+u1C73+UxRwS0nojJcK3lkzOpOYESZKYvh5rj60HO
         OVODnawV1atoMUhqXyNlLPKvzMISEiKgO+oTEU5xbmDfS+MYuJ3u5aSvQ8A/YVeL8ZrN
         /fIA==
X-Gm-Message-State: ACrzQf1SNRk8H9j6vES13EauemiiN9dQ52o46euEcb8etozxlFrLtssd
        IAhCmq57UYwICeYuGvyBtEiZLf4sd+rH7w==
X-Google-Smtp-Source: AMsMyM7kLAPyboZ1bo3FBbafLPqEEmUiEqpipe4WaWFsn+1q7Q+Y6J3nXYCe8ac9I5OcmiDy5RLvaw==
X-Received: by 2002:a17:902:900a:b0:178:77c7:aa28 with SMTP id a10-20020a170902900a00b0017877c7aa28mr46692384plp.3.1666847690404;
        Wed, 26 Oct 2022 22:14:50 -0700 (PDT)
Received: from skynet-linux.local ([2406:7400:61:dcaa:bb0:9908:b137:b0b4])
        by smtp.googlemail.com with ESMTPSA id s8-20020a170902ea0800b001869ba04c83sm216713plg.245.2022.10.26.22.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 22:14:49 -0700 (PDT)
From:   Sireesh Kodali <sireeshkodali1@gmail.com>
To:     vkoul@kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     dmaengine@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Sireesh Kodali <sireeshkodali1@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: [PATCH v2 3/3] dmaengine: bam_dma: Add support for immediate commands
Date:   Thu, 27 Oct 2022 10:44:29 +0530
Message-Id: <20221027051429.46593-4-sireeshkodali1@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221027051429.46593-1-sireeshkodali1@gmail.com>
References: <20221027051429.46593-1-sireeshkodali1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Immediate commands are handled similar to regular commands that are sent
over BAM, only a different flag needs to be set. The immediate command
support is needed to implement support for IPA v2.x, which rely on BAM
immediate commands to send commands to the IPA microcontroller.

Signed-off-by: Sireesh Kodali <sireeshkodali1@gmail.com>
---
 drivers/dma/qcom/bam_dma.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index 2ff787df513e..3135a3e4a167 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -58,6 +58,7 @@ struct bam_desc_hw {
 #define DESC_FLAG_EOB BIT(13)
 #define DESC_FLAG_NWD BIT(12)
 #define DESC_FLAG_CMD BIT(11)
+#define DESC_FLAG_IMM BIT(8)
 
 struct bam_async_desc {
 	struct virt_dma_desc vd;
@@ -693,6 +694,8 @@ static struct dma_async_tx_descriptor *bam_prep_slave_sg(struct dma_chan *chan,
 		do {
 			if (flags & DMA_PREP_CMD)
 				desc->flags |= cpu_to_le16(DESC_FLAG_CMD);
+			else if (flags & DMA_PREP_IMM_CMD)
+				desc->flags |= cpu_to_le16(DESC_FLAG_IMM);
 
 			desc->addr = cpu_to_le32(sg_dma_address(sg) +
 						 curr_offset);
-- 
2.38.1

