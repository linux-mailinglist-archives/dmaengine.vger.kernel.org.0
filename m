Return-Path: <dmaengine+bounces-6471-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B159B53FF9
	for <lists+dmaengine@lfdr.de>; Fri, 12 Sep 2025 03:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01C85565CD4
	for <lists+dmaengine@lfdr.de>; Fri, 12 Sep 2025 01:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD85E2E401;
	Fri, 12 Sep 2025 01:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="JTKYlRWz"
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013007.outbound.protection.outlook.com [40.107.159.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2C12745E;
	Fri, 12 Sep 2025 01:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757641717; cv=fail; b=JOPzb79kKZ4llVz3zU3c0rSDxcRmTtdhO3TEzTygk9DjA6c8zxvaVgjZVedvsmnIYwn0s1VLqlIfbPJbsek80EPciKs2Olrlv+FY7gcpGDzKheZivmaOniw+omBdpt4PgkXAeCY8pllRvGMZX+ghZYxhWNaq6W5k4r8kGKjJ7KY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757641717; c=relaxed/simple;
	bh=XjPRm88NUvbCdeeA1LalLUxPimJK8P61PAg8EpSiq3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HCdwrIPFy7/0qmqMR83h15XJLdmbl1aNk1Qp4zw62epgUDu4TQelc8cNIJKQMo8EI/aebDsOLeMdMEjH/ed9eJQWc150vdN58oHnBndOAAgBnmmSTcZllbvLE8rU3Rpm0JvSNGjxa71u0ThrGAMp4HXA9tvFQz1zPilGt75Yofg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=JTKYlRWz; arc=fail smtp.client-ip=40.107.159.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rejVcVRH/mOAqze6UDj7rYyJxDTTKVxwaqIHZrSTVcZtXH1sW37CSLfzoRhtT4jK+f0+raGqd4Wcr1y9qHTOcNbRlISEGC6uF22jkdEJO3/dOPP1OnG84TQFrINzDdwiSIc5y3JlBfcSJfc5gs+TiM5GgnjYNzOBbqx0sR0RPX+xpzMLzlvR5YGzgaSxSpN/auRRPqxdsfGhXz1uptHSmPpwk955O8pelGGxzV1Jo6w9zT1qLroIGm2jWzt+soSmAVcJqwPGmFANS6401Xfof9UwLnA/O4jeOErInS2VIF6jQ62oI2/kcLAW/c7JKNhmuD/DxnnuYa3Kk2NDGrF87Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i//KuktzNjtOz/+uFo4HgnGqpJuhBc9OOeMtczlkz7o=;
 b=qHJTFVWlKFjAwWo/iwA8X/2rivDicHj3twZkR9WtwLzuXXGFQkD6tghr2fu97r1pUeqPMU0W6jb9J0hy0w30jU7CrYiTrLHJACiz/zxIfqBBmMBsVDhTZ+aNY06fGxrdPAntK347iroAm9l9jCN2P0B4d07dKWLnbANTVWN+hUeTYPOFpPyJDEdnC+ZSbBdwwByNgk1CzTiH/UsoIvJfI+W0dHIzVbSJKVIJUg8UL0ApS5NVsiArOiskk8VjZ7b8i9xQduCB9i8gTNK1V6z0SWhiETwhL9w40S8pd+jateRD4lLG+sJlanCw9DwIJL5IauPPMR0E51ADKV0sHwF9dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i//KuktzNjtOz/+uFo4HgnGqpJuhBc9OOeMtczlkz7o=;
 b=JTKYlRWzyTfwZ0XjCi9NqBC2rRA0bggHBowZKxgkiQdYOHDNZNBX6zSgfJHHgpfQBHUqM/DwXeKVcP566dQ1Za8IaCv302Nkmkr97W+QSR30HdJWB9FAQzYAzafcjTQ3zlgqX2GxK85gOJphk7rhWwCSht+f92Y0h29k/kAdRzCZIUufPvaPQbRlRQBpdl34fPfY3EkyQUIGvYW++NKQ77pmPTMUyECL+NOEwDz5i7lpDepu4L2L9FKnNRVGBFTR/hfGCitbqvkr3DitiZwg6qEbYwK4nRLBLCQ6gwTBVoEwiBu6b4WTa3HDxBwX3RLyeX1t7Vvjb/ZciwOPCByUBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA1PR04MB11333.eurprd04.prod.outlook.com (2603:10a6:102:4f3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.18; Fri, 12 Sep
 2025 01:48:27 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9115.010; Fri, 12 Sep 2025
 01:48:27 +0000
Date: Fri, 12 Sep 2025 10:59:50 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Jiada Wang <jiada_wang@mentor.com>, dmaengine@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/10] dmaengine: imx-sdma: fix missing
 of_dma_controller_free()
Message-ID: <20250912025950.GA5808@nxa18884-linux.ap.freescale.net>
References: <20250911-v6-16-topic-sdma-v2-0-d315f56343b5@pengutronix.de>
 <20250911-v6-16-topic-sdma-v2-1-d315f56343b5@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911-v6-16-topic-sdma-v2-1-d315f56343b5@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR01CA0180.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::36) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA1PR04MB11333:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a25a31b-bf9e-4c43-bfdf-08ddf19e77cf
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|52116014|366016|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bkmChak89DK3gaS7dsTnH576yrtffebUxTV8yt7cD6yAu6MCAKlxacRiHU9g?=
 =?us-ascii?Q?PxATnNvj/QwBdxfFUM7NPpdmTx75OjmMj3TmF7MwT/OFn7wVUUer4f0fSIf0?=
 =?us-ascii?Q?2UK+MWDjJdh+c/gimlUFlqdG3wSTHrxJ8SlehKYwIyqD5upGnazX/B5d7S32?=
 =?us-ascii?Q?xROd6nX9NpIJGwmU3g6TwhuaFnbXF0qIbPXoWnNmzoE97SqwpcXdETgIpP/b?=
 =?us-ascii?Q?dTh1uOiF9/L8I3/7r+i/QNzma3XzdWk0AG5C+NAnJ9q4V4fDLxRP/o4OE3WW?=
 =?us-ascii?Q?7dKZvKkXNOjWp6udV816rvhrXbFpr42R+Ite27TShAfyH5YvBU/T+1s87VZx?=
 =?us-ascii?Q?wk7+/iKkbLPQg8YNfz1pj9/jXDiY9A9CeqXrZd1dj8gjS9sHU+a8Zq6prRpC?=
 =?us-ascii?Q?7arZSwOZcRhyuGsT7V3ItVoT6T8I7vx2saSsPp3KNN5Gk2WtnBx1PQMVcXK2?=
 =?us-ascii?Q?MfQQlGG5iX3xsJulu2ez0HyCeupfgrEMTMZhfdcYbFxj5ElSfEcvpB1U8ioe?=
 =?us-ascii?Q?G1ioFmLIDlgf5SOAK7ziX4Z+/nsBISySmNsaM7Fvg4Mf+y85eYmMc4Ox94VL?=
 =?us-ascii?Q?1TbkCDCd0T0vlzPH3YdrsiErsnGVr4xLj+2+d2fQuWE4nsmgak6nfkwQqAaN?=
 =?us-ascii?Q?2E4havmIZCU5RdhShtNgiyU/A1G408JK8z3Bd7+BC5gv8E8rYWCbzCEY9rtA?=
 =?us-ascii?Q?6tmWbt/0S6TpWbonYqRtZuoi641gyJEcFu5Nq0KLShkF9RrYROLHh1wqk5Lu?=
 =?us-ascii?Q?muMHOSutvN6+5N5f/iS9vntoAO++8mvaPMbHdVSEv1nLkT4W3d4qv4Pd41SS?=
 =?us-ascii?Q?sH8vfLPisST4d3bExzio3p440Y0CG6Y1Z5Xgk24QKwpDh9nxDgO+vTRzt8rV?=
 =?us-ascii?Q?NjXitEwj3Lwq2iY0mo6EzKKh6CjsU9YHS4gHeTAObNJlRwqD4iFyCOH2aD13?=
 =?us-ascii?Q?/F/E9FuFiThKSiPX9jKPiRyl/lb9KxljetI2EM5vOy2TLgAVxSROoZJkq8Hk?=
 =?us-ascii?Q?povm/JVW7JajGN/pP0V4d6Kq7+zezLB+l356xoCqZHi7z3R7axPsIT2TFi0b?=
 =?us-ascii?Q?7TvdZnysYB9TnY0uSXYaZAemID594lq2MPbo8kIlbSMDpnGScUBBV/Qroy9r?=
 =?us-ascii?Q?8XAZIUpiWdPeFw0K7KGSqwU+WPwS1tHRgjzkH4PFmYKIqVKfwkU/DRdy07ot?=
 =?us-ascii?Q?jQzM457lYiI/9PUolmBf+dVl0HdQ5PTOtuziwaBlw1/yQPV+ImfUi/LZN+IC?=
 =?us-ascii?Q?fVaWTGXxsczicGv62H4qX+UOH+4KoVq8Hu6uZ5TrFHCgxZUByZ/P4UpXQVHi?=
 =?us-ascii?Q?sqZO29l0IjBmIGzcWDkvpbuBN9qxh4INz23Q+RG++Wf+TrfnY0Gf6CiRRKUf?=
 =?us-ascii?Q?tOnyJRq2tkrwJuIG2sdY+9rgwE0B0gtnQTNID/GKyfG0KhQU5VC5W065fxG7?=
 =?us-ascii?Q?+j4k/EUNFtn+Le/938A8B4uPBVFZJFur0itsn2CaVVSGievV/aOFHQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VpgPZhjEnCPqDhB8cT2VI6O93Ag//KURxxVi3jgsCxLfOxq1kUiYdTff4kk1?=
 =?us-ascii?Q?6ks9wiPukzrvebWV0mNi4bmXG8DXMY3jKXkUiE0UUWaunh+iWgYeXdTv+ZwA?=
 =?us-ascii?Q?1ucpr4Wvs7WR2OYPL+aF+y7T5G0ZgQOYg297PtkG89ChqKpmhZ+H13VG+CNv?=
 =?us-ascii?Q?v83IGgVgTkyh+cSzBHMokrhJ9tLwQsm0ddPXm4rDwbpjXJ+KkaJrRzIud+6n?=
 =?us-ascii?Q?5f4OAuRNqUkQplRLJQAmQPNxTZIj6qBjdKXFdOIFsY7kiaqKHfQf3Gkgq4Hf?=
 =?us-ascii?Q?QafjhD41bGCJoCeGD42DKFhy1NB3Zj0MGTg4qw0lC7X7pCZ85m8rVC4Aj13t?=
 =?us-ascii?Q?nByAtaCczpI3wKVErKOX8c9zMtiovPIItqNkSngQ+vY1YnBDUgOi3nhMm79N?=
 =?us-ascii?Q?bwT5N9YAkag6RNCzXTQxfD8tUT3XIWwLChIR8IRmsWacC1/0AVV81b6Fc4km?=
 =?us-ascii?Q?enerZmcLwFUAkOtSleTnSKsQ7m78HF0vo9yi2ik6FcoMO5skKdmp9Z91kVIy?=
 =?us-ascii?Q?o0krF0bi2OvG2i/RrVHAdOtGbnlWc0kNhyExqubASDfPK4sUnbxGpDCCJgut?=
 =?us-ascii?Q?qIqrA0BkgZKqHbutaVN2EN0TloWaNTFj3PJ6LTPn5ZCs9sVre2d59YjrPsOM?=
 =?us-ascii?Q?oyoiMabwwj1BbXv/jGQpxgnht4FmGmo7RGfhiwlUhV7OEZ/MksapN722amVi?=
 =?us-ascii?Q?CTmJQee2n/wgXP/+5CVhO62ruS+iRWnxjwvN9bsKuvaxf5pwTZlQiGq0Iewg?=
 =?us-ascii?Q?MIpD92Mz9xvfj7fE0IxY9m4ke7c2q375pBWf9GjhPTQWw8vnSPocVFmOuIlK?=
 =?us-ascii?Q?Gb2+mWz4k04ewf1ttvxTiwfXy0fxjthbeC7E2ytcSpDJERoPqsqppo0WteBM?=
 =?us-ascii?Q?xpPJSlNvHpPTl2/nuTjYasY1sMrgIwtnFrsMm4Em4q7NmH4QphRc1tq+6UG5?=
 =?us-ascii?Q?lOr6h/uMrk27OhdK95HRHBRofaWbSg+8iGkoxt0sTdzuqRXkiPOYpNlA5Z5c?=
 =?us-ascii?Q?QmDAg1BBD8pw5ZJTv0NP7svwGoDgAmmEZTQPPDYdnGA552tw8EMC+0lwbDfx?=
 =?us-ascii?Q?r11KThDqoUQ5DWaTrkDr/yl2BuV33To5kptC2RRYIMR6xcrriKJeOcKUXI4C?=
 =?us-ascii?Q?VTfVZkfe8/OeM8N8pI0hE5s4y+SNW1ZaTsEGfgnw9Vopol04ql/C2H4Ilt00?=
 =?us-ascii?Q?ixeMkaHqUhYOgMGe8Y2o/phgzgkDu0+vNBbBHvNCPjjn4BQI41A/JSpt91+F?=
 =?us-ascii?Q?95Gs0pKX3WRJYnMc26drfnToXU9uo0VQGPbv+E1UuecbY3KwRbNgCReVB7DC?=
 =?us-ascii?Q?UY128/UGlRktA72KRRWYql1Saz9VIidpbGbZSBho43GmT5SApQrz3Iesl8tB?=
 =?us-ascii?Q?IDQ4djAEmWod8whcv1agWPz0Ix8lrzlEiLWjfdd16G1yyNryxuJqCaPQJs6G?=
 =?us-ascii?Q?arCdVB3rcF1OyLRZlg+JSjyFpO9CB228gW6bFzQG1dxgfiKB8IzfFtObnor6?=
 =?us-ascii?Q?rvML4hX79G9W+bUDQ7Sbtnut5STh9EIOoG8UXIj2W9dUtmnjKuuTNx4ggSGm?=
 =?us-ascii?Q?L1lKPJ1VxCMpCxvdyIkwPR9gnGonqeb8dhDjhUQH?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a25a31b-bf9e-4c43-bfdf-08ddf19e77cf
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 01:48:27.5842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pi5QA+6UQm5XIp5ocfEzqY4o1tuzhpuOPO3+/WqMKalux20KFpDnDY4lF0qMCLsy8aDa2eXtGzRIoELQ9URB3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11333

On Thu, Sep 11, 2025 at 11:56:42PM +0200, Marco Felsch wrote:
>Add the missing of_dma_controller_free() to free the resources allocated
>via of_dma_controller_register() during probe(). The missing free was
>introduced long time ago  by commit 23e118113782 ("dma: imx-sdma: use
>module_platform_driver for SDMA driver") while adding a proper .remove()
>implementation.
>
>Use the driver remove() callback to make it possible to backport this
>commit.
>
>Fixes: 23e118113782 ("dma: imx-sdma: use module_platform_driver for SDMA driver")
>Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

