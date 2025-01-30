Return-Path: <dmaengine+bounces-4229-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E48A22D58
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jan 2025 14:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86F403A75E3
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jan 2025 13:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56B41E98ED;
	Thu, 30 Jan 2025 13:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="MQdsK9pH";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="MQdsK9pH"
X-Original-To: dmaengine@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012013.outbound.protection.outlook.com [52.101.66.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01AF1E5018;
	Thu, 30 Jan 2025 13:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.13
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738242581; cv=fail; b=ftgLbQnprw0C3bFKL60mHrkbHF8Ik1V1bfo0TpSaKv+kL2ZPPXLA+RCZqqUdQM7ftR4qilzNo4dpgFlOLFZ8nPFFtKlXaLfU4s4keGIBG++XPeiJ0GeF6Pex5j02BLexGdkD55dKeJb901TjS6aErZRkRhc9wD66mnL3Lo//CjA=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738242581; c=relaxed/simple;
	bh=cPIKAv220aCivslzvlmuBd78cjQpwXaZpzqzGkUGq8Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eNtYPLx8UECgcTPagK+N2YL1hZ/Bpigrpj05E0SCDP8YrCYTx4aFuJdiq7iPHZD/c+DBeBSzkS/XbUT7HI3ZO8QAz3ogQGcZd/S+HRf/8mezowCUm3FX3CZu2kuZi44MjaEdDRXKtDhCN1ftyDgUwo6rhrQoE3XHCaMMCQBYCLA=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=MQdsK9pH; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=MQdsK9pH; arc=fail smtp.client-ip=52.101.66.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=oOJA+ffvyW2VMPYq2U00fwD686+3MZu8DNpUO/WvE/E/VKg5uLxqO5guhvG+wsNbn7gQ5AG2VgEmEFbsqA712laHBOmrPV/7wGhWGp6OWTgqJbzqkR/LnLjP5s7T4ptaLPI99FSS+7bTFf/1i3eY68BbOX2kjVSZmRXtbsdaWqxdup8ZUVWRwWmlJZlErrgPYkJbcbp948jfDxWss0hA0gMrQDoFV9b1w2Hc/wYqk7IO5hcAjw9P4IpyaDJD81vbcogFMrgPAWt8OUldseks1B/V46P05g+ROFmm0tHs1GBRauMgsw56LuvgAHXDzcXO/DeaXR4+6O0I1rID9ODKvg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YItMqBB3AFZY9z+AAWQmS9LrlWXXDu8EElut2eZSjfM=;
 b=VBRuTCEO9qkCAZEBtUy+QVeu2YPxhxA7U65spsCVfGOELLlUb0Jawa8EDmn50/iKAr6ht4Oad23sS/gbJzbGShifpt1LafP6oErS6mDA19SSVarbCIR0M15r3TNsrnREK+6vtL/l88nqjnU5haktFDc7+sqZ++OjIoSOccefsMmMm9MlHwVqk3W1eBXVwzbU6fhNfl+14xENwMuZdScwLpAuqGi8X+KZaSIxg6SBmZnzBGsGGf0bnIhQj13NkCbY1umu5+jxoj03cRL978K4vfdivJbaxv1/opHai1NxU4Ozvqc5Sgn/1rf3woPlHiAetHdyBawpQbAun+Z0TV/5tw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=0
 ltdi=1)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YItMqBB3AFZY9z+AAWQmS9LrlWXXDu8EElut2eZSjfM=;
 b=MQdsK9pH9F24jJwyVELdeH1JPCo5xohATn6LEhLoRMkS+/01lVOWYnRT4fjlfq+Lbp3+F8YK6QNnYm2gZoQAXoDDYACFtsWQVtmck993hAtZo/5d6yqm1Lp3pSiqN3Gn3Np0rRbjsT2UYx30qWRXSx4D61BA350gMM1eBIDRuTg=
