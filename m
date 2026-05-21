Return-Path: <dmaengine+bounces-10680-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDUqG5UzD2qSHgYAu9opvQ
	(envelope-from <dmaengine+bounces-10680-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 18:32:21 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C63635A958C
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 18:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40107332C4D4
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 15:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F873672A8;
	Thu, 21 May 2026 15:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="GDbnh2kc"
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013039.outbound.protection.outlook.com [40.107.162.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EB8360ED1;
	Thu, 21 May 2026 15:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779377595; cv=fail; b=f58n0Hg25uTSyA/Tdg8VYscVphmnJd7yhOQuNLBZ94v43aMljeokNY7+dCBTCG9a7pxySZA3sGjIBdroQB1gwO9PUfImZUpigVe7rNdws3mBLSNcdRONALyLy0VsTRI6YgsVu7+QLWxwxR4SphQcqoVISu23bu98LTRAgwLYD1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779377595; c=relaxed/simple;
	bh=IPs530ljxyZEklWA6fCKo4SPitNmyLEzet1kpmM0cyg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=aZE/V4aYUNi8q4aJtM5ghWuhuS3YRCf1ncB/lULbyMy+8+QGJokaI2xLM4X329/6j+QPkOTnMwrLdphkuo/rmI6Jde0Emx8GJWcraOVex3pke7oEbnGjOsoU8MTsrAUBPTvi6ME8TiBZjSqW92XS5p6tJehJntzH4hefBfD0Zqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=GDbnh2kc; arc=fail smtp.client-ip=40.107.162.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fzoeC5j4fNpwnpPCD6CG71hcshgtim2XyB4CGgJMO37yRB7yeg3Phw/p6eirh6sZC0PNThKkyggkkiGTkqdkRg3xRFNyre6ewHa/6SwEKOWeAnOBSd+zwgP4I8QbbAB3EqwSnyYAHnCziKlohZXSNYKNSLw3ITcbolYurxvYcRzJ5LgQZvK6l8pYc3VCioGaGjLYjvftKafH+JC86qjKuBWUPWqv4KvBEYI4XdkFroFpeZuHj09dcgvDgIq6UZMlgKaGIiwblLvWICssNZz3xEI3qqAiaSb6vLk6CT5rkumMzCdsOYGUcFOGGkuDQmrIIZiFG59PwbeWndiXuBNTQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ktn4yDDK+X3BcUkupV/7FBh4aTe/41UXRom1OC5H5c=;
 b=YngqLjkYJBAr/o3Mhx7I7DnY8VNRWJL3rfbh4Ba9mQJVaKUSwkL6W0PKYz+WCcy2t/ur173p6OYp0K/gcaRTaaE0l/Hd0gYmF2EqLFE9xXKVQ0kM8r+v8aQxXkV6Sq54A9mUtnb/otxRjx+FQZXMBIRh5qHw4df9AEQSYmBX1yHbM94Dzly/D15ho2vCJuvOa84p1sfCIeeoIH/uW7cwXUVRSP4s8Xjt1gHmm8LRvAAPOsC4S6IrymnNJOQZDIj7toDLiqzbUrFC2lbRF8p3xqi36VmBpSdrs80g/gV02Y1klL3qFieP3gcTCaRE1yqhgcXJcn4VJFIOp87IZy8sMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ktn4yDDK+X3BcUkupV/7FBh4aTe/41UXRom1OC5H5c=;
 b=GDbnh2kc8jc1VlyKCjiRupOiPBQ6MvGb8BPyKfMaTVYoycAwlW0XxKBSPrp5BsgZ1g0d+3qw6tnWzBCqr4pgPMoU9vXQem6YYTutsxXsoyRgNe06Is2aCXh75w7g2TnlFeggfsPe9WaBbF+2My6f7N6cW9l/bqECKjVQis1bolZC7X6Ra8XNPtYdsTd43G0LqyT+S5yi4rsAyjQL3H9HUovZlO1jIGUjms0F64BMzWyoKxEu0Mfw9g1SQ+eKKHVujzAOlqylfH6nnl2OG0stuoYkgqFFadh9ypYJjx5N4c6dErCWPB1EwhRjl52ZGipjnt3B4gvBhaMVDC+ypmrS3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU4PR04MB11791.eurprd04.prod.outlook.com (2603:10a6:10:623::11)
 by AM0PR04MB11853.eurprd04.prod.outlook.com (2603:10a6:20b:6f9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 15:33:08 +0000
Received: from DU4PR04MB11791.eurprd04.prod.outlook.com
 ([fe80::11ca:6b74:3234:d7de]) by DU4PR04MB11791.eurprd04.prod.outlook.com
 ([fe80::11ca:6b74:3234:d7de%4]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 15:33:08 +0000
From: Frank.Li@oss.nxp.com
Date: Thu, 21 May 2026 11:32:48 -0400
Subject: [PATCH v7 2/9] dmaengine: Add safe API to combine configuration
 and preparation
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-dma_prep_config-v7-2-1f73f4899883@nxp.com>
References: <20260521-dma_prep_config-v7-0-1f73f4899883@nxp.com>
In-Reply-To: <20260521-dma_prep_config-v7-0-1f73f4899883@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779377571; l=6305;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=uyPouf7iyzCcucDvUuV8ZtysqANoCh3TR/YpsX4alSI=;
 b=/y7IIWB/+aedljKZR+eFNhQRjiXkmMHlrSlHaNgRT9rVbQdxYi3dq/DrLdsx6QVd9BTm81Kov
 JUahUQw0SvZDLb6SbFz2S/BJh6O3bc00yQwRtVSoU5Fs4QKmSwhkX0B
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR16CA0002.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::15) To DU4PR04MB11791.eurprd04.prod.outlook.com
 (2603:10a6:10:623::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU4PR04MB11791:EE_|AM0PR04MB11853:EE_
X-MS-Office365-Filtering-Correlation-Id: ea51e4b7-f347-4611-a893-08deb74e4277
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|7416014|376014|11063799006|56012099003|18002099003|22082099003|6133799003|921020;
X-Microsoft-Antispam-Message-Info:
	uTizkX31fTF/0CJgs4x5B2qcMsX8Lffyr2ascNGQJR0yHB2zU4d5v5SgWvfRu+X/CGDhDWB1+WQIzIKmEn2lh6T3y6mR8utSTZtRoyQ426pd5NyFg7eYm/6xiDO2jkTMUHzC8l1WCqyJajMxIQktugANFXSWcJfnW2ehH8U18p/NWa+Xx+4KaXI/kiRxH340shihIdlK6LjAa+CCoY+5Mtd585rSYg2M42O60qMsavjxcXB3M7Y8EHYlWXU5xf0a2teIgktYJW42XI93KBVWvPpYjQ97V/SA6c6gwPqav/BU3HIEuJ9E2dTql+V+HH6i6Kpl5ppvQwU35f1YIsPqa55YX+VoabMFGfuaBO4BDzWyxbSlzvHdQgjD62QlxxHngx5MT9ebM8AxhvFG8S4w1KAhS1CVBnPFkfGLmx2B6BXk0u7+MkbpzfRG1PLgD0ot9s/TbFZ2QJWDHEpZDWkJAVDDTXAkBRESBmwaccaUh/lVYCRJKDh66QyZP15WwfS9s0uC/r/ah0B4gKYwU3BGlxjBswIX6bVJHGvyy7VHLyAS4M/u1m5gyjQnNR0UoOGk3T1gTaI0Na/i0GBCU0syKG3lnA9U7oKjaBRSPmLrOeuEE4F4ymlwNVrfr+YeOIaHQCACGHH2ESH0A7hAcq8DfKiveRwWIuWuFxSiniQEAN/+jwdGw9aih1KCJSDSMh5fIFGFnU+6ZQrprVcXPZMA9MJ/aUs8fnEPdYOq4IFLrbY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU4PR04MB11791.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(7416014)(376014)(11063799006)(56012099003)(18002099003)(22082099003)(6133799003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2NtbFF1UFltbCtFaFJORk5SR0hBeGxMUWFwc3NjZlRaSzV3bUR6aVVFaVkv?=
 =?utf-8?B?UlBWYlA1T1ZTY0VCVzludkpkS3VRZ051eDNmQkFRSmpOamNmRW1OK3o1M1Nx?=
 =?utf-8?B?T2ZkaWhhcDZZYzlUUlVGMjdKak8zU1BzWHpGTEtzem85a1cxb3hUaVVid2g2?=
 =?utf-8?B?OVpKQUdXSWFRUmN5eGloRVN4SUtnUUdzQ0xObzBLSmNrMk1XdTZmNFJHRE8z?=
 =?utf-8?B?bDdUeVdpVGpHUk1aNjltbDlVRHlwbjBWUlNVc0daU0xVRUJ0MFE4WHJpZGtM?=
 =?utf-8?B?RjhFVDlnYlZtODFjR0NIdmFSMTZHNEZsdUtXTHdHeklZUUFWc0hGWEdXQ0dX?=
 =?utf-8?B?WW5FWFFBZHR3dEJ0VHI0STFEWHJyN0Fvb2s2TjEyUXFKc1NobUhUSFNFVWkz?=
 =?utf-8?B?M3lIR3BPZTU1U3ZuNmxrMHZWelBQclRGZE82Rks4b29UUnpqRSs2eC9KZFZ4?=
 =?utf-8?B?WUtyQzh5S1VvaTlobEp0WitXc1pLclRoRlpUNEZGd0UzaHlWcDZiT0JuakZo?=
 =?utf-8?B?c05xSXBqZEdyejFTZDI2aVpudWU1NTRtaHp6Vk9SUTlVcktzdzBObVo2cmwr?=
 =?utf-8?B?dUgwRDJ1TFpHT0VlUXQ1SDZ6MkVBWHhDZlJXdmwrRHZMc2t0TmRqUjBvVGNN?=
 =?utf-8?B?eFRDQUc3Vjd5RTcyUDd1SEkzR2dzSFh5ZlE4S3FpU2x1bXBjTnhTM1RWamNI?=
 =?utf-8?B?RVJnTWt1MHFFNnRJdmlHdEprdzM3Si9zY3NRV2c4VFk1TWJYS2RPQkx5VjV3?=
 =?utf-8?B?a3dMbUROZzRWaGN6aC85RUx5VE9KWXdncTZSV3VaUkZvVmlSbnBTRjVXbVl5?=
 =?utf-8?B?L3lqZ2w2RDJKcXJrMmwwajFQQW83YXA5VTNUWGhuYkYxWnpkYXJVbEEzYUVy?=
 =?utf-8?B?a25EdEtpbk5Za3ZIQjBtdXpXeVcrWGlXQlJzWExSRXhtMGRrZWpSOVhXSWo4?=
 =?utf-8?B?YTlZQVJ6NWdleGhmeWRtRGlKTXNWMkt6WHFYV2doODVIU092WWVYa2pGQi9j?=
 =?utf-8?B?VmV4RENQZWtBNFo2RjNPZnYxSnhEcEtkek5VaGJwV1JQOGtYcUxHanRiSVFR?=
 =?utf-8?B?Kzk2QUp6TWp1Wmh3ZEdJQnlVZC93R1MyUGxuT2dUSnJyNkRuNXNRUFdyeWVU?=
 =?utf-8?B?aHd3Sld6V1NMUDdFbnBUTklEUDJyOHNBRDUwUTdlZ0xkeXVNZVJENlRNeFhv?=
 =?utf-8?B?QzNFSlhqZmRDZ2Z3eVNyY0VRQ01oYmRJZFp2cEN5aVdKSzMvVTE3TkRONXFk?=
 =?utf-8?B?alg4Q2didW1kaVg0U0pseEg1TWFRSzdPUG1zSVVhbENoZk9Gd25EZEdvTW9V?=
 =?utf-8?B?ZjM4VWdCZ2syQXpYdUt2a2J3QmltUit3VERNY1d1UjRjeERxTklYMUYyK2Iw?=
 =?utf-8?B?NmliekVwazRlUzcvdWdvYVlUTWdRTzFzMzVtNXo0QmZkcnBid2hDMTlFL2J6?=
 =?utf-8?B?T25hYmpGWk1qOHZrWittNFNkaDBoZXFQNzVNTkZkajR5cWJydDgwT3luQWMz?=
 =?utf-8?B?dWM3WDVHeUZyMGkvdXEzbWZGaFYwOCt6WEJxMkowNk9FMXNvdk5qcW4yVlV5?=
 =?utf-8?B?Vlg0M3hSYk9rTnMrcVd3aDJ1SDNYWWZtdnArUlgrNnd2OTBlSyt0Z3NxUEk4?=
 =?utf-8?B?cTNzc1dVNVdTNGxaOHFyd3BuSkNONUo5a0FPUXE0YndNWHVrQ2s1NlIvTXZt?=
 =?utf-8?B?bjVkTHpIRVBDaFAyY2VhaThkcTZUUFhLUXVtcDJBR0N1R1hYSmMzWlF6cXJj?=
 =?utf-8?B?N2loZ210QXBNVzkzV05ZbTdiVEMxRUN6TGtuckFINnlpVVVwWk56NzVHMi9Q?=
 =?utf-8?B?T0haTzU3ZVhMNWgvN0V3WjBrdTJZUTNZWVpHNU9abGhwUlBBQzVzRFBMQlkw?=
 =?utf-8?B?K2V4dVh6dG8zTFo5QktnWHRoVHF6NldJaTJSTXpQWXFpaUE3azIweUcwYnZU?=
 =?utf-8?B?OUVQWFd0a2crWWZ6U2dHdkRialVwYUMwZTJNUGhXeTZ0Wnh6bDhHUEVqUEpN?=
 =?utf-8?B?T29xUmtuR3VCckt4K3QwYjJVQ0tsWm1xVGk1eWdCZy84b3hXL1dxY2RNRmE0?=
 =?utf-8?B?K3JDYWxDb1RYeUlpU1k2UnNvRWpMTHg3RFJuOCtUSUowamRSS3BLQktEaVY5?=
 =?utf-8?B?Q3NYemxMSjNKdWV3aHNpYTk3a01BVHR1cDRFb2twR0FpUFdVOHlKY0R6U0hl?=
 =?utf-8?B?T1hGZ01mZkNYV3k1NlMwWitVV1crY2VmQjVVU1l2eVVPTm9JcUxQZDA2bTZD?=
 =?utf-8?B?ZmxFYjZrZUhEb2lYcmZnSlVRN3NEdXhIR21EOHQvQjA0Tkl6VG94WlZNU2NR?=
 =?utf-8?B?TVVubUJ4NXo5dGVsMmhTa2RBR2xjemIyQTY4dzk3djE2M2hGLzdUMnJaUlBM?=
 =?utf-8?Q?HIZ5QZuPxS22kegk=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea51e4b7-f347-4611-a893-08deb74e4277
X-MS-Exchange-CrossTenant-AuthSource: DU4PR04MB11791.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 15:33:08.6406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CC3lt17cFikOmSnoFYFuLNfN+TktuOo0ddBwFaOOYhid3En5xjorDjuRDxjzVL3LqMn2N2DaYj8+rbADIiIPrgrtdC4T0ukrF6OH2BmyU50PyvnTsvrgAmrWwBQpVoqi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB11853
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10680-lists,dmaengine=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@oss.nxp.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:mid,nxp.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,NXP1.onmicrosoft.com:dkim]
X-Rspamd-Queue-Id: C63635A958C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Frank Li <Frank.Li@nxp.com>

Introduce dmaengine_prep_config_single_safe() and
dmaengine_prep_config_sg_safe() to provide a reentrant-safe way to
combine slave configuration and transfer preparation.

Drivers may implement the new device_prep_config_sg() callback to perform
both steps atomically. If the callback is not provided, the helpers fall
back to calling dmaengine_slave_config() followed by
dmaengine_prep_slave_sg() under per-channel spinlock protection.

Tested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v6
- replace mutex with spinlock in commit message
- use spinlock_saveirq according to AI review results

"The documentation in struct dma_chan notes that *_prep() may be called
from a completion callback. Since completion callbacks often execute in
softirq or hardirq contexts, if a thread calls this function from
process context, local interrupts remain enabled.

If a DMA interrupt fires on the same CPU while the lock is held, the
completion callback could attempt to call this function again to queue
the next transfer, leading it to wait on the already-held chan->lock.

Does this fallback path need to use spin_lock_irqsave() and
spin_unlock_irqrestore() to safely disable interrupts?
"

chagne in v5
- remove reduntant lock commments.
- use kernel doc to descritp API

chagne in v4
- use spinlock() to protect config() and prep()

change in v3
- new patch
---
 drivers/dma/dmaengine.c   |  2 ++
 include/linux/dmaengine.h | 86 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 88 insertions(+)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 405bd2fbb4a3b..ba29e60160c1a 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -1099,6 +1099,8 @@ static int __dma_async_device_channel_register(struct dma_device *device,
 	chan->dev->device.parent = device->dev;
 	chan->dev->chan = chan;
 	chan->dev->dev_id = device->dev_id;
+	spin_lock_init(&chan->lock);
+
 	if (!name)
 		dev_set_name(&chan->dev->device, "dma%dchan%d", device->dev_id, chan->chan_id);
 	else
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index defa377d2ef54..6fe46c0c94527 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -322,6 +322,8 @@ struct dma_router {
  * @slave: ptr to the device using this channel
  * @cookie: last cookie value returned to client
  * @completed_cookie: last completed cookie for this channel
+ * @lock: protect between config and prepare transfer when driver have not
+ *	  implemented callback device_prep_config_sg().
  * @chan_id: channel ID for sysfs
  * @dev: class device for sysfs
  * @name: backlink name for sysfs
@@ -341,6 +343,12 @@ struct dma_chan {
 	dma_cookie_t cookie;
 	dma_cookie_t completed_cookie;
 
+	/*
+	 * protect between config and prepare transfer because *_prep() may be
+	 * called from complete callback, which is in GFP_NOSLEEP context.
+	 */
+	spinlock_t lock;
+
 	/* sysfs */
 	int chan_id;
 	struct dma_chan_dev *dev;
@@ -1068,6 +1076,84 @@ dmaengine_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 	return dmaengine_prep_config_sg(chan, sgl, sg_len, dir, flags, NULL);
 }
 
+/**
+ * dmaengine_prep_config_sg_safe - prepare a scatter-gather DMA transfer
+ *                                 with atomic slave configuration update
+ * @chan: DMA channel
+ * @sgl: scatterlist for the transfer
+ * @sg_len: number of entries in @sgl
+ * @dir: DMA transfer direction
+ * @flags: transfer preparation flags
+ * @config: DMA slave configuration for this transfer
+ *
+ * Prepare a DMA scatter-gather transfer together with a corresponding slave
+ * configuration update in a re-entrant and race-safe manner.
+ *
+ * DMA engine drivers may implement the optional
+ * device_prep_config_sg() callback to perform both the slave configuration
+ * and descriptor preparation atomically. In this case, the operation is
+ * fully handled by the DMA engine driver.
+ *
+ * If the DMA engine driver does not implement device_prep_config_sg(), falls
+ * back to calling dmaengine_slave_config() followed by dmaengine_prep_slave_sg().
+ * The fallback path is protected by a per-channel spinlock to ensure that
+ * concurrent callers cannot interleave configuration and descriptor preparation
+ * on the same DMA channel.
+ *
+ * Return: Pointer to a prepared DMA async transaction descriptor on success,
+ * or %NULL if the transfer could not be prepared.
+ */
+static inline struct dma_async_tx_descriptor *
+dmaengine_prep_config_sg_safe(struct dma_chan *chan, struct scatterlist *sgl,
+			      unsigned int sg_len,
+			      enum dma_transfer_direction dir,
+			      unsigned long flags,
+			      struct dma_slave_config *config)
+{
+	struct dma_async_tx_descriptor *tx;
+	unsigned long spinlock_flags;
+
+	if (!chan || !chan->device)
+		return NULL;
+
+	if (!chan->device->device_prep_config_sg)
+		spin_lock_irqsave(&chan->lock, spinlock_flags);
+
+	tx = dmaengine_prep_config_sg(chan, sgl, sg_len, dir, flags, config);
+
+	if (!chan->device->device_prep_config_sg)
+		spin_unlock_irqrestore(&chan->lock, spinlock_flags);
+
+	return tx;
+}
+
+/**
+ * dmaengine_prep_config_single_safe - prepare a single-buffer DMA transfer
+ *                                     with atomic slave configuration update
+ * @chan: DMA channel
+ * @buf: DMA buffer address
+ * @len: length of the transfer in bytes
+ * @dir: DMA transfer direction
+ * @flags: transfer preparation flags
+ * @config: DMA slave configuration for this transfer
+ *
+ * Detail see dmaengine_prep_config_sg_safe().
+ */
+static inline struct dma_async_tx_descriptor *
+dmaengine_prep_config_single_safe(struct dma_chan *chan, dma_addr_t buf,
+				  size_t len, enum dma_transfer_direction dir,
+				  unsigned long flags,
+				  struct dma_slave_config *config)
+{
+	struct scatterlist sg;
+
+	sg_init_table(&sg, 1);
+	sg_dma_address(&sg) = buf;
+	sg_dma_len(&sg) = len;
+
+	return dmaengine_prep_config_sg_safe(chan, &sg, 1, dir, flags, config);
+}
+
 #ifdef CONFIG_RAPIDIO_DMA_ENGINE
 struct rio_dma_ext;
 static inline struct dma_async_tx_descriptor *dmaengine_prep_rio_sg(

-- 
2.43.0


