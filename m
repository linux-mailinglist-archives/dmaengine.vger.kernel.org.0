Return-Path: <dmaengine+bounces-7411-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D9843C942FB
	for <lists+dmaengine@lfdr.de>; Sat, 29 Nov 2025 17:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7FBFC4E7F56
	for <lists+dmaengine@lfdr.de>; Sat, 29 Nov 2025 16:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE7531D37A;
	Sat, 29 Nov 2025 16:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="AvHKzsgR"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011045.outbound.protection.outlook.com [52.101.125.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB8D31A7E6;
	Sat, 29 Nov 2025 16:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764432298; cv=fail; b=kWqK+1Ms84wuPBq4z7qM6EWKXsEAjfWAWV9W5r3xOdzLUfaGjf6Uwoaeq3YKXEajVfhNgkU5a/tbz2a51pRyw9DfL86cWpU1nprltbEuneCy3MF9CYNtI73OZ8ezzQ4J2y2SFzYwpDVJlKH34H+PTAYEONxdQUQ7HBaC7MMUo4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764432298; c=relaxed/simple;
	bh=cXf2nzURuLIj60rrjF6GrKwDt59WhfIPTmEf8HUWO0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=peuvDY7h5eLnDllkkzGufjR0KRMl7iE3tUvP7cOGBzUY0tlOt1dvkqZPLDvqmfw/VnANfWAc2SPKK9A8zpY80QSuL/G7wm673kz1+V9rLbx8LHSSGRzyfa7al6Wjhvw+cM12yIaurpYw9ooa3SwDCkNWbDJvQhwl1uIhE8qx+xE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=AvHKzsgR; arc=fail smtp.client-ip=52.101.125.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E93HFq/I6xM4le4HKnZsLYJE1dkgjrA1Fxr9dYuTajk7rzvwvliDYD3qdj4O4vmVyJdPn/LwZN57Rczr9EhMapuXJPXl6PZxkavUi1uyzfjxelyZG7OmfkdnMGMFzestymxXlEN3vQLFIE3VOZhRfj2Ne33uBZFxXAJ3uF3JdxTh+sRK/djvFNa1EVDZhrIbkocCxAZygWdSHuIwkJUNOjONzs1e8o3gQaWK63QSc1KBuSCRtlGyygr3AV0mrZXq7UiGGgZvrINUDRW5rUUwrErkgsNKkr3aryUsCUREaNrvKlqQ4l/3uBV6hYDP5Ook4cYRqjjMdS8yvLjW7VteXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iGwenDnMcv+IsNtkxt9uOeIW86w+dgwwYEELc5sk654=;
 b=PbwnyIeByVqzsVbNfoaKBuce2iCPFHM4ipMQDhypXAoU3NlHBUf1ucZJ7GMI02GuBFQW3XuhMIgyC6oXOJmNoL5u5QMvpURmlg/bCeAY/bJfbbKzDj79FA+xRuFJEPJiWwV5HS4i7YTKqhlZl3zxEz3WwIUjACh+TpwowdLI+e98+l+UX2dD6OkNig5tmwZqFqN1587kkcwyeeuHT4BjTXnwatgr/w0GbqV907iAKTcRx1+/OyFBn8KAjchJNSwURjoXMYDDTlfQwIaId+z7NaLRiga8uXwHcuxZATeksS3nJGZsbsif/ihKiCtmnJkDCXSXiRoUyT51e/swKw88GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGwenDnMcv+IsNtkxt9uOeIW86w+dgwwYEELc5sk654=;
 b=AvHKzsgRVDtJf41MPLrvQM41zwpZk4MGrY3UWs8GPiZx7EhBpjS2ZLFxURBY7CJ4FMMa5uFMS5ouwjf1bgxUYRnuAVp0YTc9AAmRQDDTpEGOySHNGQ4eVSp/jii1w+3mtgLYBEkkY4miPRS55QKQ4DZxVzoOOW++8KCSuc+sAE0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by OS9P286MB4684.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2fa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sat, 29 Nov
 2025 16:04:45 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9366.012; Sat, 29 Nov 2025
 16:04:45 +0000
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
Subject: [RFC PATCH v2 26/27] arm64: dts: renesas: Add Spider RC/EP DTs for NTB with remote DW PCIe eDMA
Date: Sun, 30 Nov 2025 01:04:04 +0900
Message-ID: <20251129160405.2568284-27-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251129160405.2568284-1-den@valinux.co.jp>
References: <20251129160405.2568284-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0057.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::8) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|OS9P286MB4684:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e8889ed-6ac5-426f-c617-08de2f6103c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ggZsCOi1icYs3hwQxm97MeOz6L/iT/EbGLDfeozfgDkGtom6boRS0RFX1OzW?=
 =?us-ascii?Q?GyrpiT5DxZOCGpwM2uuRdzSVcWy3o15/MAw4QSj5OKNSRTyHR1s9JGe8Ek2Y?=
 =?us-ascii?Q?3kEWfUdK4YLDhI22oYg4VkrxEjXvGMu6izl8VUPLIGbaIW9uwwFXWcFJ1vkB?=
 =?us-ascii?Q?YOWQSFWs7no5H9vs4LZEG+tBAH88Nxphd12YSHzUaiC/5+u2AwZL07lOSeNJ?=
 =?us-ascii?Q?WKWqjAB2wrWycPGJXn8Ubl48XzaO+zktpcq2v0VGVHjRkfwKoX0au1Jy8vJZ?=
 =?us-ascii?Q?qqR8OpqrmTar345VQMGU5UHdsOLyiqbYe7Zj5UHr3lhxkgdwVdIy2P8gEtNX?=
 =?us-ascii?Q?00kgZGMEkKpbdHLAdqkZEOqII4m86Gj4RUyXm8BB9U0PBP2M0kVZg9eNE42h?=
 =?us-ascii?Q?NHDsd/Ecp9S6WN5sxs6SslPuTcjIITMwVFcvaIl+f4ipI2hwJcoHHaPrR1/c?=
 =?us-ascii?Q?lTc0UECogPTCU+orm/1ZrAnkJPF2M3/AfV0byfg0nQ7DjxGWHRrlZQKWr88K?=
 =?us-ascii?Q?Qav7p9pWlE8hbD1vgpEu4kwpOdFgLrmunT66RoT2TQl85puV9KtaCw3mRT1Y?=
 =?us-ascii?Q?UfMUwORLgMMlQl0Ve4ZGFpGyVNHj3mjRsTZSNEVbKe42uwMEID/B+Pukyatq?=
 =?us-ascii?Q?v502Mby8OWLTConoFdhMSXJQ48xojdqR76N0XR93lEBUGJGdflYqCvIRGyfn?=
 =?us-ascii?Q?JNFzt4Xqqk169sjtekv24K9CZ6CrdfvEUw4b5/rKPrhxOnhTVSZ0wfKUyr+X?=
 =?us-ascii?Q?uQPMkAOhU/ue3xCWWFJ5eIj1AWF/jJhAJOI8GMt1yrJTzY7VC3k/aKDgvfmt?=
 =?us-ascii?Q?Xr4CfroPmBaUzgcNG/qK6nob2O3C2FooiTeBpsuarDJWereE8ETtdyigO/Sv?=
 =?us-ascii?Q?p+1+YrOVXGgT2FzLrtb2GqCmK1BckRqGkUvOAXH6IIn3OEOEJ9SpkoYwDXKe?=
 =?us-ascii?Q?bBA7GkCa9d6ihsCDFbrNgdxdaRa9Rnqrl1bx0VxAgT8vEESH6Ig38yfRksTW?=
 =?us-ascii?Q?0ZFI+jktOPJn4tr25ULK7/OuAKvCkIg0c8iIOyLPqLmCE/hM9TU/pdxk22mF?=
 =?us-ascii?Q?Fc9vbLF1Ff9CHHGWW3jYIDQmW/G/O2HKBsviXV59Pn4LA+lTWlms0Ih3yVY1?=
 =?us-ascii?Q?ZISS5okhHKyNmsk5zYnpGXoKOfAItfQqKaZMG3iLS7Szwl1YAC0+Ql3WGwlX?=
 =?us-ascii?Q?oofdgyDF89o19NSczn1wEBagL5J9sa5s8lU7TvkBb7+8BZfQlTURwRLZxAx5?=
 =?us-ascii?Q?UuhVnzB1fgjQDl4VTi2XR3xOBi7Ahe69nZMahArfmU9S6sk3ch0ap9+kMWB6?=
 =?us-ascii?Q?6XA5eSQDOFH7IWNQ6LvVLMxCPw27hR3wfNW7R9AQRgjHCEWqfSJoGA3SKI2e?=
 =?us-ascii?Q?zMUhBiSoJQYan6mBOw2AqA71GHHWjp77UowAqgltYAgse6FwUvfJ+0PCrv0L?=
 =?us-ascii?Q?ptj0Z7Z4u4PJDnPYuylUjgbPwWfWoqO/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Sh79eSPDzilsGWTjzqO3iFBC10jyljd4Gmqwu9ZCJnvZRIAxUNvfOXYejrD/?=
 =?us-ascii?Q?F/r3FdFxn2jmfu3Jp9B/+PVpqnjtrhZgv/DxKOvQsnzPEt21aGDBK8Je5MUv?=
 =?us-ascii?Q?bQ1/p56J8odFyRsGcim+kW1EqWN+XoahWHfPIZq3vXdef6AOdX8cfMoogIdH?=
 =?us-ascii?Q?xD0US4b32D9YPyVMD8+jKdia3cOy1czmqux/I1pMY9KqqEN14z/GYEULvXRT?=
 =?us-ascii?Q?4k9BWD0oASEd7aj0U3x4nGBecR27+/sdaiFwNd//sKrfjx91mRU/zAoW6dNT?=
 =?us-ascii?Q?/rlmtthJ+LlGsgoiRTDT0GmkB+3iOu9aZrOziGmcYRw2DEZ+EEXgKDjmyhQc?=
 =?us-ascii?Q?VvDRNOfsr/VyabqJOKttT00/qxEhx1aKtNLhA369Y8iC7gdhe7Ak4jI/aGJZ?=
 =?us-ascii?Q?QbmDIVidDt+vsprVp5KTWsmIA4KCvh1439o7gZRcla2RwEtSVH+KNuBHYg0h?=
 =?us-ascii?Q?T82sKDjhNr6+jGwdvu/O+SWILkK44pRX6wiROLB3xa+cstuiMjYI/T8+BuBo?=
 =?us-ascii?Q?Ls2tJpfCu72WzlzZnIJaua95j8g9feoVUSXpr6wxrvmejcpG2uGuPiKx0G2k?=
 =?us-ascii?Q?uLs3FCSFI02SBIRQ2U9MJHFoGBja9Q7GEOFYUMYtiFHq0nfrL3pSwHt96ZnU?=
 =?us-ascii?Q?QbLBcNeYW6vMHYbjv5oELq0z3J3M9zSphGlJgIlLJFS+wNflA2xu/eSRVCBf?=
 =?us-ascii?Q?RD4ZEVca5PTy1IhcsztVAD+AL+GF7cOtoQ7QXy39ocibKl4qdDreI6HsYrNx?=
 =?us-ascii?Q?AAHW8KDDEq7CLOqyPhTxLlgv8m7LWqqHGfu1++JxrH/+EZsP+MM+NJtBK46/?=
 =?us-ascii?Q?UZi61KzOknjZqnQPeMHKZhqCqvznCaP4ajKtoGPdcco85dJc+48L6dL7dJiZ?=
 =?us-ascii?Q?Z8FkAaVBp71rxl+w9qY5ktgAQBj3tR/UUy5sU+dujlF5iO2YSMgRTSWiV8Kx?=
 =?us-ascii?Q?B6fNuMBDMskJQmIMi7/5jjejsmEmx+dCQt12xKOoju9XVAuKTotjTGx4IOQQ?=
 =?us-ascii?Q?23VLijIT1vIjf1skXY+e8RLL+JyUmlrJEfCuE44XizoK6Ww8rC2Rf8WgiciE?=
 =?us-ascii?Q?KtfBwn19MLsZAHhcwYnamXsv/Isp7rb4AqIV+IejfgWCiGL0gGK6y9Kpfy44?=
 =?us-ascii?Q?7bgg4gPkZzJHtN8ooAaPD24wO/emJ+OEp3OBWxnolXhu6Hgvw5rOpKWpSvuz?=
 =?us-ascii?Q?WkBFG3tx8Ew/nYscwAlXlcvE8X2+eKzzquj2Hdr4BWps/uhPZkUFUmTzUxUv?=
 =?us-ascii?Q?AsZWRJxYqy08JIoBip6JzkEC+rPYGKglNvcdPvI3p9MthzjIbt0zoho+omnb?=
 =?us-ascii?Q?jHeijYz9+SLXq6/KPwwkQMmipQK6UvSsdh7FIO0v+OJlzT62IS0+eRKb5kKO?=
 =?us-ascii?Q?mA2Q1gdZVtxQK+0gMOe7Yjr2ZOsSYckMlFkvZWH+EEuufEQZyCQhoI+td1ui?=
 =?us-ascii?Q?QiZbYgajbseiVOill49uV/58eMAyIb+atOfLC2qLG8q5XLiBynTMYnQa9W8x?=
 =?us-ascii?Q?lyDpWVPhV3J98xhcNfHT1tPSZj8F/3hd5PYbnoFtzeo59FMoxcxZXUwvn/2Q?=
 =?us-ascii?Q?duQiKOvNYoorH/aApH5uOmQ2r3X11ybWdcoatC+URXySTPNWMWqbkULc5cL9?=
 =?us-ascii?Q?BJEP7W5iN7nwtcpm9brdZ7Y=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e8889ed-6ac5-426f-c617-08de2f6103c4
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2025 16:04:45.5876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7FECMRNiGM3ADscmjydCVKy7XO8RQ6Byhg1Z6cQd2C9g0CTLIMo0bro3/a3NuSonmFJg8Xb3MLtUODmN+0RMnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB4684

