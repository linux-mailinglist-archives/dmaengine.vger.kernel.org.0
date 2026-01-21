Return-Path: <dmaengine+bounces-8415-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKUcLj81cGl9XAAAu9opvQ
	(envelope-from <dmaengine+bounces-8415-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 03:09:03 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6214F4F878
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 03:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 776AB7CFCA5
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 02:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48B6331A52;
	Wed, 21 Jan 2026 02:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="X/TiSA5E"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021112.outbound.protection.outlook.com [52.101.125.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E6B334361;
	Wed, 21 Jan 2026 02:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768961319; cv=fail; b=KwEbYiFnGrDzN+Bwi8e6QMPk9qv+3LDoNgD7Pb/uuWSXIZl/Mo/RLy9vE4mOz/nqxbxt0AVG5SH7eX155+94wMu6jxpDRhoxybYzjDAvQ5wt5I6lspd3D9w8OgwYn3OVtCvYU0YjTAAUnfGmjETkrUnRjN9ZajuBBR8fSEGLbVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768961319; c=relaxed/simple;
	bh=K6bY4Lt7FXTaQjGWb2YB0K9ueqBhpKci6PPzRBpzAxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=P1v9TjyToezxD4kxUjg6UeBz/+CT6xe258e4ea2mITFO+exemtPXyP63H2aABAhJ4Lm6+84rAMb97ezUURwTw8EcfRWAYbRrqHppQardRlMwuVBKetKGyDxp8I/3toXNan5D+ecEadPaVTgWs0e7EgRfsBN/PueZCOifcipFrGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=X/TiSA5E; arc=fail smtp.client-ip=52.101.125.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jubhuXxYZut2Rbf7ZorOFBoxW3EswShGoj2EeTyFMCbtPZEz4fY5X4yxnJxW8rturzGwHL5eaSDEOp+6NOn3+jBJni7tbe761quwFJRUQREmp3XfhJT7U12SNt8kBX739tmxtADPWvzd4VHXt8n9FsUrpfGTNz4tHdV7yIPjydVYboRaGvjzMA/kA+2fy5SdodU+yZbcUIK0ok2wu24OVO77FH9AtedDWDUbgTcQHsYPlOuP05Pk130OEXqx5aIec5h09PPJW8AAiuCMLPWvuYELLTpOiwzRD1BRBrp1NDLyW/funWyc7Cn1VXtBxPhkhXLwyYeFrJVkl2t9QbMnIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=05TJtakidhN4GrI1voZF75Zu2PsISqIJIE+BOFM2Mw8=;
 b=B9FzLGUnxSaNUtFEOhYq8f/DxkXbwr0UcFcc8AY7Q15onXUl4XZrpwZyMhaPcwB7QYjbNLP/HvJFMx4zY7AjY171nAmOL9t0rBV5ulN3zEfGqDl19rWI1Bk9pTotnNDhMDWDsrNoOQed2I4W110K2rjyzz2eLdlPecG0TlxE4eVh4ciDeBi6ehfLm/v5P+AsxSO7OIB2oyi7x8t8noeNC15R1wO9FnV/QzoIsQ/RTaQilYuHLross4YryFeKRjNbmAI8+tMJI1QhizeM71jZcygIOsiA3143qhjnjj/oEyP3wEdwguPMKT7/vrqEwn0lOPPebPdlpCpKottOfvzUjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05TJtakidhN4GrI1voZF75Zu2PsISqIJIE+BOFM2Mw8=;
 b=X/TiSA5E7liSB3xhwnxK3UjUEA/CO5EBQL2XK22my0SuOD0RDXZ4Hy5dvf4j5tKNQGSPwvwexMHVzOJcYMA0GCMUHn5zRGCD7ii5ZfnSbnNbSN2qdD3M0f9/pXS9u37fRP0tU6LV/4xrwJycipPoOt7VQwopS7pOqhs62e5z6cI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY1P286MB3295.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2e9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 02:08:32 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 02:08:32 +0000
Date: Wed, 21 Jan 2026 11:08:30 +0900
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
Subject: Re: [RFC PATCH v4 13/38] PCI: endpoint: pci-epf-vntb: Support BAR
 subrange mappings for MWs
Message-ID: <knk66iqsisdbnk5garkb7773y52xzjojyudf2immryp56ljabn@m3gxtrs5447e>
References: <20260118135440.1958279-1-den@valinux.co.jp>
 <20260118135440.1958279-14-den@valinux.co.jp>
 <aW6TY7rVM6aTnfyO@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aW6TY7rVM6aTnfyO@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TYCP286CA0265.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455::17) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY1P286MB3295:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f7729b3-01e0-4553-cc66-08de5891f9f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q8OSkmpVUg9/hNW/Nx+TxMDo6s83OQqbWzvrxWgeG36BApuFLaJEVsIksOav?=
 =?us-ascii?Q?KzcuIv3qUVfLyDpN3Sk+9Smbq5Agyd2e1PeYIb3OUoB8xGkVLze6UAnv5owB?=
 =?us-ascii?Q?xRCmg+Q5DLV0OQ7NUvBS0P9JJCKe6GIdaJE93dnf5zdFrCh/VUapQewjLckA?=
 =?us-ascii?Q?7bwl2yssGPyTktKnr17l8cxyD9nJl4heFFtpkx5jbUS4WjIC2p4AOK/3WkVs?=
 =?us-ascii?Q?W8mLDG5qTghzrlcMlr89ECM/jcyyULGGVZBelXRH+rkut6qtld0z+EODEfEC?=
 =?us-ascii?Q?YGm7dgSzj0vb6Cj1/wA1xPhVGs2tG3QrQRMgYxhv+92xs7imuafVBVN+vW6B?=
 =?us-ascii?Q?ezjOYZTeGZ/gd0HFM3gLs5GrU12QUOyLYWnPkGUbmDgvdaW75wJ6t2lk1PsA?=
 =?us-ascii?Q?5X+yUzuwrqMmfX4bDAstNcrZ/CTFVgiq6vvF5OtbLktkpy4rpv1998zZbt+O?=
 =?us-ascii?Q?nxPzmZUmn/G5uMYMut03VQeRHpmTQl+bII3qoob8hZgOXnfmOanpNBOk4Pb8?=
 =?us-ascii?Q?OoeOKd6q4ezHjm5r41VsMbXx3dV8ECsWB5xFafDCsiIvm3LfNjOrLKuYa58e?=
 =?us-ascii?Q?BrVCFClfghToG6HcqZ/Xvjn8t7/ae0BoP9kSHWi4hTnWLuIzIpYq0Ud8V13R?=
 =?us-ascii?Q?GiAphcrIwMgHm6A5d5zh6PJrwzhAhSo7M2YOYBJdLExRNaM2+dwk6T29oeGR?=
 =?us-ascii?Q?Zm8KUPLvHWcdyGRTPEKOo5BUDRdmzQ300MZSBIq80UcDwmZfGXGrqZ3nGS5e?=
 =?us-ascii?Q?a2uE7fke7TpeoBnmbDEIAkY3wFgt1qdVkkXFXMS5Fvp6qBqr97E6h0k2i5uI?=
 =?us-ascii?Q?MZ735bmpOI8rXHHceqJObaTR8WesDHJX1WZ58/HfMidFbhJ/r1BdmKT+P1Bb?=
 =?us-ascii?Q?HP/Lc5NQuscfD+/RIovCpbRgW9i8KlVkxqnTuxjyM0qWwHhR5ah0i2MT40BV?=
 =?us-ascii?Q?Ny94GO9srtidKCvSuC40gw2b+VSPADxgL4ncihbyNd0HxrA7+FGs7C72QVDa?=
 =?us-ascii?Q?PDvEzT+UmTPseXqNYoGBJ8a04EPFtmz1Fixmb4snr+YppFgLF/6EDdwjZZcu?=
 =?us-ascii?Q?zAWGzosY0xGFF7w2t+C7XlPbGUJn+SDvEuQ5NGoXTHbnN0T/FoEMJcCq04dr?=
 =?us-ascii?Q?RoB/1OY4u1NbSkGhW3t9lvDYqPt8jsrqrNfvsex4qgx+VKBjE7ml0j32DfeJ?=
 =?us-ascii?Q?M1Xpwwz7d5ekzXVsYJ01mfpsuANE3LF47fKCfM59CfkuYbM9zu1IDmbZqzlt?=
 =?us-ascii?Q?Y+2ogqRxEEVJb0vqGdTN0QMsaM6m/fLt9JnHxaUGrr+aXOOdPiVEgRxv35vS?=
 =?us-ascii?Q?l4sL1+/mdo0hCtHgRjNXyqLte9v4Lpsyll8RX3yk7RzmQzgGnzqaW7bqBURG?=
 =?us-ascii?Q?J+Zjwflktjj3KQ5JlSSi5XH5LccCe0zjcgc6hxqgXIQ73RzgMbL1kN3dv6eE?=
 =?us-ascii?Q?n2nNg5UjdJgB5rzzGMkIcEdBo4aWIXAOibs7UaVKp0lHR0CrIZd0p3VjPPaD?=
 =?us-ascii?Q?gAOlD8Iy+lhFKQ10qzirvvVFd93viQ+5s5ofNgF7OHgeqlEcVrr2dWs3rTf/?=
 =?us-ascii?Q?Li2zhtolXLz0eHmY1hE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(10070799003)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Dns1pNAAnyKUs1YKMFpKgrex/0yjYTCPpF4dl21qbJXa8WaWUJnJYlYhZnwa?=
 =?us-ascii?Q?n2xFcKgz+ThY2P5/tWcMRyMhd53/sl0fcEdJgqhub9rxq+vHBCtvjkneQaoZ?=
 =?us-ascii?Q?MeU9qlSQbVoiGYD6QzCLvnrmx7G4rHjgFoNf8OUqJu4A38ThGqxeRAe+or+I?=
 =?us-ascii?Q?Q3w0VKJiQl9PYkiCkZm2ZGS5NAZ13SnH4RjbMKCZzE00iklBn334puY4qSzk?=
 =?us-ascii?Q?N72gnnQqBbk9wJ5N6I4D6ucxhDwFaA8mCcQ5doq/S0Bz/uQSG09dy6vuD6vK?=
 =?us-ascii?Q?HsTaTE1NC86ArvbA4yzFJwZNsOCx/Pl8fAvYILw7ciPvmtyVPVbF5UhVNedl?=
 =?us-ascii?Q?9KVGIA9sztRiyaEYmo7pqooXqRCHY9nWrJUmFhZaJmMhvlHAv8F+Cjx5Bxn3?=
 =?us-ascii?Q?U+JmO0RVDgoIZnNNUqJ1bTVfc/NMBdQT0QRaXi3QfvQJlLAq5nQlt23poTtb?=
 =?us-ascii?Q?evHB76gRGAORomlY+we4J40m2jBI3PUNm/TVWeglMn9Z97HvPCnx5o5PA6Gi?=
 =?us-ascii?Q?ymPvl0L+COK2H4yXxw7lC7AY3zx2+8GjgeyzFWnTAD+4lqllL7AFUxz1wvo2?=
 =?us-ascii?Q?gE+y53Uo8VqatqapA1/B+E3z48N+zxV96jd0Z89r2gMewoRzrvV6wV/y2f8K?=
 =?us-ascii?Q?kR2cGVMFZyhh36UEzCS5bcTTSBV6FTFbdk/KzEk9t9gkPTjPJKP9yX8L4Zmk?=
 =?us-ascii?Q?47uNVe4Db7EAvXxPA9calTAZzuRk0ww+LNberviFwIg8LJrHTOuz4M+7JwrH?=
 =?us-ascii?Q?EWF/Ox9BrMW6ZpvpHnyZL/RY+k6grgBc2KpLUhs0DAeS4bk3Goq5YZ6BwD2a?=
 =?us-ascii?Q?suUNYn5UVBZSYnMEyhQ5Z5JGyaZrVa5K1ZTqInVmkimgfUh+XQvDEFBYzLB3?=
 =?us-ascii?Q?4FD5t2zkJkd3zkO66TTDHkCxlwKC969OaHlHfSefFhHJ7Ecfbzr2o0RwOfoI?=
 =?us-ascii?Q?NJwv2I4fpm8w/u50BWMLF9BNfsJOjgbZxJVJge72K9LV8IOPDiivACexHSdw?=
 =?us-ascii?Q?C1VEBpzZO607OpnsVcOPjNqb/v83F64TP5oIAxg0Ze5/t6UQ/jvpS0n9Ybhs?=
 =?us-ascii?Q?QqM6VN/O1YF3UEtWLwA6VBp+ASmofD/WrELeHdeEEoV4DtqkFbmXl6AzolTO?=
 =?us-ascii?Q?DuN4iguQaS5L4gBMA8sC/PSoaIVzc5NeNvCaRw3HFurceA8oEA65zsNabYRw?=
 =?us-ascii?Q?icPFB31qVo0BAsOI+/Nl/RwOIsTFZ+VfHs8rr+1w2a+mY12SlueXWdOmQklN?=
 =?us-ascii?Q?qT58tPtyDxPtBNl5gIL/J8eYGRZXYG7QoWJ071C1mRsz8txxCVa1uacsiees?=
 =?us-ascii?Q?1z7+TDWp8LNMrN+PNlXgiNNjr+1WR+mwLdrUD9XWg5Kon8OaOviYXWnFXaI+?=
 =?us-ascii?Q?F1ty443/tsfOu79cKidaBnrL249soUIpIzjvcSmFxa/nf6Ryrj4gMMHmR1DV?=
 =?us-ascii?Q?N3VHSLbXycRvqdJCFZD5Be7GLAvHnGHpgc8Bhwm4VKX8PdIoOihU9t6WOQkN?=
 =?us-ascii?Q?laAhoHQDScn4mfLmz4/Zc1PjBJ9glNN5Wc/qxNJZHh1dYRjfveNbLgrJyTuc?=
 =?us-ascii?Q?sL4m1Ks4rLR+WXTt22/hG0wYWog3n0YhFAkl9CHCsGhpVQ7UuW/19lujDu9X?=
 =?us-ascii?Q?Os25/rcHT8DNWFHEuw4rbXSNlDHW8yEcZxKXtjnoIH+fJypLh8u2oAohQh9+?=
 =?us-ascii?Q?jHqhwjuVYPVqRpNVGxxIrgUY5jFy74VY0bDtKqHM7uWOZMBur7l28Mk0dwVH?=
 =?us-ascii?Q?bk1OAkDYysPzcJXKI1GYa5Ct/Y9NhFserW5a5mrl6jfPT/Ip+PyR?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f7729b3-01e0-4553-cc66-08de5891f9f6
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 02:08:32.1639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7EDEeNO0IRyXj37oiC3EeCm1l6zck1jiHo09vf+zVzz5Q0FPRlvEmIuc0DAPxsyTztC9O+yQg9qcRahHqc0RbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1P286MB3295
X-Spamd-Result: default: False [2.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8415-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:email,valinux.co.jp:dkim]
X-Rspamd-Queue-Id: 6214F4F878
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jan 19, 2026 at 03:26:11PM -0500, Frank Li wrote:
> On Sun, Jan 18, 2026 at 10:54:15PM +0900, Koichiro Den wrote:
> > pci-epf-vntb can pack multiple memory windows into a single BAR using
> > mwN_offset. With the NTB core gaining support for programming multiple
> > translation ranges for a window, the EPF needs to provide the per-BAR
> > subrange layout to the endpoint controller (EPC).
> >
> > Implement .mw_set_trans_ranges() for pci-epf-vntb. Track subranges for
> > each BAR and pass them to pci_epc_set_bar() so EPC drivers can select an
> > appropriate inbound mapping mode (e.g. Address Match mode on DesignWare
> > controllers) when subrange mappings are required.
> >
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 183 +++++++++++++++++-
> >  1 file changed, 175 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > index 39e784e21236..98128c2c5079 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > @@ -42,6 +42,7 @@
> >  #include <linux/log2.h>
> >  #include <linux/module.h>
> >  #include <linux/slab.h>
> > +#include <linux/sort.h>
> >
> >  #include <linux/pci-ep-msi.h>
> >  #include <linux/pci-epc.h>
> > @@ -144,6 +145,10 @@ struct epf_ntb {
> >
> >  	enum pci_barno epf_ntb_bar[VNTB_BAR_NUM];
> >
> > +	/* Cache for subrange mapping */
> > +	struct ntb_mw_subrange *mw_subrange[MAX_MW];
> > +	unsigned int num_subrange[MAX_MW];
> > +
> >  	struct epf_ntb_ctrl *reg;
> >
> >  	u32 *epf_db;
> > @@ -736,6 +741,7 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
> >  		ntb->epf->bar[barno].flags |= upper_32_bits(size) ?
> >  				PCI_BASE_ADDRESS_MEM_TYPE_64 :
> >  				PCI_BASE_ADDRESS_MEM_TYPE_32;
> > +		ntb->epf->bar[barno].num_submap = 0;
> >
> >  		ret = pci_epc_set_bar(ntb->epf->epc,
> >  				      ntb->epf->func_no,
> > @@ -1405,28 +1411,188 @@ static int vntb_epf_db_set_mask(struct ntb_dev *ntb, u64 db_bits)
> >  	return 0;
> >  }
> >
> > -static int vntb_epf_mw_set_trans(struct ntb_dev *ndev, int pidx, int idx,
> > -		dma_addr_t addr, resource_size_t size)
> > +struct vntb_mw_order {
> > +	u64 off;
> > +	unsigned int mw;
> > +};
> > +
> > +static int vntb_cmp_mw_order(const void *a, const void *b)
> > +{
> > +	const struct vntb_mw_order *ma = a;
> > +	const struct vntb_mw_order *mb = b;
> > +
> > +	if (ma->off < mb->off)
> > +		return -1;
> > +	if (ma->off > mb->off)
> > +		return 1;
> > +	return 0;
> > +}
> > +
> > +static int vntb_epf_mw_set_trans_ranges(struct ntb_dev *ndev, int pidx, int idx,
> > +					unsigned int num_ranges,
> > +					const struct ntb_mw_subrange *ranges)
> >  {
> >  	struct epf_ntb *ntb = ntb_ndev(ndev);
> > +	struct pci_epf_bar_submap *submap;
> > +	struct vntb_mw_order mws[MAX_MW];
> >  	struct pci_epf_bar *epf_bar;
> > +	struct ntb_mw_subrange *r;
> >  	enum pci_barno barno;
> > +	struct device *dev, *epf_dev;
> > +	unsigned int total_ranges = 0;
> > +	unsigned int mw_cnt = 0;
> > +	unsigned int cur = 0;
> > +	u64 expected_off = 0;
> > +	unsigned int i, j;
> >  	int ret;
> > +
> > +	dev = &ntb->ntb->dev;
> > +	epf_dev = &ntb->epf->dev;
> > +	barno = ntb->epf_ntb_bar[BAR_MW1 + idx];
> > +	epf_bar = &ntb->epf->bar[barno];
> > +	epf_bar->barno = barno;
> > +
> > +	r = devm_kmemdup(epf_dev, ranges, num_ranges * sizeof(*ranges), GFP_KERNEL);
> 
> size_mul(sizeof(*ranges), num_ranges)

Will update.

> 
> > +	if (!r)
> > +		return -ENOMEM;
> > +
> > +	if (ntb->mw_subrange[idx])
> > +		devm_kfree(epf_dev, ntb->mw_subrange[idx]);
> > +
> > +	ntb->mw_subrange[idx] = r;
> > +	ntb->num_subrange[idx] = num_ranges;
> > +
> > +	/* Defer pci_epc_set_bar() until all MWs in this BAR have range info. */
> > +	for (i = 0; i < MAX_MW; i++) {
> > +		enum pci_barno bar = ntb->epf_ntb_bar[BAR_MW1 + i];
> > +
> > +		if (bar != barno)
> > +			continue;
> > +		if (!ntb->num_subrange[i])
> > +			return 0;
> > +
> > +		mws[mw_cnt].mw = i;
> > +		mws[mw_cnt].off = ntb->mws_offset[i];
> > +		mw_cnt++;
> > +	}
> > +
> > +	sort(mws, mw_cnt, sizeof(mws[0]), vntb_cmp_mw_order, NULL);
> 
> Can we require mws_offset is ordered? So needn't sort here.

Yes, by adding an ordering validation at epf_ntb_bind() time, and
documenting the constraint in
Documentation/PCI/endpoint/pci-vntb-howto.rst.
The sorting was only added for convenience, and there should be no strong
technical reason to support arbitrary MW ordering.

Thanks for the review.
Koichiro

> 
> > +
> > +	/* BAR submap must cover the whole BAR with no holes. */
> > +	for (i = 0; i < mw_cnt; i++) {
> > +		unsigned int mw = mws[i].mw;
> > +		u64 sum = 0;
> > +
> > +		if (mws[i].off != expected_off) {
> 
> can we all use size instead 'off' to keep align with submap?

Yes, will rename it.

Thanks for the review,
Koichiro

> 
> Frank
> > +			dev_err(dev,
> > +				"BAR%d: hole/overlap at %#llx (MW%d@%#llx)\n",
> > +				barno, expected_off, mw + 1, mws[i].off);
> > +			return -EINVAL;
> > +		}
> > +
> > +		total_ranges += ntb->num_subrange[mw];
> > +		for (j = 0; j < ntb->num_subrange[mw]; j++)
> > +			sum += ntb->mw_subrange[mw][j].size;
> > +
> > +		if (sum != ntb->mws_size[mw]) {
> > +			dev_err(dev,
> > +				"MW%d: ranges size %#llx != window size %#llx\n",
> > +				mw + 1, sum, ntb->mws_size[mw]);
> > +			return -EINVAL;
> > +		}
> > +		expected_off += ntb->mws_size[mw];
> > +	}
> > +
> > +	submap = devm_krealloc_array(epf_dev, epf_bar->submap, total_ranges,
> > +				     sizeof(*submap), GFP_KERNEL);
> > +	if (!submap)
> > +		return -ENOMEM;
> > +
> > +	epf_bar->submap = submap;
> > +	epf_bar->num_submap = total_ranges;
> > +	dev_dbg(dev, "Requesting BAR%d layout (#. of subranges is %u):\n",
> > +		barno, total_ranges);
> > +
> > +	for (i = 0; i < mw_cnt; i++) {
> > +		unsigned int mw = mws[i].mw;
> > +
> > +		dev_dbg(dev, "- MW%d\n", 1 + mw);
> > +		for (j = 0; j < ntb->num_subrange[mw]; j++) {
> > +			dev_dbg(dev, "  - addr/size = %#llx/%#llx\n",
> > +				ntb->mw_subrange[mw][j].addr,
> > +				ntb->mw_subrange[mw][j].size);
> > +			submap[cur].phys_addr = ntb->mw_subrange[mw][j].addr;
> > +			submap[cur].size = ntb->mw_subrange[mw][j].size;
> > +			cur++;
> > +		}
> > +	}
> > +
> > +	ret = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no,
> > +			      ntb->epf->vfunc_no, epf_bar);
> > +	if (ret)
> > +		dev_err(dev, "BAR%d: failed to program mappings for MW%d: %d\n",
> > +			barno, idx + 1, ret);
> > +
> > +	return ret;
> > +}
> > +
> > +static int vntb_epf_mw_set_trans(struct ntb_dev *ndev, int pidx, int idx,
> > +				 dma_addr_t addr, resource_size_t size)
> > +{
> > +	struct epf_ntb *ntb = ntb_ndev(ndev);
> > +	struct pci_epf_bar *epf_bar;
> > +	resource_size_t bar_size;
> > +	enum pci_barno barno;
> >  	struct device *dev;
> > +	unsigned int i;
> > +	int ret;
> >
> >  	dev = &ntb->ntb->dev;
> >  	barno = ntb->epf_ntb_bar[BAR_MW1 + idx];
> >  	epf_bar = &ntb->epf->bar[barno];
> >  	epf_bar->phys_addr = addr;
> >  	epf_bar->barno = barno;
> > -	epf_bar->size = size;
> >
> > -	ret = pci_epc_set_bar(ntb->epf->epc, 0, 0, epf_bar);
> > -	if (ret) {
> > -		dev_err(dev, "failure set mw trans\n");
> > -		return ret;
> > +	bar_size = epf_bar->size;
> > +	if (!bar_size || !size)
> > +		return -EINVAL;
> > +
> > +	if (size != ntb->mws_size[idx])
> > +		return -EINVAL;
> > +
> > +	/*
> > +	 * Even if the caller intends to map the entire MW, the MW might
> > +	 * actually be just a part of the BAR. In that case, redirect the
> > +	 * handling to vntb_epf_mw_set_trans_ranges().
> > +	 */
> > +	if (size < bar_size) {
> > +		struct ntb_mw_subrange r = {
> > +			.addr = addr,
> > +			.size = size,
> > +		};
> > +		return vntb_epf_mw_set_trans_ranges(ndev, pidx, idx, 1, &r);
> >  	}
> > -	return 0;
> > +
> > +	/* Drop any stale cache for the BAR. */
> > +	for (i = 0; i < MAX_MW; i++) {
> > +		if (ntb->epf_ntb_bar[BAR_MW1 + i] != barno)
> > +			continue;
> > +		devm_kfree(&ntb->epf->dev, ntb->mw_subrange[i]);
> > +		ntb->mw_subrange[i] = NULL;
> > +		ntb->num_subrange[i] = 0;
> > +	}
> > +
> > +	/* Not use subrange mapping. If it's used in the past, clear it off. */
> > +	devm_kfree(&ntb->epf->dev, epf_bar->submap);
> > +	epf_bar->submap = NULL;
> > +	epf_bar->num_submap = 0;
> > +
> > +	ret = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no,
> > +			      ntb->epf->vfunc_no, epf_bar);
> > +	if (ret)
> > +		dev_err(dev, "failure set mw trans\n");
> > +
> > +	return ret;
> >  }
> >
> >  static int vntb_epf_mw_clear_trans(struct ntb_dev *ntb, int pidx, int idx)
> > @@ -1590,6 +1756,7 @@ static const struct ntb_dev_ops vntb_epf_ops = {
> >  	.db_vector_mask		= vntb_epf_db_vector_mask,
> >  	.db_set_mask		= vntb_epf_db_set_mask,
> >  	.mw_set_trans		= vntb_epf_mw_set_trans,
> > +	.mw_set_trans_ranges	= vntb_epf_mw_set_trans_ranges,
> >  	.mw_clear_trans		= vntb_epf_mw_clear_trans,
> >  	.peer_mw_get_addr	= vntb_epf_peer_mw_get_addr,
> >  	.link_enable		= vntb_epf_link_enable,
> > --
> > 2.51.0
> >

