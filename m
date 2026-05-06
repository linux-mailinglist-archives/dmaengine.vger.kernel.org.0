Return-Path: <dmaengine+bounces-10244-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GORHzao+2mYewMAu9opvQ
	(envelope-from <dmaengine+bounces-10244-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 06 May 2026 22:44:38 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 262004E048F
	for <lists+dmaengine@lfdr.de>; Wed, 06 May 2026 22:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1D112301739F
	for <lists+dmaengine@lfdr.de>; Wed,  6 May 2026 20:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC42026D4F7;
	Wed,  6 May 2026 20:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="U3MtKphS"
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013030.outbound.protection.outlook.com [40.107.159.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C94E361DCA;
	Wed,  6 May 2026 20:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778100275; cv=fail; b=Rzfkpcjmt16w03yDgmBTOdn/W9RbrClJHOIryRNsEJOXhRlwYN0O8LzPSw2dCpEvTmH2dJw/7svoAL7nOn2wWFrN4xRIyqT8J5Z4VBe6YDCBHJIkz1ZsiuhJ4XxLyuYD6rcOdc1pO1SmW0Iqc6oinLo6cmNBebq7eVYeBCe9Qmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778100275; c=relaxed/simple;
	bh=1QDS7yalgH2vXGPIIRGsyPJsCl51h+sJw/j4GkUhGQQ=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=mwAgHgpEDKIvCRXHgoAv2x1BWbtrB3kYXGnlZmGagDJ63IEC7YNY/a0PBu9Uxd7S8HAVyzmRnWOaAs7Hn4IEgV9/fGFTUk6ESt3uKhQXiEwYcar6hK+Imu+VnZ3l9udJ3U2iZWPkXwbH09EgE9n6BvtKbtK6+njRqeoEwcm3ivE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=U3MtKphS; arc=fail smtp.client-ip=40.107.159.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hTzq1/QHI2hCTHCmUOpAyJbNTj1JgFH5XES7t/AfwQZVijX/3epFPLhsaxLE5wZxp2Sgu1KbqJkkhSt7aMdZxABF24FQCJf/pahxghLW8Sn1YvfyYNkgXaX2qNDrWm8zQlnU9DAMpwZKoKVwTkcw37ZfeG85lFEH+16cM6fVLp0ZqU9rLwH0D2pZE9Tfoy5xn6nsiPB/odLytuV1iUfwhMyxDdjppsKDKNcoI7/WrY16gwVTvcyWmC/X+mwLkORozR40Qdqtbig9qGMRTGY7bi0HjEX1foJHYwTjYomzlh2fV1YZsuMOYnCTpmHhxlgor7FXplfmIOgnYdjfE5JKGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ncu5t36Rod2R6b5mp9ZZJmHAVezXgYV3dEWrg/vr8lw=;
 b=iOvjYW90Amp+uEZ4dWf+TSCajtE8gEvHzbGsgoBFhyAi37UawnVNSKc3hHcBICyb+sguiHMozRPjiLBMJjrke5on17KUWzlCqJQLajj4JbWN83N8qUoQAtsE1fEhiJfGae4l7rJR9l1S5pPEQhfccpI7kmghx14h2XMQYMmInBRXOxbeAs/fQXO/DTvUUE0SMIVgEucClbz9+RLKranqOimCKFBHl1S6Gsf5aC2+pHAnLRMo5NC/4ngnmNiONwZ0y6oAvxgWjJaVzPjvPgiGjGpkyO2yNypHxxIM25dcg/xzWtYqjhY96Ff+OEOwLQSz/dy7vNgmXCy0hNuDJOFtHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ncu5t36Rod2R6b5mp9ZZJmHAVezXgYV3dEWrg/vr8lw=;
 b=U3MtKphSTyoE0+dENN24EjTt4sVn8EMkyygYhD/Mxz66Uqf9PDzhdP+BvFHof2nNulQMXYN6jRc596J4f5JVQk2FM0qU5sS9enwsUFCR2dauSNk3Xq5NLx81tmwVTP70mmRrPT+7ogPWpUMjpLsv57gE1DV6K39CjtMF2HCzYZD8MjeJYHqENuG9h/Pel9/iK4+KcddxgMGI1M7DYwz0B/HXm39Nxf3XQgybRCMKV3CkPBKBTWHb5Y5UJ7SLxYMVOV/WaN4hMDI/w+Q3uvjmmKmhLoCW7RSnKVK5xq5sQaLtr/9WL4EsP1HAlkbJEHmpK/yYwz/Xm6uUu8a80qfllg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com (2603:10a6:10:35b::7)
 by GV1PR04MB10479.eurprd04.prod.outlook.com (2603:10a6:150:1cd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 20:44:28 +0000
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4]) by DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4%4]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 20:44:28 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v4 0/9] dmaengine: Add new API to combine configuration and
 descriptor preparation