Add dedicated DTs for the Spider CPU+BreakOut boards when used in PCIe
RC/EP mode with DW PCIe eDMA based NTB transport.

 * r8a779f0-spider-rc.dts describes the board in RC mode.

   It reserves 4 MiB of IOVA starting at 0xfe000000, which on this SoC
   is the ECAM/Config aperture of the PCIe host bridge. In stress
   testing with the remote eDMA, allowing generic DMA mappings to occupy
   this range led to immediate instability. The exact mechanism is under
   investigation, but reserving the range avoids the issue in practice.

 * r8a779f0-spider-ep.dts describes the board in EP mode.

   The RC interface is disabled and the EP interface is enabled. IPMMU
   usage matches the RC case.

The base r8a779f0-spider.dts is intentionally left unchanged and
continues to describe the default RC-only board configuration.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 arch/arm64/boot/dts/renesas/Makefile          |  2 +
 .../boot/dts/renesas/r8a779f0-spider-ep.dts   | 46 ++++++++++++++++
 .../boot/dts/renesas/r8a779f0-spider-rc.dts   | 52 +++++++++++++++++++
 3 files changed, 100 insertions(+)
 create mode 100644 arch/arm64/boot/dts/renesas/r8a779f0-spider-ep.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r8a779f0-spider-rc.dts

