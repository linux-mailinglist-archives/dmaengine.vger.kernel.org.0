Return-Path: <dmaengine+bounces-7791-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B82CC9271
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 18:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 542E43053B37
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 17:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3922358D33;
	Wed, 17 Dec 2025 17:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="YGprAFTC"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010043.outbound.protection.outlook.com [52.101.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814CB358D21;
	Wed, 17 Dec 2025 17:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765993725; cv=fail; b=ISeHXDdUBMUd2Mh6a2X4cH1b1gtCzYoElq2Q3ce3ofQKcm8Z87QGZs5TzVgfug8fMXs5Vp/2/Htfl+s7bDwOFamGwuJqzFbXo3gdjKqeTIuGQFTidwqJimEaGqUbAufP8rOZZmD7Y2z4BTKO5t+T9M0MFc7awYH6oRxJ8er11xI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765993725; c=relaxed/simple;
	bh=IepXPJTSF+QW5csZtUTGUHvBPqsK14sVRrj2rDHhmng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ffV794rudGk474cWtebacPWAkQFjN9lgt33HLTvLjUzyIpm+7e5tuiw3hFlDZzi2GcTK5SzmxoBxX0Yn221KoJKeVEFEKahde9aJNkJedAZReCF0walCpS1Vb/ElMZl0QfBNsCxZ/yNLwzkhNhTBCMPqowz8s2XmvSNso3PIBko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=YGprAFTC; arc=fail smtp.client-ip=52.101.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mvM7ImRwQSbw57luAMLcAvGWwsyMp3j8WeX6VgJG4DcSYVDNQnwQFy13FxYnlFXMTxLMWkKi5JFrJW9H0mXR7U+Y9+8H5fz8Ky+wg01wDjCNzShBA9/ej1M9h7Uneg7VM7A3GcSFNZTOvMJa7a1jwRqdFsyPeeojB+JzuPnZGjGfTaQ8Mkmgm/kn8g8EleJDA6N81mNqDKec5HIsUX1CWwHFzvA7Db4xvn8Z4tpq0iFs9gJecdz/Y6WwuYzx1D/DycW2AkjX9jfA2/kwRkjljLnc6NbDVivqaAqDvD7r6UHmOZWa6dSbWQPrSrrHLCs5EP4zYhR8HHqskXuYTzOxnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5+HsGG0URLgiCz+kBgzM8N+sPJK7UtrCe3DgERbB/Pg=;
 b=EFahSa5t/dRo8fhMIDdeioQ7UoItiilIlgPZZ/u8mkAbus+sH9wvdhqyBaM3OyojsOanayr/HtnyG8FVvafvLpQmcPh1YNN5IOjJy8ZFpuF6+kXmpp3m3r3gpc6R+oIIg7P0hJkc3oLzTc83X0a+PsTYgNX3Zp3A73Mdbr3EgymKG7VNuRD03pDkP9L32VBp1EVCBDHsgK+QPNgr/A4Oz8Edov4XjqwUp6kKI6AzAFLQoOI3d7BvVTTaGHqfJGqu66OGjxrjnxnxZaVkBKuzw+Q6/v5A+Kw0tpkiD3AJ4IU37LDerI1brtHrs9qANYjyxjBWqX7UW0CxpwDGXFERJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5+HsGG0URLgiCz+kBgzM8N+sPJK7UtrCe3DgERbB/Pg=;
 b=YGprAFTCKpvpd/JNfYny0Ev/d6Z9FTyNnfPl5+uB3hK37sbFYGLN2RF7Z9zIKjA95nBpSPsybg+I6oEYJpH86pU4c5v3HPR9eb1Wvn1gXSlSoGf8L/Zvr64NYFQcvwOu+VUa91kmIdyEYRuzVdStljejp3FoW+O4x1NQXg5aYlQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by TYCP286MB2863.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:306::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 15:16:28 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 15:16:28 +0000
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
Subject: [RFC PATCH v3 17/35] dmaengine: dw-edma: Add helper func to retrieve register base and size
Date: Thu, 18 Dec 2025 00:15:51 +0900
Message-ID: <20251217151609.3162665-18-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251217151609.3162665-1-den@valinux.co.jp>
References: <20251217151609.3162665-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0045.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::19) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|TYCP286MB2863:EE_
X-MS-Office365-Filtering-Correlation-Id: ef2448f9-ffd7-4a4a-56ba-08de3d7f4093
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|10070799003|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gLB4+pYuU28kXW9NklnJydwDpPD6MepdywQVa7EeJj8XZK5yUzLi8kQ3JNuv?=
 =?us-ascii?Q?sieif8T2hhlbRg33U3nOu7K4rgcZcn8VpJ9vMfiCtrfpe5btQGBD8gNKveSZ?=
 =?us-ascii?Q?FSmazNZg+W55cVj4egiog4HPO32WSWh/ERmEI8fdvVVc/hZxxnboLM2BQImr?=
 =?us-ascii?Q?7hgM1WU13yYoRnpHy9zzbalvQyR3qVQQs9ZB+hryKfVLyo1MWkTdYIC6HQ+L?=
 =?us-ascii?Q?IzLz3r/hVe4dsRYdfRa7z7BcI3wqwksXXMU8Gi3CUOZ3sZLXWFhac+zHo0Qe?=
 =?us-ascii?Q?q/fQBtZLjCj/VxDiEatTijRKCNBg2DZ9ofuxKsgFWUPO/JBCRLGEUgLj47+m?=
 =?us-ascii?Q?Iuhs04o5JSM/Gxoj/C40VdMegVvG6jrG7NJUH7dATlLriQOkygfeHs0+qm6f?=
 =?us-ascii?Q?8zFgnUq+lQHZAFAEWZ4ppKVw/wSIFK3NTEgeACC4lHRuNd8p08aoM6lUfWg4?=
 =?us-ascii?Q?KodzHes7Z2rBj8VM/UhmLtVHOA7ne1+5zvXMQQ7voe4juo6iUOFTLvpn3pBB?=
 =?us-ascii?Q?i6Z8qJppcAeHZXrtFTfH72RkVEaRdVuPYSoBn5YeUdUNHFkP3w/Vl8i9IBbs?=
 =?us-ascii?Q?yrRd+sItNIOxt5ZtefXdzo+NISng5m8gTqYXJk9oMTn6EJiPN98rd1WyOEWS?=
 =?us-ascii?Q?SEkhEKfDLMejB4Bn7BKaL9QlRNnTcPYgvclu1LucKhLBPQiG+uCXZGJI9yB7?=
 =?us-ascii?Q?5poDrukl3lUvYrFVBix0Ex28/t00hZI014CVdNnBkzc2HIjbSXr0NdSXJ4zm?=
 =?us-ascii?Q?0dznI50I95jwW8PyYbyxJk8t7UGI9khu93wS3xaAKF1RBHusH1lHHryw/Tm8?=
 =?us-ascii?Q?u8k3hKE8bQDhlnD3pxb14+GKesBDz5Qzk27NBuHaFS7Nl0paKFhfJ6jUaXzC?=
 =?us-ascii?Q?UVnkY2xu2DBm4H5QfFcyE40KKMZsTAsbP1OSRgUBY1WARwSam57tnSmTjvxu?=
 =?us-ascii?Q?g+YcsKGiWKHzi3dX4PBPSAdoIOo45V4Q5YMr4Db20OXK1TSplky1NHi2yltq?=
 =?us-ascii?Q?wiGJ5VVPJXL94gODF4uT4NzAaU7IbJxhbQmHmBVSHXOE5Biepg8H3kGkMZpA?=
 =?us-ascii?Q?UDbo/9B7xQZkOY8kka64PCKtatevBhXsq8QD+8YASbJSoBtf+L0yWyWCvfzq?=
 =?us-ascii?Q?ahCgfPKBoGCi+r6lTKdfCqcyzE9CZQTI5U1aoHSyrB/QKJBm4oYh79ct9eOI?=
 =?us-ascii?Q?NsOGUI+t+AsUW7478lIQAxOKVVbVvjKu4TDq9OBPXYcZtBPNMNxA2MlmxLpV?=
 =?us-ascii?Q?C7Ze8a8OKDoQ4aq/w6f5fOFq4vFY/4jSKbL0+LOb8hcnCA31LtamPlVH7rBG?=
 =?us-ascii?Q?OFyM9c/KKT+iVnPCaBlvGLeoP4rhNyZVOGeXPxRBwozRErHXNmZP6IIwKN3f?=
 =?us-ascii?Q?xiVfY0vHh63uYc0F1o3oCIVFnjK2f67az4jyphwk9ujRs0kPFzNP78JFRYSD?=
 =?us-ascii?Q?RPj2v4Yog8DK0jf6BOXV5TDxCHW6sLIu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EZHgxQHQSR4m4HF/CCdyXCAwMRqGQBrd+Sztw91BceqzolQvI5AqtJaCBTmz?=
 =?us-ascii?Q?CPVeSwQeD7+OR/IintIF6mOEuF4JlFu1+FMZ3LA0kBiERbid3pYac9iDRw8h?=
 =?us-ascii?Q?whsK/37RiO97uf0ZIKXVQTtU7Hd4ysF4Hr3xhGLIaqNwuefCUGtFdurER88F?=
 =?us-ascii?Q?2aaKdBNLWkv8jU7jikO6zL9uWbuLcghS/SuytwSK1nBI1qxoBu2utjK33pHI?=
 =?us-ascii?Q?tw69ucqIQKphuqYmIghiEVmZNUj9uIAho/35ZbpWKK/trdcEzup8Gn72oK1B?=
 =?us-ascii?Q?Goh+vZqWsCU6fgB+B3nvH+Ltkq678im1vSoXhIOYozx8mc/pAyBJgS7XOde2?=
 =?us-ascii?Q?JbZk+30ES7xipFSHSF//+gteqWskRpJw90eQpDCNF9UCZexCFTEcgY59fkek?=
 =?us-ascii?Q?2+lr4d+Kh2mmOvZvmy+l8ccMR6nAMFKACXjGvPy6VWRQLfKk4E1aVCNgjibq?=
 =?us-ascii?Q?dK7Zi+hgQVs/9UPaXXj7OwGrIIksdYiqz6qxvReAHdOXZ+Ty3A37wVJjLJlz?=
 =?us-ascii?Q?QtagykKhGQOkIRbOgO2IV0jijKp2goramGmAZm5avB3grENA2fwTClWdlamP?=
 =?us-ascii?Q?buXIxTdg3LDQd/h011Of3IsLKoj4wWmuDlh64cefdnEVt38cKLrGJ9rL5gy/?=
 =?us-ascii?Q?1C3ZT9pBoCQ8RjAjfEGWPR7yerIfKm9SCBQzVxkUi8fntgK2H4FmVDEgYwfR?=
 =?us-ascii?Q?AX3IOjya7oGiQB2ZbEG/YH/nC9sJkjQpNVjSpYQKs4u6HZ/EeN+MhmfI3pBa?=
 =?us-ascii?Q?i8WNTTKQcKIWtVumUPRriFedAYRv/ddSNXnkiBk3FmO6TQutw8qECFOZuU43?=
 =?us-ascii?Q?Ex1gj6IQkuz2k9HLd/OAt6Aguc24izF6ss7JAQUNTtt8zC+HIm8hWc7avKPZ?=
 =?us-ascii?Q?mxYIj8ZZHRuS485GkbH1F4z0dRAHYwurPcuLadOz780CYQvDuAyN5EkA3pRa?=
 =?us-ascii?Q?CPXKbJapFteRt21DPH8H1KTY94uX55aibjbyYcqlWfLqX2YBEdNEfUOGmygS?=
 =?us-ascii?Q?+Y4BCcL+L/GI3ZOoVOIfGlEKWfsUONW1Gf2CRVVnLKrxluKz15qT68ZhLS5+?=
 =?us-ascii?Q?1No8xWnbDEDzdsf1GoTVIFecaOCi5LRvpHwUVrjZk92K0pbCGAInDC5SzjPR?=
 =?us-ascii?Q?NtjgzWffTH6rm2I0y/FQgo7dqYiD+AsJLnZqGJBUqHJj6xH7sZvANH2EZWkX?=
 =?us-ascii?Q?/i74ZBXWNLzoAFXXpYB/ct4k2RPMS7nKpAOHjiXE7WwVZBhyfkKl3RdJOSSr?=
 =?us-ascii?Q?CF98rOTTl4b10i2yevgwp7ySc2/X/HBIEB/cKJ8c7eK6DCh8PZu3D+4YEdrY?=
 =?us-ascii?Q?RUJH4Z2uBxOoVPQcm8jL6QfKdMZ7jSrf8upF5wVCyQVoQSlouFcZpk1o7nxG?=
 =?us-ascii?Q?8MbIvZqBJUl+RH8yzuHPzih61TZ/ODVAJwda+QKzs8kO+ve5yRcQNn89vbLr?=
 =?us-ascii?Q?NKRs704JuLZsKKTbsDtJI2lK6ir/m3pK4eeKq2E6s2EyCgV7BkPjBSy1G/AW?=
 =?us-ascii?Q?aJztxieSRLqVTgpwNyBiHUSCvepWUT1Ca30r3BqmSv0tGLM3/Fpc0ZWbAujg?=
 =?us-ascii?Q?+PhTTtLpMgEgvF1JrdTLCXhmyc3fdwli06dy7ZyKxMKaKKV3biXw3YziyHUO?=
 =?us-ascii?Q?bLp0E8tdKmYQ0QEndKjXVI4=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: ef2448f9-ffd7-4a4a-56ba-08de3d7f4093
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 15:16:28.7809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L4ObfIoECtQcIfL9GKNLxyPhSOTcK5dcyDNUxaX45PsGCMdib59Hh5k06HYqVG6Gfti6G8PSs3/bXpnsevh1RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2863

