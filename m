Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA6813C7B60
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jul 2021 04:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237475AbhGNCIC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Jul 2021 22:08:02 -0400
Received: from mail-eopbgr60057.outbound.protection.outlook.com ([40.107.6.57]:3716
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237428AbhGNCIB (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 13 Jul 2021 22:08:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OX3aTH4FO2LWhEX6kqy/AmhFipI/VYwaVqEw2j7GYxbIQ07l/J3P1Cke8psLUQghtb0gPqCX3QtBvX11hXM/saHH92lQGe6ARqff0lGl80Hxhwd58DbgeyjgsUnjLooMAgzwFz5/lPJoadM6IkJY2zZlHBt8xXzjlRchv/8bD2ql/eySekxeTuLmZXDN1Xa0mV7BtTdS3s0/4PbPBUVN78almMnTYFam7tjK6JjJmVMz5KLEjeLVBh8wHnc4EaSv9Koi35xlCXjcThihPYXr8i1clNiWxcyfxJys1SD3EFnd9Emf33G51S6v6nj9fGb5ZAE6McaZc8RDDt/tWIyRAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ML1ozUJ2orouf71VVS4Lwf0Xz4lvkyqJR463xfc8P88=;
 b=IGmeqKr/NMKjKurDoeVlHFoYz2IdmtfBz1juabnoNjtYPU/Q29VWZ2Fn5/s/ETV4HxVFunrnd/9c0GrxVtMJghbF2zf4J3INtbe7kCC2lp79EUhtizyou17WaOR8p7MqwJPkS+ZACaXaV8ev3YmHmkmDP/glPBsmakAqDRgDHkjzWka1FnzMCTDwYnET2Ue47dRXJXrVx75mUG2Ms9h5cfXCPYDU1yoX5e/R8o17j+A3OmEQxqRHuRXa4Wb/j8a0VDTClgMkITmAEBzBwBrie5f1U5qAwlm+R2pDsoVBDDnWACMlXIQrr7ih8O2wd7cu1CKdNefh+77n8KMzN7+cHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ML1ozUJ2orouf71VVS4Lwf0Xz4lvkyqJR463xfc8P88=;
 b=BCRyXS2MjOhJZ72c6uh5XEsXMWwyoZq7Inpo4wwuuT4jxcl7gvIAXRY+3NpOK0lI2DOHkYb3NIjv+O9x9mcRd/ZYxZdP+P0CHHss/uFMTu5/Fv5HZs1/GWv3AqmzT0sJS9C0xBcGLhSD4apZlZL1weX0voA/5s4CeNY/r7epJFM=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com (2603:10a6:803:127::25)
 by VI1PR04MB4175.eurprd04.prod.outlook.com (2603:10a6:803:40::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Wed, 14 Jul
 2021 02:05:07 +0000
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::a978:6f38:2bce:9076]) by VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::a978:6f38:2bce:9076%5]) with mapi id 15.20.4331.021; Wed, 14 Jul 2021
 02:05:07 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        robh+dt@kernel.org, catalin.marinas@arm.com, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com,
        frieder.schrempf@kontron.de, m.felsch@pengutronix.de,
        l.stach@pengutronix.de, xiaoning.wang@nxp.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v16 06/12] dmaengine: imx-sdma: add mcu_2_ecspi script
