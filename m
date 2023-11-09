Return-Path: <dmaengine+bounces-60-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BC57E737F
	for <lists+dmaengine@lfdr.de>; Thu,  9 Nov 2023 22:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B7E128112B
	for <lists+dmaengine@lfdr.de>; Thu,  9 Nov 2023 21:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314A4374EF;
	Thu,  9 Nov 2023 21:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lMIuPyGM"
X-Original-To: dmaengine@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40824374DE;
	Thu,  9 Nov 2023 21:21:38 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2047.outbound.protection.outlook.com [40.107.105.47])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F75D3C05;
	Thu,  9 Nov 2023 13:21:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A5PrIqHlEgT7P6U+JznsaabdM/03bLWzvFtEGjepIqoEsMlSuEfMMg8s8N27GjZboNxR7HUOV+uoM6nuS06yfyrlLgELUwglQYQvRqZxP3k00E8Dul5P3U1AJB6snjSZ7bcl3IeXeiRAPdbB7qkq3/qd5ofoVcPhrmJtedvgNtZwtKlTUBhHktK72TTVouc6iy6SfU65wHe+4skfRkGGznh4Iejvc+zyfdO5Z+/mbupinIPPCw0W1aBdmzITLPUVgfYbZyXeBFBrdT0CC4ZDRxxmpsrVSeKvRKB1S91Hp96zDJxozmcIpuiTrM1XUVZDMR0huRwLdMj4NA7OX3Nw4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v1Mx6XeawNDc81uQYBW7oPzCVcocQG1tHT/QCKiv7FM=;
 b=Qxybucc/hEuL/tm6p/KQOpHOOXjtU3au2hB2fk5P37GeEzdbyYuiubL/Ip0XJdPLsRfVmg/Z/zIXkRxVbzkY90UGL67l/zWLXwSqMSiMw0bqTbEEyIEa5jd8huC8mrEQRw2O2gh5u6r93sEYRXL/NdUPglp13vjKzMWbkfAkNRAeJNpBbCNsMx2EYjE6/OTaoGR95CWShBtsXH4J/65ISkMc2TaPlAmGVpQ/pWUsd4syouZync0S1c+7SUbKm24F8gaXX9hH4bLkRe1yDuFKPOKofo54es8x4jTEPJ4GltFfJKwvJfTHnznrJ99ahdNts/JkAPURTsC8By0VYmSctQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v1Mx6XeawNDc81uQYBW7oPzCVcocQG1tHT/QCKiv7FM=;
 b=lMIuPyGM7o6CGfFmbyLozvKMWYeG2GVu3sSmkZuwYMaS3QrbNsD15cFWJNbBnes9WCxfE4xIDJRqiKgUeH+Ol+hpiamWJtcmi6VeWlpZyGjIL1ybiXej0PwvqWC8UE/HaPAysVFTvIbzBe9ApkUOP4dQsVZ54P+NNfsjnNHFbf4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DBBPR04MB7836.eurprd04.prod.outlook.com (2603:10a6:10:1f3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.7; Thu, 9 Nov
 2023 21:21:34 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::55e7:3fd0:68f4:8885]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::55e7:3fd0:68f4:8885%4]) with mapi id 15.20.6977.018; Thu, 9 Nov 2023
 21:21:34 +0000
From: Frank Li <Frank.Li@nxp.com>
To: frank.li@nxp.com
Cc: devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org,
	imx@lists.linux.dev,
	joy.zou@nxp.com,
	krzysztof.kozlowski+dt@linaro.org,
	linux-kernel@vger.kernel.org,
	peng.fan@nxp.com,
	robh+dt@kernel.org,
	shenwei.wang@nxp.com,
	vkoul@kernel.org
Subject: [PATCH 0/4] dmaengine: fsl-edma: integrate TCD64 support for 64bit physical address
Date: Thu,  9 Nov 2023 16:20:55 -0500
Message-Id: <20231109212059.1894646-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR17CA0013.namprd17.prod.outlook.com
 (2603:10b6:510:324::6) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DBBPR04MB7836:EE_
