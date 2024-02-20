Return-Path: <dmaengine+bounces-1046-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 144DD85B8DA
	for <lists+dmaengine@lfdr.de>; Tue, 20 Feb 2024 11:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57B56283239
	for <lists+dmaengine@lfdr.de>; Tue, 20 Feb 2024 10:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0015C60EE3;
	Tue, 20 Feb 2024 10:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="NCGsKZko"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02olkn2025.outbound.protection.outlook.com [40.92.44.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9D860ED2;
	Tue, 20 Feb 2024 10:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.44.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708424384; cv=fail; b=eJHemk5RTRqg4g9MDxtpWFNBt55s1D8bFHsjfck9RAe8xEM9pY1KJoPHUrxD2AAPXzADYdS0I3Vy3//40yQMxrgK3MkEgcom1aSHposCYm5QabgpXLzC9vsI3X8nw/YoKiKGG6UW8NrpSJ5CN4xVfJl8zs3a+AcWLXxrUiOFAy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708424384; c=relaxed/simple;
	bh=ouxefHIpGZGmrT+vird8Utj9eejjWequ6j5GSKZklzc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=VgAfjcehMG9ItkBZMHXwTKHUyTIjUw7KxBeTilJVthwr05XeebQ9MeqiGovVg0osSRWiG2/Ih4SNaJJid0zdrC2kQOtIdUG1oM1mCVs9lYGDc75VNuRsI9iKlfJEZI+gAgkGfT+yq1JKTwSszlI535nNUTKJGvYJJalKh07mOO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=NCGsKZko; arc=fail smtp.client-ip=40.92.44.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=isBpgTbglhME5rusCt8iySr7pljKHhQuQGsSg/asvzDeXBC9fx01InlLqay8rV1LnDPHGsAI7lQZ8hdwhhqVeqZuzwnqXXGSq/Kf/wfNxfNkFCywWhbTQG/pbJoTRtgHM1+nMsyYsZ7diu5QKXLB/gfT1tQldihCYPE8NXpT2teGDt1uk/GXECcmHkQ2CqFA6h6/zTvbjDMpstj1+6BAVyMQcZ5M5UR2P6U/rHyFtyG7LKi5mUISvMobHw5LDN47LkYFKbH84q3k9lKkkvEn8BS6YMD9IF9NNyqdVZp1U0yaT8V8TTWempBqpqFkCDoWJg3+VMBO1Di03TY0zP+1Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=39IirCZNxr98d/O/hF06o6b+3jGtIF2l/EuwbTM4P+Y=;
 b=DdwGFrx0akZlnZW0MkH9V00++F6BEzIjDCdq+WcTSE0A8KYryCzaFS0fsHcw88HECZ4Qxugnu1YDmUWN9OCNfTDzpk434LN1iCdeCQiYdM27CEDS6EgTq7tG2eWyDM2hsE7ujlu99/hs2Xe4AqhjN6IAvtYvT6O+mCJU7A7Q95WOjTxpX13WpZM8C7A7YgAa5MlEQkOe6/qmr/pD8b9JN/urYnBA9NN3UNdtvfPlUDOsjZSLNOvKzNWjCRo76dRAHMO8yO5ZuYmJixKFK6ZPrUlcEP2+DDL3A1Q9Zh20xNEHAURavwkelBbGIiTIw7MTF8EJgptazvypKiTMPH9w5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39IirCZNxr98d/O/hF06o6b+3jGtIF2l/EuwbTM4P+Y=;
 b=NCGsKZkoikiBhohsuwUXgbWYi7kePNsFs5/4eMcn7yvNGsFF90rjBN3AH6nWK2S8uUVwbhjVs/2QGFORNipZoY3BkTA+lMIqysLRdOcUXruQqH3eFmHj6kfZtH/IcTnnpN/u6kreazZHCH7Fl9qGf2Kg1yV4R3sQav/aSzcksqyo0wQs5BaXbVJWOgkd9nRLP2HwAtVdAIQo1w9PT1km9mSVhkZCdS6OMmTAGP0YuYsXJrVArOaKAsZsK3EvzYY0YmRmeE1eWkKoH4MmpWNzZhDcBCfp0sahspNHw+RSKd84lr3FKpzUQOjRtWQ8aYi49hrdbacDs9jb10p7Br9u9w==
Received: from PH7PR20MB4962.namprd20.prod.outlook.com (2603:10b6:510:1fa::6)
 by MW4PR20MB5156.namprd20.prod.outlook.com (2603:10b6:303:1ea::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Tue, 20 Feb
 2024 10:19:40 +0000
Received: from PH7PR20MB4962.namprd20.prod.outlook.com
 ([fe80::4719:8c68:6f:34ff]) by PH7PR20MB4962.namprd20.prod.outlook.com
 ([fe80::4719:8c68:6f:34ff%6]) with mapi id 15.20.7292.033; Tue, 20 Feb 2024
 10:19:40 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Inochi Amaoto <inochiama@outlook.com>
Cc: Chen Wang <unicorn_wang@outlook.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Liu Gui <kenneth.liu@sophgo.com>,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>,
	dlan@gentoo.org,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] riscv: sophgo: add dmamux support for Sophgo CV1800/SG2000 SoCs
Date: Tue, 20 Feb 2024 18:19:13 +0800
Message-ID:
 <PH7PR20MB49624130A5D0B71599D76358BB502@PH7PR20MB4962.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [pKf1VHkKhq8/+HXX2C+3TBlNcrfu2J5keS8d1/LtsSQ=]
X-ClientProxiedBy: TYAPR01CA0119.jpnprd01.prod.outlook.com
 (2603:1096:404:2a::35) To PH7PR20MB4962.namprd20.prod.outlook.com
 (2603:10b6:510:1fa::6)
X-Microsoft-Original-Message-ID:
 <20240220101914.866809-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR20MB4962:EE_|MW4PR20MB5156:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c87cca1-53c2-4dcc-97f4-08dc31fd727a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	K8olmdEDXVEAbtUbBtRjTLhHIG31yRU07IB5auPJ0MDPh7n21A9uRp7QM8XoJ8Uh/nXAIpbHqILwZtCf6OV80wTMVDiHRoSaJzXysF3w+8bCZwAyVge/KggtWRXhyYh5VHXF5hDv9gTGyuyRhhisVptIiSAhmxoV3OghGjrilSwoIUSqyZe+FWAxe2DsHNSfua7y21jCUax09Y+XKOpzAFA9qZ17dJbe+xZmyM2UchsuiUjFc8pCNzA2p2H8P9ofHCo6hNj1/0OZpmJLrVxXMQgVxGB2Ap/V+uJ4XxN2AybMJWWfH/CQ43ie5X7005IZysQx206mRAQj2s3JhaChShtOk4/sSYhGP7+Ae4wsBQltbm4FwnGrpPigcJAyuj3QanDneDcaZ8Or9dFrsc3U3sOsLw/jz52A07EIwUA0fwkc2KG/emSDVhM07mhhul1AEJr1LAHNyv27UlCVTSjQHoOaYke5on50Ag3Lhe0QR2BfpVOOS1DIOF4NFSRSXb+6lqAHjImTbCRUclXHRUaR4Yv4vrhZNaM/T/5dB5ccCMZuevGoNP8L/GHktqTJwgC06BHEPLcHNG1wqC2ilr9BtLsiTHc2prBGV+HzYCbmz5CUlHaLjcifML/NKeK7UqWm
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S0/sxIMdQSP+mmvoizVBx/H87UCAuxsHIePoI/Up8/bhR26ipLcwEr/DGE+T?=
 =?us-ascii?Q?7Hq4Cnxh2OLzEYrIHz+av7QGEtrOyibODsb66iqL7XMEK4xOxJoRL0cgMeW3?=
 =?us-ascii?Q?fi77jQ0xrAh0Qr//1Dmkjr/kmh5oNbqF0zrvMZmCWpftreS7W/tJ9Cm5Njou?=
 =?us-ascii?Q?YwD2fCiGz1wmLeASBkodDDP0h37Zyj97dmQbhcz4q2SvTugxkVbreZmkVktK?=
 =?us-ascii?Q?bbgv7r1lOr/oLVzbcWKP62PmBDeAQL1crqbcIiiFmFOOC1M6akC3iuH8VuGp?=
 =?us-ascii?Q?xZj/ZfTYncsm3e0MGPzCAnSEyZ9eBBO0Qb83Y+uOiejFQnPeCAfMSH6Ax2BN?=
 =?us-ascii?Q?k7VUC1pHOI0mZq29EXyyZvAKixLCD74PucNaOUTGdBJviMQ1Y/Q0XM0JwOoM?=
 =?us-ascii?Q?/lIYZx0Em15iSPaUCT/NnY+BCvuoEvUpJq+4vbEvAQV3Q9NXDdZPuY4lDod+?=
 =?us-ascii?Q?YGDCePLmMjJQLTtNngUixbBBuo3cnurMnRBxdS3doP+FZyLzmnGWULQTjro+?=
 =?us-ascii?Q?/N/teniPMGT3WdEHNY7Q66Mqj6MfwlXsysKHQfKKj+IviArlv71K6KrozreZ?=
 =?us-ascii?Q?kP6h5Hn6h7/kCgtc1uqt7opAMV9zywnOdBCSXE22Vf1KkkdBXFru2ys4kCbw?=
 =?us-ascii?Q?RFLKNPfUjm00IPrVvhiEGxAEpjIlbAdzxf+WZ1dwmZv5xiaSqHW4/BZyeCTH?=
 =?us-ascii?Q?v59YffW5s5iQIIK68CAGNQ/GCKcCQSMwPEFEyWghY2vP0BqliljUjEx/vE3P?=
 =?us-ascii?Q?9bI6SzecylScg65iyLOIgqTOCBwePIFR/Rkgm26WqAhlqTx9sMz4sg5wJVx0?=
 =?us-ascii?Q?rk0f+2TfzhzpFNN3x0j7eoxxQ1MKYLmJ+ZiPM1u5GsRsrxzI6FIk3vwkKlgO?=
 =?us-ascii?Q?FX3fFS/GBcVGuv58Ac8jkvpBp6RmxjG+AfgYRKt1KUX+yUTQ9oT65lEI2qvI?=
 =?us-ascii?Q?2yqG/rTGxtj8u40zk0/cTH1NbOpZMIHqrBgfNT/Q0tKEx7L6KJ/fuYRdjlgd?=
 =?us-ascii?Q?1npCUL6sN5AiUeyQzlUoP3EE3+5KqzWW28Pv94ebP7aW6iMf2z7u5KdU1F5o?=
 =?us-ascii?Q?JMVqHZQVuTrro3UCoBpXWVdn5muw97eG/e0tQePPmqGrsWLgkUOrPqU08OXh?=
 =?us-ascii?Q?CQc/IAkuyyk+zeeRn2ffjFvR/Xxlh6wfYZQ0G1PWR0HnIUyIzJX3KAT/swQj?=
 =?us-ascii?Q?WXmOZuOPbfNMyQTnwwOXqIt7RPPDoMsNKSQKFmvQ0x8d4K6WUapvRfHX/gCU?=
 =?us-ascii?Q?ZRFvjCgNW57/LNFXVHzH?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c87cca1-53c2-4dcc-97f4-08dc31fd727a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR20MB4962.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 10:19:40.0250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR20MB5156

Add dma multiplexer support for the Sophgo CV1800/SG2000 SoCs.

The patch include the following patch:
http://lore.kernel.org/linux-riscv/PH7PR20MB4962F822A64CB127911978AABB4E2@PH7PR20MB4962.namprd20.prod.outlook.com/

Inochi Amaoto (4):
  dt-bindings: dmaengine: Add dmamux for CV18XX/SG200X series SoC
  dt-bindings: clock: sophgo: Add top misc controller of CV18XX/SG200X
    series SoC
  soc/sophgo: add top sysctrl layout file for CV18XX/SG200X
  dmaengine: add driver for Sophgo CV18XX/SG200X dmamux

 .../bindings/dma/sophgo,cv1800-dmamux.yaml    |  44 ++++
 .../soc/sophgo/sophgo,cv1800-top-syscon.yaml  |  48 ++++
 drivers/dma/Kconfig                           |   9 +
 drivers/dma/Makefile                          |   1 +
 drivers/dma/cv1800-dmamux.c                   | 232 ++++++++++++++++++
 include/dt-bindings/dma/cv1800-dma.h          |  55 +++++
 include/soc/sophgo/cv1800-sysctl.h            |  30 +++
 7 files changed, 419 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/sophgo,cv1800-dmamux.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800-top-syscon.yaml
 create mode 100644 drivers/dma/cv1800-dmamux.c
 create mode 100644 include/dt-bindings/dma/cv1800-dma.h
 create mode 100644 include/soc/sophgo/cv1800-sysctl.h

--
2.43.2


