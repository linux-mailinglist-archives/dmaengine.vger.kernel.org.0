Return-Path: <dmaengine+bounces-8934-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AQ2Mi7FlGnCHgIAu9opvQ
	(envelope-from <dmaengine+bounces-8934-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 17 Feb 2026 20:44:46 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C9814FB65
	for <lists+dmaengine@lfdr.de>; Tue, 17 Feb 2026 20:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B663E3011139
	for <lists+dmaengine@lfdr.de>; Tue, 17 Feb 2026 19:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534E53783A6;
	Tue, 17 Feb 2026 19:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="chnsd4d6"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013026.outbound.protection.outlook.com [52.101.72.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BC529C35A;
	Tue, 17 Feb 2026 19:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771357483; cv=fail; b=RUqOhqQuzSLMYSt/3N3O5M3PV3/G0Wdg2v24W3lHtsfrViJGKTJ5SzYlwgH8Xixs8OfwXYZSWoDzXmRnJoXWiMirB6wy+N9NoJClaS+eS7dvUX9OetdhgjmFYNaJIMAuqey77tKiIiXaYTj8lNC3K5W1SMhXDVT+qHB2WhUE0y4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771357483; c=relaxed/simple;
	bh=NpKR/c/r5d/0fblQg5EkPFBc/JqYaCXivsytloYiinE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fcBRlPmyRstraeClmPbnJyzGeAnEZXHZU/IzR/w2POf8hrVd5Nau2084sXaXyM//JvI2y/jgxtOdokfyyArSTkiXLCrv5gjHTehdw1Fs8g30MbzrxJBvqItW6j1tdD+MMuPoMXtwd/ACqSeSs2gahamgUHA/IKMt3VdPnYPhsSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=chnsd4d6; arc=fail smtp.client-ip=52.101.72.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lsGgjtzo3Ht2yYfJc23BbvTkQLzRj2n4D2RNYUmAM/3+HTu3eg8cYCb3oiRXrgma1TlFCZOPVMPMxmOss3mw7GpqHYushEgNEMJH7ZKgSNJsmJuRqy+SKUHeaP3tQrqhoeMjQuIel23vArnMwNO5EFM6/l22sdo8vW+tZJX2fDSqbBU46Ht6PMV75dK7G/Lqh2HuykewzVHK0m39BKBogTB0dnivK1TgrfNMa9+mjFn9F+sLi+sNvMpiL5ZYXP9zJoFdrc2KJwboTnHDNN3b5Rh/1wofAZ2uTKok3n3M/ol1Ig0GCNTM0aIB4ZoSJPfkC+kpYWyOXjmJbc7ddhkNSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9pFxdgX4kk0wskaXl+kuX9lMErCFOMohAIY6RKMJc/4=;
 b=ZL1GPeDE3zq5yI1/Y9Ctzj+qpFpuu849oYUZoiRC3wa/tvbVqq/v0h3KBHEZYU4Sws5AAOpnWJeG4nhnrFAMuV51PkB3yXvHVxaxbK4cR+B/JQt6l16cc4aeMGxj7WQOvKHy0R4uuMU3tMmbPEnuNl4kwPupBZRGIT0RBotpA9wS/HLhiKuXZix7BBqotUUv3k9aNQr9Htxqf7ApRqS1HObnt6IHb28KXqGGJoAhEtD8PQ6pt83IgsoDBOGqmjfuD644B5yNxr/91YGnX8TSTiwEniBcegY/BRCg0/iYaizTU3LI5PuABhVPjbTcIYqXF13J+FOOv5/LUluL9CGUBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pFxdgX4kk0wskaXl+kuX9lMErCFOMohAIY6RKMJc/4=;
 b=chnsd4d6gLJQ2CuzN1q7+/ggoq1Jrih6hkhkgfTXSAjCMJKy54+uhZ8TbBwggGx7r6TDP8oqIKhQlgL6vUaiPrKi+rrQDYCgR6VQjEixDRrvQ4yWyEtsSzEpjQgaKPULWLdP9GMOAoqgDoT9FF9CZnKZulBQgn1EsapZMK51vKAoruOAXkdCC23tLpzyngfUYhSSYqXIHE+i+t6XhXmzzPUiSbuRmmMw1W/fdzCc4qhqmFNsRjnyxhl6SaEFTOdp/V4WFW63GSBUPUCwryTfL6wSro3irRIMHt9b7Zytnhx/4vR0kNQCaeVhhC1L5ItEBXws94Icq7W8lbsYmXdZyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by VI2PR04MB11241.eurprd04.prod.outlook.com (2603:10a6:800:29a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 17 Feb
 2026 19:44:36 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9611.013; Tue, 17 Feb 2026
 19:44:36 +0000
Date: Tue, 17 Feb 2026 14:44:28 -0500
From: Frank Li <Frank.li@nxp.com>
To: Akhil R <akhilrajeev@nvidia.com>
Cc: dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	vkoul@kernel.org, Frank.Li@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, thierry.reding@gmail.com,
	jonathanh@nvidia.com, p.zabel@pengutronix.de
Subject: Re: [PATCH 5/8] dmaengine: tegra: Support address width > 40 bits
Message-ID: <aZTFHI8_iL4vCkMF@lizhi-Precision-Tower-5810>
References: <20260217173457.18628-1-akhilrajeev@nvidia.com>
 <20260217173457.18628-6-akhilrajeev@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217173457.18628-6-akhilrajeev@nvidia.com>
X-ClientProxiedBy: PH7PR10CA0013.namprd10.prod.outlook.com
 (2603:10b6:510:23d::9) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|VI2PR04MB11241:EE_
X-MS-Office365-Filtering-Correlation-Id: 669de863-bb6c-41a3-a58c-08de6e5cfb17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|7416014|19092799006|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uPcYg6D/D+w2hKjya4xn1yKhioL6bd4A+ZHXLF+8PRzOLPsNL76VijloqvYx?=
 =?us-ascii?Q?rNTWa3xS5v/Y4R86exXTGwPWlHcKrjbz53vTE3ZnPB4oNBJ5XtEXpCi0A0Yj?=
 =?us-ascii?Q?g7gELqIoF+USEUVnyPDoF9TRajizL3BsqEIT1bbdhPPO+NKtjH6yIHacWXvF?=
 =?us-ascii?Q?M5dd5BIMKzTgHgE00/d5eOx1kkOlZxyzxKOuDyO4kbYGDY0Q7IJ0obn5+FjR?=
 =?us-ascii?Q?bj3N9TqTkqwhsP5GVeYSIPFns/WEUHAIR5Ka8GBGF3NyqcWUw/pWv7uYXIvo?=
 =?us-ascii?Q?I8pnMqNIcWMdPfE8AxJl+93V2A4Bwsa4k5/xQ/8/d9eD/CWor8SfjOVlxe2d?=
 =?us-ascii?Q?PtggfIzqAe4rF0rrWxEKsWnAhIdhMIpNBMVNdOiJE/87QqQx7soN3MxpCvsS?=
 =?us-ascii?Q?Qzl7KAQOner0PGKdzubn/sCddLpcaaPZCVtdquLqupDZKViBBUpG6TdSVytK?=
 =?us-ascii?Q?6zheQmkVxyc1+IwyVE0oJyohNvWEnEYyv74lSpT9EbE1GzB3xxqEG9XwVxn5?=
 =?us-ascii?Q?T8yhaUr+GXVPM/Oew88ObQADBINSrV/finhnX2KqeAa8K5LJ66AsnJ9LMb+f?=
 =?us-ascii?Q?lWsnkI8EI+5aMfH6RsdM3UyiCgh+BQIeFacdq9Vil+N4F2GO6GjJIneGXd9L?=
 =?us-ascii?Q?2tGk5qYpVWIrbE6ClCTx/VlaeSKfa88GCxufesKsCvZ2yaOFglTL0h7AIp8p?=
 =?us-ascii?Q?4wQmETND6EMth7OYXozEWg8TgYUDbSSkcl+xOJRocniayenwuJ3ck8MA29Bb?=
 =?us-ascii?Q?9312/9P17hFBYles95kZQy4vwjGUVG0YAlTLBOWsqWuoWy4MkGjh/xgpcHoE?=
 =?us-ascii?Q?gTWQigg75A79+PqnLqfOAr1BZfY5z6uOkhFbZ4Z8IkDz44lkc/9oEmXdpkEN?=
 =?us-ascii?Q?G5pXJCjhofD5cTkT30WnrEVWLxoxS4xgTUgz54l6xMXqV8XC7NdWZXYBaVeF?=
 =?us-ascii?Q?sIDab//Ase+5saEb3rmENAm1ZBRSWfx9LAAT3iUdtNpyR5cVDoTxO5khmFAg?=
 =?us-ascii?Q?q/T2aBHIn2DQLslaCdNPVUJ6E7js9ohPg+4GLcpmOk7KG52UHQNHTOQvT5G8?=
 =?us-ascii?Q?CqjMvMFfjAaMQJemCQOWpO+qcGnlN7uE9sU3MZkr4HdwxtRM9AkVx+Zl6OBC?=
 =?us-ascii?Q?amrRrjuGU/gleGEtMv273YKEOTndyWx5Ok0MUnkimIDtjHPjWolc4pug2u+5?=
 =?us-ascii?Q?q7dJ+/t8eiAMBkF4Zs0zxlp/ujTaByqstWkf40SLo0HNVnA1o+hGqsKjkstx?=
 =?us-ascii?Q?+OR7tRYLDM27jl11fsVv0eF7W4/R+YQ7ctGtoAcAup5Dm4vA8HxpD5JeEeCb?=
 =?us-ascii?Q?RveTIDnUsi1hZpRnaTmlLwFAbuJ6fO/Y3zig2W4WxmSuh3oWjUs/vEDy2Zc2?=
 =?us-ascii?Q?QhInig8fhKnUt4jZtF5NobvaXLM2svm5ZERIILegTBoyq/dNCSBjdAeuIbyb?=
 =?us-ascii?Q?0+CQ4ixvLIBIirG9XVQPXkbueqI/ggkPWYNAc9TN6pSVDMBXPVysZzTlxuxg?=
 =?us-ascii?Q?j8EoRBaRNhsQGPad5PaSe9gVcY9i3kGw2bhs7HT3De/uA2q/v5clEEP+cEqe?=
 =?us-ascii?Q?8R4F/gYH/Byc07jJfOQiQS56HTWRaTkx0hcHggvmysxCtfULqSZV7w/l0HW6?=
 =?us-ascii?Q?2HjmgmwAiVWIeFNz1H2NZ1w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(7416014)(19092799006)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1YaOD7qPeHyxcqMmjmYpSQ7ZEmF+8TJ9+r8f/VBqily2+eZ13lNnmEPbVKcA?=
 =?us-ascii?Q?qGiyh8iRjSCSkdv8eqM2cuDdhLeGFOgxamp9nWyZ49Q1Bk9XYr5ngj7slgyE?=
 =?us-ascii?Q?k4Y44sExLiiEwF+CtGxk6CeA/YGfcKmIrjQ4fOSa0Ah9oqdO+J7LYxv8friH?=
 =?us-ascii?Q?TlfmLSczQT/W9PBYeI7z2I6OtUm098z1f44u25SQWj7MR9G0xUI3YP+U+yxX?=
 =?us-ascii?Q?OhaRWka8MLsZnxaexmnp1jICUCyClrBZJEzSKljg0CeDcE+94rvITsKP9EX/?=
 =?us-ascii?Q?/6TDdhfX3spFV54gzTmdFrZbGS+0DKxJetX9rpMeB4g0yfyxdjmUPTTESAri?=
 =?us-ascii?Q?wCzUVYQZF7GMgd3ZTp/eBlPndwxae3C6LC6CJhz22Lg5dma6uKRn85/9Oz3b?=
 =?us-ascii?Q?lHPXkFEX5dwfAQl9gNiJu771HZ68ExvzNYs06In0QG4VPgQx9L3fVHWNKq3P?=
 =?us-ascii?Q?hu8IeCCq9m/WSjBzX/6TKRvtjuyar4xURbuJbkkqppVK9CJ0h8FKTCxgUx7+?=
 =?us-ascii?Q?2nCYO6aD2IFi7c+wsNEn/XbgSly8iIz/EEtRSXixbx2NESaSlRo0k58tq2TR?=
 =?us-ascii?Q?0KJviO2v9BvL8uR8r8nyCUqz4UxX21JOEjnO3QvIMqziWBY8/RSooLD1A4dY?=
 =?us-ascii?Q?X37FDIF+0JtLU0wGHxDs9RoSLpruKT/J/PauTZhDrPi9+yBIM6Dka+U6fvra?=
 =?us-ascii?Q?8hO30GjTHyPtd1ZCaY6lzPG01ba3G5ZC54hxRAKX9gNfSQHCxb7P5L9tVY1k?=
 =?us-ascii?Q?zYxz2pl1R8+pQUyFTXd2t+B8aNWzM89Zse+wish+wr62oC++EGyn9yTrMK0/?=
 =?us-ascii?Q?/pmJ1igb6bov0ZZ1rBWElyfAn5HYtkicUoV4YNeHGkCZ70eMP1tD5ul/9rtS?=
 =?us-ascii?Q?X6HWLsNW6ons91yIJUKc1CzrdrCK3x3j3NC4BDnNLONS0UP043wImja4boup?=
 =?us-ascii?Q?WfR6ZqzSRkoqcbaq4ygZ78Ll3VP25PsXVkccCN51i+lVrPhpXFHNGY0dg9Y8?=
 =?us-ascii?Q?GD9xsp0jYSlyaMEuMgSjhX+60mzuODf5g8TGDa4Z5w8AMnnegYvnxFhrr3Zm?=
 =?us-ascii?Q?ucmKUAAckS8PGoSoqbCnE2CuUxKAaazmaGDSct/aci5wUt9KY2KDWlgBkDyD?=
 =?us-ascii?Q?chVjpaTj/92uYlqm3FJ3ggaDBKsJu5JamOOoAUUSJhX9xHFylB1u5f6wtUHZ?=
 =?us-ascii?Q?9XC50iwemofUNz2aa398n8m0NT0xYfdqNIKwzKrxSSBhuSnzjRJvTERyN8za?=
 =?us-ascii?Q?JVc6m7q5Tft0GyIGYsFx/JR9IAhdxwcWUvzV+zJXDCPcEoY4SQefJH+i8iZi?=
 =?us-ascii?Q?ky2576uJ1T5WvKRzNXSlCIGnawQawHhroxkg7/JWJigeoVYMIGe3fPNFcHoB?=
 =?us-ascii?Q?/w6gnU8gyyj5xjDFogdLmWUONN1YORvI90YF/r1MjS99yo5csn7UKF1VKN5/?=
 =?us-ascii?Q?RXl6X9Uf3XfGwXTUy1nmDBnGXcP8piyFsq53pV/KiKQC2ZQqoia1lLHOKNCE?=
 =?us-ascii?Q?2VnyuEfqBdNcJLkU9gkL/ojO+AoklZ2AfIxxebFDcHrwnx0kHfw15sSNwrbM?=
 =?us-ascii?Q?uTWpxVliRZx4VqurcZFUHe62jJFP/56Aj+Lu7PVqOCilkZVCrOlxTkEaTFZp?=
 =?us-ascii?Q?sKSfQiNAG0/dZGt6mOZyENvEqJ621H9SbLaIjq8cLYLVnv1i0LRuviOin5WF?=
 =?us-ascii?Q?DkRi1VH0zwlgJLZKsJXcE6SPZIujlVG1q9LGj2ieA42LjAoJgMGy6SkVtzrC?=
 =?us-ascii?Q?/YCkVTuupA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 669de863-bb6c-41a3-a58c-08de6e5cfb17
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 19:44:36.3243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yR2KDCshFCP2CLsJfAlOpZUARpVHG45adt6es/JeP9IOVmQN/Ux/f3/ASISknkEcjOHA0IJRxF5If7h/AzfqaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11241
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8934-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,nvidia.com,pengutronix.de];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nxp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 34C9814FB65
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 11:04:54PM +0530, Akhil R wrote:
> Tegra264 supports address width of 41 bits and has a separate register
> to accommodate the high address. Add a device data property to specify
> the number of address bits supported on a device and use that to
> program the required registers.
>
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> ---
>  drivers/dma/tegra186-gpc-dma.c | 129 +++++++++++++++++++++------------
>  1 file changed, 82 insertions(+), 47 deletions(-)
>
> diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
> index 72701b543ceb..ce3b1dd52bb3 100644
> --- a/drivers/dma/tegra186-gpc-dma.c
> +++ b/drivers/dma/tegra186-gpc-dma.c
> @@ -151,6 +151,7 @@ struct tegra_dma_channel;
>   */
>  struct tegra_dma_chip_data {
>  	bool hw_support_pause;
> +	unsigned int addr_bits;
>  	unsigned int nr_channels;
>  	unsigned int channel_reg_size;
>  	unsigned int max_dma_count;
> @@ -166,6 +167,8 @@ struct tegra_dma_channel_regs {
>  	u32 src;
>  	u32 dst;
>  	u32 high_addr;
> +	u32 src_high;
> +	u32 dst_high;
>  	u32 mc_seq;
>  	u32 mmio_seq;
>  	u32 wcount;
> @@ -189,7 +192,8 @@ struct tegra_dma_sg_req {
>  	u32 csr;
>  	u32 src;
>  	u32 dst;
> -	u32 high_addr;
> +	u32 src_high;
> +	u32 dst_high;
>  	u32 mc_seq;
>  	u32 mmio_seq;
>  	u32 wcount;
> @@ -273,6 +277,41 @@ static inline struct device *tdc2dev(struct tegra_dma_channel *tdc)
>  	return tdc->vc.chan.device->dev;
>  }
>
> +static void tegra_dma_program_addr(struct tegra_dma_channel *tdc,
> +				   struct tegra_dma_sg_req *sg_req)
> +{
> +	tdc_write(tdc, tdc->regs->src, sg_req->src);
> +	tdc_write(tdc, tdc->regs->dst, sg_req->dst);
> +
> +	if (tdc->tdma->chip_data->addr_bits > 40) {
> +		tdc_write(tdc, tdc->regs->src_high,
> +			  sg_req->src_high);
> +		tdc_write(tdc, tdc->regs->dst_high,
> +			  sg_req->dst_high);
> +	} else {
> +		tdc_write(tdc, tdc->regs->high_addr,
> +			  sg_req->src_high | sg_req->dst_high);
> +	}
> +}
> +
> +static void tegra_dma_configure_addr(struct tegra_dma_channel *tdc,
> +				     struct tegra_dma_sg_req *sg_req,
> +				phys_addr_t src, phys_addr_t dst)
> +{
> +	sg_req->src = lower_32_bits(src);
> +	sg_req->dst = lower_32_bits(dst);

I suggest save 64bit address to sq_req.  In tegra_dma_program_addr() to
handle difference between 40bit and 41bit.

So only need handle difference at one place.

Frank
> +
> +	if (tdc->tdma->chip_data->addr_bits > 40) {
> +		sg_req->src_high = upper_32_bits(src);
> +		sg_req->dst_high = upper_32_bits(dst);
> +	} else {
> +		sg_req->src_high = FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_SRC_PTR,
> +					      upper_32_bits(src));
> +		sg_req->dst_high = FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_DST_PTR,
> +					      upper_32_bits(dst));
> +	}
> +}
> +
>  static void tegra_dma_dump_chan_regs(struct tegra_dma_channel *tdc)
>  {
>  	dev_dbg(tdc2dev(tdc), "DMA Channel %d name %s register dump:\n",
> @@ -282,11 +321,22 @@ static void tegra_dma_dump_chan_regs(struct tegra_dma_channel *tdc)
>  		tdc_read(tdc, tdc->regs->status),
>  		tdc_read(tdc, tdc->regs->csre)
>  	);
> -	dev_dbg(tdc2dev(tdc), "SRC %x DST %x HI ADDR %x\n",
> -		tdc_read(tdc, tdc->regs->src),
> -		tdc_read(tdc, tdc->regs->dst),
> -		tdc_read(tdc, tdc->regs->high_addr)
> -	);
> +
> +	if (tdc->tdma->chip_data->addr_bits > 40) {
> +		dev_dbg(tdc2dev(tdc), "SRC %x SRC HI %x DST %x DST HI %x\n",
> +			tdc_read(tdc, tdc->regs->src),
> +			tdc_read(tdc, tdc->regs->src_high),
> +			tdc_read(tdc, tdc->regs->dst),
> +			tdc_read(tdc, tdc->regs->dst_high)
> +		);
> +	} else {
> +		dev_dbg(tdc2dev(tdc), "SRC %x DST %x HI ADDR %x\n",
> +			tdc_read(tdc, tdc->regs->src),
> +			tdc_read(tdc, tdc->regs->dst),
> +			tdc_read(tdc, tdc->regs->high_addr)
> +		);
> +	}
> +
>  	dev_dbg(tdc2dev(tdc), "MCSEQ %x IOSEQ %x WCNT %x XFER %x WSTA %x\n",
>  		tdc_read(tdc, tdc->regs->mc_seq),
>  		tdc_read(tdc, tdc->regs->mmio_seq),
> @@ -490,9 +540,7 @@ static void tegra_dma_configure_next_sg(struct tegra_dma_channel *tdc)
>  	sg_req = &dma_desc->sg_req[dma_desc->sg_idx];
>
>  	tdc_write(tdc, tdc->regs->wcount, sg_req->wcount);
> -	tdc_write(tdc, tdc->regs->src, sg_req->src);
> -	tdc_write(tdc, tdc->regs->dst, sg_req->dst);
> -	tdc_write(tdc, tdc->regs->high_addr, sg_req->high_addr);
> +	tegra_dma_program_addr(tdc, sg_req);
>
>  	/* Start DMA */
>  	tdc_write(tdc, tdc->regs->csr,
> @@ -520,11 +568,9 @@ static void tegra_dma_start(struct tegra_dma_channel *tdc)
>
>  	sg_req = &dma_desc->sg_req[dma_desc->sg_idx];
>
> +	tegra_dma_program_addr(tdc, sg_req);
>  	tdc_write(tdc, tdc->regs->wcount, sg_req->wcount);
>  	tdc_write(tdc, tdc->regs->csr, 0);
> -	tdc_write(tdc, tdc->regs->src, sg_req->src);
> -	tdc_write(tdc, tdc->regs->dst, sg_req->dst);
> -	tdc_write(tdc, tdc->regs->high_addr, sg_req->high_addr);
>  	tdc_write(tdc, tdc->regs->fixed_pattern, sg_req->fixed_pattern);
>  	tdc_write(tdc, tdc->regs->mmio_seq, sg_req->mmio_seq);
>  	tdc_write(tdc, tdc->regs->mc_seq, sg_req->mc_seq);
> @@ -829,7 +875,7 @@ static unsigned int get_burst_size(struct tegra_dma_channel *tdc,
>
>  static int get_transfer_param(struct tegra_dma_channel *tdc,
>  			      enum dma_transfer_direction direction,
> -			      u32 *apb_addr,
> +			      dma_addr_t *apb_addr,
>  			      u32 *mmio_seq,
>  			      u32 *csr,
>  			      unsigned int *burst_size,
> @@ -908,10 +954,7 @@ tegra_dma_prep_dma_memset(struct dma_chan *dc, dma_addr_t dest, int value,
>  	dma_desc->sg_count = 1;
>  	sg_req = dma_desc->sg_req;
>
> -	sg_req[0].src = 0;
> -	sg_req[0].dst = dest;
> -	sg_req[0].high_addr =
> -			FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_DST_PTR, (dest >> 32));
> +	tegra_dma_configure_addr(tdc, &sg_req[0], 0, dest);
>  	sg_req[0].fixed_pattern = value;
>  	/* Word count reg takes value as (N +1) words */
>  	sg_req[0].wcount = ((len - 4) >> 2);
> @@ -977,12 +1020,7 @@ tegra_dma_prep_dma_memcpy(struct dma_chan *dc, dma_addr_t dest,
>  	dma_desc->sg_count = 1;
>  	sg_req = dma_desc->sg_req;
>
> -	sg_req[0].src = src;
> -	sg_req[0].dst = dest;
> -	sg_req[0].high_addr =
> -		FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_SRC_PTR, (src >> 32));
> -	sg_req[0].high_addr |=
> -		FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_DST_PTR, (dest >> 32));
> +	tegra_dma_configure_addr(tdc, &sg_req[0], src, dest);
>  	/* Word count reg takes value as (N +1) words */
>  	sg_req[0].wcount = ((len - 4) >> 2);
>  	sg_req[0].csr = csr;
> @@ -1002,7 +1040,8 @@ tegra_dma_prep_slave_sg(struct dma_chan *dc, struct scatterlist *sgl,
>  	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
>  	unsigned int max_dma_count = tdc->tdma->chip_data->max_dma_count;
>  	enum dma_slave_buswidth slave_bw = DMA_SLAVE_BUSWIDTH_UNDEFINED;
> -	u32 csr, mc_seq, apb_ptr = 0, mmio_seq = 0;
> +	u32 csr, mc_seq, mmio_seq = 0;
> +	dma_addr_t apb_ptr = 0;
>  	struct tegra_dma_sg_req *sg_req;
>  	struct tegra_dma_desc *dma_desc;
>  	struct scatterlist *sg;
> @@ -1087,17 +1126,10 @@ tegra_dma_prep_slave_sg(struct dma_chan *dc, struct scatterlist *sgl,
>  		mmio_seq |= get_burst_size(tdc, burst_size, slave_bw, len);
>  		dma_desc->bytes_req += len;
>
> -		if (direction == DMA_MEM_TO_DEV) {
> -			sg_req[i].src = mem;
> -			sg_req[i].dst = apb_ptr;
> -			sg_req[i].high_addr =
> -				FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_SRC_PTR, (mem >> 32));
> -		} else if (direction == DMA_DEV_TO_MEM) {
> -			sg_req[i].src = apb_ptr;
> -			sg_req[i].dst = mem;
> -			sg_req[i].high_addr =
> -				FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_DST_PTR, (mem >> 32));
> -		}
> +		if (direction == DMA_MEM_TO_DEV)
> +			tegra_dma_configure_addr(tdc, &sg_req[i], mem, apb_ptr);
> +		else if (direction == DMA_DEV_TO_MEM)
> +			tegra_dma_configure_addr(tdc, &sg_req[i], apb_ptr, mem);
>
>  		/*
>  		 * Word count register takes input in words. Writing a value
> @@ -1120,7 +1152,8 @@ tegra_dma_prep_dma_cyclic(struct dma_chan *dc, dma_addr_t buf_addr, size_t buf_l
>  			  unsigned long flags)
>  {
>  	enum dma_slave_buswidth slave_bw = DMA_SLAVE_BUSWIDTH_UNDEFINED;
> -	u32 csr, mc_seq, apb_ptr = 0, mmio_seq = 0, burst_size;
> +	u32 csr, mc_seq, mmio_seq = 0, burst_size;
> +	dma_addr_t apb_ptr = 0;
>  	unsigned int max_dma_count, len, period_count, i;
>  	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
>  	struct tegra_dma_desc *dma_desc;
> @@ -1209,17 +1242,10 @@ tegra_dma_prep_dma_cyclic(struct dma_chan *dc, dma_addr_t buf_addr, size_t buf_l
>  	/* Split transfer equal to period size */
>  	for (i = 0; i < period_count; i++) {
>  		mmio_seq |= get_burst_size(tdc, burst_size, slave_bw, len);
> -		if (direction == DMA_MEM_TO_DEV) {
> -			sg_req[i].src = mem;
> -			sg_req[i].dst = apb_ptr;
> -			sg_req[i].high_addr =
> -				FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_SRC_PTR, (mem >> 32));
> -		} else if (direction == DMA_DEV_TO_MEM) {
> -			sg_req[i].src = apb_ptr;
> -			sg_req[i].dst = mem;
> -			sg_req[i].high_addr =
> -				FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_DST_PTR, (mem >> 32));
> -		}
> +		if (direction == DMA_MEM_TO_DEV)
> +			tegra_dma_configure_addr(tdc, &sg_req[i], mem, apb_ptr);
> +		else if (direction == DMA_DEV_TO_MEM)
> +			tegra_dma_configure_addr(tdc, &sg_req[i], apb_ptr, mem);
>  		/*
>  		 * Word count register takes input in words. Writing a value
>  		 * of N into word count register means a req of (N+1) words.
> @@ -1317,6 +1343,7 @@ static const struct tegra_dma_channel_regs tegra186_reg_offsets = {
>
>  static const struct tegra_dma_chip_data tegra186_dma_chip_data = {
>  	.nr_channels = 32,
> +	.addr_bits = 40,
>  	.channel_reg_size = SZ_64K,
>  	.max_dma_count = SZ_1G,
>  	.hw_support_pause = false,
> @@ -1326,6 +1353,7 @@ static const struct tegra_dma_chip_data tegra186_dma_chip_data = {
>
>  static const struct tegra_dma_chip_data tegra194_dma_chip_data = {
>  	.nr_channels = 32,
> +	.addr_bits = 40,
>  	.channel_reg_size = SZ_64K,
>  	.max_dma_count = SZ_1G,
>  	.hw_support_pause = true,
> @@ -1335,6 +1363,7 @@ static const struct tegra_dma_chip_data tegra194_dma_chip_data = {
>
>  static const struct tegra_dma_chip_data tegra234_dma_chip_data = {
>  	.nr_channels = 32,
> +	.addr_bits = 41,
>  	.channel_reg_size = SZ_64K,
>  	.max_dma_count = SZ_1G,
>  	.hw_support_pause = true,
> @@ -1446,6 +1475,12 @@ static int tegra_dma_probe(struct platform_device *pdev)
>  		tdc->stream_id = stream_id;
>  	}
>
> +	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(cdata->addr_bits));
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to set DMA mask: %d\n", ret);
> +		return ret;
> +	}
> +
>  	dma_cap_set(DMA_SLAVE, tdma->dma_dev.cap_mask);
>  	dma_cap_set(DMA_PRIVATE, tdma->dma_dev.cap_mask);
>  	dma_cap_set(DMA_MEMCPY, tdma->dma_dev.cap_mask);
> --
> 2.50.1
>

