Return-Path: <dmaengine+bounces-4228-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D22CFA22D52
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jan 2025 14:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D264A3A772C
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jan 2025 13:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE971E5734;
	Thu, 30 Jan 2025 13:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="fkNDtMjt";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="fkNDtMjt"
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013006.outbound.protection.outlook.com [40.107.159.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C9D1DED4B;
	Thu, 30 Jan 2025 13:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.6
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738242579; cv=fail; b=ON1uH82bbBVQ/qqniK9bm5iDdoc+9srQAlEsNdVUrbmDUEYf13+uzHWadAGqLgXXLGY6ausAsXvPOzInr3TH87jVKyBG2myo+wSvJswUOpDgR0ChKSVBA6I8WQUmg6idmSGlzF4HLD129wCvpkDVZLVrZgnI9isST7qJ3EAQj5Y=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738242579; c=relaxed/simple;
	bh=SF1E9KEcPF7orubwQW5xFnHo59cNg4J4xfs+vTktEKI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UyWEhK3m1neGnYtoa00yYT4/4H+QkKCcpvuFmRb6an2NglpGlEmjUOb6k/3IJo8fbjZ2ys88RgrjtGR+Dhi03yakXmOkQF8q0INTSTJlz70WQpUb6j1upAuqlaYp8QRtSIXFBmpvX03Qzv3sNxGVJ8vK3WYpZFHr3FHfmBU/MO4=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=fkNDtMjt; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=fkNDtMjt; arc=fail smtp.client-ip=40.107.159.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=C7jL/De6OPrOoBlkxHVQkTjZlA4vS0GR4QQwqzgytG97P3lyCZQmN4FUX3nCdboX7I+pBtsG4/+aGLx1E9Gqcb/VCKjbSpNMiBFdgvBDSK+s1AkScN1+XnX1Imemiy87oawxWOfjI6zxExbgNTpnbFeBF1U5yagF84X6NaPTgO7adlDrSh00/4QYBu9lpPcK/Jp9CsMXbfqSh3E4b1/4wGFcArnnOyeKXnIzuuP0uodIHZCyoI8pR8h4ifEo+g7/+g0bWjFLzH0QRLmDTOmWWuCIp/vsS5M9U1oMcBc7gPJTtrZ/5UoKWqaU9cMdY2KOkBJgGTVYYZPHwAuBYUFfPg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HhS/tbVVv2nG9EXWShqCV2+SDZU9FYl2KF5Aw4J3220=;
 b=JkpT9R64Lp6Kq82AaE6RDK5jHX6gvD7oOaaxTKLbZIQN9xZN5SEk3XlAa+0yLnIRsZiu4a86h9dFsBUj3pgAJ+Xe62vYwEAgUyeaRZXgnVhwjf91dg0qY5spTUlqFdXxB0vdF03UsvinpqIRcEuKWSl+kcHvnBXS14ifmiLB/VZNzUMeAeXpi34B+BMxgtrwm5e+m9v8AwCmvEcPNPyHvjHuJgUdgcvRR0YcIHPyszp6LS5BTGRZano3DgP4HqmJYV15uq5No4ey47p2es5tmKORwdznI/zbWEsp1PywWZiYH8xLlJcPPGz1kOUAXtzm3p/CSKNtnRZcct1gfmqQtA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=0
 ltdi=1)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HhS/tbVVv2nG9EXWShqCV2+SDZU9FYl2KF5Aw4J3220=;
 b=fkNDtMjtfoUjOZMmWF9u6+jJZ3w+VY6r06JMyjGzEOLG7UXt68gukz6GuP3og/XGnwv81E/kfQOZ5CLbxdDGbFqj+rUF/ydxsIBxrMPlM/hMjJf8XqN++vXLrCm3wG5tP1t583T9E1uQw4yu7JE8Im6yLr0/VC58HwwaSq9eqYU=
