Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A219435A46
	for <lists+dmaengine@lfdr.de>; Thu, 21 Oct 2021 07:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbhJUFXq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Oct 2021 01:23:46 -0400
Received: from mail-eopbgr150071.outbound.protection.outlook.com ([40.107.15.71]:60494
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229499AbhJUFXq (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 21 Oct 2021 01:23:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h7qE5XO2g0s01GSJl9wPVvjlPpYy4UFjleFYi6bPaQE/GM78cP4yydn4zwKhT+TWKRQ1OcGl/9OwkoqPCVla/nNxtfsLY/5O5TXp2GwGE1JEo58h9NxK8mhdHYHT0QuCQg+Qk7PgOKG62S8LnKHkUAuRf9fA4O7ZCDQ8AsTSgEKOlphdp6Kyx8vyBP9lD4kFYaIFEEr8JTk9hydPrISCX6JCxVd626fvINy5+6SzAudRMcOar2e9DdAu16YfK5MJb+oalrF+ujSS9fCtYJv70FFzUOMurGRq75PDZMNSicgIye9cUQePnf+SvZ5yHrKx+L0FBEemWXrTHVixuzHYUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+uQfoKlObvh6WkfjN3Ej57Os2ggOZ59TRIirn5NpBE0=;
 b=dub3IFt9CP8ene6GeLkFZtOszS7nlcQa2KcbVm2tGJBb8MvWLHPhUpzuo85U8xBrx0gHeffwQxjeB3cIzeJhVwZUk600JLzfn62FR38iTmgWBuGh1HFl7SLf6WqA/cycp6dwOzRvbM/e6o4LJWd5sBT7/dVpSQH3WtvNBfA+wllrSVSpO4CMERL//c4b3JdfykBjFbFwNkCuPTEyAkwa3kiMrirXeUz2isQwsUQvANgCyk3AKliIwj3ysOAoj7c2W3FT7cXASdCsC/MuamVOEuEjI68LdtU4437gdCF+BtBV/tpAywPFDoSL5hh3D3AgMl66hskRKDUugIIVqDMq8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+uQfoKlObvh6WkfjN3Ej57Os2ggOZ59TRIirn5NpBE0=;
 b=WrrKg/HAGs87MJ1G323TSYV1VqSJFqre96cav0iqTM0HxMdIPZRdoc7yaIqAAqKCsKzZw2nlp+Gcl9UusPnCvB3BTRm3Sf0nbCJnnSOYh7VC3I2J6ImVJz7QWu4E+bxFOquTC8DMUYFZx82AqZTZdT6RT54iYXMiSoHh0c5Mk1s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7444.eurprd04.prod.outlook.com (2603:10a6:20b:1de::16)
 by AM0PR04MB7028.eurprd04.prod.outlook.com (2603:10a6:208:19a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Thu, 21 Oct
 2021 05:21:28 +0000
Received: from AM8PR04MB7444.eurprd04.prod.outlook.com
 ([fe80::6db3:208e:1a23:be9e]) by AM8PR04MB7444.eurprd04.prod.outlook.com
 ([fe80::6db3:208e:1a23:be9e%5]) with mapi id 15.20.4608.018; Thu, 21 Oct 2021
 05:21:28 +0000
From:   Joy Zou <joy.zou@nxp.com>
To:     vkoul@kernel.org, yibin.gong@nxp.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] bindings: fsl-imx-sdma: Document 'HDMI Audio' transfer
Date:   Thu, 21 Oct 2021 13:20:30 +0800
Message-Id: <20211021052030.3155471-1-joy.zou@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0019.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::31)
 To AM8PR04MB7444.eurprd04.prod.outlook.com (2603:10a6:20b:1de::16)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.66) by SGXP274CA0019.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend Transport; Thu, 21 Oct 2021 05:21:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81db8e5e-2d15-4634-573f-08d99452a20e
