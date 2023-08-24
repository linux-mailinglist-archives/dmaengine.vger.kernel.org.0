Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A03787300
	for <lists+dmaengine@lfdr.de>; Thu, 24 Aug 2023 16:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236902AbjHXO7Y (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Aug 2023 10:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241953AbjHXO66 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 24 Aug 2023 10:58:58 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2076.outbound.protection.outlook.com [40.107.22.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64C7FD;
        Thu, 24 Aug 2023 07:58:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MEj6HJVTknmNbkXstfBBIpIMkejGFQFvH3X1etRRjclF8UTjLcG547nTRTu8foMj6vE9YMuWYWzeeijJAyRbwZlIbr+fQslfhOAdrtgvB+MfQGPYcES7gy4BqaNrkNYN7VQD8Gi08PoxC1JslZyxHP0+I8+JWLU+6lg7SBT2YLQrXMWK5GQTf0FzlLGxV4rAKwEAGbOPL5n8afSm/ntTqs1RYc8NX8tLtO5QdecR3irFFqv32mS4o45Ote6xa4WbhxtK+9GkF6Srv0DhJVFdHQGKXYlaukqdf8yjYdjs0oKxPRI+aCbBikTeqVw6m9eeCuckpd5cGeNVLuTkJ8/NNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SwkKWtYXaZf6motSmdYyb8cJ8E4/tDskd/G+4P+dJIE=;
 b=dIS5VcxPWv7kHIT74VJ8iuiF72GPWeu/PblQ11XcYADtdzVTxaE7fGnnfqeHZiVip20A4odt3rNqQE/xeaoAW6xuBbQFve1zKAyoyTEL0vzv4eh9dnsgy1kR/+iEYkm+y01HvEwyxZ440lkBl9KLqanXpQQ0lz8S5aK0Dgc9IwhHS4WKG+IW8NhR9V34P/N+IEtYpQDzSALGHuvF83B2rtVFiTSzABVi0aB+ocrY4jjifAyL7rT6vHvcWgwGrS8xVq/mLUQnCgWGwRo3C3Z+tW+Q9SWI7WZiMHwhOIdbqKXj9pY/EGQFtymXxL6HlInPcRhMUpOCbdi9c9fAciwGOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SwkKWtYXaZf6motSmdYyb8cJ8E4/tDskd/G+4P+dJIE=;
 b=N2ZrMLMY9RXJHjK9j4LdGBz9jdJzcIB9/yRcxWnejSmUCAV5DiQjld/Y2a+lLkxLNY1Mt942x8djLWjWSyuFDkwd8V8foSMjeb/B+S4oyoYhps1IW98+Q1H/973Oo7GPYC6ST6ps1A9ZxDneh7OBr9rNQZVLdXrY/ATf9cQ0leg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by VI1PR04MB9979.eurprd04.prod.outlook.com (2603:10a6:800:1da::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 14:58:54 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8%3]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 14:58:54 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     rdunlap@infradead.org
Cc:     Frank.Li@nxp.com, dmaengine@vger.kernel.org, imx@lists.linux.dev,
        joy.zou@nxp.com, linux-kernel@vger.kernel.org, peng.fan@nxp.com,
        shenwei.wang@nxp.com, vkoul@kernel.org
Subject: [PATCH v3 1/1] MAINTAINERS: Add entries for NXP(Freescale) eDMA drivers
Date:   Thu, 24 Aug 2023 10:58:34 -0400
Message-Id: <20230824145834.2825847-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0237.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::32) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|VI1PR04MB9979:EE_
X-MS-Office365-Filtering-Correlation-Id: 6564e447-4a50-46d7-efea-08dba4b2a259
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bxYYk2eicZWjoHFwdGyagCEk5Ur5laiCoROyLD4kg3Rjh6uG+KKlLf2zKOBQD+yqBSBYIl3xOrqDfvOTasqcbRtJPPpD5Ca5399Ttaf0b0YOtYfC+u5EKBWuBaS5Cz1EPavJLkhJnWNgENZ5YM/AWN8kSnXHtpnIYSLy664dqmsvB3g74kRgIKfw8FumaHHB4YWw/NKoDLpeenCuL5p+9spJpQCJKl8OsztovXEbmbvI8WYCjEUlI5u/6PtAAltWZK1Vbs7FA2Xjd4yjC+UPj1FmbhC/tRLfPiD/khDH3gOxWJckWcRGpegdz74TBk/MzD5oh/2pSHVC+JFg3sQpQEw02Sktel+1apWfWMhOhCgp5Lcbzvu2mMXptTnRF/X+5Ca1OdSYkTmQSUNM3nSUJ6u3GHEOvOLcWJuUhuEwY1zNAGnmcdfwbrwVpNfqDjMYXs+jfJJd3o8HD3VN+K936E+ArZ9/8s9jkbnpI8ztnOSoQmUpmxiDeaLSeTvam2dj+YpcBwNWRdD5PYL2o4fcRSqo1nnFeyLYK8LMK8F0xpfdrchr/Nv0y1gcx+PBByB1ee6quLihbpKqVk5OMlJxp4OdB9VoI+9rof/I1FCpcQfr1LWWaRw12Q8yunjpvHTMhmnWJ0yD7/ffumX6++7+8v2kt2GraC3z7W2bhiIHZ4c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(346002)(396003)(376002)(186009)(1800799009)(451199024)(66476007)(66946007)(66556008)(316002)(6916009)(478600001)(26005)(38100700002)(38350700002)(6666004)(41300700001)(6486002)(52116002)(6506007)(86362001)(2906002)(6512007)(4744005)(4326008)(8676002)(8936002)(83380400001)(2616005)(5660300002)(1076003)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4rDh/gkRWQGgCMbagSj1pxYnWFAYSA0cXONFsW/igt6dtQZKr82b+zfYlVjQ?=
 =?us-ascii?Q?iiEqMF1UzcdypQOpPE7Y9y10De4ElAnU4U62Gj0VbOIhy+ivv9bsaJ7mEyHu?=
 =?us-ascii?Q?9mko8yJovpGQXkFGGKc1MbXDABBR4/XT1MVIDbKcSj+T3/66eiJ/fU3bOGb7?=
 =?us-ascii?Q?lKvBY4OgHF0Ao0D+c/zNVcIzWEFJnDr/R1ukXZUpmJo/P35XLThZRYRnki7n?=
 =?us-ascii?Q?k6MpgiE6Aef53+LhUUXLOyd3nsOPJY2Z0wPIb2+BGZQTq9wtF6+IB8BJd5+l?=
 =?us-ascii?Q?n9zGWhydqwQInZpdXMai2NJpDDmUyT6ses/PWX8ajpOu00uB3567WYqffI2s?=
 =?us-ascii?Q?8XtmT7c/zBtafR3DR9Xhca338ClpX9+LHe1JyvhL7rZK8SBpYDDAq58QejMh?=
 =?us-ascii?Q?woFD3s7eiHs5rNEUj9a0dbpQ5EjJBDo9pxNRjfwACk1DaYyXsjN+pbNVXYZ4?=
 =?us-ascii?Q?n6BUk69HODnujLYC1Gnq6Bh4BfBRyXYX/W0OSOXs9SmmfRiefzAWORPy8/ST?=
 =?us-ascii?Q?ZaPMqxwsnQEoerdoo3+hyyNfFee7l7gJIy0N7mfA5Z8cv7nuC832+z4tjbQM?=
 =?us-ascii?Q?FMPsVrCmMacIyc6w8Vix5K9T8vjnI5PFn98pChhqI/UwFIxH3xSHD+2tQ8bJ?=
 =?us-ascii?Q?uXFogSI1qrfVTC9eHMcWOWepkiKMClgIWR0Bf2cU02F9/4S39hk8K3+JS5fR?=
 =?us-ascii?Q?JXAr7h/jEJpfmsxBlCactAKkcapMMXhuC5/YR280CIWD4qIg5fr9ReW8hzZd?=
 =?us-ascii?Q?N/wEfYYO2iBVYiYPcoz77qxnNXUbMei+OAgbcy7N6J8dAxcScmZsnOoqlvPW?=
 =?us-ascii?Q?WT+IL8zNVxeO2E5JObDDxKYdr1Ab5GsLTZIvB0dlvubyRasA/7oCm5jM9/ey?=
 =?us-ascii?Q?JpTFdBVvH1dEM1NldfaIndILS7XcBSwwE+Xx0zpk1ohihb1SQOa5sfpxLbEn?=
 =?us-ascii?Q?ZP8+WlpNsjuWO4o/7a646p9Os18gNB6xjL3gt4qfSlHsUQ+WIH/Cp0IM/2++?=
 =?us-ascii?Q?qBwMKVCfVzkZMUZ0oBC0/7HNbksEy9VzSBGlpKJd/NRhrmaHoTyIePmiz7Q6?=
 =?us-ascii?Q?K3bOruiDtId1aH742UICHQlOR7QlmH5vbNMW7FAFCVkM6Jy2RtsLF7dYtqp+?=
 =?us-ascii?Q?auT8tkyMR602B8xIk+JMd+JvgI2QLzkWmz2taj/K2BgZLImLD4ONyhDH8pXe?=
 =?us-ascii?Q?ewEW/46+WIzQuKPbLnXQiTbA9hj5xi/sz/FTfrbYXKDVqpINGlYg/aHToFNY?=
 =?us-ascii?Q?uh4Ur4QsUbsu01qHVn0v8PxNddV5lZi7do/eEh+Z1nir8dp7KdXaBySkF/UR?=
 =?us-ascii?Q?k6XesfW8qDR7fTqTJLgzL+QfmrTREWejf/NQ0GiAOPQAyAaAIHprwLJuapmE?=
 =?us-ascii?Q?vkPMMWAxbj8dq8ZLAe7db0bBI4pafTPHCom+k6GsXUKZaBUuPE0x8547Nrps?=
 =?us-ascii?Q?ATUi3Ros2LrvvxyHpTjOPqgZLCJj+76TFXKqsgrMWOPJ/+PkN3B8dgQrBslD?=
 =?us-ascii?Q?mP2HP3ojVeQmrfntU/dpQbsvnIzlXMjNjdIijNF1eRz3LFotf2MmqUW67fFW?=
 =?us-ascii?Q?sxdTASpXBL1SnsCkPDJ7XESUudublRLLq13mtUe2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6564e447-4a50-46d7-efea-08dba4b2a259
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 14:58:54.1156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: feXIWvQ5snvtJs8n5kwUos8UVufaza757pzgEx53nQbmTYJH7pKlEi4FECRP/IrZjuVG/zYdyZGEKdblPI2Xog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9979
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add the MAINTAINERS entries for NXP(Freescale) eDMA drivers

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v2 to v3
    - Again, fixed order
    
    Change from v1 to v2
    - alphabetical order

 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 23eafda02056..c1c7a9ae244f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8236,6 +8236,14 @@ F:	Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
 F:	drivers/spi/spi-fsl-dspi.c
 F:	include/linux/spi/spi-fsl-dspi.h
 
+FREESCALE eDMA DRIVER
+M:	Frank Li <Frank.Li@nxp.com>
+L:	imx@lists.linux.dev
+L:	dmaengine@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/dma/fsl,edma.yaml
+F:	drivers/dma/fsl-edma*.*
+
 FREESCALE ENETC ETHERNET DRIVERS
 M:	Claudiu Manoil <claudiu.manoil@nxp.com>
 M:	Vladimir Oltean <vladimir.oltean@nxp.com>
-- 
2.34.1

