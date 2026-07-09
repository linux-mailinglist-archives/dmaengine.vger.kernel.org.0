Return-Path: <dmaengine+bounces-12244-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vbTnOeG/T2oxnwIAu9opvQ
	(envelope-from <dmaengine+bounces-12244-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 17:36:01 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E212732FA6
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 17:36:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b="RWwqE/Hy";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12244-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-12244-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1DE67306C4A0
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 15:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3891427A06;
	Thu,  9 Jul 2026 15:34:13 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011019.outbound.protection.outlook.com [40.107.130.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213C3426ED6;
	Thu,  9 Jul 2026 15:34:11 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783611253; cv=fail; b=BORNDAqz1Qt9TBbjfrwbPA0SU6W5tIbOM8ARuEbx3Gv3kIQBI37mYHYHDp3vgbeA+M9pyHDWAbgN5EkO003HQexSe7rY+ooqRvd3ftH6bM++DPM81ZwNLHHiTXROWE03yWwCXuS2VRrYc8r+qkdmZPdlgdZEuEtwO4UcSEe7voI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783611253; c=relaxed/simple;
	bh=63u36oIWW499CxCVD3CUgF2pj86oGpHE6a4veN4CLu4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=FBMrm8TaXm8YpoGST0uhzDnCvY/BiW9yk00hSTloFEfACZIFTBwnHDoJdlssON/QdqstPxF5sg8cvG5fTNkH2W7hx6yHQNBjOvNmy9322v4xrs+qfYJTrNwF2z33hlYMl9pNkoWVjKSCcdoUPKD9KZAuMzXcoe17dTQpZHmbQac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=RWwqE/Hy; arc=fail smtp.client-ip=40.107.130.19
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d3QGNEBl2F1z2wqwf6Ku6mBE/WyiONznri+vlqry1zEuzqJn7ZbwRjEwytfMNJ9Gl86nmnLMKN4ONwhHQf1Ktdvl+s+bjR1q1f67r5en0UZ5FeigTJlg2gVtUoVwE/2svwKpRaFF3oAgLgD8WJAP+Gpt0LNTCM8QtYLfw/ysmFCru9kyBEVeJkh37hiWXaeBX3lIpknQtzkRp2g6xIf5z79LB/jPVqtHNgQNdP5OvCMTu52Zog9ojtwTFRttpgz8HH9hbPfJawIrJZKBNdVTE8MzNbCSkfzvLdL/dm9ohqx/CiwxstwxhlzdvlXngR7ju3IYKrL8+62D7dgMqYlOEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oxheSaLiwGk/Z55GRV8TcDjvGiFBVTuuLT0jCpc35Iw=;
 b=DmdGFezrhGJ3n8HxlTztyHwovUQu0+aSQv3xd6U0mUUeBYWS5myV1+NgAJ9cATab2MUEqu7lPHvpCa7iMZ2cGE1idubuD4NT6m/y+USeHMEmfVz9T1aFnzcdO8cFKhqnfi7W+JYXNdSoQsstTfYC9aDaG8PTDDfKff1Bu629MFJzGEeZPG3hrm6EC6Y/tW4HDnVKwL5Hk2n3s/kYyvfX56rdVjvEztMwxvSTwNFDaE+EKLZC+V311kGExLP9WX1RsGwiJ20+7+SQEW9mPDAaPl6jIOzPn9+Xu9e68+gLq+uBArZgGHlyfGdGy5NSLQc/mf6NuOdUpFlLxgdp3bNhBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oxheSaLiwGk/Z55GRV8TcDjvGiFBVTuuLT0jCpc35Iw=;
 b=RWwqE/HyBYwu7/iM0dPIV8sXTg2aO2q+UASn7MgqNkzpQA9tXU4SqxtT7WbqBCIrAS9osLBmonBcSM2WIP8OnZXnXojPzL2XuPAT4mNcJSAyRAkE1WR6/rvTdgzLKXMQWfA0YY0MveGEkiyZnBYNuWakufJxQkBnb3IisWO411RqO7RhTbGywsosww+oe2DMa6s7qYoHKhwFi5SOsVe6+b07GCFnYfZxiUrmuFJNB1rMvAu6Kqbv9qAjpEqPcbNMDJOJVlSxojlDeDXDZd2+6de8eC5ioAgGtMLoCGR8poJis370YnY/t9N9KWjmi4WvMoMQT9mBuu1oNaCRcfwIZw==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DU0PR04MB9466.eurprd04.prod.outlook.com (2603:10a6:10:35a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 15:34:07 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Thu, 9 Jul 2026
 15:34:07 +0000
From: Frank.Li@oss.nxp.com
Date: Thu, 09 Jul 2026 11:33:35 -0400
Subject: [PATCH v5 06/10] dmaengine: dw-edma: Add callbacks to fill link
 list entries
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-edma_ll-v5-6-e199053d4300@nxp.com>
References: <20260709-edma_ll-v5-0-e199053d4300@nxp.com>
In-Reply-To: <20260709-edma_ll-v5-0-e199053d4300@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783611213; l=6410;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=nGpsMS8wEDHjpy4/wW160YouUvzq4Rld0wqWY/q9z50=;
 b=HBYA0dZ1DlJXh1ykyFuSlPiQLREiNWh0oUJLJqGo95GLyV0paB5bibjLs+RoZvFHhF9mNfTay
 x3ju758wEodDM/giTjVgZoF+KP1ozziva9G0vhtZ4I/D6+gTghZGrVy
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SN7P222CA0025.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::35) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DU0PR04MB9466:EE_
X-MS-Office365-Filtering-Correlation-Id: a392e924-0e70-4b51-eb84-08deddcf83dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|19092799006|366016|1800799024|7416014|376014|56012099006|11063799006|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	+Q6v+GwNdFxbpa1dIAU9NN4tEC0uwWiVUG0nOU0cM/G1SYvcKGb0s2iO95NgHGmvVdF8Koh/zkNwnImelWKbPT6js2zwon/Th5kpMkkypTXAe1zihtW85YlTxuV1YIvrEpe8tg9l+zVDPoAHg0B05x4R3pQkBBUl8ddvUarcw+bzC2W3bgvhi5aTTp2D0hFwc1FMz3A+sEbn48dSykcYzcOj36ICWc4UGqTDDBMowIFAeXPCy02IsGGPDOOVCOZRGB0BrncXbeYJo6u0agZYhefBqiMO+/oC87et8CmOlvsnzRUqz6TTXOUH+I72LUZOhIqZSloQyvuald/2C+6mWhNyxmNrzlvbzVRK5+a4M58Acc+lPcd+tUy8DwH8thZqeu1M643+xHLmxj6mzvJJ22gbPeNbK9jVuaiGCwMsfLV3mYuEqMwl92+jPiWLpAQsq4wCslZK/cmEPcqkTqZqJ0d1uSN54u5AY530M30rYlt77UTVoUwBGpF8KugCUZJkUqtJpA37sD4JzDK/yQ02pV5kIB+7zf92jyVfLNWgW5ZMoND6oZA2cOZBnwgt9Z4RzLhuf8HBtUtANQfxPOpftUWPRaULSQ/FgjWpF6Q8hBf0zkFUXOtboVJGOywEKv0sFgcIe2CKSZQF4rqcutpNchqO9/PvzsGGuD5/24Uv4Vc0aFILIP/0PQjUua9gzIy115JQOWhbL5uprtvs00XFUQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(366016)(1800799024)(7416014)(376014)(56012099006)(11063799006)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VjU2bDgveU5zQ3RkbnRodSsxTUY4a1BOU1QvSjNSYk5sTEttY1RiRC93bTBY?=
 =?utf-8?B?eTZ3TFQ1bTVESmJUdXdCSm9TbHh5YjBNWFdzQWdNZFZ4S3lYbXAwaFNZYkhT?=
 =?utf-8?B?bXE2czFpOFFrT0FwU2MrWWFXZElTWXJ2S3crdmpzUnNoSFc3WDVoUzVlQ29O?=
 =?utf-8?B?dm9JRlRsbDNzVmpEcU1RUkZrK21ibDJPWCtNRzdZVzJIWDBwYlp2emhyeGo4?=
 =?utf-8?B?Sm1GZldGdUtSS1hQM3dlanNxYVB6eW5IazBJa3Q1a3ZVUXdWNmRPcU1EZ0RQ?=
 =?utf-8?B?K2x3ZVdwZU43MFhua2pYTU01dUkrdzQ1ZGh3Qm96djgyckdBQkphRmVIQlJw?=
 =?utf-8?B?VXNLd1ZMdzNJMFhWYlBMOGpLaDg4U0xMVXlFR3BydXNXRVZBWmZ3ZDluajZm?=
 =?utf-8?B?bExpeVU0dkVMdDA2Mkh6d204MElYRUd6QmpZVXhFVDdhZkQ2aUFueWIrNjBp?=
 =?utf-8?B?QUF6RzFNdWxYUlF4YTJYY1RLdkhTU1lLZWxGUlArKzRsd0xIbWJsZjlDd25T?=
 =?utf-8?B?aHlMTnlwTTRnWUdRNFJmSW9GUHdFZE0vLzFSV1A4cnprQ1lJOWRacGFIRlky?=
 =?utf-8?B?NUtoZGdEMG9lb2ZXelE4QTlsSm5ybk1LcCtwa05Fbm9iSS9DeEEvZHZhMjJx?=
 =?utf-8?B?cEdmRm85T2x1c0krRTVRKzJPR2UyUEJUNGg1VnFDSUZsN2tWbVoyemR1Q1Nj?=
 =?utf-8?B?UVd0OWw3QTJWTXQrSkNUbzBwYmh3OFl0RFZONHdxSEgwV3NIaUEzQVpRZ2Rn?=
 =?utf-8?B?Mjl3WG9XWTJKd2VEM3U0K3hsaHRKSEM5ZklYYzlwZDFlY1lIRTJicDZqQjNY?=
 =?utf-8?B?Zkh6WldVdldaN3Q3R1dYSWM4cHBDMitQc3lOVDkyNXJoWEFOWTkxbkVLVmR2?=
 =?utf-8?B?TTVSUENzbVJWMUZjUmk1N2VtVUpmTklKOEJaM0hmTzBvY1UrVDRsKzJScVNB?=
 =?utf-8?B?L1pJSXVLOC8rRzNVUlJyT3RRWmM0eUErZmZ4MUVJVWJpUjRSZlJ0TVBKbEVC?=
 =?utf-8?B?R1ZhREhUR0dkZjloT1FTSzJQc012SjNLbHUwMWM3QjdMdnBNdWw3cUs3Y2U5?=
 =?utf-8?B?SUlQTXNxQ1NLUms1Z3ltN2p5VkV2WU5rZ0VsR0NsYTlCc0ZxcUhEK29lYzJa?=
 =?utf-8?B?c2kyUHZkYWdjUmd5YU5VUUtIdVNpSHVaQXBiNk9OMVp0TWVCcFBuSVBvcStj?=
 =?utf-8?B?NS9DMFo1S0FscVJGdm1IWFB3ZVRmMUZQS3FKVXBsd2doL1BsRFVCdkZ4TG9I?=
 =?utf-8?B?MnE1STA3QWhwZ2ZDc1JxelBFclRvNG9ZdGJsTFUvUU14WVdPZEVFVUZQYXVY?=
 =?utf-8?B?N3FuK1hWSkhjZEIvUXBROENCYnQ0MklHaXN4SUZsWEhuYmJRdVB5UTFZdlUv?=
 =?utf-8?B?eDgrQTFUSkFyNlNxWXhxNGhoc2wvVWhOTjMrcVlIUGxFSllydS9kb3EwYVVn?=
 =?utf-8?B?UHJrTHkwSlUwYVNwVGxmWkdUVDBTN0NZNzJvbEZxNWNwbTl2cWRHUDEyckFU?=
 =?utf-8?B?bWcvOXlCN2Q3VWsxV3UySUFianE5Q2JqN3JYYWZxZm1QODRyajhzbFAxbHli?=
 =?utf-8?B?WGhLYllDSTJWR2RwNWxnckd4eGRDMlMwdWIwSkdRQUUwR0lpdmN0NWFtVGJB?=
 =?utf-8?B?UU5VR3RXN0VWRWJPZndIdEo3S2tKQkFkc05OcXhCeXQxc2ZXZFJtd1d1eGpO?=
 =?utf-8?B?RDZ4NzFRZGpwemE0QmQrMWY0Zld5VnpMN0Jac0QxTHdMY3F3ZHhGVFhxdmhS?=
 =?utf-8?B?bDZlQ0FuOVY4SURyR2t3L0pIQjdiYWZZTmRWM3FlNzR0T09NTmZpT3BpRjVs?=
 =?utf-8?B?OEExTHBIUkVvWW9TOVlXdUliQWMvcTBvdWoxdStoOWxhb0lyelE0RythSUFO?=
 =?utf-8?B?RktWQUlCOTgvWDBCOU1BU0I3d1NMc3cvZ3BxaWFoamFqcUF0OURFWnpZTXJT?=
 =?utf-8?B?V1pRbk5MUXpqUnJOWlNqVEZCUURMUVZoQ1pWK000WDN5S0JHcUhkTEZ5Nlhx?=
 =?utf-8?B?TGJrbXJxbWc4NURDMHA2SG5UeXhpcUhiUG1ZU3VDRzh5bzgyVlZFenhBMGtK?=
 =?utf-8?B?UlRmMFlleS9GVi9WNFROSm1BWUdtWVRRWFlSb3RvV3lCTGtiQlBWZktvS0J1?=
 =?utf-8?B?MjUxeFdlenBVNzk1RVFOTy94SGptbi9tSGdOcEIwMy80RWtoVWlvSVpKdHdZ?=
 =?utf-8?B?UkhWWnJERFVRRnc2TXd3VkRnTWg1dzJqNGlESmRmMSt3ZS9xQUJiUXFHeVpw?=
 =?utf-8?B?akFKV2Q2a1o3M3Bndm92aXZPNEpOVU9YMktUSEJoN3RVMnk5SmFOb1BLTWt3?=
 =?utf-8?B?Y3V3Ly93Nk83YTZCS1VvaG1GTkZFSytwWGRRUHA2K2tNYnFzRHRub0tlYTMv?=
 =?utf-8?Q?LPCbVlwQtQJMCTzyWmQKaOEanetIqTTFkw5Zd?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a392e924-0e70-4b51-eb84-08deddcf83dc
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 15:34:07.5121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n0UJM+ZBza3+HOkWOpTM+3cz7M+7byoYSnVUkIg6sLlozsvGs0xjbTxlYoaHHYQNZEhIS8uo6LT/JEu7OcKislM2bHs8bQ8icr0IqfYZQ8om3fTbRoSolM30Lf5+Tx8A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9466
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12244-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[NXP1.onmicrosoft.com:dkim,valinux.co.jp:email,oss.nxp.com:from_mime,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:mid,nxp.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6E212732FA6

From: Frank Li <Frank.Li@nxp.com>

Introduce four new callbacks to fill link list entries in preparation for
replacing dw_(edma|hdma)_v0_core_start().

Filling link list entries is expected to become more complex, and without
this abstraction both eDMA and HDMA paths would need to duplicate the same
logic. Add fill-entry callbacks so the code can be shared cleanly between
eDMA and HDMA implementations.

Tested-by: Koichiro Den <den@valinux.co.jp>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change in v4
- use argument in dw_(hdma|edma)_v0_core_ll_link(addr) to set link to addr
report by sashiko
- Add Koichiro tested by tags

change in v2
- update commit message
- use eDMA and HDMI
- keep inline to avoid build warnings. dw-edma-v0-core.c also include
dw-edma-core.h
---
 drivers/dma/dw-edma/dw-edma-core.h    | 29 ++++++++++++++++++++++
 drivers/dma/dw-edma/dw-edma-v0-core.c | 46 +++++++++++++++++++++++++++++++++++
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 38 +++++++++++++++++++++++++++++
 3 files changed, 113 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index b96089baf0f9c..bab4d49c92feb 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -126,6 +126,12 @@ struct dw_edma_core_ops {
 	irqreturn_t (*handle_int)(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 				  dw_edma_handler_t done, dw_edma_handler_t abort);
 	void (*start)(struct dw_edma_chunk *chunk, bool first);
+	void (*ll_data)(struct dw_edma_chan *chan, struct dw_edma_burst *burst,
+			u32 idx, bool cb, bool irq);
+	void (*ll_link)(struct dw_edma_chan *chan, u32 idx, bool cb, u64 addr);
+	void (*ch_doorbell)(struct dw_edma_chan *chan);
+	void (*ch_enable)(struct dw_edma_chan *chan);
+
 	void (*ch_config)(struct dw_edma_chan *chan);
 	void (*debugfs_on)(struct dw_edma *dw);
 	void (*ack_emulated_irq)(struct dw_edma *dw);
@@ -204,6 +210,29 @@ void dw_edma_core_ch_config(struct dw_edma_chan *chan)
 	chan->dw->core->ch_config(chan);
 }
 
+static inline void
+dw_edma_core_ll_data(struct dw_edma_chan *chan, struct dw_edma_burst *burst,
+		     u32 idx, bool cb, bool irq)
+{
+	chan->dw->core->ll_data(chan, burst, idx, cb, irq);
+}
+
+static inline void
+dw_edma_core_ll_link(struct dw_edma_chan *chan, u32 idx, bool cb, u64 addr)
+{
+	chan->dw->core->ll_link(chan, idx, cb, addr);
+}
+
+static inline void dw_edma_core_ch_doorbell(struct dw_edma_chan *chan)
+{
+	chan->dw->core->ch_doorbell(chan);
+}
+
+static inline void dw_edma_core_ch_enable(struct dw_edma_chan *chan)
+{
+	chan->dw->core->ch_enable(chan);
+}
+
 static inline
 void dw_edma_core_debugfs_on(struct dw_edma *dw)
 {
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index 8d38867cd9983..c0746e5351410 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -509,6 +509,48 @@ static void dw_edma_v0_core_ch_config(struct dw_edma_chan *chan)
 	}
 }
 
+static void
+dw_edma_v0_core_ll_data(struct dw_edma_chan *chan, struct dw_edma_burst *burst,
+			u32 idx, bool cb, bool irq)
+{
+	u32 control = 0;
+
+	if (cb)
+		control |= DW_EDMA_V0_CB;
+
+	if (irq) {
+		control |= DW_EDMA_V0_LIE;
+
+		if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
+			control |= DW_EDMA_V0_RIE;
+	}
+
+	dw_edma_v0_write_ll_data(chan, idx, control, burst->sz, burst->sar,
+				 burst->dar);
+}
+
+static void
+dw_edma_v0_core_ll_link(struct dw_edma_chan *chan, u32 idx, bool cb, u64 addr)
+{
+	u32 control = DW_EDMA_V0_LLP | DW_EDMA_V0_TCB;
+
+	if (!cb)
+		control |= DW_EDMA_V0_CB;
+
+	dw_edma_v0_write_ll_link(chan, idx, control, addr);
+}
+
+static void dw_edma_v0_core_ch_doorbell(struct dw_edma_chan *chan)
+{
+	struct dw_edma *dw = chan->dw;
+
+	dw_edma_v0_sync_ll_data(chan);
+
+	/* Doorbell */
+	SET_RW_32(dw, chan->dir, doorbell,
+		  FIELD_PREP(EDMA_V0_DOORBELL_CH_MASK, chan->id));
+}
+
 /* eDMA debugfs callbacks */
 static void dw_edma_v0_core_debugfs_on(struct dw_edma *dw)
 {
@@ -540,6 +582,10 @@ static const struct dw_edma_core_ops dw_edma_v0_core = {
 	.ch_status = dw_edma_v0_core_ch_status,
 	.handle_int = dw_edma_v0_core_handle_int,
 	.start = dw_edma_v0_core_start,
+	.ll_data = dw_edma_v0_core_ll_data,
+	.ll_link = dw_edma_v0_core_ll_link,
+	.ch_doorbell = dw_edma_v0_core_ch_doorbell,
+	.ch_enable = dw_edma_v0_core_ch_enable,
 	.ch_config = dw_edma_v0_core_ch_config,
 	.debugfs_on = dw_edma_v0_core_debugfs_on,
 	.ack_emulated_irq = dw_edma_v0_core_ack_emulated_irq,
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 31bbdc6a40642..16fe3ef43948d 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -348,6 +348,40 @@ static void dw_hdma_v0_core_ch_config(struct dw_edma_chan *chan)
 	SET_CH_32(dw, chan->dir, chan->id, msi_msgdata, chan->msi.data);
 }
 
+static void
+dw_hdma_v0_core_ll_data(struct dw_edma_chan *chan, struct dw_edma_burst *burst,
+			u32 idx, bool cb, bool irq)
+{
+	u32 control = 0;
+
+	if (cb)
+		control |= DW_HDMA_V0_CB;
+
+	dw_hdma_v0_write_ll_data(chan, idx, control, burst->sz, burst->sar,
+				 burst->dar);
+}
+
+static void
+dw_hdma_v0_core_ll_link(struct dw_edma_chan *chan, u32 idx, bool cb, u64 addr)
+{
+	u32 control = DW_HDMA_V0_LLP | DW_HDMA_V0_TCB;
+
+	if (!cb)
+		control |= DW_HDMA_V0_CB;
+
+	dw_hdma_v0_write_ll_link(chan, idx, control, addr);
+}
+
+static void dw_hdma_v0_core_ch_doorbell(struct dw_edma_chan *chan)
+{
+	struct dw_edma *dw = chan->dw;
+
+	dw_hdma_v0_sync_ll_data(chan);
+
+	/* Doorbell */
+	SET_CH_32(dw, chan->dir, chan->id, doorbell, HDMA_V0_DOORBELL_START);
+}
+
 /* HDMA debugfs callbacks */
 static void dw_hdma_v0_core_debugfs_on(struct dw_edma *dw)
 {
@@ -366,6 +400,10 @@ static const struct dw_edma_core_ops dw_hdma_v0_core = {
 	.ch_status = dw_hdma_v0_core_ch_status,
 	.handle_int = dw_hdma_v0_core_handle_int,
 	.start = dw_hdma_v0_core_start,
+	.ll_data = dw_hdma_v0_core_ll_data,
+	.ll_link = dw_hdma_v0_core_ll_link,
+	.ch_doorbell = dw_hdma_v0_core_ch_doorbell,
+	.ch_enable = dw_hdma_v0_core_ch_enable,
 	.ch_config = dw_hdma_v0_core_ch_config,
 	.debugfs_on = dw_hdma_v0_core_debugfs_on,
 	.db_offset = dw_hdma_v0_core_db_offset,

-- 
2.43.0


