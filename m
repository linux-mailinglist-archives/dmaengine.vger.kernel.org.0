Return-Path: <dmaengine+bounces-12331-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qcryB8QlUWoRAAMAu9opvQ
	(envelope-from <dmaengine+bounces-12331-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 19:03:00 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E73BC73CDDC
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 19:02:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=N1UpPwGC;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12331-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12331-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 323DE30DF5D2
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 16:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CF547B406;
	Fri, 10 Jul 2026 16:48:44 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013043.outbound.protection.outlook.com [52.101.83.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E323447AF6E;
	Fri, 10 Jul 2026 16:48:42 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783702124; cv=fail; b=sV4SEuUbR6zitEg8kxbJ9aK1CQGHe+LSoqSBY2GTVv12/qZKAXFTbK2k2gFAmeOpsltvjcGQkeI7OmtUF93WDZBnSePHVgnOdQXiIPQyafj25RP7B/Qv5QQv1dTlq61lRt6fAcahGho//0XCifd80nUoI9ktAc5dCvOlBn8hsTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783702124; c=relaxed/simple;
	bh=AVZsSw0HrLYQBf9udn9MjLxEwmoBA0vEoZ5MXxoIkFM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=DRZCv2E+9RYMTprKVisJ8+3SFzTS+nWaut1NjPUjd6r7NYn+SFU5VCiJU0ocp9lTrDbxB9zmhz34aasdTnVCm07GMSsp7EBHOfRZprqNgwKZVnlyBvo9SVYbh0pSsw6SzE4hCPnOiG0FnxSGFu9RvwtAnDN8aT8a0hMoexrliUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=N1UpPwGC; arc=fail smtp.client-ip=52.101.83.43
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DULG9pQxU3r95w1W2YeafGzsjhhdaNahoyQKsZ5C/xblBK+Tk/NRvw05WVfaXK/jz2AS55F8StLt0sLJMwj3DGaXdcVZKUdwhzcjoUvt6lPeLimawTxtSQ7G4/FE6KmfB2wCvdLEg2LkR3eNg/9jygC/Sq6PtZN6Ky+02ZoTqBnzf64dTLZZaXKNxBgv/CxLF1+j78UNeto7Dy9i8+kwTj6iItQntEbCW13QcguPwLHm8lqaRbATk1csWOhxgwD1T91+NWINmd+t3bmHibJer3JZrpz9RJ8vPEGfcIMDPSxv64kfaMawV53g0J9fNDf/pmM7VyDuCJbhfvzxvTZdxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KuOqUBJcu+CqytvgKgVH8NKXUlzsg1TPdrZPTggUNnE=;
 b=m1ng8OmWIhHw+YFHRsAgDvDyKJHiJj8SwF3qDZ/6sqERyj256wpmSUAKoFzM2zowly7yE744RZH9rk118C3a/kRtd6d7EW+/Y+k9VWwTn3lOeDSPEdcGAuElwymIoyOJr/zP4OL17MBxiJqO+vbDGVF9+t2M8L2vffdgz1RQwZpET/bmbZp816EOXn6Ed8+CCSeqe5PPwf75qW9zJB/es15GkPnAtkBwHJiuNKgZccBsSKFOFNkYAUwUtBPueF/WRGzbvpcCTv/kt/5FSlz+4Lk1Fl3cP5fsOGt5HWy7YlkFaFUZIP1WTwIsTOdlXxiNlXGBZkQz7vpifFadfse1Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KuOqUBJcu+CqytvgKgVH8NKXUlzsg1TPdrZPTggUNnE=;
 b=N1UpPwGCLAE09+hcrfrH1YZNbp85VOYVR/W65L+rExL59ciFw8Gy483It9EF5Y7qDM8MErqZvkOa6K+GHB9r17gCTtMA5qlR2UXMdgpY+zcjSsaeMF+viOgK/6n8SHoQN6OnmOTY8sGcPiZEIROa8arGxaQITbmjTLUHJzTssXI8oWHUs7mB6DeC+40srRmrV9LvpkABhHlzkbKQunFswKxW5/MdUezUvLVcBdB/vZJS1NfDVOPg26jeizO3adKTHWkKnTeXjy1Qd8R0I3Mb7gyckrQu01ti8FSCqh7+joRe8bpDIOKz5N+xhPMxx4rvxb/RkrPdd3XIE4yPGHML4g==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DU0PR04MB9345.eurprd04.prod.outlook.com (2603:10a6:10:355::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Fri, 10 Jul
 2026 16:48:39 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Fri, 10 Jul 2026
 16:48:38 +0000
From: Frank.Li@oss.nxp.com
Date: Fri, 10 Jul 2026 12:47:51 -0400
Subject: [PATCH v6 09/10] dmaengine: dw-edma: Use burst array instead of
 linked list
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260710-edma_ll-v6-9-1471d278b73a@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783702067; l=8144;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=/p+0WuLHwrBEh2B17a6pKbT6kptd7rafqFFtPFMoKbo=;
 b=3pN0tIbj+KmWy96uOZ29baQjD0YrHFnHU/S8CqV0xpJiy8f2YSqRRYAGaLzON6VAFo2CNnLmu
 gYgbNA6v9FhA/0RGWs9ZVky8m3gh5e3IRD2Bgy9PDA2iFj4XEtxerg6
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SN7PR18CA0027.namprd18.prod.outlook.com
 (2603:10b6:806:f3::22) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DU0PR04MB9345:EE_
X-MS-Office365-Filtering-Correlation-Id: 401bfa45-ed1e-41d1-608a-08dedea3174a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|19092799006|366016|23010399003|1800799024|921020|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	EdMgRnlgxFKUTF/oL34+4XSzgfmEORXP01C/JNEXPanxelczBddsL2b0WTwShq/Usxirlr/5DEQuRFwuUoVfo7ECgtOX7Q/IJmuYHk2Jfi/0sREdjtCJBCf+e9b/no+84CzBnRQXs2dP1zhhkrE1xznJAJcvnGQrv1+fTyKJ8ALSVpU+hOrnlD99KoCKjIciRb2lntKASR7/f0/4+O4y7I2XStOgEZ1qnCYiQuWPinp7tqL/r5VTAuFUCSZKc1iirty7X4auxVQ9r5WOkYK5gKHB/l7kjthXc7NAl0MnuVl/WO6NXi0Q0BIyiGpJixlqx9IAP/b8y7wl8ppxnzQJsCDhhXA39afnEsKCvxozGIgzWaLSUDJU8v2aHBrC34XYMhhM53HCiz31ee12xK1umMA3sMPoB0JxRpdNimn3UIG/bIhAZOv8aW9/GXZLn2zoEB0utgjlMxlh18DEgkfdj6TpM8PR+Ixy6vsKaA61YRWmOydW5sEtpY7HNDIeCwee8Whus0HiERCDmIxOn8W268NH7S2OrwZEFt1CWediZ7tSjqSxCv9KrmfKflQdCz/l2RNLlrqIFadRBrgOv3T2Lxt4HTAxawNPCbVBEiLbUGnCwgGFIt8EERk33OOjjSb13voJ/vDegfxQ7sv1vBiNQc33/+IVSjkU3nTJ0L5fOgwmHJkO77gFer8ZjidPpnPDzQLERIW+LERkIqID3vd7UQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(19092799006)(366016)(23010399003)(1800799024)(921020)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGsxUC9PRWY3bWZKSmRZREt6dlByUWhtK1N4UWJJTk5BbkZtS2orSzAwNEtK?=
 =?utf-8?B?Tmx6S0hFcGpxcDBKbGl5NHE1ckFsblFUYXM4OENzLzY3MVRxaTVhaTkxQVBO?=
 =?utf-8?B?MkxIMHRUR0xSWVlsUE9xNEJjYmkzQWhpdENWMjNuL2ViaHRmWjBGazRaODBw?=
 =?utf-8?B?R0FVUkxXWW9aOHVyd0h0cjRSWk8zanp3Rm9iNFFsZlpmYTcvUDRGSVlNT0ZZ?=
 =?utf-8?B?dFVBOHpySWE1VGpNZ3pDQ05tcE81aUxncEFCTmRWS0IwVFE0V3QwZy9FTkV6?=
 =?utf-8?B?QmhjdU9ZTDZGMnVSL3lEU1JEeFpiRmpUYWZWZkNsckxpWjU2Z0lJa2Jxd0FQ?=
 =?utf-8?B?Z1dUVGFBdEFORVhHcmpmQnVJbExXTUlJSXA4VHVvTzZDOG83M3c0b1ZVSFJU?=
 =?utf-8?B?Z3JEdFFaaFpnUm5MS3k0akhydEFEZ3pYVkZyNjZGK0FCUk4xdzM4bmNUUFFp?=
 =?utf-8?B?aGs5cU84VkhjbzJxeTgvbUVhVGo4eUlLNTBNdDZHZzRXQTNXRStoU0hObkJh?=
 =?utf-8?B?dWo2djhGWTBkQ3hxK3hHcC9lNGd3ZXZVeCtxaEQzRFl1cEpnU0ZKVEZWS3Mx?=
 =?utf-8?B?OUc2c2RxQTZSV25JUnNiT0FnUmNtazV1VTJ5R1kzYnVMbjNtWDJoMXZ3YVFw?=
 =?utf-8?B?Y1NSTUo1LzJtanA2MWZDT3ljZnhNQS81ZnB6b1BydEhHY1NTd09hVW1DZWI3?=
 =?utf-8?B?djVoeXdVWk9JMWJlZXcwYWo5RHpyMlpiMFRLbWU4bU1ON3B1a3h6S1FFdjls?=
 =?utf-8?B?UGFOUUdYeU5qL1UzMy9sQ3dVZHZ6Q0JBQ3FCdldUSXFadHdSNTFneEhmd0w2?=
 =?utf-8?B?ZENaSVF4S2svYTJnV0Q1UG50andyTGJrOWhZUVNLWFc2cFFwQ1Z6S3FOcWpp?=
 =?utf-8?B?aXRmSm9jT2hDZXR0dFZhQ0NOQzBNODZZeG5hVFNqdmFFUWk1QjVKdVdORCs4?=
 =?utf-8?B?WE9aZFpDSWtzb1ZsR3NWak1STjExbE1hYzdNdkd2NUlaRGdDMjJna0ZGd2U2?=
 =?utf-8?B?LzdXR2JRSHV2WkY3ZHY5UHBNZW9sVEtReE9oQWtPOVEwNEVZOEoyTHBONzlF?=
 =?utf-8?B?dDZ2OUcyZmVMUDQvT3RSVytDNkNKLytYQ0dKanhuL3dFOVZRbllWSmRGS3Rz?=
 =?utf-8?B?dUtVbjRUOXZBWDlhRnRRRVdsTTVOWWJRSmNSS2lUWmFoRWNDcUVNNDQ2ZzJs?=
 =?utf-8?B?dm9GcVNDQUsvVUJvTXVGRnFsN0JBTmlFQ3ppK1FGb3k1WFVtQ3BQaUJ3QS9q?=
 =?utf-8?B?ZDdyY3NUMkZ6OGg2c25jcTRIYU9DUkdJYVB1SUtPczIyaExaWFdIOURhR2xR?=
 =?utf-8?B?M01DaTBiN3huZHROcnJRMUxVZzh3Ly9kWkIwV3ZsN2FVWTNIS2tyQmdHQ0ZU?=
 =?utf-8?B?QldDOUdyN3k3NDBCbERoS1FwQkRvUGFBc0tTMG12ZjNnSStyOVFzMHZQbUw4?=
 =?utf-8?B?QjhwbHRMM1ZPQXlBclNMbm8vME10WG1MQy9iYk8rN3hJTHpPR1pwaUx4VTBV?=
 =?utf-8?B?N0dKU0tEOVlJMVVSdElrRVA5ZzV4SWJwdUlBYXBvMVVIb0NRUVNsdG9mMmpB?=
 =?utf-8?B?REZaMXZIaUYyaVdTamZaVnYvU0p1dVdiVmlabzFpV3c4eENNOWFTNGh0dDBT?=
 =?utf-8?B?UmI4c3diRE9LNlZJT2ZReUEvMVF1ZUZ1R1d4alJ0WkZpYXpOczhqYTJVWGdO?=
 =?utf-8?B?TTkxdDV1NFhSdXNtLzY5d3E4MnVoTWRTblVSZ0hNbXZnQkVBbTBmc0puSzVZ?=
 =?utf-8?B?NGVvamlGbmpVVVc4ZG5uZHhUUFlNWmNLaHk2WG10UEluK3JLQ053M2xvZXhX?=
 =?utf-8?B?dWxMSTdjbGYxQjNCcDI3cnc1L1poUTQ2V3RWR0dlT0lEZ0xXd1gxdlpaaHhY?=
 =?utf-8?B?MzVjc1NES3VvRGVFdUlCcDhtVmtsZ0ZLZkdkeDVncmtKeHpUQlZZRFNnbUZE?=
 =?utf-8?B?TjFDbVhKM0E1UGcrVDFaaHFVRVltZ3NZS1p2QlhOU053UGlOZ3p0c08zZ1Fv?=
 =?utf-8?B?RHZxRWlheWZMN1NaYi9EL0NsTEZsR0ZTVGtqWDcwWk1ORm44NmMvcHplY0tH?=
 =?utf-8?B?WHo2NDhlSngraTdMMkRDRzYvY2NNd2QwaDRnTi91a0hmaXJaMkdWMDgxTlBr?=
 =?utf-8?B?OS8rWXlvK09MWitPV0hIaGNvOU1XWHNjN1liSGxzWWkvbEE0WWtjeXpWUWtS?=
 =?utf-8?B?ZytNMENGY3hkV2xSeERpc2N1dFBKb0JsRWhSY040MTJvdnlHTjMxK1VWNjB5?=
 =?utf-8?B?TnczNXhqWDlvbkRWc1lrdXhFeHJrMFdMU1N5c2VoOFhuNG4xUGQybjJkT1Nk?=
 =?utf-8?B?cTlydTA1NDRtQmYxckNUOVVpZnpYcEQ4QmFWU3lGRXpDWDhzby9HWk9GYlFq?=
 =?utf-8?Q?WIF7KUiNKhfNUL7+tH3J7yzSVMyVwS7/IEPbl?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 401bfa45-ed1e-41d1-608a-08dedea3174a
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 16:48:38.8068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c3ywJCxLfL/xQoyn4Au3qLlqCCRUKvkN06k6RBo5Cqz7AQDGgd5jf4grNUYx5rvDHAAR7pWXMF8pLoMegaPXTskZeskEUMgd+EBFyJyUozTo+fw+MP/l6+t6m4B/+oT+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9345
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12331-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[NXP1.onmicrosoft.com:dkim,valinux.co.jp:email,oss.nxp.com:from_mime,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:mid,nxp.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E73BC73CDDC

From: Frank Li <Frank.Li@nxp.com>

The current descriptor layout is:

  struct dw_edma_desc *desc
   └─ chunk list
        └─ burst list

Creating a DMA descriptor requires at least three kzalloc() calls because
each burst is allocated as a linked-list node. Since the number of bursts
is already known when the descriptor is created, a linked list is not
necessary.

Allocate a burst array when creating each chunk to simplify the code and
eliminate one kzalloc() call.

Tested-by: Koichiro Den <den@valinux.co.jp>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v6
- use bursts_max instead of chan->ll_max because non-ll mode only allow
1 burst pre-transfer. Found by sashiko AI.

change in v4
- collect Koichiro tag
---
 drivers/dma/dw-edma/dw-edma-core.c | 120 +++++++------------------------------
 drivers/dma/dw-edma/dw-edma-core.h |   9 +--
 2 files changed, 26 insertions(+), 103 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index f52d9fd18e573..202862a828b4d 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -40,38 +40,15 @@ u64 dw_edma_get_pci_address(struct dw_edma_chan *chan, phys_addr_t cpu_addr)
 	return cpu_addr;
 }
 
-static struct dw_edma_burst *dw_edma_alloc_burst(struct dw_edma_chunk *chunk)
-{
-	struct dw_edma_burst *burst;
-
-	burst = kzalloc_obj(*burst, GFP_NOWAIT);
-	if (unlikely(!burst))
-		return NULL;
-
-	INIT_LIST_HEAD(&burst->list);
-	if (chunk->burst) {
-		/* Create and add new element into the linked list */
-		chunk->bursts_alloc++;
-		list_add_tail(&burst->list, &chunk->burst->list);
-	} else {
-		/* List head */
-		chunk->bursts_alloc = 0;
-		chunk->burst = burst;
-	}
-
-	return burst;
-}
-
-static struct dw_edma_chunk *dw_edma_alloc_chunk(struct dw_edma_desc *desc)
+static struct dw_edma_chunk *dw_edma_alloc_chunk(struct dw_edma_desc *desc, u32 nburst)
 {
 	struct dw_edma_chan *chan = desc->chan;
 	struct dw_edma_chunk *chunk;
 
-	chunk = kzalloc_obj(*chunk, GFP_NOWAIT);
+	chunk = kzalloc_flex(*chunk, burst, nburst, GFP_NOWAIT);
 	if (unlikely(!chunk))
 		return NULL;
 
-	INIT_LIST_HEAD(&chunk->list);
 	chunk->chan = chan;
 	/* Toggling change bit (CB) in each chunk, this is a mechanism to
 	 * inform the eDMA HW block that this is a new linked list ready
@@ -81,20 +58,10 @@ static struct dw_edma_chunk *dw_edma_alloc_chunk(struct dw_edma_desc *desc)
 	 */
 	chunk->cb = !(desc->chunks_alloc % 2);
 
-	if (desc->chunk) {
-		/* Create and add new element into the linked list */
-		if (!dw_edma_alloc_burst(chunk)) {
-			kfree(chunk);
-			return NULL;
-		}
-		desc->chunks_alloc++;
-		list_add_tail(&chunk->list, &desc->chunk->list);
-	} else {
-		/* List head */
-		chunk->burst = NULL;
-		desc->chunks_alloc = 0;
-		desc->chunk = chunk;
-	}
+	chunk->nburst = nburst;
+
+	list_add_tail(&chunk->list, &desc->chunk_list);
+	desc->chunks_alloc++;
 
 	return chunk;
 }
@@ -108,53 +75,23 @@ static struct dw_edma_desc *dw_edma_alloc_desc(struct dw_edma_chan *chan)
 		return NULL;
 
 	desc->chan = chan;
-	if (!dw_edma_alloc_chunk(desc)) {
-		kfree(desc);
-		return NULL;
-	}
 
-	return desc;
-}
+	INIT_LIST_HEAD(&desc->chunk_list);
 
-static void dw_edma_free_burst(struct dw_edma_chunk *chunk)
-{
-	struct dw_edma_burst *child, *_next;
-
-	/* Remove all the list elements */
-	list_for_each_entry_safe(child, _next, &chunk->burst->list, list) {
-		list_del(&child->list);
-		kfree(child);
-		chunk->bursts_alloc--;
-	}
-
-	/* Remove the list head */
-	kfree(child);
-	chunk->burst = NULL;
+	return desc;
 }
 
-static void dw_edma_free_chunk(struct dw_edma_desc *desc)
+static void dw_edma_free_desc(struct dw_edma_desc *desc)
 {
 	struct dw_edma_chunk *child, *_next;
 
-	if (!desc->chunk)
-		return;
-
 	/* Remove all the list elements */
-	list_for_each_entry_safe(child, _next, &desc->chunk->list, list) {
-		dw_edma_free_burst(child);
+	list_for_each_entry_safe(child, _next, &desc->chunk_list, list) {
 		list_del(&child->list);
 		kfree(child);
 		desc->chunks_alloc--;
 	}
 
-	/* Remove the list head */
-	kfree(child);
-	desc->chunk = NULL;
-}
-
-static void dw_edma_free_desc(struct dw_edma_desc *desc)
-{
-	dw_edma_free_chunk(desc);
 	kfree(desc);
 }
 
@@ -166,23 +103,17 @@ static void vchan_free_desc(struct virt_dma_desc *vdesc)
 static void dw_edma_core_start(struct dw_edma_chunk *chunk, bool first)
 {
 	struct dw_edma_chan *chan = chunk->chan;
-	struct dw_edma_burst *child;
 	u32 i = 0;
-	int j;
 
 	if (chan->non_ll) {
-		child = list_first_entry_or_null(&chunk->burst->list,
-						 struct dw_edma_burst, list);
-		if (child)
-			chan->dw->core->non_ll_start(chunk->chan, child);
+		if (chunk->nburst == 1)
+			chan->dw->core->non_ll_start(chunk->chan, &chunk->burst[0]);
 		return;
 	}
 
-	j = chunk->bursts_alloc;
-	list_for_each_entry(child, &chunk->burst->list, list) {
-		j--;
-		dw_edma_core_ll_data(chan, child, i++, chunk->cb, !j);
-	}
+	for (i = 0; i < chunk->nburst; i++)
+		dw_edma_core_ll_data(chan, &chunk->burst[i], i, chunk->cb,
+				     i == chunk->nburst - 1);
 
 	dw_edma_core_ll_link(chan, i, chunk->cb, chan->ll_region.paddr);
 
@@ -206,14 +137,13 @@ static int dw_edma_start_transfer(struct dw_edma_chan *chan)
 	if (!desc)
 		return 0;
 
-	child = list_first_entry_or_null(&desc->chunk->list,
+	child = list_first_entry_or_null(&desc->chunk_list,
 					 struct dw_edma_chunk, list);
 	if (!child)
 		return 0;
 
 	dw_edma_core_start(child, !desc->xfer_sz);
 	desc->xfer_sz += child->xfer_sz;
-	dw_edma_free_burst(child);
 	list_del(&child->list);
 	kfree(child);
 	desc->chunks_alloc--;
@@ -425,14 +355,14 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer,
 	struct dw_edma_chan *chan = dchan2dw_edma_chan(xfer->dchan);
 	enum dma_transfer_direction dir = xfer->direction;
 	struct scatterlist *sg = NULL;
-	struct dw_edma_chunk *chunk;
+	struct dw_edma_chunk *chunk = NULL;
 	struct dw_edma_burst *burst;
 	struct dw_edma_desc *desc;
 	u64 src_addr, dst_addr;
 	size_t fsz = 0;
 	u32 bursts_max;
 	u32 cnt = 0;
-	int i;
+	u32 i;
 
 	if (!chan->configured)
 		return NULL;
@@ -499,10 +429,6 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer,
 	if (unlikely(!desc))
 		goto err_alloc;
 
-	chunk = dw_edma_alloc_chunk(desc);
-	if (unlikely(!chunk))
-		goto err_alloc;
-
 	if (xfer->type == EDMA_XFER_INTERLEAVED) {
 		src_addr = xfer->xfer.il->src_start;
 		dst_addr = xfer->xfer.il->dst_start;
@@ -530,15 +456,15 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer,
 		if (xfer->type == EDMA_XFER_SCATTER_GATHER && !sg)
 			break;
 
-		if (chunk->bursts_alloc == bursts_max) {
-			chunk = dw_edma_alloc_chunk(desc);
+		if (!(i % bursts_max)) {
+			u32 n = min(cnt - i, bursts_max);
+
+			chunk = dw_edma_alloc_chunk(desc, n);
 			if (unlikely(!chunk))
 				goto err_alloc;
 		}
 
-		burst = dw_edma_alloc_burst(chunk);
-		if (unlikely(!burst))
-			goto err_alloc;
+		burst = chunk->burst + (i % chan->ll_max);
 
 		if (xfer->type == EDMA_XFER_CYCLIC)
 			burst->sz = xfer->xfer.cyclic.len;
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 27415f3a2d04b..4950c57fca34f 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -43,7 +43,6 @@ struct dw_edma_chan;
 struct dw_edma_chunk;
 
 struct dw_edma_burst {
-	struct list_head		list;
 	u64				sar;
 	u64				dar;
 	u32				sz;
@@ -52,18 +51,16 @@ struct dw_edma_burst {
 struct dw_edma_chunk {
 	struct list_head		list;
 	struct dw_edma_chan		*chan;
-	struct dw_edma_burst		*burst;
-
-	u32				bursts_alloc;
-
 	u8				cb;
 	u32				xfer_sz;
+	u32                             nburst;
+	struct dw_edma_burst            burst[] __counted_by(nburst);
 };
 
 struct dw_edma_desc {
 	struct virt_dma_desc		vd;
 	struct dw_edma_chan		*chan;
-	struct dw_edma_chunk		*chunk;
+	struct list_head		chunk_list;
 
 	u32				chunks_alloc;
 

-- 
2.43.0


