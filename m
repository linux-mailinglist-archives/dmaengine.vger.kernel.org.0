Return-Path: <dmaengine+bounces-8617-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2PuKI4zMfGlHOwIAu9opvQ
	(envelope-from <dmaengine+bounces-8617-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 16:21:48 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31316BBF94
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 16:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 782B33001012
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 15:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A5D371069;
	Fri, 30 Jan 2026 15:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Z4zDqbXz"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013010.outbound.protection.outlook.com [52.101.72.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F18236B059;
	Fri, 30 Jan 2026 15:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769786504; cv=fail; b=VIuJ7TBYDh5Fgi88FG9TtyTwuqWhVmRIUtcm/DxsAyINerXY6ZEIZjwZSwDMeMw8Ei6PrjzmlinKXtDaNlFXKckR/C6AqtkByiXIi9CC/mH9p6NEXktRWVNz15begOtxhvLsstF3P1KIv6qcYL+sAHjxUvZSk0yKAmiqRbZsWfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769786504; c=relaxed/simple;
	bh=UHyWivBoZ493Kt4Qj1di2fGIFFuCFZQwLTtp17BIWqE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=twqf/ugFOi7Yufx6bB4bIe8zxk0LUz7p8b7CiQAv08JnNlJr0mZJ5/swjtnsqmCi/ZLWpPlKgqdmlJ7oxdcr1pduym8LFowCDBo1PQE9nnj1Lvoz2uKccmwCe8la/5rLFw/jIqZ7NgfdfUUl1fuKCSIp1iTBQodjrmxKlJn6c2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Z4zDqbXz; arc=fail smtp.client-ip=52.101.72.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oUiL96XSuOcmadfCPegtG3YGjKAyrFoj/d9FQOJD3WF4j9vYU8rQPOIL+yNsEUPtU3F/Rx9wsRP7qHZrgyWMprLH35mO5VrcRoKspQWlgUSrrLJ1yq7UNqKimAp9Mm+X3soNZ0kT0riUwx9nuwfXCglFKgX2RJ+g3jVBIwjsN5+7qlBDKiG33tKzeb58d51nDpgUtOt6wS8SsoTHVLfnn01qYR52s1Uz4t/mkRSkOSgvJvBG62j0kA7/gQNu3cy6lF9veq7vSJ5uvdu/QenmqLHbkx8hxDIKOTPd7H35wy+k8PV5L1u5620cfZgXTD5eW3HbzqmUs4GRDvfYhnnYcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eI9KpWZwgRlptWpi5vHqYeed6/6SdPKn3jADGYRNhJI=;
 b=mvgPn5HU7nVOiAhliD8xiYZFmvbyEz+TKmbmmVYM5Dh5p1EfhDQDRAkpQbtzIzYYB9EHxFiktoLP/DpvQ6mjTPUl3MjU6TJswMcq59CpKieslwLXWAokxfXf/LVuolHeLBZZGcEaiqd4G7gQH6YQ3+5uBJIxoDB6gxH/10R0hJbzDEOzssxh66Ou4cvl+Y6/7bnihT+CTT0MxS2qEHslHF1bSrQ+VfWcDjxzdUHoNYJVlb4oPynjoAu2CM5T8FO2nsV8IoaXdNtMckg0TDHtXcfPMpSI7ES0RDuSEKT7ob4CkNMTyq0WyJHqP2vJAcpbhgfF2PqZ8f7oLi/PToU4dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eI9KpWZwgRlptWpi5vHqYeed6/6SdPKn3jADGYRNhJI=;
 b=Z4zDqbXzM/GUm9rVfSkIKtTSvLqttrABcQFISVKm6CCjXPexKyW2oWaUaXu1vZbGSp7OfPXpPMoJXMoHPO2PQic5Z4o7/Qa46auMNpm7iCR+Oc8lN/+SEZ8npeH2XB3IntSVVTjvHdr07Dq7qKQ6+YBbLBdE770JIC2i9ZxHh+yyGB+Tma0loXvVYCZQ66nevzJl2uKalXlEJIYlyHmSu6d7Tfdey19pcpL1HMp+gOzUI1XBw4NNfTbGXUjuARqHYrI6FROHtatrruEfqzbDbHhwDizHjVsVglRvxopKy25hP0yCkMB9nd9L6ARwRdZjlgSbgfe7sB/UD9u4+3h0VA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by VI1PR04MB9738.eurprd04.prod.outlook.com (2603:10a6:800:1dc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 30 Jan
 2026 15:21:37 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9564.010; Fri, 30 Jan 2026
 15:21:35 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 30 Jan 2026 10:21:14 -0500
Subject: [PATCH 1/2] dmaengine: Add helper macro dmaengine_prep_submit()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260130-dma_prep_submit-v1-1-2198f9e848fa@nxp.com>
References: <20260130-dma_prep_submit-v1-0-2198f9e848fa@nxp.com>
In-Reply-To: <20260130-dma_prep_submit-v1-0-2198f9e848fa@nxp.com>
To: Vinod Koul <vkoul@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>, 
 Andi Shyti <andi.shyti@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-i2c@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, carlos.song@nxp.com, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769786487; l=1451;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=UHyWivBoZ493Kt4Qj1di2fGIFFuCFZQwLTtp17BIWqE=;
 b=F/ukoW8ahl5mWCzJUvoM7NB8r7S2niGWn6nZGz5CQwJMjgl84tXWog6pl785BcUY9HAdPmiM2
 1K00e/OH1JmDnCcVL39QIv7nhJO7oPPgl+TOOTl0BJdTUeinaKOG2Af
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR17CA0063.namprd17.prod.outlook.com
 (2603:10b6:a03:167::40) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|VI1PR04MB9738:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e913b61-a12c-493f-37d8-08de6013414e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|19092799006|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YjMrWjUwUFlyV2RHOWNCL2tvQ0hrVmlyK1hDYndGbk1hZDI2ZWtFNDRIa0tC?=
 =?utf-8?B?Vks0eGNtSzNpVHNpYzVPbFQyMFNEUndtRk5PK2hJM09jdlFBb3hXRVRuOHBk?=
 =?utf-8?B?cFpWbEU2T0tvL2l1SXpyV3dnaCs5SjdoTDdsV3YvanVYMWN0cE5yVGU2ZlpJ?=
 =?utf-8?B?ZzNrbGVxbHF1R29MeXA0bFNYTFppZTBSblZraktGL2VuTUtZRytETGdvWUl4?=
 =?utf-8?B?Vi9PWXpNb3F1SElVYUMwYVBmemlrVmEwYWhEdmZBeHVlV2dZU1JPUTZyckJy?=
 =?utf-8?B?V2VNU3huZTY0YkdydU4zVzU3UmFsNWV4Z1I3MnNGbXVTWFZJc003RlVKZEJ4?=
 =?utf-8?B?L1dFS2cyUjBXNEk4ZVhoVHRTTVBNVUJLN1BqR0R3bnlUUTJFckt1ZHcxTC9r?=
 =?utf-8?B?NWRZOFhmR3hUc1ArT2dpSTl0RzNYU21DMUNmVFJIMUFUdEF0dGlRR1o5SUpS?=
 =?utf-8?B?amFlUEcreC9PbEt3U0U1U0g0WmNGeklLRzBTUzZiOFVBZmcya01BUXdKdkNB?=
 =?utf-8?B?ZUdCbjcyOTdGWTYxbmxRWVlPL1ZlTGJBNk5XNklUZlRYMlhvcGwzNXdTZFEw?=
 =?utf-8?B?NERtY1RGbG5INmJHQjV2dy9hSnVVUzhKZEVST1M1NDBGWFRHQS81UkhKRkxJ?=
 =?utf-8?B?S1hWM1A4a2VhTlNFc01RMmwxc1FPSXNzekpBRERYLzl0dHdXUjNhV3l0TE9l?=
 =?utf-8?B?UWpuWnNMcUVyZEZIbGpCUDB4ZmR4aE40aVRZWXV1TFprREIxcGNxalVTWW9R?=
 =?utf-8?B?NVhiOGNHVnBQVUc4UFlrLzlObU1WTnhkdHhRUnkxUHFGNkp6YWZLRkN6UlRY?=
 =?utf-8?B?VkJ5TkloOUtlTzdiNG4xdXQxSHBRRzFpbHFybmR2Rk9FL1Y0K0hUOFBuN0ow?=
 =?utf-8?B?ZjVzbEdiTDVsQkg1bDZScHR1em1lV1RhMUhtd1JJeElkSjJLWkxJZjFpcUhT?=
 =?utf-8?B?TFJZZnREQlAxZHJEVHpYdkV4aThmRU9QcDRrc2l6ZXQydUJFdGhqVDdWSFB3?=
 =?utf-8?B?eU1Lcno5TGRNMmx6U0pycElzeldiT1VSbjUxOEp5UnR1SGFPTUI2ZGdnWlV6?=
 =?utf-8?B?aU56UjE5bFhMU2ZhQS83am5RVHFlVU9wTEcxS3lqQi91NnVYRzRxNGFLUXFo?=
 =?utf-8?B?NGlpMm9GeXVBSDRtUTZsaWttUFFtVXV2ODZBUHlqNzdIKzhnMi9MRURkOHRZ?=
 =?utf-8?B?OTlUNWNpM0ErY3BQL0pTYTFVelhXWnQ4ZnM2K3NQYkE1aEFRRFhnV1VXaWZ5?=
 =?utf-8?B?ZmdxMXZ2ckhKT2NUZlF0UVY0UDUvUVFJMkp3VXVsdllNZjlmU1NqVnRacFEz?=
 =?utf-8?B?TU0yZHdzdnhTLzdjR0tGREhFaWVlbHZ2Mm43MzRPalpjeUFoTmpvQytKNlQ1?=
 =?utf-8?B?bHJmd3hYV3FPSThGcit0V05VSzIyMGZuM1VORHUycXlRa0lrSGlaK2l0WWlZ?=
 =?utf-8?B?MGorT3pkalZYdnhaeGNkOWxEZHREM2dsVkEwVDQ4cFAxa2todjlzNDRtUHdN?=
 =?utf-8?B?b0hVZisreFlFRWpZNmROZmxEZXpyRDJXdGIwc21YTyt5TVg0aTJDWC9qMDNO?=
 =?utf-8?B?TWZsTm1mRjJRT1VFQ3VSK2hLSUNlVzdleGxJMG5BdXBNOVEvbVlXS3RTUDIy?=
 =?utf-8?B?RUE0UmFNZ2xEdEpWWUI3N2hVS0dKak9aNVJBRHVSc2dGWlAvSW85Q09QdmVD?=
 =?utf-8?B?TDliUHZ6TGFVVnZWK0VSWE1CcUNCdE1vWVArajVDSDM3cFQxemI4NW1xUTk2?=
 =?utf-8?B?YnQwSVk0VTRZc0tEa1I0bW5Fa1hHenhreTRLc2NEbWw4S0ZEcWpwdExlbE5W?=
 =?utf-8?B?NGw2WFFSUWFSRktwMkpSOTIrbE9PdzRzWnF4SUtlcDlWR1J2clA2cmRnNGN4?=
 =?utf-8?B?TjMyVk5wRHRtTWVWK3g3OWpVQ0kxV2RIUUJnR0R0MUVXT3pDVVIvUU1Edjda?=
 =?utf-8?B?WXU2WWtxWUpBL0ZCaDFBaE1kYTA4QURCbXBWOXF2Z2ZGZ25HQklOM2krMjBK?=
 =?utf-8?B?c3ZDbU5mTG1YVlNlTkl2V3M0L0FNY3hyRFR4aVZERXl2OFFpaDQrVjJFUUFL?=
 =?utf-8?B?bHVXbU84T0w0MFZMNlN2WXRZWGpZcktlMk15NlRZeGtPQ0RYYlR1THcwUTJj?=
 =?utf-8?B?aFpoTVpkRE1IRjRBdG9ZVWNwd1FFMmhhZzdzZzg3Vk1MWkRGaGo2YzA0YnZM?=
 =?utf-8?Q?krodtEgglAWBA+mYLEPO2lY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(19092799006)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0h0T0lvZDh0QXRNODhIVjZDa3o0V3pYbnNwUmx6VmlFU2FIVW1pY3hFcEFM?=
 =?utf-8?B?dmQ5QUkyL1Y0dThHUVE4L2JjRG5ONm4xVHhoelhXekZ0ejR2VkNTVTFaTTRT?=
 =?utf-8?B?NHBLa3duZVk4eWY1NElSTzZFN1hTMDd6MXFMRG04UlI3ZW52WWU0eGs5NTdM?=
 =?utf-8?B?NmUrc3I2UEM3bmFyc1Z5WHJzT1QrNUFObTl2cnpYWHNsNUxVdWIrQU1uaVc4?=
 =?utf-8?B?WWJad1NpU0tJeHBvcVo3eThjeEtwTW54VHhOZS9QQWhpOXY5WW0wQXlHUCt2?=
 =?utf-8?B?SnZEdG5kcStUbmIyM3d2N3lScGtJKzZmVXJQR3dxbkwxQTRZenpkeGk5VDdX?=
 =?utf-8?B?aVJPbDlkWWdQQUV0RzJxcjVMQmp0eHB4amZwWEorajhyYWFKNllqS01tQmhG?=
 =?utf-8?B?Y3J6eXE0eVVXZHVPV0dNejg5RDkrVGZScVVsa2tqbmttb0RlODJQNmVBNDRQ?=
 =?utf-8?B?MWlOd0lSbVpkYVA4UUlDc2YyRnFQdm5MQStTNEFvcUtHUVNuRkx3UnpUT1dp?=
 =?utf-8?B?RVZYcjZmRDk3QTgzeWtSMXJOSUJNckVac0hTTWhJa0hoZEMxb0NNSHo3ZkQ3?=
 =?utf-8?B?RnVvNHEyTGR2RUoxTmd3aWl5enZUaWJIODdNclNTL0ZxR2tmQlRVc3ZUYnhJ?=
 =?utf-8?B?Q1UwSEMvL1RXcG5tQUJneWhTVDR4eGtBNDB5a1ZrMFdxbjhUT2Z2NCtBL2Jr?=
 =?utf-8?B?bWM5T21kaHpINjVOWEtML3ppdzg5NitBeWU3R2wvbEJxRkxvS2VWaFZzZmx3?=
 =?utf-8?B?MjlUZnpDNlVVUm1jaGdHRXZmMVZBaUdsRmhtSU03NHhidjdUd0hxZi9iY2tj?=
 =?utf-8?B?a0FWS2Z0OUszQWlLSmVRcU13WkNldWRMUmY2QWtITjVORXpZTjNsUTFodHFm?=
 =?utf-8?B?c0tUa2IxSWpLbEd5MWtTQmhxSE5PUXB1eno5WHdhQ002NWlDSndNYU4zZVk2?=
 =?utf-8?B?dzZCZHI5VWNsVEpVbCtaL0c4VHh4RWwrcUhzNWdaaXJjSTFsT0FZc25ETEJa?=
 =?utf-8?B?U3ZocnNWeW5DRnllTUMzSk5OQ1JrRE85ZmdhMnVXZWZ2NEF0aUl4V1Y3K29K?=
 =?utf-8?B?QlN6TElLRjhwTFVWWVVFeWhsME5oZFhZUnFJcTc5cWtBeCt3RVJYL3d3cEgr?=
 =?utf-8?B?ZDhFZGlldVZvTXVkcDNoakdoWEptd0RoVXFOeG5sMDN1K1dsOEg2aHVyRnNY?=
 =?utf-8?B?SkVSRVdScEo5RXkrektNUi8zeHVtZmpkUUkxRFBHckxHUTZwZlVmQ044c1dx?=
 =?utf-8?B?SUhIbWg2RGFXYTFGZHp1NTZ5aGVNQmVzNjMzU2R1N0VmdmhCZjBBV25wbEdw?=
 =?utf-8?B?V1VkNlNUaEZ3NE5vT1NxQWM4QlowTGFheEFDUFNNaEJ1dGozcXVkQ25kazkz?=
 =?utf-8?B?NzN2eGdQMUI0czFqS2JITGdoZFBGUFZBUkJuOTJqWGNYUWN3QUNJSFpZTXVo?=
 =?utf-8?B?RVlIWktDcE9YYnRuZWRrNXVHbHdxQ3hmWmdWZ1B1Z1JHZHZqb3JWbUVIQnYr?=
 =?utf-8?B?QWw1N2dxc2lETG5rcFV2RHJ5dkNKVHZsSDFiWGVRaWF4aXNpaVhTZXlyMURj?=
 =?utf-8?B?R3VQOXBKL1FVamtCMjBDWTAxand4d3NsSzNhbEdBaXF2ektCNU5KK1Y5N1Z1?=
 =?utf-8?B?dGhGRnVSTy81azJsbE9JRStXWmlOQjRwNnVjaDRrK1JSYW9TWFMyWHV2NGp2?=
 =?utf-8?B?SnBWZlVTQ0pZb0N0d0VaMjBZcHNjb09JeThCVW5BRmo5Y2twZDVZSXhMbU56?=
 =?utf-8?B?UDRSRjlybjNvbVB3QXIwaE1HSUp5ZVlJMW1McTZUZ2tIbGVBU05HQ3EzSFhk?=
 =?utf-8?B?dG5GWkJpUXhOK252VHI2YWx4ZVFFclB6WEZ1QjEvemtjTmpKMXlmVGRmTnRS?=
 =?utf-8?B?MktwRWlEdGVBNzhNZE5WQ3VvK2hFVEdIWTRoRTg2N21rWkJlOGZKVGh4N0tY?=
 =?utf-8?B?RlF4NWorSHNxeGFBSlZIZi91YnYycnF1TlZRQ2pERjMrRUNodkkzeFNKSE53?=
 =?utf-8?B?OU0wL2FoSWlXd3NqS1REN1RGaUh1NnpOWlV6czgrZEtxUWZtUnp1dlJncVF4?=
 =?utf-8?B?WWk3Zkx1QktrOFdUV1Yyb2tKb1poRmt5ZHRITC9Ob0VTOU1RU0hrOGVCRTl5?=
 =?utf-8?B?UmFOdExUejE0VDBUQ05TdVVuOHgvL053UHc2akYxUE5CSEtRTFlDOVVpMklo?=
 =?utf-8?B?R0d5MFRxd3NrNi83UTEvNEZkakZxUHVjUzdTS2xVWVNFRFJmS1VNc0FQdXlQ?=
 =?utf-8?B?QzZzR2JsK09idUcrRlJwbVhoQVdqUmdCNG5tRk5JSzFiKzQrUjdjWHVKN0pW?=
 =?utf-8?B?V2NRU1VZVWJMOTlrUm85K1lzV1A0a1RhbDdvMzVHWkYyUG1KdGhzdz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e913b61-a12c-493f-37d8-08de6013414e
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 15:21:35.1879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P5CQSp4Hx6I2nfYntTlvn/R06OdsqyThAVZFMtJkKv7cL+4lRI1S2cqMuHLH+wtOhKOFZl7VVDuzeR5sh+TGYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9738
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-8617-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,nxp.com,pengutronix.de,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nxp.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 31316BBF94
X-Rspamd-Action: no action

Previously, DMA users had to call dmaengine_prep_*() followed by
dmaengine_submit(). Many DMA consumers missed call dmaengine_desc_free()
when dmaengine_submit() returned an error.

Introduce dmaengine_prep_submit() to combine preparation and submission
into a single step and ensure the descriptor is freed on submission
failure.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 include/linux/dmaengine.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 99efe2b9b4ea9844ca6161208362ef18ef111d96..78246fd8a8294b6764d2717d73b9c49842f64696 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -1249,6 +1249,22 @@ static inline dma_cookie_t dmaengine_submit(struct dma_async_tx_descriptor *desc
 	return desc->tx_submit(desc);
 }
 
+#define dmaengine_prep_submit(chan, cb, cb_param, func, ...)	\
+({	struct dma_async_tx_descriptor *tx =			\
+		dmaengine_prep_##func(chan, __VA_ARGS__);	\
+	dma_cookie_t cookie = -ENOMEM;				\
+								\
+	if (tx) {						\
+		tx->callback = cb;				\
+		tx->callback_param = cb_param;			\
+		cookie = dmaengine_submit(tx);			\
+								\
+		if (dma_submit_error(cookie))			\
+			dmaengine_desc_free(tx);		\
+	}							\
+	cookie;							\
+})
+
 static inline bool dmaengine_check_align(enum dmaengine_alignment align,
 					 size_t off1, size_t off2, size_t len)
 {

-- 
2.34.1


