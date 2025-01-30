Return-Path: <dmaengine+bounces-4225-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BCEA22D45
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jan 2025 14:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0B613A7083
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jan 2025 13:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AD01E2852;
	Thu, 30 Jan 2025 13:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="hEh5SUK/";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="hEh5SUK/"
X-Original-To: dmaengine@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012005.outbound.protection.outlook.com [52.101.66.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587771D88DB;
	Thu, 30 Jan 2025 13:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.5
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738242578; cv=fail; b=Ub5Z3D4oCRSaVBjLE9NqTmpy8Q4qdkylqDD6LEWzqh7LiVGLYkjq4BHShX5rMtytjcnXarg5Uul71ODeqLylnuGqMUPVMsHOCuygwbEmoJM2PcpbLONE5wIJ3i25burkMkLZZ22gILpOt8dQ2hsiZ5Uy/R2g62xc8gXUlfeh02o=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738242578; c=relaxed/simple;
	bh=ei9mU9et+DPLvaAOfvkPrVZcdl3JCvDOCa37FMWIcXs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WQ+oG6FC795Zs492uqzR3W4QkExze8Ii6UsiTH0+xRJsE8Ex5Wa5XWmClIm17A9v5Uo8/7ZxgXrGP85uPYY++mJqpMjKkKH45H6ggGnfViw4Mqn9SYOyrP95kd+pfwyWIFqjp5lS2wHToxwojLkWtK//X2YfEa3XDnDLTWiWOK0=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=hEh5SUK/; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=hEh5SUK/; arc=fail smtp.client-ip=52.101.66.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=FhzmgMq8Xw/n4F/FTenfempn4hkyuyptnlBv8rO9dZjmDIoiRunZfaU2G8H9FDqfMbw7RmpcZKieNE3jOsL+PQpGwtySQnk/cQUOwLz0lWfqY+G3xNOOWfbliFotXrsAIFGvWHdJ2kXBWTcoZYATH8JzBTTlU+nHZ3hXdLHeIi8Y3NSD8duAShj0ZzuVPLUmIAClzTlUkp0wb5DUE3DgjiwnCmH5zghXMSjS5j8y+01Xo9OHD4Am6JOum4+u/s6oT3llKZ0NuPSkFnjeBe5cVmMeQ7vjXMOKH69+CAbkrL1DMSxYMuUsYAMKx8Zvu4frnYbQzepT5m0d1wc9YNOTjQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UXjSOSLsb7QXXz6LyVv3iqQW8mKVxWL8nBI4sm2ps/k=;
 b=MzHK9GWAL6BGWQE8gn/remDzfoM02AL+mPRqw2NQOKZbUr1sAVZUtTsZtdMWd6L0HwoXLfWQBuQh8fIPMqcE9zU8lNPprJcRTWxS6XbF80jn+1pEMBRH8BOoLgaeqHIweRurDy7yWqcveq70gaXi+up9T26AsEfyKNztOfCsT1n9IJX/6/vEOWlUoRhUosuHAfiQBsgzw1wylSsWr27Scg607tF397iL5amvGktifjp1IenTeLKPxGrTKEg2PfLnR2WyfMgl3j2VOLjDPDeAO8z6MReIOAPqxnd7bwhvm+IH55VkJeCXpZPlCWBl/HtXB4nENCK3Q7dQUw+ngFAB3A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=0
 ltdi=1)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UXjSOSLsb7QXXz6LyVv3iqQW8mKVxWL8nBI4sm2ps/k=;
 b=hEh5SUK/ps2zChagWta7nkTTJsSVck/fa2kVvjZpY8GIyO6pkNTTif/5uxVynkMpRyjwip7SmzVW6gpBDo9fdEtYtW3vPpyM4JyhUcg/SE9AkVQJB3sKPPmoCmyWrUEoqhPYYsywR0eg6QQ+fU/Bn1wpOZclCAmzO7K+z2jy7yg=
