Return-Path: <dmaengine+bounces-12407-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2lp6M6saVWr9jwAAu9opvQ
	(envelope-from <dmaengine+bounces-12407-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 19:04:43 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7E874DD8F
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 19:04:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=WHxIG0aw;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12407-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-12407-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 86044301C6E4
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 17:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3733438AB;
	Mon, 13 Jul 2026 17:03:59 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012001.outbound.protection.outlook.com [52.101.66.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B35D33F8B7;
	Mon, 13 Jul 2026 17:03:57 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783962239; cv=fail; b=G7rPd/kL/zHpMkN79qpUQMGltU+l3AqyZ6CO9vKsx+BVV01dT3R7GEmrVvgdbDr7mHU7s4cEfo+90mcnLb9LrcPwmxBgruG+FMyJD2O7Db23FmJwfiqK+z8ZZudXAccE+EINAuNp27qV9OV9WVe9kF/rdQWnMMyYnRcJwQiApbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783962239; c=relaxed/simple;
	bh=CRItB+1fulewQ1KoXTqdqVMTtqDzIaLrROB9cMKEeHA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=P1UyoIqKGb9k0SAnLkY/jaB3uS626DwVMMY5aVa7Z+6e5bUXTC8/YvW7fPxHPK6aTSgny+RlATBMpS/N4lNo7l8PIHXKQbvdte3lE0w6EeuvM6d2rak7ciVMK0J839lZaPOmptMU1bzOfRhH5cG6yt6rBDfMrMly4Bhi1w80ipg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=WHxIG0aw; arc=fail smtp.client-ip=52.101.66.1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dC51pwq7gtQytNZxFPXSYaaJkxuzsMpZeM37BaqcYz+HLif/nvHk1ZOHqzly0eZGN5keP1RBn3jVguodqyjpNymVvpbUv5oqlNo7GeIBo2cKXje73igYj5K1K1jDVPR0GB5QxYBRB1Kq7AjuhXyCAHVZBXzQe1NADUFKWaUF5v17WO8C6rZ8+LIMHGzaGpsfx49kljkgA51xtnUFSxdGjaSAfk34/m17C/r/RwOpysAg62SFOMv6Ak2cznZCBPTqo+zgW7JF6dAaueGHrK4ljC2RQm6ZyiGLfWQz7drEkxIo1UfnRYG/QG6dLXpzADKD2ecPb0Zyz+BPFUVWF3r/GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A0HYdoCHDVVqPT2A/8bJ2VXDlGvMBZhfxuZvYBmiLeI=;
 b=JkBwaJ2AajcPPNRaskRwqdgGEjO3dtmVhuKz78dPprU/5iYIVdijFQxndgf2auqUJITwc/OWWGp2xjCwuEsfvFYXnYede8sxU6R8zCTA6MacJaHciutT7GYRhine4oog1q0ZF7t7xhy5zRssPbUBB9G/FSwyf5PEccwxA0mgzefgckOLjZkkKLWgFS3ETKqtvDVizkK+BKrqyIyqXG2OCo1AI8Sde/ReS8baxpgVeGfxUUeKXNfviaTxqGPy0jAm7pFrUWADF8D0ydhCIDBcQHKwjTjJDHmnBVo75998Jy/dt7+ry1+8NNa0Wp8Qw2cK1cI9C4q84idHVuaKEyLIPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A0HYdoCHDVVqPT2A/8bJ2VXDlGvMBZhfxuZvYBmiLeI=;
 b=WHxIG0awEFwcDcaYeUn3yS6lD/xKnX8R3zew41qDLYZHs6gzDtHbkn/BlrhA04cZ0f4ePOgvSK9TxHhwGSLZRey6Z+RjV4UIUXSKO6ACMeB0bLn5bsGRIBvbiB8IWYZgfucAzxNOI+FtSvVgCLy2O6r2zPN3aQOkF9vkoFIf+eo6vd/jCap6sRyKKC3uUkZw/i4xpuX8Y9hkTogmpSzrMXGTgJr7SsUJCGOTEPe0QjU0ezc0K64+qu8yEXB5c964eu41O/3SJK+8Ci5HiF6A86t2+fae7jGchXygCcpTXT1aWqPiFH6sd4LI2MnybfNfK/bMA29sdAmlgF+uahmNFg==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA1PR04MB10228.eurprd04.prod.outlook.com (2603:10a6:102:454::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 17:03:55 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0181.019; Mon, 13 Jul 2026
 17:03:54 +0000
From: Frank.Li@oss.nxp.com
Date: Mon, 13 Jul 2026 13:03:24 -0400
Subject: [PATCH v7 06/10] dmaengine: dw-edma: Add callbacks to fill link
 list entries
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-edma_ll-v7-6-6fb7498c901e@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783962202; l=6462;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=rs5l6wPLdrsI8W14mvik91/05jmfzlZQq4zCM/GjM8U=;
 b=rTiZt5ARSi/0Z414KBEz61nvT22Pa+bUgCSZlxEHLBeeOiLSFgkktW+z9KfNKii17LJ+nHjFg
 TMJPgsr9HDbBPUN6UTnZmeOk1fyTc80Lss80yGnWIFNF9W2j7vJ6xUI
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA1PR04CA0016.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::21) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA1PR04MB10228:EE_
X-MS-Office365-Filtering-Correlation-Id: bf5a6e3c-5280-4029-b1fa-08dee100b897
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|19092799006|1800799024|921020|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	fzzJZEXLAt0UJ8jBqFdtV9U2eL4qelCgF9Y8sSqsqRBkd12KWqWi4+UgmzgFXim8EzWWHKGtXm1TCal8iMsjZKAwjDrB/ovAILmHy/44UvRblOg/BlDa8FwjjqIiqWElFtXKkBSoeKDK+G3sJFbG69n9+FFO0/iOPA/05lDSVsvJzdtM0/Xzcr89AjOL1ZNlvHplI4WkN83w98AFzR09eHE7YQccoqPCiKblX/xNxPlbVA20TrYVr9TEtUf45XEljeRkPA8KXoZSLJhogLKq+yHxLIU1PvxKTIB8rNJkn0T16tLo4PLkXKh43pcQYzYfDiea5WzwLqcrHq5gSwkNXSfNyQrtFr4r2wuFMcylJdTCb3fhYOz/Yee1/hYCtY4isLmmrr478YDPuiG1QOSo3xMMxsZwyZQukyZwozpKmvRk1xgKAvp+3SN5UiU3PrdtXUq2vEe93xWb/+39PFSdkjlSiD3PwLhj+BynHANUMEXrzJYOa9AT0Udf9mPSFZLgbnzbCvv5BAFCFWP5+0arDEjVq6uQGAgdi5UX3rhUqnWQ3fuCpIW5MJ5nyqlZUYH45x4VlBT8DYfqijHsnvi8jUK3VRYg7YxMclnMpMV14vzqu2BCb2Z92/MviQhjnuPyM84Td2uOJeGxciV0kxZ+/hwCG+Na2iQwZOgs7DGYt1PMPdozItE3egOzgJOZcfQ1g+3SjlnxexciS2X8Oghsxw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(19092799006)(1800799024)(921020)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VU02L2puaW93U3JUWmZvT0Q0VE1ITSsraGZ6RTlpbERrN3lZazdERjBhUVBB?=
 =?utf-8?B?ZjZJYm9WV3AzL1hOZ2NsM2VCRjZaZ0VpaThIa2tRZHY2R0h2TmhZUUF0Y1pi?=
 =?utf-8?B?ZUtobTJFZGtKaWRvalBMNkRrSmdGUnkyMDNJVS9UdHhTU1pBS013eHFudklM?=
 =?utf-8?B?bHIwUVJJWU1yYjFPKzBHQzZWTG95L0dOWHBzUUM0S1ExT09YdVQvL3lNaHNp?=
 =?utf-8?B?Ymhhbkh4WnB4bjNLdXBTaStMZlVqWTlGQ0Y4Zk02cXFORFZPVHJVSlZMSEsy?=
 =?utf-8?B?bnNLZkE1cXNhUEJpbTl0S3R2NHhnRVhvdHI4cEc1Tjg5ZDBXQUlVcmJ4N3VJ?=
 =?utf-8?B?WVREY0ZmZ05xUkR2ZEIvYkhaOXdTUTlERUE0eTFYUWc3dnlYNEtDcitFVkww?=
 =?utf-8?B?LytiTmRnZVVmVkw0VXBxQnQ0MkNYR2w1d0trdHdvMjRNVGhONlloUmNNMnRD?=
 =?utf-8?B?ckVWcGxyQWJ5R3FhNDc3WkVpYlVyZDM0SUdRMTFvMGJMak9TK1h3cFdvaFpU?=
 =?utf-8?B?SGhaRU0wbEcwRUk1SXlPTE0wSmtGZFBjOFNWSTlSSWpxYWtuaEljd1ZFTUFl?=
 =?utf-8?B?Nzc1clZON0VNVzkvc3hGSVBIWEhVTjZCQXNEcTNhUVZqUGJHTHBSQmNFUENH?=
 =?utf-8?B?U1hxNFg2aXRzNUJZS1EzYWdWOElyUStlc1l1NlpzQjN6VURTdDRtQ2Y5dy93?=
 =?utf-8?B?UHVyaHB0TXg2SndlbElhb0VDYXMrcmVBQ0E5ai82bmtIUG9SOWNwajFUdTlE?=
 =?utf-8?B?YjAzWi84ODlDdmRRZHRvSFhWVEtRMlJUZjRqT3FBd3hvRDVGQ3ljQ1VLL3J2?=
 =?utf-8?B?TUhqV3RwaFBlc21wTUVVVjljL0RRek9hVkVzQVIvNWtWVWREVTdBYnN4Nktn?=
 =?utf-8?B?WTBaVysvNFQ2SWNTYUZvS2oyMk5JYzF3ZlpZWXJJTmxDUjkxQmtQM3ZHclVR?=
 =?utf-8?B?NEFsMnRQK2Y2T3FUa1B2L1RubkpCZ0xyVXR0WmtvNHN2ck5OUXV2ejJDUHJz?=
 =?utf-8?B?T2h1Q2Z1clI2RVFjd213dGoxSDR4VXVSZjVXejI3NHQ0aCs5dUM1TG5NM3lv?=
 =?utf-8?B?d1o0R2FGa0J2VVBCNUFBRmYzMmZwMlhPNTYwVmZDM28rbElLczJ2NEtTdzh4?=
 =?utf-8?B?MW9zUEZ1QUFYTUJUVFZ2TEdaaGZMZnFhREFHVmswa3BTUFhFYTd1YVF4dktY?=
 =?utf-8?B?ZStnM2pTMVcza1A2L1h2WWtvZkptVjhRTkhXQk56SmQ0dXpNbEhhTnJjcDVs?=
 =?utf-8?B?RUJSRHY1b0E0dWdwb2dYOUU3OWNDV0pHNytqeEtyemVjN1JmRVZINGEyNndo?=
 =?utf-8?B?cnlsaTljUiswdUorZzg4S2lRbmF0aGFtRHBsLzc1VFBJaXNlNTM4YS9iK0hl?=
 =?utf-8?B?MURLREw2bmFEU2hCMG82UEtMdWdBc2doTmFhUkZIdkdJZXBlRy93WldhTVRy?=
 =?utf-8?B?Q29qRkh3NWlKV3hJT05sSktPYzdsWjlXVFdWL0NZbEZFeFJYRkFOaW1GdUpp?=
 =?utf-8?B?MUN5S0Z1ZURXTkg4TnVITFNDQ05ZVnJSUWRuWnRmNEx2MEpJS3lFUytnd083?=
 =?utf-8?B?Y095NzlpUDNzOUVSSmdhWGtPOUhwQnplZ3FxS2huL2UyOUdMRG9tazh5MkF6?=
 =?utf-8?B?WGxSa0hBQjlxbmY1Zm5UbDBQU3hRSmR6cktlZHFIdnJNODRFSk9yZWJadURX?=
 =?utf-8?B?Z29IZTJaUDgwVGpQNit0cFQ1L3dKRVQ2MWEzOGI1TzltMVd5OHVyWmpKYjNx?=
 =?utf-8?B?cmE4YVJIYTZQNWJrTGYwSloxVytpT1pqQk0yMVlQRG5WNTg2b1JORCt2aDlX?=
 =?utf-8?B?b1Q3Nk1VTFNGM2lNMm5vNWNnNEw1T0tDMnlNcUpUNkRoMzhvTHFSRCtNa0l4?=
 =?utf-8?B?VE5mR1RxWE44OC9Md05lWkxjSGwrTkZjeStLZkRKc1RCUGU3THZWNVR3QUNl?=
 =?utf-8?B?eFBvNm0rVjR5bnJGRVNFZUZwMFdEcVQ0V3Rjc2JtSC84OXFWUDNtZ3BEck15?=
 =?utf-8?B?MVpoM2xIbCt4bytBQUlMK1JLaWpSMjB3NWZwTGJZZWY1OG02bVhZZEJoajlL?=
 =?utf-8?B?aHVhdXR0cS8xMnhwNzh3dzFVTTAzd1oyRnZORGtEMTcvaWIvNkNYWWE0QVlT?=
 =?utf-8?B?WTNtUGtLbVYyL0tSZXlqSU5CeHRSRi8yZnkyM1BlTkJMTWY1VVkvcTM1ZlZP?=
 =?utf-8?B?SXNoZ08rQVRxSWdrUnpzSzZ1ektLeDU4eTZMSzh3WkNCNlpKMXBQR1ZGbXZm?=
 =?utf-8?B?RzRBQ25pcHNyY0lWRXNDRWxINm1hNEdTMUlJVFo2b2dzQVFlWEw2SzFxcS9X?=
 =?utf-8?B?MGZDbU8vWlluTXVrbjV0NUFyNGdIa0gvUHhZOGdSalpXb1Rob0c0bzNZZjRi?=
 =?utf-8?Q?xp718kyHnbo0COqni482oxlon7Y9coqku8G8E?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf5a6e3c-5280-4029-b1fa-08dee100b897
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 17:03:54.8793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6jqdKAJK2LzIblZba/Fv0ft3g7HQ0OSPdyWHTUZA1oAvwbcAecsAZXU8n0D7sh90Wv/2RCWY+BsAT286KBW92o+jnU0bAkk/L8v0zKfroXFVLLwAojiqmDieiIiUX736
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
	TAGGED_FROM(0.00)[bounces-12407-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,valinux.co.jp:email,nxp.com:email,nxp.com:mid,NXP1.onmicrosoft.com:dkim,oss.nxp.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6B7E874DD8F

From: Frank Li <Frank.Li@nxp.com>

Introduce four new callbacks to fill link list entries in preparation for
replacing dw_(edma|hdma)_v0_core_start().

Filling link list entries is expected to become more complex, and without
this abstraction both eDMA and HDMA paths would need to duplicate the same
logic. Add fill-entry callbacks so the code can be shared cleanly between
eDMA and HDMA implementations.

Tested-by: Koichiro Den <den@valinux.co.jp>
Tested-By: Devendra Verma <devendra.verma@amd.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change in v4
- use argument in dw_(hdma|edma)_v0_core_ll_link(addr) to set link to addr
report by sashiko
- Add Koichiro tested by tags

change in v2
- update commit message
- use eDMA and HDMI
- keep inline to avoid build warnings. dw-edma-v0-core.c also include
dw-edma-core.h
---
 drivers/dma/dw-edma/dw-edma-core.h    | 29 ++++++++++++++++++++++
 drivers/dma/dw-edma/dw-edma-v0-core.c | 46 +++++++++++++++++++++++++++++++++++
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 38 +++++++++++++++++++++++++++++
 3 files changed, 113 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index b96089baf0f9c..bab4d49c92feb 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -126,6 +126,12 @@ struct dw_edma_core_ops {
 	irqreturn_t (*handle_int)(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 				  dw_edma_handler_t done, dw_edma_handler_t abort);
 	void (*start)(struct dw_edma_chunk *chunk, bool first);
+	void (*ll_data)(struct dw_edma_chan *chan, struct dw_edma_burst *burst,
+			u32 idx, bool cb, bool irq);
+	void (*ll_link)(struct dw_edma_chan *chan, u32 idx, bool cb, u64 addr);
+	void (*ch_doorbell)(struct dw_edma_chan *chan);
+	void (*ch_enable)(struct dw_edma_chan *chan);
+
 	void (*ch_config)(struct dw_edma_chan *chan);
 	void (*debugfs_on)(struct dw_edma *dw);
 	void (*ack_emulated_irq)(struct dw_edma *dw);
@@ -204,6 +210,29 @@ void dw_edma_core_ch_config(struct dw_edma_chan *chan)
 	chan->dw->core->ch_config(chan);
 }
 
+static inline void
+dw_edma_core_ll_data(struct dw_edma_chan *chan, struct dw_edma_burst *burst,
+		     u32 idx, bool cb, bool irq)
+{
+	chan->dw->core->ll_data(chan, burst, idx, cb, irq);
+}
+
+static inline void
+dw_edma_core_ll_link(struct dw_edma_chan *chan, u32 idx, bool cb, u64 addr)
+{
+	chan->dw->core->ll_link(chan, idx, cb, addr);
+}
+
+static inline void dw_edma_core_ch_doorbell(struct dw_edma_chan *chan)
+{
+	chan->dw->core->ch_doorbell(chan);
+}
+
+static inline void dw_edma_core_ch_enable(struct dw_edma_chan *chan)
+{
+	chan->dw->core->ch_enable(chan);
+}
+
 static inline
 void dw_edma_core_debugfs_on(struct dw_edma *dw)
 {
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index 8d38867cd9983..c0746e5351410 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -509,6 +509,48 @@ static void dw_edma_v0_core_ch_config(struct dw_edma_chan *chan)
 	}
 }
 
+static void
+dw_edma_v0_core_ll_data(struct dw_edma_chan *chan, struct dw_edma_burst *burst,
+			u32 idx, bool cb, bool irq)
+{
+	u32 control = 0;
+
+	if (cb)
+		control |= DW_EDMA_V0_CB;
+
+	if (irq) {
+		control |= DW_EDMA_V0_LIE;
+
+		if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
+			control |= DW_EDMA_V0_RIE;
+	}
+
+	dw_edma_v0_write_ll_data(chan, idx, control, burst->sz, burst->sar,
+				 burst->dar);
+}
+
+static void
+dw_edma_v0_core_ll_link(struct dw_edma_chan *chan, u32 idx, bool cb, u64 addr)
+{
+	u32 control = DW_EDMA_V0_LLP | DW_EDMA_V0_TCB;
+
+	if (!cb)
+		control |= DW_EDMA_V0_CB;
+
+	dw_edma_v0_write_ll_link(chan, idx, control, addr);
+}
+
+static void dw_edma_v0_core_ch_doorbell(struct dw_edma_chan *chan)
+{
+	struct dw_edma *dw = chan->dw;
+
+	dw_edma_v0_sync_ll_data(chan);
+
+	/* Doorbell */
+	SET_RW_32(dw, chan->dir, doorbell,
+		  FIELD_PREP(EDMA_V0_DOORBELL_CH_MASK, chan->id));
+}
+
 /* eDMA debugfs callbacks */
 static void dw_edma_v0_core_debugfs_on(struct dw_edma *dw)
 {
@@ -540,6 +582,10 @@ static const struct dw_edma_core_ops dw_edma_v0_core = {
 	.ch_status = dw_edma_v0_core_ch_status,
 	.handle_int = dw_edma_v0_core_handle_int,
 	.start = dw_edma_v0_core_start,
+	.ll_data = dw_edma_v0_core_ll_data,
+	.ll_link = dw_edma_v0_core_ll_link,
+	.ch_doorbell = dw_edma_v0_core_ch_doorbell,
+	.ch_enable = dw_edma_v0_core_ch_enable,
 	.ch_config = dw_edma_v0_core_ch_config,
 	.debugfs_on = dw_edma_v0_core_debugfs_on,
 	.ack_emulated_irq = dw_edma_v0_core_ack_emulated_irq,
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 31bbdc6a40642..16fe3ef43948d 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -348,6 +348,40 @@ static void dw_hdma_v0_core_ch_config(struct dw_edma_chan *chan)
 	SET_CH_32(dw, chan->dir, chan->id, msi_msgdata, chan->msi.data);
 }
 
+static void
+dw_hdma_v0_core_ll_data(struct dw_edma_chan *chan, struct dw_edma_burst *burst,
+			u32 idx, bool cb, bool irq)
+{
+	u32 control = 0;
+
+	if (cb)
+		control |= DW_HDMA_V0_CB;
+
+	dw_hdma_v0_write_ll_data(chan, idx, control, burst->sz, burst->sar,
+				 burst->dar);
+}
+
+static void
+dw_hdma_v0_core_ll_link(struct dw_edma_chan *chan, u32 idx, bool cb, u64 addr)
+{
+	u32 control = DW_HDMA_V0_LLP | DW_HDMA_V0_TCB;
+
+	if (!cb)
+		control |= DW_HDMA_V0_CB;
+
+	dw_hdma_v0_write_ll_link(chan, idx, control, addr);
+}
+
+static void dw_hdma_v0_core_ch_doorbell(struct dw_edma_chan *chan)
+{
+	struct dw_edma *dw = chan->dw;
+
+	dw_hdma_v0_sync_ll_data(chan);
+
+	/* Doorbell */
+	SET_CH_32(dw, chan->dir, chan->id, doorbell, HDMA_V0_DOORBELL_START);
+}
+
 /* HDMA debugfs callbacks */
 static void dw_hdma_v0_core_debugfs_on(struct dw_edma *dw)
 {
@@ -366,6 +400,10 @@ static const struct dw_edma_core_ops dw_hdma_v0_core = {
 	.ch_status = dw_hdma_v0_core_ch_status,
 	.handle_int = dw_hdma_v0_core_handle_int,
 	.start = dw_hdma_v0_core_start,
+	.ll_data = dw_hdma_v0_core_ll_data,
+	.ll_link = dw_hdma_v0_core_ll_link,
+	.ch_doorbell = dw_hdma_v0_core_ch_doorbell,
+	.ch_enable = dw_hdma_v0_core_ch_enable,
 	.ch_config = dw_hdma_v0_core_ch_config,
 	.debugfs_on = dw_hdma_v0_core_debugfs_on,
 	.db_offset = dw_hdma_v0_core_db_offset,

-- 
2.43.0


