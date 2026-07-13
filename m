Return-Path: <dmaengine+bounces-12402-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id g2C2Fm0aVWrqjwAAu9opvQ
	(envelope-from <dmaengine+bounces-12402-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 19:03:41 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E208174DD58
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 19:03:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=QPzg2kgU;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12402-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-12402-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E30623017B86
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 17:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B3E33439A;
	Mon, 13 Jul 2026 17:03:36 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012044.outbound.protection.outlook.com [52.101.66.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D8130DEBA;
	Mon, 13 Jul 2026 17:03:34 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783962216; cv=fail; b=G3VtnKLuJjZgxL7OdRXH4g1/OS4IVI3Wv4gZAT+ZGSpTuERG3VQrNrRdYglrsM8u++7P1H2EAujXgs6LDNn+0BnEh2HDilDSDpOLWXk7QOLysOPpqY6JBjlcOPdapLBZuVaqVpXuWiQ4L2CFNo9ywH+kOKJ989NWhgbVZ0aFIpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783962216; c=relaxed/simple;
	bh=0rUaAhRYXGLBuL92sG3IHilwL5OsC+P5KgfJiOuVZEM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=asg7z/6afmirLuA3WB/gFEHpNAzCKRKFM+ZYCs0Um65hMUxvZDDRkX6+zJGo6c5cdsGAREk+nq2tjBWA+RUBCHEgwitdMTzWFzYYiMLQZlPB3EG+e3BRXiWpfa4/pj8U1ebWe8QZZOTxPbaL5QPm9B/GVB7ylJBYi4zdVsY448Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=QPzg2kgU; arc=fail smtp.client-ip=52.101.66.44
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HX5s1Pr+vnKdM5hP013JQI7Dz00ksqhUayIJPPe/wblCh2NlFK6vd9PgCIPP90RtLtSUJi+p7kziYl80uS6vOeALKLnRDnvVEwysCKUgQedkcUJkzHji4+6j8NCYbP9Y7L8dGcBK8zfzWEV4h4+3r1sAOtskvzv5qAmBwFsJT6LI7ILH0kjecET2a5O8rFKwmhvParJgKJkw1zmEAz3uS4m3IaOW05HH4BIt/pSdN4Orfh97c09uFGRspXcdmuBlMh6gIFV3kGfkCwD9SEzaUWJWUZxPNyXg8PcIVCvHp+3Ki+rm/Lmkhavb/C2ooLuHvRmHXd9m7nyIdNdsqZA0Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ekbvDQDKa607fzFh0+aPv9ATxvLOpiy+Pj1Ja9XJpDk=;
 b=HNQKKywTzBCtV5xqtyWW8UtgHt9STCmDdmHzm8tP3foFRPRcLtOFoso/yoR1mDMAgjceX/59NFq+H+Um197D4Wcxy2tZWu+3LtCiOfJhRSre6BAbVG9uXVuPW8DCEGaY978XqjRMg508rEzSFPm1yf0Gfbn3Dw0HI3iihKzmNfEmyW4N1w7KVWYla1td0qfw2FjZOPsTbu4YS0hbmnjo7cZUCeRqlReT517bdJhGWwVdTkHi9K0vV2ppj2CtzQV50H83/vaC2mCY8kdlQp+/eu+a7DAC8mYkqVtMakMSpU97fkhaAAJRqv7R6yvHd0BuY/P+Wjbj7pOwriIuFpbWBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ekbvDQDKa607fzFh0+aPv9ATxvLOpiy+Pj1Ja9XJpDk=;
 b=QPzg2kgUTp/zlEkoTQPkEVYLJnwvhz6rU0RsK9uEcWcX2p1aqpIpGrezP2c1njs3Ybt7QuqUfUWL3jZF8i2diLW6AEcBhBdJJsOYIegNfIPYgVB7oBrInyXtHDSGFk5SC0a2IlB3zb69FmTrVS+sITa7+r64O8kCRYA0C5OElaYNQcVyQTTAHnoqQdhohkUwz7j2m4URaHUNrw2EsW2ZbnKg2JFcTprHCiu9TOnHDCl+dPIeNeViBc1VBD4m6TKqjL58g47bXAYLImUD4JwwOqJHeSFY98p5YzvnFUuepwbAgdoRlDD+k1nuBd6Jbi6tAmlfy1FUjIJBoDy3xPtUkQ==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA1PR04MB10228.eurprd04.prod.outlook.com (2603:10a6:102:454::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 17:03:31 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0181.019; Mon, 13 Jul 2026
 17:03:31 +0000
From: Frank.Li@oss.nxp.com
Date: Mon, 13 Jul 2026 13:03:19 -0400
Subject: [PATCH v7 01/10] dmaengine: dw-edma: Move control field update of
 DMA link to the last step
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-edma_ll-v7-1-6fb7498c901e@nxp.com>
References: <20260713-edma_ll-v7-0-6fb7498c901e@nxp.com>
In-Reply-To: <20260713-edma_ll-v7-0-6fb7498c901e@nxp.com>
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
 Frank Li <Frank.Li@nxp.com>, Devendra Verma <devendra.verma@amd.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783962202; l=3618;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=gVYSKfPnpSeZrfSYGx+A3Uwf3FueXyIjjaG1eS+BC5U=;
 b=uric20U89P0Tj9RccOjg2Z06OFVD76RazkS5jiF9CkKi4Bjrvk580ZuD3npjB1yVGI5jNf/7J
 ok0byGmp6gyCly28MC44mcPLJmc+P+FNbOn2w4weurnXelY61loF/jR
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SN7PR04CA0042.namprd04.prod.outlook.com
 (2603:10b6:806:120::17) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA1PR04MB10228:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d57e3d4-cf6a-46c1-a00a-08dee100aacd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|19092799006|1800799024|921020|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	O3AIqS9A3zcnCLE7ypiiaKqnQzuaseRYupbqRMkYoqei2Q1MbabsX6FksfGur4N/dtnNPC/56oB0Siob4iH4j1KJmRb70g1sAMhy+FHngr8DtvXFjRiu59qVK0mk71Y5xMl6/LS+E9b9lpcKwtr1QLQdMnnhiZGsKKzA2v5qrHStFGhd+Tw+1N3Alx0SwTbQziA+NK3SP8IG3MVevD+1SeID09tMjd36zLRtjLeR6e7hLDchbc4xc3+/X42L3XruoEsYu+UeyK2mzwRoxmF0dtbGI+zcVTvAkOyX3c2IAxXjEctF5oO4uTJQcj3ZssFBsdlshugst227Pftmoo99mpO5smxieFSeEN7LdoblYExQdAQY8Ozy0ACgU2mfxjx2Yav2k11s/+NVK5V6CqGwy5pRZrFMuWim7ZopLTfHQeBhMhGWVpgOuudsteOWXyUNs4sfOQuQXEBns5X0d0wz/97uftUnPEQfNpICuZi4KWeJtwg2Tx2T7xCbmdmShwSykdp/Xj1PqHtq3udUhL89toW28WcNyTqeHWFtEsZo5nYC4hAfuYIirwSMn6583d6bc1wXFrU61hQrjT+1lOBQ2rBzQ7eY0rDX2C/FBRG1CvN4vKCfPETAzcFdPy47tjQvo2L+DFZu/KSS4uig9YJec7KRUdHSKaLGJKPpjFpYahoAXnGpThNc6x51iy/ms8SeV145nd62cRVKWjwUWM5wow==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(19092799006)(1800799024)(921020)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ni95aE9XUlJiRTN3eFkyQURKUi9waXpKRVFXT2h3LzNzK3IrNHJZMWNTU01h?=
 =?utf-8?B?SWI0NU5sZWdhbW5uSVIrTitJZk90Z21lZHhGUk1QMGh1ZTFKV3gwVmN1OWIr?=
 =?utf-8?B?bzMvQmhDZ1dTbzZCL3lHeUY2djlwRFBZSStsVEl4a3lvOUxmTzVQd0dxR3Bu?=
 =?utf-8?B?eEtiVTZGcW9WbzR5MDZXdXo5cVk4RHdjcUgzSUllaDlvUjBpRXJPQm4yS2RT?=
 =?utf-8?B?K0ZNa0Y3WW5hWHRvd2RZN3hNR051ZXhBR0J0QlI5ZWV2a2tqdWttWmhVRUVZ?=
 =?utf-8?B?Mk9CamI3TTk1VXozTTJQSkN1Y2lXdEs4MEtuNmxrbDhCME9yREpWWkRaS01M?=
 =?utf-8?B?V1llMGpyNnZ5cnpzYlBpRTVDcHVlbDZmejBoaFY1SDdsb3h6Tis4SUM3WGxu?=
 =?utf-8?B?M1Zsa21kZzNFYVd2QW5mM3oyWjJsN1UyM2ZMa1VCd3hwZ2tRRnhkZjFDTFll?=
 =?utf-8?B?aTNYUGRhbmswUDF2TGJSQkZ5UUxLaGl4TWg2T1FPOENrQnpaNjY5UU1tdDZI?=
 =?utf-8?B?dHIyMFZVbjhBdmVFOGtpdjBqdFl2OFNDT2hYUmFXYUtYUFpBcTZWVHFWTzJT?=
 =?utf-8?B?WjcrRm93ZkIyVnRjMy9xSU1KYTRucFVRSldvWkxreVNtQ045eksya3Vtek82?=
 =?utf-8?B?ZlMycDluU2kra21lUUpWYWNKY0g1Lzl4TGN4c0NzTXV2YkRRNXJMbTQ3NExY?=
 =?utf-8?B?Nk1HOG1sd1VKS25oMGc4Nk0yTDhmOTdUNnlVK1dYaUxvdWVQcFFvT3h2OFFj?=
 =?utf-8?B?RU90SElmN0J5RVhqdC9nQWgxQVhIeldvT2FQakxnWEZDWDlVWk00c0JTbzFl?=
 =?utf-8?B?cmxlR0FUL0pWWkF1ODVXdDZDdkdFUGN5ODV5aWp6S2x5QU1ERkZMYmEvL25i?=
 =?utf-8?B?RElOdXJwK01XYXpBVU1qUWpIWmcwNTduUTFuRGxvaVdXQTlnZjlrWHR1VWdj?=
 =?utf-8?B?Q2hHWlpraElBWmVvQ1cvKzVZV0xka09yVHp6SUZ3V05rbXIvZG95MXRpa1lq?=
 =?utf-8?B?cWpZSE0rRDc1ejdoVkRXUCtxY0tqVG9Vcy96VWI2anFCUnBMQm9FMmxHMnpG?=
 =?utf-8?B?N3dQRTZDQmoxUmQ1a0JWVW9KeWg3WUs5L2kzcW1FZSs4eXorREFPU2U5M2Jr?=
 =?utf-8?B?aGpvVlZENFc1bWoyeXJPbDY3NDNzd0xZb2htdVlub1k3Q0FrcDZpRWIwVVlX?=
 =?utf-8?B?WXIwZTdHeFkxTGI3Q3VqS2ZkV01uS3ZiRkluTzRFWVJ6dm9DTWtlZkxsZ0x3?=
 =?utf-8?B?ZWlJWGxWQ1NxZ0lta0JoUnFSVkowUDVqeVk1UFkraDRrNkZsL0t2QXRWS2FX?=
 =?utf-8?B?RS9temUwWHhnYlFGdHZydDNTU3pxZGl5aDBSek1PLytaR3hBRThWMVdwMFUv?=
 =?utf-8?B?cC93dFJtZm4rOVdwQlFablRDdWZjSVAwaSszK0VyOUw3T2VDc2twcmV1MmdW?=
 =?utf-8?B?ZG1EejNRc0tDd0RVWG5SZWhwT1hRZVFRZzNKWDdKbnNnQXFQRUticXdFZ1oy?=
 =?utf-8?B?UTVpZGk2TlhnbC9FdHhlaENFcS9kZ0N1d25rTU9xbmE1NldEM3k5aFdJcXVq?=
 =?utf-8?B?UkFpcmxIdUVSYkJXN09UbXVKQUR3bW9QU3duVnJOdjF6UlN1eHNFcENsZ0pH?=
 =?utf-8?B?eHZGamZ3U3dXdCtHMGJHMCtWM1BlSFJFQitPNlp6bnF5TjRUcnJnUHNxK1Ey?=
 =?utf-8?B?aFl6OEEzZHZkOStEVmdGM1ZkUm96WnFrUkUrTTFEWEpkZDR2RmNHWmZxUldM?=
 =?utf-8?B?NFVTeWZJZWNWU0ZPKzFrcVZDbHlXU005dkYyeVlWSkV1RklwY09aOWl3amxM?=
 =?utf-8?B?Vk9Nbm44UXlxdEJmeVQ0dkVzWWR3ZjhlSnpUNHVBVHhCWUYrdkZOWFMrckpn?=
 =?utf-8?B?dEw2aFhLTXdhWjQzT1RTQlBrTlpNSUd5MU5OVy95amF2bGZkVm9aNDQwcUVo?=
 =?utf-8?B?QlI5WW1wSzhzVjdQbldRZVB3OHo1aU93Q3hTaTduTVRXVFoyU1NWVW5EMElH?=
 =?utf-8?B?QkRHaER2NjBqOWoxY0drems3cmI2bzdqWVgydzR6aVBybUNIVGRXUldTMUlz?=
 =?utf-8?B?bjZKUHRHWWFKNFRJOGVDaEFOV2UxdXhzUlMyTm5DQ2tkK2M3S2FaNTFDN25P?=
 =?utf-8?B?WGZhQVczb2c5WTFkYy9tSzBwUnE3bDlvWTZ6NWNXa1hjRjVIQnRRa1pJL3lV?=
 =?utf-8?B?L1JMdjVJaS9mWmI1R2ZSRTJiZ0xvdHFtN2VzdlBoS0YxZzJLMWhNbElDcldK?=
 =?utf-8?B?dWNYWDY0c0Zaa0RqcnlOREpUZXUvditFSStJSGViN29oWU1xcG1VZmJ0R0h2?=
 =?utf-8?B?bHZYak1mNVA3ZlJsNDJ3ekhTWDFEOGxxcDdiVVEwMEE2dlpyOFZ5T1B0dE5P?=
 =?utf-8?Q?SB4B90UtaCKtIGV0MvmORlP+geJ5d8cpeFS5q?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d57e3d4-cf6a-46c1-a00a-08dee100aacd
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 17:03:31.7133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TM5EH/XJOZpWzChNpOUSO9YbuMIb4/c+vnwztg56RHcQS0iVUGudSy9rI2wjONU59D4ldFAfwHdVo1lWwcea1Xdavx/JO49q4HJb6U+Y1d3ZRJbOfbTfMNikKTiQyY71
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10228
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12402-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mani@kernel.org,m:vkoul@kernel.org,m:Gustavo.Pimentel@synopsys.com,m:kees@kernel.org,m:gustavoars@kernel.org,m:kwilczynski@kernel.org,m:kishon@kernel.org,m:bhelgaas@google.com,m:hch@lst.de,m:cassel@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-hardening@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:den@valinux.co.jp,m:imx@lists.linux.dev,m:devverma@amd.com,m:Frank.Li@nxp.com,m:devendra.verma@amd.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amd.com:email,NXP1.onmicrosoft.com:dkim,nxp.com:email,nxp.com:mid,vger.kernel.org:from_smtp,oss.nxp.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E208174DD58

From: Frank Li <Frank.Li@nxp.com>

The control field in a DMA link list entry must be updated as the final
step because it includes the CB bit, which indicates whether the entry is
ready. Add dma_wmb() to ensure the correct memory write ordering.

Currently the driver does not update DMA link entries while the DMA is
running, so no visible failure occurs. However, fixing the ordering now
prepares the driver for supporting link entry updates during DMA operation.

Tested-by: Koichiro Den <den@valinux.co.jp>
Tested-By: Devendra Verma <devendra.verma@amd.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v4
- add Koichiro's tags
---
 drivers/dma/dw-edma/dw-edma-v0-core.c | 10 ++++++----
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 10 ++++++----
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index cfdd6463252e6..ee5c3c317557b 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -284,17 +284,18 @@ static void dw_edma_v0_write_ll_data(struct dw_edma_chunk *chunk, int i,
 	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
 		struct dw_edma_v0_lli *lli = chunk->ll_region.vaddr.mem + ofs;
 
-		lli->control = control;
 		lli->transfer_size = size;
 		lli->sar.reg = sar;
 		lli->dar.reg = dar;
+		dma_wmb();
+		lli->control = control;
 	} else {
 		struct dw_edma_v0_lli __iomem *lli = chunk->ll_region.vaddr.io + ofs;
 
-		writel(control, &lli->control);
 		writel(size, &lli->transfer_size);
 		writeq(sar, &lli->sar.reg);
 		writeq(dar, &lli->dar.reg);
+		writel(control, &lli->control);
 	}
 }
 
@@ -306,13 +307,14 @@ static void dw_edma_v0_write_ll_link(struct dw_edma_chunk *chunk,
 	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
 		struct dw_edma_v0_llp *llp = chunk->ll_region.vaddr.mem + ofs;
 
-		llp->control = control;
 		llp->llp.reg = pointer;
+		dma_wmb();
+		llp->control = control;
 	} else {
 		struct dw_edma_v0_llp __iomem *llp = chunk->ll_region.vaddr.io + ofs;
 
-		writel(control, &llp->control);
 		writeq(pointer, &llp->llp.reg);
+		writel(control, &llp->control);
 	}
 }
 
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 632abb8b481cf..1201f1ab5f359 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -160,17 +160,18 @@ static void dw_hdma_v0_write_ll_data(struct dw_edma_chunk *chunk, int i,
 	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
 		struct dw_hdma_v0_lli *lli = chunk->ll_region.vaddr.mem + ofs;
 
-		lli->control = control;
 		lli->transfer_size = size;
 		lli->sar.reg = sar;
 		lli->dar.reg = dar;
+		dma_wmb();
+		lli->control = control;
 	} else {
 		struct dw_hdma_v0_lli __iomem *lli = chunk->ll_region.vaddr.io + ofs;
 
-		writel(control, &lli->control);
 		writel(size, &lli->transfer_size);
 		writeq(sar, &lli->sar.reg);
 		writeq(dar, &lli->dar.reg);
+		writel(control, &lli->control);
 	}
 }
 
@@ -182,13 +183,14 @@ static void dw_hdma_v0_write_ll_link(struct dw_edma_chunk *chunk,
 	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
 		struct dw_hdma_v0_llp *llp = chunk->ll_region.vaddr.mem + ofs;
 
-		llp->control = control;
 		llp->llp.reg = pointer;
+		dma_wmb();
+		llp->control = control;
 	} else {
 		struct dw_hdma_v0_llp __iomem *llp = chunk->ll_region.vaddr.io + ofs;
 
-		writel(control, &llp->control);
 		writeq(pointer, &llp->llp.reg);
+		writel(control, &llp->control);
 	}
 }
 

-- 
2.43.0


