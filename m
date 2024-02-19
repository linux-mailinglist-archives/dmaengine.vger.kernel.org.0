Return-Path: <dmaengine+bounces-1038-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF24D85A804
	for <lists+dmaengine@lfdr.de>; Mon, 19 Feb 2024 17:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 773092812E5
	for <lists+dmaengine@lfdr.de>; Mon, 19 Feb 2024 15:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C763A29A;
	Mon, 19 Feb 2024 15:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JyukACi/"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2074.outbound.protection.outlook.com [40.107.241.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8915838DF2;
	Mon, 19 Feb 2024 15:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708358395; cv=fail; b=mKA/Inz80tClZi1suDCC/q+4m0eaGL7paaNQIPxLYExOLEo9aOmWe5g6ipGJSVcHMBdq7K2DYfhP2x9BgCuyrSXfYM93kxVzv9TeCTNV3fM/oeGSdWrC3+oB3B6THPJg3aId2h7JzJ5iq0u9fTlFG/RnEkgoQ/BIeJS2JRlhBK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708358395; c=relaxed/simple;
	bh=PbebcNxPPqgmQwzviQuB7uu2/erkbS8O0hptgyXd1J8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=IcRT+C6Nf1xi6mxg92LqOpBCYJE0ibFFEcDM4V0i8qQCtxsPMM8kPFe1lj4IOk83ezWQ57NIgr6FWa6WsqR13UKzIpryyQmx0al5ct1he5aixzmojfsSev1cowwdNXpovTLy2sM8wvaABw+Ru5WYzJaUKxyDczKdBIK9t3o5km0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=JyukACi/; arc=fail smtp.client-ip=40.107.241.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oNaOtdOovodA9mO0IhHA9A6rGJELW9kzx5Li1p2XltDdTyTzcCWVZzssXHH5qH/hdF7+unDcCJ6JbtSSlBlsdAzRP/ybVDolB6oaQllNRB7LpY6JnXDAK1ViaBz+Zn+cgEU99aMD+bwguhtDmMeIUnbj2WEe1MHcnqp/dUNaxrWLWd72pw0vHfVCUK71YCIDq0YTc9hIs1tn6vTa/TfsXVbcmbofGkMvLcxzln7/HGh0+RF8KaWR1Lr4ZMzMz7nqxItbENVYr7Sfc6tjYVXSHYJt0+UeOHhTKAs3BM51xLSGjFekpTlcofyPUI29895TheyT7X6ULvDZQucF/LHlHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0a/URzydOecL9yZy0YkXo2W/IfmwvDzcgc8qqKA0Tss=;
 b=YiuMZhcxws+ghsTXAmQuTtNVifTQDuHZGKWE7jwSfPmCYFAfNaVd2JwQ3AN1o18+2jZ+uRu1CVoCz2Py94ud2oGwL/t4LpjQu2bgMq8VuW7SUmqqW+pc1A9Ba1gF6mjWfgOxZonrnMbKZdVR7o+52nEeXCMc61zb7kSnP38bmJtyRukh+QUWEU+dMc04FUpxdIUD7XI0mynjjhfY10iJ4wrpVycYMdbiH7v/pzmscjUv5d5l0n67SyY6xYyAwT4Eqs02UblTMvdsOwE/SA2ptR3shYficvPF5UinbRGYf8wD/I9RFhfzc1U3w4aBm+XyVvk9iaHn5HUkTekY4PVcQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0a/URzydOecL9yZy0YkXo2W/IfmwvDzcgc8qqKA0Tss=;
 b=JyukACi/74BxsAyvcbAA2hond08Bj/RlcubcXqfAXDBNS1ZuLAcrUzueXDj6rnG660AwQ+oLOJ1r9VsGlYycnnvvKf2T8u4Lqhy+3rVDagkQFymf2OANt9qXl9CNbfHOuL2dsEi0vhhzZT/aaJoODGMTy0VBGIhTtJTDNI4brLQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8627.eurprd04.prod.outlook.com (2603:10a6:20b:42a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.27; Mon, 19 Feb
 2024 15:59:50 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 15:59:50 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org (open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH v2 1/1] dmaengine: fsl-qdma: add __iomem and struct in union to fix sparse warning
Date: Mon, 19 Feb 2024 10:59:39 -0500
Message-Id: <20240219155939.611237-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR01CA0051.prod.exchangelabs.com (2603:10b6:a03:94::28)
 To PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8627:EE_
X-MS-Office365-Filtering-Correlation-Id: 55080c36-cc7a-4038-c3fc-08dc3163cdd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+8LuqDWaaHys4k1Ljq7OPAWe2XtgASEhQq9MDX239sSdxaAbPFT3CQtlK0fSGKCb5zaOahUUXih7FMU0/VdHfo6qifU1NIyge/m/uKrUgSnlKBE9Ovc39Zjx+jFatWSoBSqX4W+vGgt7xPjsmeing5ZppDpBusdDOuPQnxrZTUcjvnhsJOy/3qoxruVwBbZH6S4GyuRZXQK4zgD8CKLeXIcCxtjprqUKSjBWMQHDG/Ug8y+Ue1/R8flB8NIa0iZj9huuRh44Mrfg3XcgVoTfab1w0ArW7YZkEBHIzwy6LVqSceVG0HbVnz/koB/4eNjLPxg+gt2BztSGt+0lUknox5EXIxdOaEzdlf/CHHmJE8pklMqTdbloHQu0+SjW99jbkBpekCGmrM7qt2fm1MXGy65naArVNWKv7zemeOeBHUtc2unjS7527wYvAdCs/B1f1JUqLtVXXzpVSC2uQ7la051178paKdAjUcXNhvXu94SIURjH/9H4uM8HvZPROcz4A+p3vNcooaxYIPbv0HOJymSQjswIvDquPSu00fn1JgbVSYyPSxOR/x2PW4mwqjhA/B9LDO6SPRz80KWbFPAvbuAIt1XEaw3YThqxbUV6HLk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RzBUOVBtTlI4RlliUkU4cDREa2trcE1YTkNSMmhWK3oybXNoWEZzaExSMFcr?=
 =?utf-8?B?QjlvcWJBMWN6b3hYbkNZYU1tbVAzUlBXckVYT3cyNVNqUzU1VmQrKzU0MzNN?=
 =?utf-8?B?QlBGYk5PWTFyRUtMWnJuWVFhc0I0ZDhQUXVQcFR0NWRXK25TOHVaMEdNcFdm?=
 =?utf-8?B?dGhxYkZxOE9hcEZIUFgvZ3U4QmdmQmdGVHhXZU1rdGpzY21mUjcxNndlL2d2?=
 =?utf-8?B?RUY3c0NkNVF5VStOYkxFazh3emhacTdEN3pod3FpdFN4M2ZRUWVzc2crQ2tv?=
 =?utf-8?B?NklaejlITFBPOTJtd0dkOGZGdFZITHBsL0E5VXpaVjJkV1FXdkFGaFQxVjdt?=
 =?utf-8?B?d082U090aFRTakx0UFA0aWUxMnR3MVIwUVJOMXpCU2w0dWNIZWZPdEFPdC9U?=
 =?utf-8?B?S1lVc3E4aENQeUIyVjg2YXBMM0JSekRUdHh6bDNIbUxiY3Q5a295WnZrSitY?=
 =?utf-8?B?QVRWQjgzQkNjT2d0S2ladEZhOUxTaDJicEg4ZGcxMkYyTWt0ZTVEQ2V0TWQ2?=
 =?utf-8?B?dkdyS0lvYTlmZWVDRWxLUGJZS1FiaExMaFRaeHBIWmxHQTYxOHBhK20rak1s?=
 =?utf-8?B?QWFTWktSL0ZlaFFpbFJkVjdzbUpLWDlsWGJnaTZodXZudTNFanFsS0NYRkRO?=
 =?utf-8?B?ZkdyWm1HcjV5S3hxUHUxMllhcjNsS2FmWXBOVEZaVU1vOFhDY29KOFI0RXJ0?=
 =?utf-8?B?c0RURkFVVWMxNVVTSkxINEFpcFJKN2QyNlBMOGhqVGM4M2hDb2krWTdzdW1V?=
 =?utf-8?B?VVkyQzJ5SjBpd01QZmlhdnlNNU45ZlM4WlZiNk1kcmhQOGplZFVKeFcvVnBp?=
 =?utf-8?B?bTVlcUdpSnJ0emhaVkcxNDdzeDVnbUNxSG81UjM5WCtYei9TL2xGZ3RjamFS?=
 =?utf-8?B?R0VIRURDZ0l3S2dXZVJmVk91R3VzSk5YaFZrbk1lbFVjYlJob2tpT0gzSjFv?=
 =?utf-8?B?M2RnVXdSNHZIdEdJc25tVE01Y0ZlTTBWTE8rbzBwUk9QbWFDNmdzUklKSCta?=
 =?utf-8?B?bnMydGllZ0pVdTBMZFBzWHpXc2l3UmkvZE0vd00wd3pMKzJNY255bXp3Zklo?=
 =?utf-8?B?MVp3SHRubnNQSnJTcHpWM1hHSkg1bEpRRW04K21FR01ERnpUOENiNTB2SGpi?=
 =?utf-8?B?Z1ZTS1M5YjIzVklVdXlzaFpvcjNBbmJNd0hKamxnY2hlc3YvL0JHY3Y4S1lD?=
 =?utf-8?B?aXhGZEVKQTZRQUVuUTN0MGR4cExpdXYwWk9HdnZPZUF5THk5a1VKeHI4Snov?=
 =?utf-8?B?eGJUejgyU240MnFEUm9TTCtpWUJoc1MwbzV5SGlseENabnNTdUIrQ3FjSkZp?=
 =?utf-8?B?YWExdFlBamszWWJhWXZWeDhhditHM1B3OXJ2L0wyREs5M0pLcVZhdFh1NXda?=
 =?utf-8?B?NHdhNjdnRTRsUVEzNkd3ZEdOOGlQdFMyOHBoNzA3WHNCM2YyM2ZOVFdqYll4?=
 =?utf-8?B?VlFUb0w0c2MvQjZGOCs5Y01DYkkrUDBpaUQwTVpyZEZFVHRaeVF2QmpkdWNU?=
 =?utf-8?B?ckJLNk4wUGZoN1lGL04zM0g0TDYyRFNsS2pOY2x1UEpOQ2xsZ0oxd052RlZO?=
 =?utf-8?B?OEtqakcwSWhHSGwyd1lsQUtKRFYrT2t6VFkrb01GVFVqalZNNnJ5U0tJdjNG?=
 =?utf-8?B?OU5Wb0xaV3JkMFp6NUQ2a1BrbVczMFdmeERRMHBrNGVwN282dlhpMnJNYVBn?=
 =?utf-8?B?eWtwZFVmcUhIRDhaS1J3QmFVS2JIamoyeTJLaGVvL21FK3VGQk94enRMbTFu?=
 =?utf-8?B?K3J1R2VlL0ZuQ2R2em9iazdsTTdBSHh6a2RvdHE4dm9Td2Mra2RqOTQ1TU1J?=
 =?utf-8?B?bFlJT3RDYzlmNlh3dnJkZUtQcmlNRzNPSTdLRVpvOUtSK2tPT0ptWFA5eXZZ?=
 =?utf-8?B?aEdKVXRPN0JVVWIyOVZiYjNqNHhxalJUYTE1NnlqYURSdmxJS0NvcU14anFX?=
 =?utf-8?B?ZTVWalBMdjlGNXhDMHlYbHhkVGV4M1hUNnV5YWVVS3dvWGx4bXlhWDF4WW1L?=
 =?utf-8?B?OXg4N05ETlJ1TVdjbkNuRTJYTHVpQmtsZktZajZLdlIxc0pNYTNhdG1VYUdW?=
 =?utf-8?B?d3hsSTB6REZCRmNLVVRpMXYzVUhkZjJpY3pVVTRLNWthMmZianNScjBibWtn?=
 =?utf-8?Q?0+sJFFvizIvFw564+4BJD9P4K?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55080c36-cc7a-4038-c3fc-08dc3163cdd2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 15:59:50.5545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v196wIL0kct3kdHDxeRsSgysEsEwXVw3I/HajQN2fKOPPbyzHengqvckbJVGQ5kQA7i0LeTvxAlbQKttFw4fIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8627

Fix below sparse warnings.

drivers/dma/fsl-qdma.c:645:50: sparse: warning: incorrect type in argument 2 (different address spaces)
drivers/dma/fsl-qdma.c:645:50: sparse:    expected void [noderef] __iomem *addr
drivers/dma/fsl-qdma.c:645:50: sparse:    got void

drivers/dma/fsl-qdma.c:387:15: sparse: sparse: restricted __le32 degrades to integer
drivers/dma/fsl-qdma.c:390:19: sparse:     expected restricted __le64 [usertype] data
drivers/dma/fsl-qdma.c:392:13: sparse:     expected unsigned int [assigned] [usertype] cmd

QDMA decriptor have below 3 kind formats. (little endian)

Compound Command Descriptor Format
  ┌──────┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┐
  │Offset│3│3│2│2│2│2│2│2│2│2│2│2│1│1│1│1│1│1│1│1│1│1│ │ │ │ │ │ │ │ │ │ │
  │      │1│0│9│8│7│6│5│4│3│2│1│0│9│8│7│6│5│4│3│2│1│0│9│8│7│6│5│4│3│2│1│0│
  ├──────┼─┴─┼─┴─┴─┼─┴─┴─┼─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┼─┴─┴─┴─┴─┴─┴─┴─┤
  │ 0x0C │DD │  -  │QUEUE│             -                 │      ADDR     │
  ├──────┼───┴─────┴─────┴───────────────────────────────┴───────────────┤
  │ 0x08 │                       ADDR                                    │
  ├──────┼─────┬─────────────────┬───────────────────────────────────────┤
  │ 0x04 │ FMT │    OFFSET       │                   -                   │
  ├──────┼─┬─┬─┴─────────────────┴───────────────────────┬───────────────┤
  │      │ │S│                                           │               │
  │ 0x00 │-│E│                   -                       │    STATUS     │
  │      │ │R│                                           │               │
  └──────┴─┴─┴───────────────────────────────────────────┴───────────────┘

Compound S/G Table Entry Format
 ┌──────┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┐
 │Offset│3│3│2│2│2│2│2│2│2│2│2│2│1│1│1│1│1│1│1│1│1│1│ │ │ │ │ │ │ │ │ │ │
 │      │1│0│9│8│7│6│5│4│3│2│1│0│9│8│7│6│5│4│3│2│1│0│9│8│7│6│5│4│3│2│1│0│
 ├──────┼─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┼─┴─┴─┴─┴─┴─┴─┴─┤
 │ 0x0C │                      -                        │    ADDR       │
 ├──────┼───────────────────────────────────────────────┴───────────────┤
 │ 0x08 │                          ADDR                                 │
 ├──────┼─┬─┬───────────────────────────────────────────────────────────┤
 │ 0x04 │E│F│                    LENGTH                                 │
 ├──────┼─┴─┴─────────────────────────────────┬─────────────────────────┤
 │ 0x00 │              -                      │        OFFSET           │
 └──────┴─────────────────────────────────────┴─────────────────────────┘

Source/Destination Descriptor Format
  ┌──────┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┬─┐
  │Offset│3│3│2│2│2│2│2│2│2│2│2│2│1│1│1│1│1│1│1│1│1│1│ │ │ │ │ │ │ │ │ │ │
  │      │1│0│9│8│7│6│5│4│3│2│1│0│9│8│7│6│5│4│3│2│1│0│9│8│7│6│5│4│3│2│1│0│
  ├──────┼─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┴─┤
  │ 0x0C │                            CMD                                │
  ├──────┼───────────────────────────────────────────────────────────────┤
  │ 0x08 │                             -                                 │
  ├──────┼───────────────┬───────────────────────┬───────────────────────┤
  │ 0x04 │       -       │         S[D]SS        │        S[D]SD         │
  ├──────┼───────────────┴───────────────────────┴───────────────────────┤
  │ 0x00 │                             -                                 │
  └──────┴───────────────────────────────────────────────────────────────┘

Previous code use 64bit 'data' map to 0x8 and 0xC. In little endian system
CMD is high part of 64bit 'data'. It is correct by left shift 32. But in
big endian system, shift left 32 will write to 0x8 position. Sparse detect
this problem.

Add below field ot match 'Source/Destination Descriptor Format'.
struct {
	__le32 __reserved2;
	__le32 cmd;
} __packed;

Using ddf(sdf)->cmd save to correct posistion regardless endian.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202402081929.mggOTHaZ-lkp@intel.com/
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v1 to v2
    - update commit message to show why add 'cmd'
    
    fsl-edma-common.c's build warning should not cause by this driver. which is
    difference drivers. This driver will not use any code related with
    fsl-edma-common.c.

 drivers/dma/fsl-qdma.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/fsl-qdma.c b/drivers/dma/fsl-qdma.c
index 1e3bf6f30f784..5005e138fc239 100644
--- a/drivers/dma/fsl-qdma.c
+++ b/drivers/dma/fsl-qdma.c
@@ -161,6 +161,10 @@ struct fsl_qdma_format {
 			u8 __reserved1[2];
 			u8 cfg8b_w1;
 		} __packed;
+		struct {
+			__le32 __reserved2;
+			__le32 cmd;
+		} __packed;
 		__le64 data;
 	};
 } __packed;
