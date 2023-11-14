Return-Path: <dmaengine+bounces-111-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2319A7EB40E
	for <lists+dmaengine@lfdr.de>; Tue, 14 Nov 2023 16:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 461BB1C20A42
	for <lists+dmaengine@lfdr.de>; Tue, 14 Nov 2023 15:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B9841770;
	Tue, 14 Nov 2023 15:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="R9K0M/ms"
X-Original-To: dmaengine@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9484176C;
	Tue, 14 Nov 2023 15:48:48 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2060.outbound.protection.outlook.com [40.107.105.60])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65A0BB;
	Tue, 14 Nov 2023 07:48:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oCuPA0OEiUGgCmoec3/bnFR9V9LPG9wnsh7Vq1UM+C217q5OXNewYhxgAPX/wDMk+c4ixUal8nsJJXSRQbOppbz1SothnlNmFG0wytYIB+HshorzXDcqoN57ZeNFbF9CkNaN+FOz1yP1hTnHx7TISAWe/vEgJQRVPJlgOzjZxMh1gDm1KrwTCfF5TD4ahfIfPrJxhUe5NkUrF/fs/0lkrypGg/nKBedzf1h/seIbPhhLVBM8ThH3nF/KhDWI8fRcvrp4MjBrAS44elBYgxztp6TqeBH0N8+VYsnGvZ0hO8yhaHlFUFw8OD3F/dZ36Au/r8y35TcZF8aON2xHdQ3gbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YqET8rV15/obDWa2GfPNt6AO0br+ooALAgiMEnteOvA=;
 b=WeyW7QHH2+ND5LcvNyVa50PzixZ0Yb/D0vhoTkaFp6NusoVFJjmZl17vu7LJO1SMUfBdEqz00w4UYPFGi22QP+pwu0GYov4+gTYz5ybNDLCJ6Nnos2cKnVuzpTjwYzqh0UpeXBy205zKVeaqtqJ38pBclXmrmzCA+SAhsXv6DdIJiJTjUZUM25VCuFbaad5speduDnk3AA9cqYxLeUIsqIS/qTkR4Q51RHYPCSqcBxIcoDp8VjR/sljxCoHNiLUrUiSvSOW470ptVWVrGgZpIOpBY7qWZ8RYknwt/8hco5IEl51a/z07gcxzQjkTkytOS6GRNyQIV+vZwqej4xXh2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YqET8rV15/obDWa2GfPNt6AO0br+ooALAgiMEnteOvA=;
 b=R9K0M/ms3JBxZuQ4ZHuac1zpQq0gbbdV7YgWRFQvJ3wnEM8aYiMSF+XItNboNshFQuomAv3QGOki5/hpVtVfWsVi9usf/+jGMaXN6Ea62rYxYvBTJDbG1PBtFeX3Mp8tf3aWoP7oLhrAJJ/MhOx+mnu3CMoYArQzU9YiwuB5vAg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM9PR04MB8113.eurprd04.prod.outlook.com (2603:10a6:20b:3b5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 15:48:43 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::bc7:1dcd:684d:4494]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::bc7:1dcd:684d:4494%4]) with mapi id 15.20.7002.015; Tue, 14 Nov 2023
 15:48:43 +0000
From: Frank Li <Frank.Li@nxp.com>
To: krzysztof.kozlowski@linaro.org,
	shawnguo@kernel.org,
	festevam@denx.de
Cc: Frank.li@nxp.com,
	devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org,
	imx@lists.linux.dev,
	joy.zou@nxp.com,
	krzysztof.kozlowski+dt@linaro.org,
	linux-kernel@vger.kernel.org,
	peng.fan@nxp.com,
	robh+dt@kernel.org,
	shenwei.wang@nxp.com,
	vkoul@kernel.org
Subject: [PATCH 0/4] dmaengine: fsl-edma: fix eDMAv4 uart dma loop test failure
Date: Tue, 14 Nov 2023 10:48:20 -0500
Message-Id: <20231114154824.3617255-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR13CA0010.namprd13.prod.outlook.com
 (2603:10b6:a03:180::23) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM9PR04MB8113:EE_
