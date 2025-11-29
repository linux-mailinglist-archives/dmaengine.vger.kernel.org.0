Return-Path: <dmaengine+bounces-7391-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F09FC94229
	for <lists+dmaengine@lfdr.de>; Sat, 29 Nov 2025 17:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9B2114E360D
	for <lists+dmaengine@lfdr.de>; Sat, 29 Nov 2025 16:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA98E30FF03;
	Sat, 29 Nov 2025 16:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="OaXc8MZ8"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011006.outbound.protection.outlook.com [52.101.125.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2DD30F931;
	Sat, 29 Nov 2025 16:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764432271; cv=fail; b=bWOblcWLj9qW9tLg/LiIKP3nAORd4Jf+G37WhksGstzFqahe1yURnd4ddTR8sbPGywKZIAukS0fYa9o+yObqEy6CvsZhJoyAU7bj0xeTUgtQX8LWgAIihGtKOWVBRUnT14KpO9AyDz4xVHnstq+xJ/y8HCgqLuns3ItLS2HtbyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764432271; c=relaxed/simple;
	bh=T61Cyg7tA7TCZs2r9/jsgpTaONwzx2wELyDbUteM0lw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gKLAFb/dUWTA3XCm3k/2GQZ/U3Ch3eRXcDUZFSM0JUNEF/PWqIcdckaKQCS0c0Br0XhB7tcKx0qhvcZYpOC0yJ8Bt7NBuGZ29Ll4l0vfMjuNvrv+JItGc42AxDi2WpyjYbAocHKobwKn1t4Ugs25PjUu/ilQp41nMlDFOMLTNR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=OaXc8MZ8; arc=fail smtp.client-ip=52.101.125.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DqD9d92gWqajP9E7fYECAfMaklVLqX8hpqkReGkEHo1nsYNKRsM/gm4Y/j3vuxQ+kcuipac8rPd5i44IsCYgTAOlSUg3Lv5QMiCBK87JahbeLMuyosMVOtpDHsOrDafbw1pnPJio3ezUsmLUraCfoBXDZNcRy/xG01wVrptn0hnzGk1EzxjXvPS98gp2rqtALyMjAaTbgN32PbO4rzBDa1cYUEyaRZxdiyamEiF0RoGR2jbcld6HwoCa8/qVAH6BwxDAWhQ3WnC99eSWmGlVyEhY1OBXPJARYViz3GLzQoWD6/kkDoRyO65Sp8kegQ1G099LthXzQtGVS7D/DGIo+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9somTYo/MfCteHoify0p/wRgj1iO2hVSu8rpUxmrUec=;
 b=m7I2V+/ggnYnUBI+wDXIxbrV9EyussXtMDhgZCHGNlSuaw5tdVz7UB8a0Qr8mk/Sm114Ip6rfWOSsZrYrjBIm3CpH9LIpwJncjQFjL6ehsUt286KAY9ALaWjlJtv6qqD6IXkscd6fwYHO8eNg7ap5vsuLhb5WQIzRGyNfyldiafKTQqipjFMdXJA+4i//OyfwGudkf/TYhC12ukqBPM2ExZeRNOOtO3VPpxQ37q/lNmiLUOZTdo6Tu21abVXgdqYVxsNaaSjGKBUxQHVrWZAX6d3aQSvepSr6sl+WPChvN33LDdmhc+HtL6HREoKLhsmxNn9G+Noiw1DMiJa5ftrdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9somTYo/MfCteHoify0p/wRgj1iO2hVSu8rpUxmrUec=;
 b=OaXc8MZ8tKEMZJ3yo1C0xn61ZfjIfINa5GIAERg8UvUYGgWqnKkww2xn6AI2zvRYeogtY5Lan6GCil8IiwHcCNlAiMLtlDIs4yqq5RdBijdG6LBvX8901IBe38bptBmZxhe/4y461xIJ7+XpKKQeOAJpMYr/py9hdcnFActjrjY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by TYCP286MB2050.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:15e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sat, 29 Nov
 2025 16:04:24 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9366.012; Sat, 29 Nov 2025
 16:04:24 +0000
From: Koichiro Den <den@valinux.co.jp>
To: ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Frank.Li@nxp.com
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
	fancer.lancer@gmail.com,
	arnd@arndb.de,
	pstanner@redhat.com,
	elfring@users.sourceforge.net
Subject: [RFC PATCH v2 06/27] PCI: endpoint: pci-epf-vntb: Use pci_epc_map_inbound() for MW mapping
Date: Sun, 30 Nov 2025 01:03:44 +0900
Message-ID: <20251129160405.2568284-7-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251129160405.2568284-1-den@valinux.co.jp>
References: <20251129160405.2568284-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0004.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::9) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|TYCP286MB2050:EE_
X-MS-Office365-Filtering-Correlation-Id: cb0e7384-61f0-489f-7a38-08de2f60f711
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GFOcE3RLNkwcO0lrNrahHnpiLKSBSmDTqyZQpWT8ksDh8DHrVolETY+16r2c?=
 =?us-ascii?Q?8Wwnqwm78n0rYq6Sk/40/En3MRtbOQg1MHUvR3QHtdiYSQT9jUXRG/hnyQn3?=
 =?us-ascii?Q?sqyjr/Bk5Uru6dilVsQliTQKLDyfDxupU9x+WlFmAILfaf9xqNnqift7XanG?=
 =?us-ascii?Q?3KVyWzFhBE8lf3cJaTz3ZkI77uf/tRKjG4IjGNxaolZv9OIp7SwbHT0kDnLt?=
 =?us-ascii?Q?9bfxGvID/ZyWxXIaEjkrKt5XAZuyKIFFjpkXIqAoGKy5/joRdjkgLvKBa9dP?=
 =?us-ascii?Q?MDmCIROM8/yXhbgcyL5ayRT+y1S3HxITNVrTUjRn9Gxy2B+bAvOeBBsCp6Ct?=
 =?us-ascii?Q?VWsnnnnXYURvfovxHLrijmoXYNvQOskFBedeMnQcWTyJ/klxxAP/dfXQcjtF?=
 =?us-ascii?Q?2/6yhuL/C6hMPbXjELReVmfWTHDNih4I4n/OsV3SIVCJu2fCNPvtSALgulQ8?=
 =?us-ascii?Q?c2cKQUH5iLMWh4AlBydSMLZdPGyLxLq++pjHWaHhqJXU/iCT5K3MCmtsmZ49?=
 =?us-ascii?Q?OHvmLZdgf0k1fflBKQLIUx7IQQAresoPiYsJLkPtRyrmT9Pv0U71x73MUdGD?=
 =?us-ascii?Q?ASdKOUkcgWXyJIUShMY23bpRIb8Rvv1+mEoNGKvoy4NxR9/Xa+m2P7rr+VHm?=
 =?us-ascii?Q?NjhqAV1D2t8jVjE/DvzQNIn67dHez6U5Aitb/K09Ozx6jFxCQW3ums7LcVib?=
 =?us-ascii?Q?E0+Erc7iEwbphG9WXMg5RwTiejhtldPuQX8d4prDNkdq8yFFtn9EPRdpvN+k?=
 =?us-ascii?Q?0vlVKRuLV6y683mhMZ1xZx0mHJdI1tDBqLhO35u8Vd2SPwn866KtmvT7Ugq6?=
 =?us-ascii?Q?NBQbKijUx6i2fWpjSTlfCu6SPCD5sZ0NzeXXsLKgsn9hCesvQemSUnGL34Cw?=
 =?us-ascii?Q?vJbxnI5Zbq9Eqr/3Ejde1HrqWN/v4A/PVFKz1JTq3o+kFx1oQ+SqZJJC4T5J?=
 =?us-ascii?Q?57Z3Ga8FuO4gS1ArPxiayCyQnwaLEk1t4M5mB/XhjwdxJjhMAaqWAWq+AFCD?=
 =?us-ascii?Q?ya2BnRKPTFKWvDmxlPTMKk2eeqrA5Nq9jPax6c4FYeGwnzsA5owwmw5htggO?=
 =?us-ascii?Q?/9RkE89dO+1ww/GTD2hTIx99DeHQIfSURe9SDulEzTIuiic5/5Q1NCSKmPSs?=
 =?us-ascii?Q?MxQROBJ9JhVZ3lE1Wvx0XOYsAsIJAE/amL1obRPgwDUXDaSsQj2GtEmuA6kl?=
 =?us-ascii?Q?ILzaQsT8BVt9xpKhI1rTq8SMia3T47bQU1imef6zx7SXwh+ZGtTquEcayDze?=
 =?us-ascii?Q?MNCJGupKwK5lWVyEXgJDUjMVaNHt3eyU5DIIFG4cV0BrqpbJntQMvlEHU6zN?=
 =?us-ascii?Q?Zvn/IEWnQCr8DdMq6k5BJc6fUnnbMY+dXiEUbARtDGG7vaGoKbvtCgKyjdzW?=
 =?us-ascii?Q?R0tB01R9qIgndksUkZWcIryH4iMELGCYz3OBdKg+sys32VET/S2iNfUq6Vmr?=
 =?us-ascii?Q?+hK9SeYAZ8ACq65UrD+nU5cgILOiIfDq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BLs+4/SeeTA/azcq6YV/IssiS9FYqZkjtnlxUieK+lH4xVMgtWu/ynIX0aoU?=
 =?us-ascii?Q?X/mgs1a5u22H53emyst6kbiBFCLwIVIUepO0WX0SvtOIdd9medkcgsTrRFWR?=
 =?us-ascii?Q?Ajo8BHnKtm/KVJOnq1bNM7v5YFAM9u3ujaw7aUuXju/hQ/eZdwUS/k3UAB6R?=
 =?us-ascii?Q?Jjd8oBLptC8oIu9/vl55OoDouliVSqddkG0Z6jfkMRuwCdPNPsYtOwczhq3g?=
 =?us-ascii?Q?g6jNMLleMQdR12CsKnNI0vcauRiwYRZlZQDp6AJcp5XepjjhnNVVGNSc7KSZ?=
 =?us-ascii?Q?1o2KDXWWns/gVtIwZnT9huBXWMiBjqktO+m/cncrFTK8YZ4+Ub5l+r5VVkhB?=
 =?us-ascii?Q?AMB0Qx4Fd1KOPTYq9Vi6BlA0RArYHGwxoB5IDhtduhUwyKviS3uprW951jax?=
 =?us-ascii?Q?clSJk7JhjSXX7QgKyIkWISkhA/SrNdIHrGC7nK+oeYnMHDe4/eQn0cw3jcfc?=
 =?us-ascii?Q?zknnr2MWVjSfYVStloM3ZO0EZ6XJMEH+fTI1bs3VLj7EN3QZCgC1hvsRiM51?=
 =?us-ascii?Q?pYS3+nNJO0I2RdDHCPUPZFVR0qnTiuAIbtyQ6HsLGEHc/h3/TEf9mnzIzFeX?=
 =?us-ascii?Q?uGv96SjgljPv1PAB0KeLQO7OI8D8VUUwTRI7GU3AVBFmYUAE0BtO9GgDQnrC?=
 =?us-ascii?Q?mbCLfhon70FTbSJqphuYxUCXrzy3IM08HirCrautkgod7cjZAXLWG1AgFD57?=
 =?us-ascii?Q?CI7oRW24Qvpzq8WDnPJ0AD8rN5wsZkK9Qy5MOt0KkpYYS4YiR1Wp/KfNGmRn?=
 =?us-ascii?Q?zGvJVaON+6c+henvmYljzLjMiiPAbuoF1TCdKpaYVe3Xdeh1pUIOBpYohcEd?=
 =?us-ascii?Q?4+v05pyzI+oeNryyQ31mo5eTETUvTLu6d0loHufiWck1SXNFZd2BK9fRPWq8?=
 =?us-ascii?Q?/8a7skjAVBkcPOUYiYpktcKRvErO8jb9RO8CXSl9oBh376jGvFx9lhqg8Z6V?=
 =?us-ascii?Q?uUg1LNA997GQq+9rstlTq5pDXuskrPSm27dJTdxw7E4hxBDVlQS3J7s44WCq?=
 =?us-ascii?Q?pAdNj1DwbIHnj7xczScuR+zJ3xBmyi4r+IVMAy6+dlvvKQHHWGSXBdy/3ctY?=
 =?us-ascii?Q?X63P8078u59U0MHGBTVImXBEJjwOxq9SWzL+B2gZBpZ3WN7isjP7VAlOqzd3?=
 =?us-ascii?Q?5Z//lbizvffkjqhjDEtaNstj1G/3cq5C8NaFdCe6O5V6E0WNJxg0yio1rCEc?=
 =?us-ascii?Q?J/m4axcnQSsWzpcu40T6bFuMoB7+FSD+uoRvyv4t/YCdUj4nlYNnddHRH0Wi?=
 =?us-ascii?Q?C/uN67J912KrIx9y2+UOu3IxYMKwdbIreKA7a9w9HD2XT/cgM5wiv72zJsbJ?=
 =?us-ascii?Q?pZWv+FkPF5Oz+iwFyfLZSfns1P5+ObQJFzuSANYfUg8cRWzA1rvc8kOYg/4f?=
 =?us-ascii?Q?jxi/snBjaw7IMw0Vbp/WE3ykhCEtiz9b2lqd8MCwA1Ct1HU2/Wd/GFqox7J0?=
 =?us-ascii?Q?h+FHk3SNbY5Itjwt+T4woE8wow0DPvlEL7MDuXG9T3pR7btimFeiMEaaMhAW?=
 =?us-ascii?Q?dMId5PH6FbAC7w81jNS7v7LNCfDVvzpAv7toyjzH9Lb/+lfJJ23UqYTe3gsE?=
 =?us-ascii?Q?2lQCuRHOZMQuDXwfJiEzTGFrmcM0vXLGDF1DFD869ldwj5vdssBH7Jtk9dBF?=
 =?us-ascii?Q?IFMpSLMzEmKF7T+CQIw6CTQ=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: cb0e7384-61f0-489f-7a38-08de2f60f711
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2025 16:04:24.2376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zk2Rp0OtNUuJrwO9W54RIxAbmsJ6kAzWhpRYUfDy0dV9nyW+0LAbQ20Ca2Fg7as1TgnuMrsD6o+m8VUka8x/6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2050

