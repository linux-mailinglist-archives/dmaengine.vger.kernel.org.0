Return-Path: <dmaengine+bounces-10251-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +A7mEpep+2myewMAu9opvQ
	(envelope-from <dmaengine+bounces-10251-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 06 May 2026 22:50:31 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD3E4E0673
	for <lists+dmaengine@lfdr.de>; Wed, 06 May 2026 22:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C52473016531
	for <lists+dmaengine@lfdr.de>; Wed,  6 May 2026 20:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401DB3B38BB;
	Wed,  6 May 2026 20:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Fcz+FpXI"
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013050.outbound.protection.outlook.com [40.107.159.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5955A3AE71C;
	Wed,  6 May 2026 20:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778100304; cv=fail; b=B/C3nW1oqqAIrSfv1MdJxLhigkNWCHyZGZ5zDrZCcigDUJsa3T1LiDUhMIbI2oD2JVOz3B44NDD1ijApuTyAF71l1//T18Oaus6MAyqT5B3yJj36Hogm+CyCAGKczqQ0Uj1wfvym0lo4p2qkv0MPEgukVMvPTAhdkj7by+EynRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778100304; c=relaxed/simple;
	bh=RvdziMXLgHCPTve6vEOMT33tDQN/456l6K0okC0StJ4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=HxNdJSMIWBeT7mT4dtrDvvLTw/VlrpTVR4eIDsiLXoDZd2hk5fA1wEgYlUVg/zX7EK/ScMMFGlHRvYT09JpE/U+RmA+rUFyNUtaEAR7CQNPIuwjBQw/dl3ZRRcyPzGdiJyGbek5DEvkmQc5xo6EBI217sdZyH9MLcGGcmC9RpPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Fcz+FpXI; arc=fail smtp.client-ip=40.107.159.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pi1QoZ/isTG7dkhoEoEG1ZqJnhfCQ/ANvxJmZEcPIksio9NgB3BHPJoPrLTEx2URNPU7P5+JbaqCTqQRaPrdQTSpXl+nufGid0RyPplp70NHRY1eWIW6reTH26DeTRH5Ie6piGrT1B1dTIt1bwXjrOXPQHjSHtailfhzHMfnInB2DPnM6fpIDjLoDf2M5xo/eWAgdRVEwtW9/83Am5mQ70lAsIveQZtp50t7A0uklSEz77+OvkTGy3JuFhLOeucttEKVv8WnlMWuGUQkwpLvqTLosPVyaM03mZ4j0fPM3O/GT1BChZ4J+c8vwf0B+vOZDNDcbNAPHyyicXDBWm0qPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z0YdLHERI94ItKZlxs7ipo0z1CpPVEp9OjspjJQJYB4=;
 b=m8gLFTZBJ7CYjFHFxCzEum/AWV8ZIpvGOTsC5m6pEQbe15728GX6bzzgyio75SEDbzDyPkMdBqA09qDk69llYXZrFQBWx0X2eU4cmKtXiP1qGNj6WNJUk+FTsKzWxGX1kRUPgdCZvIZl1iHEz10IA2vGx61lWwQ5ip5Q+jf1LWiv5zB9hwqaSKuthaohzg62o4ay9va8+JXMcQDfjjWjbMeBIsDH82eLhHls1vxNpDLyx/7gulAnbT6o1kSlyBZm6zlpTgKDMsnXEK7Zd+CObxCIJ6YCHUuaK9QzWf4SiPig5PVgTAUJAjrZIzVfzcpuFErQmYmPPB7yc9N83yiWpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0YdLHERI94ItKZlxs7ipo0z1CpPVEp9OjspjJQJYB4=;
 b=Fcz+FpXIfTys6z7bClVEyUqBNcjNpM1oU/hDysi9tpAsMalUklWwYk/AEJa1rXM5sKaN79zue4fCwbnbXyfCohzbNvl8vfGmbFr4Fz/k5WTRVTRZw9smx50G1OdcKSydY05cqVRrMPIttleEJ6aJqm+FMcmFHMJhrxyRo3lgcW4P/vF41kx055+T9eE7KcV4QTvizA6FZhbWLvoiD5qY8vBouW58lKKCMyNfyAc1M6u8Jx/DHPX+Z3KEc6bu5Q9f+HZLWJ/BUSZiWliJfsY/JHtxZAd2H63BQ8SF/uK1wT7LM9e6FNfwrTbRCusV7DwFZBNBn7cIqV3njFAOCwx1JQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com (2603:10a6:10:35b::7)
 by GV1PR04MB10479.eurprd04.prod.outlook.com (2603:10a6:150:1cd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 20:44:58 +0000
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4]) by DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4%4]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 20:44:58 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 06 May 2026 16:44:19 -0400
Subject: [PATCH v4 7/9] nvmet: pci-epf: Use
 dmaengine_prep_config_single_safe() API
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260506-dma_prep_config-v4-7-85b3d22babff@nxp.com>
References: <20260506-dma_prep_config-v4-0-85b3d22babff@nxp.com>
In-Reply-To: <20260506-dma_prep_config-v4-0-85b3d22babff@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778100264; l=1756;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=RvdziMXLgHCPTve6vEOMT33tDQN/456l6K0okC0StJ4=;
 b=BzSwX7sx6284KhQgvOganSFRzgZo0JCSnm+JKgcCHkj8rK9Uzf5oVnjRc7q0TUYHc94ede5LA
 3GBlLVTtMDDBNiF0UxPyyr8joACe97lKiqfyvJee6F/Y47vlmPPR6Dt
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA1P222CA0051.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::24) To DU0PR04MB9372.eurprd04.prod.outlook.com
 (2603:10a6:10:35b::7)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9372:EE_|GV1PR04MB10479:EE_
