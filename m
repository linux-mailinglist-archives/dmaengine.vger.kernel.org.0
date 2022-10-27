Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D7E60EF62
	for <lists+dmaengine@lfdr.de>; Thu, 27 Oct 2022 07:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234325AbiJ0FOy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 27 Oct 2022 01:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233917AbiJ0FOu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 27 Oct 2022 01:14:50 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D59120BD;
        Wed, 26 Oct 2022 22:14:47 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id b11so498534pjp.2;
        Wed, 26 Oct 2022 22:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VVZZUSIC9z7s5n7uGatrD9g/rvuN1O14UMugKzBE6CA=;
        b=CbSV+L1onJuzwTvZbJ6p7505PoKAEODSzSp5UTQp8VhXjhAO8KIwwZ/0iAxmBxzLRK
         LcPVrI2i770a7EveFZYeVdJVJp1VzggM8nYZVyqgH6TfzW7yB819TeVXvMIyqTtd+zuz
         iz7HA6bB2dUNvcLDXavrvjRYBZF1xuhn9UDTualnBjbT730dLYV8QRFF0JqvrJHOtyYg
         jP9H5yKpAZiIPtjeW/yKcRKFGvqHhHA4QaM1orj0rS6LzejB/qI1+bFrx2vNiLLA1PNj
         gzoA7NLfglyguLQXCiDc0UO+VBl9rmLVInN4+yo/pctzuVjmMadzCsmoZ2hkD0fsiroG
         6vdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VVZZUSIC9z7s5n7uGatrD9g/rvuN1O14UMugKzBE6CA=;
        b=lnA+vzXALl2mQhAU6pTHq/NjSExBnR7joju2hqy9Mw08Fs376hJl/TxGrCkmbohfEO
         cn2KDpi4gFGVsvXSkDZdnu+MP33sOS+o+wB3LuBLialWkxazRhVnSr6OoC4hbg8H9PIL
         JhFb4djJwA/uvR4aPupmx+e16h23FRqnruHvbfVeuH8fZGW4GT8H8yYoiG0PThrEL36D
         wMpglr30MhIZegEWeOxjosu/h3IxjYVRQoZgAwvV/yLn5ZrIPaUaXeftiG5DRegS67q/
         vm+5SJ4ZPZ+bTS82SMru+1CuLlxDyN7qxG8+AKQtpoE5s0U8XV6vAubf2XZxa51PTNit
         X7Zg==
X-Gm-Message-State: ACrzQf1PZ4im5OebbVf3xgJKVgQ1g5HYu43Rha11OVqNIk1LhQcylCry
        dQGpSPa9kiKn81o9BfGyJJk=
X-Google-Smtp-Source: AMsMyM6CLsp43+za32DC0T/iF4tMwJB0ZXqJWohEqTxVaF5BQSe5W0EDmjIj6f9370Ng7ozT2Ijy8A==
X-Received: by 2002:a17:903:2442:b0:186:ef89:7b41 with SMTP id l2-20020a170903244200b00186ef897b41mr126475pls.164.1666847686611;
        Wed, 26 Oct 2022 22:14:46 -0700 (PDT)
Received: from skynet-linux.local ([2406:7400:61:dcaa:bb0:9908:b137:b0b4])
        by smtp.googlemail.com with ESMTPSA id s8-20020a170902ea0800b001869ba04c83sm216713plg.245.2022.10.26.22.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 22:14:46 -0700 (PDT)
From:   Sireesh Kodali <sireeshkodali1@gmail.com>
To:     vkoul@kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     dmaengine@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Sireesh Kodali <sireeshkodali1@gmail.com>
Subject: [PATCH v2 2/3] dmaengine: Add support for immediate commands in the client API
Date:   Thu, 27 Oct 2022 10:44:28 +0530
Message-Id: <20221027051429.46593-3-sireeshkodali1@gmail.com>
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

Immediate commands are needed by the IPA network driver, so that it can
send commands via BAM to the IPA microcontroller.

Signed-off-by: Sireesh Kodali <sireeshkodali1@gmail.com>
---
 include/linux/dmaengine.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index c923f4e60f24..8da96bb50a63 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -190,6 +190,9 @@ struct dma_interleaved_template {
  *  transaction is marked with DMA_PREP_REPEAT will cause the new transaction
  *  to never be processed and stay in the issued queue forever. The flag is
  *  ignored if the previous transaction is not a repeated transaction.
+ *  @DMA_PREP_IMM_CMD: tell the driver that the data passed to the DMA API is
+ *  immediate command data and the descriptor should be in a different format
+ *  from the normal data and descriptor
  */
 enum dma_ctrl_flags {
 	DMA_PREP_INTERRUPT = (1 << 0),
@@ -202,6 +205,7 @@ enum dma_ctrl_flags {
 	DMA_PREP_CMD = (1 << 7),
 	DMA_PREP_REPEAT = (1 << 8),
 	DMA_PREP_LOAD_EOT = (1 << 9),
+	DMA_PREP_IMM_CMD = (1 << 10),
 };
 
 /**
-- 
2.38.1

