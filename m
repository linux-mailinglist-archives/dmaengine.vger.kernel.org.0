Return-Path: <dmaengine+bounces-8260-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AACD2198B
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jan 2026 23:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 582E43015AF7
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jan 2026 22:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93CA3AEF47;
	Wed, 14 Jan 2026 22:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TRyz6/jZ"
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011030.outbound.protection.outlook.com [40.107.130.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BB03AEF59;
	Wed, 14 Jan 2026 22:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768430074; cv=fail; b=rlcB6ykuN+BUfL7dKoDEiGLXS/gs8ivsPnvgFpc8cqOhazwAatJUmfYNTMglf0f8Y+18rXWxnIsUfIpF2DnlV2zPZdekL24Y0AUC4Xfote5cz0wePDvYcQcgog08Qu4a3oPIGJ540WazgjwSk5YY6ymQ89ClAjGHIIYX60yl8W4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768430074; c=relaxed/simple;
	bh=Tbf7OnXpUHIFI8anYeeb7AjFgn4x+JUTTHZWEP9jc7c=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=bPNtEDSjA1/Rj2pkdKm1nCE2OjP1lxjHUFZ+rwCyHTmkCqI/90lun/Y3YbxP9PYYp5qyausrRtmhbSyguOsA8enFxGFRoQIuF/zO0J/ERsjI6PYz1Hm3GtX88L6OdeHjrRgCkbI9R2BrKm+N8YGMfNFKhls93grhcwP8C1O2E9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TRyz6/jZ; arc=fail smtp.client-ip=40.107.130.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uc6DKGEJEy1JOdgyibiXhIsA3Y3LE4Q7nWGndSfSNU9nhJGjXkMIbel1lgItDZwK2wkNq1oKx2sPnIyOh2m2xUaviAbE9WZMwsHjsaOPkbtid2UmJbRWsKEldjFNazlS6Ck3pzB6LTWLtVNpt2ZHW3KuJUOcR57pLLllDAn+JGB/4LCkLcqayg3+mx3P/jwBr5sLcfjAA5d7496GkkFzaQg79KLw78O0c1L1dbUXT7Te8XCollo/qDUwdRw96eq3AKePPdFYVSOYT/OSkm0BT1AkVQKh2BTnAaLOdiyl0T3pPLwU/6SK4ULraNMaHFw1p229ufBOXHH2pEeqt/F4Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tQwRs+JpP/trgnV17CyKWgBwVfAMdVaNSL+Y3HCu7t0=;
 b=rsn4gVlHgzePhYmeSmrEbaSJd7Wo8wQ5mEFqKMWYfVjI7hG/g1PXGfbnAqGdW2nTnLbJOcvg2K9GlVUBAvGHY/M7pxDzU8rLGPv2SRlW9xqzOAxp8Fewfn50h2+L3g61MNeaCzmkWGAZsr7lUrakYnTBsjmVgQfhzGrDOSHd8wTzMQLPWct6mN+24JnYEmAajzqJAsVpQMnNJB22VeNX2oLf4wthbgZhJ9VO46IVFwrH1BbpgT4s5KRMdKBtpBOZIXvdcS/ukOnR6KpcSm5ChLqv0+bhRpeBB0Z6l6Vj8K92VHj1mVpyPQ/P9SjoWNFVtLzR9h6lu8PV1ZXS5h4+0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQwRs+JpP/trgnV17CyKWgBwVfAMdVaNSL+Y3HCu7t0=;
 b=TRyz6/jZJWQ66YdfRex7NkA3EBex0lT/3U0AQEbQe+LAx1xtXKpdZeToAPqKppXVlFbUP/Yuc2hzNlO9Xf9AtGL1FdziDE5ieOI/v+4VboC4GQOr2fCAuxYxodOu99gFkw3IoQBt+6Dfz462A81I4Q5KTXNMJVKiayeP+3JZ8DeGp436wfObIX57A/ug/ZsGYTM6LaQ2sXHkJsCXN6Zfc1GEBKzkWa7SC9I+S5TU62/PfVbqzLHtAxfwW5k2bAdzb0EXPmLKzjHCCEWO3YkeDdiWudwdigddv7wXhiIDJuQYu6BrKLCABxecFcRYWFnvt/jxJ7g2r/OIMw1Ih13bpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by DB9PR04MB9554.eurprd04.prod.outlook.com (2603:10a6:10:302::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Wed, 14 Jan
 2026 22:34:03 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9478.004; Wed, 14 Jan 2026
 22:34:03 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 14 Jan 2026 17:33:18 -0500
Subject: [PATCH 06/13] dmaengine: mxs-dma: Add module license and
 description
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-mxsdma-module-v1-6-9b2a9eaa4226@nxp.com>
References: <20260114-mxsdma-module-v1-0-9b2a9eaa4226@nxp.com>
In-Reply-To: <20260114-mxsdma-module-v1-0-9b2a9eaa4226@nxp.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@freescale.com>, 
 Frank Li <Frank.Li@nxp.com>, Jindong Yue <jindong.yue@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768430015; l=651;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=o15bPOST+VPjJ/nT5MOg5zQEiNO3sOuP04M2ygO8Mtw=;
 b=WwDefsDM4rtV0G/2uNIxnR/72ROJ1raj5QTLlx4UvaXFOKFmB/35dBGi+WaAjcA4eWiawocnL
 rBS73TLijH6C80F3QkyITR3HT89wVp0OyptmfR4AEvd4r8erADdyG8J
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH8P223CA0005.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:2db::19) To AS8PR04MB8948.eurprd04.prod.outlook.com
 (2603:10a6:20b:42f::17)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|DB9PR04MB9554:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c77fe39-3b6e-4208-adf0-08de53bd052f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N0JZcVZnL2ZpZGxyTFg3SnRFWFRpNDBHSitkbDg3Ny9GdlZKTjRNcmNnRHc4?=
 =?utf-8?B?M3d4RFFpSy9HNGs3d3ZhSFZVSmluTVRwditjWnU5VVNnbExTeWNjcGxFY2dq?=
 =?utf-8?B?RlV4OTBvWkQ3VHNLWVFVTnBjd29SYURxWXBVekpaSEtFdFhPM2wyYVN6R1Bz?=
 =?utf-8?B?SllIV3p2S3JCYXNBOS9lZUR4eTQvdzF4bFcrSmZPNDkybEswVjA1MWFKZFBt?=
 =?utf-8?B?OEIyQ2g1V2kvVjRJWmRWcWhTNWJIMUZCOW9hTGdMVWZ1RVhDcGd4K295NnVI?=
 =?utf-8?B?TDJCWm1oRGUyQ0ZibkNDako1RDNGWHp6M3hTQ0hKTXJ3K1hXMUVURTJra2Rz?=
 =?utf-8?B?cVJ6dGNobU9JSmpPQXdkK2VTZHdGbWN6dWduN28zNGtSYmpiQTJPTUpDc1Fr?=
 =?utf-8?B?S0xCS1dUK0FtcjBUTlNqQk5uTHBTMkpIWUJLNnRMejErMlQwWld2ZE1ZcHRu?=
 =?utf-8?B?Ry8yZFdNS2hUS0xObCt3M2FWbVg3OHQraGxNNUdJNU9pbjgrbmgyNlkrZWQ4?=
 =?utf-8?B?enA0cWpOYUpJZFVWNWtSOWtsK1A4bVJNOEpjcC8wVGtoeHBYNXEydHhaYnN6?=
 =?utf-8?B?VTJ6OWsyWTFNZ0R2eGliZCtxRisxNkxKN1FldmJsNHRCdkZWTkl1Y09iQjRz?=
 =?utf-8?B?VHNwWUtIeHk5dTVpUkdtaFZVSGl3c3J0UEhYYm1kcHBJM1RrSjlLbWViUGdB?=
 =?utf-8?B?R083TDkvNXNXMk9ET0UyaHMyTTV4c2VqY0swbDBMcnp2THp5WGVXbUZ1ams1?=
 =?utf-8?B?WTY5Ym5vWGNzam5PY1RXTGxCUnMvbktGNjhHYXpxREwwMG0rdDYzOU1QaFBE?=
 =?utf-8?B?bmRPL1ZxSWY0c01odnp4VkJZd0lSVlN4ZjFEZzRBU2Nqb05nUUh1bGRCSjlO?=
 =?utf-8?B?SDVMdlRmYldheHhheUFSdHZYeFJlZDViK0svMzBRbFRTeEdQWDNZenEyQ1pW?=
 =?utf-8?B?bWNNSytNRFdXaFNqalJ1SGcrZmNnOCsvNjJaaTBsdDgxamdEUnZMb3lVTnhw?=
 =?utf-8?B?Y1ovYTB4Z09NUHVOY0czOU4zWHlUNi9YVGV6aDZDaGd3Qzg0UnkxNnpBUlhu?=
 =?utf-8?B?SFI1N0lFQysvdFM3R1J3eFNCM29PV1Z6NUs3b2krZThSc05IQm85SjFMblBG?=
 =?utf-8?B?alZJd0lvOWQ1Ykp2NjZQN2RpaVV0dktUTDdtVHNxNnRCc2ZOdXhhc3dmWHNp?=
 =?utf-8?B?UzNWdUcwWDlaSkxUZTlFalhsQndmbG0vS2xBUUlreWZQcDQ0bi9TRFRCZUtD?=
 =?utf-8?B?TEY3cStUZGEvWWkxNTk2aXdsTGVhd3lSNHJvNmhuam94NVM1MkN6RXREZytB?=
 =?utf-8?B?RkhOaU9LSngzelhJQVVaTnkvaFJ5aytUdW9sbHMraW5nUkl3RHFHeENCOVgy?=
 =?utf-8?B?TmpuZ2FWd3Q4c3FBVENhWG40MnFZWW9JL2VXaUNrVGVaMEVyS1ZoZ0NWRmxB?=
 =?utf-8?B?dVNMQ2huNUx2VUp5eXNEK3ExY29mYnBJRnErZEpWVUFTY2pTYkFVZzhvenpW?=
 =?utf-8?B?dytxZ2praHI4M05nWTZ0NEhJcjJ0cTM3TzM0Z0REN29RMUpSaWpTRWtsb1Zx?=
 =?utf-8?B?ODF0ckZTa1M4QlB3N0pQMjNJanp5SVNRbTREbFQ3MHVJRkVBTXkybE1qR3Rz?=
 =?utf-8?B?YTQ0UWdMdXVIYzFaOURqazhpK3Y1REdxY1l5b1NxUGROMnJCS2pQVGFjSDI1?=
 =?utf-8?B?TVU0bm8rQVR6SVNMNmVXMktuQzBUejNHMlNmYXdsTW8rWWJpbmlVaTRiSUpq?=
 =?utf-8?B?VlZXRXhPWG9LRWorbXdST0ZtL3lDL0REbnpIMUpKSVV1ZFc5M3E0cit0dzhq?=
 =?utf-8?B?SzRTQlg1ZnBmU3Zuc3kvaFhzU202SDFMK2w2OCtBQWtTNnJoZWJvaTUxV3hD?=
 =?utf-8?B?TmJ2aGhFcTE5WU1SbnBUZDVVZnc1RFVDaFppOXFreEl0cGxmLytjQW52dC9H?=
 =?utf-8?B?ZHhPeVZIT1c3THJXemtIVDlOSENmOVd6d215L2U2d28wcG5vNXJZTEhyU2Rz?=
 =?utf-8?B?cytPajAxRG14eHVRQkVzZlY2K2FabnY3VHFrSzZOSFF5d0hGS05jVE9CWjRJ?=
 =?utf-8?B?dDFkVHQ0a0lNNUhEMFByOW9TTFZMVE5Mc0MzYlBmL200bnJSOE1rd2p1RDJk?=
 =?utf-8?B?Wk9hYzBhdTAxVDZlamhTVWkrSGZuOEpneXdwOWFVekxWWVJva2ZXNVRaelgr?=
 =?utf-8?Q?VHXW1XQlNGua+zfJh5rVddE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eCtMbERWT1RacXNLWVJhM2wxR3U1Y2pPa0NxeFVjY0FDVzFreklTUm1nRWxM?=
 =?utf-8?B?aEFwK2g2b1M2TGhXV09EZHBURHY5STluSjBvendvOWFKdnlYZU5UQVRBazd5?=
 =?utf-8?B?U2dJZVVkMXF0UVVOYjkrTXZUUkJweXJKQlhKbWFha3ArbXBlclpaUUl3cE0v?=
 =?utf-8?B?WGxRenI1TUdlY1J0cTFjS1VPbC80YzdCaWNUa3RFMENsQkdJN0djdjFqclk5?=
 =?utf-8?B?YVJ4Y1ViV1drRExqdGVlLzZ4TC9NMzhEYlhiVVJyMDhRbEQ2T1c3eFpTdE84?=
 =?utf-8?B?V1pQVHRHcWdaNE5Hby83RjNjNkxWdnNyS0loTk9ZMVJDQll5RTZHWUJmanpO?=
 =?utf-8?B?K0o3L2NUaVJtalVHajJYZHhHN2o1dWxJRmhXUW9QVFlsSG5WTWtVVDhtNW42?=
 =?utf-8?B?QkJBbXUwbFBzUFNFOWluc2RGZm55Q3BzZmFBRHZJNFRCSUtTRGM5ZTNTZURK?=
 =?utf-8?B?UEdwdnR0Y1lEcE5vOHQzL3BiN1JzZnpaY2xZY3BZR3RkaDFOTVhKRjZJRVh3?=
 =?utf-8?B?SS8rY1N0ZUlxL1lZK2QydGo0WDVqdWhmYjV1MklJV09QNnFVUm55ZzhtQ3ZZ?=
 =?utf-8?B?UytqQktWazE2TjdTSkI3TVVXVy9EN0hFUXZZdXdVYUJQelpQTExjbHJwTUR6?=
 =?utf-8?B?bElTaFZJaldlYlAvY2xlVFpyazl3enZER3gzSlBHWnNJdE1ZdlRLck5LVFky?=
 =?utf-8?B?OGdYM1c0Ty9BSXRuWWtrQTB2U0RPUUZuUE41MTRMQmgvUWQwM01vb3V4czk2?=
 =?utf-8?B?QStjVXFodEhwaDVDNGc3aDIvVy9pTjQ0Z0E0b3J0czZCZ2YrVFUxbDhlMVNi?=
 =?utf-8?B?dVNoeTl1VlMveHU5NUFXekNCWUZXbGh0ajcxNWdSRS8wMVk4Q3F0enhHbEdw?=
 =?utf-8?B?emFjWDBwRjFrZnhPSXlwaDVQUFdFNXo0c1l1OWhaNVo0ZXB2b2FPcjBqQXc0?=
 =?utf-8?B?bmVYcTlweHNjQ3dZYTZOOEdNSk5BdG1leHExU3l3aEhDdW4vOGFRQllwczFy?=
 =?utf-8?B?VzV2MHFUaVoyQ2dsZHJ0OEkweHEvekNTSU82VmZPSGdSUlpsWVptNU14RGR6?=
 =?utf-8?B?K3JKSThJS2V1MlZzY1UzVmdXYlNhMEZLVGRpYXV2VytOYmx6WERDNFJaZC9y?=
 =?utf-8?B?Mlh1NENrSEpSNnFmMFBSbkt5ZUd3NTJqVzVMZytUaVVQQXR4bitua1BDRGRQ?=
 =?utf-8?B?VDRFdm04U1NyNmhxa0o5TmZpWVArNXNraE5DWWJYa2hHYStGVE5sbExGelJn?=
 =?utf-8?B?ZXVOcVJoS0FLT2ZFRHpMajhFTVVLbTQxZ3QrU3hhYUE5MVc4WE03K0I4dmJ1?=
 =?utf-8?B?KzV3eTJUaDRoY3EvK3RKSlArOUVacEFaSGRJZGxoM3IxSm52OEZOTHNlclp5?=
 =?utf-8?B?NWRPRmErUGtoVFF6QkRzZXE1OWkzU3ltdzZURU9ZcGwxbFIxUXZOTXkyQ3F6?=
 =?utf-8?B?Um0rbHNYejVkZVJYclhhRm84UkE3RzNObUIzMjhRenJVZjI0eWR6L21Wby9v?=
 =?utf-8?B?RVh6RzFPZUxSZUUrdWRocFNtMisrQ0d4UUE0QnZwOEo3bjVMekFDeVA2eCtM?=
 =?utf-8?B?WHFCd1lZZXViekcxNmRUVnl1YTBncGZoSVNoM25IUUhjUG9wS2Y2b3dEOWRZ?=
 =?utf-8?B?V1VMRjgyb3lwanhSTncxdC8yTURsYU9PRU1HeDFhK3B4REZScGNVM2hxMUVK?=
 =?utf-8?B?ZEgrNmFJOTV6emNHQUdhTUZJUU40b2l0Ym9mOGNtMkVWTUVJdkJLYllpL3Bk?=
 =?utf-8?B?b0xVSzRud21nUHlselVsVmova3BzN0MvcWlKem5DVHBwVDBXVHBwdGFhQWRm?=
 =?utf-8?B?M1lKM0Rtc0F3M3BvNnR4d0xvdTdKL2pGWjVyeFlHUkcyNElnMFZSQnlJamw3?=
 =?utf-8?B?MGZUbU9jbmFLSXRmS3NlNXJuT0xGNVU3S0prRDdoSU1mdUI1d0hVTFoycmJu?=
 =?utf-8?B?TC8rbUhrc3VQZXdSYzhHN29VT2ZrK053YUNubUtzZDlWTmxwdlhxUkhNUlRp?=
 =?utf-8?B?SEcrUjRqVEsxTitFclM5am9FYUNVMnBLeWxYN2ordFhSNmdGNFhQYzd4eWJJ?=
 =?utf-8?B?M3o2QmJ3amREL0g2Vm9qcFoyOTZZd2UzNFoyTlBQUDhlRHliRXJFS01RZGxl?=
 =?utf-8?B?d2xYV0R5OFk3S1kvdlpFRmh0VlltVEtTNHllN0VpUTZlV2FXSmRHVlEzSjZ0?=
 =?utf-8?B?S2c1Z2l0SHFpLzZCTlNwWis1Qjl4aTJZVWJJTmtkVS92b2tuWFlSbStjTUhN?=
 =?utf-8?B?amUwSHRNeEN2SCtyVENiek55RTFZYVJXQS9EZ29zbUdkcGx4UjZlM0UwdmxK?=
 =?utf-8?B?UnVvU3NJNHFNenFlN284NkJGRmQ0ZkxqcUUxbkp1c01JLy9lanRrdz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c77fe39-3b6e-4208-adf0-08de53bd052f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8948.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 22:34:03.6939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0TWqzQnTji0TtuSYma7fRJiYrxOlr+yGCfuJ7WmZA8Lgwe92pCH/pwlD85nxqTwEpLbaYLvGLi5nhFtzRRziKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9554

From: Jindong Yue <jindong.yue@nxp.com>

Module license string is required for loading it as a module.

Signed-off-by: Jindong Yue <jindong.yue@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/mxs-dma.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
index e047a41a8df2e84e0c68b112f59cc79c0ab84491..083a396a8d0d6f92bdde41e90c09f316da0dcad5 100644
--- a/drivers/dma/mxs-dma.c
+++ b/drivers/dma/mxs-dma.c
@@ -836,3 +836,6 @@ static struct platform_driver mxs_dma_driver = {
 };
 
 builtin_platform_driver(mxs_dma_driver);
+
+MODULE_DESCRIPTION("MXS DMA driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1


