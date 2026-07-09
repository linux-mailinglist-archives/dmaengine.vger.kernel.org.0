Return-Path: <dmaengine+bounces-12246-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0vTWCCfAT2pInwIAu9opvQ
	(envelope-from <dmaengine+bounces-12246-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 17:37:11 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EEB2732FFE
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 17:37:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=P3Xl1qGN;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12246-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12246-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 11250304E0BB
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 15:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38F642CB1E;
	Thu,  9 Jul 2026 15:34:23 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010002.outbound.protection.outlook.com [52.101.84.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC31422559;
	Thu,  9 Jul 2026 15:34:21 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783611263; cv=fail; b=SPO2b90A67M33grimNjKUlBHQj9V4ZI6EtbIGMIMNqglgNS+6ZbxlDwp7EmXu/HWXKLnqjGiPz/7IvX/wzFgf+uQV4dSAfkTaZ6eVHPk595naXKlNz+ep9efg/tzXMEVDhpAkt+3kJoHlGpqPOFB+iFJEsE67jkq478GGP9r9z4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783611263; c=relaxed/simple;
	bh=ZGipr494m0d1oF5X8IqRV2atoMwFfHeL5ZqNIrXGVT4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Ey1QgTAT4l5UU7ykbReyKpmS9rldV+qFwJKHhZGE4dqbsPRUZm7uqKEOQlWqEmnkRIxUOJeL8xWBCEgundCOOoF6y5Lcbm8rN9f+/f/bCVU4FaYBkdITnGZcmtJ4Ek7m5r54oa7IQa2UjRutvHIf9MyNJmcnfdLr5lCIg4wHkUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=P3Xl1qGN; arc=fail smtp.client-ip=52.101.84.2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=natLuVyR4mQHBLCAYJbqFmJsnQCyvy2g2tSkoDCBbbi/M0tUKblgbj2XcXXCrtdEHGmjT6oJGElKB+TgTybX2g2I5BvXzxm1UJ+ibsediCHKCeahwy4QJru5r+3WMWjRlCVl5txdzb9Ykwt0uFNAjSPoUMNzlfYg+lUfMBwEo722uZ80Iqrhd54EiwjrLgEthY0tQQS0evm4/ailxZNdxrtKE0Xp7pS/Kmn4mFUsV33T6bGncI3i9ZtDmct8KmTGP6h2qF2naAMdkvCzYZrJqA6ZZM+hpEiz8nQAqcK3EngsRxmrmAV2zbaBLFE4EKquyut1jBDjp0drwcjiuDTihg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=goI7oOu8P3D/92hQL22NS9PUw7qHJVgLP7B5rCuLxJg=;
 b=FR9nsG2/qugPfn5/o6eGE5UBZVgVI3cffl3z8u1y78zBCoPF088jWBwtRwQoZ+Uw4eP7J9WPQY4r31B5cOpnUFkIDdgOzkoTmksvhh87hFuh6XcWRr1U/tf+gSPUI59ccOXUTtB4ndMRmEL4es3g0iMSb3ZF9X1DuaCGTi1qAmGUGMdVbp6IXRemMEmO1hYFQkvBPORgcB/d3o9Pgit5PQE7+im+em1WqZ++8ug/eg1MJSnoD7TsiUGEjEiLiFikot9C/+87Lr+ZG0Z0OrmPJUZO8R/SaxAqHW0bhQsCQFLTW1+o51vPUVhPNzPIiGW1hIfBk5sF5qGOAka1Y5fQRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=goI7oOu8P3D/92hQL22NS9PUw7qHJVgLP7B5rCuLxJg=;
 b=P3Xl1qGNXH/lgT3esEEh0gL91wfQ30NKpQviuGmm+bSCCHp2KJL2HmiaenOU/rsmvNTpQDjiW7O1yHT/oJ8FLiCPTOwcwhKZQIamqarpF9VVUXRy5Keb43oE4+N05vbvj7bQj9rl2EMt25QShw6s8JhR7oYQtwFLTqaW916lh9o3IyQGd8XXeIsXe3FyxTkub2ePZ9+6n6Qtv43eynavukbUm1Yxk8/Mfkn7Lz/DPXhGRh68aymVzSh9A9W6kGsy06wN3FIh//yFjtVpdnqBi1C4xCAe+SuJlE1A/0TL8nJouWVXkt9/hHIMeB58q8kYXKPOrBR+cSIiG4r0FIRSpA==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DU0PR04MB9466.eurprd04.prod.outlook.com (2603:10a6:10:35a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 15:34:17 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Thu, 9 Jul 2026
 15:34:17 +0000
From: Frank.Li@oss.nxp.com
Date: Thu, 09 Jul 2026 11:33:37 -0400
Subject: [PATCH v5 08/10] dmaengine: dw-edma: Use common
 dw_edma_core_start() for both eDMA and HDMA
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-edma_ll-v5-8-e199053d4300@nxp.com>
References: <20260709-edma_ll-v5-0-e199053d4300@nxp.com>
In-Reply-To: <20260709-edma_ll-v5-0-e199053d4300@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>, 
 Niklas Cassel <cassel@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Koichiro Den <den@valinux.co.jp>, 
 imx@lists.linux.dev, "Verma, Devendra" <devverma@amd.com>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783611213; l=7783;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=5wNiTIt210tjZzECyabmvGNuz/dnWdaiBgHGtRLK7CM=;
 b=lzLrJX5tjfLmMppbc6Nm/+NHXvGHCrJ15mofogNN1BtpmITIPkI2H2yEMiwgf41RSixuFQA/j
 hyc5a/FcyJbCH1niIy2YKrehycJGQlmygubCiMc5nYKp3kbWp1Td0rI
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SN7PR04CA0213.namprd04.prod.outlook.com
 (2603:10b6:806:127::8) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DU0PR04MB9466:EE_
X-MS-Office365-Filtering-Correlation-Id: 57151dc2-b11c-4c7f-8eef-08deddcf8986
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|19092799006|366016|1800799024|7416014|376014|56012099006|11063799006|18002099003|22082099003|6133799003|921020;
X-Microsoft-Antispam-Message-Info:
	OvHgH67TDxC1p/FCIzrulBmRq/8oI+2aWJms1Sc+uWeiWqERVFw/m528YWk5iwhX6p3qgEP2MHdgsCXnVW/rn2TIubiUN8gfxaI0izXajq1AJsgkEGbqPWMXtl4FJbXbjQwxtLkRdjc+2vmUby8GcghY16bW/FaTOQqPdUpGK4FpWPqmU8p1JR8jyI0t8O3zH640yaty+aqN4ZsM+mRicnb5ZjW1OWGKutz+I2zbNsU+PWd9ELM5qkLHahLGJNppX4Hc8c4egvOH3XbBpnsmN1Oem+KHNMaevew5i+KZQUfkS45mvM9qGXYJ3UdwkKfQZC2MGtpg1bz0x+TgRjBC3mhMaZ9SuJnVaYznw2SvzZvwq4maG99BZFA41aplNjD6aa1lPWP2gqjtBLjC5bMZaZD8uS3hJ3C5PbVedZ+mjSRDlKzo4yRLf0mSfV+hbkXX1V6ir41OfL/0A/V36iMmEbxcuogtYTnL4fLVW2TdA6m/cFunq4oL6LF2QjxK4IzQNBeyDYYhhLeGjWd+ARoMmtvgf0KYw3cCcurfjouw6hcaJ+lOGONOZnNiZrJiKpU9YfUlQp8I36hqZipHbv4m5FKQCsrbFMZISs7gD09hNubVMjq/EY6YXMb5pr+Y4BYQiD/+1hMs/se+U1reVOYqZlGPXXSscAcpO67kiHTk0JiMTPX5BOSRCJTiD8wwR2iMh2NhqiOIJ+AS5yZEFw7x0g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(366016)(1800799024)(7416014)(376014)(56012099006)(11063799006)(18002099003)(22082099003)(6133799003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WXQ5dlAwdzZCKzY0dTNQa2hSK2pvcVlNeUlIWnNkTGh5ZDQwOEozenovbzRD?=
 =?utf-8?B?N3htdXVKSDdtNm16ZExaNldHRzFUejY1VUxtYlZqYzVqNHhwSC9ydE9pM3BF?=
 =?utf-8?B?UGN6dTBMdm05QzRXMnNzbUJ2R3J5dnJ4elFwdkxucnVDOUN1ajIzMjRzeHEz?=
 =?utf-8?B?cEZMZkY3V0FRRzhOd1dkczJzS2d1RVJmVlJld1o1NS9naGlzaXNCdUdXS041?=
 =?utf-8?B?ZkJ5OWY0RlJhTmV1bWw5aGFCbzlrRGlxaFB3R0tFYnNRcnI3N2krOFUvOGds?=
 =?utf-8?B?bTZnYjdndkJybklwN3p5WWF1MmRtbjVSVTU5N09aSW1XNjhENVJ5WEI0bDAz?=
 =?utf-8?B?emZkYXBPOWJJSWNxQzFVZHhIVVR0ckdsMXRRNGtVVUZJdWhaZ0pXWXpMN2Ux?=
 =?utf-8?B?eUVSdDBxWlVVZnNRSzQrbmhxcUI5V0Q3aHNFUUE5T0paQXdTcHF6Zmd4TWUv?=
 =?utf-8?B?TUYrK25ncXJwT3VSTzFhQVV6Z0xjRk9JWEkwWTF3Uk1yYldyWldZeWNQTU5P?=
 =?utf-8?B?aCtINWhTR25KYXhhRjV1VklZNm5zNWlrUmFYOUpneDJUWTdPQXZFK3hUOTJL?=
 =?utf-8?B?VjBDekVVdUFnSEtWamRIY09GVk1iSXdRM296aVFsWTJqRjI5NHNKNGxoZEVz?=
 =?utf-8?B?LzRQMkpMWmNHMGx5VnRyMXYwbWw3VUR2ZFdGcnZISDdaaWZPTE5ZZDlJcWpx?=
 =?utf-8?B?UmNHQjNPVk95YzNwQ1h6Z2w3S09IM0dZbEZvT3JkTnFiY3laeDVUR1IxanNy?=
 =?utf-8?B?eUh2THFaVHc1b3ZyRmEzR3VNSDZ1MEM5OUpmMVdndUVQQWR0SUE1MjJvNlla?=
 =?utf-8?B?TXBOUHlxalVSaXlpMlhEbUFPQ3dmSVhNbmNsdzA5aTFwUnVWK0ZKdzFmcmRW?=
 =?utf-8?B?OWFmdTFyT0I5Mi9qVXpCejg1bDErZmRLbTRibi9YWWdpTFlYZG96V1gyeDJN?=
 =?utf-8?B?VVI4c1hRZmxtWlM1bm56UE1ES2FDUlRYT2I5WVVMRmhHbmFDQ20rTW9mQzRw?=
 =?utf-8?B?dHQxamo3ZmdXZ1Y0b0QvRS85QzM0UjB5OWtSMU1nYURuNFQ1bkVjaHNFbU1t?=
 =?utf-8?B?SjBNUC9JRWtPRmNJWXNhZjd2Q2RYNnpWdzZFU05jN2NzVzBsZXVGck1QdDg0?=
 =?utf-8?B?cFRBSWRxWXo0M2gwd1RPR0NudDJXVGF4NmpYalBGd0lZMXZobDRnODJYZzFK?=
 =?utf-8?B?R3Z2SUNpOS85NmdVYkpRTUp3QlVoWnF1NzgraE5FRk9odkhIVE11dCszTStC?=
 =?utf-8?B?MGxjeTdTNTVQQks1b1MvRXpvc1kzVWxjbENSdU1QYWZYYWJNSTdwdWNXMEc3?=
 =?utf-8?B?c09mQi9zUU5Zd09SYW5kaVZETUdveUlsdVhYZXRlWlN2TURkbDVLeHoySmsw?=
 =?utf-8?B?WisyY1BLTUJCQW5UYXZlYmQzVXNFVXBxZmo1UGJqaG11OGRaeUtFbHhnMWF5?=
 =?utf-8?B?MEdKSE16QjkxTlR3eVg0d3B0b1krR1RkNzdNbWNlWnhvUE9wRHBmYmlFZUFi?=
 =?utf-8?B?bEJlWEtmZjl3RGxVd21PVDNLeVFGRHVwb1NXUzVPaWt5b3FEREJnc0xOM2dQ?=
 =?utf-8?B?VDRZcUhEQTFieDhFTmIzWDYyeTZ4b2hENFV0UHFlRzYzTGdRSy9NanBLSDRV?=
 =?utf-8?B?Q3YxQXRsUXpRYjI4N2c3VXdlNVRIb0NjMiszY0R0dHpuK2ppK0MzSE1KYmtt?=
 =?utf-8?B?QURqR1R3ZktFeG9SZmFZOW5DaktLRzNaU2JTZjJUbzl4bDF2bURYNWZHa2p6?=
 =?utf-8?B?c0xNRktqVFlJRjVhejhDeFZnZmp5ZXdvWXRScXI5MUZTVW1IcXByeDFvRHVr?=
 =?utf-8?B?QjRpcXI1ZnB0WWczbUJFVjRLanlQaEVrdlBqd2ppMlJlNTJTa3UzdUc2M1JW?=
 =?utf-8?B?STViOUtQZmhROVNpQ212V1g3eGp6U2xxK25CejFvQis5a2ZFQ2d2T3FXeE1I?=
 =?utf-8?B?aTZHakpyTEcxT0J4VTQzZERSOTVXTzg5MFo5cnZnTnY3clhvWmFKdDlncmtX?=
 =?utf-8?B?dW16L25DbnRRSjJqYnhDOUZYdVZyT1d5VENhRitpaW5LUFh2VzJXQmpWenlG?=
 =?utf-8?B?Smg3d2h6Qkk3a1I1aGZ1YlNIUlNyK2ZJNE0rZm9QS1loelBXMmVTY3FVQnB4?=
 =?utf-8?B?MktyYlU4TEhhbFNzVFMzM1p1eGlwYkJ4MUdtR3VLUm1xYXZCcVFneUU3bTRC?=
 =?utf-8?B?Z2VqbWxoSWIyQXFiUzVFUlcyemJrc28zMWZYQ0VIQ0RTU3U3YVdwN1dCVTMz?=
 =?utf-8?B?dmgxTFd2RFd0Y1MzRHdUdTJka2hwdkVMaUgwbTVJWkk5UkhkMjZQNmZ2WlY3?=
 =?utf-8?B?OFJSWnFCS2RBWU9QV1lCSkFKY2ttN08yQ1ovTHZkU3VwNGJ6RVhFSnF2RG1E?=
 =?utf-8?Q?Hc20sTLehr5xexH1QK0fMyT5FXpbi1s6XHOLF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57151dc2-b11c-4c7f-8eef-08deddcf8986
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 15:34:17.0561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ardq4pBe7GhyfsP7llrz/2DA3PfDSsuplNh42Git0VA+pQrIs29VtiNJXzh/hGs5cJeGSA6vRxDYKb5fzv9ujR/JMS7kklTMYP4AMy2veCFZDzUZ9CQSoBokugDyNDDe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9466
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12246-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mani@kernel.org,m:vkoul@kernel.org,m:Gustavo.Pimentel@synopsys.com,m:kees@kernel.org,m:gustavoars@kernel.org,m:kwilczynski@kernel.org,m:kishon@kernel.org,m:bhelgaas@google.com,m:hch@lst.de,m:cassel@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-hardening@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:den@valinux.co.jp,m:imx@lists.linux.dev,m:devverma@amd.com,m:Frank.Li@nxp.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[Frank.Li@oss.nxp.com,dmaengine@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@oss.nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.nxp.com:from_mime,vger.kernel.org:from_smtp,nxp.com:mid,nxp.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,NXP1.onmicrosoft.com:dkim,valinux.co.jp:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9EEB2732FFE

From: Frank Li <Frank.Li@nxp.com>

Use common dw_edma_core_start() for both eDMA and HDMA. Remove .start()
callback functions at eDMA and HDMA.

Tested-by: Koichiro Den <den@valinux.co.jp>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v4
- collect koichiro tag

change in v2
- use eDMA and HDMA
---
 drivers/dma/dw-edma/dw-edma-core.c    | 32 +++++++++++++++++++++--
 drivers/dma/dw-edma/dw-edma-core.h    | 16 ------------
 drivers/dma/dw-edma/dw-edma-v0-core.c | 48 -----------------------------------
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 37 ---------------------------
 4 files changed, 30 insertions(+), 103 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 2652ad8e7a8f6..f52d9fd18e573 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -163,9 +163,37 @@ static void vchan_free_desc(struct virt_dma_desc *vdesc)
 	dw_edma_free_desc(vd2dw_edma_desc(vdesc));
 }
 
+static void dw_edma_core_start(struct dw_edma_chunk *chunk, bool first)
+{
+	struct dw_edma_chan *chan = chunk->chan;
+	struct dw_edma_burst *child;
+	u32 i = 0;
+	int j;
+
+	if (chan->non_ll) {
+		child = list_first_entry_or_null(&chunk->burst->list,
+						 struct dw_edma_burst, list);
+		if (child)
+			chan->dw->core->non_ll_start(chunk->chan, child);
+		return;
+	}
+
+	j = chunk->bursts_alloc;
+	list_for_each_entry(child, &chunk->burst->list, list) {
+		j--;
+		dw_edma_core_ll_data(chan, child, i++, chunk->cb, !j);
+	}
+
+	dw_edma_core_ll_link(chan, i, chunk->cb, chan->ll_region.paddr);
+
+	if (first)
+		dw_edma_core_ch_enable(chan);
+
+	dw_edma_core_ch_doorbell(chan);
+}
+
 static int dw_edma_start_transfer(struct dw_edma_chan *chan)
 {
-	struct dw_edma *dw = chan->dw;
 	struct dw_edma_chunk *child;
 	struct dw_edma_desc *desc;
 	struct virt_dma_desc *vd;
@@ -183,7 +211,7 @@ static int dw_edma_start_transfer(struct dw_edma_chan *chan)
 	if (!child)
 		return 0;
 
-	dw_edma_core_start(dw, child, !desc->xfer_sz);
+	dw_edma_core_start(child, !desc->xfer_sz);
 	desc->xfer_sz += child->xfer_sz;
 	dw_edma_free_burst(child);
 	list_del(&child->list);
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index e18d6e827c2c9..27415f3a2d04b 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -125,7 +125,6 @@ struct dw_edma_core_ops {
 	enum dma_status (*ch_status)(struct dw_edma_chan *chan);
 	irqreturn_t (*handle_int)(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 				  dw_edma_handler_t done, dw_edma_handler_t abort);
-	void (*start)(struct dw_edma_chunk *chunk, bool first);
 	void (*non_ll_start)(struct dw_edma_chan *chan, struct dw_edma_burst *child);
 	void (*ll_data)(struct dw_edma_chan *chan, struct dw_edma_burst *burst,
 			u32 idx, bool cb, bool irq);
@@ -199,21 +198,6 @@ dw_edma_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 	return dw_irq->dw->core->handle_int(dw_irq, dir, done, abort);
 }
 
-static inline
-void dw_edma_core_start(struct dw_edma *dw, struct dw_edma_chunk *chunk, bool first)
-{
-	if (chunk->chan->non_ll) {
-		struct dw_edma_burst *child;
-
-		child = list_first_entry_or_null(&chunk->burst->list,
-						 struct dw_edma_burst, list);
-		if (child)
-			dw->core->non_ll_start(chunk->chan, child);
-	} else {
-		dw->core->start(chunk, first);
-	}
-}
-
 static inline
 void dw_edma_core_ch_config(struct dw_edma_chan *chan)
 {
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index c0746e5351410..7b4933c66f9f2 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -379,36 +379,6 @@ static void dw_edma_v0_core_ch_enable(struct dw_edma_chan *chan)
 		  upper_32_bits(chan->ll_region.paddr));
 }
 
-static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
-{
-	struct dw_edma_burst *child;
-	struct dw_edma_chan *chan = chunk->chan;
-	u32 control = 0, i = 0;
-	int j;
-
-	if (chunk->cb)
-		control = DW_EDMA_V0_CB;
-
-	j = chunk->bursts_alloc;
-	list_for_each_entry(child, &chunk->burst->list, list) {
-		j--;
-		if (!j) {
-			control |= DW_EDMA_V0_LIE;
-			if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
-				control |= DW_EDMA_V0_RIE;
-		}
-
-		dw_edma_v0_write_ll_data(chan, i++, control, child->sz,
-					 child->sar, child->dar);
-	}
-
-	control = DW_EDMA_V0_LLP | DW_EDMA_V0_TCB;
-	if (!chunk->cb)
-		control |= DW_EDMA_V0_CB;
-
-	dw_edma_v0_write_ll_link(chan, i, control, chan->ll_region.paddr);
-}
-
 static void dw_edma_v0_sync_ll_data(struct dw_edma_chan *chan)
 {
 	/*
@@ -423,23 +393,6 @@ static void dw_edma_v0_sync_ll_data(struct dw_edma_chan *chan)
 		readl(chan->ll_region.vaddr.io);
 }
 
-static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
-{
-	struct dw_edma_chan *chan = chunk->chan;
-	struct dw_edma *dw = chan->dw;
-
-	dw_edma_v0_core_write_chunk(chunk);
-
-	if (first)
-		dw_edma_v0_core_ch_enable(chan);
-
-	dw_edma_v0_sync_ll_data(chan);
-
-	/* Doorbell */
-	SET_RW_32(dw, chan->dir, doorbell,
-		  FIELD_PREP(EDMA_V0_DOORBELL_CH_MASK, chan->id));
-}
-
 static void dw_edma_v0_core_ch_config(struct dw_edma_chan *chan)
 {
 	struct dw_edma *dw = chan->dw;
@@ -581,7 +534,6 @@ static const struct dw_edma_core_ops dw_edma_v0_core = {
 	.ch_count = dw_edma_v0_core_ch_count,
 	.ch_status = dw_edma_v0_core_ch_status,
 	.handle_int = dw_edma_v0_core_handle_int,
-	.start = dw_edma_v0_core_start,
 	.ll_data = dw_edma_v0_core_ll_data,
 	.ll_link = dw_edma_v0_core_ll_link,
 	.ch_doorbell = dw_edma_v0_core_ch_doorbell,
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 641a513bc52e7..4bf5a441afbfd 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -222,26 +222,6 @@ static void dw_hdma_v0_core_ch_enable(struct dw_edma_chan *chan)
 		  HDMA_V0_CONSUMER_CYCLE_STAT | HDMA_V0_CONSUMER_CYCLE_BIT);
 }
 
-static void dw_hdma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
-{
-	struct dw_edma_chan *chan = chunk->chan;
-	struct dw_edma_burst *child;
-	u32 control = 0, i = 0;
-
-	if (chunk->cb)
-		control = DW_HDMA_V0_CB;
-
-	list_for_each_entry(child, &chunk->burst->list, list)
-		dw_hdma_v0_write_ll_data(chan, i++, control, child->sz,
-					 child->sar, child->dar);
-
-	control = DW_HDMA_V0_LLP | DW_HDMA_V0_TCB;
-	if (!chunk->cb)
-		control |= DW_HDMA_V0_CB;
-
-	dw_hdma_v0_write_ll_link(chan, i, control, chunk->chan->ll_region.paddr);
-}
-
 static void dw_hdma_v0_sync_ll_data(struct dw_edma_chan *chan)
 {
 	/*
@@ -256,22 +236,6 @@ static void dw_hdma_v0_sync_ll_data(struct dw_edma_chan *chan)
 		readl(chan->ll_region.vaddr.io);
 }
 
-static void dw_hdma_v0_core_ll_start(struct dw_edma_chunk *chunk, bool first)
-{
-	struct dw_edma_chan *chan = chunk->chan;
-	struct dw_edma *dw = chan->dw;
-
-	dw_hdma_v0_core_write_chunk(chunk);
-
-	if (first)
-		dw_hdma_v0_core_ch_enable(chan);
-
-	dw_hdma_v0_sync_ll_data(chan);
-
-	/* Doorbell */
-	SET_CH_32(dw, chan->dir, chan->id, doorbell, HDMA_V0_DOORBELL_START);
-}
-
 static void dw_hdma_v0_core_non_ll_start(struct dw_edma_chan *chan,
 					 struct dw_edma_burst *child)
 {
@@ -383,7 +347,6 @@ static const struct dw_edma_core_ops dw_hdma_v0_core = {
 	.ch_count = dw_hdma_v0_core_ch_count,
 	.ch_status = dw_hdma_v0_core_ch_status,
 	.handle_int = dw_hdma_v0_core_handle_int,
-	.start = dw_hdma_v0_core_ll_start,
 	.non_ll_start = dw_hdma_v0_core_non_ll_start,
 	.ll_data = dw_hdma_v0_core_ll_data,
 	.ll_link = dw_hdma_v0_core_ll_link,

-- 
2.43.0


