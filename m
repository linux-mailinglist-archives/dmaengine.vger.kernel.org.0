Return-Path: <dmaengine+bounces-2430-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F0290FB3D
	for <lists+dmaengine@lfdr.de>; Thu, 20 Jun 2024 04:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCB74283617
	for <lists+dmaengine@lfdr.de>; Thu, 20 Jun 2024 02:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B7718026;
	Thu, 20 Jun 2024 02:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sVOyguy9"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2069.outbound.protection.outlook.com [40.107.7.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E5EB66F;
	Thu, 20 Jun 2024 02:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718849902; cv=fail; b=DEP8UZGDwlw+7PdrYKS9yCTWzqI0w4v1VecT40PvfrTA6l0ZUnqvqtDlglmisuAtWr9g1owXE7ch6Ay60jtniDPqsI4Cx1pGZG0tqbze4VCsUKtzXoxBwn+A49noRb6I+w63oivtM0+Rmipb5BbbKtM0Y/PhS7OOly9Rf9sSdXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718849902; c=relaxed/simple;
	bh=fNJj7jTlU40jjUfhPCu/mnbKyEyOwyJ/JeNZwO6BHuo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=NOIUtkOda4eP35KPCudqAcqfo5KxJMylOyBmIG1VMy9DCDjdz6YyZktMMeRdIpOUl/fSYQ9M9BVlxTrdl+m4Twcdym5MMIRzTRw7rnnDcRz34QVr/D5O4J6u1YP0e8hzoIAPD4DaN8rDkQex6LknSUSty9+2U4nFmHK6a9cYHYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=sVOyguy9; arc=fail smtp.client-ip=40.107.7.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PtaLBEuV0KqAMO5KTfHpWlG1IMLl90QFI7Z5i8s0UHowK77Ul/VNH/DMThKgXlSSp+zrBSplKvFRBe1qd9pSGQnkXEr9vbON04eIPIUOZpXhyilfE3GbXvia/LdVvZY/GsyW0+jPU6PhSWC+WDATmzrL41S8CtpC29hvWU3B+wG8Jal9ktiu/xPHTPre9ighStHx7v6nV5Ug6BCRnA4xXsu6Pyv9sPVcC/JuC0LG2x6caiDue03WQZ/0lxYNOPWinL6GU9NJy+OYAWHMybiEhPQRMMJRoI7U968g1WbhaFk8GxbiKx7xnhamjpvoMcUFc9dQIOEBJ6aSF1MHSQFxYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ffzOXmhMPeyT60jI5mpFG/Cq0LmSD0JVC0QG3d3P7Os=;
 b=SxjaaNwUZLWzWS9gMvDkn2aj798ig3uOHVOBWAau+MTaAkqFmPCGZxV9fD39XrQy0R9VgCLnawxXU1zRKB4fpDGwL0dzy/XyxztoWgjpRMldrSdE+ju1AqvG3bAKer+V9CU5uK17tf4VeEJNDEFP0DrlyGmbEsAIhhgF2M5NQmErLyas14aiCdtU/3arozbNpLTbJtJPvEz8clyFFNAW7EkqBVANzbr/6ihB1+IOb7E19MshClY0D0GIRLDtHvSYf2c2ri7kqGq444ddnDAYzmvYn+skp9zssNNxfrYk3y9xC3VN4fQ68O0yVJMAppe2IuVrKId8etxXZ93tv40WqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffzOXmhMPeyT60jI5mpFG/Cq0LmSD0JVC0QG3d3P7Os=;
 b=sVOyguy9MbQ5TAPf0uB9X0StLZ6hjd2jNBA/suDEZK3DoWiZaMT9GbrFOa1v5UpL6sB2v1abIsbIGrwfN7XvfxT15mw6kxVAgzqe6DmEeSshZEMtvG5t1vUsCct+7kDfQG/L8trnsM97wxHdrYhHMWlGhP2IeXcTc0nAP13pOes=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by AM9PR04MB8472.eurprd04.prod.outlook.com (2603:10a6:20b:417::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Thu, 20 Jun
 2024 02:18:17 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c%5]) with mapi id 15.20.7698.020; Thu, 20 Jun 2024
 02:18:17 +0000
