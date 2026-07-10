Return-Path: <dmaengine+bounces-12330-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VlBHBOgjUWqY/wIAu9opvQ
	(envelope-from <dmaengine+bounces-12330-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 18:55:04 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EADB773CCB5
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 18:55:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=lNKBwFyk;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12330-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12330-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0845D3001F80
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 16:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0380B47A0C0;
	Fri, 10 Jul 2026 16:48:41 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011070.outbound.protection.outlook.com [52.101.70.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B02A47A0A9;
	Fri, 10 Jul 2026 16:48:39 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783702120; cv=fail; b=EZJKLpAKLYQHh48Th7P3Q9I+ax14221gIL1rNU21fCPFzS72oOJD0A6liZ2eoU73sghAAUrysSVyTRXL0XGGz5ik67aaeZmdjvdV9/iDeqOIOxiSnYrorpAA8zcMsqtFbpL6fS/lnaJZU0/SCXDeJPi9W73ehw2WbB8cFPXDO70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783702120; c=relaxed/simple;
	bh=ZGipr494m0d1oF5X8IqRV2atoMwFfHeL5ZqNIrXGVT4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=FU8QIxUjMWgsa2BuaRUhB4QD/FLN6a4PQeHp4Qkf86NS9IurDJ9jgw/WxI6aiug3vyZRlN95Is+LONygiMgKb2Q5SW1uYap2jtkfEv6qFhw+Css01h4QyXE9IDI2zceq9hkQIWcDP0CQawWSp8JYe/hEJLGT7vN9HUx932twXzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=lNKBwFyk; arc=fail smtp.client-ip=52.101.70.70
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XWdirz9nDU+DEIyI0YKyky0nmdsAPyrAUkYzHYJJCKhFCalM2rsri5Yqpk48WzPfyyGW8/XdPR0VriDJAnRTiKSghqa1z7WN5m9ZfhP0A4w7bVbk3lK2g2lGocorEubdhM3urT2K7kEdLeNdRhk6DlhBnbCBapoQHRtqcd5oEH74RDQdvZblRvUpqHda3FmDk9HgHE5WckFo5iLCPT/zbMz7lKJyH+90Z+M/g5nb53dcIZlBLPonjxfC8B8+MY6QL/3jSs0IvjaTgkfRkE3LzFFYBMLLpxRGS9PZOhC9zvR/yETdLZBA88YvPHHbr0C9SK3NWM4KJoj0KLKnFqED4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=goI7oOu8P3D/92hQL22NS9PUw7qHJVgLP7B5rCuLxJg=;
 b=XVZR2qZj2C31JAIrVsINko6DLVLwHhv6DRvGQIO/UWlnRYg34vHMLxH0j+Y4w+QNhUApvaS0vj7YhqGiY045NWGOqMIsrg08YSjQe35fPbJaRl5+7ZdREehwtsa0bnORgEeFawRGn5UfRTckUYj94R8NGvk7Mq2ByffaQQiec3M36v4F2+v3jj5f1bbI9+OZoLHg+rzJEO0F5nq7Ctkip7EqWK740ErvtDh0PJIcwPWMAEBgC9asSObapKXzInqe7RPrCSsw4VGzmxvxWLE6sGpQkNBv/lPSDW2u2kITwPjIe2ceDsumZy9MrNAgexkIBBntilwJpcUyjK0yeVLPdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=goI7oOu8P3D/92hQL22NS9PUw7qHJVgLP7B5rCuLxJg=;
 b=lNKBwFykyoLfMAUAQi8uEFKHqTG0t9ulebuDF9KPSR/y+6RA8eTiEX9K0tZTT3oKhtt9Fy/Rpr/ah5H46u3vy1cBAzePJp59SzChIAUVYD11AN/0BKXvzcVUQLOQ44I7W3QnjuOEyVjkbFcR/YgIDLm8zhXrMcyzfdmVsh+xCMo31zIAvuDl2iuJeF1VZwWgFFK9cNgz7n8RAcBfhxA6kLc26vld8JlYLRAvyagg5cMQPNvOKXXr0lHAOPPgh5/Bv+43S5DaCPMmAE9qoiioeV/xhHzeL2O9w8s7rYmqtDQugO8Yrp6WxGx3iVG6LS+DbHssv8p49NJmBymdWC2iEA==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DU0PR04MB9345.eurprd04.prod.outlook.com (2603:10a6:10:355::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Fri, 10 Jul
 2026 16:48:34 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Fri, 10 Jul 2026
 16:48:34 +0000
From: Frank.Li@oss.nxp.com
Date: Fri, 10 Jul 2026 12:47:50 -0400
Subject: [PATCH v6 08/10] dmaengine: dw-edma: Use common
 dw_edma_core_start() for both eDMA and HDMA
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-edma_ll-v6-8-1471d278b73a@nxp.com>
References: <20260710-edma_ll-v6-0-1471d278b73a@nxp.com>
In-Reply-To: <20260710-edma_ll-v6-0-1471d278b73a@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783702067; l=7783;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=5wNiTIt210tjZzECyabmvGNuz/dnWdaiBgHGtRLK7CM=;
 b=qwOh/6i3vY8AGz0Ww73JywQzeSHJYh0JItpJRO3UMvYl+susWsu7YT3TrxFUl7D1jSY7p/sew
 5xAur8NqqgaB2m4OvTAnUED8rYFqDYFT7M8sNeHpYCEk7n4fEXxfakb
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA0PR12CA0002.namprd12.prod.outlook.com
 (2603:10b6:806:6f::7) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DU0PR04MB9345:EE_
X-MS-Office365-Filtering-Correlation-Id: a0008da1-6f11-4423-4aaf-08dedea314a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|19092799006|366016|23010399003|1800799024|921020|6133799003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	CkT3ao2nXIEkG+zvXkuA+Iy1V7zr9NVN9huL6Eq396KD04ojOyO1LfYSVRdp5z9U2R74BRqkKPMHm0I/x7uLcRSYvN9bkNMNYqdrvSlAlUpL2CFT7LXCz15sme4r/M4r/tLN/oFETHbcDDtPQbxbvrA4VVpZRqjEKFq3kI+t/8B5ql/dWMhLKIr8jyfUkHUjQYbPXSbBc9CzgnwMB+SG4vA4S1HK59B2/2sKQrz15UvLK1KKtSb6JMySL8+Sh/J1Vte/Z/IdakH4TyaYWxvT1OwoAMmtLK4nzw36IozUF30jD6Wtoc+JT840Gh5BM00RhHp7ZYmqzje7nGHegCVMs0WOZkLeZYozLWB2KSf5lJABCkiqhL/c/MCj4IWYoR1qsmZfZMUdbOWJW7NBhnqrjjWeZZLxmZdetp1HP9DqZB8RFGW926akFlsWmiTcECUYPWIsgNPs5pI6B7JKeVI2jkmAKcTaA9Y63lKmMH54fr9924Eh+w6ZYoWmO7onx/TY/UqWty5qW09+TxawwlYWZDLLDWQWCG9trIZWPIWwh+Zs48v9PHkntRZsSndwsyHhoKu4Y2dmfwQTY93jfjNMbU8hztJRV505II4otMIpsDcHIJadWQEdGWaF/UdBXBjN5P9f+9pAZaYrHk39uu0mC1nR2p8qdTcbQ5/upaoSOQjz9PW/Dpx4vyq+XcCxxXH6zso0iVyzbCy72JC9tMit4Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(19092799006)(366016)(23010399003)(1800799024)(921020)(6133799003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cUNLaDRuRXNNWmZKRmY1cUJ5T0VpcG1GSGkrNGlKbE5nZDVDUE9XWVJGQXpu?=
 =?utf-8?B?WnhXUUNCV1Mxa3lVMWllbkdFc3dPUlM5dmhTMTc1dkxpOTEwTTd4TktaY1ZV?=
 =?utf-8?B?SlRBbXNVN1gzRlNhZkZERHZ4YXBwb0h4ZUpvQmZPUi9uL3ZkRDFVWmhZUXdP?=
 =?utf-8?B?SEVjNTJWS0c1aG1YdlUwT2FSditKRUt0OUpvUU9LQ1BraEtyOXl6VjdHVEVm?=
 =?utf-8?B?ZkptM0VHaWNlb2lkSFNPL1JyN2o0UjFscUxNOUZ4YVd1dTNkMk1UUWFTL0Nq?=
 =?utf-8?B?QzY5RGRIaUkxejhTaWRmb21RU251U2h0YlgyMGM4THQ2eE5QY0ljVzhkTWxM?=
 =?utf-8?B?UHVGL0M2K2s5QThRZXI2YmpOYlNwVTQxNmR0a2k2UlBGOW1MQ3BJMTJSWXhT?=
 =?utf-8?B?OTNieWljQnJMMlZsM0U0bWxYZ1cxdGdCM3ZQR1EzcnhlRFZiNEF1UHRMNzVw?=
 =?utf-8?B?RlhBWEFrWGNqSGVSRXRGOEphSVRvcHN6dXBoamRPbTB2TkwxaHdyayt6azNP?=
 =?utf-8?B?dmFyL0tpOGVHdWxhallRWmN6cWhoWDIwMy9zbHFoQnlnK0RyWlZUL0MrQ1pj?=
 =?utf-8?B?SW9HbXZ1RVZYYU5BVU5oRDJ0WmpHZDAzdlo2V280dzd4amlOdzhZM0F2MjNv?=
 =?utf-8?B?ZWpORUk2SGFSbHpmcXV0TUtTUDkrVmJwWjRoV2NLazlVOTNGVmNFdklwT3Mv?=
 =?utf-8?B?OTM1a3hVSjhCNitLNkhsLzV4QmlEVHdyd2k3WlM0eWFSeG1PckNTTUUvTW4v?=
 =?utf-8?B?TlNhMys0OXhTdTNBVGRpM1RVaEdCNmxXaXlubVJKejl3WHJjRU1zK09RWHJl?=
 =?utf-8?B?emI3ZFNvZkgwWlgxeFF1NXo1SGRqUW5wTzFVclV5QW41QmU4a21TQ1d3cjlz?=
 =?utf-8?B?WDdPVUk1dUpZQ1VsZ3NSeGNYOWtralNvL3E2Z2hwcEZITTRUSFc5Rm9QUWUr?=
 =?utf-8?B?VzFuYkdsM2lDclV5YWpJZ2t6OVdKNUxESVNwMmxFMTc4S2FuK245MEF1RTlD?=
 =?utf-8?B?bVpSeVFEUmN0K0I3YTdjN2t1bTBUdGFpVzcxSFRKMXRad2VBRFNGTmNhY1pl?=
 =?utf-8?B?TEkvRmEzR1ZmNDBQcFJtdE45OGJjdzBIc1VkZTVzaGlTT1gzbWN2RlFsaUVG?=
 =?utf-8?B?U1YySVB1dnh2S0I2SXhrNE1xRFFqTnZ0ekt5N0FKNEd1M0RycTd0T1VUM2g2?=
 =?utf-8?B?b1F4T004NDdldFdEQm9jQlpmK3dFbW9sZEwxdVVlVzNHVHRnYTRIbzJSWmIr?=
 =?utf-8?B?QnR3Mk5pOHVHUmRRSDc5Si95cXBIOE5uNXZuZk91TVRKSmVWMlhHYUZDWEJL?=
 =?utf-8?B?Y0x1eFNLajFUc095L3ZQVkowc01pS2xqZ0UrYjJxRFVzL08xMk4rRnpaVFRE?=
 =?utf-8?B?SzMwa1RoYUkwTmtzTDMxSmhqUWlFRVovUHJTT1pPY0dXOGlKOGFFOFY4SzV5?=
 =?utf-8?B?a0Z1c2FkT0k2VUZhSm1xQzBpSkFnV05NUzgrZEU5em0rdEZFY09xdHBHRW5W?=
 =?utf-8?B?dks2d1pvSUIxbVEyN29TcmYyQ2VnQUVNN3JNTkV6RDVRTk5jWVNYZGEwMkdm?=
 =?utf-8?B?eXR1c0hKVnNOVXA0dit4c3c4TmZ2RC81TjRadlVZZGZZS1lPOXZsOUVQdXVF?=
 =?utf-8?B?L1p5ZEx4emdnbFpYajhZb0g0TEZLeERxQzJBSFVSZlFFRldGajlUZCs5d2Zh?=
 =?utf-8?B?d1E1L010Q1Z6MGlvcUhSWWVhbHhCTUNJRnlLVlRYcDgwRVR6eThqRE1ZY1RO?=
 =?utf-8?B?MUVPbzVVUW9WVEpkV0NXYkRQNEpuQ1dGTFNDZmMzcGRRdEo4cGhPN3FXQXZp?=
 =?utf-8?B?YzBhcVd6QldwbUNGODJJN3B4NFBLWjdIYXIrRVp1eXVXcjBlWmpwbTZ1WDk1?=
 =?utf-8?B?TFRaMW1CK1BNVEh5WlJtQTAwbVBaUTlMRWdIc2doRFRDWFI1aCtVbUt6RWFn?=
 =?utf-8?B?dXpvUWQ3aXd2WUJycWpzUFRncmFydWwvZWVxTEJZMnA3Q0xpa211dTdaZWIr?=
 =?utf-8?B?SXNGU1ZDak5HOE9XTHlBdllXU1E1aDBKcE1HWWdQaks2SzluTVgrRzhKYnFR?=
 =?utf-8?B?TGRlaDExME5oRUJZa0hGeVl2S3BXMGI2bFBBeDMvL2dPUHBqdjhpUDVMdlN0?=
 =?utf-8?B?YkJFZUxjZVdKTktITTVZVGoxK3VnVWR0Y3hJdlhCSDV6ZEVnYy8zYUl6eGla?=
 =?utf-8?B?QmJPUHRwV3NIdXlGd3BJTm9KdTNEOHBVVUVVaXc0aUZEd3pGSHRRY0o4ajZS?=
 =?utf-8?B?a1pHZTVnd00yMUVvN01wV012OUJnQXQ5ekNHblh6ZXA1UFNYWEhOUXNQSEdk?=
 =?utf-8?B?eml4RmVtR2t4YXFCZ1BYQXlxK1YwWHI4TkVxMkdabkVkYXpWbXJ6SitEb0xJ?=
 =?utf-8?Q?Gwcq5iARcidnz+OuZYzrsU4CVy7FSblH9eoRy?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0008da1-6f11-4423-4aaf-08dedea314a0
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 16:48:34.2499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1UJ2N2S0P9snn6ndJ1yVhtWQMWIL1u/LDZ5zWqkVu3cR91R5kkXWw9Ii9wo12PdP7HXh8UpzT11NzlDsI8MFuoH4+RUk4dAqdVizQyvjkQa5/ZtsGRRu/xCzTO6x0oh4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9345
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12330-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:email,NXP1.onmicrosoft.com:dkim,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nxp.com:mid,nxp.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EADB773CCB5

From: Frank Li <Frank.Li@nxp.com>

Use common dw_edma_core_start() for both eDMA and HDMA. Remove .start()
callback functions at eDMA and HDMA.

Tested-by: Koichiro Den <den@valinux.co.jp>
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


