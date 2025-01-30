Return-Path: <dmaengine+bounces-4227-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 887EBA22D4D
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jan 2025 14:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8898418859F3
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jan 2025 13:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A8C1E493C;
	Thu, 30 Jan 2025 13:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="dmC+bpbq";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="dmC+bpbq"
X-Original-To: dmaengine@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013071.outbound.protection.outlook.com [52.101.67.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05C01DDC22;
	Thu, 30 Jan 2025 13:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.71
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738242578; cv=fail; b=W+AfwJjQm4nKG1C4BM+X6PbDpKb4R+lnVEhIplm26Ixl1d8NGIFDfrHkmBp2Bo+tGeYyyPVgiGdgVTmxYBvij4VrU8qXvvDwnCBno/uWPKXgKmmUQblTSB0SAWbA8lLOxjdZJ2cw0F26PYAK3x3kq3nq3xAzsx1KfWiioF0DJOg=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738242578; c=relaxed/simple;
	bh=jnnSPvYuLDJkBZ2OYaWAtkzl0NE6YgWQXJBFVsq3GmI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JuX/MqopRcqjRQN96ct4/rRo8S3LIuDJImXnE/bXQHycil7Rjhkb/sgMquZwR+NJjAIs/I8S0aPavM95YnzkRelDFAZHHM13dw3NcwCpOlrqJF62UnbKxjFYBinnmKdBZwNS/omafVrwk3P+6M5pTuGIEUUcGsUovar4vtL3pzs=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=dmC+bpbq; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=dmC+bpbq; arc=fail smtp.client-ip=52.101.67.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=AGgKXpZqch+OyNIf5BUZEzEwSN4tEeiOjhkSj/GxaNFF8ADaI/EfHHEPNenQ58FssqX3iekuOytXU+gwb3O1dAXhesaVMw3NOTFSXw5BwdHpzdx/gif5xgvJD5aCzUtlyhrtSvMvCCrfz2a9ICaY23FcrjxAIt+th09d9BG2MXzOoGkoS8Lj9MLmtK07X/Vu22uei04AZtQsxQ480ihY0UxzBN9kDRANvYMpvoOMe7diygbdoe9HrZWPdLRuhsp1/feeKQ7vrxN4PDJ98H34K4S8lH7opoEwzXvtOpObjWSFVvUAbjDKRL0ZQU9sAjs5jwGRt1fr0r4oPmXmhhWnOw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FgaCamHnxvPMXaZFSAc1/BOzJH3l89NFFvdMd2pfmO8=;
 b=n/zJXn+yX0zRV7t5hKSJbeLgDSoRJzGSSzc45UELjvw4t9mVv+5T+itpMJTGG1fGKmOMwf1d9U31nK7as5DFiLwvPqK7H8r8M6pe67rVLiq2eFK0m0KrtJEwYg7Tg+DSL4/c2oK1NfiUW52P5170Lba1SWuCrzCJQYqjpKzh3kkdplRkydTpGsEzdFP+A2T+osLfNCL9P0nkL+Y9xnKLZWHH3EtW+0xcWbwbNIhe9YA5ZCA0Oh3Q4R0SU2gaeT3QdyRM2vYcgOwLwSwUYfIDecq21vXR3t6r9R6hEmBua31saTQdG/h2KmYKdbQW1X2JA1okwyv4O5Jvia5tHFsrww==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=0
 ltdi=1)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FgaCamHnxvPMXaZFSAc1/BOzJH3l89NFFvdMd2pfmO8=;
 b=dmC+bpbqsqNQNwGSG8FQ0oaJwBR6z8iZ6lnDuLWWxDwOequSaClXVdbfZXxqBNJNMbXXaSr4R+Te8pFJ8HeXIrQjQBeLnwXybISI5+3hG3mmisqfJ24OOm3YmKQIMPy1HA/95d9nxKuq6jwpQ/GuyV9/VLObdcpxNl3lPrbIl5g=
