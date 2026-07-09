Return-Path: <dmaengine+bounces-12248-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id M/9IDnrBT2qfnwIAu9opvQ
	(envelope-from <dmaengine+bounces-12248-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 17:42:50 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 862837330BD
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 17:42:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=GWBrPlW1;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12248-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12248-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5CDCE30FC735
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 15:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0948423A9D;
	Thu,  9 Jul 2026 15:34:33 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010039.outbound.protection.outlook.com [52.101.84.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A6242643E;
	Thu,  9 Jul 2026 15:34:31 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783611273; cv=fail; b=TvteMTT0ca3iIIrpdect21wH8aTsv0O0yqYd/2fu+is5z5PqYngUb6NeROPM8k1dmUnoIJ+utvbWhRMJ1z4ans79EO2Gf/UlgcKBD2aTpPNz19XM/dEeL/FKWEhP37Lqy5kXvzjzS/aa3dWTspAU8/ydQbFabaiQR4gSIh9f9O4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783611273; c=relaxed/simple;
	bh=yR31N6LLfxwo76EPOBoQeN8bEUyPj7wWmnEUBJE46MY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=bUfHNr4lsX3QA9LoorNvqRwwCahpK4XB2Nc6dkwtdrCVvC8IRlazOFpmEBAwA5+dVh5o4JW0/M5i473G1Fd8OyEroRtGnphHblFnBd2DLTV/or8U1+W+5OksF4dPDHXqKhNeyqZ3ZiDS8k5IzolSb1daJJbzn9hPFPBxqw05DHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=GWBrPlW1; arc=fail smtp.client-ip=52.101.84.39
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fimnMF4/DgC1t5Ro/5av5+zuZSgjslgLZjj2gIG3fV1v7T/GOm6+UYU4fcXUYKbE1bfJ7bIPCB99uAiQRRrns/KLB1jBgpBf2wTtc3uec4EaflYo3NLmjRdV/IGi//Xc08Oxdpc8RbVuyjLy/+vGJzxkL0ytGPGqG+AUc7qYr46ojMBOSgEFbkqhInQmTDJ6266n2QHryrDlg+TfVN5aJOaPke4fWBJ7ONBOJQDpuufHHyOMlx5o4CXPVscfxywxVxtKW25Y4VE9FZNKz0X+epEA8kXJAIEghYnpNSHjYV3M2vabDuLJYCr2RdBY18h8pkBIl4cl5htRAvcHUtHKXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tGW8rcMOb77/RR4GJVv58XHusp4homN8Ty3CjAJCKK8=;
 b=N17OWeTGCCXmt9DMgsEAb8G9pNs68E1wGNdJs9xZlMjwCebWym2CgYEl8jlYALfw0NyJfL2HE3ITREOO9/89DBQNUYP64vnVjz1Bfm80Q6q1nxIXz2CQbMUxhDMSjs1Xevd/nOWoWNnKGkV+xl3YD/3mQjtFzcJmINXXrmrcIrtJo+S4zMzqGwKd1FoLMyHO2qqw8kRs+ctbNKA8crZiFLRR3ZGA5B761kIdPvKZ0UY2gofd79nhNWoTemw9AyUcLm4Q6UKZ9ULhNA/5Thfr4u1N+IgDdYVT4iB14GM7y/VKHCDUbBYl1177S/r2VgC/T2wy0H/okCz74e4WzzV+qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGW8rcMOb77/RR4GJVv58XHusp4homN8Ty3CjAJCKK8=;
 b=GWBrPlW1v9Akwtrmahp34ADA70IIgW7My/h1IFkAkndhRVSy3h7AAHXHB6PARDb/Lp9F2z4agSQxQ92f4/y///1QDtZmamI+J98D39lwLQxnm9X4ElBV6TTngHGDktmCvCJ3CFdeyZtss9M9YN/U4z3Okn+DzILrEjJp8m17D21GXoqJglduz8akseYbg/u+rqMUtNyZnBXr1Q9pPAaW0eWtbsKAQo88jed8UCyfMTeI3y9zaK06Glpp1hqkZOw3HAy4nGXQlrM3ZVyXIncRqimnLUU4FZ7OV60cxbKGHUJRhlc7qZh+7Sv8Ug7UpadRGbt87i3q/3WDAt24Emmt9A==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DU0PR04MB9466.eurprd04.prod.outlook.com (2603:10a6:10:35a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 15:34:27 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Thu, 9 Jul 2026
 15:34:27 +0000
From: Frank.Li@oss.nxp.com
Date: Thu, 09 Jul 2026 11:33:39 -0400
Subject: [PATCH v5 10/10] dmaengine: dw-edma: Remove struct dw_edma_chunk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260709-edma_ll-v5-10-e199053d4300@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783611213; l=10338;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=ZC8WCHV+EziaHQWFsFY8WXU3Nd3ZKQjul7s0QI3Jsf8=;
 b=nOrxlVc5k62UkBcdaLO1jjGT7QGIPAqwRADzU8w2NabC0idBQnmQ8NCLFpLrUhyGv17rYnUp5
 u2R9seixUhtB7zlPF98+2FvwoLgO/5shmDlT76ZrKD53jT4V+nNRU5W
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH1PEPF0001330F.namprd07.prod.outlook.com
 (2603:10b6:518:1::a) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DU0PR04MB9466:EE_
X-MS-Office365-Filtering-Correlation-Id: b1c31613-57c5-4224-406a-08deddcf8fac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|19092799006|366016|1800799024|7416014|376014|56012099006|11063799006|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	9eTeIYTb2bPlzOnKNOhXGgQrapaykryOBxYh666EeL7F1SsveQcEwT9W0migtYkYd12P9jJai/hQoGEl7o4c/1COuR+1cGTh9lXSUGCz3EpNa3FHbmqIkCsD5TDEC5/B901KdI4RkLJ4Y1De4FVs+pVM0aaDosNF1OxY2RzTT076q6nNPAnwDo6sjIBptJo6LkqKEGtweneBTlWONPA/YekU04RZrrIvi3FJXjgDOS+yFZxxlrLneGRD4Yvj5S7ENHdQoPiW1fPQl6JZi/GP8dKZbD5sTGl8JZVRkbo1jNqlUA57ksFGVydgZ3MdI83TmQjF3G3QtCWGqOj6jjFgOSqxU3SwRMejszwiHHS8E4lx+k3UKizYjH7o3CMsaVjC4wsR12HieoI2glLSnltvb6QiJOVD2gACW64SFnDRrxVf8QlW2+vIr2Ta9MNcnBeD8bZvWr0GGuxX1w/22FGkPI4Mg39HNPbrdH+LpaJM5TpErWjEVksZGIt/UBypglhsojWEouB/N5h9LKlTePOvV0ankuDk9TJXB8meuDEYXeq0O0PV0kXKxPrlniqE8LFZG9AdnBygRw5kSqlJmCZmXMVYDauydb0k4UfSRUctrhrZ2IV9ES+5tijR0276HLvttD4bCNsj36bliFq/ehDqAOAXNTUGdn+S7h246vrz0yUFP7w4P5dm62Dli/8uVN+IpLH41bj2dTjY4E+7XZi1YA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(366016)(1800799024)(7416014)(376014)(56012099006)(11063799006)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N21BTGxaaStpMTh1dzFvZE56M2hLVXFRNUc5eTJNZGt0WUJsNE9qeU9pQnkx?=
 =?utf-8?B?WEtFQUtkTTdtY003MDdIb2JBeEhpeGtMbmNtUHl6SER4aW9mNWJnOENkQWVn?=
 =?utf-8?B?MWt0MkUrdndaMnhKY0FRM3E3WVQ4RG9KaE1iTFI0aWdQUmgxMHVzTzhkZTJG?=
 =?utf-8?B?U0NVM3ZZMFdDVytCcW5MRmljYnJCTGlLYUZPN3k2ekJFeGIwZU9QeFJSVEtY?=
 =?utf-8?B?cXVZak5VVm1NdFpFa3I1Z1ladGVZZVhrWFN2RjVkZnd0dXV3SzRpYkpXRW0w?=
 =?utf-8?B?M1hidXByVWJuWVB0R0E0dFhDd1NpREF6a0t5Mzc4ZVBvZi9YQ0pGNnNKZjlu?=
 =?utf-8?B?Nmw3WjlNQk9id1VLY2ZyYUJyTWFseGZKNThpVXdpeVlUODFQdFhCc09nM1ZF?=
 =?utf-8?B?dzJBZ0RFS2xzdVRremVxMTY5eDdXa052RThKZUxQUWIwa1ByQUE2ejRiZlJl?=
 =?utf-8?B?dUFGMWk2RGk0Y0FLaitkbE5Ea3VYai9XWkhKL0pjODJTQlB0Zk9SQVl2KzNj?=
 =?utf-8?B?VHB3WjRvRk90TGNxOVFzMjkrQlZaSmFmaEZDWTdnb3BKelk4cE1ocVRRZUZM?=
 =?utf-8?B?NjFmS3M3UmVHYWtNeDU4a2llb0xCSVg2bmt5ejdqa2lDU0Q3VERJT1lwdUxK?=
 =?utf-8?B?ZTI0b1U0L2k4TitJRVovSjlJTHR6YVIzRnJaa1RxWHVEWHJWajdUSk53bFdw?=
 =?utf-8?B?azNxQzRsT1BYaW1QTnBKR0wzUnlNUldacGFLOEpxMUxBVWV5V2dwSWpMbDR0?=
 =?utf-8?B?Yi9mQXlrVWFiUnJiM1JGcFdaQUlJaFMrNU8rTDRnNVRaRUllU2pkdjVDSnlY?=
 =?utf-8?B?aERBZUFHMnBqMXg2ZFIwdmNDejBNQm44MEN2eGpUTFhKdjh5YTl5ZXVDRERw?=
 =?utf-8?B?dGV4UWVYbUJPb0J3S0x0YkRiOUtIWkVZMzRMUXR4SFVvdWVSQi9HK21Sbmp4?=
 =?utf-8?B?ZzdDOW5aN1RWcVdoMklDa3QzeXVYaTA1Yk1uay9wL1ZiUEZHZE5RbHpZWDJ1?=
 =?utf-8?B?SkxZSlY5ckFPVEgvZ2hOR3o0WkxDelV1VmI5SjFUbGhaanZ1bVNrc0NkZWNV?=
 =?utf-8?B?Y083SEVkV3lBdUFDWUZQdXphU3BESkUzUWFDQ2s2b3RSQkp3bUdKQUpES0NS?=
 =?utf-8?B?djZvcWh4WWVHaUgwQXlnRndBM0wzbEtHbE5Ldy9tSG1yOVhEZFBZa2F3NHFE?=
 =?utf-8?B?YmViQnR5N2dZcFMwMFJCNUNQNW0rQ0I2U1JYd1F4UzlPQWRkeHNVVTYvbjM5?=
 =?utf-8?B?ZzBnRVM0UFVjRUZDYW02VDJYK2xlZ3lzQ2hzcXNMVGl4OW44WU80MktUWnN2?=
 =?utf-8?B?KzMweUJ4NWhmZjE2YmV0ODNlVzNTd1BuTFZyWktQV0kwVkxxTEJjZTVXYzkr?=
 =?utf-8?B?VEZmTkVGTEpjYXkwMDIwUzJIWERmdmk0LzlRSHJ1TnZTNnZGRzJydTh2YVIv?=
 =?utf-8?B?RnlSZllkMC96SXBzUUpoUkp4Qk9Gd253UTZnWmNMWlB5UTdLblFjUEZwOUtv?=
 =?utf-8?B?WlFCak8rQXJOZUNRWkU1V1BidmJhbEdlbm80QnorN3RQQ2xRVkR5c1VYS1g2?=
 =?utf-8?B?UTZwU3YxSjRiTE9FcTNQMElCa2o0VGJGcEIxTHY1NHJ6Y0hWdFIyMDgzQVNo?=
 =?utf-8?B?TzZpUFNXZ0paSGx4Wk9NQVB4cTl1TGMwU0ZOSzl3U2R2eGZnUXMxWXhvR01v?=
 =?utf-8?B?dC9QbHVFRFYvSS9IMmY3S2xGZi95ejlpWGJGQ1RqRW05bVBkeStBT25TN0Fv?=
 =?utf-8?B?N2p2VjFyeGp5KytLQUdyVCtuaEQ3ZE9WeG9LY3gxdEE2Rk5IV3hDU2RSd0M5?=
 =?utf-8?B?cWNBY1I1RUZKeW5HMWJjenhlbDNxcnh3OGdJT2w5akJyeDVrVkcxSVhnR2NE?=
 =?utf-8?B?Q3JHT1ZaNEtLR25RZWQrNlprSXNoYUpvWWh1M3ZnZWsyeEZjQVRIWlhSeXRy?=
 =?utf-8?B?UjJuQ25kcnNXeHhSbGQ4TmYyYnRCYWVKaUcrcUgva0pZZnMzT1JVdzN3YWpX?=
 =?utf-8?B?cVBBMktLeS9jTGROM3U2cHBRR2lpS1pZcm1CNUIrRGpCNzF2SFJPTzlTNC94?=
 =?utf-8?B?b1Fmakw5cWNhM2hIZWhseG5tTDBGM1dxZ0tTalduTkxnSUs4SHhGcHNxNEdP?=
 =?utf-8?B?WlU5bzBrR2pKUkl2YlpEd0hCMVQ0VnZ2TDRjalAzZ2NSL1VtdGR6UkY1bEZm?=
 =?utf-8?B?eDVsUGhZdE0wUjk0WDhQWnV1TjAreFBIT2pFU29EUFkyMisxNXpzVElMOW91?=
 =?utf-8?B?WEh5c09RTUFRV3lrRzVSRHZrVGlTZVpOY2ptSUhoTUxqOWN4TERZSVFWdnV2?=
 =?utf-8?B?Y3VYTVFjMnlvUWxreEZJMHNpNlVtZmpXb3llR2hKb3M0Q0NwekRNSzZROFZr?=
 =?utf-8?Q?M5CdIJju2Ptd+QkLeFaKeMVurdirzG7ktw4J5?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1c31613-57c5-4224-406a-08deddcf8fac
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 15:34:27.4945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QLqeO8BouQ5XEAYsqAkbQBg2mXIWQ/iHrC998EN8V6dGcQVrJk8k/jss7K52gWaLpX4TjQHrBJZH+KbFm4+EejQOU1JhO3j7T5/l6DSTi5YnzapudQeq0KcJcGz0qAG2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9466
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12248-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,valinux.co.jp:email,oss.nxp.com:from_mime,nxp.com:mid,nxp.com:email,NXP1.onmicrosoft.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 862837330BD

From: Frank Li <Frank.Li@nxp.com>

The current descriptor layout is:

  struct dw_edma_desc *desc
   └─ chunk list
        └─ burst[]

Creating a DMA descriptor requires at least two kzalloc() calls because
each chunk is allocated as a linked-list node. Since the number of bursts
is already known when the descriptor is created, this linked-list layer is
unnecessary.

Move the burst array directly into struct dw_edma_desc and remove the
struct dw_edma_chunk layer entirely.

Use start_burst and done_burst to track the current bursts, which current
are in the DMA link list.

Tested-by: Koichiro Den <den@valinux.co.jp>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v5
- fix double substract and done_burst -1, found by sashiko AI

change in v4
- fix loop condition check in dw_edma_core_start(), found by sashiko AI.
- collect Koichiro tag

change in v2
- remove debug code
- move "residue = desc->alloc_sz;"  in if(desc) check
- keep inline to avoid build warning
---
 drivers/dma/dw-edma/dw-edma-core.c | 143 ++++++++++++-------------------------
 drivers/dma/dw-edma/dw-edma-core.h |  24 ++++---
 2 files changed, 61 insertions(+), 106 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 01bee22fe3b3e..30b034a94a815 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -40,82 +40,54 @@ u64 dw_edma_get_pci_address(struct dw_edma_chan *chan, phys_addr_t cpu_addr)
 	return cpu_addr;
 }
 
-static struct dw_edma_chunk *dw_edma_alloc_chunk(struct dw_edma_desc *desc, u32 nburst)
-{
-	struct dw_edma_chan *chan = desc->chan;
-	struct dw_edma_chunk *chunk;
-
-	chunk = kzalloc_flex(*chunk, burst, nburst, GFP_NOWAIT);
-	if (unlikely(!chunk))
-		return NULL;
-
-	chunk->chan = chan;
-	/* Toggling change bit (CB) in each chunk, this is a mechanism to
-	 * inform the eDMA HW block that this is a new linked list ready
-	 * to be consumed.
-	 *  - Odd chunks originate CB equal to 0
-	 *  - Even chunks originate CB equal to 1
-	 */
-	chunk->cb = !(desc->chunks_alloc % 2);
-
-	chunk->nburst = nburst;
-
-	list_add_tail(&chunk->list, &desc->chunk_list);
-	desc->chunks_alloc++;
-
-	return chunk;
-}
-
-static struct dw_edma_desc *dw_edma_alloc_desc(struct dw_edma_chan *chan)
+static struct dw_edma_desc *
+dw_edma_alloc_desc(struct dw_edma_chan *chan, u32 nburst)
 {
 	struct dw_edma_desc *desc;
 
-	desc = kzalloc_obj(*desc, GFP_NOWAIT);
+	desc = kzalloc_flex(*desc, burst, nburst, GFP_NOWAIT);
 	if (unlikely(!desc))
 		return NULL;
 
 	desc->chan = chan;
-
-	INIT_LIST_HEAD(&desc->chunk_list);
+	desc->nburst = nburst;
+	desc->cb = true;
 
 	return desc;
 }
 
-static void dw_edma_free_desc(struct dw_edma_desc *desc)
-{
-	struct dw_edma_chunk *child, *_next;
-
-	/* Remove all the list elements */
-	list_for_each_entry_safe(child, _next, &desc->chunk_list, list) {
-		list_del(&child->list);
-		kfree(child);
-		desc->chunks_alloc--;
-	}
-
-	kfree(desc);
-}
-
 static void vchan_free_desc(struct virt_dma_desc *vdesc)
 {
-	dw_edma_free_desc(vd2dw_edma_desc(vdesc));
+	kfree(vd2dw_edma_desc(vdesc));
 }
 
-static void dw_edma_core_start(struct dw_edma_chunk *chunk, bool first)
+static void dw_edma_core_start(struct dw_edma_desc *desc, bool first)
 {
-	struct dw_edma_chan *chan = chunk->chan;
+	struct dw_edma_chan *chan = desc->chan;
 	u32 i = 0;
 
 	if (chan->non_ll) {
-		if (chunk->nburst == 1)
-			chan->dw->core->non_ll_start(chunk->chan, &chunk->burst[0]);
+		chan->dw->core->non_ll_start(chan, &desc->burst[desc->start_burst]);
+		desc->done_burst = desc->start_burst;
+		desc->start_burst += 1;
 		return;
 	}
 
-	for (i = 0; i < chunk->nburst; i++)
-		dw_edma_core_ll_data(chan, &chunk->burst[i], i, chunk->cb,
-				     i == chunk->nburst - 1);
+	for (i = 0; i + desc->start_burst < desc->nburst; i++) {
+		u32 idx = i + desc->start_burst;
 
-	dw_edma_core_ll_link(chan, i, chunk->cb, chan->ll_region.paddr);
+		if (i == chan->ll_max)
+			break;
+
+		dw_edma_core_ll_data(chan, &desc->burst[idx],
+				     i, desc->cb,
+				     idx == desc->nburst - 1 || i == chan->ll_max - 1);
+	}
+
+	desc->done_burst = desc->start_burst;
+	desc->start_burst += i;
+
+	dw_edma_core_ll_link(chan, i, desc->cb, chan->ll_region.paddr);
 
 	if (first)
 		dw_edma_core_ch_enable(chan);
@@ -125,7 +97,6 @@ static void dw_edma_core_start(struct dw_edma_chunk *chunk, bool first)
 
 static int dw_edma_start_transfer(struct dw_edma_chan *chan)
 {
-	struct dw_edma_chunk *child;
 	struct dw_edma_desc *desc;
 	struct virt_dma_desc *vd;
 
@@ -137,16 +108,9 @@ static int dw_edma_start_transfer(struct dw_edma_chan *chan)
 	if (!desc)
 		return 0;
 
-	child = list_first_entry_or_null(&desc->chunk_list,
-					 struct dw_edma_chunk, list);
-	if (!child)
-		return 0;
+	dw_edma_core_start(desc, !desc->start_burst);
 
-	dw_edma_core_start(child, !desc->xfer_sz);
-	desc->xfer_sz += child->xfer_sz;
-	list_del(&child->list);
-	kfree(child);
-	desc->chunks_alloc--;
+	desc->cb = !desc->cb;
 
 	return 1;
 }
@@ -337,8 +301,10 @@ dw_edma_device_tx_status(struct dma_chan *dchan, dma_cookie_t cookie,
 	vd = vchan_find_desc(&chan->vc, cookie);
 	if (vd) {
 		desc = vd2dw_edma_desc(vd);
-		if (desc)
-			residue = desc->alloc_sz - desc->xfer_sz;
+
+		residue = desc->alloc_sz;
+		if (desc && desc->done_burst)
+			residue -= desc->burst[desc->done_burst - 1].xfer_sz;
 	}
 	spin_unlock_irqrestore(&chan->vc.lock, flags);
 
@@ -355,12 +321,10 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer,
 	struct dw_edma_chan *chan = dchan2dw_edma_chan(xfer->dchan);
 	enum dma_transfer_direction dir = xfer->direction;
 	struct scatterlist *sg = NULL;
-	struct dw_edma_chunk *chunk = NULL;
 	struct dw_edma_burst *burst;
 	struct dw_edma_desc *desc;
 	u64 src_addr, dst_addr;
 	size_t fsz = 0;
-	u32 bursts_max;
 	u32 cnt = 0;
 	u32 i;
 
@@ -418,17 +382,6 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer,
 		return NULL;
 	}
 
-	/*
-	 * For non-LL mode, only a single burst can be handled
-	 * in a single chunk unlike LL mode where multiple bursts
-	 * can be configured in a single chunk.
-	 */
-	bursts_max = chan->non_ll ? 1 : chan->ll_max;
-
-	desc = dw_edma_alloc_desc(chan);
-	if (unlikely(!desc))
-		goto err_alloc;
-
 	if (xfer->type == EDMA_XFER_INTERLEAVED) {
 		src_addr = xfer->xfer.il->src_start;
 		dst_addr = xfer->xfer.il->dst_start;
@@ -452,19 +405,15 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer,
 		fsz = xfer->xfer.il->frame_size;
 	}
 
+	desc = dw_edma_alloc_desc(chan, cnt);
+	if (unlikely(!desc))
+		return NULL;
+
 	for (i = 0; i < cnt; i++) {
 		if (xfer->type == EDMA_XFER_SCATTER_GATHER && !sg)
 			break;
 
-		if (!(i % chan->ll_max)) {
-			u32 n = min(cnt - i, chan->ll_max);
-
-			chunk = dw_edma_alloc_chunk(desc, n);
-			if (unlikely(!chunk))
-				goto err_alloc;
-		}
-
-		burst = chunk->burst + (i % chan->ll_max);
+		burst = desc->burst + i;
 
 		if (xfer->type == EDMA_XFER_CYCLIC)
 			burst->sz = xfer->xfer.cyclic.len;
@@ -473,8 +422,8 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer,
 		else if (xfer->type == EDMA_XFER_INTERLEAVED)
 			burst->sz = xfer->xfer.il->sgl[i % fsz].size;
 
-		chunk->xfer_sz += burst->sz;
 		desc->alloc_sz += burst->sz;
+		burst->xfer_sz = desc->alloc_sz;
 
 		if (dir == DMA_DEV_TO_MEM) {
 			burst->sar = src_addr;
@@ -529,12 +478,6 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer,
 	}
 
 	return vchan_tx_prep(&chan->vc, &desc->vd, xfer->flags);
-
-err_alloc:
-	if (desc)
-		dw_edma_free_desc(desc);
-
-	return NULL;
 }
 
 static struct dma_async_tx_descriptor *
@@ -605,8 +548,14 @@ static void dw_hdma_set_callback_result(struct virt_dma_desc *vd,
 		return;
 
 	desc = vd2dw_edma_desc(vd);
-	if (desc)
-		residue = desc->alloc_sz - desc->xfer_sz;
+	if (desc) {
+		residue = desc->alloc_sz;
+
+		if (result == DMA_TRANS_NOERROR)
+			residue -= desc->burst[desc->start_burst - 1].xfer_sz;
+		else if (desc->done_burst)
+			residue -= desc->burst[desc->done_burst - 1].xfer_sz;
+	}
 
 	res = &vd->tx_result;
 	res->result = result;
@@ -625,7 +574,7 @@ static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
 		switch (chan->request) {
 		case EDMA_REQ_NONE:
 			desc = vd2dw_edma_desc(vd);
-			if (!desc->chunks_alloc) {
+			if (desc->start_burst >= desc->nburst) {
 				dw_hdma_set_callback_result(vd,
 							    DMA_TRANS_NOERROR);
 				list_del(&vd->node);
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 4950c57fca34f..7f2ec871f5bd5 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -46,15 +46,8 @@ struct dw_edma_burst {
 	u64				sar;
 	u64				dar;
 	u32				sz;
-};
-
-struct dw_edma_chunk {
-	struct list_head		list;
-	struct dw_edma_chan		*chan;
-	u8				cb;
+	/* precalulate summary of previous burst total size */
 	u32				xfer_sz;
-	u32                             nburst;
-	struct dw_edma_burst            burst[] __counted_by(nburst);
 };
 
 struct dw_edma_desc {
@@ -66,6 +59,12 @@ struct dw_edma_desc {
 
 	u32				alloc_sz;
 	u32				xfer_sz;
+
+	u32				done_burst;
+	u32				start_burst;
+	u8				cb;
+	u32				nburst;
+	struct dw_edma_burst            burst[] __counted_by(nburst);
 };
 
 struct dw_edma_chan {
@@ -128,7 +127,6 @@ struct dw_edma_core_ops {
 	void (*ll_link)(struct dw_edma_chan *chan, u32 idx, bool cb, u64 addr);
 	void (*ch_doorbell)(struct dw_edma_chan *chan);
 	void (*ch_enable)(struct dw_edma_chan *chan);
-
 	void (*ch_config)(struct dw_edma_chan *chan);
 	void (*debugfs_on)(struct dw_edma *dw);
 	void (*ack_emulated_irq)(struct dw_edma *dw);
@@ -170,6 +168,14 @@ struct dw_edma_chan *dchan2dw_edma_chan(struct dma_chan *dchan)
 	return vc2dw_edma_chan(to_virt_chan(dchan));
 }
 
+static inline u64 dw_edma_core_get_ll_paddr(struct dw_edma_chan *chan)
+{
+	if (chan->dir == EDMA_DIR_WRITE)
+		return chan->dw->chip->ll_region_wr[chan->id].paddr;
+
+	return chan->dw->chip->ll_region_rd[chan->id].paddr;
+}
+
 static inline
 void dw_edma_core_off(struct dw_edma *dw)
 {

-- 
2.43.0


