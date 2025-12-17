Return-Path: <dmaengine+bounces-7757-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1B9CC8677
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 16:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A465230C68FC
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 15:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A1D3242D8;
	Wed, 17 Dec 2025 15:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="cEHu0fo5"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011052.outbound.protection.outlook.com [40.107.74.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB3C22FDEC;
	Wed, 17 Dec 2025 15:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765984580; cv=fail; b=VJ4bkBHcmF2Y4obgETEyJaXwn7gF7cu1ed7pjhoMrgtGl3vVZe4hdbtOZwsUqrTTjpem2EY6vRkVXlvTr7sqRhcQQwQ7EYo+KzQbFXhvcfjj2x53aO1JtLla+9/oC3R2vcEZDhAeKZwCaRgUepZD7n9W/xKATjTN0QOLr+kbp6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765984580; c=relaxed/simple;
	bh=giXGEvXD2Ai+O5YhLmkxdNq8aD5ZZAyzGWCbggeYxOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KbIqkyabP4URjQVQqIDzT9woTwG/sW63EFi3HSvUmo2S0w4ZLQZwvBaxMmNbHQXdIWFaCJpV0hIMuDhvfvKpj8eLEM5VavcCHVkLSJZGS+IgKhsPA6IQtH3FB0KkrXwyVY+jVFT8h4BJ4nfvboMUVkKIOOLoXREGqOVV3Dwrlz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=cEHu0fo5; arc=fail smtp.client-ip=40.107.74.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VLYOJbcX5S7prkWdidI6qhIEDvBYlBNaxQqBVk0rsO6jbmdXH2yLeH4uEsqaeBv+nw2Kbhza80K6D7BJ2fxBG9QCatKhQAoRTXhVs4V8G6ql1s0tlV0UNf82Abvrua8KheD8rUTmOvpOCHLg8aVkncXxxZlC5l333gHmKtArrLKvo+093sRdzyPOaoBF82fMWj+kFIUP4X35avFWmARyB+mVjZBTU/7+rycM9bQaaX07hxGb3eqoP1ieHpek9jNQ68Tfn8rCZhzQO1cpKigsqKABnboZgDVSbDQyk8FYX7kB20Hz7VrL+zR1IEoM7Ev+dvhBTvngWJfnNQUu/UligQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VD6NCTTJahO4Rf1Dji0OqiYFqVU8dPDbvWQgpvSQdFQ=;
 b=wmv2j7/BIFtQpB2Lmdld/wf5zll3nWfBAmEJKVvovSWOL8eIkvzeDRrLiAddVWo1a6nNJmT2sV57atJ5i45w9usFe6c1b1giEOB6I/rqYmSpa0wLJ08koLpBH68A0IEPKFX2jsKxPu/WeLab7m1NBjt0DMxUTwEJGrKLR4/U5i3vv4atGC7/w+7JzRIIDgw6FK33U2ygwpWyibNym9qgdqmp/OEXRlfvg0oHc97RLrT9bUThdnbSYYrXfIcw7dujjmkYjuTs+stfMtLYZdJ0w958qbVji/w7/wHbIZcpbSBqiYkAmYv+dYCjfLnHdr5jE+W7y8kPfsRNMhv04ruJRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VD6NCTTJahO4Rf1Dji0OqiYFqVU8dPDbvWQgpvSQdFQ=;
 b=cEHu0fo5SZttzWLNZ2M5LOJaHQGp0CAkGyy3rY5NGnRQ672VRa/i70JIZq8SSnZZ8wlhW2gcPypd5/XXa7kTNonRvtlz3B0SEC5CO824NTHql2AxTHJFF0dfxAiR6SWOH402/p+dvjH2BU4PThFyrtR37jeC83KNRFLimcquJ/w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by OS9P286MB4633.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2fc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 15:16:16 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 15:16:15 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Frank.Li@nxp.com,
	dave.jiang@intel.com,
	ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: mani@kernel.org,
	kwilczynski@kernel.org,
	kishon@kernel.org,
	bhelgaas@google.com,
	corbet@lwn.net,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	vkoul@kernel.org,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	jdmason@kudzu.us,
	allenbh@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Basavaraj.Natikar@amd.com,
	Shyam-sundar.S-k@amd.com,
	kurt.schwemmer@microsemi.com,
	logang@deltatee.com,
	jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	utkarsh02t@gmail.com,
	jbrunet@baylibre.com,
	dlemoal@kernel.org,
	arnd@arndb.de,
	elfring@users.sourceforge.net,
	den@valinux.co.jp
Subject: [RFC PATCH v3 02/35] NTB: epf: Add mwN_offset support and config region versioning
Date: Thu, 18 Dec 2025 00:15:36 +0900
Message-ID: <20251217151609.3162665-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251217151609.3162665-1-den@valinux.co.jp>
References: <20251217151609.3162665-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0242.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::9) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|OS9P286MB4633:EE_
X-MS-Office365-Filtering-Correlation-Id: d65ab6f4-0778-4b29-fb53-08de3d7f3887
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dzw3konwxBm3fLxgM2I58wZW3SLkl1IQW9FAXFUZgRsoYiRmkSaqCBzk2ZEn?=
 =?us-ascii?Q?3uQojSpCH5QbkiQMSmhkSLuX5AH3kemfZ3jlFu9CB5BUXAV4iIvxo8Q9/+Ul?=
 =?us-ascii?Q?H7oQpBKVnxmLyDY11R7isS1jrydljFMGsE4Ss318r1p88ny5Pw+eHTGTAlRy?=
 =?us-ascii?Q?21Gj8ii2h5MTCu040b/NywjMS0ZuY+Yby8mtN/RFlHZ1knzucoOhhJvM3BnV?=
 =?us-ascii?Q?uO8bdz0fnHLo/Z2R7x3uyDPpAzGsrYVY2ycEWxeO2cEbHKB67x2FxHAGJau7?=
 =?us-ascii?Q?dUzAg2BbFQRbN6V6okgHqwrdObQGbjswT+TX7ftbTImT1OiBnyCqTndS/23/?=
 =?us-ascii?Q?FnhypMx9nx38vqkzYfwAymq+JwcKdDm/qhqrimBV3A0nDNw0yzJ+xd7Zf0ki?=
 =?us-ascii?Q?ia56CIXT3xvyc2uNZHnvkqCwDsbT0/lH/7EZJRZd3pr0FYn4PdYbVjEEruJM?=
 =?us-ascii?Q?IQ5qnN1r8yfkidFnzcuXQhskN6bxMAHcDggr9kdj5L4DHpL5o0htnAw9/7vE?=
 =?us-ascii?Q?yNI11vG4wucvHS921hv4wwMV4s1ZxaXCgCy0Gav1UA2l62EwnxQZDK25IvtU?=
 =?us-ascii?Q?62TjkOf2W7mseJJJXWNiiBl55X/PJps+NQq5olCgUz5ZZ1RSqZkBMINZupgQ?=
 =?us-ascii?Q?yTGPqMC93J34i42v3M3FdYH8iTxdlv1vFdceswxuqRbIIYz3amudMm9gzh3+?=
 =?us-ascii?Q?L7z7V69ilnOxR94eqSO+2r0zmn6Lza0XgtX0PxT6jblEz+0bWZnJuV7nrjWZ?=
 =?us-ascii?Q?THLREo9X5WBs4Q+RjjaPLMOuV3AIzYb1HLUoiVOshL5iB/Xc3vRjzb/egbT9?=
 =?us-ascii?Q?Rg6wd21g/ko+auyMFZeHmXmNdq+AJ5mlmt5are1c01kpxOnd1J7MmyOv6jMU?=
 =?us-ascii?Q?n8CsXu8maspGXG5czriw8Xr3WMjEs3y6DDUnLbazRPXpvSui6iTWQVWcJjys?=
 =?us-ascii?Q?PJ2kGbxp7FTDyTnrKIadDaodno75BG8Kjm51jApFuY1bv8CMNiNNm8jL0nmO?=
 =?us-ascii?Q?4DAt/HwNFOYFdHQP6offerwslcfMlrsM1D9WRfecv1NrS2d6rtPO2daEYyak?=
 =?us-ascii?Q?RPxX2Q3HnOy7J2jmabeBarGQtRtXKqUC8e3pvsg7HoP7Rb5nPwAGqljIDpDL?=
 =?us-ascii?Q?EEzrBXaWSZ/3eKsDscLwD/pu1BjLUKetv9uTDPjE13cjTjqVPEWkwkPitxJH?=
 =?us-ascii?Q?e1JLO51g8zGWJ8NkmNN8I+59du+ngyN1jaOiDkWnNUmhl6Agj7jGnOyCYF5r?=
 =?us-ascii?Q?fW/vZbJCJttB4SRcfSazE+QBVNlZllrEiK4MzzpgIiuvcfB0VdNVStPYiYx8?=
 =?us-ascii?Q?lHO5XipI6KTVyoGdncs1tN+K9z/Zzr8Wy2ilHm8xSvCm2P5er/p2VBiK0S9W?=
 =?us-ascii?Q?oes62iXUBrK1BlYWTf+QYdwDOcXGUu4lJvbmuIiHL3zkoA0+eUB7v9uoERC7?=
 =?us-ascii?Q?LlG8n8ChRcV5lIy+8BsSI5mWEuAcjrDg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z1KHKf8tupxcm6iFB720xRivOmnD6mKBrDTiRX3e/j2TQK9toVuOVCjFlktP?=
 =?us-ascii?Q?7l+QlFIA5qH/LyKZqUCv8C3PeGVbWG3c+qzXGgT/+xXvg62+SnxeQkpMlM+o?=
 =?us-ascii?Q?Psf2wmQqj8Hz12DpcaIU3OwcyhKBS1Bf0bnbFvQ9RIKBZAzbODvLGv8CltND?=
 =?us-ascii?Q?47MKI44JKXFDbGeCIiMAH9h2dk2DS8Tu0MRck76URfZBn2qwCb/AeBXXGckq?=
 =?us-ascii?Q?sAID8KwLo6fblFIONe04zvSVE7RCT/gfukB22qjJbZaHSW9TGUeGMdMXgLoL?=
 =?us-ascii?Q?YsOkCqrxQhr+5P5/HTxh4taxwgX+bO9uXcOaGHBKwKGTlImI61uWVbsYH9m1?=
 =?us-ascii?Q?aJlh1doKUbbAhylwh8NBDmzdsf0XOV72Z6xm2IAHQTtsoU1WHQsxsqM+XBKC?=
 =?us-ascii?Q?gFy4SKgntogU6JL2FBlJJlDRGJni25tJ+2NZf/I81ZFkLSP/J7m0S3nlJ15F?=
 =?us-ascii?Q?UbAgfAXZqRluFTDNNwiAU0XEmI4bmF+MDNy+jPDpa5xutHBhJUk43qDMtAy+?=
 =?us-ascii?Q?gzRVVosNrQcBOXpA470bub3EWhbHNO2lGU4oJi7Zv/MP1n1uSVQ4HF8j/5IK?=
 =?us-ascii?Q?A77iRy/8XkhsW488FdVD06Q7vRnOo78YhBC6jNH0+CghX0uPVmbxe/aoMO6I?=
 =?us-ascii?Q?0v5XfcasumZCzvzTvTZJ4GkNIiZLT4x/OpBukW6jlR8tE5/cDs5ERdb88jQk?=
 =?us-ascii?Q?/q0Ulq0TYpdwMdszhuYibT6CZxh1Wpgt4UzbGNyq6UhBf5G6hcx+dkF+Sz9X?=
 =?us-ascii?Q?FTAFuLfW/9lN1erIJEVXgF/xlFbsEf+/1JctatR/KDs1KWcwW0FciNsmEMx2?=
 =?us-ascii?Q?Ez+WBFwlabIALwWy7SDTBsVVGYA8FeBpdWwzYbKUtVD2o9aOpRYeH6J6ooNC?=
 =?us-ascii?Q?sfmnzJR8GGz5U6irD1T15Vi90ruT6G0rFpGGyhc+QUInP6ps8oHeSKFd63r1?=
 =?us-ascii?Q?b0U0iUD8GsohT9LxnqooWCn0mjNrb37VIkDsXPgFX1xtCi17LtlJ8yuvArl9?=
 =?us-ascii?Q?8gy45HmpW7spW5UkgCqmiD8+Vj1JhrvDRgH2ZHuajt15gzTf9x93DnV0ZlOc?=
 =?us-ascii?Q?Gb1OHgvq/U8RhBHRDWOzasMAT1vOkWjtoHIs7Ctwvsp2qMA/gzZrcXpvvA8T?=
 =?us-ascii?Q?ur4uGNQIqu7P9xcDBSIhGCeIwF17Q5iEFILKMqkl9P7zJVoUY4d4ddb6dOMr?=
 =?us-ascii?Q?JW3BDQKdofNMDUG9yDECwDx2gQIINez6kRMz0jEupi8MXirGNzhiuh+E95Pa?=
 =?us-ascii?Q?l3VDY/RP2ptaq0G6Fbp/GpDgMHO4XaWjtuTnwD6r0M4j2L9n8mX3VA9mtWog?=
 =?us-ascii?Q?JWd5UuewRQJk6b/Bx1ExDIgAEx6K9BMzKOzkC0N1ON+VKrNHN+oTukWQqBXj?=
 =?us-ascii?Q?sQ56rKjQTPPqSQE4wM3PMko7W5pdEdvkyS10ZalQENkUZ0Mrg6HjAfM9H3wv?=
 =?us-ascii?Q?PzDefDKqjZBMod0Tsr4r9rOQN25R7Q86HYMh+FgHA/aUAENzwXAvhVJxKr2z?=
 =?us-ascii?Q?ugElCkn/kXH0Ik/QhYZjhTdnL/z37dhEOgH4TG3IHbsa84EAA6RMi5NynV/I?=
 =?us-ascii?Q?FZ4yocLBEeuoa5RoGwGY9JK96jDQI6NYh6SECOUDJHadyyAJTBmLGLGMNjok?=
 =?us-ascii?Q?wTWlTzAM/kQpt7ErKxfgEks=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: d65ab6f4-0778-4b29-fb53-08de3d7f3887
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 15:16:15.2411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: skeYbzjyWzARUN/MamArF/U6DWVowgswXkylL1C7egc6tYVKDZykfQDQr0bEWD7ZBn/6wg6wa6gMyagCgrpK4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB4633

