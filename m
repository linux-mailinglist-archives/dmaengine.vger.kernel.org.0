Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F11F43564EA
	for <lists+dmaengine@lfdr.de>; Wed,  7 Apr 2021 09:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346331AbhDGHQF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 7 Apr 2021 03:16:05 -0400
Received: from mail-eopbgr150071.outbound.protection.outlook.com ([40.107.15.71]:40655
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1346268AbhDGHQF (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 7 Apr 2021 03:16:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mwe9VE5lGkYc60ktY2mxrsTTq63Fvb7NTwwPPKFeloKSzjZwzgrBt/35Xvd/4oM2moN/0rXhD4TKVP3GTwcYN7gTkD4gtqmUV2Xf+kOjmaxVnVHH7ua2zQl7teQG97TmDOqKEs7bJ+yihTkOkHZpVjRCgXjta0zzsGBXSfNDlUM+XIgoBB+ulYTW7ogfJZLhq0CrjNAjNMmJ+oV063kOOmw+40d+0549RCzhUMhpGeygV0Nc+/XwiwR4pd1m8YK4iKdjDXnBexdBsCNlOPHNbFPszm8NgmOloCIuQQvMAI7y5Fp9OoRjWl/5151+rC/qmjUpJimvu+MGs8WCkEs0gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IuhrTIJKl5JhJW4phvz7ezIbJ5GeJbE7LgYQrcWZcSM=;
 b=oBGlxzJzvwKyWvbIzyhbsThfkty4V3H6ynVbbK2hHnIYyU0UvUGQsJkP6XYK6jw/5l3ddVh26Lv+6WpZER7S0fpfOp3qx4L6nOHXAfK389/6Bb20eseR78M7vYYd2FI2oHgUfPGUJhOhNBqtt7aIF4cU55qyHS1WBSbS3X2wDma3U8MOrZ2YaoWnazIsHqj3z0JAhbn3jAgRs7NzmuI/pHChBfwjc2z6nVjR1Q0F7bCziDJf8qbupilH63lHH18HVAvGgplr4GLsaKqnz9fmVKnpqY4XRIUbLNExmLBhId6p0w89rBPOLnO1R80VZy8OzuC3iB3yWl3e2grzySz6OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IuhrTIJKl5JhJW4phvz7ezIbJ5GeJbE7LgYQrcWZcSM=;
 b=aBDdo9rFr0GuaIaCkN5bDcAWv1R9Umk4UmzbrwB+HOrGRgVoS2y5Fu3lIFsVXQrJrBlp9Pqvm738adHtD8f47tDVdXxtfjPBTXUuNIEIadOixs5SAJE1/gO/xJKnKg7zxiHy1AAgZ0izvZSZau4FKcGLvSrPlYue1araAyrN4co=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6509.eurprd04.prod.outlook.com (2603:10a6:803:125::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Wed, 7 Apr
 2021 07:15:50 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::e8e2:7756:13bc:2cb3]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::e8e2:7756:13bc:2cb3%7]) with mapi id 15.20.3999.032; Wed, 7 Apr 2021
 07:15:50 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        robh+dt@kernel.org, catalin.marinas@arm.com, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com,
        frieder.schrempf@kontron.de, m.felsch@pengutronix.de,
        xiaoning.wang@nxp.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, dmaengine@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH v14 03/12] Revert "dmaengine: imx-sdma: refine to load context only once"
