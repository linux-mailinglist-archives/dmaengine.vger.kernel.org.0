Return-Path: <dmaengine+bounces-8261-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2674D21990
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jan 2026 23:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0FCAF300AC93
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jan 2026 22:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C743A89C7;
	Wed, 14 Jan 2026 22:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bGetDPc6"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013033.outbound.protection.outlook.com [52.101.72.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA53938A729;
	Wed, 14 Jan 2026 22:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768430080; cv=fail; b=rHKfsTijZ2Y2H6Npdff6aTqSOBEQto6CWbJEYMskM4qr0ubqvY3y+wvUWHciEQ8l+xz30NlnNDQciEhLvhBrz/mfIRKwXochwfbpkEd87xtUGPtKAmK91ND103akAnabMPjIZeOqfYcTEJa+RsYcU71Rrf2BGoNUlWcYpNY37Wo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768430080; c=relaxed/simple;
	bh=SQCaozGDnqZZof8cp4kNNQdXYMha4tAf+PTC0BbfHrA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=SEhUoZQyGiCzP8y6T17PitAYhwNYH68WSYh61iXjA6/xtcVcmkX1qY6emUytZq7xdEMlODP08RnIHILI9oXC1wZmzKV1w9r66JFlwQhWBeyaRS1cIEd8983FGv6JThDxiIr85ioWmnQK6ItNkFiIFnnw7Fwo22+iLnLbOuT51Qo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bGetDPc6; arc=fail smtp.client-ip=52.101.72.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k9u22+Y1XONXQPHu3QuVCrHyN4cuTU1nwFha2+kCjfeWn+gIDC9YCQCvj8328E7tSdQPCHijeR2wJPfXL+i/JC3quLTZOpFo2aSRc/jE1twAz4TerBuSo3QUFqG9Bq/6gg17EdJbO4CXNbyzyiYTjDvi8BfsGBa2hTvN+h++EdRzgDehBvw6/Hw7eWNV2wsGy50tSHHNTdyVvMondAkTzAZ9t7i2KL+Em0yk4HL7+sisMg8iYhdcTbFjJ+V9IOg6T7FVeGNTTpqANl+2YZcE9vkkpK3adb5xb4M6h4T8izxFqlxnMaOnPbn/asz4+p2XoAtrQxSqadfxatEk0mklqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G/isUkW2dUX+3o19O7qOC7YAfzcg+sLKmLHDflIAGF0=;
 b=GrMLIvCIzcmWKotxy8YdbGl83GYEeB+PIb9mUYkFvSl0wObkik4CZcrb7B2aUBJPnO7U9NQFts38xUvA3V/PIs7p2vVaKA1QKjWVulMWtsn3+ZgfNlZX4n9IcG6FcAKO8llMGHNtUPnTkAsn/3BUoHho4oT1bhxBZOQAPkTv3zMNnyLbmSAGraaobNiCvUCKtlgjpcOBU7pip8/QUW0XCqUWLjwHGST/8KE6tUIplcyk+9UjI+Kjpz5bn14BfzoHNC0uLqh5jpLzprHjVw+2nwROp003STAYs+uBe3Dtq7qctAmCkA5kY7tAumCB/G2t8XX6lk/wh29nPCRZpqnj/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G/isUkW2dUX+3o19O7qOC7YAfzcg+sLKmLHDflIAGF0=;
 b=bGetDPc65yexm4MFL5ZzeoFdYr7WhI9hpGrn4pjrhpcbI79OtAeNzeer/6sCEiuBm9ApVgtyz/FueXRonHmoufQo2HMIdeXRFLM0M2FXYZn7pCBDpOJgmGpMxCX6/PpcByMNCgk3WiI89wpswV1kHZGwfnQc8BJ5xw0Bg+N6P6DdyAP0IgDPLSQ9NTftufnGgiV6Q/k9MuWxjTqhLGNvVmacvWluZ39Q0YYemCdgd1QR97+V0ijAE1YvtkFIUDzJjWOH91QQRFVOYPWZlpjdsxdfw/g5riKv4yQdTuhhS7CIIDpNPsAbXmI5PKxc0ifcNxxG8BjtDhHB4ZOnFUNVNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by DB9PR04MB9554.eurprd04.prod.outlook.com (2603:10a6:10:302::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Wed, 14 Jan
 2026 22:34:07 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9478.004; Wed, 14 Jan 2026
 22:34:07 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 14 Jan 2026 17:33:19 -0500
Subject: [PATCH 07/13] dmaengine: mxs-dma: Turn MXS_DMA as tristate
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-mxsdma-module-v1-7-9b2a9eaa4226@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768430015; l=680;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=dh5gBs9pt4KR/3QKIUl3wn2CmlzaqBtYSrG0vQ/yYuk=;
 b=yT7h8FpAXXeeSHPyPVssbhtdZj+oGlZOGUs6oUYXT+1z24Z8W197NVlnt1USqYmY4NX4W0gGK
 CLlrts5o5b9CfwLKFtHYp5aLKPNIUheEblyt6KUWz86qA/PHD+zDeRV
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
X-MS-Office365-Filtering-Correlation-Id: 1c9e7082-cae5-4503-03ab-08de53bd0787
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RTM2aFUwQkhjdnRvOVg1QUVleThYNUk3V3dIM3RoZVZ1azh1L1dXMWRYR2R2?=
 =?utf-8?B?c20ySFZIT2lEclRwQkNjZlhUZFVEamlsYmtsSjdxUTNpZFBiQVdqUGhRMU4x?=
 =?utf-8?B?ZURpREhMcTZYVzViVlJ0ZDZLMFdqWGlKdnpobkVSR0dEZnNKV3JWVzRJNVlV?=
 =?utf-8?B?bUExRURSeDN4MUpETlUyYnFoaWNlb3lxN1Q3TW9lREx0U1I3aDU3OURSRi9L?=
 =?utf-8?B?M2tTSVJjL0lkMVNTNEorQVJVTlY0a1hvOHNKYVRQaXllQ0JXeFNadTNyc3Fm?=
 =?utf-8?B?ZVpoQy90UVdscy9ReFhsaXVIMWtYUXU2amM5ckhidHlPcUh0VnlGeDRuNUlW?=
 =?utf-8?B?QnpRMmtmakNwUWRqRVpxL0RhaFI5ZlJsK3hqRVlEcmxhQmw0azVSQXJkd2wv?=
 =?utf-8?B?OUNLSW54eitVM1pvczBKbDFSMWtUK21KU1hmazFTL1V0VUxRQ1Z2ZWprT0N4?=
 =?utf-8?B?b1FWcWo2cXFhdVUybGpJSmQyMms5WlR3TWdPTjU4dzBZTEwrWDM5V1R3aGJ5?=
 =?utf-8?B?TkNSdlhJNWVlMEdvV3RTSmRSamlGUUVRdG5LeDVZRVY0VEhzdGZOdU1sbGhF?=
 =?utf-8?B?Nk0wV2haUGpaMk9sUi8wOFJtOXZhUTZCL3ZpL2lrQ0RYckl5TnI1Y3AwdkRi?=
 =?utf-8?B?YWw2ZWk3dEo3bmM3cXhSZnRCK0RRdDhzVVV6cjVMclNhbk5vSHhreDNJNmRm?=
 =?utf-8?B?WHFIaHdFZVdndFA2ZEJReFFKdS9pbTJnZ1orNjRCM3hhWUlSMkZ3Q0VYYmxi?=
 =?utf-8?B?dkZWVFg0MFdXZ1JWRnJyL0R3SnM5NEpOK1lqczBTanNsVTZobjZMVUFmMmtP?=
 =?utf-8?B?VzRYQXl0bnRXcEpPeVlSdmtsRHVNUFdXcGJGa3creWJPUjQ1NHNKY2srZ1Ri?=
 =?utf-8?B?Nm93dXhoNlM3OHl4NE9BQk1oeS9oUmVWWXJFMXRDRkgxMDJWZHFKNEhTcDRV?=
 =?utf-8?B?aGxyT1c0bTA4M2ZlWFFINDFzRFpsa1FQTytiVXVkc1FJRDhZOFltOXhTbWJT?=
 =?utf-8?B?dHpKZ3dmbE5sMEg2aC9raUluMHJ5c0FPZkRtZWY2cnpiSDNRT2wzQytod3Rm?=
 =?utf-8?B?SVE4N0lNSTgxaUZDNDBHQXpDMWRSbDdteGlMdzJWYWh1ZE9OWFRhdHJpZThV?=
 =?utf-8?B?YXJmV29XV3h0OXBTWXQ4RVl0NFZSMDUwOXJyYWNHOHBuSHJnNzRxYXMxeUJo?=
 =?utf-8?B?SHorb1I0TDA2eWpwdTBZZFhHVkJ2cFNnRi9CZWhuVDRjcUQwWllqTkViRDN1?=
 =?utf-8?B?TWZhUmRCVG9kMjlXbklNcGFWdUxITXRMYVQwN3dPTjdHZXBsbllMR0FYTU9G?=
 =?utf-8?B?d0x6SlNSY1pMYmZuUnkrODNtTGdSbU1PUnJ3eDM1MHJta3hoaklCTTIyRjN6?=
 =?utf-8?B?STM0dEdOd1Nrd3Z0NkJTYUg4QWtCS25wRVRyOERybjNFQjZ2SE9XaU8vYWor?=
 =?utf-8?B?dStJTHovVnYyYW1YNmVva3E0UGRMYStvUjhGNlJGQ3ZhNU9NUGh0WGg2SXpG?=
 =?utf-8?B?VnJFSWRuNjRlUDRCMFZ0c2ZOZitIOTNUMjF5S2xFdlhVTzFJUEd3b1RZUzZi?=
 =?utf-8?B?bThOMDJObjdHTzZlUWxqRVU0S2E2SmlURmMxc2xCWGNGbEZVQytyVXhmTXFz?=
 =?utf-8?B?N1Y5NXFGWWNjdjdPRjAyZHNjYmpuMkpPbkVnZHlTK0swK3MxMHRYOGhmSHc2?=
 =?utf-8?B?WXUrbVFZWHdqdWF2UjZlRTV5elA5N3ZQVWxsVGprdDVOUENrY09qaDE4endW?=
 =?utf-8?B?V3dPejBCUFVZL0JvcWRqaTA4OEpoVXVxZmZBTUQza0w3cXFSWVFJV0ZqRTA1?=
 =?utf-8?B?QmVHUHdvK2Y5dFJPbk9MdDBoMkVqYzJlb1dhby95RGJ2RVhwTkhQdDhSTUNm?=
 =?utf-8?B?aWR3KzJHZkZEZEt6NmhxSXc5ZnRHeWdHQ0JqN0NSZ3NHVS9TVG95a0t5dlpy?=
 =?utf-8?B?VHo1em01cVo3TnFCWTdIeE1YVmdrem9UZ2h6d0xSRno1NXhtK2g5QWRlUjE2?=
 =?utf-8?B?OEttc2grbWtzbHVodDhFWXVieFI2bVRiaG9IMDRYWjJsTnJhRUNnaGNTbWpO?=
 =?utf-8?B?eUtieS9hY2NjdCt1SVhVbzM3alBmbGdwbWdxekQzbnY1a2lYQ3FiWERFTWVn?=
 =?utf-8?B?K204c0Jvc1krZjZROEJmelovNm9aTmpkSTlqU0hERmwwVHNCK1plczMwM0FN?=
 =?utf-8?Q?SJr4sq3nb2ou8P1bA/z2mFU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGp4SEl4bk1OZ3k4SllzR096UmFOUStMaWZqbVV4RHowbzRVODlmSWxHK29H?=
 =?utf-8?B?VC9KOUZUc2s4bDdCaUI3cU9UTU56S1BpbzZlR0EzMXdPTTV4L1BaWlJaOWhn?=
 =?utf-8?B?cDNyaExJTUljNUFUZWJwWmtqQUpVcExEeVQydjhxNmMvdHNONk53amgvUHNX?=
 =?utf-8?B?ZmRWLzUyWndPTzRaYU9YUkhaSlBva0NDUFUvZ05DbEx5ejBBZVlXd0VKdXdZ?=
 =?utf-8?B?VTJkck9XRlI2YzNSMldxWTI3ZzJyazB5em93Y2NwR21ub3JYcmwwaEJrK1lO?=
 =?utf-8?B?eWhyVkpwclBDMHRXQm1aT3lVanlSTm5pTUVmMXhjYW9rNWhXZTEwM2FlbUUw?=
 =?utf-8?B?NUZQWTFOZDdiZ1hEald6eGVVT3BYUzBXbmRTdERUellNc241dWZzSlVXUHlp?=
 =?utf-8?B?aTN4QkdVeCtpTWFDMHM1Z0xrckphU2xxTG03N3lmK0NSdjVWaWtRU2NvbjN6?=
 =?utf-8?B?dFlsS2Q5TmlacnhMWXlOTWNjSmdpRXVNWXRLcFE5b1Y2K0l6cVhmbVY2eXJ4?=
 =?utf-8?B?Wjg5RGZtVU43dDZ5QVcyTllSajk2UEVCTUFJNHRVTWRCRUtMLzkzdWpyUzBj?=
 =?utf-8?B?QUhEUjFuMDRNT0dLV1NIaTVwc21MaHV6MEE2QkcvSDVhRXhnSGdUTGRqcmxS?=
 =?utf-8?B?WXRCRldnVHJRbDAzejQ1dUdkRVRyUmdhbnRWZ1JnWU1QRGl4ZmVqT3ZaSEZN?=
 =?utf-8?B?K3QwNkV3eWxrZEtoMXpzNjY5Zy9ONzBTVkIvd2U2MHRXbjdLV0V4bXVtT3Vm?=
 =?utf-8?B?OW0yR1BGZVhUUUtpREVJUjN4bVpiVlN2OHRjTlk1K2lQcjNkU0Fyblo5RWNl?=
 =?utf-8?B?TVhNakNGMVo0d2xQclpUVzdwWkM4aE9rc0pZZXpwb0RnTXo5MFJPRm9aTStY?=
 =?utf-8?B?UDlsWnFSNHZvQUYxbkZ2UksrYnM4a2ZGRTBzMmt4Z08zK2RITmxKRTUyY0tE?=
 =?utf-8?B?emJmOTBoczlUUSs0WnJ5STdLZkx6OCtGSUZHejJGOUNsU0l4clRTMUFuWDll?=
 =?utf-8?B?OWpMUEVSdTFySmN1djF6dmdSRGlpaVR1ZTllSEVhUjIvQjRJbVBnT1crTVEw?=
 =?utf-8?B?dGo3QVhROVp6ekUxTFZoL1p3UUI4ay9lL3gwUFZnczQvdU9PbGZKMkJISW02?=
 =?utf-8?B?ZngzZmdwSGZ2VDk1YytXRHdickcyS2loSlJqc2lhdW9VSEtjZ1BVa3JrWU1D?=
 =?utf-8?B?cDdNTUVCUjY2dUxQS1BFVWRtK2lmdFRpajBzcVN6M3lMSEFlblpHcVlDMElz?=
 =?utf-8?B?SWVFdjQ4aXFHRWI2S0xKU0VDWWExZkh4N3FaS0JCMTZpSno5RDVNUm4wVjFh?=
 =?utf-8?B?ZWIzdklmR2FhbFk5Q083enV4UGxoRTMwUTVrekVxcVdsZnU2eFhuc3dzMUhz?=
 =?utf-8?B?aDlpdEdJeThidjlmYnJQNTJSMkRUNEJMVTBpZ0RuZEc5dFBpelNadUMrNk5W?=
 =?utf-8?B?cGVFYmQ5ZVB4LzNWUEdEQlpWRk9US1RiS0gxeXVmVFRWbmJ0dTFLcTQyekR0?=
 =?utf-8?B?KzlmU21GOTBYVldta1VuZnBYUjd0MjQ4dGRvS2pLa1ZCSWZNNGpJYzFjTXQr?=
 =?utf-8?B?OFNZNS9RcGF2TldYTVNidHZhSzZleHhqYWtEWEcvVEtZSWw3R0hiOVRVYm5P?=
 =?utf-8?B?bllvd0FJMWtTWlN3OUsxRjl3c21iZlRjdDhidTNYeGFYS1VzUGkvRHJuRndH?=
 =?utf-8?B?aDhPYytqelpqRWdsZmtRSTNlMXB6VVovNU9XT1RBdWZCcU5jU0srMnFFdENo?=
 =?utf-8?B?VzZnOG96TTJnTVhJU1R5Ky9wdnErR3VJcTRHYnlKdTdaQWJTNUdSYVFYZHMz?=
 =?utf-8?B?K1A2emp5Q01mME82Ui8zSy9EbEx3SlVjb25TOXZUSWlVcHVKc2NyRHlzbzRq?=
 =?utf-8?B?Q09sdit2NHdkQy81WXJDZkhNVGJvNHRTRTd6dmZHM0JUdkdLUElDRUdLUUEy?=
 =?utf-8?B?dVBzekxneUJ0bG5Yci9aejE4NVNEMm9vNWJCdFY4QzZNdE9SSUZtbGJBam9m?=
 =?utf-8?B?Z1hubXR2blEwbE5LTEptOFF3eGQxMTZZVmp1MnlnMjRNQVNSZlk1RkhXOXNr?=
 =?utf-8?B?NnFCcnA0cTl6aHpZdk1Kb1hTZ0RIWW1GWjRiTUNLMVhGWU9XV1oxb2pxRTJC?=
 =?utf-8?B?MVNtaXora280Wkkrd2xnVUpUMTVsREpKVnJ1V1I0dUxYVzZlSEdzcCtnZmhS?=
 =?utf-8?B?UWU3VjJSdE9zUVNwbzNEcmp5UU52cW02QTQvM0FQTThLL1BTdGdlZUFhRFdT?=
 =?utf-8?B?cnp6RTJKcjhqL0FEVDVVSTRaT3pYRUU2eVY4NFNiZEtZY3JpcWhBYjBSNkZU?=
 =?utf-8?B?QXpEaFBUeitGc21SdHRvS1FTUmkzMFpXZEVZUDdaeDVvOFFXYzg3UT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c9e7082-cae5-4503-03ab-08de53bd0787
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8948.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 22:34:07.6128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xoKAyETKca0Ti89vo4tULRWpGB5ZLdNAq4aZigH2X2DkXhr7iwef3Ma5dVPyhqDKaFpUhjZ0DRWrJl8wSUQd8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9554

From: Jindong Yue <jindong.yue@nxp.com>

Use tristate for mxs-dma to support module building.

Signed-off-by: Jindong Yue <jindong.yue@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 8bb0a119ecd48a6695404d43fce225987c9c69ff..b1c2d0fd0836edec9f9b6868e020310f50bba63c 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -505,7 +505,7 @@ config MV_XOR_V2
 	  platforms.
 
 config MXS_DMA
-	bool "MXS DMA support"
+	tristate "MXS DMA support"
 	depends on ARCH_MXS || ARCH_MXC || COMPILE_TEST
 	select STMP_DEVICE
 	select DMA_ENGINE

-- 
2.34.1


