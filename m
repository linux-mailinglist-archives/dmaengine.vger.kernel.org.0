Return-Path: <dmaengine+bounces-10578-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGYTOnk2DmpN8QUAu9opvQ
	(envelope-from <dmaengine+bounces-10578-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 00:32:25 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FD759C0FB
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 00:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 44DE0309A838
	for <lists+dmaengine@lfdr.de>; Wed, 20 May 2026 22:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CCC3B6340;
	Wed, 20 May 2026 22:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="qvFaWekP"
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013023.outbound.protection.outlook.com [40.107.159.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3997D3B47C1;
	Wed, 20 May 2026 22:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779314465; cv=fail; b=Kd0LKNH7Lc7r+esv1SdijrDoiLMvdZ5gcxcipkzEzPx+oKU7rIu+M/i8OphC5dlWMBPfvZzkk81wdfPx5GLJ9//ZCAxitT/QxL8Qlf36YQED2+7mX7Nx2lCgpi/kYjqJMp5OlvtD5k4o2AL8ICdkWFEYIiAWyeDOOUsDoFm2aTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779314465; c=relaxed/simple;
	bh=a9A53SM+VdFB2RLFWLugieOW5hEiFRT/j6jsWD40wPc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=OZ2VFnoMTQ2OLLloyDPTH3E2TgmGD1VFwHSnwIwUcNUBg5iz9U+sZI9WSao+cu1e5HPbYZ6V6J0lQuUjcqQnZhB2xLoex4rkQYHEAmGjxVJo8MagqD3QqtOvSUtU0oMGT2D26aOIXfLIRf4gXBixs7BZlt6mNm6IzHVQbYWqqvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=qvFaWekP; arc=fail smtp.client-ip=40.107.159.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JZfJEH+z/lEWxFjue+3CSNy4GbDZZrjFI8GS6JY10xWfAm+hqYVEOWI50jRWoyWmsgVaLvh3nqA1hEQ5d54J9hCqm7Ha4TiqSaLU7Qokws50ztP5JJA58VBNk+cjmiEQqrD4/pD+84MSy9/7KDXd1niZfjI7K3fa6sZk0JPmlTPPQBKeM/+uAxkyfwjCxKIAg5mzrvV9CM5sIGcp4Kn20V/bsU6Aii7meEPdHjmVYH0j07YIG0dP9FzJNnNYlo8V7xqKhAOvoDxdpEkpVy0Qf7trL3GmISGwa+0TfQtBo9dU2XrvEhD8HzRWtqc0HE9RuKD0n3u5vqNwqw6ERxCfkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+k+bZnLmJz+9qzRK6FRbQBZKkvK2YVJRWu1DVhIt6vY=;
 b=J39EbU9SX7aDI/C6cUiAK5I0GvqBBBvIQ6VgvihPn9IrYc9dHxxbmKgQgDE2ZTo+sPR1l6ZjIWYF5p3hGqEaP/5jtOHXLuB31vyf4QxtGZ6ir7K8qjwPluuzDUjU/ZWrGWp0k8tpknQxiHllbsvHzBumX1z1aVZMbqNIt4zJSrDm2IRaq+UjU24JEw0tj3H76zU/qh5UKrnZ/t6fXZcGFkjoG6U5Udlw7jnh1dCYhNrbGq/GSxlGUxWo6OTUmqSysktbeXrLKWizgwho5u6GPq1hGV2wQ4FojnRaWCIw5e6Dx7qnGVM/MuoQbp2eV/3+ejtrcTyolqX/MEMPmxyDhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+k+bZnLmJz+9qzRK6FRbQBZKkvK2YVJRWu1DVhIt6vY=;
 b=qvFaWekPtahcU0VX+ZwE07dkglR/Up7g2bwBj/8Aj9nB/Flt3+Gutr4m2mWhovyaPfLYQysejiJ3Dy9GmvmFT+/Tuj9K5chTfbu8P0mHWLuXH8i0a9uTtWi2OSyG/j0rC917QGhcKmVgPBCoIQeqymgZy2/UQ6TN5VgquQ1aGZgm1gLwu9FD8EoQ41aGPeaX+YbdzQykLIud1RecAlpt/9ad9YhRhcHAs3Al+Q44X9q53++TBivsGa0te4kKWPgSfmD36M2oVfU94tYMmoQMknDuSlvK0E3y+2tN73bm17EyVtA+6O1Bk9FsME0+G33NMNGuOYpKy+8e29GtWHDsbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA4PR04MB8029.eurprd04.prod.outlook.com (2603:10a6:102:c9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 22:00:55 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 22:00:55 +0000
From: Frank.Li@oss.nxp.com
Date: Wed, 20 May 2026 18:00:42 -0400
Subject: [PATCH v6 1/9] dmaengine: Add API to combine configuration and
 preparation (sg and single)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-dma_prep_config-v6-1-06e49b7acb38@nxp.com>
References: <20260520-dma_prep_config-v6-0-06e49b7acb38@nxp.com>
In-Reply-To: <20260520-dma_prep_config-v6-0-06e49b7acb38@nxp.com>
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
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779314446; l=7275;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=NXX3wZLVHLdMncF3RB/2/LEEAsVKc1piFcsNx8qgrf0=;
 b=odHe+BxhBCP6XqvwgHNFtrEPqaGDDpAgBFsbmxghyYU3q/ZdEFjmLgfyoeVnOk2+9MdJIkof1
 bunfyzWci6RDoT/Rpq3UHqcZludGVh2ReCfQewP0VcovkrvEU1A3mdJ
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SN6PR05CA0031.namprd05.prod.outlook.com
 (2603:10b6:805:de::44) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA4PR04MB8029:EE_
X-MS-Office365-Filtering-Correlation-Id: a0fcef8d-7e08-4b4e-385e-08deb6bb43f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|19092799006|921020|56012099003|11062099010|18002099003|22082099003|11063799006|7136999003|6133799003;
X-Microsoft-Antispam-Message-Info:
	15oHdwxFd4MHPCo8As4Gg8Luzu1uynqkY3DKApqHSsFow3PGd8hqbJPI04Sldz17LtdKD9d56/nLNGFk9dIsahh4+SKDcHl/pdmupoaFBp65tTxWB7acgiMG1dXO3Ds7RrjCSH4nEPxFu16PDVNqC4i7ydCxMg16dUSt3ZvoS5IY6J9T5sVG+QV5lKvJ3u00RN3KJPkajhuALWmLePKrRmox97r387SfRWuI1mVBy1wfSX2hiJ1gFjdysKNhEoI116YiOn4iyIyNfUTJfnBDYo27JtB5gpTcbKoac8Ps5mlSSmPhx4uLQIVQdLHmd0Rji1rR6TKGCky3Hoh2tgkxhPS1v8cx/fbI1ViyAILtgp5WjI6O+myrvPO/tHDv+jys826ykbQMVctxbQmuK5GOmjlLaI2zEJPsG20QkbU7WEP/HYdLzVPNAVTzl88d6lyrzTE8PjKyieAGf19m2aX13lvvcA9tQdX+578YGxdO7HptmMK5GK6BhZbfHtDG0GFt2t3qUyqoNsTzPZG0vPkhWR6ju8LIxLLh0fY4/xr4Y4cZDKnoIJvemkwAJ4F8QCzAtKUb5fG2L6+Xw0dEwwVOnzMuuTBHUhPIiJ7Hx9p8ROM+coc95mQykdjn3IA+l+DeVTuHJJvNjZWxgFQaguKpGXJyKMGgYxx1m7mz42hNTOCnkmy1WcJcZ75Lz0ZtRXwmzWdAuS2hcMbdBfZhs11zZHCU2C+ymGQl2Vr8AuzAgMs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(19092799006)(921020)(56012099003)(11062099010)(18002099003)(22082099003)(11063799006)(7136999003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bCtjTXRXTjRQSmJqUEZrMVVXZXZBQjVvZlk3QUJlQkVGUXhVeExtK0ZkQUM5?=
 =?utf-8?B?Z0I2bnBuNVJydUJFRTRCMXBDMFhxQ1BEMDRnTUdwODNRVUJjWmt5S28veGRT?=
 =?utf-8?B?blhhM1JOVTg1NUVQMWVEU0d1YTRpZDFiVmJFTERYM1hWdEVQUC9iODF5Y2xo?=
 =?utf-8?B?VURKZEtwWHpUNldBZngrM29JcnEzYjE0eStGdEk5ViszeE4wWno0ZXVaR2No?=
 =?utf-8?B?L2ZvTWxmY0VoYkdoMmNmeHRkdVJnS1RnL2ZYYXo3LzNCMGpsUXZtY25vaGta?=
 =?utf-8?B?N1NOdW4rWEk3U1VkRDV3Vjduc3hFR1d4ZWdTRmFxMzdIU3FNWE0wOE00N3B6?=
 =?utf-8?B?VUhwNU5FSHo3b3lYR2ljUU05bmRUM2tPY2JtZVBKZVVCQnk2V0FNcmxVSlVZ?=
 =?utf-8?B?Y2VodWxWdktlcnF2U0xiSmk5NUhVOVFrRG8rVmVON1p3SGZQejJxS3RaNkFi?=
 =?utf-8?B?eUQ4V3B6ZDA3bG5VZlVkMWdvVmdSMkJKZExOTWpDdUlzQzRaVTRPaFhmS0sy?=
 =?utf-8?B?a2VsRWNuTDhQcG54cG1NV1l4ZS91TmJOWEpRc3JrZjFvZEdmZ0R1ZFduYTJv?=
 =?utf-8?B?NXIrcFJ6Uk5PeFAwcnZHV0l1NHBoSHNjSHNnM3Z6WWJlZW94K1JiTmxsZlZa?=
 =?utf-8?B?RXgxUk9SK2hxbW1ocjFoM2JCV0tYa3J4ZG9BYjFuVkpYUTBmeGNjS1BZdmlF?=
 =?utf-8?B?M21jWUNpSURaMlR3dEpLV0NiVkdrMksvUUNBWllSM2lMMXR6ZC9UTEx4TDFH?=
 =?utf-8?B?RVVPS25GcldpOEVuaE1WU2cyaWcwUjlpUHhDMnUySUpnYkhyUHNac3g2WE1Q?=
 =?utf-8?B?emZ6OHBBU2Z6N1RqOW9YMHQ5WFZ6Y0xJeTlRa0pxMDRjbHNSWmY3QmkzOXRO?=
 =?utf-8?B?VFR4eUxZMklOQ0ZHZm9KR0ZkN1YxNkFqR1I1eHExWUt5M08zWGxLOTM3bFRD?=
 =?utf-8?B?MTVZSXdQczFQQ1lKQ1VtdTFSSDBnUEgva1hCNlh1U3M2cWR4TEhhVEUyZ0lk?=
 =?utf-8?B?T2FUYWNqNURLNjN6QWVDbndub0NjOFcwaDFxNWIzdDhEVFZhNTVTdXVPLzlJ?=
 =?utf-8?B?Qk1PRHFoWUM0dzhxUkg2UFNkcVZnSG0wSHJDVUNjb0NXTEl0NDlSNmFxMXIz?=
 =?utf-8?B?NWJJZDZYLzFMcFBYb3JXaFdnTkVFaExPZjZvL0JZMUVPOXFwaHNIakpTbGdk?=
 =?utf-8?B?Ti9UV3RFNG5SNG9RK1pScUVPQjNZSkpXb2crM20wU2FhYU95ZFY3Szh5d2Ez?=
 =?utf-8?B?bVZXcEtSQnhzeXJnZkxwYjhkK2ttNWV4VVlRRXIwemY0V2J2OGV6dk43TlEy?=
 =?utf-8?B?RG9KMDVLbFVLajZvU0puM1JPdzVrQUNwTm1WQWJVN3BlR1BNZG5uZ2Y3SHdt?=
 =?utf-8?B?YjBTa3VjQW9LMHhHZy9yVHU5WklWY3JodEt4S09reEMrNVJLM3pqTE4xeExz?=
 =?utf-8?B?UDEzSmhITEpkaVYycEwyREozMFg4UVpHZFJ6cXg2R1RUaGdjcGlLRkhodjYw?=
 =?utf-8?B?ck9SQUdCUm1BVjB1NjE1bzBtc0cxcUNsSTRBaHRmOHErSW4remN4dW9laXA1?=
 =?utf-8?B?OW1TMHNma0VMSUVSSkQ2dUpXSUoxQVRjZzRoQXRVb251VkxibmpvbU82Nkpk?=
 =?utf-8?B?WVRnb29MV3hkTWJOeWVuenNHbDZVUmc4cUZQVmg4VGpJL0MyZ3JJMUZOby9G?=
 =?utf-8?B?a3U3MHptVFAxZ3N3VE9jOTRCUDJLbDNGYXdkdUhSWXYxLzZ4bUhpRThPemxF?=
 =?utf-8?B?dk9WWVhtbHBmZkFxVEZBSEJSaDMrZFlhZXpJQ24xT0dTZG9VQ1BybXZ1T2hQ?=
 =?utf-8?B?ZUF5MFV3UGQvdHpMd0k3MTJqZGRsZkFmem9ZUm14cFFjdEpEV0RZVWx4Qjc4?=
 =?utf-8?B?ZDUvM1g3d2UxekFZQVo4ZHo5blJvWUc5dkI0R0dlYXRBTW1GTFliejdpK0JI?=
 =?utf-8?B?VjdOelp5Nk1DMmI5NzNxeXJmczNjeWtpL2JmendPTURMM3IraHI0RTdtd2pI?=
 =?utf-8?B?WUw3c3VrNlpGMEVnWVdjUEtUNVlDT1U0QnBBTGgvbXFCTzg0S3dYWGxaY2h3?=
 =?utf-8?B?ZFdyWWpHZjRrbDRHYm1WYW1lR2o1NlA4MXFjUkpMeDdlMTBqci95cTB5T1dD?=
 =?utf-8?B?MmczOHhSNGJlSmkwK0trR2txSk45aVY3WFJPZys2NXQ3SmRkNWhsMVlaMjJz?=
 =?utf-8?B?ZHROc0plOE5uWnFzU3BMZ1c2TnVMV1RESkkyUHJrL0xJaHVUUEZjZk0xT01Y?=
 =?utf-8?B?Lzgvb1ZEZ2RmSDUxTDJERjVuYnpTQkNVaXRkSGxhck4zSXpDTmZ2UEJBbXcy?=
 =?utf-8?B?S2JHU3VMQTNtNXlHSXdNWE5PUnZKTWVqamhDNDB6VUoyRmlrMFVTeU80ZUd1?=
 =?utf-8?Q?K3AXs9en/jUywJkM6tvAQm4oeAkJFjW9Q5gqC?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0fcef8d-7e08-4b4e-385e-08deb6bb43f9
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 22:00:55.0564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pp/ihCafiUZVaZPr6zkurDTbx1PfcS3375OTOa35dCEO4mt6ZMZfF6V00lUp9Yp8wyGvD837+PsVGN6xdUTDM6gZsSK/9KxUFYYy3wXVR1XrTBbbo0ULTxMmFHsbdTug
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8029
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10578-lists,dmaengine=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@oss.nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[NXP1.onmicrosoft.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,nxp.com:mid,nxp.com:email]
X-Rspamd-Queue-Id: E7FD759C0FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Frank Li <Frank.Li@nxp.com>

Previously, configuration and preparation required two separate calls. This
works well when configuration is done only once during initialization.

However, in cases where the burst length or source/destination address must
be adjusted for each transfer, calling two functions is verbose and
requires additional locking to ensure both steps complete atomically.

Add a new API dmaengine_prep_config_single() and dmaengine_prep_config_sg()
and callback device_prep_config_sg() that combines configuration and
preparation into a single operation. If the configuration argument is
passed as NULL, fall back to the existing implementation.

Tested-by: Niklas Cassel <cassel@kernel.org>
Acked-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v4
- drop context in device_prep_config_sg()

change in v3
- remove Deprecated for callback device_prep_slave_sg().
- Move condition check before sg init.
- split function at return type.
- move safe version to next patch

change in v2
- add () for function
- use short name device_prep_sg(), remove "slave" and "config". the 'slave'
is reduntant. after remove slave, the function name is difference existed
one, so remove _config suffix.
---
 Documentation/driver-api/dmaengine/client.rst |  9 ++++
 include/linux/dmaengine.h                     | 63 +++++++++++++++++++++++----
 2 files changed, 64 insertions(+), 8 deletions(-)

diff --git a/Documentation/driver-api/dmaengine/client.rst b/Documentation/driver-api/dmaengine/client.rst
index d491e385d61a9..5ee5d4a3596dd 100644
--- a/Documentation/driver-api/dmaengine/client.rst
+++ b/Documentation/driver-api/dmaengine/client.rst
@@ -80,6 +80,10 @@ The details of these operations are:
 
   - slave_sg: DMA a list of scatter gather buffers from/to a peripheral
 
+  - config_sg: Similar with slave_sg, just pass down dma_slave_config
+    struct to avoid calling dmaengine_slave_config() every time adjusting the
+    burst length or the FIFO address is needed.
+
   - peripheral_dma_vec: DMA an array of scatter gather buffers from/to a
     peripheral. Similar to slave_sg, but uses an array of dma_vec
     structures instead of a scatterlist.
@@ -106,6 +110,11 @@ The details of these operations are:
 		unsigned int sg_len, enum dma_data_direction direction,
 		unsigned long flags);
 
+     struct dma_async_tx_descriptor *dmaengine_prep_config_sg(
+		struct dma_chan *chan, struct scatterlist *sgl,
+		unsigned int sg_len, enum dma_transfer_direction dir,
+		unsigned long flags, struct dma_slave_config *config);
+
      struct dma_async_tx_descriptor *dmaengine_prep_peripheral_dma_vec(
 		struct dma_chan *chan, const struct dma_vec *vecs,
 		size_t nents, enum dma_data_direction direction,
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index b3d251c9734e9..defa377d2ef54 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -835,6 +835,7 @@ struct dma_filter {
  *	where the address and size of each segment is located in one entry of
  *	the dma_vec array.
  * @device_prep_slave_sg: prepares a slave dma operation
+ * @device_prep_config_sg: prepares a slave DMA operation with dma_slave_config
  * @device_prep_dma_cyclic: prepare a cyclic dma operation suitable for audio.
  *	The function takes a buffer of size buf_len. The callback function will
  *	be called after period_len bytes have been transferred.
@@ -934,6 +935,10 @@ struct dma_device {
 		struct dma_chan *chan, struct scatterlist *sgl,
 		unsigned int sg_len, enum dma_transfer_direction direction,
 		unsigned long flags, void *context);
+	struct dma_async_tx_descriptor *(*device_prep_config_sg)(
+		struct dma_chan *chan, struct scatterlist *sgl,
+		unsigned int sg_len, enum dma_transfer_direction direction,
+		unsigned long flags, struct dma_slave_config *config);
 	struct dma_async_tx_descriptor *(*device_prep_dma_cyclic)(
 		struct dma_chan *chan, dma_addr_t buf_addr, size_t buf_len,
 		size_t period_len, enum dma_transfer_direction direction,
@@ -974,22 +979,44 @@ static inline bool is_slave_direction(enum dma_transfer_direction direction)
 	       (direction == DMA_DEV_TO_DEV);
 }
 
-static inline struct dma_async_tx_descriptor *dmaengine_prep_slave_single(
-	struct dma_chan *chan, dma_addr_t buf, size_t len,
-	enum dma_transfer_direction dir, unsigned long flags)
+static inline struct dma_async_tx_descriptor *
+dmaengine_prep_config_single(struct dma_chan *chan, dma_addr_t buf, size_t len,
+			     enum dma_transfer_direction dir,
+			     unsigned long flags,
+			     struct dma_slave_config *config)
 {
 	struct scatterlist sg;
+
+	if (!chan || !chan->device)
+		return NULL;
+
 	sg_init_table(&sg, 1);
 	sg_dma_address(&sg) = buf;
 	sg_dma_len(&sg) = len;
 
-	if (!chan || !chan->device || !chan->device->device_prep_slave_sg)
+	if (chan->device->device_prep_config_sg)
+		return chan->device->device_prep_config_sg(chan, &sg, 1, dir,
+							   flags, config);
+
+	if (config)
+		if (dmaengine_slave_config(chan, config))
+			return NULL;
+
+	if (!chan->device->device_prep_slave_sg)
 		return NULL;
 
 	return chan->device->device_prep_slave_sg(chan, &sg, 1,
 						  dir, flags, NULL);
 }
 
+static inline struct dma_async_tx_descriptor *
+dmaengine_prep_slave_single(struct dma_chan *chan, dma_addr_t buf, size_t len,
+			    enum dma_transfer_direction dir,
+			    unsigned long flags)
+{
+	return dmaengine_prep_config_single(chan, buf, len, dir, flags, NULL);
+}
+
 /**
  * dmaengine_prep_peripheral_dma_vec() - Prepare a DMA scatter-gather descriptor
  * @chan: The channel to be used for this descriptor
@@ -1010,17 +1037,37 @@ static inline struct dma_async_tx_descriptor *dmaengine_prep_peripheral_dma_vec(
 							    dir, flags);
 }
 
-static inline struct dma_async_tx_descriptor *dmaengine_prep_slave_sg(
-	struct dma_chan *chan, struct scatterlist *sgl,	unsigned int sg_len,
-	enum dma_transfer_direction dir, unsigned long flags)
+static inline struct dma_async_tx_descriptor *
+dmaengine_prep_config_sg(struct dma_chan *chan, struct scatterlist *sgl,
+			 unsigned int sg_len, enum dma_transfer_direction dir,
+			 unsigned long flags, struct dma_slave_config *config)
 {
-	if (!chan || !chan->device || !chan->device->device_prep_slave_sg)
+	if (!chan || !chan->device)
+		return NULL;
+
+	if (chan->device->device_prep_config_sg)
+		return chan->device->device_prep_config_sg(chan, sgl, sg_len,
+				dir, flags, config);
+
+	if (config)
+		if (dmaengine_slave_config(chan, config))
+			return NULL;
+
+	if (!chan->device->device_prep_slave_sg)
 		return NULL;
 
 	return chan->device->device_prep_slave_sg(chan, sgl, sg_len,
 						  dir, flags, NULL);
 }
 
+static inline struct dma_async_tx_descriptor *
+dmaengine_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
+			unsigned int sg_len, enum dma_transfer_direction dir,
+			unsigned long flags)
+{
+	return dmaengine_prep_config_sg(chan, sgl, sg_len, dir, flags, NULL);
+}
+
 #ifdef CONFIG_RAPIDIO_DMA_ENGINE
 struct rio_dma_ext;
 static inline struct dma_async_tx_descriptor *dmaengine_prep_rio_sg(

-- 
2.43.0


