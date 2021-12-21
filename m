Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D363147B98D
	for <lists+dmaengine@lfdr.de>; Tue, 21 Dec 2021 06:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbhLUF1i (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 Dec 2021 00:27:38 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:15239 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230497AbhLUF1i (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 21 Dec 2021 00:27:38 -0500
X-IronPort-AV: E=Sophos;i="5.88,222,1635174000"; 
   d="scan'208";a="104664124"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 21 Dec 2021 14:27:36 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 9A6D241D5D91;
        Tue, 21 Dec 2021 14:27:36 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     vkoul@kernel.org, robh+dt@kernel.org
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH 2/3] dmaengine: rcar-dmac: Add support for R-Car S4-8
Date:   Tue, 21 Dec 2021 14:27:21 +0900
Message-Id: <20211221052722.597407-3-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211221052722.597407-1-yoshihiro.shimoda.uh@renesas.com>
References: <20211221052722.597407-1-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add support for R-Car S4-8. We can reuse R-Car V3U code so that
renames variable names as "gen4".

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/dma/sh/rcar-dmac.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index 5c7716fd6bc5..e409c89edca1 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -2009,7 +2009,7 @@ static const struct rcar_dmac_of_data rcar_dmac_data = {
 	.chan_offset_stride	= 0x80,
 };
 
-static const struct rcar_dmac_of_data rcar_v3u_dmac_data = {
+static const struct rcar_dmac_of_data rcar_gen4_dmac_data = {
 	.chan_offset_base	= 0x0,
 	.chan_offset_stride	= 0x1000,
 };
@@ -2018,9 +2018,12 @@ static const struct of_device_id rcar_dmac_of_ids[] = {
 	{
 		.compatible = "renesas,rcar-dmac",
 		.data = &rcar_dmac_data,
+	}, {
+		.compatible = "renesas,rcar-gen4-dmac",
+		.data = &rcar_gen4_dmac_data,
 	}, {
 		.compatible = "renesas,dmac-r8a779a0",
-		.data = &rcar_v3u_dmac_data,
+		.data = &rcar_gen4_dmac_data,
 	},
 	{ /* Sentinel */ }
 };
-- 
2.25.1

