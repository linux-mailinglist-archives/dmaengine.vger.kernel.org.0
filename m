Return-Path: <dmaengine+bounces-11992-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +IASIQjXRmrIeQsAu9opvQ
	(envelope-from <dmaengine+bounces-11992-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 23:24:24 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0836D6FCEDF
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 23:24:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=mbYLGpG2;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11992-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11992-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF78C3071C77
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jul 2026 21:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C33F3845B0;
	Thu,  2 Jul 2026 21:21:47 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013022.outbound.protection.outlook.com [40.107.162.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D0B33E36A;
	Thu,  2 Jul 2026 21:21:45 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783027307; cv=fail; b=u0YONttaEsNJhXZHQa+sOHsUEO8YmYhJ9LxUsfqFdyy0wBPsRIWe8pkveGywV4Vdt/KPrRDLGRH92VuSaYzjtCIYKWTJA/DdVH6xNZo2/+YzWB4RYuJgZ1eeZ+etaEnnuPIO7JhmDoz9cFI1ksLsh65cRZNkCKNWFQCICPfdCsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783027307; c=relaxed/simple;
	bh=WmejG79Ni05dsanBAIH0A3WrQieGCaRlTjl1kaPc4bs=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Db5S9lHtjEDTGMRrBS1sfXbp9HeRbXBF9rrotjsN05izzFmrXLuKKcrO4tnw+gscsQtPkztIF+eCluY8eL+asE/gTd4LJl2TRRpI2aZLBvrOY7tMLSL80vaSZfhhT8I+56W8qdrje3JRC+C4UmpwXLbu4aJ1eky2DlRdjC5yCUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=mbYLGpG2; arc=fail smtp.client-ip=40.107.162.22
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pCRnCt2yR2K1kGfOfcxjk7m2iseHVv5SCXT4RDTJapJxX7vLJU9DdQPDJFoiTTIeB8tDMuWvQl3QWQkBvFIeW5Zq7jccn4OZNwTVerP9fy0U4tNRj5WKqaM9PyaxzzFkclyP52uhcdQynPkHcNRTRonUzWbIdaFrfEJ7kJ0K91nNWdgrBW9AHDRLmKbWIzI1BxgyJu+9owMiur6EHOnRmQrTvEkYH5d6CqaArcMmEEBZ32O2ow9g/BJYC+T5gmBMFtvH8eUfUH0rcm/cm7MkIUf9P4/3V9q0bkvjW+iIWGBogzzNcgWHjpWirhiiLquyaRYqw09DziY0jQSwI6UgjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Br5yAWcBMcwgz+sOMUsF/jkdw8PSIWXz4HRrkmafwdg=;
 b=Lw6OBm4aL9MIq6szFFf99HIxCdk76vR2fqlJMIdNndu0FLW/0KjEmKPg2rQpmGLYISeIiEYoCy6OP6ZF+XEHeeS0Z22GTT2XtcLcim3YB10Mff6NOBitWUIgfXk1lMkAA+fObQP+kT8Cjpb6td4pqpv1hhd7fpHzJxoBVycc5aJBFKm5xefIKwinkLRF7kzdMEQmqYxMHMG9OKEltwPWtkjaVkPytHhYcxnJ34sY4MgtzRT5YXMRqz/icrIcsOCDsCs4oNtjq9A2jeESQj/j2KxrK+9eaNYLM46YiJo7IKeGI45UbpyiAkfPxeTwwFphlg1Kg83Ao59EXZd4nASeQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Br5yAWcBMcwgz+sOMUsF/jkdw8PSIWXz4HRrkmafwdg=;
 b=mbYLGpG2s2iKeSpeHdw8Ed5ni0jLoHZwrhYVEAaMh1S/9zO3GHV00W487rgDePBP0xgY9y7rfzf0Yt4KwkhuWhLq6WdI/RphmH6OhIaAcdLyMd+Gpb0oIYiH7lWfvu1YMeZa5WPfJF1RG10PtZ+HeFvImf11fHhp7dHbJ3bIn3RctmxieH6IUOn/CsYUaIpS21eQnsJd48Z3n4ik6qS24ihCOazeoCAxShbDzqsoKWrjH/T3awW2zF9CHw2Bp8A2MQzxuhjtkASyMvTYMjVhYy6s6Hh3t4Q/d5nWcqgieqYcoSCSXBngcS27SCBz43qvkmJewAtwPjDr3wS7jSVmcQ==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PAWPR04MB9815.eurprd04.prod.outlook.com (2603:10a6:102:381::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Thu, 2 Jul
 2026 21:21:42 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Thu, 2 Jul 2026
 21:21:41 +0000
From: Frank.Li@oss.nxp.com
Date: Thu, 02 Jul 2026 17:21:22 -0400
Subject: [PATCH v3 02/10] dmaengine: dw-edma: Add xfer_sz field to struct
 dw_edma_chunk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-edma_ll-v3-2-877aa463740c@nxp.com>
References: <20260702-edma_ll-v3-0-877aa463740c@nxp.com>
In-Reply-To: <20260702-edma_ll-v3-0-877aa463740c@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783027287; l=1677;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=0U5H57qDq2yNKBbJM/PjlgPgeloFRy9T+R+xeFXhN9s=;
 b=1igDDGN8LFoM5GDi1FthtNyFGTElH+z8dVFX6IYKVK/T3nL+sJuc57h+nTih0cCS2hHIUGM42
 CXZFTJpds0KDMv1MAC1TZ8LPnPqpBXl37jelu46U+3ipf7acbbVRj9N
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA1P222CA0186.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::18) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PAWPR04MB9815:EE_
X-MS-Office365-Filtering-Correlation-Id: 1be3d00e-3fd6-4ace-d5b7-08ded87fe8f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|19092799006|23010399003|11063799006|56012099006|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	t5SXtWwybMRQ2ltn5a3cXq01tFgvhzuYRZzIxHIxggo6E13jmMj/DKUUU19YnxgABn5aLE/4cW0stsMFgs+m+798r2iDQKkSUCE6cimeobHnOmLkJFdIp/HYdlMX8+kkHl1p6EGb8YcelwclpRkQGRyEx8iK+zcbssDkLF93V4ygLrYRDJEfBB6iYPZwQmMPm79gzl45A7DZlNyqi9mq9VTKK1imQhSrk9BOL78jNImtSpqxdYx58zRvkXiFNQHGr0AotOxIyZhQGYUKcLBHTzCHMT4/SrNxBzAEywKApjz92ihMUbqjWoHyNcmXm6J2q8MwO9UYW8qeKZVr2Uxsma0rm16pfpD0v811kvlvnUVMAABj5eVg2aj+7LGDAJfayUR+bNEQbY6anBLHRPrFaMd1rOptc9BJUCFliGeqAlwOg2HOYxa6Nf+ZbkzmwzqJ3wgkJaEVMFGa0hhC7bfQoCAsYB3bRsxgudNa5WVUzXT0wOXHD2MGOnwgyWUTzpgt2fOm24KaY3E762VpF0W1Q4UvhOiwUjkOVTJ00RSum1u8+DBaa8RaeScgGXF+sGL46f5IyTrpp5CH+u91P4GbZN5JKhX3BWqtwLU4TDIVn1e0WRMr8QdX8wDHKO5sVqWAUt/J4QFWiMeHdz74VuPnNqjYQCFeVzX+eGS7NcUiZP/iBSJ7NY5HWt3PzfoDSv2HJj++3RQRbWkq9nd35nma7Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(19092799006)(23010399003)(11063799006)(56012099006)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SXptbTEralBEdk5EYm9GbC9SVVkyYVhvb0FwdFRKVHZSbndBYUpWRGttVnJU?=
 =?utf-8?B?WVN0M2xFWTR2V2s4NlIrTktzbzdiazlIRWV6dUxMazVXOGl3K3gyWnFlcE9V?=
 =?utf-8?B?UEV5MG9PK0U5TVdld01SQjIxWCtGV0xGenc1NnFkNU83UVJ0WjVvSCtpWlFN?=
 =?utf-8?B?N3lJdHA4aFVYV0RldVBieldkKzlaMXFRb0c1RFZCOEl0VGZxYXVtemVhVy9F?=
 =?utf-8?B?WmZtbzdQek4vVUlsYmh3emdpQjRLTUJmS3J0d2pkckI5ZXdJUVhRajlaYjgz?=
 =?utf-8?B?Ty9RYi9ESURVeW5JanJFQVp6cTh6WjBhTVJSNkdmcHJ6T0tia3k2UFpVOFps?=
 =?utf-8?B?alEvVS9idzhmRTdTejdJYlUzR1pIa0xmbWZoTElpZzZSK1NLL21rQ3NjZVFV?=
 =?utf-8?B?Z2hQRFd1LzlCVVBnOE9aMGtMNUpsc1hmMjZoanJSdVFqUlpkSm9yYy9xVUVZ?=
 =?utf-8?B?RU9DRVVVTHJrK2hXSDZGZnVwR1BTQWNYN1RudmpRTExJaXdPTmlCMTRZMzNu?=
 =?utf-8?B?NzZmVDR1MkN4T0NQd3A3UGpDRTE2a2NxalkzQ24vZnRWbDdKMmlLdVpZekdY?=
 =?utf-8?B?N3g5Z204SzNkZFBhUWNYYXpoTmdUTzVFOUFPLy9WZVY0c1pLZnZLNFduYjRY?=
 =?utf-8?B?eGNKZDZJcWQrMDJlMXVVd25VWkxBN1BmQ0Fidmg5dzhMc0VhTVlsN21jVXNy?=
 =?utf-8?B?SlA2T3hCMUdTa0l5QUVzcVNxOEE4OWVOVHlwTVBqci9qVmVrTDBTRm13Y1pa?=
 =?utf-8?B?a01XblNNMXFqNmxFcCtGcU5YREgwaUE1N3QwRzJpLy9PRTNHNGxHR3lDTHNU?=
 =?utf-8?B?RXlGOEM5Zjd0YkNnRnJvaW1xRWo1K2FGaXA1UTJjS0xGVnYxdGIwajByR25j?=
 =?utf-8?B?TkVMdTRPVDRUbWlTUCtHQkIwOTBHUkt5ZjBZQ29VcjFFMDFwaDVZekI1ZUlt?=
 =?utf-8?B?eUU5N21WMjlQQTYrUzlZRW15RjljNmlQcTgySU8xT1FRSWZPTUVRb21BQVdZ?=
 =?utf-8?B?WHpKSmRyck0zMFZSaVpzdWMvSmVCQ09aa3NnV2VTSjVUMVZzZmZZNTlTclIy?=
 =?utf-8?B?UndSelA2ODdiS1l5WDVJT0Y1TDlUSlQyZW8wSVJJdTlNWWhHMys2NlRDMWc3?=
 =?utf-8?B?bEx6NkNZbUQyazY5d2dFakU5RFNGa3d3TjAzcG96amMvV3JWTFVVRGN1SFY5?=
 =?utf-8?B?VVZ2dUxlUnByd2Vjd205MXNhRWtYQy9QeGZUY1VlM09tRVVzUTdndjBiTzg2?=
 =?utf-8?B?SU8wcjdyR0xVdTZXMFAraUc3ZTFSUUhMeVBGNW83S0lIeEVTMEVrTWRabU1K?=
 =?utf-8?B?M2t4NnRWMG5SU1NkeXR1bk5hNFkzODZoc0R0ZGJRNWs3bXEvb3BGNm5hTFZy?=
 =?utf-8?B?bTUveHJFQ1lONXdZV3oxeVU2TXJWb21zeG5iYUNpaXdMOEFXZHdHZW0vdFJq?=
 =?utf-8?B?R0diRzg3dkpQcms4aDE4QytndmMvZWlsSCs4OFY2bkRrQjJVVmczVmU4RVNl?=
 =?utf-8?B?UXB6ZHJqQko4OFBISVE4UXhVWDc1cklHOGtINFVTSGZFNFlEdURIRGJSZVJC?=
 =?utf-8?B?RmtaeFJwTUtGaGRmNzZqbnlDTExJeUJuZURyTzJNK3VNREV2cG5LQ1VGSzJR?=
 =?utf-8?B?M2J2SDlLb0NUY1Y4b1p1OVlKMGhsZEVHWkRKR21mbkoxYVpLdWk0ZVRxaHFo?=
 =?utf-8?B?dlhiVVhIOUJGWEdaUFBTbVBIblhtTnFxUDdRS2VDR3FaUC9ReWNkd0RKN210?=
 =?utf-8?B?S1dFMWdjV3l2MWYrQWU0WG9pZTVLWkNSU3BZaXdvYXpyaUc2S2VjMjhFMmto?=
 =?utf-8?B?NzJTb29USUI4cnJYUUNFQjJYd1BBeC82ak9xbFFUZENyenh5MVViV0Irdldw?=
 =?utf-8?B?ZUhudDhMcGdJVG45Umg0Q1FNM2VQYTZrcmtlbElTZXNJOFB1VFZ6Sk40YTdo?=
 =?utf-8?B?MEttbGlzN243TGFCcEFjbVYxNUpKMy80VzZSWmdhNUZBSnB1WGRSbk45RGhp?=
 =?utf-8?B?bDNzc0M2bnJBZ0h4WEhWOHFsUWRLWDJYSHJmSEd2MWp6TEJwZldJM1RFK25J?=
 =?utf-8?B?eW9weGJncFBaVmNmS01kc0dJcHBEMFh4b04vdjAxczR6TU9QeUcwWmFQdVlV?=
 =?utf-8?B?Smx3YUh2KzJRc2NDQmZTQ0JWcnU0UE1wak9qZnA1Uk90U3EvVWVBZVVzdzhT?=
 =?utf-8?B?T1kwSlY4QU9EUmdWOTJoTGE4UHc5WDNHV0NjTzcwZ3YyWGNSL2JXTko1UlN3?=
 =?utf-8?B?N0M1ZjJBdHZpM3NDUnNoV2JkYmpBNDU1eGg4eVBzd21CY0thMnMwVDZ4U2RG?=
 =?utf-8?B?RFk2OUhteWQxNEpYMU5ITnpreE1kek1qeUc5YnJ4T2FLZmFDeWs5ditVRGMw?=
 =?utf-8?Q?hRZ848JOh73XxZR79mQS0BFMNKb4nYldLIO27?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1be3d00e-3fd6-4ace-d5b7-08ded87fe8f7
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 21:21:41.5983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RSf0o9O4N/lgyXmwwdn/MsiqJSl0SGt2FkvfTmhwmO4ocWqOWRemL+iIDCZBLLXzwJTCBxWi+eQbniU4xjGzFKr6JRlrvFL9Ib2pp7YKvim9BVHipShvJSOtT5e8UO5W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9815
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11992-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ll_region.sz:url,NXP1.onmicrosoft.com:dkim,vger.kernel.org:from_smtp,oss.nxp.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nxp.com:mid,nxp.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0836D6FCEDF

From: Frank Li <Frank.Li@nxp.com>

Reusing ll_region.sz as the transfer size is misleading because
ll_region.sz represents the memory size of the EDMA link list, not the
amount of data to be transferred.

Add a new xfer_sz field to explicitly indicate the total transfer size
of a chunk.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/dw-edma/dw-edma-core.c | 4 ++--
 drivers/dma/dw-edma/dw-edma-core.h | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 1fec1b52e3d47..53469c8c8b82e 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -192,7 +192,7 @@ static int dw_edma_start_transfer(struct dw_edma_chan *chan)
 		return 0;
 
 	dw_edma_core_start(dw, child, !desc->xfer_sz);
-	desc->xfer_sz += child->ll_region.sz;
+	desc->xfer_sz += child->xfer_sz;
 	dw_edma_free_burst(child);
 	list_del(&child->list);
 	kfree(child);
@@ -527,7 +527,7 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer,
 		else if (xfer->type == EDMA_XFER_INTERLEAVED)
 			burst->sz = xfer->xfer.il->sgl[i % fsz].size;
 
-		chunk->ll_region.sz += burst->sz;
+		chunk->xfer_sz += burst->sz;
 		desc->alloc_sz += burst->sz;
 
 		if (dir == DMA_DEV_TO_MEM) {
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 6474cacf71953..db5f45bf048c3 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -57,6 +57,7 @@ struct dw_edma_chunk {
 	u32				bursts_alloc;
 
 	u8				cb;
+	u32				xfer_sz;
 	struct dw_edma_region		ll_region;	/* Linked list */
 };
 

-- 
2.43.0


