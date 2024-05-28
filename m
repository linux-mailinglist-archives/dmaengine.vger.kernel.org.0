Return-Path: <dmaengine+bounces-2199-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 841788D21BE
	for <lists+dmaengine@lfdr.de>; Tue, 28 May 2024 18:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36397287346
	for <lists+dmaengine@lfdr.de>; Tue, 28 May 2024 16:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34E3170826;
	Tue, 28 May 2024 16:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KR/BNAgw"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2063.outbound.protection.outlook.com [40.107.20.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7194116C86F;
	Tue, 28 May 2024 16:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716914273; cv=fail; b=godb5m21rQO2Ex4+eWaMWRTtUSck4h+x0rTrtgTvSA7lAgfgC4vB+6dcd/7opV0iSpuqAgpMEYsloi8mnAIb07h0890Vbp7G+qb2FxgC8bnzMOL4t9Dg26Gg9cxCJkDJeBo5cCiT8UgpEWPMm49jmklkA4grThwZrtTsUFVapSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716914273; c=relaxed/simple;
	bh=+d8de66yaT8xiheUwXMRKmPwCEhj+TaoAFr0loD9Gkk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=AdA3mBZJTSoJuFfiGcM51T29rVGuB0jfnW4Ue1I/LTDXNiRKSgzBK83DoezyuX4nRmv1XF9RsZYYYBzGlsH0xrAefecttW5JU0lyJCsL3F1g/e1or/0pLK+5q3GKeNL9U0a/juWhr3pA+ldKsIEoitLqaKqnaTntY7jhl5Tacas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=KR/BNAgw; arc=fail smtp.client-ip=40.107.20.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MDa6w2yGc1vjzKByiA5rjDGfO11IAikAGZcNObLzqAT/62tJ7Q2srow03GByyusPf1DcdjJQllmKKOlybpGFo5ftNuti8AtLX8na0KpDgeoFW8mCL4FpozYVaMKJ66AAOR3s1KV23qWyNGtipvSsgwDt0dQ9SSIQQUKj/13i/wyk3VIuTns/Xx3dmO9KqcPBoqwOsb0gKc4w3lJxxMeppbSI0x3v6TC/hWukY6TtT5SKsGgxAU4MqzR6YvhZAyRJXsV3oYdiFn5MH7CcCMeKDPbA/tlVjCN8xUAG9PTfTgGrj8yWKguEsKbQTtVHn9REulzaqdmnixPTHol7LiIJnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b3u9q8cHqVMZURDuomlOuVUsRvMYihu+yaWiEmc8Kwc=;
 b=mcXo3lC4LgV3zfbQF7SdNwncR/4KNWYy3Q35Pn/xZSJ7TDGEuURBJXeIvr8lolr028sWYl+igePv3//yK1MvAHbGd9mQreaY7pJRQg6ouTW4jzQX4g29y4WENxkhdK3N3F0qENA96TDlEuxEuENZEs7QIp4g9fLsPdQr515NwKpP09S++YsvrJCklYODMGuwuFYH4nsPp9R4q3a/VCtdQZgepSbmsfr0BGPAoBcyn/s34RjqKjDg7czp8UgZlENaQRwVA4BtSQT3deboZtCy6bOHpO5xVfv+9JM6R1dFBt3+6vKt/2h+IgjVUyKxpg46OAI/n/bV1kqNViz4wH3Ygw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3u9q8cHqVMZURDuomlOuVUsRvMYihu+yaWiEmc8Kwc=;
 b=KR/BNAgwDCW+J8DxTRKgSqRHM+QjuV2P5ETiwiC/7tgr9AxKQ/I6aZE1N2eF4Bci0NzCeidD3QbTic+CkYzDNJv89Ig5yxMcNFZziMXO1MInzB/xjMeIi66k/ochMqlr2Gy/Jo2Sz/c0hq1bqWJ1S86+alBAz0yJdmXQwHNdjpg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8416.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 16:37:48 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7611.016; Tue, 28 May 2024
 16:37:48 +0000
