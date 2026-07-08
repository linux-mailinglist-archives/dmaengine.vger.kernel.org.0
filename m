Return-Path: <dmaengine+bounces-12133-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3f1cHCWZTmoaQQIAu9opvQ
	(envelope-from <dmaengine+bounces-12133-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 20:38:29 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1AB5729957
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 20:38:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=Y7TB3XjO;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12133-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12133-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 02427308683C
	for <lists+dmaengine@lfdr.de>; Wed,  8 Jul 2026 18:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2788A4D2ED7;
	Wed,  8 Jul 2026 18:35:49 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013037.outbound.protection.outlook.com [40.107.162.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CACD4C957F;
	Wed,  8 Jul 2026 18:35:47 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783535749; cv=fail; b=dqvLiVeiG1SV39pjM3aP3MXZe5Mq9nQmVyWEZ5CmGns3z1k4S6N5+RtcRwBfoptuu6bC4py6gKA3oT24JWx4TfDrun5HpvBPJhT6bpuqyMnQcStz4KLu2Q7JbAuLsSEHM4AZz1rKXXE9lrb+YEYOvcC+DCtS4U/ZQ1q2rZcs2pQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783535749; c=relaxed/simple;
	bh=yvPwnDZmrlh0fwppVe0OLvF3BVWLpT2Y1jXpItnJlZ4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=lwNQGyQACdggZOErFRHW0DO3aOdX6xjxh1peijB99oYG7xYkbHCeD3kSthahnca1vAdDKGo35ZQJpt4y2kdjNznUzS9pgfjjBMzHXB1/eWahMMmOC4khIIxqb06HJOHeJI17UC6IPFp3FBuNmOSMxECjIxBC6X7Xw/Xd6Jtqklg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Y7TB3XjO; arc=fail smtp.client-ip=40.107.162.37
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KZ3nslsbGsFj7YkH+z6rtBDRow6RnAQi3oAyu+VLgMT0adzyK0/H4bVjZEa8RwiZlSwLeptJ6z15o5nTRiKSB/QtQN+9wSVHqdG7F1ym0aH7zoAACWT/0bPwiv9hfSoC21BRffy0F13sQ80OFljQszqNdsRCbJTA8TsjZ6xfLdsDJi1AVYzphRb0CX7PvRhxmfsWBz8TiUHpjBcohNk97ceWbHBaNLfurhaRz2i4eirpQNWFAsG/o8pnqFt3fSxPwfWWy6RNVq+6SxNIBs4Z8M4MGZVHLPjbVqpJwHy7TTm2Ajud2YXV7tnsFSMLIHUQLRjkQcXCSthldd2ep7bAdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rrBZl9W0kqdsiipmliASH33yIMN/jVDBHqiyK7fUMJA=;
 b=H3KlLNA9zAL7MZgy7nkzFaH7/W4OmKlDhED77/YWiSlYKfQCT3agtZv7kv+eoXmjRQrH5G3z+eGr5chCyninhRsqHDvEKdYWMUzZzhC9d0LYHWP9AstGkPCpq8T0nMJYRnWu7D3lyNYWv3wGIKzk6PXIFbfub5sgD9goRswB2ccXd/I53QHXtNgyFRavbvuvJdMRF78/2ZDowlNpMEYV/BaOc7kEc7x/OvuJaF7Cuai0ubxSE23eqfrKuZr0oBGDkRrbEoWH9UZIWSFS+O0WkMURYLG8Q2KV7sdZCsBeUhLFF9qncr+OWe6hjyv2RG1kNEM5CwU4g1fFUnhOaz5G8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rrBZl9W0kqdsiipmliASH33yIMN/jVDBHqiyK7fUMJA=;
 b=Y7TB3XjOfL0Qo9j3wQT9yCwXFR3/9ws7Z+erAD11ymisqAfz5FmT8AB1p/tF2Y/jtIoCDcsq5Ts5WFy7ZFOHYvoSSDeuGk6UEYKPX6nfxvW5/2swYz51GyFPmmO/VHQbpBqx76NNQRu8PbcmoVwWUZPKiKVSJNLyMNPrK5WjtebJMmO3rGxiea/sj0L3XTrbhHIQJcr1CA4fJ/jzQ6PxeIXJZF4frM7jpkQt9ignAzaOLIZ+2i60phmuqm2bzsyze7diAFYK4JMmf5DJDevanvU5yFDglDJr2PbM1a9XsGSBbaB2m7kLsaYIyOL+CW8DdUuhaj6TYnYYr+wuA50vxw==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI1PR04MB9810.eurprd04.prod.outlook.com (2603:10a6:800:1df::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 18:35:44 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Wed, 8 Jul 2026
 18:35:44 +0000
From: Frank.Li@oss.nxp.com
Date: Wed, 08 Jul 2026 14:35:07 -0400
Subject: [PATCH v4 07/10] dmaengine: dw-edma: Add non_ll_start() callback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-edma_ll-v4-7-cc128f0afb61@nxp.com>
References: <20260708-edma_ll-v4-0-cc128f0afb61@nxp.com>
In-Reply-To: <20260708-edma_ll-v4-0-cc128f0afb61@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783535707; l=3682;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=LO3iSgVjP18J5ombaOKncW8om/QRIKrEzKhmIbVez/8=;
 b=gXLhJE+bE9DPFc1ArCABzDd89GkCR5by6ZJhyZNFETsMr4KI5GPOgGMu//e1h2VUfA68o8piL
 C1cG0TWqsXcB/23o0UbXmax/oq2SA4DTrdzjJIkwA/hMXfXDFuU3E6g
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA1P222CA0108.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::29) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI1PR04MB9810:EE_
X-MS-Office365-Filtering-Correlation-Id: 14571ef0-02cb-4ab5-d248-08dedd1fb85e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|19092799006|376014|1800799024|23010399003|56012099006|22082099003|11063799006|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	7RjXWwXcjni5Bj1DiZMVo6szyfLvP/C7UE+NaYCS94eRaZjN2OKB85HfwJB2CyjjgAOgV1FtVVmvuWt5aGznUSX0RSYrYpJFJ7/GDBpnytmneCU513ouCqScZgAPrdcfjYTL3/9lo3zyGxN7ZrDXaDKyK/8Q8gzE5HeJ87Zh3xilCOHWn6EJlqdVTj0EguMT2wI2mne6o2XDaBUsc1JT2vm2zViIYfLbX0553gQNOKb8M3XA6cOpBesGNDDyI56hWc1Xbv7aZzb2Byl+CA09MmsiTv/rd0Y+gshv7i3wF6AHKvzveNpOU5m79VHno2lmfizyyvkdqBZTmiFuyPwn16VTck0F6nvtL8FWKD6+pHXJs3cq/Rh/OTkDP+S0ICHik08EI0RRKjtHhx9Zt/I/YoQkxiV9ZMb4lt5tGkhSIFvJykjHPmGU4/oW8wC4Z8DPMxAls2z0rUcRcTbBWJT7rV/bvlPtT08Ipz+RApguPru3C5DrJddj5HpsPOzSXwl1o2E8DRBIopOq/aEDOWZ/FLYIQjcHnV6WRS25BTbdLw67jaJmPM0/mXgQ+bf4+zGgecXkDtBI80qSUgp8cfbmiVGKZBifTutintFS73Ak6An7ftFRk3OX8y7GyPZVp9eYOFWH0XgHqGgpe42sgt+FB5/j5vmOysKWGUkzeO38HuuMh2gVr4Nq2Egsqo48QIvkuUy7n4XWl3jTGJq3sTDz8w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(19092799006)(376014)(1800799024)(23010399003)(56012099006)(22082099003)(11063799006)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?KzJITlpQY1hZU3h6ZW9oOE9rbTRuRHRValNGMyt0VEdGSFczM0l3a3J0ek5h?=
 =?utf-8?B?UXlDUWtxMERMZ2xDKzdscXptaTBjSCtqd3FNKytQQXlYa21iMmF2SUt1Qmt5?=
 =?utf-8?B?aWVoaDBuQm1jSnQ3T0Nsa09ZSzNYTjJhbVE4OGQyYStJWEREY1VYZzd4OVJp?=
 =?utf-8?B?U1d2dnZrVlllMzhtMGNsdHpDZW82bVNKVUd1UG1WR3p3OEM2R3dMeXliQVR0?=
 =?utf-8?B?VEwxbEhLVEk2MStDMFQ4emE4aXV3bkZLSnJaREYybXl0QjlMRElGL09HZkN5?=
 =?utf-8?B?dzZTc3gyb0xVbTc4enZ4TTRPbU9sQWo4blgvUWZQNTJIN25hNEpSaCtzdmdE?=
 =?utf-8?B?cm1qRDNlU1JxbTFYNDM2UUV0aVc1VDA5bVh5dTVrQlJJMmdWMyt6SkxDZHk2?=
 =?utf-8?B?Wi9VbW9zWXczZFhhTnpSMHN6YUhDaEg4TElwQi9WS3lCUmo3Q2thOVVQRnh5?=
 =?utf-8?B?anFRTU5hREl6OUs3TWp3cHc5YTVDazltRGxKK2x3d2JyUm1Sd0lLWkplQXlH?=
 =?utf-8?B?OHJsckx0R1pHTm9neDA2dlJ1Zituck9XWVQyMTkrMU9aVCtXWVMxcDI1ZDQv?=
 =?utf-8?B?ZWZoSGFSRW5EZzRxWmZ6YmlTOHJNMmVBZFZUZUNoZER5NkZlV0Z6eU4wOFlD?=
 =?utf-8?B?RVVESHV3L1hGamEwNXRJNk1mM0FqZGlPamxrdG9qTmxhQmpsQzZzdFc1d1Fp?=
 =?utf-8?B?UXFjUEJ1OTFtaGNmYS9VcC8zWExtZ2hJcXEwSnpNekVpMytDTmFFMUp2Q0Qx?=
 =?utf-8?B?WFd0QXlBTDlmMm5iR0FSNjhsVWZ5dS9nMXdyRUYwWW4yLzh3MDViZU42b1RS?=
 =?utf-8?B?bStDeHQxUjdPV3ZubjJoZGtaQjJtNWdteVpaL1lMWkJVL0tHUmFwNnVYZUVu?=
 =?utf-8?B?Y2JoSUhrWExGQkplbjJCQXJHRGVGODZOMDRXaEFxeng2TWkxR1NrWHhVeDUy?=
 =?utf-8?B?ejZZZDVHejZhTzZOQW1lVzFyNzlEdEZ5Q3VkcTF3d0p4djlTa2xmVUlIOUJy?=
 =?utf-8?B?ejJMSTU5Z3RlSSs3WVZLci95SzJ4c2gwc0orcmJ6bzdUc09XNzZDdTBVTUtE?=
 =?utf-8?B?YVRVTlVjcVBtR2RGd3lib3RsRWNsUGJkekJIRWdjdm5McituaHh5eHdodi91?=
 =?utf-8?B?UlZaQSszQVZWOENab1Fvbkc0WDBWSDYrTEhIY2J4N1VjR3JnSEJ1bG1TNWdS?=
 =?utf-8?B?Wm5xcHpMSUJ0NHdXZ09lSW9OTWZra1NZZU11VjNTMHg3L1UvZ3hSUy9GR1Vh?=
 =?utf-8?B?WEJSNEtzdlBQWXB0MWo3MjB3OWt3Y2pmU2R5RkR3a01rZ1BiVy9SWjYxNGph?=
 =?utf-8?B?QWVLK1F2QWJFN3h1WGNQNy9LTWxYOHh1dTg2aW5IdXA3UlBvSGpBQWIwTENG?=
 =?utf-8?B?UGYwdmVEcUpWZ2JsM3FUU1RVTkZsMWVONlIzekI3aGl2dElpb01DUnRidE9n?=
 =?utf-8?B?UFZVdDNtWTd5Sy9JWlFLYVBFTkJzVVc2Mm9ONkprWU9zR0lBRCs3NldSVk1o?=
 =?utf-8?B?dWZYU3htZGtCR05XVW41VHBOanRhaHdMckxUQS9tTDBXaEVQNGpsTm5JWTc4?=
 =?utf-8?B?c29HbDZJYUQrNlhyK29GM3ZZK1RQazIwUmE3ZmQvVWt0VGo5NjM2R3lvQjFZ?=
 =?utf-8?B?ZENQZkc4U1NoYURkQjZnUm1mc21BLzRjVjdCUHRpNnhwSjlVMkFUcFRSdXBF?=
 =?utf-8?B?cTdPbmxNYmJrdlpVSzBYYmwzTnlSa2krS3NLZUl5VUZTNUk1U2NqbkU1Qnhx?=
 =?utf-8?B?UW1kRVJYdkllUTF1a28rS0pMamVSbmNNSXRmZ3NKa3RpUU1lMjlPemk4TmJP?=
 =?utf-8?B?RURMbUt5M2c3WERzdVBtekhYaWQ2Q2NGOWJiV3A5WnQ2b3FTS0dSM1ByOEY2?=
 =?utf-8?B?UCtJWHBNZGM3ZE1OQmYxdERncTltQ2J2aTg3SEE4TFUrR1pRTEE3a3VrOGdn?=
 =?utf-8?B?UitIWnF4c3lkTmFiNWpjVjFla01iTmNxbjMrcjdhejduYkJXc2dNU1Qybjhp?=
 =?utf-8?B?bGNkZXBUYXh1Nk5FcUNqY1VqTGM3UFhYYXdTTmN2Z0lzWUF0dGUwOGx3UnRy?=
 =?utf-8?B?ZW42NW0vQnI5aFRmSzZ3U25YbmRiYUh2dWRnbDZlS2g0QVcvVjZqaEF0SDRB?=
 =?utf-8?B?aG5UTzN4NHQzS2FXQXg1K1E1b1V3UWxCVHduVFR5VzhpdW16Z2s4Sjg0MVB2?=
 =?utf-8?B?cWZKRzNFelFBQ3Jka0NXd2g1Um81Nk02QXJJK0oxeWlTOXgxNkxsRzlhL0Vo?=
 =?utf-8?B?UGo1azJpd1AwbHZheG9Ic0w4RmpVRERqN3BFUStZVWduNFA0dm55VHJlNTRB?=
 =?utf-8?B?RWt6TWJ3MHE4clcramM4eFljTjVUaWMxSUY3UGtCMFpQNmtyeHdXNjB1Sjda?=
 =?utf-8?Q?XeNsHc+8dbnTEYGh15Om1agPgpfC0lZL+3vyr?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14571ef0-02cb-4ab5-d248-08dedd1fb85e
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 18:35:44.1763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lfFdSKxf1F7TUQciWXLpmwLaJ1YYJCst4yEnVljgjioxTpkdl1wqMzumnMSF1J84CAIL1ID1aiGssKqZX0B/U+SFZ633QS0HhvTvb1UTBLew2n8/Wsnv5iaZ1XI+2R33
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9810
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12133-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.nxp.com:from_mime,nxp.com:mid,nxp.com:email,NXP1.onmicrosoft.com:dkim,vger.kernel.org:from_smtp,valinux.co.jp:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D1AB5729957

From: Frank Li <Frank.Li@nxp.com>

Add a non_ll_start() callback and move the common non-linked-list channel
handling into the EDMA core so it can be shared by both the EDMA and HDMA.
Prepare for the upcoming reorganization of the burst and chunk structures.

Tested-by: Koichiro Den <den@valinux.co.jp>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v4
- add koichiro tag
---
 drivers/dma/dw-edma/dw-edma-core.h    | 12 +++++++++++-
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 23 ++++-------------------
 2 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index bab4d49c92feb..e18d6e827c2c9 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -126,6 +126,7 @@ struct dw_edma_core_ops {
 	irqreturn_t (*handle_int)(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 				  dw_edma_handler_t done, dw_edma_handler_t abort);
 	void (*start)(struct dw_edma_chunk *chunk, bool first);
+	void (*non_ll_start)(struct dw_edma_chan *chan, struct dw_edma_burst *child);
 	void (*ll_data)(struct dw_edma_chan *chan, struct dw_edma_burst *burst,
 			u32 idx, bool cb, bool irq);
 	void (*ll_link)(struct dw_edma_chan *chan, u32 idx, bool cb, u64 addr);
@@ -201,7 +202,16 @@ dw_edma_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 static inline
 void dw_edma_core_start(struct dw_edma *dw, struct dw_edma_chunk *chunk, bool first)
 {
-	dw->core->start(chunk, first);
+	if (chunk->chan->non_ll) {
+		struct dw_edma_burst *child;
+
+		child = list_first_entry_or_null(&chunk->burst->list,
+						 struct dw_edma_burst, list);
+		if (child)
+			dw->core->non_ll_start(chunk->chan, child);
+	} else {
+		dw->core->start(chunk, first);
+	}
 }
 
 static inline
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 16fe3ef43948d..641a513bc52e7 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -272,18 +272,12 @@ static void dw_hdma_v0_core_ll_start(struct dw_edma_chunk *chunk, bool first)
 	SET_CH_32(dw, chan->dir, chan->id, doorbell, HDMA_V0_DOORBELL_START);
 }
 
-static void dw_hdma_v0_core_non_ll_start(struct dw_edma_chunk *chunk)
+static void dw_hdma_v0_core_non_ll_start(struct dw_edma_chan *chan,
+					 struct dw_edma_burst *child)
 {
-	struct dw_edma_chan *chan = chunk->chan;
 	struct dw_edma *dw = chan->dw;
-	struct dw_edma_burst *child;
 	u32 val;
 
-	child = list_first_entry_or_null(&chunk->burst->list,
-					 struct dw_edma_burst, list);
-	if (!child)
-		return;
-
 	SET_CH_32(dw, chan->dir, chan->id, ch_en, HDMA_V0_CH_EN);
 
 	/* Source address */
@@ -324,16 +318,6 @@ static void dw_hdma_v0_core_non_ll_start(struct dw_edma_chunk *chunk)
 		  HDMA_V0_DOORBELL_START);
 }
 
-static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
-{
-	struct dw_edma_chan *chan = chunk->chan;
-
-	if (chan->non_ll)
-		dw_hdma_v0_core_non_ll_start(chunk);
-	else
-		dw_hdma_v0_core_ll_start(chunk, first);
-}
-
 static void dw_hdma_v0_core_ch_config(struct dw_edma_chan *chan)
 {
 	struct dw_edma *dw = chan->dw;
@@ -399,7 +383,8 @@ static const struct dw_edma_core_ops dw_hdma_v0_core = {
 	.ch_count = dw_hdma_v0_core_ch_count,
 	.ch_status = dw_hdma_v0_core_ch_status,
 	.handle_int = dw_hdma_v0_core_handle_int,
-	.start = dw_hdma_v0_core_start,
+	.start = dw_hdma_v0_core_ll_start,
+	.non_ll_start = dw_hdma_v0_core_non_ll_start,
 	.ll_data = dw_hdma_v0_core_ll_data,
 	.ll_link = dw_hdma_v0_core_ll_link,
 	.ch_doorbell = dw_hdma_v0_core_ch_doorbell,

-- 
2.43.0


