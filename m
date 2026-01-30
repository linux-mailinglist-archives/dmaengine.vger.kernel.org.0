Return-Path: <dmaengine+bounces-8626-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MyrIM/TfGlbOwIAu9opvQ
	(envelope-from <dmaengine+bounces-8626-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 16:52:47 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFEBBC3F0
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 16:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 455833004C9A
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 15:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA1034321A;
	Fri, 30 Jan 2026 15:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VHa+29TK"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013004.outbound.protection.outlook.com [52.101.72.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE3E33C1BB;
	Fri, 30 Jan 2026 15:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769788358; cv=fail; b=ukPIa8oZmEJN0vcsqzLcn9LKLhcASWYuA24cLPGe/hppYZWvp1VFVzxXwTlcghg3UtRo89NaM5BGNAu23jTfH+oxv0oB3587yOkH5/PE0ABsb8I4//+0cRIQK++ZXDaS6Mrte9nFawUsSyWASNLVljdg2DOqBcdD8zD0rtSX8j0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769788358; c=relaxed/simple;
	bh=E58iBGao1cMRzqFJ6tKx6S7Ua474MZRd04qzC7a+pL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mQ2YfO1b/vkp1xHThup/RqfZ4Fmzr6HlvxumPlEY3whL1+O2E7xepdYh3ZgDSAvAlUZz2XalBK1Jz9ZPjp9LjZAy2UdYhKSWT6n1vfMzm8t1mni4L15j4OgHv+zhK6ziaBDSO40Bd82wAWJn8+PswiVG35nVJ0zxDYAe34ruNio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VHa+29TK; arc=fail smtp.client-ip=52.101.72.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d9K7Bjn5zztNC/2n7Izt8rd4s21w8Bw4ofRqPzbnSmq0vnFQfEe9WkAC2agmWXdlIZiaP2wMOIHNhADJ5+C/S/U59i+2WRhbaRjxKUBORiy4265a6ohFv7HMTAVYDZ+NLEIyGPsYT8xSrcDshMAkKu/VCLoTBkGYwCLLG0v4MOkzbZn625KM1n/338UjeFYq8mN+PA+quEjlqERCQPoUuXOQz0DkExigza7rxgST/X7CO+3ZcYUPquPXyjjl9yB5ElR6DzfvmxvOYyFN0RuBtHh0v2t8HK5NnEC4+IoPKuTbqo0UGs8CquHqRP8WZs6qESi/uSwdF20ymN7TqBKW2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QXd3JsSRnTzCMYbpci5jQq0m0HgcGcYmMjMuSqzZaAI=;
 b=ajlop4PUavUcNQ7CsBofTYKEFdi6X7cmRpBXjcW0NmGtjmYlbiX+QmkJ/thX7Kzov2n+Nu57fDXTCRt4oLYMs3X1EGfGOsdJhnKU/4ixMCn2Gju13g3KZl4tJ4qS4zmGMMlVDZpeXskuR+gbNc+4N+AUAiy+JMuOFgIaCtN84F0UJuB0/joSGwzY6uHAAgek9b6P/lnoK904180TJ1iC7Fup27Cddvh0PHhdRE1BIuOZWTZmMdhxzHnHN/Yio7CGQAVkfk8Tx/wrw5Vy+cMfTM5SmlYU+0eVw5Yac3hbnchR9oVdEhufHq6pDY9XCPePDUvMQhhmliiB6KoFKsXmbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QXd3JsSRnTzCMYbpci5jQq0m0HgcGcYmMjMuSqzZaAI=;
 b=VHa+29TKz+gTJot/2jviBbd1QGHKFWOtxEWE5/0UXBTJzT5puVteRVqpUBXtl96vsnDId3GLvHslVd0hnjP4prabdRhl4oTPs+iEhCsvZYhAT09GOkZmUVi4jYeFywWUjkuf5v8/pcUav94WetPkEMpeOUx4zN0B5pDcxQMd87YajC6R1LjmvGskLB78q2v3KF3ZyJuatYi/3dhtp20rF0iT842UHiGioa4mkgR1I0Ws5VYw6yd8DQaPw69MG4LiAxITQVVRrJuDxTKr3I09cjrxnXyPCIfYJDLaypH3liO4+SqCgFPqVOvy/YKm03Hd9ycv53W/AqUwNVzVHJFFFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by VI2PR04MB10809.eurprd04.prod.outlook.com (2603:10a6:800:27b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Fri, 30 Jan
 2026 15:52:33 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9564.010; Fri, 30 Jan 2026
 15:52:32 +0000
Date: Fri, 30 Jan 2026 10:52:25 -0500
From: Frank Li <Frank.li@nxp.com>
To: Sai Sree Kartheek Adivi <s-adivi@ti.com>
Cc: peter.ujfalusi@gmail.com, vkoul@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, nm@ti.com,
	ssantosh@kernel.org, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, vigneshr@ti.com,
	r-sharma3@ti.com, gehariprasath@ti.com
Subject: Re: [PATCH v4 06/19] dmaengine: ti: k3-udma: Add variant-specific
 function pointers to udma_dev
Message-ID: <aXzTubDlsQDIgLGM@lizhi-Precision-Tower-5810>
References: <20260130110159.359501-1-s-adivi@ti.com>
 <20260130110159.359501-7-s-adivi@ti.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260130110159.359501-7-s-adivi@ti.com>
X-ClientProxiedBy: PH1PEPF0001330D.namprd07.prod.outlook.com
 (2603:10b6:518:1::1c) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|VI2PR04MB10809:EE_
X-MS-Office365-Filtering-Correlation-Id: f47f9523-e3e5-48cf-57e8-08de60179473
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|1800799024|7416014|376014|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4ik7prwfEGUJXQ2SSyNzgwC9hmcKfjL0eD7mRzQ0fSEmPNgn6q2E8cQ7UdoM?=
 =?us-ascii?Q?TH4ddsnay80LonwSfW0Hzqo7CIskzWEU3pkhseJujKSLHThgdPxuQkp7nege?=
 =?us-ascii?Q?92pY7PZ+A9lkTw1jiQ0tC7c7jLp020D4SzvBzNSLON5PNHwuzXsrMWIBs9d+?=
 =?us-ascii?Q?uh8isdNzwDlazLhW+XvJJCoZnTphZy0SR99+GKu8ZVRfxok1+LBK6sbVZAFX?=
 =?us-ascii?Q?tlgzw3bZXPlM+G4bmnZeZNb3raNjGCIv9KX/z8yoTkVIopUPrz0OInUjMXUI?=
 =?us-ascii?Q?aHSfRgoruDq49k/BzxflLPBRevZxx/hrUzu5hcfWaIG2VIOn39TfIn/5Er4g?=
 =?us-ascii?Q?PabfVMfhQB5YeSqk1Jv7FYtp7g2Z42liCkKgqBEnPY9FG3Eq0CMyHl6sHJ04?=
 =?us-ascii?Q?ZpwoNaPFBFAY8BDg0Lf10yhQatvY4z0kv54PnoVt4j/e4lN/320QB9ZCMIr6?=
 =?us-ascii?Q?0Ra6k13hdygiHEilpl/tVwJX1sAmLyqov2RhO5fFX29ZT8VJAo72IXALm631?=
 =?us-ascii?Q?uhp6BtEF0lXSraiGov3EgJTkEfA2Fhr7z8zhd2I2oiRNafi5D6whEXWXHp1L?=
 =?us-ascii?Q?Sxe2p0h2qCm6xwdIJBGw2ahrTe8oN/T1tng4gvgzhOYzhNqGBlixctmmWmC1?=
 =?us-ascii?Q?3h9aWyZhLWOPJhLtXgS/28jdtLE5Kz5OsQCReYNE1qGyTOolp9k8X9mjcxD/?=
 =?us-ascii?Q?iEPUEZkmAoHNYcvPzatPylDH4D82qXXV4vvNe0Fnw8hY0fhf5l5gXPMRGQ06?=
 =?us-ascii?Q?eYZ4OiXy4WM0og4j0R4zz1/9iLqtYcuwGR49N91zBsOkPEdDbqChOeHgXc5i?=
 =?us-ascii?Q?R6stSESihm8aAj928ZrIBMlmXyQY6vVYfXo63p8TQo0QxORISIPso6SJHXMD?=
 =?us-ascii?Q?1lQzLZ0HoAj8DZNuMxMrMnk69jMnJmEZ8P+jGjVy5phOe31b+jNPcxUM6x9u?=
 =?us-ascii?Q?MMKD+bkWgQtNNZX8B4BfiLERk4n3NyghOy2xtHBccwJmyEZo88BvQ8xcAjj5?=
 =?us-ascii?Q?cdHYEBeOqtgv7HqHZvN/7M8AA8afh6BKwDcAr9jERVPr6JAmKJaQJsoCHHAc?=
 =?us-ascii?Q?NkUhc6MeOVl2eSFYBqfu6s7gcOJKzL17VGOP8sxD27/ivDJMo9B37rO6VRa6?=
 =?us-ascii?Q?dbLkG4ML+2W1f15U5Sa57eTZGMrUVxgTZGOB8xRhBndGXNDHdE07KzCFikPQ?=
 =?us-ascii?Q?dh9GtkULVf+ZfRbhm9NvhWugTkxqbrwh0wzNlyiUS+MZoe0QyQkHaBnj/aZR?=
 =?us-ascii?Q?Xy/PSKu6mfsPUuWj/Bp9SxdTc/YGr5NyrveUV2LcLovocaV3kUZzohgxZkH0?=
 =?us-ascii?Q?ZFSueZe1yjujtjsZl9UoIjZB85TPOGg6/EtD8BMae0CBBeJGoxRcaUK7rBTd?=
 =?us-ascii?Q?8NuYg1PRBczwNErZoWz72Sy0IwkbS4PFPcTAjxy7i/NInORitjpbbdnO9CCs?=
 =?us-ascii?Q?82geuoNLMOpGEqwmSo1hB/qOqEivanNHMrHnXQp7VlF+UlRizx/GbuGxR2tF?=
 =?us-ascii?Q?hKfN4V+grnKedBunopQblxkKREm9RN6A9pilz3delSHVE9uJPrmHbRoq4U57?=
 =?us-ascii?Q?L47jeLgETkq3wyRrV0NI81qotFLfzTVakLFkPWHHFNfdqGta5M3ujf4GQN4F?=
 =?us-ascii?Q?NB9SUz4WDIoyaetxKPGNqhI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(1800799024)(7416014)(376014)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EI6i9lDN2OpmpK3fv3kR6hldXdRfMwp+LoVcg888WYz6b+MbZrxadhX9Oher?=
 =?us-ascii?Q?yRb77HaVzWJbgbbpRVefTwmJtOOvvO/O8hZgXcc2R2yIafNdgDwfEbc/mEtg?=
 =?us-ascii?Q?ttiW7MWKZty19yDCqSp8i10EYuthr5c21VbZ8TH4/mbtqWApEMX5SLeE8Vg1?=
 =?us-ascii?Q?WOinVWhKnqa5NEnSJsIn2HfvFrO+hu8sHQ+1xURObnMkJSj0w8BJfn1+flr7?=
 =?us-ascii?Q?wZGEk7b2qnLijB+Gg3QqbYwLLF9EWDSyvJaF2YDoBki3OOfbxq3owyKcvPKd?=
 =?us-ascii?Q?m/p5YNrK9xc1pSKITo0/hwDp0tuhtWxUpFeCshP+oXVrqH+fFbW7BCPERnHq?=
 =?us-ascii?Q?7dFKhhsY7W7HbGoUz5PeoTzhtlHf3Kb1OqWOExHSI0Au+rvT8jBfLnHMZpXF?=
 =?us-ascii?Q?3CnRlMjlX9It2JF9NDi4ZBg2iGbn72C4IE6CR4BlvCzCMN88zJ22zVA8Z/ue?=
 =?us-ascii?Q?Nsa4wgfM3bBGRCQpUxEnpGEJMG1g4/Sj76rmUXXdRjp5wmqdYzoLPnl8rClB?=
 =?us-ascii?Q?v3E/CxPP61e+M0cmbodaJjTA7ZuZTU5HpR7mdlVKaW8NqYaz9WeS3t6IGArJ?=
 =?us-ascii?Q?qeXrAr0CIg2VHLNpmoAk2pXmuu6MHr29r3D5uI3AlvDtovb703EZGkIOfLIv?=
 =?us-ascii?Q?6MseNQA3NGSUZYRZTfx42dDJyHGh8+jxeY/3MxaEIa58/446TghC7JHpxZMk?=
 =?us-ascii?Q?0dBJtV497QJRU1Gc48P91tx2Ysici6u20ECKDbnOdMJwvWD8o0Jr2FW513XJ?=
 =?us-ascii?Q?Sa0MaG2HXkTHgRbECMScNQQKuzBhvSUIDpCXwvcMRfcL6C1FzX+LGTSjMMQr?=
 =?us-ascii?Q?4lVmGQILmMh3/TYihS0MyNA0/ej61vmpKeQq8sn9jk8HHjQ273kyL4kEwuFL?=
 =?us-ascii?Q?sj044WXPzKa5oXAcLxWSs70IztWXJBbi7fSLkk705kom5q7RoJXcT1/oYSKh?=
 =?us-ascii?Q?TP281FJqSvvs8DIRhWX2TOBMOU4fSpsR8T+VKCAcUWFIUaw0KSSYgCeVe4aT?=
 =?us-ascii?Q?RzGmPHzAe3DrEHjMXaGRN578B4o6mIJ1Mq1lsWNPiFNwPIiQvfcWlnlncczb?=
 =?us-ascii?Q?0ZVJUHDYvmPuPkCgvJMLKBb2cYTljaa1F1f7HTSEEVbvacc1Qhrd4MBeFQLE?=
 =?us-ascii?Q?t++DzBAVZ49tCUyWZSbemg5cmUNHgZekgDsdeQw4Y25J1yfymu7QqEfTkzdU?=
 =?us-ascii?Q?Y/xRrtFWVP0LJ/0fAtcvupGfHpMlYyrLk/3yIGcF5jcZfqJlbnO5faocM2rb?=
 =?us-ascii?Q?MsNN27MWoNE+VtMI+3KZMm3S9UirdV5u0ZKZIQdagIpqXSsTO8FFOUxhyCXg?=
 =?us-ascii?Q?QUzfN11EUPUelGbfY/xzFh3XnOb0iyT4GHgI1RRBAJ6iE1ik+k/QbXhAdYQV?=
 =?us-ascii?Q?8ZKEp2bj/NjOskp2GcwNuwBAuvSLAkOeHMO9TvSypxEM0AQfqiS67JrsVCCs?=
 =?us-ascii?Q?94wjehlcMLj5McMyOERzMiiMxs9CQXq5icSxrxsRfetUeWwtSGT/tl3pUuWg?=
 =?us-ascii?Q?KrT9sDflMwz2PEvHfVn44WiyBO5NKcyw3RqMRBNuRbs/Sexcd/D59Il/ZvUf?=
 =?us-ascii?Q?X55Qp2VBhDwkIpKI/9BVPfHkC9WLX14QTQYHpXse6HfaHOqP9vYiJzM7jnR0?=
 =?us-ascii?Q?nyCJKysYSkL0Yq94UAKkopOO068IzjS4UuXUb/mSJEmpcTmiBUZHFdAMLHbe?=
 =?us-ascii?Q?M4bfZhOodVv86tD1KeVVDCeEwoXNyA7Ojk/i+aS/eEeDhYGh0QZHjAYuOAPF?=
 =?us-ascii?Q?yGeVRBrqFw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f47f9523-e3e5-48cf-57e8-08de60179473
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 15:52:32.6464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rXBMAloEkXW9YvfCUd7a/8wzXZ5vIEb4fvDNmdiiVXCCmfOfXT1uG45u1k/NeuoPhAiwAMrBGg6lLbpucw5kvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10809
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8626-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,ti.com:email]
X-Rspamd-Queue-Id: 9EFEBBC3F0
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 04:31:46PM +0530, Sai Sree Kartheek Adivi wrote:
> Introduce function pointers in the udma_dev structure to allow
> variant-specific implementations for certain operations.
> This prepares the driver for supporting multiple K3 UDMA variants,
> such as UDMA v2, with minimal code duplication.
>
> No functional changes intended in this commit.
>
> Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>
>  drivers/dma/ti/k3-udma-private.c | 10 +++++--
>  drivers/dma/ti/k3-udma.c         | 46 +++++++++++++++++++-------------
>  drivers/dma/ti/k3-udma.h         | 12 +++++++++
>  3 files changed, 47 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/dma/ti/k3-udma-private.c b/drivers/dma/ti/k3-udma-private.c
> index 624360423ef17..44c097fff5ee6 100644
> --- a/drivers/dma/ti/k3-udma-private.c
> +++ b/drivers/dma/ti/k3-udma-private.c
> @@ -8,13 +8,19 @@
>
>  int xudma_navss_psil_pair(struct udma_dev *ud, u32 src_thread, u32 dst_thread)
>  {
> -	return navss_psil_pair(ud, src_thread, dst_thread);
> +	if (ud->psil_pair)
> +		return ud->psil_pair(ud, src_thread, dst_thread);
> +
> +	return 0;
>  }
>  EXPORT_SYMBOL(xudma_navss_psil_pair);
>
>  int xudma_navss_psil_unpair(struct udma_dev *ud, u32 src_thread, u32 dst_thread)
>  {
> -	return navss_psil_unpair(ud, src_thread, dst_thread);
> +	if (ud->psil_unpair)
> +		return ud->psil_unpair(ud, src_thread, dst_thread);
> +
> +	return 0;
>  }
>  EXPORT_SYMBOL(xudma_navss_psil_unpair);
>
> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> index 214a1ca1e1776..397e890283eaa 100644
> --- a/drivers/dma/ti/k3-udma.c
> +++ b/drivers/dma/ti/k3-udma.c
> @@ -40,7 +40,7 @@ static const char * const mmr_names[] = {
>  	[MMR_TCHANRT] = "tchanrt",
>  };
>
> -static int navss_psil_pair(struct udma_dev *ud, u32 src_thread, u32 dst_thread)
> +int navss_psil_pair(struct udma_dev *ud, u32 src_thread, u32 dst_thread)
>  {
>  	struct udma_tisci_rm *tisci_rm = &ud->tisci_rm;
>
> @@ -50,8 +50,8 @@ static int navss_psil_pair(struct udma_dev *ud, u32 src_thread, u32 dst_thread)
>  					      src_thread, dst_thread);
>  }
>
> -static int navss_psil_unpair(struct udma_dev *ud, u32 src_thread,
> -			     u32 dst_thread)
> +int navss_psil_unpair(struct udma_dev *ud, u32 src_thread,
> +		      u32 dst_thread)
>  {
>  	struct udma_tisci_rm *tisci_rm = &ud->tisci_rm;
>
> @@ -329,7 +329,7 @@ static int udma_start(struct udma_chan *uc)
>  	}
>
>  	/* Make sure that we clear the teardown bit, if it is set */
> -	udma_reset_chan(uc, false);
> +	uc->ud->reset_chan(uc, false);
>
>  	/* Push descriptors before we start the channel */
>  	udma_start_desc(uc);
> @@ -521,8 +521,8 @@ static void udma_check_tx_completion(struct work_struct *work)
>  		if (uc->desc) {
>  			struct udma_desc *d = uc->desc;
>
> -			udma_decrement_byte_counters(uc, d->residue);
> -			udma_start(uc);
> +			uc->ud->decrement_byte_counters(uc, d->residue);
> +			uc->ud->start(uc);
>  			vchan_cookie_complete(&d->vd);
>  			break;
>  		}
> @@ -554,7 +554,7 @@ static irqreturn_t udma_ring_irq_handler(int irq, void *data)
>  		}
>
>  		if (!uc->desc)
> -			udma_start(uc);
> +			uc->ud->start(uc);
>
>  		goto out;
>  	}
> @@ -576,8 +576,8 @@ static irqreturn_t udma_ring_irq_handler(int irq, void *data)
>  				vchan_cyclic_callback(&d->vd);
>  			} else {
>  				if (udma_is_desc_really_done(uc, d)) {
> -					udma_decrement_byte_counters(uc, d->residue);
> -					udma_start(uc);
> +					uc->ud->decrement_byte_counters(uc, d->residue);
> +					uc->ud->start(uc);
>  					vchan_cookie_complete(&d->vd);
>  				} else {
>  					schedule_delayed_work(&uc->tx_drain.work,
> @@ -612,8 +612,8 @@ static irqreturn_t udma_udma_irq_handler(int irq, void *data)
>  			vchan_cyclic_callback(&d->vd);
>  		} else {
>  			/* TODO: figure out the real amount of data */
> -			udma_decrement_byte_counters(uc, d->residue);
> -			udma_start(uc);
> +			uc->ud->decrement_byte_counters(uc, d->residue);
> +			uc->ud->start(uc);
>  			vchan_cookie_complete(&d->vd);
>  		}
>  	}
> @@ -1654,7 +1654,7 @@ static int udma_alloc_chan_resources(struct dma_chan *chan)
>
>  	if (udma_is_chan_running(uc)) {
>  		dev_warn(ud->dev, "chan%d: is running!\n", uc->id);
> -		udma_reset_chan(uc, false);
> +		ud->reset_chan(uc, false);
>  		if (udma_is_chan_running(uc)) {
>  			dev_err(ud->dev, "chan%d: won't stop!\n", uc->id);
>  			ret = -EBUSY;
> @@ -1821,7 +1821,7 @@ static int bcdma_alloc_chan_resources(struct dma_chan *chan)
>
>  	if (udma_is_chan_running(uc)) {
>  		dev_warn(ud->dev, "chan%d: is running!\n", uc->id);
> -		udma_reset_chan(uc, false);
> +		ud->reset_chan(uc, false);
>  		if (udma_is_chan_running(uc)) {
>  			dev_err(ud->dev, "chan%d: won't stop!\n", uc->id);
>  			ret = -EBUSY;
> @@ -2014,7 +2014,7 @@ static int pktdma_alloc_chan_resources(struct dma_chan *chan)
>
>  	if (udma_is_chan_running(uc)) {
>  		dev_warn(ud->dev, "chan%d: is running!\n", uc->id);
> -		udma_reset_chan(uc, false);
> +		ud->reset_chan(uc, false);
>  		if (udma_is_chan_running(uc)) {
>  			dev_err(ud->dev, "chan%d: won't stop!\n", uc->id);
>  			ret = -EBUSY;
> @@ -2123,7 +2123,7 @@ static void udma_issue_pending(struct dma_chan *chan)
>  		 */
>  		if (!(uc->state == UDMA_CHAN_IS_TERMINATING &&
>  		      udma_is_chan_running(uc)))
> -			udma_start(uc);
> +			uc->ud->start(uc);
>  	}
>
>  	spin_unlock_irqrestore(&uc->vc.lock, flags);
> @@ -2265,7 +2265,7 @@ static int udma_terminate_all(struct dma_chan *chan)
>  	spin_lock_irqsave(&uc->vc.lock, flags);
>
>  	if (udma_is_chan_running(uc))
> -		udma_stop(uc);
> +		uc->ud->stop(uc);
>
>  	if (uc->desc) {
>  		uc->terminated_desc = uc->desc;
> @@ -2297,11 +2297,11 @@ static void udma_synchronize(struct dma_chan *chan)
>  			dev_warn(uc->ud->dev, "chan%d teardown timeout!\n",
>  				 uc->id);
>  			udma_dump_chan_stdata(uc);
> -			udma_reset_chan(uc, true);
> +			uc->ud->reset_chan(uc, true);
>  		}
>  	}
>
> -	udma_reset_chan(uc, false);
> +	uc->ud->reset_chan(uc, false);
>  	if (udma_is_chan_running(uc))
>  		dev_warn(uc->ud->dev, "chan%d refused to stop!\n", uc->id);
>
> @@ -2355,7 +2355,7 @@ static void udma_free_chan_resources(struct dma_chan *chan)
>
>  	udma_terminate_all(chan);
>  	if (uc->terminated_desc) {
> -		udma_reset_chan(uc, false);
> +		ud->reset_chan(uc, false);
>  		udma_reset_rings(uc);
>  	}
>
> @@ -3694,6 +3694,14 @@ static int udma_probe(struct platform_device *pdev)
>  		ud->soc_data = soc->data;
>  	}
>
> +	// Setup function pointers
> +	ud->start = udma_start;
> +	ud->stop = udma_stop;
> +	ud->reset_chan = udma_reset_chan;
> +	ud->decrement_byte_counters = udma_decrement_byte_counters;
> +	ud->psil_pair = navss_psil_pair;
> +	ud->psil_unpair = navss_psil_unpair;
> +
>  	ret = udma_get_mmrs(pdev, ud);
>  	if (ret)
>  		return ret;
> diff --git a/drivers/dma/ti/k3-udma.h b/drivers/dma/ti/k3-udma.h
> index 4c6e5b946d5cf..2f5fbea446fed 100644
> --- a/drivers/dma/ti/k3-udma.h
> +++ b/drivers/dma/ti/k3-udma.h
> @@ -344,6 +344,15 @@ struct udma_dev {
>  	u32 psil_base;
>  	u32 atype;
>  	u32 asel;
> +
> +	int (*start)(struct udma_chan *uc);
> +	int (*stop)(struct udma_chan *uc);
> +	int (*reset_chan)(struct udma_chan *uc, bool hard);
> +	void (*decrement_byte_counters)(struct udma_chan *uc, u32 val);
> +	int (*psil_pair)(struct udma_dev *ud, u32 src_thread,
> +			 u32 dst_thread);
> +	int (*psil_unpair)(struct udma_dev *ud, u32 src_thread,
> +			   u32 dst_thread);
>  };
>
>  struct udma_desc {
> @@ -614,6 +623,9 @@ int udma_push_to_ring(struct udma_chan *uc, int idx);
>  int udma_pop_from_ring(struct udma_chan *uc, dma_addr_t *addr);
>  void udma_reset_rings(struct udma_chan *uc);
>
> +int navss_psil_pair(struct udma_dev *ud, u32 src_thread, u32 dst_thread);
> +int navss_psil_unpair(struct udma_dev *ud, u32 src_thread, u32 dst_thread);
> +
>  /* Direct access to UDMA low lever resources for the glue layer */
>  int xudma_navss_psil_pair(struct udma_dev *ud, u32 src_thread, u32 dst_thread);
>  int xudma_navss_psil_unpair(struct udma_dev *ud, u32 src_thread,
> --
> 2.34.1
>