Received: from AS9P251CA0004.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:50f::8)
 by AS8PR08MB9977.eurprd08.prod.outlook.com (2603:10a6:20b:636::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Thu, 30 Jan
 2025 13:09:27 +0000
Received: from AMS0EPF000001A7.eurprd05.prod.outlook.com
 (2603:10a6:20b:50f:cafe::8f) by AS9P251CA0004.outlook.office365.com
 (2603:10a6:20b:50f::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.18 via Frontend Transport; Thu,
 30 Jan 2025 13:09:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AMS0EPF000001A7.mail.protection.outlook.com (10.167.16.234) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.14
 via Frontend Transport; Thu, 30 Jan 2025 13:09:27 +0000
Received: ("Tessian outbound 5438980c8758:v560"); Thu, 30 Jan 2025 13:09:26 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 72d6f04d9d32a842
X-TessianGatewayMetadata: VZ1gol2vpkpx7GI7TujVKeQ7nnUISba/c/lJrVYKRpzmsxF6dWy4YHLLxwnmaN2AOXI1uO/Zl3nWOS0J+Z6Q6xPoMSCDH72CZVsXZ0q7W+z6BRmQ6LKRsQ1qwBZg/kABY/22966ghpokeTYy6FKcdrG9WBURHQRFt0m4ilL18hx+JDjVpiGSc8eC799Oyc+PKoymsQ8wRFYcwWj3Ak896w==
X-CR-MTA-TID: 64aa7808
Received: from L5f77923fb7d2.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 8905E2D2-A953-457F-93FE-AF38EA3A1E77.1;
	Thu, 30 Jan 2025 13:09:19 +0000
Received: from DUZPR83CU001.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L5f77923fb7d2.1
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Thu, 30 Jan 2025 13:09:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aVzDpi/QUa2cZuVapLj71QIsIr+z9ZMtsE7xLbXFQu8iAnQ6u1m5cv1GngrbSAvWO2qxhEtUDNT+qd8eDV8HD22Y/ZZBxX1YweKEN8ZU/tFbHZlHdzBHi8zXibMJfaq7a1kN7M8wXVND3XI1KWUBxkQqhGMYY6i2Nx1Z2NbS0vATwzXxVjYX9/mXp51x5hgvdLxX+9M7Tgx+Y35ZRpg3uuNyDCXoe2m4LgG1dduiV14wK/TIJPvwz5r8HX2Z5R2VMMxUS6epTRFORxZVududeXT+WI419C8zVebUl46Esn3hDJruWk6zPizHfzG5ehGudS7YHj74bC36BVTV40UupQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HhS/tbVVv2nG9EXWShqCV2+SDZU9FYl2KF5Aw4J3220=;
 b=iLZ9l4DLYBL2Y8anKVVYheoVs0h8TUFEiVGrURfJCDiWPiAwkyk5OCIVtEbgZPyq1fNsL79C8LNSxcSjFHtvIr+QuuBWk/GBCy7ZpH5NxfwoL77cCtT5/0pqqngbRXjUEXfsNcmFIpxblHGRUFyZVSfUl6YCHMqsDwmTNoBjpMEsSw/5qqwtcaIJr6rCRcRXDOhGx1orX0ncaBrQ1qnHDarUg1o0saeFIHkDPjpIyonAysDH+e36r+dmCob5RbRLCGxqqXcozQxv4wTqGzujF/WHpxHe+oIABbpAZm4rci5CFlgtcgaz7pDAzXzOhV5rm1Qr5wa3dJfYdTlnjJlxpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 172.205.89.229) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HhS/tbVVv2nG9EXWShqCV2+SDZU9FYl2KF5Aw4J3220=;
 b=fkNDtMjtfoUjOZMmWF9u6+jJZ3w+VY6r06JMyjGzEOLG7UXt68gukz6GuP3og/XGnwv81E/kfQOZ5CLbxdDGbFqj+rUF/ydxsIBxrMPlM/hMjJf8XqN++vXLrCm3wG5tP1t583T9E1uQw4yu7JE8Im6yLr0/VC58HwwaSq9eqYU=
Received: from DB3PR06CA0003.eurprd06.prod.outlook.com (2603:10a6:8:1::16) by
 AS8PR08MB6053.eurprd08.prod.outlook.com (2603:10a6:20b:292::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.20; Thu, 30 Jan
 2025 13:09:17 +0000
Received: from DB5PEPF00014B88.eurprd02.prod.outlook.com
 (2603:10a6:8:1:cafe::f6) by DB3PR06CA0003.outlook.office365.com
 (2603:10a6:8:1::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.21 via Frontend Transport; Thu,
 30 Jan 2025 13:09:17 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 172.205.89.229)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 172.205.89.229 as permitted sender)
 receiver=protection.outlook.com; client-ip=172.205.89.229;
 helo=nebula.arm.com;
Received: from nebula.arm.com (172.205.89.229) by
 DB5PEPF00014B88.mail.protection.outlook.com (10.167.8.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Thu, 30 Jan 2025 13:09:16 +0000
Received: from AZ-NEU-EXJ01.Arm.com (10.240.25.132) by AZ-NEU-EX05.Arm.com
 (10.240.25.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 30 Jan
 2025 13:09:10 +0000
Received: from AZ-NEU-EX06.Arm.com (10.240.25.134) by AZ-NEU-EXJ01.Arm.com
 (10.240.25.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 30 Jan
 2025 13:09:10 +0000
Received: from e121164.cambridge.arm.com (10.2.10.32) by mail.arm.com
 (10.240.25.134) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 30 Jan 2025 13:09:09 +0000
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
Subject: [RFC PATCH 4/5] drm/panthor: Add support for protected memory allocation in panthor
Date: Thu, 30 Jan 2025 13:09:00 +0000
Message-ID: <821252c96ab2ab3e2d8ef211a09f8b171719baaa.1738228114.git.florent.tomasin@arm.com>
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
	DB5PEPF00014B88:EE_|AS8PR08MB6053:EE_|AMS0EPF000001A7:EE_|AS8PR08MB9977:EE_
X-MS-Office365-Filtering-Correlation-Id: e9d5d84d-5bd0-4af1-48a5-08dd412f53a5
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?C63ia1BLCksXgv6LrgFDBzOG8TTo0jWWrnsy+E+iug61frIHZ7NPCG4drwMX?=
 =?us-ascii?Q?T5awfStu5UPOzUIGgDoKPioufYA9q+AHXbfYXEwFdfLQKu3KV69+L13saY7e?=
 =?us-ascii?Q?+jrXzAsryGKGTUgCupNfVOHbioQIT6M2XJG/laKZsgi8CSxgE9oec3mAqFag?=
 =?us-ascii?Q?bAB2iSajGp7gDnWqwtKETbW87auJWr/L3nBRpJRKrIOUMlWe6ZxphoDYqTvu?=
 =?us-ascii?Q?smSVP7A2AGiX/68EpaX0+F+rgASklDDZRX86qCn6gjLb6ThhtThBKChPdZpB?=
 =?us-ascii?Q?V8ZgD7Cdz5nRoKImKKNcAO1CYEXpJMzyDtgy7Ua7fX5dA6XIY28NFmv8mgp9?=
 =?us-ascii?Q?JhIhIY/RyyLV7oDHDjmwPi3h3ZrwN7f94vaWUpjUoFuooKA/nuU43OqUZ1vQ?=
 =?us-ascii?Q?WdBQ9tGQQTzHP/F/ZFUCCY4vqT1XUUvw42LNALJkugzBNQbSlOb4uAD1pqDf?=
 =?us-ascii?Q?bazKOBm/1Uous3ix6H+uVKMZId2GKgOzSuCtNIgi0wBSc+5BW07PoWo/Kwvy?=
 =?us-ascii?Q?aPUgr6CbvP9pS34TC+PjAQxY1KX+1nVzpTfjVqizKeOHMQOHXtE+pQLyLgkV?=
 =?us-ascii?Q?y8NUr/RHQFr/GKmFC/v9ZUbasvIaIMTtrrCQuYSpYraM3bPbYH2jd9am+Tmw?=
 =?us-ascii?Q?ATSkE1HESUK6vwSQ5MfUzUVQ3GID3koioVg+pN8ceguz6dtz/8BjE4XkHsCj?=
 =?us-ascii?Q?PdFiwiLrA+Ekn5/80jWWp54RCuCRXl3ZPSfV4iLP/RINvONk3+yj8JfoS87/?=
 =?us-ascii?Q?m3UMtyany/F+tthoUerW8l2FyxhA2kiK4NYQaBgxRp/UDtRKIVFA+hwqSWej?=
 =?us-ascii?Q?UoddBZeqLkGepdyWofkHvi6NZzYUGdIITP7i9oiHaEDVcAD9f/73dbctfHEy?=
 =?us-ascii?Q?cIdFc0LaTk4l1FYeuOEkVkCqQwHrTJfG/DCZCL738ym5WNqp/5wt/XXab3c/?=
 =?us-ascii?Q?xsbsjekLOXPd2kB72pm2ynaxlXMWU5n5LBgEv3IqYT8Hu1ZarrysXVXZik2j?=
 =?us-ascii?Q?NNa1U46DSdD2DLGFcUX4b4IwV0UzHG0pnxArXdPDhL9idGYnl9pPVrt6oo+F?=
 =?us-ascii?Q?/Pbc/mtSxrbDEV7Pdb/XfLjd2/TcPfMVQB+d9X9QRSw/iuhnR8tk8BLc9+sI?=
 =?us-ascii?Q?sQ++VjFN+zl25RrjWAGX4+Nl2a73y0rBPwvAlj4Kz2MqLckxEgUTWiNENj9b?=
 =?us-ascii?Q?ipuEbBa5Q/ueEPPo//seICWDROhZpUB13MY3w6Bgbt2piTMsqgZCV6elovDz?=
 =?us-ascii?Q?w6Te8/PvJma3rsmgDaaSRz+0CuHe3xRUXzFCxcQVGFyJyxic/pxlsw28CCOK?=
 =?us-ascii?Q?C6Zw6lA26aZWgS2liATmiqBGPsYVtZOgQD3OsgKZk/WhpnY3LTDpGsJhZZa7?=
 =?us-ascii?Q?/OoWUm2Ly67kpyXjQVO+a9bLXlVFQODP0H7voiMi22l1KM8Jj+U4czh1Iy1V?=
 =?us-ascii?Q?YMU7WMGcD8fuvYpupdu6+13jC8nsxJeT8SR6QRNe65sU1/Y02Z/wo/WXnDUx?=
 =?us-ascii?Q?3xsGwzb7GDnI413F9e8LaLyoQJcQWpReCX1d?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:172.205.89.229;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6053
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:8:1::16];domain=DB3PR06CA0003.eurprd06.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001A7.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	640d1777-448e-4775-ac76-08dd412f4d35
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|35042699022|36860700013|14060799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1PYgEdSSDsINqfAJTx5W2JVZl3vqENHIJYcgMzewfDi5FG7dPTE/D+dbSyBB?=
 =?us-ascii?Q?pGGKInichYKnUi8ywZEjUQUALOVKKcH4+xyWGcYbubdev3JCfwwEQQA6oDt3?=
 =?us-ascii?Q?0XMc2y8y2iuBGSSU1g9jXFq8G3hx1moOHsb+FLyZeSKKirYpEyeYci/bIHLZ?=
 =?us-ascii?Q?M0nzHEoZnvUblRfMAmCUAg+5Y5xY7eXSoGq+e1wWeSrfMu1PElEei26pasKf?=
 =?us-ascii?Q?+GNLcUIRpUdSxRv2SirCtkWA+BPxZf48XTaubvqzon/QxVYyHSaulpnyThLX?=
 =?us-ascii?Q?VoSEULemMQ3UPqtv9+LRBnpvlk46a5BV5SFgvLpmDFSvbriZk9xmw/qDXPJP?=
 =?us-ascii?Q?7wsPGlQGfdVT9g2cg5Nlt2VQGu4uvIgPCuhGiN6On4R6Oa9pdEK/iMDxbH4n?=
 =?us-ascii?Q?p5FCdo05tOq+vFk3Cp6mwXIF5Gu8DlX/4o+wRn9iVDxLuMtIvQOwshV8q04q?=
 =?us-ascii?Q?O4KV/X0bmf14Mpdethoao3iAmgQzeBhupnLdjcg78Iqkn3us9chx3eDbgwtB?=
 =?us-ascii?Q?2QjRbWt+1bcuRpNxpSalIGicf9gmhBAPw2VBOV6AXl4GsDt1I6h5c3Duk3Es?=
 =?us-ascii?Q?1B10iazi/TVZa2Hv3lUIM2eQDrs6F05Y1ENs/E0TJhog5kSiekySC/oxpUcY?=
 =?us-ascii?Q?t3cnojRUobjccvN5Z95axCv/P0h6XMwhsisAUSiQfjMZqrBtwMCwaD1dcZwN?=
 =?us-ascii?Q?7znVoJr0hEbSWchM5H+Li1xZrtBB2Lj5K0xaz2y8tn2FKM3tkgHO3cDjltzG?=
 =?us-ascii?Q?z5Ymvi4A2fPa/YDNzkpnZb4mxxfRfU46esYcguPqB2eaT51s68k5WTYcx27F?=
 =?us-ascii?Q?SSZ3UvMq9Jsl+AeXRSoh0p4q6mpZB2B1PRcUjhcxixeRU8Dhzfnan11FR4R8?=
 =?us-ascii?Q?hbt9YzADozlIdRBFSmrtFTl1TCW95Oh/HPK+qgdIJJz7dhn6yCybv+iXY86U?=
 =?us-ascii?Q?++GuiGAc6Mn3YDDtIsn550J+LCy/8hBvvc/5w8MxIceKufkDeJ84NF8uM0Uq?=
 =?us-ascii?Q?5pRx6mxY/AUZPtSHDJRuM/Hhuw+go0+E7iaflS6AeNbqz+99pXijfr28l+GQ?=
 =?us-ascii?Q?UfJ/VGb6blDp4SeSWYtZK+r6xUqNcgF296musRuVk/oEKXk1FYT+JaZCRV26?=
 =?us-ascii?Q?lV7yW+StPD5kuoneC08ySqI1/HEWjnXTfu235czwnzMVmYsHPFZCHtOXyb21?=
 =?us-ascii?Q?6T7slPt1nrH2VPSmjTDlbx/ynYhif6wr3QFgfDYjGEoUI6i/18tntSdC8V63?=
 =?us-ascii?Q?m7wONSoO/nmutR5hTlxhNTNM41F/XtmhriAPgqwxmo7rdYVde9KnFZ/aITSM?=
 =?us-ascii?Q?ZnkssQOIScFFDstutzDn6ufBIF8FoxQ8G/VbcDhQKsPE6lkyPhxdCFxFYr7E?=
 =?us-ascii?Q?JjwP4/SAGtiFIcbBDP7JeS9k139ivqsqr59L7ixVqHRywg9HTVHWgI0zSMYV?=
 =?us-ascii?Q?hXc5W/lJKc3HESu20bqfB75Me6FPT5O69F5rvV/IGke2mpQBU8xcI5wTgiy5?=
 =?us-ascii?Q?Q/xgW6AujhtKa3MeP1gezqeL8ZR2FCp6iija?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(35042699022)(36860700013)(14060799003)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 13:09:27.6900
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9d5d84d-5bd0-4af1-48a5-08dd412f53a5
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A7.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9977

This patch allows Panthor to allocate buffer objects from a
protected heap. The Panthor driver should be seen as a consumer
of the heap and not an exporter.

To help with the review of this patch, here are important information
about the Mali GPU protected mode support:
- On CSF FW load, the Panthor driver must allocate a protected
  buffer object to hold data to use by the FW when in protected
  mode. This protected buffer object is owned by the device
  and does not belong to a process.
- On CSG creation, the Panthor driver must allocate a protected
  suspend buffer object for the FW to store data when suspending
  the CSG while in protected mode. The kernel owns this allocation
  and does not allow user space mapping. The format of the data
  in this buffer is only known by the FW and does not need to be
  shared with other entities.

To summarize, Mali GPUs require allocations of protected buffer
objects at the kernel level.

* How is the protected heap accessed by the Panthor driver?
The driver will retrieve the protected heap using the name of the
heap provided to the driver via the DTB as attribute.
If the heap is not yet available, the panthor driver will defer
the probe until created. It is an integration error to provide
a heap name that does not exist or is never created in the
DTB node.

* How is the Panthor driver allocating from the heap?
Panthor is calling the DMA heap allocation function
and obtains a DMA buffer from it. This buffer is then
registered to GEM via PRIME by importing the DMA buffer.

Signed-off-by: Florent Tomasin <florent.tomasin@arm.com>
---
 drivers/gpu/drm/panthor/Kconfig          |  1 +
 drivers/gpu/drm/panthor/panthor_device.c | 22 ++++++++++-
 drivers/gpu/drm/panthor/panthor_device.h |  7 ++++
 drivers/gpu/drm/panthor/panthor_fw.c     | 36 +++++++++++++++--
 drivers/gpu/drm/panthor/panthor_fw.h     |  2 +
 drivers/gpu/drm/panthor/panthor_gem.c    | 49 ++++++++++++++++++++++--
 drivers/gpu/drm/panthor/panthor_gem.h    | 16 +++++++-
 drivers/gpu/drm/panthor/panthor_heap.c   |  2 +
 drivers/gpu/drm/panthor/panthor_sched.c  |  5 ++-
 9 files changed, 130 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/panthor/Kconfig b/drivers/gpu/drm/panthor/Kconfig
index 55b40ad07f3b..c0208b886d9f 100644
--- a/drivers/gpu/drm/panthor/Kconfig
+++ b/drivers/gpu/drm/panthor/Kconfig
@@ -7,6 +7,7 @@ config DRM_PANTHOR
 	depends on !GENERIC_ATOMIC64  # for IOMMU_IO_PGTABLE_LPAE
 	depends on MMU
 	select DEVFREQ_GOV_SIMPLE_ONDEMAND
+	select DMABUF_HEAPS
 	select DRM_EXEC
 	select DRM_GEM_SHMEM_HELPER
 	select DRM_GPUVM
diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
index 00f7b8ce935a..1018e5c90a0e 100644
--- a/drivers/gpu/drm/panthor/panthor_device.c
+++ b/drivers/gpu/drm/panthor/panthor_device.c
@@ -4,7 +4,9 @@
 /* Copyright 2023 Collabora ltd. */
 
 #include <linux/clk.h>
+#include <linux/dma-heap.h>
 #include <linux/mm.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
@@ -102,6 +104,9 @@ void panthor_device_unplug(struct panthor_device *ptdev)
 	panthor_mmu_unplug(ptdev);
 	panthor_gpu_unplug(ptdev);
 
+	if (ptdev->protm.heap)
+		dma_heap_put(ptdev->protm.heap);
+
 	pm_runtime_dont_use_autosuspend(ptdev->base.dev);
 	pm_runtime_put_sync_suspend(ptdev->base.dev);
 
@@ -172,6 +177,7 @@ int panthor_device_init(struct panthor_device *ptdev)
 	u32 *dummy_page_virt;
 	struct resource *res;
 	struct page *p;
+	const char *protm_heap_name;
 	int ret;
 
 	ret = panthor_gpu_coherency_init(ptdev);
@@ -246,9 +252,19 @@ int panthor_device_init(struct panthor_device *ptdev)
 			return ret;
 	}
 
+	/* If a protected heap is specified but not found, defer the probe until created */
+	if (!of_property_read_string(ptdev->base.dev->of_node, "protected-heap-name",
+				     &protm_heap_name)) {
+		ptdev->protm.heap = dma_heap_find(protm_heap_name);
+		if (!ptdev->protm.heap) {
+			ret = -EPROBE_DEFER;
+			goto err_rpm_put;
+		}
+	}
+
 	ret = panthor_gpu_init(ptdev);
 	if (ret)
-		goto err_rpm_put;
+		goto err_dma_heap_put;
 
 	ret = panthor_mmu_init(ptdev);
 	if (ret)
@@ -286,6 +302,10 @@ int panthor_device_init(struct panthor_device *ptdev)
 err_unplug_gpu:
 	panthor_gpu_unplug(ptdev);
 
+err_dma_heap_put:
+	if (ptdev->protm.heap)
+		dma_heap_put(ptdev->protm.heap);
+
 err_rpm_put:
 	pm_runtime_put_sync_suspend(ptdev->base.dev);
 	return ret;
diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
index 0e68f5a70d20..406de9e888e2 100644
--- a/drivers/gpu/drm/panthor/panthor_device.h
+++ b/drivers/gpu/drm/panthor/panthor_device.h
@@ -7,6 +7,7 @@
 #define __PANTHOR_DEVICE_H__
 
 #include <linux/atomic.h>
+#include <linux/dma-heap.h>
 #include <linux/io-pgtable.h>
 #include <linux/regulator/consumer.h>
 #include <linux/sched.h>
@@ -190,6 +191,12 @@ struct panthor_device {
 
 	/** @fast_rate: Maximum device clock frequency. Set by DVFS */
 	unsigned long fast_rate;
+
+	/** @protm: Protected mode related data. */
+	struct {
+		/** @heap: Pointer to the protected heap */
+		struct dma_heap *heap;
+	} protm;
 };
 
 struct panthor_gpu_usage {
diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index 4a2e36504fea..7822af1533b4 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -458,6 +458,7 @@ panthor_fw_alloc_queue_iface_mem(struct panthor_device *ptdev,
 
 	mem = panthor_kernel_bo_create(ptdev, ptdev->fw->vm, SZ_8K,
 				       DRM_PANTHOR_BO_NO_MMAP,
+				       0,
 				       DRM_PANTHOR_VM_BIND_OP_MAP_NOEXEC |
 				       DRM_PANTHOR_VM_BIND_OP_MAP_UNCACHED,
 				       PANTHOR_VM_KERNEL_AUTO_VA);
@@ -491,6 +492,28 @@ panthor_fw_alloc_suspend_buf_mem(struct panthor_device *ptdev, size_t size)
 {
 	return panthor_kernel_bo_create(ptdev, panthor_fw_vm(ptdev), size,
 					DRM_PANTHOR_BO_NO_MMAP,
+					0,
+					DRM_PANTHOR_VM_BIND_OP_MAP_NOEXEC,
+					PANTHOR_VM_KERNEL_AUTO_VA);
+}
+
+/**
+ * panthor_fw_alloc_protm_suspend_buf_mem() - Allocate a protm suspend buffer
+ * for a command stream group.
+ * @ptdev: Device.
+ * @size: Size of the protm suspend buffer.
+ *
+ * Return: A valid pointer in case of success, NULL if no protected heap, an ERR_PTR() otherwise.
+ */
+struct panthor_kernel_bo *
+panthor_fw_alloc_protm_suspend_buf_mem(struct panthor_device *ptdev, size_t size)
+{
+	if (!ptdev->protm.heap)
+		return NULL;
+
+	return panthor_kernel_bo_create(ptdev, panthor_fw_vm(ptdev), size,
+					DRM_PANTHOR_BO_NO_MMAP,
+					DRM_PANTHOR_KBO_PROTECTED_HEAP,
 					DRM_PANTHOR_VM_BIND_OP_MAP_NOEXEC,
 					PANTHOR_VM_KERNEL_AUTO_VA);
 }
@@ -503,6 +526,7 @@ static int panthor_fw_load_section_entry(struct panthor_device *ptdev,
 	ssize_t vm_pgsz = panthor_vm_page_size(ptdev->fw->vm);
 	struct panthor_fw_binary_section_entry_hdr hdr;
 	struct panthor_fw_section *section;
+	bool is_protm_section = false;
 	u32 section_size;
 	u32 name_len;
 	int ret;
@@ -541,10 +565,13 @@ static int panthor_fw_load_section_entry(struct panthor_device *ptdev,
 		return -EINVAL;
 	}
 
-	if (hdr.flags & CSF_FW_BINARY_IFACE_ENTRY_PROT) {
+	if ((hdr.flags & CSF_FW_BINARY_IFACE_ENTRY_PROT) && !ptdev->protm.heap) {
 		drm_warn(&ptdev->base,
 			 "Firmware protected mode entry not be supported, ignoring");
 		return 0;
+	} else if ((hdr.flags & CSF_FW_BINARY_IFACE_ENTRY_PROT) && ptdev->protm.heap) {
+		drm_info(&ptdev->base, "Firmware protected mode entry supported");
+		is_protm_section = true;
 	}
 
 	if (hdr.va.start == CSF_MCU_SHARED_REGION_START &&
@@ -610,9 +637,10 @@ static int panthor_fw_load_section_entry(struct panthor_device *ptdev,
 			vm_map_flags |= DRM_PANTHOR_VM_BIND_OP_MAP_UNCACHED;
 
 		section->mem = panthor_kernel_bo_create(ptdev, panthor_fw_vm(ptdev),
-							section_size,
-							DRM_PANTHOR_BO_NO_MMAP,
-							vm_map_flags, va);
+					section_size,
+					DRM_PANTHOR_BO_NO_MMAP,
+					(is_protm_section ? DRM_PANTHOR_KBO_PROTECTED_HEAP : 0),
+					vm_map_flags, va);
 		if (IS_ERR(section->mem))
 			return PTR_ERR(section->mem);
 
diff --git a/drivers/gpu/drm/panthor/panthor_fw.h b/drivers/gpu/drm/panthor/panthor_fw.h
index 22448abde992..29042d0dc60c 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.h
+++ b/drivers/gpu/drm/panthor/panthor_fw.h
@@ -481,6 +481,8 @@ panthor_fw_alloc_queue_iface_mem(struct panthor_device *ptdev,
 				 u32 *input_fw_va, u32 *output_fw_va);
 struct panthor_kernel_bo *
 panthor_fw_alloc_suspend_buf_mem(struct panthor_device *ptdev, size_t size);
+struct panthor_kernel_bo *
+panthor_fw_alloc_protm_suspend_buf_mem(struct panthor_device *ptdev, size_t size);
 
 struct panthor_vm *panthor_fw_vm(struct panthor_device *ptdev);
 
diff --git a/drivers/gpu/drm/panthor/panthor_gem.c b/drivers/gpu/drm/panthor/panthor_gem.c
index 8244a4e6c2a2..88caf928acd0 100644
--- a/drivers/gpu/drm/panthor/panthor_gem.c
+++ b/drivers/gpu/drm/panthor/panthor_gem.c
@@ -9,10 +9,14 @@
 
 #include <drm/panthor_drm.h>
 
+#include <uapi/linux/dma-heap.h>
+
 #include "panthor_device.h"
 #include "panthor_gem.h"
 #include "panthor_mmu.h"
 
+MODULE_IMPORT_NS(DMA_BUF);
+
 static void panthor_gem_free_object(struct drm_gem_object *obj)
 {
 	struct panthor_gem_object *bo = to_panthor_bo(obj);
@@ -31,6 +35,7 @@ static void panthor_gem_free_object(struct drm_gem_object *obj)
  */
 void panthor_kernel_bo_destroy(struct panthor_kernel_bo *bo)
 {
+	struct dma_buf *dma_bo = NULL;
 	struct panthor_vm *vm;
 	int ret;
 
@@ -38,6 +43,10 @@ void panthor_kernel_bo_destroy(struct panthor_kernel_bo *bo)
 		return;
 
 	vm = bo->vm;
+
+	if (bo->flags & DRM_PANTHOR_KBO_PROTECTED_HEAP)
+		dma_bo = bo->obj->import_attach->dmabuf;
+
 	panthor_kernel_bo_vunmap(bo);
 
 	if (drm_WARN_ON(bo->obj->dev,
@@ -51,6 +60,9 @@ void panthor_kernel_bo_destroy(struct panthor_kernel_bo *bo)
 	panthor_vm_free_va(vm, &bo->va_node);
 	drm_gem_object_put(bo->obj);
 
+	if (dma_bo)
+		dma_buf_put(dma_bo);
+
 out_free_bo:
 	panthor_vm_put(vm);
 	kfree(bo);
@@ -62,6 +74,7 @@ void panthor_kernel_bo_destroy(struct panthor_kernel_bo *bo)
  * @vm: VM to map the GEM to. If NULL, the kernel object is not GPU mapped.
  * @size: Size of the buffer object.
  * @bo_flags: Combination of drm_panthor_bo_flags flags.
+ * @kbo_flags: Combination of drm_panthor_kbo_flags flags.
  * @vm_map_flags: Combination of drm_panthor_vm_bind_op_flags (only those
  * that are related to map operations).
  * @gpu_va: GPU address assigned when mapping to the VM.
@@ -72,9 +85,11 @@ void panthor_kernel_bo_destroy(struct panthor_kernel_bo *bo)
  */
 struct panthor_kernel_bo *
 panthor_kernel_bo_create(struct panthor_device *ptdev, struct panthor_vm *vm,
-			 size_t size, u32 bo_flags, u32 vm_map_flags,
+			 size_t size, u32 bo_flags, u32 kbo_flags, u32 vm_map_flags,
 			 u64 gpu_va)
 {
+	struct dma_buf *dma_bo = NULL;
+	struct drm_gem_object *gem_obj = NULL;
 	struct drm_gem_shmem_object *obj;
 	struct panthor_kernel_bo *kbo;
 	struct panthor_gem_object *bo;
@@ -87,14 +102,38 @@ panthor_kernel_bo_create(struct panthor_device *ptdev, struct panthor_vm *vm,
 	if (!kbo)
 		return ERR_PTR(-ENOMEM);
 
-	obj = drm_gem_shmem_create(&ptdev->base, size);
+	if (kbo_flags & DRM_PANTHOR_KBO_PROTECTED_HEAP) {
+		if (!ptdev->protm.heap) {
+			ret = -EINVAL;
+			goto err_free_bo;
+		}
+
+		dma_bo = dma_heap_buffer_alloc(ptdev->protm.heap, size,
+					       DMA_HEAP_VALID_FD_FLAGS, DMA_HEAP_VALID_HEAP_FLAGS);
+		if (!dma_bo) {
+			ret = -ENOMEM;
+			goto err_free_bo;
+		}
+
+		gem_obj = drm_gem_prime_import(&ptdev->base, dma_bo);
+		if (IS_ERR(gem_obj)) {
+			ret = PTR_ERR(gem_obj);
+			goto err_free_dma_bo;
+		}
+
+		obj = to_drm_gem_shmem_obj(gem_obj);
+	} else {
+		obj = drm_gem_shmem_create(&ptdev->base, size);
+	}
+
 	if (IS_ERR(obj)) {
 		ret = PTR_ERR(obj);
-		goto err_free_bo;
+		goto err_free_dma_bo;
 	}
 
 	bo = to_panthor_bo(&obj->base);
 	kbo->obj = &obj->base;
+	kbo->flags = kbo_flags;
 	bo->flags = bo_flags;
 
 	/* The system and GPU MMU page size might differ, which becomes a
@@ -124,6 +163,10 @@ panthor_kernel_bo_create(struct panthor_device *ptdev, struct panthor_vm *vm,
 err_put_obj:
 	drm_gem_object_put(&obj->base);
 
+err_free_dma_bo:
+	if (dma_bo)
+		dma_buf_put(dma_bo);
+
 err_free_bo:
 	kfree(kbo);
 	return ERR_PTR(ret);
diff --git a/drivers/gpu/drm/panthor/panthor_gem.h b/drivers/gpu/drm/panthor/panthor_gem.h
index e43021cf6d45..d4fe8ae9f0a8 100644
--- a/drivers/gpu/drm/panthor/panthor_gem.h
+++ b/drivers/gpu/drm/panthor/panthor_gem.h
@@ -13,6 +13,17 @@
 
 struct panthor_vm;
 
+/**
+ * enum drm_panthor_kbo_flags -  Kernel buffer object flags, passed at creation time
+ */
+enum drm_panthor_kbo_flags {
+	/**
+	 * @DRM_PANTHOR_KBO_PROTECTED_HEAP: The buffer object will be allocated
+	 * from a DMA-Buf protected heap.
+	 */
+	DRM_PANTHOR_KBO_PROTECTED_HEAP = (1 << 0),
+};
+
 /**
  * struct panthor_gem_object - Driver specific GEM object.
  */
@@ -75,6 +86,9 @@ struct panthor_kernel_bo {
 	 * @kmap: Kernel CPU mapping of @gem.
 	 */
 	void *kmap;
+
+	/** @flags: Combination of drm_panthor_kbo_flags flags. */
+	u32 flags;
 };
 
 static inline
@@ -138,7 +152,7 @@ panthor_kernel_bo_vunmap(struct panthor_kernel_bo *bo)
 
 struct panthor_kernel_bo *
 panthor_kernel_bo_create(struct panthor_device *ptdev, struct panthor_vm *vm,
-			 size_t size, u32 bo_flags, u32 vm_map_flags,
+			 size_t size, u32 bo_flags, u32 kbo_flags, u32 vm_map_flags,
 			 u64 gpu_va);
 
 void panthor_kernel_bo_destroy(struct panthor_kernel_bo *bo);
diff --git a/drivers/gpu/drm/panthor/panthor_heap.c b/drivers/gpu/drm/panthor/panthor_heap.c
index 3796a9eb22af..5395f0d90360 100644
--- a/drivers/gpu/drm/panthor/panthor_heap.c
+++ b/drivers/gpu/drm/panthor/panthor_heap.c
@@ -146,6 +146,7 @@ static int panthor_alloc_heap_chunk(struct panthor_device *ptdev,
 
 	chunk->bo = panthor_kernel_bo_create(ptdev, vm, heap->chunk_size,
 					     DRM_PANTHOR_BO_NO_MMAP,
+					     0,
 					     DRM_PANTHOR_VM_BIND_OP_MAP_NOEXEC,
 					     PANTHOR_VM_KERNEL_AUTO_VA);
 	if (IS_ERR(chunk->bo)) {
@@ -549,6 +550,7 @@ panthor_heap_pool_create(struct panthor_device *ptdev, struct panthor_vm *vm)
 
 	pool->gpu_contexts = panthor_kernel_bo_create(ptdev, vm, bosize,
 						      DRM_PANTHOR_BO_NO_MMAP,
+						      0,
 						      DRM_PANTHOR_VM_BIND_OP_MAP_NOEXEC,
 						      PANTHOR_VM_KERNEL_AUTO_VA);
 	if (IS_ERR(pool->gpu_contexts)) {
diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index ef4bec7ff9c7..e260ed8aef5b 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -3298,6 +3298,7 @@ group_create_queue(struct panthor_group *group,
 	queue->ringbuf = panthor_kernel_bo_create(group->ptdev, group->vm,
 						  args->ringbuf_size,
 						  DRM_PANTHOR_BO_NO_MMAP,
+						  0,
 						  DRM_PANTHOR_VM_BIND_OP_MAP_NOEXEC |
 						  DRM_PANTHOR_VM_BIND_OP_MAP_UNCACHED,
 						  PANTHOR_VM_KERNEL_AUTO_VA);
@@ -3328,6 +3329,7 @@ group_create_queue(struct panthor_group *group,
 					 queue->profiling.slot_count *
 					 sizeof(struct panthor_job_profiling_data),
 					 DRM_PANTHOR_BO_NO_MMAP,
+					 0,
 					 DRM_PANTHOR_VM_BIND_OP_MAP_NOEXEC |
 					 DRM_PANTHOR_VM_BIND_OP_MAP_UNCACHED,
 					 PANTHOR_VM_KERNEL_AUTO_VA);
@@ -3435,7 +3437,7 @@ int panthor_group_create(struct panthor_file *pfile,
 	}
 
 	suspend_size = csg_iface->control->protm_suspend_size;
-	group->protm_suspend_buf = panthor_fw_alloc_suspend_buf_mem(ptdev, suspend_size);
+	group->protm_suspend_buf = panthor_fw_alloc_protm_suspend_buf_mem(ptdev, suspend_size);
 	if (IS_ERR(group->protm_suspend_buf)) {
 		ret = PTR_ERR(group->protm_suspend_buf);
 		group->protm_suspend_buf = NULL;
@@ -3446,6 +3448,7 @@ int panthor_group_create(struct panthor_file *pfile,
 						   group_args->queues.count *
 						   sizeof(struct panthor_syncobj_64b),
 						   DRM_PANTHOR_BO_NO_MMAP,
+						   0,
 						   DRM_PANTHOR_VM_BIND_OP_MAP_NOEXEC |
 						   DRM_PANTHOR_VM_BIND_OP_MAP_UNCACHED,
 						   PANTHOR_VM_KERNEL_AUTO_VA);
-- 
2.34.1


