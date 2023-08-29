Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB31378CBA0
	for <lists+dmaengine@lfdr.de>; Tue, 29 Aug 2023 20:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237602AbjH2SBI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 29 Aug 2023 14:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235241AbjH2SAg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 29 Aug 2023 14:00:36 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0FF011B;
        Tue, 29 Aug 2023 11:00:33 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-68a3ced3ec6so3736937b3a.1;
        Tue, 29 Aug 2023 11:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693332033; x=1693936833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HHaSrUHWKq22c6/csllPkR1MWun8gSPfHwy/CrQ/MWw=;
        b=jHYNc+qHX5PWxDPOr5+lj3PXKa9+qui0nfFpsjUawM3IckVlfMi6PS+QmqRejFEI0t
         5G+0/zGSfHom4i5KUhOXlogicf8NzIyfkYdHgMjH6Gnhl5zkv3bQ5UdzzkBI/U/rz1Bb
         79ggH5675CQTVLc+qxkz7Gj31QBUiYeclqQI0Jzm/3S1MSK9AsLQ8PZfFbmRSJfPDUlb
         a7rwAg52Y2smCx6kTLOlxGEU+Mb0dmSiZidtXvmQYHtCy9r3njelYD8ZgLlv1cIGjmvN
         jYnTjuK/lENcW6mtgJIjcSqGfvJSSy9DqpJxJKBD4dFxyBMI1mdTVhorxcredoYlTq2y
         SL7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693332033; x=1693936833;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HHaSrUHWKq22c6/csllPkR1MWun8gSPfHwy/CrQ/MWw=;
        b=Hj6R9Pk+6e7ol1kc2toMfb0ghrajnsncax75KsF2tYxW9jipAEZAyjcqADwn9HyBxY
         jKx1J3wWIgWg8kfAf0dgUJMeVNXDW7UbRng8SxdrxAYql7RCO7jC6eVfppzpOFDUvI/O
         5vLh/2BoVYfmFDC3NFZpiOifAm9ae5PlSQqWDd/I0P5ekUmL+lkkhaPZPrnzGYiNsQFv
         qr45+H8eERkjhyoAoa5wmtX8wX6Us3vAv7mnPe6i+wOBKvMHg/PIDo5MoiAIf1/ygRUZ
         0to3Njl6T5tPtELG2tGVgrlHQI14iTQQYTMK0fJY7EoToon67I6OM8dZY4wc85ahdzl5
         YRgA==
X-Gm-Message-State: AOJu0YzNB6Uur7Vxvs1MSeYjFZT2UpFmJjAGXWfyRa4MfcvXmDuEuEJa
        rwh5CSX33UWJ5chMlkwlAn8=
X-Google-Smtp-Source: AGHT+IET8lPq9rFGe1yJQbX1R9V7hGIScp5mNLrdAlzxu0lN3q+6e6vQtRLyrk6QhK7LWOOwuyBrww==
X-Received: by 2002:a05:6a20:7f86:b0:134:8d7f:f4d9 with SMTP id d6-20020a056a207f8600b001348d7ff4d9mr50257pzj.52.1693332033202;
        Tue, 29 Aug 2023 11:00:33 -0700 (PDT)
Received: from localhost.localdomain ([2409:40c2:100e:2f74:981c:2bef:d96d:9de7])
        by smtp.gmail.com with ESMTPSA id c5-20020a62e805000000b00689f10adef9sm8782870pfi.67.2023.08.29.11.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 11:00:32 -0700 (PDT)
From:   coolrrsh@gmail.com
To:     fenghua.yu@intel.com, dave.jiang@intel.com, vkoul@kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Rajeshwar R Shinde <coolrrsh@gmail.com>
Subject: [PATCH v2] dmaengine: idxd: Remove redundant memset() for eventlog allocation
Date:   Tue, 29 Aug 2023 23:30:27 +0530
Message-Id: <20230829180027.6357-1-coolrrsh@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Rajeshwar R Shinde <coolrrsh@gmail.com>

dma_alloc_coherent function already zeroes the array 'addr'.
So, memset function call is not needed.

This fixes warning such as:
drivers/dma/idxd/device.c:783:8-26:
WARNING: dma_alloc_coherent used in addr already zeroes out memory,
so memset is not needed.

Signed-off-by: Rajeshwar R Shinde <coolrrsh@gmail.com>
---
v1->v2
Renamed the subject line
---
 drivers/dma/idxd/device.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 5abbcc61c528..7c74bc60f582 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -786,8 +786,6 @@ static int idxd_device_evl_setup(struct idxd_device *idxd)
 		goto err_alloc;
 	}
 
-	memset(addr, 0, size);
-
 	spin_lock(&evl->lock);
 	evl->log = addr;
 	evl->dma = dma_addr;
-- 
2.25.1

