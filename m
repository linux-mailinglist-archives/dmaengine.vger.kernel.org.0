Return-Path: <dmaengine+bounces-6938-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AEBDBFF83A
	for <lists+dmaengine@lfdr.de>; Thu, 23 Oct 2025 09:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C31C8358B79
	for <lists+dmaengine@lfdr.de>; Thu, 23 Oct 2025 07:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78AE2DFA2D;
	Thu, 23 Oct 2025 07:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="ubyZfJb2"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010016.outbound.protection.outlook.com [52.101.229.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0B22DEA78;
	Thu, 23 Oct 2025 07:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761203971; cv=fail; b=Ha9oUQk6scImcEUVQcnCzZ74sPYy9ivAJjxOuy8fjcidRlXaBe1dlivzM6wVQJvtGgSrUXtiIdR3GD5UhdgCgm7Q0Qoymp4CqaKbDVjThVlln6469t4Vj7qzcxvufXqxMqIJs6fWyaHkue5alq5vp7BD+WOpLQR4MuBI8rwTF0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761203971; c=relaxed/simple;
	bh=2nUA1zCGpabdSGOuh2wWne0BwiG/Kh26sCnNrLWPgrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SK6Axx6WAp2vEIVk2YrQvHvJuOo+3yeabeC+MeWRCFBxTG7MEH98lHZs9i0FH0atRA0WKAcwY21TyZLwPf1pwzAOgPjeNjmebH+OBnWITOYOydxpEpH0BPHpE3t71TamMISVXe++lb9TpOALKhcIfiHUxsQ3uuhAe2XlZARX16U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=ubyZfJb2; arc=fail smtp.client-ip=52.101.229.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rDExRlG+UyyGLiM0I4r3Q2GSRp5GT6ozozlBKVbBWj7yIPzXla33FvSfLXXK0DfjuYZIMX7lx6jfPrn0rnvTIxeWcnzg4LMSC6sVD6ct1wcQAzBW5zbPDTxBwtx8jXv8AdsTaDikIX64rKL0puqArHf9YKK2+kyDQueNiNxXMem/lIJSnRd8exrD8x1mmjnzASZH64M856Uab4drNF1VBhD/xh0QPK3aVTunu/nt9jg/MkZL6qFZoF7rOUyhvwOC08OqqwVRkc0UsQKbMa/96ajBGu0P5MrnFqVhSDthIWlR47+kk5jz6Uqw6xMillcZPaqP2aghO1C+sychsnJK0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FhIuzA2RPUAu4BgyrY1Eb8OqCdUGvZHg++B5Ffmmt7g=;
 b=eEwKnns+kwkn775PBsasTBJ6NN6E/L1WseEu9GMMvSbA6qHQW4VrF4Es4oOJQHdQECVSN6l0knjSv/xwcygFVYVCTQ3LpEm7L0eh7oe30FPZxvDCuyFHuBJoXhjAWrvEKdqu6M5p264RRwUhpibf0JPU/YRAlt8VAImsgfefyyEv+9S3EKZoczxhesug6OFYvuyL/AcyQshTR6kp32DcOMSWUUvc/taHo9IZAw56HhQnP6Nin3EVc0eT/doMf6SUTsgl8Exc/EyyaSDozlHKpTv+UFDkj7pLJpFyGgIqtKI++GY8daSucqMtXvGSHsSid9LRJyTtcQYgemWrfsd6Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FhIuzA2RPUAu4BgyrY1Eb8OqCdUGvZHg++B5Ffmmt7g=;
 b=ubyZfJb23O3Aw4XsXO/MRaZOT9D9H18DNQdATlf+2mEaiT7BtCJr4Rf0/NVjyNduT5wCOFBVVf5C0BsCQt2L16G6bw7eD64ePFgwwpLPQqBUJvh9TRgnu6IRSCWQj0UtbgWpy/pfZy4RMBf8sDUXXRUcx1o0yqzz7UtdswHjoss=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:10d::7)
 by TY7P286MB5387.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:1f3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 07:19:25 +0000
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a]) by OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a%5]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 07:19:25 +0000
From: Koichiro Den <den@valinux.co.jp>
To: ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: mani@kernel.org,
	kwilczynski@kernel.org,
	kishon@kernel.org,
	bhelgaas@google.com,
	corbet@lwn.net,
	vkoul@kernel.org,
	jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	Basavaraj.Natikar@amd.com,
	Shyam-sundar.S-k@amd.com,
	kurt.schwemmer@microsemi.com,
	logang@deltatee.com,
	jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	robh@kernel.org,
	jbrunet@baylibre.com,
	Frank.Li@nxp.com,
	fancer.lancer@gmail.com,
	arnd@arndb.de,
	pstanner@redhat.com,
	elfring@users.sourceforge.net
