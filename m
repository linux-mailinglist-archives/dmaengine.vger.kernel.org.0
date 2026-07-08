Return-Path: <dmaengine+bounces-12127-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ecr0FX+YTmrCQAIAu9opvQ
	(envelope-from <dmaengine+bounces-12127-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 20:35:43 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C72A17298B0
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 20:35:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=mAJ8nvjj;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12127-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-12127-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2BBE8303E2BC
	for <lists+dmaengine@lfdr.de>; Wed,  8 Jul 2026 18:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75F74C9018;
	Wed,  8 Jul 2026 18:35:21 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013007.outbound.protection.outlook.com [40.107.162.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143594C9005;
	Wed,  8 Jul 2026 18:35:19 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783535721; cv=fail; b=Whnb9E1myo/YPcBSie8WdoYAyo3K8gYlrV4dA0L3SolveXRXZcWmWINVidErvZAXI25/bziAMyV3f8ToCvEaagEOwDadGf75VEYPen2p7zCIiZIfag0RNgsYXIsYFZy2v9W1AJkTER/1UkEf55HBW4vJ4/s4umuxdBmSKAC+RVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783535721; c=relaxed/simple;
	bh=LEdJdCACevNrxSBUJ8meqngfIrqiHsc5sZQnnH3iNDc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ROQuOTFbUXgR5rRu1VxWRuW58/qwGKsy7WVP3lKuMDq/tUC2jYHSt/Iy1EqXEZPh/R/EzDoTStqs31dVyUF7NnfNHasd1zoJn/XtszCaZF8Y/WYjovD3rAuuCMiP36hPcSuKy65D4yYZP6tovUEJV10yzokL9V3CeG0STla0OFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=mAJ8nvjj; arc=fail smtp.client-ip=40.107.162.7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cBZWEKZHEXfSZddF36SXt5CgMPGfB/88pG2hu5IDrhQBqInJvECaPui+6Wi3LkvWpu9XtwUxY4Dut0ODasnSn45xnsEv/YQpJoXLQ/CNTv/W6vhKEx2H+cWSkER+ZUALfPxcC8mbfcIhZ/yzR2/5xzyzGZjVPRiGurBe0oC7Hk9xb/O3Z06sXDvOvzDK/9PQBKZ/2goXW2RFMfYwyYLDH6XZFayDBosNct5FNbns/PTBcKyyHE53cevDPyh+mc47FcpaaLy878mCZQ7VZuDXy14PqaORKJTIwwyx+H4Y0nHwOnXBLMCdWtJ1o/c9JfuTl9Nf1EFdHJUzb/Y0QzqGUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vdfg/n8nGgvFwcsy0j9MK+wCSiPdNNYD732a15idxaI=;
 b=KeUjTOC7yPdvmAJKNdOYKpp5zYYrI0BIVQAQDIz0Zz5ABnBlcafJPlQ1FIoB/w6o5xchxH+5eM5/3rxy0K5voQRMRCQhu9Ta3NiyYBQpigNx4thqmMA3QKRyyF8zIJuDsQn2Klq8NRth+9+tHfcc3VxVvt9xoAap/FWv9mromouCpVZz45qUaKhiGVclNKtwxwemkWJH5ohMI9u1c3R7uNeoKjdeNegbDuOtuCvwgG4ZTkeITJ9bUKOjmZr55+9bqQi20o5DmjbbTjhM78seLZtZVfay1Ti0ZZMAB7M1z0jXp6haIVVMNVNo8+xQBVYGNLQD83XNFrgDxn6q2YuHoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vdfg/n8nGgvFwcsy0j9MK+wCSiPdNNYD732a15idxaI=;
 b=mAJ8nvjj5984iCHGaZbt7gOjMs6BXs+F6/kyv/iaI0TlUbzCa31DRJzSl99WOVCFMyFcpcnJouvyrpO2GNFUyEcfg7dbucsiBL6wKIvc8iZAwFZEVCEDnuXnqG/Fz7yPdCRj+wTp2shJO7wprGQCgGi1hnYf7jetiiNIC2978gTsTdEN5mhbjEs6To+5JOzcUffqIuE9vzSjfZmorabeKbtoYYwJC1wceHCFSuva2uS5IFsNUOKkvCogqWMmYzn+V1uTDWhOqAril5ifR/nFABSvrZpeaI+OSihvCGl2uj3AVtPobab2MvhxhvjHrWHsXZYvguYKI0eNTfR/hTl0Ag==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GV2PR04MB11883.eurprd04.prod.outlook.com (2603:10a6:150:2f9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 8 Jul 2026
 18:35:16 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Wed, 8 Jul 2026
 18:35:16 +0000
From: Frank.Li@oss.nxp.com
Date: Wed, 08 Jul 2026 14:35:01 -0400
Subject: [PATCH v4 01/10] dmaengine: dw-edma: Move control field update of
 DMA link to the last step
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-edma_ll-v4-1-cc128f0afb61@nxp.com>
References: <20260708-edma_ll-v4-0-cc128f0afb61@nxp.com>
In-Reply-To: <20260708-edma_ll-v4-0-cc128f0afb61@nxp.com>
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
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783535707; l=3566;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=geWLY7+7Bq0r3OZ5EWJpTkJEDEWVSA01WcSxrlvbm7w=;
 b=wuoeWP5O2HWYsyQvjbhrN3A967djXYkb249hvdszMJT5z2Xd85u2A0iINFk+cugvQfDTp9wmn
 f/Q//kvjCsYAstwdw65O0TSFjpCTQGzfZLqpZCT4umW4Xp+JXBt3wzf
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SN7P220CA0005.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::10) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GV2PR04MB11883:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ead05d5-207f-423c-2c68-08dedd1fa7e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|23010399003|366016|1800799024|7416014|921020|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	4z9hq34aN1ldey789mDE9tSe9MM7bxClFrEmbhb7z6qyQMqotihDnHqbAqufiAX6hEy+bsU/rEenQpq4oLxaEJ4vyGmdNDYwD7400MV02qsXGwH+Q86cIIxyl/rfuiIYgyWjnmDQ1ZJXrbSzSru+qj1B9L8GvpkRaxy4ct/ZHdk1m02McvqhKYuHvihb7gr1+2zITuseb5K3UWS97xMP1+SHvpgMgDEvGGq+CGsxuH/bzcbrISHYTWeS90eCwpEbywnuZumRrkBZEVKJaEHGPDhkngPvdJI1eRloK3319HvyxAHsgdEx4ekk4qALgiEv/G090DFLMM+04IMbFCyEAbdj9Vm8Q1WyEGlhTogUHrlYYbvO7GcWk8Nvl1IEuh8ZFxIxlcErLutJl7oJoqb1z2k6f6+aVFY4UW6i/QkCfqWzXjlQo9GXMa2LOKbLrFKTEH36DiFXcO7VBdGOe3i4ZxN3syW4Wd++2/l8aX1pW0+bnXBBQX3FFrF/GQB6eXC3iBymwO1fZfK2rU5tTg9cVJdk3Lu8qAuKQtXIM/25+XRSMN0JnxTE1RBVztmPWp/v89fp75Sel1jl6exkBLbBE5CUM5oBhKyJUCXcr7VpiLe3oOWmwpBqbTk7xn2Bh0KvCDz02NmSd5RFaD1yhHhWqAPlSeNurLctenKKK/CPYembyXWD8xMg1JvtVJJK5lN4MXs4ImnJ1RB6P32e2wDYFw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(23010399003)(366016)(1800799024)(7416014)(921020)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QnVyd200Y0VmMHFvSVY1TWxDbCtjekJYcW1lSEhQRWR4RloxT0czdjVBSHgz?=
 =?utf-8?B?bDhyaXV1eUN3ZmRrcTI5ZktlTGRxenNGUzVSRXRYakFMRkU3SC91dWplNXBq?=
 =?utf-8?B?Z1Jod3pjOUpnZE1ZL0lrdHFXL1A4Tk80K1gvVzJCeXFWemxwZUJuNjVaTG40?=
 =?utf-8?B?UUhDcFhieEVlV1VXOUxScmlGS3FXMTY3VTc2YlZCblpWcmdnR3NieFVJbW9i?=
 =?utf-8?B?bW9RZTRWVVJCQ3NxUFZBQ3ZqWGNZZFR3cjlKampTNlpHLzhmNlVpeE41VUdQ?=
 =?utf-8?B?Yi9rYUN2M25KeUgrWDhUa0ZTa0dlR2dpVFJWL3BGelo1Nkc2ZktHamJoNzgx?=
 =?utf-8?B?THVCd2dSdkZLVHhpWWFiSW11Tmc5Q2p1dFJmbkhxekJ2MGVCQUJGWXBzdGE3?=
 =?utf-8?B?OWNXWUxBN0toMzl5Ky9lSDlWN0ZBaVBnR2RYbTQxSEM1NEs0UDVwbFRETU83?=
 =?utf-8?B?NE94ajdXMkVWQlVES0c1UzRJcElvWmhCazJGYmNTbDVvK0M2Tm5EanE3eFFW?=
 =?utf-8?B?Yk9YdHc1RTVjV2hOVlRrOGFzb1dKbFpyZ2c0TWxtNUxjaTRRWXRRZW14YTVq?=
 =?utf-8?B?MzZmT3JIUitvVUN0U2Q5bzllL1BMcnpVQjNHYU00L3d4bHg1aU9lNUgxODU3?=
 =?utf-8?B?anF0QmJiSVhoTTJuckxoTk00MlBnMWRDN1lBRk42K1REbi9Ha1NEelkxcXM0?=
 =?utf-8?B?UVlsS0hRVURXemYvRGhwUSszUWhieVRFTkgzMXAvRm8zcFBqVzNpdXJHU29p?=
 =?utf-8?B?TEoxSFNXRzVjQ3E4cWdOOVNES0FvZ1VkTEJBWnc3Snh6QnJSZCtyTWVvYVNK?=
 =?utf-8?B?c1F2aHR1RGJRZlpnQjJKWllFZHBjNUtkZFZKY2pzdm4vcTdzL1BLNitpU2Rl?=
 =?utf-8?B?VnNrQkxUMDlHc09WdGNJR1IySUNBdDdJeGJTYlFBK2lpTXd1ckQvNk13Q29B?=
 =?utf-8?B?UUtUNFNGQWpJREFYcUxNUWpjNDBuemduSy81MmJ1UGJBelBvdzBFTE5GMTAw?=
 =?utf-8?B?bVFUd0hQeUd5eDdTelhTdEVTWnBLOTBidEw2MHE0U1ovaTU3bEFVUDFZbXFo?=
 =?utf-8?B?a0FQbTlkdmVWQ1JaVUltanZNcDFKM2NlVk1mTi9pcFYvMEFnVjJHU0RBU052?=
 =?utf-8?B?aFVkTjlCaXRGbUhDSHdjTUpwSkxBaW9qSGI0dXlGTTJaWXVrLzI0cmN1Tkhm?=
 =?utf-8?B?bDJsU1ZNbCszWit1NmNvSzg4TExaVGlmWUZ6eUNnR1doQ2hDYWgzYkZSOGhY?=
 =?utf-8?B?MG55T3ZtMlVvQVc3SXRoUUx0RTNGWGxxWlNPa3liVmMwVXpoM0E1OE5MU2lt?=
 =?utf-8?B?UjMvS2VZRm9vY0t1SDMwdVVkRGFxNGQ2U0hCRmZNVWRJUzl0M3dnbnpNY3JY?=
 =?utf-8?B?eGs1dURMdlF5Y1ZaTCtDamdjVy83SDlsOS9IT2J2cU1pb3kvbHA2QU5tanJu?=
 =?utf-8?B?YmpzcGJMUmVLODVkdWFTajQwSitWWXA4WlhsT3p5dDdCamVZdmo3T1dBZnds?=
 =?utf-8?B?QUMrNW81clZLMHJzSW5KbXBOM3dDY0RmTEJiTW43OFJOSktYRWFDS0wvdUdD?=
 =?utf-8?B?czY3d09VT1JFWlltdkFrM3FoTXY0R2svUExFRUtKYVpwcU5ZZHh3L29WQjV3?=
 =?utf-8?B?dGdMWitoZlJlUGpjZTlYMHhNSUVOcXlNaVRuVFVwMGlkb0JFMG9ubHJYc0xD?=
 =?utf-8?B?clR6aDdWSG14UXdraStYMkFWaE9sWFlDRHFaVDlsL0xyTC9mWlJoN0ljeW12?=
 =?utf-8?B?QzlYNlhacy8zZTlza0JRa3IzVDhVdDJnRkJEUVlyUXNYT1VlNFpDVXBKRmlW?=
 =?utf-8?B?NGJGTSs4cWN0ZTZ3SEswSU9XT3lRSDVsUTJURjViVVhQWko4SklYS0R2U2ZW?=
 =?utf-8?B?UXQ5VzdsVVUzbXMxNkRlcXgvMkJyaUFJSG1IUGFLcEgxRjZ4cCszMEN4Mmgw?=
 =?utf-8?B?dEt0ZFRENy9RdGUyVWN4enE0ZjFWcmpzZjZBOHVWelFyNFJYZXF2YjJUQkxH?=
 =?utf-8?B?STRWZFd5L0Qxekd6bzhHSVBRenN4UlI1TmF5VW1weWhvM3RML0U0aG11cG1K?=
 =?utf-8?B?WG1aZnFiS3lQNU5XQnhkSzFPL2h3eHVzdGYrVy82VWN3aHJsdFl0aTk1Z2RC?=
 =?utf-8?B?bWZLbHZYMFdoejFOd0UwMU5kWUlMa1VodmVkOVJnOHUzTTkvcEQvWnBEMDln?=
 =?utf-8?B?bTh4THdObEh1QnpYNk1zRHR4eUc4ek9LdTF2dnByVE1jdkdUeGFxUHNETWJD?=
 =?utf-8?B?NkFRajdwWC9oWW1lalMrdDVMbXF6d281TFJ3VjRnMjNKeVBwS2gwWjNrTElq?=
 =?utf-8?B?UDBkT0tVOEl1UUdSSDBiRnpBdWovRkxZRllENVFNeCsybm5WRGpJRW85b25L?=
 =?utf-8?Q?MyLNVv6f4ADfd7I6Sg7lBs2EwD121A77PtIMT?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ead05d5-207f-423c-2c68-08dedd1fa7e2
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 18:35:16.5783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l/eyzPonTIDuz0lA8+BpRZ4XUNaIFa48a0CXNeS3g2B7DzeQt2pg3qPB49IhZRzeiKvw5M+HDoQeWl/LFr5kYEpJJ2nWDi8vgl48sRZbZ44RfWtaQrV1dsMULWK7RKUs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11883
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12127-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mani@kernel.org,m:vkoul@kernel.org,m:Gustavo.Pimentel@synopsys.com,m:kees@kernel.org,m:gustavoars@kernel.org,m:kwilczynski@kernel.org,m:kishon@kernel.org,m:bhelgaas@google.com,m:hch@lst.de,m:cassel@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-hardening@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:den@valinux.co.jp,m:imx@lists.linux.dev,m:devverma@amd.com,m:Frank.Li@nxp.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:mid,nxp.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,valinux.co.jp:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C72A17298B0

From: Frank Li <Frank.Li@nxp.com>

The control field in a DMA link list entry must be updated as the final
step because it includes the CB bit, which indicates whether the entry is
ready. Add dma_wmb() to ensure the correct memory write ordering.

Currently the driver does not update DMA link entries while the DMA is
running, so no visible failure occurs. However, fixing the ordering now
prepares the driver for supporting link entry updates during DMA operation.

Tested-by: Koichiro Den <den@valinux.co.jp>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v4
- add Koichiro's tags
---
 drivers/dma/dw-edma/dw-edma-v0-core.c | 10 ++++++----
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 10 ++++++----
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index cfdd6463252e6..ee5c3c317557b 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -284,17 +284,18 @@ static void dw_edma_v0_write_ll_data(struct dw_edma_chunk *chunk, int i,
 	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
 		struct dw_edma_v0_lli *lli = chunk->ll_region.vaddr.mem + ofs;
 
-		lli->control = control;
 		lli->transfer_size = size;
 		lli->sar.reg = sar;
 		lli->dar.reg = dar;
+		dma_wmb();
+		lli->control = control;
 	} else {
 		struct dw_edma_v0_lli __iomem *lli = chunk->ll_region.vaddr.io + ofs;
 
-		writel(control, &lli->control);
 		writel(size, &lli->transfer_size);
 		writeq(sar, &lli->sar.reg);
 		writeq(dar, &lli->dar.reg);
+		writel(control, &lli->control);
 	}
 }
 
@@ -306,13 +307,14 @@ static void dw_edma_v0_write_ll_link(struct dw_edma_chunk *chunk,
 	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
 		struct dw_edma_v0_llp *llp = chunk->ll_region.vaddr.mem + ofs;
 
-		llp->control = control;
 		llp->llp.reg = pointer;
+		dma_wmb();
+		llp->control = control;
 	} else {
 		struct dw_edma_v0_llp __iomem *llp = chunk->ll_region.vaddr.io + ofs;
 
-		writel(control, &llp->control);
 		writeq(pointer, &llp->llp.reg);
+		writel(control, &llp->control);
 	}
 }
 
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 632abb8b481cf..1201f1ab5f359 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -160,17 +160,18 @@ static void dw_hdma_v0_write_ll_data(struct dw_edma_chunk *chunk, int i,
 	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
 		struct dw_hdma_v0_lli *lli = chunk->ll_region.vaddr.mem + ofs;
 
-		lli->control = control;
 		lli->transfer_size = size;
 		lli->sar.reg = sar;
 		lli->dar.reg = dar;
+		dma_wmb();
+		lli->control = control;
 	} else {
 		struct dw_hdma_v0_lli __iomem *lli = chunk->ll_region.vaddr.io + ofs;
 
-		writel(control, &lli->control);
 		writel(size, &lli->transfer_size);
 		writeq(sar, &lli->sar.reg);
 		writeq(dar, &lli->dar.reg);
+		writel(control, &lli->control);
 	}
 }
 
@@ -182,13 +183,14 @@ static void dw_hdma_v0_write_ll_link(struct dw_edma_chunk *chunk,
 	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
 		struct dw_hdma_v0_llp *llp = chunk->ll_region.vaddr.mem + ofs;
 
-		llp->control = control;
 		llp->llp.reg = pointer;
+		dma_wmb();
+		llp->control = control;
 	} else {
 		struct dw_hdma_v0_llp __iomem *llp = chunk->ll_region.vaddr.io + ofs;
 
-		writel(control, &llp->control);
 		writeq(pointer, &llp->llp.reg);
+		writel(control, &llp->control);
 	}
 }
 

-- 
2.43.0