Remote eDMA users (e.g. NTB) may need to expose the integrated DW eDMA
register block through a memory window.

Add a helper function that returns the physical base and size for a
given DesignWare EP controller.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 .../pci/controller/dwc/pcie-designware-ep.c   |  1 +
 drivers/pci/controller/dwc/pcie-designware.c  | 25 +++++++++++++++++++
 include/linux/dma/edma.h                      | 24 ++++++++++++++++++
 3 files changed, 50 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 9480aebaa32a..46d18e7945db 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -12,6 +12,7 @@
 #include <linux/platform_device.h>
 
 #include "pcie-designware.h"
+#include <linux/dma/edma.h>
 #include <linux/pci-epc.h>
 #include <linux/pci-epf.h>
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 75fc8b767fcc..1de88df7b1af 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -162,8 +162,12 @@ int dw_pcie_get_resources(struct dw_pcie *pci)
 			pci->edma.reg_base = devm_ioremap_resource(pci->dev, res);
 			if (IS_ERR(pci->edma.reg_base))
 				return PTR_ERR(pci->edma.reg_base);
+			pci->edma.reg_phys = res->start;
+			pci->edma.reg_size = resource_size(res);
 		} else if (pci->atu_size >= 2 * DEFAULT_DBI_DMA_OFFSET) {
 			pci->edma.reg_base = pci->atu_base + DEFAULT_DBI_DMA_OFFSET;
+			pci->edma.reg_phys = pci->atu_phys_addr + DEFAULT_DBI_DMA_OFFSET;
+			pci->edma.reg_size = pci->atu_size - DEFAULT_DBI_DMA_OFFSET;
 		}
 	}
 
