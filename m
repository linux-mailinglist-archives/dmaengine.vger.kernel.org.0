Return-Path: <dmaengine+bounces-10246-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBcpCUep+2myewMAu9opvQ
	(envelope-from <dmaengine+bounces-10246-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 06 May 2026 22:49:11 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CF44E0606
	for <lists+dmaengine@lfdr.de>; Wed, 06 May 2026 22:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 461DF3062AA4
	for <lists+dmaengine@lfdr.de>; Wed,  6 May 2026 20:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCF53AF660;
	Wed,  6 May 2026 20:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XgYWQm2t"
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011059.outbound.protection.outlook.com [52.101.70.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCD6361DCA;
	Wed,  6 May 2026 20:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778100284; cv=fail; b=JtDxlNvfwLZw+9rd66I6VYvvKsXb7KvF3v+4w79MbbJfn2uh+TB4atJhRCgHJWWciV/vgaVu4JHTeRVi8D0yuHw3D145V0nz/KrqNYWpDhireD5spAtLyIs1i8DMDJ02NmdJsHPscz8NLkScadgb3J3TjDJO6Dd/AVwRj3cOCN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778100284; c=relaxed/simple;
	bh=+R+dfDYb2Ixm8StGp8SozMg8BUknBvn5MTuMlDY2220=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=rs1MX/oQ4raOSIgatFjWxWwKjqmsgsJMhAYELTz1HkEmikg86OPM1P+LB0vtMI9sdXaloEKQpBqp8APVnpFzAdZfWmIDuzd6oHhFtZ7KxFUG/g3u0FNJrHBhOk0SPNGd7N9RFPDf0BPE4qK83ecjkCYskx73kaf0tiMWqha+UoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XgYWQm2t; arc=fail smtp.client-ip=52.101.70.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tgh2nyZDHLa8vOnfNxS5ql3FjIhzq1oHt3cfbnsIE6jMwiS25wRst/hJrIOPPJMw8Ab0Tat87ZqTPAaDWxquoOk5p4ebBvhN24dGzitnMCdjj2zZORKi7d2f168+17XRFxu25FyCBcTPx7OnYlhHZ2vhyWpl+kS3F5rV+t04MDzF+V4aseTM41xBws/4x0HM/duVa4zo0ulmSti6bVvS/A3yo2qmmSQ3wYzsO32ndqTaCE/0flCrdCPFlhYtIzddf8EEaTxFCaV8CE5WqGdad+dpXl6684SQkMdvAMmko57fhwtz39jCz38CukxUph261SMlYBH2LJTLQlyGvxlRtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nPrQ1SS9rYpKK6pohevXn8iidZPknmRB0pcrUQ/Z9A8=;
 b=QEy0l0KUdFucnQ/E/S9gzp6LDf9i958lWfim6P/3lvqnk4j360MC7KplgqpfdJ2ttiB8eYOSn1PFAHoqNArwcKoP1Wstd7pJqGme/F/BbohwHhGHfc8ERXLCvKJWecUNyKRo8UnFvQO/PrymKFK9ldM7qh1iIz/BYkuhS7/5JK43L+kseKm14kIxdX01+2RuLjDWHc7/1mWepxaD1odkf96/pGpOUJbsxQyTlxThN/EV4D9IH3lro2+CSuPpD47gSbFUfmldR0vlflGyrJ4sDsORIi3HPqHJbzoi2l6w9J8+9kcDBG/RjkKzN3Do0CCi5v4ukgFGmhzhaotJStf0sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nPrQ1SS9rYpKK6pohevXn8iidZPknmRB0pcrUQ/Z9A8=;
 b=XgYWQm2t/Q/XuUxg35IAC5Tnpl1rV31JO9GdWVlzvkTVnHDqs08pa+mqPNSeee0XUh7K1o+ECHNwKb4v47ajM8ddGKd7Sr92OedJlzzqoQdoV3C0GbPQ1RGuqs4LUho1dG0wXTFZd/TAOGLH+TqtnrHlMTBJzUU5LbTe9/KsY0Fw5ZAgP6yDqLGU3YLo8dwAzvy4r/l1yjyeBBTAkhSNKb+6KAzj60T/VLpIw8TgNYVlAB0IFg82KR8DCseH05iBXcnsBd1BW4xBw5Syx50B+GTMm7RVFB2soJ6c9HbW7D7hWK8unH72wPjS6SnCTRMHvIULmzxpnQHR545OzK+eEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com (2603:10a6:10:35b::7)
 by GV1PR04MB10479.eurprd04.prod.outlook.com (2603:10a6:150:1cd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 20:44:37 +0000
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4]) by DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4%4]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 20:44:37 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 06 May 2026 16:44:14 -0400
Subject: [PATCH v4 2/9] dmaengine: Add safe API to combine configuration
 and preparation
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260506-dma_prep_config-v4-2-85b3d22babff@nxp.com>
References: <20260506-dma_prep_config-v4-0-85b3d22babff@nxp.com>
In-Reply-To: <20260506-dma_prep_config-v4-0-85b3d22babff@nxp.com>
To: Vinod Koul <vkoul@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Koichiro Den <den@valinux.co.jp>, 
 Niklas Cassel <cassel@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org, 
 mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
 linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778100264; l=4358;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=+R+dfDYb2Ixm8StGp8SozMg8BUknBvn5MTuMlDY2220=;
 b=vuUwrc45oDzcD/oGrbm0Gb35fJpKQ8p8NIM3TWB/JUSD2y906d1+C4bgN3L5ZU2tqucTuGhWB
 m6M3vFrPFgHDsHqLsevLikpvLFnVim4oUx78UoHt4CutFcc8HZyChbq
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA1P222CA0051.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::24) To DU0PR04MB9372.eurprd04.prod.outlook.com
 (2603:10a6:10:35b::7)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9372:EE_|GV1PR04MB10479:EE_
