Return-Path: <dmaengine+bounces-8851-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GO8mJ4wEimluFQAAu9opvQ
	(envelope-from <dmaengine+bounces-8851-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 09 Feb 2026 17:00:12 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D38B11242E
	for <lists+dmaengine@lfdr.de>; Mon, 09 Feb 2026 17:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F15353009145
	for <lists+dmaengine@lfdr.de>; Mon,  9 Feb 2026 16:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64283803F2;
	Mon,  9 Feb 2026 16:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TvhtXe17"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013044.outbound.protection.outlook.com [52.101.72.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BF73803F5;
	Mon,  9 Feb 2026 16:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770652804; cv=fail; b=KsxQFpsTGyBYCv+PxciSD1XhjElCqBrVGp7E7SJmWT6uTTmbsDzX6WzYL++VnjZfTd0B46jezQho3p/mJ9hkxRpNveMqTDUKVDKU3EpgT4H64cW0rHmC4gShyKx0f2/e5gygHZaNlgzWSyLFWetXp54hc2i+aXET/cvHvZQ4fLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770652804; c=relaxed/simple;
	bh=HSQZTeVOkAbIeT8Z0ftc7Iy4GVT1Na6wr/RV6qU6b/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rjd3GiG2GE01kgPLJyC2ExNgUraeIACTdibNWC1tHA0gWtl0wVmkWqoBuN7RwR8Fb+k3NlfCYJkrRInsKLEO44CViEjRgqKlzZ61CPJo6ppMiO7liq2AtPv/BthpMYpJDITO9YYvo+GRdZg7XahOD9++fXMZ7AeM4YndyTdKcDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TvhtXe17; arc=fail smtp.client-ip=52.101.72.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qb1rr3w9K9Ks7wKOgjwChw77XwQFxTJlOHeMxF+48HVAG7JdFJINZ//OpmPzqQCTi6h0wUBh8jpg37JPgb+Y7FO1GQuh97wtDqBYQHWYBSvyv1uQJ1Dd1hflMLm1/HrwvbTvPp7a0EAd9ZMI1jIh8yKVfJJmsrtzAuH/nXoBOpL2oKKDqWpv7cZHK29WjIB/I0GblgC5r+xDcJJ0E21VAN41lu+eh48LmCNq3k895Fl7M2wMulD+7EPo+vZT1YPIj9JuAgKuP0Qc3X8TQcBBJ8OrQT/i1+fxghKZrk1w92QCRtpiQ7iO2Jdb6CFoiOgRt/qXf8j2SPO7tGgF5Es9PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VACdv6TQ+sws/tA1UZSuIpOr8KpShGXgkJK8eSaSoRI=;
 b=D7vMwjulucGu8KWM1WIdeTab+CH/dFvx2FSivIFd4pxF7eQDA7TowkgdtpXWV1Qqt0eMEcFFOT46hC6baDmyLOyAOiomh9t589bO8qnx94jZkdt8JDJi3i+8VIhwnSBGfz0AUOSUm600EmEdY/vQ9uNg5hz4i83BGq7SIb67kg729D+gs46dPrIsPGE/pAswFB0PCNIq9GN20NY864d3ZKiTXzqXMl7ENHYWkBX0sLeaJHHjIcS4UGEsjDTfMRfrQHDKFjdpoP/nrrmt7yeP+0WXpx5/Xyy+uyemtupaqc5IlGrHPZpFPnOwVcnGTPyq6rq1lo7L0g0R8OpW7jwKEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VACdv6TQ+sws/tA1UZSuIpOr8KpShGXgkJK8eSaSoRI=;
 b=TvhtXe17PgRo+NiCwiGmvs0UiogTdWGYjUdt8zZrQSZ6RjGcIcx8v5A7wNwApHxcfqmBJCnMJLncIuCGlmol9OBcoyATdhelHNlEoV6SvrOt768XuTO336PxbEAJEXjnBGHZ2NNTMK6sW7yZnGK5i9w6zY0O/eD9CKRzvEK42nmEdlWHTjA9VIdI3ki8TjPXVR6Ho3GmaJmqcGmdJQ5G+B5CFG4cfvhLxDsiIy9pQHtZN3wBt9EVO31wduiSrCT9LXYEq/BvTHPQ+PVDYCE1xEmLu7Ah1gvOU42BilQ2Sm3vBzYMFWEl7uc8zZf7pXK9XaGIjlPnXJlO1FhjKgGp4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by GV1PR04MB9516.eurprd04.prod.outlook.com (2603:10a6:150:29::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 15:59:56 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9587.010; Mon, 9 Feb 2026
 15:59:56 +0000
Date: Mon, 9 Feb 2026 10:59:50 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: vkoul@kernel.org, mani@kernel.org, cassel@kernel.org,
	jingoohan1@gmail.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	robh@kernel.org, bhelgaas@google.com, kishon@kernel.org,
	jdmason@kudzu.us, allenbh@gmail.com, dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org, ntb@lists.linux.dev,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/8] PCI: endpoint: Add auxiliary resource query API
Message-ID: <aYoEdubp91XBWYw0@lizhi-Precision-Tower-5810>
References: <20260209125316.2132589-1-den@valinux.co.jp>
 <20260209125316.2132589-4-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209125316.2132589-4-den@valinux.co.jp>
X-ClientProxiedBy: SA9PR13CA0169.namprd13.prod.outlook.com
 (2603:10b6:806:28::24) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|GV1PR04MB9516:EE_
X-MS-Office365-Filtering-Correlation-Id: ceac2bda-24c9-45e8-3dfb-08de67f4455d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|52116014|7416014|376014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FxwpOieFHYAVaYqh+W5AuqYdGzHSdW2fcda85SwGTXmlDUerddG1YZqQQR1c?=
 =?us-ascii?Q?xwJtg0+JZdbcDzA31beptl65pRa2qqwE0EZw6MCP62Xap1jUSsL14tUQ/qt/?=
 =?us-ascii?Q?r4moH3nQdJ8BRtxrRsU19uTbpo79X3lLUByam/qDSD5UljCMCaH8uKUw7VF1?=
 =?us-ascii?Q?dOtLFxZtU6kC/K+NJ509h7iwjXH3qUle2KHooq+nZvZIW6+2seZ692Awc7Xi?=
 =?us-ascii?Q?0A+lyQq29zt8P1O3uc4NAFXPnlPPVvcxQeGDUT/KspnkrJKnJZw6z7NyIYXo?=
 =?us-ascii?Q?LpweXUdo042sbT/BbpzKEluX9RBZ8WoSqvUyRzPf90dOtNHWLc5ZehPe3pNj?=
 =?us-ascii?Q?SdHE77364bXsnLJYxYbrhTm5iD6luNo1AuQf2k2us6ATsm6Kv0pUTM7o/IZn?=
 =?us-ascii?Q?6vCx560FsR5dUrf4ge+w4GMqR15YKtun6yhCTA2hu1LxYTNnOUy5RNd+eeYB?=
 =?us-ascii?Q?6g2+fYTWrZeMdUU5133q/PJQwfzxOqVOEwpMV+kCYNNQkv+yVypuoFpBnSbK?=
 =?us-ascii?Q?uOOG4U9WXDFX34cXDTpggU+iUx387k71lg51ySf147HughMMwB2Z18O5x4a7?=
 =?us-ascii?Q?gwGZKvU9liKy7iaS5uKVw9dksMfPK0qSF3amxGu30YXoh5UYzmdjOS4RF9vZ?=
 =?us-ascii?Q?4xLlc4PyqTROcwxdLXMLSDRjlO3ndlQh5+xzotjnKWGVZ3paISclYhHy5c2z?=
 =?us-ascii?Q?Cw36XOelB6iXd2tvZhw5VPGNPd/fJ/ObARzoem8iyXklVjsLMUGu8C7RZUbQ?=
 =?us-ascii?Q?iOe5yQU80MRTIWakfxhmfcTTgxZBLR9SDFgjD+bYAhGPgrA3PswhCxcTR7Gw?=
 =?us-ascii?Q?JI/5JDzqr45uODA51fOHzQbT4G6/5wgi6isZ8wQKPgA+5rub6NTb/9z1HIgM?=
 =?us-ascii?Q?zEX69t5AgAYeBAxKkiKtGQOGEUZ5uoNeA8WbmvMawjw335TZLXLjintk9sBt?=
 =?us-ascii?Q?aRXeUC3RKjcOpIFnKDiG3RgdVXg4hO98YNel+HiSqIfq8laUaBIEbbYTFu5B?=
 =?us-ascii?Q?hnc0mxlUxjgRlUqzCZpvLsoJbBE5yoGOxOV69BnVuljSXYUOJ7Cgc4bfhNyi?=
 =?us-ascii?Q?GKAZ6EyH9rwQbtecVySmAnPQphbnJV2XDwTAMr3iimP1MGxY06CZF0THDVg9?=
 =?us-ascii?Q?EtTEOD+AUPlKUvzspzKOmQ8CCA+gVUsTuLV7lQPreAE/wP1rzJki8oYoZEmQ?=
 =?us-ascii?Q?DbN7Jf8HtBv09mWsr/btvTFfDD+rYxav2WSvhiw5maDe+VLYjT0VHwPHF6oY?=
 =?us-ascii?Q?n2czC6Zm87MmyHzhRll8JTTJB4ItHXy+7WAmPYlRTH3bziDap2ub5/assrH7?=
 =?us-ascii?Q?In2hc+y9MklMV6SJCcxVdDn6Y/uSagRBYqDpqh+Admkch25Shrxd5Ft2N1ye?=
 =?us-ascii?Q?ihg+xNQ/kdLOwIv2DL3+1bO0PG+E/SJMgOXmx8eSlgR5LyuoJWwrN5wie4Z8?=
 =?us-ascii?Q?q/pirm8y3t9EwzL4NAQdl50hISwCjN6CmdVEdLvTqzziNMJZiU+oXkTHUu/K?=
 =?us-ascii?Q?sQh1gT/z6DDpHma78W0n0GctXF5x/MV93kgCZ7oo5KO8HaoT6yoavo76EEcN?=
 =?us-ascii?Q?eBFpdMVKACCC9jDAfr68eNNBoaeSbAIU1YAv/szzqlkGdQs3hV1TAkpPQFLm?=
 =?us-ascii?Q?/D1Kb5tpTjr4ls5OglLqjNQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(52116014)(7416014)(376014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GuPAAl+I14FvpiHSyaPvNn+HmWtiIiISUAiX3HfWy+rBE2pibCVo/gKpifg+?=
 =?us-ascii?Q?QaSpDd2IrAx8wO8NhidX4QiRtz39+srVFOYQGM6qAoYIlMXCGfvKPEYweagx?=
 =?us-ascii?Q?zmbwFmd2Z3eviZUDFCvAokqcRl99bGv2YiLofY7gVvFw1jyA3woQR/XJkCau?=
 =?us-ascii?Q?18SfFax9V82/cVFtS0jPKjoAAQmKLXRiBFPTC9HJpx4ydMoEm8ibTOspAjzg?=
 =?us-ascii?Q?szJOYrdcgrgl0I5UNXB/D3X8kTUM0w1yVLguycNeR3Dq1DGcItzg6/Ky5O5G?=
 =?us-ascii?Q?d3fdhAxdyNbMG1d5BMtRUdKJhPU+rof+pHh/WyXHtgbBEYz3urknTzzz2LDq?=
 =?us-ascii?Q?sRlD/HgkdT+zKPfpcEhYn3gUxN5O1jgL6HMkR5rbX/RoPVIoQuo61JSDNSVb?=
 =?us-ascii?Q?dxTc82nuYTguXNO4BCEthr4X10i+/F62X5qXac7cRQR/C9joLoQGtGioBphC?=
 =?us-ascii?Q?JqPC40rHFE0DNmvaL4s6U48kOfmtCOZiQuNTdeiHaK0swlVEaEQs6H/nBv68?=
 =?us-ascii?Q?R5Y0PfWG1bgXm1hVs9M+lcK2GcbIsgqeIG02VcIM4m0MQiJYXIpDby7Wso7w?=
 =?us-ascii?Q?k1WFWX6qIwWi1DzKotXOenhQdITIIVkGsQ4FMRbecV5LY7vfjL9ZqdhyYm9i?=
 =?us-ascii?Q?00roP9X0tbIEV5RSDr1cHhVpymTfybm16nH0CP2WDwpBklPZdalq9tdvBDvs?=
 =?us-ascii?Q?NXqkRhUV5jhN5jVnZvWhaieYmNzs1Cy6RwDNguISLZdXMcwgoH85l8ioOvV5?=
 =?us-ascii?Q?gD7B7YFfDyWiULb4VsN7fD9DPXMaxtSSxHcIwVxQVceBnLEbGDTcZIcbfhSC?=
 =?us-ascii?Q?LyGnLlCEhE0d8vE9U0Aljl89ktZR+NSAZy0DWYSrrsApFjA93MfSLLx8TJC1?=
 =?us-ascii?Q?5G9nJbcsyVvjqUOF1wz6FTv6STP3+WJuSzAzi6YSq41RniYaYYLhRO8WcoAJ?=
 =?us-ascii?Q?9VF8YHL8FzBt3TWHMx6ipvDK9uNNI6TzcN0HUbg018PI14PVEsl1VIazcj20?=
 =?us-ascii?Q?icleXEbwGSiqMslm7rr7LO/DK6NLXaAyt/3uTgdyZXBHJFJLrOdtCb2eKfZm?=
 =?us-ascii?Q?lI9xIUeOajBjLtEeLF4A0FMkdZCj6MLkqSF1oofY2YOBr1cmCP8jGKTVCI45?=
 =?us-ascii?Q?9AenXPhboodjSWe5bU3YiY+3lx2TMF0HtNlTeUoUHICNft0rOK8VGAz9NbrW?=
 =?us-ascii?Q?5ipZ9Bd68C9qjKvN8g7zhlOd0SndlGr8XaYUy10t+v//SDd3fkXs2Ymatcvs?=
 =?us-ascii?Q?gr5gg3jPfDHb1q/wmwTlvUqk5hw0ttKrqn2IHmsP4FLMzPRufMfVNyjgL4Va?=
 =?us-ascii?Q?SgwDl54MyGwif/n6HADX7Sb/AIDErgvHh069RF7bKyUFzJ8liHMJ1Dkh9b8A?=
 =?us-ascii?Q?c84ydfFglEeB6pXIodZDBG/2hs+jgjVDqECFicMfJLo+qqRs/3pO6wllQ2EI?=
 =?us-ascii?Q?t5UltkRMKSf8Gv68wfzCuT6DzqeloKe7o1PJsCiBxV8xPaduOoUzKCLk5TbL?=
 =?us-ascii?Q?uBwGHirDOBkDIvmqpl9HS3F4Q0EoezS5ERLPbmukfiO/5d+GbrvM3LfvpBKC?=
 =?us-ascii?Q?+0FC26nG8uqQWIKBK7TD2qU7/Nq3Pw5hVP2sDLhurKm/e9V+kpsLR5RgQyex?=
 =?us-ascii?Q?USSbzoGtCog16FW9LgN016IDdeSAlTtyBxdewx6WBoPpAzljg2W+vOXxCjKW?=
 =?us-ascii?Q?BgSSR5aI87DtHyg+7oVDPJ2Gz/zZjzpCzn+AgG9450PqJG2ztacoFhXmL/pS?=
 =?us-ascii?Q?Zz7qezmXcA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ceac2bda-24c9-45e8-3dfb-08de67f4455d
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 15:59:56.7980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4oTPv+gXhuBfGUR4DYrWgY1YWLhMtcMPrbXLZLQ/7+y7Zb0sG8dXbWDrIsCzO2qYDHTW8c0A8f+nnLt2f5H3zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9516
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8851-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,google.com,kudzu.us,vger.kernel.org,lists.linux.dev];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim]
X-Rspamd-Queue-Id: 3D38B11242E
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 09:53:11PM +0900, Koichiro Den wrote:
> Endpoint controller drivers may integrate auxiliary blocks (e.g. DMA
> engines) whose register windows and descriptor memories metadata need to
> be exposed to a remote peer. Endpoint function drivers need a generic
> way to discover such resources without hard-coding controller-specific
> helpers.
>
> Add pci_epc_get_aux_resources() and the corresponding pci_epc_ops
> get_aux_resources() callback. The API returns a list of resources
> described by type, physical address and size, plus type-specific
> metadata.
>
> Passing resources == NULL (or num_resources == 0) returns the required
> number of entries.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
Reviewed-by: Frank Li <Frank.Li@nxp.com>
>  drivers/pci/endpoint/pci-epc-core.c | 41 +++++++++++++++++++++++++
>  include/linux/pci-epc.h             | 46 +++++++++++++++++++++++++++++
>  2 files changed, 87 insertions(+)
>
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index 068155819c57..01de4bd5047a 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -155,6 +155,47 @@ const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
>  }
>  EXPORT_SYMBOL_GPL(pci_epc_get_features);
>
> +/**
> + * pci_epc_get_aux_resources() - query EPC-provided auxiliary resources
> + * @epc: EPC device
> + * @func_no: function number
> + * @vfunc_no: virtual function number
> + * @resources: output array (may be NULL to query required count)
> + * @num_resources: size of @resources array in entries (0 when querying count)
> + *
> + * Some EPC backends integrate auxiliary blocks (e.g. DMA engines) whose control
> + * registers and/or descriptor memories can be exposed to the host by mapping
> + * them into BAR space. This helper queries the backend for such resources.
> + *
> + * Return:
> + *   * >= 0: number of resources returned (or required, if @resources is NULL)
> + *   * -EOPNOTSUPP: backend does not support auxiliary resource queries
> + *   * other -errno on failure
> + */
> +int pci_epc_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> +			      struct pci_epc_aux_resource *resources,
> +			      int num_resources)
> +{
> +	int ret;
> +
> +	if (!epc || !epc->ops)
> +		return -EINVAL;
> +
> +	if (func_no >= epc->max_functions)
> +		return -EINVAL;
> +
> +	if (!epc->ops->get_aux_resources)
> +		return -EOPNOTSUPP;
> +
> +	mutex_lock(&epc->lock);
> +	ret = epc->ops->get_aux_resources(epc, func_no, vfunc_no, resources,
> +					  num_resources);
> +	mutex_unlock(&epc->lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(pci_epc_get_aux_resources);
> +
>  /**
>   * pci_epc_stop() - stop the PCI link
>   * @epc: the link of the EPC device that has to be stopped
> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> index c021c7af175f..5d3e1986b49f 100644
> --- a/include/linux/pci-epc.h
> +++ b/include/linux/pci-epc.h
> @@ -61,6 +61,45 @@ struct pci_epc_map {
>  	void __iomem	*virt_addr;
>  };
>
> +/**
> + * enum pci_epc_aux_resource_type - auxiliary resource type identifiers
> + * @PCI_EPC_AUX_DMA_CTRL_MMIO: Integrated DMA controller register window (MMIO)
> + * @PCI_EPC_AUX_DMA_CHAN_DESC: Per-channel DMA descriptor
> + *
> + * EPC backends may expose auxiliary blocks (e.g. DMA engines) by mapping their
> + * register windows and descriptor memories into BAR space. This enum
> + * identifies the type of each exposable resource.
> + */
> +enum pci_epc_aux_resource_type {
> +	PCI_EPC_AUX_DMA_CTRL_MMIO,
> +	PCI_EPC_AUX_DMA_CHAN_DESC,
> +};
> +
> +/**
> + * struct pci_epc_aux_resource - a physical auxiliary resource that may be
> + *                               exposed for peer use
> + * @type:      resource type, see enum pci_epc_aux_resource_type
> + * @phys_addr: physical base address of the resource
> + * @size:      size of the resource in bytes
> + * @u:         type-specific metadata
> + *
> + * For @PCI_EPC_AUX_DMA_CHAN_DESC, @u.dma_chan_desc provides per-channel
> + * information.
> + */
> +struct pci_epc_aux_resource {
> +	enum pci_epc_aux_resource_type type;
> +	phys_addr_t phys_addr;
> +	resource_size_t size;
> +
> +	union {
> +		/* PCI_EPC_AUX_DMA_CHAN_DESC */
> +		struct {
> +			int irq;
> +			resource_size_t db_offset;
> +		} dma_chan_desc;
> +	} u;
> +};
> +
>  /**
>   * struct pci_epc_ops - set of function pointers for performing EPC operations
>   * @write_header: ops to populate configuration space header
> @@ -84,6 +123,7 @@ struct pci_epc_map {
>   * @start: ops to start the PCI link
>   * @stop: ops to stop the PCI link
>   * @get_features: ops to get the features supported by the EPC
> + * @get_aux_resources: ops to retrieve controller-owned auxiliary resources
>   * @owner: the module owner containing the ops
>   */
>  struct pci_epc_ops {
> @@ -115,6 +155,9 @@ struct pci_epc_ops {
>  	void	(*stop)(struct pci_epc *epc);
>  	const struct pci_epc_features* (*get_features)(struct pci_epc *epc,
>  						       u8 func_no, u8 vfunc_no);
> +	int	(*get_aux_resources)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> +				     struct pci_epc_aux_resource *resources,
> +				     int num_resources);
>  	struct module *owner;
>  };
>
> @@ -309,6 +352,9 @@ int pci_epc_start(struct pci_epc *epc);
>  void pci_epc_stop(struct pci_epc *epc);
>  const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
>  						    u8 func_no, u8 vfunc_no);
> +int pci_epc_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> +			      struct pci_epc_aux_resource *resources,
> +			      int num_resources);
>  enum pci_barno
>  pci_epc_get_first_free_bar(const struct pci_epc_features *epc_features);
>  enum pci_barno pci_epc_get_next_free_bar(const struct pci_epc_features
> --
> 2.51.0
>

