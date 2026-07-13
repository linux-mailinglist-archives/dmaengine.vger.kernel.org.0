Return-Path: <dmaengine+bounces-12409-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qpFAAckaVWoBkAAAu9opvQ
	(envelope-from <dmaengine+bounces-12409-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 19:05:13 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8030F74DD9C
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 19:05:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=vw2d8nZY;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12409-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-12409-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8CBAA301F4B2
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 17:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689FF3451AA;
	Mon, 13 Jul 2026 17:04:09 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012020.outbound.protection.outlook.com [52.101.66.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A38346791;
	Mon, 13 Jul 2026 17:04:07 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783962249; cv=fail; b=JLIBWyYbojp8htQNKCceAeQ+o/KUzyAet1z04DJTh2qmSot3QWNPZQZdcyC3x6b3zbud+Z/nO4fT0uz0VcEeA/XWMmEGHK9rabbEejt7GcIfLGB2ocMQhzs/4rrRwcGXU5ad9qiBSizyH12aECdRo7pRnb/8Tt5QBtT/b9r5deM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783962249; c=relaxed/simple;
	bh=bCs8dWmGpCsLwHPhagEXebof8+UynoVPA2GSNARy5Yo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=h+7OL4UTeOVJqlWnjIx69QTLjfqUNy/fRcRPvRGAvK4lb/nF99bveoh5H9FQ/XIKjpY8OQ3/SZqkj5rDkpG9OGEvtdKLPLJltPP6ednLrj8MzL8vHJaUCSujZ3hERXP//2iMnoo0frWLc60MK4xveVvRf9/Hwnkp671gAOG+798=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=vw2d8nZY; arc=fail smtp.client-ip=52.101.66.20
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R9Tjq5PFYPSy6bbv0aEgAKX9LbflncdfLL2IF9iRw5YvV7BLzTqBotka0kQ8MY8HBe68GVYB6XKqh6NXJY/g02/pLcBwwGKZ071IVUo0/NDmk8oYqvBxrHZ2KHhzm8YAFnE4i3AdqGUSAQIKIk9t209RoQBmlHpCd75HynAeWn5mT5vPl1Aw1MgWje+ZT/pasq9dELpIhTGsHQQ/6o0oWl7+cX6dEA7WAg3S+HCsQb+On6Z2GT8ChDuXLrFw5BYMGLTIKEU5IB1DaK6PXExh1Uh15pzBRCHx7vQ6DFtA/kle7AMx4HYow5QMbF/f3EWhbYlTEwvWTWHDm/1ZQcygTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=41j4i2J8jTE8wl1mRck/rqqTuxk85pIUeCNvbJh71/s=;
 b=XQUs4UkYSNyVwET1zgKirwf+VCLssWuKeqA1NjMhhlxKwEVUA2VErXLSB1E4LL6equ3d+vkd5xWksyG6BrX4JNq6Re50nuFhjIaLBM46mRopXbDqUuwvxTZLUD9uxiDQ1PsD4Kpd4IQOKptBOpgvvSjwciK7iR0oAtqha4ydrRTr0ls+sVV2ieHmbgoA5MTqy9a7gIHauLctB3UTRPtLMabMlDMoU04r4yk19Py5d1wEIPBezDoOUMS7ej4dEiIanIlgPt96CC9J/R5DnYiEeajsoF1zUlVOQRPdNrT+HEhyOENYEhPAaynMz4xtwYGFQlj41RLlMilxFjx60ks6QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=41j4i2J8jTE8wl1mRck/rqqTuxk85pIUeCNvbJh71/s=;
 b=vw2d8nZYXJN9m3vFu7VxxFHPd+tgTlS4hs5N6Z3kIoPvnxTADBYSa73qkIAR/0QANeBA8bG/I/igYNkf3ezr/XRXEKaUsOfJmnt5LNEhKKFlXLEqR+CLcWR/wghTXVdd9Z/mQh1XsmAc2Ib5jznJAvYrMQUIvPB2V61TxilJvW/H6CkZ44UJVk9qAMO/PQ71xIWN2gP1WwLzUWC6zxmA3VXr6a7qao9wXV9316NUPgadGM1V1JrRXTftqs/8VtF8FbZp9E/rOz+XjuQmYDH0SYETxi1n3beZYDtrpg3SoRjcVlG65tgWsp+p8kYAn/5FR6qXIcjuJIT3jAhqUGnU/A==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA1PR04MB10228.eurprd04.prod.outlook.com (2603:10a6:102:454::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 17:04:04 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0181.019; Mon, 13 Jul 2026
 17:04:04 +0000
From: Frank.Li@oss.nxp.com
Date: Mon, 13 Jul 2026 13:03:26 -0400
Subject: [PATCH v7 08/10] dmaengine: dw-edma: Use common
 dw_edma_core_start() for both eDMA and HDMA
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-edma_ll-v7-8-6fb7498c901e@nxp.com>
References: <20260713-edma_ll-v7-0-6fb7498c901e@nxp.com>
In-Reply-To: <20260713-edma_ll-v7-0-6fb7498c901e@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>, 
 Niklas Cassel <cassel@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Koichiro Den <den@valinux.co.jp>, 
 imx@lists.linux.dev, "Verma, Devendra" <devverma@amd.com>, 
 Frank Li <Frank.Li@nxp.com>, Devendra Verma <devendra.verma@amd.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783962202; l=7835;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=iEo6c3L0nFKwZa590SO8zR4RfzzxZwQtYzu3blwy25Q=;
 b=XY7XBWBflD600BYUH4f6lc5stqNFZ/Z4K/IALrw2Oi1xlvcgkO66VsKHgNE8iVtJ4qXDcAnl9
 vhYGictvd/uBqqPLhSCi3VlvsnUxenBwET/2ILHaZW4DEWpk2USrXml
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SN7P222CA0005.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::22) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA1PR04MB10228:EE_
X-MS-Office365-Filtering-Correlation-Id: c73dc6de-0bed-409d-8a75-08dee100be66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|19092799006|1800799024|921020|6133799003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	/P6Y57eWESxMmY4kljmNFquR8HhovDaGut/83R0Yjz4iokE5WIqzOlRHpdK+//Yjer4mHTPpM4UX/321OxHMqRJJRLQLDoox40x7SvJ5THsSOzeZ+J6Nb4hpLRhYxLNOk4h9PKSQiqzhWo5DDgPSMccNkXYUNBHTYIXQyGdrGFYjUBEg4ohlA2Zz5XNsbM6jxLD4kb11trIxFiJpCRl/qKUk8Tb2F5coc28T8W77F1hahsdd34CMuR2nOFEATOhqAvy0ve5VXHtAgNeFuezUSYPn64k29FiejE4hovJ0q/ti1iWEaKUmXU90r3+Yv5Ve+Qx479lmvnQaIx+AwlyAZeKbelP7od0NONnzAH8tBAZI1SGcoqgtiii0tyEW/Eljy3JXcQO6VlfKEHAAGInbIoWz69vzsEMAe8Fe225yfNd5vLSAOsjKLI2fQmjyjuOJp9FldAx+9GGkg4xbqAQ5U/URgBeua9zs81+qSJuSa/BDxovonzifA2CX+KjO3v4lJnRcrEH1LR5AgHE8o7/p9EbEABjFBJZ4JdN+2yPn7lJlaKo+pee8rGNxDmudb3i9mO1zlthFoRms7lWcia7Mm/TRZb/md+bPnsJ2rQFPPrA27XEqyfS9duTIn0XvvBmUIx02BdPvf7W1sjivBo+67A/fKb01n84jMv+aYOigdzovIVxLxndpgakmpWPhvK93PDVMPyDd4HZoWouLCtnA5A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(19092799006)(1800799024)(921020)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2dBcnBsZTJIbVBQa0J3c2JoeHhTeTN5NXZXYVhwb1ZsWmpYQXE0ck1SSFVH?=
 =?utf-8?B?R1EvVStJY01sdEJVcVJZUWtNRWdoY05mWkp5NFROU3lQOEtIaFYzZDgxLzFW?=
 =?utf-8?B?bUNtMWd4M1k2dnFYM0tubGFaN3dSdFExaTVzSy9NZktzME5LSlZWSTIweE5Z?=
 =?utf-8?B?c2pjR1lFZ3d1ajFNeUJVZmRYdHpyejh0UDRBdC81V1BxMjNBcGhwTGkrNWor?=
 =?utf-8?B?QktpRFVQOSs1LzF2ZUNzRytXUklFd3JnL3dvYWg3WVhtNFZnRUJjZWhVMm9X?=
 =?utf-8?B?WFdKZXZwYjJrcFhoQ1NWcXBZSTlleTNrWFUxaUwxQkppdHRHZHpRQllvSW9B?=
 =?utf-8?B?aXR0VnlBV1QrdTFaR3Evb01kT3dXT0R4bGNENWpaRjJNTE56T0ZUNkZISVhL?=
 =?utf-8?B?TGlDdU5NOHo4eW5HZlpGd1crWkhxYVN0OEYzV1JCWjBhc014STEzL3laSmpU?=
 =?utf-8?B?aTNYblZNRmxRTjEvMUk3TUxCQTh1K2dZQStnOXFnaGo4clo4TDRXRG5pMUgv?=
 =?utf-8?B?eDlNVU10M2pDMGs5cXN3NUlEMjlaVnF6VFF4VldyVjcvODhJQnZxc1U5WEU4?=
 =?utf-8?B?Z0tyVU04Vy9WbGZJSGNtQ2NjQ0JrTiswWUJUaldFL2pmR2xYc3hBN0ZyRnR3?=
 =?utf-8?B?K3djQzEzVHRPenFxQWQyNmR0NStTZjkrcFpuMWJnM095MXM4ZEg5ak1Nanl1?=
 =?utf-8?B?akhRUDlJSStLU01WUWZuZkJ2OVdZd09Zc3MwMWp2TE5TTFlUTXlHRHR0dEZr?=
 =?utf-8?B?SVNxMGJmOEJtZldPQ3hFTm1BY05sdlZaTDZ1Z0tPL1lQOHFsd1JtWnRVS2tp?=
 =?utf-8?B?YXJ1Z25pNkNzc21GNUtaRmt0RWxsUzVVeDlHQzNwQzJJMHhGSFRDaDNnamc2?=
 =?utf-8?B?WlBSQ0RZQkV1T1Z6ZytIQWVOYWg5ZWhjQU0vUUkwYmRHK3kvSUFvSmIyb3gy?=
 =?utf-8?B?NVhpWjNMTHAyMEJaWlBWVVhrNEU3QU1Wa1FsQ0xZbEM2OUZjNEVWOTViWFY4?=
 =?utf-8?B?OFFFeHhpZU4renRHYVJEQ2lxOWpQQzZ2Z0dXcTVvYjFXSUNlTTFucGZzRktl?=
 =?utf-8?B?UVBpUE0rRmJ0Rng2UEU5Rkg2OWlmNjlBSitKb0luZXQvWndJRXNnSWJIMG5K?=
 =?utf-8?B?NVZQWXBoZC81RUc4VjlGVWdxUUhONS9Cay8xSUExTDA1ckk4M012OENGcW0z?=
 =?utf-8?B?Qm9BN0NuaU81cGgrWDNieVFESTFvSVpVVUlqTG4zVEk4aE1qd3BMNU1uODFv?=
 =?utf-8?B?cXE3Q0JPN0paUVVTNjNCUVNmT21BSldoTzlLYVo2YU52c0lkY3ZiT21RVG1k?=
 =?utf-8?B?K2JxSkxGd1ViM3BCYXpBYk1mS2tFb1hOblFoZnN2c3ZHQzBPQXUrOHF3SWsx?=
 =?utf-8?B?VHBwN003N2tDN0ZOU29pQ1htUTNSMlJtL1VnajdkcjhwYjdidEFESVlrdTNP?=
 =?utf-8?B?dm04dnZsQmFmNW5NZ3B4aitJbElRZUJBaFNwVzdpZXQyNUYzWG1VMzFEOFdU?=
 =?utf-8?B?SFJ0SlE3MDJpZytwbmRNREV1M1pZU2lNUW5nVVY0OTB2em14NGJoVTczN1lK?=
 =?utf-8?B?ZzQvOENkL0VLWHZycmlKMVBHNTY3ZDRIVmVWbXZYSWMxVzNlM25EeXE2ZHR1?=
 =?utf-8?B?ZE9kNkZGOGFFdWdBeE1ObGlSZUtxajdmNXNwc1g5Nk1JMStQL0I5bC9kZ0pk?=
 =?utf-8?B?VnNIaXZNZlZXTFpwckJFeG1BUVArZkpIVHpnS0tUMFdFN2ZzVkhwZzNZMmxY?=
 =?utf-8?B?aVZnSC9lZ0p0eG9DWHF1M0NjOXZyNjdSSWZsTXlaYndkVk1lUmFrblA5UjBz?=
 =?utf-8?B?SmxHcUNWVGwzR2lNem10RGhVYXNkNnJLUlZodjc2clpHeVRZcVBxUFBZR1Fl?=
 =?utf-8?B?Q0RPWXI0ckZNdVlnQVNaOGlaa0JrTVdETExNU3loQ0lTL2FHSnNVbXhPSGlQ?=
 =?utf-8?B?QlBERjRVelpNRVI3VE8zYXlVNTQ3OEk2TitudWwyZnpkeXlDMWxVOGpya1I2?=
 =?utf-8?B?ZTM0SmNRK0dyTlNiMTVJKzlqc2xoWG9kRjhOZXY5YW56YVc1Y1lZRVFxUkxP?=
 =?utf-8?B?eWVTYnBCQ29LR3hQa0l1UmZ2YTFORFdkZTFHYTVLcDBneDNuRzhLa25FZkY0?=
 =?utf-8?B?VTdHcjhXWThSMERORmJzWURXbTRHQmxvUWJsaTlNanZvT2lsVVd6QURQN25n?=
 =?utf-8?B?Q1VGNmh1d0Zrb1VsQUwzQ3M5aGw4OFExOWd5Q2cwL1hramkyTFVpQW1BVnBR?=
 =?utf-8?B?eUF4QjhDS3ljUGtXL1V1RjJWZW5hOThJdUpMeHdTZkFBNnBxUzVHK1RiMC9U?=
 =?utf-8?B?UG44TitUS1Avd2tzZ3NaWlg0NDFnNmhkSmR4NTVhZFlTM3FneGtoQ1R6OWNH?=
 =?utf-8?Q?5avhFcbsGCJiraRhWLddBUQ3SWWBmwhPsEBBb?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c73dc6de-0bed-409d-8a75-08dee100be66
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 17:04:04.6011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l8cAlXHKz4bk7PiA8M75NfuwUt1JOHHe7ejYk3KYbypXEWmjJNRNlXILjuTGaoMM3keoI026qsmr3HM+0q/zyLP4/UL/K78oWSIjQteDdEp9KIyJSxEr/jC7XglOY9Mx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10228
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12409-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mani@kernel.org,m:vkoul@kernel.org,m:Gustavo.Pimentel@synopsys.com,m:kees@kernel.org,m:gustavoars@kernel.org,m:kwilczynski@kernel.org,m:kishon@kernel.org,m:bhelgaas@google.com,m:hch@lst.de,m:cassel@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-hardening@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:den@valinux.co.jp,m:imx@lists.linux.dev,m:devverma@amd.com,m:Frank.Li@nxp.com,m:devendra.verma@amd.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[Frank.Li@oss.nxp.com,dmaengine@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@oss.nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,valinux.co.jp:email,nxp.com:email,nxp.com:mid,NXP1.onmicrosoft.com:dkim,oss.nxp.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8030F74DD9C

From: Frank Li <Frank.Li@nxp.com>

Use common dw_edma_core_start() for both eDMA and HDMA. Remove .start()
callback functions at eDMA and HDMA.

Tested-by: Koichiro Den <den@valinux.co.jp>
Tested-By: Devendra Verma <devendra.verma@amd.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v4
- collect koichiro tag

change in v2
- use eDMA and HDMA
---
 drivers/dma/dw-edma/dw-edma-core.c    | 32 +++++++++++++++++++++--
 drivers/dma/dw-edma/dw-edma-core.h    | 16 ------------
 drivers/dma/dw-edma/dw-edma-v0-core.c | 48 -----------------------------------
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 37 ---------------------------
 4 files changed, 30 insertions(+), 103 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 2652ad8e7a8f6..f52d9fd18e573 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -163,9 +163,37 @@ static void vchan_free_desc(struct virt_dma_desc *vdesc)
 	dw_edma_free_desc(vd2dw_edma_desc(vdesc));
 }
 
+static void dw_edma_core_start(struct dw_edma_chunk *chunk, bool first)
+{
+	struct dw_edma_chan *chan = chunk->chan;
+	struct dw_edma_burst *child;
+	u32 i = 0;
+	int j;
+
+	if (chan->non_ll) {
+		child = list_first_entry_or_null(&chunk->burst->list,
+						 struct dw_edma_burst, list);
+		if (child)
+			chan->dw->core->non_ll_start(chunk->chan, child);
+		return;
+	}
+
+	j = chunk->bursts_alloc;
+	list_for_each_entry(child, &chunk->burst->list, list) {
+		j--;
+		dw_edma_core_ll_data(chan, child, i++, chunk->cb, !j);
+	}
+
+	dw_edma_core_ll_link(chan, i, chunk->cb, chan->ll_region.paddr);
+
+	if (first)
+		dw_edma_core_ch_enable(chan);
+
+	dw_edma_core_ch_doorbell(chan);
+}
+
 static int dw_edma_start_transfer(struct dw_edma_chan *chan)
 {
-	struct dw_edma *dw = chan->dw;
 	struct dw_edma_chunk *child;
 	struct dw_edma_desc *desc;
 	struct virt_dma_desc *vd;
@@ -183,7 +211,7 @@ static int dw_edma_start_transfer(struct dw_edma_chan *chan)
 	if (!child)
 		return 0;
 
-	dw_edma_core_start(dw, child, !desc->xfer_sz);
+	dw_edma_core_start(child, !desc->xfer_sz);
 	desc->xfer_sz += child->xfer_sz;
 	dw_edma_free_burst(child);
 	list_del(&child->list);
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index e18d6e827c2c9..27415f3a2d04b 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -125,7 +125,6 @@ struct dw_edma_core_ops {
 	enum dma_status (*ch_status)(struct dw_edma_chan *chan);
 	irqreturn_t (*handle_int)(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 				  dw_edma_handler_t done, dw_edma_handler_t abort);
-	void (*start)(struct dw_edma_chunk *chunk, bool first);
 	void (*non_ll_start)(struct dw_edma_chan *chan, struct dw_edma_burst *child);
 	void (*ll_data)(struct dw_edma_chan *chan, struct dw_edma_burst *burst,
 			u32 idx, bool cb, bool irq);
@@ -199,21 +198,6 @@ dw_edma_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 	return dw_irq->dw->core->handle_int(dw_irq, dir, done, abort);
 }
 
-static inline
-void dw_edma_core_start(struct dw_edma *dw, struct dw_edma_chunk *chunk, bool first)
-{
-	if (chunk->chan->non_ll) {
-		struct dw_edma_burst *child;
-
-		child = list_first_entry_or_null(&chunk->burst->list,
-						 struct dw_edma_burst, list);
-		if (child)
-			dw->core->non_ll_start(chunk->chan, child);
-	} else {
-		dw->core->start(chunk, first);
-	}
-}
-
 static inline
 void dw_edma_core_ch_config(struct dw_edma_chan *chan)
 {
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index c0746e5351410..7b4933c66f9f2 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -379,36 +379,6 @@ static void dw_edma_v0_core_ch_enable(struct dw_edma_chan *chan)
 		  upper_32_bits(chan->ll_region.paddr));
 }
 
-static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
-{
-	struct dw_edma_burst *child;
-	struct dw_edma_chan *chan = chunk->chan;
-	u32 control = 0, i = 0;
-	int j;
-
-	if (chunk->cb)
-		control = DW_EDMA_V0_CB;
-
-	j = chunk->bursts_alloc;
-	list_for_each_entry(child, &chunk->burst->list, list) {
-		j--;
-		if (!j) {
-			control |= DW_EDMA_V0_LIE;
-			if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
-				control |= DW_EDMA_V0_RIE;
-		}
-
-		dw_edma_v0_write_ll_data(chan, i++, control, child->sz,
-					 child->sar, child->dar);
-	}
-
-	control = DW_EDMA_V0_LLP | DW_EDMA_V0_TCB;
-	if (!chunk->cb)
-		control |= DW_EDMA_V0_CB;
-
-	dw_edma_v0_write_ll_link(chan, i, control, chan->ll_region.paddr);
-}
-
 static void dw_edma_v0_sync_ll_data(struct dw_edma_chan *chan)
 {
 	/*
@@ -423,23 +393,6 @@ static void dw_edma_v0_sync_ll_data(struct dw_edma_chan *chan)
 		readl(chan->ll_region.vaddr.io);
 }
 
-static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
-{
-	struct dw_edma_chan *chan = chunk->chan;
-	struct dw_edma *dw = chan->dw;
-
-	dw_edma_v0_core_write_chunk(chunk);
-
-	if (first)
-		dw_edma_v0_core_ch_enable(chan);
-
-	dw_edma_v0_sync_ll_data(chan);
-
-	/* Doorbell */
-	SET_RW_32(dw, chan->dir, doorbell,
-		  FIELD_PREP(EDMA_V0_DOORBELL_CH_MASK, chan->id));
-}
-
 static void dw_edma_v0_core_ch_config(struct dw_edma_chan *chan)
 {
 	struct dw_edma *dw = chan->dw;
@@ -581,7 +534,6 @@ static const struct dw_edma_core_ops dw_edma_v0_core = {
 	.ch_count = dw_edma_v0_core_ch_count,
 	.ch_status = dw_edma_v0_core_ch_status,
 	.handle_int = dw_edma_v0_core_handle_int,
-	.start = dw_edma_v0_core_start,
 	.ll_data = dw_edma_v0_core_ll_data,
 	.ll_link = dw_edma_v0_core_ll_link,
 	.ch_doorbell = dw_edma_v0_core_ch_doorbell,
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 641a513bc52e7..4bf5a441afbfd 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -222,26 +222,6 @@ static void dw_hdma_v0_core_ch_enable(struct dw_edma_chan *chan)
 		  HDMA_V0_CONSUMER_CYCLE_STAT | HDMA_V0_CONSUMER_CYCLE_BIT);
 }
 
-static void dw_hdma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
-{
-	struct dw_edma_chan *chan = chunk->chan;
-	struct dw_edma_burst *child;
-	u32 control = 0, i = 0;
-
-	if (chunk->cb)
-		control = DW_HDMA_V0_CB;
-
-	list_for_each_entry(child, &chunk->burst->list, list)
-		dw_hdma_v0_write_ll_data(chan, i++, control, child->sz,
-					 child->sar, child->dar);
-
-	control = DW_HDMA_V0_LLP | DW_HDMA_V0_TCB;
-	if (!chunk->cb)
-		control |= DW_HDMA_V0_CB;
-
-	dw_hdma_v0_write_ll_link(chan, i, control, chunk->chan->ll_region.paddr);
-}
-
 static void dw_hdma_v0_sync_ll_data(struct dw_edma_chan *chan)
 {
 	/*
@@ -256,22 +236,6 @@ static void dw_hdma_v0_sync_ll_data(struct dw_edma_chan *chan)
 		readl(chan->ll_region.vaddr.io);
 }
 
-static void dw_hdma_v0_core_ll_start(struct dw_edma_chunk *chunk, bool first)
-{
-	struct dw_edma_chan *chan = chunk->chan;
-	struct dw_edma *dw = chan->dw;
-
-	dw_hdma_v0_core_write_chunk(chunk);
-
-	if (first)
-		dw_hdma_v0_core_ch_enable(chan);
-
-	dw_hdma_v0_sync_ll_data(chan);
-
-	/* Doorbell */
-	SET_CH_32(dw, chan->dir, chan->id, doorbell, HDMA_V0_DOORBELL_START);
-}
-
 static void dw_hdma_v0_core_non_ll_start(struct dw_edma_chan *chan,
 					 struct dw_edma_burst *child)
 {
@@ -383,7 +347,6 @@ static const struct dw_edma_core_ops dw_hdma_v0_core = {
 	.ch_count = dw_hdma_v0_core_ch_count,
 	.ch_status = dw_hdma_v0_core_ch_status,
 	.handle_int = dw_hdma_v0_core_handle_int,
-	.start = dw_hdma_v0_core_ll_start,
 	.non_ll_start = dw_hdma_v0_core_non_ll_start,
 	.ll_data = dw_hdma_v0_core_ll_data,
 	.ll_link = dw_hdma_v0_core_ll_link,

-- 
2.43.0


