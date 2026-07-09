Return-Path: <dmaengine+bounces-12239-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xrw/ImW/T2oFnwIAu9opvQ
	(envelope-from <dmaengine+bounces-12239-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 17:33:57 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 166A7732F45
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 17:33:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=OxN9Xvmu;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12239-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12239-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4756A3046F78
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 15:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CDBA41B365;
	Thu,  9 Jul 2026 15:33:47 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010047.outbound.protection.outlook.com [52.101.69.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF8740E8F1;
	Thu,  9 Jul 2026 15:33:45 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783611227; cv=fail; b=Y5o98lis5FATFrfYpgh8C8LkSl8q5oH21dR7DDRG8/x0qTxfP9Q5hGaxp9Bjyg+D8PLehw/399LkYmJCNnJqigNEp8P6MkLxlyl/vGkDUJW3B3WVj0q6XrbGuqpfDVvIm1kgg0YtGVbKbq9BIaUSOuDZCcfS9RxHbKfaNSV/6TI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783611227; c=relaxed/simple;
	bh=LEdJdCACevNrxSBUJ8meqngfIrqiHsc5sZQnnH3iNDc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=DW3g99NDMBUnmkWMv7TK0ks1fZ2R/G1ROxV8qavP+ixkh90H1VVvEvEfptkjSqH/QBXGemRYYthlxVOtv20vP3uONBjL6B4e5Pj6EzCjzGYKYZNcr449Krm82dTnB96+w5xJT9YZCdqLSZ8M4RoAmxMGMD9t7KzyUoSxMFdtqKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=OxN9Xvmu; arc=fail smtp.client-ip=52.101.69.47
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KWy0L3bI90d+7qcHg8ygsw2Pz0pVf/b3qi4ubJ9Qwg5u2yXyzqgzm9YzGB/4f41+aHNZnblVff//HADUKL6kymRuh0/GNPdBO62tODLnNDkEXptyDjDqyM/CAfh4/un1UYLe6c38ZdSf+0uHREQkvl04Uzv21AAdAyhBm3hO/EJY8r8+DJKuA3V0G4oKqBFK1Rb7orQk0/5omjeY1T/DslYVR7lJUgvGVLTk9KfxshoVYBqHaPQzfbwjrdCMV+WdtAwa580+VNAR741AF+uJFjFQ1M8I0FGU8wWBU0JKwr/wKlbpKbzS6le8GtXIlKXmocJOl7VXvvtrVYirMqabdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vdfg/n8nGgvFwcsy0j9MK+wCSiPdNNYD732a15idxaI=;
 b=q5Pva8SMOcza3ASF+WGFwLxmsRUukPwxRi3RNBw0dd+X41Ul4NfrmSaNTgYX0xXsoArihuzlMDEkJjH7ZrxV/JmpsM04r8N8pxyxgWqxdNxrJ1Wl3EoXTea+kjF60HnIaA7XfAB//Ux/5Tax9MZeWc2Uzgy8rvbTy1iJIViTwD+e22M8tX3VRqUCOi75iYp7NcWq15ohsKwps4fLlin2uQwxK/TuuLe7tRgAa0xBTmZHcKD87y7SeTJycK3ven/fODIcx4a8Ja25RsqBgS9JysexgRZpmFKETRXK7unHCIM22C2BtIkT68to9fPpPoVa/KtXVnUt/MSwyMA6yCzPZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vdfg/n8nGgvFwcsy0j9MK+wCSiPdNNYD732a15idxaI=;
 b=OxN9Xvmu0qFanXn/b9b321fVhBbpmGPvyhGGr6OWzOqssdPvP4lin0NUVtL1m6ytpaERVJA0vHHHakUIxNNXLdEYtRr5YMZffu2SgRlhtxbamgPWxrbyX5x1dDczhu+drAoHvnfSzWtf4UGreXTlr8J2zD+AJVHtMEARlceDnb6y2wFxA9POTpkpM/WbyYL1yXs++VAheU3Wf3+QiTBsLDpJTxtabLly0b7NnJ14VSuzTRPmxE2wefcHu6zQUUYuD1Te5S6wgJbOoOk72eE5hlJLmQdJ01cCJJK6HggC1ngxjWnISq35zi20hYS/BT1Xr+ZPowivPPYTHYA8r3b7QQ==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM7PR04MB6968.eurprd04.prod.outlook.com (2603:10a6:20b:dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 15:33:42 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Thu, 9 Jul 2026
 15:33:42 +0000
From: Frank.Li@oss.nxp.com
Date: Thu, 09 Jul 2026 11:33:30 -0400
Subject: [PATCH v5 01/10] dmaengine: dw-edma: Move control field update of
 DMA link to the last step
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-edma_ll-v5-1-e199053d4300@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783611213; l=3566;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=geWLY7+7Bq0r3OZ5EWJpTkJEDEWVSA01WcSxrlvbm7w=;
 b=j1Yab2oOJUj767CnqCMDEw8c5OZVEb7Si+p2Jwr520TiEutGS2GBxjLp470sCmWr71O4V9igO
 MwuZS97kiifDbuqdieqjZBmS5XY+DUbMFl7jGc4FbQ2q180EBeDpCPT
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA9P221CA0026.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::31) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM7PR04MB6968:EE_
X-MS-Office365-Filtering-Correlation-Id: 116e8881-187e-438e-5e5b-08deddcf7510
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|19092799006|376014|7416014|1800799024|921020|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	wRP6G5x6TIdBmKULzNrvmCT0XVwzYQZg2HgN62LwoHejYdVeNS8O0Fwi3JQYaL3TaY7I0M7/VTLWsNWynrAhJ+EhYqVk6M40U0eWHcmcLTCehRca9y8tqt41LhkTUSa/nvUySXfQ06JdeWsDmyOGoN4m+qI/LHvpY3gXDYuHJWSykMulnnJOpDFiRij8VO+s0UEGr9Z0pQ7O/EAxlDIz1KOOroX4K3d9P/JBiaipdviSsaTAn+b8G8q7nfEMj+7Y5Ir/qJuRwuygPwKTYLZEMZGUrC6lwvenJ/nf5N8lweo6bvQZiwC+6RSQyUGf61JkQl7tRiorYhh7VtTwyXlrG2p0vVIAzOtf890hz0aSI9BAtVZgAJ0OGGq7lGE4DuJmIfrvefHuWfLY+FR2c29vxW5kXEsOScS0s+uOrdaBHFksOBnmXqBzkqx978Smh0jinr4fLRQug0oyrgpiR3b8NZafl0jOMvxsfjYO0W0lbjW8LVQQRLKgld3ybbDDrAs9aAnklBU97Q0qDAf524Ip9gildNS0TXtyMBKqYYPuzQCZyKozkmwlb/yhTc+lvtNivv4pddXp3btoaAGXv+smqP8oWlUAnSCmBiO1g2fQ79iRHGogyQMF3N/2/q/h3R8tWxOT9Nh9PI8g0ZHrkMQ4XOzUcS9yJAojYmbk6S+k3nvlIA5hp0DhZyimCJFDA2darT3uxgQ0mqoNE2k1gUAlog==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(19092799006)(376014)(7416014)(1800799024)(921020)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QjBwTVk0cG9JMXJjRllXTjQzaEEzdFZWZFo4ZlYzTVlFeWdINGJSOUtFMnRC?=
 =?utf-8?B?NkhOZjgyZXBlSGxmMFdwSWJsU21KbElzYmErOUV3SVBrRTg2RDREaS9GeXNU?=
 =?utf-8?B?RWxMSkZ3YThoMnA3NmluQk93OXFqKzRSSW1EU0doOTY0ME5RY09xdHJ0NUJk?=
 =?utf-8?B?ZXJXVXFPSjNQUmVhRTJzTnlpanVWMmhHZjVCd05BcHVBOFpJMThiTEJlMjJX?=
 =?utf-8?B?UGhUYXJmdVppWlgwbEJ2V1lyMC9pRTVUUEw5OGl6eEVzQ1JlSzVZalpIMmht?=
 =?utf-8?B?L3Z3V1Z4cmpPNWVEU0loWHhDNlJ4TTNBeTlpS21kOUcrYXkwbnF6YXdBWDAy?=
 =?utf-8?B?Tkh1d0E1WDV3cFNMTndwT0l6SVRlbXJ4bWNMQmdFakpEd3NMOCtBeTJuTjQ1?=
 =?utf-8?B?TWs4VUhoSVc1UGJCZHpzdWczTFlHUVdvZDgwT05KRzhnbkpVdERPckppV3NX?=
 =?utf-8?B?Yy85dENhK3FjRElkcGNWZEVDL3UwZjg5T3NSejFBZFVzb0VwVW1KemtRYmhr?=
 =?utf-8?B?a2lPNlBCam5rdlZrczZnTThTUDdUWjEyajNROU5zaml2cjRTd3I0ZGdVUVRL?=
 =?utf-8?B?ZGNIak8rUEU1bFZNZGxOOGd1MVJDS3RHV3hSaGxOYy9Fa0FFb1JiQmVvdjdi?=
 =?utf-8?B?WkIvN3hlNjVtcXRVUjF4b0VlUUJzMDdwODRIOXJQT1BRT0lCdjVZUmF6am1O?=
 =?utf-8?B?Q2x5UFJ0dHR4WWJvU0lCK3dhOU1RRktGQlQwQm5lVzMxQjNXbktBenFlVU1Y?=
 =?utf-8?B?QlpyOGV2dUVMS1pCWWQ2V0N0b1R3TUdjZkNLWllKZUpXdUxoaXErKzhRMkx1?=
 =?utf-8?B?UEw5UGtGNWgraVN6elRiM3cwZlg5WE50Y21RaTJlOFA5MFdEU0I5ZWUyMVpN?=
 =?utf-8?B?U2wyYS9oaGgva0ZVNjJsVVFiVE1sRVJCQWJoMlIrSUxIMG1tY2dFK3NRQUdI?=
 =?utf-8?B?cmE3SG1ORjNKaUgzUzA3bTFoL0JYMFJzb3VwUUZtQWZFM2NDVXRFNGxURXlV?=
 =?utf-8?B?Qk5NM0E4NEhmaTN1UnFNcHg5WC82LzZZTmVnYjRvZ2JldVRJbkdNTjhoUEhY?=
 =?utf-8?B?MFZBakNoNVlFdlNaYTJxY1E0RGpXYm9HT1YvSnQ0VFdxSzdaM3U4VGJ2Q0V3?=
 =?utf-8?B?MVZ0SWlRZWV0c3AwbmVTZVFVRkZOLzFVWm1tVWcwLzJSd0xaR29XaEZSRTk4?=
 =?utf-8?B?bDRRTllkSlR5dnduajdhZndXa1pXclRTODErRThFM0FMSWdKTUhpNEc4Z0ZE?=
 =?utf-8?B?M2Q3K0hvczc3blNqbzg5V0UxQWxtNFViVll6d0lvZVFpR3VGQzNYbkZxT1Nx?=
 =?utf-8?B?UUNFYkYzV2gwL3BuU1NUK1kxbENZb3ZhL01yVFVLMUUrYkY0N3ZFMGNSKzJ1?=
 =?utf-8?B?WVMvVkhwU2xSNW02c3JxbXdycDFsVmxjU1huRFRWSStEV2Zjbk80Q1d2SCth?=
 =?utf-8?B?QTM0aFYxWmxNUWQ3azQ0OVl3bmhucm9vT2FTUytBTEYvc2UvRHcvcXF1dkwx?=
 =?utf-8?B?QytvaTkvUlJUVE9KbmJWQkMwUVNXNXhqYkVMdlVjRVk4V1VYOHY5MjhQdmRm?=
 =?utf-8?B?S2I4cGtuM1JxQ1VJZ0VKaFVUV1REOHE2VTdOUCtCZXlmRmxOYTBKaXZnRC9M?=
 =?utf-8?B?cG92SkRCSTc1alg5V1RReWY1SXdQUTQzalN1bDB6dWNIUGNtSHBKVjZrSzBp?=
 =?utf-8?B?cGtNODJQVlhHUFJzR2tIZXVyR2xxaUpPUjQxbWxqOG1ZQkM2aFdLdUNYcU5q?=
 =?utf-8?B?V21rUXBZeFh5VzJGRiswOVVqeEtTTGhCQXMreXlmeUtwN2lweHNYUFpiUmJx?=
 =?utf-8?B?NFlidXZXNDdsbmlyVGYwYXZibm50eEU4SjNFcjlkbkJLR1RVSmRsSjl4QS95?=
 =?utf-8?B?bmxGV25NZENOcjZGM0RMQy9PRVB6ZkozVHBwVVFUdWxjVHIxSFZYZUJwb2Fj?=
 =?utf-8?B?VjZXYzU4NDU2OGU3QkN2Q1lERTNuMGNVT2lqNExqMUpJK21PeUNxYWMxTVB2?=
 =?utf-8?B?MXJsQnAzell3aG0zdXZLZE0wN3EzUnAzWUd0WVl2MlJHWWlRQk1BeklUUFhJ?=
 =?utf-8?B?M3VGbzlYU1o4cFRlamZaUkR2TWM1NC9lenBEOTlKYXlQRUx2OFlmUEg4NVpV?=
 =?utf-8?B?Y0JiV2w5VjlJdU5McVRha1A2eDhaSzVnUjBjY3I1ekN2eDg4Mk1pdkRQVnk5?=
 =?utf-8?B?OWZoWTJKaXJQN0ZEOUczMittT2JvY3dtaFc1Q29KblJDam5JR1NUcFUyOWVL?=
 =?utf-8?B?dXdNZWV3OFJxMmJPb3BUMkU3a2RJVzhHbWhBVDlWczBoQVRPSVFGQUJDeE1T?=
 =?utf-8?B?c3lMQ3kzUkxSZURBMVo0MFU0UGl4RWp5NGIxS2h3ZVM0ZC9iV3piRTVIMXNZ?=
 =?utf-8?Q?Mb87SkynKXDouVMNNlV0/C2H2CzdP8GdHCJis?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 116e8881-187e-438e-5e5b-08deddcf7510
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 15:33:42.6896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ycq6a3OhlC0Uu0b5EpOVNMjxwKA66+5ZbG/OxDAIOjTcT+KR32Pp7PAkdOzMBaiafXHfA1o/DjKhwecdcelY9/wuJAiuHjCDajQ4qtQY2OJ++iia10OVk9/NsKmCdJZK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6968
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12239-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,NXP1.onmicrosoft.com:dkim,oss.nxp.com:from_mime,nxp.com:mid,nxp.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 166A7732F45

From: Frank Li <Frank.Li@nxp.com>

The control field in a DMA link list entry must be updated as the final
step because it includes the CB bit, which indicates whether the entry is
ready. Add dma_wmb() to ensure the correct memory write ordering.

Currently the driver does not update DMA link entries while the DMA is
running, so no visible failure occurs. However, fixing the ordering now
prepares the driver for supporting link entry updates during DMA operation.

Tested-by: Koichiro Den <den@valinux.co.jp>
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


