Return-Path: <dmaengine+bounces-8158-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F63D0AEFB
	for <lists+dmaengine@lfdr.de>; Fri, 09 Jan 2026 16:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1668B30A9325
	for <lists+dmaengine@lfdr.de>; Fri,  9 Jan 2026 15:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7460D364024;
	Fri,  9 Jan 2026 15:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TzBvuI5v"
X-Original-To: dmaengine@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013004.outbound.protection.outlook.com [52.101.83.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A09C363C6B;
	Fri,  9 Jan 2026 15:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767972586; cv=fail; b=H3Z6XRZpO4GJ7+lG2J+tGJjFviHsgpes7VGovFXi24ui2nuLwpIAwDB2Tgk3Yges9eta3yQAWDBNcUDhmHs2vtnL6Tm+KK4mUUxr5afZT6N2aF9lLSjrrYNuXd6HZFhKB8RYK5w3reLhjB3scNxSGgeuApo58zmmZUM3eW0BnXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767972586; c=relaxed/simple;
	bh=ytOl0SEzwn07yeKl+Jxu4ja5wb5i34yK75CCH+G0XQM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=s2FmVVCHRM3N4BW0RSc228rR284V0AX3u9G2i6vKdCYjmj9Sg8U2Gut1VNtr1eJ+UNqhBnORY2JUVvrGMku+zMgoPKNUCoKG5sN/x4XPaYUCJI7ZooRO029G6uZqfz/OeGU/aNfrulqw99rs1vBSQ8GXglmnfd9dVA3w+HHgpn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TzBvuI5v; arc=fail smtp.client-ip=52.101.83.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DYN68CYni0iT7Fq/mF2nQiUAALM55UQXUS0KFchIc9OH+8UIdy7xrkd0YnobJw/oLsKxTFRtkCYF1Zys3ux3WnyARXKT4JZNaUkgtseRQUtawy8sfavLNorJr2/EaffnSo7RCuE9LdTYlcWXNpYhtEiMyCNyIx8z8FARMV5uUbNsZsMP2//z0Ku9SO0QDEo8hwE31wrVD8iD6P2CeB87dhoQOjT+PIxvh9O7IgDnxaVeqQ3OLF4gZaei8Viza5mcNJjIcEiTkdD5sH+IA2zSIJBbOLLrhm9i4VsWtpYOyeWI20Ky817CI/bq6U5oFoodxRgCCgrHrgx/ytZbkc6z0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U8pst+iSQHS0EmFBE2PVl/2ZmMwH3SXsGj/LGmrdiFs=;
 b=l93r2dCeIT6x5i5a5LHcBWL3XL7+0BUosXS4emMlsLYRgt9KYOuwyi+lYC+lkbHW2s1m4GNpGj0KalJICpMEzKczj8kFlmrU4idtpqPqK9NWajHl1eCKGtlyyt/E7KteW/nHri3zUoCbimmnYP+/nPpfHArgpPDM65Hor+CHSpFXcu3ebLxsHEDcAUmpQ7JJrj1/6Aks43VFL0wz0f2w7PUnr2lmzNrKJkajSNOsQcLBibGgDkjGillf/3sgFKRNfU8csXIyv0/FwkVtrcD2+HSRD32XsuWkTkOEjInWxzfqgW61BwsUqG6ZFA5M4jSIHbv6qEdGhYB17wg3g1v6HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U8pst+iSQHS0EmFBE2PVl/2ZmMwH3SXsGj/LGmrdiFs=;
 b=TzBvuI5vz2PJg5jY295/GeZL+VhtQ97GusmMKVy+jn4frDTVT4INg5UHjARilNZqfPmBTdGWvGP6sc0oVHCkrvXyRQVRSk5o3UndSExE/lLtULWhfxowooes8fKkK+od62Yei3Zt7FbBsCoAEapAigjayJXvtSTp1fuyRTGw3rPAHbL+pIEWpkatnghCY3B/wP4pZBZz6d5pklN9/ZCppAMpyZplsOqo6GCLkIHR4SmrODswRnZiMMMyOLsG6bWt/owjSUe5XYg+bNUXEo5yLVdgS2hsW+4PDpaOPrBG5i3DkAu6hBUFxO6t7yuYXDhYnD8TnW1bjBbE9m9NifXUew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8957.eurprd04.prod.outlook.com (2603:10a6:102:20c::5)
 by DU0PR04MB9371.eurprd04.prod.outlook.com (2603:10a6:10:35a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Fri, 9 Jan
 2026 15:29:41 +0000
Received: from PAXPR04MB8957.eurprd04.prod.outlook.com
 ([fe80::9c5d:8cdf:5a78:3c5]) by PAXPR04MB8957.eurprd04.prod.outlook.com
 ([fe80::9c5d:8cdf:5a78:3c5%3]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 15:29:41 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 09 Jan 2026 10:28:30 -0500
Subject: [PATCH v2 10/11] dmaengine: dw-edma: Use burst array instead of
 linked list
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260109-edma_ll-v2-10-5c0b27b2c664@nxp.com>
References: <20260109-edma_ll-v2-0-5c0b27b2c664@nxp.com>
In-Reply-To: <20260109-edma_ll-v2-0-5c0b27b2c664@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>, 
 Niklas Cassel <cassel@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-nvme@lists.infradead.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767972522; l=7729;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=ytOl0SEzwn07yeKl+Jxu4ja5wb5i34yK75CCH+G0XQM=;
 b=qtIv36ZRNWLImQjQ3Z1r3JnyajnQZWxJ7wl9mOsPrC76N39G2ruMiJvSJKiRxFOgFjrS0thiQ
 wyYWt1Clg09COlDO9V/Dq+i320kMjrn4Z+xPd90zHAzs+0qt+xPKO6K
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR01CA0069.prod.exchangelabs.com (2603:10b6:a03:94::46)
 To PAXPR04MB8957.eurprd04.prod.outlook.com (2603:10a6:102:20c::5)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8957:EE_|DU0PR04MB9371:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fb13bf9-2b94-4a65-010f-08de4f93e86d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|7416014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SW5aMWtNY2wvdmp3RWhaMUFEejRSVGV2Sy95ZmdCNlc2d2FJNVZGQUFrSE1j?=
 =?utf-8?B?bXJhWE5YTGVGNEdQVW0xQnJCbGE5UFpjQk5pYS85M3hTZGo1NDdNdlpBMEtM?=
 =?utf-8?B?NVJWWTZodkpreUV2ZnEzQlNiUFUrM1FGaEtnazluUmpzOGZ4LzZMVllaekkz?=
 =?utf-8?B?OU96aEwvNFVtbkxOMi9mQ2dvMjliSWhrZndyRzdUVW5UZzN0QWxtaFVJSnUz?=
 =?utf-8?B?UHMySjZLYUhmTjJvUDN5NGszTEs0SmRsNk9UUzhUc09VelNvbG5PaDJUbjNX?=
 =?utf-8?B?WGcrSWdFN2Jlak40UTdBRzY2a29rRDVsZUdzUjZSZ3Fud0FJejBxUGZ3TjJo?=
 =?utf-8?B?VDhMYm1BU3pHcXoxTEtxejR1OWZqTzI4ZTZRNUttZHB0YndvYmU2d2c1elRP?=
 =?utf-8?B?d1M3NkJHVVo0M0hHNDdkOEdWTkZhMDhTZlFQNUV1RjJhMlhDbTF3VlBkS0tj?=
 =?utf-8?B?VnlKT1c2MGFTWm5VbmwxaEJ4ZEpvR2VzaWE4MUZ3eGlDa0Vjc2cydEplbEtL?=
 =?utf-8?B?MklRMDVHNEhEUWxzbHhIRTJNWjNLdVZ1RVByZVJ0R3JzUGhCMmVQM2xReXlM?=
 =?utf-8?B?b3ZzSHhXSVA2WHN4YWNRS2l5cEZqa1ZKamMzZUZhdERIZVo5azQ1WE5ubVh2?=
 =?utf-8?B?OHVXaEEwaDRPS1JKcnpybStPUzdNOTVxaThWUE5EcmN6cVJTdVpZQWZqcE5G?=
 =?utf-8?B?OHJoNHhIdit1OXE5SE92a1NqQ1pDWldFeVhUNVA1b3BtWWM3RW1TRFZoQTFV?=
 =?utf-8?B?SGFUQTlLUjBJT3dhU0dhdmVTaEJtRERRZW9VeElnNlJXRWplSDJvOHFrSmpI?=
 =?utf-8?B?SVpOdURXNWVVQVhwcGJjQUp4SVl4M1FTU3o3c292bGNQUGZEVlBWcUlxd0ZL?=
 =?utf-8?B?K3U5RTFDNmtlZiswNVhBTGVuSjJ3RHpFR3dRa3lFbzVESkZQaVVraVJPekFD?=
 =?utf-8?B?ZlFXa2U2KzhxSzBwTWxIbGhIT2kxbHozUlVBSDRrYUE0NUU1dGRZRlUzamYr?=
 =?utf-8?B?QlZSTTJNNmIvQ0FNb2Yzbkh0K2hFY0o3M3lOWGtCS0hJcUNmUkhzSnNPOFRB?=
 =?utf-8?B?OEZ5bmJ0QkF4UE1IVExzcWduakd0alVUQm85cTNZYlNOTms4eVV3anZYenl2?=
 =?utf-8?B?NVNzY0JRODFRVDdwRFBlZitHdTlVNXFsdUZESmJFbDZsWHo4TDY2ZHZqSEQv?=
 =?utf-8?B?Y2lLSlZqN1RNeXFKRUd2MldKdS9nYU0zV05EM3hSR2FsTGo2N3VJY0Npc0RX?=
 =?utf-8?B?UHhRcjM3YWNWZ2NKYW5EbDdtRFh0M0VVbDV5bGlNQkhrOFptQmk5bE9xNHla?=
 =?utf-8?B?VlZqcnF4eWF1NENPMEpSdWU2NjBxVkNlTTNJa1RMQUZEUVBoTThqRUl4OHM5?=
 =?utf-8?B?WHE1blhsR2ZZdUJpcmRtUjVDVjBEVmRqNmV5RzhrVFcyd05NejNuYlVxYkZq?=
 =?utf-8?B?ZHpydGtTQXd3ZVJPSXZKczhscnlXVkNtVTR5d2RjZlIxNjRQQ0tuSFZiOGVp?=
 =?utf-8?B?ajQrZU1uU3paWmtyOS9wQVBuNjl2MDE4eUxpQVJkM0JkV3FwV01HOUdSNWFX?=
 =?utf-8?B?dnhVVDIxd3Vhc2VaYklWU1ZQaTRWcU9kZzB4YklnRk5nSkw1RDgyeXZydUwz?=
 =?utf-8?B?Q3MxSTN3RTRkTjlpOWx5aE1TOVlQdGcyQlZQaDgrZ1djNlFsZjhtYXVTZ09M?=
 =?utf-8?B?NmwzZFBsZUlIUmg2SUlqKzc5MlpSRVRaZ084U1hQWWdPK0FMTDZxTzd3MGk1?=
 =?utf-8?B?eEU1Yzg1Z3hqUjAxS3hNVkxNOGJHOHdoTnA1aHFGaCtMc043UGI0K0kvcTRB?=
 =?utf-8?B?Q3lWODVNbjdjY2MwY3UwcnBtNmxjdHU4ZjR2a0pac0lIVE5LT3NXY2tQYzV0?=
 =?utf-8?B?ZHJ1cHhOeHV0eWpDWS91bnZuVnlSWlBWc05Id2hYN3BVSDZkNEhMNzlBRm9k?=
 =?utf-8?B?RFNvU3lzQVBGYUs0Y3hLNGUxd1VUUHlabDlQTk9DckROT2NUZmgySFhZdmFk?=
 =?utf-8?B?UnRDN2lETmN6MmJvYnpLUG1qYjRFUUZGS3VYZmtEQ0phTWdabnNvaENxanox?=
 =?utf-8?B?c0dMTUh3bHMvNGdOTkFLbzM2T2ZyNUNvd1RGdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8957.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(7416014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Uk1aejRGTUM3US82U01ONnBLVnRjanVnYWZLYU9TSkFHMHp0bUtGSnNndXJS?=
 =?utf-8?B?dXJMa2JSUnBDMS8vYi93UDQvT1FYS1B2UG43QmljNk8rQWIrV3BVd283RHps?=
 =?utf-8?B?OWYvYVArUDBXR3dtMXlyOWJYOEpqb094MzF5NW5WVEdNcDU5bXdvNGVoUkgr?=
 =?utf-8?B?YjhETDIzbEQ5OXVvN3k3LytpaHZzR0g2QVFpNVQyUlBldTAyeE1US3cvN0tW?=
 =?utf-8?B?bnllT1oyMC80enEramdiUXVPMjBLSm44QVgrdE1OaGJtZUlGT1JZZjVQbUox?=
 =?utf-8?B?cHppWE5EMitySFZXaDVQbkRZbkRNeXlnTUh0TXhLUXBqaHp2cWtUbFZUVFJk?=
 =?utf-8?B?TG5kWnBvdFJ5KzhJS3pWYTByQjRpZEFaZWlRTGhweHVYUGMxZnBJTzhpbksw?=
 =?utf-8?B?Y3UvK29SWFdOeTZzMzN4dlVBdCtMNkZCQldRM1BxeHJ5Zko5TXFzTWJkZVpo?=
 =?utf-8?B?aFEwVFd3WHl6a2JnUHowMlhGK2ttQWlwaHREVy9sa252MUl4dTViOGpZbk9F?=
 =?utf-8?B?dnlDdTFPVnQwYXlrekRSRGNVUmVxMm9pSlFHTHBiRmNYYWNxVlhOakNhR1Uw?=
 =?utf-8?B?VTJUaUlaNUxoUElHTzF0L1NoTTFCcmFyK3k3OEhsM0ZMZjhiTFB0Y2haQzdN?=
 =?utf-8?B?NityRzhhWjB5eENkU0srVUFYSVdHRzdnb09tRWhsRE5Rb3pCeFY4K1Z3TWVD?=
 =?utf-8?B?NGFDdStwYXA0dE5CM1dyOXRYaUlSaHhLU0VKUjZUQ0R6bFFkZkpTUzZIR3dE?=
 =?utf-8?B?RXBWZDF2ZU9DZ1Y4Wm83MTFKRHc5bmJXcWVITHFzTThDL1NGUkNNWWc1SXJS?=
 =?utf-8?B?OTFRb2Z0NkE4NG1HKzFYVHdKZFNXWnZWM05sRnl1QjhwbTJ6a0lYNHlTWkll?=
 =?utf-8?B?TE5CQzBhSVloRXlvcGsyWDRaalJyQXpDOFlNNHBBYlBDOEQ5dk5xVk9SWUZk?=
 =?utf-8?B?THpXNFJhYVV6ZkcvdlhvMlFLb2Q1QlA2Zjk3SHJoRUR2K3A0VkozdEt4S3VN?=
 =?utf-8?B?OTQvUzFqR0xaTTBMV0lEbW1VeVNaQ1Y5TlRpNGY1QWNTenFoWmlRc2hBcFJC?=
 =?utf-8?B?cXpLMEdGUUYxb2tIeUVnRG40ejJhd0RkNEFrNmV5MlVlYjFTdCt0RURPM1B5?=
 =?utf-8?B?Z3FoSS9EZURwekduRlFxanM4cERoNDlWaEllQTMrWU9id05FQThKMHlLWWd5?=
 =?utf-8?B?MSsrV1dhait0Z3lNTGFtWEh3MkZRZkZ5V3U3aGwwSy9ESWpabnFuQUlxUUla?=
 =?utf-8?B?bjBqd0duZ1VyeVpjRmZvNlEvNlpuU2hYTXlOTjkzWjdXQ21kblBwQXdpUVdM?=
 =?utf-8?B?ajhtUE0yTVNqamZLWSs4OFViT3pwMVJYaUt6ZitQUUxWV29BYUtjWVhUY1pB?=
 =?utf-8?B?OXVUMHRvT1RiZVFoVTJKNWVSRTd4VFAwZk5XSnFXSllqOGFGdEoweExzMUFh?=
 =?utf-8?B?eVVrQUtoUmd0cFluTGNzbmI3ZGhFUzZyZ2NHOWZWS2RzVzZxaTZxWGxrRnRF?=
 =?utf-8?B?T083ODVwSjVxOXpFdWFLMWtKdjN2UEJrNm5NTEZUYjJ4bit2Z2RqRG1rNUdX?=
 =?utf-8?B?K3prM1Rnb0ZKdyt3enhVM0dLTU1nUHFEL2o4ZVNTWHVrQWVGaWs1MFlUN2VW?=
 =?utf-8?B?WHpjQWJNR1NySTlyb2o2VG1TKzNvVWlWeTdzWnRFb3lOYlM1RUxFSEVPOG1T?=
 =?utf-8?B?bFU1UTJoMnNjQzhSRTloakRzb09GaEFqc3RvR3BWTnpSam9QOEN2cDNTMHBT?=
 =?utf-8?B?eXl1YnluVVVOb3BDZ3RHYnlRVmJ1ZHQxbDJXcHNFVXByTk5vWmIzMU1CaTVh?=
 =?utf-8?B?RU9jZ1RtQStRUEIybTU0OHRMbkdpbUZ2ekpNWnNXcVoxeUFpSEQ5S3cwLzZk?=
 =?utf-8?B?cWpxVjRWNlE0UXZldmNpdXZXTzVsOHdNM0pLekt0RktYMC81T1ZZb0VFcEk4?=
 =?utf-8?B?U3ZwcFhkZlVMSWthTGZtN2Uzc3RadGRNNlNqOWZrdEk5ZHRvWkFzK2Z3UFJI?=
 =?utf-8?B?ZzR5OG1LYTlTVXBJOGhqYXFPckpkU0h1czdxUVRhbFppdUduZUF6Szc2VHF2?=
 =?utf-8?B?T2kzbnByczJ2TmhISitiTnFZVlo4QnRpUVB3YmZQdG9nNWxQWnhGMHdObUoz?=
 =?utf-8?B?ekdNVzlGcExOK1k3TlZWTEFodzFIWlI3Yk44bm1XcHZXa2tVeUlyVWEvOGk3?=
 =?utf-8?B?UkdrUDZrcEtlcm9YQWw2eEp2UTVVbHd6c2xlZlordkZFOERkVG9UNTRFTml6?=
 =?utf-8?B?TVUrRHB5SFBWUW1oU3BvVWFrT3p2Nk1DcU5NbjBKMHBHY3FKSXVIeTJvZkNa?=
 =?utf-8?B?MXRwTDhuSWQvWHhXZ1dWSU5EcUpmK1VkZ3VrTUowdTZuRjczMnE0QT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fb13bf9-2b94-4a65-010f-08de4f93e86d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8957.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 15:29:41.6402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yf/kzKxM/eBkY4Q7s8w4APwC6F/iuCr0u/g8h2e7eeWaQhRiWDoVs5qpl/0v4OvkmwYB8IuQNQC0CigKaEG2HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9371

The current descriptor layout is:

  struct dw_edma_desc *desc
   └─ chunk list
        └─ burst list

Creating a DMA descriptor requires at least three kzalloc() calls because
each burst is allocated as a linked-list node. Since the number of bursts
is already known when the descriptor is created, a linked list is not
necessary.

Allocate a burst array when creating each chunk to simplify the code and
eliminate one kzalloc() call.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/dw-edma/dw-edma-core.c | 114 +++++++------------------------------
 drivers/dma/dw-edma/dw-edma-core.h |   9 +--
 2 files changed, 24 insertions(+), 99 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 37918f733eb4d36c7ced6418b85a885affadc8f7..9e65155fd93d69ddbc8235fad671fad4dc120979 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -40,38 +40,15 @@ u64 dw_edma_get_pci_address(struct dw_edma_chan *chan, phys_addr_t cpu_addr)
 	return cpu_addr;
 }
 
-static struct dw_edma_burst *dw_edma_alloc_burst(struct dw_edma_chunk *chunk)
-{
-	struct dw_edma_burst *burst;
-
-	burst = kzalloc(sizeof(*burst), GFP_NOWAIT);
-	if (unlikely(!burst))
-		return NULL;
-
-	INIT_LIST_HEAD(&burst->list);
-	if (chunk->burst) {
-		/* Create and add new element into the linked list */
-		chunk->bursts_alloc++;
-		list_add_tail(&burst->list, &chunk->burst->list);
-	} else {
-		/* List head */
-		chunk->bursts_alloc = 0;
-		chunk->burst = burst;
-	}
-
-	return burst;
-}
-
-static struct dw_edma_chunk *dw_edma_alloc_chunk(struct dw_edma_desc *desc)
+static struct dw_edma_chunk *dw_edma_alloc_chunk(struct dw_edma_desc *desc, u32 nburst)
 {
 	struct dw_edma_chan *chan = desc->chan;
 	struct dw_edma_chunk *chunk;
 
-	chunk = kzalloc(sizeof(*chunk), GFP_NOWAIT);
+	chunk = kzalloc(struct_size(chunk, burst, nburst), GFP_NOWAIT);
 	if (unlikely(!chunk))
 		return NULL;
 
-	INIT_LIST_HEAD(&chunk->list);
 	chunk->chan = chan;
 	/* Toggling change bit (CB) in each chunk, this is a mechanism to
 	 * inform the eDMA HW block that this is a new linked list ready
@@ -81,20 +58,10 @@ static struct dw_edma_chunk *dw_edma_alloc_chunk(struct dw_edma_desc *desc)
 	 */
 	chunk->cb = !(desc->chunks_alloc % 2);
 
-	if (desc->chunk) {
-		/* Create and add new element into the linked list */
-		if (!dw_edma_alloc_burst(chunk)) {
-			kfree(chunk);
-			return NULL;
-		}
-		desc->chunks_alloc++;
-		list_add_tail(&chunk->list, &desc->chunk->list);
-	} else {
-		/* List head */
-		chunk->burst = NULL;
-		desc->chunks_alloc = 0;
-		desc->chunk = chunk;
-	}
+	chunk->nburst = nburst;
+
+	list_add_tail(&chunk->list, &desc->chunk_list);
+	desc->chunks_alloc++;
 
 	return chunk;
 }
@@ -108,53 +75,23 @@ static struct dw_edma_desc *dw_edma_alloc_desc(struct dw_edma_chan *chan)
 		return NULL;
 
 	desc->chan = chan;
-	if (!dw_edma_alloc_chunk(desc)) {
-		kfree(desc);
-		return NULL;
-	}
 
-	return desc;
-}
+	INIT_LIST_HEAD(&desc->chunk_list);
 
-static void dw_edma_free_burst(struct dw_edma_chunk *chunk)
-{
-	struct dw_edma_burst *child, *_next;
-
-	/* Remove all the list elements */
-	list_for_each_entry_safe(child, _next, &chunk->burst->list, list) {
-		list_del(&child->list);
-		kfree(child);
-		chunk->bursts_alloc--;
-	}
-
-	/* Remove the list head */
-	kfree(child);
-	chunk->burst = NULL;
+	return desc;
 }
 
-static void dw_edma_free_chunk(struct dw_edma_desc *desc)
+static void dw_edma_free_desc(struct dw_edma_desc *desc)
 {
 	struct dw_edma_chunk *child, *_next;
 
-	if (!desc->chunk)
-		return;
-
 	/* Remove all the list elements */
-	list_for_each_entry_safe(child, _next, &desc->chunk->list, list) {
-		dw_edma_free_burst(child);
+	list_for_each_entry_safe(child, _next, &desc->chunk_list, list) {
 		list_del(&child->list);
 		kfree(child);
 		desc->chunks_alloc--;
 	}
 
-	/* Remove the list head */
-	kfree(child);
-	desc->chunk = NULL;
-}
-
-static void dw_edma_free_desc(struct dw_edma_desc *desc)
-{
-	dw_edma_free_chunk(desc);
 	kfree(desc);
 }
 
@@ -166,15 +103,11 @@ static void vchan_free_desc(struct virt_dma_desc *vdesc)
 static void dw_edma_core_start(struct dw_edma_chunk *chunk, bool first)
 {
 	struct dw_edma_chan *chan = chunk->chan;
-	struct dw_edma_burst *child;
 	u32 i = 0;
-	int j;
 
-	j = chunk->bursts_alloc;
-	list_for_each_entry(child, &chunk->burst->list, list) {
-		j--;
-		dw_edma_core_ll_data(chan, child, i++, chunk->cb, !j);
-	}
+	for (i = 0; i < chunk->nburst; i++)
+		dw_edma_core_ll_data(chan, &chunk->burst[i], i, chunk->cb,
+				     i == chunk->nburst - 1);
 
 	dw_edma_core_ll_link(chan, i, chunk->cb, chan->ll_region.paddr);
 
@@ -198,14 +131,13 @@ static int dw_edma_start_transfer(struct dw_edma_chan *chan)
 	if (!desc)
 		return 0;
 
-	child = list_first_entry_or_null(&desc->chunk->list,
+	child = list_first_entry_or_null(&desc->chunk_list,
 					 struct dw_edma_chunk, list);
 	if (!child)
 		return 0;
 
 	dw_edma_core_start(child, !desc->xfer_sz);
 	desc->xfer_sz += child->xfer_sz;
-	dw_edma_free_burst(child);
 	list_del(&child->list);
 	kfree(child);
 	desc->chunks_alloc--;
@@ -375,13 +307,13 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer,
 	struct dw_edma_chan *chan = dchan2dw_edma_chan(xfer->dchan);
 	enum dma_transfer_direction dir = xfer->direction;
 	struct scatterlist *sg = NULL;
-	struct dw_edma_chunk *chunk;
+	struct dw_edma_chunk *chunk = NULL;
 	struct dw_edma_burst *burst;
 	struct dw_edma_desc *desc;
 	u64 src_addr, dst_addr;
 	size_t fsz = 0;
 	u32 cnt = 0;
-	int i;
+	u32 i;
 
 	if (!chan->configured)
 		return NULL;
@@ -441,10 +373,6 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer,
 	if (unlikely(!desc))
 		goto err_alloc;
 
-	chunk = dw_edma_alloc_chunk(desc);
-	if (unlikely(!chunk))
-		goto err_alloc;
-
 	if (xfer->type == EDMA_XFER_INTERLEAVED) {
 		src_addr = xfer->xfer.il->src_start;
 		dst_addr = xfer->xfer.il->dst_start;
@@ -472,15 +400,15 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer,
 		if (xfer->type == EDMA_XFER_SCATTER_GATHER && !sg)
 			break;
 
-		if (chunk->bursts_alloc == chan->ll_max) {
-			chunk = dw_edma_alloc_chunk(desc);
+		if (!(i % chan->ll_max)) {
+			u32 n = min(cnt - i, chan->ll_max);
+
+			chunk = dw_edma_alloc_chunk(desc, n);
 			if (unlikely(!chunk))
 				goto err_alloc;
 		}
 
-		burst = dw_edma_alloc_burst(chunk);
-		if (unlikely(!burst))
-			goto err_alloc;
+		burst = chunk->burst + (i % chan->ll_max);
 
 		if (xfer->type == EDMA_XFER_CYCLIC)
 			burst->sz = xfer->xfer.cyclic.len;
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 0ad460e1942221c678a76e9ab2aee35f1af4eb25..e9e0346c35b1917a5ef2c545fdf1754d18684154 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -43,7 +43,6 @@ struct dw_edma_chan;
 struct dw_edma_chunk;
 
 struct dw_edma_burst {
-	struct list_head		list;
 	u64				sar;
 	u64				dar;
 	u32				sz;
@@ -52,18 +51,16 @@ struct dw_edma_burst {
 struct dw_edma_chunk {
 	struct list_head		list;
 	struct dw_edma_chan		*chan;
-	struct dw_edma_burst		*burst;
-
-	u32				bursts_alloc;
-
 	u8				cb;
 	u32				xfer_sz;
+	u32                             nburst;
+	struct dw_edma_burst            burst[] __counted_by(nburst);
 };
 
 struct dw_edma_desc {
 	struct virt_dma_desc		vd;
 	struct dw_edma_chan		*chan;
-	struct dw_edma_chunk		*chunk;
+	struct list_head		chunk_list;
 
 	u32				chunks_alloc;
 

-- 
2.34.1