X-MS-Office365-Filtering-Correlation-Id: f92e7a45-07ec-480a-7804-08dbe169d988
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0LZBAb7IY4M/j5DazMBZVHODJH5SkDe0ahPJ/Y0SVYgIN9BQ4AT0mIHhoilOKtAHLle1Ti2/fpc7/EFr1xkRWzQZLNuc4JEpvtyIbK5lpqfVaOb1o+cqIbzhYeyQD/TVjYiNpNxEeg9vMWATG8vH/y++HkzxFw1uNk0BiUX72BbI+pM5qwDCG9n6oFH5QQGlHPo4UbJvwMP6pufDp/x8/buLiZ67bxl0pno9+9dvnuVdDYJSTvxkSHNfDAIRjV/3YSO9/2KXvGhBzFB7iuUH7rUfNTVyYiQUP4i/Ty9mvUOh2i8XQURN2e0/enaF4lvLzA1RTNxavR32gcHGIpkQXDCQuPa/zsQI+EH3LIfY39mGHQCQr6jcRdga1oiSM7siE7Sz3zJxhIe+S376JqH7ZAJo+FTF6cYDDHYBRcfSGTwwN0wyFxkJTxp5SrY/ebv5VKRJSilYr+9BfisvcwoJBL9O0MHQKBoUJWVd6WpgYE7QFWJdm/2S0osVegejzFZq5wk0k8PfnofFP1UVpmALnydeZERt3HcPUEVXFU5LgoJG7xd2pgrb557e+xtu0UklwcVgv+ibVCwdTztjPcNzoC4aHPeNV9fRAk0RDK6J0lCct5QxtiR0ql2D+w/TovvF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(396003)(39860400002)(376002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(66556008)(66476007)(316002)(37006003)(1076003)(6512007)(6486002)(52116002)(26005)(66946007)(6666004)(8676002)(83380400001)(8936002)(6506007)(4326008)(34206002)(2616005)(478600001)(5660300002)(4744005)(86362001)(38100700002)(41300700001)(2906002)(36756003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mOko3Geg62SBYdZ4AcJmOFKBK4EKgDYUFP3xXXpBaxwoLrnEvo8zMqf9oAOS?=
 =?us-ascii?Q?f+FwKDXj5TVlEoF+64M2ZGJWHphc6xvAwUBW1T5eEMA8IJG/+dBiqEdG909o?=
 =?us-ascii?Q?DmlZWLj0BVlDr+VEsgdenuXmPyCLG2V81vBtckd5RgfpHJuxvXF2Cq3MdapY?=
 =?us-ascii?Q?ELBW1HbIZFCrOJ3pTXv5V2h3eClbr3cCJ0pU/tn8EdHDg28g9vhfuz6Oy2b8?=
 =?us-ascii?Q?0W9L3fpLeTSHmAkbkGknB5DqpqnDHiP4tD1cArgLeiSb4WQyQADZHSmlnn23?=
 =?us-ascii?Q?wBfmVNpr/8tWkRhVnfDDr6Wo6GlkrbrYnZxYdgdfOBTCfIgjuafcy2PKoOiu?=
 =?us-ascii?Q?1xW+NtjXkCjgSLcIOWDDP+mW4NHNMynIvNj18q1SR3lPDqHDv+wL+XjXGJzf?=
 =?us-ascii?Q?9aqHxfK++ZMeYc2aK45Xv32K7Ykj2s1+XNV3skNw7JAgm2k5IsUZ4dk0ykBq?=
 =?us-ascii?Q?JLJfICCr0xqiEmkVtcBXwemxmfIH/Lk9I0Sh1mQZMHsmSmEjTZxPmote8Kmy?=
 =?us-ascii?Q?PqMDofibFRXMUtk8iw99mXcnDUDVEpTZhIuxna57CprX9VQqXq/O+JB7MGi9?=
 =?us-ascii?Q?/Jbjom02XJ6VqaHL6arnBSl/bE10t7Kn9NPcHDt5CBt9gg/F0T5I1TOw5Y87?=
 =?us-ascii?Q?t6O211h+UlFFUJINpzuboVf0+iJVyQVKC3UzC50XnQL1TPyOHfJAUodILIyw?=
 =?us-ascii?Q?Tu1ienlk5q/ctrE3AqlH1064HuwxFJFsHLQqZ/SngG1H31xO3fgDaXwQdSLp?=
 =?us-ascii?Q?OZhEPt2OKeqHFSOtsPM1XcAQtvoZLHccLBOxz6DDk1koBVH+OPEaxQ79cTUY?=
 =?us-ascii?Q?5mgLGaMS+L1U9WAMjdOkDgB89vxsnMqhLR7kwzJ2bMXGPJGeQf5Stc5lJK+p?=
 =?us-ascii?Q?3pbAi0aKuaJNoeupcsYqTSWxSvKi7KcUmZ4K73jZzGcPdEQ9f8D9ZB7YYRlw?=
 =?us-ascii?Q?e82cCtDo6VNSAO0A8Uas/adKNCFJWeXBxP0Q/oe9Wt9UqNM9EEVkcOuQcVpI?=
 =?us-ascii?Q?DPI/nDlnZ8Y8rdBc4hkYp1mKhNltqmAbGOwVl+kIT6Fr2Umh0UlHAUYfqU7j?=
 =?us-ascii?Q?UlNJWpWgM9E+NxzZ0Dw8gmmbpSnMSvmXAQpWhk04AaHB4Fwb+7TYwhhS6On/?=
 =?us-ascii?Q?ETbb+q+8MhhOx7RNxxje9GAXuGoYbeQgKVdqCpJAhAfc5EbBcgrFoekHfNGu?=
 =?us-ascii?Q?7TFRHSyGpNQZsBkKLO5cEwy5ZgfAS9US652UmkHhTuC2+sPjkm/NGT1gsnwl?=
 =?us-ascii?Q?ku+R2t7fl/GelAWmIhb3CueLmRnugg1utjYySfYMXXUdCOSBNtJMkRVpPnvA?=
 =?us-ascii?Q?ZMfiWO9HGxZNUuXltuzwF5+Bga6tBGed4b5uRvjeteHTdv271tYLdlbmlVI1?=
 =?us-ascii?Q?puPgWoXjuifm/qFbl4oBeaLvYUbL1f3lkfRfNYCBXI3aPGL16M1ezRb5p1wq?=
 =?us-ascii?Q?Db6mzf4y9qsREOSzVfXxjqFj/Rhh+Vq9V/yfB75OfwSNddZh4YyrRx5HoEVT?=
 =?us-ascii?Q?NUBLD3PnoObcUX/2h0mya4kgkVMnXf+HJmzxYMvmj7gDNH+VnFRa7J0j0F+d?=
 =?us-ascii?Q?S0U/l9x+VNZNYN/KLUoFZfel+W9IAi2cYhjCxX3E?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f92e7a45-07ec-480a-7804-08dbe169d988
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 21:21:34.3702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3GPpkAwgV7xDKYXxQoMtItbuN+v0WKwjcCAs+busPLFdAj2d0AB9OLh8B+BCfj/3x5RIyXnpp2Vzm4O7/6l81g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7836

first 2 patch is prepare, No function change.
3rd patch is dt-bind doc
4rd patch is actuall support TCD64

Frank Li (4):
  dmaengine: fsl-edma: involve help macro fsl_edma_set(get)_tcd()
  dmaengine: fsl-edma: add address for channel mux register in
    fsl_edma_chan
  dt-bindings: fsl-dma: fsl-edma: add fsl,imx95-edma5 compatible string
  dmaengine: fsl-edma: integrate TCD64 support for i.MX95

 .../devicetree/bindings/dma/fsl,edma.yaml     |   2 +
 drivers/dma/fsl-edma-common.c                 |  85 ++++++------
 drivers/dma/fsl-edma-common.h                 | 126 ++++++++++++++++--
 drivers/dma/fsl-edma-main.c                   |  17 +++
 4 files changed, 178 insertions(+), 52 deletions(-)

-- 
2.34.1