Received: from PR1P264CA0094.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:345::19)
 by DU5PR08MB10440.eurprd08.prod.outlook.com (2603:10a6:10:517::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Thu, 30 Jan
 2025 13:09:29 +0000
Received: from AM4PEPF00027A6B.eurprd04.prod.outlook.com
 (2603:10a6:102:345:cafe::4f) by PR1P264CA0094.outlook.office365.com
 (2603:10a6:102:345::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.20 via Frontend Transport; Thu,
 30 Jan 2025 13:09:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM4PEPF00027A6B.mail.protection.outlook.com (10.167.16.89) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.14
 via Frontend Transport; Thu, 30 Jan 2025 13:09:29 +0000
Received: ("Tessian outbound d1e0abd198b0:v560"); Thu, 30 Jan 2025 13:09:27 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: ca60226393ebda3c
X-TessianGatewayMetadata: 41C5iM3Q8zvqrV/s0MlO/0wnrlMX+Jatsbrho/D/C2GhtTE3Y+4Chb5pNS5mtMBvvXr+fM0Ibb/jz0djhK8I9YYwm8NBP9opIwyKPGt5YFOpWNp6jSJ1Hr5BckpjU75lsG71j6pmwTzQ9x/XzGrpFqmnnZDPtgdNa5DN/u++sRQ=
X-CR-MTA-TID: 64aa7808
Received: from L5f962119725b.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 731C6107-BEA4-4A6F-B553-063DD10D8C51.1;
	Thu, 30 Jan 2025 13:09:19 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L5f962119725b.1
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Thu, 30 Jan 2025 13:09:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A2F/MXQOBnGUwhfmeXLXObpK9a5AwalCQ5i9Gy+ZhDtwoOcx/PEWwaOg+E1SsHV48iJ1RU5NsB2g6oqE3MUV4js9hDfKkOtOQiO2ecerwRyfE/j8xG5FqOYTh/fVU7ETmce2Hs8GNRAz2URfK1znwckSH5XFpnn6SqlyXL14QJtyjnnDg35BJHs3zT5PbY/2qh2OwoR92zzdKefzyLEFKL5K3JHXUinhuW8RLFrPqo1yFhL1xsHHmVSobGU5rCd4m0NmFO1KENYcl0rstlcbY+8dwb9x3kCYncyatcu9YO97zYCYD68EMk6NJRogJUrnr4KC5u2jPcGztVNtdNinyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YItMqBB3AFZY9z+AAWQmS9LrlWXXDu8EElut2eZSjfM=;
 b=LOQhso0IBUCf8C4lBimp6ffAl50lvlcsPsNS/XKn0WgMNgdveXJeSjmsGiQZ8TUzBxxhLHeFDrhttf2WpPgxEVaC3gHvmVOXWH/5LE0vCCvEZK6LLAe2FUZc/r3mqiVBjpfT94cTVidEpIzqxWNZHGTLI+7bO2zrKlUo/Dwx/EEmkcuSuVWsjAvmo4J6ucKHre17Cl+lnYeS5M4I8xkRY3+aUBkVnjbxFTlDldARk+WllOPtFxRHQuCvS8eZDdsIZveBlXvjquiyJoNpMTyM9+KI93tMEWPShv9ZNS/1Uzm2uvSfz/ZUrZfR+Lth+9ybvtei9B0rGuU+DmjpmcbMYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 172.205.89.229) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YItMqBB3AFZY9z+AAWQmS9LrlWXXDu8EElut2eZSjfM=;
 b=MQdsK9pH9F24jJwyVELdeH1JPCo5xohATn6LEhLoRMkS+/01lVOWYnRT4fjlfq+Lbp3+F8YK6QNnYm2gZoQAXoDDYACFtsWQVtmck993hAtZo/5d6yqm1Lp3pSiqN3Gn3Np0rRbjsT2UYx30qWRXSx4D61BA350gMM1eBIDRuTg=
Received: from DB7PR05CA0044.eurprd05.prod.outlook.com (2603:10a6:10:2e::21)
 by PA6PR08MB10593.eurprd08.prod.outlook.com (2603:10a6:102:3c8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Thu, 30 Jan
 2025 13:09:13 +0000
Received: from DB5PEPF00014B89.eurprd02.prod.outlook.com
 (2603:10a6:10:2e:cafe::ea) by DB7PR05CA0044.outlook.office365.com
 (2603:10a6:10:2e::21) with Microsoft SMTP Server (version=TLS1_3,
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
 DB5PEPF00014B89.mail.protection.outlook.com (10.167.8.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Thu, 30 Jan 2025 13:09:13 +0000
Received: from AZ-NEU-EX03.Arm.com (10.251.24.31) by AZ-NEU-EX05.Arm.com
 (10.240.25.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 30 Jan
 2025 13:09:05 +0000
Received: from AZ-NEU-EX06.Arm.com (10.240.25.134) by AZ-NEU-EX03.Arm.com
 (10.251.24.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 30 Jan
 2025 13:09:04 +0000
Received: from e121164.cambridge.arm.com (10.2.10.32) by mail.arm.com
 (10.240.25.134) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 30 Jan 2025 13:09:03 +0000
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
Subject: [RFC PATCH 0/5] drm/panthor: Protected mode support for Mali CSF GPUs
Date: Thu, 30 Jan 2025 13:08:56 +0000
Message-ID: <cover.1738228114.git.florent.tomasin@arm.com>
X-Mailer: git-send-email 2.34.1
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
	DB5PEPF00014B89:EE_|PA6PR08MB10593:EE_|AM4PEPF00027A6B:EE_|DU5PR08MB10440:EE_
X-MS-Office365-Filtering-Correlation-Id: 66e07149-5553-4863-4e56-08dd412f54cc
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|7416014|36860700013|376014|82310400026|921020|13003099007;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?xgibOeOPOwdEr8QJXRHf78g1HmeBgI0EsC/AzHf3IWY8T+DX1eOgLpyJLet6?=
 =?us-ascii?Q?7PTLSkG7i0QgfGfbtVONuJzG6huoExizKuVt23a7zT0GCwxqP8mg7T5pITVS?=
 =?us-ascii?Q?SJm8vcqNWP1+6bP+j4AQ9ntU9Sh8o55l4H/y/2aQLN/gDwAKu6B3Dk9WXs91?=
 =?us-ascii?Q?2OV8BaCo2Ehpm7Eu9LvSNnRZygJG/BGSRKnjoGdXKQYTDbBoZz9dEDylv+TM?=
 =?us-ascii?Q?7PwVYhC58QdPSWohJROc4/u7flfP1g0jc/jmpAh824VU4m301YYcWD1LG3HA?=
 =?us-ascii?Q?DfsU7GoG3riWMdUFvEh4S0yGB+T4eGS0CVFk31Jn6TQC1mdRmfCmk3onB/Du?=
 =?us-ascii?Q?j9S/OvNcA43DYlE8eG2Qk9pBez8/bOgNv/jaZuHsHv2LZEuxoWHuZamGYm/t?=
 =?us-ascii?Q?W6YxMC/Ib9wdcf9kpINFlvCBqTcW+TlIZ8LeLk9tBCSYfohH1dHsheKkHYPO?=
 =?us-ascii?Q?31ghd7QmpS33dNt7TThSm7SPbdkEWA/0p0MJMWX7ZJkpzm8H4Xk8cDAksgtc?=
 =?us-ascii?Q?MqrEvauaGSCsOi/5UHNzpYfmaNxwPOaG8q2cxZ1txdp1jAnjItGbtHX+PYEF?=
 =?us-ascii?Q?FgYDaODURyiWI+w2+QuVMHi/H2utL4dd5cqG13lXIm7qgCedXv4rQnhQ7pYM?=
 =?us-ascii?Q?bmL0l221QfqT9uKG3yfXRbn/TxA+5V5tuE4gaOgUiFNORd+SQ2YMLXIlEz6q?=
 =?us-ascii?Q?P5z9nU6DjjoZnZMBUyvBYogPxWwAq4j7KMZARikG0+h+Zyn0D+VlzGcgutv6?=
 =?us-ascii?Q?GTq/Pcu7hdxzqZEHXWRSMFLOhi5XOwXj4CRNJXB7qCBUTr3MAAF8dI2tELaz?=
 =?us-ascii?Q?WdJWGoG9DivoqRHqd8278afdVy1LefZnmMHyLPYgVfFcVUfjiILt93D4SxTK?=
 =?us-ascii?Q?TpFtdXlnWC0vV2NqOsow57T8xjWlP4gaTKSnD91oDVF6G9i1ihuOSwdZVtsj?=
 =?us-ascii?Q?LbbyjLjleCCwYx1LM4pYkXeBvxdDDZNIdwf2tSzrcf9qjBSp4iF1/6XuPuKh?=
 =?us-ascii?Q?YV0QNCS8gru75HODY6rFwSWto/vhLLllUVXYZumc0Oo0yArmYTctcCrTEI6B?=
 =?us-ascii?Q?fBsJIhygB7bQkDk+JLHxNpXj8CZWpa/XdWaWSWoTZvC4fvUl57mD1W2W8u5N?=
 =?us-ascii?Q?Rr7JTmU7AE8zC3XfnBLBLku8FL8x/AajuJpANEyTIfD0IOJFYKcrRF4VFq8i?=
 =?us-ascii?Q?HP2op5rUP9D/NoJTL69US7R3zxdVcaPKutW1G+T90SBQXLWJGxvUH+RIPRCj?=
 =?us-ascii?Q?sYCnxQNn9QOVpDfItcZkFQdhp4PXwJPvZVBdN7H5wd+1Ndx9vQUQb9+J+MUa?=
 =?us-ascii?Q?nlawo8QH2vECS23sgfaLGcsk77H/IOnTg0FPGkmsU9AkdEVwE/Gy3OX42zug?=
 =?us-ascii?Q?zfhq4z7tBqt2Et13nNXySYRbrpaYuSTBk66rW2ucwW+NFWPooW/982DWXgGW?=
 =?us-ascii?Q?yO4s9UZwsFFtAfl8wb78MCGfV2PHZvufx2sSbIfVUkwdn0efk8bR6w=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:172.205.89.229;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(36860700013)(376014)(82310400026)(921020)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR08MB10593
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:10:2e::21];domain=DB7PR05CA0044.eurprd05.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00027A6B.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	90491689-a6d6-4550-a5f4-08dd412f4aca
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|35042699022|14060799003|36860700013|376014|82310400026|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Lbtn3zs8g/FaR52oDES6dhWlulZtw1CzK4ehH9u0ZWtv3V5A8IjDHBJV9DWn?=
 =?us-ascii?Q?2DvXHdgDWgQ0yCzCo+HkOjKmF4rhNS3EyTpSJgpmJCQVvLn5L5nOXW2InEVp?=
 =?us-ascii?Q?RwGfDhlE2hIYmTm+f6RKXvUQMqi+BbMAJAaSYkdLW3/76Oxwq700x+xcApez?=
 =?us-ascii?Q?opSHItS3ro2hhIAGXioqCnUQqzB4CAOB6Gtx4Ay06Me2T04HgqU+obu7M6eJ?=
 =?us-ascii?Q?w4LXbYNb42ls/3LgoBqBb3rDZjhqNTc8qMQRjwyNulIQm1xYmAnPepJvpZcF?=
 =?us-ascii?Q?aMd07H1Ta7tezgy7UeUnFzIP/t7n99P752mMQ+ug7/cbZwb3/oJaBBrkz3du?=
 =?us-ascii?Q?vLWbY2eCEIHo2/fhLX0ECfxsWZRimGUp3XHTBnAd32ZlmOWrTUGH39BdNHLx?=
 =?us-ascii?Q?W9vx88isRnJj2Ab6A0LVHLKkNDPPlkWjVK0N4MuhQEKfpcK/IN2g5A0n/hzW?=
 =?us-ascii?Q?18iS9MXSy+j+FhXp/Ycu+XDu03pvpA+HmfNGlY8oWK7S4eGM/NGtLOwVAfse?=
 =?us-ascii?Q?XPLfjxUKoUeLnyRLNkB/cVQLibZcJOuE2Dz0XiR9J/7+lX+BGMVrqV/2gv9D?=
 =?us-ascii?Q?m5cRBQrYsOsCzsIe4gTeEZETHs3aZ0Zwr5CQQCL0DTDnh8c1B+qtUDQWutFy?=
 =?us-ascii?Q?nsF0N0sFYrpeliV52BrzeMF6joqOsZXQDSQbNKxbhpx9u6rK5QUk2yLG67GU?=
 =?us-ascii?Q?Bgt1uQzt98kqjF0iNmTy218e0DDw8TX5QCv3Iie/psGQi2xngvnK8otaxU2x?=
 =?us-ascii?Q?gkUAUhA/p6MAhCvFJeeID/cGhGF0knvQER5K4LQbuyWchs1PvdIE80KDl344?=
 =?us-ascii?Q?+zNZHSCTha75jZTJdkNfKFH6ud43CiNdu7Q4TMfQOYIw8qi3V3qisELcfJAR?=
 =?us-ascii?Q?6gV1p3ItNbj27lZZJMqN+4WC1NQwGtPaODb2xLjOY/CdNyR96BGjv50BsDrT?=
 =?us-ascii?Q?N/HctddbaqjqeKSAdqeWWA9wG8SmrA3LD0SMZgXP3EjoGbuKC0DZohMTvLT7?=
 =?us-ascii?Q?OwO6j0Fl/uI55Qgr1VrjiatLb1fBQeoxFT3nUyo34MD4FGet8oWIvHf+g6jx?=
 =?us-ascii?Q?LPcmAsNpOupwBonUyxDClOBk5zcP0sST916aTHaHz0O5rgf8MXCun2KPgGW7?=
 =?us-ascii?Q?rLmEophjXA/jSpnCQmSIFqDKKc4R2gmPGuUTHtqvj7FEvZQqR3AWCzOqYLJH?=
 =?us-ascii?Q?sSyy0gkwtGwxU+Y53ttz9TR6UOQnn9aVH+43tpLA3C5s+Dm9ei4qc741i+bx?=
 =?us-ascii?Q?mRUArpw6kEU8r43NuR1Hgh99sM+bvvIYGMf/59Tkq/kixCDbw1o5+lyd7XAW?=
 =?us-ascii?Q?/lgJa2qmKevs1NRSgOPOyPpvAcREpZetaaJYPoi83UrO6O2QcsMQ0iyVFmAa?=
 =?us-ascii?Q?y3E6qSzgaoyWIn/liZZTLYWCrIAFdXKjNQ8cCE7PZEvFhenG8hkeO5JCeui0?=
 =?us-ascii?Q?1uzhiHRL8DQupIvP04fqpQJsDC/3D3gmBaJBgmi/JxsjIPlKBkUOoQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(1800799024)(35042699022)(14060799003)(36860700013)(376014)(82310400026)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 13:09:29.2172
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66e07149-5553-4863-4e56-08dd412f54cc
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A6B.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR08MB10440

Hi,

This is a patch series covering the support for protected mode execution in
Mali Panthor CSF kernel driver.

The Mali CSF GPUs come with the support for protected mode execution at the
HW level. This feature requires two main changes in the kernel driver:

1) Configure the GPU with a protected buffer. The system must provide a DMA
   heap from which the driver can allocate a protected buffer.
   It can be a carved-out memory or dynamically allocated protected memory region.
   Some system includes a trusted FW which is in charge of the protected memory.
   Since this problem is integration specific, the Mali Panthor CSF kernel
   driver must import the protected memory from a device specific exporter.

2) Handle enter and exit of the GPU HW from normal to protected mode of execution.
   FW sends a request for protected mode entry to the kernel driver.
   The acknowledgment of that request is a scheduling decision. Effectively,
   protected mode execution should not overrule normal mode of execution.
   A fair distribution of execution time will guaranty the overall performance
   of the device, including the UI (usually executing in normal mode),
   will not regress when a protected mode job is submitted by an application.


Background
----------

Current Mali Panthor CSF driver does not allow a user space application to
execute protected jobs on the GPU. This use case is quite common on end-user-device.
A user may want to watch a video or render content that is under a "Digital Right
Management" protection, or launch an application with user private data.

1) User-space:

   In order for an application to execute protected jobs on a Mali CSF GPU the
   user space application must submit jobs to the GPU within a "protected regions"
   (range of commands to execute in protected mode).

   Find here an example of a command buffer that contains protected commands:

```
          <--- Normal mode ---><--- Protected mode ---><--- Normal mode --->
   +-------------------------------------------------------------------------+
   | ... | CMD_0 | ... | CMD_N | PROT_REGION | CMD_N+1 | ... | CMD_N+M | ... |
   +-------------------------------------------------------------------------+
```

   The PROT_REGION command acts as a barrier to notify the HW of upcoming
   protected jobs. It also defines the number of commands to execute in protected
   mode.

   The Mesa definition of the opcode can be found here:

     https://gitlab.freedesktop.org/mesa/mesa/-/blob/main/src/panfrost/lib/genxml/v10.xml?ref_type=heads#L763

2) Kernel-space:

   When loading the FW image, the Kernel driver must also load the data section of
   CSF FW that comes from the protected memory, in order to allow FW to execute in
   protected mode.

   Important: this memory is not owned by any process. It is a GPU device level
              protected memory.

   In addition, when a CSG (group) is created, it must have a protected suspend buffer.
   This memory is allocated within the kernel but bound to a specific CSG that belongs
   to a process. The kernel owns this allocation and does not allow user space mapping.
   The format of the data in this buffer is only known by the FW and does not need to
   be shared with other entities. The purpose of this buffer is the same as the normal
   suspend buffer but for protected mode. FW will use it to suspend the execution of
   PROT_REGION before returning to normal mode of execution.


Design decisions
----------------

The Mali Panthor CSF kernel driver will allocate protected DMA buffers
using a global protected DMA heap. The name of the heap can vary on
the system and is integration specific. Therefore, the kernel driver
will retrieve it using the DTB entry: "protected-heap-name".

The Mali Panthor CSF kernel driver will handle enter/exit of protected
mode with a fair consideration of the job scheduling.

If the system integrator does not provide a protected DMA heap, the driver
will not allow any protected mode execution.


Patch series
------------

The series is based on:

  https://lore.kernel.org/lkml/20230911023038.30649-1-yong.wu@mediatek.com/#t

[PATCHES 1-2]:
  These patches were used for the development of the feature and are not
  initially thought to land in the Linux kernel. They are mostly relevant
  if someone wants to reproduce the environment of testing.

  Note: Please, raise interest if you think those patches have value in
        the Linux kernel.

  * dt-bindings: dma: Add CMA Heap bindings
  * cma-heap: Allow registration of custom cma heaps

[PATCHES 3-4]:
  These patches introduce the Mali Panthor CSF driver DTB binding to pass
  the protected DMA Heap name and the handling of the protected DMA memory
  allocations in the driver.

  Note: The registration of the protected DMA buffers is done via GEM prime.
  The direct call to the registration function, may seems controversial and
  I would appreciate feedback on that matter.

  * dt-bindings: gpu: Add protected heap name to Mali Valhall CSF binding
  * drm/panthor: Add support for protected memory allocation in panthor

[PATCH 5]:
  This patch implements the logic to handle enter/exit of the GPU protected
  mode in Panthor CSF driver.

  Note: to prevent scheduler priority inversion, only a single CSG is allowed
        to execute while in protected mode. It must be the top priority one.

  * drm/panthor: Add support for entering and exiting protected mode

Testing
-------

1) Platform and development environment

   Any platform containing a Mali CSF type of GPU and a protected memory allocator
   that is based on DMA Heap can be used. For example, it can be a physical platform
   or a simulator such as Arm Total Compute FVPs platforms. Reference to the latter:

     https://developer.arm.com/Tools%20and%20Software/Fixed%20Virtual%20Platforms/Total%20Compute%20FVPs

   To ease the development of the feature, a carved-out protected memory heap was
   defined and managed using a modified version of the CMA heap driver.

