Return-Path: <dmaengine+bounces-12241-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AWWSCjTDT2oFoAIAu9opvQ
	(envelope-from <dmaengine+bounces-12241-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 17:50:12 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F327331B3
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 17:50:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=AAPlFaz3;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12241-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12241-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 923EE3098C35
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 15:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C529641B374;
	Thu,  9 Jul 2026 15:33:57 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013041.outbound.protection.outlook.com [52.101.72.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB48E421EE0;
	Thu,  9 Jul 2026 15:33:55 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783611237; cv=fail; b=mOMcjYJ5CJtEN3UmRzBVQyLonGEqlAJTpVs/Lwl3OcTI78w8t1d7lw0uSnRWeErYrsJGCelkyPoFZ+/gq4BO7JfsWdfwfvEn/+/L1tKW9XvkRAJhB6sFSOGblHoj0nnEZfRzNd8zOjsJWixv4XkMK/NEAbeJmUCzA3OJ1+ZUbxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783611237; c=relaxed/simple;
	bh=qVuuMMJsQy3hIe5JuUoqdQkCzZ4FIL2qJKmyn/KfNPU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=UijrGlpIR9Xrq5L4ErtPcRQfhH824kkhLG1MstwU7csuUBdgrqc1ktX5ZqpEh5EWIEm19n+fHGnvugJpJgplkP6h+GX2BQYIhyqHRCoVBxzPwT1lWcsW2vVpQzPa6/X/MKg0q9Z+oVUWviUaUOpQmo0IJtP+4mM/FQ98w4NqG+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=AAPlFaz3; arc=fail smtp.client-ip=52.101.72.41
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sGXlOFY1ssEUZo/M5QZYKmz6CeKdlNy+hJtfi0cZeBl6n7InvUgiilQv6mVdQUyanZEP/SqZeGpAZ14xO+ggSY86ST41rQdi0sWLWxXjkA38RhOnHjJ30fBY0lHevwr+V4UGBJHb6u9lwnPUIVGxP4M6pBcN/bPEPp6ncrEJdjYL0rAN24mjha6lYCHdxdWmblHmPAk4NhUOrQbAeUDkv+BmrQzRc/ESkzIP0XDC/SBVcw0aSH+Um1Z/b1Y/yYJSkXq1WEJdTCgGKhkGgWQ6pJ0k/SK6qla3+71A+xUHa35HQ7/i7A7JmZDZ7ypiUleFT69Jzai6a9FnbTwVdqJjcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=htKCchOFJEB/1kcz9Ei0HvNuGZp7OR/PrXyB6wNOmQo=;
 b=HmdAnP4OpwYPqNUBku83IbnkiNg0nCOW+HrCRQ4l8jJX5EDZbOFzvok0Ee/xtOV/PZo5vAP+Z1rIN5QoyuCFQulDu6qi7drecMnVJO0lCnEFuEmK8ZcT5QRnIl17ejVB3qdvq1gvHcamlLKxYCKHrqTqbnEry2BO1ReThKruyB8qRfNT6TZpP/x2xpqwa5zwoPe0mQxDwbmyuUaBN2K7UFeP5v2nOHy3ecIpup+WmG6G8Pa7wACVRU8IYJrav9wDGhIasExu5uO2YvYE7c9dANnZskh1v0uE8z9Xc9BUfbKwe5HGxaqxbI5qUSh6UZl6Cu5oKeVewjxuybDRfVPXOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=htKCchOFJEB/1kcz9Ei0HvNuGZp7OR/PrXyB6wNOmQo=;
 b=AAPlFaz3VYtESG/oNWTrpuvBsHXFoRikQg1CPZggWrUVZOEg6bkZmXuFef1NoIK3PWPymuH4DSWgYY8msZPWBoSsrR6a1Si0c4VKn7+VI8OIV51smzJVjoln4xslaPEO/lGxnCz9Pdrg1yJ9bNbGttmqk+7xywYae2KKZHY+W/mLd1VDAn1fMMJ4rB/eiIm6w9dBSWkqRqfGhy3PSnPREq+LwcQr76vAoKYr03IKdqCs9cLqozW2j+Iri33SBwCQLwtiWeQYckrXHJtYsbOHjdIjwUpsG4zOGHG6gHrtrdDrT2MO4mK+koD2rcE5u17hSGaJpKEiUvLlcdfdKVsoXw==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM7PR04MB6968.eurprd04.prod.outlook.com (2603:10a6:20b:dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 15:33:53 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Thu, 9 Jul 2026
 15:33:53 +0000
From: Frank.Li@oss.nxp.com
Date: Thu, 09 Jul 2026 11:33:32 -0400
Subject: [PATCH v5 03/10] dmaengine: dw-edma: Move ll_region from struct
 dw_edma_chunk to struct dw_edma_chan
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-edma_ll-v5-3-e199053d4300@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783611213; l=9141;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=cj4nbH41Ro3oOo3R3LkUC+mTEQB5fEKv1fz84+0ptno=;
 b=DTWw2KSB5dn8VZid5I7Im/Zi1R+YOcMnSoHoS60KbniXjRDKFNxpiSN/vplzT909iluCTeu92
 rpHwXjfOhTMDUbAeQzlhabGaBvxAG5RNtpmH9/KpLydgidL+MSalFyV
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA1P222CA0187.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::14) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM7PR04MB6968:EE_
X-MS-Office365-Filtering-Correlation-Id: e62865e7-3f99-4471-be17-08deddcf7b22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|19092799006|376014|7416014|1800799024|921020|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	NDW/CkXstcvGu/22a9veHVuy3iVOXFVwP6xlmoLsMTWQj9SnOJVT6qrm2N8J9LOxsnCJNLRdK4Sqao/RpTLnvnv2ftHjspH7CpkCmllH8FMyYc2oUCPQOCR0iyRhU65lwuAgfjo/MTvK53dICCUbcJUouX9wFzM4hw0tB50UBDLmIkWvVe8dPGD5nJx08YO7Dk2WTzMVrze+paKpEITiwL9XAUG4ifShiivku+69V3p/AOL6dRMg94aMBeYsgmO59I3rbMLU6DgX/sOETjFh95iR8deLZs4UbBoz+7V9D+jtGfO7cog4Ajt/u7V3XtuvfWaRIFrzjXobl/ufJqeq9oRiMQs+Im1ytneTbYpoEZN5522WE6b1m+hf/1sZkJgrw14m98iHkYi3mFUgZUd5GFs3F18vq3dYCC02r+c0mP6nLRft3wt/xaV8YcXXBFCNUdb+unPt+JFlH8YtVtO7N3Cx549IlrFzAoY1awrhceyF+3HoB8BYn1VJ1wFSW1ziQGqnkftrn/ne5ylFE2hu9BNax/q51ebpkQxStLdlUmCIchDXHWAjnRLLluYAzJD4uH9SJWEkjgk64fYwuQBKG7TU9f9Crs+0z6aChVZi2LFbaHZPa5xZpusBg4rFHWDw4Y2TxI3cVHjJIT+gWWzdNWiEeapgtquGmJWwwCow47RGTgSDAb/F1oVO9MZh6B9O9+cFkL19JXkU1dE/GKwKNQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(19092799006)(376014)(7416014)(1800799024)(921020)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TjJTT2xkbHBUT2xJcmlGTDMxTEZnNXhWL3dWa092V0ZRa2QvS2V6WmN2SjBB?=
 =?utf-8?B?Q0VUL0dWMXNmTzBiUFdkVzJlMzBxU1NsdUlpWDFaWGNPcGF5ZkQ2U1lYU2NS?=
 =?utf-8?B?K0Jib290Y1J1N1VMN0VpVUp2R3YwRDZEanBCWlRyZmNsZlBCbzU2SS9hS0lJ?=
 =?utf-8?B?QytiR3lVVUU0TFBUdXM5UGlYM2h5WXVmQXFFNTFDZXhqdlpURTZNeXMwNmw5?=
 =?utf-8?B?L3l2aGhIa0cvekh6a2M4QTd1eXlHZzU5NTkrOXRIRE5IY3BHWjhZRzRycVlH?=
 =?utf-8?B?cTZnZUFOWmRUS2xDU0lOOW9GQWlNU2dFVHNGZ3FITG95Y1dpT2Yrd1BZWld0?=
 =?utf-8?B?QVRJQ3pIQmszVFVLUFEwaTFncWo1QTJzbEUrUXl1QzVOczlLY1BpWnVBblhz?=
 =?utf-8?B?YllXV0Q0M2NqUG5WSU5nb04rdWtsUER6Q050YUhSeU5waUN6OXNaVHg0SDBx?=
 =?utf-8?B?ZTJNdWw2UDJCWHMxbEFNQ013NzBmTXgyS0g0bjBiSGRXVjRsTFY2NkZlOTh5?=
 =?utf-8?B?VG5iSzdTdzRjL0RYU1lVYkE0NGpRYWQ0ZUZDblpkTHh0YmNhVVFtYXZiYlVn?=
 =?utf-8?B?WnlHZFJWMUhmMHkwTC9JZjRBSllnaDRCOVZWVko4ZklyUFhOZFVRTlBnb2V1?=
 =?utf-8?B?Z3hSMU1nTlRuSXNzZStmWVdZY0dpNnBGb3ArZW4rNDRGVmVBNzV3bm0vU01r?=
 =?utf-8?B?REptT0ZNcVlrc056WEdCZHpMT3V3MGJGUG5tY3BMcytPZm11L1JPV0ZjNDNh?=
 =?utf-8?B?UXRyc2Y3aXZpNC9md3prUEpwZ3l1SERVZTJ4U3F4ZkRUUE9PL3hIaFZiTWww?=
 =?utf-8?B?eXdQb240VUxXOGUxTlN0KzQxNkw1eU5pZHRIa2RFcDA3c003NnhHbEVPUVo1?=
 =?utf-8?B?RFNlVndOWDVjMnVmUCtndWxrV20xeWxBb0d2VXEwa0ZaZ1N3YlJOK0xhei8r?=
 =?utf-8?B?RmgvMUxJcHI5SVcxUVpsQTJ6eWxoSnRzelU0c3JWV3p2Qm5zeEVGZ3dxNnFO?=
 =?utf-8?B?T0t0SjNIYW1pazZvNUJ5cnJGL1dCQVdURDhlTTV5ZVpaS1JOVUpuRlBLRWdr?=
 =?utf-8?B?ZmtxNExkMnRWLy9wc0lzNFFUM1MxSmNEZkxsdVNJbzc4ekE0ZzE5Y3B3NTBm?=
 =?utf-8?B?NUFBemh0QWJJWWJyZ0hISDlDK1FGd1BOUVJUVElZVzEvWCtQdDJ5ZWorMmQ5?=
 =?utf-8?B?akZ2L2cvWmUxMUlQVWxvNlpTZ1ZYTnZqYWJjQTFocVlyQUVZc1VSQUxWM1RP?=
 =?utf-8?B?UHpRa2dkNXdKQ2V6WDZzQVJEQ01vbElLalV5ZE5OajV4UFFBVmk3VUpub2tG?=
 =?utf-8?B?emJoZEtmWmlCTnN2RHZRc0NKZHhwblMrRW9ET2k1cTBMSnRNVUY0SFJobEUr?=
 =?utf-8?B?WG5Qb1lsUGNGcVNQK2xCUWZQclBXb3VVbEpQZmduMjcyWmpaQjBoYUt6cnNW?=
 =?utf-8?B?bkNRU2JUc1VGNlh4TDhmZTlrY0toOGVUb25wR1ljZXVaZlZZQVdUYkxTbE9O?=
 =?utf-8?B?WlRGTHFVMVprK3BvU0hYdHRMcEtYbnYzRW4zei8zN2RMdjNzMkJtWkpFSlll?=
 =?utf-8?B?c2hXdXpHbFF4MHJTVVdSdENScXNTbFgxV3JOaHpYaDhndDVjV0xtV2R2TXdG?=
 =?utf-8?B?WjZzZnY2ejA3bUZRUHFCekdSOEMzQlR4U1F1eFJOWjBmWktqWHRyNjF3eUJQ?=
 =?utf-8?B?c29UL2NNWkNiVTZJdjEwSXJZUHIrQ282MzR1ekxqcEZJR2pkNy9uSEk2c1dx?=
 =?utf-8?B?U09XdTh5VERhbFZtL3pHQlNVM1R2bTkwYWplZ2VWYmpEcGJQOFJQMUsxcmdH?=
 =?utf-8?B?Nm1iNS9BVE9zKzZOZkxWaDBJZis0NjQxU2htYlRaYXpYNE5NVFI1dk9RNlIw?=
 =?utf-8?B?QmNMZS9MbEhYbWVKK2xEU0prWnFnQmZqSnc3eDU0cm5QTE1tTTU0UWxwd2pP?=
 =?utf-8?B?djlDMldMZFdNOUluQjVSdVpWT1pmcmhsR2MySklBZjVJb2tQaGUzYWF3eEM5?=
 =?utf-8?B?SkYzdHg3elgxam5RRHE4ZFl2MTF0Rjc5NDQwdXVYZ2Uyb2hmLzE1UXdDNU1n?=
 =?utf-8?B?TEVURGo4bEtmZ1lsRi84UDhkRUJIK2dTSGZqeUhMQUIxclhUMGRsYk0yazd5?=
 =?utf-8?B?Q0NCcG0vcjlYUDRtbnN0V0ZSQnVUMFZaeTdPMFZtWXZ5dDRReWM4ZzJWZ0Uv?=
 =?utf-8?B?VzNHUC9sTHpIOTRxSkcrQkxCcVRmTTdMczVDbzhDaE9LRE1EOXlLSGlHNFNG?=
 =?utf-8?B?eDg5WS9GL01QK2orOWtLdlVCbzNLeEU5R1ZQLzlXZ2NHTlNEcFQxbXZFQmJX?=
 =?utf-8?B?V3pPeWp4blphVzg5WjNRT1JTQy9kTy84eDhWbHRFNTAzY1M2aklhc001YnN3?=
 =?utf-8?Q?p0c4LTs/PIOFlFHkg4CDM1TzuWhufh1e82eu6?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e62865e7-3f99-4471-be17-08deddcf7b22
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 15:33:52.9190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RfLN89EYD5R0VIjiY+9WPYq069QdKFCPsle+UXgUQPrdAWOLrc8Ddg6IANIQg2b8OyaB7UW1rvHm51XsoY8wbPWibR401P+OQKGmEblYKlmdHWmF2unF/erbKqk+B0JQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6968
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12241-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.nxp.com:from_mime,vger.kernel.org:from_smtp,nxp.com:mid,nxp.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,NXP1.onmicrosoft.com:dkim,valinux.co.jp:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 17F327331B3

From: Frank Li <Frank.Li@nxp.com>

ll_region is identical for all chunks belonging to the same DMA channel,
so there is no need to copy it into each chunk. Move ll_region to
struct dw_edma_chan to avoid redundant copies.

Tested-by: Koichiro Den <den@valinux.co.jp>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v4
- collect Koichiro tag
---
 drivers/dma/dw-edma/dw-edma-core.c    | 15 ++++-----------
 drivers/dma/dw-edma/dw-edma-core.h    |  2 +-
 drivers/dma/dw-edma/dw-edma-v0-core.c | 18 ++++++++++--------
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 18 ++++++++++--------
 4 files changed, 25 insertions(+), 28 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 53469c8c8b82e..2652ad8e7a8f6 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -64,7 +64,6 @@ static struct dw_edma_burst *dw_edma_alloc_burst(struct dw_edma_chunk *chunk)
 
 static struct dw_edma_chunk *dw_edma_alloc_chunk(struct dw_edma_desc *desc)
 {
-	struct dw_edma_chip *chip = desc->chan->dw->chip;
 	struct dw_edma_chan *chan = desc->chan;
 	struct dw_edma_chunk *chunk;
 
@@ -81,13 +80,6 @@ static struct dw_edma_chunk *dw_edma_alloc_chunk(struct dw_edma_desc *desc)
 	 *  - Even chunks originate CB equal to 1
 	 */
 	chunk->cb = !(desc->chunks_alloc % 2);
-	if (chan->dir == EDMA_DIR_WRITE) {
-		chunk->ll_region.paddr = chip->ll_region_wr[chan->id].paddr;
-		chunk->ll_region.vaddr = chip->ll_region_wr[chan->id].vaddr;
-	} else {
-		chunk->ll_region.paddr = chip->ll_region_rd[chan->id].paddr;
-		chunk->ll_region.vaddr = chip->ll_region_rd[chan->id].vaddr;
-	}
 
 	if (desc->chunk) {
 		/* Create and add new element into the linked list */
@@ -925,10 +917,11 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
 		chan->status = EDMA_ST_IDLE;
 
 		if (chan->dir == EDMA_DIR_WRITE)
-			chan->ll_max = (chip->ll_region_wr[chan->id].sz / EDMA_LL_SZ);
+			chan->ll_region = chip->ll_region_wr[chan->id];
 		else
-			chan->ll_max = (chip->ll_region_rd[chan->id].sz / EDMA_LL_SZ);
-		chan->ll_max -= 1;
+			chan->ll_region = chip->ll_region_rd[chan->id];
+
+		chan->ll_max = chan->ll_region.sz / EDMA_LL_SZ - 1;
 
 		dev_vdbg(dev, "L. List:\tChannel %s[%u] max_cnt=%u\n",
 			 str_write_read(chan->dir == EDMA_DIR_WRITE),
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index db5f45bf048c3..b96089baf0f9c 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -58,7 +58,6 @@ struct dw_edma_chunk {
 
 	u8				cb;
 	u32				xfer_sz;
-	struct dw_edma_region		ll_region;	/* Linked list */
 };
 
 struct dw_edma_desc {
@@ -79,6 +78,7 @@ struct dw_edma_chan {
 	enum dw_edma_dir		dir;
 
 	u32				ll_max;
+	struct dw_edma_region		ll_region;	/* Linked list */
 
 	struct msi_msg			msi;
 
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index ee5c3c317557b..51e50f1fdcac4 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -280,9 +280,10 @@ static void dw_edma_v0_write_ll_data(struct dw_edma_chunk *chunk, int i,
 				     u32 control, u32 size, u64 sar, u64 dar)
 {
 	ptrdiff_t ofs = i * sizeof(struct dw_edma_v0_lli);
+	struct dw_edma_chan *chan = chunk->chan;
 
 	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
-		struct dw_edma_v0_lli *lli = chunk->ll_region.vaddr.mem + ofs;
+		struct dw_edma_v0_lli *lli = chan->ll_region.vaddr.mem + ofs;
 
 		lli->transfer_size = size;
 		lli->sar.reg = sar;
@@ -290,7 +291,7 @@ static void dw_edma_v0_write_ll_data(struct dw_edma_chunk *chunk, int i,
 		dma_wmb();
 		lli->control = control;
 	} else {
-		struct dw_edma_v0_lli __iomem *lli = chunk->ll_region.vaddr.io + ofs;
+		struct dw_edma_v0_lli __iomem *lli = chan->ll_region.vaddr.io + ofs;
 
 		writel(size, &lli->transfer_size);
 		writeq(sar, &lli->sar.reg);
@@ -303,15 +304,16 @@ static void dw_edma_v0_write_ll_link(struct dw_edma_chunk *chunk,
 				     int i, u32 control, u64 pointer)
 {
 	ptrdiff_t ofs = i * sizeof(struct dw_edma_v0_lli);
+	struct dw_edma_chan *chan = chunk->chan;
 
 	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
-		struct dw_edma_v0_llp *llp = chunk->ll_region.vaddr.mem + ofs;
+		struct dw_edma_v0_llp *llp = chan->ll_region.vaddr.mem + ofs;
 
 		llp->llp.reg = pointer;
 		dma_wmb();
 		llp->control = control;
 	} else {
-		struct dw_edma_v0_llp __iomem *llp = chunk->ll_region.vaddr.io + ofs;
+		struct dw_edma_v0_llp __iomem *llp = chan->ll_region.vaddr.io + ofs;
 
 		writeq(pointer, &llp->llp.reg);
 		writel(control, &llp->control);
@@ -345,7 +347,7 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 	if (!chunk->cb)
 		control |= DW_EDMA_V0_CB;
 
-	dw_edma_v0_write_ll_link(chunk, i, control, chunk->ll_region.paddr);
+	dw_edma_v0_write_ll_link(chunk, i, control, chan->ll_region.paddr);
 }
 
 static void dw_edma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
@@ -359,7 +361,7 @@ static void dw_edma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
 	 * last MWr TLP is completed
 	 */
 	if (!(chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
-		readl(chunk->ll_region.vaddr.io);
+		readl(chunk->chan->ll_region.vaddr.io);
 }
 
 static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
@@ -430,9 +432,9 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 		/* Linked list */
 		/* llp is not aligned on 64bit -> keep 32bit accesses */
 		SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
-			  lower_32_bits(chunk->ll_region.paddr));
+			  lower_32_bits(chan->ll_region.paddr));
 		SET_CH_32(dw, chan->dir, chan->id, llp.msb,
-			  upper_32_bits(chunk->ll_region.paddr));
+			  upper_32_bits(chan->ll_region.paddr));
 	}
 
 	dw_edma_v0_sync_ll_data(chunk);
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 1201f1ab5f359..20089d57f8ab0 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -156,9 +156,10 @@ static void dw_hdma_v0_write_ll_data(struct dw_edma_chunk *chunk, int i,
 				     u32 control, u32 size, u64 sar, u64 dar)
 {
 	ptrdiff_t ofs = i * sizeof(struct dw_hdma_v0_lli);
+	struct dw_edma_chan *chan = chunk->chan;
 
 	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
-		struct dw_hdma_v0_lli *lli = chunk->ll_region.vaddr.mem + ofs;
+		struct dw_hdma_v0_lli *lli = chan->ll_region.vaddr.mem + ofs;
 
 		lli->transfer_size = size;
 		lli->sar.reg = sar;
@@ -166,7 +167,7 @@ static void dw_hdma_v0_write_ll_data(struct dw_edma_chunk *chunk, int i,
 		dma_wmb();
 		lli->control = control;
 	} else {
-		struct dw_hdma_v0_lli __iomem *lli = chunk->ll_region.vaddr.io + ofs;
+		struct dw_hdma_v0_lli __iomem *lli = chan->ll_region.vaddr.io + ofs;
 
 		writel(size, &lli->transfer_size);
 		writeq(sar, &lli->sar.reg);
@@ -179,15 +180,16 @@ static void dw_hdma_v0_write_ll_link(struct dw_edma_chunk *chunk,
 				     int i, u32 control, u64 pointer)
 {
 	ptrdiff_t ofs = i * sizeof(struct dw_hdma_v0_lli);
+	struct dw_edma_chan *chan = chunk->chan;
 
 	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
-		struct dw_hdma_v0_llp *llp = chunk->ll_region.vaddr.mem + ofs;
+		struct dw_hdma_v0_llp *llp = chan->ll_region.vaddr.mem + ofs;
 
 		llp->llp.reg = pointer;
 		dma_wmb();
 		llp->control = control;
 	} else {
-		struct dw_hdma_v0_llp __iomem *llp = chunk->ll_region.vaddr.io + ofs;
+		struct dw_hdma_v0_llp __iomem *llp = chan->ll_region.vaddr.io + ofs;
 
 		writeq(pointer, &llp->llp.reg);
 		writel(control, &llp->control);
@@ -210,7 +212,7 @@ static void dw_hdma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 	if (!chunk->cb)
 		control |= DW_HDMA_V0_CB;
 
-	dw_hdma_v0_write_ll_link(chunk, i, control, chunk->ll_region.paddr);
+	dw_hdma_v0_write_ll_link(chunk, i, control, chunk->chan->ll_region.paddr);
 }
 
 static void dw_hdma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
@@ -224,7 +226,7 @@ static void dw_hdma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
 	 * last MWr TLP is completed
 	 */
 	if (!(chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
-		readl(chunk->ll_region.vaddr.io);
+		readl(chunk->chan->ll_region.vaddr.io);
 }
 
 static void dw_hdma_v0_core_ll_start(struct dw_edma_chunk *chunk, bool first)
@@ -251,9 +253,9 @@ static void dw_hdma_v0_core_ll_start(struct dw_edma_chunk *chunk, bool first)
 		/* Linked list */
 		/* llp is not aligned on 64bit -> keep 32bit accesses */
 		SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
-			  lower_32_bits(chunk->ll_region.paddr));
+			  lower_32_bits(chan->ll_region.paddr));
 		SET_CH_32(dw, chan->dir, chan->id, llp.msb,
-			  upper_32_bits(chunk->ll_region.paddr));
+			  upper_32_bits(chan->ll_region.paddr));
 		/* Set consumer cycle */
 		SET_CH_32(dw, chan->dir, chan->id, cycle_sync,
 			HDMA_V0_CONSUMER_CYCLE_STAT | HDMA_V0_CONSUMER_CYCLE_BIT);

-- 
2.43.0


