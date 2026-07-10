Return-Path: <dmaengine+bounces-12328-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fizlHE8lUWro/wIAu9opvQ
	(envelope-from <dmaengine+bounces-12328-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 19:01:03 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D452073CD81
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 19:01:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=Iz++7dDH;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12328-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12328-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BC62D30C433F
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 16:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7D4477993;
	Fri, 10 Jul 2026 16:48:28 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011019.outbound.protection.outlook.com [52.101.70.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818F7472796;
	Fri, 10 Jul 2026 16:48:26 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783702108; cv=fail; b=ZnWl+NIvaEpa0BuHYhGC9RIizIyK3wkdvMuOyERTlqOOWkke0fhwzZ4+VA9j4pjVjqBgA1q4Vlv5QkCnHQSn6FBd9PKb4KfEnv322ILPBPiZUtYkry8VtVCaI/9bA3ZRU2ykFBW0dTzWxpCEhmA8TX04H16yNVWp+cgzwyOpec0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783702108; c=relaxed/simple;
	bh=63u36oIWW499CxCVD3CUgF2pj86oGpHE6a4veN4CLu4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=rAKcWDXweEe8ytUawWspBRKyRF0K0S/OAcy0l8IqOtU1Gih932+MKaMN0xHQoumOIdeSxPXY3gxnRs91WJVdb3DEt5MYG2rGv/IDSUm5bZpreIarvcWMCex8IkgmUclHCmRUf9yAJZZvtNEW8m+rM3A3SwOg4KluC5DYPbtiPMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Iz++7dDH; arc=fail smtp.client-ip=52.101.70.19
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N8j7HPf3byMhCZvHdNGMfmwH8YIq0M2rsilH0BKPRoz9oh97YZfp13hZjKcuSUTkfQl4xefRPvL7v7dZ1AKpZjD8Gpxo64wfuKCd3HlCQkwtBxukMiuv2U7aNAsQ2LFkg3dCWm7CCnlKWplZXW0WH4q+pKZFKN9ek7A6zWes3F/WtQQMNu4yoA3SViLHQjwcImNu3kq80lLyGNqAlpeUaVIWwWmf0X/C9eTE2YhaL6mE40wwbwPbsNaljuuU1ItJ7s36XNjOwsT3mjkiKVw/N+qswinEYGenXr7YgRzQzJ2Q4/SJl6oUGb8dDEJ++QXV7whFC2xJ87LkUlsCHukbjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oxheSaLiwGk/Z55GRV8TcDjvGiFBVTuuLT0jCpc35Iw=;
 b=B0hpTv9pv4JWOSgkPkzEdTfYNJIRx+JGYXcxUdHyw/xr2ZI8UoJimCjbmIp7tm1T+AlcMREAJs8Dhkteuo1B+PLJ9SP6JLwpjA+V0+tYbXioyEcHpWROz2jpR3cRgew/yBMwlOaKHT/6gyORqMcatlb7rMis79e6Twgu3P5edxGRw1157W/az5n/rp+7uTZxGO7Lw2OLHupFQcUWMx7VbAyxWTmVgCmh21y/YkNonDw7KX9v96uygTG0wbKxoW5DK7EvMCmRiAj2JzEGBlgvrBkK2yNppTAfTbcFgTMV8+kdSzBpVN0etFYXg2cOCwMFlN3AfuUytZLG0lm3mLxMgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oxheSaLiwGk/Z55GRV8TcDjvGiFBVTuuLT0jCpc35Iw=;
 b=Iz++7dDHJOqu5ULajTWKNmr8XMf6rFpJZcUyr6w8yVfmANSM8Ar1BR+NF5OdEhX0IxL/6yZ4OuVF12TsEfs2E0JT5bFrCOX+/ORxy65I3m/x07PChwmSXYzeRqxcqtfYAjWqFRe7NlbmAT6o3yRTXem/gNwJFW25HR7uuwwMmeW4USrMZC2y4NA6VJLTcCYw/JnVEuNCQXsJRR7J+dp0VPx/C50Z7LtgJ3v8t8+bocHtOiCmVrUUd3U0JSiAVJ6qMTceXD5g9h/IwhIHdxpUoAfRJzdWmu91GfUo/moK5k496FT2TK8E4Ub/g8mv0Xe5GimHiku4+juhXcYGsWPlEw==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DU0PR04MB9345.eurprd04.prod.outlook.com (2603:10a6:10:355::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Fri, 10 Jul
 2026 16:48:24 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Fri, 10 Jul 2026
 16:48:24 +0000
From: Frank.Li@oss.nxp.com
Date: Fri, 10 Jul 2026 12:47:48 -0400
Subject: [PATCH v6 06/10] dmaengine: dw-edma: Add callbacks to fill link
 list entries
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-edma_ll-v6-6-1471d278b73a@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783702067; l=6410;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=nGpsMS8wEDHjpy4/wW160YouUvzq4Rld0wqWY/q9z50=;
 b=mLEmFsoB6OOI6kdQ/BsuEV7iIicFFylZqiVI40H/RFwQQPqw/cokL7sHwSRaL2BjSHLhDHWsu
 iDpzJl1eAzgC2ytgG8EuOmAdK7XIqwCJz80d6wFMtmH1PESvpBR4pBF
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH8PR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:510:2cc::8) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DU0PR04MB9345:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e02451d-c2c4-42e4-3672-08dedea30ee3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|19092799006|366016|23010399003|1800799024|921020|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ZrpU2ipNi0ZmAI7jwy7KhrTzQJwMG+dlU7kFsvQzgqIAYLsTIJ/WdZU2NcwyvbexTarMkLvzrrPYl7TUKGjBcUQ149wDP8bhXRi21gWKqMyysXJ/wpmmgNmwVQLXOaQvLzIUie+HDCXh+NWDdzQ8XotcGH0RT8OD9RyfiJ/kQBmeGA+t1YRKyeEmmtZoaRRUZzJDy3eZOb1FtTMm2c3WvDYJq0H4yZk629mZBw0Y9Q+wxMJUF9Zi9fp5GQpLp69sYhd7WeSedcmRWFGkbgrqqVBOcKMRzn6JhD/dMX+lvNcdCVuh/e5fGrXGAX3Gdh2LGEJZRu2HV9p4oiVDa5f81+hKpsboieOZ8/Xk8221rRWX2tK249CuHOlZRSM7/qtqxxG2yFPcbbWxA176XeeyB5ZezSAk5evnG+prRd1vC110GDqE2wfEFbwdBnPNJZ4S6kaECZGKySyh55m638lwPRSj9JffDT9bu35DWhJGLKLkCrxVPk8WXPuc+pPFMJLclKVXyO11B4Ab2bvoChE+rghCHWcbW0JXfGvmpRf/JvxErciVCABPFF+FRTCaaZlXcnWb4etMBs060AqrpfkARVJEkXSk6y091eNwocXs/ypOoVZvO6iz/u6+mw/zVR70Sr5NAJy4o44ov1dZ9yDARlRo3lyDixTZuaIUU9Z39GLqGjROgaDB+Ng9qUeHBAV4T2wer8IP36D0fjwYulxDjA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(19092799006)(366016)(23010399003)(1800799024)(921020)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K04vZmFwd0dzdm5GNGY0RzZVem9nTzlzZUlsT2V6d0pUWnU0QUl0dVQ5Vzds?=
 =?utf-8?B?R2tJVTVQVG81dHNSajNuQWFQSnFZZlF4R3pYUTUwUDBid2VXRXF6UWIrWVVk?=
 =?utf-8?B?R3l2OVljdi83NGRaZ1NiK05SSG04c1Fhei91QWhXMU9xL1lpWm1SMDZvSFc3?=
 =?utf-8?B?VktoK2NMSW4rUEpQQ1NNTVUrTXd4UEJGUEY5TENFRCtZZnVSUU5lV0VkSmRk?=
 =?utf-8?B?Z1NlcS9yZ3NXRjRSR0pqVkR5NW80cFF6M1dOVEJ3T1lJU3Z5aDFGQ3pLY3hz?=
 =?utf-8?B?aFF5aU8yUk1kVWdXL3Q3MDZNOFVOR3ZNR09Gam82a216dm9pd2Z6SURyQzhl?=
 =?utf-8?B?Z0hlcCt5enlqQ2J6V3JmUG92Y3QyQVNyd01kWVNwL2l1WjNuN0phcy9kQXh3?=
 =?utf-8?B?QXYvMDVrM3FYalpOMURiY04wN0NmVjN1RUI3SkJOV1pMdWJydlYvclZ2VkRG?=
 =?utf-8?B?akc5SU85S1dlMEVpWUpXdUtUc0tEcmR5N1kwcDdlZTFORy85dW50NllJc3RJ?=
 =?utf-8?B?K0ZyYTQ2UXVtMkdWQzQ4VmxScE9QNEJZQWp6RkV2cGNIelJYUmpLVFZPZzIx?=
 =?utf-8?B?czJIY3lWbUxMWk11eUFlMXFiUENFam5CeVVIMGZ4b3lVdXlBc1gzYkxKQ04v?=
 =?utf-8?B?eFhKUjhOV0QySWtMM2N1QlhCc2hoS3pBa3dQR1JvcUhsbWRxeFQ1SS9lZDI4?=
 =?utf-8?B?Z2RLZURrbkxuajNCdkJyTHozSXVpOWZOWUNjUGJ6UzcxaDdrbnpNbzBFYVFD?=
 =?utf-8?B?dzdCOGIxZ2lSL1N3Q3c1OHNNOE95RGswVW10RnRaZ0t2MDhjWjh1c2duWnhV?=
 =?utf-8?B?UkcrTjlJY2pTai93VE4rdzdRRWJOWjRvb2Nna1MwSGRLcFdhOHZqaTZPRFZj?=
 =?utf-8?B?VGMxWUl3L091R3V4NGRlaTNIZ1NiWkJIVXpvZU5TWi92bTBCdGZnMW9lS2Mx?=
 =?utf-8?B?cHRLNEpoWUxQZXRFTnQrZ243SEhHWkRvTEJDRzhld1N5K1EzaE5LOU8zNzMw?=
 =?utf-8?B?a0pKSXVmL3RaTmF1WThmN2VidDQ2cVFJVjI1b0lKamoydWRRaHdrNExMWDJ6?=
 =?utf-8?B?Nk1tR1h5QjZoL3IzSU4veXViaVdHeW45cDhPUndITFhPVmpLMi8zTFdENUJk?=
 =?utf-8?B?aXkyQ2hzT01VTE4wdWlWY002dTlRZmdmOWJQOW1IZHRJTXJsM0tWQVZkUW92?=
 =?utf-8?B?Yk01UlZ2RHZ2T2Erc2szK1EwYWw4c1ZxRVBQZmkvODQyUVhSQlRoNUhDSjlZ?=
 =?utf-8?B?WncxekdiMjZxamZmdDlxdVZZdDAvKzk1ZitvZnZKZmRKaE9ORE1zYTlxUWlH?=
 =?utf-8?B?WEhNRy9kelRJaWR1SG1VeHMyK0tjS2h1NE1wSWIwbEVNbjVVMGo5Q3lISXRw?=
 =?utf-8?B?c1JzamxLRy9zMWpCaS91R3FyMHlmZUd3WUV6blhqNjNIQm9IdE1sY1lrUUZN?=
 =?utf-8?B?SlU1TEx0TWpWUVUwdG5tMFB3a015SWVnSE9JSEFlSWZsSVM4QlB0VjE1bHVO?=
 =?utf-8?B?RitETm5vajdsSElQS0RHb3BWelpES05BbEtKaUhwQUVUbS9wOFVzUkprRDhS?=
 =?utf-8?B?WjR0U0pHTm9zdnBBVjg2RmFlZnU4OGV4Um1GV1ZFSnBiYnQ5TDI5V1YwM3JZ?=
 =?utf-8?B?UHo1RzhDQ0ZHT1ltUzlnME44THlCL05FcGFENlNZVHZnMmNzaWdBczhWVG1r?=
 =?utf-8?B?NlRRSVlOV2JYWklKV3JWMm5OZ2UzSitnR0FFOVovYVJCUnRCTzNXbW8vTUJJ?=
 =?utf-8?B?NHNuRXdqU095d2dLWU9pUm1GT1o5TGhVNjlYdkxwR0hjaWxlaXV6VGRhRi9O?=
 =?utf-8?B?NE9PMGhVQnFObmZnRE1QRHArT3NSdm1mYzR0OWFqSnNIUnlmRGdiSTFJTGJ3?=
 =?utf-8?B?OENwUlR3MCtSZGxMTk5Wb05NNmRqTVEzVDZnbDNHYS84bEhoQTduZlpHdnRL?=
 =?utf-8?B?bnBTdVhWam1hcHZjeHF3RUg0MU9JbHR3VTJVN1Rwc0d4ckxaYWhnZkFxb3Jv?=
 =?utf-8?B?NWhMUGJwbHFCR3hzK3JHZ25rNEtyeEN1VlhScEViMm5mMFEyTVB5aExyME9F?=
 =?utf-8?B?azF6TlZXbktBeXZUS20wWEljVVRJT0Z4TGo0cCs2ZlhHR09Gc01vdCtzZ2x2?=
 =?utf-8?B?ZGZvTzdKNTRWNGFxVWNFWHlrMW5acDREUDlIdWNTeHNtZEtUS0xhLytabmVm?=
 =?utf-8?B?U2tYUkhnRjNheUZGMG91eGtPRnRMd2lGajNTT2R1ZlR0TkZCYmpQOVZOdnpS?=
 =?utf-8?B?ZVZTQ0E1cWQ2VENDN0p1UkxyeVBIR2FjaW90VXM4UjhFWmtwMUt0RzFJYVhN?=
 =?utf-8?B?NXhFUmMvc053OXBmaE1wVExqdEc0VzVad3FqL2VTd2hXTlBvUnNsVEdjaUQy?=
 =?utf-8?Q?mDbmGb7LJBpH3E35wL6M5eyl7rtIdLn0HVD2P?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e02451d-c2c4-42e4-3672-08dedea30ee3
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 16:48:24.5758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2t+xRyOoo6pCmS4yDQaEOen4z3T1OL548w4nbV+bldPZoO2PZ3TBS1YZH3NplzOIc+LSIJ6L9P1mQHwLG3c7aZ397XtoQrgqFle5tV4/OB83jW8JS/hVSZCoD+Wo1rSm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9345
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12328-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[NXP1.onmicrosoft.com:dkim,valinux.co.jp:email,oss.nxp.com:from_mime,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:mid,nxp.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D452073CD81

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