X-MS-Office365-Filtering-Correlation-Id: 887548c6-4a15-4f5d-732c-08deabb0566a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|52116014|1800799024|7416014|22082099003|921020|18002099003|38350700014|56012099003;
X-Microsoft-Antispam-Message-Info:
	dDgltjrPh9YXA0pkp7mv12Z8OHH/BgGPSGtg86gySIvWshRz4EBxaJnz9RuWB7UIziCI4+qGWLSJSL0iCPlNfo2pFAFBkymwroxekaUh6GwInQbkzqgbNum02WYNnm/ZG+fWLo5X9ZTbZJc2LtdNAlgzx/Sd8pzR1UFOWuHHY2aZHTjQSRocqObIBJDAX90oOK+yIS6xVgnW26rt/DD21AYX92KYlNYoGHAT+9bkPDpZO+AgsYcHeFKHl/VRYWS6mldgHA2Obpu9SW6b1AmAqa/zvb08qVtATjEzQ3E5BBQXjKR6pzV7XDK7+YaQtmuNeFKbOwOa6/+JICem6Afphgn3keR098fr9D1FBhsd/l7x/ew7sYR3CSWdNvyH5sAWC7emsnxP8MkSAYQ4KkYyAu4bzlg7PieACzHowBjXB1azpopqGT71FJbUdX43KFpmyjO0TCXmdwAxKy3LMlkpbyPu9S7BiMYM9GHhIHpRFsmbNbeuUCUh5RmlMxu/IAUmb3TQOSV4gVijdH2WpDjBUUtIRrU+nEdOWgs0FKLRQEUI+ErRPhmYKoG2bpv2DVCKam0aqi1rYvCCE1fM/O+CP4J1SAV6l5ikmJTBP3k4R3TfaBjCA2p7P2BAAJmEMfvKQn0qnBXvNS1mnmQ/U3Vzv24HRNGDKiWrHyZiuZLLLjlEWDWUdl8leQkhJgQcr/3u/VxxcPMzlTAqzbYTYaAylvmhBVcI3qRCiQy0NemLOaYt6ViDiwYWlip59DX5pWU064Fk/EHehvwM+LtAnDY8cg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9372.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(52116014)(1800799024)(7416014)(22082099003)(921020)(18002099003)(38350700014)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MjdLRTdiRm1HZDlMalFpdWZRbmNkVTFUd3hKb0RmQWdKOUlBejdRTDFJVlhN?=
 =?utf-8?B?dTZpMFk1OGZMcVF4bDFtZll0UFdUQnJXeiswN2RTODQxb2pJV0JrRkRkZGVz?=
 =?utf-8?B?WXZSSUcyeDB3cmRSWnp2cThDbTBKMXg0SkJoS0t6U2hMM0puQ29RMy9NaXN3?=
 =?utf-8?B?djZySWNDRG1YdUQyVW9xdGFVTjBsS3JsWWZONytxRG1POGlHUE1SZFpkVDUy?=
 =?utf-8?B?ZjcxQmNEOC8zd2twb1BrMHFWQVdzRzJzQkNCTXd6bEdkWTVqK3Q0aXhxY0NC?=
 =?utf-8?B?eTcrcW5uUGhlNjJFeW5mbHpaNGV1b054SUtkWkpkRDJrWndRWFFnWVFQWXlo?=
 =?utf-8?B?eDYxN0ZmU2pTZ2hENndXaHdRVnpZVndSdzk0MDEwbXJhengxc1Q5TUFtWjFo?=
 =?utf-8?B?ODBmSURXWDVpUnhkb2FxYVJ3bzA1NldzZjR0SlhSZk85TCtOYjFEbjJZdW1a?=
 =?utf-8?B?OE9pS01tUVRzRER5OFFmODczSjlCalA5cW5zb2xPNGNtZURsaHNhTmlHUVVn?=
 =?utf-8?B?M2xvN283akplbWt6SXQwRWFFNmhlS1c4TE9sSjBXRFdMZ3Q1QW00aU9KSFEx?=
 =?utf-8?B?SFFDa1NVQS83NU1vT3YwbVRQMVAvNTBtR0lwRkJlVi9ocHpkL3h3ZDBOeUl3?=
 =?utf-8?B?eC85dWg4ZUVxWEdYTUpPRnF6Vm9mbDFJbzlSMTg5dnNqNUYvZW9zdGZaN1Zi?=
 =?utf-8?B?NGhMYzIwVVBCZG5TTUxHbVo2NDYxZTU0Tm4xOXdsamszSkxxSDU5UnNhaXBz?=
 =?utf-8?B?djVydkhrRlF5NzhIMUh2WmxwS1NBbElhcXdwR2xqQnh0NmVqUTZMdnJLZXdI?=
 =?utf-8?B?NEFORzZabDNZZExrNHNWY0ZqT0h4QzJOUTZyUStUUzBPZWNGTjlpaFJCSHJ3?=
 =?utf-8?B?T0FYVlU5TkhSRDE5UTZvcFczK2IxYzhPK1B2eVl4NHlHcjcwOTdYejlYV05s?=
 =?utf-8?B?QVFwTjJCWjdBWE91cDRKTi9XcU5FN2dIWjdlRzRucmgvOWc3VkRackYyZ3dX?=
 =?utf-8?B?VVZ5NkJ1M3RHSjVrL0xDcndoWk1BYm1oWGpVbnZJbkgvb1IzazdkSlFwOEd1?=
 =?utf-8?B?aFhhYVB3SzdoRXN3S0xKeGQydWJvZVNFeFB5ZTk1K2lsTklpb3hxOWxTN3RC?=
 =?utf-8?B?aG5yb0krZjBEcldDZEQwbXd0cC8xWFFWWWxJWTd1bUVsK0YwQ0w4eFVDb1FG?=
 =?utf-8?B?ZFdLTTlVMFZkNVkzVGxjNEp3Y1lNQVNzZUdqd2VGTTI0bEVrYXY3Nm1idk5Z?=
 =?utf-8?B?NCs5LytaQ1RFZ1l4a2dSaXBqVGpZVm5hQmdJb2k5Nk8wZjlqNS82cGJOWWM0?=
 =?utf-8?B?ck93aTJhMGF3QVZCa2hvMGFFZTg2SzNZR2U4cWw5TkhxTjc4ekpSdktJYVpi?=
 =?utf-8?B?UlU0cUdKbDlOU0g3RGFVQUpoSWQvRHhJcUZYVElOZ1FSZnp0cFlEL2dLd1I2?=
 =?utf-8?B?eERvQ0FiaDJ5R2k2TUVpaUdsVFUxNFRvb3JydmdRVXc2OXlLNm1nNjhSNkNU?=
 =?utf-8?B?dlRtSXEvNXlNS0tBbldpZDh0bnlLMGttNDI3Wk9lU0VIRWduejdXRHpwQ0tv?=
 =?utf-8?B?N1d5MWFNVTgybHRmamh3bHhrRGpySlFXYk9LNUk1dTI3SUxCNVoyeERaMTVU?=
 =?utf-8?B?VFRxbEdaOTlvMEZnOHVXUjJjOWNQWEozZXE4ektJVlpwM2JaUy9NSDJCT2ln?=
 =?utf-8?B?QzNmTGVWSURmRmd3ZkxKcFZqUGFDbnNsbi90UXdWbVBtNVlqczNRTWJPcG0y?=
 =?utf-8?B?ZE5VMEg4S0t5VmlqcGNRS0xZdk9KM1hqakFlZUpjS3BhRXNDQUQ4MzdwUTlq?=
 =?utf-8?B?Y1g3VkY1MHVIQkQ0YW16ZXI5S2hvNWwzQXE4Wk5NYVhjME85VWpkTlhvRU9x?=
 =?utf-8?B?dFhOaVYxUU0wSC8zakRSNHUxblhuenBoUzBlbDh6eENuOHRKVmV2RDAyRW5Z?=
 =?utf-8?B?U1FNTzBVSjJHcTZRaGpOQk5RNUs1eW5GczFzUlYzeHFQMk96ZitGMk9wR0RE?=
 =?utf-8?B?Y3VhRmRkc25VTXNFVWpVZjZWd2lkcUVBcWNSeDlWY0RMKzFFbUpKOFUwMXJO?=
 =?utf-8?B?OWNKOG1yMnZRYkQwamFuVDRvVlE4azNhSnhsUVlSTTR1RGNEQUFZNG5rb0t3?=
 =?utf-8?B?ZnRadFNMUm5hcjdMdjc5Ulk1ZHI2ei9YeTJ2eDZDVzlRWGFOR0E2VkthOFg3?=
 =?utf-8?B?bkpIMmMwSzZDQnRjbmVnOU1rZ1BzSng1VytFQXlZcjBNMGsydk5WQjhKU1VB?=
 =?utf-8?B?MlRLWFhPVHNaczJLUzk4WEVXUVFLYXQ4TWJDVHRIK3FpVkpGa3drTTlEK1V3?=
 =?utf-8?B?eVlZdEh0VFhmbzU2RFJ5NWc4Q1FJR0ZIbVE3RFZ5QzQ1amkwNDlpZz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 887548c6-4a15-4f5d-732c-08deabb0566a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9372.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 20:44:58.7481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /oW3541kYhRJkmifySkL8vyzmtStqDtGpb2gaq5zRfoWaHgRAEg7f0EHyWONkv+B4j0yVMBPzCJ2xYOCGSU8QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10479
