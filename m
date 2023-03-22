Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B757D6C49FF
	for <lists+dmaengine@lfdr.de>; Wed, 22 Mar 2023 13:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjCVMLS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Mar 2023 08:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjCVMLP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 Mar 2023 08:11:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAEA35DCB4
        for <dmaengine@vger.kernel.org>; Wed, 22 Mar 2023 05:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679487027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=hZCSBOFZs4bkOWaMU96a/OIFoJth3tDCdyrQdmx4OyE=;
        b=M7bA65Go1wbFEHxwAn0wuppM3j7pgtdsQ3lG6G9Ss2tGyclHWoUVCNdsC8idn7/qLOK1Pr
        SemgP/4Vba57fdG6D8IBGgg+2HFee+jnpFw/PEChy5Onw+Fo0B4rYYPn0yhwc6TpqgADkT
        8p4I8uP9W4CCz+GIF7tNWQarTBoX0f0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-iJQQQJy2PT6EtAYJrGYsTQ-1; Wed, 22 Mar 2023 08:10:22 -0400
X-MC-Unique: iJQQQJy2PT6EtAYJrGYsTQ-1
Received: by mail-qv1-f69.google.com with SMTP id a15-20020a0562140c2f00b005ad28a23cffso9066683qvd.6
        for <dmaengine@vger.kernel.org>; Wed, 22 Mar 2023 05:10:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679487006;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hZCSBOFZs4bkOWaMU96a/OIFoJth3tDCdyrQdmx4OyE=;
        b=6J2feBKXB8vxVaybhrMsQARehUxDefG4DEn5y5IBNmxYgrfxOP12Dqm914veubln6E
         sqiN75Sxgan6Wt8nm5GZ6XSjDAalsr/VugIY0RznD3gSEsf9BAAYpL42ut0Y++SGibVj
         afeNTDpp+dJn6X851EdsKOtC9jNsISebfhMN08YO0roCrzlYwQ8u9clqm4sGmruFM6DF
         P8IdF9qYzB+y2NBI75OT5S6BILizFrb8GAmZYanQrCRMbF64n2g2tX3Ea/qPGkVwt7vt
         +Qus5hCLVvT56ArySrwNGkqrni0Wgbn8dmm32YvK7WHgyPIJHHkdvW4JIPeyN8NfPBbG
         i6lg==
X-Gm-Message-State: AO0yUKXcQkj7xqK0D7PFbCjS10nJnkM6H54Yda3PTluSyTpxxPvwAfGB
        VOWSPvzCjXS+DlqS3hItAlwgjtbvXsTTh2jrmb36RH6Fv5xuolJPI210VCLtx1Z+jqzwah+mFo/
        nzcSlSWmolMIGEBDJG69z
X-Received: by 2002:a05:622a:1354:b0:3bf:dc7d:2221 with SMTP id w20-20020a05622a135400b003bfdc7d2221mr5538831qtk.47.1679487006006;
        Wed, 22 Mar 2023 05:10:06 -0700 (PDT)
X-Google-Smtp-Source: AK7set9kJIiglNnHWmwnAgvPqP7BHrdzvpjmZvpPWl/1axq5Z7bYHV045R+cDjo20tgQiJGFKa42Xw==
X-Received: by 2002:a05:622a:1354:b0:3bf:dc7d:2221 with SMTP id w20-20020a05622a135400b003bfdc7d2221mr5538790qtk.47.1679487005680;
        Wed, 22 Mar 2023 05:10:05 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id b17-20020ac86791000000b003b9bb59543fsm9757855qtp.61.2023.03.22.05.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 05:10:05 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     ldewangan@nvidia.com, jonathanh@nvidia.com, vkoul@kernel.org,
        thierry.reding@gmail.com, nathan@kernel.org,
        ndesaulniers@google.com
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] dmaengine: tegra-apb: remove unused tdma_read function
Date:   Wed, 22 Mar 2023 08:10:01 -0400
Message-Id: <20230322121001.2569909-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

clang with W=1 reports
drivers/dma/tegra20-apb-dma.c:236:19: error: unused function
  'tdma_read' [-Werror,-Wunused-function]
static inline u32 tdma_read(struct tegra_dma *tdma, u32 reg)
                  ^
This function is not used so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/dma/tegra20-apb-dma.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index eaafcbe4ca94..cc6b91f48979 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -233,11 +233,6 @@ static inline void tdma_write(struct tegra_dma *tdma, u32 reg, u32 val)
 	writel(val, tdma->base_addr + reg);
 }
 
-static inline u32 tdma_read(struct tegra_dma *tdma, u32 reg)
-{
-	return readl(tdma->base_addr + reg);
-}
-
 static inline void tdc_write(struct tegra_dma_channel *tdc,
 			     u32 reg, u32 val)
 {
-- 
2.27.0

