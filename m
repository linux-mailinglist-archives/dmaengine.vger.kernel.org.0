Return-Path: <dmaengine+bounces-12401-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id L8caIF4bVWoWkAAAu9opvQ
	(envelope-from <dmaengine+bounces-12401-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 19:07:42 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D18B674DDDF
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 19:07:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=qlIXelK7;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12401-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12401-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5415C3044739
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 17:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D130E330B01;
	Mon, 13 Jul 2026 17:03:31 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011017.outbound.protection.outlook.com [52.101.70.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA7B3090C4;
	Mon, 13 Jul 2026 17:03:29 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783962211; cv=fail; b=FP+cSQBebYcjOR2jTV4sepkmMeM51M2ft9VtPKEmqtUBaQjuyBg4uaGjq9UkcvYX/+BjbzAGVJvVmp+demjA/di8w8M22/OsUknlIeVtuuTcK+k09uJqrg+P32K6miMit716vhTREoS5ZNtHNMd2BfBCy59bJbKFzOc+j3jX/nY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783962211; c=relaxed/simple;
	bh=aoUWIJM0N2bBYH184hqwH9JNQa2K6rflQU2hA+V6/98=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=lVFXY8AGwTCH1Voq4A8MRSNh/g05v+iLK8MbrUIQLjJtcN3kjOsmSeoHpMbjaRIwNqzmJ3hUb0z0Zok41yDmUit8qIxERkHB2eZ+P2a4frxatcRDBPl5NIf0cTZfe3uCGNXm65eMVcDH7Gef+r9+SxR3wv+kVdNHfoIVS7ItQTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=qlIXelK7; arc=fail smtp.client-ip=52.101.70.17
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m4tCKOdh5aJ3wf7x1MIk0PkQAgZTKOAB9+1QnhrpJzG6Ny1IADmUZQH/7EWLS2E/b7b6vn+QN/P66vnwoQw6atUwzQVDRF04BPW578oPHFnaB8VtzqyTH8y0T4uymfZbk3sB7FaW8vxi2cTcW6qQ1t/6eondxvGmPtj+Ob/dhadpd2BHNjipQn3d3sV4dVX/18efSj2U67uAGJ32RC9yIW9rleqaqaeHo48fdHNVWGZYiKYB43ADS64aiDmdIZfQIT3NlI95PQ24i17TNQtKx+4umt5E1CMiCGlCcEBarozegVpUJlzFjvp3WIlbzWt5/NHpJ+l/V8pXxfveQQHTPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=igGbM5+Wcaf/cNYhuZaJM6h8LHvlnY211UUZ4xoSdQ4=;
 b=hm1Ow5bfgCMUukV9Fu/Ns39dIh37Dn4Lj4lVh/F1zmn9HOrGyI8MrGjV0kHtd+kbPGPm396RAGr+y5j/1GNmPn6EV2ydn7f+BrbgZnvEeYpCVkYRCCfydZM2bVbu/DLvdeM9SWZVMEDurA92taYqq4pgC9koAdaL9Dtu2FGFx5m+T9bAXgJyOQ3SDjMM519vDnM4Al+0nsfDrcIRh8JqCq1kf5Gsp1MFRS6f7TAclqIa33zXpMipAbmeRCxshzvPIXhkPS0desf3dJCPpbLu9wMpQQjD2IqqKKceYabX+RWq9ArwIV1L41/6AMVTkI5M67YGHSzw5I/3MBNWmhecHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=igGbM5+Wcaf/cNYhuZaJM6h8LHvlnY211UUZ4xoSdQ4=;
 b=qlIXelK7DduMcmMXB0e+K3u/EhwEGFScEYcjB1ke9iLjR69ivca4QXXU5Y5CzrhuSYu+xSHq4krnmP1KAUipgEmVLlgjWURZLnhusd0ViT4OpRyZ4/OwW3ArckY8R0aXYMH8roufTpY9Tx06RQk6HJ6QaZVai4+IbGLJBI9stpnTBUOxy0oLIbDO+Xlm/drzX5gbJrHF+WnMwdUWy3F9CIhBPL9v1wFxtAYd0yP+S+FmKS/1+/2YCEvAqcBNWPsxka4SuInGnhGTAssXk8HXvfZjuYqSUAvsuOZUiQ8pfj9ew/Gp16nAFfeLOhg3FYfNrdjSy1/LLXLUe2acSk+G8g==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA1PR04MB10228.eurprd04.prod.outlook.com (2603:10a6:102:454::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 17:03:26 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0181.019; Mon, 13 Jul 2026
 17:03:26 +0000
From: Frank.Li@oss.nxp.com
Subject: [PATCH v7 00/10] dmaengine: dw-edma: flatten desc structions and
 simplify code
Date: Mon, 13 Jul 2026 13:03:18 -0400
Message-Id: <20260713-edma_ll-v7-0-6fb7498c901e@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFYaVWoC/1XOy2rDMBCF4VcJWldlZnTvqu9RStG1ESR2sItJC
 X73KoFU9vIIfb90Y3Oeap7Z2+HGprzUuY5DG+blwOLRD9+Z19Q2IyCFhMhzOvuv04mDAxk8WFc
 AWbt9mXKp10fp47PtY51/xun3EV7wfvps0H9jQQ68RKtFckVFL96H6+U1jmd2Lyz0VBoQXFfUl
 IoQyASKWsu9El0Z2LwlmrLGeC+1MBLiXsmtsl3JpmJEsgV8CRr3Sm3V5oeqqYzOgRJJCoC90hu
 F0JVuCqXBRMYGI3xX67r+AeVjXtmqAQAA
X-Change-ID: 20251211-edma_ll-0904ba089f01
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783962202; l=7062;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=aoUWIJM0N2bBYH184hqwH9JNQa2K6rflQU2hA+V6/98=;
 b=YligZQ+pC3bpDEN/CJD7ulLrnSG0wsWFY7dpd6Nhl5om94Lvwky5dBcybbfC8YiFZARsB9H9x
 S6Lp7raKSVFCSy4WNioPWQFlx+pVDkZbXp+Vq5gVzHXLLPnZHR2Hm3V
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA0PR11CA0098.namprd11.prod.outlook.com
 (2603:10b6:806:d1::13) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA1PR04MB10228:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ab5b66b-94b9-417b-ec4c-08dee100a7e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|19092799006|1800799024|921020|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	p7jnRwgFaicPCLi5OE7DoPFXJkKxsyq2uDFVO4zM9MMuFTqICcboP7lMaN9mPlpOl+r0zR5S+C9JWugo138jLWwX/Mkvv5ioLXI+DHQ+jGELvOPcfkAmR1ZSP3yVIG6ywYzz2xgLJzdOwakos1iuiICXwM6OGQjTdV8Yjj1xJeeVbhM2t5KRfMIODIqD412DtjIbbvkeM2NAF3JcxOeTruLgQstxslpMK+aR6JQW3dh1+KM2YsjDxqVOpg3XDM2Nqdkv/uhUeopXsHoG08ODRYCxW71ojWLS8TEJxGuEjBt7A/uPKI4ccPTLn8JNlNXytkyMCtz/+AEzowUyRaZPXs8CbWCaajyLN3M6MnaJYUmvJqshmdn0BjMFBSWhC+k+6QfOoOG9dNtR4Xx9MQa5sKisfHUiP0hhUmHrTlWcS/1A1DhWaXsAywjHsqlFa7rR9Pp68mlQ2uanDcQQLGakAZGLk8Dr/SsY+eWzu31XV/plJ3lVQcxDHZOQudvNTWVS69g53dgU+Aqfrch6zjQYOMTKAW7cEO2HQhM4XhiaIVIBrEC7PUViemX8eyLBIxJPKjFi+tHIZ3jhHFomRbNSfHUp05YHGeKBBj/OxymVV5+nnFAJs9cQrrTcoyoKM7h+HX7EKaMDRgIol8PCtTAU3MrxIxsAoCIgNUMCEKdIgZY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(19092799006)(1800799024)(921020)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d1Ewb2R5NUZtNGdnSTFBemlLck04SVhmOTJnd2NJTE5lMFdDVms1Y0J3ZjVN?=
 =?utf-8?B?Z016aVJra0R1WFlpTno1QllQMENTQjVFK2NuSm9RRHY4ZHpmZkV5V2hDYmRh?=
 =?utf-8?B?SkNyUG5lNS9zdnJlMVdmcEcwaWthczBmWWtBcUVHUnZ3bzVhdVlUSGhPSDNw?=
 =?utf-8?B?ODM5QW1scDN1Tmk1VHJRd1B2S001cW1vMFJ6YTM3YjdWZDV0ZnVVdHVmWFlz?=
 =?utf-8?B?ZkJEcUhkdCtod0FRakNJanVzQmR5OUdDcnBhWkRIZ3FLUFNaNG4vMkpzemY2?=
 =?utf-8?B?K2ljVjAyQm1RQmRIY0ozZDRKWDNnc3YxNDJ6c1hjZHdMK2xwVTdUSFVSZU41?=
 =?utf-8?B?M0ZzUys5Qms3U2ZxU2o1dXh2UDFJZVhyL1NpaDBMQ3o0ZW5RNzZVYWNhUGU4?=
 =?utf-8?B?dWFla1JjV0V5YTZvbGFnQWYyUDJPS25qYUxENUt3aDNLMGg0WXcxb2JaUDl3?=
 =?utf-8?B?WllIOXBNbEp0Tnp2cXNsUmwxRit1dnZJelN5QjdEN3ZPcHJjcTlhazZzK1hW?=
 =?utf-8?B?MFJGdXIzMDNpRlVKMUpJNnJxOVFTeVRPSnlEcXBtRjdXYnlSbkQ1MXlUTFoz?=
 =?utf-8?B?eHBhdEl0VUFFSzFPcXZhZlFwaGkxa2Q4S3NqNjNmM0p3QVV5cDJaUWhYV1o2?=
 =?utf-8?B?OFFPVnU4U0V0UyticmFUYlhGQzQrSlJKRzJMeG9QTkM2NGlrak85Y2U0cG0y?=
 =?utf-8?B?Mkl0V0Q2OXUxM2FRRkxGNE9GRVBmRUZNM1NpZ1ltQjRIcHZnOW1BT0JDTnFk?=
 =?utf-8?B?cHJqWUpTYzJrU0MrYWRodHFmbEtTd0R5SlovKzhzdE8vZmt2SENWQmZWVnVy?=
 =?utf-8?B?Z0laTHkwczNUYW1FTkFScTdlcCtudXJsZU1ESmQ4b2QzblFpc2VycG9US1lZ?=
 =?utf-8?B?dk4weDBha3BZZ1MvQ0xBT1NuSW9WbHlVY3M5RXFmZ3Z0TFRoanYzTTdib2ZC?=
 =?utf-8?B?Ni9IbGlWcFdSTkF1WFJZMzF1WWJFMTJvcWtiOVFQb1NNNlZEYTFSUk14ZEVm?=
 =?utf-8?B?VUtQeVA4dWhzRG4zV2VlNG9QUWwrMEwwVmJpT2lCN01FN3dlcFFOa1orM2x3?=
 =?utf-8?B?ejl2czZ4d1VhbXZnbDhlZWJDa0RGWGVLSXlhMnFLVkhRWS9FbmxQbVpmMzAw?=
 =?utf-8?B?UkVKM0hNdWlUZVhBUCt4VktSbmlvcm1zR3FzSFQzUU9WcWZSanJjT0lzNjlL?=
 =?utf-8?B?WnZFRXFBOC9LSnU2SGwvcTBmNzVtUllvc0krcW1ldXZJNWNRektrTEo0SXhw?=
 =?utf-8?B?elFDMC9xWVVNTmNzSWJMNWQ1eGpMODBVeE85WHJ0VEU2SUVGeUQ5L3VYVlFM?=
 =?utf-8?B?aTY5M2VUS3BSRlFNK09TRENRZWhLS2d2cTFhaFdBNzk3NS9FbjNBZ2lWblRa?=
 =?utf-8?B?b0ZGMlQ0ZU02WjZkNlc4dHU3Wmh1b1huSFB3SGI2Tlhhb01aVVpzZ1U3VXhw?=
 =?utf-8?B?eHloaFRxNmFITUpiTlN5SGI4OUVjeldNeHR4WHJSbkVKdGVBQUtiYTNOcUVR?=
 =?utf-8?B?WjVYa01INC9PWlZmbjNEeVNYd0I3U2tTT2J0SXhxTDZHdng2VjZHeGdOSE83?=
 =?utf-8?B?ZTE4K0hzMmR0NUoyeUxDZjN0Y2RvSEFOOERXUGpEbC82bDR0VklxNm0ySGpz?=
 =?utf-8?B?Rm1FVUtDOWI4ei9KNVRYQXd1Y3VOb3lCYkd2N2NMYlp0V0MvcXJ4TW4zUGky?=
 =?utf-8?B?WUExRmdjdUtwMVBUcGtaNzAzL29VRjlmYXJQM2lvbmZJYVF6cm5nR3NWRHpB?=
 =?utf-8?B?MGpYaGlQaHl6cSt2eUJDRTc1UFd1bzNWOFFPcFBKMWFEVjFWUXZLd3E4VEhx?=
 =?utf-8?B?Q1dmWkZ4MW5tdS81R3Qway9LMTVrbG1VcklmT1R5clU2UlhWRGZaVzU2dXhE?=
 =?utf-8?B?c2lCS2ZORzhCamtMbmhyV1k1T2RSNTBHby92bm1JRmZzdkZWc0pxYzVnQ0dy?=
 =?utf-8?B?NmloUk9FbDl3UXBoUGY0VmMxQ2JqME5keVFaakQ1QXhoRkI1QUdyZjQ1NHph?=
 =?utf-8?B?Y2FTVUVSTVAxMTFrVW9UaTJpVU8rVE12TkZMdkNPdU50dDF2ZStGa09mUXV0?=
 =?utf-8?B?WUh1ZTREZzZFOHJCZlR2MnUzRWtmT3Rkcml5ZWNNV1ZqSC9zYVRGRHJRNWh3?=
 =?utf-8?B?dWVyKzdieEJMbW13SEhwSk9XMXdVTkw5cXV4UWcvSWQ2WCtORW00MzdJQ1RT?=
 =?utf-8?B?MWFaTk94K0RZQzhxZllyeEtoQUF2UTdBcEt0bzI1dzhHQXBseWxZUjRpa1lu?=
 =?utf-8?B?Y2FqeXZ2akJOeEpIblB5UlBuWXUzT1N6TXhUenJjTzdJVjNGUXJHcHdmcDM0?=
 =?utf-8?B?dDQ3TGpPUnB6MitZMUs0clhDVmEvTXRUNlhhcFNNeXFrTGVXWFAzUWx0THd4?=
 =?utf-8?Q?kvK6KYqRFjTK4J5a7sABcHeGvY8xH5p/QH+SL?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ab5b66b-94b9-417b-ec4c-08dee100a7e1
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 17:03:26.8059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rjBGl1tKtb9t9PvjCy6DTpWqZK+DsXWKMNEZyxPgkMKYe4VQvhLrHjXVptyzry7nRFhb/faneBDDI9B6wuUosbeFWp5FrKHUFzjjGu3xvE8L8h6kfxNDfsIOpPcLHPh6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10228
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12401-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,NXP1.onmicrosoft.com:dkim,oss.nxp.com:from_mime,vger.kernel.org:from_smtp,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D18B674DDDF

Basic change

struct dw_edma_desc *desc
       └─ chunk list
            └─ burst list

To

struct dw_edma_desc *desc
            └─ burst[n]

Flatten desc structions and simplify code.

I only test eDMA part, not hardware test hdma part.

The finial goal is dymatic add DMA request when DMA running. So needn't
wait for irq for fetch next round DMA request.

This work is neccesary to for dymatic DMA request appending.

The post this part first to review and test firstly during working dymatic
DMA part.

performance is little bit better. Use NVME as EP function

Before

  Rnd read,    4KB,  QD=1, 1 job :  IOPS=6660, BW=26.0MiB/s (27.3MB/s)
  Rnd read,    4KB, QD=32, 1 job :  IOPS=28.6k, BW=112MiB/s (117MB/s)
  Rnd read,    4KB, QD=32, 4 jobs:  IOPS=33.4k, BW=130MiB/s (137MB/s)
  Rnd read,  128KB,  QD=1, 1 job :  IOPS=914, BW=114MiB/s (120MB/s)
  Rnd read,  128KB, QD=32, 1 job :  IOPS=1204, BW=151MiB/s (158MB/s)
  Rnd read,  128KB, QD=32, 4 jobs:  IOPS=1255, BW=157MiB/s (165MB/s)
  Rnd read,  512KB,  QD=1, 1 job :  IOPS=248, BW=124MiB/s (131MB/s)
  Rnd read,  512KB, QD=32, 1 job :  IOPS=353, BW=177MiB/s (185MB/s)
  Rnd read,  512KB, QD=32, 4 jobs:  IOPS=388, BW=194MiB/s (204MB/s)
  Rnd write,   4KB,  QD=1, 1 job :  IOPS=6241, BW=24.4MiB/s (25.6MB/s)
  Rnd write,   4KB, QD=32, 1 job :  IOPS=24.7k, BW=96.5MiB/s (101MB/s)
  Rnd write,   4KB, QD=32, 4 jobs:  IOPS=26.9k, BW=105MiB/s (110MB/s)
  Rnd write, 128KB,  QD=1, 1 job :  IOPS=780, BW=97.5MiB/s (102MB/s)
  Rnd write, 128KB, QD=32, 1 job :  IOPS=987, BW=123MiB/s (129MB/s)
  Rnd write, 128KB, QD=32, 4 jobs:  IOPS=1021, BW=128MiB/s (134MB/s)
  Seq read,  128KB,  QD=1, 1 job :  IOPS=1190, BW=149MiB/s (156MB/s)
  Seq read,  128KB, QD=32, 1 job :  IOPS=1400, BW=175MiB/s (184MB/s)
  Seq read,  512KB,  QD=1, 1 job :  IOPS=243, BW=122MiB/s (128MB/s)
  Seq read,  512KB, QD=32, 1 job :  IOPS=355, BW=178MiB/s (186MB/s)
  Seq read,    1MB, QD=32, 1 job :  IOPS=191, BW=192MiB/s (201MB/s)
  Seq write, 128KB,  QD=1, 1 job :  IOPS=784, BW=98.1MiB/s (103MB/s)
  Seq write, 128KB, QD=32, 1 job :  IOPS=1030, BW=129MiB/s (135MB/s)
  Seq write, 512KB,  QD=1, 1 job :  IOPS=216, BW=108MiB/s (114MB/s)
  Seq write, 512KB, QD=32, 1 job :  IOPS=295, BW=148MiB/s (155MB/s)
  Seq write,   1MB, QD=32, 1 job :  IOPS=164, BW=165MiB/s (173MB/s)
  Rnd rdwr, 4K..1MB, QD=8, 4 jobs:  IOPS=250, BW=126MiB/s (132MB/s)
  IOPS=261, BW=132MiB/s (138MB/s

After
  Rnd read,    4KB,  QD=1, 1 job :  IOPS=6780, BW=26.5MiB/s (27.8MB/s)
  Rnd read,    4KB, QD=32, 1 job :  IOPS=28.6k, BW=112MiB/s (117MB/s)
  Rnd read,    4KB, QD=32, 4 jobs:  IOPS=33.4k, BW=130MiB/s (137MB/s)
  Rnd read,  128KB,  QD=1, 1 job :  IOPS=1188, BW=149MiB/s (156MB/s)
  Rnd read,  128KB, QD=32, 1 job :  IOPS=1440, BW=180MiB/s (189MB/s)
  Rnd read,  128KB, QD=32, 4 jobs:  IOPS=1282, BW=160MiB/s (168MB/s)
  Rnd read,  512KB,  QD=1, 1 job :  IOPS=254, BW=127MiB/s (134MB/s)
  Rnd read,  512KB, QD=32, 1 job :  IOPS=354, BW=177MiB/s (186MB/s)
  Rnd read,  512KB, QD=32, 4 jobs:  IOPS=388, BW=194MiB/s (204MB/s)
  Rnd write,   4KB,  QD=1, 1 job :  IOPS=6282, BW=24.5MiB/s (25.7MB/s)
  Rnd write,   4KB, QD=32, 1 job :  IOPS=24.9k, BW=97.5MiB/s (102MB/s)
  Rnd write,   4KB, QD=32, 4 jobs:  IOPS=27.4k, BW=107MiB/s (112MB/s)
  Rnd write, 128KB,  QD=1, 1 job :  IOPS=1098, BW=137MiB/s (144MB/s)
  Rnd write, 128KB, QD=32, 1 job :  IOPS=1195, BW=149MiB/s (157MB/s)
  Rnd write, 128KB, QD=32, 4 jobs:  IOPS=1120, BW=140MiB/s (147MB/s)
  Seq read,  128KB,  QD=1, 1 job :  IOPS=936, BW=117MiB/s (123MB/s)
  Seq read,  128KB, QD=32, 1 job :  IOPS=1218, BW=152MiB/s (160MB/s)
  Seq read,  512KB,  QD=1, 1 job :  IOPS=301, BW=151MiB/s (158MB/s)
  Seq read,  512KB, QD=32, 1 job :  IOPS=360, BW=180MiB/s (189MB/s)
  Seq read,    1MB, QD=32, 1 job :  IOPS=193, BW=194MiB/s (203MB/s)
  Seq write, 128KB,  QD=1, 1 job :  IOPS=796, BW=99.5MiB/s (104MB/s)
  Seq write, 128KB, QD=32, 1 job :  IOPS=1019, BW=127MiB/s (134MB/s)
  Seq write, 512KB,  QD=1, 1 job :  IOPS=213, BW=107MiB/s (112MB/s)
  Seq write, 512KB, QD=32, 1 job :  IOPS=273, BW=137MiB/s (143MB/s)
  Seq write,   1MB, QD=32, 1 job :  IOPS=168, BW=168MiB/s (177MB/s)
  Rnd rdwr, 4K..1MB, QD=8, 4 jobs:  IOPS=255, BW=128MiB/s (134MB/s)
   IOPS=266, BW=135MiB/s (141MB/s)

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v7:
- collect Verma's test by tags
- fix one more place use ll_maxs, instead bursts_max, found by sashiko
- Link to v6: https://patch.msgid.link/20260710-edma_ll-v6-0-1471d278b73a@nxp.com

Changes in v6:
- use size_t for nburst (sashiko)
- remove unused field (sashikio)
- leave pause and resume as it because there are other problem for it. It
is not fully functional, need fix later.
- Link to v5: https://patch.msgid.link/20260709-edma_ll-v5-0-e199053d4300@nxp.com

Changes in v5:
- Fix cover letter typo
- Fix double subtract found by sashiko AI
- Link to v4: https://patch.msgid.link/20260708-edma_ll-v4-0-cc128f0afb61@nxp.com

Changes in v4:
- collect Koichiro Den test by tags
- use addr in argument when set ll address, found by sashiko
- fix iterate burst problem when exceed max link list, found by sashiko
- Link to v3: https://patch.msgid.link/20260702-edma_ll-v3-0-877aa463740c@nxp.com

Changes in v3:
- remove patch dmaengine: dw-edma: Remove ll_max = -1 in dw_edma_channel_setup()
- rebase to vnod's dmaengine topic/config_prep_api
- Add non-ll-start() callback to handle non-ll mode transfer
- Link to v2: https://lore.kernel.org/r/20260109-edma_ll-v2-0-5c0b27b2c664@nxp.com

Changes in v2:
- use 'eDMA' and 'HDMA' at commit message
- remove debug code.
- keep 'inline' to avoid build warning
- Link to v1: https://lore.kernel.org/r/20251212-edma_ll-v1-0-fc863d9f5ca3@nxp.com

---
Frank Li (10):
      dmaengine: dw-edma: Move control field update of DMA link to the last step
      dmaengine: dw-edma: Add xfer_sz field to struct dw_edma_chunk
      dmaengine: dw-edma: Move ll_region from struct dw_edma_chunk to struct dw_edma_chan
      dmaengine: dw-edma: Pass down dw_edma_chan to reduce one level of indirection
      dmaengine: dw-edma: Add helper dw_(edma|hdma)_v0_core_ch_enable()
      dmaengine: dw-edma: Add callbacks to fill link list entries
      dmaengine: dw-edma: Add non_ll_start() callback
      dmaengine: dw-edma: Use common dw_edma_core_start() for both eDMA and HDMA
      dmaengine: dw-edma: Use burst array instead of linked list
      dmaengine: dw-edma: Remove struct dw_edma_chunk

 drivers/dma/dw-edma/dw-edma-core.c    | 220 ++++++++-----------------------
 drivers/dma/dw-edma/dw-edma-core.h    |  67 ++++++----
 drivers/dma/dw-edma/dw-edma-v0-core.c | 240 +++++++++++++++++-----------------
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 169 ++++++++++++------------
 4 files changed, 304 insertions(+), 392 deletions(-)
---
base-commit: c9e9927c6d8346cdf6555a8f97da093980172e4b
change-id: 20251211-edma_ll-0904ba089f01

Best regards,
--  
Frank Li <Frank.Li@nxp.com>


