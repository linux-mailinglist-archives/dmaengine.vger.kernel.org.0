Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5C146B485
	for <lists+dmaengine@lfdr.de>; Tue,  7 Dec 2021 08:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbhLGHx6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 Dec 2021 02:53:58 -0500
Received: from mail-psaapc01on2091.outbound.protection.outlook.com ([40.107.255.91]:60897
        "EHLO APC01-PSA-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231474AbhLGHx5 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 7 Dec 2021 02:53:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UeKieGX8iuL4pBdtOWo06u5fg8zs7QUKGl1bV/dGqR4bHvm8q6APV2kCZv+eKeZjmPYNjPWKzHxB6bIRWwd631x/hpyqfhZXYxrxlciYITHv2X7FeQsBfz+Dgcthf6z10VzD2w1YQe0ujpdx9hlc0duMd6d1DY2GyBmHo80OMgbjdHBMcE7dA/xcrT1B8l0aX8Q/Th+lRgH3ULZTkTMCMTkoypUIpdjTcp88Wra00aElHXW0f/yggaQvQPK9Lovk3DLUMsEV8WLsPQ5Hj/dIqYhMXZn4sd2sor5tTj/ser7Dl3+FBgpWG7Uj/3jrfWD6JKdy/RZLblpUSnneFSKAug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=buESRzpRV08lOt/GlQzgQZISBDmcf/qaVu5mIFdSZNo=;
 b=f2UzfJQ458lWZ4romR9KmE/X99LjrbFohgI8gCc/iSrZmR0fvwDPKvSQXzI8+tUlvHXjv8SRt7Qg0/7uRdtHhxOTpN2qaQEBtu8j4yUzHD4Tss9fSwXwchTl9cXC2o+ztX/1PysY4Q+llKOC+rFuVi3BJg4SrP0gybSefN5o83cXuAYbTLTAfVJZBvAL8LHeyYIDKFlNGLzwqp8sUom0gwOsz5bLSUtqWnoDtQXaq2SIfH9CfCgi3L8A6Vv2VxV0sa5WjKbq8fcmRqcPLF4gGA/xgfaal9TJdSMh4lhecjA1kypx2KrfLO+zEGdMTNvT2G0bRGUE2IR25Fr7evev+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=buESRzpRV08lOt/GlQzgQZISBDmcf/qaVu5mIFdSZNo=;
 b=d5AZtwb7HGnLDErQ8sqRZL3erbKR4A2BGc9rdJdC0MDD6Y7J0zYodqjwtsI2KjVqrVmV1a9uDYUPrWQg3xp3pCDCt20q61BvQMtXYwXP3eMMR6PDStZaThpdu+FqC6aU0ate3TPnvrq/itabu6t7PpB13oy2M0Y4S7FF+h/eaHQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com (2603:1096:202:2f::10)
 by HK0PR06MB2353.apcprd06.prod.outlook.com (2603:1096:203:4b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16; Tue, 7 Dec
 2021 07:50:23 +0000
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::8986:b885:90d7:5e61]) by HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::8986:b885:90d7:5e61%3]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 07:50:23 +0000
From:   Guo Zhengkui <guozhengkui@vivo.com>
To:     Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org (open list:DMA GENERIC OFFLOAD ENGINE
        SUBSYSTEM), linux-kernel@vger.kernel.org (open list)
Cc:     kernel@vivo.com, Guo Zhengkui <guozhengkui@vivo.com>
Subject: [PATCH] dmaengine: use IS_ERR_OR_NULL before PTR_ERR
Date:   Tue,  7 Dec 2021 15:50:02 +0800
Message-Id: <20211207075002.4009-1-guozhengkui@vivo.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0401CA0022.apcprd04.prod.outlook.com
 (2603:1096:202:2::32) To HK2PR06MB3492.apcprd06.prod.outlook.com
 (2603:1096:202:2f::10)
