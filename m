Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C37B43564F5
	for <lists+dmaengine@lfdr.de>; Wed,  7 Apr 2021 09:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346393AbhDGHQY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 7 Apr 2021 03:16:24 -0400
Received: from mail-eopbgr30081.outbound.protection.outlook.com ([40.107.3.81]:41938
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1346385AbhDGHQW (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 7 Apr 2021 03:16:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U4PkUjULXo6VGHQza6UigD5yyXBy2aZy8bgqpYd157RVZvIF3xOaD4yM9/AhmB0WVEtwkyHn2ilHdL1xEm+BVIW1oMlMTYKCxt/Ig8+bOukF2F5IHHNTiQSztPUjlCoLXuDP/q8q6qUT4KMTwFDq+YNN17sP13jx9jLqPwahQMlp3dMmU/mRtlihapb8u4WbvSKT5h4Hd2uteK+itI7nnpM5cdTk2pllQrjhgHSjzRdAVDYU9E6rQw5gT8Bqy6es9ehIgcoNKdl1coz/HTcaTxhT6MBArB6gJ+UacpPs7sq8HZVn/PQeUk/P7GREF24MtrpnNCYAyKKhaHIXJjqspQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fiJnpPaTlSqgyxfFsv/N8BjdfbnBxrwPPZjdYhqivR8=;
 b=dEnlBx7rjgZlVuogBMo08STdTPgzhDVdrCtZv3tDvDfNjmZBeKFdlaGtHDQtntE17Yt7OIIGbRj1gd63lrHq4VRpN+MwzncttItmbwMPAD0hlZBy24rvA46weLbjdzrJGKgWKVhPZJoHIM0uwCFGtQWSoa3IdE3+92DtdFxfduAFjOKKN9eauQOcs/IXlDsH1DtOedo6tBRLcsnzC1OOEUr8/kIEcAqJEO7cCboRKAMoneJyUYYM+ltruwxPNZGYLzLeKG+QnmpmwKp77983BqJ6lFw5BfgqhVls5S79Jri1gWxYpUuyYXx+wdo2g+FDY2lO2zg4j3R9fadm/MJUmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fiJnpPaTlSqgyxfFsv/N8BjdfbnBxrwPPZjdYhqivR8=;
 b=sf7L8fs8BIUC/QyH0+Nsdf7xGXQrq33UT7YdU1Ve8oEdv8+Qpbu3l9qNDEWIcrR53+nu9RpAEZMY6e2qVLU5UzHk845ZA83oVvAMaKl16niE2yN3elO7gRirLZtt/V4EeU3n0MuyD8iE/7Sou2GnIe1vbl2eJJdJyBUaAiavAPo=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6509.eurprd04.prod.outlook.com (2603:10a6:803:125::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Wed, 7 Apr
 2021 07:16:11 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::e8e2:7756:13bc:2cb3]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::e8e2:7756:13bc:2cb3%7]) with mapi id 15.20.3999.032; Wed, 7 Apr 2021
 07:16:11 +0000
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
Subject: [PATCH v14 06/12] dmaengine: imx-sdma: add mcu_2_ecspi script
Date:   Wed,  7 Apr 2021 23:30:50 +0800
Message-Id: <1617809456-17693-7-git-send-email-yibin.gong@nxp.com>
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
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by HK0PR01CA0049.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4020.17 via Frontend Transport; Wed, 7 Apr 2021 07:16:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 455d82c1-d2fb-4550-f9e8-08d8f995053d
X-MS-TrafficTypeDiagnostic: VE1PR04MB6509:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB6509C3B66E1D395B94C90E1289759@VE1PR04MB6509.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:361;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gLpGknAUk2omSEnjgHYCSSAgNHefMk2Uoy1XWiOAxgBMxjZV0jxsOhwWVUXlHQ9u7m+mCAcoqCpTKnhwi6yxYuLtV5bybNcafJS/J8LnTQ3hJTFcM7+t9Xroo9KR30Tqwtj2tBtImi1Y4DBGAP1AFVXzgltGDLefU+IwpjVRyvwpENh6r3S1Jna/1pe95RW96UpeGzrkTi7jAfSa7BmLHiIkekt4npf01mMxqet1l6OQ6MivuVaHWiXge6WgFForsr0+ChGHMljSoKpZAW8xR9Lp2fdL8brw/8b05L4BF4wEioMzRdVClGTjEzRqCvdx3cq5Qsb8AkM2OLeBLfddiPHLP1ocKS3oYk5eNUTl0QrPeQS6jzW0c7xI7md9xwu0H2MF9Fv3dj3/xQT62aFOvIjVdFr1449S7+qYQgYTPVuXCUh9IHpTv/49I/9ofkdbaOGIdq21u9BDZMBcF7F+PgSiJ9RGHuoui5KxGzjB896qQu8irRsTtl9OHCvhpyHs6+Dn87x2O68MyODCZ1Lf2jJ68Mk3PSR/4ewuPdA/UeE2F1qH9/J6GgBYqGGLnMXdU8hCIBOb5yDkI/0q48NqvCi+gCQm5q9INiGMfGa2+aboHYzrLCJ0nmpqTZesEKrjxpQ1ZI4nzLPGfqvzPdAc/VwEGme4LppVXmmQihsHQP6RsmHRUQYtyoX/ECN98shL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39860400002)(136003)(346002)(396003)(6486002)(6512007)(4326008)(52116002)(478600001)(5660300002)(6666004)(8936002)(66946007)(4744005)(2616005)(956004)(26005)(8676002)(6506007)(38350700001)(36756003)(66476007)(66556008)(38100700001)(186003)(16526019)(2906002)(921005)(86362001)(7416002)(6636002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?CUxDZFVK3d0RCl+CEDE0F8bJka9TPzoa/miLCwnHn+cL3IOA5lRPZviDCCmZ?=
 =?us-ascii?Q?kZEKpT7u1NN/L3348EDCtSF6Ha0CF/HwiichrNfx5YA1R3g+sS4myDI27t0D?=
 =?us-ascii?Q?IlFbJvGjLm40FWdxPPXkBH8zDkhVkLitRZFM7goE+ka64oxI0+O97S+OitwT?=
 =?us-ascii?Q?L9HxoMoZPApxAMvNc6MbH7YYa6asUM8gyaPkrON5uu8BfC3gwXjJuGlY/8tD?=
 =?us-ascii?Q?8IZTsce19/YLQUroe8NKtKAOV8oFzz8lyAOGvXTx01vpzY/q9TfZt9tf83Oe?=
 =?us-ascii?Q?VRyacQzjB7NTFJIL03cF1QiCC48/2iFfTsqYLt6nWxO25n8iBzs2BoIlskP8?=
 =?us-ascii?Q?krZ/C4nSma3bDuZnIyCr3C7azCiI1joR3klnSAlJWsXcTLl+uNl1I0eLvxfv?=
 =?us-ascii?Q?5A5KMInBF79ioKKOjp49W15Dqjoq7575pOZe+QoLkp5Mo+nfn7O3r6tZzSOw?=
 =?us-ascii?Q?asruHsa/YR9DV94lTvmn499BuQ7Od4vmOJZFi+Ek3EMGZDCwV/ontP7tFSvz?=
 =?us-ascii?Q?RASxqwJMhkPnUCcX+v3TMaSYldbF42yKGY+o719iR4TGbCUUQZVZWvH6vKa6?=
 =?us-ascii?Q?FI6zzPPaImByOYSK5zemiUd4ePjxRelfsdfHhxk27tx79WoTJo2waT6OwOmw?=
 =?us-ascii?Q?hScTP3mLOIQ7zEil7FcMCIcrto6QkzwhnqQRjOk86HYD7TTLEnDBRRGXxl6s?=
 =?us-ascii?Q?8Rn+wbMVwJhhOUjMb1Z2wDRku3XaRCV+ar/+u+N9A+L4hS5+as5xNAK6ZCeZ?=
 =?us-ascii?Q?Oe5pyUVsL2gFENIXw2iOzfhX9LZgFpJplBMunVYGJ1PHb0QhJHuCE08SQUEZ?=
 =?us-ascii?Q?nzpw2NT/CCqgUXEdhCMzowpDxQznWdVK93eBIxBzlt+QbyFvA4vzKKtYF4cr?=
 =?us-ascii?Q?yp2NmoEeyxpa/XMVivflpdJbBZ36PFc8SCEMlqjuDAOeQWrtbeIAkYg8QlTu?=
 =?us-ascii?Q?11In9aa/Dj7McHemaPoy8jvbHmXfyVtMD4Z3AesEjGblNPuhsWKEzq+zM4Rm?=
 =?us-ascii?Q?yC6C31iwqv8JBZz4lb9Qj8fEoMOKricDVtyQhS129Htcmuus0zjfjO9B/x6I?=
 =?us-ascii?Q?GQ+91fqvhxdsJzvhh6Z8a+BxWjjn/9ooUZoc9bR/7UNge2mAD8WMzhXJkq1b?=
 =?us-ascii?Q?uNKcoVTs7o8bt0egixQ2Ie6dPhTAL6cSpJIxbVf/wULZOQPXJlSXp78hsvng?=
 =?us-ascii?Q?EWaJOFbxDLRoKQTXpzjfqX7r52zGOQmndzfkiZxteBngWfE42pGfwviIFBfD?=
 =?us-ascii?Q?joM7f2hSxgE3oUFYycUIeVyXe+V87UuABmJAec5E+JdwUBE4x1ujlADwLdWw?=
 =?us-ascii?Q?B8WzujwMOVWV9DE5kMGrH75g?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 455d82c1-d2fb-4550-f9e8-08d8f995053d
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 07:16:10.9714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0W2X7dQlpVk3Uc/P2C++cqFFjRiPuRYg5lmGsr4e5bb3sB+7cUKFeq6O4ZuwRrymwhs9rsZCdLwh7fzxod7VbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6509
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add mcu_2_ecspi script to fix ecspi errata ERR009165.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Acked-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/imx-sdma.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 78dcfe2..86bd383 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -892,6 +892,10 @@ static void sdma_get_pc(struct sdma_channel *sdmac,
 		emi_2_per = sdma->script_addrs->mcu_2_ata_addr;
 		break;
 	case IMX_DMATYPE_CSPI:
+		per_2_emi = sdma->script_addrs->app_2_mcu_addr;
+		emi_2_per = sdma->script_addrs->mcu_2_ecspi_addr;
+		sdmac->is_ram_script = true;
+		break;
 	case IMX_DMATYPE_EXT:
 	case IMX_DMATYPE_SSI:
 	case IMX_DMATYPE_SAI:
-- 
2.7.4

