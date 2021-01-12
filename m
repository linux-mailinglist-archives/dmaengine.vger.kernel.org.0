Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDA12F39BF
	for <lists+dmaengine@lfdr.de>; Tue, 12 Jan 2021 20:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727622AbhALTNS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 Jan 2021 14:13:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbhALTNS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 12 Jan 2021 14:13:18 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB024C061575;
        Tue, 12 Jan 2021 11:12:37 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id 22so2895199qkf.9;
        Tue, 12 Jan 2021 11:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q26h93gSS0y9iR+Qm0MkHYb24X55fLtSwxVQagnZbx8=;
        b=cpxV9/KULU/QTHufkILmQ5sNOh25AE7CPuNpwLyyEONMdKty6a6etdY25354NNYe9Y
         fMnwt0fXnXouOqMn8LhEwmbSg2K5ccTi7+tLRZH2bkzApX+2coDyIgWyLm7s/uAVG7kr
         BRsTt5tFdUv4f198LQxZ8KvqLn62KVGfkhOTLGXZesf/kyEbnr7lUkB5vnAGjD6cOoBv
         OkP4DshKIUhtJx4dI1W3724iqSoMAyNtiU9wil+YMxqSloNo5iLUSA52w9YSpv5Bf6gz
         c/dvsMkB2992CAVkuH5ak0GFGxeag2KmMWCht6DBiIhS8WhO87e2WpuTCv/OEEb/+axK
         aYZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q26h93gSS0y9iR+Qm0MkHYb24X55fLtSwxVQagnZbx8=;
        b=M+vUKnGhqhWA4L9ZDQ8coyLVplWI58eXvb3dFgbr9fhcBvSMMuFedpVureYklLfXN1
         MXGps8l5eSg7kagqtg1bQnGgj4yf9IOHXHWyeyBqr3pv0+Y4PPVeaUAdTKZ7NM1OKg9r
         cU5teAMjYYBswF0EmVXUBTT+NmKLh0GBLAOHnEUiB2p41XA3jhR6w2GX7QfmhCKA6lK6
         j50hAPnn7ZdpHWZuIPrJJvrcI0BnJVAlkwUNyRCGkv1EevU4iZXdQGNHfkiMGd9z7sT7
         LG8QM7TNBfYVNmkeuq911Ca6/g6E2WlhM1eGTTD1Nv8wcG3wEFE4/VUyLocAkipf2meJ
         zF9g==
X-Gm-Message-State: AOAM532chSHoGTcsMWsM5zo9m/PiFO7GTgavSgnhSMe4hfRgu9Btydg7
        RUh90AwIAaZr4IhlLV/Sspg=
X-Google-Smtp-Source: ABdhPJzltk2bVl0P/Jw4bElA4gsCXcb3W8L4e7Evd9K3CYkp7UT8AjEXsDMdfDM370Ssk8naPBZYVw==
X-Received: by 2002:ae9:de45:: with SMTP id s66mr866170qkf.197.1610478756993;
        Tue, 12 Jan 2021 11:12:36 -0800 (PST)
Received: from localhost.localdomain ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id u5sm1861674qka.86.2021.01.12.11.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 11:12:36 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] dmaengine: qcom: Always inline gpi_update_reg
Date:   Tue, 12 Jan 2021 12:12:14 -0700
Message-Id: <20210112191214.1264793-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

When building with CONFIG_UBSAN_UNSIGNED_OVERFLOW, clang decides not to
inline gpi_update_reg, which causes a linkage failure around __bad_mask:

ld.lld: error: undefined symbol: __bad_mask
>>> referenced by bitfield.h:119 (include/linux/bitfield.h:119)
>>>               dma/qcom/gpi.o:(gpi_update_reg) in archive drivers/built-in.a
>>> referenced by bitfield.h:119 (include/linux/bitfield.h:119)
>>>               dma/qcom/gpi.o:(gpi_update_reg) in archive drivers/built-in.a

If gpi_update_reg is not inlined, the mask value will not be known at
compile time so the check in field_multiplier stays in the final
object file, causing the above linkage failure. Always inline
gpi_update_reg so that this check can never fail.

Fixes: 5d0c3533a19f ("dmaengine: qcom: Add GPI dma driver")
Link: https://github.com/ClangBuiltLinux/linux/issues/1243
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/dma/qcom/gpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
index 1a0bf6b0567a..e48eb397f433 100644
--- a/drivers/dma/qcom/gpi.c
+++ b/drivers/dma/qcom/gpi.c
@@ -584,7 +584,7 @@ static inline void gpi_write_reg_field(struct gpii *gpii, void __iomem *addr,
 	gpi_write_reg(gpii, addr, val);
 }
 
-static inline void
+static __always_inline void
 gpi_update_reg(struct gpii *gpii, u32 offset, u32 mask, u32 val)
 {
 	void __iomem *addr = gpii->regs + offset;

base-commit: 7c53f6b671f4aba70ff15e1b05148b10d58c2837
-- 
2.30.0