MIME-Version: 1.0
Received: from guozhengkui.debian (203.90.234.87) by HK2PR0401CA0022.apcprd04.prod.outlook.com (2603:1096:202:2::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21 via Frontend Transport; Tue, 7 Dec 2021 07:50:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a4b043bd-7273-47c9-1b2f-08d9b9563933
X-MS-TrafficTypeDiagnostic: HK0PR06MB2353:EE_
X-Microsoft-Antispam-PRVS: <HK0PR06MB23531D812A280651AC76EA6BC76E9@HK0PR06MB2353.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ip+fkT2l7VCRpRp5wuxPQZl379VQP/pM68OWNDKDwUTLfTGTXqIblEhcTR4+PfUQK9lFMZiu3sxcn0j3unGWWVKqmayIPUmCV6SFRJyitrQW0uvCJT8gHvhcdwhV+z65ni+O+1fh5iERY9d5bGcbEf8Xh+tXFG+3HAxanxKIUPl5ztSaA4bBnCtf+kPMTtMXpXQwNtfqOV0vA287tISwJJLiLY1/xdhfYplUBu/s7Zz83VgO9M3MejbyKKu9JbTw+QI4EXEy6F9yhw5nxHP659cAXTKClrUgirB9/G7ggixJCpMf3Mubpym25teksVCA8QSatesMxQqqLfoEOmukJdu+o17vs8x75GlqQSye3ovs75BqfgPgQDloc/QSLs5CAo6nOQqZ5TmSHDxdLh7pJvwIfBSxBIVF37nKyKpKL7YHnCzFQ5bv3Snd9fgZYoMChdt3Wvy0AwNtAB/zMqK/jrsuKaCu/Y6fnSjwdCht7ub1lkXTUwNLFf3WwywlfS7tIlAd8dEs5fR3wpzBqROXyPbx7ZdsXncii01cIRQF7033EiGHjUBgJnXDhTG+NbiA45Ha8F6jfukn5vWY0R94vxxrR91qBwb0A+DlwpKzg1tL1TBvWEOo3dNSSGALxkmqohqXP9pCdySgL9uq/OLGcmtoPPQpe/cUZen+gaxQGEkAXmWYdkrflXc4cAGtNqXD4Fd+Q1+7KTKFBg9zYpYqiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR06MB3492.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(107886003)(6512007)(6486002)(186003)(2906002)(86362001)(8936002)(508600001)(8676002)(316002)(66946007)(66476007)(66556008)(26005)(38100700002)(83380400001)(36756003)(6506007)(956004)(38350700002)(1076003)(52116002)(2616005)(6666004)(4326008)(4744005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5ibE8rFSBfWbji0JMPGX85NxgIhgEat7xkArsHRax/EVIEy6tSsbExrYzcR9?=
 =?us-ascii?Q?qI8t9OzcnbllhzFYPmN8K+Z/iIWaAcFh6Zqx/M4ZYz/GbLKStbvz743Sw1rB?=
 =?us-ascii?Q?J46rGt7JYeWp/5Too3A/yeXyoGOsUy/ZcCAsKa8UTiT6HaLzCPsU8e66aL/w?=
 =?us-ascii?Q?HISMehMdxfGfnBDVCBMvt01bFTw06aoUr5Lew2vsUZk5nDck7jVCMLck0kSy?=
 =?us-ascii?Q?axc4hnUmS26yK/eLOM5B3MtXugSqsbi6lX5Vgw0ay7Wbusog1ZSkWw2NJ8S0?=
 =?us-ascii?Q?usMBCxRkSFZ2+X0gUPnufC2DqMoJceIy1uls/xUS/z4NFmL/rD3IT0+Jp2iL?=
 =?us-ascii?Q?k09by0vB7N232WtAzg5AVTV0FyO6gi7HLu/5TLdeMt/m8oAHRMLN8myxoW0/?=
 =?us-ascii?Q?Wczmd4h5Oup1r5PzCVUxnuG9QNj140oXNKGkvEBUvZJGhU+szHsgkWVzczYJ?=
 =?us-ascii?Q?lKdou/dSZWbSHrdw+ijHsuXXaWRCnlboe4sgZERBIQoKu3VLwv8XooyEYi5g?=
 =?us-ascii?Q?HHKH6MX8DnwowdDfSEXRacn2anxMyMUcKklaBpZtDEqWcshIZlwZRKoyxEEu?=
 =?us-ascii?Q?s9g9+1WRl96tIPvb8dqljdnSqpvQzS6VaUhMC82vtiPJPeP3pzf6M9oQOtah?=
 =?us-ascii?Q?+svPAxJX5Fpbsjq+sJj2bsVf4LhbcQUxKE+Q8xAHhA74fU4Op306hjLlpwO8?=
 =?us-ascii?Q?XxGNJpUFBRKWV9k9qdSlRwZeLjRGWZP/JGfRZKFGGZuQEbLNzdX8qzuqn+/n?=
 =?us-ascii?Q?lCTXa84/maoTLIL5xbgFfAKHut3qMDsfYJ+Ui9rbgg7eI5Zf1c59CAP8XITj?=
 =?us-ascii?Q?cD/wv/16iGnZ19KTLnbH6ysNQ/gq5avyJH/NBq4RP3kcVSAb+ol3Qzv98vDv?=
 =?us-ascii?Q?FUSKmllLnDjK1fr12c5jHTWN57SHd1C7OygDjfAvDUIdV1NZPRy0rWMoh5Hz?=
 =?us-ascii?Q?7PZgg6j3UTAkA/MzP8xaQ6zDAMOwEiN2lglxd2bAmqkLjnkjEbIuvNP0Qlx+?=
 =?us-ascii?Q?xPHul4RzlP01mqX7dd17iG6KDtM2hEDJ1EWSRYE7fW5W2BTWJ16eOUVbQQ2t?=
 =?us-ascii?Q?46kInBurkr0z2wqp3d3x26D9G2JU1r3nRDpuZwI515ASl+EHZOTbtD42phLl?=
 =?us-ascii?Q?KfmYH01XySnn9gjDfMj0d6eW4+mqwQUMUOIFwGYhhpcrqTe0gUhg85YBEecO?=
 =?us-ascii?Q?935EWauhHNP8vacL5ff1YHWuQzZ6YuARWf2Y2oLFTlpQvpwND9JJIQBlGzIo?=
 =?us-ascii?Q?OmC3KlNtjX+xfG1ZdWA6+6Oujrc+d+nEG2c8EOEa/7F73O0pTAbTbEjUiptI?=
 =?us-ascii?Q?KgBdVQNjkIPV72NOYhPN0K43c2apfmBHMpDfr2zomIWhIobS+qx+Eo5/etFs?=
 =?us-ascii?Q?Qz6HsHxfmwyFEgJyJGsvJu6x1cDt6NTo8EaHOPCs+KpGV0wAB3c+hn8UI1n2?=
 =?us-ascii?Q?mwGo3FzL6v3k4LzGn/KHiGZqsmGYAlNiNWi3boUTPe9dAVmVZ7wDtlk8UNCn?=
 =?us-ascii?Q?NYZwLYiafjm/gJyYLCuzw2eWQsHoxW+mIR8Mn6OhEGPJwFzfCY6V0NU+ZuBM?=
 =?us-ascii?Q?Vz9eSq4K5eu6bMoO/USPvPeXwLeEG6ZfLMtT4cyLsmWnGOSWkGeKImlUkEyd?=
 =?us-ascii?Q?nk6FbBrwZxw53RPPI/b8vaU=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4b043bd-7273-47c9-1b2f-08d9b9563933
X-MS-Exchange-CrossTenant-AuthSource: HK2PR06MB3492.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 07:50:22.9956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nd1EXcSKpKH+HRwFIwCnoQ5Qy94X3A0G7UIJpCrSp/brGfRdfwxeABohiCYfW94e4GqKTSvR31Iav1lM4k1JFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB2353
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

fix following cocci warning:
./drivers/dma/dmaengine.c:825:5-12: ERROR: PTR_ERR applied after
initialization to constant on line 815.

Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
---
 drivers/dma/dmaengine.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 2cfa8458b51b..0e6ff875c34e 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -822,10 +822,10 @@ struct dma_chan *dma_request_chan(struct device *dev, const char *name)
 	if (has_acpi_companion(dev) && !chan)
 		chan = acpi_dma_request_slave_chan_by_name(dev, name);
 
-	if (PTR_ERR(chan) == -EPROBE_DEFER)
-		return chan;
-
-	if (!IS_ERR_OR_NULL(chan))
+	if (IS_ERR_OR_NULL(chan)) {
+		if (PTR_ERR(chan) == -EPROBE_DEFER)
+			return chan;
+	} else
 		goto found;
 
 	/* Try to find the channel via the DMA filter map(s) */
-- 
2.20.1

