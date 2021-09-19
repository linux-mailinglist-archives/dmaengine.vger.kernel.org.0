Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21200410BFE
	for <lists+dmaengine@lfdr.de>; Sun, 19 Sep 2021 16:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbhISOpd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 19 Sep 2021 10:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232862AbhISOpb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 19 Sep 2021 10:45:31 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9368CC06175F;
        Sun, 19 Sep 2021 07:44:06 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id q68so14762195pga.9;
        Sun, 19 Sep 2021 07:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eYQdmjVuswA5ajxv1Qre9oW4YHwul4VIctgt9MF9joU=;
        b=U7ilE28J7eBa1z7cBaTpnLhLvo7ti/uvif1oyEmXbi9xeLY6UOh9B4O8f4EJTuk7r3
         6gXVGmR0zfl3SJbz1PPKp+VlmiruuK4MuXlUj4z1wJkkzUXkfOdbkvKzm23qdy3J0iyt
         S5Ryb3+RxrAxMVpZSaeuPArjCZXt+OekfVcCqByy1wd4aHdUUp5eByEuCV1MBFF59cV4
         3TrIIrSGlaNIInLCKichmlTUInEoBWnbrn2Y6qYLZ0nEcyWxyj19aL+qaY1HGDi8QlLS
         IW8oTe6OW28bP4rmzZ2OOqyEVB9sQXyZl09sV8usFa5VniZ3r3VaS6cFDeICgUhRvkD7
         LSvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eYQdmjVuswA5ajxv1Qre9oW4YHwul4VIctgt9MF9joU=;
        b=YG7jmVffCDKJTzO+yRQNCL5NCsjerK+DxXFXUhsgKvgAkUpS6ZPYcEQ5AkxI0k2Wmv
         eJRuuFVPF5wIOhoDKF0ktc9rlzdezRd0rn1wnejMKg+/jc7/JkG1JQTggO1lp1++zmKc
         DnKgawFsfbWGuPLljSlhePfKZ/7dY62U6siEbfN/rbWRr4QqRhJQPKItk0PMzXMf/UX+
         WtFzDKqFF7JxlGWFDBqTUHj2RoyaZtdiK9HZuKRHQmbjB7ID4zMoZf98GC/icOJFIoCA
         vOtkjAQ7Qi9YwMfv8e5l7uRS+6M420cw9/0N2XfQoePpwbo2Jy8xNkihubKPvRBvyN2v
         FZUA==
X-Gm-Message-State: AOAM531a5WuKCyjFx5odQMAKgR9G9dcZ5jaBi+jROB8VJxav2ngr4Ha3
        OAtPW+ploHc7mSrqRYH9QmniV6ETiQNQqAhL
X-Google-Smtp-Source: ABdhPJy1Hapx/Wk4MQhozXahELgkxD2JVEC8Gw+h8eANYkNMFUD6FNzGPqC7xrl7EYkK++Ym2+7lkw==
X-Received: by 2002:a62:7a11:0:b0:443:937:9fd1 with SMTP id v17-20020a627a11000000b0044309379fd1mr17487583pfc.47.1632062645885;
        Sun, 19 Sep 2021 07:44:05 -0700 (PDT)
Received: from skynet-linux.local ([106.201.127.154])
        by smtp.googlemail.com with ESMTPSA id c9sm16270427pjg.2.2021.09.19.07.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 07:44:05 -0700 (PDT)
From:   Sireesh Kodali <sireeshkodali1@gmail.com>
To:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Sireesh Kodali <sireeshkodali1@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION)
Subject: [PATCH 1/3] doc: dmaengine: client-api: Add immediate commands in the DMA client API
Date:   Sun, 19 Sep 2021 20:13:19 +0530
Message-Id: <20210919144322.31977-2-sireeshkodali1@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210919144322.31977-1-sireeshkodali1@gmail.com>
References: <20210919144322.31977-1-sireeshkodali1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Immediate commands are used by the IPA driver to send commands to the
microcontroller over BAM. These are different from PREP_CMD.

Signed-off-by: Sireesh Kodali <sireeshkodali1@gmail.com>
---
 Documentation/driver-api/dmaengine/provider.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/driver-api/dmaengine/provider.rst b/Documentation/driver-api/dmaengine/provider.rst
index ddb0a81a796c..f92a0bae06a0 100644
--- a/Documentation/driver-api/dmaengine/provider.rst
+++ b/Documentation/driver-api/dmaengine/provider.rst
@@ -571,6 +571,16 @@ DMA_CTRL_REUSE
     writes for which the descriptor should be in different format from
     normal data descriptors.
 
+- DMA_PREP_IMM_CMD
+
+  - If set, the client driver tells DMA controller that passed data in DMA
+    API is immediate command data.
+
+  - Interpretation of command data is DMA controller specific. It can be
+    used for issuing immediate commands to other peripherals/register
+    reads/register writes for which the descriptor shoudl be in a
+    different format from normal data descriptors.
+
 - DMA_PREP_REPEAT
 
   - If set, the transfer will be automatically repeated when it ends until a
-- 
2.33.0

