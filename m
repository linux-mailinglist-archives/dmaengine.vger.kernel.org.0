Return-Path: <dmaengine+bounces-2110-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B7A8CA364
	for <lists+dmaengine@lfdr.de>; Mon, 20 May 2024 22:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 417C22813E7
	for <lists+dmaengine@lfdr.de>; Mon, 20 May 2024 20:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B852413957B;
	Mon, 20 May 2024 20:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="m+7GbhzC"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2059.outbound.protection.outlook.com [40.107.7.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5EDD27A;
	Mon, 20 May 2024 20:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716237569; cv=fail; b=MWlOemLtRg5qjmsyJk5wiWid4u82ddcl0YwflhcZVjtaJHCSEJqXctEEdizRGGab2wV6VeL9lbaXlCSAb17vqQWbXTRh8zFL1TvbzNnfiIsZiKB3m3DQfcz5iGh6FO5Vldo0N/dPLZn1krdMTfo4iwR9f2Ttmqy7+TNGc8hImtw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716237569; c=relaxed/simple;
	bh=FUBEZ3rmlB7WIMdzf+PYyLoc2mRka6Wf0NEQhKaq25I=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ICY+froXNcc7trxdlV1i4nXcWK3y5lYs9/9Eo5atVUbv4V2/w4Gm9Kv1z6OyiTuyBrUxP7LZHFsqaTMs7rZVCs+fbEbsv3z7IakxvEvnlBGl+4OCC2kQM40V3hpc1Dm50thB6KxDQ473QI8G2vCdO0QjReD3ElbUNXFhZlABiPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=m+7GbhzC; arc=fail smtp.client-ip=40.107.7.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h/DoxJSO54WiiyfNOsHILF9pJOHpEGWW/r8IWOjAvhDecSypQVThJiS70FKUCBLiXmmVjLEWtOSnjqUQ8TLogfApkQTwgRoOBni3epQytewmauNGWHYhon4K/IUW8edbEUo1qE0P/wRmTLf4N7i1o53hMqjnJ+8OwKEcgqu/5hgFOp0URiPYeMG2XRT02V0cinnTH6OwcY92DSVf7JRBohfZhV/hFD72v9bruYTv81UfbPaBvvdwj3TKP/9NZgp7sRp/jjrCbfN+fqC2V6TAvt/qyfMpaDEIo/Zv8VYA93EU4BtJ4U44bqJRLznGTCw3RsKp+cdmNuV+R94pwbVJ1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UxEWyYzzWUkM3mq7Y36bvJfTBVhfDta0H4YqmBqUhw8=;
 b=EgmDeIbMNyWTs/E+95ZC1WGHf4QJ5Bu3MaNc0TdWIEYcsSLWgTHZy2Gdyvtrm7rU/Ls/zz9bcsL7RtudsAroHj2YboxdaRmjP/uOgWp6K43DuXhc1f0R4wR6fS6jyr48yHGwWhry4Yfc0uZrOfuqdvfP1BO/jz8SYolHmQG0mWpcEXZv6jcaEPpMY50PPd+F4dGrSSWmbgYXbc7Iv4mRaK6KAJlkFZjoI4qxaWrtxTJS68XaWnfqC6hlsSqGtahp+zJK7iEARI7GwZvD9FKXRzTdrrvsigP001MCA3q6xL+zAGGmgk4Ku0S0ybdXMIBF5mEW2ZT/E/qdJu4C73LHXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UxEWyYzzWUkM3mq7Y36bvJfTBVhfDta0H4YqmBqUhw8=;
 b=m+7GbhzCgAdibnBxBCKeN3oSGGW8TgJ7Y3SaFT/ZXNt1Ic+desnqlSPiItVt1CyIicB4ON5NYFLw1V0DxyEYNEJ8JtZB7lxYSuQWOYoWdDnP/TnLFd/Q4aLbIsIxBtFQLJMmY26K8Vano7rhtLnxLZRPV8VwF1y0+w2g32Fp6rU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7385.eurprd04.prod.outlook.com (2603:10a6:102:89::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Mon, 20 May
 2024 20:39:24 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7587.035; Mon, 20 May 2024
 20:39:24 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	dmaengine@vger.kernel.org (open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] dt-bindings: fsl-qdma: Convert to yaml format
Date: Mon, 20 May 2024 16:39:06 -0400
Message-Id: <20240520203907.749347-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::11) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PR3PR04MB7385:EE_
X-MS-Office365-Filtering-Correlation-Id: 8578412c-526f-4175-d628-08dc790cef27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|52116005|376005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YKStVSB4iTQ1In+0xyDbENiVv1NhdVH/A8LGLzkeg73sNjr14D0FyPcYRrP1?=
 =?us-ascii?Q?qTxe6E/bHTw34HZJi44JijJdzy5oKrmFP9MTEbWCWfXRvmGj5Kv4XD5aQ6a5?=
 =?us-ascii?Q?Nd9XZiwAbwIeBTnG79EuWg0yl3C3qNAjo2xTt7ArQXGKVdUC+0JD05Plh5Uf?=
 =?us-ascii?Q?0AOwD1YBI8dEraUMnRbFssq9rVgd/zAnmpEuhHtt20MGXZfT3e5wQdJq9izj?=
 =?us-ascii?Q?6pgiocvwSLo3aH2ppMHZPXpE8xV/Dn6eNWqQzrTXiPxPh3OgPC1l/xlBVJgi?=
 =?us-ascii?Q?2i2XAWezl5S6XPgUVO6hKjVnRl1dWmzJsASm2LBJe/4LQS8seoLYdzE5/FIs?=
 =?us-ascii?Q?hwd0Bzfo8ZKgxpDPfOQGH4vFfaWlohyA2sKaOjpGEEJcGPcHBCjwmx4ncDEG?=
 =?us-ascii?Q?jReVXgwlTCP5Jyv4YDi5oiHeQe6Z2gEYjf2ILR5wS7UBjCLFqqoiE3BJFAOe?=
 =?us-ascii?Q?yeLfdYKtdy75zpt55R04vvLBFw0IPklcjk7hlS4BedumyOqmRXsT8lnkkH3M?=
 =?us-ascii?Q?T9+ObxZzJ/o+380sXKazO0Qet0excUNFPJlggkLeQOWMcWu38JEfDe27rtvE?=
 =?us-ascii?Q?gCdBxprZSgq/fVyIMgNcwO2ResAKtKwaU9fmrioKiNCK9T68kjX5UA6osii3?=
 =?us-ascii?Q?vaS8Z8sBn0zncv1zFnO92DYGydrfAJKTG7fiTkOmVAX2f2S3WS72R1C+nWV1?=
 =?us-ascii?Q?OdNXwTfayaGtUT4AUt2EVSmhtC4dCO4pYcM5qk7gimIx00wDi3N7f94xDOs9?=
 =?us-ascii?Q?Se6iJ6hluxprjxmRd10QS07eViuyVyNZo3ZA5T6v5jl9FmoGGANd9T988dRa?=
 =?us-ascii?Q?YZE4HdRd27Jqtk+fuZMgwremM136sTjNws0hFdMP6Q7Zp6gJz2VEx3d9KU69?=
 =?us-ascii?Q?wUzmoYgJDr7LPctsno4BstZhWSDe+nohryfQ/Qm2XA6G+sRk4ISZ//bY9X+A?=
 =?us-ascii?Q?Z1Vv44+xow4AWgCqk2FqyHfedWUDuufwQa9nuF2F2CnjaPZSy94FxGkgh3BP?=
 =?us-ascii?Q?bsqBxGOr8xfWKCnnA/RyuOpid9FtKlW0/KQ5PpKf3pvicATYfOji3SkHwcdB?=
 =?us-ascii?Q?1Br9SpF7OT5I8vsMs/UyWnSmGdxJAjdW/ptatFwn02DAZvdEta7z5XeBS4O7?=
 =?us-ascii?Q?9xSqYtbfGIxK+waMd81pb5yNJjmWR12W5Xt3hxoGccC2+O6y8QUDL6pvbTBh?=
 =?us-ascii?Q?ovY1rtzGJ60TEj2sZfUesiALaYtevJmXj5sfYkmN27M/eR1eDdsh2mfO6uj0?=
 =?us-ascii?Q?12BPxJYS/mu1ZNwahrCqh2QPC01IwVAiDWaRBTgw9A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ab5s7F1rwXOQ+L/BdTO6c9zuoB6aFgTw5+78ZVr2S6hXIimvsAmlIpk3mbQe?=
 =?us-ascii?Q?oFqgGUBPjjErumKuruwK/W7swG5e6Ttx3m82HvkphYXiEHcG67++dQ2ZtWrM?=
 =?us-ascii?Q?eutz7RSvUpzgwK0ks9L3vsWhzUfOMkGvDLZPSG769G70mnpkr6X612P9wtSQ?=
 =?us-ascii?Q?genmyzY1aHf2PGf/lRF/j7LP4qurhCA5Gsi2M0E1AtyVn2T2k2rGrri2P9fR?=
 =?us-ascii?Q?U8RSk3EvUgxH8ECNjWqv6W16DX/i08wZ2Yd1w3Tx8yofVJVD1wSEeJ+jkSMH?=
 =?us-ascii?Q?KPwGfhl5SKT72DiNEB14zJf/CtNatL060KJkmDh1hEgxGvpwcOw8vcwunNIG?=
 =?us-ascii?Q?ERPYiDvAjaHB6LvPZrapFPVm9BBxg2n8WkK62bWsGePtdEStAxsatsondPCd?=
 =?us-ascii?Q?mcnV3kTBMHasnbdRRXDpRJhnjR6iO3USiYEMjFRT35hHlox+T604NUkg6yLh?=
 =?us-ascii?Q?hFEeFMSsHiqZjeAdNm1sW5wwr7x9T/xNaEhwgv4lHGxMBTIQ3Xckn0PSCGhy?=
 =?us-ascii?Q?RUon+M++3YCJNIrK2eIfmB6YV8p6igJRrJ99Lzy1tEEc2NfKnCO0jHTzlduI?=
 =?us-ascii?Q?GZ6E112hvbcdsV15m2B+St7VwMbXcOty2WMj4Oqn7Sr8UnrV7LO8Im3nYQkJ?=
 =?us-ascii?Q?J9qMvrbePn7tAL6ezvX0f68vMuiK6ZkR8cWHszfFqJckUyPjyJCj7OtqBmm8?=
 =?us-ascii?Q?R8nK0RnBBiYqFeoohg0Nu2aHuATd5UA+Jp4u1TrfwgD0uHJ7DL+N8yX5RJcy?=
 =?us-ascii?Q?Dzu88PpFZEbPrxkCLMEJeQoE3n8jnMWHiNNZuulDoJNNEBoJ6aNjFdW1Iztv?=
 =?us-ascii?Q?qqNc+jD4ufa/W3UAGIgRYWQMT3fv4WYye4jyp3NHxC6G2JVRh3NnoQMXu774?=
 =?us-ascii?Q?dH8eP10vf6hjK+pO0xG9CQn+k5fHlBqK0x5yQxqMkVrKegdRy4/3a2Uz/50d?=
 =?us-ascii?Q?+hQuQDf05rL8gmBy1u/xsxXNisP/G+Y32e4SSwr3WkjpRCMLx82X2Ntu7kSp?=
 =?us-ascii?Q?z3PqpmJLzdqLgq3THbWT8AVbXFc3TI6ds2cs+8E25vGw1xZHehxlz1v/YArU?=
 =?us-ascii?Q?Fa8Hbs6b+x3ejefBqOnM6x29+Hcwphq0mv0V+1ATgkhzAkzMaXFxNQRInM+w?=
 =?us-ascii?Q?z6TKnpuWdOO8Nujnd10JBV92dJTe1dXaT1EEMyPc5SP2jrEPWFT8F3tJKhMv?=
 =?us-ascii?Q?gkehtIhQUpUspl6bHVd0sbqbcNMSNlr52dInWVWHntUn2mf024EL14d91Aaq?=
 =?us-ascii?Q?zKm5AAQ88t8AGGTYxSrrMIWUUpiuQd4IR81XXFfmejLGvCb70KaPVr4Vzz5k?=
 =?us-ascii?Q?y0rOJLQ2oG0IgNLVUsPn0WRV83PxcIhUEAHA/mQX82scbV7uGSvUvKGA1Sir?=
 =?us-ascii?Q?VqddCXDN9CCi0TV9Z86s6TxelZnLwEUtGS2bDNAgGKL02Pj7vKnrrivmUzMI?=
 =?us-ascii?Q?a7AdZDZG2hnP6iQMOvQyO8Cfkz9Ti5gFsy8h8e0mgwdBB6Y3wYqW8XtSBVWe?=
 =?us-ascii?Q?hVTSnWPSjit2KCOTsUMaQxa2suF5gIa7chgrrzSa1oMTPDk6EYwIlvQf12sU?=
 =?us-ascii?Q?oXuXsXEEuRyIs9+nyLNghO6ssW8nlAsRPZatLNrq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8578412c-526f-4175-d628-08dc790cef27
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2024 20:39:24.0103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NCmLPXsa21WLwt6FG7/6NotT1CuJltOw95p4leHbC9yeRqu0TGNe1OCXguUtN6p/aEXzPbjornJ4kxjzMMhkWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7385

Convert binding doc from txt to yaml.

Re-order interrupt-names to align example.
Add #dma-cell in example.
Change 'reg' in example to 32bit address.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Pass dt_binding_check:
    
    make dt_binding_check DT_SCHEMA_FILES=fsl-qdma.yaml
      SCHEMA  Documentation/devicetree/bindings/processed-schema.json
      CHKDT   Documentation/devicetree/bindings
      LINT    Documentation/devicetree/bindings
      DTEX    Documentation/devicetree/bindings/dma/fsl-qdma.example.dts
      DTC_CHK Documentation/devicetree/bindings/dma/fsl-qdma.example.dtb

 .../devicetree/bindings/dma/fsl-qdma.txt      |  58 ---------
 .../devicetree/bindings/dma/fsl-qdma.yaml     | 110 ++++++++++++++++++
 2 files changed, 110 insertions(+), 58 deletions(-)
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
index 0000000000000..e6d24670ff893
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/fsl-qdma.yaml
@@ -0,0 +1,110 @@
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
+    minItems: 1
+    maxItems: 64
+
+  fsl,dma-queues:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Should contain number of queues supported.
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
+unevaluatedProperties: false
+
+allOf:
+  - $ref: dma-controller.yaml#
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


