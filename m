Return-Path: <dmaengine+bounces-8619-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBZpBYLPfGlbOwIAu9opvQ
	(envelope-from <dmaengine+bounces-8619-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 16:34:26 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC2CBC0F0
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 16:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C18433019F09
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 15:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DEF33031C;
	Fri, 30 Jan 2026 15:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LSKGoflc"
X-Original-To: dmaengine@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011060.outbound.protection.outlook.com [52.101.65.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588B61EA7DB;
	Fri, 30 Jan 2026 15:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769787262; cv=fail; b=hPujdqIWWViKWhTGOA77oJKPxJ//Yks2BpQkvisG1Q6QOTjtLh/a4qJm+DuLRnfWuUH8qqeqnFLO5m/Ek7iUTftlymrLvrwGvkKpYTz08alcj+Tibrg3VOmPr71/5pnZiwNF9Y1+yJXyFgszNMEjT0pmkiYASCP36FjhPqmVM1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769787262; c=relaxed/simple;
	bh=wTeVZRFEaPUI2vPpMohJKywKQ+Jy1m2Y+y7+MZtF7rI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UwKM2DGyASUaXdPjveLgLCJQb1ftxA0HEfq65EHQmLvbQjCe/Ih+3YYg3Go1E8Dly+CRxEUC8YyjlIvs8x3l+1wt3Tnv/fFASk2rSjchMacNEmWPhVQD7BwnLgvaYztgM9McHDUZhywiT4UFu1v07Wl5c47MXJxWsFhzdbEf2D8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LSKGoflc; arc=fail smtp.client-ip=52.101.65.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XwrueY3UvW3ExuAGstYmoIIVch1SqqaAMIgrXpJgsqvmyYJ32ssc4tU+elm++vmdZwptu66kHr7QCWcgQ1rvmwE0gSAEL0He6iazgb5wQSDRdeDI0t99lglJPshUqjlQRhDCWdxMe2JGy6kLIBkh6Crh4iNUeYLYc45F+vIptAGe3JzKrDu3PtG335Xs+WE1s4uoZy6Mvl+xPmUE+EH+Y0+UGuii9xsdLQh/SRj3jn50guPrAH+gSO6EJf04TQK6KJjabLaRO+4fMKdFBWal8wh71zjVoJUza3Rj2GN0J27rg2bx9a3B4KgJk+hxVNYmLShSdWopgMBQZVxYhvNggw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c7qCNVrRFkd0ftN72A4k9TptEGPlOOp1rhmfU+DF4z0=;
 b=f205Ztxl0RNUgafFtUeVgcRmZWQlSiOdM/A3+QlYwfHAL+1Yx/SsuUWC6Fy4xChacSSBkyX9iJMmaFwnQwZ+X1GYFfNK6j0SnHsoBOKLovQ/uZAXsGjRQnNXW0wbSBNgm2dyiR8aMMDuwPDhRBK+9+PUq3i4P9YjRwSJ4r7vITBVQZG4vXNBQlooWzNg3ToXrYqYGT4SqUhB3HNBmg6/cpZzY3UQbK7lOWp5OW16DyTyHPEAGPWYvusmdjJ2Xi/n8ZDKDMuw0w899JNy1TAh9xM9L/dcmLDm5k4MV4HGrYrYcJsdndzv4BQVt/BOhS2v96y+mYq+QYcNldbTHnErKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7qCNVrRFkd0ftN72A4k9TptEGPlOOp1rhmfU+DF4z0=;
 b=LSKGoflcl3sQsbYvbJTN2q72xkHwxe/b1KwPsch8K317/gjjYss4DhSjBjhDLGdyIkNIZnVqHCTHSE8Ijf/DozivZwfusxbg2yfZBUEXNmfS8NTUklzpRYSz7eMEJQPYP9HB8Iaqjpq8iRtAUYuRI2Dk2ymEhjyR2nWyUgZAUqBF2nzxWVFQhLRr7gov2nB26EZ06U+phogx4YPk3doblKXjPcXm65YmDkulMq+6mKcQEJofcrxLNMg2lAAYNeHrp/YoFa5j0HAxTVyGjKkfvFI63j14WZqx/gIRS5aphnK7c+QI6hI5LAoLZkppQiITanl4fxbyldv/9YOz1ygr+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AS5PR04MB11466.eurprd04.prod.outlook.com (2603:10a6:20b:6c6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Fri, 30 Jan
 2026 15:34:18 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9564.010; Fri, 30 Jan 2026
 15:34:18 +0000
Date: Fri, 30 Jan 2026 10:34:10 -0500
From: Frank Li <Frank.li@nxp.com>
To: Sai Sree Kartheek Adivi <s-adivi@ti.com>
Cc: peter.ujfalusi@gmail.com, vkoul@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, nm@ti.com,
	ssantosh@kernel.org, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, vigneshr@ti.com,
	r-sharma3@ti.com, gehariprasath@ti.com
Subject: Re: [PATCH v4 13/19] dt-bindings: dma: ti: Add K3 PKTDMA V2
Message-ID: <aXzPck9B6cTsTTwU@lizhi-Precision-Tower-5810>
References: <20260130110159.359501-1-s-adivi@ti.com>
 <20260130110159.359501-14-s-adivi@ti.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260130110159.359501-14-s-adivi@ti.com>
X-ClientProxiedBy: PH7P220CA0046.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32b::10) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AS5PR04MB11466:EE_
X-MS-Office365-Filtering-Correlation-Id: f2d9d47d-2800-4856-8ce9-08de60150853
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|366016|1800799024|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rGfXNCDj5nJQFwfVEm3B9FdDAKmPuqv6wp2BB0bVNyuPD0TJWWViJmovPq4+?=
 =?us-ascii?Q?U5OxS/5RXvWYnJvxgRg5N+Bi7Y3rTzCMyD94McBTcdQzV+pXobqmA0b16OA/?=
 =?us-ascii?Q?CyrdijcCAyJVypY7Qh2qfHlq++vnfb6LAZqSoh5rt2xaVn/YqvKxecIxY8rZ?=
 =?us-ascii?Q?s/7FVTyAiLUjpIvVIZDYhMtypQS7va2WaBrsM+OAxW2KV6imoW1Jx/wARXgx?=
 =?us-ascii?Q?4XSIboLNGB92/fEC3MymqQFX9a/LaViM/S7q0jler9WG4Bl25Wl1ZlRJ4UdB?=
 =?us-ascii?Q?22gbCyv+wjomre3G/HNmhaNUZ/POXyrEGRO9r9TBAZRRJSm3QIzpIvJqteko?=
 =?us-ascii?Q?6M5FgytOa2zsukYmaxXGoW2ygbHVlopgZ42AIqnaEs4yBWb09Vlf2uv32UYh?=
 =?us-ascii?Q?n4moXtaVrtAWlmVLo79IhipB6SlHgg0KY3Z+5Pd9LJ7JW7YpzyTvZv3Svo9p?=
 =?us-ascii?Q?dXpXWE/QIXhxPzffIxUUT7mp2mMa671DlIgoGnKggsOQgtkUrf96fzQFV+FX?=
 =?us-ascii?Q?+6uO/SQt4W0P+w2oMN7uwWcLBaK15OLopemMfw31VZkqcZjYm/ib21qs0NMF?=
 =?us-ascii?Q?fqRPKlubHPXEQZDTvBe79g/VngxDp9n1TmJ6JjI2FVZOriFYqi1EGTb3upPE?=
 =?us-ascii?Q?G3dfW5+E/yFM3GGjZr+oPLNQIt44+K013OIYQ7bd3oZj6A7n8tympMTGwFDf?=
 =?us-ascii?Q?HpKXuhn7b3j7vpuJ9/R0/F90GNAgTZbG8JyrNNIDu0jkpdkWqAETHv2C51Sl?=
 =?us-ascii?Q?2MEkycNsBIftPV5O2F1FMsw3whLnywIYXcKamVAjmzJPM+9TSdD6de4ytHb9?=
 =?us-ascii?Q?b7WO+4YSY8x3Y22gIX5TR51hCyPgP9yqcfx47CD7RU1i4i5VzskuE4qodfMR?=
 =?us-ascii?Q?CD9uPdbqfssGWeGZscQMQYXhLtaC+WvwRKD/pZcnsC2+8v3Etm6aF9u9zSsE?=
 =?us-ascii?Q?k6dlCysYZZ4BreyhSiawi5LpnK8U4C7drq3OLcND39DPS/0Cxgm/pRgRdcj5?=
 =?us-ascii?Q?Tj3yXh8Fzc1amaEe9bH/YKErsEXmNwqC7c/IfpxDtzZsD7+tsXaVMOuSW+gP?=
 =?us-ascii?Q?Va2ahJelwRf8c8vi7uvIPE0kWqLtBoQ/O+6ms5UWR61wphcxj338QXDqykrl?=
 =?us-ascii?Q?CD8t1prrpyno2bFIweUxxpuTnBMDogHAJdc1LSdJ85yi91t12Rw1zxin1NYC?=
 =?us-ascii?Q?Ih+yq6hy835LSdDiq5CpkGCbKjEZEMEnXy8JR7xf7cdxzeo4qDS0jJaDB8Ze?=
 =?us-ascii?Q?cJ7W8TpR0wj+6oNgBTkMNdooEV5MFSe7rPEOAMT4ZOELd8BMJ4ZKMMqDGCiS?=
 =?us-ascii?Q?SVeovFKJ7N6kSBLsSjnI4aHU3B7ycAtJkxahxkrKrXW2vOGbSZrRgwpc+dGt?=
 =?us-ascii?Q?/E7o3JGG2NKK3o4kK/gTr4ufpar4g0fs0TiX/00nfSwWf2QZRz36gBzAtyvM?=
 =?us-ascii?Q?zhHH74xCM5ZaE2gcdfyoSvzmCVhHRrmbgLIDBHZhHQ4bB7m8x+nSTIy5Hqgh?=
 =?us-ascii?Q?gCksXvWw3nKfkQwoHqxcvCM5N9OEDX3PX24Q4UatoJOK5GE7A4VPBmYUn8w2?=
 =?us-ascii?Q?KgYAvpCZgM3KrEKuujUMYaRzDMZC3WXXfAxiwLst?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zmReDAaz7/h9cImthP3eHUoIewWtZtsyvzOvzdO7tDcOJ8NvuUDiGNmAVHPG?=
 =?us-ascii?Q?VzJGmNgvuyiGKCWK6NXZ77mtuZ+1m4i8AvdapJGjWGhRBNgnbjvme/swnSC8?=
 =?us-ascii?Q?tdYP+Uzd7G/kNMQshmyCZcSjYhYbvo7MTwbNm/VmoXdiaJlCd3OFM5LY+3+C?=
 =?us-ascii?Q?Qhg6P07lV0RKueBiBToJPXA3PGSxYx+N9osvN2b/w/zAMnrzCPNtPE+RQZxO?=
 =?us-ascii?Q?xvxPXukUMgbeVREy0r6XmWSupCkIXIuAfq20PpPHw6Yk7LPCCm2xSLxU+oj1?=
 =?us-ascii?Q?gLdwgfxeiKS5T4FMBu19mQAfORYlI6AfXiQC7N1fpA4Yp8QpqujJ9KjpSNSm?=
 =?us-ascii?Q?M2Z8owQOdFF7DR+mmGv5TOwyvLmP2QikO50eVVkfJ0/RJub2I3E6wjzHs+WX?=
 =?us-ascii?Q?8VK5mqraHUns7LSRjv/d0dF+S8RVlQRcf/wrKK4pq4m7EBSp5Kvel/LJprqy?=
 =?us-ascii?Q?5w2brXpFYT+b61Mvf9s8e6gwtiUaBH2o7pp33d4gEFz9lF766AJY7LE18JZQ?=
 =?us-ascii?Q?vxV1VYCMZZJ+hIJxmQb5v32yZPU7Cbo+ncp4sRKv5RGTQFLjlsqEuwObSXVL?=
 =?us-ascii?Q?7KYgP3ntIgFKbj82j8jMJbIj/lw+2RkeMAjPHLB0BW/C76owIfiV4S6Vja0F?=
 =?us-ascii?Q?QRAgQuR0x8lAl4xzfIhfIPRxTlYzWoimOyewFeuVYl9/5vgFT+4oOxbq2fHW?=
 =?us-ascii?Q?L7Wl0a8jIFLAPTym1BDDBgGX9lfUhXROpHaYnMGcvcUFnFzzUefgn9/mYXS1?=
 =?us-ascii?Q?EV41Q1UAp9NhrOphkkWhXNrKjVEHTwUC9VFIZVMuIUBdQsWQD2DYQx/wMwJe?=
 =?us-ascii?Q?7qqnpzrN5BfJ/L54M5icWXoM9wJ2LV8sE5kzgzcV7/dnqgQzvPjX00tpxmoH?=
 =?us-ascii?Q?GLmztDJfo+uPz3kdXuKQMVVsqROYjOh6hJ+xDED3AYzTkJacErzqUFCUXhJy?=
 =?us-ascii?Q?ATcOFWDwZOwhqpdAr4QJEAu/MZFAfLzYAe4XmjZiaJfMfAPlfIsMicpJXToU?=
 =?us-ascii?Q?wcRRCb0yjsjW+WusQfNmzg3yMVHdz2wEUqeTgpeG8ww7ZDvDiXmdW2UcsdTZ?=
 =?us-ascii?Q?IarlN5vASBIXcJRWCcpH4vwlqST1oZnjqQt3DQhnCMppUpOuTHAFO0Nzhfo1?=
 =?us-ascii?Q?xqBXxM5xbbmeEVDstcaTptre40ir2pdFf2Qc3dTSMsgwdYQz1xNxVQJOZPEt?=
 =?us-ascii?Q?3NdOSP3+2YIVUQRJqn4JAUIVAkUcfwr68dBmS1tvPKEmMZ+Acp5ptma5GwwW?=
 =?us-ascii?Q?yrYErH5LJJLlk9xrNe7ySWQhJtkNkUed1Qg3hi5ZlWCX1xUAMcjLzKD7NI73?=
 =?us-ascii?Q?wWIi4D981ieibtgM07Eaib1hYsnDFWJ9J0Tm8F1WBr8LfgDTOH/LMJBXjEzu?=
 =?us-ascii?Q?jaydgNJNX/qJ4OnB3cPl1SfK8RPJVpUWVtTT2mCAAAOffsE/rxR3bznd41Qy?=
 =?us-ascii?Q?a33GCt9XFGrypF8LzCEktPenAPgnX06UrYfNVrOxVqRfRjKcxzYysjfVuI6R?=
 =?us-ascii?Q?mr9J9rijgzqEkeb0pKObRcVTvfqve0MobJhgxIzMMLLwOUw6dbh74/v551Oj?=
 =?us-ascii?Q?5U9OgDUnAIpy7PCjSobpF9yGgopc3pVLUyexD3a00tdFirG38BWHx48KhKSV?=
 =?us-ascii?Q?shEJ+/vFaDBeNFFeDv8dHUvCwn/unUYl3hn/b+JWbQrVJsZCCpp3BfjhoEec?=
 =?us-ascii?Q?rSAP/r1fp0+XjKSJ6CnIIkYJP0RCd6uW7IYPgrat4hY2WpjIIQz5TvH/OfEn?=
 =?us-ascii?Q?pUbePwb7Fw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2d9d47d-2800-4856-8ce9-08de60150853
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 15:34:18.5737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Exlz/dqrLqsqGmbidevSRe+JpAiBO9RpbiyJKv20KgPDzNd9FDHTZRbu39lF0PAK2TRNYctm2baC5NCbn/ZTiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB11466
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
	TAGGED_FROM(0.00)[bounces-8619-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,ti.com,vger.kernel.org,lists.infradead.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	DBL_PROHIBIT(0.00)[0.42.185.128:email];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,devicetree.org:url,485c0000:email]
X-Rspamd-Queue-Id: 6EC2CBC0F0
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 04:31:53PM +0530, Sai Sree Kartheek Adivi wrote:
> New binding document for
> Texas Instruments K3 Packet DMA (PKTDMA) V2.
>
> PKTDMA V2 is introduced as part of AM62L.
>
> Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
> ---
>  .../bindings/dma/ti/ti,k3-pktdma-v2.yaml      | 90 +++++++++++++++++++
>  1 file changed, 90 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/ti/ti,k3-pktdma-v2.yaml
>
> diff --git a/Documentation/devicetree/bindings/dma/ti/ti,k3-pktdma-v2.yaml b/Documentation/devicetree/bindings/dma/ti/ti,k3-pktdma-v2.yaml
> new file mode 100644
> index 0000000000000..e8afa6f6738b7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/ti/ti,k3-pktdma-v2.yaml
> @@ -0,0 +1,90 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2024-2025 Texas Instruments Incorporated
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/ti/ti,k3-pktdma-v2.yaml#

filename need use one of compatible string.

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments K3 DMSS PKTDMA V2
> +
> +maintainers:
> +  - Sai Sree Kartheek Adivi <s-adivi@ti.com>
> +
> +description: |

Needn't |

> +  The PKTDMA V2 is intended to perform similar functions as the packet mode
> +  channels of K3 UDMA-P. PKTDMA V2 only includes Split channels to service
> +  PSI-L based peripherals.
> +
> +  The peripherals can be PSI-L native or legacy, non PSI-L native peripherals
> +  with PDMAs. PDMA is tasked to act as a bridge between the PSI-L fabric and the
> +  legacy peripheral.
> +
> +allOf:
> +  - $ref: /schemas/dma/dma-controller.yaml#
> +
> +properties:
> +  compatible:
> +    const: ti,am62l-dmss-pktdma
> +
> +  reg:
> +    items:
> +      - description: Packet DMA Control /Status
> +      - description: Channel Realtime
> +      - description: Ring Realtime
> +
> +  reg-names:
> +    items:
> +      - const: gcfg
> +      - const: chanrt
> +      - const: ringrt
> +
> +  "#dma-cells":
> +    const: 2
> +    description: |
> +      cell 1: Channel identification for the peripheral
> +        PSI-L thread ID of the remote (to BCDMA) end.
> +        Valid ranges for thread ID depends on the data movement direction:
> +        for source thread IDs (rx): 0 - 0x7fff
> +        for destination thread IDs (tx): 0x8000 - 0xffff
> +
> +        Please refer to the device documentation for the PSI-L thread map and
> +        also the PSI-L peripheral chapter for the correct thread ID.
> +
> +      cell 2: ASEL value for the channel
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - "#dma-cells"

No irq and clock?

> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    main {
> +        #address-cells = <2>;
> +        #size-cells = <2>;

If use 32bit address, needn't main

> +
> +        main_pktdma: dma-controller@485c0000 {

Need need label

> +            compatible = "ti,am62l-dmss-pktdma";
> +            reg = <0x00 0x485c0000 0x00 0x4000>,
> +                  <0x00 0x48900000 0x00 0x80000>,
> +                  <0x00 0x47200000 0x00 0x100000>;
> +            reg-names = "gcfg", "chanrt", "ringrt";
> +            #dma-cells = <2>;
> +        };
> +
> +        serial@2800000 {

Needn't this in example.

Frank
> +            compatible = "ti,am64-uart", "ti,am654-uart";
> +            reg = <0x00 0x02800000 0x00 0x100>;
> +            power-domains = <&scmi_pds 89>;
> +            clocks = <&scmi_clk 358>;
> +            clock-names = "fclk";
> +            dmas = <&main_pktdma 0xc400 0>,
> +                   /* tx: PSI-L thread ID, ASEL value */
> +                   <&main_pktdma 0x4400 0>;
> +                   /* rx: PSI-L thread ID, ASEL value */
> +            dma-names = "tx", "rx";
> +        };
> +    };
> --
> 2.34.1
>

