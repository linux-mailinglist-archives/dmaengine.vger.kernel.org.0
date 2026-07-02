Return-Path: <dmaengine+bounces-11993-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id V/YQMDbXRmrVeQsAu9opvQ
	(envelope-from <dmaengine+bounces-11993-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 23:25:10 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B9F6FCEFD
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 23:25:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b="TNoQEis/";
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11993-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11993-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A93AF3093D39
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jul 2026 21:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02070318BB3;
	Thu,  2 Jul 2026 21:21:54 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012048.outbound.protection.outlook.com [52.101.66.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CFA33E36A;
	Thu,  2 Jul 2026 21:21:51 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783027313; cv=fail; b=pbFct1jyQbz6m/GDRTX+J9c/VB9EZHJHIqFnONEgKl5q5J2n+b6CG/uowuKqDHx0zPLmlcUDbPps9Ze4fT3kDcXmmZnYl5c36Oeu3zFsxHun8K6v/1c0ghq6CHmxUwrR9dwPW2h+vL8iim0snzQteHEvmUf+kEZKBm/eowDNxyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783027313; c=relaxed/simple;
	bh=bKSG4Sx+WFfLMa8BfJunNo6z6X9LsWXLzJ3cbi6EztM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Ww2+AlJk4G1bLtKpxMT5uwxxKfIP8Bn+ef6h/GKnVnuzJkmMrT5cuKxqUWWKMRiEqybOZ4hsIj6B2WqwBqPPrI2crbOPlfliTPuff+iMNiLKSQZfW32D/hbg11xYthq3zJ6mrZWU2iFI9RvzqEn1ZTzUsOv8PpcDUZLJ5THxNCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=TNoQEis/; arc=fail smtp.client-ip=52.101.66.48
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ua6wvrSIltrZoWNCxGZmyINBPPl9iYaaLK7F0FUr1r/G+x7JJcjRcb8I/wo3giTIq2URhGWlZaH/+Abg9kzRA67yCtRND/AnUfZNT1YVjhmpNKJeh9m8JOjO7wPpiRdTT//rGWgjL7y18QNR4DEGmvAkYXSWp/ztB+WDjvIkwE0AcNFHKw+0ONYQY5NYaC9UwaDN/2xU4fWFWQpIEJ0hLQ+jCNQB/8mK7IS/DcdnXCYFjTBh55+9Sqp6qxjDLRrLQKB74JIB71bxS2hrR/tTkaAfeAcItHS7f2eUWpIVKEVwc2ZGbGdJYH9VTXCJCEYM8/jt7DRtsyFc/ZpSWyCG3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+lHp5TOjFkSUA9zt4ON4C8fP/B+lDBX1t27ScOAtPwM=;
 b=QLNhSqWqC7yaRhHvcAM6Soz4WlzlNqXa5JhrQEkHmCekonCAlJfk7NPjFBtw9DL5oK4b6mt3enrnyBVuL1+5QJhZvqy19UdxYfMSsq8BAWNFmAlVQvJYjBkgDp4ihvuAQLXftKSzOqqdtTBcSlP6NjB1lGudx/Ddx1Z+vgw8FNavp8FjdCV5mr3yKZi5W/Wtxq+1uu8Sv8AOMDQRBsitNmmEQfrWLDhwjVLB4qbtEe4oY+DNhGNB6dm4BsciozEGuciFtGd1d4/9bLh5LL0Fs8BL10N6GoyvOVK96ijR/LBuzBDwS877wh2YV2LHCdDaCcmd8XyIW95qYu+9peKKig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+lHp5TOjFkSUA9zt4ON4C8fP/B+lDBX1t27ScOAtPwM=;
 b=TNoQEis/mejaumUvIggkcHoiJJe+uyelGnWflLcMgiwI/cydKDhr6CLffH+7PdjixWUvy2VWcB+0kfDqm1FkEj6Uuw/vovXAgJ9tGGP0ZhMIxqbzlKkOz0nkVpSgvi2NpQk2wvNQI946q74UxKUGDIO35Iy2Mp+iWk3JndFfnnTEyOcq7r3b5MEaGcvHwwTRKRpJRXImG2AHY8u2BMYKwO9AA4F/4nLmK2U4HYFXi0vFO7jRvevzWWVzR4UI2WVhpoU3BLEJnGSaSV2T719c0CRGqsorEURJF/i7i03Y450w7x7T3SrEnmJ+64jvt9GACadPi9f1bVE/sS2k2rnnCg==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GV1PR04MB9213.eurprd04.prod.outlook.com (2603:10a6:150:28::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Thu, 2 Jul
 2026 21:21:46 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Thu, 2 Jul 2026
 21:21:46 +0000
From: Frank.Li@oss.nxp.com
Date: Thu, 02 Jul 2026 17:21:23 -0400
Subject: [PATCH v3 03/10] dmaengine: dw-edma: Move ll_region from struct
 dw_edma_chunk to struct dw_edma_chan
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-edma_ll-v3-3-877aa463740c@nxp.com>
References: <20260702-edma_ll-v3-0-877aa463740c@nxp.com>
In-Reply-To: <20260702-edma_ll-v3-0-877aa463740c@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783027287; l=9053;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=ql5rhYlosKnMPGBhV2Jpc3WGz0nyLfE5uGZSsU93IBk=;
 b=T7YWSwH+jyb7LLsmVbxfejQJ3LvrMF0XlBtI3J42/1Llx704CKm5jZQMnuoyHoTF52tJjm/m9
 j+HaczyJqK/C38mkINnn6wz+RcIoiVI+zmCy1e3QGaCqOpM9NZcreVn
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA1P222CA0043.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::17) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GV1PR04MB9213:EE_
X-MS-Office365-Filtering-Correlation-Id: da31c1ac-2c6f-4992-6ec2-08ded87feba0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|19092799006|23010399003|11063799006|22082099003|56012099006|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	44oSNpgyJgyZdvYsen/dLymRAEE1sqK6h74S2mVWFuDCH89cn/WDTIbW0lnyalTmSIc7hG6lhY9j+iWJ7ZvppUS7hUUy75Kz+zJV5jAalSQhQH8icBVge90AAqZ5R/rayR8rl9oOrDfgMlVjHHl3kwHvSc3vqDICtkS0z9Lb3fmq/TPAFkQo5MY8K/5r7PRTW0b4zhgHf4hhyy62fuN4pBA4/3rhMw0F7YRvguBajaP9eaVIiuvzJuEJTZ9sa6hjsQN/N8HAfpyLJ8HhAWDBugbypJaAFwt4LHfWodHA4kOEp5ZTc0rj/FBCigKe4Sz5ikf73Pe/lUO/u4Y4EZJui0aUZfM21I4jzwWWp8Ci7/wxXwZnMJ1LoCx7dbesWb/9NapPaxSFljv5UD/pk9TnXDz4jiCPANVu3hJ/kWfEDHNkimo5MO9YbZweC/HGoKAf7V1Z6vtr+v2vGItSGEFngqp6Nm+B9wdcTJ+kYGJtMjQzxduplJJXpenw3D2xlBh8lWVq69c2gR3VgWWbQY/rF59i2HMNiwA+XEynaY2cjLF5CWIwrlNL0E5SrFET7wL1BOLiI1L74RhEc27/AK1n0Ls+riGE+C/IU4Lk3igYjlhIJsIqQcpquhBlSZ5MHr05X4PnsIGHbdlYjDZcWpytKESv9EkEse3t4gq8wKA2frvoxMQovDM0QloohVie5zKepwPjrZxSi47Dwcn1E7CA5Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(19092799006)(23010399003)(11063799006)(22082099003)(56012099006)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dFJOTUN1ZHM4WlJXcGlzWDZ6MUxUVFhuT3dYdU9ocUlETnNjdENLanZCQXJ5?=
 =?utf-8?B?UWM5Y1RNTXMvdGFGOGRmRWRLa3RVWmtuOXY2NlZObDB5bzNRRWh4clBJWWox?=
 =?utf-8?B?Y2hnTTNGVGp1S0NRRWdvWGVXcXJUVldwcEdndWJ2dlpPSlRNa3JsMlNJRGZs?=
 =?utf-8?B?WGVaQkIwM1FlQXE5bENEZkEwcEpKeDB3ZXBVckJmQzYzaXNHMVVUdnVTeWM4?=
 =?utf-8?B?a0RpRE5zZFZ4dkl3YjlRWjZNeklTOHhGNEFXWkhJbk1heEU5ZXd4STI5S3Ja?=
 =?utf-8?B?KzRoQ2dyNGphWU1LUWtkUnJOUUxEaThibjdPdEFtZy81aGZFM21CWUU2SE9R?=
 =?utf-8?B?TkRqeGZFalpzSURJblp2b0JKMit1RlNvdjh2Z3NtSm5jUkJKSlFDaHE4NUV5?=
 =?utf-8?B?ajg2eEIrWk9pSklJWFR0MmZyTEQvSzlIQkZSLzBuUnZ1aXNCK2dlWVc4S2c0?=
 =?utf-8?B?RGR0alUwSXcwT2FFU1NsNkd5Z01wL2JPUkFyUzcvazZkbFE1cWJxbUJ5NWk3?=
 =?utf-8?B?Y29CVkZ5MjNqTEFhbzc1N3BoVVoxWXU4YTYrc3Z4ZytPYVcrV2xuWm4wYmdy?=
 =?utf-8?B?YmhVQTBzbnZRNE5ld1NMWVhLalBlV3BJTXNxenJWY05TOTEybUFXUVFXZWJV?=
 =?utf-8?B?SjVsckpZVTJobm54WUliZUkxdDd4YkNYSGd3REtvTkN2TVczWEdJdjl6TzJE?=
 =?utf-8?B?d1FoMTUwR3d5MHB1VkpBekFISTdvWVF6ZGNMREZhUlZxTms1ZExpM0x6Rlhx?=
 =?utf-8?B?Z1NLTVBFY3hFRnRoYWRCOTdHRmRPVjhmUDlIYkMxYXpJWGxSN1dtS005U0J0?=
 =?utf-8?B?OGtHdVBNUEJ4U0dCSDFwdzl5UDNyc2FUV2pzWHVnK2EwOEs1OXJlQmxYblBI?=
 =?utf-8?B?S3VZUUNQU3JCM0RXT0w4RXV0R0pMSFlrUE9xTUxLM3AzNWMzOENpaDdQcVlp?=
 =?utf-8?B?Q3dQUzhaRDVMdFdiMFIrQmZyckRTWWsvdUIreG55S3J0TWlLSWlha1hybEtp?=
 =?utf-8?B?M2x6S0Z5djQ3RThIc0FpTUlXaFcxL1NyaG4vOWpEZGJhOUpIOEd1RGFqdUVZ?=
 =?utf-8?B?Y1VXZDltKzJtNjRjNkU3NnhWVXlIY3Foenl6ZUtHYUIyNktWaThvOW1yQ1Jt?=
 =?utf-8?B?bThIUEVLYTgyOG44NEV1RHIrdXIvZmhzcnFjNjcvM3pvYytqYzVyV1dNRlYr?=
 =?utf-8?B?V3ErUXd1clhrOGxmZ3lzYjg3M3RKVEp5SmlqRGNvTC9aeXY1KzQ4V1NmZFBZ?=
 =?utf-8?B?SHd2eFlJV0htZU1CWjJOYWp5RkE2OURxT0ZSL2grYk1WdkRqUzlwRjdHbjZV?=
 =?utf-8?B?U045aHdSbUFieitDN3o5c2NJSmxZZWZOenRVZGFHRlEzZXBKRnh0SmxQRlV0?=
 =?utf-8?B?NTNsZ1VpWUVOYlNhV0NVd0pUa282UFR4d213TGZHamdQQjFoVVJPeGtHUG9w?=
 =?utf-8?B?OWU2R29CemROaUNxZTVpSW9xMEh1YWU2eWxhZW1FVlJNZ1F4N0JGRjhoL2gr?=
 =?utf-8?B?Z2xYU05TUk4ycjQ0dk95RVNIeUtjcVkzOC82SzhVaWVDYTh3L3FoNjZjQ2Yr?=
 =?utf-8?B?QUZNWnROQTc4QVM3eTNxcktuQjF0OW9nTFB4MFZpMEdheVJ0aDM5SVJqY2cv?=
 =?utf-8?B?WnhtVkhNWHFYN0UxRXlLdGN5c2JDVjhDTStDRXZJc2xKbzhZeCtJZU05VWFw?=
 =?utf-8?B?YUU1NTVpa1hnUzBsU1o5OEtvOW95bFVRa1dKVmV0TTR0SGZPN2FPb3FoUWFa?=
 =?utf-8?B?bUM0Q1hIOTExVEE1QzBPRGRjVWxlSkk0ZDFHa0lnd1padFlZakhwTkhRLyti?=
 =?utf-8?B?V29sTnZaTWhzL2tXVU81aVVneDhvQjhRbTVtOXViWjBBN3RYZmdQT24zNEMy?=
 =?utf-8?B?ZHJmZDI0OUk1RnE0czFudmkveDF5TmJlbHZENVovUmVhTSs1dzZaTUk1TVFz?=
 =?utf-8?B?clZ5cWJnYUNqY2ZvYnR5UVV5WDFGOXEyc0x2K3ZyWVpqa3luYzBxSU05dlB2?=
 =?utf-8?B?TlhFNUtSTk4ra0RweGorVG96ejRxZFN2aS9HZXZucFBPQkhDUFUweHlSN2pK?=
 =?utf-8?B?aEVJNWFPc1ZKT0ZqSk5ycUJUWlUxM0VPQ2I1UG0vb0VHLzQzek9MVmNzK1Rh?=
 =?utf-8?B?Nzd3bkhjQXJzNkNiVURGVXg3emtyV3o4Q0U3SDZpK1MzZWlYN1o4cC8rN1J6?=
 =?utf-8?B?TTJFMytDT2FPZ3FYT1pCYTM1WVB4L2xHdDNZSEJOZzkxWkUwU1BuRnZvL1VH?=
 =?utf-8?B?N1poR1hVSWFGVnVBWStHZ1NjZVErMUdrVUZYYXFwZE9ZelNUdGh5bTlySFM5?=
 =?utf-8?B?eVM4SW03R281K05tUmNqZU1vaGt3TjdEVmRSU25qUGttLzV3anQwbHBRTDZO?=
 =?utf-8?Q?sIaA5h6n9NF5FXndCICteEq2OwbpRhSb3/OFj?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da31c1ac-2c6f-4992-6ec2-08ded87feba0
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 21:21:46.1218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L/f18dJlgIzJXwK8KwBaIkrlFRb/XfAGJaqtKM2elMafOmcJvrHo3aSm4KCeCcsTVyLfRu4pPsbCbZpVKiP4y66BT919TzrV6tNdB0M0aLdRC2Gvxa//soZ+drzR+QI1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9213
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11993-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,NXP1.onmicrosoft.com:dkim,nxp.com:mid,nxp.com:email,oss.nxp.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 18B9F6FCEFD

From: Frank Li <Frank.Li@nxp.com>

ll_region is identical for all chunks belonging to the same DMA channel,
so there is no need to copy it into each chunk. Move ll_region to
struct dw_edma_chan to avoid redundant copies.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/dw-edma/dw-edma-core.c    | 15 ++++-----------
 drivers/dma/dw-edma/dw-edma-core.h    |  2 +-
 drivers/dma/dw-edma/dw-edma-v0-core.c | 18 ++++++++++--------
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 18 ++++++++++--------
 4 files changed, 25 insertions(+), 28 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 53469c8c8b82e..2652ad8e7a8f6 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -64,7 +64,6 @@ static struct dw_edma_burst *dw_edma_alloc_burst(struct dw_edma_chunk *chunk)
 
 static struct dw_edma_chunk *dw_edma_alloc_chunk(struct dw_edma_desc *desc)
 {
-	struct dw_edma_chip *chip = desc->chan->dw->chip;
 	struct dw_edma_chan *chan = desc->chan;
 	struct dw_edma_chunk *chunk;
 
@@ -81,13 +80,6 @@ static struct dw_edma_chunk *dw_edma_alloc_chunk(struct dw_edma_desc *desc)
 	 *  - Even chunks originate CB equal to 1
 	 */
 	chunk->cb = !(desc->chunks_alloc % 2);
-	if (chan->dir == EDMA_DIR_WRITE) {
-		chunk->ll_region.paddr = chip->ll_region_wr[chan->id].paddr;
-		chunk->ll_region.vaddr = chip->ll_region_wr[chan->id].vaddr;
-	} else {
-		chunk->ll_region.paddr = chip->ll_region_rd[chan->id].paddr;
-		chunk->ll_region.vaddr = chip->ll_region_rd[chan->id].vaddr;
-	}
 
 	if (desc->chunk) {
 		/* Create and add new element into the linked list */
@@ -925,10 +917,11 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
 		chan->status = EDMA_ST_IDLE;
 
 		if (chan->dir == EDMA_DIR_WRITE)
-			chan->ll_max = (chip->ll_region_wr[chan->id].sz / EDMA_LL_SZ);
+			chan->ll_region = chip->ll_region_wr[chan->id];
 		else
-			chan->ll_max = (chip->ll_region_rd[chan->id].sz / EDMA_LL_SZ);
-		chan->ll_max -= 1;
+			chan->ll_region = chip->ll_region_rd[chan->id];
+
+		chan->ll_max = chan->ll_region.sz / EDMA_LL_SZ - 1;
 
 		dev_vdbg(dev, "L. List:\tChannel %s[%u] max_cnt=%u\n",
 			 str_write_read(chan->dir == EDMA_DIR_WRITE),
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index db5f45bf048c3..b96089baf0f9c 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -58,7 +58,6 @@ struct dw_edma_chunk {
 
 	u8				cb;
 	u32				xfer_sz;
-	struct dw_edma_region		ll_region;	/* Linked list */
 };
 
 struct dw_edma_desc {
@@ -79,6 +78,7 @@ struct dw_edma_chan {
 	enum dw_edma_dir		dir;
 
 	u32				ll_max;
+	struct dw_edma_region		ll_region;	/* Linked list */
 
 	struct msi_msg			msi;
 
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index ee5c3c317557b..51e50f1fdcac4 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -280,9 +280,10 @@ static void dw_edma_v0_write_ll_data(struct dw_edma_chunk *chunk, int i,
 				     u32 control, u32 size, u64 sar, u64 dar)
 {
 	ptrdiff_t ofs = i * sizeof(struct dw_edma_v0_lli);
+	struct dw_edma_chan *chan = chunk->chan;
 
 	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
-		struct dw_edma_v0_lli *lli = chunk->ll_region.vaddr.mem + ofs;
+		struct dw_edma_v0_lli *lli = chan->ll_region.vaddr.mem + ofs;
 
 		lli->transfer_size = size;
 		lli->sar.reg = sar;
@@ -290,7 +291,7 @@ static void dw_edma_v0_write_ll_data(struct dw_edma_chunk *chunk, int i,
 		dma_wmb();
 		lli->control = control;
 	} else {
-		struct dw_edma_v0_lli __iomem *lli = chunk->ll_region.vaddr.io + ofs;
+		struct dw_edma_v0_lli __iomem *lli = chan->ll_region.vaddr.io + ofs;
 
 		writel(size, &lli->transfer_size);
 		writeq(sar, &lli->sar.reg);
@@ -303,15 +304,16 @@ static void dw_edma_v0_write_ll_link(struct dw_edma_chunk *chunk,
 				     int i, u32 control, u64 pointer)
 {
 	ptrdiff_t ofs = i * sizeof(struct dw_edma_v0_lli);
+	struct dw_edma_chan *chan = chunk->chan;
 
 	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
-		struct dw_edma_v0_llp *llp = chunk->ll_region.vaddr.mem + ofs;
+		struct dw_edma_v0_llp *llp = chan->ll_region.vaddr.mem + ofs;
 
 		llp->llp.reg = pointer;
 		dma_wmb();
 		llp->control = control;
 	} else {
-		struct dw_edma_v0_llp __iomem *llp = chunk->ll_region.vaddr.io + ofs;
+		struct dw_edma_v0_llp __iomem *llp = chan->ll_region.vaddr.io + ofs;
 
 		writeq(pointer, &llp->llp.reg);
 		writel(control, &llp->control);
@@ -345,7 +347,7 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 	if (!chunk->cb)
 		control |= DW_EDMA_V0_CB;
 
-	dw_edma_v0_write_ll_link(chunk, i, control, chunk->ll_region.paddr);
+	dw_edma_v0_write_ll_link(chunk, i, control, chan->ll_region.paddr);
 }
 
 static void dw_edma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
@@ -359,7 +361,7 @@ static void dw_edma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
 	 * last MWr TLP is completed
 	 */
 	if (!(chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
-		readl(chunk->ll_region.vaddr.io);
+		readl(chunk->chan->ll_region.vaddr.io);
 }
 
 static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
@@ -430,9 +432,9 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 		/* Linked list */
 		/* llp is not aligned on 64bit -> keep 32bit accesses */
 		SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
-			  lower_32_bits(chunk->ll_region.paddr));
+			  lower_32_bits(chan->ll_region.paddr));
 		SET_CH_32(dw, chan->dir, chan->id, llp.msb,
-			  upper_32_bits(chunk->ll_region.paddr));
+			  upper_32_bits(chan->ll_region.paddr));
 	}
 
 	dw_edma_v0_sync_ll_data(chunk);
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 1201f1ab5f359..20089d57f8ab0 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -156,9 +156,10 @@ static void dw_hdma_v0_write_ll_data(struct dw_edma_chunk *chunk, int i,
 				     u32 control, u32 size, u64 sar, u64 dar)
 {
 	ptrdiff_t ofs = i * sizeof(struct dw_hdma_v0_lli);
+	struct dw_edma_chan *chan = chunk->chan;
 
 	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
-		struct dw_hdma_v0_lli *lli = chunk->ll_region.vaddr.mem + ofs;
+		struct dw_hdma_v0_lli *lli = chan->ll_region.vaddr.mem + ofs;
 
 		lli->transfer_size = size;
 		lli->sar.reg = sar;
@@ -166,7 +167,7 @@ static void dw_hdma_v0_write_ll_data(struct dw_edma_chunk *chunk, int i,
 		dma_wmb();
 		lli->control = control;
 	} else {
-		struct dw_hdma_v0_lli __iomem *lli = chunk->ll_region.vaddr.io + ofs;
+		struct dw_hdma_v0_lli __iomem *lli = chan->ll_region.vaddr.io + ofs;
 
 		writel(size, &lli->transfer_size);
 		writeq(sar, &lli->sar.reg);
@@ -179,15 +180,16 @@ static void dw_hdma_v0_write_ll_link(struct dw_edma_chunk *chunk,
 				     int i, u32 control, u64 pointer)
 {
 	ptrdiff_t ofs = i * sizeof(struct dw_hdma_v0_lli);
+	struct dw_edma_chan *chan = chunk->chan;
 
 	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
-		struct dw_hdma_v0_llp *llp = chunk->ll_region.vaddr.mem + ofs;
+		struct dw_hdma_v0_llp *llp = chan->ll_region.vaddr.mem + ofs;
 
 		llp->llp.reg = pointer;
 		dma_wmb();
 		llp->control = control;
 	} else {
-		struct dw_hdma_v0_llp __iomem *llp = chunk->ll_region.vaddr.io + ofs;
+		struct dw_hdma_v0_llp __iomem *llp = chan->ll_region.vaddr.io + ofs;
 
 		writeq(pointer, &llp->llp.reg);
 		writel(control, &llp->control);
@@ -210,7 +212,7 @@ static void dw_hdma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 	if (!chunk->cb)
 		control |= DW_HDMA_V0_CB;
 
-	dw_hdma_v0_write_ll_link(chunk, i, control, chunk->ll_region.paddr);
+	dw_hdma_v0_write_ll_link(chunk, i, control, chunk->chan->ll_region.paddr);
 }
 
 static void dw_hdma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
@@ -224,7 +226,7 @@ static void dw_hdma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
 	 * last MWr TLP is completed
 	 */
 	if (!(chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
-		readl(chunk->ll_region.vaddr.io);
+		readl(chunk->chan->ll_region.vaddr.io);
 }
 
 static void dw_hdma_v0_core_ll_start(struct dw_edma_chunk *chunk, bool first)
@@ -251,9 +253,9 @@ static void dw_hdma_v0_core_ll_start(struct dw_edma_chunk *chunk, bool first)
 		/* Linked list */
 		/* llp is not aligned on 64bit -> keep 32bit accesses */
 		SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
-			  lower_32_bits(chunk->ll_region.paddr));
+			  lower_32_bits(chan->ll_region.paddr));
 		SET_CH_32(dw, chan->dir, chan->id, llp.msb,
-			  upper_32_bits(chunk->ll_region.paddr));
+			  upper_32_bits(chan->ll_region.paddr));
 		/* Set consumer cycle */
 		SET_CH_32(dw, chan->dir, chan->id, cycle_sync,
 			HDMA_V0_CONSUMER_CYCLE_STAT | HDMA_V0_CONSUMER_CYCLE_BIT);

-- 
2.43.0