Received: from AS4P190CA0011.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5de::13)
 by AS2PR08MB8901.eurprd08.prod.outlook.com (2603:10a6:20b:5f0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Thu, 30 Jan
 2025 13:09:33 +0000
Received: from AMS0EPF000001A2.eurprd05.prod.outlook.com
 (2603:10a6:20b:5de:cafe::b4) by AS4P190CA0011.outlook.office365.com
 (2603:10a6:20b:5de::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.20 via Frontend Transport; Thu,
 30 Jan 2025 13:09:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AMS0EPF000001A2.mail.protection.outlook.com (10.167.16.235) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.14
 via Frontend Transport; Thu, 30 Jan 2025 13:09:32 +0000
Received: ("Tessian outbound 671aa0ad34c4:v560"); Thu, 30 Jan 2025 13:09:31 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 3b96bd91acacdd57
X-TessianGatewayMetadata: qoVaNJHo09g7Nr7WiHlnEBFdWsRJB86Jj/NwpEIIV1Qq88fWkjIEUWHk+pCw1TL7pUy+TLEebcJOBSpZN7EgS0ol5XZzuTyDaNnuFpQ6xF40pIoQcfXKCTIdNoBADG1ONgGHHMq20bCs8l4tVPN+DvhO2Hy6iQETymIfAALxHbX4frIPiHLUbNYM2hvY+X5J7eSYGku2M8AuZnlReqTqeA==
X-CR-MTA-TID: 64aa7808
Received: from Le713702a97a6.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 53CAB092-6D8F-46A4-93F9-AB52E14BE0B5.1;
	Thu, 30 Jan 2025 13:09:23 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Le713702a97a6.1
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Thu, 30 Jan 2025 13:09:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NcYGZlKtG/CiW2quSQm53ORx3ZwKWmz5l/J/qsZAdT96OM/1Cly36e1DrVpOrHtRpTcYGc31DLUsuzkpONfyiNpH1ovmGek3BntuXp9NO0VCHvsZRhlUsc4fFnWVdocmEfgHrZFPiUVlzuSUPK+kHQ56Q07ep5u3MLhh/gFBsr0OYm5e8CTYQzeGF7iGGR/z6qZ8e2Uwlco6JGtYOs4pUosIWk1q5vC+7H+iK/C5X61rXyWMJ6km5pFa302DMUgp/3Z5POXykrXWd1efcAC97BKjLNORXuYUJy8VW6kC1+LZGe3Pb+wnZe/k5Nby3KBMO2yF34SxzGuNHn7bOInd1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FgaCamHnxvPMXaZFSAc1/BOzJH3l89NFFvdMd2pfmO8=;
 b=D0WhO/Q/XdUsh8ikXb/MvammaXbC/hohJqZdJ60/yhGBjTGaD++zetwSHqRXRDiGA0VQctwhvbGWtI48aLGOLsAPryXS882x83K1X1gBhg6fTZkc9TJV5Weg2bfbGsHHeX3YW4CQXjHxLJjxHkuhw+Uv8ciKEWtCS8ywMewO7jDIhYaR0unFnEW8i3wXzwd61TaxbcKe533CHAsWxRZ86EFefDw2y/8QvSP9JgHYs3THlAPAevqmwfVvw0CkmsHq5FmUEnKIyEs7CR1vqILbiUSz0dcDCwJZpJ5BUrRfqZXfxcdxzY/m9uVg6ToUvb7sM4poFbFX5pBZT8DoSjjROg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 172.205.89.229) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FgaCamHnxvPMXaZFSAc1/BOzJH3l89NFFvdMd2pfmO8=;
 b=dmC+bpbqsqNQNwGSG8FQ0oaJwBR6z8iZ6lnDuLWWxDwOequSaClXVdbfZXxqBNJNMbXXaSr4R+Te8pFJ8HeXIrQjQBeLnwXybISI5+3hG3mmisqfJ24OOm3YmKQIMPy1HA/95d9nxKuq6jwpQ/GuyV9/VLObdcpxNl3lPrbIl5g=
Received: from DU7P194CA0027.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:553::7) by
 GV2PR08MB9374.eurprd08.prod.outlook.com (2603:10a6:150:d0::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.20; Thu, 30 Jan 2025 13:09:13 +0000
Received: from DU6PEPF00009525.eurprd02.prod.outlook.com
 (2603:10a6:10:553:cafe::e2) by DU7P194CA0027.outlook.office365.com
 (2603:10a6:10:553::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.18 via Frontend Transport; Thu,
 30 Jan 2025 13:09:13 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 172.205.89.229)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 172.205.89.229 as permitted sender)
 receiver=protection.outlook.com; client-ip=172.205.89.229;
 helo=nebula.arm.com;
