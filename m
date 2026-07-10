Return-Path: <dmaengine+bounces-12325-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id b8u8CAElUWrL/wIAu9opvQ
	(envelope-from <dmaengine+bounces-12325-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 18:59:45 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B49E673CD4E
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 18:59:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=C1Kk6R+J;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12325-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12325-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6480930BD533
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 16:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5007E46AF10;
	Fri, 10 Jul 2026 16:48:15 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013032.outbound.protection.outlook.com [40.107.162.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CE146AF05;
	Fri, 10 Jul 2026 16:48:11 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783702095; cv=fail; b=hF3JVq/Q0fXigUiCZPkONZvYUk9mL8h+Fb0G+t4VwGUetcX6bLkgKO1oZ9zs/oEvFDCq0rTt03F/cwcZCFEVogSCAJ32X4FGZnnFoV0/y6jePNHERRZTaF7KKsZLmncXEWA1cbPzi2l7dJtO5cIZyw/VxHH8el+rr+Hhw8vHGQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783702095; c=relaxed/simple;
	bh=qVuuMMJsQy3hIe5JuUoqdQkCzZ4FIL2qJKmyn/KfNPU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ikLL97hRngh7xmBnuj36RpNj7BTRLpRUNE5xFhFhUnYoW8I7dwdttSB9ApAbl7P4LfbRL0Xwo/lBs+US9C0srblAZ1BgXphkbNEl6SZf++xeD7gSzcWzEZRFMrK7FvKpKW2RwhnM6IbWFfBD9B8Ul0dLKY/O7x/sOXWUJR5iW2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=C1Kk6R+J; arc=fail smtp.client-ip=40.107.162.32
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oP0c5NTJajJ/3P1Un4MjZkkCxtwVBRfsrG1aHQaR6NqlpeNzWJXF2SUKQyS+rWTnoFIcgvb3PHKFYeL8i1TZlBRIJ/IUNOtXbvzt+D/fvYO5IqyWtL2VMnlgFfE/3/65j862UweKHr3zpuDVIw//QRdrA+IFiYnKUIviporDuQpfpDNvzmW4lJZL6SCeO7wPL4YY8140mI+/24Xq6ttrAm586okQQ+3G9zA9veSBv2kbDLjCpq3vbT99r67S108udijDOrWB/JrW1AFot5aFkLMGSsQEtZtCYEuH3eCSY2qu3v6sQcXcHhSooC2QSOFKciMZb0qPeczSESjWNMNT9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=htKCchOFJEB/1kcz9Ei0HvNuGZp7OR/PrXyB6wNOmQo=;
 b=e57M3qA5q03eXDzYnZtPTFzDZi9FcW6woRZnEb9dFgDuT8SCFl6EvcNM0kv7B6lOC2er3PRTShQ+KOgAbiIGMWrJ0ADczO1dNn7iHFDmAQlbIOCv9YEesbcjbaOiK6qbGkhg7zK8kuekKj4QMwvunEmNcVLCdQ2sDTXRS9l+jFecwl6sIpf5WRtxImmj4SFjOHlVJiX3YQ8jUVOofxFbI3aMszKsfUE6PXq7Abp7tee6HdlxLJiIGWF/0smOvvMqCyGbYoqqUCiiTbHhs63wa+N+Ie8gTSZHFeCn9RtjYBk3qlWVbDAEHDsiKDHr5ay5kCSYLZfe3v9UcOvc+pZeHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=htKCchOFJEB/1kcz9Ei0HvNuGZp7OR/PrXyB6wNOmQo=;
 b=C1Kk6R+Jz7wI60/Kedlzm9DyVpfP5jcXjCEMjaUILmLr+/Nr0aoYJn8WTmxVPb9tN+/aIEt2bvRWg3z8G8l4LDAqi1CXm0ilzk99jDTIx6RoaKX428mJkjQbHqjVrCv/QI8BAQE2l/cot3gQT7Tu42CszEwjsBpG2bff+cr/o6JEaDYUG26eA0bpxnj66rF+4/3BtL4t+LXUyC2O5STV2olm3V2gLGsv4UAtUvLCsviw/OIEgfPeSrf+Uz4k2pDgIQPTkp04+vcTu9LQmCUPG9l4kIsf2qSnucqHCXdwSaRYdxHBnebkrNeBZHYJh0lKFWL/W5ijgInJPJ0Prw2P7Q==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AS8PR04MB8578.eurprd04.prod.outlook.com (2603:10a6:20b:425::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 16:48:08 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Fri, 10 Jul 2026
 16:48:08 +0000
From: Frank.Li@oss.nxp.com
Date: Fri, 10 Jul 2026 12:47:45 -0400
Subject: [PATCH v6 03/10] dmaengine: dw-edma: Move ll_region from struct
 dw_edma_chunk to struct dw_edma_chan
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-edma_ll-v6-3-1471d278b73a@nxp.com>
References: <20260710-edma_ll-v6-0-1471d278b73a@nxp.com>
In-Reply-To: <20260710-edma_ll-v6-0-1471d278b73a@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783702066; l=9141;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=cj4nbH41Ro3oOo3R3LkUC+mTEQB5fEKv1fz84+0ptno=;
 b=Syn8qtZBhTE0/JkavzWMWQKOL6iSiXUuRn1XBgRkrjGAawp39WXsmBZk3kFUV/Y5J1zrmwKut
 M9fbt2M8mYAB1f3c/IZTh1A36wbnG7FZfdlFc2pi0voihhPOmFKqGS1
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH0PR07CA0033.namprd07.prod.outlook.com
 (2603:10b6:510:e::8) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AS8PR04MB8578:EE_
X-MS-Office365-Filtering-Correlation-Id: d4f43af6-deb0-4b09-a63e-08dedea3052f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|23010399003|7416014|376014|366016|22082099003|18002099003|11063799006|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	4MPRfU0HkBBCzwl/c2mrTBACRjS33XTPBVZWz3TmiCQaDVQIOI/zfnb9byvj9zkYCevGi1cIcAWRFMVmba/N+73TjMSA3IGU1I7j/3LqsoGxlnXxnD9gPnAKPgvwfmdWbdIeKChRDH/Gy2laDRKNSP6eAr7clnbsoVimarPRQ37oYkvn+rycxROcr5OIujuP9OEpQIDPRU9Z4xEQ4yCxR4cq0QZbANI1LZhJfWTK4GB2+d9X2i6pmujJOg8TS9j/5i0u7u9iznUHLmL/tFhUewg/YxdnDSjBNxzLGuWXrmi+2RFIurDTc/RjvsdGTeUKwJXhV4i8Xm6Vj23qxvmV892ACHkOmTgmclvD6D0pk5NOgSazq1s4YxUxLUm/4GPIG416sHE3MWmu01hEnD2hB59ilECceBzMLCHVwDj7F25i8YziWvgDgBl9AvWHeJgp9pvzaDMJtdW/3LuRr6D9pveQYDsP33wduLqL3KFuf+bGnTRiujyadlkjkQnzIhd139/vwPSO1VUd4E5tXHaNcLoBFbxF9qI1LJU2CpBlXjDtuOJM/nTIJtiDnGw7BVwvFKz/fgbvcenh9VNiYz3zVUPggb7ezx+bPsCw/33LEWhiIhl7YgAmIsliZtZyoCvGbabnpYOiGguTJL8C69dKIykhdwpzK4EZXG6aG4Oqt6yb5ysXnPQhKQTBKxj0Tffk5ryo7MbTcQlOAN3wKTOm1Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(23010399003)(7416014)(376014)(366016)(22082099003)(18002099003)(11063799006)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZHNuemMrRVhnTnBUb2JsMnppemNlS0drZUFWcHYrU2ZTWDJxdjZ2cjY2ZGhO?=
 =?utf-8?B?VS9YdzBIR1dmSm43enE5cHZFT1pkUWFLaVJMYnJTNG5vWlJmeU1RVTltTTVX?=
 =?utf-8?B?YmVHM3QyaExqdkVpazdRMXkweUJ3elBSQS9TRkN0R013ZEpXUGVlSHVtaUFD?=
 =?utf-8?B?elZBclFMazJxWGl3S1kvSnlqWVFaT01sTUVYcEhZQkNOa0x6TERmeERrcEtL?=
 =?utf-8?B?YWtIc21NY1ZMTkxiTnNMbk0vdHl2NGNRcU0xT2tQNjZTOEluMUoxbjN4ZThR?=
 =?utf-8?B?TWhjWDhmWCs3NTUraTFoaU1UcnBLSjZuK0E1eFJVT1JncnM2cFRjZ0czb1lv?=
 =?utf-8?B?b3BSYUk3bUg5cUcxNkc5aElXU2xKSURibW5IVWdQazJyRjZ6SkNuYjY2cEVj?=
 =?utf-8?B?REJVYTFHeElOU0xDS2Qxc2E1alJZRVVFV2ptKzZJQ3JhMWRObkRlZUVWS3lZ?=
 =?utf-8?B?YmRNZzR3eUdQNHlrenlyeEIvSm9qZlVhdFhad2VYckdTdVFPK1dwOU5vaVBS?=
 =?utf-8?B?dHhOL0ZtU1R3NWYxOXZpRU1UTm45REJZSENZc1NKN0V6UjJXckNWU0VTNDhV?=
 =?utf-8?B?NkNPRlRuTWpXdEN0Z21wNzFud3QxdW1nbHBEM3RocGpCMWxhYjE0RStOaHc2?=
 =?utf-8?B?bUlnL0xzTlBUUTFrTGZLZU5UbVJudVE0SGZHNVEzOVlvdnd2eXFORllTcDR4?=
 =?utf-8?B?ck1UY3RwK2FJOXk3Y0N4MmV2bW5qOWVpRmVMNElwMzlRWExiWlM5ZjZtdkNI?=
 =?utf-8?B?LzhCMEdsRjZib3R5eUc0MUdQRGNjUHdRRGNrVS9UY2F0OTdtSDRUaUNsNVEw?=
 =?utf-8?B?aEFuSC9EK0FUanlNWnc3eTdPem1VZGF3SXkxMitqR0laVlpHNmRhbXI4WXE4?=
 =?utf-8?B?YkVQRDhWNk5hN055OVRRQ0U5ZjRzbVJvam1ubHFkdDZZK3hINFo2eC95bGJi?=
 =?utf-8?B?TEhyS1lBSGJiaUo0dmluNFB1TnJ6U0ltRUpXZnhZVWo2NThFdjdmUjlUSzNu?=
 =?utf-8?B?SFdmU0UyN1NZbHJyZ014c0w5NC8yUGtUa3c4b3F2RS9OeG03OGFHR04zT2JH?=
 =?utf-8?B?WW1xRTBIZ3dSaDk1ZzFwV1BEd1I2dGpNc0tCOEp0OVdxV2hNUG9ZL3pHYXNR?=
 =?utf-8?B?NXBNcWR3cDczK0JxMlkzcGJpUWZqRVA1Z0VwU3VrUkxNZ1R6dnJQajdYMHBl?=
 =?utf-8?B?MVB0T28xaG5hM2dtWTljQ2srVU8wYnpuV2xYeFVKbHU0MHp4emJLcFB1Sy9y?=
 =?utf-8?B?cHJYUEtEaFVuSE1RZitaVHN5dWxRcFBPUTcwUFBWVWM0RUxRSVFHYk44Vjcz?=
 =?utf-8?B?R2FDQS9wWVVGUFJON1JQcE8reEdZUnN2alo0dkdoK3Q0Zy9XdVplWnArSStV?=
 =?utf-8?B?MXlTNnZGNjdadVc4aVJ2c0pkSW9wU1NKYWZJaHFuVmRkWnZvNGg3WmZBUG1W?=
 =?utf-8?B?RGkrc3AvSlllMXA1WkJUWmNSR3dVeUpPRm4weDdxdFdTTDhkajhwK1ZyRlFE?=
 =?utf-8?B?eitaMCs4Q2lOMU12MWIxYXV5dm1HVUljaE5BbGFoRysweEFwd0V2ZVVkWmcy?=
 =?utf-8?B?SlhRZ3NnUElRZ2JsUGhma3BzRmFqOXltdmNxbjc5SklVVjR5WHBoVU1NaFA4?=
 =?utf-8?B?dFpXWkxBSy9rMTZxMXNnQW9ZVEU4UXBoWnhnN1Rmb1pVYWhZN3ArdGFxUG9z?=
 =?utf-8?B?VVZEOTZVdE9PSkI2bWR3RWl1VVhXTlFudW14cGFWaDlWRlFScCtZbmJCdkJM?=
 =?utf-8?B?TUFoNnJOa0NYeGwyY20vbUFKUWZFVGNyUEJXRzVPSzdEZHl3blJ4YjFPQmcv?=
 =?utf-8?B?VVJIdG4yMGNFZ0IyQWdKb283SUE5cTRybXJZU0dncWo0OE5rNU9iQWFkdHdx?=
 =?utf-8?B?S1lGdWJLeG9EWHB4elE4SGdUREV2cjEyQlVuTzdDT1l1OVhzSVZueThCNEtY?=
 =?utf-8?B?Rm9iQ0k1bmx5WHRBb0E4VllzajZKcXFVRU1WamVtTy9pV29RdElubThxckx6?=
 =?utf-8?B?UTdVRnNlL2J2RFpPK2dTNTMvVDY2Umtlc2wvTkMzcG9MWjJURWZPNEJ0N1dQ?=
 =?utf-8?B?MmZDSy9KbDhnb1UyVHBvajJHZlM1bE95cWozbCs1QmFRMlBlMXYrRzlPRkpw?=
 =?utf-8?B?Tmx2YkN0T3I4S2tXbE1ncVhaRU5uRFFHY3FoQ3FRdkthd2RrN0VTaVNHY2Vl?=
 =?utf-8?B?RnZiRFFXSCtjVUM2eFNmS0ZLSDJnUjB0bkRiM0tBdXZhdk82dzlLejVXSURj?=
 =?utf-8?B?TkFERUFpcDNmQ1QzeHVKTGlLNXBhRVF5b200NER3aVpycnVqZkFwMnFiSWo0?=
 =?utf-8?B?NllHWjNVS05UamtQcStNWGFZN1BpazlPTmNWVFZoMkVBNzRTNDV5SWp2N1lN?=
 =?utf-8?Q?ZgS35iRTd7L4WfXUJ+1eKxk5OII1YFOtbSwwJ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4f43af6-deb0-4b09-a63e-08dedea3052f
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 16:48:08.3107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xruv/hPgQhasPIiTs2LOwvsxYrimO7WcuKLhfTb+o57JP/YZS36yfIOX9jKndsXoUuuGYAniN17er0taz9j6iHOXwY0hruTapx/pZj+bEkdp/OX6Aj36FRiVVa5Oa+cB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8578
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12325-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[NXP1.onmicrosoft.com:dkim,valinux.co.jp:email,oss.nxp.com:from_mime,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:mid,nxp.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B49E673CD4E

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