Subject: [RFC PATCH 03/25] NTB: epf: Handle mwN_offset for inbound MW regions
Date: Thu, 23 Oct 2025 16:18:54 +0900
Message-ID: <20251023071916.901355-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251023071916.901355-1-den@valinux.co.jp>
References: <20251023071916.901355-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0094.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37a::13) To OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:10d::7)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB0979:EE_|TY7P286MB5387:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a5881ee-fcc4-4618-4852-08de12047f3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oaPAhRc0EkdLE4eKJ1H4pIqlFQsph5oIUSPe14XFnZmkP7VaTufUWzfYThPT?=
 =?us-ascii?Q?7vEJty6KpfZo6YO3d3ktg6NaCHK8/5VAiZBEeO9rkMoQzek6AFNoh3pxfumL?=
 =?us-ascii?Q?mx9U4gjHOw8E0RvACqn/bBDH8eWVMy+Yhb+v6pLqrACA8dRY2hNH6GXyL3SJ?=
 =?us-ascii?Q?m84ZJrxKkhcpXZ2f8gPgjf/cMSPvizjVR+SbH0GReRlbavKomI42AOh/Jfrc?=
 =?us-ascii?Q?3i+hq/4XVaTT7e+AljlgqLK7+Ez2SDeDhOT2SVkchgJaAd3KRlIDmBP+e+SJ?=
 =?us-ascii?Q?fyH0AkNdMTdKZbrsqknERuqhRQ9UKD419x9pZ0e4mkgdN6nWpiF9PeCg3qIs?=
 =?us-ascii?Q?rX38PrW2UTJJcW/+VJ7KuyHZZwkh4uQstKX8jDFceu3QLi2966mx2D/YXisQ?=
 =?us-ascii?Q?uCFduDBJklcwNpJBVmNIqxNqUfBBmC+dC+bp3GI2H1fTPU0HPVSfgtbgzbd1?=
 =?us-ascii?Q?gzO6cEBPt0gVndzUrb23e0TFIeatxNVd3rWsJ/5yzBxGIpALM6Aeu2QiJse4?=
 =?us-ascii?Q?htlYZ1+Cv6Ku/ShY5SP00/ln90hejPUfhJFJZ3O3lusfSVEZFGMCod48+Di6?=
 =?us-ascii?Q?/n2Bl459+nMN/ZUmIKF10LnFD8nSoBy1LNiUX+WdM8gTTGBNsYf5Y/PWmyKP?=
 =?us-ascii?Q?wk1r5nTkdR+Iq3P1f2dX9S+Es9kS2QITmZO8t9lbNyOe9nw2Qt/rh8l+/3Y0?=
 =?us-ascii?Q?rX/oqDp0JBS6zooxQDmHAPDLFwEMPOEFgUvws3ncTludZeCn7Z1VdiNTs2oh?=
 =?us-ascii?Q?rVmDJbIflXPPyy+QqjImBaKdpMjkmgPX/X78/Zn06zyvHDeiTMNL5JvMr60d?=
 =?us-ascii?Q?mBCgvrKGKRhmhUf/M21LsWZiz7V84aheIHDZ+SbBqIAsTGTNOF/hCCKWoWuO?=
 =?us-ascii?Q?yIU/Iffv+602MVkWGeT7s95z+b75D66+JhzDZ091m6CZchYUjj2UrXZpZ/lN?=
 =?us-ascii?Q?EzGcPf9VtgDVkpwGvKU1Y40ofmGuxwBkPsOg/zI7/Nv4Fkh0nHm3u7LkDg9x?=
 =?us-ascii?Q?xm0MdBXjzVSP1MH0vdTNvXI7CJNt7dEvjTtKldzZBxSKHrHQLEIjVoavRDpb?=
 =?us-ascii?Q?tYJslCZhUR+Np5m7S630G+ab8oslQxrV/6UncHtOTZBClnK/0mrNtECRUhY/?=
 =?us-ascii?Q?+le46q7Q3OtgbQVf/RLvlS8aJgKeC5gYP2WLA8KQPxiGKQ0sx2gZbgHREqDm?=
 =?us-ascii?Q?I71llvSxP8mZ99RZjjBwWvrLLMSeJedoJ3n5utwDgkPSgw1KbppiofoZR3ES?=
 =?us-ascii?Q?JFW5ngJQbVQuj7198bN7n7dl56cZZRymPT928BaiFLLzUl5Rw2ueJ4uVdPry?=
 =?us-ascii?Q?VfMpEjyTWFET2okYJ6tV6Zf1TylVymzq255bfPI6Fe/2DSw+LpgeemfbMfPd?=
 =?us-ascii?Q?jX5Iew3NIxxsr4RRt7hS3JLOecA47vAbmlJ/sC+1LROgGIrdyQPdb2n/Ajez?=
 =?us-ascii?Q?xNX7ovR17pvFjqa+c8hWonieybvkTcaW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?261+Slxg+vWUTowBuZQxXSY6lw6uVcyIMe9Be2Q2BpWSZFuuyyM1cCxXH/cU?=
 =?us-ascii?Q?tFnkOI5gaBaVilwwLdKvOjv2KaEiSJE4Yy8PDPkNlRbv16dOUurijH5IlVMo?=
 =?us-ascii?Q?nibUY22qQjWodXi9Z7P6ksjsWyuOUCaGzO+CP80X/WfJfn8C1iPHdNIFtFeb?=
 =?us-ascii?Q?daU9tmkn5B1SMamPgykbtQpnom+bOiSPjlORvqZVTTI1T4D8i6AWfkQqqrFb?=
 =?us-ascii?Q?MEkJBDauII1W3G4TaM6UMlmHX1wAtt6MWkJNGlDv9/c2BazbNc2DO7quJxgL?=
 =?us-ascii?Q?yDqIpKP+SCKEByUKughCdEZrEHgt2xhQh+4Z1qvcdcXuFyQ8Wpyo0a9Puhom?=
 =?us-ascii?Q?eQ0GcLroVIzJEG4gvI9fXkIJqRKppcJU8xXR0CabPoHJBuyP9NpjYBPsAibJ?=
 =?us-ascii?Q?6C0uqaC0JVWix72SK7Dg+z6S45vvotde09D7XK/8hUXqwkhr4tfzH+MFXa1L?=
 =?us-ascii?Q?zqDBVNs/NR7frvTuI3ENW92LeK9vO8cZvMNZQv8m9/Gj0jEgloFbgfMd9poj?=
 =?us-ascii?Q?wQNPExQo3g+0CVID8ipPxFmxfiLpqySD9/FsDPVys5d9uneVxEtCgCmjE8of?=
 =?us-ascii?Q?t3ofNx3oiEvQYVyluhZIweNp7vcrjx5ix+3qb8uP6QrHlyalJ+oAZ+WdYhEe?=
 =?us-ascii?Q?nEovxb0hWDRpVkq3O/vteNSPW4H39z0zScO8k5kISzhu8fknF7T+6q5+766j?=
 =?us-ascii?Q?6hM6u6gj72Lgp84rMSjCKvBpDt1nwJwWXkZQ1ghpf6cAiP1tyLH4VxiN4Xtt?=
 =?us-ascii?Q?IN6iFdkmVLGZ8vAreWD6ddHF+lngAPRm64WUaEN/YL+Wu6ovitKqG1IQX7ay?=
 =?us-ascii?Q?7oFDBFl6twQFdpTkfJ7+kT8CpHCdpx43MKLJxQHRyOVaZ7dnCUvHWEH/vfXq?=
 =?us-ascii?Q?ksRwCJBgeC0K4VD0nm/pzL7kOA9+yHXI90g4TcDGEPXu42SSH51/YY7COscK?=
 =?us-ascii?Q?fxRwdoeteh707PCBIMTrqpmCE2OOKWzGvZKK8sJCmr/Cc+ph1pIfNEf8eknC?=
 =?us-ascii?Q?TILPm24DjPJ5t3q6rg7KZ81Gqqy3CicDGdEn1B9A1byHbBYe5l000SAmhDXM?=
 =?us-ascii?Q?/rdJ0Taio3gYaa5hxYZ7hiCbMpP6tQX+C1BVBv3g6+ozjFd5KPds7535wank?=
 =?us-ascii?Q?8dYHqIQ2tAyj1XPPnTtVmc5SUhFvbrw2SX9i6bS5IxBM3jxgcA1meUKPpI2t?=
 =?us-ascii?Q?yUDvv/SEAVUWbDEihk5BewO4VZC6Lap23MgS/OXd9Kxu0ME//237B1/aEWf4?=
 =?us-ascii?Q?Fk7PXXMmrG8e1FxCLzZDNya5kJwmx1vgir9X0+xocYrSLJGxSpfrZthG3+ps?=
 =?us-ascii?Q?CdYFfEnUB16oP06S2e1hE0VNMEy9jHznKUMsjZyEtwV9G/y1g7kcQWur3mEM?=
 =?us-ascii?Q?VMIcrsX3bLqQG+n96ODWO7lrTcSZlJMRJgcR6X6dtNEmZ9LfA+be6bHI+tLR?=
 =?us-ascii?Q?AmlBfOD8rObD5/BFmPHoOu8i61xG9AujJDfq2JhFUwpf5P452jxDT0DtJuLY?=
 =?us-ascii?Q?xbtocaXGSfO/+UHMbK1ibOuYT2YEjrpm8COoiIw2LwgKBzCrVYgSxh1Pd0ib?=
 =?us-ascii?Q?77pjsDCkB2tDdMxYJrBgQwkzrdsuG10mLwubeR/XY4RkCM/eCA9tP5f6tjaX?=
 =?us-ascii?Q?vditVNhQchYWtGZF6mRJI04=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a5881ee-fcc4-4618-4852-08de12047f3b
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 07:19:25.8046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: smXErNaZfhBImgS8cHUwBTKJ0dTnrmbqrjm414VWwNDhsAuhbD12Ii78z8/3d0DLNfToF8WpnH0JS6qJium0IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB5387