From: Frank Li <Frank.Li@nxp.com>
To: krzk@kernel.org
Cc: Frank.Li@nxp.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org,
	imx@lists.linux.dev,
	krzk+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	vkoul@kernel.org
Subject: [PATCH v2 1/1] dt-bindings: fsl-qdma: Convert to yaml format
Date: Tue, 28 May 2024 12:37:34 -0400
Message-Id: <20240528163734.2471268-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0213.namprd04.prod.outlook.com
 (2603:10b6:806:127::8) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8416:EE_
X-MS-Office365-Filtering-Correlation-Id: dc41cd65-837f-46fd-5cd1-08dc7f34829e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|52116005|366007|376005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Qke0GqrdMhP9E1eaAptvN3HJCVAQanwfLtJtw2IIzgrEIUwYrp7FWP+mElhJ?=
 =?us-ascii?Q?irEJ1VEp94tYNsmyrtbPe2Zp7xbnMVs8eyKBVcQWLtsbfHMGAYVHpA3KdD4D?=
 =?us-ascii?Q?EhgRrkWxjFWJtDQVlBLka3mMfb3TFvrYTgkELJnK4jq/EQwmb3ITGxirRomq?=
 =?us-ascii?Q?R48gV4Lrugf6FmnKRFKFNUfZi0qFGH4w68k2t6Rhf7otOBHeJZYdeq03LE9M?=
 =?us-ascii?Q?A+8f3U+cNVZINfEg81M6XcM23zQnHQFjv+rBm9TizqC+uoOMOdhHS6wNtIcw?=
 =?us-ascii?Q?ACBEMkXGo0jYMT8KC3vkxuIeGa4Uta47UQwv0xlsryRY9DfiCYiccFU1OIpb?=
 =?us-ascii?Q?5kHNyEU5aBZ+Nh3UiIakudtvEg/hBbLzq/Wdv3+zzoWkL/D8TlFJwnIWugRi?=
 =?us-ascii?Q?37Uw6Vs+cV4YGa2O+k9T0p2aytdobUATZ9fskSV0ABZQ6WGva+LC19kCUnn/?=
 =?us-ascii?Q?l8RABDMVjXvgV2hqOGeyrKWzMSa14yEUt6bcdxv2xyg04jEnKXBpPABh6uZN?=
 =?us-ascii?Q?EXWevzU6/bHu2YfTiQPWDSTsFcuiPwjJBeJxxPjKkAN6doX3neyfUvRdYeMq?=
 =?us-ascii?Q?bkX6zyaFnV33+RBKjuWu7+sUVvaoflVLD410xUcDejz/wx4jx7cCR8kRf7my?=
 =?us-ascii?Q?/pZcChENY44OP/XTp1LHMIbGpiEmZ0UDQPRXPVmOg6YoCl7IvVj1vpt1mPWv?=
 =?us-ascii?Q?L6nAuBDw8/l+iZO+Ob6GY6Slpobyo5Xums/p9toaUO8q9eqtR8oKZWOr4CMe?=
 =?us-ascii?Q?cKE+OJZLvC9x2uhcnAAe+UuWSGlbGio6SBse43v63jb7oCTqxYvA9VV0DIZz?=
 =?us-ascii?Q?4e+B8Jq0gcD208kI7mH3YqazhG10fEnEXpT9lY+1FDXY1kru3UtzXmUCgXEK?=
 =?us-ascii?Q?jRSltPskC5qo7zazXWFDFEuYjfC78W2LeCk26WIGjDXpQorgcLjcYI5eqnR0?=
 =?us-ascii?Q?u5poVKE41rqYtPokm7owa0RCOpJGb/nXfIEWXnNjSejBIDnSd4pMyQIJIc+1?=
 =?us-ascii?Q?KaVQobHlAJV4Myh4GKXIeEhxdl9YMSrAJI6wrhYFaKLxxAGEQjOH7VpxqiVg?=
 =?us-ascii?Q?CFvWNYciagvLGQNtEjzWAQOx/2WeqVODP9VyakM5EnF62r08CcEf2M08F9iK?=
 =?us-ascii?Q?Cix1g6984K/+pBssuMg/kuzavvGLpF2lSZlGbyiY69tAs1XcpjQI3mO9Pa6E?=
 =?us-ascii?Q?YiLQy+UZMiNckUKNkDOfKzaubhwleHRSn2Au2EFNLc/KsNItt6OCk2bT+/0t?=
 =?us-ascii?Q?FYNqh4EBZ+OW2dre3Q8Mg5X/IeUPz+BDbLgnYpkcgTNRpWiBfPjTeVjR0K0Q?=
 =?us-ascii?Q?Z+M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(366007)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7EiIHABd5d+P3XoSgMMXyW2awuB6A2AgmaH12hJclH8qA3aD9Vo8/N6g+7ty?=
 =?us-ascii?Q?tt/i3kObkCrPalBb40lbMnvTLDBWZEIgdjnTOK88uydEwRnQPT9LG8WrdfYK?=
 =?us-ascii?Q?yRdva0Piw7b3okZvxvR67voP23U+Me28nCWePbsfbluTwa1cgXkbjW4r6gtn?=
 =?us-ascii?Q?9jLgCf6keDJceKQHB3/0h1G4moqQyXvNnHyCr63GFvYJ8x+50Fa/qD/mfEIr?=
 =?us-ascii?Q?xjQ/xqVB1FjwqZwm10NfrOfd1aCl+dO4UHjBbJDToQ0nIzRgzqFm4y9fXcWa?=
 =?us-ascii?Q?o+06sDdUC0ws76Ocb1B7ivpjLF99Yy6GeOPY/HlRCJi/vGAkHCKXlpveKrIU?=
 =?us-ascii?Q?/NMxYF+I6CpH+tYFuaGXp4PZaDn/WDjJ+Dj/XsHPkBG8Yd3+E90JwidI+saR?=
 =?us-ascii?Q?7ducnvUdNWMsbFdz+u1SqOUP5xsXl0cIMP13v7Wd61ma6rLevjf1h0fd+ZDz?=
 =?us-ascii?Q?9pqOxsll0w0TU1/isoIg99oytP2N0+MFz7Z+LHUk1+yf8EOHLWO8UQFiCvJg?=
 =?us-ascii?Q?zWY3UJfNDB1LLhBzelWjVxKDN+k/4dDano+YcccCimc6INfchqKyswKbJl9A?=
 =?us-ascii?Q?1WC8MA+kgkfAkEaBm9vGLg0gSer7pOezxrE7+Kc33+NrOXi1nwTSTN4jT8Ln?=
 =?us-ascii?Q?AJujDZVVuqUo/pcL+DLTy0JxMaurwOuShtSGskKupVobFoYp57N4pdy5HpQP?=
 =?us-ascii?Q?71Efkz/xDzqTNw+7fN7gFSJyYjfqnT5QDgbfIpIqQ+ekpmy9d0+fB36aH8ZA?=
 =?us-ascii?Q?oVExQIzHktY5wlenQZQ7wXP6VqsDzhfUUYPfFTOCvpitEVd0H3sRgCDCfLQO?=
 =?us-ascii?Q?XvUC4X9gOeccwCD8LahTWKanZPCyFG4DiRWkFrSdSDJR7RxDQ1QG7e1CtQ7I?=
 =?us-ascii?Q?7qB2rMvsn+PbYRjJB8Cr51s+O++vJX66JgmcrjM/z42dQWT39pQy22f02HoE?=
 =?us-ascii?Q?9/+g44szGaXOBrQZbD7JwceGoiQBaBude7IEbIroNoRmIrIn37YsmaB00ASl?=
 =?us-ascii?Q?YDCvcnYjGOwyKeqxCnHEg14calGYN37b3G51dZzYhrDHhMj+FyF3XTAhLaPH?=
 =?us-ascii?Q?VBec6tYI2y1Y8zGeFq1ZstGOpEbKL0SyTKBEo5J5f6CFq644c/NMqYZGUZC3?=
 =?us-ascii?Q?04Y9VylhXsic5ihdfJXt13ZpgB2MvG10gv4sKnO5LvLYHQYaC/NEgK3lk+Yc?=
 =?us-ascii?Q?X/oTunmmXiKYMg4T4MQq2YjQjP80OkHTNighQ8KTWcV56EuCQqK+TGXaILG3?=
 =?us-ascii?Q?jc6rZS5kWYdr0wmaDNWkyTaRe48xL71JicuLjIIezytF2mw7XD/AG3OWlhZI?=
 =?us-ascii?Q?RV9kqfNm+k8HbNBbjm76/i0ABhPXjoD1Y6/BKVK5tjhmNP+f5ZMd1G9Uz6iW?=
 =?us-ascii?Q?1z/IyuX2MWfxrGfTfOPo/WD114i2pEtbdKh3ECcmOmAOgY8ozYmY7aEyRMP3?=
 =?us-ascii?Q?NL2XL93FQNMYpS65+KJB/Nf66/6VmkkKVSt2Cv9NiCjGLGsXE58gPkbmBMRF?=
 =?us-ascii?Q?jCj6rLm0s9h2asYUJaqDhn+nFNKxCrlo3q/B+moUs9sZmnC/0OWXESH2ryyC?=
 =?us-ascii?Q?RhL7Bzskp9yssd1u4tmob850esh77lwvWRnSXm5M?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc41cd65-837f-46fd-5cd1-08dc7f34829e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 16:37:48.7262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pdi33JhmOcd3f3mGSlAupx2eafAGMm9MN+jw63nRKjri8oiaVrQPMUBzP1UbJYZaf9KK5X9KKqnfVRaS/cWTXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8416

