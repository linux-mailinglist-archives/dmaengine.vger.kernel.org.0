Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39C4B356504
	for <lists+dmaengine@lfdr.de>; Wed,  7 Apr 2021 09:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349393AbhDGHQu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 7 Apr 2021 03:16:50 -0400
Received: from mail-eopbgr150088.outbound.protection.outlook.com ([40.107.15.88]:65189
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1346510AbhDGHQr (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 7 Apr 2021 03:16:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GLVTZmvmF0V1pr3XPZPwHoDvO41JMCrWrD+2nPxmusfaE4kEqXl+21N0lYsexRzF4IYkLvnRF7EVyJtCLac7Zf0+8l+8d/kRWY0sY3EFYSXYyRYVkB7DrRpQmOI3okbgghPnkZyxl1gULKJZBKEz7qcBzxziEeSYkOJNYRiVGke5NsTOZjnAj8E9mQ/re2q6CxAxGJpgrA1J5HkoNkwyFyqwIK1WjhLGexm7Gwh6mmFYIYEFkB4sITWVg20gVImAeks+N8h7Ei9V0jm3iktWZczyO2Ac/Rb0Ups9fzj04Z0CoWN2cQQl3BFtLUly5TTP7qkXw4rTygQlnZBu+dYCyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZvU3VGhVcTeYxe4fB6geATT0prKN/x1vEpROhK8pVc=;
 b=TmvU3MA7EZxshL+kx9fZ//jKJFSLpsMIFxZwLUupERB339Dv1nPa5wWmi6s17O/bqgy/kzA2Q4oKSobAk2VxG5mZ5lh5jtQ3bQHL/fsQZReYTWSSeE/GxuxqpYX8z/qEu1VRKMHQEyHfyBLUQzlPx6AK3dpMD5X25Nv+hoPmn+IvkWByRZ7M8OffoXXUDX5QO7O0U24Oj03JWPAh0kOmBkdJ3r29rBK48Z9G4Oesqq7mU0uAjN9YvicnOfGtzUTxRi0G7ayncyGJMEX4A2s5v9RkHexaTkwRdevCZMZGhMYJOgNRzks6l0HFzlp1R4/tAOeW4r1C4kfPEeRulSL+Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZvU3VGhVcTeYxe4fB6geATT0prKN/x1vEpROhK8pVc=;
 b=fDRWJs9t2AehAV7WwH/7jvR3ddo82oG9dtkmf2rhzNpa6spEKuLGMbwyvTU9ulgH/p1o9A7ysYoNQXi1OEMPAU522n1ABqeZ1ado7ZX5VQkA6Ue0/JoYgKoowIohoAMB9WssbYWQvdsXz54NhTg0tYS1tPUD12P2tJG6fkU6lqU=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6509.eurprd04.prod.outlook.com (2603:10a6:803:125::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Wed, 7 Apr
 2021 07:16:36 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::e8e2:7756:13bc:2cb3]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::e8e2:7756:13bc:2cb3%7]) with mapi id 15.20.3999.032; Wed, 7 Apr 2021
 07:16:36 +0000
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
Subject: [PATCH v14 10/12] dma: imx-sdma: add i.mx6ul compatible name
Date:   Wed,  7 Apr 2021 23:30:54 +0800
Message-Id: <1617809456-17693-11-git-send-email-yibin.gong@nxp.com>
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
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by HK0PR01CA0049.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4020.17 via Frontend Transport; Wed, 7 Apr 2021 07:16:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6dc3dd4b-9a4a-4fbd-0162-08d8f9951478
X-MS-TrafficTypeDiagnostic: VE1PR04MB6509:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB6509574D2D6EBFF6AEEA129C89759@VE1PR04MB6509.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:632;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z0ZFDXd8njGJQqbIrUTR+G90QtuH8vd8uBOw+wovRAzWBQX5t4Mh21nyOzbRzjbs3wMnmA7Z1ehOwGj41ipWkWyxKPggLD9fzg892nuidrUjSriKaJprhxMtoMJRsKwJkjy/wKJNhspfH1onVt+C2CmLNYuF4jrXAEVEaQaQBiDvTB4piXja8uJ2So0A+AWkyljtju3gisvjRvlFqCcqqwebKQ4JYfA7d/0uXRb5B0iXaOcPgkvxLSp9CLYSMjUlUh5YzVBq23oFnzHzsddvOawUONdz5BmMrvMRiYwuzgaEb+XmQfBdaWlRvaPF/fMOoO02YktV8tdKET9tey14pDhdVZRfg144RlbFMDyHe/qTJlLRH8z/7CWvsFAVNZM8Gv3YyNCZ8MWdpgHLiHnZAcVcvVwdbuZkrfcIYdOVD3ggCNQNWPCXVoKjHUsRwRzD6ixxSsuHg+4lI328ds6t05Yzb9CQxj4udnc7fDcKnIDuZGzVFDLaHAhSLibHMR/sYvkhNaOwNviWpV7LRpPyBWTUiKxb7wvPcdgGTAzJ/sjo55mfLb/SVDvAIc7xMpUXfGZv9xfTufyiEfeFxvRi0aKDA6JriGAz4BiCYoDtxxovKPfqTCz1G1O26jw19moeTLjEInJTXcDMXeorVFT5Ido56cl/qP9RdU/O7A9Mrn7HxtSfFfwzHZs+/i5GHJ/U
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39860400002)(136003)(346002)(396003)(6486002)(6512007)(4326008)(52116002)(478600001)(5660300002)(6666004)(8936002)(66946007)(4744005)(2616005)(956004)(26005)(8676002)(6506007)(38350700001)(36756003)(66476007)(66556008)(38100700001)(186003)(16526019)(2906002)(921005)(86362001)(7416002)(6636002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?tnk0iLAraGO61kp8Scid+IXaZpbZirn8+bQazmbWjgiLL0HV1SQMbg1fjnHE?=
 =?us-ascii?Q?59xOqEzzFuQXALdfML04SDahe7fRkjLSkr8jiDz2lq2jazDsaweTU7MhqlNX?=
 =?us-ascii?Q?s2BEwCqns1HrGXEnRFOhfPVdH0imgr8QLgxuKduuzAyHa4Iu5nQHq3ZyPN7s?=
 =?us-ascii?Q?2LIY1w4OP4L3tdQZCRIxSPerCXQyQ2lQLK+q4b9KCwi+9RG45XVXU9BlBh8U?=
 =?us-ascii?Q?jxIJu10CJIFHltJEyLYO3VBbNJtW8K6uY5H7Snz7m20tlAAEw6iBz1ZXVR9W?=
 =?us-ascii?Q?Z8OOKoRJpAbn2Y2DaTa8E+PfpClzlYTejmahNeL/6LSFhyrLraUgdWPDLTsV?=
 =?us-ascii?Q?FsQ6IsMzg9F/IQTr98rCk+s+hY3FF+yrelNICzioz0614l/gQZtF0Q82x/pL?=
 =?us-ascii?Q?y3FR7c+Tu1OQDaVPFUVMP73oa+buR9UAgTPlsWBYgphkVOQGIEPANu0Si2V6?=
 =?us-ascii?Q?YU7jyxJv7NxMzn8xFX+X1s/KhbwfZyMobEig2g31PdEVNxuOiUfIJueZjEr0?=
 =?us-ascii?Q?F+fA7ZcHysk0kD7awnLpY/hjLZmxRBNJ2U8vvyn7wedGaG10ut33LExbLuk7?=
 =?us-ascii?Q?axq3e286loVTVLcKGeP6lnQO6ZxjWx0B80YWPgDfCVGcppVb7i8GCFr2qnsN?=
 =?us-ascii?Q?ubS3W1jw3WTmh0TKoAcnhoewy44tuuhMGtNJy3y7E4XocaMxkcZiwalMVQe2?=
 =?us-ascii?Q?kYdOt+UOf/2lJpbaA04optjqgRCRmbJA/ZRvRlQk6NFdL7rbIOHsk6EVKC2m?=
 =?us-ascii?Q?JmiQXa977cNJzm2SXLOnP2VRH8inVaUazbWn5KOZJSedOKQu1jzgDafHOQJc?=
 =?us-ascii?Q?JiWB4N2Ftskr617exgeFt0TbXCGdoaBES0niAGQiuvhQ76xzBh+EEDqhax60?=
 =?us-ascii?Q?RJrhKKvF5yMDKBDW6RnwzgBs55Y70a721l0Q1mYSHawRQZJuoY7clKfeVDNG?=
 =?us-ascii?Q?3Y0GWHILL7g97In1ri+0YfT2hqb85JZQKX5rxB1+DtXDU95JDo/nPJ45EGwJ?=
 =?us-ascii?Q?xIiFc+VhPrXmSMKX3QrWX37/Gcc5ptAX5atLHJEu4hM2GqlQm2KmI5FAYIbm?=
 =?us-ascii?Q?H/2OYfu7lIayRLmMSDnzQTyzWr8+duN21zSa29VRRZdvkon7RrG6bm6qtJGw?=
 =?us-ascii?Q?oi7nQrXoS8moAksvLYO6/DMGUzWlPI8lxZXzvDJVx37htMOU/+DptLJzb6jO?=
 =?us-ascii?Q?6d4/ZQB47gw7I0ib9kFEtDO+l6ONeqTYnsN5gNvKSK3U1Jy3YjEdMcxHgcIh?=
 =?us-ascii?Q?8nmDDAXfKlF57kZDesNYDdMS2EXVPK0RuOcS8dplvTl6Ri+xXCxFqjdo9eEJ?=
 =?us-ascii?Q?2uO1+UvEGP1gIQEdfpJ9zXrL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dc3dd4b-9a4a-4fbd-0162-08d8f9951478
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 07:16:36.5465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /RhsLVb/mEnzzKu73Vq2qupbkknHBGHJ+UQ4QLvtbmtUbQF9CdWVKhyycv/fdUgrwvtwrKK4cSHu53WMQUtR1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6509
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add i.mx6ul compatible name in binding doc.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt b/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
index c9e9740..12c316f 100644
--- a/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
+++ b/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
@@ -9,6 +9,7 @@ Required properties:
       "fsl,imx53-sdma"
       "fsl,imx6q-sdma"
       "fsl,imx7d-sdma"
+      "fsl,imx6ul-sdma"
       "fsl,imx8mq-sdma"
       "fsl,imx8mm-sdma"
       "fsl,imx8mn-sdma"
-- 
2.7.4