Add and use new fields in the common control register to convey both
offset and size for each memory window (MW), so that it can correctly
handle flexible MW layouts and support partial BAR mappings.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/hw/epf/ntb_hw_epf.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
index d3ecf25a5162..91d3f8e05807 100644
--- a/drivers/ntb/hw/epf/ntb_hw_epf.c
+++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
@@ -36,12 +36,13 @@
 #define NTB_EPF_LOWER_SIZE	0x18
 #define NTB_EPF_UPPER_SIZE	0x1C
 #define NTB_EPF_MW_COUNT	0x20
-#define NTB_EPF_MW1_OFFSET	0x24
-#define NTB_EPF_SPAD_OFFSET	0x28
-#define NTB_EPF_SPAD_COUNT	0x2C
-#define NTB_EPF_DB_ENTRY_SIZE	0x30
-#define NTB_EPF_DB_DATA(n)	(0x34 + (n) * 4)
-#define NTB_EPF_DB_OFFSET(n)	(0xB4 + (n) * 4)
+#define NTB_EPF_MW_OFFSET(n)	(0x24 + (n) * 4)
+#define NTB_EPF_MW_SIZE(n)	(0x34 + (n) * 4)
+#define NTB_EPF_SPAD_OFFSET	0x44
+#define NTB_EPF_SPAD_COUNT	0x48
+#define NTB_EPF_DB_ENTRY_SIZE	0x4C
+#define NTB_EPF_DB_DATA(n)	(0x50 + (n) * 4)
+#define NTB_EPF_DB_OFFSET(n)	(0xD0 + (n) * 4)
 
 #define NTB_EPF_MIN_DB_COUNT	3
 #define NTB_EPF_MAX_DB_COUNT	31