Convert binding doc from txt to yaml.

Re-order interrupt-names to align example.
Add #dma-cell in example.
Change 'reg' in example to 32bit address.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v1 to v2:
    - dma-channels's minimum and maximum
    - add Constraints for fsl,dma-queues
    - move unevaluatedProperties after allof
    - add interrupts contraints for ls1021.
    
    Pass dt_binding_check:
    
    make dt_binding_check DT_SCHEMA_FILES=fsl-qdma.yaml
      SCHEMA  Documentation/devicetree/bindings/processed-schema.json
      CHKDT   Documentation/devicetree/bindings
      LINT    Documentation/devicetree/bindings
      DTEX    Documentation/devicetree/bindings/dma/fsl-qdma.example.dts
      DTC_CHK Documentation/devicetree/bindings/dma/fsl-qdma.example.dtb

 .../devicetree/bindings/dma/fsl-qdma.txt      |  58 --------
 .../devicetree/bindings/dma/fsl-qdma.yaml     | 124 ++++++++++++++++++
 2 files changed, 124 insertions(+), 58 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/dma/fsl-qdma.txt
 create mode 100644 Documentation/devicetree/bindings/dma/fsl-qdma.yaml

diff --git a/Documentation/devicetree/bindings/dma/fsl-qdma.txt b/Documentation/devicetree/bindings/dma/fsl-qdma.txt
deleted file mode 100644
index da371c4d406ce..0000000000000
--- a/Documentation/devicetree/bindings/dma/fsl-qdma.txt
+++ /dev/null
@@ -1,58 +0,0 @@
-NXP Layerscape SoC qDMA Controller
-==================================
-
-This device follows the generic DMA bindings defined in dma/dma.txt.
-
-Required properties:
-
-- compatible:		Must be one of
-			 "fsl,ls1021a-qdma": for LS1021A Board
-			 "fsl,ls1028a-qdma": for LS1028A Board
-			 "fsl,ls1043a-qdma": for ls1043A Board
-			 "fsl,ls1046a-qdma": for ls1046A Board
-- reg:			Should contain the register's base address and length.
-- interrupts:		Should contain a reference to the interrupt used by this
-			device.
-- interrupt-names:	Should contain interrupt names:
-			 "qdma-queue0": the block0 interrupt
-			 "qdma-queue1": the block1 interrupt
-			 "qdma-queue2": the block2 interrupt
-			 "qdma-queue3": the block3 interrupt
-			 "qdma-error":  the error interrupt
-- fsl,dma-queues:	Should contain number of queues supported.
-- dma-channels:	Number of DMA channels supported
-- block-number:	the virtual block number
-- block-offset:	the offset of different virtual block
-- status-sizes:	status queue size of per virtual block
-- queue-sizes:		command queue size of per virtual block, the size number
-			based on queues
-
-Optional properties:
-
-- dma-channels:		Number of DMA channels supported by the controller.
-- big-endian:		If present registers and hardware scatter/gather descriptors
-			of the qDMA are implemented in big endian mode, otherwise in little
-			mode.
-
-Examples:
-
-	qdma: dma-controller@8390000 {
-			compatible = "fsl,ls1021a-qdma";
-			reg = <0x0 0x8388000 0x0 0x1000>, /* Controller regs */
-			      <0x0 0x8389000 0x0 0x1000>, /* Status regs */
-			      <0x0 0x838a000 0x0 0x2000>; /* Block regs */
-			interrupts = <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "qdma-error",
-				"qdma-queue0", "qdma-queue1";
-			dma-channels = <8>;
-			block-number = <2>;
-			block-offset = <0x1000>;
-			fsl,dma-queues = <2>;
-			status-sizes = <64>;
-			queue-sizes = <64 64>;
-			big-endian;
-		};
-
-DMA clients must use the format described in dma/dma.txt file.
diff --git a/Documentation/devicetree/bindings/dma/fsl-qdma.yaml b/Documentation/devicetree/bindings/dma/fsl-qdma.yaml
new file mode 100644
index 0000000000000..1b689a2529c87
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/fsl-qdma.yaml
@@ -0,0 +1,124 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/fsl-qdma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP Layerscape SoC qDMA Controller
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+
+properties:
+  compatible:
+    enum:
+      - fsl,ls1021a-qdma
+      - fsl,ls1028a-qdma
+      - fsl,ls1043a-qdma
+      - fsl,ls1046a-qdma
+
+  reg:
+    items:
+      - description: Controller regs
+      - description: Status regs
+      - description: Block regs
+
+  interrupts:
+    minItems: 2
+    maxItems: 5
+
+  interrupt-names:
+    minItems: 2
+    items:
+      - const: qdma-error
+      - const: qdma-queue0
+      - const: qdma-queue1
+      - const: qdma-queue2
+      - const: qdma-queue3
+
+  dma-channels:
+    minimum: 1
+    maximum: 64
+
+  fsl,dma-queues:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Should contain number of queues supported.
+    minimum: 1
+    maximum: 4
+
+  block-number:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: the virtual block number
+
+  block-offset:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: the offset of different virtual block
+
+  status-sizes:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: status queue size of per virtual block
+
+  queue-sizes:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description:
+      command queue size of per virtual block, the size number
+      based on queues
+
+  big-endian:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      If present registers and hardware scatter/gather descriptors
+      of the qDMA are implemented in big endian mode, otherwise in little
+      mode.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+  - fsl,dma-queues
+  - block-number
+  - block-offset
+  - status-sizes
+  - queue-sizes
+
+allOf:
+  - $ref: dma-controller.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,ls1021a-qdma
+    then:
+      properties:
+        interrupts:
+          maxItems: 3
+        interrupt-names:
+          maxItems: 3
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    dma-controller@8390000 {
+        compatible = "fsl,ls1021a-qdma";
+        reg = <0x8388000 0x1000>, /* Controller regs */
+              <0x8389000 0x1000>, /* Status regs */
+              <0x838a000 0x2000>; /* Block regs */
+        interrupts = <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "qdma-error", "qdma-queue0", "qdma-queue1";
+        #dma-cells = <1>;
+        dma-channels = <8>;
+        block-number = <2>;
+        block-offset = <0x1000>;
+        status-sizes = <64>;
+        queue-sizes = <64 64>;
+        big-endian;
+        fsl,dma-queues = <2>;
+    };
+
-- 
2.34.1


