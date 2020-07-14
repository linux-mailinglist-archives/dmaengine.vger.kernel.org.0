Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B11B421EEDE
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2020 13:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgGNLQm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Jul 2020 07:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbgGNLPw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 14 Jul 2020 07:15:52 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27844C08C5DB
        for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2020 04:15:52 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id k6so20883208wrn.3
        for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2020 04:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J5xJlzZ+5aNa1GB1o6zmShj2PdHMF5lWE0KYZLpqibo=;
        b=RfZ/Kz3I91qMv/2m0Zf4ivjprRznfDKxRo5ZqPfQhhX9PSZaThHJo6P+kCgKU3rr8P
         ch5dX9+quX9ibe+sKu0v+Q+oiCV4mvt9tXT+dOpTZlx3dlk3pFSFYEBV9GrqzAU5e/qZ
         2wuJ02QboJI8XWG+i9e/liAXGaPAVnPv3+356DXkW9YOG6Yu1G48GvrBl69d/svmIOHf
         M7goBeDf5RKNAnR9LAsrJsJn/VUl7itgVGaOdoTZU7JX7at3D701oJQUMpkJOWv5dSvN
         Vqzrln1AVz6HaXiepPBW+suT8kz9j6tWg2CRXWblQOSODD48YjXUIjfkxnM1sVlC2Ha0
         P9zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J5xJlzZ+5aNa1GB1o6zmShj2PdHMF5lWE0KYZLpqibo=;
        b=j5P6iC8Tb1iW5Q5k5aX5HKzzkWHTR0JvXO+e/fgZbUrjBs29b5P/tAnWnUzTt5Zn9h
         ZvXX0OyAVx4dNL8GKKyrrviKNc6RJnCBEJSZPKhAyYDxM8RejJ94lZwIsHJmrDJN+twR
         FTSm4k8woB64NaKhNRA7IEg6U/VC5886EuLODn8OVdWBU1tM93mgBLn8N842AutJnf9P
         qI3ECOO+OYyJj8sxqo8U4KwV942TtfRBAGdD278IKcwdqVzS/U96t/urpFycdu8cWxF8
         Zt9HU7NDoOdKlq3aUytffNWCtrRDKI0TLl/0w4kxBySlDb6+933L90now1TpiUL1V+Nr
         GU3g==
X-Gm-Message-State: AOAM5330ZxQcCM6BWE7ygLc3MikkQgQrV2RDz3bH/ppD4m2rBF2IHxRK
        CjpkPXcP61vqUuSZur9XpLP4ToCdPuk=
X-Google-Smtp-Source: ABdhPJy+IpSkDvt0gKhCLe7N/pHcRPdSZRSy6u7pwrYXAu5aBo0g8In969/7Eo5zqi8LjXxj6Yj/1w==
X-Received: by 2002:adf:f388:: with SMTP id m8mr4799959wro.338.1594725350794;
        Tue, 14 Jul 2020 04:15:50 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id l8sm28566052wrq.15.2020.07.14.04.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 04:15:50 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 01/17] dma: mediatek: mtk-hsdma: Fix formatting in 'struct mtk_hsdma_pdesc' doc block
Date:   Tue, 14 Jul 2020 12:15:30 +0100
Message-Id: <20200714111546.1755231-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200714111546.1755231-1-lee.jones@linaro.org>
References: <20200714111546.1755231-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Struct attribute names must be an exact match or the kerneldoc checker
gets confused.

Fixes the following W=1 kernel build warning(s):

 drivers/dma/mediatek/mtk-hsdma.c:120: warning: Function parameter or member 'desc1' not described in 'mtk_hsdma_pdesc'
 drivers/dma/mediatek/mtk-hsdma.c:120: warning: Function parameter or member 'desc2' not described in 'mtk_hsdma_pdesc'
 drivers/dma/mediatek/mtk-hsdma.c:120: warning: Function parameter or member 'desc3' not described in 'mtk_hsdma_pdesc'
 drivers/dma/mediatek/mtk-hsdma.c:120: warning: Function parameter or member 'desc4' not described in 'mtk_hsdma_pdesc'

Cc: Sean Wang <sean.wang@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-mediatek@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/dma/mediatek/mtk-hsdma.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/mediatek/mtk-hsdma.c b/drivers/dma/mediatek/mtk-hsdma.c
index 4c58da7421432..f133ae8dece16 100644
--- a/drivers/dma/mediatek/mtk-hsdma.c
+++ b/drivers/dma/mediatek/mtk-hsdma.c
@@ -107,10 +107,10 @@ enum mtk_hsdma_vdesc_flag {
  * struct mtk_hsdma_pdesc - This is the struct holding info describing physical
  *			    descriptor (PD) and its placement must be kept at
  *			    4-bytes alignment in little endian order.
- * @desc[1-4]:		    The control pad used to indicate hardware how to
- *			    deal with the descriptor such as source and
- *			    destination address and data length. The maximum
- *			    data length each pdesc can handle is 0x3f80 bytes
+ * @desc1:		    | The control pad used to indicate hardware how to
+ * @desc2:		    | deal with the descriptor such as source and
+ * @desc3:		    | destination address and data length. The maximum
+ * @desc4:		    | data length each pdesc can handle is 0x3f80 bytes
  */
 struct mtk_hsdma_pdesc {
 	__le32 desc1;
-- 
2.25.1

