Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3773DEE47F
	for <lists+dmaengine@lfdr.de>; Mon,  4 Nov 2019 17:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbfKDQQg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 4 Nov 2019 11:16:36 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40517 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728138AbfKDQQg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 4 Nov 2019 11:16:36 -0500
Received: by mail-wr1-f65.google.com with SMTP id o28so17761475wro.7;
        Mon, 04 Nov 2019 08:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/Xhq0H5pLLtX0Ww6fnj03dQOrsFXJBAwNPPPx6Ye9nM=;
        b=uq8ZW9pIQW4yWd3s07FDkzrPSTAb037Z+3vX+UfJZojPUV4AJXiIY3NiFvJNXSDVcM
         HrVlzfg0u53TzIxZavbNf4G4KQQkrkjTu6+XcysXMXv1nuxh1eBOmg+a2YoF4QlW1cGT
         6utz9YoUabbCV9CSdV/njE1my0HMpUgPtpp23PvH+1tYeGwHKqk4QtVpwZYxgsT+WY38
         vih2eszoe21JVWag3ZUmoRmQDhsKm97PzLEMhPsUTMFZOyuS+jQOONmOnHWlcYh2yJng
         vvTtqEg3QSK3+7w859a7FITf/AbVWqvrL0NjPU3tUDWr0S+/Bsjbq1GBbpRzLgAFJ8nD
         5YEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/Xhq0H5pLLtX0Ww6fnj03dQOrsFXJBAwNPPPx6Ye9nM=;
        b=MeN4lP0z0YfpjYvhpz5XOa/5jsfoZ09k+gMHC3oLn+NPBQf8adxkt4cOGyP3pKRvig
         pbGKS8I4EqSClbUcxre4fTNasOMEYGbjUeU2hpGYekHHHu0fTBK1lzBBRQCfocOmlmud
         yhOJfe+Z1KfDCdo2D6of2nhut/7v6cz95yX4gsYYsy4LAD6NKCoV2ajAtWAC6Gnz919I
         x7rw8/XTWt8DRTVrBhja992FKqEfHazqhj4mUO3x1PoFqPsYSUSMTiBHd+qhtdFf6D1Z
         dNFklL+2SxURWLHQt9RuHEQKy8DkD4yPdcNSniRamGno5cdZdPqYSU5ko2jwZ1jBWg5r
         qrhw==
X-Gm-Message-State: APjAAAV535bdM7kAm3p9AUhiGCibTNr9gEOEXJq5gPQIp78PQg1Hb+6X
        3Sk1ZSu3c/a+Ou0cIdRiZBw=
X-Google-Smtp-Source: APXvYqwuQiiMHirp5J8wAt3nc9veuTB7izFK8r/TGXUkIv971Jb0Imnw8HDrPd4Wu0kgMSIiJw0EkQ==
X-Received: by 2002:a5d:6947:: with SMTP id r7mr18751271wrw.129.1572884194088;
        Mon, 04 Nov 2019 08:16:34 -0800 (PST)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id f188sm10410999wmf.3.2019.11.04.08.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 08:16:33 -0800 (PST)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] dmaengine: dma-jz4780: add missed clk_disable_unprepare in remove
Date:   Tue,  5 Nov 2019 00:16:22 +0800
Message-Id: <20191104161622.11758-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The remove misses to disable and unprepare jzdma->clk.
Add a call to clk_disable_unprepare to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/dma/dma-jz4780.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index cafb1cc065bb..66ab76b9520f 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -987,6 +987,7 @@ static int jz4780_dma_remove(struct platform_device *pdev)
 
 	of_dma_controller_free(pdev->dev.of_node);
 
+	clk_disable_unprepare(jzdma->clk);
 	free_irq(jzdma->irq, jzdma);
 
 	for (i = 0; i < jzdma->soc_data->nb_channels; i++)
-- 
2.23.0