2) Protected job submission:

   A protected mode job can be created in Mesa following this approach:

```
diff --git a/src/gallium/drivers/panfrost/pan_csf.c b/src/gallium/drivers/panfrost/pan_csf.c
index da6ce875f86..13d54abf5a1 100644
--- a/src/gallium/drivers/panfrost/pan_csf.c
+++ b/src/gallium/drivers/panfrost/pan_csf.c
@@ -803,8 +803,25 @@ GENX(csf_emit_fragment_job)(struct panfrost_batch *batch,
       }
    }

+   if (protected_cmd) {
+      /* Number of commands to execute in protected mode in bytes.
+       * The run fragment and wait commands. */
+      unsigned const size = 2 * sizeof(u64);
+
+      /* Wait for all previous commands to complete before evaluating
+       * the protected commands. */
+      cs_wait_slots(b, SB_ALL_MASK, false);
+      cs_prot_region(b, size);
+   }
+
    /* Run the fragment job and wait */
    cs_run_fragment(b, false, MALI_TILE_RENDER_ORDER_Z_ORDER, false);
+
+   /* Wait for all protected commands to complete before evaluating
+    * the normal mode commands. */
+   if (protected_cmd)
+      cs_wait_slots(b, SB_ALL_MASK, false);
+
    cs_wait_slot(b, 2, false);

    /* Gather freed heap chunks and add them to the heap context free list
```


