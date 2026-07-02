Return-Path: <dmaengine+bounces-11990-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ljBEFoTWRmqieQsAu9opvQ
	(envelope-from <dmaengine+bounces-11990-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 23:22:12 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A362F6FCEA2
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 23:22:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=jTN5qEPB;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11990-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11990-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF024301BC39
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jul 2026 21:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423B2348465;
	Thu,  2 Jul 2026 21:21:39 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013048.outbound.protection.outlook.com [40.107.162.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E0C33E36A;
	Thu,  2 Jul 2026 21:21:36 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783027299; cv=fail; b=q6+K1OULPoPmmSZUCnjSbDh3RUypmLlsd1ceAJW8t9FY8TNxYEeUyKkHDUCtz/aXKbxsSLwWnALW1+K0lVp66Z89rQxFImtizXDEInoVCinn+qv02uoTFo6BAbBMh294Pw1xQ3cACAW8I1fcVWsy5hWdOrMvodMkG1CCnHPPCdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783027299; c=relaxed/simple;
	bh=PH/sQ3RZ8YFvzu4kEo4SOecxpFyLtvyDs1BY6wkMbwE=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=j5B2Jc3+9/0cL9YgQK4yc/QmGGoN0ExVId35EuczlI+MLX2b/gCukMYYBlw0/M7s3nxUOTzeu8kOgr/rvHLavpLcN9/uip5nKUl+liwuJFp5X/QZNr/3C0L+1rpvMM2G7cVW76X3PUXEKmmrqjcQmT2U/VJyHgbRac0fXKYoWf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=jTN5qEPB; arc=fail smtp.client-ip=40.107.162.48
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nIXLct1dFC4tU4j8QCxtTQbDd3MoFhzaiAgExNgVQx74MshHIzeqvgTsVWg25Qfl1lwTuC7ggtUX2gpd09eoa7MJ7K8Pip0tD+Wy/4kq5+vk6f8UxzjS1PAyAFaQBr1p9hx3X36LVdEwGvWKYz3nMw35Ort56uItudBghQTHIibC3vB/WJYt3PiFuJ9bkLrgTXXjC6X9Y2gWhY86wFnkP/9+c9xkYjtuyMEUz5g3JHTMiYtVbNzDeGDMUeh0VlGPaTkM/UAekMeergCW8iYIKRKUCo1WqIPw7Hgwdv5KCIn9W+iYes/1ZHoBrEilQcWR+dkap/x5M5eKzj9zxRMFzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nceZxM8HCEeaizbbM3pPQ28huhxHyW7R3n1qlW9CHR8=;
 b=oN2r9wQ9/iMZcDmQc5rq3Pp0EKdQ9f2QUeTSZN01GwhihtUEXkrADgXJorFqWDaWkr7xgub5Ed8wSX/fzWPvWZasBAuN0KdT8MbaG79hTE0U+6Nr2ooQqH9pj+pfAd87yjPCq+G/6nlewim8paENxZDcJO3hLRKZiDP84etRRASExUWOOzStlPG4JAptVWL7WZqkC2IGGM99u63w+MD2wS/G9IIONfhGwym2/8DE5Y5qtOvMQ6ahFyWdnrr7l1cJs63JCss4tkkO1RDLnA1Ho8/B7LO7O374aZG90hL5QEQEg9nqe9jioaArUfQ7lVJ5z5M2VaQ08rygaUSxTKQXkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nceZxM8HCEeaizbbM3pPQ28huhxHyW7R3n1qlW9CHR8=;
 b=jTN5qEPB6iAkSHyQuckHrvKJ8yn0p6uok4P/FG94vvy6uKr67pMLbClu/v/THE7GceaH33p6UHJ2crAObqqiwH9RsyQT54Gx1HY5cEJpU1l71f1Lz6nur36v26aR+6nQXA5yspYtmeiNqe+KfsNuaLiKA6er2/oDgeuXN7eGyRHDyZvV2CmcRJzjHaT7LliKKJTE00loWMjFoMOc+GrWctmQa5Kf+tgCoFFR9/eciVDrLMebwHbgTr5JUPZxGVOcfXZcngjtzNsJuXtewxVacVmbeQOhXmjQEcPN0ukNEaG71K/Q2Couygydk86ejNf4gREqqrDEP1yWbQFol1co7Q==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DB9PR04MB10066.eurprd04.prod.outlook.com (2603:10a6:10:4c1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Thu, 2 Jul
 2026 21:21:33 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Thu, 2 Jul 2026
 21:21:32 +0000
From: Frank.Li@oss.nxp.com
Subject: [PATCH v3 00/10] dmaengine: dw-edma: flatten desc structions and
 simple code
Date: Thu, 02 Jul 2026 17:21:20 -0400
Message-Id: <20260702-edma_ll-v3-0-877aa463740c@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFDWRmoC/0WMwQqDMBAFf0X23JTNqqnpqf9RSokxqQGrkpRgE
 f+9UbAe5/FmZgjGOxPgms3gTXTBDX2C/JSBblX/Msw1iYGQSk6cM9O81bPrGEosaoWVtMghvUd
 vrJu20v2RuHXhM/jvFo58XfcG/RuRM2RWVyJvpC21ym/9NJ718Ia1EGm3BHKUh0XJKjXWdKlJC
 1Ec1rIsP8wkiuTSAAAA
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
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783027287; l=6351;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=PH/sQ3RZ8YFvzu4kEo4SOecxpFyLtvyDs1BY6wkMbwE=;
 b=VSMjurXW7nf1lSCw7lkkHQR6qaLDbMzBqS3q1Dcr51swoQpGAWWSYout/LZBJflyNufUgIfRh
 yYckJv2jFE3DsdVUKLXvk/WYrewBxxCR0yycYsmLlaPbiUCtINwaTOg
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA1P222CA0044.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::9) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DB9PR04MB10066:EE_
X-MS-Office365-Filtering-Correlation-Id: e9be0fed-1f72-4bb8-3a11-08ded87fe338
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|7416014|376014|23010399003|366016|18002099003|56012099006|11063799006|921020;
X-Microsoft-Antispam-Message-Info:
	CzRZjRRZ6RRtTJ0mY0fZ1HzgGp/CwAWxB1U1YA4TCptHthaWtG/EfG3XwrStirGXwCQXj4AQ+sOgbUjeuY5utFH9D95G4aAw3xXZbY9d5OPAa2Kpu51nN1+vRtH8xu2UrU9zPgYbqcrWhLD03f7XJk1fWx2qcGc/9LZ6npKNEgDCOpZGhTPX6YPki5pl7P+rKgMjESfF17YkpqYQRWTw3c1J/wB0sBdpNHIlaUCtFh+RpwlpT1qHLeCSAjQqwsHZ/EufC9B+RsmenPSDUcBiqdsOyU1dxzt7DI7AxSPsDA8+38otXvdJdMZNP404WgpGKaF9WVgzPoACpdU+rQmo0eryVmnQRGRWuTWxjqW+31AKbcl6TLf5NEQadMkIrcJQmKHkPJYgPEgVfHDhcZSB2le1lG9ffh0ikUsu6I/BcZ+nfT5fHE2Mtbjn4Yx0nX+VpviVypkI2lN3Eu7yr+XgO59G10aPLwRVi9ReseZYR4AxeCLv9RD+Ym1lMFYHAGnHnJjHdFce6RbW7yl2/qMKdAZj/orW2Q62owvGCjcfXwKaxT+sOAxTNwMihULXrzSO6aUnV7HXs6KAG5EQ1ZVbIdAVpjsNaULcSJwU1imCLtEheabOMXS+xnGLKyZopDiKr8U5+KomjNn7cgOFuw2osA1AqI/wKsrx8KigY39iS2kHZIofivNq6e1RBo8KEiF1riWy1ai/Hf8OYlivzdAOmg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(7416014)(376014)(23010399003)(366016)(18002099003)(56012099006)(11063799006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bXRNMlpZQUhHOStWaGNpdGpLMVordTJpUitBMis2bWZNSkF4Q0dQUi8zeWpZ?=
 =?utf-8?B?UFZxUXlIVjZqekNKQ2hyVUxLSTdrdWgzV3lOT1dQR05GVmoxalN5THRyM2xG?=
 =?utf-8?B?N2tIZXV6QXhtUGtnMDVwM0UrK0ErMU5rczZqRWFVU1VqaE0zSDZia0FNU3ll?=
 =?utf-8?B?S2cyZUg5bW9oekNUQUhicitjOU4zNkNySUNOZGJGaE9JaURONHRnZWNGK0Fp?=
 =?utf-8?B?NTNCWmd4UnRpVVVCMWNpc0Z0QWFZaXJjc2JlTFZpd3I0ZVk5QWJWekZmNlpG?=
 =?utf-8?B?VUJtY3IzVWtiaU9nUkl4U2pSUlJNU201KzF5TkVwbjR3WmptVW5JYm5kTFVy?=
 =?utf-8?B?d1ZqOENOaGhUKzdIclhMdGFnT25JTldpdmV3dERGeFVLZEtCSThVZzh0UjNM?=
 =?utf-8?B?Nm50WE5oc1J2YnlubXBXZ3F4VmlmcFZ4SGxaM251WXNYOGs3Rm5EbGlueGxR?=
 =?utf-8?B?WFl2bXZBTEVJY1ZoWnZ2YW95NE1Dcm5IeURFc3pkNFFNNkpMWENOQm0xZFk0?=
 =?utf-8?B?a0pCeDBqV3hlZUFWN3ZqSmVJYkE1c3l1OU94SnRVcDNSSmF4cnJKYVV4dzE2?=
 =?utf-8?B?M0VGdUl6dlo3ZW1SdTdOL3Q2c291K1hxZ0NiUEh6NFdLVkx6S1lTdVRkakRm?=
 =?utf-8?B?dFRUQm1Ka2JhRDVFaC9hYlYzTThTUVZtOURYNlgwN09WSTNNMWprc2IyUkRj?=
 =?utf-8?B?WjFpMDl1Q08vQ2RHaElaeEFja3BjY3p2dVhpakhFMFZVZU55Q2lpWmFocklh?=
 =?utf-8?B?VE80K1JXcHRPemRCekZwV29INVZkWDBUdWs2MFVQb1Q3bHpCdVhUb3FOdzhE?=
 =?utf-8?B?azc1N2ZEaUxoNDF0NkgwZDFCYk5FOWdJMlhhUUdERk84S0NiL2JuREhoMTly?=
 =?utf-8?B?MmR5UnQ3d0tjNkZtZ09IUC8vTVA2ZCt4RXRmbUplREhCbEl4QkNzZ3lJajdQ?=
 =?utf-8?B?UWpyV3ZpZW8xTnd4SXR5bmJKc05ySE9IRzNLbUpWYS9uQUVaQjREU1ljTGtk?=
 =?utf-8?B?Y0FSbnBSMWdERThSbWNFaDZnVXpPT1lpYVUvVXVKQnpoQmQ4d3FsblF1VmdY?=
 =?utf-8?B?RFI1TVJRR0tmL0xBUUVxSjBLdzdrSlpxcE1CWHhpNEQ1V25yM2RCeCtRbi9x?=
 =?utf-8?B?K0RNeDZxeDc3UXcyc0VqR3pYdlUrV2lPZnh0YmsveVpPVlRtRnBzaFZtK0Fk?=
 =?utf-8?B?UUI1UytiSXYvRzZOR1YyQ0ZCZDhmdjVyVGhlUHNUbzVmcWxRUy9nQ29mazF5?=
 =?utf-8?B?VTErV2wzQm5NTS9WenBpM2JUeHN5NU5aZ295QWQ0R1hOUjY4bmRZb0wxeWtn?=
 =?utf-8?B?MkZCSGZRVmM5bnptSFpGNGkwVjNVM284VnI5SCtKY0h6VWgxTnhuazBGeVdp?=
 =?utf-8?B?Z1U4UUVrS29mSEhJa212T1BESVlUVUdPeG5GM0NXbVZnNHRQWDFjTGs0VHRT?=
 =?utf-8?B?dG41NEJRUzV4aU41dm9OU1lIZ1UwcCtiSHZPdER3Q1d3NUJKOU1pWkg5VmJM?=
 =?utf-8?B?NUxHMTZxbzFpS2dacTVabzM5Z2JVbGszc0JFMTFxcENDbGF5RXAxNW5PUE9L?=
 =?utf-8?B?cWxBMm5BdlhZejAzYlFWRzVIMGxLeEw2M3NIYVVvTEJSSG1ZRmQ2dWtuMERO?=
 =?utf-8?B?NkpYUWZUTWUvNS91clNtQ2NFUTU3dnRLYlk0YTQyUmNwNFpUbURrd1RzbWRE?=
 =?utf-8?B?TFJscjNKN1lsSXV0amJsdjF3ajdrWVZja3RvaWVNcXdSM2pJcTdFdXIzZmU5?=
 =?utf-8?B?Nk1ZbllZeHF3eDIzNzdEalZUU01pd09QaEUwTVF4YlltUzlQbHR6Unkvd0JU?=
 =?utf-8?B?L21mMk95YlZEakM3Z0tWSDBJUWdxcGtmQ2FUS01vSU1xdGFoSFFUQVJuNTg0?=
 =?utf-8?B?T2lSSlB0dWRFSjY4RDl5NUgzQjNKemJTZjFxOHB6YU5aNUlZOExwVjcyd09D?=
 =?utf-8?B?YVk5RjlheVNuTjgxUHo5NEhUd1dvRkRkNW1iV3QzRGtRcFg0YnRnSElmZUdI?=
 =?utf-8?B?eEVRaTJEcXQyTElrVnZybTJ5L212bFpZTGtRdmNCYmhHWUt3dGRUZ1Nkb2ZW?=
 =?utf-8?B?dzNlZ1RzdnBkblVWckxrZGFSNkJLUzYwa2swRHZCUzVyTFN0RmdWajBpOElw?=
 =?utf-8?B?NjFuTURlVlFVMlg0b0tvUHFKZ2EvMCtycUdoVUJjTEFId2VSZ1VsQ3N2RnRs?=
 =?utf-8?B?Y3l6ZW9HUkY3YllWRFhhOURXUlFTcGZTZ0J3cmY2NkxsYUdjVzNNTG9OSTNL?=
 =?utf-8?B?Wm9vcUZrZXJhNjJZbDNCMHMrcGw2dE51VVZQVU9lVlNRcU0zcGZEblJvTzFn?=
 =?utf-8?B?U2hjY2NEakRIODdkdTJnNUVwU3hlM3FWUExwbk0wOVBucXFTRFpGSTFCRUN2?=
 =?utf-8?Q?eRogAVBKr9UtegPhX877VsBkcs0A6v65rcMcQ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9be0fed-1f72-4bb8-3a11-08ded87fe338
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 21:21:32.1586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QsmRJe+XFEoGJtSGfmWwd5YiGhqipE2EeIFUjI4oaE8ukI2vz7w05XyCd8T29F4vq1GU6iMBMHpf5wnMUthkixVwIKbvtXYwKvdNEpMwQpOGld+Ac32n/5T3tsf7dKPc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB10066
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:mani@kernel.org,m:vkoul@kernel.org,m:Gustavo.Pimentel@synopsys.com,m:kees@kernel.org,m:gustavoars@kernel.org,m:kwilczynski@kernel.org,m:kishon@kernel.org,m:bhelgaas@google.com,m:hch@lst.de,m:cassel@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-hardening@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:den@valinux.co.jp,m:imx@lists.linux.dev,m:devverma@amd.com,m:Frank.Li@nxp.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[Frank.Li@oss.nxp.com,dmaengine@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11990-lists,dmaengine=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@oss.nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,oss.nxp.com:from_mime,NXP1.onmicrosoft.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nxp.com:mid,nxp.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A362F6FCEA2

Koichiro Den:
	My hardware temperately is unavaible recently. Can you help test
it.

Rebase and compile test only now.

Verma, Devendra:
	Can you help check if block non-ll mode?

Frank

Basic change

struct dw_edma_desc *desc
       └─ chunk list
            └─ burst list

To

struct dw_edma_desc *desc
            └─ burst[n]

And reduce at least 2 times kzalloc() for each dma descriptor create.

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

 drivers/dma/dw-edma/dw-edma-core.c    | 216 ++++++++----------------------
 drivers/dma/dw-edma/dw-edma-core.h    |  65 ++++++---
 drivers/dma/dw-edma/dw-edma-v0-core.c | 240 +++++++++++++++++-----------------
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 169 ++++++++++++------------
 4 files changed, 302 insertions(+), 388 deletions(-)
---
base-commit: c9e9927c6d8346cdf6555a8f97da093980172e4b
change-id: 20251211-edma_ll-0904ba089f01

Best regards,
--  
Frank Li <Frank.Li@nxp.com>