@@ -1204,3 +1208,24 @@ resource_size_t dw_pcie_parent_bus_offset(struct dw_pcie *pci,
 
 	return cpu_phys_addr - reg_addr;
 }
+
+int dw_edma_get_reg_window(struct pci_epc *epc, phys_addr_t *phys, size_t *sz)
+{
+	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
+	struct dw_pcie *pci;
+
+	if (!ep)
+		return -ENODEV;
+
+	pci = to_dw_pcie_from_ep(ep);
+	if (!pci->edma.reg_base || !pci->edma.reg_phys)
+		return -ENODEV;
+
+	if (phys)
+		*phys = pci->edma.reg_phys;
+	if (sz)
+		*sz = pci->edma.reg_size;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dw_edma_get_reg_window);
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index 3080747689f6..11d6eeb19fff 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -11,6 +11,7 @@
 
 #include <linux/device.h>
 #include <linux/dmaengine.h>
+#include <linux/pci-epc.h>
 
 #define EDMA_MAX_WR_CH                                  8
 #define EDMA_MAX_RD_CH                                  8
@@ -60,6 +61,27 @@ enum dw_edma_chip_flags {
 	DW_EDMA_CHIP_LOCAL	= BIT(0),
 };
 
+#if IS_REACHABLE(CONFIG_PCIE_DW)
+/**
+ * dw_edma_get_reg_window - get eDMA register base and size
+ *
+ * @epc: the EPC device with which the eDMA instance is integrated
+ * @phys: the output parameter that returns the register base address
+ * @sz: the output parameter that returns the register space size
+ *
+ * Remote eDMA users (e.g. NTB) may need to expose the integrated DW eDMA
+ * register block through a memory window. This helper returns the physical
+ * base and size for a given DesignWare EP controller.
+ */
+int dw_edma_get_reg_window(struct pci_epc *epc, phys_addr_t *phys, size_t *sz);
+#else
+static inline int dw_edma_get_reg_window(struct pci_epc *epc, phys_addr_t *phys,
+					 size_t *sz)
+{
+	return -ENODEV;
+}
+#endif /* CONFIG_PCIE_DW */
+
 /**
  * struct dw_edma_chip - representation of DesignWare eDMA controller hardware
  * @dev:		 struct device of the eDMA controller
@@ -85,6 +107,8 @@ struct dw_edma_chip {
 	u32			flags;
 
 	void __iomem		*reg_base;
+	phys_addr_t		reg_phys;
+	size_t			reg_size;
 
 	u16			ll_wr_cnt;
 	u16			ll_rd_cnt;
-- 
2.51.0


