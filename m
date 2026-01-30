Return-Path: <dmaengine+bounces-8623-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMDlJeTQfGlbOwIAu9opvQ
	(envelope-from <dmaengine+bounces-8623-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 16:40:20 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 586E0BC1EF
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 16:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E3A6C304EEA1
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 15:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BFB336EE3;
	Fri, 30 Jan 2026 15:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YJ9PkPMJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011028.outbound.protection.outlook.com [52.101.70.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F397333439;
	Fri, 30 Jan 2026 15:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769787552; cv=fail; b=JFbDvKYwr6QbmPoUGswdZorC0iKrgLXVsJjEqIRo6R/2/YieylrCNNsRpt9zVk8pPMMQIOt3oRgH7n1uV52bxhz9GEGPGzeGv9WyFgBGD2CHCaKiX+lmXH4JEDceR1CKUjWAU49HIpXO/8xPgQnX6pnxFhjXuYk7hQSK4G4tatA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769787552; c=relaxed/simple;
	bh=eoOJ8gcgpD9lPitZuiYR8AHq29rX2BMGIQnzIOc6qTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Vazer2BjJJZ87Z7s0pV7y0ZhrluDayPlW/2fYs9KNiC7fMQHXV8PzcK8eZMK9hZoHSvaRncu4RAHvwVxQNv7flmrHUYPPOEDoQcLsBxH84+xWtX3PYAs1V6U/8RqqZY6yrHCY/XIlM4MOntkP5C/g58PTFb9QVedwzzkqSzCdVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YJ9PkPMJ; arc=fail smtp.client-ip=52.101.70.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aTYXz12hU5lXjzyyeceq7/9xo37CxGLJuJWMN+5Ekiv0VaEjFh40UKhhxr2yzq7JIIXwgt1PfpQssmk1cet7qsFk+X7K3FouvF5mNf3Pv/yP0GbSyC8PYa6vbri1ZrzP3WzD/80U+At1QbibffKnQ0WmFdhRTkzOvdRy8+UhSt69r4dlAoNEWkdsqR04tzQ9wlJjzkiuWId/4zsXIKlNiRyHma+y697aym3Jd6vQCjXridThCeejDfjkSWYiF/QlEIAaETqBrzjhVJ8hQ2BbA3FFTGTlG9f6Y88y7X4K4RhkUcp03HamAo9iaL/4Bl5ucpL1j9gS8Mt2vUtse8/mcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xkPMtR+PVZkNAYTqe9uWj0mNxfGf+ufcPykv+8TMmmw=;
 b=pIDaV+mqKvCcBMsvWCPZMxBEyP5iZA25yrEdqJf7GDqhmch4+h2S4xRzamLUeGfVtn2YA8Yux1HOlDAKKVR6PCJz/NPv0FjoyCZkZkkahcutlaYB6gNEvJox9E16u7+pFLSoo9YVMNUALzTnfnOFdG+hxguXc41/Lye9D8TtN3miqQdCU7xDWmvtlklx2+UW/Qk6k8fv19OABsDbIX7Pa7FI2oKdkxJlEGO7rBRyZHA9gec1e031b8IJNyG22uKW2v/zN6OyjK6xq3vOlDwoDbzRPVrUbZp2tBmSdNI4FVCwDhHtuXiCNZm6XMOJQEigaMVk5Dhgs8ug1GctvC7qjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xkPMtR+PVZkNAYTqe9uWj0mNxfGf+ufcPykv+8TMmmw=;
 b=YJ9PkPMJNS95z28jEZ6npYV4OAcLUFznkUhW0tTOw5rRyPbTl4ShS+PUx2rkMH12MX8ocbEWOvYSP9fCXajhxz2qdx4iCxg6d8hXlzH7S5x0haMmexNeqw3oWU7PSlHm3Qr+gWgD4KjaJG7iORgYHcNwswuz6wxf37oSMikJeFg4EyrNi2Esncw282lqjRCZDrb1H65L1eMWpngjxRgki168P5GqG3yHZXaVZfWsGaKhtUH6sW0qW9A1SCoS/wqmg7HDl4OA7B941xYvJtXlLUKCsX3gtSh4TXqwPmRvVqj4n1dRFKVWstN6iC9JWTz0PqNBsb7bTQOUhEOcdl8WIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DU4PR04MB10958.eurprd04.prod.outlook.com (2603:10a6:10:581::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Fri, 30 Jan
 2026 15:39:07 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9564.010; Fri, 30 Jan 2026
 15:39:07 +0000
Date: Fri, 30 Jan 2026 10:38:58 -0500
From: Frank Li <Frank.li@nxp.com>
To: Sai Sree Kartheek Adivi <s-adivi@ti.com>
Cc: peter.ujfalusi@gmail.com, vkoul@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, nm@ti.com,
	ssantosh@kernel.org, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, vigneshr@ti.com,
	r-sharma3@ti.com, gehariprasath@ti.com
Subject: Re: [PATCH v4 03/19] dmaengine: ti: k3-udma: move static inline
 helper functions to header file
Message-ID: <aXzQkqUuT/c/Ypwc@lizhi-Precision-Tower-5810>
References: <20260130110159.359501-1-s-adivi@ti.com>
 <20260130110159.359501-4-s-adivi@ti.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260130110159.359501-4-s-adivi@ti.com>
X-ClientProxiedBy: SJ0PR13CA0057.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::32) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DU4PR04MB10958:EE_
X-MS-Office365-Filtering-Correlation-Id: 25dbf708-adf3-4eaf-0e0f-08de6015b430
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|7416014|376014|366016|52116014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y5CwxVpWw56bnq/aAJfn+JUdn0+xcoALBtrkUlyLEhYxlXOILVL0pYhZgK+f?=
 =?us-ascii?Q?Ty6Ne2lTvSUKXh6qmdRXsEdtN5jct6egfbMfM/DRpl09zZRUTA852lvNOmBN?=
 =?us-ascii?Q?yOs8/Ts/C4Ms5Obbe+OwRpo4TfyU8j2khi+DkXKYboIruHM2zS5+d2+PtjjF?=
 =?us-ascii?Q?XQwn8NJCkKgfpSE0lqIVOZqUNsStnBiQxsMuExnisrmAIgUsWdhWvVxeoWq0?=
 =?us-ascii?Q?XNhP0ItujcKqGPAxgoIOBUBZowpfbWRod+eqQSsCYUGuHpf/szIEhiSiTyV2?=
 =?us-ascii?Q?pGlfDlZIf0Kv/8ssIxR6X9nPe18XhA1Ejx8ieJCdp+2dtfoOMIlW+QcUVU5H?=
 =?us-ascii?Q?EUXMku58eApdR+5S0+B1YAzbjErvsmJl2IQWoLZ0b/c/RkxPxvjMsWsY5NiF?=
 =?us-ascii?Q?bNHHMwAdsZRLAns3gx9Rn9vtrCz1gOHX5uJcKLVg1QXvr06M243nbA0LxcIz?=
 =?us-ascii?Q?bJ3mTGMJKQp9tlMwelUm+KsEJc80/X8tRL83CBKYZpxApjugkncukvt4KTh6?=
 =?us-ascii?Q?8ReM8CLLnE/dkypfCGg3mI+d0bfnzQKUpsz+vYJWc5nS1dFBRn5MkSyGOjF6?=
 =?us-ascii?Q?eUnaHLLlB+XoC+LoogyUiwp6Z//aD2IObpAAvPavBbAxpQlPEKH9JuC4PuyL?=
 =?us-ascii?Q?hKTxdJIbK7L5PQS7gNpOCV6o+H26RtPlEKDwFTZvqIRZlmA2fqVEkYWAyiJK?=
 =?us-ascii?Q?vPxbDcvuv+VRTNwSLOHedU1L58/h62TTyrVcqbyFbTd2J1G4YXMocB1CbY1l?=
 =?us-ascii?Q?mlZsrMtCMdAv2VTp9tFYqXmm7Llb11Ht5oJvgoWeu/4sIstoogeQKplyqqZW?=
 =?us-ascii?Q?x+ziHO00R/4gGWPAnWxUCn2l1EafLmcxOOzTSCZrGHIxUfntlq5o2E5N8D2U?=
 =?us-ascii?Q?3gJwtG6zdCO708YZ++7eL8D2uzYTUIUSKEj2T2afliB/1G8HOsmOteCn7/9I?=
 =?us-ascii?Q?01E8ljnHA/9oX/Owrx1uNe1fKvLQaRL3J6MFck0on3ijoO4UVuTZxF2SwWav?=
 =?us-ascii?Q?1IvXWxZMD1/EyP5/dc+cA+26Ag1B0uaIjhLyJs+XO1d28qkGBG9pX477tdCK?=
 =?us-ascii?Q?JdYBOua3ERNlCso5oWIftDsSlJ7TANdU7iN2zzZMM/2uLyPnuKJOfCVbQT+M?=
 =?us-ascii?Q?AmBrwiO+3USZJsGSJqeUBFaiIGle1ciRM1W/1GNZxJattxnBe6kyaPf7YLGG?=
 =?us-ascii?Q?/BC27NRRdaeq5dFmvZnQoQIEHqnZmQgdAw+Y7Q4BPpDrHnq75mgfMQvEWklh?=
 =?us-ascii?Q?iAGGiricJOlY2Fyjv3Bxp80Z0L/3rZugxz9Kd1MJ0wd+oy1nCuWVxHIHT99c?=
 =?us-ascii?Q?cYsf5SxdPK3cZaKOPKraTd2IbuSQVSiR1NecJkK98gv1leK8Mw78lNWAoJJ6?=
 =?us-ascii?Q?C+GLTrHMg6rl5KqRdqcjTv9trgKLiz0TNwNu13AXwFwOiaZQVryefLfVX/Rd?=
 =?us-ascii?Q?h3FJICreVZyQ7W/l+xMt856lBm9abs25EAMrlUNckl0AAFnEpM2hJ+ob1BCP?=
 =?us-ascii?Q?Pc29iA2jiyr3/Cfqb0Edj+cg2aD0t8H6Z6KQwKuxaePsqvbAZMrW2poIm9Hc?=
 =?us-ascii?Q?nkq1ix/4MMlc/VQZK3OIGKD31hYJ+ROSspxbN6J87F0B1aLwfd1qMlS0UDhq?=
 =?us-ascii?Q?kLGRpYBBZ6DZtZeSdnkAJiw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(7416014)(376014)(366016)(52116014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SRyVVq8BAQgD4j2kB8u62tdUv44ouYS1HtPGTflbubAj/Wk8sX+aFgjXM5IN?=
 =?us-ascii?Q?1LvqcS+BBkmP7IexMgdrOj04bjFV5ibBoxlJp9yly5GiBKSkW69opK4HUzMU?=
 =?us-ascii?Q?AZKMg0PBOuzBLmacm+lyfrduGNqHwapp0Rdqanq681TAtxAeLE9oWxRSfown?=
 =?us-ascii?Q?avrfGuIY4CJu+s75HZqkbeSuCCb+V3gCDqLWKZ1HWoS3mZP0drCxFBbGyhM8?=
 =?us-ascii?Q?6kHOWVUVoJSzMqfST9IinrB5z75WvpeYFQTsTuZE5yTCMMAjiAuGVYLgE3uL?=
 =?us-ascii?Q?Fqs4uEkw5MsuIlyeW543T7ViFCnL+a89ykCjXLKIoPBY5jipAZe8ik6ITd0Q?=
 =?us-ascii?Q?InNUr9R7L1C8Uf3HbTXVUJvPZ7R56YPpgaiXWIlKptj4wQNqWMC0VYWR5DiZ?=
 =?us-ascii?Q?Pgh4L+2GXPWIiOggVwpXj3ftTPD6xFTfuRnBn9Ue0oAXPDyZKOca0nDn8QeD?=
 =?us-ascii?Q?Ep89bSH0KpScm/8L8vCwY33xd4rdQccBHAbZKbEymDHyS4oWTTtL+UsqZikF?=
 =?us-ascii?Q?iDk5rbrsOdHWV/eEbnHt9fOCMRQMXXrb+gxRdI1n5V0BrcK/64KE/zitXsxt?=
 =?us-ascii?Q?TaQ9osYEiEyiovMekiuai4/wpFgEOFeAWi2yikGoZ+MTkClUWGZOyBOdmxuf?=
 =?us-ascii?Q?s7/tt6do862rGKr38MApPOl3v4dWoHs+3MoOXtCR8W4p8Y28MRMlk4DjXcex?=
 =?us-ascii?Q?5LidwZBsucJUBR7AUhdk+TeyNjTdoE7yEyUCwizVG/q0XHfa5oFK+gF/ceec?=
 =?us-ascii?Q?1j4hF6SVR4DeKCx1XpTvhUJ4sQuj+jWsyY7yMPqBVWb5PnWJ/Fq5NmZkJsin?=
 =?us-ascii?Q?agkLUhgu0pXRc+hYT/GVX1laSgNqBj4tVXDWrNXQIBFPm7hM50CV3pZ0Lrss?=
 =?us-ascii?Q?om9kEk/mDGCZYDj2WSwAadB4QQ++uHjQqOKVXI2Cb76HG1n4hzRucqs4ouLT?=
 =?us-ascii?Q?GuFrOGRANc9l1JnJUwCDoGX5EscIeSl6ETuhZkwSHXrHkwfbxs3rzK845WHX?=
 =?us-ascii?Q?tRRMKpJtpzZiRSU/u5KaRHJZciliveXCPOfKyw1RCiTII9w4LM+OMH9F8Tef?=
 =?us-ascii?Q?KCwi3WRDmYZRfqy4LD4+1bEprcexQnV6j50ifaqw2EuSxRtzmzD3JBXNDVAD?=
 =?us-ascii?Q?vPc/xzBxFn8oWIV9iS9btiX0W17Zahs1GctjNAUvC1ltuM7wmjfrX4ikTvof?=
 =?us-ascii?Q?bAUSKBK3xsshkMVYP87XadCL4mGrRFszBrPs5Wj1YmmFdDA66tojArTxwrBg?=
 =?us-ascii?Q?ghDhvsk9cLeWzPZBkm4tdnhoH+SF/41rn6/CZLvWu3Ju0uYONNb5qYNSUq7n?=
 =?us-ascii?Q?0/1Aj/gBCeRe29Cot0Chg0R3DjCcdxsjMA21HwwqbtmJVe+Y/xciHGfkRqui?=
 =?us-ascii?Q?ShkDZEEtN7yj3f/OAsMk5htTFcRT4+xIighMTF3axL2Nw1CD0SyiVPkSCs0F?=
 =?us-ascii?Q?h6iHcg410k8f4wes55dM6cQKtB21eyeggFv0TphP1jSQCviFo1WkDbc35Sr4?=
 =?us-ascii?Q?85dU0oBm3v1EJDitiUyH/xTS+EFOnnuqxQgEVedyOwQYzNIX0DMzkwwpA/b4?=
 =?us-ascii?Q?Duive7gzHXykRWhtOPje0YOQnrR+oc4LjkD4Z/9CRTsYu0oNNlaftRY8ZXwy?=
 =?us-ascii?Q?qm71kjM8xe2Ln1rLewcx60jlpZfostPem+E3wMGHWVwgqt97fIJNt2STucOk?=
 =?us-ascii?Q?I0qcwQX9VAmSK01MO8A9Fgw+ZbQ5AlEghq6lw4EKVHrtAzwY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25dbf708-adf3-4eaf-0e0f-08de6015b430
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 15:39:06.9816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GnEisqKli6sqfz3ZwomqHQ8WMVn0iVSRN69Xqgx6GPix3/GyxBOZlF6EdgtPhJtN0ADVUKF0yZPY+D7baEhwmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10958
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8623-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,ti.com,vger.kernel.org,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ti.com:email,nxp.com:email,nxp.com:dkim]
X-Rspamd-Queue-Id: 586E0BC1EF
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 04:31:43PM +0530, Sai Sree Kartheek Adivi wrote:
> Move static inline helper functions in k3-udma.c to k3-udma.h header
> file for better separation and re-use.
>
> Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>
>  drivers/dma/ti/k3-udma.c | 108 --------------------------------------
>  drivers/dma/ti/k3-udma.h | 109 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 109 insertions(+), 108 deletions(-)
>
> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> index e0684d83f9791..4adcd679c6997 100644
> --- a/drivers/dma/ti/k3-udma.c
> +++ b/drivers/dma/ti/k3-udma.c
> @@ -40,91 +40,6 @@ static const char * const mmr_names[] = {
>  	[MMR_TCHANRT] = "tchanrt",
>  };
>
> -static inline struct udma_dev *to_udma_dev(struct dma_device *d)
> -{
> -	return container_of(d, struct udma_dev, ddev);
> -}
> -
> -static inline struct udma_chan *to_udma_chan(struct dma_chan *c)
> -{
> -	return container_of(c, struct udma_chan, vc.chan);
> -}
> -
> -static inline struct udma_desc *to_udma_desc(struct dma_async_tx_descriptor *t)
> -{
> -	return container_of(t, struct udma_desc, vd.tx);
> -}
> -
> -/* Generic register access functions */
> -static inline u32 udma_read(void __iomem *base, int reg)
> -{
> -	return readl(base + reg);
> -}
> -
> -static inline void udma_write(void __iomem *base, int reg, u32 val)
> -{
> -	writel(val, base + reg);
> -}
> -
> -static inline void udma_update_bits(void __iomem *base, int reg,
> -				    u32 mask, u32 val)
> -{
> -	u32 tmp, orig;
> -
> -	orig = readl(base + reg);
> -	tmp = orig & ~mask;
> -	tmp |= (val & mask);
> -
> -	if (tmp != orig)
> -		writel(tmp, base + reg);
> -}
> -
> -/* TCHANRT */
> -static inline u32 udma_tchanrt_read(struct udma_chan *uc, int reg)
> -{
> -	if (!uc->tchan)
> -		return 0;
> -	return udma_read(uc->tchan->reg_rt, reg);
> -}
> -
> -static inline void udma_tchanrt_write(struct udma_chan *uc, int reg, u32 val)
> -{
> -	if (!uc->tchan)
> -		return;
> -	udma_write(uc->tchan->reg_rt, reg, val);
> -}
> -
> -static inline void udma_tchanrt_update_bits(struct udma_chan *uc, int reg,
> -					    u32 mask, u32 val)
> -{
> -	if (!uc->tchan)
> -		return;
> -	udma_update_bits(uc->tchan->reg_rt, reg, mask, val);
> -}
> -
> -/* RCHANRT */
> -static inline u32 udma_rchanrt_read(struct udma_chan *uc, int reg)
> -{
> -	if (!uc->rchan)
> -		return 0;
> -	return udma_read(uc->rchan->reg_rt, reg);
> -}
> -
> -static inline void udma_rchanrt_write(struct udma_chan *uc, int reg, u32 val)
> -{
> -	if (!uc->rchan)
> -		return;
> -	udma_write(uc->rchan->reg_rt, reg, val);
> -}
> -
> -static inline void udma_rchanrt_update_bits(struct udma_chan *uc, int reg,
> -					    u32 mask, u32 val)
> -{
> -	if (!uc->rchan)
> -		return;
> -	udma_update_bits(uc->rchan->reg_rt, reg, mask, val);
> -}
> -
>  static int navss_psil_pair(struct udma_dev *ud, u32 src_thread, u32 dst_thread)
>  {
>  	struct udma_tisci_rm *tisci_rm = &ud->tisci_rm;
> @@ -216,17 +131,6 @@ static void udma_dump_chan_stdata(struct udma_chan *uc)
>  	}
>  }
>
> -static inline dma_addr_t udma_curr_cppi5_desc_paddr(struct udma_desc *d,
> -						    int idx)
> -{
> -	return d->hwdesc[idx].cppi5_desc_paddr;
> -}
> -
> -static inline void *udma_curr_cppi5_desc_vaddr(struct udma_desc *d, int idx)
> -{
> -	return d->hwdesc[idx].cppi5_desc_vaddr;
> -}
> -
>  static struct udma_desc *udma_udma_desc_from_paddr(struct udma_chan *uc,
>  						   dma_addr_t paddr)
>  {
> @@ -369,11 +273,6 @@ static bool udma_is_chan_paused(struct udma_chan *uc)
>  	return false;
>  }
>
> -static inline dma_addr_t udma_get_rx_flush_hwdesc_paddr(struct udma_chan *uc)
> -{
> -	return uc->ud->rx_flush.hwdescs[uc->config.pkt_mode].cppi5_desc_paddr;
> -}
> -
>  static int udma_push_to_ring(struct udma_chan *uc, int idx)
>  {
>  	struct udma_desc *d = uc->desc;
> @@ -775,13 +674,6 @@ static void udma_cyclic_packet_elapsed(struct udma_chan *uc)
>  	d->desc_idx = (d->desc_idx + 1) % d->sglen;
>  }
>
> -static inline void udma_fetch_epib(struct udma_chan *uc, struct udma_desc *d)
> -{
> -	struct cppi5_host_desc_t *h_desc = d->hwdesc[0].cppi5_desc_vaddr;
> -
> -	memcpy(d->metadata, h_desc->epib, d->metadata_size);
> -}
> -
>  static bool udma_is_desc_really_done(struct udma_chan *uc, struct udma_desc *d)
>  {
>  	u32 peer_bcnt, bcnt;
> diff --git a/drivers/dma/ti/k3-udma.h b/drivers/dma/ti/k3-udma.h
> index 37aa9ba5b4d18..3a786b3eddc67 100644
> --- a/drivers/dma/ti/k3-udma.h
> +++ b/drivers/dma/ti/k3-udma.h
> @@ -447,6 +447,115 @@ struct udma_chan {
>  	u32 id;
>  };
>
> +/* K3 UDMA helper functions */
> +static inline struct udma_dev *to_udma_dev(struct dma_device *d)
> +{
> +	return container_of(d, struct udma_dev, ddev);
> +}
> +
> +static inline struct udma_chan *to_udma_chan(struct dma_chan *c)
> +{
> +	return container_of(c, struct udma_chan, vc.chan);
> +}
> +
> +static inline struct udma_desc *to_udma_desc(struct dma_async_tx_descriptor *t)
> +{
> +	return container_of(t, struct udma_desc, vd.tx);
> +}
> +
> +/* Generic register access functions */
> +static inline u32 udma_read(void __iomem *base, int reg)
> +{
> +	return readl(base + reg);
> +}
> +
> +static inline void udma_write(void __iomem *base, int reg, u32 val)
> +{
> +	writel(val, base + reg);
> +}
> +
> +static inline void udma_update_bits(void __iomem *base, int reg,
> +				    u32 mask, u32 val)
> +{
> +	u32 tmp, orig;
> +
> +	orig = readl(base + reg);
> +	tmp = orig & ~mask;
> +	tmp |= (val & mask);
> +
> +	if (tmp != orig)
> +		writel(tmp, base + reg);
> +}
> +
> +/* TCHANRT */
> +static inline u32 udma_tchanrt_read(struct udma_chan *uc, int reg)
> +{
> +	if (!uc->tchan)
> +		return 0;
> +	return udma_read(uc->tchan->reg_rt, reg);
> +}
> +
> +static inline void udma_tchanrt_write(struct udma_chan *uc, int reg, u32 val)
> +{
> +	if (!uc->tchan)
> +		return;
> +	udma_write(uc->tchan->reg_rt, reg, val);
> +}
> +
> +static inline void udma_tchanrt_update_bits(struct udma_chan *uc, int reg,
> +					    u32 mask, u32 val)
> +{
> +	if (!uc->tchan)
> +		return;
> +	udma_update_bits(uc->tchan->reg_rt, reg, mask, val);
> +}
> +
> +/* RCHANRT */
> +static inline u32 udma_rchanrt_read(struct udma_chan *uc, int reg)
> +{
> +	if (!uc->rchan)
> +		return 0;
> +	return udma_read(uc->rchan->reg_rt, reg);
> +}
> +
> +static inline void udma_rchanrt_write(struct udma_chan *uc, int reg, u32 val)
> +{
> +	if (!uc->rchan)
> +		return;
> +	udma_write(uc->rchan->reg_rt, reg, val);
> +}
> +
> +static inline void udma_rchanrt_update_bits(struct udma_chan *uc, int reg,
> +					    u32 mask, u32 val)
> +{
> +	if (!uc->rchan)
> +		return;
> +	udma_update_bits(uc->rchan->reg_rt, reg, mask, val);
> +}
> +
> +static inline dma_addr_t udma_curr_cppi5_desc_paddr(struct udma_desc *d,
> +						    int idx)
> +{
> +	return d->hwdesc[idx].cppi5_desc_paddr;
> +}
> +
> +static inline void *udma_curr_cppi5_desc_vaddr(struct udma_desc *d, int idx)
> +{
> +	return d->hwdesc[idx].cppi5_desc_vaddr;
> +}
> +
> +static inline dma_addr_t udma_get_rx_flush_hwdesc_paddr(struct udma_chan *uc)
> +{
> +	return uc->ud->rx_flush.hwdescs[uc->config.pkt_mode].cppi5_desc_paddr;
> +}
> +
> +static inline void udma_fetch_epib(struct udma_chan *uc, struct udma_desc *d)
> +{
> +	struct cppi5_host_desc_t *h_desc = d->hwdesc[0].cppi5_desc_vaddr;
> +
> +	memcpy(d->metadata, h_desc->epib, d->metadata_size);
> +}
> +
>  /* Direct access to UDMA low lever resources for the glue layer */
>  int xudma_navss_psil_pair(struct udma_dev *ud, u32 src_thread, u32 dst_thread);
>  int xudma_navss_psil_unpair(struct udma_dev *ud, u32 src_thread,
> --
> 2.34.1
>