Switch MW setup to use pci_epc_map_inbound() when supported. This allows
mapping portions of a BAR rather than the entire region, supporting
partial BAR usage on capable controllers.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 21 ++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 1ff414703566..42e57721dcb4 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -728,10 +728,15 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
 				PCI_BASE_ADDRESS_MEM_TYPE_64 :
 				PCI_BASE_ADDRESS_MEM_TYPE_32;
 
-		ret = pci_epc_set_bar(ntb->epf->epc,
-				      ntb->epf->func_no,
-				      ntb->epf->vfunc_no,
-				      &ntb->epf->bar[barno]);
+		ret = pci_epc_map_inbound(ntb->epf->epc,
+					  ntb->epf->func_no,
+					  ntb->epf->vfunc_no,
+					  &ntb->epf->bar[barno], 0);
+		if (ret == -EOPNOTSUPP)
+			ret = pci_epc_set_bar(ntb->epf->epc,
+					      ntb->epf->func_no,
+					      ntb->epf->vfunc_no,
+					      &ntb->epf->bar[barno]);
 		if (ret) {
 			dev_err(dev, "MW set failed\n");
 			goto err_set_bar;
@@ -1385,17 +1390,23 @@ static int vntb_epf_mw_set_trans(struct ntb_dev *ndev, int pidx, int idx,
 	struct epf_ntb *ntb = ntb_ndev(ndev);
 	struct pci_epf_bar *epf_bar;
 	enum pci_barno barno;
+	struct pci_epc *epc;
 	int ret;
 	struct device *dev;
 
+	epc = ntb->epf->epc;
 	dev = &ntb->ntb.dev;
 	barno = ntb->epf_ntb_bar[BAR_MW1 + idx];
+
 	epf_bar = &ntb->epf->bar[barno];
 	epf_bar->phys_addr = addr;
 	epf_bar->barno = barno;
 	epf_bar->size = size;
 
-	ret = pci_epc_set_bar(ntb->epf->epc, 0, 0, epf_bar);
+	ret = pci_epc_map_inbound(epc, 0, 0, epf_bar, 0);
+	if (ret == -EOPNOTSUPP)
+		ret = pci_epc_set_bar(epc, 0, 0, epf_bar);
+
 	if (ret) {
 		dev_err(dev, "failure set mw trans\n");
 		return ret;
-- 
2.48.1