Received: from nebula.arm.com (172.205.89.229) by
 DU6PEPF00009525.mail.protection.outlook.com (10.167.8.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Thu, 30 Jan 2025 13:09:13 +0000
Received: from AZ-NEU-EX06.Arm.com (10.240.25.134) by AZ-NEU-EX06.Arm.com
 (10.240.25.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 30 Jan
 2025 13:09:06 +0000
Received: from e121164.cambridge.arm.com (10.2.10.32) by mail.arm.com
 (10.240.25.134) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 30 Jan 2025 13:09:05 +0000
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
Subject: [RFC PATCH 1/5] dt-bindings: dma: Add CMA Heap bindings
Date: Thu, 30 Jan 2025 13:08:57 +0000
Message-ID: <771534be8dfa2a3bdc3876502752f518224b9298.1738228114.git.florent.tomasin@arm.com>
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
	DU6PEPF00009525:EE_|GV2PR08MB9374:EE_|AMS0EPF000001A2:EE_|AS2PR08MB8901:EE_
X-MS-Office365-Filtering-Correlation-Id: 2636919b-0d11-4a92-6872-08dd412f568e
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?kp7y9OlcNnlxCGnxZwdQsMAB37oeT5uUdoygQ5PD3ph0+XkNzmSYUKIvo1Rw?=
 =?us-ascii?Q?vj7CuGFQF9RsvFkRJvRVhl6moydjlfwp+6lTi8xaBVFPL/fnvV7BC9Lb8HBe?=
 =?us-ascii?Q?bBabXoZ0XKkW705JdLXytHzZCA9bEUA5qAQ9PlJnc2374P8Q5Ovivfu2O5fQ?=
 =?us-ascii?Q?iUUTo3NKkaWAD0B5oT2PDbBGvlu0W1chD+9nmd5umC0fd/yh5eAZc8RacAne?=
 =?us-ascii?Q?05jvopguUjipA5u1HlJSytE0VQCkyqHk6NnUbiU+pRismDuh7Z+JNo/04G6U?=
 =?us-ascii?Q?iP1Dt11x2g9M/w6MHJKQD1+Pfq2J5Nh+ywbrrKh5ONG2TwAny1kM3vbEwcJn?=
 =?us-ascii?Q?CYdwKGte2csmQThyJlmfDF0ktDhDs6TlaZaj2i+7O87IM3HodFzf3BdfFvsR?=
 =?us-ascii?Q?gsFfzvio/OfYQdIYmqb13ZYIKzXcD0DTKF8Mt5zGZNkJA/fZTX2eXH2JxzRi?=
 =?us-ascii?Q?pdz+JmF5yN8gKnphfzNHky2jUW64ydHf9NRFc/YhnNwTA7aTjTjnAf2WCi2C?=
 =?us-ascii?Q?F+FD/8OeLVZomq9s65jFPpUrpqELjJAoQezS8y+TKKzual1ZcQwKOMr5WESC?=
 =?us-ascii?Q?vtzehZQbj4Bd1t0H2DnGP+xGke3ft6WKTSPadthR2PKcXa983DtMN6sHGiAI?=
 =?us-ascii?Q?qC/PT3E3gYnry8gJ39Y6eUzO3T+9UoLf7hJuegXMaljtSJgrBU/zcc2lN/XI?=
 =?us-ascii?Q?JDTzSOGrRrtvNflqmYHD8q+9oNG5f6QOZ9fLW2fFHGQGJ1kQPyTdUHRzn7Di?=
 =?us-ascii?Q?9rWukmDYF2iKBX4BmgZENboTuTFxRZCkmAuVHuwXWp9U32cKBMmeqQZAXd0S?=
 =?us-ascii?Q?XNVms56q5/Rv9u92OJne8U7vEb8izzeA60A1jXCNGk+wAXdeQAx7CAMf8F0T?=
 =?us-ascii?Q?/c3z7X88mzK5NzxeDQqJXKtkLXAfCjhYjLK3TyAeVmAvu5l5iw8Ldyifs8n7?=
 =?us-ascii?Q?PQRzEf/36FkM2wYq0OJsuV4w5Vv3Fkj5uvY3XjBqo+dyokTHl2q6/b+Mm45W?=
 =?us-ascii?Q?477f5qiPIau56UvBAnVPGXQpDeUsM2q/PLTc+UTVCauz9UjEibTW/9Yj62Rz?=
 =?us-ascii?Q?UmiEw6fhkhKGprpFjx0CsXrB26CO4TYkIoyN3rEn6G+Jv4UfTpcTHZGe7ZRy?=
 =?us-ascii?Q?Y2lf6RMYMFC/AvFW+go0r5ezEjsKEDRJtIhiZfjFE0KfiU7y3Ur0ixgKF2Oj?=
 =?us-ascii?Q?XULmlEhPU0i1o0EIJ6Dm0bVHjZuWRoLCayxCdf5ZvxvnH04HydeTtXbphzH1?=
 =?us-ascii?Q?LJ4ZOabhm2et0uAEkZnTFwHPLBnuLKIKtiQl8HtDs1hj0CEt6VVYjJzgGGww?=
 =?us-ascii?Q?YdhdjS645rlwhKFsE4izav4zGBX0r+FP0D2Jgmz/rYs9VXJJjsPN27pfDw5z?=
 =?us-ascii?Q?/cwf6YAVHmL7lN9qzjqB9fhp5CegXNaskjko6SHoQV2av1nJFeMbqsZ0r3R4?=
 =?us-ascii?Q?GgTu3XoYa5ktMxeN6jl3m6tJ7yu0gfP9?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:172.205.89.229;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB9374
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:10:553::7];domain=DU7P194CA0027.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001A2.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	250177de-9e0c-40fa-488a-08dd412f4ac8
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|14060799003|36860700013|35042699022|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jjx/ASw2gAl97Mx5BHsOgtEbrKUWHzUSC3kWsIcjkLiUHOQrrwSHwEesbmEG?=
 =?us-ascii?Q?hmr8FGtOvwYxxakj0TFiAt1Fhm1qGhNhX0NbyA7xqxFbBVPO+GibvVCHFQko?=
 =?us-ascii?Q?6lVuV09YTOSX6cKXuCob7CI03Icu/wBegtIFQa0bwrTF86YhchMAU3/jAMJo?=
 =?us-ascii?Q?YCxt4VpJkft8qXQ+EZNYqm7Slp7S5m8DQgDcvVezHlYRdx5z/aZcEAjSSDvL?=
 =?us-ascii?Q?/7c3DS9OaucEYqZQOsTRIptaEr0SS4jhgb/p12Cs8d++w3XH5In8DYyIVOmO?=
 =?us-ascii?Q?sRt6ENojY3ygekGWJLc3tRvbJohq6TjMsGRFa6g7EoYg7vNEHW0zBhySsw+N?=
 =?us-ascii?Q?0NjMi1SXKI+25niUv2xF/PEqKiyMuqryLzDAOj9DjiCQGNNPIJREc3qkmGto?=
 =?us-ascii?Q?MRA7T1Drca4T1YXHj1gWoCqdfbE3P0Sq7YUEyDlFpvtJ8QquzlB2U652pqph?=
 =?us-ascii?Q?WLQ58Z/UqgtmaYKPQrzQpsgh4SX2Le4PoSg3AVAuf5MzyQONnooifdYC4kkb?=
 =?us-ascii?Q?JEHYQG0kjlgmb2d4GNk+JHe7kRcl3G6VXgtdfj4dvXAOm4s7a4G+uU3xki/o?=
 =?us-ascii?Q?dWgG6KHzrWmQyFKq1ZReDR8ezZNWaFzM+/I1qDBntS17t9ZB/D2xNIaVy3S/?=
 =?us-ascii?Q?uYz87HGEGrBi7Hr7TrjNfZnLfOB0lWfoPzIjq/M8jjaoGyyS4EdNNyx7PLgI?=
 =?us-ascii?Q?PZ8tuaPEjH5/bSFsIk9lMkuIZm+qUZSQgzvE5/UOT4nCwO/H3SLgbXNX6nnN?=
 =?us-ascii?Q?nbzGnVkrYwNB/qG6p7IaTxtpop2AtHVS2qFhXfDvjVz1Gntzp+whWrYNZbSc?=
 =?us-ascii?Q?qD28SU/hCQHtnOu21/7wTnj/jxUHKo23LMDo0JzoeajYKm8nwUrDmVoRKv1X?=
 =?us-ascii?Q?lyyqBMkcsBm/jlkjAiacqPAscIYnbA6HV3psO0Dl/zJsmfRKKZrxXchSQ4gV?=
 =?us-ascii?Q?LNprtO/n9ep0/DZm7xi7qP1cV7aEg+67XjsIYJ02FEwztMa+j5BENIzKqhTW?=
 =?us-ascii?Q?LZBKCZCQ9a0ZXanpjCQr1FFrCJ5136y3S89oCU7vO7tD69ZhAxhoXu34Bkt6?=
 =?us-ascii?Q?omUhz+qA7eTPCYrn0vNLIKqYvsB3QTIk+VGIRlVJzOgpStBzR/WzdiK9dV5F?=
 =?us-ascii?Q?xx3oGUdxwdX1B+OrE43lj09BupBxGHJ4E0OBSRc6/h97ZRiYdYkTkuSLC1sM?=
 =?us-ascii?Q?MJwYdLTa75oLbOZa5XXN0Chdnqaupe8B5bZ+yiqVF7XHpTi3FIQAkfM+KLxH?=
 =?us-ascii?Q?uYn/NtHiFxwf0pCFTOOBkW9cn6d1qeFXOPlRg7nqfZL0eIRUZyG5JHPezqGC?=
 =?us-ascii?Q?dD23ZoFxNMNMKhvTUytAG+hEg/vAWYQv6qUS7xJlaF4XEVfDMKZik3eMf03G?=
 =?us-ascii?Q?yxkw078DE7MrBAu8zCDPNcN/Pp6orJxNWafFqNU87E3N7jLeC5H6O5oEPCdq?=
 =?us-ascii?Q?f4U3sBhbId2+9a69G4Bk0n2DW0ccn4B2?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(14060799003)(36860700013)(35042699022)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 13:09:32.4795
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2636919b-0d11-4a92-6872-08dd412f568e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A2.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8901

Introduce a CMA Heap dt-binding allowing custom
CMA heap registrations.

* Note to the reviewers:
The patch was used for the development of the protected mode
feature in Panthor CSF kernel driver and is not initially thought
to land in the Linux kernel. It is mostly relevant if someone
wants to reproduce the environment of testing. Please, raise
interest if you think the patch has value in the Linux kernel.

Signed-off-by: Florent Tomasin <florent.tomasin@arm.com>
---
 .../devicetree/bindings/dma/linux,cma.yml     | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/linux,cma.yml

diff --git a/Documentation/devicetree/bindings/dma/linux,cma.yml b/Documentation/devicetree/bindings/dma/linux,cma.yml
new file mode 100644
index 000000000000..c532e016bbe5
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/linux,cma.yml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/linux-cma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Custom Linux CMA heap
+
+description:
+  The custom Linux CMA heap device tree node allows registering
+  of multiple CMA heaps.
+
+  The CMA heap name will match the node name of the "memory-region".
+
+properties:
+  compatible:
+    enum:
+      - linux,cma
+
+  memory-region:
+    maxItems: 1
+    description: |
+      Phandle to the reserved memory node associated with the CMA Heap.
+      The reserved memory node must follow this binding convention:
+       - Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
+
+examples:
+  - |
+    reserved-memory {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      custom_cma_heap: custom-cma-heap {
+        compatible = "shared-dma-pool";
+        reg = <0x0 0x90600000 0x0 0x1000000>;
+        reusable;
+      };
+    };
+
+    device_cma_heap: device-cma-heap {
+      compatible = "linux,cma";
+      memory-region = <&custom_cma_heap>;
+    };
-- 
2.34.1