diff --git a/arch/arm64/boot/dts/renesas/Makefile b/arch/arm64/boot/dts/renesas/Makefile
index 1fab1b50f20e..e8d312be515b 100644
--- a/arch/arm64/boot/dts/renesas/Makefile
+++ b/arch/arm64/boot/dts/renesas/Makefile
@@ -82,6 +82,8 @@ dtb-$(CONFIG_ARCH_R8A77995) += r8a77995-draak-panel-aa104xd12.dtb
 dtb-$(CONFIG_ARCH_R8A779A0) += r8a779a0-falcon.dtb
 
 dtb-$(CONFIG_ARCH_R8A779F0) += r8a779f0-spider.dtb
+dtb-$(CONFIG_ARCH_R8A779F0) += r8a779f0-spider-ep.dtb
+dtb-$(CONFIG_ARCH_R8A779F0) += r8a779f0-spider-rc.dtb
 dtb-$(CONFIG_ARCH_R8A779F0) += r8a779f4-s4sk.dtb
 
 dtb-$(CONFIG_ARCH_R8A779G0) += r8a779g0-white-hawk.dtb
diff --git a/arch/arm64/boot/dts/renesas/r8a779f0-spider-ep.dts b/arch/arm64/boot/dts/renesas/r8a779f0-spider-ep.dts
new file mode 100644
index 000000000000..9c9e29226458
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r8a779f0-spider-ep.dts
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: (GPL-2.0 or MIT)
+/*
+ * Device Tree Source for the Spider CPU and BreakOut boards
+ * (PCIe EP mode with DW PCIe eDMA used for NTB transport)
+ *
+ * Based on the base r8a779f0-spider.dts.
+ *
+ * Copyright (C) 2025 Renesas Electronics Corp.
+ */
+
+/dts-v1/;
+#include "r8a779f0-spider-cpu.dtsi"
+#include "r8a779f0-spider-ethernet.dtsi"
+
+/ {
+	model = "Renesas Spider CPU and Breakout boards based on r8a779f0";
+	compatible = "renesas,spider-breakout", "renesas,spider-cpu",
+		     "renesas,r8a779f0";
+};
+
+&i2c4 {
+	eeprom@51 {
+		compatible = "rohm,br24g01", "atmel,24c01";
+		label = "breakout-board";
+		reg = <0x51>;
+		pagesize = <8>;
+	};
+};
+
+&pciec0 {
+	status = "disabled";
+};
+
+&pciec0_ep {
+	iommus = <&ipmmu_hc 32>;
+	status = "okay";
+	/* Hide eDMA from generic EP users, it is driven by host side remotely */
+	reg = <0 0xe65d0000 0 0x2000>, <0 0xe65d2000 0 0x1000>,
+	      <0 0xe65d3000 0 0x2000>, <0 0xe65d6200 0 0x0e00>,
+	      <0 0xe65d7000 0 0x0400>, <0 0xfe000000 0 0x400000>;
+	reg-names = "dbi", "dbi2", "atu", "app", "phy", "addr_space";
+	interrupts = <GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>;
+	interrupt-names = "sft_ce", "app";
+	interrupt-parent = <&gic>;
+};
diff --git a/arch/arm64/boot/dts/renesas/r8a779f0-spider-rc.dts b/arch/arm64/boot/dts/renesas/r8a779f0-spider-rc.dts
new file mode 100644
index 000000000000..c7112862e1e1
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r8a779f0-spider-rc.dts
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Device Tree Source for the Spider CPU and BreakOut boards
+ * (PCIe RC mode with remote DW PCIe eDMA used for NTB transport)
+ *
+ * Based on the base r8a779f0-spider.dts.
+ *
+ * Copyright (C) 2025 Renesas Electronics Corp.
+ */
+
+/dts-v1/;
+#include "r8a779f0-spider-cpu.dtsi"
+#include "r8a779f0-spider-ethernet.dtsi"
+
+/ {
+	model = "Renesas Spider CPU and Breakout boards based on r8a779f0";
+	compatible = "renesas,spider-breakout", "renesas,spider-cpu",
+		     "renesas,r8a779f0";
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		/*
+		 * Reserve 4 MiB of IOVA starting at 0xfe000000. Allowing DMA
+		 * writes whose DAR (destination IOVA) falls numerically inside
+		 * the ECAM/config window has been observed to trigger
+		 * controller misbehavior.
+		 */
+		pciec0_iova_resv: pcie-iova-resv {
+			iommu-addresses = <&pciec0 0x0 0xfe000000 0x0 0x00400000>;
+		};
+	};
+};
+
+&i2c4 {
+	eeprom@51 {
+		compatible = "rohm,br24g01", "atmel,24c01";
+		label = "breakout-board";
+		reg = <0x51>;
+		pagesize = <8>;
+	};
+};
+
+&pciec0 {
+	iommus = <&ipmmu_hc 32>;
+	iommu-map = <0 &ipmmu_hc 32 1>;
+	iommu-map-mask = <0>;
+
+	memory-region = <&pciec0_iova_resv>;
+};
-- 
2.48.1