@@ -355,7 +359,6 @@ static void fsl_qdma_free_chan_resources(struct dma_chan *chan)
 static void fsl_qdma_comp_fill_memcpy(struct fsl_qdma_comp *fsl_comp,
 				      dma_addr_t dst, dma_addr_t src, u32 len)
 {
-	u32 cmd;
 	struct fsl_qdma_format *sdf, *ddf;
 	struct fsl_qdma_format *ccdf, *csgf_desc, *csgf_src, *csgf_dest;
 
@@ -384,15 +387,11 @@ static void fsl_qdma_comp_fill_memcpy(struct fsl_qdma_comp *fsl_comp,
 	/* This entry is the last entry. */
 	qdma_csgf_set_f(csgf_dest, len);
 	/* Descriptor Buffer */
-	cmd = cpu_to_le32(FSL_QDMA_CMD_RWTTYPE <<
-			  FSL_QDMA_CMD_RWTTYPE_OFFSET) |
-			  FSL_QDMA_CMD_PF;
-	sdf->data = QDMA_SDDF_CMD(cmd);
-
-	cmd = cpu_to_le32(FSL_QDMA_CMD_RWTTYPE <<
-			  FSL_QDMA_CMD_RWTTYPE_OFFSET);
-	cmd |= cpu_to_le32(FSL_QDMA_CMD_LWC << FSL_QDMA_CMD_LWC_OFFSET);
-	ddf->data = QDMA_SDDF_CMD(cmd);
+	sdf->cmd = cpu_to_le32((FSL_QDMA_CMD_RWTTYPE << FSL_QDMA_CMD_RWTTYPE_OFFSET) |
+			       FSL_QDMA_CMD_PF);
+
+	ddf->cmd = cpu_to_le32((FSL_QDMA_CMD_RWTTYPE << FSL_QDMA_CMD_RWTTYPE_OFFSET) |
+			       (FSL_QDMA_CMD_LWC << FSL_QDMA_CMD_LWC_OFFSET));
 }
 
 /*
@@ -626,7 +625,7 @@ static int fsl_qdma_halt(struct fsl_qdma_engine *fsl_qdma)
 
 static int
 fsl_qdma_queue_transfer_complete(struct fsl_qdma_engine *fsl_qdma,
-				 void *block,
+				 __iomem void *block,
 				 int id)
 {
 	bool duplicate;
-- 
2.34.1


