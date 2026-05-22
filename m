Return-Path: <dmaengine+bounces-10764-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKbMOK25EGqzcwYAu9opvQ
	(envelope-from <dmaengine+bounces-10764-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 22:16:45 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6675B9F37
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 22:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D3333030B20
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 20:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772BF37A4B9;
	Fri, 22 May 2026 20:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="dJ4s2uUk"
X-Original-To: dmaengine@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012000.outbound.protection.outlook.com [52.101.66.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020DB37881B;
	Fri, 22 May 2026 20:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779480833; cv=fail; b=TNoR/KkWMfBfj0nGWHJf6eDAP+dMsPoYVskgJnfXE4vNIqOwlcFRQC9XVAI9U+OAUBncLaQj8RcgzuyKIcDU1Fa7dUvn6DRXbmuB0AUEO4yzKoSUFZKI1H4ZGrcjyHhsw4Jmhu1//tUTEk5GOy5PmXXixBme7CP5DnL2kZUI9yw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779480833; c=relaxed/simple;
	bh=QwYNFK5US066p1bqi9016s/3R0apCMwPvOMoLZ995Qs=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=VdUBSnQBXVIS3AzDA5X9k2bOz0l+GcCOFk35zMnKH4/WBGepY8WaszxmlKonD4gIHgHHDSy3G39y3yMegaTZdR/11ByRAacwHiCpyOK3M3ktIIvMUYIP7j6uX63Ctnk07/KhEOpd5b4DIjYLeK/NJ6230Z1bYIFui3j2g5TWCDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=dJ4s2uUk; arc=fail smtp.client-ip=52.101.66.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AGhF0R5kYxjzAcvNf5kJ/2ziHvK+nKeArw/JN8Ieuqnpdp4+mfbvKE72QQ5wqzPGV+lTwjO59eh7ltx2olWiR2kg6H3BpAx/2JzL7HkPlXJMiDFaSWEbsuFCQiJeyctSBwn1WtMh+WdJdCJ+SGMHHcFwvFGdP3U3mTf+6/Oq237TvOZB3+tBxPs952Y2CsHKcXmqY3psd9Z2iC9DDhwpV1ORBeRZMqSfKJ12CcRfvkE8pKeAp1ZXtyHtLuk8bXBb8IJ8DMsfxfoNVUYeaGiPWWsNQxB+JF3rrkgoQt0gN6N2DTxVZbRHoPBLpfRQGFNqmygk07RS1xtmHLvPquIK8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dwdFLu3pu9rraGDbFWiYfetrzqEveI5olXM7nVctzls=;
 b=WeErbSpiJac0stdWYT/a5TPoZwslSiDxSgDzvPXjm0u5ss4nZg0PaI34pcfg5xh+KpeN+CWFqTA4/fTcqkW9A4O0zoCMiVSWs/Eod3cpJhNRBwQ2GC0rmliq55aDPIZvgZWZwjHg/5PrIDoWkloEPxmwVJvNtPZbbcJEJUar03ZKXdKz4FnVWolGSgdrY3FV7hepPIVeC4Pgn3+yfJGMH3kLpU4M3c5pWR7MZ/APC0zGCg+0iLjUtZw4AxaiHwqBl6rfQClXLT5JHV0/VZRR1Wu5ChyeH9eloAYKRqBiPVpAD2Pk6Y8rGnbtEjWTd02CZ/Hv5FbvR546B3WZyUP13Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dwdFLu3pu9rraGDbFWiYfetrzqEveI5olXM7nVctzls=;
 b=dJ4s2uUkV5fQe0bbIwCJJBNn/q9YKQx3nw/RI/AzwQyNkuIBPZF3Ev5QZ0vWi0xB3KpM4K2EgA7JS70lPIo89NSLYQG/1RrvYAua+nbhCuBO9oDlnxlZhciBJl330/Ws7glsKYgm7WxusCBB1cTmCCFD94DqlzOetBOEB4GU4ORs4gC3ANBs19bFmVikdg6JDwhvts7hxUt1fjQRnoPLYvsvC3fAI1oE7k3vlgar26B5t6Goia8YpZ7VMZxkjqqQS/lD5gA6uMhQY4f/KnyqaTyCT4fMP+AVEpcBGYr7yCYcYkOaxpI5zCo/B4FHjMnlPHY5HpKUWbBQvbDZDtlf3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI0PR04MB11503.eurprd04.prod.outlook.com (2603:10a6:800:2c7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 20:13:49 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 20:13:49 +0000
From: Frank.Li@oss.nxp.com
Date: Fri, 22 May 2026 16:13:32 -0400
Subject: [PATCH v2 2/2] i2c: imx-lpi2c: use dmaengine_prep_submit() to
 simple code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-dma_prep_submit-v2-2-7a87a5a29525@nxp.com>
References: <20260522-dma_prep_submit-v2-0-7a87a5a29525@nxp.com>
In-Reply-To: <20260522-dma_prep_submit-v2-0-7a87a5a29525@nxp.com>
To: Vinod Koul <vkoul@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>, 
 Andi Shyti <andi.shyti@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-i2c@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, carlos.song@nxp.com, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779480813; l=2024;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=0oqiLl/YkASERPPvsSb50njVryfyA7gCf6+80IwRBI0=;
 b=SuLwtjcCez9LYpOeglxmj6e9/lRNQNNBJ+qxtT6D5vVDUok2ckI09VU0q2yMTjnh4K59hWvyx
 gRiTydg1BjoCDVhcso6qPqNyUmpUpyl4rXwDjfprHpXrOSPfcDosFEG
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SN1PR12CA0087.namprd12.prod.outlook.com
 (2603:10b6:802:21::22) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI0PR04MB11503:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bad5c64-f421-4922-2166-08deb83ea289
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|19092799006|366016|1800799024|56012099003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	Y7c8vRBXf/TtYQKwGa1l1hnzFM5Wmyod8Egpi4Y6XZO2zE9I+6MEOSyWv6EbRvxfRFbDI79161h5/SoQmoCn8LSZCgzjHuc7fSua8wgc9DMjhevcbIiZ48UTZsb9YsQh002Q/NHIzRZajCr99vuCu+Lz7liGcgwmG1nc35+76r5GRLgPjUJPsJVh6bqataiHEwSbGhvAQJ6yGIh8ua1z3nNh7G1Xg1BcZSOMF7LTSKE/wrA3u+MLgzLzB5H8FvQKTIEXijWJoOSIapAK9Gdm/3cEancm4SQT+sso5d8n+O552Jkl53Gor667X2NV/lPDaJQXBINRxtXWlbjQRpyTEB59Lr1t7xgoI+XV3DrbHEkE9ubxdmFKycuBoC7E4Ue4VfeBf9FsftoasFS3Ue1YOZq9v5jxpZvWt9PAkLeJFJx9ZbrxHFwF665pZ6cwoLmfA5yee2gSTGHjtRS0O+7B2tyycy5piCruDlr2L9GA+IW83OtEAitsa6EQztuGiI+NEj+AhicxENoJCGwL8LKkX0xWnFzLnUg5r7f2ppP598AuwLUJio80AB3fBy6rfbUM3gotlZt5Pm/7KZ64bL5KImteQnti31fqfZPSrFJQqAbPtcF1YVZMBkNw0U3bzGl/oHToc0AzJO+AEAObsSobvkTOj7TN6OlYFPpCFke+1APPf0aboR0QvAr/mLMDstm5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(19092799006)(366016)(1800799024)(56012099003)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y2pWWU1aRUZkSUc1VERrUm5ubHZXdm1NbkRHQkpmL1pnQ3l4UFB5MWx5S2lP?=
 =?utf-8?B?TXozWVp6a0dVcjZJb0tWbEZ4dU1XUmEwR05MOEtjenVTY254cmVWa1Bpd3NR?=
 =?utf-8?B?bnhLZTJFZ1BSMEsrdjRXUEJWK2tGT0p1K0FISkx3cDhhV1BXd2hBanBUUUIz?=
 =?utf-8?B?aEFHbjFEMGdjT0I3aXM1NTkzbkduejlER2daU21LYU5EMlNqNkVNQ0pRL2RN?=
 =?utf-8?B?SGREWDloRitFaVFrd2h2U1RIMWovcGM0N1NQcmJFYXgxM1VuWG43azdmOEJj?=
 =?utf-8?B?NUF4bys4SDNXZGlNeDlhNGltRVBnMjBOZzJYeVJVU2Q5Y1JXakZJa0oxbUl1?=
 =?utf-8?B?cUlKSjRBTlNSOG9yZmliVDl4b2w0VDRWeTk0RmRBMjBnZkdTNnJxZUJvSGJE?=
 =?utf-8?B?elJvZ0hiNnhSUWk4aUluNFloZHBGRWVPejlFYlRsVFZTbWszS2QyWjMycEIy?=
 =?utf-8?B?aEFOUUp4NE9GK0M4Qk96WTJnQ1hXdXdXcFIyZVNjZVQ3VnE2aExTbldRcGJ3?=
 =?utf-8?B?NTFMWDRMMWdkZ2xac21kNzVZVDB5eHN5NzV2UnlzZGl2ajJHR1oyRE00RjAr?=
 =?utf-8?B?TmhnOTQzRWhHRjdnbDl1VXlKMWxzUGVIK0s0VksreEJtTVJuNHhMSlZCK3FN?=
 =?utf-8?B?R3ZheUp3MFBWejY4cEQ1RnhXSDhXMXRQWXFQL2VVeXpEMi9EYWE0QmVuMVR4?=
 =?utf-8?B?TnBvVEVma290YzNxUEs2TUt2a1g2dkZ4UDcvV2VrTlI2VHpGT1RXTk1palhN?=
 =?utf-8?B?KzYxZExVR2gyQTBvTll4TkJLRTN1d3hLVmZiMFZSSlZ0NTQ2L2hsaXRHakIy?=
 =?utf-8?B?WUMrcllZOW9kL3JjUFV0TWw4RFkvOTd5UUpsNmQzVlNnbDc0emxKMk40elk2?=
 =?utf-8?B?N0FQa1hwWElySWxHbUQ1NW4rbHRlZDVDRGlvdjZaS1VsOGdGY21DOTJlZ3NR?=
 =?utf-8?B?YUw1eWNSb1VZVm4wWjNBQXozRjBVYzllV3BablJOWkxUWHJmbjhBN2lIWnJK?=
 =?utf-8?B?ZWxRK3pwNG9GWkRYVE9Yd2hwVzdqRVpQZmV3UnkwenlpZzA3eU5vQ2o1cDk4?=
 =?utf-8?B?bjdZN3c1MmdhU2M0SjdqNk5GZE1aSzhNakRwRFF1RlE4RkI4cjdBMCsxQmFC?=
 =?utf-8?B?ejBHMTA3aVNnYzJkM0dNczVNK1NkK0thelMxbWRLelRjZDZ5VnptZ2FZRlpS?=
 =?utf-8?B?ZHJCSi93UVVJR1RwZTBkSmN4TDRDWUMrdlBtTlBQRERyYkpDMTVvZUJNSXRq?=
 =?utf-8?B?Tm16T3dtelhSSURTQk1Yb1VMcXpHMlRyZlhybnJ0NmRWYWpqRTQ2cEI4MVBj?=
 =?utf-8?B?QkdwSTdRNzNDMGQxd0Q4SVR4NEpIalFySE41R1d5OWxTVm90V1pWYUpKZyt0?=
 =?utf-8?B?M2xaKzNMVyt0NFIvVmdBelhWMHJhaytCaXQ5cHUwTU9vK0twOVluTnowbVRa?=
 =?utf-8?B?cUR1OXRLK29uTmEvVTRlUUhhaythWldmMXRXVG9VZkNHNityWVN4YzV4ejJR?=
 =?utf-8?B?NHU5bkc3QUg4YmpNM3pEU3JhYWZQU3p6RXp1cE9ORGxBSERrbExZNW5VZlBY?=
 =?utf-8?B?R1AzY2s0bTdUQUZyS1c2K1RkUGViejFGaTgxZE1WOC9WZktHVVhoMXRQMWY2?=
 =?utf-8?B?Z0tpbldoeTVsaGxIUkloeWZTK0dlUmc4TGloTnpndlRSdmtRdGdPY0NoWWRv?=
 =?utf-8?B?NmUzWnJxaGp3cTI2SytBV0FEUisrY3EzK0RvQStvcHBSTnEyb2pZRTVPbXhG?=
 =?utf-8?B?MU4yc3Btd2pweXlQOXBCbWcwT1VqSUFNS09QZUZnZGxZWFkwR1RRaCs2RzBV?=
 =?utf-8?B?YTQ4U2tySCtydFMwU2djakxsT2x3YkdoZnhWcjltRHRDd0Q4eXhVay9zeGlq?=
 =?utf-8?B?TnRBU25yaG1jMERwaTN4TUQ0akZMVVFINWlBR3dGL0xJZ1VCY3pUWjZJRi9N?=
 =?utf-8?B?UG0vcUVTbnhpWkZQNmF4Rm1RUVI0TXJnVFV2b3p2aFRhZFMzODJNUlF1cFR2?=
 =?utf-8?B?bkZXVHFHZ285NnBvTzlPYXpoOUZqNWlmUHYrZlJsaklGQlI4R3phOXFFK0RN?=
 =?utf-8?B?R2IyZ2lmci9Ndzd4cWgyU1dUV2svZ3F1WVVJNWZPVlIvUUw3L3IwcFdPaWtk?=
 =?utf-8?B?SkdkbzJmbDIyZDVQOTZFSkhHY2FmVS9HTE5kTkxpVEt3WEZXejZ0UHlQVlNJ?=
 =?utf-8?B?Q0l6Wk1HdE5XZWdlNFJuQlRyazh0ZTZwT2lJZ3dHRURFRHA2TFhTWGZkQk9F?=
 =?utf-8?B?YjFlelRSVDZNQVRreUltMy9nQWNIWEt6ZWpaT3o0M21SUFVlS3BrNE1La0h1?=
 =?utf-8?B?WEFJRmlDdzhwS3pKaHhNZDE2Q0JENWFGcDB1VW53TnF2Vld0ZVFtVlBCWGxv?=
 =?utf-8?Q?BcgfpSCapkh8nCl0uPNcZ1cJAwmRd469g4nZ8?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bad5c64-f421-4922-2166-08deb83ea289
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 20:13:48.9255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IxFTZ3+//6cPcNV0Y2BT4uEWm+LcWt66Mcb6mc6X4dfwJw0AVX2EPSr976I4NVHuUv7BkF0iSkHi1bAP4wWazhMQA2q9i+wws7LtUCu7GJlFRURF6+ZACIdbISbTeUZ7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11503
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10764-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,nxp.com,pengutronix.de,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@oss.nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:mid,nxp.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,NXP1.onmicrosoft.com:dkim]
X-Rspamd-Queue-Id: 5E6675B9F37
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Frank Li <Frank.Li@nxp.com>

Use dmaengine_prep_submit() to simple code. No functional change.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/i2c/busses/i2c-imx-lpi2c.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx-lpi2c.c b/drivers/i2c/busses/i2c-imx-lpi2c.c
index 2a0962a0b4417..c90f72eec8498 100644
--- a/drivers/i2c/busses/i2c-imx-lpi2c.c
+++ b/drivers/i2c/busses/i2c-imx-lpi2c.c
@@ -720,7 +720,6 @@ static void lpi2c_dma_callback(void *data)
 
 static int lpi2c_dma_rx_cmd_submit(struct lpi2c_imx_struct *lpi2c_imx)
 {
-	struct dma_async_tx_descriptor *rx_cmd_desc;
 	struct lpi2c_imx_dma *dma = lpi2c_imx->dma;
 	struct dma_chan *txchan = dma->chan_tx;
 	dma_cookie_t cookie;
@@ -733,15 +732,11 @@ static int lpi2c_dma_rx_cmd_submit(struct lpi2c_imx_struct *lpi2c_imx)
 		return -EINVAL;
 	}
 
-	rx_cmd_desc = dmaengine_prep_slave_single(txchan, dma->dma_tx_addr,
-						  dma->rx_cmd_buf_len, DMA_MEM_TO_DEV,
-						  DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
-	if (!rx_cmd_desc) {
-		dev_err(&lpi2c_imx->adapter.dev, "DMA prep slave sg failed, use pio\n");
-		goto desc_prepare_err_exit;
-	}
-
-	cookie = dmaengine_submit(rx_cmd_desc);
+	cookie = dmaengine_prep_submit_slave_single(txchan, NULL, NULL,
+						    dma->dma_tx_addr,
+						    dma->rx_cmd_buf_len,
+						    DMA_MEM_TO_DEV,
+						    DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (dma_submit_error(cookie)) {
 		dev_err(&lpi2c_imx->adapter.dev, "submitting DMA failed, use pio\n");
 		goto submit_err_exit;
@@ -751,15 +746,9 @@ static int lpi2c_dma_rx_cmd_submit(struct lpi2c_imx_struct *lpi2c_imx)
 
 	return 0;
 
-desc_prepare_err_exit:
-	dma_unmap_single(txchan->device->dev, dma->dma_tx_addr,
-			 dma->rx_cmd_buf_len, DMA_TO_DEVICE);
-	return -EINVAL;
-
 submit_err_exit:
 	dma_unmap_single(txchan->device->dev, dma->dma_tx_addr,
 			 dma->rx_cmd_buf_len, DMA_TO_DEVICE);
-	dmaengine_desc_free(rx_cmd_desc);
 	return -EINVAL;
 }
 

-- 
2.43.0