Date:   Wed,  7 Apr 2021 23:30:47 +0800
Message-Id: <1617809456-17693-4-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1617809456-17693-1-git-send-email-yibin.gong@nxp.com>
References: <1617809456-17693-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR01CA0049.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::13) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by HK0PR01CA0049.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4020.17 via Frontend Transport; Wed, 7 Apr 2021 07:15:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5230fcbf-ecac-4b87-eb83-08d8f994f8f3
X-MS-TrafficTypeDiagnostic: VE1PR04MB6509:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB6509BA707C1A73950D01E8B989759@VE1PR04MB6509.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:132;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L52Kz+bryOW0sE/gQpf79s9zAu0dd9ao8Xf1DkJML4AfJ6IlT5rjS+wUk693ELMH4cqd7HapC4x0/Yo4OgUBoZF5qLIdSdfM9BRJ53BKsPlOHC+fCKtziEEk/DIbq6osieoqShwvJWDq/pFF5CJoiKvqadT/dHyugEj9Xmo+Vssn5EQgLS0VXrSsfWp+05lUrrB6OASwzVBuNbgYBx5aWgKXvagu6gzFPAeF4GsI+71dk9KcM6O+1IgWkwz5+j08mq08n93Mrph3FCrv1O1qIpk1d+PHFfxP5kpC4xHNoPqtOCy4lpnH2D+3R4vEO2B6s+n1gD/z9dBzWgKiNFkmEIXTG/kpH24lOCb2+H9qQVLdYGI+TCvOcR1y8eIXiFZj9yXnMbeNUG9i4W+kJqHTbI36oy1jSvint35Jl9uSEJn/ZGcFHZp+Oq0VY97f+wsXNyj1vma6JgF3kJr3TXIE285jEIKrtCmXJTEPANbircveqWFjI/1iUO4ksahr4mpalojYnFZwE+2cDR/WdwviclM6Absrc4LvAWoMaGf6rdXKCXfw7AtxlEFjabxXJpI1+IOSpTXiipskN6HnHfxbyZ2pICFmdpbDbCe6UExn9oHEJG9oj9lUcVot2py+UTZyjgHw61e68eFFAV+mVpTYb00mziE7hB52cNlicwLxwrBDHdPSjf7uA+tRTfOVOj3BoYYeFcOKh7fe6bVZ7ufjKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39860400002)(136003)(346002)(396003)(6486002)(6512007)(4326008)(52116002)(478600001)(5660300002)(8936002)(66946007)(2616005)(956004)(26005)(8676002)(6506007)(38350700001)(36756003)(66476007)(66556008)(38100700001)(186003)(16526019)(2906002)(921005)(83380400001)(86362001)(7416002)(6636002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?F0iYW1RFNMrYLQBCHEG13OBWkqdCVtBMcCweDsxtFYPu/+Mi5HuRp0yRxfvJ?=
 =?us-ascii?Q?Mnpac+ORqnx0iDUosy0NURJu/kzqcrKWbCd4/4TLAGbmlpAMUUHIjUef1EVP?=
 =?us-ascii?Q?ToImICnurDaxFPeN4ZUJ9hYpi6VorbnAaCcDot9wfdPYVoRN/6E/D9FHgIuo?=
 =?us-ascii?Q?b4GBVckZIMC40dI0m+BS2e8k/MkmxHkARtFekyRd7RCBcr+h/5eIcxYHBsoS?=
 =?us-ascii?Q?u1J2kGzSzZ2OkWBw/mqLEDORJbZn/7uDt4YL6WyXZgHiQ5+0kxdhXY2sSXyj?=
 =?us-ascii?Q?eHkphMprlY8vpl6Gwpa8z3pkk8ZeniAKJdsAXH+KMgOnp6SQCOlEe0Qjh6/0?=
 =?us-ascii?Q?RLMhPK2c6G70Nw0pCH5BtUafIq67xiPpgl5mIeSTJUk2Z7sWon5TtC/qNO+8?=
 =?us-ascii?Q?eoNZ6nP7lix+r3ag45A8D6DJfJsXA6Nhpd+B7vC3l92qUj6Nm8jebLUlcIPw?=
 =?us-ascii?Q?AbbJa8Js4RT4a+XowkRn1fyg/453h3KbrEjnWLBLci/HOhCp7rwqwkJq+FeT?=
 =?us-ascii?Q?JbG5KdiPKo3VSU5cyi0KccKyokZc2OtBZyuX4MsYvLxhPTncjBh7wFT9eb30?=
 =?us-ascii?Q?wb08+yPJY79GqYmN67AgCPa6uGH1hT5TTZI6qiljb9FrJIqDV1lhqtlg8I9I?=
 =?us-ascii?Q?cI1giIypQyr8LQPNdyaxgyX1WmJPWZKxF2aoGuTVylZ3C8nAb4CJ/04SiCeh?=
 =?us-ascii?Q?AY4M4KmWx/+veLvRxaAq//XNCFrp7PVEc/U+loB+coVnxBURZM+weYXwmp/4?=
 =?us-ascii?Q?PU2gLWeV2BY1UM7rjsyfcwpwiStR15B4k8tJTt+XheLhatGJ4NuBW7+It4xg?=
 =?us-ascii?Q?HxjTSKL2WfyEQFCbw52nEw9C9hIDbdVz7es1M+AtiUzZ/rsFo8OChiD4Aip5?=
 =?us-ascii?Q?yP/zeKz9SSGq6QQqR674U/VN//XljUSaKpDHjyVWeyXIiylSWb86SQIKDfc6?=
 =?us-ascii?Q?HHi+xfvxwos/Be7ADOJLi2OQXWEd26gyZIx9aE4zq8gQrkkmAthzS5iRXrnO?=
 =?us-ascii?Q?IL9orQeNisLEVi01Sg2awVp1quz024yveE65X8Fuql3lNSSaZLnK/oT65QXT?=
 =?us-ascii?Q?gFuPw+qIVSxyWIMBUxki5G3cC+GZTfr2DWgxOBbG9KVSFEfKHrXFew4/9GPk?=
 =?us-ascii?Q?N87Z5t6vZUxORxA1Ceb1vP4ezlXP9A9s2RDfCeZhAOFGRNXYSzBmUzxatrUp?=
 =?us-ascii?Q?VAnVxMAjO8LC+6kljSsZBBLYeza7vIRc3mgd7fKsF6DYUzw/kRPip+l0etrR?=
 =?us-ascii?Q?oY0FiQYueCFkV0FjyVmJRpTY0SMDWJSDn8Ad9SO3CqP+9m7EUG4nkpV5cilI?=
 =?us-ascii?Q?cSoeFbzWSy9TYHxd+GdqgzS0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5230fcbf-ecac-4b87-eb83-08d8f994f8f3
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 07:15:50.3104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6IDl7OrmKuvlR8tS9ic2ibGLb3Dl6s8y2dUYmtNTZWHcOXXlrNTtRXncOLd5kbT1w8YR6p5PxlbZ65GVDyH7Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6509
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This reverts commit ad0d92d7ba6aecbe2705907c38ff8d8be4da1e9c, because
in spi-imx case, burst length may be changed dynamically.

Fixes: ad0d92d7ba6a ("dmaengine: imx-sdma: refine to load context only once")
Cc: <stable@vger.kernel.org>
Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
Tested-by: Richard Leitner <richard.leitner@skidata.com>
---
 drivers/dma/imx-sdma.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index d5590c0..02f8584 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -379,7 +379,6 @@ struct sdma_channel {
 	unsigned long			watermark_level;
 	u32				shp_addr, per_addr;
 	enum dma_status			status;
-	bool				context_loaded;
 	struct imx_dma_data		data;
 	struct work_struct		terminate_worker;
 };
@@ -954,9 +953,6 @@ static int sdma_load_context(struct sdma_channel *sdmac)
 	int ret;
 	unsigned long flags;
 
-	if (sdmac->context_loaded)
-		return 0;
-
 	if (sdmac->direction == DMA_DEV_TO_MEM)
 		load_address = sdmac->pc_from_device;
 	else if (sdmac->direction == DMA_DEV_TO_DEV)
@@ -999,8 +995,6 @@ static int sdma_load_context(struct sdma_channel *sdmac)
 
 	spin_unlock_irqrestore(&sdma->channel_0_lock, flags);
 
-	sdmac->context_loaded = true;
-
 	return ret;
 }
 
@@ -1039,7 +1033,6 @@ static void sdma_channel_terminate_work(struct work_struct *work)
 	vchan_get_all_descriptors(&sdmac->vc, &head);
 	spin_unlock_irqrestore(&sdmac->vc.lock, flags);
 	vchan_dma_desc_free_list(&sdmac->vc, &head);
-	sdmac->context_loaded = false;
 }
 
 static int sdma_terminate_all(struct dma_chan *chan)
@@ -1307,7 +1300,6 @@ static void sdma_free_chan_resources(struct dma_chan *chan)
 
 	sdmac->event_id0 = 0;
 	sdmac->event_id1 = 0;
-	sdmac->context_loaded = false;
 
 	sdma_set_channel_priority(sdmac, 0);
 
-- 
2.7.4

