Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA0E741B2D8
	for <lists+dmaengine@lfdr.de>; Tue, 28 Sep 2021 17:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241605AbhI1PVb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Sep 2021 11:21:31 -0400
Received: from mail-eopbgr150078.outbound.protection.outlook.com ([40.107.15.78]:56462
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241575AbhI1PVa (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 28 Sep 2021 11:21:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EZqS5f/24qBA9ddE8BQmcYrqacraYnZ6/7T2e+TARZkSpUMQxiGluj/rrbP3WcgLErlIeXz5uXn2Ucsa1Tb6RUgXZuydkHQrrlYe7HRaLj7SSvly7h5HLHdTWR5pZHVwXPe7NhdvyNDwR9sjA6nZ7d7VcllqZQakjop/8M0zDJmOqPsuyg5g6f9MHdZBGtZ5+5gUX3jnqhU1deRjjEFprt2OUhnUt/wRyNLpvoxBbyYGO7YK9T+90IGS96s9R+13KoXIn9Nv8LV3NvfqAT1S9SDkGxPM/t5oBwlz6G3PICVYqRekv77D7pHb1TpQ3KtaIfNHTrOTR8l6MoeJw6Abpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=t4zUjXTn0plzCzI+5m20ObT412GiESbjjj+IPIieFWI=;
 b=mYl3phyy+xeCwZRauXfw20aAlqg3eEqwcwKyKCrCByUUiNccxRDRGVF6tlLpbt7QoeIZBiR28/tL4ool2hXdatVKnEPWJtaCaP1Xdn12MCsepFOrZfR9xhFxdcDVob38NTLEirG2cQZeYk4yfjZNQKQxOsc5d/KpAcJGtGK+c4rhLYXTXV74V8mO0R0MnNGZIEGRMmh4Mp7A8C6IFeGn9oy47q6DLVyU7yS8LDQVrafgftBgQbo1XR2yLwZlXfdCamuqWZniRGjeG/Lw+p8drKZPIja6kLBBmOj5WpVzaictOibeYTlPUEzVK2rTxZWiiWLBlqXg/VvIcVAHIW/PGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=permerror (sender ip
 is 151.1.184.193) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=asem.it;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=asem.it;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t4zUjXTn0plzCzI+5m20ObT412GiESbjjj+IPIieFWI=;
 b=Bwl8M3wIUD8TcDMfk6ppfh3rBuAWlUbVjRrU6M3XKFCTFan61jG63s4B3RLtl3n8r4T44188ooJyrB9YVNUB5TDe9RmL8e3WNgR5T3mDs+auxmzcP2Oj3rtHckoW3rWOnslUTwKYm78yxd06iM4Hh8mNE50yZHNzpN37I2hzh7M=
Received: from DB9PR02CA0019.eurprd02.prod.outlook.com (2603:10a6:10:1d9::24)
 by AM0PR0102MB3444.eurprd01.prod.exchangelabs.com (2603:10a6:208:d::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Tue, 28 Sep
 2021 15:19:45 +0000
Received: from DB5EUR01FT060.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:1d9:cafe::ee) by DB9PR02CA0019.outlook.office365.com
 (2603:10a6:10:1d9::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.18 via Frontend
 Transport; Tue, 28 Sep 2021 15:19:45 +0000
X-MS-Exchange-Authentication-Results: spf=permerror (sender IP is
 151.1.184.193) smtp.mailfrom=asem.it; vger.kernel.org; dkim=none (message not
 signed) header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=asem.it;
Received-SPF: PermError (protection.outlook.com: domain of asem.it used an
 invalid SPF mechanism)
Received: from asas054.asem.intra (151.1.184.193) by
 DB5EUR01FT060.mail.protection.outlook.com (10.152.5.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 15:19:45 +0000
Received: from flavio-x.asem.intra ([172.16.17.208]) by asas054.asem.intra with Microsoft SMTPSVC(10.0.14393.0);
         Tue, 28 Sep 2021 17:18:50 +0200
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Flavio Suligoi <f.suligoi@asem.it>
Subject: [PATCH 2/4] dmaengine: imx-sdma: add missed braces
Date:   Tue, 28 Sep 2021 17:18:31 +0200
Message-Id: <20210928151833.589843-2-f.suligoi@asem.it>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210928151833.589843-1-f.suligoi@asem.it>
References: <20210928151833.589843-1-f.suligoi@asem.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 28 Sep 2021 15:18:50.0986 (UTC) FILETIME=[245EDCA0:01D7B47C]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5a17659c-9026-41c9-bdfd-08d982936751
X-MS-TrafficTypeDiagnostic: AM0PR0102MB3444:
X-Microsoft-Antispam-PRVS: <AM0PR0102MB3444E514CE8ACCCE5D6F39EEF9A89@AM0PR0102MB3444.eurprd01.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1iMxCNwx0OgSwyX/BsR2loipXZZiLs+tcXj8YDLvPqCkrVv2WsKe8dUs8hSl/g4vPHppEDBrbHMpVTCYvbLZ8vH6XunB74cr3a/UoGVHtc4PonWx9Ng6V58dxfXCJcIiqKnFbK+ja6bpdbdvWPWKZSFqCDsBo0BVABgXBI0bSHli/rqao6iUU4D8TQzUUYUTvX2hxorcdB8VmT6c1di29C9gQXS/WwtSwlfVpSWTwnxv5Jpi6t3evdvjacCSKf7YRHyrENWeATAwjyWLk1PMxcC45hxwBbSLvMIcpnFgKo3CYaA57gN7a6omCyPO7FzfA/8euVvoiRbeiltQMTmIRdB1WaWfAr2qu4RgigoVk1Lz6U7qhCAawoJ1L+cRenls1mmk8GfLbuzEidVK+luLMEIUuIGpcXEwm3fiqDS/713BK5zqIbhbw4i8Hi/wX79EqFieH0OjSyTCM1veCAzN9e2iaPuYuESnF7Zd0AxFzxFmfyHDuLizAWrUfvyWNxVZKmEqeGZZAJscVIg3iJe/Wgp/BSAfjP3qHh4X1l2Sd5Om5YHmTXycOQqt9vnrREDa8gCUwE8wl2intctgku5a5pfZlcY4hdPxgNhcJ2fC9LWZVPUq8mznBiuL3RchVwaTQSyCE2cV/i17OxiO5S+mcED/67b8TI8y7XxXhuTG6H7hW7nL1O/eI6kY4HNrXuV8dZ+po0YipprIOcoWXbCE9W/BBgJJn6p1ZbZPeZVPIRc=
X-Forefront-Antispam-Report: CIP:151.1.184.193;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:asas054.asem.intra;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(46966006)(36840700001)(450100002)(86362001)(316002)(4326008)(2616005)(5660300002)(1076003)(83380400001)(54906003)(70206006)(8936002)(81166007)(70586007)(4744005)(336012)(110136005)(356005)(508600001)(82310400003)(107886003)(186003)(36860700001)(2906002)(8676002)(26005)(6666004)(47076005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: asem.it
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 15:19:45.3500
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a17659c-9026-41c9-bdfd-08d982936751
X-MS-Exchange-CrossTenant-Id: d0a766c6-7992-4344-a4a2-a467a7bb1ed2
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d0a766c6-7992-4344-a4a2-a467a7bb1ed2;Ip=[151.1.184.193];Helo=[asas054.asem.intra]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT060.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0102MB3444
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The "if" conditional statement is not a single statement,
so both branches require braces.

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
---
 drivers/dma/imx-sdma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index a58798fc3ff8..726076683400 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1226,8 +1226,9 @@ static int sdma_config_channel(struct dma_chan *chan)
 			if (sdmac->peripheral_type == IMX_DMATYPE_ASRC_SP ||
 			    sdmac->peripheral_type == IMX_DMATYPE_ASRC)
 				sdma_set_watermarklevel_for_p2p(sdmac);
-		} else
+		} else {
 			__set_bit(sdmac->event_id0, sdmac->event_mask);
+		}
 
 		/* Address */
 		sdmac->shp_addr = sdmac->per_address;
-- 
2.25.1

