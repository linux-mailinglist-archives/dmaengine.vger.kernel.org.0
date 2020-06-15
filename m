Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC9061F917B
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2020 10:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbgFOIcR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 15 Jun 2020 04:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728162AbgFOIcN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 15 Jun 2020 04:32:13 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F75C061A0E;
        Mon, 15 Jun 2020 01:32:13 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id c3so16090319wru.12;
        Mon, 15 Jun 2020 01:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LhYq3ErTARnN8M2y3YfDyaUAiF9DdChbWeaq0FOKRSE=;
        b=iAth882ot48k+1hVxs2N7dKisLYLFY15sfEjKljaix/MP7NhyZkJnNqvQIQdA/RFHN
         xoasva4/H9ZHoHRiTydzkdZfExNxJrgbe4KXfoIiPl+5y7jGS4fxWHtd3pdsDayb1NVk
         phF1qbUyyV7Cv1Wa9Taqnjee2Un2UqqOnXyieCToPVOxYJgESkzIuHyTyXLZBsi//ZPJ
         etNN5douj8ntVKOi9ac6mOTUSz8cpJH7JQCErUoIxMi1Vaq1io+Il8Up5OkPHweBWcck
         Hg6EehHHD8Gq377nepRnWrXzLjE1ireVXu3V1RWbHdTWShK3adK6VVBeaDuhnPJz3V/a
         mhdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LhYq3ErTARnN8M2y3YfDyaUAiF9DdChbWeaq0FOKRSE=;
        b=sirZBdp5upWY7EFS92Tn92ZH42VMlQ+q0rd5h4rO8C45+8ZaGI+P+KlU2ZNLeiqKoS
         mK9qkszVduIYATlN0d+c5bsAeZEOtmCq1wB16r2Z+2RskfkygstFQtd3SdwEiC3sqvJd
         RCuu/KyUCJwa8OARd1Fpri5WrXP9qItITEhwbz9yaRoNGeZ+ANfIKrrCI4mxxNee6+wT
         eg2BgEV9W+vRDZqoKjZIq8d8yNz2yAdXQrSo6VlctaMWs3xCSk4Yqt9lXxHXuttQvl7F
         CyMOhtksxtEJZFVAjiLOSVoYUNUcldsCIBd3QfKFD6/dIu7WBwT03ekJKNlJhzgoE6eK
         kL9Q==
X-Gm-Message-State: AOAM533WHtOldtZ8r2T4g0NUSoALed90EPVMEvlGcYMwRobHuG4bx7iZ
        g4eP0ybq/OrkSoCLqqDM+is=
X-Google-Smtp-Source: ABdhPJyVpcmhLb92L22CTkhQXirzPyFYPKxH7q0JUBoAhTgmjAwOEGO/IzLwbRaAtJ7n5HAteFfw7g==
X-Received: by 2002:adf:f205:: with SMTP id p5mr29480211wro.302.1592209931903;
        Mon, 15 Jun 2020 01:32:11 -0700 (PDT)
Received: from net.saheed (54006BB0.dsl.pool.telekom.hu. [84.0.107.176])
        by smtp.gmail.com with ESMTPSA id z206sm21954745wmg.30.2020.06.15.01.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 01:32:11 -0700 (PDT)
From:   refactormyself@gmail.com
To:     helgaas@kernel.org
Cc:     Bolarinwa Olayemi Saheed <refactormyself@gmail.com>,
        bjorn@helgaas.com, linux-pci@vger.kernel.org,
        skhan@linuxfoundation.org, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/8] dmaengine: ioatdma: Convert PCIBIOS_* errors to generic -E* errors
Date:   Mon, 15 Jun 2020 09:32:18 +0200
Message-Id: <20200615073225.24061-2-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200615073225.24061-1-refactormyself@gmail.com>
References: <20200615073225.24061-1-refactormyself@gmail.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>

ioat3_dma_probe() returns PCIBIOS_ error codes from PCIe capability
accessors.

PCIBIOS_ error codes have positive values. Passing on these values is
inconsistent with functions which return only a negative value on failure.

Before passing on the return value of PCIe capability accessors, call
pcibios_err_to_errno() to convert any positive PCIBIOS_ error codes to
negative generic error values.

Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
Signed-off-by: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
---
 drivers/dma/ioat/init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/ioat/init.c b/drivers/dma/ioat/init.c
index 60e9afbb896c..fc8889c2a88f 100644
--- a/drivers/dma/ioat/init.c
+++ b/drivers/dma/ioat/init.c
@@ -1195,13 +1195,13 @@ static int ioat3_dma_probe(struct ioatdma_device *ioat_dma, int dca)
 	/* disable relaxed ordering */
 	err = pcie_capability_read_word(pdev, IOAT_DEVCTRL_OFFSET, &val16);
 	if (err)
-		return err;
+		return pcibios_err_to_errno(err);
 
 	/* clear relaxed ordering enable */
 	val16 &= ~IOAT_DEVCTRL_ROE;
 	err = pcie_capability_write_word(pdev, IOAT_DEVCTRL_OFFSET, val16);
 	if (err)
-		return err;
+		return pcibios_err_to_errno(err);
 
 	if (ioat_dma->cap & IOAT_CAP_DPS)
 		writeb(ioat_pending_level + 1,
-- 
2.18.2