X-MS-Office365-Filtering-Correlation-Id: 4817aa4a-c567-482e-12b4-08deabb04975
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|52116014|1800799024|7416014|22082099003|921020|18002099003|38350700014|56012099003;
X-Microsoft-Antispam-Message-Info:
	YgJHfrbsnw9Wv0yQZge2ZKCG70LNkEBnTL2Qs1GH2VZAIGn38knKjyiWCwMCNztHNHTOE5gN6Y1pnG/qL6UyfBCUDfsJHABYE4h3AI+DrCcEXEFnyOjAK9MA7bz5S838/x6H85cVWQ+Cn9h8iqxBvJ2wQDPKjBbaULORuEOUnhqDeZSPM4LLkXOKVRYZ/+l3wTi/fBwel02niZng6RnRVGMEtculgKT6IkSONW0htuIx+gQREfVsvDu7q02Y/PUgmK3VC9CavvSN+xo+jiXgnYB5pAt0xJRohH5tE22z7pj6EfeVOibEIILQODN4gPd2RxQo8v/716hRs1z3jLIlMOb8FY0P0/PXs0qvZ0bEkxewbjgOYOWD02f8oD7+rMZCb4vO2w3ILjBFrBwFZg6GKVA76stskLfXxT4RX7+xTAVH43SJ0MSRMB8wlG0J7DSbWqEFPPOAbDuf+oza3OcX8j5v4m7LV1CXE7UlOd4M0AUk3TIm7uUuM3yBNzPv5IC6e13P4BtToeCwr/35zs+y1EJvu5XEyJt/VdTk2HOmy4jn+lxPxrI/slUB3nBAXPKzonPNRX1gqgWR+a/VU+OEkJbgC0YDJKh2ySah4LAsKHRXj5Mdo6ip9re4xsHiBx4AKx0D4tGtoyLd9I+ZPKKgXL/QuMeciqPCBYquZtshQ1ojTuyoA/BWYrb8E+v17A0978GahFdnSnKLJmmtjvkt7xrRbcNqHxMYjgsWx0Kzc5dBEorGyT/oXgu7zcBdWW2SFoOcuMFtre4K4RRj2otWrw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9372.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(52116014)(1800799024)(7416014)(22082099003)(921020)(18002099003)(38350700014)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0d6T21UeWZITXpaa1lTd1U4d2FVeEpRaGM1cTBnVVpsc0k2Si9mN0FCRWNv?=
 =?utf-8?B?S0gzelhxRThEV1RLcmM5UG1CRWg2ZEVzSC9IR1FHa3BaeXZCNkk0RENJcGhn?=
 =?utf-8?B?azhBeVpsVjBYTHJmWURwS2E0ZU4rUjFlbVIveHozY3A4c2ROQXNTSXBxRkJi?=
 =?utf-8?B?T3BPL3NWTWdDUTMwUmRmTEpnWmNtT2RaV2x2UUxvZ2tkU0t4MTRNMFVVVENY?=
 =?utf-8?B?WFpHTzNOSnExMUFTc21Na3hNOWRtOGVETlNGNFRmUEtjeGhVQ1F2NkVYN1Q0?=
 =?utf-8?B?dlJ1cVo5NUZFVnBCdnI3S1p0TEk3MXlWYjRDVFhCM3hUWHNPNEZ3Vk9LMVRD?=
 =?utf-8?B?YVpXb3N2VEZRRlhGdm5uMCs0RTBaMkVXaWN4NmxzMHZUeHNBWDV1ODZBRk1C?=
 =?utf-8?B?cTFDM3NMai94YndXVmhxdVNRc0FJQmlEN1RuK0FPNVBDcmpTdnRnQWpJcmpk?=
 =?utf-8?B?OXJCOUFzdmo0RUxyMlF6R1ZWZHZSRWJwYXFxTC9kUUo3ZWNYTmhPMTVSbXJN?=
 =?utf-8?B?ZEFHWjloVVJ1ZmxmWlNVa0YrekdGUWtKQmpqVXRSREd6TXZseTJzY2ovSXYx?=
 =?utf-8?B?UGtzR3dxY1R1aHIrZXVUTDl5V0RiUFBjei9pTUlqL1hCQ2p2TUFNeDVOL0pr?=
 =?utf-8?B?VXFHZytJa2kyTFhQbWdGTXZWNXJYbGZLdjloc05LN2hRcVpXRFBrNTFtNFhT?=
 =?utf-8?B?cWZqN0M1Z0hlWTBYM3lvQkdsYzk3bkNuc3RqZEE1aWJOTVBCSTlOOGdVb3I5?=
 =?utf-8?B?bFgrZTBLZ1NxR2poSWlwTEdjcmRMS2ZmalJsejJHY09kUXRCRUllWldvaVJa?=
 =?utf-8?B?c2ZlWFo1KzRPdHMrblJsV09IeUorWmdGbWsxcENYcll3eUlWZjllSFcrMjZt?=
 =?utf-8?B?ZEM2TkZsUGFLNW02clM1T1ZqMDVENEplOExCYTd0VVFoQnc0YUlvd1lUbW1U?=
 =?utf-8?B?SW02Njlabmc3RWE0M3E2RnVqbFphQlJOT1BVSjZGeW9ZeUUrbGl1QyttaWNX?=
 =?utf-8?B?S2k2Y2poQWE3ejRiWmN3MGE4TWpyQXFZbFVxQWYxOWdMQlVrcVNCYnAxYno1?=
 =?utf-8?B?NVRCME5kQ0cvU2J4S09kRXRGR1hDUWRVdkNzYW5icm85Nkc1bXBXelc1Z3NZ?=
 =?utf-8?B?eUdiYi9WRDNyMElIR29uREFiZERHZ0M5Slcxc2hWTWoxeVZLS3V1R2hHSUNp?=
 =?utf-8?B?RGdmeHdQeEhseHQ4WHpmNUxIZUwzbmJwVzQ4OVdvVW9MekRROHZOaFR1ODhY?=
 =?utf-8?B?TnNtcFh3RHJMYUVTbjJaV0xkN2hHU1pQUGJnbEQ0Z2h1VGZnNXA0UmlUODJk?=
 =?utf-8?B?aldaRlF6MWpZdllqS3FISVRPd2toWU9SSmtwTjl3NlNkQnNwcXVpNHJiUkJJ?=
 =?utf-8?B?bHU2aHhpRDZOUm94dFVPOU5wdjRrRDh1RGt3eW4zT1I5VTRuaVU2ZWk4Uktu?=
 =?utf-8?B?bDQxOEgrZnR1dVlvVHdTelVhSVd3TC8vQVZJSzJRR2ZPZEpqUmplSU95OGxN?=
 =?utf-8?B?MzhMZy9wMVkzQUt5NXE4ZU5BV2xQSjJINCtiUXdOM2tPc2oxQ0dBa3F5cUJ1?=
 =?utf-8?B?M0x1R0ZIUHVJL3duSmZtbFg2RTFXMU9LcTl2aEV4QVcrcTh1UENYTlNVNXNH?=
 =?utf-8?B?MEZWcW10aVlvYlFaVDBub282S09vR0JoQTIvcHhseFV5b0ZBMFlqZi8yams0?=
 =?utf-8?B?MXhGMEdQcWtiRWZrc0J4NGxUQU9NemJFWk1JRjlMTFdJNmRBRHRCVndicmdT?=
 =?utf-8?B?a0k3djhGWFd1Z2ROMEJVM3JmYk1Ccno0S2V1bW5vOWpZa3hDVDN0QVpWdFkv?=
 =?utf-8?B?aURIZGtla3l1OXdmdlVnQ0tLeG9PbjZ2Ykw3dmx1ZGJNY3IwS0xTYThpWEU4?=
 =?utf-8?B?QVF4dzkyVVN4WHIwZzhxaHEvV3RVeWRlM2g0TitpSVJldXZXelA4dWFZTGRl?=
 =?utf-8?B?am9ORDg2VllvVnJBTTVEaFloMitRUmdlSmlmOFhYR2Q0THRJdUdreDVxaTJx?=
 =?utf-8?B?bURYby9td1kyTEhtVHpLU3FnbHJvdk4xQWVEdVNRK1pSTlFGM0hzVEJqVkFi?=
 =?utf-8?B?TWVscjJCUFJMUVZtMGk3RTUzN0x2aHUxd2RoSlF0WDZhVmVpZFlwbmEwS1Y4?=
 =?utf-8?B?eGhHU05NTzlVTk03VGJ1ckQxVVNhZ0pEOGtKQVBGMTRmR3d4QjVZWFcyejdi?=
 =?utf-8?B?MHRXbDBCNHh5Q1k1YXFHUnNYT1NiNFlZdW4yaGwwRFBLSGZhalZBcU1XKzJq?=
 =?utf-8?B?QjJ2RUczcVlINWowNjdXSVFKb2pRakhQbzh3aHdia1BRYXpNMDdXSHAzK3ow?=
 =?utf-8?B?QnJPTTRWNTF6TVoxdnhUSnBSeEJCdFl6dHJ3a3M1NEd3WjY0QnVVUT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4817aa4a-c567-482e-12b4-08deabb04975
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9372.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 20:44:37.0644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Doh4rwFL8vyzarovg479HHt7va7m39y39TNOUPecppnQYFZH9du0ewk0IoF2TO11PA8ADRmWOH+y5Nctao1Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10479
X-Rspamd-Queue-Id: C2CF44E0606
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10246-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim,nxp.com:mid]

