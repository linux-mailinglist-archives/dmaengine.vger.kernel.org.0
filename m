Return-Path: <dmaengine+bounces-7810-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9038BCCCA62
	for <lists+dmaengine@lfdr.de>; Thu, 18 Dec 2025 17:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8509A30517C1
	for <lists+dmaengine@lfdr.de>; Thu, 18 Dec 2025 16:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50618357A2E;
	Thu, 18 Dec 2025 15:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="W2lFT3yY"
X-Original-To: dmaengine@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011051.outbound.protection.outlook.com [52.101.65.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58D934B193;
	Thu, 18 Dec 2025 15:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766073438; cv=fail; b=DTOZdFGlRQ/E0lXMzt6e0+F3iUIhmO3LkkEJib3qXR3+AAdLMDONQFtKvjM24kmbfL+eep1g6SeXX0VXPaVleyZ8OBIIvhf46wi6jmMNXnqfaJuuAT2GyrTz9SDTmgircc4z0sfzbfvzvjZZUxPp54P6+GNE928846RUSC95Ok8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766073438; c=relaxed/simple;
	bh=y2+PfL2H7b1FUgjqeANH8jwnoWP1hvs/HDEhP+Ko9ic=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=XuQ+nineIVP4V2D+tg+/XcGMzlvsa9KAqe3C+Wre3yTYWm0Hx1vQKGH9nKlCuU0LxRP4M3tTIJlTYRtqDXAGa8lkdRcnSdTBK4mTSxeadQg7+jTqWCHWHF6XLIATmWjC/Yrs875GSuQmAQvGyIZP1NDb5hCWyvs+jykbo3pK2M4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=W2lFT3yY; arc=fail smtp.client-ip=52.101.65.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q4JBV1z/QTYD1l53RUMNgy4FoTfNv1NU/gYPegtGQXjiw4ECvakYwK1lXQQRSQ47NqoNqo6fg2z23KLqtmkXHAwWS/5HCNkxRpc/CuKalpTg0rf6yRVIPpWSnRg2Aa5K+Ul2ibRz8HIzbOT+xrlrkQk93prkaTpcrDv1KAVf+Wv+5kOSUXRlO9pjgGrv9D7uxisP4+dvcedfvX+MIkd6Rn4KoY/VyRgt/ryuzV8vdQ2O1PJuVssZMpTVBN1xVx1Hm3H7X0+thFrcJd3GtnPdcvayZuK4PBYqV7ytn4x+44UDFvrEX+GFRbzQ5TrF7AF2MBS8ajXfLTD6R0KhKxH6qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bwjk+7+Yxg8aO8dUdJlfm7y3buwrxqjEUHZvv97CBHs=;
 b=mLXLBZQSIGxdd9ztyjfSWYf1C3slesCXnzRdtWe2L9Bft2FlGAzAbTYPhyXFHjdghRuEYn54eLtGMxGjXWL5B7yHC4LOQ7b1nEDHDEP7+Q+tNzWyr0TSyj1S78g+oi0jT24o3ybdWV5MD4Mc6T44V+BC9hdsABoVU2KQ/IvGIuWo6CHMkSprOeXoV1QdpNCp031mcvAoQZ1u8gbUil4kl+5gl/K76USGPpsoKsYGQfoubcdJu5P27w9r9nZ11Klm3IQanNEXNUnpVoD5XVOjvuigp4Mzm4sthGGwMah6Z6ocCmKDpapOnkOekq0dkZGW8rZ/8IFK6YtxIA1rASA89g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bwjk+7+Yxg8aO8dUdJlfm7y3buwrxqjEUHZvv97CBHs=;
 b=W2lFT3yY+ImXvq1a9L7+OePChrARB51yYBagFUc46BvygQEUoegX7B2JCZkRSM4edD81FekCmna+moppILRco/5GtESf9iUXI5Ju6DpuVISuFq9w+J931LpZKVSMT667/+5RvLmLvX96cz6m8XfTS2SvllrOsnhgfAoQwmEIlPp3nPXj7yczqj9bSPX7CYBvfYF83QAlYyzBFJqWSIBLTol2JklmEwGQOiXEZM+DWMcQk29WdRDCYyHNEuLGcJNyQJsmaEofp6pvDKq9UJdtca6DX+hqn+hapb37QBjGqdOwctqolmIN1Gob0KMeh+Mf2FFxFjm7z3BiPTdOGAyWCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by DU4PR04MB12130.eurprd04.prod.outlook.com (2603:10a6:10:645::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.8; Thu, 18 Dec
 2025 15:57:10 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 15:57:10 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 18 Dec 2025 10:56:27 -0500
Subject: [PATCH v2 7/8] PCI: epf-mhi: Use dmaengine_prep_config_single() to
 simplify code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-dma_prep_config-v2-7-c07079836128@nxp.com>
References: <20251218-dma_prep_config-v2-0-c07079836128@nxp.com>
In-Reply-To: <20251218-dma_prep_config-v2-0-c07079836128@nxp.com>
To: Vinod Koul <vkoul@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Koichiro Den <den@valinux.co.jp>, 
 Niklas Cassel <cassel@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org, 
 mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
 linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766073392; l=4628;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=y2+PfL2H7b1FUgjqeANH8jwnoWP1hvs/HDEhP+Ko9ic=;
 b=9oCAFabbdkwtJ9zL7HhHSw3tl/+MtWUtN4lW6KoFMIVgy9ob9+0+0eoj2r7L8Jjwmq1dNwqXQ
 7JUjSl66TcTDorC6a9pbZA04I7eRChsBtp46HeUnDx8vhOEsgTyU+Fa
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH8PR07CA0047.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::10) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|DU4PR04MB12130:EE_
X-MS-Office365-Filtering-Correlation-Id: b910d42a-f0a6-4994-ad7f-08de3e4e1a52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|7416014|1800799024|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bkhSUXV1NHBNTENVbmZkZWl1NGp6Wkp3QmlqbDlyQjJ0cXg3ZzNqUVo5OEc4?=
 =?utf-8?B?VWdxd1hHajE2SzRpMDh1WWxraThHR09PNEg1V2YwZU1VZU8raWhDN1p1STB3?=
 =?utf-8?B?YWJEcGRHOTRkUnQzejg5MmRBbHRVUWlQc2hQV2J6TnNTNzFFL0lrcnlSR2Uz?=
 =?utf-8?B?dnpXSTRiRkQzS3kyZ1drTnRxR3Bac0JnSnNFcWJMYnpwTTcrR3R0bGdLRnVo?=
 =?utf-8?B?bWY3MXc3ZUdLWHhMbW1rMVdtUk1NSWlaZ05hbUR3RUdtMUUvR0lqS09zRHpa?=
 =?utf-8?B?dmFHckRibHFOdTNkbjdvWXhHbUdMNGlCRXZscXlWWjZnZFQrTHV6aWRnVHlt?=
 =?utf-8?B?dGJPRVJISWxiNW9ONHZxMDJLWXB5ckhkMVU1eitSd2cxVEtuMmRYSWNaTnBw?=
 =?utf-8?B?YnZUR1lUOXM0eWcyVHBRcTFNTUZmT1g1aXNla2w1cFpER0RTK3d0eHkzRHh0?=
 =?utf-8?B?Y0MySTZqVDFtOWlkanVWdjBwUzNoMjY0ZzRZWVNnVDM5S20yLzg1ajRiSTI1?=
 =?utf-8?B?SytLckxYRkNjRk4vSXNhblpMVllrankzd0VCZ2FMOEF2cTZ5YUJTeWlCVld6?=
 =?utf-8?B?SE1XL0NQeEpYOEp2MDlEM3dFWnorSlRzcnVxaVpGQzArMjdQblhOZ3FpN1Vu?=
 =?utf-8?B?Q2UvY29RbWRTQUV0dm9OTjVHQWo2SHV0SStRU0t2SGkxTFZPc2NCS21PMTJh?=
 =?utf-8?B?MHhSUGhaUGs4TDJEVjFVckx5R3QrT25tVno1OG9wd2NNNWoyaTVvbDB5TDFZ?=
 =?utf-8?B?R2tsdkZRckxuc0RUMG93ZDZZSHpFUGpTYkY1NGlvOG1pRlFIT2hEYlgxVGp4?=
 =?utf-8?B?NXhXdlFEZVlrM080OFY2bjJtcUdwUnhqKzhpbWFsWXUyVGVMbm1QS1BjRVhI?=
 =?utf-8?B?OWsyVGpESnpTbzdseWx4SytGRU9HVWFEenAzMjI2Rnd5UVZMTmFvMzRQdmp6?=
 =?utf-8?B?cnFxb25FMFgrZnlVeGJ1TzBMS0N5YzE5cHlEU25DY0xsMlpnUjRkWjJDMzk4?=
 =?utf-8?B?OVJaQm9JeHVoMENwbXpVNGUxUld6eGpxdXdETTNxVi9wWXViVFZZTjNvRXp2?=
 =?utf-8?B?UktvQ291OHFGUWs5TjhwS29YZkJoRTM2N05QcmFFU3RINjBZN3Rtd25kdUNV?=
 =?utf-8?B?MWdNWWpwMmNaaDhoWWVYWVFHOEZkTHFQNy85cEJwZ2hJOVp1WGlDZ3FtT2Ro?=
 =?utf-8?B?M1ViN2pDUkc5SVJxQUhYTDBJdWxnYlEyZnl6SFJXSkRsWHYyeHhHZTJZak53?=
 =?utf-8?B?R1VUNWZwS2lHY2RLc3NRTDVML0djbUFKUWtGTFRsR1ZvOFVMM1lJdzJrNUJM?=
 =?utf-8?B?aHlmdFRKNy9JVG5DN1VQMDhBQTNYdit0YWlRdm5aYlZzTU5kZW5Ea04xQ0ZJ?=
 =?utf-8?B?MUdjTEI5QjBvN1hJYTRxd3Jrd1FkbkYrSHEvRnNjV1dBbHVVb1ZCWnVhbTcv?=
 =?utf-8?B?ZnVGUW9NV0xKeE5OUmhoWXkwa0dsZXdyVUNCbWdyZlFsZm5nZEJOMTk0UVIz?=
 =?utf-8?B?UWlBTk1wMFhiN0dsYTlVMUY5WlFqNUx2ZUxLSHhlN3VtRUIzSlZOYmtXRWhl?=
 =?utf-8?B?bXJpSVFKTEtlK3I3UG5haGUxZUhKRlBXOC9kNEdNN0lIR24rd1gvSVZXVVJO?=
 =?utf-8?B?Y2FDUXJiVzlqN09qYnZYam52Yk9sbzRGMEp3MDNUZElyU2tyS01CTEJPMVlw?=
 =?utf-8?B?Wmdxa0d6b0hzM2FMeFpGcEJuc1VpY21MT1FmNkxRL0MvazgvT1F6d20xRmVT?=
 =?utf-8?B?RHloa0lRZWRSRi9vYmtiVG1XdTMrZWw2TXJvSHQwWjNFL2VQSk1pMnVZSGZ5?=
 =?utf-8?B?QUdpU2Q3Q1ZuY2EwcFJla0dIbk9adXIvTW41YndudnVGV3A4enVCZmVyVGJi?=
 =?utf-8?B?SGJOaHQwM0tsQ2VMbGUzZ1FUMzM2MVNZMmZqSk05Z3dMUHR0aXZvQ292Sy9m?=
 =?utf-8?B?NzY1b1dnSm9pdjVrUU9BbDhNYk9DR3FsUkRvcW9WcTQzNFpNRGlOMzBaVERm?=
 =?utf-8?B?WUN4Tjh5SGNJU2FDWU52dlBVRzFPL0NvT1QyZzFVdzBXK1htaFBjOENoemVP?=
 =?utf-8?B?bWc0emFqaW9NWVIxcmhNY3lqSUtRUVlwRi9Ldz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OENZZGxFVE5kL3dROWZsM1NYR2F2aDd6U2lLSmpFZ2RveExya2RGSVpmTXcr?=
 =?utf-8?B?bVV1a2ZkWFgwT3FWU1JiV3cxNkhFdlhOM2tVUks3Qkt6UThFZDA0enlrSThY?=
 =?utf-8?B?RkhUQU5uYnNMMzZJaDhPT1RVaXM3ejN1VzNPVWFBUG1EajBpRVZQTjR6akNM?=
 =?utf-8?B?WU00bTdQaXBwa3pFaExMb1NJdllhdlhxdXBURElGZXZtVVFuSExpK2lVVkdP?=
 =?utf-8?B?YnZjWUVvNnU3QlU5bEdlZVZCNTdiYW1HUmh3V3hLRlpVT3JnaGxOeTdlV05o?=
 =?utf-8?B?Q2JVdEtIVFYyOVdTNzdkSUZVU3VsQUY1ZDFSNFkvVkxMMEllcFF2T3dVNlZ1?=
 =?utf-8?B?bWxzSVJTbUdBNHZUS2RCblk1UGhZeTJxTlBJSWJkcDJDVGxRYW8xL1FSOFZ2?=
 =?utf-8?B?WHJOOWJmTUtkVzZpSnlKeFhTNnV3Q2xBT25teUpKRUtPR1IxclVzME12MVB4?=
 =?utf-8?B?OWIra2lZZU9IdjlvK1Qzdng4MXRVZ0ZNaVNTYTZzMUxEMjVzQU5XZEQvVEgz?=
 =?utf-8?B?cThTZG81Ymg1N2tQTlpoRHZ6cnJVUENRNlB1OWVVdW16dzBGZUY5UzltMmhI?=
 =?utf-8?B?aE80OFR6cXFyTUxMeSsyc3pFRUxCRHk0Q1h4RkRpNFJ1YU5mUnA5bVBaeFZl?=
 =?utf-8?B?REtVZGMyWFQ0eVkreTBMRkJYRGtPcXkyU1V6SnJGa2VyZkFPQlhGWlNuRlFx?=
 =?utf-8?B?dStTbStoa0ZKSFlVZUUreHZIQ0hzT1JxaDBtTE1yeVdGRVcva2ZmSlUvR0p3?=
 =?utf-8?B?VFVnUGZ2dzZqdnYwOUxONmhaaGtyOFNabE43WlRidHZXUnZqUERENllYempL?=
 =?utf-8?B?VGtvcExWM1BUN3dQZHlDUHpiUkdHUThTVmZ2bC9tQndBUkx4RnA5RVNUMlJj?=
 =?utf-8?B?Uk9nMVVvTzFBa3J6aEtJRHFseVR5YlhacnFOUWZYYmxyWDl4OERxZVNZQndP?=
 =?utf-8?B?NGgvYXo4REJSTHpwZ1BKUjZCN1dHWUZTallEeXBZTEplV0IzSStFMjlaWjM4?=
 =?utf-8?B?dk1YWCtmYW93TXhRM0dBZGQyYjVxc1I3OWJLQUVocDVCUGxCS2UydExYMTdW?=
 =?utf-8?B?Tnh4TjljaFduWUg3cmdkSkp1RGtBaDZNMVMzRkZzamhGMjMvV0xsdlVLdEMy?=
 =?utf-8?B?dGEyNnJPUEdoSTFJV3cyVm9ZMmJCdUEzNHMxTnVoM21ubUJQTFBmZ3dTZEJl?=
 =?utf-8?B?OUxTQ0FMZkthMCtINms3T25uYXcyei85VDlSUFpoSjZDdWxmVCt6Y2VFVTY5?=
 =?utf-8?B?d3ppOVZZclFNaEYxR1ZyMWZFSWVVK0RYWjVKVmhQY2tKWjZVcDk0YmdnQ1pz?=
 =?utf-8?B?eEtLWHc0NmpWallCZ0FRUUk2RS94NGhiNCtpaUxzOHp4SGhYYWlVaUxnUUYx?=
 =?utf-8?B?OUl3VENiQzFldjBJbDJRYVl3NzVwZklYYWZ3ZlhkSTErbkZidW1ER0ZDSDFD?=
 =?utf-8?B?SXNLV2Nwb1NXNStrVEt5SWhWcm9yaEFaODNVTjA0NEExNXZyQmJCZ1NvQ1g0?=
 =?utf-8?B?VnY3ZjVEWXdzNmNOd08rOWhhN0NxbWJCWFF2R1phcmRKV3YrNVlsZ2FEcVhC?=
 =?utf-8?B?ZEZTQ1JzSzBNTDdQL2c1U3ZPTFJUNFFwT2dFUHRvZW43SnFUeTF2TjBoaFo1?=
 =?utf-8?B?SVdjd3Rva2FBbU4yTllFVkp4bW5ZMGt6OHpxTGdmd0xZNG1YSjIwN1NsZ3Bn?=
 =?utf-8?B?elpKT1BBZnYvQWpnd1BVNUpETGlTbTBTSlkwZDJzZ2sreUVQc1cxRmV0cE5w?=
 =?utf-8?B?NUtOMjN0S21McFlVWnBNN05ZTUhuYXMwVEc0RmJIdlkrZUsrVmtjd2JROFRX?=
 =?utf-8?B?dWtQeFI5VU15a0wxSmRaKzZxbWpLTTlLc2owSDlYMFE1QWY2YnRSektkNGRy?=
 =?utf-8?B?Yi9sSndDd2RSNkdpY1YzVWc0ZHZab2E1eUtyc3NYVXFWZ3BTeWNnUWl5aERt?=
 =?utf-8?B?SXhiRDN4OXRNYUVhQ2JuS09JYXJGc0hFUThYV05KY1FKUHpUZ21ScVNnTCtU?=
 =?utf-8?B?blVWRVF5KzVOT2d4Q2NLNTF3WVZadVMvUDdrSnllU3dwNm5nOXc2WUlLTU5h?=
 =?utf-8?B?YSt4ZFVjRjJWMUhCKzBOU2RMSDdSNzlCRE5WM2ZSRFZWa1JybmtHMFd2aDZa?=
 =?utf-8?Q?ElsZY21OkvczBoO+iKa/cAm03?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b910d42a-f0a6-4994-ad7f-08de3e4e1a52
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 15:57:10.4972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pXtOu0rwgd59/mPiAy9J4ctIgqFaO/pxbz8Rk4nc32Cnz6s8sq31enmGeeTYnjWG/t7fSRurjVminP25B2ARIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB12130

Use dmaengine_prep_config_single() to simplify
pci_epf_mhi_edma_read[_sync]() and pci_epf_mhi_edma_write[_sync]().

No functional change.

Tested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Keep mutex lock because sync with other function.
---
 drivers/pci/endpoint/functions/pci-epf-mhi.c | 52 +++++++++-------------------
 1 file changed, 16 insertions(+), 36 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
index 6643a88c7a0ce38161bc6253c09d29f1c36ba394..0bf51fd467395182161555f83aa78f3839e36773 100644
--- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
+++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
@@ -328,12 +328,6 @@ static int pci_epf_mhi_edma_read(struct mhi_ep_cntrl *mhi_cntrl,
 	config.direction = DMA_DEV_TO_MEM;
 	config.src_addr = buf_info->host_addr;
 
-	ret = dmaengine_slave_config(chan, &config);
-	if (ret) {
-		dev_err(dev, "Failed to configure DMA channel\n");
-		goto err_unlock;
-	}
-
 	dst_addr = dma_map_single(dma_dev, buf_info->dev_addr, buf_info->size,
 				  DMA_FROM_DEVICE);
 	ret = dma_mapping_error(dma_dev, dst_addr);
@@ -342,9 +336,10 @@ static int pci_epf_mhi_edma_read(struct mhi_ep_cntrl *mhi_cntrl,
 		goto err_unlock;
 	}
 
-	desc = dmaengine_prep_slave_single(chan, dst_addr, buf_info->size,
-					   DMA_DEV_TO_MEM,
-					   DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
+	desc = dmaengine_prep_config_single(chan, dst_addr, buf_info->size,
+					    DMA_DEV_TO_MEM,
+					    DMA_CTRL_ACK | DMA_PREP_INTERRUPT,
+					    &config);
 	if (!desc) {
 		dev_err(dev, "Failed to prepare DMA\n");
 		ret = -EIO;
@@ -399,12 +394,6 @@ static int pci_epf_mhi_edma_write(struct mhi_ep_cntrl *mhi_cntrl,
 	config.direction = DMA_MEM_TO_DEV;
 	config.dst_addr = buf_info->host_addr;
 
-	ret = dmaengine_slave_config(chan, &config);
-	if (ret) {
-		dev_err(dev, "Failed to configure DMA channel\n");
-		goto err_unlock;
-	}
-
 	src_addr = dma_map_single(dma_dev, buf_info->dev_addr, buf_info->size,
 				  DMA_TO_DEVICE);
 	ret = dma_mapping_error(dma_dev, src_addr);
@@ -413,9 +402,10 @@ static int pci_epf_mhi_edma_write(struct mhi_ep_cntrl *mhi_cntrl,
 		goto err_unlock;
 	}
 
-	desc = dmaengine_prep_slave_single(chan, src_addr, buf_info->size,
-					   DMA_MEM_TO_DEV,
-					   DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
+	desc = dmaengine_prep_config_single(chan, src_addr, buf_info->size,
+					    DMA_MEM_TO_DEV,
+					    DMA_CTRL_ACK | DMA_PREP_INTERRUPT,
+					    &config);
 	if (!desc) {
 		dev_err(dev, "Failed to prepare DMA\n");
 		ret = -EIO;
@@ -502,12 +492,6 @@ static int pci_epf_mhi_edma_read_async(struct mhi_ep_cntrl *mhi_cntrl,
 	config.direction = DMA_DEV_TO_MEM;
 	config.src_addr = buf_info->host_addr;
 
-	ret = dmaengine_slave_config(chan, &config);
-	if (ret) {
-		dev_err(dev, "Failed to configure DMA channel\n");
-		goto err_unlock;
-	}
-
 	dst_addr = dma_map_single(dma_dev, buf_info->dev_addr, buf_info->size,
 				  DMA_FROM_DEVICE);
 	ret = dma_mapping_error(dma_dev, dst_addr);
@@ -516,9 +500,10 @@ static int pci_epf_mhi_edma_read_async(struct mhi_ep_cntrl *mhi_cntrl,
 		goto err_unlock;
 	}
 
-	desc = dmaengine_prep_slave_single(chan, dst_addr, buf_info->size,
-					   DMA_DEV_TO_MEM,
-					   DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
+	desc = dmaengine_prep_config_single(chan, dst_addr, buf_info->size,
+					    DMA_DEV_TO_MEM,
+					    DMA_CTRL_ACK | DMA_PREP_INTERRUPT,
+					    &config);
 	if (!desc) {
 		dev_err(dev, "Failed to prepare DMA\n");
 		ret = -EIO;
@@ -581,12 +566,6 @@ static int pci_epf_mhi_edma_write_async(struct mhi_ep_cntrl *mhi_cntrl,
 	config.direction = DMA_MEM_TO_DEV;
 	config.dst_addr = buf_info->host_addr;
 
-	ret = dmaengine_slave_config(chan, &config);
-	if (ret) {
-		dev_err(dev, "Failed to configure DMA channel\n");
-		goto err_unlock;
-	}
-
 	src_addr = dma_map_single(dma_dev, buf_info->dev_addr, buf_info->size,
 				  DMA_TO_DEVICE);
 	ret = dma_mapping_error(dma_dev, src_addr);
@@ -595,9 +574,10 @@ static int pci_epf_mhi_edma_write_async(struct mhi_ep_cntrl *mhi_cntrl,
 		goto err_unlock;
 	}
 
-	desc = dmaengine_prep_slave_single(chan, src_addr, buf_info->size,
-					   DMA_MEM_TO_DEV,
-					   DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
+	desc = dmaengine_prep_config_single(chan, src_addr, buf_info->size,
+					    DMA_MEM_TO_DEV,
+					    DMA_CTRL_ACK | DMA_PREP_INTERRUPT,
+					    &config);
 	if (!desc) {
 		dev_err(dev, "Failed to prepare DMA\n");
 		ret = -EIO;

-- 
2.34.1