Date:   Wed, 14 Jul 2021 18:20:46 +0800
Message-Id: <1626258052-22198-7-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1626258052-22198-1-git-send-email-yibin.gong@nxp.com>
References: <1626258052-22198-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:3:17::28) To VE1PR04MB6688.eurprd04.prod.outlook.com
 (2603:10a6:803:127::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR02CA0016.apcprd02.prod.outlook.com (2603:1096:3:17::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4331.21 via Frontend Transport; Wed, 14 Jul 2021 02:05:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88b1bbc3-4629-4243-74c6-08d9466bcd97
X-MS-TrafficTypeDiagnostic: VI1PR04MB4175:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB41758D0868FEA24C2C92C7F489139@VI1PR04MB4175.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:361;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3/g7DQd4F5TReqhAbBODMDrSclVq1psoGQplH6aVNmCuui+Kh5gN1D+MUmbMWHsNWkA//q37OeuyAX4OtNW9jBIDazhHGErC8jMA+e9+tBRcqT5vj6nMgGY3jAemFVBtlRffqfHygGpuo+gVipcuiaLDYuUXlF1p4cf7Xt9QhFq/kqWCckL3vYLm0Bd3ZMLvjbiLZjxAFVNdMn/CQsFpUEe8xLJcmL7I7gfugImOWPAfcjY93wKGFwqUi2JqvM+7a6HWDKhkRMPNTavYeG/z36KA1kpLUHQt/V3Lndni8Ts6Ol2Vk916wwDeqYE8SVfCjEfyA/HxVdzuPBIWTuyhbYOa2QSnyRNXtlwX34SUzMjpuh7dHaKgYT8N5MiSB/kC/qnFAJ/RJ/8qOHAtqkYMgxs0aklk3KxefbJeg8IeYrnHrYV3JjeEJzMfzC4IC+mpux+r2TSkiR/CSl1UibKG1lG2jAKU1NJMQLJyUOrVhZmtczbchNYXrXzrKsVgPe+b9urXvKnM8f4GjogP/EdNxGEZ58S9Vjil/MeVrmhy2DnAp7AM8Kr6Egtr7duhFUzBw/16vLmlF6RP1PNxGLt6oB0Yomu//pTkS8Yz8MAwxSONmkk2UYt+0h2ku7dr1O0crUEqGgUiueqS4teHGRaPxroMxDZ8kkjHgub3cArFtbQaHmUFjgP9uoFI+0T5QS9h/8MAniPcubb5WgStTbIana9UyyyuwnqfuEFpzbJBmvU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(8936002)(7416002)(6512007)(2906002)(921005)(6636002)(6666004)(6506007)(86362001)(26005)(36756003)(4326008)(66476007)(478600001)(66556008)(956004)(52116002)(6486002)(8676002)(38350700002)(38100700002)(186003)(5660300002)(2616005)(316002)(66946007)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LX8tQVeTlZVXF++KR3/gBVvBXtxNWRBUHe699jTh8n+sF59FSW4DhzD+ctBP?=
 =?us-ascii?Q?ANeOei01pyFHmPEDN+s/YJZl4CYwXEW9IzsuO2ybqJTYGzVrMx53a08UEezg?=
 =?us-ascii?Q?rUsZ0663KmHiH2i0TnPsziXy+yu8GnehyyOjOI8coVaLyeoc3ApNOYScXQ4s?=
 =?us-ascii?Q?5NsMa20L1582/VOhwv0nzgSslesM6mIFt9YmnJ+HuNw9iglptKGvmJZvXIfd?=
 =?us-ascii?Q?Mx0FFgbyqy/m1W0OhLja/9QxFC0rUCxmyt8MHy6WuTqWF47FyGPFMNl5m0KI?=
 =?us-ascii?Q?BcD+KhDm71s8mWsChsqmR6PTfu6d1hqGfuJkMe1nuWxyZyVx6b2QkrDXurqO?=
 =?us-ascii?Q?FanUES3VRLd+S90gWm3Q3almu3+bdBDfkhPzchwAIW0wslEq6CC8sD4Dc/qj?=
 =?us-ascii?Q?g8ESlxJHRw72NuEg9K5SB++66f08syBPgLUPwVAHFTG+XCwPbTVp+W8GWOjt?=
 =?us-ascii?Q?eRHQKNl9ur6SdKdfzQL7YQUHpUFQ/XBQ1iDh1F4krfguzsbF5QjPuJgl4HG6?=
 =?us-ascii?Q?gq1znFFX77y2dUyoc9nKIbO/rxdoUPYRGHzB4bSjZs46xb3z3tJtXw1pnC4+?=
 =?us-ascii?Q?WIw9eg1MPgveW4klwdi/MQxFD+VRy6eSYbGapE29UYeJlB5y08YF+YaQLz71?=
 =?us-ascii?Q?3o6C6e+HSh59RjaSQEvA1a4cD8N1rRtaA1oUH9IFD68q/FB9QWVvmYatJdWA?=
 =?us-ascii?Q?NgJrtlbs/mvjIVLJDPixdtv+8LeplqOY/2Fm0dx7Zkhr1+8+9jiPorfhPaV2?=
 =?us-ascii?Q?pLtXqxVu5/0hlY5GEWp9F6Qh8UamQpkUIC3Ru3XHU9aGvwUwde7uX/juMdz/?=
 =?us-ascii?Q?m584souHnwfcBi6csH6fK/Kco2TUvoQQ173OPVEOd7C1A5J6C9HxR81qkv8E?=
 =?us-ascii?Q?QrUeBm0QusXuB0Dadvdhhza1fN22+9h8hj0ZY0vfaHpeXWJmhFHOpG8sAtTU?=
 =?us-ascii?Q?fD/C/hvszwkJE72lt0pIQQzi/GxSYjWlgBtM5ocU5eVW1CX1n/ZYeeoV/d3d?=
 =?us-ascii?Q?SVS759xWt5U8V2t0DhsVgDGxUFuXiXNf8DhyGMywPdK5WQVL9A0GocfcfcMq?=
 =?us-ascii?Q?G3lKR7MSOSU4sbiwtL3kBI3FJDfbK93y2HWge9A/7NXvYO6lp7+0YufxWkTL?=
 =?us-ascii?Q?DS9gYUNRjuyWQra9v+aXaI3Oe5rceSOnprx1HKHbTjocDVqQXlNAuXa0LN8w?=
 =?us-ascii?Q?Ets66WXHmeThx5xvnYPAsTiue/A7INc0ks6SIME5qKvF7DLvotgMiZry3eeF?=
 =?us-ascii?Q?NjXqLRk9432BDAvoQfCqldqxIk6sKzoGRSk5s014DDntTrPFyZMYw9lnfQD8?=
 =?us-ascii?Q?J7IZ5+M2bJL28ZhFU6nGt7WX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88b1bbc3-4629-4243-74c6-08d9466bcd97
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 02:05:07.7973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yFMrWBfX1PilbNumruRhTYvO96gustvG5onN6J9VG+B8XtjZ0sUfK/rir92ta5Zm7xFb4YWDBggHeoqpEF/7ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4175
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add mcu_2_ecspi script to fix ecspi errata ERR009165.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
Acked-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/imx-sdma.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index d366198..5969df8 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -947,6 +947,10 @@ static void sdma_get_pc(struct sdma_channel *sdmac,
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