Introduce new mwN_offset configfs attributes to specify memory window
offsets. This enables mapping multiple windows into a single BAR at
arbitrary offsets, improving layout flexibility.

Extend the control register region and add a 32-bit config version
field. Reuse NTB_EPF_TOPOLOGY (0x0C), which is currently unused, as the
version register. The endpoint function driver writes 1
(NTB_EPF_CTRL_VERSION_V1), and ntb_hw_epf reads it at probe time and
refuses to bind to unknown versions.

Endpoint running with an older kernel that do not program
NTB_EPF_CTRL_VERSION will be rejected early by host with newer kernel,
instead of misbehaving at runtime.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/hw/epf/ntb_hw_epf.c               |  44 +++++-
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 136 ++++++++++++++++--
 2 files changed, 160 insertions(+), 20 deletions(-)

diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
index d3ecf25a5162..126ba38e32ea 100644
--- a/drivers/ntb/hw/epf/ntb_hw_epf.c
+++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
@@ -30,18 +30,22 @@
 #define NTB_EPF_LINK_STATUS	0x0A
 #define LINK_STATUS_UP		BIT(0)
 
-#define NTB_EPF_TOPOLOGY	0x0C
+/* 0x24 (32bit) is unused */
+#define NTB_EPF_CTRL_VERSION	0x0C
 #define NTB_EPF_LOWER_ADDR	0x10
 #define NTB_EPF_UPPER_ADDR	0x14
 #define NTB_EPF_LOWER_SIZE	0x18
 #define NTB_EPF_UPPER_SIZE	0x1C
 #define NTB_EPF_MW_COUNT	0x20