X-MS-Office365-Filtering-Correlation-Id: 60b956bf-cef2-4bc7-36a7-08dbe5292e0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oxgUYmuxM5cat7BVbCgc3UVUrhP9bEJYfPvoQ+cnA5bgq8XVxn583HqmwkYqp+n3VRk8vWYHQhz/Oef6vP/kLkYfA+XoKxmRiFD6JsNX+HNEYEOcBPbmKEaHs4lhdOJ8UiiLwfVBKBWcYKevjHqAt2ShqwkD/xmuXhMo9d4HWAqmPGciK6UCo3fBZuH76A0Q930Km+BWW/dcG5tf5aXWzGpJCDaO9b74b6SSnMqQCwB1k0DIenVkoLNdTyC35UN3wLn8kAF/8Tbrk/GSM0quZRqd3MTWB31onUoToOezZZr/uQQWrRou68w4rryWvMBZuFQ1Ag+w52XtoilIziPZEUCj5UvRAzE4/cXj6hC5VmCV2XPhS9tG1NUIjAAUEHjnQ/E+xw8aFDlnGZXv4Tz7n3WCOkeB9zgio1sePzV5V74JNofRQQmaVmu5twqmFvwPrNmZeGvlJul8EumfgpWESk0GcgdNKquKifpREWLtWLJj2MFBadLwHDbWJSou1wuyzwdD1BrD22p1J16jdxNRGtcd7VY5ZcqVf7pIkAaElou9BGrjLbuvlWc3iIy+8YJhyD/ZsAYUo7Ox7pWTa4dabIJEpXGF6YUMslSX8N7XuS5ZGW8eHrRUyVEwq/QYWlN5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(396003)(39860400002)(376002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(1076003)(2616005)(83380400001)(38350700005)(26005)(478600001)(52116002)(6666004)(6506007)(6512007)(6486002)(2906002)(38100700002)(8676002)(8936002)(4326008)(36756003)(41300700001)(5660300002)(86362001)(4744005)(7416002)(316002)(66556008)(66946007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1lci6nMK/uO6z7cfiBvgs7SXir3dowY3nvSv+JtouoMydfkXfOof7N+Y/NF+?=
 =?us-ascii?Q?Jt3MkJ0MHWip4jjpZFqYxHCPrTZ3cgOP290fdsola8s0Vrr4vlGZJ2Dszke/?=
 =?us-ascii?Q?4xEBGuo3M71lPNIso6totFrhhiDvaZL3DtttgHc5bgZCNgU88KZfFjtuOir+?=
 =?us-ascii?Q?hqqVXYHMnFxBoCENy7Quv6dFXTTPZ1njwUgRQvfBzVosHY+qqdX3lBlYixt6?=
 =?us-ascii?Q?DABwvlwS3027Fs9b15KIIFBXgegoj2ISYecVb+SZBg5qeZ6ee7amzv2tZCSf?=
 =?us-ascii?Q?rdR0PGWPCYL9aWyd5XIC5KlG8wvrtgn9l0eNCnWww0QoxRX5kqO0fOo7YXE0?=
 =?us-ascii?Q?PabQyPvpRyI1UtxxJyyrBrjwILbjMzs7S+JtULQaRbOImom4IIVkfLmZvKBA?=
 =?us-ascii?Q?NKzgswskBUsUbAPS4kczQiIn+k2283LkyTSm4aiIYEHLA6p9dpPbAnNDdgz4?=
 =?us-ascii?Q?HqIjZ9b2oOFQeegAqMPKmVLCihkFiBqijZuZiH8EmzIvt6bOva8AjbB6LAN5?=
 =?us-ascii?Q?7fEgUf4ktSTSaviAd470vTlk7HaHCoJNixoLGDx2v28PEb/7CYRtc1c3Jad2?=
 =?us-ascii?Q?EWyCOAgXKZ2txvj0HIal2LEu8dR6u1RKxh+M3XYad1P0/nvUjOiU/7R3UlBc?=
 =?us-ascii?Q?i9AoRnICaNxbDaUETDZoaC9xjkYa7AI0SC1ynyYRWqoi0+ef+MmaNJ2EQmq8?=
 =?us-ascii?Q?ySzePV0b8JXdnacg7obFcK5mCl5ZUnHmzoRbhRmhGvX/dPZsRAV38xtD/EpE?=
 =?us-ascii?Q?C+VTJVH+TGH7s/RbOvezLFQX8LvkkqFl+nAXrFzXkscQQpbKn6PYHv2dkQYB?=
 =?us-ascii?Q?bviU9Vq7O1lXmnbQe0q+Jv7jZO3cNL+Ql4gRkS66enrvhh1F+UVfSdpOf+pG?=
 =?us-ascii?Q?SsTLjRJ+D8IMOJ+nvYplpNT1ZAUAI3vbmximUVWhaSjewswQJurfoZ0uTvXu?=
 =?us-ascii?Q?1XtL+EamnzfHy9l+2vJrf1S2Zq0QKBSjvTJ+o2POFO+iQu0+uxHQWLCCHLsR?=
 =?us-ascii?Q?rntNI2BEuMIEDlazIoqHnhSFIPlKsDXZ3nTH3X+Bd0eOEFReJkxRweVl249y?=
 =?us-ascii?Q?eJVM0nCijiZFxoa6T9svaLeVX2CBhkSIhfJ5JcUEu/018xUQP4uBya3/osVe?=
 =?us-ascii?Q?9TUGLlRVXENo56GbfVShqJTDI0S6BcGbNWk+/Z0heaWo4FJC+9DehMBjc2eA?=
 =?us-ascii?Q?FSekORoiENOTY8JQWIdeHdu/D/uSR/xHC8Bo5vKQz1W43/eZtBAN9HI8yDUl?=
 =?us-ascii?Q?w/vRm39sKQQIgKp42aGO8Yjz/8XUxM3ac/Ocmc/COvpIYsxrpzib3Sjf4JXV?=
 =?us-ascii?Q?7F3mFP+rUFSeZ36MZSah78s+V8iChyQhTTQBt9ZyXxJ3wp4O5hGeN7P+I16C?=
 =?us-ascii?Q?lPFXEPolM72bo5+91S6+OZOiq+paQTb1x5qs18PDOE4FsOS/tOnOKhmRbCBZ?=
 =?us-ascii?Q?E53QtuLETM1sNq31tdY7JvxYThlMCSQitABeQV19a7nMmLPixqKN+HKoFD+7?=
 =?us-ascii?Q?n7Sp4XqB+fzqlhEHcl8J3270+UBDnd6tiuvAJRMxWzchCKH/AQ6W2DfTKpfu?=
 =?us-ascii?Q?eeepM0z5rrNgML4YF18=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60b956bf-cef2-4bc7-36a7-08dbe5292e0a
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 15:48:43.4901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cYDb71fvsSokhrK5x4BrdO4A2x6Q22FAyaq4FVwluU22rz02HbvReXWM6WuWbb1g1z5yn8twJAn7Nw5jV7QWlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8113

The commit a725990557e7d ("arm64: dts: imx93: Fix the dmas entries order")
trigger a hidden eDMAv4 hardware limitation.

Some channel require stick to odd number, some require stick to even
number.

This fixes include 3 part.
1. add limitation at eDMA driver.
2. create dt-binding header file to share define between driver and dts
3. add ODD and EVEN requirement for uart driver at dts file.

Frank Li (4):
  dmaengine: fsl-edma: fix eDMAv4 channel allocation issue
  dt-bindings: dma: fsl-edma: Add fsl-edma.h to prevent hardcoding in
    dts
  dmaengine: fsl-edma: utilize common dt-binding header file
  arm64: dts: imx93: Fix EDMA transfer failure

 arch/arm64/boot/dts/freescale/imx93.dtsi | 13 +++++++++----
 drivers/dma/fsl-edma-main.c              | 17 ++++++++++-------
 include/dt-bindings/dma/fsl-edma.h       | 21 +++++++++++++++++++++
 3 files changed, 40 insertions(+), 11 deletions(-)
 create mode 100644 include/dt-bindings/dma/fsl-edma.h

-- 
2.34.1


