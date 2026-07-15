Return-Path: <dmaengine+bounces-12543-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id f5PpLuMsV2rWGwEAu9opvQ
	(envelope-from <dmaengine+bounces-12543-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2026 08:46:59 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DC375B360
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2026 08:46:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=vivo.com header.s=selector2 header.b=h34pInHa;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12543-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12543-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=vivo.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4DE723026F34
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2026 06:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93290320A14;
	Wed, 15 Jul 2026 06:45:05 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012042.outbound.protection.outlook.com [52.101.126.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2973731F9AC;
	Wed, 15 Jul 2026 06:45:02 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784097905; cv=fail; b=uIwIsKoEsU2uPOU2Y5mh1GQGapXTSvf5sib5dKR3og4WrmXcYh4VuaSNvxG61vn+sEj7PG2OcyzKH3iOI4ztzuEB8s/GBr5+XfgL6R0oYCHjmRUWBTSGxz81jWnbN2l/fGk9JOzrMMkzbaLaSTbPgTJ3RmFVRxkDIUdxjowMAh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784097905; c=relaxed/simple;
	bh=kBjjXjZzvYzWVHq3xKFZ1zlWEHUpHQhz5n6ZXXnf1j0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nqhj4+KHYWr5q8EBoJOZcRxWSXC8VyaCFAJ4IssxAuRXtLFRMYpgVBXkvD4EofBEg9R17GFVHYidaZvYavj6gNxITiYh97R6K9DHh/rvjHiVNSyXe/FuRqSew06rO2aTP7WS0zI/jnDhGevtGqzaUs5vBoPCOd2i1d9ZhmqKFd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=h34pInHa; arc=fail smtp.client-ip=52.101.126.42
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n1/6Z3VoJIXc/UuF229/0tDEru66wok/Fr/6Q2rXXK4pBiOaoBKfBMqyLUTvQ5j0g8+HRXsM34lOfUAZ/9KOhgBo+YvNRrq2PEI72XSu5kwo1DYNYo2VLxMTMQYEAUjHzn/X2+uWASk0vtADuoOsUoGoNxCJSuI+5qvm5mSZ3e4FnLQX3fU4ds7LLXx+M3o/3Uxsc0htT9mxvsM2rxd0EZtx8uoXkR93EBYHLbty0Cs4A5DrcrX9PBlJyxFg+6B05BefFr4vzYvfEmd305VDBBBBQKm+QIqWZApgdzB++dj5r106rt8Cof20Cpz7FcwJupQGpH6Rs03x0ty3szrMJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/YFeYk5xw3Boy/uxWkTtMdNPJjZVZwbmeuLoGuj3ujw=;
 b=L9+LsQFgZ8u0XGwgOlt6saJwJQFM5aLMgY0Hk8XlrQWNV2Ce/1bfwXRD0xuGO1A2OXLSilAsIRSIrPhdnDvX37Y9DJSw2NsJ7a+dLhK2nnJ7Xt+vqBaNEFK6OPw/4pSAHzg88FVXs5JOKnWiwemJEZqghfXu07GhtrrBScLvA4wmT3hG8Uq94MoZtJzpYRZMiR0Q3cGngHcicH7Y+MkE91Tww62rZAl2tdybG2+2DJ3r8eFJMk5oCtTE6jcTIn07+6qQi56A0UZtoUmgbHHYDzGlcXTz38DZpw9HCXMeW9s4m0nqI4F0sUSlb2QokyLWf3LYaSkAQwX1VfEwwT68ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/YFeYk5xw3Boy/uxWkTtMdNPJjZVZwbmeuLoGuj3ujw=;
 b=h34pInHaiepLDLqZECA43/EhYdisi8vD/eFRPLK5buu6hFdhlR0GZ6++DYoCSokJalHJZeGJqLlek0f/J7m7CYnlJT5tDG5XgubvFGQ//Q6tL4kB3dMHZOH3/GOrfAoXFi4gy41sYI1QEEMoACM7tjG0caDFw7eFdHD/qMcsAMbZ65x64MG1KqhmciPibRinXIyxuvxI6yEazaQI1coQrPvuMuoCFgaKg5+4PfBWHKrU81Vt+ELdOVewv064uDpPOs0EDvqlQMqeNdSXwHWum1eORpDq9AcU2oLpudfi6NcdAmFQg+e01MHUh4yykWX7Wrz/Hxvs4yvn3NlSKh51HA==
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by KUZPR06MB8991.apcprd06.prod.outlook.com (2603:1096:d10:88::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 06:44:58 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 06:44:58 +0000
From: Pan Chuang <panchuang@vivo.com>
To: vkoul@kernel.org
Cc: Frank.Li@nxp.com,
	afaerber@suse.de,
	alexandre.torgue@foss.st.com,
	amelie.delaunay@foss.st.com,
	andersson@kernel.org,
	angelogioacchino.delregno@collabora.com,
	baolin.wang@linux.alibaba.com,
	biju.das.jz@bp.renesas.com,
	claudiu.beznea.uj@bp.renesas.com,
	cosmin-gabriel.tanislav.xa@renesas.com,
	daniel@zonque.org,
	dmaengine@vger.kernel.org,
	dmitry.baryshkov@oss.qualcomm.com,
	geert+renesas@glider.be,
	haojian.zhuang@gmail.com,
	hayashi.kunihiko@socionext.com,
	imx@lists.linux.dev,
	jernej.skrabec@gmail.com,
	john.madieu.xa@bp.renesas.com,
	jonathanh@nvidia.com,
	kees@kernel.org,
	keguang.zhang@gmail.com,
	ldewangan@nvidia.com,
	linmq006@gmail.com,
	linux-actions@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-mips@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	magnus.damm@gmail.com,
	mani@kernel.org,
	matthias.bgg@gmail.com,
	mcoquelin.stm32@gmail.com,
	mhiramat@kernel.org,
	orsonzhai@gmail.com,
	panchuang@vivo.com,
	patrice.chotard@foss.st.com,
	pjw@kernel.org,
	quic_jseerapu@quicinc.com,
	robert.jarzmik@free.fr,
	samuel.holland@sifive.com,
	sean.wang@mediatek.com,
	thierry.reding@kernel.org,
	thomasandreatta2000@gmail.com,
	vigneshr@ti.com,
	wens@kernel.org,
	wsa+renesas@sang-engineering.com,
	zhang.lyra@gmail.com,
	zhengxingda@iscas.ac.cn
Subject: Re: [PATCH 00/26] dmaengine: Remove redundant dev_err()/dev_err_probe() calls
Date: Wed, 15 Jul 2026 14:44:43 +0800
Message-Id: <20260715064443.525836-1-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <alYmNl--mxMK1-86@vaman>
References: <alYmNl--mxMK1-86@vaman>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0042.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:7::20) To SEZPR06MB5832.apcprd06.prod.outlook.com
 (2603:1096:101:c8::12)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|KUZPR06MB8991:EE_
X-MS-Office365-Filtering-Correlation-Id: fbc5fe82-180b-4eea-939c-08dee23c9625
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|52116014|1800799024|366016|38350700014|6133799003|56012099006|11063799006|22082099003|18002099003|41080700001;
X-Microsoft-Antispam-Message-Info:
	WYVFUGViK+AT6BFkkPqTRL8TgunUVYUvcmKa9R1UGcC8OuYQ/2Z1OdZS+tH9DVdv/a489oc9t9gx65if2FHp03cWAZWw6BgDnsMdMCGbi03vIU4bbFDzGktwFv0U6q5If/nmQUTBLlMpavxqgpfZ6bX6Z0KIQqiLTsCsioATcQ0Yp5v4M0iTRggz/jlGgvV4OPdfkVXnxbw3lEuwCHHU1J+1GN0Rg2zRslEqQeC0mwKNYv/fuqgKWOcVy4Dvkgrv5R0Xsfa9d6bPlT85TGm0WEvUQCKCbPgwwXRVT3EKjP6svoLlIDIGkISK5h2g9JZ8xzMOP74uSElmvkS/r+6HRqgceVTg8E5bC2S7z2fRdp41vX9eCYBPZh2slybArkvO8Bn0YQxraCSO+HwpQVPhVBQzmh4OF87dCV8pJKyvARhQCzKtUKjx5lkZE/cK8lpxDNzWsX0Gq0H6+nguZlZx1IMJb/OYLMFBoVDmSR1zf1GhCC2G3eRYxIW3VsSf6yZps7evsXVnywmBercgifvUK42Jd8GlrjZo1E89+BDf3/VP//HEV5w/K1BEtvaI9MKMQ6pPzd2c9Fsd6wHbZFFEDOHzSYG3Fgf/zihBT3qAaWtFGp6kfBEbTeUcVFq63EnqlkQCkGFm37Xq6AcQW9TuHvPRyHzjOQUNKFj3XHtpBIWndx9N6m/laiDR6mhg4R1XXj8WFSZHFnKTFUozQ/rpy/48o0ivaSmOItRC/9KvN//HnB2OSOpsJfRUGn7AQeTN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(52116014)(1800799024)(366016)(38350700014)(6133799003)(56012099006)(11063799006)(22082099003)(18002099003)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XX7d341lm0+hgQrKIp9/x9htYftyMTv5vZIOSom1XPuqtAw0vS6LILbpzaoV?=
 =?us-ascii?Q?j4In7qk7HasidjUHtvwZo/Ou8ZzMM7ibeXM8U5Lyv2GmrSEFNF6wZjgFRinj?=
 =?us-ascii?Q?xHPoJn/EenXJ4TmqsjmDPje4Vu3Es3Nv4HlYoTZ7UH0JyddTqx7aKjnGN9iR?=
 =?us-ascii?Q?Od8XCMoxR8/m7X/jTSf49L1j6lO/RBGPVRLNNWWJ57HWcYS6u8DO+71KXeoS?=
 =?us-ascii?Q?Kxchz1CEvP1f3qP+EMHVpzutKIkk1AVcXoqSy6+yG8sNl+GInBheb0xQhoL/?=
 =?us-ascii?Q?FXTl0BGHVTpjgpK2WyllcJIyC4yhw6ArgW+g6c7rkN3UgGaGxuBn3N/wThvO?=
 =?us-ascii?Q?JMTK3mIB11/Stjs2tswxFIAApbHKHZkAoLV4e39FJSxiCf5Y2fvkvmEhXmLG?=
 =?us-ascii?Q?MNnOAJd/DLT2B7QpvGETM6T9YtHTWgTP4tKLNKvlfR4/rPcL8lsZoA3RgFWI?=
 =?us-ascii?Q?70mg1q8ZEjoCQmn4ub5lalvXtSKiRtHAR5CQmGb9mqJ6tVvGOG+APEh/fETn?=
 =?us-ascii?Q?vlFAk2Y2tdDrm4zw0xtYgDOZuaq1M3Dw6BayVQ2w4AF7JFay6gdhAv7PsiT7?=
 =?us-ascii?Q?rkz+gWgSLaLvX9El3bSiQKdNoCTqVkU8ZQIO2Z1Po5fHZ6yzE0MTGgyNpgq8?=
 =?us-ascii?Q?FHyerwpCCE9KafITNVU8BE+xVceZ+bF1wFbBHmshWBKqfMm2GwhDiRXrN+nw?=
 =?us-ascii?Q?rLPcK8aM5MzwJoFeti17wXxwsgl0QmQt3sYaK/kaYu2N0dXNJ9fYZQRHYwF4?=
 =?us-ascii?Q?nfIhVT+0xyvvwUEQYc/WCavQnIEDX7h4kTuOV4UKQQrC04qvvsgY+/VP49bT?=
 =?us-ascii?Q?cEyy0s55/xt79oU2QWrind8HNcMd54szhis+YJh2vwhnsd2eTMDnUfG18MUN?=
 =?us-ascii?Q?oP6kBCDBk4E+v/+5v2p3w1SGCu2G0DF5JEXP1X02oCyDw0DBvqO6aZXakU6V?=
 =?us-ascii?Q?fJTkAqXI1Irh/ZMK80CIY1zHQRuxZHc2xNvMZ4MNJFXLFZnPqUmypaSboPfj?=
 =?us-ascii?Q?6ln0a4ZXeewlC5ZJtpvJ49WDCQ/sBZz9cLlPWl6Yjwu0ULUMjv2UlZHaBfCu?=
 =?us-ascii?Q?HrFcdl/4bQLSLB+A8BXLPYUGAKPamCctDPHG4UhtRA1FYtaO13V/kzDQfJkn?=
 =?us-ascii?Q?842rolaL/OSM7d6GrKHXPSyTgTBWbQgt11rlMba75ZXLACmoWnfrDuSKKUZE?=
 =?us-ascii?Q?VG0lBxMwRwnNNi6/5pVTsb5YGhbEx3cycv3S4W/boQeI1TZgReKWzZwFPzeD?=
 =?us-ascii?Q?G96r4CYgl1NMzoIBfc7ybzMGUuEbOmyslbcH1sofvF51jgV7R11DGCjK/zz1?=
 =?us-ascii?Q?3ve6NtsfCceGHs9FogujGBu7OLt7MLx33CeNA/U0OgTA4KAMDRR37zSJJaY4?=
 =?us-ascii?Q?7keYajo57njgq2VmXLWiz+DnJBrFgyFABSOVMpWzIXmrrSf3jvH19eu3UXzS?=
 =?us-ascii?Q?ul70UHnw9GA22eduMlZUsjB5W3qUU8/6rKupBQqGQzqz3po53sfw9Bais+/u?=
 =?us-ascii?Q?5fn9TGd437kGQmR5bi+RDtOZ+5aJyDCCjYCRQcS1O9rmJxtNuxFxY9yFjvTX?=
 =?us-ascii?Q?C0M3Fja+a6Nd3iMNUOikfV+lRrXxwtb4hGtJL6npZEtD81JwPLcJItYgxOj8?=
 =?us-ascii?Q?lM/8sTUpGnj/agT6ggU2XliFj419UFcRsM45JYAp7YZ9XSurQb6eiTZAlduM?=
 =?us-ascii?Q?AguyDZePmuxAG/z35nfDTGiXW5hTvQI2jMErqDU87ux9aOEiSs5D5iPtJaV+?=
 =?us-ascii?Q?UsvLz0J13g=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbc5fe82-180b-4eea-939c-08dee23c9625
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 06:44:58.0134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IV1eCzCAFMOqLCkkSyOqdg4aBiGm3bqN16cYaZK3pY2/atV4o+JJKB2hQqnKR7xOETHjwRL0kbbzqvHpOlo6yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR06MB8991
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[vivo.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[vivo.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nxp.com,suse.de,foss.st.com,kernel.org,collabora.com,linux.alibaba.com,bp.renesas.com,renesas.com,zonque.org,vger.kernel.org,oss.qualcomm.com,glider.be,gmail.com,socionext.com,lists.linux.dev,nvidia.com,lists.infradead.org,st-md-mailman.stormreply.com,vivo.com,quicinc.com,free.fr,sifive.com,mediatek.com,ti.com,sang-engineering.com,iscas.ac.cn];
	TAGGED_FROM(0.00)[bounces-12543-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@nxp.com,m:afaerber@suse.de,m:alexandre.torgue@foss.st.com,m:amelie.delaunay@foss.st.com,m:andersson@kernel.org,m:angelogioacchino.delregno@collabora.com,m:baolin.wang@linux.alibaba.com,m:biju.das.jz@bp.renesas.com,m:claudiu.beznea.uj@bp.renesas.com,m:cosmin-gabriel.tanislav.xa@renesas.com,m:daniel@zonque.org,m:dmaengine@vger.kernel.org,m:dmitry.baryshkov@oss.qualcomm.com,m:geert+renesas@glider.be,m:haojian.zhuang@gmail.com,m:hayashi.kunihiko@socionext.com,m:imx@lists.linux.dev,m:jernej.skrabec@gmail.com,m:john.madieu.xa@bp.renesas.com,m:jonathanh@nvidia.com,m:kees@kernel.org,m:keguang.zhang@gmail.com,m:ldewangan@nvidia.com,m:linmq006@gmail.com,m:linux-actions@lists.infradead.org,m:linux-arm-kernel@lists.infradead.org,m:linux-arm-msm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mediatek@lists.infradead.org,m:linux-mips@vger.kernel.org,m:linux-renesas-soc@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:linux-stm32@st-
 md-mailman.stormreply.com,m:linux-sunxi@lists.linux.dev,m:linux-tegra@vger.kernel.org,m:magnus.damm@gmail.com,m:mani@kernel.org,m:matthias.bgg@gmail.com,m:mcoquelin.stm32@gmail.com,m:mhiramat@kernel.org,m:orsonzhai@gmail.com,m:panchuang@vivo.com,m:patrice.chotard@foss.st.com,m:pjw@kernel.org,m:quic_jseerapu@quicinc.com,m:robert.jarzmik@free.fr,m:samuel.holland@sifive.com,m:sean.wang@mediatek.com,m:thierry.reding@kernel.org,m:thomasandreatta2000@gmail.com,m:vigneshr@ti.com,m:wens@kernel.org,m:wsa+renesas@sang-engineering.com,m:zhang.lyra@gmail.com,m:zhengxingda@iscas.ac.cn,m:geert@glider.be,m:haojianzhuang@gmail.com,m:jernejskrabec@gmail.com,m:keguangzhang@gmail.com,m:magnusdamm@gmail.com,m:matthiasbgg@gmail.com,m:mcoquelinstm32@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[panchuang@vivo.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[vivo.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[panchuang@vivo.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_GT_50(0.00)[56];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vivo.com:from_mime,vivo.com:dkim,vivo.com:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 35DC375B360

On 2026-07-14 20:06, Vinod Koul wrote:
> On 09-07-26, 16:26, Wolfram Sang wrote:
>> On Thu, Jul 09, 2026 at 09:58:04PM +0800, Pan Chuang wrote:
>>> Commit 55b48e23f5c4b6f5ca9b7ab09599b17dcf501c10 ("genirq/devres: Add
>>> error handling in devm_request_*_irq()") added automatic error logging
>>> to devm_request_threaded_irq() and devm_request_any_context_irq() via
>>> the new devm_request_result() helper. The helper prints device name,
>>> IRQ number, handler functions, and error code on failure.
>>>
>>> Since devm_request_irq() is a static inline wrapper around
>>> devm_request_threaded_irq(), it also benefits from this automatic
>>> logging.
>>>
>>> This series removes the now-redundant dev_err() and dev_err_probe() calls
>>> in dmaengine drivers that follow these devm_request_*_irq() functions,
>>> as the core now provides more detailed diagnostic information on failure.
>>>
>>> Pan Chuang (26):
>>>   dmaengine: fsl-edma-main: Remove redundant dev_err()/dev_err_probe()
>>>   dmaengine: fsl-qdma: Remove redundant dev_err()/dev_err_probe()
>>>   dmaengine: loongson-loongson1-apb-dma: Remove redundant
>>>     dev_err()/dev_err_probe()
>>>   dmaengine: mediatek-mtk-cqdma: Remove redundant
>>>     dev_err()/dev_err_probe()
>>>   dmaengine: mediatek-mtk-hsdma: Remove redundant
>>>     dev_err()/dev_err_probe()
>>>   dmaengine: mmp_pdma: Remove redundant dev_err()/dev_err_probe()
>>>   dmaengine: moxart-dma: Remove redundant dev_err()/dev_err_probe()
>>>   dmaengine: owl-dma: Remove redundant dev_err()/dev_err_probe()
>>>   dmaengine: pxa_dma: Remove redundant dev_err()/dev_err_probe()
>>>   dmaengine: qcom-gpi: Remove redundant dev_err()/dev_err_probe()
>>>   dmaengine: sf-pdma-sf-pdma: Remove redundant dev_err()/dev_err_probe()
>>>   dmaengine: sh-rcar-dmac: Remove redundant dev_err()/dev_err_probe()
>>>   dmaengine: sh-rz-dmac: Remove redundant dev_err()/dev_err_probe()
>>>   dmaengine: sh-shdmac: Remove redundant dev_err()/dev_err_probe()
>>>   dmaengine: sh-usb-dmac: Remove redundant dev_err()/dev_err_probe()
>>>   dmaengine: sprd-dma: Remove redundant dev_err()/dev_err_probe()
>>>   dmaengine: st_fdma: Remove redundant dev_err()/dev_err_probe()
>>>   dmaengine: stm32-stm32-dma: Remove redundant dev_err()/dev_err_probe()
>>>   dmaengine: stm32-stm32-dma3: Remove redundant
>>>     dev_err()/dev_err_probe()
>>>   dmaengine: stm32-stm32-mdma: Remove redundant
>>>     dev_err()/dev_err_probe()
>>>   dmaengine: sun4i-dma: Remove redundant dev_err()/dev_err_probe()
>>>   dmaengine: sun6i-dma: Remove redundant dev_err()/dev_err_probe()
>>>   dmaengine: tegra20-apb-dma: Remove redundant dev_err()/dev_err_probe()
>>>   dmaengine: ti-edma: Remove redundant dev_err()/dev_err_probe()
>>>   dmaengine: uniphier-xdmac: Remove redundant dev_err()/dev_err_probe()
>>>   dmaengine: xgene-dma: Remove redundant dev_err()/dev_err_probe()
>>
>> One patch per subsystem for such trivial changes, please.
>
> Yes pretty please
>
Thanks, I'll merge them in v2.

Best Regards,
PanChuang