From: Joy Zou <joy.zou@nxp.com>
To: frank.li@nxp.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: imx@lists.linux.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2 0/2] remove and reorder labels
Date: Thu, 20 Jun 2024 10:26:35 +0800
Message-Id: <20240620022637.2494329-1-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::18) To AS4PR04MB9386.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|AM9PR04MB8472:EE_
X-MS-Office365-Filtering-Correlation-Id: e71bfe95-4406-480f-4892-08dc90cf3f27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|7416011|1800799021|52116011|366013|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xtGBsKnFHlB2cne8aPijQEC+Z/o8bTyjvjyxsuSoVG8nk0Y1xb+MBxtipgdk?=
 =?us-ascii?Q?ZZ+72DOzUg4vKehYvIPxr4yye4u+a44nstqNai6WZus36qODRBxN/2z5F4BU?=
 =?us-ascii?Q?NpgMz3FcXPhAHJfV0kS+kIpErUJ2GwtmqD1PcDOc4QPaY5hwFKuPeyM4Hebe?=
 =?us-ascii?Q?f3GTkqAG9nzgSPOvRkUIqiZfgNF8BV/ffdIUkPMKM+c6kC12atgt0mEbpwiw?=
 =?us-ascii?Q?8WZ/7MuWmz/N89cfM42fX2wr57sncaZKvTVFi4KsprWjp3gnZcM7SBG8F2aD?=
 =?us-ascii?Q?ewenbbeui+9I0rFTsU1idriAZF+wWWspHFS1AkXBgbf4ix8gyugIfSwKghYl?=
 =?us-ascii?Q?J6hZJgo5/XLMRBMrmjQdU10ZAK9elDgH4harUpWv1N2xl4F2r0jisw2dQMOq?=
 =?us-ascii?Q?mXQuzuX8b/ApgPFCXwOpYweCTRmOruemBFMPBg7Rj2h5N1WcIHEQ0tVQMoIs?=
 =?us-ascii?Q?lxvbwuiiG+TXE5BDrZ+s4wZMNYr4Xz3LMHvoI7dgqrzJ5UjXjlE8WmyoUsju?=
 =?us-ascii?Q?A8REoRT0OYvNky3iKlHuALD9eHkXf1BC4bRJ66H1LUVrr0vxtYWhXaZ7m08I?=
 =?us-ascii?Q?6AELevS852xMyMmjeF0BKVwtcw6IDHn5NSQp1hgyo3ASPZyrbDovj0nRwTas?=
 =?us-ascii?Q?A8jSwJAr+q7D6E62OajYRB8yWBOdYx+MWXLvgauZKgW+cDikYKhNN0lRxWMu?=
 =?us-ascii?Q?AgazkTAtNlLaD3gGHvRLquF5pVRLZQ9MGQklKWL0aIssWyUp9Tc1iZ3Iuvro?=
 =?us-ascii?Q?MoDyK9QB5OvZR3rDRYlQm5vXpmJQC0lAkGL9vjxo0mixNDzbPKgujVWrULRd?=
 =?us-ascii?Q?UTY73712ejTmr/FXX7Y9J83z2gF36+OgYMPo8QJQkqu5twDoiy7hPdR5uXQr?=
 =?us-ascii?Q?WLi8xaT3KyRPV9sHDcfH8UfMRqpxiNMs6Hezo7rnkbzwN/l5lwL+TYyEe8Gi?=
 =?us-ascii?Q?Ksnd8gI09e92qlsPH3yGKlcoPjRfUIrqQtZZjsRIt+3YovCWXVDoTYaubrj2?=
 =?us-ascii?Q?lzqEVmhtfwWk5ReTgTz5Hp1xf5YmL/Ot6btXg5QaVrZL1BfoOMRX3PiYRHyu?=
 =?us-ascii?Q?1PPI7ZhfTillVljYtSmYn2deuQ4fHX/zDdBeSEFnGsCCRn5A4XBlZUAz3pAi?=
 =?us-ascii?Q?RvenZD4011ZeTSbTwm3h4AB0mmxTlsZZxbLnArPLaI/NlB4vuviyLhn/qfk3?=
 =?us-ascii?Q?XEDwg2eWYXl+Ez/DPYYc98b3WOjwnuwKwbDtKOPAi9BSgTx/1FO2+2WQ1h2E?=
 =?us-ascii?Q?XhSxUY7TT9LZ4vdFNvo7EWBOKQ+Qv8S9aXJBo/9mMkNnncFzEXSKLoTF8xx5?=
 =?us-ascii?Q?iL7fYmoVlB42ODxmq5tl8Cj9dUMN00rvng8OaXguIFU5g7LqbAom4w3XJfMr?=
 =?us-ascii?Q?DZNS+PU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(7416011)(1800799021)(52116011)(366013)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NhLfeB6XSE/mXbtsnUYovtX3MsjCLshM9VxUnEKj3eAC4oY+Zd0bmhd5CsLq?=
 =?us-ascii?Q?UJJC0Soc0BugQ4b9lGF6+lKXOMfl8faTJNLdF48jAyWTTEOV+8eZ+eXzNWiV?=
 =?us-ascii?Q?8vmjMDVJRYlTBIxKaPJcJWS5RFTyg/dsnYEjxvmadNVTq3E5I3N+m7GSfOt3?=
 =?us-ascii?Q?lFzfCL0FNDeSgMKOHIneqx/D1y/uztFjjz6XBnCEVOgkv3rrDIHbyr0gJaof?=
 =?us-ascii?Q?WVMfSi13oMTltnkNo+Z1N2TywwiT4Ik1j8nvknvEmmi9kAd1gyCPIyUFFt6M?=
 =?us-ascii?Q?JA2Jkx5DOAhbNamrwbcyRLE3uisejRwb2ER1Jnib+WMxM2QGPbGiKOcyaHOV?=
 =?us-ascii?Q?3OkfMgYdtJX2rSCpHYZtbAkfPINCN6OftZEgK4yNVnq80CQJydT0Y2K6QlIx?=
 =?us-ascii?Q?MSXQc8BqGhm2ey65X3sySD5xemmgqmvP30hmZOA4j4E2F6wHCOlqwrjspTkX?=
 =?us-ascii?Q?xHu4skLmrHHn0ArGUxsMlSgf/bDb7fAUWg53bmv5Irm/u6sHs7UBaQTi80nQ?=
 =?us-ascii?Q?cyPA6cJq95fMHw5s+vlbEwdGFtUXKeWt+SG0h0VtnM4mxZ038B/TyaQtyLuG?=
 =?us-ascii?Q?QVfG7326ZyuLBVcRumkrl7FFDzkYLgEV3eaQM8d1W7nlCMLZScE7KJdcH+mf?=
 =?us-ascii?Q?FIUJaJaOWAZngitRoPMIuk0v/fepKH3kO7vzaOMELv0xJjtBv7bkIqTTcO90?=
 =?us-ascii?Q?5bgAuG+T8StQDnnOxj5Ls5QDZRZ7Qm34LZUoTMUn9gXPp3NrITm6DEXD/Gts?=
 =?us-ascii?Q?UTmqCU3bERMptdOZaECaK1OptTS1sxCrOfvYvCfu40ifXbT0NU+qwI1LdCVq?=
 =?us-ascii?Q?TUYsWR906d+2xjInnLBPIXuOvWwT7YbYMv9g8bW6T9+HboXN8/oCbAE4D4JD?=
 =?us-ascii?Q?HdqRCJMutW7C8fHn56ziyw2byQq/u0rktHkb4Aq+qDFByuGJVg3eXOYlampP?=
 =?us-ascii?Q?F5a6HfYVtlr59XGykgqss7h+whqr6nj03buWdfnCbK03Qpc4JMjyjvV5r3Y8?=
 =?us-ascii?Q?hHmcb0J7k0HEkvNFsm//x+rrO+Cevv7SXYJkekw4FS+eNQj0ylUCxWZIj0k4?=
 =?us-ascii?Q?lO4+JacHbSaH6UDKQQS5DeAnEU9JNTTZShVzAZ/LSBy57yq8E4QRKsUZGBxv?=
 =?us-ascii?Q?d2OZiI0GG747OAOi4CtuDO22zkRaOTy1YtCmu6LjoTu0FLA+38RQc3k/XzbF?=
 =?us-ascii?Q?xVmKmfMv5PEWr1fhT0OCwH7axVYygtuKjDWJCSjqVIIJXLCn//2qh8TmD7W5?=
 =?us-ascii?Q?55BtfdJaXgPNCby272Xa4ioovt1CsZcqPBUl4s52/xsGBsGdXtOFZkHX1YFz?=
 =?us-ascii?Q?TVmdhXtOAlWqyWErO4Z5Es9EklUTIZStQXOe9Pf/yLw+XzaLCIyj4ua6oJr6?=
 =?us-ascii?Q?9RcWiMbKKNmi2SPhdO1o2JlLV3QI0ZjtgiZLwCUO0OyUda96pA99/8bq1J0e?=
 =?us-ascii?Q?7tKDsFMeNF7H1q1Ibs61C3waQH7CGEVNpt937jlsk1hv1M08llQVs4gzQwfE?=
 =?us-ascii?Q?Ep2OTVHyMZlGp9j9U8vLKm11JJoymYqoOMe6L83ERWzwSO5jJggTa58o3+NV?=
 =?us-ascii?Q?ATKlTmXuIjNfZN3cPh0qUDCg7UG4Dcd3btOhdJCz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e71bfe95-4406-480f-4892-08dc90cf3f27
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 02:18:17.5242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kZKYQJkAkn14n2fk0Thd7yymbBnV7H3HR/xq39XaeUEFtSJGhkqRi5p4PpJ0Ddi7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8472

For the details, please check the patch commit log.

---
Changes for v2:
1. separate the remove label patch from reorder patch.
2. change the child device order in lpi2c3.
3. modify the commit message.

Joy Zou (2):
  arm64: dts: imx93-11x11-evk: fix duplicated lpi2c3 labels
  arm64: dts: imx93-11x11-evk: reorder lpi2c2, lpi2c3, mu1 and mu2 label

 .../boot/dts/freescale/imx93-11x11-evk.dts    | 309 +++++++++---------
 1 file changed, 151 insertions(+), 158 deletions(-)

-- 
2.37.1


