Return-Path: <dmaengine+bounces-10582-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEbDOrQvDmoK7wUAu9opvQ
	(envelope-from <dmaengine+bounces-10582-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 00:03:32 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3C559BA99
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 00:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 255EC304641C
	for <lists+dmaengine@lfdr.de>; Wed, 20 May 2026 22:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1DD3BCD0B;
	Wed, 20 May 2026 22:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="aOCmyHrK"
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013023.outbound.protection.outlook.com [40.107.159.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FAE3B530D;
	Wed, 20 May 2026 22:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779314482; cv=fail; b=bIF7x3+ot6fy9FL0wx0HQXc+DMPfRR+JFIblnhqmqxL4Y7CWapFoIPOMvUj6FGwn79rtTbfqNJDm80NqyNfYdTbDnfoWOaOGIfYwqZKBYlK6y2a1q6J5rNa0ZotAOzTkDjAKf19nwgZHpcy4gSZzPBFQbTJWGH6NCSVM3dx1slg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779314482; c=relaxed/simple;
	bh=iIX53NjUCPF1mDIkG5DU7PMIW0Upf2qtAbp2L7cxMh4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=rP4D+WrpvhVHgso/Hy4x/XAmP8R1/Q/T5qo9wMGVY8n3hqX9aXVt6tvUHkLTeu/inmBYm0bD/3CLSf3+pnb8XOhrjYWE7y7Q+TyHNkfi6dIfewNQketW5+NAT5CWNZWIF9EgitDPEz4Y2GL3N0MMizNrbTHGmvBKG7IwN6Y9SN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=aOCmyHrK; arc=fail smtp.client-ip=40.107.159.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wE4EEMP2cJi1iI+FGKl/me071FkQRUigJpSl3h05lEtcgVQ8eFEIA4/h5RrIPdoVqOb6rLGdu1eFqS0J84nZqS9aSOIoCl8+V7xC19qmJpcRk4n2h0SpIskyuREy0Ec6l08NR3SBM3H0zm7KmJFEPLLs8rH3/4DCK+MlI7BdmSp8Idl66i9Ac4xAFBU5asJJhHmcrxm9OPtrjr7UZkJdI6GLYOMZYMgX0aO5ff6XElruNoh0jWxEBCXy9hkwje3zXChzuw7gDupyaLGsumE59iUi0ojGRm3/gyE/vFXRZGU08YmxlnHYJY6esWGX10qsPIbQVm7pxe1peCfbpfXgfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=37bcc8TfgjTqfML06R1EwTBVyj48QWZJKxW9EQbmuWU=;
 b=tc80DvsvK9A4H8luuGHEjpyUH2aIgQHqpkas50eWnxjBTc5FfzWrNx7Ni3uBxCYvjvvzBnykge186oV6t1UI0d7EtbhMIXZdqCUCSKJ6uaMFq4aqp+lK79Jbtfbrn7nFedsRoGLVd4Y+nLRCF5gY37N6NgEFSY1NENGsXGquurLmgw6MbI19Fg0UZ1s3R7ATh/75Ilbi4kYGP3ZWXNXhBoC2MPjKAgKcEq7jfAyB+QHooxkKwxd5n8fswcCzAAZaCC3aDTRgiiVt5OVM5tmDtxOUldsORc02RcaErx5QTLlxYg/Zl2tQhK5zhp2gtK1sbmFO53O7fzubC6JX0N1TZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37bcc8TfgjTqfML06R1EwTBVyj48QWZJKxW9EQbmuWU=;
 b=aOCmyHrKsOQLAgt8AkYMCujRkagsMgO5iDAS3qYhM0EnzAlN/ccoXiww/HwhQpoCOKVF/bx4D8dUvg4E/2IAvIUGs2/AfP8ZmjMsg5/Gp1cbuBFsxrsIOHedgQ4UyoIo+yvjoC3XUsmjo9BcEsKuS2uo/LmAa1HlQbIe+xbELxTuemJg458RBrdIgjrBFBLLGpLIUOLNNubk7MFnE25R5ooWPb7Gclxh5J0+yL38xtqeThVLIOT6aR+7YOzfBcd6njZMsVPxZ1Rc0TiEsGsghMTj8OWC1mQkyRmgPQVyp99aQu+KuviPKP7yU6ehdS7o15HqzMZenlukydTn96GLew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA4PR04MB8029.eurprd04.prod.outlook.com (2603:10a6:102:c9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 22:01:12 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 22:01:12 +0000
From: Frank.Li@oss.nxp.com
Date: Wed, 20 May 2026 18:00:46 -0400
Subject: [PATCH v6 5/9] dmaengine: dw-edma: Pass dma_slave_config to
 dw_edma_device_transfer()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-dma_prep_config-v6-5-06e49b7acb38@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779314446; l=3048;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Bn5aqmUeZY3ewFQKEdMEUfnmGy7LGfvlckh7nlENc4s=;
 b=F0KFii2Tc3R+5dTVy5UoTKU9p7MLoQOurXZT7Niu2tWJKrsSxPcV8ODOpwpwMMbh/4no2loFZ
 aLjdsU9GwzfBGEWFixLTCqqbFREAru0liqmZY78Q7KwB6KMagPAUafK
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH7P222CA0002.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:33a::21) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA4PR04MB8029:EE_
X-MS-Office365-Filtering-Correlation-Id: c3e4ef67-c8da-4fda-aad3-08deb6bb4e17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|19092799006|921020|56012099003|18002099003|22082099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	EAd2XDGNlKf76+nYEcM2YwCpLnG/0fZYDjsEA7Luzza80983USt1G15oYGH+igNZNAOMhcV5vtqniz6qj8GUkVX33AW/UvkXi1Dq0cUJO0UCwnA6j+kfJyFWmW1F57jlcLjD2v9Y58S8xjOC5y9/zNA74EewhF3nSC897qZ19kza0dxhwg5lPPnAmcv4TH9n5mgdZbjJZT8toy9NNKkRdAk2quYB8J8hi/sZ7IhGhTagx9T1lQHPBO+vcr33TlyvF+71j5o1XZ8R1sPwFqwFb0XpzPdoOyz+cVVSA5+ZUmoF8lu66FzHru/GC1/NWFESN0nKsDcbpE35YTZU713RABhnFmIXYhXV3mxZxVwDL/96U+LInFJUgojLUYYgeg3Lt8pzvSZc33Xl1LU7jggfk+3kCbslK7jMV9VOuy6juJZpW2pSbJuBcrRlJraiZZ3fSxqhoNPDc++szkQzk0cWnsTl9EbMHnQ9ZwBDus8vZ37IfOVEICQfSjcINi1lbf/d5VWvdaVrtMrGh7ilCNcG7Pphoa/LL8dJABy4zu5IHcWQXTdjYuyp9jXvrAvnO9GQ7Lpy/Gi5f6oI9t1gXVRmQuOMRojQkz9Ab00PsTQoYBK6PIp6msD7W8q+R1QYJExKmy9tCzCAYzbDqI6vXAX1wc+qDP6EhGrJevHBfMyIM7WgoHUX3fm6Qc6f4wlNJpfbZeIkKG37CXodPnY+pmpAKXAP+d2Dg4Xt7od/H2gpURw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(19092799006)(921020)(56012099003)(18002099003)(22082099003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QW1JYjBXamJpemV1SEpWbzdhQ3IzS0t0NzYrWnZEdVVuMUZzT2hDMUltYmto?=
 =?utf-8?B?WVdTSEp5dE5nd1FRc3NHS3NqUTRxUkExdkpmaWdpdFl6WHRXMm1XZUJvRnJR?=
 =?utf-8?B?OEZ6SnZMQitPQTNDczF0WDI4RmdBU0F1RzlnWVJsTUQ0NUUvc3hNUDJqVDZY?=
 =?utf-8?B?WUhYdXlDOXdWYXNZZTlxMENTaHJ6eVd3T0JPQkFHbDZ3T1VVYUxjUmdsS2Fi?=
 =?utf-8?B?d0xJcEp2OUxYd04xbUhORjV5TGhEN2FNaUpNVTloMTFjM3FpWXJBRHp1Y0lz?=
 =?utf-8?B?bFUrL2tKVmhiMS9rTVEwMWF5RzA0Tjh5dmZBeE1JLzVhS2htM0RUa0g5WFBE?=
 =?utf-8?B?eUEvOE45dWl5NWUxYzJyb2d3dGRoMVZJRW1mV2x5cWNJNkJKMWdtUEw5MkRS?=
 =?utf-8?B?VEFlSEtDeWpWYTBMSlE4WjlkTW1CUnpBMElsc0pWMzZwQVpESlo2cHNZMzVw?=
 =?utf-8?B?eVdsZW02d2NBOVFIRXExOElpTUVRVGorQTkySCtnQnhwVjNaN2h5SEZ6ckQ1?=
 =?utf-8?B?ZlZkWW9yZzZTNExXY2R5UFRHR3gwSjlJNW5GdDVmRVBlVFFobGhTTmdDSGVV?=
 =?utf-8?B?YUVCL00yM1pyd3dzdjEzcGdWM0lDMDQ3L3V5UHZjZG9OTkVYS0V2ellIVlJk?=
 =?utf-8?B?MnRpVFh2dkQ2U3pMTlpkZG1QTEl5U0ZwdFNrcVZzNFkvTzJNLzMzd0pvOGVt?=
 =?utf-8?B?YU1NeStmMk9MbzMzbnpOSHBkUEdqS0laKzNKQzc2a29xekw5aDI1ejNmckpv?=
 =?utf-8?B?T0REZlBFRWk0RnVWZjQrbEl2QkpreUhQSTJoY0RGV3ZtUE5DTzBYMWVpbkhX?=
 =?utf-8?B?YWN2d2xMR3FXUDFuWkNLVnRrWkFQeTF1L0xVS085WnBjbHNpSmtnSkFhanMw?=
 =?utf-8?B?Uys0VHIwMHVzVm8zejAzT2FEV081WElTMjlKZFZnUmtuSzEvT0tYMjZPdjVP?=
 =?utf-8?B?MmdLS0I5WDYxeDdMNHdoTkZHQVlVeU1HNzhVQVZRN2E2dXhrS2p4SnpMUElN?=
 =?utf-8?B?SURBYnlIUXRuSHVTZVVvWDFMcEtPSWloL3ZsNURibXg1L2kyMXViTFR2dHRX?=
 =?utf-8?B?UUZjcTdrT2JCTlhvUzNMaGN6QUhGcnZUQWRRK2lBNUc1Kzd0bjVkMEw1MGg1?=
 =?utf-8?B?dmdKUXJnUlpCdVU1bmcwc0ZVMVZpd3FqTm1Xckp1WlFTam9rOEVUeGRHV05t?=
 =?utf-8?B?R0R3UnlDVUJhVVN0c0UvQTBSa2dJOWdGd1A2NTB2S0FrcjRnL1dIK2JqWWpw?=
 =?utf-8?B?YlAzUDNSN3lqQzNqZHpLZktkaXdMVDVQM29XMVY1UzV5SFBETjZJeXlQSk8r?=
 =?utf-8?B?UEp3S3A5QTBLQVF4cElzS2ZNWVFyNXN0UnFLSFdacEFMalhEaEpWWC9BZTNk?=
 =?utf-8?B?QlBOZ1Qyd21oaXhFeFpab3phdG81VGNodUZmUmNkQnZxMEt0K2E4UVNDOUpY?=
 =?utf-8?B?OHhubVc2SzczMEJRcjBubjJYY0JHSjJQUG81TkRXTEoyYWkxVlpNVjlNV2p5?=
 =?utf-8?B?REJ2ZVhLSWppYzFkRFJPWDJTbU5PdFozcVBQaXFBQlJURksxZTgyTUx6MmdD?=
 =?utf-8?B?cXJWMkVXMVBoOFhjOFFOd3FRS0FnRkdBRi94cWRoMThCS3JHbG5lTG1HSm9Z?=
 =?utf-8?B?aDE1cElHMnB1UVkrRERaNGNUV1l0dlN5R0dGaUZyZkZ3b3FiLzRaVU16aGxY?=
 =?utf-8?B?Rms5WE9lSW5FdUV1TGZrWFJQRHB3WE1SN0xOb3J2RWhtMHBqT2IvTFJsRDZl?=
 =?utf-8?B?OGpncTk2WFBOdmVrekhKSVowZ3Rmc2pjeXdCa3ZxY0psaDJqTDh1L2t4cnFq?=
 =?utf-8?B?ZWtsVXZibVUvckNZUlZ2QlJQTTlmQmVwV1dzUFlaRGM3dlBZUDczcXo5Y1M4?=
 =?utf-8?B?M0tRRWFCeUgyczk5LzJDRTg5akY5Z1h6MllBQVFiVnJmcElJcEF2Y0c4ZXkz?=
 =?utf-8?B?L0ZMSTBEQWxtaVBYejZJeWdzSmo0azBuNlVzYXlPQmVnVHRDSURWMGIxNytw?=
 =?utf-8?B?Zm4wUXlmMmF5Ynh6V0t2alN3dzgyY0IwRlp5bVJ0dFBRamFiZTc3WUpiS2d1?=
 =?utf-8?B?dWhOOUNVR1VERVZZYmVXUURmM1lybWxUa1dHbHc2cjlEdjFkeXZzdlR4Q1lE?=
 =?utf-8?B?U0VZSHNVK0lML1VRMGdUb0hBNDlpQjRZUVJmUlNKbVhLb2puZGl2RldCOGRR?=
 =?utf-8?B?U1hCU3g4UEY3K3ZpeFhyWU9UWkZYSGN3VlB2R0dqWVRkeXZDM1ZLQmt3U2ZH?=
 =?utf-8?B?QW1Yd0RKV0RldHlteFJ4UDVvNzN6eFNUcGV5SWpCaXk4a2t6NlNNVTJqTGhT?=
 =?utf-8?B?MFZKVFV3Z1l4Qjc4eS9pS1dzME1YbEVsWk1lb2lrbURFYVovYkk2RTFGSDNq?=
 =?utf-8?Q?PztITvm6jCBdZu0wJHcbm9elG7C+EEro4FEby?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3e4ef67-c8da-4fda-aad3-08deb6bb4e17
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 22:01:11.9638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K1XkKhPkVbwnDWLaA6XkjURv8mVfze+fBukPDACap4SFtUXToZqtmbpki54/CGZkkq/dK12RW1GuYIUvB3EvHH0pe/GQmxngnaIU+p/6EZUiwV8Sqf7V2VwZTv2GTlHb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8029
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10582-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:mid,nxp.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,NXP1.onmicrosoft.com:dkim]
X-Rspamd-Queue-Id: CB3C559BA99
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Frank Li <Frank.Li@nxp.com>

Pass dma_slave_config to dw_edma_device_transfer() to support atomic
configuration and descriptor preparation when a non-NULL config is
provided to device_prep_config_sg().

Tested-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v3
- rewrite dw_edma_device_slave_config() according to Damien's suggestion.
---
 drivers/dma/dw-edma/dw-edma-core.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 92572dd8131e6..ba37bc983dcd2 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -267,6 +267,20 @@ static int dw_edma_device_config(struct dma_chan *dchan,
 	return 0;
 }
 
+static struct dma_slave_config *
+dw_edma_device_get_config(struct dma_chan *dchan,
+			  struct dma_slave_config *config)
+{
+	struct dw_edma_chan *chan;
+
+	if (config)
+		return config;
+
+	chan = dchan2dw_edma_chan(dchan);
+
+	return &chan->config;
+}
+
 static int dw_edma_device_pause(struct dma_chan *dchan)
 {
 	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
@@ -385,7 +399,8 @@ dw_edma_device_tx_status(struct dma_chan *dchan, dma_cookie_t cookie,
 }
 
 static struct dma_async_tx_descriptor *
-dw_edma_device_transfer(struct dw_edma_transfer *xfer)
+dw_edma_device_transfer(struct dw_edma_transfer *xfer,
+			struct dma_slave_config *config)
 {
 	struct dw_edma_chan *chan = dchan2dw_edma_chan(xfer->dchan);
 	enum dma_transfer_direction dir = xfer->direction;
@@ -472,8 +487,8 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
 		src_addr = xfer->xfer.il->src_start;
 		dst_addr = xfer->xfer.il->dst_start;
 	} else {
-		src_addr = chan->config.src_addr;
-		dst_addr = chan->config.dst_addr;
+		src_addr = config->src_addr;
+		dst_addr = config->dst_addr;
 	}
 
 	if (dir == DMA_DEV_TO_MEM)
@@ -595,7 +610,7 @@ dw_edma_device_prep_config_sg(struct dma_chan *dchan, struct scatterlist *sgl,
 	if (config && dw_edma_device_config(dchan, config))
 		return NULL;
 
-	return dw_edma_device_transfer(&xfer);
+	return dw_edma_device_transfer(&xfer, dw_edma_device_get_config(dchan, config));
 }
 
 static struct dma_async_tx_descriptor *
@@ -614,7 +629,7 @@ dw_edma_device_prep_dma_cyclic(struct dma_chan *dchan, dma_addr_t paddr,
 	xfer.flags = flags;
 	xfer.type = EDMA_XFER_CYCLIC;
 
-	return dw_edma_device_transfer(&xfer);
+	return dw_edma_device_transfer(&xfer, dw_edma_device_get_config(dchan, NULL));
 }
 
 static struct dma_async_tx_descriptor *
@@ -630,7 +645,7 @@ dw_edma_device_prep_interleaved_dma(struct dma_chan *dchan,
 	xfer.flags = flags;
 	xfer.type = EDMA_XFER_INTERLEAVED;
 
-	return dw_edma_device_transfer(&xfer);
+	return dw_edma_device_transfer(&xfer, dw_edma_device_get_config(dchan, NULL));
 }
 
 static void dw_hdma_set_callback_result(struct virt_dma_desc *vd,

-- 
2.43.0