Received: from AS4P195CA0043.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:65a::11)
 by AM8PR08MB6563.eurprd08.prod.outlook.com (2603:10a6:20b:315::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.20; Thu, 30 Jan
 2025 13:09:28 +0000
Received: from AMS0EPF000001A4.eurprd05.prod.outlook.com
 (2603:10a6:20b:65a:cafe::db) by AS4P195CA0043.outlook.office365.com
 (2603:10a6:20b:65a::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.20 via Frontend Transport; Thu,
 30 Jan 2025 13:09:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AMS0EPF000001A4.mail.protection.outlook.com (10.167.16.229) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.14
 via Frontend Transport; Thu, 30 Jan 2025 13:09:27 +0000
Received: ("Tessian outbound f30a9786ee22:v560"); Thu, 30 Jan 2025 13:09:26 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 91e1c7a172a7e595
X-TessianGatewayMetadata: WkF+dqQQruReeSGG4qB1YousMuQFgCQ8b34WLS9XlQu45hD1Xm8qzM7/9y6wZNU2tXVPvhsW449KReIfHHfd3p+rsheA4C8aQBuwIwhD328exO0al/RbTvj2Ndzjwg7uF2JMd0C1de9LxCk62s6rEuR+H5SRNP6wsolh1S/dLI50tIxg3I7pE88F2zmDrOZEy5D2kbFSe1f5omcOp82Nrw==
X-CR-MTA-TID: 64aa7808
Received: from L35ac65cd58f1.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 3643363C-6AD0-4BF5-B88D-30EB6BE75727.1;
	Thu, 30 Jan 2025 13:09:18 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L35ac65cd58f1.1
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Thu, 30 Jan 2025 13:09:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jq+h/dgtpkg9M8YFNEKEjh41GX+1Bl01T0kIM36xdQ/F/evRYa3qFzHKcm0b6kDNizlV/twZvfOiEfdr+egy3Qb80dLTwuiXgIiKoVtpGbe8y6scMaQ42ar3qqGK0z3e3xo4/71BAR7GE3229ayynYlpLm2EZEsdXGUoVI0Ty/nS21Jeruspw2xHGsnQVv/fylWCRooubfsUqJnOCCCaAzr0AOmxvrxfNM5mXU9VaxzfLpZR7h++HrmCcFoTbBYXOkjcVhrRfxgtLYGupsW5XFH93FLakNZDhKMRKam0y2iS49bgJT201/wufeWjBjdqL/8yAzErpjSgpW56pw2Gdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UXjSOSLsb7QXXz6LyVv3iqQW8mKVxWL8nBI4sm2ps/k=;
 b=iAGqE0rD9qJwcOzvipNCjf4wsUHOExW+IYdcW0QHTJ2ygNREOBI2KA6QsVA2qBewUrk9/WtFcG+56dlYG0EKY63b+3qW1/r8oF1G8ttb0eMvG110N3P92iEkRWN7ukC3H5Doza39TFVOKHdR1h1l1Hpp/cXTuKcWnIra5LzH5MbUQZYFRUo2O6ZDMuxRKf+U+fqB18fdXkK2S+AyFo4OcnmZ1f6cCQ6inhorhXDfw38wSogVBVzp7c+q8xr9qnx+3CqlmLAyuoq6/nCw1fyW/nob3K25tsyqcjSnYC+6YD80T8B8hLDLRXbiAHIjxHhDaRxN3BG1M+6GP+EiQDQxzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 172.205.89.229) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UXjSOSLsb7QXXz6LyVv3iqQW8mKVxWL8nBI4sm2ps/k=;
 b=hEh5SUK/ps2zChagWta7nkTTJsSVck/fa2kVvjZpY8GIyO6pkNTTif/5uxVynkMpRyjwip7SmzVW6gpBDo9fdEtYtW3vPpyM4JyhUcg/SE9AkVQJB3sKPPmoCmyWrUEoqhPYYsywR0eg6QQ+fU/Bn1wpOZclCAmzO7K+z2jy7yg=
Received: from DB7PR05CA0071.eurprd05.prod.outlook.com (2603:10a6:10:2e::48)
 by GV1PR08MB10789.eurprd08.prod.outlook.com (2603:10a6:150:163::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Thu, 30 Jan
 2025 13:09:15 +0000
Received: from DB5PEPF00014B89.eurprd02.prod.outlook.com
 (2603:10a6:10:2e:cafe::b1) by DB7PR05CA0071.outlook.office365.com
 (2603:10a6:10:2e::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.21 via Frontend Transport; Thu,
 30 Jan 2025 13:09:15 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 172.205.89.229)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 172.205.89.229 as permitted sender)
 receiver=protection.outlook.com; client-ip=172.205.89.229;
 helo=nebula.arm.com;
Received: from nebula.arm.com (172.205.89.229) by
 DB5PEPF00014B89.mail.protection.outlook.com (10.167.8.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Thu, 30 Jan 2025 13:09:15 +0000
Received: from AZ-NEU-EX03.Arm.com (10.251.24.31) by AZ-NEU-EX05.Arm.com
 (10.240.25.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 30 Jan
 2025 13:09:09 +0000
Received: from AZ-NEU-EX06.Arm.com (10.240.25.134) by AZ-NEU-EX03.Arm.com
 (10.251.24.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 30 Jan
 2025 13:09:08 +0000
Received: from e121164.cambridge.arm.com (10.2.10.32) by mail.arm.com
 (10.240.25.134) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 30 Jan 2025 13:09:07 +0000
From: Florent Tomasin <florent.tomasin@arm.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Boris
 Brezillon" <boris.brezillon@collabora.com>, Steven Price
	<steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey
	<Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, "T . J . Mercier"
	<tjmercier@google.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
	<christian.koenig@amd.com>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Yong Wu
	<yong.wu@mediatek.com>
CC: <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
	<linux-media@vger.kernel.org>, <linaro-mm-sig@lists.linaro.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<nd@arm.com>, Akash Goel <akash.goel@arm.com>, Florent Tomasin
	<florent.tomasin@arm.com>
Subject: [RFC PATCH 3/5] dt-bindings: gpu: Add protected heap name to Mali Valhall CSF binding
Date: Thu, 30 Jan 2025 13:08:59 +0000
Message-ID: <36b57dcf20860398ba83985e1c5b6f6958d08ba7.1738228114.git.florent.tomasin@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1738228114.git.florent.tomasin@arm.com>
References: <cover.1738228114.git.florent.tomasin@arm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic:
	DB5PEPF00014B89:EE_|GV1PR08MB10789:EE_|AMS0EPF000001A4:EE_|AM8PR08MB6563:EE_
X-MS-Office365-Filtering-Correlation-Id: b1c3e3dc-0603-4b89-8a63-08dd412f53b4
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024|7416014|921020;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?JqMW2AHMxE6ja3EPK3WX1c429zqIyYgdP3UkhafeyaEQMrUFNfObPmHbm7gI?=
 =?us-ascii?Q?wlh5REPnLtSX6R4Z3FxHZ8DNLooMvpHwV/H0yVdj447BMrgxFERuI2e1thq4?=
 =?us-ascii?Q?ODn4zHt/wFx8Z1dZ6GD1stfBmgD5gJMnI6wJRvAEP4FORfzJcLc8sTrVNaxr?=
 =?us-ascii?Q?JZAqNiz2oIXEkYuWLCgjs5Uznpy+8aWgFnXyWJBY2QI3BCk1ucMWSN2uGn5+?=
 =?us-ascii?Q?DkRR5M8bWEAaFc2LTUh9a0+rWHz4Ag5Nc+VY7TMBM/OCKPAqU5LGYBNI2oVF?=
 =?us-ascii?Q?s30PJF/D0MiYq/wVccNWDVq4/R7ov7ObsNPJXeRc8VK7NgLcdbtMLr9pPEqN?=
 =?us-ascii?Q?mUMb5DFDEt8A0BCu8A1F+r/IFaaliRk7jtFfKQvSy+aI2jHfHYRX2EhIPkOD?=
 =?us-ascii?Q?8Yrmrm8KHAkxPC1XPlQIY7qbJoOy0XlKJYsohvyY3mmn+wQbvFpLYdFiWIF6?=
 =?us-ascii?Q?gnI2QCUKiuSSw3smhSYnZqwRLDCnnyf7oqiF+fOuxlyG5dWCfT1NJuxs+GmE?=
 =?us-ascii?Q?RQpVYrTHzIXh3uy1FDyxFaJa3tnK6CTzmuNdsbhc3tFjxdbh8RmI3vuspvjb?=
 =?us-ascii?Q?g228UQOaAVKbXVsy4BV47c3tfJuC0b6Tzw5WYAt/k+52YxYeNQHS3M0Ia3iy?=
 =?us-ascii?Q?1vlHkcmBVC0NEpShEloCMyT6zt8gkToTf/aatO9nfJ6SmJiAkzz+ZdhytInR?=
 =?us-ascii?Q?bej0lX8pPjcSjYEzjkf14vh6GdOP93JrYApyJCufIaaPXEl3+7M3M1gGPEtm?=
 =?us-ascii?Q?Kry5KUQ/UBuyf58jZNtEDnwMwH1xaYUYCHqzJf2T9CL8aWTwHZ3vwi4qS64O?=
 =?us-ascii?Q?udG7NkcQTH7eUFTpGEbi1PIACMoZ96nhtZ3DuTcRygFveBKMh+wCCSGVmjfi?=
 =?us-ascii?Q?9IQAVt9p2AzytoqChr7sEMSQ8Lf2wmIPz4UXlhLD9x9o3bnyLXcXtsnFczq8?=
 =?us-ascii?Q?UmyeQiAG7YYazDQtLCfeABS96ldo/Hnz5MM6qyR0/yLy0k/+PRCRR1bgf4Dp?=
 =?us-ascii?Q?TTJOvAukFnJEzZNN9M6h9d/P/fPoLYIuHKgZMeugdDXAeBYGHKL3JHuh1Ip/?=
 =?us-ascii?Q?E83ivxq7okmDjWhWtA0Mri8ce+0Jz3TF2xFVgJKjQlPsnl5WR9NKAq5Jzvzu?=
 =?us-ascii?Q?bc+b+CZjqeTPAtrjtS39jBsIAxnhTdxoagMK/uYRkXXg5nY2vSH1KETEX9NE?=
 =?us-ascii?Q?mPVuL7GjdiNUdLqFOWtFB/y1lL7QbEa6vGMxDbtFp8oVQ7orcmMR6xewieve?=
 =?us-ascii?Q?hGQUp1Z9UYYjnfERoSK6PENS2/VzDD8wNvFWMKpMqIcST/wOvM0Zy9zNzw9d?=
 =?us-ascii?Q?k0EUAyeavfv/Bh5EMyzTyXmr19MX1FOUvUQtRTnwP4zAiX0ix6QdRF9UppvZ?=
 =?us-ascii?Q?VAfUkf71/e/rcgeFiU9mkmrQUU5/Yn63KuswELqIkmB5MadBbpoIfCJOkQEi?=
 =?us-ascii?Q?c6K0d0zXRNguNSRxS2C8b2POYy+cwHY4rN+5Jh+ZxhZNxt3LvLqRwg/uIWjF?=
 =?us-ascii?Q?wKNppRPyMfMOPXu9h8HqxHCHDCE2xd1FNVFX?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:172.205.89.229;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB10789
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:10:2e::48];domain=DB7PR05CA0071.eurprd05.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001A4.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	f866a139-ca62-4d86-fb34-08dd412f4c02
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|35042699022|14060799003|36860700013|82310400026|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NhzPsDaEbXaegCfUlaFyRsLgCQpcMg/Wtofh68VSD67f7sS1F4uaD7qdzVdK?=
 =?us-ascii?Q?+p+1HxeC0i42oDnmADkuhWRct8BUpBjreDkABLrInAWpZzKUoNram6ZPfH+m?=
 =?us-ascii?Q?7q6lI/SjElw114rk/CQhJN8H6DKH2J8vDFKXoxHfaSCHXNSWbz8u+CUuCnHx?=
 =?us-ascii?Q?YBB4vC4kBXAVzNp0EXFFHhET8Wsl3FEbdStE39RYn7IDQyEHAIN13cwZ/AQI?=
 =?us-ascii?Q?tLx2CPXQLRxo+bVJYdK0gLpF/jB9tc64cz/m2m3pBqoakQPBVchuGuajA6RQ?=
 =?us-ascii?Q?OQCqrmpuIxAirm90L022Ahk+fhtG4sgAc1+BWQNnGGOPs55eS50Wy+0UOrKG?=
 =?us-ascii?Q?dBciOUtDS7M0xgUmilCPV6EfbalTwVVZcMh78g12j9preunDcmx2Jore5qBD?=
 =?us-ascii?Q?Q2hmTLrxFfAJZs9d4jFz+jAxu+i7MU6AORhX1nxrF5uaers9BcMAZunD82yi?=
 =?us-ascii?Q?Dp4ftB4FYIiSjKs/BhaGBjRBWMPWBKSkHqQoxtxCYdEZH+R2HkVpRmggobWR?=
 =?us-ascii?Q?OQHJMyqv1U3axzve0fF8tBkO29PCvL81rhtxWN2KNpbBB4vIBFz0Ex64wK7Q?=
 =?us-ascii?Q?RXqaQpMisaAmE/yQbtM4jUpaFcbplNhquRrL/nAbKfrAVXSv/uxXPpsaoeIl?=
 =?us-ascii?Q?HpECXQcHJaKAIvHujEBWfdwA2iDkeLH600F8sAovKXGLx28ITEA7LiNm842R?=
 =?us-ascii?Q?TXzML7At+g80OZHgNIdEXlVRsKobV9MUVQNz2Jh2ce/vC+teYGcJsceV8cUH?=
 =?us-ascii?Q?s5gsrUgYFFgDi28qvTgOyD4C39ItyJJflYinwqPvnxzRvgPXHZ9mWubQc0p4?=
 =?us-ascii?Q?UNzAfRRSjJM3mxUsGoBznFvzCieTBsDK9CVCEkOdhCnDcJhedAM7MPQDT2zC?=
 =?us-ascii?Q?Mz0T+m1FEbVHd3GVE3c1Ov7wvSakN2J/R/pHQs5GjdxR4hFCWO+RAd0kb/vE?=
 =?us-ascii?Q?ldtHPKQ5vYXPINTBpn4LdSJ+LTOV74fr2xjq34sxV2mh0kj+6VImvTq/VPeL?=
 =?us-ascii?Q?1ODTuIGoRx4e4b11LhLoi5ecHO9qFEM89CK3RnTLXIo4g5J5swd9Air9p318?=
 =?us-ascii?Q?QXOvV+Pp/JM/EZwtQ3sxxAoKKGEDbGRHhowxukUpQpjz3poXGxJOVLPJHxpQ?=
 =?us-ascii?Q?Vk7Iwh6ZuJIJzj8fOHEXXjWxOc5RQueXwabqw9DFC/6CUcmMrUn1urCmK61P?=
 =?us-ascii?Q?6QBNBAtgF+o/1VOf36Qyt+vYjspMPiT0wjMWOG6yA2yEtFkxeL7cRZ69CB4v?=
 =?us-ascii?Q?wuOPONPzO/or2zR9NgyD5785QKGnB5TqVazs06Hjk40eT7YhpMHzkFhO3wUg?=
 =?us-ascii?Q?2Jp8K2TOXnmXFkMaBXHIXa4ap4UdFKU5uZ5CFIJBsjU9hxzqDYw6fYHqr/oq?=
 =?us-ascii?Q?JhcSyQEtY0IaPoO1KybAmvYARJL7f8CP18+DAuSH4yoiyJtlGkPKfmMapIyu?=
 =?us-ascii?Q?pRYCpRGzYSGAybN8jCNf4WRIL9/Of3BQPwgGWOhMfh9BcsRkJWbfGEv7rdqn?=
 =?us-ascii?Q?ArFPT82tCH2Qz5zZ+PyCnEgT//XxNwdkp4yc?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(1800799024)(35042699022)(14060799003)(36860700013)(82310400026)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 13:09:27.8993
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1c3e3dc-0603-4b89-8a63-08dd412f53b4
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A4.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6563

Allow mali-valhall-csf driver to retrieve a protected
heap at probe time by passing the name of the heap
as attribute to the device tree GPU node.

Signed-off-by: Florent Tomasin <florent.tomasin@arm.com>
---
 .../devicetree/bindings/gpu/arm,mali-valhall-csf.yaml       | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
index a5b4e0021758..dc633b037ede 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
@@ -85,6 +85,12 @@ properties:
 
   dma-coherent: true
 
+  protected-heap-name:
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      Specifies the name of the protected Heap from
+      which the GPU driver allocates protected memory.
+
 required:
   - compatible
   - reg
-- 
2.34.1


