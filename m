Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F238613886
	for <lists+dmaengine@lfdr.de>; Sat,  4 May 2019 11:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfEDJwj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 4 May 2019 05:52:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:55048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726694AbfEDJwj (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sat, 4 May 2019 05:52:39 -0400
Received: from localhost.localdomain (unknown [194.230.155.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6039F206DF;
        Sat,  4 May 2019 09:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556963558;
        bh=Uni34c/o6D0GHiHq8PrHrCJH5kAMTO787liaEy0LQSI=;
        h=From:To:Cc:Subject:Date:From;
        b=GGXKJhBnDhrPXSbuGX6II8/OXfs/Nwf1ZtY1EfckBYWBlEn9k/HiyELZQnIf5WFcM
         rQTEGamyL6zloVmekMtCFb7Hg3YjaKXk0Omkwx4bWOZJry53TPTdg7BU/F3Ofw9Flr
         DOPpEujFnVe8vaW62S/D/T9bMw7veh/DwQXy0//A=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 1/2] dmaengine: fsl-edma: Fix typo in Vybrid name
Date:   Sat,  4 May 2019 11:52:23 +0200
Message-Id: <20190504095225.23883-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Fix typo in comment for Vybrid SoC family.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/dma/fsl-edma-common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index b435d8e1e3a1..c53f76eeb4d3 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -136,7 +136,7 @@ struct fsl_edma_desc {
 };
 
 enum edma_version {
-	v1, /* 32ch, Vybdir, mpc57x, etc */
+	v1, /* 32ch, Vybrid, mpc57x, etc */
 	v2, /* 64ch Coldfire */
 };
 
-- 
2.17.1

