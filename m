Return-Path: <dmaengine+bounces-1905-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1F48AB150
	for <lists+dmaengine@lfdr.de>; Fri, 19 Apr 2024 17:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B20781C214C4
	for <lists+dmaengine@lfdr.de>; Fri, 19 Apr 2024 15:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E01E12F38D;
	Fri, 19 Apr 2024 15:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kjKwEPjo"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2048.outbound.protection.outlook.com [40.107.15.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1498712FB03;
	Fri, 19 Apr 2024 15:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713539277; cv=fail; b=DCIRyIuKkHJrAY8gLX6RzL8ava3ApnEyqaaADZ3o39mXUfYPFdHJ/G1tfaz3X3la6ESG6aneqgYNdddxWgHGdVX2TuH2NLT1EjId6wK5VMVb0rUiqjo291llQxHmqvuPbiwBXHKYNPyNo5TLxgVFtcnTRB6/yUwuNnSEXRX3oyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713539277; c=relaxed/simple;
	bh=LezexKi/njf5WJzUJ5rLzvDGoE2jGYh71MApeI7QUb8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=n+hDT3pdxi4tbcLFy/E7Nn4fxy5EeWnPANz8a7oRM0H0cCaPTcgHzXMMU3OTGBPedrsaLio/FNCrEFY+aevZBo5i0yQgkNEaxxvJKHe/MsuWzneABKDty8SN76KXTb+nQIAcqJrV7mBTPSOetDtT66sT/MI0drOp8iaVJ+WE8CA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=kjKwEPjo; arc=fail smtp.client-ip=40.107.15.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nrDBbXVBpXEH2OQJoGeWdAimNZfH0JQ+t47312AZAFb32Ln69vOR6opvmJYAczeNv2MOJ/BcBJ0Nn+2o/dNtMPChMwl4YhZZzrx93+MmAhS/rZepqHjdRUGnS2sbY3Ij2ze6DQsqo+zFen4oh1GIFypQWUNP5ce6DbuaHmOitgiEDXyDx7uV94GXJDgUI6xK2sK6eO23LOO9FNxdrGHaimkQmuSqZhWOa0+g1j98kFTW4kZozJrLIiLRua7wRUkJXGSRD9TCsdLnnOq/VT/hrncoFkfGlebhes1jauHcAr49qay9xVy2veWjfT8Nkg4fIcQ/VAe+mxRH7Dljl28MWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=48Y0BjVoxPxokN2MQq+QIxImoQoKWsrW7mlrMSDnp+Q=;
 b=iQ5wzz4qUWMeq1YI3FMAhIHV6OD8JAFk0STYmlR91jSaX78/AX0kjnfyLub6WvHEzz6EuUhH47fxJ4j5nJXismWj5b+4EEvBNJ8GstkpV/CzsT8DsrxE58H0Ks7zH1HzshP+MsayPBbP3YOM/bNbfxYrmpSyLmNiOQj/YXTYrSNFkC9okH+5zARuAKhqnxBaDYHeCa0kBRQEC5tDf9t1gJeONIrBoPwQ3jAdcZs9CrX5DVCpNPnN5hTgN+XR8VvXaHmDFSQfoYaIpjUZZmdf3TqHDeKbRmNQN3DqyetgGlPfAXBMZVmRfmtif0LzLLOgb+U5bPbdojd08wOdB1ePuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=48Y0BjVoxPxokN2MQq+QIxImoQoKWsrW7mlrMSDnp+Q=;
 b=kjKwEPjo4gjvWvovGHvHK7jKH9u+XHXmZyYRYFkzIEI7mq57KSkh12Us5Xli2mBIiAfVhOc/z8o5I5HZQYc2+ljtexexQcT6Xt/fnHiulBVlssUGeOQ/HSIOewVX9LCHx/kjy5lSmb+E02oO2lM+mh1Ug0ahvu7I5FYsPJNI7Ro=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10330.eurprd04.prod.outlook.com (2603:10a6:150:1cf::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Fri, 19 Apr
 2024 15:07:47 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.037; Fri, 19 Apr 2024
 15:07:47 +0000
From: Frank Li <Frank.Li@nxp.com>
To: vkoul@kernel.org
Cc: Frank.Li@nxp.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org,
	festevam@gmail.com,
	imx@lists.linux.dev,
	joy.zou@nxp.com,
	kernel@pengutronix.de,
	krzysztof.kozlowski+dt@linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-imx@nxp.com,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	s.hauer@pengutronix.de,
	shawnguo@kernel.org
Subject: [PATCH v5 1/3] dt-bindings: fsl-imx-sdma: Add I2C peripheral types ID
Date: Fri, 19 Apr 2024 11:07:27 -0400
Message-Id: <20240419150729.1071904-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0008.namprd21.prod.outlook.com
 (2603:10b6:a03:114::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB10330:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a9fec9b-d4e3-42a7-0d95-08dc6082792d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KY9b3EULoIgwdXJWcM3lKa1aw4fbyJAA3bDoHYq2BtR4H8c36gmblaoPVUua?=
 =?us-ascii?Q?oLBpGPk2LEiUiQRd0/XJdbT+tdcK5vtSvp4skYovgKWvm5eqSbRuCkn2mMPQ?=
 =?us-ascii?Q?FEqSunmSw/XdOdWWrhGi1E3sIkQ7aCcBBnZ5QQrDN0rsE4ONDyaWgCIrPtKh?=
 =?us-ascii?Q?erjq6PFas5X8ZyCChlUiT3IfSVZv025XeKtvzeu7Pdbzsyp3V/2mVRp8PMtA?=
 =?us-ascii?Q?Be0oCyi98cd//FDaHKxJGUstdz59oAeLpFz3CU7hvjpoW8h2tW0M24C749Sg?=
 =?us-ascii?Q?vtK8QSXIxWGXPdiCr5u3qUJHva14/ukDMksyg2co1L8/m9xhgvXYcQWy3n/F?=
 =?us-ascii?Q?cIDcSsYv1zU9yBbyn6ZC4Z+dPpyWTrhDCHUMkHELxyqbi4XTWj4wDzsfsJ39?=
 =?us-ascii?Q?P4BCZSETPjqbUmh2u28d9Ua/5enZm6xxQyg2w86QZoFEJY0NkygafbH8oGqQ?=
 =?us-ascii?Q?r4DfUCWxfMy8UK1GeJfBYsSwtfX+IIsocJS7C202u61mEg/vuRJ0ZGTdkMOQ?=
 =?us-ascii?Q?kaGiLU9fpKqczqOjYMu4S4c+Dxzpc4WuQUKmKa+8+9KGQLBmmit50ZQcaydO?=
 =?us-ascii?Q?OAhtLrfn7ORyL5ZDrR0QgDVt4MnhyaSfTAVBCxSXId6Cixm6WdMtVtqMWO+w?=
 =?us-ascii?Q?TUWgljt5Q/cI6yK7qjWLIxNXAd7/7U9+BSII9E1a+n+q2WkzYnYG/QVTmlfL?=
 =?us-ascii?Q?JQPR5PXDmEkMF81Of8ylE8XySWbaL0dEIJmmdgyrRIgwl+ztntcVsc2FClDy?=
 =?us-ascii?Q?rI5+K0Q+OleubPRpZBS+25HXGYvPw3PIpSUJ4MvZ/V1uHiApyodREgK5Myh7?=
 =?us-ascii?Q?dR6TfSjbkb00kq/moI62abRR6QergYIkg8MS3nx/Fbs+cQCvsltt/9IbMfqj?=
 =?us-ascii?Q?sDG3rRtnA1vXNYKputwCtQrEzCgcfWEAZW+WtdZd04GpZC2SzMeuaXMWEWRg?=
 =?us-ascii?Q?aWXZMvNZrAVXnZJLw+C5GxuH8VFoXoVfCc99ZTKuUsYKAgYzMwyZek80Db/f?=
 =?us-ascii?Q?OORcdsTGtT+AmM9/v9YpNB8pli7MIF6cINHV9HAgllc2SJjeIZy3p93uY1Pb?=
 =?us-ascii?Q?TMc1FsaEXtzsnL3dyovd2ApDvS7eXZRu8o3c1X/rQ1M/ehO9qEpcaNCEbQWt?=
 =?us-ascii?Q?LaNHJtxazUXV3LG3a2yU54MHkoG2JGd3S2rdUM++z/hrmAbNNdAGE0CPKgvA?=
 =?us-ascii?Q?c0DzHtEso6Qxb7SVEuuGNc/oRh0B0TjGrJJn6vdyObcuacbbE8A4z4ytBukL?=
 =?us-ascii?Q?wsNqNSpkGSqNw956wmQ+LIS73p65rYxeXfgam+OvYLAteE1OC8O1rt8QC3E3?=
 =?us-ascii?Q?cF63wWfcgJ2wiIgbj8UpXn16n7Nsi11pCBxqDfoaw7xMLQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(52116005)(366007)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dy6kwP7WrnRUag0v587PL20VM2QqG8irlDJgH1pT5CTF5a7fNCvDWqSLDFWv?=
 =?us-ascii?Q?j1E1yyciAw7jgT3i1auqfqQw58njaL3GskglaFxLqjfgw4Jkqs+B1Pi4OhEl?=
 =?us-ascii?Q?6ieICQbsJf2TYmT1kXFAe539ToHvioS/7hqPWcx87qQl0B+kk4kxlSmBIvSU?=
 =?us-ascii?Q?J1VDpblxWoDrZ9fU85EplOwZwD7lYw3XesIp0bwOmty1ST14kL5Qcj+KxWWA?=
 =?us-ascii?Q?Rwgme1vYVI6hiUBjudEYyBJX/+sUyFQJr2zIoweAj5jRyHhqE+w8mphSkNj6?=
 =?us-ascii?Q?2w+NyjUns5R6gObV11TK9RvhyngcQp4u0L7UL7cLg4fSk46BFGF8Qd54upKA?=
 =?us-ascii?Q?vOKxAz/1NT3Hk6Yd8MHldpRZHuX0KjOjcZbR7MB5DN4dCeNW9H8y0gd1vaxG?=
 =?us-ascii?Q?gRvfbiEPKiW6PlP3LRCoIlYV17iwQUK32xLWRPMI1LWEOPAOSeNV1O/ETSZp?=
 =?us-ascii?Q?mAONg8DxC0u5+ifeHiS/MCYiuWsJueJsJxhG6IFgLJEzp9k6zOqbr3lPp3/2?=
 =?us-ascii?Q?kzDmu03I1B8yGhTofIQeB7RaoAFUNrRklaP2Ncze9zS3DQsKzqcAZoDlav4J?=
 =?us-ascii?Q?zD4h+FJ82KT0CCxjBuqzOOn5KqFZoHPG3NYGgFHkNTPd1zbmSebAfM04Ir2Z?=
 =?us-ascii?Q?oCThl99VDX9DNrgTjW6wCDXXfYf8bqkNjZP4GRpEgN/D0Znl9a70a0Q8Xpsx?=
 =?us-ascii?Q?g1wFzb4/Vzj5L+zBFM6LEObgrIELzLlYvsMUW51w6tk9kZ4D1/nDdH0YXYGN?=
 =?us-ascii?Q?r2epHH+ckFmZ0jwvE4z+DLv7WXxKSSHoyPw95g5N4jWqnE5HXGe4QPDIcZ3Z?=
 =?us-ascii?Q?1ip5gPT75r4w9FYmtrO9RHj6o9wm9c4l1ZZHNtJ74vOFcZTkjoR08Nd//cu6?=
 =?us-ascii?Q?+tVd8rPRhLQViB1R5hNqCdcXfaUKTTKIFnxD3T87Ql4fQF3+0bAkt0hT69Dn?=
 =?us-ascii?Q?mxUd+p8HtJZu5JoSkNFH4v8fbDEA5SHdlf3E0/UO85ph91g30gExsEKZxhbD?=
 =?us-ascii?Q?pHV4ne4Mcrn9NddFggbFrPlUjBLOgmLFdvnTku+YNRTIitmapKbZNmKiqX7T?=
 =?us-ascii?Q?8SArdSwcoF0BEx8JwGIqCFtF+cgPkcb3muLRqBYMhPDTuJgwzC6+B49QBMpy?=
 =?us-ascii?Q?7EBt3bN9vkOFQQ0XrA1VfgsHO/ld2JQU8Kj2s47zHB0b3B1LBurmntOPCdvF?=
 =?us-ascii?Q?uxK6HgQUjC3N9FT1mPt4HYwQjjYebBj8ikZGg3ZA5A6FCXGBWepGi+R8Op+r?=
 =?us-ascii?Q?Bi4nJalbY0nWxfrV98LWXu7lqnIqYhejEqGZAqPatkQKGPuRjyOd76HB1pFT?=
 =?us-ascii?Q?E0Hi8fe5fc5wbkaxwzdIxO/ExDJyJA7kAVCy3R+B+6osftawLb97IOBtovsU?=
 =?us-ascii?Q?f+jCB/d3PDUlFwgVY6yiORLqmDwU13wxC8UTawDNBnIv/FLISPUH+OpRUTtG?=
 =?us-ascii?Q?CR3GZk4zV0CmKf3fcSl8hQQTvEcnfv6yVKOnBxR72TxygPw9FBxGWOqYqcxg?=
 =?us-ascii?Q?ceHNlSt0MKsGBNO7wDbjSsh9NrL4H5IF0+4D6N3QQTHUMjH4K6a2Zbyb7EBd?=
 =?us-ascii?Q?iuR+AwJcJlgNrP2m69fgI0gr9eRImC9yg/zPSQGG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a9fec9b-d4e3-42a7-0d95-08dc6082792d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 15:07:47.7499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G2AtcNb7vMSY897hxDPygNCH/pcAgW2ncI+4wubts7pga+jK6ggifrbyqDWqwvsUdy1RkfKXw2if0vchaH9vsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10330

Add peripheral types ID 27 for I2C because sdma firmware (sdma-6q: v3.6,
sdma-7d: v4.6) support I2C DMA transfer.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v4 to v5
    - Update I2C to number 27
    - Add Krzysztof Kozlowski's ACK tag

 Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml b/Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml
index 37135fa024f9b..738b25b88b377 100644
--- a/Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml
+++ b/Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml
@@ -94,6 +94,7 @@ properties:
           - SAI: 24
           - Multi SAI: 25
           - HDMI Audio: 26
+          - I2C: 27
 
        The third cell: transfer priority ID
          enum:
-- 
2.34.1