Constraints
-----------

At the time of developing the feature, Linux kernel does not have a generic
way of implementing protected DMA heaps. The patch series relies on previous
work to expose the DMA heap API to the kernel drivers.

The Mali CSF GPU requires device level allocated protected memory, which do
not belong to a process. The current Linux implementation of DMA heap only
allows a user space program to allocate from such heap. Having the ability
to allocate this memory at the kernel level via the DMA heap API would allow
support for protected mode on Mali CSF GPUs.


Conclusion
----------

This patch series aims to initiate the discussion around handling of protected
mode in Mali CSG GPU and highlights constraints found during the development
of the feature.

Some Mesa changes are required to construct a protected mode job in user space,
which can be submitted to the GPU.

Some of the changes may seems controversial and we would appreciate getting
opinion from the community.


Regards,

Florent Tomasin (5):
  dt-bindings: dma: Add CMA Heap bindings
  cma-heap: Allow registration of custom cma heaps
  dt-bindings: gpu: Add protected heap name to Mali Valhall CSF binding
  drm/panthor: Add support for protected memory allocation in panthor
  drm/panthor: Add support for entering and exiting protected mode

 .../devicetree/bindings/dma/linux,cma.yml     |  43 ++++++
 .../bindings/gpu/arm,mali-valhall-csf.yaml    |   6 +
 drivers/dma-buf/heaps/cma_heap.c              | 120 +++++++++++------
 drivers/gpu/drm/panthor/Kconfig               |   1 +
 drivers/gpu/drm/panthor/panthor_device.c      |  22 +++-
 drivers/gpu/drm/panthor/panthor_device.h      |  10 ++
 drivers/gpu/drm/panthor/panthor_fw.c          |  46 ++++++-
 drivers/gpu/drm/panthor/panthor_fw.h          |   2 +
 drivers/gpu/drm/panthor/panthor_gem.c         |  49 ++++++-
 drivers/gpu/drm/panthor/panthor_gem.h         |  16 ++-
 drivers/gpu/drm/panthor/panthor_heap.c        |   2 +
 drivers/gpu/drm/panthor/panthor_sched.c       | 124 ++++++++++++++++--
 12 files changed, 382 insertions(+), 59 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/linux,cma.yml

--
2.34.1