Introduce dmaengine_prep_config_single_safe() and
dmaengine_prep_config_sg_safe() to provide a reentrant-safe way to
combine slave configuration and transfer preparation.

Drivers may implement the new device_prep_config_sg() callback to perform
both steps atomically. If the callback is not provided, the helpers fall
back to calling dmaengine_slave_config() followed by
dmaengine_prep_slave_sg() under per-channel mutex protection.

Tested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
chagne in v4
- use spinlock() to protect config() and prep()

change in v3
- new patch
---
 drivers/dma/dmaengine.c   |  2 ++
 include/linux/dmaengine.h | 58 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 405bd2fbb4a3b94fd0bf44526f656f6a19feaad0..ba29e60160c1a0148793bb299849bccfebb6d32b 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -1099,6 +1099,8 @@ static int __dma_async_device_channel_register(struct dma_device *device,
 	chan->dev->device.parent = device->dev;
 	chan->dev->chan = chan;
 	chan->dev->dev_id = device->dev_id;
+	spin_lock_init(&chan->lock);
+
 	if (!name)
 		dev_set_name(&chan->dev->device, "dma%dchan%d", device->dev_id, chan->chan_id);
 	else
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index defa377d2ef54d94e6337cdfa7826a091295535e..23728f3d60804e49cd4cbbd3a513c4936eed5836 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -322,6 +322,8 @@ struct dma_router {
  * @slave: ptr to the device using this channel
  * @cookie: last cookie value returned to client
  * @completed_cookie: last completed cookie for this channel
+ * @lock: protect between config and prepare transfer when driver have not
+ *	  implemented callback device_prep_config_sg().
  * @chan_id: channel ID for sysfs
  * @dev: class device for sysfs
  * @name: backlink name for sysfs
@@ -341,6 +343,12 @@ struct dma_chan {
 	dma_cookie_t cookie;
 	dma_cookie_t completed_cookie;
 
+	/*
+	 * protect between config and prepare transfer because *_prep() may be
+	 * called from complete callback, which is in GFP_NOSLEEP context.
+	 */
+	spinlock_t lock; /* protect between config and prepare transfer since */
+
 	/* sysfs */
 	int chan_id;
 	struct dma_chan_dev *dev;
@@ -1068,6 +1076,56 @@ dmaengine_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 	return dmaengine_prep_config_sg(chan, sgl, sg_len, dir, flags, NULL);
 }
 
+/*
+ * dmaengine_prep_config_single(sg)_safe() is re-entrant version.
+ *
+ * The unsafe variant (without the _safe suffix) falls back to calling
+ * dmaengine_slave_config() and dmaengine_prep_slave_sg() separately.
+ * In this case, additional locking may be required, depending on the
+ * DMA consumer's usage.
+ *
+ * If dmaengine driver have not implemented call back device_prep_config_sg()
+ * safe version use per-channel spinlock to protect call dmaengine_slave_config()
+ * and dmaengine_prep_slave_sg().
+ */
+static inline struct dma_async_tx_descriptor *
+dmaengine_prep_config_sg_safe(struct dma_chan *chan, struct scatterlist *sgl,
+			      unsigned int sg_len,
+			      enum dma_transfer_direction dir,
+			      unsigned long flags,
+			      struct dma_slave_config *config)
+{
+	struct dma_async_tx_descriptor *tx;
+
+	if (!chan || !chan->device)
+		return NULL;
+
+	if (!chan->device->device_prep_config_sg)
+		spin_lock(&chan->lock);
+
+	tx = dmaengine_prep_config_sg(chan, sgl, sg_len, dir, flags, config);
+
+	if (!chan->device->device_prep_config_sg)
+		spin_unlock(&chan->lock);
+
+	return tx;
+}
+
+static inline struct dma_async_tx_descriptor *
+dmaengine_prep_config_single_safe(struct dma_chan *chan, dma_addr_t buf,
+				  size_t len, enum dma_transfer_direction dir,
+				  unsigned long flags,
+				  struct dma_slave_config *config)
+{
+	struct scatterlist sg;
+
+	sg_init_table(&sg, 1);
+	sg_dma_address(&sg) = buf;
+	sg_dma_len(&sg) = len;
+
+	return dmaengine_prep_config_sg_safe(chan, &sg, 1, dir, flags, config);
+}
+
 #ifdef CONFIG_RAPIDIO_DMA_ENGINE
 struct rio_dma_ext;
 static inline struct dma_async_tx_descriptor *dmaengine_prep_rio_sg(

-- 
2.43.0


