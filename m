Return-Path: <dmaengine+bounces-10577-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DYgMgIwDmoK7wUAu9opvQ
	(envelope-from <dmaengine+bounces-10577-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 00:04:50 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B43859BB30
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 00:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 473E230233C8
	for <lists+dmaengine@lfdr.de>; Wed, 20 May 2026 22:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BEB53B47E9;
	Wed, 20 May 2026 22:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Z4ZCRWH4"
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013023.outbound.protection.outlook.com [40.107.159.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1823B27EE;
	Wed, 20 May 2026 22:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779314460; cv=fail; b=N7VZZoFxd1pF/QgYjPTWX1HyFgEt8Hks4pOz3B0w8RzAi8mYN+OkMyXiKS0H7fbjZUDcsgjcrtH/C4DRNXiSvDuJZbXxhoeGBwyEcmSsB9ootDGNQKvnp3traPeQ5y7FyPXVRGLppCARxij1au29u2MXDJV5lcBe1Lx1lo6aieo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779314460; c=relaxed/simple;
	bh=DHlc3SwvYtrTHGbNIGQpmy4twRjsxIzZQnHXq/+JiK8=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=bTFCTfLl94jms21Bi994e9jVxBbaMXri+4dX2btIIJxLZyxIYiu45Gs8PBDUv2W8+O6qZ1szPslUzkZfUjOlr9wybylj4+Ruz+M2AP20U4eXzSGYCCWXe9A3tmuo6YKQOgRUUNEKJwbNPpXTOVw6JHa5DDehLj073GToDChAQXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Z4ZCRWH4; arc=fail smtp.client-ip=40.107.159.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eHra0d7PVlIei2t2gZqB3yfPH4hV7BHi9Ft1tPt/v2NeUneYJ9WqrW/MYcSOWrfNujvUDGxEsSHipwpMVhcQfxTooVpLfPunn6ItWOjWESqvKT04v0aVEV/fzXpzFFZmVAzC8Q1T2lBy4bIztYIgggADDIrRA5oGS1sfGqT6oRn8SrydE7DcAf+GquZsO03G1ehVXeGk6etV5r5UJA9OOPE+X1raMFUfdtbh8u0O1m/Dy4y83Fn7K0C4NTc46rAWSgG8k/6K3axEoDX37PsEzO+zpqdgQk9N8jhrPh5bnlGSbd7vNylPorJNKPd/oLQSxlCPBN1CrAsdVI5Rb4SQzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R4aBUiKBnMFwsK6Afxi7ulK2qXsNXTYy3GBtvltTeJI=;
 b=d0/YwdALiB9seFuLSjC/5BbH8Q/9jxx/h1OeeSCQO9pTYm77tE+GqtQQNqcbQrx9jLKUA+iwKq6L4ZsC5bYcoInHwZySTkXgn81YbtKYmJoKKHl/TjpZKW4o6YpgmAdEbGSi5BZjZRfhFoZOpfnUkVkT2JMf/d7Jcv046tNsKOa5lnJ59lWQbbmohw6Oubzgss4UAJSeVteb1KrOomzae6z2eYyDa/bV26zi+B8hm4RHk0z5QBP8x+cmBSBQpFE/uQzZpNxLMwLT/qePJp+Si9uDLPfdzAAvfaLEDrhWu7F59ICA4A3U773sXwD9Rd0SXpjtG39+D0moXEWSZYkGww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R4aBUiKBnMFwsK6Afxi7ulK2qXsNXTYy3GBtvltTeJI=;
 b=Z4ZCRWH4fSrLxe3/rMkxovucCQJQEP+2MZoudN7OUw13hZRbOhdqZ9JZCDLA1rDCLM1BqmgONk6b7ObsngXAxQr5NVD1YN2Kuokh4AdtMM/BDZfoeJPojRZaZnEnhdwTbXjO/eT4TppJY9XGOu0S4NLh4hkwJtFoo++1vb67nHR+eXZu6IlZBJvfLSu8/Xzu9ZHCgCk6Nqtpk16gwyUPKTlIbLXvxlFuPKbHM0o+nw+HMKktYLf87/DRqaqAjcsIsvpTIIvFnwgY1ObLrLx8TjL3g7WOfv2cxu5Lor2adkJ4FiXflNBJOQCdtLsvBMA5M8g9z4uvM4feZFArlrix9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA4PR04MB8029.eurprd04.prod.outlook.com (2603:10a6:102:c9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 22:00:51 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 22:00:51 +0000
From: Frank.Li@oss.nxp.com
Subject: [PATCH v6 0/9] dmaengine: Add new API to combine configuration and
 descriptor preparation
Date: Wed, 20 May 2026 18:00:41 -0400
Message-Id: <20260520-dma_prep_config-v6-0-06e49b7acb38@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAkvDmoC/23N3YrCMBCG4VuRHJtlZpJJU4+8j0UkzY/mwLa0S
 1Gk975REC318JvwvLmLMQ45jmK3uYshTnnMXVuG2W6EP7v2FGUOZQsCYiTQMlzcsR9if/Rdm/J
 JGtZYQSDNjkRR5S3l67P4eyj7nMe/brg9P5jwcX217Ko1oQTJStfgOWIkt2+v/Y/vLuJRmuhD4
 xdNRXuooKqtMkh2qdVLG0DgtVZFO6stKEMpaFpq/dYMZq110ZYbFYga16S01PyhkdaaiyZjDTe
 pCrXit57n+R+O8h9npAEAAA==
X-Change-ID: 20251204-dma_prep_config-654170d245a2
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
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>, 
 Damien Le Moal <dlemoal@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779314446; l=3498;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=DHlc3SwvYtrTHGbNIGQpmy4twRjsxIzZQnHXq/+JiK8=;
 b=/ndXBG1/LbmGaS038ufLQyN7lgJhbM09Id/ZwdxgL/6YFAs0G7MNDAgfDlZiOTQRhkzzciW9E
 4ozCKzt5+ZxD4Q1upFzQBNswCtdoLgvzU5PsCYkJHM0avlKJwBLw6Jc
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA1P222CA0038.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::19) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA4PR04MB8029:EE_
X-MS-Office365-Filtering-Correlation-Id: d4798de9-0e71-4646-8954-08deb6bb4182
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|19092799006|921020|56012099003|18002099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	xDT+gFSdCWCqXzPXEWwkx8OfO2smgZderOZO5FHYP7i++cjQUw/2ik3M43CI1Qmfxwlr6xOjXu7yS5uG1M7aMrjDef8WMFuvsJ9P6iMdpLWRioCInxg4vtnHT6MDX3O8FLVR+IMPTKq55EO6hD1Cb39FNqELbHekzGV7jH3eDPwC9kGkUAUTQmW3ZDDBuXhCz4h/X4+yyHrqulEavlVuWx5GHj+h/icBINmBpNLht9gY5/wZPKj5K7Na5pLeorNBxK8k5cyOp5ZfLGBbfHZ61kQxzAR/UD/6kXZ1SXwtRN8aarw40k1k008pshXBr9iWEx3pRlY2eUojF682KnVzSN0dhLarUSh7Ezr/CuoByNSDQ0b2iftpWcR3eI5TsIudKeGyNk0uACG4NOtjhZQNi3T0EXHHPIQkoOL3mQQ+sIEbf2W6M70O0iJH5WIwIG3lgcO/Nz8+7icHqK/eBUx4J8gz3wm7gbLb8HdmMwENmA7xMQxTRIbeKSlYeSsQgY7fVGTLMwfx+80zfLAYkqeK6gfQ2dSv+fcwMXI3zccGvZTL0DeZnaoZKmogSXXnL12KIDUiH/Gfwni97i3PsGaph27Z6AE6Hnt0iQRofmvjOJ4kKiQenmYGfRbrTmxvHR1eG39eBgO9DLq+fq9CXknOYvzmVhjJONL/GbLRBTyCtvRICzuCteibuoz/yLjfBtHrpbcZv76gzGEq+FDXhJBA7uqVSThirOiMLFYs1EulE2f41IIhZJqfzlzELbm7Grqs
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(19092799006)(921020)(56012099003)(18002099003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N3VacWxaVzJlWWR6ODBEb2tuQlVWdjhSVHhiQUhCam4zSGhSSmpmZVJpRjJo?=
 =?utf-8?B?aGtPS0Jhald4dVJSaFlFd2RVMlk4Q2IxSkRsbW5XeitCTmZFeU9HTjU4blNy?=
 =?utf-8?B?Ukh5Y3JtWVBUYTZZUXBBOFczNTM2RWhvZWxqekptK3Z3OWVCMW5oK0hnaTA3?=
 =?utf-8?B?S29yVFlwYjhMNmczU0l5TGVnREZOVkMyMXRoZm91U0VaZzlQaG9WcHUvcUNi?=
 =?utf-8?B?Zi9QaW4yUkxYZEh3VklCNHFUcStteHhIZm5ZU095TEtzbGhMRkJQODcrSUdJ?=
 =?utf-8?B?MUcyS1RQVUxZbmlneWFFbTRyTndHMG1mRXBCWGZkbFdKOHRaTERpeG1ycDk1?=
 =?utf-8?B?aGhtVncxRUJhSWhkRml4VWRjM3pBcnRtdHZFaWs2SlRiWjZlKzJQK3kwV01T?=
 =?utf-8?B?Q3dTUDc4Y2dmRkk0a3kyMFAzZlg2dmRsV0xWSEJEaUlQQ29tdFVzUmxwdVpZ?=
 =?utf-8?B?VlhmY3cxcUl1ZU9wOGIwdVNUYVZmMm1Nd2lDWVdPajE2QnczUHhwaDBoVUg3?=
 =?utf-8?B?YVR1RUFtSXI5emczc3ptWWg1bUprcU1VRGwyS0xMZG1kUld1eVZlYnFBYlRS?=
 =?utf-8?B?Y0NPZjVlVDhIdi9LVXJkMnpXbis1cXFlbTBFT2Y3V0FJQ2x1VUpjZFJOeWxY?=
 =?utf-8?B?ZUF4Tm50bkJNblZRdXZadmZkVjMvcWlWbXl3cER2OXBSSG0xVjdYTzF0azRE?=
 =?utf-8?B?ald5NHM5NGt4Y09xV3NMSndVSDBCNFBRWmNDUXY5b0l1R3lNcjdZOXY3eWtT?=
 =?utf-8?B?TitETXJqVDZCMjcwOWRhVDVTY2lNakxEcitUQTZjTHIrSXJNZll1Ty9ySGV3?=
 =?utf-8?B?dFhhRnh0OXdSV3MvUk10ZXNFWWtsOGdPbE9OaUNTWEt5b1V2cVJhNTBJb0N1?=
 =?utf-8?B?WEwvMVBQRW83ZFZtTkFxeGw0MThjMGttU1M2dVRtZUxkcG5rcEthYTExMUxa?=
 =?utf-8?B?VUhISTJVZ1ByK3R5d0V2QUtETVZlY2hra2RUYVV3SWVIS2JSbkxIVTduMkJT?=
 =?utf-8?B?S3dCMlZmVHdtY2NQV003RlN6bVhkZlRzZmdIT0h4QmM2SDdFdlRjVjd1MDBi?=
 =?utf-8?B?NGFrRVNzeDh5ZkpTRjNXM1dRUmluMzFnLzlrYk03UzZ2Y0xlY1BTYnRPT3hn?=
 =?utf-8?B?S3ZYdUlqcUVVVzc4OTB0SnFQV3dQZ2daam44c045UVBRYzFtRldtczNOcFRD?=
 =?utf-8?B?VGlkcllaZDF1bSsvVEJTYWtnd0JFOEI3eUVVS1YxNTgvcFhGUzhZQ1p2VVFS?=
 =?utf-8?B?L0lYL2lTbW9CVnYwU0JvUHl1d1pUTzlyT2FDcVp1QmlXSURScDNvTEUxSnVB?=
 =?utf-8?B?ZER4L3RHOVJWNnR1NFRTeUEvcWpYSUc3Tm0rTnZ2OSs1S21ySlJNQy80SWMx?=
 =?utf-8?B?VTd2YlVJYVZnMUx4L0lMRitwZ2hLR2x2ajFzT0dudUYxWStVTlZsZTNGRjJw?=
 =?utf-8?B?RXNrL3hucmNlVFhJTWxFcXNDWE5IRzVRYXEzS0tCT0p1aFF4RGJySHVFVU5p?=
 =?utf-8?B?eVdMeGU2M3BhT1E1OUhidU9KZitzTjRaQUsycGZDbzVnNlpSdDZrUUh2VjdI?=
 =?utf-8?B?TlZ3dzRucEh0T3BITGp3MFY2MldtQnJPV3Q3SXdKWkxjc2EraW1KVm54eHRs?=
 =?utf-8?B?SjNwc1M1NE1SSE9lZ2ljdmxHL3c2QkhReVpleXA2ZklIWmNoTjdFRFYyN3hm?=
 =?utf-8?B?S2pnSys3R09WNXhNbWhDR3NnU2xSRjZVWU1NM3VmNDM3Y2oxcXNLeFdkVXBx?=
 =?utf-8?B?aFhDQkR1STdGUnJ1SWRLSXJzLzhxbmFjeGRMWjdwMzc5ZTYvZmoyem9FNHZU?=
 =?utf-8?B?L0NWaEUzMHNWcXBhRTg4SGZLM3pOakZ4RlpZbzl4TjdpZEtXbVAvMmVmbXBG?=
 =?utf-8?B?SGRWb1d0Zk40cDdGZ0wrRHdSQms4S2tSRVp4NnZJUXV3alJCRzgyYTBlcnBO?=
 =?utf-8?B?RURITzNVc0I3MkxFa0NoOUtod1JWSDkvSGtFZ0NaZk1SVk04UGFEVWN2Y0ZE?=
 =?utf-8?B?MG9kL040UiszOUpwa1ozbE5vYmJvTkc4Rk5ZYzVIa20xSjNaMEZSdWkwQk1w?=
 =?utf-8?B?VEc4MkdYWmI5T1lUbzJnL1JVYThleVhsT1BzTEphVm5jNG9PMjhwRCtJWjh6?=
 =?utf-8?B?WklkOWt1QUtianVwWmdkTjdlRG5pWVBSLzdoZDVpZVRwdmQvR1FhY0JFR2lN?=
 =?utf-8?B?RmllSFhhQlhkOUN5Nis0VHhPdllsNVVGU25Uc3E2TllLVnNWZklNTGRhM1RP?=
 =?utf-8?B?Y2VyTWk3VWRVSExrcEZuelUyK3VZM3QwUHJ1S2VHbWlvWHhuUzl3RWVOM0Zw?=
 =?utf-8?B?cE5tYmlNT2tGcDJkbVFYMjlhMHFuRGdydXMxRkozblpSZkkrMzBuSUNqYlRT?=
 =?utf-8?Q?8jwY6iPOjVxpL2jQ=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4798de9-0e71-4646-8954-08deb6bb4182
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 22:00:51.1579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eweOjq6eCDWvNZmNmFvLjbN8qwm00XGoPrv3XNkoYrkQXe0D1yB7lLTr3qCxTo6Fp/7R3pOGK3IWwQ7dtbmNUy8EsTrmObbfXxiBE0Q4mRP0n9VFhbBJL2mB0hQLhSo8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8029
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10577-lists,dmaengine=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@oss.nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:mid,nxp.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,NXP1.onmicrosoft.com:dkim]
X-Rspamd-Queue-Id: 4B43859BB30
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Previously, configuration and preparation required two separate calls. This
works well when configuration is done only once during initialization.

However, in cases where the burst length or source/destination address must
be adjusted for each transfer, calling two functions is verbose.

	if (dmaengine_slave_config(chan, &sconf)) {
		dev_err(dev, "DMA slave config fail\n");
		return -EIO;
	}

	tx = dmaengine_prep_slave_single(chan, dma_local, len, dir, flags);

After new API added

	tx = dmaengine_prep_config_single(chan, dma_local, len, dir, flags, &sconf);

Additional, prevous two calls requires additional locking to ensure both
steps complete atomically.

    mutex_lock()
    dmaengine_slave_config()
    dmaengine_prep_slave_single()
    mutex_unlock()

after new API added, mutex lock can be moved. See patch
     nvmet: pci-epf: Use dmaengine_prep_config_single_safe() API

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v6:
- Fix sashaki AI report problem, detail see each patch's change log
- Link to v5: https://lore.kernel.org/r/20260512-dma_prep_config-v5-0-26865bf7d935@nxp.com

Changes in v5:
- collect Mani's reviewed-by tags
- use kernel doc for new APIs.
- Link to v4: https://lore.kernel.org/r/20260506-dma_prep_config-v4-0-85b3d22babff@nxp.com

Changes in v4:
- remove void* context in config_prep() callback
- use spin lock to protect config() and prep().
- Link to v3: https://lore.kernel.org/r/20260105-dma_prep_config-v3-0-a8480362fd42@nxp.com

Changes in v3:
- collect review tags
- create safe version in framework
- Link to v2: https://lore.kernel.org/r/20251218-dma_prep_config-v2-0-c07079836128@nxp.com

Changes in v2:
- Use name dmaengine_prep_config_single() and dmaengine_prep_config_sg()
- Add _safe version to avoid confuse, which needn't additional mutex.
- Update document/
- Update commit message. add () for function name. Use upcase for subject.
- Add more explain for remove lock.
- Link to v1: https://lore.kernel.org/r/20251208-dma_prep_config-v1-0-53490c5e1e2a@nxp.com

---
Frank Li (9):
      dmaengine: Add API to combine configuration and preparation (sg and single)
      dmaengine: Add safe API to combine configuration and preparation
      PCI: endpoint: pci-epf-test: Use dmaenigne_prep_config_single() to simplify code
      dmaengine: dw-edma: Use new .device_prep_config_sg() callback
      dmaengine: dw-edma: Pass dma_slave_config to dw_edma_device_transfer()
      nvmet: pci-epf: Remove unnecessary dmaengine_terminate_sync() on each DMA transfer
      nvmet: pci-epf: Use dmaengine_prep_config_single_safe() API
      PCI: epf-mhi: Use dmaengine_prep_config_single() to simplify code
      crypto: atmel: Use dmaengine_prep_config_sg() API

 Documentation/driver-api/dmaengine/client.rst |   9 ++
 drivers/crypto/atmel-aes.c                    |  10 +-
 drivers/dma/dmaengine.c                       |   2 +
 drivers/dma/dw-edma/dw-edma-core.c            |  41 +++++--
 drivers/nvme/target/pci-epf.c                 |  24 +----
 drivers/pci/endpoint/functions/pci-epf-mhi.c  |  52 +++------
 drivers/pci/endpoint/functions/pci-epf-test.c |   8 +-
 include/linux/dmaengine.h                     | 149 ++++++++++++++++++++++++--
 8 files changed, 208 insertions(+), 87 deletions(-)
---
base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
change-id: 20251204-dma_prep_config-654170d245a2

Best regards,
--  
Frank Li <Frank.Li@nxp.com>


