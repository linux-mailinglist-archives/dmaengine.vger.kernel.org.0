Return-Path: <dmaengine+bounces-11994-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id y2oUIHjWRmqgeQsAu9opvQ
	(envelope-from <dmaengine+bounces-11994-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 23:22:00 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E0AC66FCE9A
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 23:21:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=bugwICTF;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11994-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-11994-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E4B5E3035B41
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jul 2026 21:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF9A3914FE;
	Thu,  2 Jul 2026 21:21:56 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012048.outbound.protection.outlook.com [52.101.66.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3978C393DCA;
	Thu,  2 Jul 2026 21:21:54 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783027316; cv=fail; b=Q0UJnLHjECVWhH2oHJOtR4VEOQ7CuLKbwp/VpgSPgrVdXPj7GzqQFPrzDnfQeG4nt0D1v6Kk0ivM1XBYtAEaLZEQx/wYyCsQwH0CFuI+EQBiZZA0CpWDtgZKHWaX3/HXAyE9Nk8JmHH6YVFKD6Zd0NvUYMeJKlL63LQVf/o+W80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783027316; c=relaxed/simple;
	bh=b+Czz1cZx6Y+EoreXLnkjcUQ4HDcLTEV9ZX3nyx6M/I=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=bXTyeTaTZb2mnhO8sAwXhw0QA6ljwich1WIor7GvywN3JWTAHohfBrGxljpxTZq2MJdqVCb9RA61cnN+YhRgjnJa5uruIGuavFeASrqwwdYlAyr76yjCnPqUdqH8dPPQ54NEvQCanZZxhWYflyCZTxgvVqsQ3sy2k40IR5yLBIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=bugwICTF; arc=fail smtp.client-ip=52.101.66.48
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CyV263fJTM2cqZwHxMh9W1qfM7zuMXzScAFC4OoeXhrsMEE9ZoGT3ud8ifO/WeX53aF+Oj2OR2hWmQQ1J4lUZTowu5CfTWd/lT/qz6rFBO/DWzV2mRS0iaWcR47Wy6USlW9zUoTWD+EK9ZgzroOGEZZP9d7XWm7Eqlc0jWWFvsKUN5e1ealdpTcFgnaz/aeg6sogdFCQ+the5ehoxTTDyk/92lXjsRx672RGGdkqCtiUxHwijuqorZ7A0vMrs2Hxdw18+ve/F0Wu55j+aTbLfrjhIHss34HacepxI8jELA4oHty/r5j76AiLDRnmV3D0S0h+ujjTsF1hOhGqIT/xrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8kedgBmNG+SkeNQXANLNYeA+Hlr8AAJVtcREUrOmHNY=;
 b=FnOKzqD97+m/zN3yJATTvRGs0m8RCvE/0y4PZM1fZzO5feoN0bFKqTG+eh/Kr0VbxYmebUBcgU/f5DJqKEwbnrxylpNKDWoPs6sD0e//+/8qUEuTdB9uTmcPV3DsFbc5ZrYuzWpEzikSyVRCC3g5rJu89SL4ApXJpJib6S6HTbIOp2GCsSEDd0o9Usl2m3IdM/NZ0mxB+ITQ7bUMgxPlrrkz9YkeQ1csPIreIQi47ek/bHq4SlsrxGdXbY+UU7LkyGIvcIl6BUDtpE88Dy/We1FcEc8Ezth6y5buhbx64md3kxSYxtEVR4S9rn68skaNhBBnoggVa3/sko0AgGTuog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8kedgBmNG+SkeNQXANLNYeA+Hlr8AAJVtcREUrOmHNY=;
 b=bugwICTFW92j4lhKczw4dXm/11fKwR01GSelzH1Ih8WDEJQllxVDGRh0yuXYyi3+eSunAM4SH83yE7we18BwO4iRwFENKALmEm45kl8OKZcx+gNRE3WYvqthaTevMaypl5Vr1XY8PLo1aSEEIuXUris7TFkfNGQn2x+RxZXghaWoC13zzDnmoSlg4eMPEdpUyVnOWh0rTiW2dGPXcLRTRo8MKuKr0nmGzuAJ40uZ53ZXLNYWhh2+cKJjfFPXxVTXHo6NpZijVuk2N4nwH+IpIDm6mGs3agrkWQGFXFp/cGNtFjC/a2ZDAQ6UD1mc0S93jhf/kklhZW5K8UEWVtfKvA==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GV1PR04MB9213.eurprd04.prod.outlook.com (2603:10a6:150:28::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Thu, 2 Jul
 2026 21:21:50 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Thu, 2 Jul 2026
 21:21:50 +0000
From: Frank.Li@oss.nxp.com
Date: Thu, 02 Jul 2026 17:21:24 -0400
Subject: [PATCH v3 04/10] dmaengine: dw-edma: Pass down dw_edma_chan to
 reduce one level of indirection
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-edma_ll-v3-4-877aa463740c@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783027287; l=6830;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=DkdG/AiYL8t0sTOt4gdXWRGmarqWBDwRG1A/sA1MRsY=;
 b=x9S/6OoXlF0HY6A8ajdtCQ/x8HZoXJIQ85jVqW+JeBJ69BU/qD8VQziNSUIxSvxajDzh0ERIB
 dR65NHxbOmOD5NgbG1EXQf3n+CCvUr/tg0A5eC7rg/3DgYVArgDUukt
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA1P222CA0187.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::14) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GV1PR04MB9213:EE_
X-MS-Office365-Filtering-Correlation-Id: bfbfa91c-e380-4660-7815-08ded87fee5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|19092799006|23010399003|11063799006|22082099003|56012099006|6133799003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	iVjKxOJjzFx97RjsaqHF3ZkNH0q+TKyOFulf0T/7pqN+3/O15IAmq1uQP91qF0nQK5qmEtNmp4MSobRetLRyNBqyiKwX7NI2muyzL7pnU3iQnH+Yog4cbRh25PjrbdDbrqlgRs2W3fUc/2KLgEYAi0v3WRRDDnixJaAmjM1hFdOxFJQaVTwGHexK/3IXH0e8R9nK/KWQSSsReQrwyKuKEO4T0cyMrKvfheNGqCYmSFZgbgAYF3aEYozLdlR8Cf7WAH+Y81eTQw0N6kOOR732/imF1C2bd1FwMJtul+1elwT3Y6ptqGKGGE9B/JEYNxE4mCVecClEDex/fVMHu+aH9J+lOe2178ZIqOR8SH5WDMZaGbS6C6QududJwwGDBhf7Dt0TTp5wmqTQcBeG0CR6CXk0bMml2LYi6OIdid2u6aZ07uyHONL718g+zuGFlKSt2TOjnF7a1VnT06Fbacw7lg97dANGMts5sdNVSW0KiN4jEi8UPa5R+8i4w5vx6kkUd0Yl80csoAkGu8Jym/lbaLeT/rFKRBFY3+u6a5EcSdyNrUIPziibdi/Vk8WgmULNQg42LBbQmhQVP1Q/LWvFbpTE61yOuRNTXC8o+AANHIfhoPSFqwMZ7meuzE4drUOlwGEDucOo2WwY2fUzjqmV6e54pqE0uy+PEZFbio26PjVh2UMFbazmLjIUdUeivndMMqt5A+/w/xcc7YdXu3GM0Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(19092799006)(23010399003)(11063799006)(22082099003)(56012099006)(6133799003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L3R4dlpBMGtFZ0lNODlzRldoYVdRSFNkT2wvR3BRUVA1S3FHQXVYclZ5UUNH?=
 =?utf-8?B?RU9aamtCVU1MT1lWMG1XbCs4SlBOblcyckh5djc0NWt5RWxOU0xkQ0Qzd0lU?=
 =?utf-8?B?SFhXOEJ0TXBUNXFYNFduV3BVdzhZeVpyRHcxRFZKMnpUc0x0ZU1wNktTcEdK?=
 =?utf-8?B?djJNVlBRTGg0dC9LWnZTZDBIODZwczZTbUtzd3kwdWNGaGkvOFJxalNwM1p3?=
 =?utf-8?B?MTR5c0Zwa3dZT0JLRlhNMSs4WVFqU3d4UEF4QXZyTUIyNnNkUzdTVDZYQUtj?=
 =?utf-8?B?RGtTdkZ0OGlZdXVCZkg1QUd6bkQ4dDFvakNMclJxak16Q3lsY1hTMVk3bEhE?=
 =?utf-8?B?aklpd0htdkxabFNwUE9YNThkT2tETGtLZlhsU3dKYjBEdFpCMEkrZ1BMVXFE?=
 =?utf-8?B?dWliZzJOM3JkOEtwb1NGbjl1M09LZ0pta3lmdit5M1pQNVdiaTBKMEZrRlRx?=
 =?utf-8?B?bWR4OCtOOWY4VFhvck1aQ2hLSWowY2NpS1VXNGlWVlVpRm95bFl3ZGdIdjdj?=
 =?utf-8?B?SXlqU05HZkJJRm9wdlJ6NVFUekZFMCs2THI2dENSUWZsYXRnc0ZzK0tKS0Rh?=
 =?utf-8?B?cDBWUEh4KzJFT0t0Y2x5am0wc0RWUGZWMjBhdGxya3JYVS83N2xBbDhjZ0I3?=
 =?utf-8?B?bnUzdlk4bm4xZDVQMm1QQVNXNXlDcFhpRHkvR3QxajdNWW50ODFOSTR5YjM2?=
 =?utf-8?B?djVWWXZnN0tFcWR4Rm9NOXVZNXR5bEQvZ2tSWW4rVnFKcy8zdXdTdE45VnFp?=
 =?utf-8?B?Y3lJU2cxa0NLdGpJczh0a3dvdXBibVRBbWoxQXZ3bm1mUzk4NzcwZmk4T0lq?=
 =?utf-8?B?M0NDdm1RRjRBUU1kQ2thdTROaVNsNk5sMjV2Q3pkaXRWcjY0ZFd6NzJlckhs?=
 =?utf-8?B?RE1DV2NtZklzaG9qN2NSdWZBU1NHY0tUVlZ2ZjErOHZQc0NTVGFIcmc0NmpO?=
 =?utf-8?B?VDFWeE1RdHBVK1BNeEdxZU1QZlRVQTcyblVpeHRlMjdmdDRMYWdFREVhdU5T?=
 =?utf-8?B?RXZBVzJ6ZHFpVFI4N1M5WTRDOVRCZlJXWGdZVVBSYVc5dVcyUWRFVi9vU0pK?=
 =?utf-8?B?R1I1Si93SGN3VzRHNDI2TU4zUlJjQm4zbjMvbDZqZHdvRUd1aURGa3hNODZJ?=
 =?utf-8?B?THdhUEF6Y0FPQ2Z1UnhMTnA1aDJrL1VMVjFwSzlHbWkzSzZlclFHNXpidVVB?=
 =?utf-8?B?OEdHeVN4bUcwV1RtSFI5NlYranBJdFQ0UlA0aVZKT0gvOVVENUVTcWlGTWwv?=
 =?utf-8?B?cFk4Q0FHQnVEdGNFOVNBSXB3Z0Y4dlpoQ0tObVZSTFZiQ2lOSThZRWJ2YmNG?=
 =?utf-8?B?RmlpQ3J1cEpSUzI0cElMcUc0clhKQWNwWFpFZ2hLT1I3aHhnbVdMNDRpZDls?=
 =?utf-8?B?cC9CNFVRbGlvcjBnSk84SGc1UTRpc1F1cFc0bWEzMjFQYVliTEowSDI3M1J1?=
 =?utf-8?B?VHAreEVvOWJEUEZNVkdtM1FZZW1LWHV6RGNrZDl0OTZ6cXpiaUd3VjYvNzBT?=
 =?utf-8?B?VzJUWCtYUGN3RTcrVGQvbWZmQXgyWmU1OFN0d285NGl0NjNBWDhmcUR1K2R1?=
 =?utf-8?B?RTVEcUhaWENTd3ZTdEE2bnN6d2ttay9TcHBydFVmd1pHSHdLYWluUTVQSHAz?=
 =?utf-8?B?Wkorc3UzTG4rODBPTUtKYnNZMlhhOHFFZTBlY1pEdkR0dkJyZzhpcnFobTMr?=
 =?utf-8?B?V1pybnlvZmo2cE04V3o1c05KZXZWOTJ2MlBzWVNDb3V3RmQ1WHE0ZFJOWFk1?=
 =?utf-8?B?MVprNlo0VTZCamNjRTlaY1ZndWJsZWIxZG1WVjNtanVJWVNuWG0vekZvb1d2?=
 =?utf-8?B?ME8yWW43WU5tLzlIWDl5dHREVVdGU205M3hMUHBzRms0RGFHT01ZZWczOVAx?=
 =?utf-8?B?YWpiR1NHNkVTQmczakZEMTNidkJtVlF0Z3NWSUhSMFBMRkVaR2RxODJnUUVm?=
 =?utf-8?B?bWM5dzhvSWVmOTJ0eFVZZGhaRmVWdUxiQktVTzVZU0Z0Y250QjF3bUovejgw?=
 =?utf-8?B?Qkl6WGkxeC94TFo4d1hmYklQOUZwYytCM2xMa3p0elY3bkd4ejhURFM5V0t4?=
 =?utf-8?B?UDI3NTBSTktLekpteFFtRE1YSG1EQ1p1MVdhVmtkWE5OOTI5U09JUUE1SzVE?=
 =?utf-8?B?eHNRd3d0L0R2RE5KbC9WZ3hCWlJEV3JET1FMVGZLNVE0dmg0ZTZUUUFrSjNp?=
 =?utf-8?B?SkE4WFBuK3BUakJoMGd5eTdMWlg5MVV6QXZpZVk3REpQbXludFg1dTJPbGla?=
 =?utf-8?B?LzlldlNvbTBaL243Q2lwclZXRE9wdWVoSDBlby9kZ0JsRERpKzllYlZ3NmJx?=
 =?utf-8?B?VW5qWXEvcEtPdkV1WFJYUlk0dWZERmZYMFA1MUtWck1yYUtCMjFtN0VTT2xu?=
 =?utf-8?Q?/cLtlQ8GsNZwSw8q3P6xvEmci5OZum9cWUBEq?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfbfa91c-e380-4660-7815-08ded87fee5f
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 21:21:50.7517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dgu+K01OFctjZrb/8J8mQT6fCQjg0kVyEt+KzXojaSmEAZSNb/p7ZTpcUes16ZIvkOAdQQdVNww7UooIIT+Gn8xNLNWzKk1nU+5GLpKUAZQBTAMIi/mG1t7yP41JlGW9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9213
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11994-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nxp.com:mid,nxp.com:email,oss.nxp.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E0AC66FCE9A

From: Frank Li <Frank.Li@nxp.com>

Some helper functions do not use any information from dw_edma_chunk, so
passing a dw_edma_chan pointer directly avoids an unnecessary level of
pointer dereferencing and simplifies data access.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/dw-edma/dw-edma-v0-core.c | 22 ++++++++++------------
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 23 +++++++++++------------
 2 files changed, 21 insertions(+), 24 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index 51e50f1fdcac4..c341aa5343417 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -276,13 +276,12 @@ dw_edma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 	return ret;
 }
 
-static void dw_edma_v0_write_ll_data(struct dw_edma_chunk *chunk, int i,
+static void dw_edma_v0_write_ll_data(struct dw_edma_chan *chan, int i,
 				     u32 control, u32 size, u64 sar, u64 dar)
 {
 	ptrdiff_t ofs = i * sizeof(struct dw_edma_v0_lli);
-	struct dw_edma_chan *chan = chunk->chan;
 
-	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
+	if (chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
 		struct dw_edma_v0_lli *lli = chan->ll_region.vaddr.mem + ofs;
 
 		lli->transfer_size = size;
@@ -300,13 +299,12 @@ static void dw_edma_v0_write_ll_data(struct dw_edma_chunk *chunk, int i,
 	}
 }
 
-static void dw_edma_v0_write_ll_link(struct dw_edma_chunk *chunk,
+static void dw_edma_v0_write_ll_link(struct dw_edma_chan *chan,
 				     int i, u32 control, u64 pointer)
 {
 	ptrdiff_t ofs = i * sizeof(struct dw_edma_v0_lli);
-	struct dw_edma_chan *chan = chunk->chan;
 
-	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
+	if (chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
 		struct dw_edma_v0_llp *llp = chan->ll_region.vaddr.mem + ofs;
 
 		llp->llp.reg = pointer;
@@ -339,7 +337,7 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 				control |= DW_EDMA_V0_RIE;
 		}
 
-		dw_edma_v0_write_ll_data(chunk, i++, control, child->sz,
+		dw_edma_v0_write_ll_data(chan, i++, control, child->sz,
 					 child->sar, child->dar);
 	}
 
@@ -347,10 +345,10 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 	if (!chunk->cb)
 		control |= DW_EDMA_V0_CB;
 
-	dw_edma_v0_write_ll_link(chunk, i, control, chan->ll_region.paddr);
+	dw_edma_v0_write_ll_link(chan, i, control, chan->ll_region.paddr);
 }
 
-static void dw_edma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
+static void dw_edma_v0_sync_ll_data(struct dw_edma_chan *chan)
 {
 	/*
 	 * In case of remote eDMA engine setup, the DW PCIe RP/EP internal
@@ -360,8 +358,8 @@ static void dw_edma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
 	 * LL memory in a hope that the MRd TLP will return only after the
 	 * last MWr TLP is completed
 	 */
-	if (!(chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
-		readl(chunk->chan->ll_region.vaddr.io);
+	if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
+		readl(chan->ll_region.vaddr.io);
 }
 
 static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
@@ -437,7 +435,7 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 			  upper_32_bits(chan->ll_region.paddr));
 	}
 
-	dw_edma_v0_sync_ll_data(chunk);
+	dw_edma_v0_sync_ll_data(chan);
 
 	/* Doorbell */
 	SET_RW_32(dw, chan->dir, doorbell,
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 20089d57f8ab0..156b1cc225091 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -152,13 +152,12 @@ dw_hdma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 	return ret;
 }
 
-static void dw_hdma_v0_write_ll_data(struct dw_edma_chunk *chunk, int i,
+static void dw_hdma_v0_write_ll_data(struct dw_edma_chan *chan, int i,
 				     u32 control, u32 size, u64 sar, u64 dar)
 {
 	ptrdiff_t ofs = i * sizeof(struct dw_hdma_v0_lli);
-	struct dw_edma_chan *chan = chunk->chan;
 
-	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
+	if (chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
 		struct dw_hdma_v0_lli *lli = chan->ll_region.vaddr.mem + ofs;
 
 		lli->transfer_size = size;
@@ -176,13 +175,12 @@ static void dw_hdma_v0_write_ll_data(struct dw_edma_chunk *chunk, int i,
 	}
 }
 
-static void dw_hdma_v0_write_ll_link(struct dw_edma_chunk *chunk,
+static void dw_hdma_v0_write_ll_link(struct dw_edma_chan *chan,
 				     int i, u32 control, u64 pointer)
 {
 	ptrdiff_t ofs = i * sizeof(struct dw_hdma_v0_lli);
-	struct dw_edma_chan *chan = chunk->chan;
 
-	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
+	if (chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
 		struct dw_hdma_v0_llp *llp = chan->ll_region.vaddr.mem + ofs;
 
 		llp->llp.reg = pointer;
@@ -198,6 +196,7 @@ static void dw_hdma_v0_write_ll_link(struct dw_edma_chunk *chunk,
 
 static void dw_hdma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 {
+	struct dw_edma_chan *chan = chunk->chan;
 	struct dw_edma_burst *child;
 	u32 control = 0, i = 0;
 
@@ -205,17 +204,17 @@ static void dw_hdma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 		control = DW_HDMA_V0_CB;
 
 	list_for_each_entry(child, &chunk->burst->list, list)
-		dw_hdma_v0_write_ll_data(chunk, i++, control, child->sz,
+		dw_hdma_v0_write_ll_data(chan, i++, control, child->sz,
 					 child->sar, child->dar);
 
 	control = DW_HDMA_V0_LLP | DW_HDMA_V0_TCB;
 	if (!chunk->cb)
 		control |= DW_HDMA_V0_CB;
 
-	dw_hdma_v0_write_ll_link(chunk, i, control, chunk->chan->ll_region.paddr);
+	dw_hdma_v0_write_ll_link(chan, i, control, chunk->chan->ll_region.paddr);
 }
 
-static void dw_hdma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
+static void dw_hdma_v0_sync_ll_data(struct dw_edma_chan *chan)
 {
 	/*
 	 * In case of remote HDMA engine setup, the DW PCIe RP/EP internal
@@ -225,8 +224,8 @@ static void dw_hdma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
 	 * LL memory in a hope that the MRd TLP will return only after the
 	 * last MWr TLP is completed
 	 */
-	if (!(chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
-		readl(chunk->chan->ll_region.vaddr.io);
+	if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
+		readl(chan->ll_region.vaddr.io);
 }
 
 static void dw_hdma_v0_core_ll_start(struct dw_edma_chunk *chunk, bool first)
@@ -261,7 +260,7 @@ static void dw_hdma_v0_core_ll_start(struct dw_edma_chunk *chunk, bool first)
 			HDMA_V0_CONSUMER_CYCLE_STAT | HDMA_V0_CONSUMER_CYCLE_BIT);
 	}
 
-	dw_hdma_v0_sync_ll_data(chunk);
+	dw_hdma_v0_sync_ll_data(chan);
 
 	/* Doorbell */
 	SET_CH_32(dw, chan->dir, chan->id, doorbell, HDMA_V0_DOORBELL_START);

-- 
2.43.0


