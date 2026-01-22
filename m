Return-Path: <dmaengine+bounces-8450-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MzzKyt7cWkvHwAAu9opvQ
	(envelope-from <dmaengine+bounces-8450-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 22 Jan 2026 02:19:39 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 208A560410
	for <lists+dmaengine@lfdr.de>; Thu, 22 Jan 2026 02:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AEF3B4E90A4
	for <lists+dmaengine@lfdr.de>; Thu, 22 Jan 2026 01:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1A834E771;
	Thu, 22 Jan 2026 01:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="VwYuu+TA"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020079.outbound.protection.outlook.com [52.101.229.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035962BF00B;
	Thu, 22 Jan 2026 01:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769044772; cv=fail; b=ofJlXoIf7xe3RJTCcA3+JFf75ASdwySOkRD4pvazj10PsWde690ObaF9NTuDXBZE1/HJwXrUA6GuiY2yTBLj6dtV0CyRlMh9YY1BbooeNqoZWttimApsebqNVRuiYKfoR3aAQ3HxMkbLrIqAlIC+SeSzzEEktWBTrRVWhV5WeHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769044772; c=relaxed/simple;
	bh=o2NQLMS/embWth5RzuLVwrEMh0pQn2Vc7mYfETjCulM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DeFVEkAKzuy823jAVfO1E7yG/E9dLVYx+K4+vYYGe4gv1knloY+1KM287qAz4eI9AIAhyS3kSJzEcVc8EIACORsQMBOsHKD2cHazVb61mPAeFGTcmWP/Il26n0D5k0PXncNcgWDMqS3xbHMC0bdTCdZdBd9NvR+7YGzu4T7V8i0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=VwYuu+TA; arc=fail smtp.client-ip=52.101.229.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eNC9AgpikQfyd7xEXdlfw6XImwxJdv0QtRXX+r4AWm6YUifJry7fcuEncV6WR+PVvczKYy1zN1y3QfM8QgXYRam6AyhW8YvnII3RVpC0d6Npc2CKVyzsBTV/t7RZHi2he/TdCM0cx8OsjXWKc3ygP64U7LXbcJ9XSBvin7Pbv7WypurWEGnPxsOScD78kEn/MUn/2GSJ1Rmm/m103sNiKlqXAbf8wZADk2BrcRFOuprJNYyIfTrQuN/tcKVUFlhHD6nMIMjow7+2fhEEOx2VjojwA7BiX/vpWlvFuUIqoObBlWH+enNtNPs24owPjN6CPRajbt1+SThln/Fryf6TSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FsHuvGeytFBSKIZe5jzERdo52s0CnCoK3SAaFRhEnj0=;
 b=PH4dvxhNgUfx7W+H4X7na7h2WKmHHH6W59MPr9cngZTu2EkIuwUp7Y7RJOT+dQv1q0iBfQgNnXgf+Uy++iHHnN3q2sTxnWg/JYNsI6r8/+SieAEQndA5zHiVMTOj4H4xnq52tQkhNx6sZj6IN3ApavVL+RWBheXIFJIZR5WSbpDViSV2MNm9WvYnnpwucFUaDizXjSDxC+TE7Rk30T9fNNhEV0fz/Eu/UBOje5PPBONgyer2ckEwwIrads4fL1sCZCBDRjZX4PBIs0rMp6i4Y4JUj8br2T8kYgUmnEp6F8UDkE5whPMHaZY57l9D0e5NAoA4KXMx8ckQDVwQFLy5YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FsHuvGeytFBSKIZe5jzERdo52s0CnCoK3SAaFRhEnj0=;
 b=VwYuu+TAbNMDl1nEbkGxYD9kIfpGz5iYuRTMxU3eymSGO3ewdPH36bI6zv5dPpEMM4pUIdQIdIz8DymHTf0UQ008yHZil0RDpnHRQ0wYgzEL8145kt4D+siJ+jOYLMklcAzfcvOSRWDuwptqFWYf7VRyPBLbcnm4T1ImMZ+6WNg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY7P286MB6210.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:329::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 01:19:25 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 01:19:25 +0000
Date: Thu, 22 Jan 2026 10:19:24 +0900
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
Subject: Re: [RFC PATCH v4 05/38] dmaengine: dw-edma: Add a helper to query
 linked-list region
Message-ID: <42qzkekk6yqbtcynxny3f7pl3xg6tqkywxvjsgfmrdpnr7zy53@i7ebpgazbi4z>
References: <20260118135440.1958279-1-den@valinux.co.jp>
 <20260118135440.1958279-6-den@valinux.co.jp>
 <aW0S60D2uALBXdtQ@lizhi-Precision-Tower-5810>
 <e4y664ylum35wvj4endwprzpp4cvfaggklik5mxvdkgmakuqyj@lgevmhllem72>
 <tuhaxwmmcjfltih7ckfo2l5ltzicnj6zfc5ka3pvqlljn7ldu2@ibo5eo62lndn>
 <aXDvkRCZXQ/dPwRd@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXDvkRCZXQ/dPwRd@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TYCP301CA0008.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::6) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY7P286MB6210:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d12f959-3cb4-4ebc-9d46-08de595447c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|10070799003|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ri9IMbMDzUHAwQNCR3d8X5Q4Q/vspMT0v/N8X/JKM1aRLgoUvqqFP2/vgJis?=
 =?us-ascii?Q?0Fo2dV1b1brgpIsrYSJyD74wxizw6zseErTvFIbZN0LoVOfwh47xpa/IhWt4?=
 =?us-ascii?Q?iKCHhSm4/XXuVcLKj7ChLOJWp+Z9PT97wALTKCAXGM4AqTxQ9a0PtR97s1dh?=
 =?us-ascii?Q?gQEAEXmt66nNSLmpDMQSVvOXj6Spcv7HrW1aD/nZj4MF7xeTPV7gG9A6erRO?=
 =?us-ascii?Q?Pt89V5PwW1mUfrl2DFvBeYClxGXBqLMk9OzQSWA+03NNBVyOMbgQQMVc+vwJ?=
 =?us-ascii?Q?uxvTv6W3K4m2c9Lg04GxgbPdeU4mh8r57xaICXcpLowulZ1t0igaI7Km4MyP?=
 =?us-ascii?Q?G/xXiy+UHgvSOWHm1vR2IyeatPShiG1W9CjUpwKQeg8WM0dxb3ftwf/uQgRH?=
 =?us-ascii?Q?FQkyTyTvvyr4H6AZskrCFJUAGP/81zZ7lGjTiooFrxthThHV9k3dGu5D5/+D?=
 =?us-ascii?Q?GUwCI+IrQu9LKsasebPvHZdVgtKbam+9XqHoaOlRg+Up/LYmW12Cg49LE2pg?=
 =?us-ascii?Q?q9GnsxKRxWWGPlzyTGwn7UsW2Okli1T7S3td7LFirZyVLKxQxS9J3J40SmLu?=
 =?us-ascii?Q?FtJ/ZBFgnzqDLhwDHjp42Jd6iD2GL9iAE6gvv5zASd7wG5D2nTUQ8NwVA7Qy?=
 =?us-ascii?Q?tE0obssEjRFwMvL6J1ehn12ToNfk3tclyHBQo4qX+GNilLFbD688Q84nFCzP?=
 =?us-ascii?Q?wt16KPdfXXsPFfSb467ZMib4g0gFIi8t+oK1i83JbYyCdwivVTfdUyAkVt9I?=
 =?us-ascii?Q?hDwLNpL/1BlXg1b/aJDYNe03EJpe/XnizqGXRPU+8uDx8/pI9LKPgxKxIGBM?=
 =?us-ascii?Q?Ql33NNaFYNWMqnnE+/EOKqBUhjEYmvTE4ek5U1z2c48WN/EEOiyoQ/sLw01r?=
 =?us-ascii?Q?HmycC+nUHYWrFIJyXUIzFeBVND2I8qhSgn/8CzvcNyQGMMQCoqgyqi12m6Qa?=
 =?us-ascii?Q?JYHqXGrMyPulkz0oZPHeuApWiRgWF/3vKA9wRDKB+sTtX/IGNYrCBzoRbtj4?=
 =?us-ascii?Q?6mLGcZh4eGz1PzWEhF07ft4HVjdB6/B8rCcrVwy2QKBmv2ToZfeVyYAiu8Ch?=
 =?us-ascii?Q?EKEiEcg+84JrJkRF9dWfFWfioI2+4ZVCSAUGlA8QH9L76HDUbh9vQmAwE9qU?=
 =?us-ascii?Q?9QAO/A6perKwpFRWgNVxGCTrhTN7EjWGMYYGvpI/EMnYZw9/nyIqCpQRcBbY?=
 =?us-ascii?Q?VaLjAbJKH3mKtATvN8h1fbCd1Xh9JIQsPsj/q8m1et1PV5eZfsXJ8+06LBWO?=
 =?us-ascii?Q?ZAFyUGozA5RHZgwIesaGjfHvvl8b2Q38YcQqXGvEHP0TQIA/k4eg6K7oQVAX?=
 =?us-ascii?Q?qivqlTE57x8mj6ho0Cgate5QctH9Kv/cYAqseny5U3vMbuQv1/ROYm98f4G3?=
 =?us-ascii?Q?u+fWGGW2yLb//fARpEXU+WtMn4FjQFWuTeT8lFOnd8jrXZ6XmGwnyhYEud9Z?=
 =?us-ascii?Q?o+D042fbFXnjqUtuurr4iEFgMfHUKrs/jZGRkQODfEuY5dnikuTlKkEZcFzo?=
 =?us-ascii?Q?4VUAGh+As8HevjDsRlW+2qIY5dJQpe/URKasvK22ZTGAYJ2kd39tRV59//s3?=
 =?us-ascii?Q?73pDfz6CMSEZ5SkssQc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(7416014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bXy7xrG0lGJtw1cchbaUNrCcnmrVtyCFzAPVssZ89skuzZhnIDcHTMtcvq49?=
 =?us-ascii?Q?CUrsv9qQ6GeqqbF35qxFtdUzk+GISzl8sGA1uJJcx9IKgRhaMCo0u/PnD9d2?=
 =?us-ascii?Q?4RlOixdLH59Roz/1uqgTS4Gt0Lre+ovWTp+Xh+ZzXcDql+Si7Ceeh359M0AH?=
 =?us-ascii?Q?9BL0OFmvF5kdDTt+zrc8QrUr+/orhDxTqpwFLZuYei1PnE+v5hpIslMKGYAB?=
 =?us-ascii?Q?ApBUwjw/Pd8nh9//L3lnpNnqpHMcgzvvOBV067mjGXojOijzkkHiudRMenn4?=
 =?us-ascii?Q?9BwwmuAlJbGGdYGQ3zuFf4RhVunsLklnTDFnMOGnXLc+6w1H6ehXLnKvxGOx?=
 =?us-ascii?Q?lV7tfP8HHTlD6+k8BiOXe5lvkABmCTHRz3vfXfrNXB05zK+ZvSvAHqP/i+54?=
 =?us-ascii?Q?FFvp9piuKKZKRlSysRrSuJE2CUyNrmQAny7qA49bqUQShrvyclGgCXxnf/In?=
 =?us-ascii?Q?M50wMBgd+76s1PioHtNvQPrztqEiiWnFbB145x5Uoi4Q+HGrXEqsqhoTcUwe?=
 =?us-ascii?Q?d1CGEhRwiWtGi1poWLlFUNACiz0wyVD4Bv/s3iuRXyLOmzLA59mfgS+9gAei?=
 =?us-ascii?Q?UkSs6Ecldn8MHJW65ydLMXo4vlPkwFZX5XCX6EL/PGkt+Lb8V7PgMKV/rNMX?=
 =?us-ascii?Q?+gAfAucdeCZGSavhoLGzvEF/HiDeG03OY1V1Y6gxeBIwUHzcLq0tZ5Q9xtVU?=
 =?us-ascii?Q?d9T8bmWjUe1qnwXPAwPDlqxr5UsmfW2cjDdcTeSP04TAzB7a27Ivj5neI53f?=
 =?us-ascii?Q?sU+PxYC4aDNXapTEtad/qt83MKEnjbWzjeKVX+BdkCdjIQ/cYLak50fypbD1?=
 =?us-ascii?Q?T2IB17QwHSQ+YmOVm2JCOWIdCkTds3fS+H5F0BGH/gcUwomYg1Pec9vkVfZM?=
 =?us-ascii?Q?jfyCGjFR5Q7yMop0i4Us3drUX9+5aFVHYTiyMtRL/ZG5GpQm4rlEIAruSvtl?=
 =?us-ascii?Q?vJyoy7Sg89wMu5lsuaU+7ctB9VMtkidwTRrm5HFrBmxP0d/BK/DZkF23QFIL?=
 =?us-ascii?Q?uAQaYaJviRiC0hbwl3+Raf772Ab7B0ZdKXWgHR6VTVGilInRl1EGOFIJWbGy?=
 =?us-ascii?Q?NmNNSj0qqQnIbVPqmr42poA2rOJFrRYQJl78e+/yQStGbg5wW6JoSqMet+54?=
 =?us-ascii?Q?Yy2VZEPmiwEB5B274jptIA9KDfbYvrZwZTKNhW47rtvN08WpUNdaB3jZpqDx?=
 =?us-ascii?Q?+FCI8wJu3nUVba2rcILjkUGC/bjuXEJStMif8OJb8CKgez04cZa/CJH+nOe4?=
 =?us-ascii?Q?vHBAUdCnnIbsrtijAoR5V9o1Nqo950uWfmf33R14usmWWa4RlVzYJP4h947X?=
 =?us-ascii?Q?6uGKBINEGVgeU/3NnZDFFBZdKJvu2IeelV8IldW2HrPay0emAmLAsr0P/cG4?=
 =?us-ascii?Q?XjxJ/Mtw7i2YU7u4AC8K418B06tz4cvD7saF86sWrv30gIKmPZWxDJe6u6u6?=
 =?us-ascii?Q?XHDxjFyB7oXDmBXiaCcFlZA7PXvkbU9gq8OmGdFchZJEX/fxPSWsNh1SVFs1?=
 =?us-ascii?Q?98gwShnASmxZglhEt+ivITiOJVSinWdqUOZXWu7lx+dnWYjQ+4t1dCAeFvT7?=
 =?us-ascii?Q?JasbshOVkW8RPKZXW1qdw6N9TkziBEOSznsAYyk7y9wpqIDNR1TWHU/ASZA+?=
 =?us-ascii?Q?3T3MhVCCV/lzPJigBFNzS6mrSbSI95OZhqZXcM+dA/KdMJ2WxwEAs1ZMkpuu?=
 =?us-ascii?Q?a6+Azw8r7t993sgp7utMbjjue0v5PTm34J2k21QA6tAy1F4DMfK/q9ffltlL?=
 =?us-ascii?Q?IirjCHo2eQI5EwsXKr/KW4wuH7HsHRoGGd2Gwc2y2PSWoDGV8gi0?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d12f959-3cb4-4ebc-9d46-08de595447c6
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 01:19:25.0576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gDgf4Icprdvhem44vuCWTIxFiodQz1mn/xaBFvUQRo6q6HCwbmIvzC8Iq4X5AgjlxU9Dh/H+XCSUUpWwHtectQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB6210
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8450-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[dmaengine,renesas,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:email,valinux.co.jp:dkim,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 208A560410
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 10:24:01AM -0500, Frank Li wrote:
> On Wed, Jan 21, 2026 at 05:41:11PM +0900, Koichiro Den wrote:
> > On Wed, Jan 21, 2026 at 10:38:53AM +0900, Koichiro Den wrote:
> > > On Sun, Jan 18, 2026 at 12:05:47PM -0500, Frank Li wrote:
> > > > On Sun, Jan 18, 2026 at 10:54:07PM +0900, Koichiro Den wrote:
> > > > > A remote eDMA provider may need to expose the linked-list (LL) memory
> > > > > region that was configured by platform glue (typically at boot), so the
> > > > > peer (host) can map it and operate the remote view of the controller.
> > > > >
> > > > > Export dw_edma_chan_get_ll_region() to return the LL region associated
> > > > > with a given dma_chan.
> > > >
> > > > This informaiton passed from dwc epc driver. Is it possible to get it from
> > > > EPC driver.
> > >
> > > That makes sense, from an API cleanness perspective, thanks.
> > > I'll add a helper function dw_pcie_edma_get_ll_region() in
> > > drivers/pci/controller/dwc/pcie-designware.c, instead of the current
> > > dw_edma_chan_get_ll_region() in dw-edma-core.c.
> >
> > Hi Frank,
> >
> > I looked into exposing LL regions from the EPC driver side, but the key
> > issue is channel identification under possibly concurrent dmaengine users.
> > In practice, the only stable handle a consumer has is a pointer to struct
> > dma_chan, and the only reliable way to map that to the eDMA hardware
> > channel is via dw_edma_chan->id.
> 
> If possible, I suggest change to one page pre-channel. So there are a fixed
> ll mapping.

I agree that this would make the LL layout more deterministic and would
indeed simplify locating the region for a given dw_edma_chan ID. That said,
my concern was that even with a fixed per-channel layout, we still need a
reliable way to map a struct dma_chan obtained by a consumer to the
corresponding dw_edma_chan ID, especially in the presence of potentially
concurrent dmaengine users.

> 
> > I think an EPC-facing API would still need
> > that mapping in any case, so keeping the helper in dw-edma seems simpler
> > and more robust.
> > If you have another idea, I'd appreciate your insights.
> 
> I suggest add generally DMA engine API to get such property, some likes
> a kind ioctrl \ dma_get_config().

I think such a helper, combined with your one page per-channel idea, would
resolve the issue cleanly. For example, a helper like dma_get_hw_info()
returning struct dma_hw_info, whose first field is a hw_id, could work
well. Consumers could then use this helper, and if they know they are
dealing with a dw-edma channel, they can derive the LL location
straightforwardly as {hw_id * fixed_stride (e.g. PAGE_SIZE)}. Adding hw_id
to struct dma_slave_caps would make the necessary diff smaller, but I think
it would not semantically fit in the structure.

Thanks,
Koichiro

> 
> Frank
> 
> >
> > Regards,
> > Koichiro
> >
> > >
> > > Thanks for the review,
> > > Koichiro
> > >
> > > >
> > > > Frank
> > > > >
> > > > > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > > > > ---
> > > > >  drivers/dma/dw-edma/dw-edma-core.c | 26 ++++++++++++++++++++++++++
> > > > >  include/linux/dma/edma.h           | 14 ++++++++++++++
> > > > >  2 files changed, 40 insertions(+)
> > > > >
> > > > > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > > > > index 0eb8fc1dcc34..c4fb66a9b5f5 100644
> > > > > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > > > > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > > > > @@ -1209,6 +1209,32 @@ int dw_edma_chan_register_notify(struct dma_chan *dchan,
> > > > >  }
> > > > >  EXPORT_SYMBOL_GPL(dw_edma_chan_register_notify);
> > > > >
> > > > > +int dw_edma_chan_get_ll_region(struct dma_chan *dchan,
> > > > > +			       struct dw_edma_region *region)
> > > > > +{
> > > > > +	struct dw_edma_chip *chip;
> > > > > +	struct dw_edma_chan *chan;
> > > > > +
> > > > > +	if (!dchan || !region || !dchan->device)
> > > > > +		return -ENODEV;
> > > > > +
> > > > > +	chan = dchan2dw_edma_chan(dchan);
> > > > > +	if (!chan)
> > > > > +		return -ENODEV;
> > > > > +
> > > > > +	chip = chan->dw->chip;
> > > > > +	if (!(chip->flags & DW_EDMA_CHIP_LOCAL))
> > > > > +		return -EINVAL;
> > > > > +
> > > > > +	if (chan->dir == EDMA_DIR_WRITE)
> > > > > +		*region = chip->ll_region_wr[chan->id];
> > > > > +	else
> > > > > +		*region = chip->ll_region_rd[chan->id];
> > > > > +
> > > > > +	return 0;
> > > > > +}
> > > > > +EXPORT_SYMBOL_GPL(dw_edma_chan_get_ll_region);
> > > > > +
> > > > >  MODULE_LICENSE("GPL v2");
> > > > >  MODULE_DESCRIPTION("Synopsys DesignWare eDMA controller core driver");
> > > > >  MODULE_AUTHOR("Gustavo Pimentel <gustavo.pimentel@synopsys.com>");
> > > > > diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> > > > > index 3c538246de07..c9ec426e27ec 100644
> > > > > --- a/include/linux/dma/edma.h
> > > > > +++ b/include/linux/dma/edma.h
> > > > > @@ -153,6 +153,14 @@ bool dw_edma_chan_ignore_irq(struct dma_chan *chan);
> > > > >  int dw_edma_chan_register_notify(struct dma_chan *chan,
> > > > >  				 void (*cb)(struct dma_chan *chan, void *user),
> > > > >  				 void *user);
> > > > > +
> > > > > +/**
> > > > > + * dw_edma_chan_get_ll_region - get linked list (LL) memory for a dma_chan
> > > > > + * @chan: the target DMA channel
> > > > > + * @region: output parameter returning the corresponding LL region
> > > > > + */
> > > > > +int dw_edma_chan_get_ll_region(struct dma_chan *chan,
> > > > > +			       struct dw_edma_region *region);
> > > > >  #else
> > > > >  static inline int dw_edma_probe(struct dw_edma_chip *chip)
> > > > >  {
> > > > > @@ -182,6 +190,12 @@ static inline int dw_edma_chan_register_notify(struct dma_chan *chan,
> > > > >  {
> > > > >  	return -ENODEV;
> > > > >  }
> > > > > +
> > > > > +static inline int dw_edma_chan_get_ll_region(struct dma_chan *chan,
> > > > > +					     struct dw_edma_region *region)
> > > > > +{
> > > > > +	return -EINVAL;
> > > > > +}
> > > > >  #endif /* CONFIG_DW_EDMA */
> > > > >
> > > > >  struct pci_epc;
> > > > > --
> > > > > 2.51.0
> > > > >