X-Rspamd-Queue-Id: BDD3E4E0673
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10251-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nxp.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Use the new dmaengine_prep_config_single_safe() API to combine the
configuration and descriptor preparation into a single call.

Since dmaengine_prep_config_single_safe() performs the configuration and
preparation atomically and the mutex can be removed.

Tested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/nvme/target/pci-epf.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index 2afe8f4d0e46104a1b3c98db3905cf33e8c9e011..04d8f48d6950349ca97d2dbeae4e38e4714ad0d4 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -388,22 +388,15 @@ static int nvmet_pci_epf_dma_transfer(struct nvmet_pci_epf *nvme_epf,
 		return -EINVAL;
 	}
 
-	mutex_lock(lock);
-
 	dma_dev = dmaengine_get_dma_device(chan);
 	dma_addr = dma_map_single(dma_dev, seg->buf, seg->length, dir);
 	ret = dma_mapping_error(dma_dev, dma_addr);
 	if (ret)
-		goto unlock;
-
-	ret = dmaengine_slave_config(chan, &sconf);
-	if (ret) {
-		dev_err(dev, "Failed to configure DMA channel\n");
-		goto unmap;
-	}
+		return ret;
 
-	desc = dmaengine_prep_slave_single(chan, dma_addr, seg->length,
-					   sconf.direction, DMA_CTRL_ACK);
+	desc = dmaengine_prep_config_single_safe(chan, dma_addr, seg->length,
+						 sconf.direction,
+						 DMA_CTRL_ACK, &sconf);
 	if (!desc) {
 		dev_err(dev, "Failed to prepare DMA\n");
 		ret = -EIO;
@@ -426,9 +419,6 @@ static int nvmet_pci_epf_dma_transfer(struct nvmet_pci_epf *nvme_epf,
 unmap:
 	dma_unmap_single(dma_dev, dma_addr, seg->length, dir);
 
-unlock:
-	mutex_unlock(lock);
-
 	return ret;
 }
 

-- 
2.43.0


