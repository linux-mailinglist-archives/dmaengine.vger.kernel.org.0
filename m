Return-Path: <dmaengine+bounces-2059-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1998C8C19
	for <lists+dmaengine@lfdr.de>; Fri, 17 May 2024 20:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 056A42840CC
	for <lists+dmaengine@lfdr.de>; Fri, 17 May 2024 18:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D069713E03E;
	Fri, 17 May 2024 18:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HLEvajm1"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2085.outbound.protection.outlook.com [40.107.21.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E1B13DDDB;
	Fri, 17 May 2024 18:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715969429; cv=fail; b=Sjz/b8fSmc6TIfibEDGTqgG6enxsN+Zk+h/aGZWOMP+6VkQpojJ+R0dekoiIUWEse40JRrk3o+Q0shEsuEA7z9ju2EgylSZYYd8cVgNGJ7Mt5bxk9p9gZsAiNb/o0bKXJn/OigpHrydhDuEcqcIXEPeuR4/5xGII621ARoBSgTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715969429; c=relaxed/simple;
	bh=Ue9DoiTmBK6eu+g2lWFajA/J9GaQ6d3UFTf3Ewes2Ic=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=b4ld7z0M7AKXMK8oXcebfx4l7kejtcrLOc+ox0iB+vmYGni+9J9F3VSg3kT+IA2o8RBAQx1yS2boVkKUmOsySq2tlAES7rkSSKQs4K+8fEuRN7tLzyWjG0gGraLi3qCm6fl5UrdXcSYRMfSJQ1P3EFl+Wql9REX6xf9/Zt+67z0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=HLEvajm1; arc=fail smtp.client-ip=40.107.21.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gfkMesE3PdgDKCyaElDytuHac+Gq7x0pYj0dpK15oJSsEKAG02+eUIsxQJI7bVA0oRToNlnnaoClemyHQo+OCpC8J5B69TYElKZw/lBFS9tRI1WwWdBP2O2P09Mv8NI8CN5RBonbQtC5UH7WTMpW/WAMolQ6MaF3US0t+aIC6T6UhuhBhBO5wOb6y2e6ASeio6ZQAd0K2hgXnQ5HYrg4C9M20TvewztFyNoEawZ9yIL0ltoQuUx+h2yuMZn0L54s46FOO83EHIJKnutJ0Z59HrqKxMs51llOhDnhK2Dh4OI92xRWNx7QDUXOOHsEc9QfNDu/st1AB3GUW55SipJ8kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BDlgFfsLoKEnExBRGn7/MB1Z+OHdzQrEQt8j81qDNrQ=;
 b=EGlSH8b1/BwCj92RVvgErsHxZUcuyYc8823XfIBoHTvfu8QYT6rKRqxwJGoSw+n1q8BYiUrjot++anBfyCT3xwtDeuhSMkO5rT0MEWJwZX/pfFZjcunoYRdsFco5y9BCRDCxscyboCWvJBisoxjZqeHzJ3R+wXrb/7uLKBze3jaFRG9qcTl5Z9xpYI2GMY0ugXILhk4Uyx6mqQdx7f+tOYiBCD0ESDQRehZB08ZdIsiQ5pg3+VV1C4oQ/0SEjrwx3c/y48ziGrJoY0OVHGXJcMID5WkKDSyIz7scZPYZAdTWEYv7pSWaXTWguOFDzYxWwAD6RHz+5bXDxwE484+kgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BDlgFfsLoKEnExBRGn7/MB1Z+OHdzQrEQt8j81qDNrQ=;
 b=HLEvajm12fSAgXX5zhCW0QxdPqhQfKeuKIagx+93PxFPK9Oz8zbVjwc0ausFiOEY8jZS0Us88kgOD2fuETe35MhIhcHLBMQsfzxuriFgAV7tdakdSPmCCjnCIIcZV+1tFZm2hOAgkYT70qOIwxKrSzzOG/d5fFKw6JDwfULjx6c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8422.eurprd04.prod.outlook.com (2603:10a6:20b:3ea::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Fri, 17 May
 2024 18:10:26 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7587.026; Fri, 17 May 2024
 18:10:26 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 17 May 2024 14:09:48 -0400
Subject: [PATCH 1/5] dt-bindings: mtd: gpmi-nand: Add
 'fsl,imx8qxp-gpmi-nand' compatible string
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240517-gpmi_nand-v1-1-73bb8d2cd441@nxp.com>
References: <20240517-gpmi_nand-v1-0-73bb8d2cd441@nxp.com>
In-Reply-To: <20240517-gpmi_nand-v1-0-73bb8d2cd441@nxp.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Han Xu <han.xu@nxp.com>, 
 Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>
Cc: linux-mtd@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715969417; l=1517;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Ue9DoiTmBK6eu+g2lWFajA/J9GaQ6d3UFTf3Ewes2Ic=;
 b=h3g9vKblkojKvphUerg0u44sWQoCkZo9efEKTHb/wdWZwldO7VSOJeo7eaDbfa/Tg5esZx+iX
 ATwhYmwatrWAvovcCwLWdo3t6VAab5AW7Lg78alrq6nk3pyVfwGSSEZ
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR07CA0068.namprd07.prod.outlook.com
 (2603:10b6:a03:60::45) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8422:EE_
X-MS-Office365-Filtering-Correlation-Id: 11d56590-dc5b-414b-9a56-08dc769ca0ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|366007|376005|7416005|1800799015|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K0lKamlpM2h5K0syQjBTWUdCWE9CVGFnNkpsdzVBV0xnd0hOcG5uaVl0V2FD?=
 =?utf-8?B?UGttK2NESW5wdzNvSjh0d0w4Qm4xL1QwYVhQbmFIb3BLVkM5RTVaNEJ6Ym1s?=
 =?utf-8?B?NFdoSlZ2TVFmSHZ1eWk4b0cwenVlYkxac2ovMTN3MTFsRnpISC9CM0pYVUdQ?=
 =?utf-8?B?a3Z2WHQ5ZUYvR1ZxREd1eFJ3a3JEKzdhMzRvYitGTUptZjRvVEhEMUpaSlUy?=
 =?utf-8?B?NU13NU16NWhHeUpSaGpQZlZrMEZlTktleCtGNjFDNnM5TVI0M2RMUHRMKzhn?=
 =?utf-8?B?ZWFwTXkrMjlpWVkzaDJidzg3SnZXNWpQcm16ZkN0Ukl6TklublRmUTI5YU1L?=
 =?utf-8?B?U2c5YlUzMHVFQ1BIRFZ4WWVDTHl2TWZFNjFobFM5cENiUkhVbnpoRVRQcTdM?=
 =?utf-8?B?TWtTYjcvcVVHM2JYZmlTL3ErMWdGVUlqNC91Q1ZKWHYrcnNnaVhZdHQrSDdz?=
 =?utf-8?B?RUlYVWlLOGp3RTVnWndwLzNLRXEzMUkrMjlESURQSWVVT0QxbDF5R2ZHSmx0?=
 =?utf-8?B?NnpHOHl1cWw3V1V4YStReThkYi96UTUrQ1I5V0dJcDFtdzFpOVpucW1RV01j?=
 =?utf-8?B?NkNjeU13WFM1SFZFZFNVbkZ1by9QdzQvZ0pFczU4cE1nMU5jL3NuOUxwRG54?=
 =?utf-8?B?RXVQVXVkQjFibWpyTTFZYnpFNVAzSy94WEhUVDBmTnJUaDN6c1hVSlZlQjcw?=
 =?utf-8?B?K2NRU08rK0J4elBZSEJCeVJQZHdGMUJzODAyTXhJbWpEMEtzcWxmZENpQ0xE?=
 =?utf-8?B?dmJrMkxtcFEvUXFSKzRpQmp1dmxNRFVYR2ZSc1dRYzJ3NmMxM0ZpY0o4QzNM?=
 =?utf-8?B?bXJaUkJjZHNiVW9Eb01OcXV0SlBNRnh2Nzh1S2pPamMrZStQTzZsWndtQ0Np?=
 =?utf-8?B?cG5FVDNSOXpEMGtML0wzdlQ3dHd1OVkvSnZ6RHJmRmp0ckJzRFdvRFdWbVVx?=
 =?utf-8?B?UU9oa3B2Q3NtclhLZVBnNDRzMTZzazYxMFk4TTFNUzZXZkZnUTZMQTdLcVlr?=
 =?utf-8?B?dE1zUXdFS1dTUnBobVkvOFo1a0tLRjhjNEZFdmNQZWg1R1hvb0pBZXN5a3Fm?=
 =?utf-8?B?Y08vc2RMcnY2NXQ1RWFkbkphRWh0WDkzdDdpZXlDQlNsZ3NsTDUvR2VyRHk3?=
 =?utf-8?B?NzZlUFlwaHVBaWUyemk1Y3czWEtXNHllbExKS2RZN0hzNVBNaEJHejFQS2Va?=
 =?utf-8?B?VHZ1aldJZzJEQlp4ejVKWElyT2dKalowNVo5V3BRZWRoak9PKzZjRzBycGF2?=
 =?utf-8?B?djcrenBIQkVqM3hVQnBjL0NQNlplSzBjQTBLL2hkR0tscklGVHhKditQRkRu?=
 =?utf-8?B?WExCQjhOajR4eVQ3NlVMWUsxL2RlRFU0a2IxRUtFWVFsOG8zUGExVkdKU0E2?=
 =?utf-8?B?ZHBFeE82UnVHWHE2VkZkckM0UjVOSUNVclh1d2ZacEdKb01hR0RIczl4Mk1y?=
 =?utf-8?B?VzZ0emMreHpUR2lpUWw1VHl1OER0MU5ZcEVLZ0d2SkErOFhMSGc3UEtZNVNE?=
 =?utf-8?B?NW5sVU9jVWZIM1lDSmRGS04xODNsVmZpTXJuY0dKdVJ3WHZmY0R5dWx3cFNO?=
 =?utf-8?B?WkZLL2Nma2JFajJPOFRLU3g0R2ZySGNIZkQvRGZwRkFSc0I3c3psN1k1ekRw?=
 =?utf-8?B?VnRJZ0R1STB6M2I4TkExUUpEYmswMGIrVXY2SnN0dUdjNjduektxblpVcGFs?=
 =?utf-8?B?OFRON2hhQjl1ZVFLMkoyWlliWEFjT1dBbmozN0JPd2ljQ0VXNFRTdDVLSyta?=
 =?utf-8?B?eXZQZ05DbE5majJmSUc5Ung3anFiUnBKSHRmOTNaMnNvVzYraWZmQTdCa2hn?=
 =?utf-8?Q?eEEqzceZnZ+3ucE65jWpkonhVt+RX3vvxEgsY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(366007)(376005)(7416005)(1800799015)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c253T09PMTdpS21sWkRQZzIwYitBRkdSYjFuY242cmFCeWRhNVhFRWQyUjNX?=
 =?utf-8?B?KzNiTkNJVUkzU1FnbXhVb09XWlRwTUJrcHNnazBjRGsvek5YVG5OWHI3Yitn?=
 =?utf-8?B?U2l3aHR2T0JVUE92NlBmank3Szl6M1ZDeU9oNGJ2OFVabWNHMStjb3hvaGV5?=
 =?utf-8?B?Qm9vejYxY1duSTVLNzJoV1dsS3hYR1dJWGxUcnhVZ3o4SXUwck5ScG42RUJP?=
 =?utf-8?B?dXAyUmdqM3pBYTBtaFphTGh3UnVKRVhRSlNNRkl3Q1k3TGMwbFdEY0VkR3Za?=
 =?utf-8?B?Z09EODB0a2lxall0ek1jUUhreFdxOFQvMzE1czB2cFN4VGM0Z3ZqcUREY2Zx?=
 =?utf-8?B?ZTdDNWhOaFFhNFVkamw3aVQvdzRLU29pNkJBOWs1Z0NSWTNUeTh2dS9US0pu?=
 =?utf-8?B?U1AvNC80MXJMQlZMcHZLRHptRzhza1ZXUmkxeWJFcmJlcGNYVi8ralA0OUQr?=
 =?utf-8?B?MERGUUdJaWNpcDFwWWQzUGJoTVhMZnNqcXlLcUh4ZmpKME9xeU5BZnpzOEZD?=
 =?utf-8?B?RUJ0RDVzTXZGVDZYYTJyaU1kKzZ0RW9MdUIwOGRZZ1ZqcDQ3NU05MHJKeUNi?=
 =?utf-8?B?akRlNjBpNzZNOEp1M09mU3NBYVBPZ0wwVklpODhKQWo1M0FvK2VHM1BFME8w?=
 =?utf-8?B?Y1Z2TVc1cWkxUnVneWFDNXl2UG51V1loVlFnMkhoY0NmcForREdhTDNIRW5O?=
 =?utf-8?B?TER0Y0ZoNGNORnhvc0JuNytmMmNEM2U4WkF0cElKYUUza0RPSGVHaWx6Nm11?=
 =?utf-8?B?WjJDM3UrZ0xIUC83VTF6bEZlZFlTOHE3UGJocWIvbnlUZlQ0ZjJhajhWRVg2?=
 =?utf-8?B?eDZTS2NtNzVYTkVYV0s5QitjVUllUklZd0YxSlY3R1lLMUFUQ1ZPS2VwVXFH?=
 =?utf-8?B?Q3JEVVZUMUx6WXJSaXdPY1pRR1lCS1BnUEQrQlFmSHUwb1QvcWdTOFgxTXdI?=
 =?utf-8?B?QWd3a1VoTW1BTkhtYkVtb3VUTTl4QWdUZ2lrTVBBVDlUT2t6YlpnS2ZjaXY2?=
 =?utf-8?B?RmgvZ3RkVTk2YTVyeVIzWjlWbS9HamQwZUdMcG1lYTFxRnJ6eHprbzFmWkVr?=
 =?utf-8?B?dmxDSDV2dkZtMkNWUmNhL0xWQXdMbUYzanJFZkpnZDY3QUFZc3VDN251ZXR0?=
 =?utf-8?B?U0tQWDdoU2xJY25xZm45OGFucGZyRUwza0ptMnpXOWxOZUJWT2prLytTa0VD?=
 =?utf-8?B?Q1Q1cHJ1dm83R2FPQ3Vwdkx5dzJiaFVCNElGWllsRGZaK3ZCSktMSVlOSnlY?=
 =?utf-8?B?UklKdlU2bUpIUVhXUExOWnBjTjErUTQxYWgrcVhOdDhZa2I3SmtHQm9QSjV0?=
 =?utf-8?B?OXh6clZRS0x4bGdRaXI5RTJqNXllNkdKSmlzYkp2U1FGUm1Sa0tYVkQ3Rmpt?=
 =?utf-8?B?NUJ0YitNWU5WYkNJc2kwZk9MVFoybzFUcFZQZzlFZDdHbTNQV25EQzZHd25Y?=
 =?utf-8?B?R0wxelNpb21XU2ZURXBQSmN5cm1lSGxTNEpONVlKUkl5MzV2eC83U1hRTDB4?=
 =?utf-8?B?TWttTHBFamRuSlhIbWE4SnF4ekxsbmMyR0l2WENlaWV3UUJ5cFExOVRWcS85?=
 =?utf-8?B?cTFGNFZHZFNZTEp5QnlHWEZHR245ME1DZzhaSURRUnMrZEhIUWxDb1RIOUJS?=
 =?utf-8?B?RllOWjBRV2dFenhKNm5GelY5SHM2ZEwycTMzNDhBUTh2czZtSjZkQXVTZzB0?=
 =?utf-8?B?b0RNUmV0cFpqZEVUcjFMaHh1ajlMemRBcUFwRUQ5dnk5VE5uR0Yva3pmRmpR?=
 =?utf-8?B?TU5oZEFmbGUyeFFQdXo3c3d0VVhyRStSSG9DdGlrVUVKNENoRmxmcHc1dEdV?=
 =?utf-8?B?dERkcTU3ak1yck9Lbm9wbkhRMkNqcTFqdTQ0OXhYL1U2SjJzcmw3c0hac0FB?=
 =?utf-8?B?R2Z3WVh2bzdIQzlIdDJMY2xDdFF6K0tWMGd2NEw4VzBVcEdVNHJSb0FGaFds?=
 =?utf-8?B?WkhOTDQ2dVhVTXhvbjNsSlFHY0FpZUNaZm84V3lwd0R0SDRpRnlRUWNnR2tJ?=
 =?utf-8?B?bm50d3h1Q2x6WkdMbkhYbUVHMHlIOGtHbHMrUVR4RDNnOHNLanNJVmt6T1d5?=
 =?utf-8?B?Vk55dzN0OVAwcjBSNFhMREhZKzV6dnNWekVzVkVTSW5EdndKRGl4eWFJTGd4?=
 =?utf-8?Q?hLdZUmYI+kmv4ql4JWbjmMUBK?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11d56590-dc5b-414b-9a56-08dc769ca0ae
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 18:10:26.3317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OpAoagks0S3FnZuW4UF/hQCVwpGTK0sx9l99jjFt9p2/ZMjRyaku3rLEagMkbpZlepuAuhZRg8GCdg1fONjRFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8422

Add 'fsl,imx8qxp-gpmi-nand' compatible string and clock-names restriction.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../devicetree/bindings/mtd/gpmi-nand.yaml         | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/gpmi-nand.yaml b/Documentation/devicetree/bindings/mtd/gpmi-nand.yaml
index 021c0da0b072f..f9eb1868ca1f4 100644
--- a/Documentation/devicetree/bindings/mtd/gpmi-nand.yaml
+++ b/Documentation/devicetree/bindings/mtd/gpmi-nand.yaml
@@ -24,6 +24,7 @@ properties:
           - fsl,imx6q-gpmi-nand
           - fsl,imx6sx-gpmi-nand
           - fsl,imx7d-gpmi-nand
+          - fsl,imx8qxp-gpmi-nand
       - items:
           - enum:
               - fsl,imx8mm-gpmi-nand
@@ -151,6 +152,27 @@ allOf:
             - const: gpmi_io
             - const: gpmi_bch_apb
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx8qxp-gpmi-nand
+    then:
+      properties:
+        clocks:
+          items:
+            - description: SoC gpmi io clock
+            - description: SoC gpmi apb clock
+            - description: SoC gpmi bch clock
+            - description: SoC gpmi bch apb clock
+        clock-names:
+          items:
+            - const: gpmi_io
+            - const: gpmi_apb
+            - const: gpmi_bch
+            - const: gpmi_bch_apb
+
 examples:
   - |
     nand-controller@8000c000 {

-- 
2.34.1


