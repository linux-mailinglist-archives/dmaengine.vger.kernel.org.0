Return-Path: <dmaengine+bounces-4039-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFD49F7984
	for <lists+dmaengine@lfdr.de>; Thu, 19 Dec 2024 11:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3C0A1896018
	for <lists+dmaengine@lfdr.de>; Thu, 19 Dec 2024 10:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A83223334;
	Thu, 19 Dec 2024 10:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="l568iqs6"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2080.outbound.protection.outlook.com [40.107.20.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E09222D5E;
	Thu, 19 Dec 2024 10:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734603888; cv=fail; b=HTJIvWEbDM9rRMOdanfjKtI11jtx1QZDI7Nc9G5SGGSjj08zl/JMOB0+f4/UtktSNk4pd3disL4L/LZrUiZm9CtDQFkDwj2lI+pQfENEV9WhbdrDHbIvw6gmzOGoIVkf+x8q8ZbZjI+xpGcQcgI0vIqcv/NQdHdszAsU7WN7dxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734603888; c=relaxed/simple;
	bh=98XY1a7JJVwiXnOcAyieAc4D9SnwiEirbyAuDC/CiBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PwRPp+jxEu9JdoSNiEUMYsb7V2gkj1KxxuqWWhm2Ovj8aAllKqGcKw13xRxQ1J3qcdSgZ+F5FyNiu/bnv+3RU6Pcpifq90B0rUF4qMa4ZR0YQ3mgKgYjPBqAMsAnKKJMHrDisapw3dU8HNDj8yqzQ/zpOYNfEgKG3VaFyiR0cvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=l568iqs6; arc=fail smtp.client-ip=40.107.20.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D97MlnxKqCxoMD6drAJR7Qqt7G2yRht+4r8R6N+U+zd/lqLvkVNUnum6BV2gFycRU/ZtK6HazM3NBuR3x2qPhYuJ6eE1IZ3jdBkeGd8wmgem9vWsYn0etjg0TgEy5m4ef1vrCQ3fyJBPP8KwhGVGmqo4tdZTJiNKwJyacllhF8+FgFudNp41zFhiNk5PCfJwHeHS9L4Pw42ab/4wT0hO3pmvet6B77BSmf/qthl4NX9ZRts0Cc7ggILrg/o4pqXn48R3lPDS6xudU681P5f7d7m4M0q9Yukm9ekEUfCODZVCSmVbOA4H42t+koWQdowBBSNErYgf2YZp1eWUc2Jjeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9CmmJJtzZ4GKvoSl5NZeQ2TTqc2zau2UVovMX1/ogI0=;
 b=dMK4YjYWQk5MkmyZqo/C59QaADJoPgJSgQfmQYYvYitphvEo/Z4QbkploMfegcMoAzkX/+9Oi7H93UI0FoWwYOWL6OqCjUScVV/FlM7siCvUaShIrKmd3xytwRcfwiMDhNm8py/74d0P1gEw8zru26rRFzJTlUs6pNGr6XT9xHirQvx32369FSU9VlzpppTLpUQlHXdGZh9CcFXJc9MCA+UnfzpWCFUc+j4rBLnVlfW+EIqo6SsSL9cqk81tAR/Azh3tzI+PLYBzXSlxqGRoHnAY6G6+ePRWDTPwdHyAZS2GFoOy1ktI+oS6JPK6K+1uX6XsJsLVlZdZxjId/pN9Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9CmmJJtzZ4GKvoSl5NZeQ2TTqc2zau2UVovMX1/ogI0=;
 b=l568iqs6fdf8J//r3fujAy2k0XNBDIwhEvbdxtjiiiJNEe97VfTpQbk/DMyek1qemDy8RvoC7qSH70wLAuK8LkXWsF9xX5xjJDS99iglLqGyECrY7DL/nE4AT4r/cJvop2fL/AZDODFXfF5T4yNE5GLACRv/6hpXrXI/i9Gr5jmlbcgbcn/pXvYYRlPHcpfdYDZJiqwAehII3UhPQumuijw5qPm3aDGI4mPkA95lo9ym1GBrWYHunNI5hw06NCmUHGAKxXSdv/EvZuTBosF3a1hgWmx8l66gLOuV5pVxCsTVsCN3eE0MWkjg37e153Lky6ilj8gOLEexVnQTn5FXIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9550.eurprd04.prod.outlook.com (2603:10a6:20b:4f9::17)
 by PA2PR04MB10187.eurprd04.prod.outlook.com (2603:10a6:102:409::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Thu, 19 Dec
 2024 10:24:43 +0000
Received: from AS4PR04MB9550.eurprd04.prod.outlook.com
 ([fe80::e28d:10f8:289:baf7]) by AS4PR04MB9550.eurprd04.prod.outlook.com
 ([fe80::e28d:10f8:289:baf7%6]) with mapi id 15.20.8251.015; Thu, 19 Dec 2024
 10:24:43 +0000
From: Larisa Grigore <larisa.grigore@oss.nxp.com>
To: Frank Li <Frank.Li@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peng Fan <peng.fan@nxp.com>
Cc: imx@lists.linux.dev,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	s32@nxp.com,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Larisa Grigore <larisa.grigore@oss.nxp.com>
Subject: [PATCH v3 2/5] dmaengine: fsl-edma: remove FSL_EDMA_DRV_SPLIT_REG check when parsing muxbase
Date: Thu, 19 Dec 2024 12:24:11 +0200
Message-ID: <20241219102415.1208328-3-larisa.grigore@oss.nxp.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241219102415.1208328-1-larisa.grigore@oss.nxp.com>
References: <20241219102415.1208328-1-larisa.grigore@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR04CA0120.eurprd04.prod.outlook.com
 (2603:10a6:208:55::25) To AS4PR04MB9550.eurprd04.prod.outlook.com
 (2603:10a6:20b:4f9::17)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9550:EE_|PA2PR04MB10187:EE_
X-MS-Office365-Filtering-Correlation-Id: 636595d4-6c0c-4bf7-ab35-08dd2017599c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WldFMXNBb3dlYnJyY2pqNWhyY2lZVzk5MDllTlE0VGphSG00TVl2a2djemho?=
 =?utf-8?B?cHlqU3pudnFFclBKeUFVcnJTS1pVd2VRVWRPbnhDUGg5WjQydm56ZVdCdy8v?=
 =?utf-8?B?OGp0QW5JeEgxMUtyYlYxWm1CbFU4aFNOMjRZN0h6QUxTVWlwWUltUng4WVdu?=
 =?utf-8?B?Q2FacEpGZ05oUHBNUnJWcUdiZCtQMloyMmVFMjd0d1l1MXdwdnFOaWNyWXRQ?=
 =?utf-8?B?QW9WT0k4RGEyVEo0dUtkWC9CSlpFeVFvQzR5UzR6aG84VUR2Tk1uL3NhOGVQ?=
 =?utf-8?B?ZC9BUHUzSElSYlJ1cStRVlo1aTJoSUVFTWJBVkpjTG0yMSswMUJ3ZFJsS0R1?=
 =?utf-8?B?NlVpVUJwa0FtQyt2UTZuRXVzTVNzajJNbDliS2ZYZTFNQi9FQnZmQWErQkV5?=
 =?utf-8?B?d2lXRVhZeXN6dCtvQWtGcC8rM2puc0toTzM0RlRKcHY3TlZYY3RaRG5NZE4x?=
 =?utf-8?B?MUhLaFhVV2E0UmsyVHV5ZHU5Wk1ESEN3YXYxYmx0N01mUGdRY2hFMGx5bzVN?=
 =?utf-8?B?OG5zenJ3bHJCUWRJdVpXTFNZckV6eHBJLzdjV05WWHZwbEhxMXcwUjg4NUtt?=
 =?utf-8?B?cFdtcjl6dXRCVjkrYkc1UnE3RHZWbzVkYk4wZkZNRVBDTVhUakhlQ3l1c0w3?=
 =?utf-8?B?RGtYeG5SZ01qb2RLaHpHeDR1UXo2bmMvY2dNUjJralArTVRrRFZIZjJ0VW1M?=
 =?utf-8?B?a3VNWUNCV2tabUZud2VvWTZCaXBteHBObHhmZkQ3dXZXNVpadzE1MmRsV3Iy?=
 =?utf-8?B?ZG5kRDlYUjMrenFZUFV0NUVVQld6NW9yMW80Uy9NU2xkb2h5UmE5dTcyYWk2?=
 =?utf-8?B?NTVoSytieHZiZm15aWV6Zy9zSk1xbUo4SzMyaVV2djFseGpraTl6emNWaTlF?=
 =?utf-8?B?NGVOYXlKSDhaUitCN2NMMi96VVBqU21hVEpUbnFrTWhCRWkwY0VKdUJWQmJY?=
 =?utf-8?B?SHgzWDgwNDdDV2FJM1IvL2piQkVuMUtuYXpiaTR4T2hJUHhpQm5VNFZQR3pY?=
 =?utf-8?B?THVjMzFGWjZhRWwrZi9QQzhWWllXU0F5Um9RUGUwSEl6TmtkeEZmeEtMSVlM?=
 =?utf-8?B?ZWxZdk5lQmQrVzk3VkhzaTR1RlJRaHBtbjU2WlRvY29MSEFKQjljWGtKdXJq?=
 =?utf-8?B?NXJXWk5Cb1UzTVZjWmxWM1FGR2s1OGJuWmQzeTFIcnhYTDdpVFZNUHJIbkRH?=
 =?utf-8?B?SGRSYTRFcVhSRVUzeWw3bFRSMVNwcWZ4TExwcVc5TmV5SmhCUWsxRVFyY0Vz?=
 =?utf-8?B?M0tOaisxTnlLUndiZnE5eVdOR3M1M1lsYUZGa3NoK2k5YTZoWGo3dWkrR2pt?=
 =?utf-8?B?ZkpTOXFLMWUzakRJZlRIUVJ5RnJET2lyUGc4ejg0UzNZWnRpV0RvUndFZTlO?=
 =?utf-8?B?VVh1ZTZ5eHVlTGxPY0F1Y3lMeWkxcUtmNXJOQkRIY2JoWExiaWxOYmhydU5Z?=
 =?utf-8?B?WG9uZDB4VWxUQkdtT01Jb2VKckxDb2hXcGNEaVRjTkVzTHluQkJzd29rb25n?=
 =?utf-8?B?RzZQZHRlLzdXRUF0SGJZcGhTb1NPRDY4cU1vZklDaFc4VHJFTUdiQlVhR0Fp?=
 =?utf-8?B?bFVMRVFOR3pOeFZJRTJxU2dqUVJyTDJiWDdFL25GdUl4YjMwOXBtSTVJQWZL?=
 =?utf-8?B?enFBSEROZ1lMNWlCTEpmdk9EL3RCeTNMdFpsNElSdnJWeEZSQXFvRW1vRFd6?=
 =?utf-8?B?V05pZ1BUUjdUVGg5Z2t6TE9KL0N3UHZVWXovckY3aUhldDhoQ3BNeTExVHVY?=
 =?utf-8?B?MVROeWJDR0VHOHRLMUh4Sjc1YXBXUG5LekVRcytxNWVDWEdDWnB4VnRIVjNS?=
 =?utf-8?B?bUtzYjlJNldYL2VDcFkzUEJzQnRMSDB2dHd2MGVoNHFSSEZJR0p2bWNOMldE?=
 =?utf-8?Q?3s9ai2uh12POl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9550.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q1d1VytzWE1BS1RtQTN4dWVhbm9FQWE0RVJIWUtYQ1VXcEhnVWVTS3kxODhL?=
 =?utf-8?B?UFJISEFjUjU5SDg2cUNoOXJTK29YQzNIM1Mvb1UwTmVOWDQ1OTZBb1c3eUFy?=
 =?utf-8?B?c3dQc1ZkdjRnbGFnUU5YTCsySExtdUk5QzF3blpURG1OeFFGRW1XT1F1eWV1?=
 =?utf-8?B?eVJaaWkxL3BUM2VKZnQ1NkNaMi96eVBXYjhTVzlDLzltOW5YTVNkVmlEZnpD?=
 =?utf-8?B?M0E0Ym4wbGNrZ25BUTl5OHFKeFgraHJibkhwVGNMN2FBT1hFWEZLVDNKTjEx?=
 =?utf-8?B?YXpLcGhJcWFiUmVpa1VCcGMzV0lNMnNtVVVoekR1d2Z4aWxPcDR1SnNSTWNp?=
 =?utf-8?B?NVlXVWlYemdDOEJNZDB4bjZYMzZ3VkN5aXhmODRBSUtveGRoVWZzOGZIU2F5?=
 =?utf-8?B?MEYxK3N4ZS9SOHBDVWsrOWdpbjV0Wjl1SVZhREIwNHNJRjU5MVNYWFJXdU9U?=
 =?utf-8?B?TnBkZFNFanBPWExmQWpRaWRSc2hMcFVRalplek5kSXpzdCs5TU03UHhzZXQ1?=
 =?utf-8?B?N09KM0dBQW9pT0xLbDJ6K0E4dDNRbW42VEprZUZydmdmUkxiaXZJZ3QwaXV4?=
 =?utf-8?B?Nnk5b1VRMUVpSFdnZXZPR3I2cktrYU5zZmgzWldlWDl0TmFVMFhuUGxJdzRI?=
 =?utf-8?B?Q0J3ZUZrbDl2cjlSVTFzekE0Wis2bWdXZDdJemhHT0V4WGxGSkFncXU2UVp4?=
 =?utf-8?B?VTNIRnhoV1JNQ09DSDJtWVpVTkNDVllDdDk3TDdMSmc4RXU4Mm5TSGZFMEZ3?=
 =?utf-8?B?d01kY25ZT0YvVUJ0U253b2drZnlmSEMxZnZiekxFR202ZWtUSXR2SUI1YTl4?=
 =?utf-8?B?dlVKNE4xSzJoZHZDdGZkQnhZT2c5bUFXUE9Hb1BlMFhxWWhEUnIrNWlpN3JR?=
 =?utf-8?B?M1JPc2taSHc0clBMOHhScDhlcUNmQ0ZYSDVWcTgyMS9mMEdZYXhDd0VSb0Vp?=
 =?utf-8?B?Nmc3a0h5elhTTDR1YklTYUR0NWozRVA5aWlOS24vbncyYjBuaHRPUEhCRzBa?=
 =?utf-8?B?T05xejUvNEhCd2FTVStWV0xyejB4VFdsYXRiTC94T1JRbis2VlVZbFJXSGp0?=
 =?utf-8?B?VXc0Qm00QjNRZHRDTEt3Q2dYR3ZOaFpMK1FwbHN4Z2JOTm16RVF1L3M2aXVP?=
 =?utf-8?B?KzFBcFpna0tXVWtRRkkzaDlhR3plM09Ha0hGZk1yNVhMZ2VEK1dyQW51bnBp?=
 =?utf-8?B?Rk5sSDQxWDBPT0pBdTY2cG9LYTNyRG9peTZONU1OQm94MmVTcUVYb2dQQzAv?=
 =?utf-8?B?YnJPMkNQeWZJN1d6VGw5UUg4L2JpK3h3a2JHWkYwb0diWWpGb3pRS2trRTV2?=
 =?utf-8?B?WjlvaGxqSktvZHJveVdLeTRhYWhkM0JyN2huek5yRXhPMzE1SnU2dWZ5T0V3?=
 =?utf-8?B?SDQyUkdZcmdpVnB1REdwd3ZpMzd4MlBGS2hzeTFFdjhRZ0ZkWXJ1enFpeDVG?=
 =?utf-8?B?dzBWSjVuTkZZVDgwampRK3diK1A2RlFic3pMakNRTGlZaHpxRjZMV05qUmRW?=
 =?utf-8?B?YUJaUzl6em4yV0pybE9BUzhQZnRPV080Mi93bzgwTGtQUFEyRU5CbWVpaVI1?=
 =?utf-8?B?NGtXVUtsY2dhbWxuMnRRSGJ6c3p0L1NRWm5KZS81QVpjYzduSVVDTEg0dmFj?=
 =?utf-8?B?TjBteXI1T0hjaDZUczRQRjUzblk4ZSt0S21HRlBUQlJiL05kOWp0Z2tMdi80?=
 =?utf-8?B?S2NGSjZXdGZzZDFJU2h2UzZMT3BlbU1kOVVFNTI5NmhvcGhXcjl1QUlKRmN1?=
 =?utf-8?B?YTJqSDJYbHNiaDVxNlUwbnQxVXk5REE3WUNRZnN4RGtWVUFOTmNHbndERFR6?=
 =?utf-8?B?dng1UnJRT25wQVZuSEJscTZySW43R2RUNUJqZ1JqL25TWDRMeDZkNithYnBW?=
 =?utf-8?B?d2pCY1hNdWQrM3FFdkkrR1NjSThOUjY1cVFRc2xyZi80TytkNDFvS24yaHV3?=
 =?utf-8?B?U1BYaVZjNWlka3I3R2FWc0tPZldoR3ZYKzhhZUxUTnBTUEdvMTc0dDEvcTZj?=
 =?utf-8?B?R2JXK3FoREVyV2psekhjdjMyaC91LzJFKzdhWFB6dEdRWk1jZHZ0V0svNUpq?=
 =?utf-8?B?anlvZ2NFYXQrVXNFVGVzRU1vS2xpSk1ZbGIxNG5sZUNxY1RJZEZQZ2pWN3p4?=
 =?utf-8?B?cGJlREN1TVFCUUJ3eVV1YWlhQWlYQ0NGazVxQ01zTzFSNngzTXpFU1FKNWd4?=
 =?utf-8?B?NEE9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 636595d4-6c0c-4bf7-ab35-08dd2017599c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9550.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 10:24:42.6525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 86xYyKqVaxqoVzoeLimdCHRJ4AsSDj+c5Q/BepJpEP7gcZTKtM5Qa/F0ZP4P3CY3Kt4AnN4QHJHfne7cXxGdjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10187

Clean up dead code. dmamuxs is always 0 when FSL_EDMA_DRV_SPLIT_REG set. So
it is redundant to check FSL_EDMA_DRV_SPLIT_REG again in the for loop
because it will never enter for loop.

Signed-off-by: Larisa Grigore <larisa.grigore@oss.nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-main.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 2a7d19f51287..9873cce00c68 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -517,10 +517,6 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	for (i = 0; i < fsl_edma->drvdata->dmamuxs; i++) {
 		char clkname[32];
 
-		/* eDMAv3 mux register move to TCD area if ch_mux exist */
-		if (drvdata->flags & FSL_EDMA_DRV_SPLIT_REG)
-			break;
-
 		fsl_edma->muxbase[i] = devm_platform_ioremap_resource(pdev,
 								      1 + i);
 		if (IS_ERR(fsl_edma->muxbase[i])) {
-- 
2.47.0


