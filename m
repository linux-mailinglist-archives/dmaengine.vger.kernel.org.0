Return-Path: <dmaengine+bounces-8413-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4J14Hc0ucGkEXAAAu9opvQ
	(envelope-from <dmaengine+bounces-8413-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 02:41:33 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3A84F3DD
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 02:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CEB15B0AB94
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 01:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F9E30F943;
	Wed, 21 Jan 2026 01:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="d2oCPMVZ"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021121.outbound.protection.outlook.com [52.101.125.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7C530BF5D;
	Wed, 21 Jan 2026 01:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768959686; cv=fail; b=R36e82VE9yoznZQWzGrWtyZRHWN3eawAFbt+Ijwb0ZaQmAFjANLVhsaqg+v2exKPK+1cGRUacr8hDq4lKpBy4+JN9s1rolru5U/qTPCsCINr3LCA/vCMuKlHCf4QTE9k0zwnbSNR2/6kaXJ14lD4OSRfCi97pMHn+u0NY6FCarw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768959686; c=relaxed/simple;
	bh=1fC7dIoBbCSiidqdkeXWv9Mwxj0hPBBKsI58rJaAzbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mOGA6QuJKczMTvtZ/QGCh+gkg+neZaWtobL49iS+dIydACpvUqg9A0xHnPcncvahvGnqs6DrZQA5lu5GdHzhVvxbsE1+IMvqEtX+jSWAJ7e7c5zX/zLLPBYzUdmB1SzVxFCwSBiA8uoV5Zbehkkj7GzyfORQjm7k16O7e1VWXzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=d2oCPMVZ; arc=fail smtp.client-ip=52.101.125.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mi7YyweMwxvymEvPPqey+qSnY0KKXRzVRDmTwcxbOigqcCpms9LzAgZMVdT3wBj81mSXrgG4OTaTaZVAer5YsXXXTJBe0CyZY20WfdH7Iud7Mqrrcga9QSIbdTgXTM9BiizWRbm+1CHcgHulZ+eBFPKkBaSsrVxVzDVHOHrMIpxvQry+YF57YbyfAACcIQjAZMCKhlBNKkVCO2WlAXNhfjdgNVhLHJMFqjB0RdDGdaLKY5/DWBF3S2vjSZk+vaupQemNvT/UopiqCMRupl7R5WB3t6zMAiOYU1zYC8fdzkRCBgfIlwWqZ4/TqUVQs0P5JGHmIZ3mOYWKWi1d4n8Ibw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xCKs1v4PfAYVqd0YVe8W3A91+JtyJ3F8ZUVWRcd7zuk=;
 b=qf2aUCOqqHugjZhPaPjI7reVv5Qv7/qHVacx3I95p0X/NNV5xJKzpXyCDZZWJIc35HvoEZDcRZbo/Z58iPV8mosR3oFLFGkpDJ9x2pa8H98ovo7c76SbTAS9TJ85ZBMBICB+WNAmvfjQ2CP0gANHm7aCGAewdbO6hxJ0Qg2xcDKSaItkb4p6S2QbsYG8xCdMwOe0mXOghstYuYRYEwDmKGeElH0nz9K+O0ilLAENez6/SD7e2B9Nq393OPr/bR1hH1oVZSNbPL5nW4W9hw5rGIC4hpFjylzCblSUcPP+VeE8rekl3qc8rGBPeVzZ95sZalQlr+bCMChho470xJM3bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xCKs1v4PfAYVqd0YVe8W3A91+JtyJ3F8ZUVWRcd7zuk=;
 b=d2oCPMVZ+MJ9FkPKNldQa6ni+MpHjrqs2EqW6O1PQZy+noEJFVO2KM+VQLEOynclyOGH8TgLNHretG35Y7T7fYg4007pr1tf+hfWLx3xHnhmqPmscb/XBScgwogEydlzDiRePKRSJ8aQ8kPKrTFJl9xDJ2YboFuSrkfXbTsU0fQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY3P286MB3603.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 01:41:11 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 01:41:11 +0000
Date: Wed, 21 Jan 2026 10:41:10 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@nxp.com>
Cc: dave.jiang@intel.com, cassel@kernel.org, mani@kernel.org, 
	kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com, geert+renesas@glider.be, 
	robh@kernel.org, vkoul@kernel.org, jdmason@kudzu.us, allenbh@gmail.com, 
	jingoohan1@gmail.com, lpieralisi@kernel.org, linux-pci@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, dmaengine@vger.kernel.org, iommu@lists.linux.dev, 
	ntb@lists.linux.dev, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	arnd@arndb.de, gregkh@linuxfoundation.org, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, magnus.damm@gmail.com, krzk+dt@kernel.org, conor+dt@kernel.org, 
	corbet@lwn.net, skhan@linuxfoundation.org, andriy.shevchenko@linux.intel.com, 
	jbrunet@baylibre.com, utkarsh02t@gmail.com
Subject: Re: [RFC PATCH v4 08/38] NTB: epf: Provide
 db_vector_count/db_vector_mask callbacks
Message-ID: <lem6nqeaoy5hzfwxfqxdbfeftlrorrk4vgqqekm7lt5slggkud@zlwmk6radnng>
References: <20260118135440.1958279-1-den@valinux.co.jp>
 <20260118135440.1958279-9-den@valinux.co.jp>
 <aW6N+6r/Cy+VOYnW@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aW6N+6r/Cy+VOYnW@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TYCP286CA0326.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::10) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY3P286MB3603:EE_
X-MS-Office365-Filtering-Correlation-Id: 523465a2-89eb-4049-4208-08de588e27df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4N5F9ZEc5N/X+Z/Mgdw+PE/F/hYssEIBUPAVDv2FfvVu8LHZMlGYhxJapaA0?=
 =?us-ascii?Q?nmCdddUd7YhwXrQAhzsClMDU3SIMc/dPE8Ai9vcdQ33dZyK9iiL/sjsTgyi+?=
 =?us-ascii?Q?IIo60LVtsS4ocgUgR48mP8PICUYXeO+GatJTLSkI0kffaE6EjJK7vaJrc/yv?=
 =?us-ascii?Q?NIcrwTAyw1EVrp7heODRNvs1nm2xMxXVfWe3WMyLyWeO9jCY9CtU/eDwlGcw?=
 =?us-ascii?Q?P6c719+ZmZa4Hr8yopKp3srp+IwqkpYQPKQ9NGsZfPDlop0gl0WPwYz4fAW5?=
 =?us-ascii?Q?xWrpjCFrqOomym5/t3Q/lVwR2Xuh0zlN5VsHciipL1+0mrioE/+MXPlvhcIv?=
 =?us-ascii?Q?ZZZR9rdnODiUim3ZSSqIeZH/rKyYnNNj7sUwOycbJpEa0ITnx0HHcjplHJ11?=
 =?us-ascii?Q?hHPuqtGq939JAnbSdeANru8lorrcrNdAsvYIR8LAND/3eglJBBCapwczgE7B?=
 =?us-ascii?Q?Bq1PrIDiQlqwlAngO4Vq4iTXMBJGcyHeGDVviwzJaGIkK8A9b6vlfYiUqeW2?=
 =?us-ascii?Q?XR2A/dlxNUj0O4YprzzqaiTpfEW6KP7MytrWY6DWAr9QCHecP3nbYd0UmqIu?=
 =?us-ascii?Q?L/y0Y/K5R0DHSaaL0ypTDNSnC+UUX7xIneUi0MlI6jpF8WyREHoRvJaVd5CZ?=
 =?us-ascii?Q?7pCNoADNGBVvRGIy6cpXATN/Iqze5WUzsaysjVWC/y8v9Wfz7G264qVGRC5q?=
 =?us-ascii?Q?txHGq1WbMtvzyIr0QuKXQPhF91U00YQevDbW6avwieH/DUABnOwWFCt3b3gr?=
 =?us-ascii?Q?7HQJnMeGVv/qCXarrqx8tQJe1EFITF1BRYv/UiMKaZTKhQEq2wWYLcgc3Dae?=
 =?us-ascii?Q?Enga497uOunG3h+VwDlKQVY7yeio8t5w5eTaye7vOvxft3J3LHndVny9AT38?=
 =?us-ascii?Q?2F37CdbyCeOjOBSZHHMXhuMJhEnlWzXzC03KjRViyACChlteqQ1thErM0B2O?=
 =?us-ascii?Q?qEs1eLKx/LW1IgUfrYsIaQN99TX2CinjWS7f8eCz19irJLRH+J39GmozTqoL?=
 =?us-ascii?Q?L+7RzhOmpUDhyYXHVv7vjoGpikWHN8mq/Ld70GPDP8P3vNN8dhjHgmLG6AlQ?=
 =?us-ascii?Q?6jxaOx6PkSIVGNE0+naZfqJk5qhsDSXUnKuQHjThd0Sl9EDC/A916Kde4hLx?=
 =?us-ascii?Q?Pv2q1z2C+KMTqWhjP3y7jbaXIPDyPgjr2kohkJxonPZnDGqRBRGx/eqVnCFT?=
 =?us-ascii?Q?PxVTrude5pEX/9uB0QKQ64KpDk15lzpW22A6K9M5t04bCHiDWds9NOeTNBA3?=
 =?us-ascii?Q?YtrUP2pappva+P8ve4wY5VpGLwba0ZlHLohp3J+2v2KuZw+Oy9uPbR2HTg1X?=
 =?us-ascii?Q?uN+0uNkaWw2jABLpOcAIXg7VSe3tq7z37hYlQLwfPkGWrgFfyfjQXKX2EtCL?=
 =?us-ascii?Q?F7ZPtsgDAoaF++5UH6A+YY8PX98K0cqFDEmQkv06E27MBott2Tu859yDHh6w?=
 =?us-ascii?Q?+ML9q5oT8pL2UlVEoJzpxDVZ5Mo5kMjxoRdk+auxFnphlUrYuh01OgxpzVYM?=
 =?us-ascii?Q?rcwEsQltiS4KNDUaLtGNeVKwgG3PjkCpmDWCH2EsN8P8iHNr3EHFqba9bv7x?=
 =?us-ascii?Q?UfYtQ0CvkBQbF+vIGRQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2c3+ze7PiDAmsUVwVH0i+cVhEHCDpRKsHcqcHht25/oJFWfRz8+3PNpdB813?=
 =?us-ascii?Q?fquJHSxIqcoczJOb8muvm75/j2cWKmiaICY613EGr/CUompoqdXg3IbbWDwq?=
 =?us-ascii?Q?vII/g+7HdBSo+nUUu5FnOFCPeAEvxjJxZQrs6nx6+T43QCII+SLsKZcgKkAq?=
 =?us-ascii?Q?JFgFB6/nDG6XYNmF38+KsHLmDu/qV+0VHaTjwX0RH7rthL98EtDO+O15IBSe?=
 =?us-ascii?Q?g4Up+NB/yuzgsXNwr6TslcLaINgcIsoONEi3RzQgECk52fXDbHc00YtcAout?=
 =?us-ascii?Q?xbGRvP90Df6l0PHjpx93gYCTWLgx/MkdhpUPhL9lu0y3vHsmUlYghV15g0fr?=
 =?us-ascii?Q?IYMDvRwJmddjIMpJHIEzROJUkFwH5lnVB4Mz8QKw0cAwcCpjelbSJJfNq7Qa?=
 =?us-ascii?Q?t4yHN1T++97lqHPNi7UpEpowySUmaVoVK+yHtgmzTe8f/wuXV6ojmHnR8Q6I?=
 =?us-ascii?Q?V87M08ThhgMqECVvyLrfRCDN9NcDkZN4VRoh2e4Q8eMLA/2REljt4l0Rd9Tt?=
 =?us-ascii?Q?UbClWv7LyLT8Dx7DFaDT0vnHo3/8v/K/2mlSAENSFIZDuDsJwF5+pCk3tVaZ?=
 =?us-ascii?Q?H4eNLX/WIOCqZGYEReguosR3coa6qcTsIrFVNUhNlktdF/+E+2W8kj6IYnTy?=
 =?us-ascii?Q?AEyNrjMCWe576gQpQkhT6G/LkTD6Y0C/tZZGBMJGRsJZxoVwDruZWYTZat7L?=
 =?us-ascii?Q?MMoRd102mUB54+M9UY0yLzBaeJXdLzf1MCJW2M6PuflarEhL+F47QYUruZUQ?=
 =?us-ascii?Q?0yfKDPdrjAVPscP9TvsuZXg6173C15p9+hk+CQ0kZxIuKcI1T97lwrshdWLr?=
 =?us-ascii?Q?SnG7+tONoUkD1m5TEMab1a2+zG7aohWyG3LAxX6s4NqIH2O3tfVz9/z3/l2+?=
 =?us-ascii?Q?/yEjJ9qORx2bQ4cJcAoYbqCKD/nDjZKRvX2qWuGrUDrks9qx2PHDcRVuwkBf?=
 =?us-ascii?Q?mU3s91Lnh8zSC9hAmXW7VxmDz4v7wcst3Fr0U9cOzismXN1V2ePk5wpfVOJ7?=
 =?us-ascii?Q?+TYuO08xtk8Yl6Aymo4rIboOmSzjpTf9yiN6emTzJtPCC/niD+QEZ2e8fmrs?=
 =?us-ascii?Q?SYgBZQK0Hax8mbJHiTx+dNPLzwACiyQfiEDqhXC5cWZuLeo5HFNtOHygzoHr?=
 =?us-ascii?Q?gcvVgiIwJHWk1vkd1mTBHbZtiI9mux/5oAszJnrtMN/bW6acKxw68Q+0thjJ?=
 =?us-ascii?Q?bvin02Jq6gQnwTxjjdV7YDq6Jfg4Rmx2NAGUbUXebQCRmMVKJ2OmyMhuMJL8?=
 =?us-ascii?Q?qOyOjaWasvM9WBchadizqdwMmSjBBIh+YQUuU4a3kf+w/8E/v5SmldNGAwsE?=
 =?us-ascii?Q?YLrbr+D3y7nbu8FINgQUlQfDR+Vva6vtQS4vr4oMKCNEMGlBiIOU/gnyj3kG?=
 =?us-ascii?Q?FAo/HBj9svKyofhLa8MQG4wEA4F/p7/6B4Bn/g9IkRI8SNu0BelO4rVU6ljn?=
 =?us-ascii?Q?OiOserODmbsGhWRBnzg3o1zyq2tUCeox87fpkm8F3/LvSvz/Hu6cf91YWKwB?=
 =?us-ascii?Q?Y9SGMYjsHJvNA1JKupdKLx0D8jlfcCCkKDdb2M3FtoxCtWuhCByCU1SMNVbJ?=
 =?us-ascii?Q?9Ur0pfZr9/gAjGiEa40woIF8npGhaovZE++NSOet4eIFqvEb9QH9lnHRV+Yy?=
 =?us-ascii?Q?CXt0qMyFca5mQVKNntVjx07zDBoG+wh7MXIFQL5s5672q9gEv/NLFP3aS64C?=
 =?us-ascii?Q?1mc70vvADojQ+ZaTnN0Ex5nAi7T4CYJ7YwGGFsjHQseuFQu68Mgg2EIJM9OQ?=
 =?us-ascii?Q?9Ay2I0uY6dAm9Zj2VrS80Pw9DgElrkiDJ5QqTWzPL4pAEe+qAbJX?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 523465a2-89eb-4049-4208-08de588e27df
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 01:41:11.1575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gtLwkb0vcF9d53DKe4FvEUyxzlP8nUR5ceQmkEimiuIdRMXj4mrucvBuYoFuqZWY4hKWKlNIy79eAWw4STH93g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB3603
X-Spamd-Result: default: False [2.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8413-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[37];
	FREEMAIL_CC(0.00)[intel.com,kernel.org,google.com,glider.be,kudzu.us,gmail.com,vger.kernel.org,lists.linux.dev,arndb.de,linuxfoundation.org,8bytes.org,arm.com,lwn.net,linux.intel.com,baylibre.com];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[valinux.co.jp,none];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[dmaengine,renesas,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:email,valinux.co.jp:dkim,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 2B3A84F3DD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jan 19, 2026 at 03:03:07PM -0500, Frank Li wrote:
> On Sun, Jan 18, 2026 at 10:54:10PM +0900, Koichiro Den wrote:
> > Provide db_vector_count() and db_vector_mask() implementations for both
> > ntb_hw_epf and pci-epf-vntb so that ntb_transport can map MSI vectors to
> > doorbell bits. Without them, the upper layer cannot identify which
> > doorbell vector fired and ends up scheduling rxc_db_work() for all queue
> > pairs, resulting in a thundering-herd effect when multiple queue pairs
> > (QPs) are enabled.
> >
> > With this change, .peer_db_set() must honor the db_bits mask and raise
> > all requested doorbell interrupts, so update those implementations
> > accordingly.
> >
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> 
> Patch 6/7/8 can be post seperatly. Basic look good.

Will do so. Thank you for the suggestion.

Koichiro

> 
> Frank
> 
> >  drivers/ntb/hw/epf/ntb_hw_epf.c               | 47 ++++++++++++-------
> >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 41 +++++++++++++---
> >  2 files changed, 64 insertions(+), 24 deletions(-)
> >
> > diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
> > index dbb5bebe63a5..c37ede4063dc 100644
> > --- a/drivers/ntb/hw/epf/ntb_hw_epf.c
> > +++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
> > @@ -381,7 +381,7 @@ static int ntb_epf_init_isr(struct ntb_epf_dev *ndev, int msi_min, int msi_max)
> >  		}
> >  	}
> >
> > -	ndev->db_count = irq;
> > +	ndev->db_count = irq - 1;
> >
> >  	ret = ntb_epf_send_command(ndev, CMD_CONFIGURE_DOORBELL,
> >  				   argument | irq);
> > @@ -415,6 +415,22 @@ static u64 ntb_epf_db_valid_mask(struct ntb_dev *ntb)
> >  	return ntb_ndev(ntb)->db_valid_mask;
> >  }
> >
> > +static int ntb_epf_db_vector_count(struct ntb_dev *ntb)
> > +{
> > +	return ntb_ndev(ntb)->db_count;
> > +}
> > +
> > +static u64 ntb_epf_db_vector_mask(struct ntb_dev *ntb, int db_vector)
> > +{
> > +	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
> > +
> > +	db_vector--; /* vector 0 is reserved for link events */
> > +	if (db_vector < 0 || db_vector >= ndev->db_count)
> > +		return 0;
> > +
> > +	return ndev->db_valid_mask & BIT_ULL(db_vector);
> > +}
> > +
> >  static int ntb_epf_db_set_mask(struct ntb_dev *ntb, u64 db_bits)
> >  {
> >  	return 0;
> > @@ -507,26 +523,21 @@ static int ntb_epf_peer_mw_get_addr(struct ntb_dev *ntb, int idx,
> >  static int ntb_epf_peer_db_set(struct ntb_dev *ntb, u64 db_bits)
> >  {
> >  	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
> > -	u32 interrupt_num = ffs(db_bits) + 1;
> > -	struct device *dev = ndev->dev;
> > +	u32 interrupt_num;
> >  	u32 db_entry_size;
> >  	u32 db_offset;
> >  	u32 db_data;
> > -
> > -	if (interrupt_num >= ndev->db_count) {
> > -		dev_err(dev, "DB interrupt %d greater than Max Supported %d\n",
> > -			interrupt_num, ndev->db_count);
> > -		return -EINVAL;
> > -	}
> > +	unsigned long i;
> >
> >  	db_entry_size = readl(ndev->ctrl_reg + NTB_EPF_DB_ENTRY_SIZE);
> >
> > -	db_data = readl(ndev->ctrl_reg + NTB_EPF_DB_DATA(interrupt_num));
> > -	db_offset = readl(ndev->ctrl_reg + NTB_EPF_DB_OFFSET(interrupt_num));
> > -
> > -	writel(db_data, ndev->db_reg + (db_entry_size * interrupt_num) +
> > -	       db_offset);
> > -
> > +	for_each_set_bit(i, (unsigned long *)&db_bits, ndev->db_count) {
> > +		interrupt_num = i + 1;
> > +		db_data = readl(ndev->ctrl_reg + NTB_EPF_DB_DATA(interrupt_num));
> > +		db_offset = readl(ndev->ctrl_reg + NTB_EPF_DB_OFFSET(interrupt_num));
> > +		writel(db_data, ndev->db_reg + (db_entry_size * interrupt_num) +
> > +		       db_offset);
> > +	}
> >  	return 0;
> >  }
> >
> > @@ -556,6 +567,8 @@ static const struct ntb_dev_ops ntb_epf_ops = {
> >  	.spad_count		= ntb_epf_spad_count,
> >  	.peer_mw_count		= ntb_epf_peer_mw_count,
> >  	.db_valid_mask		= ntb_epf_db_valid_mask,
> > +	.db_vector_count	= ntb_epf_db_vector_count,
> > +	.db_vector_mask		= ntb_epf_db_vector_mask,
> >  	.db_set_mask		= ntb_epf_db_set_mask,
> >  	.mw_set_trans		= ntb_epf_mw_set_trans,
> >  	.mw_clear_trans		= ntb_epf_mw_clear_trans,
> > @@ -607,8 +620,8 @@ static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
> >  	int ret;
> >
> >  	/* One Link interrupt and rest doorbell interrupt */
> > -	ret = ntb_epf_init_isr(ndev, NTB_EPF_MIN_DB_COUNT + NTB_EPF_IRQ_RESERVE,
> > -			       NTB_EPF_MAX_DB_COUNT + NTB_EPF_IRQ_RESERVE);
> > +	ret = ntb_epf_init_isr(ndev, NTB_EPF_MIN_DB_COUNT + 1 + NTB_EPF_IRQ_RESERVE,
> > +			       NTB_EPF_MAX_DB_COUNT + 1 + NTB_EPF_IRQ_RESERVE);
> >  	if (ret) {
> >  		dev_err(dev, "Failed to init ISR\n");
> >  		return ret;
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > index 4927faa28255..39e784e21236 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > @@ -1384,6 +1384,22 @@ static u64 vntb_epf_db_valid_mask(struct ntb_dev *ntb)
> >  	return BIT_ULL(ntb_ndev(ntb)->db_count) - 1;
> >  }
> >
> > +static int vntb_epf_db_vector_count(struct ntb_dev *ntb)
> > +{
> > +	return ntb_ndev(ntb)->db_count;
> > +}
> > +
> > +static u64 vntb_epf_db_vector_mask(struct ntb_dev *ntb, int db_vector)
> > +{
> > +	struct epf_ntb *ndev = ntb_ndev(ntb);
> > +
> > +	db_vector--; /* vector 0 is reserved for link events */
> > +	if (db_vector < 0 || db_vector >= ndev->db_count)
> > +		return 0;
> > +
> > +	return BIT_ULL(db_vector);
> > +}
> > +
> >  static int vntb_epf_db_set_mask(struct ntb_dev *ntb, u64 db_bits)
> >  {
> >  	return 0;
> > @@ -1487,20 +1503,29 @@ static int vntb_epf_peer_spad_write(struct ntb_dev *ndev, int pidx, int idx, u32
> >
> >  static int vntb_epf_peer_db_set(struct ntb_dev *ndev, u64 db_bits)
> >  {
> > -	u32 interrupt_num = ffs(db_bits) + 1;
> >  	struct epf_ntb *ntb = ntb_ndev(ndev);
> >  	u8 func_no, vfunc_no;
> > -	int ret;
> > +	u64 failed = 0;
> > +	unsigned long i;
> >
> >  	func_no = ntb->epf->func_no;
> >  	vfunc_no = ntb->epf->vfunc_no;
> >
> > -	ret = pci_epc_raise_irq(ntb->epf->epc, func_no, vfunc_no,
> > -				PCI_IRQ_MSI, interrupt_num + 1);
> > -	if (ret)
> > -		dev_err(&ntb->ntb->dev, "Failed to raise IRQ\n");
> > +	for_each_set_bit(i, (unsigned long *)&db_bits, ntb->db_count) {
> > +		/*
> > +		 * DB bit i is MSI interrupt (i + 2).
> > +		 * Vector 0 is used for link events and MSI vectors are
> > +		 * 1-based for pci_epc_raise_irq().
> > +		 */
> > +		if (pci_epc_raise_irq(ntb->epf->epc, func_no, vfunc_no,
> > +				      PCI_IRQ_MSI, i + 2))
> > +			failed |= BIT_ULL(i);
> > +	}
> > +	if (failed)
> > +		dev_err(&ntb->ntb->dev, "Failed to raise IRQ (%#llx)\n",
> > +			failed);
> >
> > -	return ret;
> > +	return failed ? -EIO : 0;
> >  }
> >
> >  static u64 vntb_epf_db_read(struct ntb_dev *ndev)
> > @@ -1561,6 +1586,8 @@ static const struct ntb_dev_ops vntb_epf_ops = {
> >  	.spad_count		= vntb_epf_spad_count,
> >  	.peer_mw_count		= vntb_epf_peer_mw_count,
> >  	.db_valid_mask		= vntb_epf_db_valid_mask,
> > +	.db_vector_count	= vntb_epf_db_vector_count,
> > +	.db_vector_mask		= vntb_epf_db_vector_mask,
> >  	.db_set_mask		= vntb_epf_db_set_mask,
> >  	.mw_set_trans		= vntb_epf_mw_set_trans,
> >  	.mw_clear_trans		= vntb_epf_mw_clear_trans,
> > --
> > 2.51.0
> >

