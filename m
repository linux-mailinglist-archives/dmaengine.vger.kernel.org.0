Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC6DA21EF17
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2020 13:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbgGNLUT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Jul 2020 07:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727971AbgGNLSm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 14 Jul 2020 07:18:42 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D82C08E886
        for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2020 04:16:06 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 17so5003771wmo.1
        for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2020 04:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tHvsPtXMawqhgTlXf8i2jhQs/B2cBsj2Ks/fZJOcmHY=;
        b=Fqu+JGaFSRh7vRRPgR/HabR8IBZaeLvvr2EcwSrSv7QCI/6fOnODRUdqwt90J3g5C8
         0s7/ZkCY/MC07cLGz5P6eZPk8H0sOh7MIQCT3wT/fmUP0dZZvRlB6+ROihSuNTcRcnrn
         3f/KQJT0rXlJvq27p2T59AjfgIz20tp6gxCQwiRj2g3DFceT0HNj5P5tLxs2F3WUfGUr
         BCztbiua/SQvCo0rqC98vsPQJ6hLsJvnB5rS2qxatc4pm34FHMoA/X6H2H78RvRzapwC
         7c22y4tqYny0qVqhSNYiSLAngITlsOr2bNM3rVNtPcNOiSxaFmQjsg/AEf1VCrEiPz2W
         p5Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tHvsPtXMawqhgTlXf8i2jhQs/B2cBsj2Ks/fZJOcmHY=;
        b=HPJryujxIm0l8lVQG2WqWsfKeRaLAKj3mj1TzKBeqUTbk5JJgBnFucjXUycMa829Qo
         pl0A6iEPt/u6CW9q8v73/S9fJrwj7Zhq93fnoikCzq/WLo+EG35+YyRjBdRiFRfyq91G
         XDtLO3QRsHUHgoCsId8Q1UNXgDbJKIKIhUxcHJMaZmMmEuayyC75Reqg67Utp2VQbBMK
         wNS5LXrAX3JPVqPI3HGCfZyPr5LQyoVKeNe5Wcg6+HLbRmofXySftLrwFaIRzYJ7juNn
         bhYDHaBZls4b20BeADXXvzaJa/GdoKkOYh1qHeoSr/UnmKUSjAMKO5O/SUOHj/FW2bdH
         7YPg==
X-Gm-Message-State: AOAM531SJR9bDT5MZNhozF6FRCaxEL3m0lhrkLrA5ZK14Zjgua15XP7s
        JwBky/6S8euPlftS4kw66I5Zhw==
X-Google-Smtp-Source: ABdhPJxVoSxX2N3tawtWC/yLdMqtT4pktyn2twbJ8qTyWyZpqmkc6sC5zihRJLY5WtskmmQJi5EWrw==
X-Received: by 2002:a05:600c:2116:: with SMTP id u22mr3778571wml.82.1594725365560;
        Tue, 14 Jul 2020 04:16:05 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id l8sm28566052wrq.15.2020.07.14.04.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 04:16:05 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Prasad Sahu <rsahu@apm.com>, Loc Ho <lho@apm.com>
Subject: [PATCH 14/17] dma: xgene-dma: Provide descriptions for 'dev' and 'clk' in device's ddata
Date:   Tue, 14 Jul 2020 12:15:43 +0100
Message-Id: <20200714111546.1755231-15-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200714111546.1755231-1-lee.jones@linaro.org>
References: <20200714111546.1755231-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/dma/xgene-dma.c:310: warning: Function parameter or member 'dev' not described in 'xgene_dma'
 drivers/dma/xgene-dma.c:310: warning: Function parameter or member 'clk' not described in 'xgene_dma'

Cc: Prasad Sahu <rsahu@apm.com>
Cc: Loc Ho <lho@apm.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/dma/xgene-dma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/xgene-dma.c b/drivers/dma/xgene-dma.c
index cd60fa6d67501..4f733d37a22e2 100644
--- a/drivers/dma/xgene-dma.c
+++ b/drivers/dma/xgene-dma.c
@@ -287,6 +287,8 @@ struct xgene_dma_chan {
 
 /**
  * struct xgene_dma - internal representation of an X-Gene DMA device
+ * @dev: reference to this device's struct device
+ * @clk: reference to this device's clock
  * @err_irq: DMA error irq number
  * @ring_num: start id number for DMA ring
  * @csr_dma: base for DMA register access
-- 
2.25.1