Date: Wed, 06 May 2026 16:44:12 -0400
Message-Id: <20260506-dma_prep_config-v4-0-85b3d22babff@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAByo+2kC/23NSwqDMBSF4a1Ixk25uXmYdtR9lCIhiZqBD2IRi
 7j3RkHaYofnhu/PTAYfgx/INZtJ9GMYQtemIU4ZsbVpK0+DS5sgoGQIgrrGFH30fWG7tgwVVVK
 wHBwKaZAkld7KMG3F+yPtOgzPLr62D0a2XveWPrRGRoFKLi5gpWceza2d+rPtGrKWRvzS7I/Gp
 C3kkF80Vwz1r+a7VsBAHjVP2mihgSssncCPXpblDe/0BxsoAQAA
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
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778100264; l=3149;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=1QDS7yalgH2vXGPIIRGsyPJsCl51h+sJw/j4GkUhGQQ=;
 b=kAOgIhphFrp720OIy2SnK9em0kuGsw1Hs/tzzu0Sw6s3snRyg/EUwfSeAGtoLokAkpExeXDue
 zKrWSLFDZ8fBZSnvactMtYp2sZXM8k7DGzRYYmvEHG5VNskZAArEZWx
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA1P222CA0051.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::24) To DU0PR04MB9372.eurprd04.prod.outlook.com
 (2603:10a6:10:35b::7)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9372:EE_|GV1PR04MB10479:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d3aa655-ba8a-4c4b-ee05-08deabb04450
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|52116014|1800799024|7416014|921020|18002099003|38350700014|56012099003;
X-Microsoft-Antispam-Message-Info:
	igPjOrxJLH6r613vpEY1gH26abxQ3DrSOvf76GyWCiG9dCnhi6y8jCshQFPyPuJQ/kGHA3/iSPO85e+U4lUPMXWDegOBYqathh1Yp68C7ZpZoE5LW88So0QyOuruLghMrXs2RsCDosj8F1XskJMKX7wuSiPKTEWFZJ6R/lCdIq1KMiB2MiiZEAEj0lB5KIYKqRcrsKCH7iB0l3hcA+nndI8qYorGGWtwgeCHpiA0FTTdcgR2taejBhTSv36YFDranok2+/cNwK6tqiKmRM7q07caAlPpP15/NJHt8KSCrX0fh8ySsTZpkh16CzRc9Ilz4AzXPWYv6chYXKD/Xc3LUT6CB0deTP2eDeYSqj/pZyo7m7oUO9zRho5hZWk9OVFIC7VchVY23yVfP3+1vxALA+165vVZgIsZsJMD0MRohFGUjqlNYt7JNJgLfBL3i99YCr6vJvug71IU6Jk5c3g9GOAK/LG6RimDkNNeRjxQ9CIWoL+d81PXFrwuOgkVkRDvhzbTTvIoPp+nSUvJvkuapYLDtENTA5heH38xaH0od4P4mgWvqmhtJMvw6BaN3ExJcyEUL+8CCxBpUTMuve1BLPwif7fkittlSaZ+iYlDFUbbUdz9aqxN7Rg4gfhJVCwH3nq/4L2g7+bvbAB85J3CUyTsYrfCCtSJ2UIjvtDDcq9eN0Ombo6qqCKt3QDQmzSoe0GD+D9o4pkthV9VGONEwk79xOeFfNAfrn8M3+rTy5CoYWlrMrjcW3orpQGGI5dU+ZXjJGMaylM/pqeKSRr56A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9372.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(52116014)(1800799024)(7416014)(921020)(18002099003)(38350700014)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VHk4MU55Q0V0cElOM0JETTk5YnZoM2N0NUZHUW9pQnNsYUJGVEhVYlMreTVK?=
 =?utf-8?B?QXYwd1lkeHZxSXhTb1UxbFl5QXFzaW9VRCtUb0Uwc3ptU2JzdENGZlkwalJs?=
 =?utf-8?B?ZW5xMkF1NUx5b2Fhd1FlS0VLSVU4Y0FKRVdmbVdsd3FreWhZK1NOLzd3Nk5U?=
 =?utf-8?B?c1pUUUlIZnMrR2Y3RlpGTzZkMC9wcmxUZTNVU2E4bnIxWFNtY2NBSy9UQm41?=
 =?utf-8?B?TEZQVURwc0tPalBWdkVOREVsTlhCeEo0aXpOVXZWTXpQL0FRTFk1UVc0WTBQ?=
 =?utf-8?B?MVNlczYzVm1sMjBJc2t1bXJ1bXRuTWNGSCs0S3hGbW9GNFBOdU1YajRmVDRp?=
 =?utf-8?B?VWVtbWUzNE44Y3hYMkFVR1ZlNktmMjVTOU5rdVRTNXp4WlBWYncrSDkxbUV5?=
 =?utf-8?B?RnduWHZKa1JabUF1dlMwYVNEbEdkeWpkei9oNmtGVktCMGxSS3dmbGJHUDBm?=
 =?utf-8?B?NmZMQWZHa2ZmUDR1SHNoZVY5bERQRTlOME0xZ0liZDRCdHBndTFQMnpndVB5?=
 =?utf-8?B?WG8rcGNvNGZWcm40U1BjM2NHMEt3bEVZYVAzdWJ3Nm13U0JtOFJVSzlFVitk?=
 =?utf-8?B?VXhNQkJvcW56NEY3b2tXb1RQOW9LMTZtSGlGY2J1REhyRE9nN1FiN2djdUt2?=
 =?utf-8?B?NHpqNk03OFZxYk1kcFo1Y2lBZE9MaExBcFBzWTh4aGowUEpOVENQR2c1c1NB?=
 =?utf-8?B?dnM3YkdEbTh2Q3plM01VNzRCVDZwYlN4em1tbi90aTJuRnY4WEFzTXVGWHIx?=
 =?utf-8?B?eHhwNG1kYnJqOEo4L0dyc2hnZmRGdWZuZG8vSUFZQ3VraEtpMkxKN200QmpW?=
 =?utf-8?B?SkF1WkdXeUFBSU9ZZXJuckR3dmdDd2lJTkJkdEdFODgrdENwYmw5dXpiUUhp?=
 =?utf-8?B?Y1pHZmZiVmN0SEpseHhKLzJGVk55bkRzZWFyOTJmakhUajV6bWwzeUtJUTVm?=
 =?utf-8?B?UjZwaEd0dC81OWJwaEd1OHI0dzdQbG1UV2k3ckQ1QzJHVjRMSnIwNEp6Qkpp?=
 =?utf-8?B?b3NydjFHZVliR2pMOWt5SVFkVmxuNUlTbDFocnRmYW1wNERUSmg3Z1VPdEQy?=
 =?utf-8?B?ajRnSW1qY0pwTXRWNkNWRWt6V0dMaGMvTmVzZlRaK3ZvYy9jelZPM3FCUEpV?=
 =?utf-8?B?Y2djdFpTZUszeVBCZFhFZUp4allSSmJjSHdVcmlobkVPclVBWWlyNHY3S2FE?=
 =?utf-8?B?SnVaRS9RQVIvR05DWDlpYlRna0hFWjdJYS90czNtK3J5cG50UVZGejNoVjJ4?=
 =?utf-8?B?VjcyaU1WSmg4SGQrYzY5RWR3Rzg3TXZCYWM4K0c0bDBPS2FtQWt5WWg5bDVv?=
 =?utf-8?B?ZVpaYm5VNS94UWZKY1hOTEhaSmowaFAzcEVMRlpqUHFEazNZSzV2V1hVWW1x?=
 =?utf-8?B?Qm0zWGM0RERJM3czcG1DRmFUN09pVU11Y0QxRExncm1IdWc1TGtRNzFHWG1Q?=
 =?utf-8?B?cEd0eDVEZ1IvamFTSFBSd1o3QzlvYkdjTWQ3S2pMcUl0bHoxaVh2NzByVVdy?=
 =?utf-8?B?Wkw2MWl5dnFMbVhrNW55eWdyRGRyZlVxaUlLMXRLdVExOFYxaUZKbEszQWls?=
 =?utf-8?B?UE5KN0V0REZVYlNxQWhhbCtReDdvaWlidU93Y3ZXdmV3QStIREUybDFTWHVU?=
 =?utf-8?B?d2ZJblBsR2NqV2prUXFOekdKbFRac3prRUhoaU5QTUtRL0diRzk0d0FxcjZJ?=
 =?utf-8?B?QmliUjh1YkljS2VaUnJHSEZSWkJ4dm5xdEZBWGdIUUROMGQvdVNVbWJ3OC94?=
 =?utf-8?B?dHp2TExaUXlldjBDNWdFT2hhcWxENm9rcjd3dHRmUlYxc0Z4RTc5THVXcXhT?=
 =?utf-8?B?MERjdUhPd0FBZDRZY0h3ZHNxSDkyZ3hnR0l2eHVoekg2c0FXeEhkaGZlbVZQ?=
 =?utf-8?B?UWw1eUZTUG83UUREc3JNOEhERkVXR0xSQ1oxZktRV2xFWEVWb2FUZUNpanA5?=
 =?utf-8?B?QUVKMW1JOHdYam5hTFZtM3ZSZzZkUTZPZmpKMlpuN2duaFZtb002WGV3M2kx?=
 =?utf-8?B?cmtHVk4yTlZSQTJmdkxBQXpialpWR05JSGZKZnlMSm9ON2FEZlNoZDNkVjZJ?=
 =?utf-8?B?K1Bwajc1MzIvT05vekhudkFBSXZCNUNocXR0a2d2enlIcjFSZjJrQUR3bDBW?=
 =?utf-8?B?WWk5a3VqcFRtelVONGpzNlMxVG5UakJITkQ4OStROGYyb3kyVVFBTldYeFhs?=
 =?utf-8?B?ZjJIRkJlODhobGt3eXA4aU5RbXN2UGtuSVFHaEtmdHBJTythdjYrUVM0OUpw?=
 =?utf-8?B?R0h5M0x4OTJBMkx4ZURtS2tCUngwcVZSL0ZZcWdBUGhxbEVmSmExbVdrSTJD?=
 =?utf-8?B?aFpURmFQTmJzazRhNnpQbDJBeG02RG11QlgydFlwbTUzR1RRWDVYdz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d3aa655-ba8a-4c4b-ee05-08deabb04450
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9372.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 20:44:28.6242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0U8ip3M43oZPyDHbBne3ob64fYcUCG9ESplXlzYabktGegmt/e5hkVrzCumOeMJa432ZKSOXpSF1WRE2iSyTpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10479
X-Rspamd-Queue-Id: 262004E048F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10244-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim,nxp.com:mid]

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
      crypto: atmel: Use dmaengine_prep_config_single() API

 Documentation/driver-api/dmaengine/client.rst |   9 ++
 drivers/crypto/atmel-aes.c                    |  10 +--
 drivers/dma/dmaengine.c                       |   2 +
 drivers/dma/dw-edma/dw-edma-core.c            |  41 ++++++---
 drivers/nvme/target/pci-epf.c                 |  21 ++---
 drivers/pci/endpoint/functions/pci-epf-mhi.c  |  52 ++++-------
 drivers/pci/endpoint/functions/pci-epf-test.c |   8 +-
 include/linux/dmaengine.h                     | 121 ++++++++++++++++++++++++--
 8 files changed, 180 insertions(+), 84 deletions(-)
---
base-commit: b9303e6bff706758c167af686b5315ad00233bf8
change-id: 20251204-dma_prep_config-654170d245a2

Best regards,
--
Frank Li <Frank.Li@nxp.com>