@@ -451,11 +452,12 @@ static int ntb_epf_peer_mw_get_addr(struct ntb_dev *ntb, int idx,
 				    phys_addr_t *base, resource_size_t *size)
 {
 	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
-	u32 offset = 0;
+	resource_size_t bar_sz;
+	u32 offset, sz;
 	int bar;
 
-	if (idx == 0)
-		offset = readl(ndev->ctrl_reg + NTB_EPF_MW1_OFFSET);
+	offset = readl(ndev->ctrl_reg + NTB_EPF_MW_OFFSET(idx));
+	sz = readl(ndev->ctrl_reg + NTB_EPF_MW_SIZE(idx));
 
 	bar = ntb_epf_mw_to_bar(ndev, idx);
 	if (bar < 0)
@@ -464,8 +466,11 @@ static int ntb_epf_peer_mw_get_addr(struct ntb_dev *ntb, int idx,
 	if (base)
 		*base = pci_resource_start(ndev->ntb.pdev, bar) + offset;
 
-	if (size)
-		*size = pci_resource_len(ndev->ntb.pdev, bar) - offset;
+	if (size) {
+		bar_sz = pci_resource_len(ndev->ntb.pdev, bar);
+		*size = sz ? min_t(resource_size_t, sz, bar_sz - offset)
+			   : (bar_sz > offset ? bar_sz - offset : 0);
+	}
 
 	return 0;
 }
-- 
2.48.1