X-MS-TrafficTypeDiagnostic: AM0PR04MB7028:
X-Microsoft-Antispam-PRVS: <AM0PR04MB702844039F4870D8F1D06275E1BF9@AM0PR04MB7028.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R0cf/XNWeW6cuv2pIWdLxF5O/DcKQ2QvdHoUb+iVtT3lOzCQCdX/5k3q3uS6FwJaWVSnlOMKOf36rHP3D0HI+y4Rs3VvD9P1tCfxh2gGQ0EcJphlCH9E/TykXFJQMu2Ug4Pg9A8l1/Lp41D8nJk0iUxRpqy2XtC0jqH2qw/Lwjg1Abl+/Gx/OaqIOHAKZF1iQfkRn+O8wBz4COqYkZVf3MMZ04TPrHXPQG77k+aWg+TYytSK5lDYu9D37ZNyNlgeU0jV3hUrJnGAX2USOZSKco+dgylRqTYusfumsC5L+lFRKqR3APinpd1HOBBpSDv24k5nS3NfRf+hzRTOCCxPnRabL2JXkosQxjQ9Lc2Q6MyYxFC/YfN/xk1geo4KlOomuI1En+dzEeEUUZ8C6CImZXvRZGLT9GNNuDmPFQ63lVcUzqYLOAGhtKl1Q3nbceHI7R5OV+LS4yRf4t+/oT+naL+llAETULsJmNj2EiuHjaqO++HAgXol7FR/MK25QepzU2TNN/jb4YUw1LkVBkai0oxwzKuxUGprDN2fnn7jnqHHdvRBJ2szMJkz4hN+hHNY7DpvSPId+AH9uimCXOK78fleCaRzwM36uwvb51k0VSyMt1Z6bMNvKcP8HqEEgorA2SbMW46Q6IMOnR3Y1kHQX3n2SxhJJsIQ1R62xtQimkUz9IKECDG0K9nUipdZFmpqL799ZT7SPdFVZ2cLyDpdhg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7444.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(2906002)(186003)(6486002)(26005)(1076003)(4744005)(6506007)(6666004)(2616005)(52116002)(316002)(5660300002)(66946007)(66476007)(66556008)(8936002)(44832011)(36756003)(8676002)(86362001)(4326008)(6512007)(956004)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DSig1Ng5WYuTt7OCj0F4UxboAQlXzB27evxy0tb0WrLaggWWuRR0ZoLeEggJ?=
 =?us-ascii?Q?bPiNKwiRSEz36Y7Xw+sQ2OGPweFVMSFvvELLTa0zoFk3672FuPlIwR9B+BJ0?=
 =?us-ascii?Q?EfXiIVoRG+IB4a5OvdYZNyu14f+tD6LEEpUlM1jWjg9bg6wRsxv2SWDw9sIH?=
 =?us-ascii?Q?iuAPRMiwAMUG9/6CUkRj7lk3kigUurFMNZC5zuQMp22qPbzgHImtBwqOcXOT?=
 =?us-ascii?Q?c/FFtx5WERszxzvXbJ55m5GYznAHp9wnQZVlgPhPP2BzUEUmHm7H5eQO678o?=
 =?us-ascii?Q?fGdqdCmdoFhdB06x3Ar0wPVO7gDk/xMtb/YQuJIDJv/rBIz8JsY0kobiEqjB?=
 =?us-ascii?Q?4hQmSTEbIb2W466pzWT8a4/gIoGzuZpCZOxxPCmj26JmSZbF8kf5cIC074q/?=
 =?us-ascii?Q?/T8zfCcxtp0pThYLOOocm5gwJ9tFs9uaY50Do1h4qm61SjRkoY+Ixq2tp3ha?=
 =?us-ascii?Q?7MgZy/TdtogHyrBRpf2peBXWSJC9g7INP/F3990xzbaVTv9qow1tidM2L4b8?=
 =?us-ascii?Q?UEdKHM1hRGpDQkAxjVhTZhIqdG2ocbqL3ZZi1e9FVl8Qr8nsFIPKoRhNEQJ8?=
 =?us-ascii?Q?Bnpkh1w3JGLPnkyd0OUqljLCKNWZHSfpmooSlOCIfsROmY9xlUC8ymBfcapB?=
 =?us-ascii?Q?S3jo0QcuvPebyz6yC3nweT2nuD6wDKIzH21Sn8UhkfFKmmdkiRaHJ9iH+TGU?=
 =?us-ascii?Q?qtUoMw0Ub0DAhCqHaEmMvupYPeGk0cYSvD/O0tY+XwsvY37i7A85bDl6E3gH?=
 =?us-ascii?Q?ShX6d2VtkqwaMWy/h0ULYiOizLisXezcUtLvU9en+OHFfcexJAFbtZJC5+9y?=
 =?us-ascii?Q?Qg8KefMYNggnp0e4B51lgiDrjSiG2iVqTtTawxQQh7QEsnlrHC9z8kfAohqN?=
 =?us-ascii?Q?RJFfsEIBlLSkm5VXmhWs8CD1n8QYm1VIG/fWdYx88+hyyx0mFwV2oD7j148q?=
 =?us-ascii?Q?vCQUJJmUl78Z6bgiznf3kX5X2GSsH5VHgzwCw/bnD1EuauNBcrBT9b4vcc/v?=
 =?us-ascii?Q?FleXRRaRj1jlpyWbks+W8OnARz2i1TqSsLaacW7hwfBjcmIbO9Mx35XpDYeL?=
 =?us-ascii?Q?LjBgXjN2xYw1a1DJEMepqc65yt18b8qkVqOmwoh5HjkUwvZhhI2fSfpHVLof?=
 =?us-ascii?Q?4eI59FwJnWHijfsSm9nGMFpX7oEjfxoy5e7N4195lgwdWNcD7W3f1vJVMRot?=
 =?us-ascii?Q?AqlPat/4KdKRi5E78H7O8vw4O6lGFKkHNhncETCVTQ54IHGTuw1XHeI8IGYw?=
 =?us-ascii?Q?53BNCFDTjtX+AGoJsw4iZ7RK9KfBet1YPT2MnM8AKX7C/GVeVKrw4zhm2hPL?=
 =?us-ascii?Q?zu7aqRVkU2f2F0vkTGtR+ueaURxNGV6v5CGF++qYkmOt2semU+DbiBM4NWZj?=
 =?us-ascii?Q?biubxOEfn32W4QAb3NVbI2GsPDPjXBYWakkVD5ovf+gVpOP+TkGUIVz9JbEB?=
 =?us-ascii?Q?quNGcYX+kpg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81db8e5e-2d15-4634-573f-08d99452a20e
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7444.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 05:21:27.9451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: joy.zou@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7028
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add HDMI Audio transfer type.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
 Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt b/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
index 12c316ff4834..ffa61264a214 100644
--- a/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
+++ b/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
@@ -55,6 +55,7 @@ The full ID of peripheral types can be found below.
 	22	SSI Dual FIFO	(needs firmware ver >= 2)
 	23	Shared ASRC
 	24	SAI
+	25	HDMI Audio
 
 The third cell specifies the transfer priority as below.
 
-- 
2.25.1

