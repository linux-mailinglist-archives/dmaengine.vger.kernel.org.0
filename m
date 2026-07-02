Return-Path: <dmaengine+bounces-12000-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ERZ5Fz3YRmoVegsAu9opvQ
	(envelope-from <dmaengine+bounces-12000-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 23:29:33 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E80FB6FCF69
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 23:29:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=KEpFXRjd;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12000-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12000-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5253E313603D
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jul 2026 21:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1AC83AC0C6;
	Thu,  2 Jul 2026 21:22:27 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010012.outbound.protection.outlook.com [52.101.84.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BA0392811;
	Thu,  2 Jul 2026 21:22:25 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783027347; cv=fail; b=DKp6GXLJH6uDYfZcF6y6xrkZdl0W3Dg5WrGoIRt8N41MP7Q8ulsO8Pgit3U8mM66uRG6CQYZCEzB0Ie9WlYTYH97u0ASXtjOXNMJRBkgynm5bvPR/6LPQeXUROICssoYdIt+wzTNVIsq/Niv8wOeYvo1JactoYJYVxJK4B6PkSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783027347; c=relaxed/simple;
	bh=H7PtG7AhDW0ZdCuBHGjpRu1y6n3I0vkZKTJVYnj1Giw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=PBUMUsyCnQkaiTGk9hO4ta3nRWhpJ0LVSi1PoYRqtTCRYJiHApGvHDN6KCFgHEggsNhNDNRxyFC/rFq3U4HLsA8mkKtCjZGCnjzauo/aIwoAzaDrtYZKyBbY9N8Ch6t9uMyLob43JNSeeElUfdAQJeBPjSs0f8ltrrdqb/oHgdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=KEpFXRjd; arc=fail smtp.client-ip=52.101.84.12
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VZw2uHO14aWF2KHClPGbKuUoMCgw3lovhecSb27PvPBSLwqvBQUXRrwOgiT1ihXW/QKWKzzON7Re2ogXYOGoHIuWLZB5kyHfPfK9eskBRVfNZmWkUxAD2G6lA5+jb5oHZsMWOB+5BUyBLZHaMMyDgcxlt9CTDV3BTVAesdkKPOivTIgLcndlIyrpN2HYPUCoTSHB19n8Lqmzgh8TP6CsBz0Zf/5seI5aKG8tewMf2j+uXIQ/4Ew8J/26ZB/gZW3hiso7RAGrMmMZHK/p2Y/hJhhZqP1ZJxXLRQFoa38AbgkT7rF/+gH0o+b1dyYZEeYdsdtLS7nRjBM/+CA4xZ+R3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=52Fy5GYWwHoWjfL9aEmc3aTQhoQ7/pO4agi+x0g4dks=;
 b=rSgdxzGnTSKJSFF0i6B0//4N5/uX5PPVFjNXfX3eXylX20pJTLiN9ZgJFV3oi4rjuEWE9T4N86s+qdPwntv/AP9qkMS6cKttArkcoQIigmokDWrz9og/P+hGs6/hc8j6neZgn5bDe1W/R/QqNwDbBt4xmD21yYsHmJyFVVUCvGFF0yBW5umVFQKpIANZ7gmUvZeltlr1g0QlKKU4regipOgml640oqtqAXnSfDkohU5XjbmkoV1WaaHpX7tAakjTm7wm8n6G58DzG7s1/g+ZkHOETnnU5ChTNzsqTKx1hejA6HDEgmC8C5idEfXYLb1w1w3lLYO5koU+qdvDsKIElw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=52Fy5GYWwHoWjfL9aEmc3aTQhoQ7/pO4agi+x0g4dks=;
 b=KEpFXRjd2zhqAcp3o6l4HWoN7x/RB7qgw20fCWSaouXc8m+Qr0HgPiOgbzAkmSJIHhZwI/LyIcg+c5IJZouvJOrmp9AiM2CxryZ9inmrtD5cB2McoumiOJrHKDhb6+MMvxlROr9X+ozbMdTEyXIeozXETmjlKex4cXc/wd1mEAJ8hudgATDvCbu3I5WQpLvaaPBvN3nWrMs6Nqfry78vFZXkuarPD6EFWVlOBW+MAirZS4imL/Ek6bvOLPhvd7R0Y4pUU1HEdFRex2trQy4KqHe+/6FTwS8DG/x9rPGxdxO1+ris6Hzglmj2gM1L30ah8VbVA6z5+2YNUN6j8C4jKg==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GV1PR04MB9213.eurprd04.prod.outlook.com (2603:10a6:150:28::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Thu, 2 Jul
 2026 21:22:19 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Thu, 2 Jul 2026
 21:22:19 +0000
From: Frank.Li@oss.nxp.com
Date: Thu, 02 Jul 2026 17:21:30 -0400
Subject: [PATCH v3 10/10] dmaengine: dw-edma: Remove struct dw_edma_chunk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260702-edma_ll-v3-10-877aa463740c@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783027287; l=10056;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=2BnnOPrASniAs7nYNB5WKApoPnVL8h23/L0SLwd+Ric=;
 b=vDiYYXf0vS5fLxzdC9UU5RubBUw4sCZCg8AR6S5IOoCDDVIS7hpCMhDgsWNJjoPWXOMuQWmX1
 YYLRB0LXi3JBscO+kNIrL4evZCptqlCpWlMaqdfpjx5sjKhie6fDiax
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA9PR13CA0035.namprd13.prod.outlook.com
 (2603:10b6:806:22::10) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GV1PR04MB9213:EE_
X-MS-Office365-Filtering-Correlation-Id: e36d2800-aa90-4d68-b0eb-08ded87fff82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|19092799006|23010399003|11063799006|22082099003|56012099006|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	3fGSbcdycOLfZkq6JvWaza4ZltLCMQlzcqlPrx1La0viDuZSW8vyXNtolHEOEHhOHX493HftpNk3Hu1XqH3ZxqYRMdxYDglXI4bzEqua0916tJ0BimB46ziyKWJR8hCPBCAIuTxu/uKVT156/wTRw+9UnAtpQlO2mYjukaa7KMuCwJFR+IW8YPd6qKYTYh2O4NgtyMv6Nsq0+uFIVDoicv7mkl/NKo5scPkemgEq2b7q8Z0avhpDHHL65tqBJH/0RolzGEJXs+O2b29wfoCbrwFie33NPEGdoqQ594XyVusZi5W5mf4gJPz7QmA8dktJneSIGdRTnJ+aTB3YeU402Trvjpnlh07VFqzB4KSVjpeOZaLCVb8+FgQZ8//nRzDvRjKgvJrQiR46zPZrpJNV/bGpi53tg4PJWlTKovwq7n5/8ID3fhrnudySnM4QW0xe3H0NbVyLaT0y19zfLEjGNAY+OkM1GQpoMEUVbTCrVvVALSVuugGiO+W4hBT4RckhcvBSocjniChtp87LSu0c1ebHvR0bUDsV4S8FuGCZm/IMpUIyx4+f4P6CteCeypYbUf/1joqli7Ocn+8Q9yRJAkWp5f/8U0Dic42UPOrVNhRjrW/5pOFpGXdLyJNI9m2lEq2WurVAX7MEuoZAY7qTNdTAypZglaFYxLnXXxx4CzK83W93sxKSA1MDZEYE9FnDBm+rViSXPyw4BetvRTkVCg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(19092799006)(23010399003)(11063799006)(22082099003)(56012099006)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ODhCbUwwT2xOZ3NLL1VzODVWOGlzRStNcTVKL3JTMEhMT3AwUHlPSjl3UTdD?=
 =?utf-8?B?blIrMHZXWXJEaVJRV3ZYN1grcFdBZkNoNElkY29tYzN0NGdkRzJDLzVJRmJj?=
 =?utf-8?B?dWN3RHFNNnhORVdCdllkT29Ec0FFMUhyVHAvUlZkQ1BDa2dKaTFVWktwL3p2?=
 =?utf-8?B?SU50aEg4V0dZbHJDY0RyUVUxTTRmdmE3MnJVNnpIaEs1WjFuc0o5S0Z4NDdu?=
 =?utf-8?B?U0RiN1ByVU1VQy8xbDBieUxjR2JqOXorR01SakpCVEJ5YmE4NGZQbDdJZ2Fp?=
 =?utf-8?B?Z2M0Q1cveFcwSDI1ejBXSGtsYTY1Q1czQTNpSzRVNDRnQ3FVZk51TnJMbDVS?=
 =?utf-8?B?V2R4c1BXTEhRemNUbTVJWk5CQ1cxQmdFL3JOcXZOc2IyNFJxUFBsajd0Z0tQ?=
 =?utf-8?B?L1o2TU1ZOTY1dkV2V1V6b1VVR1ZveHk5ZWRyOVZWVUI5dytYQ2w0Mlg1TVdE?=
 =?utf-8?B?eE5oZW80ejFoWkxTWTZlQzRrNUNEeUR1cFVERnIvbTlwMkdnUW9xeGk0USt1?=
 =?utf-8?B?cW83RmFxWVdEVHRiYkJxQ3RxQWxHQ3FZbDRZRUlEYldEbTlqWHVqQTdzbHlw?=
 =?utf-8?B?Z0kyMlMrcXBaV2E0NCtpNVgySncwWGExeG0rUlIwdDUvd0ppQXdQbEhlZVh5?=
 =?utf-8?B?NFlXZ1UvejRBZk01TmJ5V2hrSndSaTd4cDkxUU50dWJhRHdXaWc5cGpLc2Zs?=
 =?utf-8?B?L2ZOaVVSbHc0cXMwRitTUEFlRWVETEJwajhOTjc0RVN4czVUUndlVmxsZ21F?=
 =?utf-8?B?WG9jTHV4TU9jdE9FeVJHbGkrRWwzYnpMVDVLNzdXOVFNQkx0Y0h1OVI5dkRB?=
 =?utf-8?B?TU9FaW12WUFTMW51OFZFMU1Qbm40QldVWmwybi9TWStHcW5UdHhFYS90S0Qr?=
 =?utf-8?B?YUhZdmxqUWg2VmIxblpwcjI0cUt0bHVNem5LQjhWWnE3TkFmZXJ5S0NodERl?=
 =?utf-8?B?aEpxNmphblhrandaWXNxQ3BKb1Z4anhQR3AxSythZG85cUxTRytyZHZKY2NM?=
 =?utf-8?B?dXBTNm1SaVovU1BiWWx5L3NIQUErQm9BaUt2SWdVYWpieXpNazVUTVBOb2Zu?=
 =?utf-8?B?ZWNVaXE4ejZUK1BwOWtSVDZkZ3Btb0x1ZVVQZnM2MDIvQ0pwT3dDMHR1WXRY?=
 =?utf-8?B?MUtQWEdWYmIwakl1dUtESytNY2VBLzJLclhYYUtPak1VQkg5UEdBUVpKM09p?=
 =?utf-8?B?SS9QTVRuaXowaWR6NjhhbDhOdHFpWlRXdjI0ZGVrTy9XZzBPa0tZMjEwSjNV?=
 =?utf-8?B?b24yV0VoMGdtTDR1bS9BaWxIUXlCZExRZ3JLWDFFSmU0WVhYVi8wSmc0UWV1?=
 =?utf-8?B?UFFlUmJZODRqRFFZV3hPNS9rMExIN2tTc0ZHaVJpdDVsMXNtMXdLb0ZXZVJ3?=
 =?utf-8?B?TFdKVmtZbm5HbHNpdXF5ZWVxTnl2T2JhakVBNmhtL2h3ckF0WXJ4UExlUXFS?=
 =?utf-8?B?cTJSSFNSUEdpbVBFZUlkNG9OWktLYWhHS2RKL3ZYazV5eDRUemhDM3N1Wklp?=
 =?utf-8?B?OG5FWExQSlZIdEVPYmh2NEhuTm1HVU9PQURVZGdhL0V6aXZlc01ZdWJ2U3BY?=
 =?utf-8?B?clVSSjg5WElnTVNxaDdwVHRGK2gvUTVaZlVncTZCb0s0Mk80SWlhUkQ1Vlcz?=
 =?utf-8?B?anRMV1ZCZWU0QUVtdWQ0N1ljTHdnQ2IvNGtWQlNTZFhuQ0NTcVV3RDdtVm8w?=
 =?utf-8?B?eFp4eFVSYkRmREJzMHVyNW5YcWt6VFFiWXZmM1RxRWtHVDBVcHY3c3BnemU0?=
 =?utf-8?B?WjVlb2pIUTlOMnB4SEczSWZuUS9wSW45b1ppUHJ6UWgwTVkvKzFRMUFxbk5F?=
 =?utf-8?B?ZFVBNHk1dEJqRlE2WWJHTy8zQnoydmF4OENwZXcra2dueHQ5VGhKazhzZEMz?=
 =?utf-8?B?TFVzOGxuQnFieVY0SUlEN0JuazZTQjB6eUtoM3R5Z3o0Y1dZSk53ZXNxM2l5?=
 =?utf-8?B?aEJOQUFSR0hyNUtGM21BVzJnUHA2QStkUzAwc1pvbE9qOG1lZGtWdENZb05J?=
 =?utf-8?B?SGppQ0tnbkwzYUcrQndVaFE3YXhhS09kZ2ZnMEpHa2txRk5ZWWVqa1loZWFj?=
 =?utf-8?B?N2JYamR0R3pGN25NUFMzek9DYTRvVEIxSGJNL0h5dURLTE0rMm5yRnJnZys1?=
 =?utf-8?B?dGpWR0VYbFpXK3QzK1NrblF6eGpsWVB2SmdYcTNMeHczcFA1TzhCamFwTWlv?=
 =?utf-8?B?RmNrd2RhT05Vd3Vzdk95UGdFblZrZEVpVzRnazQ4cGdSNUszRERWY3R3Wk1p?=
 =?utf-8?B?L1kwZGJMQStLQnYzdVE0UXh3TGNGdFE3SllDUEhmV1FjVGR2VnpVZ052R3ZI?=
 =?utf-8?B?QkNOdnN6V3FoaDk3L25UY2VDQThCYytwaUF6NnlBQzRrdmU5dmVlS3Y5YmVl?=
 =?utf-8?Q?hAABuDMTIKsIAEd0=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e36d2800-aa90-4d68-b0eb-08ded87fff82
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 21:22:19.5454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5iW3wKYfsgSICgKSBXsZIQh82EOUOQUDd3NBKLnrakDgqzEdvNpjHdWBvzNj9ry/ltAwkXjNKo/op2r3+rsUzSFkEp8mxOLJxiF5m7n6bhvWRekw1aDq5ZOv9TgVC6ih
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
	TAGGED_FROM(0.00)[bounces-12000-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nxp.com:mid,nxp.com:email,NXP1.onmicrosoft.com:dkim,vger.kernel.org:from_smtp,oss.nxp.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E80FB6FCF69

From: Frank Li <Frank.Li@nxp.com>

The current descriptor layout is:

  struct dw_edma_desc *desc
   └─ chunk list
        └─ burst[]

Creating a DMA descriptor requires at least two kzalloc() calls because
each chunk is allocated as a linked-list node. Since the number of bursts
is already known when the descriptor is created, this linked-list layer is
unnecessary.

Move the burst array directly into struct dw_edma_desc and remove the
struct dw_edma_chunk layer entirely.

Use start_burst and done_burst to track the current bursts, which current
are in the DMA link list.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v2
- remove debug code
- move "residue = desc->alloc_sz;"  in if(desc) check
- keep inline to avoid build warning
---
 drivers/dma/dw-edma/dw-edma-core.c | 141 ++++++++++++-------------------------
 drivers/dma/dw-edma/dw-edma-core.h |  24 ++++---
 2 files changed, 59 insertions(+), 106 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 01bee22fe3b3e..eead38897c42d 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -40,82 +40,52 @@ u64 dw_edma_get_pci_address(struct dw_edma_chan *chan, phys_addr_t cpu_addr)
 	return cpu_addr;
 }
 
-static struct dw_edma_chunk *dw_edma_alloc_chunk(struct dw_edma_desc *desc, u32 nburst)
-{
-	struct dw_edma_chan *chan = desc->chan;
-	struct dw_edma_chunk *chunk;
-
-	chunk = kzalloc_flex(*chunk, burst, nburst, GFP_NOWAIT);
-	if (unlikely(!chunk))
-		return NULL;
-
-	chunk->chan = chan;
-	/* Toggling change bit (CB) in each chunk, this is a mechanism to
-	 * inform the eDMA HW block that this is a new linked list ready
-	 * to be consumed.
-	 *  - Odd chunks originate CB equal to 0
-	 *  - Even chunks originate CB equal to 1
-	 */
-	chunk->cb = !(desc->chunks_alloc % 2);
-
-	chunk->nburst = nburst;
-
-	list_add_tail(&chunk->list, &desc->chunk_list);
-	desc->chunks_alloc++;
-
-	return chunk;
-}
-
-static struct dw_edma_desc *dw_edma_alloc_desc(struct dw_edma_chan *chan)
+static struct dw_edma_desc *
+dw_edma_alloc_desc(struct dw_edma_chan *chan, u32 nburst)
 {
 	struct dw_edma_desc *desc;
 
-	desc = kzalloc_obj(*desc, GFP_NOWAIT);
+	desc = kzalloc_flex(*desc, burst, nburst, GFP_NOWAIT);
 	if (unlikely(!desc))
 		return NULL;
 
 	desc->chan = chan;
-
-	INIT_LIST_HEAD(&desc->chunk_list);
+	desc->nburst = nburst;
+	desc->cb = true;
 
 	return desc;
 }
 
-static void dw_edma_free_desc(struct dw_edma_desc *desc)
-{
-	struct dw_edma_chunk *child, *_next;
-
-	/* Remove all the list elements */
-	list_for_each_entry_safe(child, _next, &desc->chunk_list, list) {
-		list_del(&child->list);
-		kfree(child);
-		desc->chunks_alloc--;
-	}
-
-	kfree(desc);
-}
-
 static void vchan_free_desc(struct virt_dma_desc *vdesc)
 {
-	dw_edma_free_desc(vd2dw_edma_desc(vdesc));
+	kfree(vd2dw_edma_desc(vdesc));
 }
 
-static void dw_edma_core_start(struct dw_edma_chunk *chunk, bool first)
+static void dw_edma_core_start(struct dw_edma_desc *desc, bool first)
 {
-	struct dw_edma_chan *chan = chunk->chan;
+	struct dw_edma_chan *chan = desc->chan;
 	u32 i = 0;
 
 	if (chan->non_ll) {
-		if (chunk->nburst == 1)
-			chan->dw->core->non_ll_start(chunk->chan, &chunk->burst[0]);
+		chan->dw->core->non_ll_start(chan, &desc->burst[desc->start_burst]);
+		desc->done_burst = desc->start_burst;
+		desc->start_burst += 1;
 		return;
 	}
 
-	for (i = 0; i < chunk->nburst; i++)
-		dw_edma_core_ll_data(chan, &chunk->burst[i], i, chunk->cb,
-				     i == chunk->nburst - 1);
+	for (i = 0; i < desc->nburst; i++) {
+		if (i == chan->ll_max - 1)
+			break;
+
+		dw_edma_core_ll_data(chan, &desc->burst[i + desc->start_burst],
+				     i, desc->cb,
+				     i == desc->nburst - 1 || i == chan->ll_max - 2);
+	}
+
+	desc->done_burst = desc->start_burst;
+	desc->start_burst += i;
 
-	dw_edma_core_ll_link(chan, i, chunk->cb, chan->ll_region.paddr);
+	dw_edma_core_ll_link(chan, i, desc->cb, chan->ll_region.paddr);
 
 	if (first)
 		dw_edma_core_ch_enable(chan);
@@ -125,7 +95,6 @@ static void dw_edma_core_start(struct dw_edma_chunk *chunk, bool first)
 
 static int dw_edma_start_transfer(struct dw_edma_chan *chan)
 {
-	struct dw_edma_chunk *child;
 	struct dw_edma_desc *desc;
 	struct virt_dma_desc *vd;
 
@@ -137,16 +106,9 @@ static int dw_edma_start_transfer(struct dw_edma_chan *chan)
 	if (!desc)
 		return 0;
 
-	child = list_first_entry_or_null(&desc->chunk_list,
-					 struct dw_edma_chunk, list);
-	if (!child)
-		return 0;
+	dw_edma_core_start(desc, !desc->start_burst);
 
-	dw_edma_core_start(child, !desc->xfer_sz);
-	desc->xfer_sz += child->xfer_sz;
-	list_del(&child->list);
-	kfree(child);
-	desc->chunks_alloc--;
+	desc->cb = !desc->cb;
 
 	return 1;
 }
@@ -337,8 +299,10 @@ dw_edma_device_tx_status(struct dma_chan *dchan, dma_cookie_t cookie,
 	vd = vchan_find_desc(&chan->vc, cookie);
 	if (vd) {
 		desc = vd2dw_edma_desc(vd);
-		if (desc)
-			residue = desc->alloc_sz - desc->xfer_sz;
+
+		residue = desc->alloc_sz;
+		if (desc && desc->done_burst)
+			residue -= desc->burst[desc->done_burst].xfer_sz;
 	}
 	spin_unlock_irqrestore(&chan->vc.lock, flags);
 
@@ -355,12 +319,10 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer,
 	struct dw_edma_chan *chan = dchan2dw_edma_chan(xfer->dchan);
 	enum dma_transfer_direction dir = xfer->direction;
 	struct scatterlist *sg = NULL;
-	struct dw_edma_chunk *chunk = NULL;
 	struct dw_edma_burst *burst;
 	struct dw_edma_desc *desc;
 	u64 src_addr, dst_addr;
 	size_t fsz = 0;
-	u32 bursts_max;
 	u32 cnt = 0;
 	u32 i;
 
@@ -418,17 +380,6 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer,
 		return NULL;
 	}
 
-	/*
-	 * For non-LL mode, only a single burst can be handled
-	 * in a single chunk unlike LL mode where multiple bursts
-	 * can be configured in a single chunk.
-	 */
-	bursts_max = chan->non_ll ? 1 : chan->ll_max;
-
-	desc = dw_edma_alloc_desc(chan);
-	if (unlikely(!desc))
-		goto err_alloc;
-
 	if (xfer->type == EDMA_XFER_INTERLEAVED) {
 		src_addr = xfer->xfer.il->src_start;
 		dst_addr = xfer->xfer.il->dst_start;
@@ -452,19 +403,15 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer,
 		fsz = xfer->xfer.il->frame_size;
 	}
 
+	desc = dw_edma_alloc_desc(chan, cnt);
+	if (unlikely(!desc))
+		return NULL;
+
 	for (i = 0; i < cnt; i++) {
 		if (xfer->type == EDMA_XFER_SCATTER_GATHER && !sg)
 			break;
 
-		if (!(i % chan->ll_max)) {
-			u32 n = min(cnt - i, chan->ll_max);
-
-			chunk = dw_edma_alloc_chunk(desc, n);
-			if (unlikely(!chunk))
-				goto err_alloc;
-		}
-
-		burst = chunk->burst + (i % chan->ll_max);
+		burst = desc->burst + i;
 
 		if (xfer->type == EDMA_XFER_CYCLIC)
 			burst->sz = xfer->xfer.cyclic.len;
@@ -473,8 +420,8 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer,
 		else if (xfer->type == EDMA_XFER_INTERLEAVED)
 			burst->sz = xfer->xfer.il->sgl[i % fsz].size;
 
-		chunk->xfer_sz += burst->sz;
 		desc->alloc_sz += burst->sz;
+		burst->xfer_sz = desc->alloc_sz;
 
 		if (dir == DMA_DEV_TO_MEM) {
 			burst->sar = src_addr;
@@ -529,12 +476,6 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer,
 	}
 
 	return vchan_tx_prep(&chan->vc, &desc->vd, xfer->flags);
-
-err_alloc:
-	if (desc)
-		dw_edma_free_desc(desc);
-
-	return NULL;
 }
 
 static struct dma_async_tx_descriptor *
@@ -605,8 +546,14 @@ static void dw_hdma_set_callback_result(struct virt_dma_desc *vd,
 		return;
 
 	desc = vd2dw_edma_desc(vd);
-	if (desc)
-		residue = desc->alloc_sz - desc->xfer_sz;
+	if (desc) {
+		residue = desc->alloc_sz;
+
+		if (result == DMA_TRANS_NOERROR)
+			residue -= desc->burst[desc->start_burst - 1].xfer_sz;
+		else if (desc->done_burst)
+			residue -= desc->burst[desc->done_burst - 1].xfer_sz;
+	}
 
 	res = &vd->tx_result;
 	res->result = result;
@@ -625,7 +572,7 @@ static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
 		switch (chan->request) {
 		case EDMA_REQ_NONE:
 			desc = vd2dw_edma_desc(vd);
-			if (!desc->chunks_alloc) {
+			if (desc->start_burst >= desc->nburst) {
 				dw_hdma_set_callback_result(vd,
 							    DMA_TRANS_NOERROR);
 				list_del(&vd->node);
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 4950c57fca34f..7f2ec871f5bd5 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -46,15 +46,8 @@ struct dw_edma_burst {
 	u64				sar;
 	u64				dar;
 	u32				sz;
-};
-
-struct dw_edma_chunk {
-	struct list_head		list;
-	struct dw_edma_chan		*chan;
-	u8				cb;
+	/* precalulate summary of previous burst total size */
 	u32				xfer_sz;
-	u32                             nburst;
-	struct dw_edma_burst            burst[] __counted_by(nburst);
 };
 
 struct dw_edma_desc {
@@ -66,6 +59,12 @@ struct dw_edma_desc {
 
 	u32				alloc_sz;
 	u32				xfer_sz;
+
+	u32				done_burst;
+	u32				start_burst;
+	u8				cb;
+	u32				nburst;
+	struct dw_edma_burst            burst[] __counted_by(nburst);
 };
 
 struct dw_edma_chan {
@@ -128,7 +127,6 @@ struct dw_edma_core_ops {
 	void (*ll_link)(struct dw_edma_chan *chan, u32 idx, bool cb, u64 addr);
 	void (*ch_doorbell)(struct dw_edma_chan *chan);
 	void (*ch_enable)(struct dw_edma_chan *chan);
-
 	void (*ch_config)(struct dw_edma_chan *chan);
 	void (*debugfs_on)(struct dw_edma *dw);
 	void (*ack_emulated_irq)(struct dw_edma *dw);
@@ -170,6 +168,14 @@ struct dw_edma_chan *dchan2dw_edma_chan(struct dma_chan *dchan)
 	return vc2dw_edma_chan(to_virt_chan(dchan));
 }
 
+static inline u64 dw_edma_core_get_ll_paddr(struct dw_edma_chan *chan)
+{
+	if (chan->dir == EDMA_DIR_WRITE)
+		return chan->dw->chip->ll_region_wr[chan->id].paddr;
+
+	return chan->dw->chip->ll_region_rd[chan->id].paddr;
+}
+
 static inline
 void dw_edma_core_off(struct dw_edma *dw)
 {

-- 
2.43.0


