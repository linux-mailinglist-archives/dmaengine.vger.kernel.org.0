Return-Path: <dmaengine+bounces-8764-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCJmFQ7BhGnG4wMAu9opvQ
	(envelope-from <dmaengine+bounces-8764-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 05 Feb 2026 17:10:54 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F94F504A
	for <lists+dmaengine@lfdr.de>; Thu, 05 Feb 2026 17:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B77633005303
	for <lists+dmaengine@lfdr.de>; Thu,  5 Feb 2026 16:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9F342980C;
	Thu,  5 Feb 2026 16:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fexYTJSi"
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013037.outbound.protection.outlook.com [40.107.159.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13FD31B824;
	Thu,  5 Feb 2026 16:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770307848; cv=fail; b=KAZ27N5Xg8wojulDEEYPIZAExiWq3ETAzjkCfC0Ge+CCN4S3VactP1riwZkEQd1szqYfJwfIROkvHA1kXrR25d2b7Bl5El70Cc2CzI8UlvBTvVQAsi0LYxVzq6lHmxOw3f5jAmPaHYibljtAxs6aXOBjTzSmluPKaFhsvBw2bLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770307848; c=relaxed/simple;
	bh=13DFrzSGBciGx0RTjBGVTf2GDL9U9Lj+RCThkF/fIig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c4+3Ho8Nt0RMGXgTB2NOu15Z31CHptswQtZH4GYipl+ximSwnWOjgQmJrxfQlXOAyxFYJkjAbHe5h40xIrGcsTqmmBtRZTMF6i6S8YuYbKrcGdBxx5I+FqcGgdy3O2gEyANyAIIr49kjeFZDjeRFXZ8ExLsXuzAtWxA+pfvTLus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fexYTJSi; arc=fail smtp.client-ip=40.107.159.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y6aMWJgtHnJtRfcX0NyEoxPJwfXjMMWk5YvqVInksv6D1XJQczKGD0YDYRYlPA4XyS+RdFlAaQYW6NtRpWSqOkr2EUOrqQSfMDdW79CICR8/ltc3rMu2S5RGiXjzfNOpY/2bYM8aaAedBtuAsm5FtjkO5sCqNK7xAPId3YZNlvTxbiCAumgifGNPD14FE6YZ8t3yW2ebwCp9nn5kuIiP1maoaecpw7ffBwhRz7GVkVwIYJ8/+kVeanB+Ik5DZd9sbfxlhY3ish8f8IZRxZMpkmvexIiid4LyMEcXMOli/mYbKFC7s+yhcbaoCmWvd0wDxyjvN0uF+peKpLr4s3vcZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4xt98E39occDCwpve5qgkusSchRPHB/z+PUbuv1iDw=;
 b=blpZmTfMxIv/NA0XfN2sjFhKuFD46kWjO6wpB5tqrXVs+j7t2uA5a0j2ZhdhvaIzeJmUP6S5UmhvWgwiKAqWohv+sq123j6p5jqWyJBqw+ZZb3sMC1uDsmonQxz1xrZcOU6oHr5CeE5cAn87bEsn0d9ZcKRp42cBefLOgzQsWWJIKP/q229IoQ/MZVfCAVCUb1c/sf6uc68NX1eKCHTsmkxFp4ZKBoI7xGqtdcvPHg2GjdWvhT5NTXfoTG2H2NVpOpnqn6JrGfwncAIjqPH0LhUT2dIUAPiQGe3nKO76hIeUfH+iZLuu1tJpi1KV0Fj5PCZAH6X5QUfvxYYWes333Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4xt98E39occDCwpve5qgkusSchRPHB/z+PUbuv1iDw=;
 b=fexYTJSi0eCGCQX77fuuHcBeehT5dBoLZ1Dip+jicv/qHxjhEmtyKl3VDLSHZATZws4CshFzeMd0YZOJSjlO/c4/J62pNn1DokOQt/Pe54R2YsCMDXVQAsgdfR/T+lhRfhD+7/+dyAPYqzsLcIVvzBZE9XOw5KY/tidPfntlBKv1dTwL5F6DZWSDEfXvTQ2mN7uidX+EEtk4FgcUwNpWkOZHks6ah5PuL7CUqwldcwp7Xzfq3ysUxu40REOjEVD/NRtsXTL/m9c2dOIT65Qld2oAd68atYYhnEBKrvkzVjEKdzp+EMQjd3D+OwVQfMT8om0+xhMli3eBsdtov16xIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DBBPR04MB7769.eurprd04.prod.outlook.com (2603:10a6:10:1e0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 5 Feb
 2026 16:10:43 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9587.010; Thu, 5 Feb 2026
 16:10:43 +0000
Date: Thu, 5 Feb 2026 11:10:35 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: vkoul@kernel.org, mani@kernel.org, jingoohan1@gmail.com,
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org,
	bhelgaas@google.com, dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 06/11] PCI: endpoint: Add remote resource query API
Message-ID: <aYTA-671yVanQdo_@lizhi-Precision-Tower-5810>
References: <20260204145440.950609-1-den@valinux.co.jp>
 <20260204145440.950609-7-den@valinux.co.jp>
 <aYOILtPYxazppfRD@lizhi-Precision-Tower-5810>
 <dmbz4qealzaiqvmmb4fcvsnkymmcm4qoxn5lsp2h4jal4cpmsv@hdfyd7evbr74>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dmbz4qealzaiqvmmb4fcvsnkymmcm4qoxn5lsp2h4jal4cpmsv@hdfyd7evbr74>
X-ClientProxiedBy: PH8PR15CA0001.namprd15.prod.outlook.com
 (2603:10b6:510:2d2::13) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DBBPR04MB7769:EE_
X-MS-Office365-Filtering-Correlation-Id: 55337f75-ef76-4e08-24db-08de64d11d16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|7416014|1800799024|19092799006|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3a4F3f0LX53WLPRHRVqcQ2SHCCnM0YeX87QpVl8esqXDPoicB3ogYFz+gDPv?=
 =?us-ascii?Q?cdy5PUXj8epwizlq6FXjMxx1HNPfKBC5aCRHt2VlasUgbqHDSvWebmk0GdFm?=
 =?us-ascii?Q?tZMe54dTlrxzjonXZD1MHsVs1RzmlXFqyAhxTh/qnM+t4cWRejnFWPU56IGv?=
 =?us-ascii?Q?mD0ibthcbjzo7cJan2ua/hrj4naUjgN9Le5UgzUMrRuOKdM//8xZASjiy+4d?=
 =?us-ascii?Q?j1b4DNzhgSWsLqCi0bLmSyIuXsn2oVX6iLETXgnbH+wj19p4k8OE0FSJa340?=
 =?us-ascii?Q?BCrnpIzSRZ10w2N4GGsL/+hjz8LBhYfnUBVk9/ilr7IEOAilkwW/s+blYVvw?=
 =?us-ascii?Q?NxEa5O2arhVqJ/7QSFkiofSz2ngAeqah2RCXK/CBOCTTAfM/xWpIh6tSxZMg?=
 =?us-ascii?Q?2vcuFp0M5AIQKP7lQO2lnHWHbpl6AYOKBTRIBiqGtZziWN2azp6VD+dG+zTw?=
 =?us-ascii?Q?y/EUCknKR36ynWq88Uu4iSH30amqD/2p7nAGYyz7UCE5c8o7OsYwpJnqv5Jy?=
 =?us-ascii?Q?aiOES8q9uRg/3uW/22XmSwDx3CsBf3BEYvTmpRc/COuYi4ZN6xlefVIMI+0X?=
 =?us-ascii?Q?UqjxshBcq1obq6x2qNtBQVzfvpSxUEcS4FrPcZpnXGbqLDwMyMuYJKKleJ6v?=
 =?us-ascii?Q?aQq6JBwPrnR7TYN81EtGhUkTKUaDTcAZVJ/TWfaCirq2bvuNaQP4Moo1TtBo?=
 =?us-ascii?Q?XM+YaaderecI3a/rk0I9I0v5+dkzUPU2XSwuya4tR6Bl4PvB2Ss2tGH2Sc2R?=
 =?us-ascii?Q?TzduC5H2bJWYtEIULJ0FYwdZ05+BGxZ0ZWuKbg0qaMOiXIOIqsht3ou2/vy5?=
 =?us-ascii?Q?RBtDMPx7eu9eZehHRtqEC4wZXPjP9MEbHpisrvb3NEny36Iz2kXkqa5c5gKp?=
 =?us-ascii?Q?4oPGRmIm0NBZ5XWhT7MRwtPXQwUHUZaPLxEclqqaCnNERdedlkHVgIPZDj7w?=
 =?us-ascii?Q?Me2Odoci6oPgxkLE8UbBbSkeaf2RjOTzKgrHnUNJ6AvdRdrBECUcSrbCrOJA?=
 =?us-ascii?Q?l+RgHC/SsOm1sOl5cQVSBkuxhHZ1+6eA2JQtT77uixJ0HHO4iiAZzsCLtjQl?=
 =?us-ascii?Q?W2w+Yqw6/rI1JKOuCyHreFjxEiyb4OdAixlOVwvb/6jHNoijaY65PPRbQOCk?=
 =?us-ascii?Q?kT8uyjB3LKEKuokazJIJdNwDgpCiUzsRF2bqkfhcm++3u2ZsQmKnAjq+Yydl?=
 =?us-ascii?Q?TEz1cSZ76fEJjDi8xErihQc50BuIcOrKFrcY4Kt2Cawl58EagDGYnOY2sX2T?=
 =?us-ascii?Q?6hJ45bDd5KCtIF7vlAEcm+LHWSFGD1Axo4OHVAlpLGlR80/3IRppkWE0yLeO?=
 =?us-ascii?Q?U/lcEMM43A2PZ4rcBPaEp3hd2neTuUnFpV7njIdDSJzV03XetupsZN7XdIP2?=
 =?us-ascii?Q?B/K7XtjsAOECoSA+iOLMFSBdSgvTfHudkc+Y7Q2fYI6dYgaj0ZjCCBHzGKl3?=
 =?us-ascii?Q?SCFVVRJNgjatnQkn15K++XSVS64MzN5Ypm2YxsaU3iLGEY6fOnaP0wGyFhix?=
 =?us-ascii?Q?VovtIF9kEHzXAFSoObeIZY7akiTeYNOS28h9Iffyo/1ByLJ38PEW1ayZeV/1?=
 =?us-ascii?Q?V4CQhE6hWaahewKnyE8z8hr2WeEzO9/KDhcNP0t/6kaCP4VWcofvO3e4aEuP?=
 =?us-ascii?Q?ICGKt4uj6ZAiCy+GTxGkMag=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(19092799006)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G6kPf78++WHSFbQ9iWRw+IR97sQ6W5iqdaWs5qe/WidW1lf1piPB/0oEuGyT?=
 =?us-ascii?Q?56NZ6ucUprupAH/rCCdXCMB4ZgWvf+RSHXjuablE578R77zDvcIBzqFJsP3V?=
 =?us-ascii?Q?ZhDVOlJ4Q5w6ouRaFTiQJ1wKP44ZhCk06y+gQwTC5C1SM8kzKZuat74Xqbvz?=
 =?us-ascii?Q?bGv5V8KclrsWZo5HWVt6dYME7xmJ0BAG00UdJf9Y+i/F6ybe2qSxjppvZVUR?=
 =?us-ascii?Q?BKShNCVsMJGsdWlejxZCJqeiVRDLP/qRUFe7OGHygxqc2NwLQbIqDct7c75r?=
 =?us-ascii?Q?ujwhQY7UbKLsDWdlKyMrSEE8yPn8FXwRSDA0/xU4IyUY4XCFxm7EMVRGQbKn?=
 =?us-ascii?Q?lMtljZZKmdOOKszEZyI9+sGVHxUHeG6oWbVDUm/vF6V0rHiwfDhgQRdEkoA9?=
 =?us-ascii?Q?X7yKeTDRxUruug4kcj15zOI0oFZpqksz6pY/BNJ4/qz4Kryyv28TL5sQXXwy?=
 =?us-ascii?Q?Hlk1AwN8aqZpey2OphHL2hCZ+kkF92MdBHd2Sj7QaiNr8dpTY1TaZqKJ33Tb?=
 =?us-ascii?Q?KaYyqpeGxyadSuevwkc5HzvNYGKB6+dQPou0j2+MJXlUoP7D21ypTislZmpV?=
 =?us-ascii?Q?o3jEeGp8xvYv7J1M3R8ZtjEXHeYjoUhCgUaHr6KBkllhF91clC0a4CFvSW48?=
 =?us-ascii?Q?vYfjjefQdNGv8mZUrRRylzFvI5uz8GWpMNaEX25/1vW5sW3wXG4NaTYrarav?=
 =?us-ascii?Q?ENBxcZs0xn+RNrdGTsyzBg6xXNKMX/jEO7KYbW7WGJgg5RnQtC8po0qAj4ww?=
 =?us-ascii?Q?Q/CU1ifXEMh+KxYI1snS9jHr9wBe7kY2bm2OrlKvCIRNK1vh0fCd1r+a84bc?=
 =?us-ascii?Q?gENeL2vAodZlVPSpLqNt+GqlidNQtXDyPCGNBTDSzxh5QQRrSxszHSliLlch?=
 =?us-ascii?Q?dUgqpjApa1JNT7Mv3Xh0UI3xmiY+rT2G/nEWM7Gsl1Z5vQRI3ftDWYAuLWPd?=
 =?us-ascii?Q?eYhtdmVLDKe3kLKK4arDaWGFBxCIItPmSgFyxPl9A4ZMPvZzDWy3bnwf/Lml?=
 =?us-ascii?Q?PdaX1C7rFrvt7EtChJwb0phdf1h2xjWw8gTk+MwMY9slcyI2yiVy6kxWXZOD?=
 =?us-ascii?Q?x1yKMBSXxrlAlHob2tlftCZD1kT0AvWuYkFPO+LqsiwQMxfroPfE4Xsjuv8w?=
 =?us-ascii?Q?biU20PCiEDT6U76qNPpDLWFMrHQ0ooqiJ0JLfhOzA0JjTWNwuEweYfVUL/g2?=
 =?us-ascii?Q?+j3Z9efjvp1WohZev0CMi0Fj8lnh/CoEosTfdRnRqynuwXlNPdD04BDlQp0h?=
 =?us-ascii?Q?O+xXiyhU9XCwdw6+Hxo643tnDb7xjcyvarNRDCBpI5eZu5wN8fRE+UWb4eKh?=
 =?us-ascii?Q?a/Auy+tINFcJH16Eei8E0RgvWCBJV5Qzp9+fMRXQTBLhaMy4buP6q6DK4Pux?=
 =?us-ascii?Q?gG/6fDt9GgUGOKr/qsqCzSNTRM5JbUcO9WrWsDDK3PBOQlhpn3T5jZvOTBxu?=
 =?us-ascii?Q?f7D+EKlATl9PXrJEqnR0wGARgMhy6+j2YHoe9usDVqS5OlsQ4XAWZ3HGgj5O?=
 =?us-ascii?Q?udIasgTUOJdyczMsVGHg7De3bCv5hptpieth06oYLABvaQBbLPSoojjiMiRc?=
 =?us-ascii?Q?HynrQ5EU4qf+/kXiSI6ZLcj0yjvx6Bgi3vQyJhgCuRst1R3HJXJnGCXd05sm?=
 =?us-ascii?Q?OFL5J8isal4NLFxJHO7eDsoN/e6Kam1ozBq7pmsPVeBj5GsxD8qgcIUcoBKQ?=
 =?us-ascii?Q?8/O34r6/UJID7Ww5lj65TmLWFZb/koH+5M3loxtnuwv0pNDYsO9Tphthl44q?=
 =?us-ascii?Q?oskpS51soA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55337f75-ef76-4e08-24db-08de64d11d16
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 16:10:43.3759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YYdnajbCJViJnzjqVgcjAEweooLJ6wn57JcPBi75oL+4jaUKEcSy0noivWYKjfKx42kPPZL6X/vHWeD2SyFS/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7769
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,google.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8764-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,valinux.co.jp:email]
X-Rspamd-Queue-Id: 63F94F504A
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 03:53:52PM +0900, Koichiro Den wrote:
> On Wed, Feb 04, 2026 at 12:55:58PM -0500, Frank Li wrote:
> > On Wed, Feb 04, 2026 at 11:54:34PM +0900, Koichiro Den wrote:
> > > Endpoint controller drivers may integrate auxiliary blocks (e.g. DMA
> > > engines) whose register windows and descriptor memories metadata need to
> > > be exposed to a remote peer. Endpoint function drivers need a generic
> > > way to discover such resources without hard-coding controller-specific
> > > helpers.
> > >
> > > Add pci_epc_get_remote_resources() and the corresponding pci_epc_ops
> > > get_remote_resources() callback. The API returns a list of resources
> > > described by type, physical address and size, plus type-specific
> > > metadata.
> > >
> > > Passing resources == NULL (or num_resources == 0) returns the required
> > > number of entries.
> > >
> > > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > > ---
> > >  drivers/pci/endpoint/pci-epc-core.c | 41 +++++++++++++++++++++++++
> > >  include/linux/pci-epc.h             | 46 +++++++++++++++++++++++++++++
> > >  2 files changed, 87 insertions(+)
> > >
> > > diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> > > index 068155819c57..fa161113e24c 100644
> > > --- a/drivers/pci/endpoint/pci-epc-core.c
> > > +++ b/drivers/pci/endpoint/pci-epc-core.c
> > > @@ -155,6 +155,47 @@ const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
> > >  }
> > >  EXPORT_SYMBOL_GPL(pci_epc_get_features);
> > >
> > > +/**
> > > + * pci_epc_get_remote_resources() - query EPC-provided remote resources
> > > + * @epc: EPC device
> > > + * @func_no: function number
> > > + * @vfunc_no: virtual function number
> > > + * @resources: output array (may be NULL to query required count)
> > > + * @num_resources: size of @resources array in entries (0 when querying count)
> > > + *
> > > + * Some EPC backends integrate auxiliary blocks (e.g. DMA engines) whose control
> > > + * registers and/or descriptor memories can be exposed to the host by mapping
> > > + * them into BAR space. This helper queries the backend for such resources.
> > > + *
> > > + * Return:
> > > + *   * >= 0: number of resources returned (or required, if @resources is NULL)
> > > + *   * -EOPNOTSUPP: backend does not support remote resource queries
> > > + *   * other -errno on failure
> > > + */
> > > +int pci_epc_get_remote_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> > > +				 struct pci_epc_remote_resource *resources,
> > > +				 int num_resources)
> > > +{
> > > +	int ret;
> > > +
> > > +	if (!epc || !epc->ops)
> > > +		return -EINVAL;
> > > +
> > > +	if (func_no >= epc->max_functions)
> > > +		return -EINVAL;
> > > +
> > > +	if (!epc->ops->get_remote_resources)
> > > +		return -EOPNOTSUPP;
> > > +
> > > +	mutex_lock(&epc->lock);
> > > +	ret = epc->ops->get_remote_resources(epc, func_no, vfunc_no,
> > > +					     resources, num_resources);
> > > +	mutex_unlock(&epc->lock);
> > > +
> > > +	return ret;
> > > +}
> > > +EXPORT_SYMBOL_GPL(pci_epc_get_remote_resources);
> > > +
> > >  /**
> > >   * pci_epc_stop() - stop the PCI link
> > >   * @epc: the link of the EPC device that has to be stopped
> > > diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> > > index c021c7af175f..af60d4ad2f0e 100644
> > > --- a/include/linux/pci-epc.h
> > > +++ b/include/linux/pci-epc.h
> > > @@ -61,6 +61,44 @@ struct pci_epc_map {
> > >  	void __iomem	*virt_addr;
> > >  };
> > >
> > > +/**
> > > + * enum pci_epc_remote_resource_type - remote resource type identifiers
> > > + * @PCI_EPC_RR_DMA_CTRL_MMIO: Integrated DMA controller register window (MMIO)
> > > + * @PCI_EPC_RR_DMA_CHAN_DESC: Per-channel DMA descriptor
> > > + *
> > > + * EPC backends may expose auxiliary blocks (e.g. DMA engines) by mapping their
> > > + * register windows and descriptor memories into BAR space. This enum
> > > + * identifies the type of each exposable resource.
> > > + */
> > > +enum pci_epc_remote_resource_type {
> > > +	PCI_EPC_RR_DMA_CTRL_MMIO,
> > > +	PCI_EPC_RR_DMA_CHAN_DESC,
> > > +};
> > > +
> > > +/**
> > > + * struct pci_epc_remote_resource - a physical resource that can be exposed
> > > + * @type:      resource type, see enum pci_epc_remote_resource_type
> > > + * @phys_addr: physical base address of the resource
> > > + * @size:      size of the resource in bytes
> > > + * @u:         type-specific metadata
> > > + *
> > > + * For @PCI_EPC_RR_DMA_CHAN_DESC, @u.dma_chan_desc provides per-channel
> > > + * information.
> > > + */
> > > +struct pci_epc_remote_resource {
> > > +	enum pci_epc_remote_resource_type type;
> > > +	phys_addr_t phys_addr;
> > > +	resource_size_t size;
> >
> > is it good use struct resource?
>
> Personally I don't think it's the best fit here, since these remote
> resources are not meant to participate in the global resource tree or
> managed by the resource management framework. And most of struct resource
> fields (name/flags and the links) does not make sense in this context.
>
> >
> > > +
> > > +	union {
> > > +		/* PCI_EPC_RR_DMA_CHAN_DESC */
> > > +		struct {
> > > +			u16 hw_chan_id;
> > > +			bool ep2rc;
> > > +		} dma_chan_desc;
> > > +	} u;
> > > +};
> > > +
> > >  /**
> > >   * struct pci_epc_ops - set of function pointers for performing EPC operations
> > >   * @write_header: ops to populate configuration space header
> > > @@ -84,6 +122,8 @@ struct pci_epc_map {
> > >   * @start: ops to start the PCI link
> > >   * @stop: ops to stop the PCI link
> > >   * @get_features: ops to get the features supported by the EPC
> > > + * @get_remote_resources: ops to retrieve controller-owned resources that can be
> > > + *			  exposed to the remote host (optional)
> >
> > Add comments, must set 'type' of pci_epc_remote_resource.
>
> Would something like the following address your concern?
>
>     * @get_remote_resources: ops to retrieve controller-owned resources that can be
>     *                        exposed to the remote host (optional)
>   + *                        The callback fills @resources (up to @num_resources entries)
>   + *                        and returns the number of valid entries. Each returned entry
>   + *                        must have @type set (which selects the valid union member in @u)
>   + *                        and provide valid @phys_addr/@sizei.

After I review your next patch, I understand API here. It is good.

Frank

>
> Thanks for the review,
> Koichiro
>
> >
> > Over all it is good.
> >
> > Frank
> > >   * @owner: the module owner containing the ops
> > >   */
> > >  struct pci_epc_ops {
> > > @@ -115,6 +155,9 @@ struct pci_epc_ops {
> > >  	void	(*stop)(struct pci_epc *epc);
> > >  	const struct pci_epc_features* (*get_features)(struct pci_epc *epc,
> > >  						       u8 func_no, u8 vfunc_no);
> > > +	int	(*get_remote_resources)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> > > +					struct pci_epc_remote_resource *resources,
> > > +					int num_resources);
> > >  	struct module *owner;
> > >  };
> > >
> > > @@ -309,6 +352,9 @@ int pci_epc_start(struct pci_epc *epc);
> > >  void pci_epc_stop(struct pci_epc *epc);
> > >  const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
> > >  						    u8 func_no, u8 vfunc_no);
> > > +int pci_epc_get_remote_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> > > +				 struct pci_epc_remote_resource *resources,
> > > +				 int num_resources);
> > >  enum pci_barno
> > >  pci_epc_get_first_free_bar(const struct pci_epc_features *epc_features);
> > >  enum pci_barno pci_epc_get_next_free_bar(const struct pci_epc_features
> > > --
> > > 2.51.0
> > >