-#define NTB_EPF_MW1_OFFSET	0x24
 #define NTB_EPF_SPAD_OFFSET	0x28
 #define NTB_EPF_SPAD_COUNT	0x2C
 #define NTB_EPF_DB_ENTRY_SIZE	0x30
 #define NTB_EPF_DB_DATA(n)	(0x34 + (n) * 4)
 #define NTB_EPF_DB_OFFSET(n)	(0xB4 + (n) * 4)
+#define NTB_EPF_MW_OFFSET(n)	(0x134 + (n) * 4)
+#define NTB_EPF_MW_SIZE(n)	(0x144 + (n) * 4)
+
+#define NTB_EPF_CTRL_VERSION_V1	1
 
 #define NTB_EPF_MIN_DB_COUNT	3
 #define NTB_EPF_MAX_DB_COUNT	31
@@ -451,11 +455,12 @@ static int ntb_epf_peer_mw_get_addr(struct ntb_dev *ntb, int idx,
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
@@ -464,8 +469,11 @@ static int ntb_epf_peer_mw_get_addr(struct ntb_dev *ntb, int idx,
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
@@ -547,6 +555,24 @@ static inline void ntb_epf_init_struct(struct ntb_epf_dev *ndev,
 	ndev->ntb.ops = &ntb_epf_ops;
 }
 
+static int ntb_epf_check_version(struct ntb_epf_dev *ndev)
+{
+	struct device *dev = ndev->dev;
+	u32 ver;
+
+	ver = readl(ndev->ctrl_reg + NTB_EPF_CTRL_VERSION);
+
+	switch (ver) {
+	case NTB_EPF_CTRL_VERSION_V1:
+		break;
+	default:
+		dev_err(dev, "Unsupported NTB EPF version %u\n", ver);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
 {
 	struct device *dev = ndev->dev;
@@ -695,6 +721,10 @@ static int ntb_epf_pci_probe(struct pci_dev *pdev,
 		return ret;
 	}
 
+	ret = ntb_epf_check_version(ndev);
+	if (ret)
+		return ret;
+
 	ret = ntb_epf_init_dev(ndev);
 	if (ret) {
 		dev_err(dev, "Failed to init device\n");
diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 56aab5d354d6..4dfb3e40dffa 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -39,6 +39,7 @@
 #include <linux/atomic.h>
 #include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/log2.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 
@@ -61,6 +62,7 @@ static struct workqueue_struct *kpcintb_workqueue;
 
 #define LINK_STATUS_UP			BIT(0)
 
+#define CTRL_VERSION			1
 #define SPAD_COUNT			64
 #define DB_COUNT			4
 #define NTB_MW_OFFSET			2
@@ -107,7 +109,7 @@ struct epf_ntb_ctrl {
 	u32 argument;
 	u16 command_status;
 	u16 link_status;
-	u32 topology;
+	u32 version;
 	u64 addr;
 	u64 size;
 	u32 num_mws;
@@ -117,6 +119,8 @@ struct epf_ntb_ctrl {
 	u32 db_entry_size;
 	u32 db_data[MAX_DB_COUNT];
 	u32 db_offset[MAX_DB_COUNT];
+	u32 mw_offset[MAX_MW];
+	u32 mw_size[MAX_MW];
 } __packed;
 
 struct epf_ntb {
@@ -128,6 +132,7 @@ struct epf_ntb {
 	u32 db_count;
 	u32 spad_count;
 	u64 mws_size[MAX_MW];
+	u64 mws_offset[MAX_MW];
 	atomic64_t db;
 	u32 vbus_number;
 	u16 vntb_pid;
@@ -454,10 +459,13 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
 	ntb->reg = base;
 
 	ctrl = ntb->reg;
+	ctrl->version = CTRL_VERSION;
 	ctrl->spad_offset = ctrl_size;
 
 	ctrl->spad_count = spad_count;
 	ctrl->num_mws = ntb->num_mws;
+	memset(ctrl->mw_offset, 0, sizeof(ctrl->mw_offset));
+	memset(ctrl->mw_size, 0, sizeof(ctrl->mw_size));
 	ntb->spad_size = spad_size;
 
 	ctrl->db_entry_size = sizeof(u32);
@@ -689,15 +697,31 @@ static void epf_ntb_db_bar_clear(struct epf_ntb *ntb)
  */
 static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
 {
+	struct device *dev = &ntb->epf->dev;
+	u64 bar_ends[BAR_5 + 1] = { 0 };
+	unsigned long bars_used = 0;
+	enum pci_barno barno;
+	u64 off, size, end;
 	int ret = 0;
 	int i;
-	u64 size;
-	enum pci_barno barno;
-	struct device *dev = &ntb->epf->dev;
 
 	for (i = 0; i < ntb->num_mws; i++) {
-		size = ntb->mws_size[i];
 		barno = ntb->epf_ntb_bar[BAR_MW1 + i];
+		off = ntb->mws_offset[i];
+		size = ntb->mws_size[i];
+		end = off + size;
+		if (end > bar_ends[barno])
+			bar_ends[barno] = end;
+		bars_used |= BIT(barno);
+	}
+
+	for (barno = BAR_0; barno <= BAR_5; barno++) {
+		if (!(bars_used & BIT(barno)))
+			continue;
+		if (bar_ends[barno] < SZ_4K)
+			size = SZ_4K;
+		else
+			size = roundup_pow_of_two(bar_ends[barno]);
 
 		ntb->epf->bar[barno].barno = barno;
 		ntb->epf->bar[barno].size = size;
@@ -713,8 +737,12 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
 				      &ntb->epf->bar[barno]);
 		if (ret) {
 			dev_err(dev, "MW set failed\n");
-			goto err_alloc_mem;
+			goto err_set_bar;
 		}
+	}
+
+	for (i = 0; i < ntb->num_mws; i++) {
+		size = ntb->mws_size[i];
 
 		/* Allocate EPC outbound memory windows to vpci vntb device */
 		ntb->vpci_mw_addr[i] = pci_epc_mem_alloc_addr(ntb->epf->epc,
@@ -723,19 +751,31 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
 		if (!ntb->vpci_mw_addr[i]) {
 			ret = -ENOMEM;
 			dev_err(dev, "Failed to allocate source address\n");
-			goto err_set_bar;
+			goto err_alloc_mem;
 		}
 	}
 
+	for (i = 0; i < ntb->num_mws; i++) {
+		ntb->reg->mw_offset[i] = (u32)ntb->mws_offset[i];
+		ntb->reg->mw_size[i] = (u32)ntb->mws_size[i];
+	}
+
 	return ret;
 
-err_set_bar:
-	pci_epc_clear_bar(ntb->epf->epc,
-			  ntb->epf->func_no,
-			  ntb->epf->vfunc_no,
-			  &ntb->epf->bar[barno]);
 err_alloc_mem:
-	epf_ntb_mw_bar_clear(ntb, i);
+	while (--i >= 0)
+		pci_epc_mem_free_addr(ntb->epf->epc,
+				      ntb->vpci_mw_phy[i],
+				      ntb->vpci_mw_addr[i],
+				      ntb->mws_size[i]);
+err_set_bar:
+	while (--barno >= BAR_0)
+		if (bars_used & BIT(barno))
+			pci_epc_clear_bar(ntb->epf->epc,
+					  ntb->epf->func_no,
+					  ntb->epf->vfunc_no,
+					  &ntb->epf->bar[barno]);
+
 	return ret;
 }
 
@@ -1040,6 +1080,60 @@ static ssize_t epf_ntb_##_name##_store(struct config_item *item,	\
 	return len;							\
 }
 
+#define EPF_NTB_MW_OFF_R(_name)						\
+static ssize_t epf_ntb_##_name##_show(struct config_item *item,		\
+				      char *page)			\
+{									\
+	struct config_group *group = to_config_group(item);		\
+	struct epf_ntb *ntb = to_epf_ntb(group);			\
+	struct device *dev = &ntb->epf->dev;				\
+	int win_no, idx;						\
+									\
+	if (sscanf(#_name, "mw%d_offset", &win_no) != 1)		\
+		return -EINVAL;						\
+									\
+	idx = win_no - 1;						\
+	if (idx < 0 || idx >= ntb->num_mws) {				\
+		dev_err(dev, "MW%d out of range (num_mws=%d)\n",	\
+			win_no, ntb->num_mws);				\
+		return -EINVAL;						\
+	}								\
+									\
+	idx = array_index_nospec(idx, ntb->num_mws);			\
+	return sprintf(page, "%llu\n", ntb->mws_offset[idx]);		\
+}
+
+#define EPF_NTB_MW_OFF_W(_name)						\
+static ssize_t epf_ntb_##_name##_store(struct config_item *item,	\
+				       const char *page, size_t len)	\
+{									\
+	struct config_group *group = to_config_group(item);		\
+	struct epf_ntb *ntb = to_epf_ntb(group);			\
+	struct device *dev = &ntb->epf->dev;				\
+	int win_no, idx;						\
+	u64 val;							\
+	int ret;							\
+									\
+	ret = kstrtou64(page, 0, &val);					\
+	if (ret)							\
+		return ret;						\
+									\
+	if (sscanf(#_name, "mw%d_offset", &win_no) != 1)		\
+		return -EINVAL;						\
+									\
+	idx = win_no - 1;						\
+	if (idx < 0 || idx >= ntb->num_mws) {				\
+		dev_err(dev, "MW%d out of range (num_mws=%d)\n",	\
+			win_no, ntb->num_mws);				\
+		return -EINVAL;						\
+	}								\
+									\
+	idx = array_index_nospec(idx, ntb->num_mws);			\
+	ntb->mws_offset[idx] = val;					\
+									\
+	return len;							\
+}
+
 #define EPF_NTB_BAR_R(_name, _id)					\
 	static ssize_t epf_ntb_##_name##_show(struct config_item *item,	\
 					      char *page)		\
@@ -1110,6 +1204,14 @@ EPF_NTB_MW_R(mw3)
 EPF_NTB_MW_W(mw3)
 EPF_NTB_MW_R(mw4)
 EPF_NTB_MW_W(mw4)
+EPF_NTB_MW_OFF_R(mw1_offset)
+EPF_NTB_MW_OFF_W(mw1_offset)
+EPF_NTB_MW_OFF_R(mw2_offset)
+EPF_NTB_MW_OFF_W(mw2_offset)
+EPF_NTB_MW_OFF_R(mw3_offset)
+EPF_NTB_MW_OFF_W(mw3_offset)
+EPF_NTB_MW_OFF_R(mw4_offset)
+EPF_NTB_MW_OFF_W(mw4_offset)
 EPF_NTB_BAR_R(ctrl_bar, BAR_CONFIG)
 EPF_NTB_BAR_W(ctrl_bar, BAR_CONFIG)
 EPF_NTB_BAR_R(db_bar, BAR_DB)
@@ -1130,6 +1232,10 @@ CONFIGFS_ATTR(epf_ntb_, mw1);
 CONFIGFS_ATTR(epf_ntb_, mw2);
 CONFIGFS_ATTR(epf_ntb_, mw3);
 CONFIGFS_ATTR(epf_ntb_, mw4);
+CONFIGFS_ATTR(epf_ntb_, mw1_offset);
+CONFIGFS_ATTR(epf_ntb_, mw2_offset);
+CONFIGFS_ATTR(epf_ntb_, mw3_offset);
+CONFIGFS_ATTR(epf_ntb_, mw4_offset);
 CONFIGFS_ATTR(epf_ntb_, vbus_number);
 CONFIGFS_ATTR(epf_ntb_, vntb_pid);
 CONFIGFS_ATTR(epf_ntb_, vntb_vid);
@@ -1148,6 +1254,10 @@ static struct configfs_attribute *epf_ntb_attrs[] = {
 	&epf_ntb_attr_mw2,
 	&epf_ntb_attr_mw3,
 	&epf_ntb_attr_mw4,
+	&epf_ntb_attr_mw1_offset,
+	&epf_ntb_attr_mw2_offset,
+	&epf_ntb_attr_mw3_offset,
+	&epf_ntb_attr_mw4_offset,
 	&epf_ntb_attr_vbus_number,
 	&epf_ntb_attr_vntb_pid,
 	&epf_ntb_attr_vntb_vid,
-- 
2.51.0


