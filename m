Return-Path: <dmaengine+bounces-8274-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 04708D2598A
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jan 2026 17:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 79755300EE4C
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jan 2026 16:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480472C11E4;
	Thu, 15 Jan 2026 16:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VqcgGa8c"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013009.outbound.protection.outlook.com [52.101.72.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6DC27A92D;
	Thu, 15 Jan 2026 16:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768493231; cv=fail; b=kfm6dbbvYm5xHkZt4VpLaHfmr+NKW8BsmgW9f/6C1GcMIxlJF33AFJeyVuQ/psEV534haOhjIrO1Jd8x33UBIihB8eYRNdA4HBB3gtzfTafQpmZqMyOrBQKDLxrTxn25CMf3ebovSWUUYZriPWSUQdFR8DbKM9Ga+41GvK8/F0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768493231; c=relaxed/simple;
	bh=ceQzFsAdpjm3S80xKJmi+srb8wAfNrsmvN1XHsGONfs=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=JvB357VgzifZ90svMwvP6ooilhiN4jjMBEs6WDK1vcgu+/QpQQXgohUCw+JH7NQlgus41H9qBNjORQcB+y9OsE9NPrvj2oZdHjTEHtYTA7itNeN1ICLwH3ehR1dmQqQRjqpCqUObWmS/LoXNAN4ovHivLxBq29JSSThPUbV4lgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VqcgGa8c; arc=fail smtp.client-ip=52.101.72.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LxZKIb3NGpBvQN2ZYjXDHAsEvjyzCOSc5Epsb19ku/6djwAwGuRaH1rToOuReFQxiOl4BoUMiTuGPCbevELdQaydN6ouIaqFL+OZqZ9OVDh1qr6RhzW5hX9+XPFgdEivm0lEgnUQprdWo7ZZRR0NIsKEs2yDRCtO2LmovxKaxKpQ4AK3Y6n+OKFQJdz4x8bbVfVeIHgtEDHM5+HGD9ScjqUyHLfNVh4Nkl3eysWQERQ7n5rLEQlIs+5uBlnYZMTSaO1GGe5ZuXhwv4YjwsoN+DnydMv43+xC9KJmguQ7X9bPnQIxQkTNWlfX8szKQT4pJ7zIqUYmTjTd6gTH/jRQ8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RsCoffTOoj8cD18Ha9BQ3+UGe0G5QNgN35ILeySLDgM=;
 b=nAzl1lkzQSWG+1oh/Qdq1Ljlb9TkC5pB0TwT13/G8zaeaVTPDthdYQdEQKSR5humj6qz4o6YixM0/VeZKHj2XdTF0btHPREq/Q/rIRkhO5lBw+NCA6ghTo5VkLliW0J1T5jPB37BawxUBoMdt8GBMD0w+IHMLhb6iuqCAFGxlNdPAMKXm/WiYX2EdAPczoij3vvocItNzr7NrxMonopNF+MqX2tGkKEnXIClNGtnJ6wCL7sbegJQJpDf0A1Nm5SZF5NUdSCk4bNWm0VTQymw1EGN2zwcWbMgnEtJJlCsxGOzY3W6GbFL7EYrsgkgIGAE5u7uR0Bje4NLhjpgR9YQNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RsCoffTOoj8cD18Ha9BQ3+UGe0G5QNgN35ILeySLDgM=;
 b=VqcgGa8cXyi2YFL/8fgP5uVmuqUozhP3rzCoYA00OB3emMsVXXxlzeResQDeJipTD4dOtOHXS1S5MFJfUnC1j+sCli35OdAxMSG8ycSM+F7hSm0qSVlbOSQsLjTfS9XEiAKJ79JK+hupy8RfeKbp/nyR7jgBA/XTtma2RxQFIfaVlXQAkhL5EHM8D0E+ndAsSCaV8uToL31nwBnBs7JBN1JJuKIgBBB7vexI1csm7RdUr14f7aYDq1ADqo1+jzE4olZ2Akt36baSaUiMdgYVAXL+FIQD3EZgU4hnVQPORmz0oH7rpjDrs8GU8yYoFdKodAOdOHzPMZv0jBHwk/D+rg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8948.eurprd04.prod.outlook.com (2603:10a6:20b:42f::17)
 by VI0PR04MB12235.eurprd04.prod.outlook.com (2603:10a6:800:333::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 16:07:04 +0000
Received: from AS8PR04MB8948.eurprd04.prod.outlook.com
 ([fe80::843f:752e:60d:3e5e]) by AS8PR04MB8948.eurprd04.prod.outlook.com
 ([fe80::843f:752e:60d:3e5e%4]) with mapi id 15.20.9499.002; Thu, 15 Jan 2026
 16:07:04 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v2 00/13] dmaegnine: freescale-dmas: small improvement
Date: Thu, 15 Jan 2026 11:06:39 -0500
Message-Id: <20260115-mxsdma-module-v2-0-0e1638939d03@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI8QaWkC/3XMQQ7CIBCF4as0sxYDE0LElfcwXVAYLYlAA5XUN
 Nxd7N7l/5L37VAoeypwHXbIVH3xKfbA0wB2NvFJzLvegBwVF0KysBUXDAvJvV/EaEJurbFSXxT
 0z5Lp4bfDu4+9Z1/WlD8HX8Vv/SdVwTjTExpNxkhEdYvbcrYpwNha+wJUzKMnqAAAAA==
X-Change-ID: 20260114-mxsdma-module-eb20ccac4986
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768493221; l=1910;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=ceQzFsAdpjm3S80xKJmi+srb8wAfNrsmvN1XHsGONfs=;
 b=NVEs6BTMBY0FoVeSJIECUKWMMdH3ifxvboC80TfAa6Nun87dV+2IKfMwGulHa+apR2rJm0Cfk
 Z9EZPPUXDNNAwn1KWvuTo2pP9qMxFEzSj8p6QqYWG2UYZq3z5+dt81Z
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH7PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:510:339::15) To AS8PR04MB8948.eurprd04.prod.outlook.com
 (2603:10a6:20b:42f::17)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8948:EE_|VI0PR04MB12235:EE_
X-MS-Office365-Filtering-Correlation-Id: 59fc1f99-f54c-41ff-4d23-08de54502008
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|52116014|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U1ZhcFFmaTRZc0FIWHlicGFOZEQ5Y1RQci9BcWZiWWdGTG02c3Izdzh6YlBt?=
 =?utf-8?B?QmpJM2NVWFhNb1QvaWxSRDh4VkJyZG9XdXUwOE5SWWNwZEd0Njl6ZHJiT2hy?=
 =?utf-8?B?Y2N5Y2VLNVNwUE5waUU3Q05xQkwwcGR5UUFkOFpVUGcrU2lpbTRzaHZQa0g0?=
 =?utf-8?B?blNBZEZXcGdwclE5V2Z6RVZpQmtxVWxzajN3dHlMdGpDM2dzbUtLeE5NSEx1?=
 =?utf-8?B?ZDVEUXdOUkJVcjZIRXpPa3c5MThlWFRCN3gvMXpTNlA1OFRmV1FVckZCVzlB?=
 =?utf-8?B?OENkMXpuVmpZamRQaFhqTmc2QS9UcXd3c2ZleEMxeWEyRGxHOGowYllrN3NM?=
 =?utf-8?B?QjczR0FTaTZzbkRla2I0NDVOVlp2MGxaNDNGOFBTeURtckQzYjMzZkt2cmt6?=
 =?utf-8?B?aWNBSWtsc3BXSUxWUmJ0eW1nZjBsYktrNjF3M0EwRHVZamV0ZDhsN2VRYTlD?=
 =?utf-8?B?ZHRORkcwaDIzTEN0YjdjdFUzejV2OFZVMzNtbjNIU2xIWFVUdDN5ZEJRS0lG?=
 =?utf-8?B?bWU4R2lFZzA3b2tPOG13U0dFZW9RbTF1NnF5dUw0QUVXMm5EaGtmTjI2QmFC?=
 =?utf-8?B?ckpVWHIrNm9QM21ZTHh2Y2VoVGc4aGI4YjVnRlM0S1YwVDNqSGN5dGlhTHh0?=
 =?utf-8?B?T3hMbjN3eUFUcXAzRjJwM0E3SnRVaEdVT3RRSXV0bWpndXpSZFl6VDVxZEZL?=
 =?utf-8?B?dTcvUnIwblhGYkhwa3d5VFlBRTE4N3JoM1pQNVp5dURKOEhwZU0venB0Kzl2?=
 =?utf-8?B?MUE3ZjlWYTAzeVB0K25uQnVvSGx6MHhRWmU5UG8xT2tyb0F0MlJ0dCt3RDJq?=
 =?utf-8?B?aHQyK1pGWnBWc1g1SHBPWkNQckRrU2kwVUFyU1ltR0dzakwrczZicVdhMWcv?=
 =?utf-8?B?SzdrUUdRYXRWczNQWmIvR0hwcVU3eVFPMEZMRVNCL29HZW10WkxKQkNwZlVj?=
 =?utf-8?B?ZE1aSlVEZUdJUUM3aS95d1k2QVdiVG1nSDFOTnVoMkxQSkh6NVRuMXN5SVpI?=
 =?utf-8?B?L2VnbFpCUVRaeURrT2UveE52NTlxeFBrQytIMEFCdTJIemlGWVMwOE5HR2o4?=
 =?utf-8?B?U3NCcjh6LzhlOHJiaC9QZm54cnB4V3MrbXFMT1E4OHBFQjJkcnh3Uzk0aVlt?=
 =?utf-8?B?eEJGbUpXaDFmU3dHU2tDL1hnMjV1Vnl0cVFSUXlFeHBudyt4QitCaXhGSUda?=
 =?utf-8?B?UlQvdmVGalZHeHJwRTkyS2NBNTduNmVWdzREWmFPMWJaOWNCa1VnUzY0cUQ0?=
 =?utf-8?B?OVRTbU0wejRzZUlacmVBSDFnUXU3MUdCbzFSTkhEdFoxZ05qbDFjaXpDaXdB?=
 =?utf-8?B?VGlaL2tuNGJHTzh6d09KQnFBRWNRM2w4SVdocGtHSGRzQU16RWMxZ05rMndY?=
 =?utf-8?B?dkxJTkQ1eVRCYVV1UG4rM3FtcDhld01wV1BGMm9EOTZaQlZ5cG9PaU9QN0Z2?=
 =?utf-8?B?ajdXNENkTEo5L3BDOXdrdjE4NnI0UVZJcGk1MXJwQ2ZmcHR0Q0FDcWhSSWZQ?=
 =?utf-8?B?YThhK1FNM0p6SFlpd0FzS2huMmwzK1J5Y29LZ0lrRzJ4SitGNm5KOTRoMDAv?=
 =?utf-8?B?UE82bXdmZ1gzdEFJSHh0S1cvNit2d3g3dUV1MnJvMHl2U3N0ckNGUzBwMU80?=
 =?utf-8?B?MmhURFVaWXZubDNjYmRyU095SE5ZdjRZRlRQTkVwTENMSFFxQk1kT21qcFJE?=
 =?utf-8?B?MTQzeFYwUmt0ZjBwN0V6Wm5JSnNGazZmc0RaaWx6SlNWbEJLdXR2WjFqeER0?=
 =?utf-8?B?ZUU1QjdyWWRFR0UySUlwaldmK0Q0M0RtZ01qV1FCQXVOd0sybDZ3eTBHK1Bw?=
 =?utf-8?B?cVUxSjlvM2VxemlteWtQdEpzb0JkMWlGS3VJdlVjNVdVcnNUcFowOTdDQVor?=
 =?utf-8?B?NkxoWWQwc2c1VTZzbXZYNnpvSng3THZRVCtkNzFTbFZBZFphU3VOYXJwcXZp?=
 =?utf-8?B?VXVNZHpHTGJuN2luMWZPaDRWYmdJSG5FbkEraVRCZ0RrdzhXVjdwWmQyTTdP?=
 =?utf-8?B?UW1OMVZkdUlpaC9rSHFlK2szOFJXVGtJdHVQcnRNNUxZNkJsY3FmYTZDSDRj?=
 =?utf-8?B?ZFUyNjRQWGxDY1R5V2FRZUVJeU5rdTJ5MUtnV2V3d3NINFNnRi82UFdNcUQ5?=
 =?utf-8?B?UXA5RzVHamUwZWZLcVo3RmpocmFMd002T1E1MVR4RnIyc3k5THFqeUFTUHRS?=
 =?utf-8?Q?BDSVLD8KR2BfxoxNVYF0YPM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8948.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(52116014)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RENoWHdrUXhCT0dyeldSa21nYjlmUURUa3Z2eDdURHIvayttY3ZoKzJwSFBG?=
 =?utf-8?B?dVlTbzBQQ1krZUY0a0VramlFY0VPR083NmdCSldWTjd4cXpXRkJnbmxNMmNO?=
 =?utf-8?B?MmMwU1FOMnpiN2ZHdlJ1RUk1cXZQMTBPTWRHTThrUnN0M3FZWUhOMUh6QTcy?=
 =?utf-8?B?eC9jeEhPSWNaUFdZbk5yc0dHdTVvMDhMYklYajFVbHRjekpPaVNXcWRxUlh4?=
 =?utf-8?B?VCtvbGFQWlZya2dWZGU1Z2dVMFZsY3Z1TjFXZGlHWFdOVk5XRnFaNnI2UXJV?=
 =?utf-8?B?NU1OeTFjOEc3ZXd5b290T1JwNDRmQVdkaHdLSDB0ajJ0ODBzZWpHeWdvM0ZQ?=
 =?utf-8?B?b0hSOEhrZDExSUU1OWJEbUV1MFBmcmVVRnZzcjNiNFh5SnZtVmtOZ2ZFVU80?=
 =?utf-8?B?NnprTHpNNWNtN25Bc2puUnljN3gwWkt5UnBSKzlhUzlidUk1UEhGSHdPVThp?=
 =?utf-8?B?TDc1azVWdjU0MURvZ2poUlB3SVd4SWlCY1Z2Z3JwbHRkY0dycnYvaVNKR2k3?=
 =?utf-8?B?OVJpMGtDUHRVSXFIeWUrU2tFNnlTeGlsL1NJWVJraVpvQ3JVMDlqMUJod1Nz?=
 =?utf-8?B?c0J2R1Rnd3ROMmVsUFdsUnBDMHgyNnRTeStyR2l4N3grcHNXNWVyVnJFaUtH?=
 =?utf-8?B?VHVXdTZpY0UvQmJZRko1UlJIaWZHUnp1eE1BZ2JTR1FlTm9IaEFUMCtncHBk?=
 =?utf-8?B?ejZoQTUzdzREVjFhMElmU1NubTZVWml2cDdNNlVydEZqZWw0Q0tSRFhtMmQz?=
 =?utf-8?B?K0ljUjVvUXRiczdFTnliSVFJNjEyZm41KzdXUzFNQjV5dGM3MmprOTlxa3NW?=
 =?utf-8?B?NXFPRmVkUmR5NVZWbWlsV0dRTWNOZGc4R2U0VlF0UzUrWFZqRjJUdTljdnNN?=
 =?utf-8?B?aE8vZENtSUM5VU9yc1BwZkZINlhCd0pMc1lmV1FxYUlPbmtRSGN4MnFrZDhV?=
 =?utf-8?B?SGFSVjVHSVdjdXRPdGVXTDVBbDJlRDVrc2dhNVM1WW9DWlN3Y09rbERVbmN3?=
 =?utf-8?B?UFlXOUl5Ym16dlRPeFdxQnBqK1Flcm8wRDR0OVNHMDR4YlZiNkhyZzF2WGsw?=
 =?utf-8?B?Mi9PS2RXbU1SdGdwMTV6UGk1bHdDZU5sdlBEeURaZmcwVnBtM1FSNW90Zkd5?=
 =?utf-8?B?d2tYcjlFV1RGL0lGMWVSZzRxUm94ZXVJN25OeVNYQmgvSWZGazhNTDkxVnVx?=
 =?utf-8?B?TkovZ3FoUzdHUVVLdHhXbmJrSTJmYk5SdjQ4ZG5yUnlPczdrbmRhRFQvM2dr?=
 =?utf-8?B?NmkrT3NVcmJVWEwySzVIZDV5QW13T0ViNkcwb1FpeWhhWkcxWTRQK21hc0E1?=
 =?utf-8?B?RUZ2T05KWXRaQURTbU02Lyt3L0tNZmpPOS9CM2hXQ2h4bXYxeE9sQ21adWZM?=
 =?utf-8?B?TWlJZmtPbjUrZUg2SFJwMGtUQSthdFI2WXEwblhJc3FPaG5uNXN3d2VCNEYv?=
 =?utf-8?B?MGhkMVFlMGFZT1AwTGdtNVVVU3EwWGtNMXVhdnlsWHhGU2ZhSGplZE94V1h1?=
 =?utf-8?B?NC9FV1p5WmRFeWhiWDR3UTRxcjFReklUTVc4bGJaVXUzdFdjZGRQN1Fja1B5?=
 =?utf-8?B?VW5tamRKbll0L2tVZ1NsTWdSVEtsRkNoSDkzWFlJZENGMDgyQXBxU3RRWThY?=
 =?utf-8?B?RTZvS0dybG5mcWdXZjlHd2hINjR0ZldRYWZnN3Ard3lxcVNnWW5WMW5TZHVE?=
 =?utf-8?B?eU8vTW13REtZanlwN29OM3VtNnlPUzFEc3NMQSt2YXprMkNvZnRMMUFESXlp?=
 =?utf-8?B?ZmY1Vk1FUVVnZ2NITjJjNlVFdldsVENZV2dnVW9ISkhkYjJEOGFTMzVOVzZP?=
 =?utf-8?B?NUlUQ29OaEZhZ2I0Nmg0dnpab1RpMmRXYTAvTjIwRHlDUnc0ZzFUNHlCcXB2?=
 =?utf-8?B?UWtZUGFZdWJNNUoxN3owSHUwMjBab3lxOUhJT1dvTm9HOTREM3cydVgyd0tv?=
 =?utf-8?B?aURwV0RIR0pNWTNZaWN5QVlnOG1TcFBvVWJSaldrSjlnRU4vcEo5UlVvbCtt?=
 =?utf-8?B?SUpCWU0vR2U4SVRqOWR1S09EeTY0NTNOMDk3MWVhSFRVVEtlV0l4TkJhNXVY?=
 =?utf-8?B?cEU5ZWRKZnhaRERKUTFVc2xqS3dZYWxYUU1WeEY4K3dCM2RYOXhRUFRxWUp3?=
 =?utf-8?B?alpZRUlKcFNhWkRSU3ZmRkNHUGR3NG0zeWk1NHI3SkF3eXR1cEJkRDNrVXV4?=
 =?utf-8?B?YXRZODRKUXlJUGFBVFR4MmhnWXNyeU9Cb245bGh6K3FpbGFLRlZFeCtSK3Zp?=
 =?utf-8?B?bExya1JjN2VESEp1by92eENXME93b25aaytuWkpyckE0eWZqTXJWVGtMTUVq?=
 =?utf-8?B?ZVgxYjhLUm85cUFjSUk5QTYwTHNqYnY4R2kxelJ6WEx2V0VZUzlJdz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59fc1f99-f54c-41ff-4d23-08de54502008
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8948.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 16:07:04.6176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mbpvyRpNOpbmgQ0+SVBH2evw9+k64oKEkjuaiPs1x4xZakCsHClIjKhMynPrwW7WHc1aFLXtpy/0qw8QdgwpVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12235

Add managed API devm_of_dma_controller_register().

simple mxs-dma code and add build as module support.
Use dev_err_probe() simple freescale dmaengines.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v2:
- fix missed int at stub function
- reorder patches according to dmaengine
- Link to v1: https://lore.kernel.org/r/20260114-mxsdma-module-v1-0-9b2a9eaa4226@nxp.com

---
Frank Li (11):
      dmaengine: of_dma: Add devm_of_dma_controller_register()
      dmaengine: mxs-dma: Fix missing return value from of_dma_controller_register()
      dmaengine: mxs-dma: Use local dev variable in probe()
      dmaengine: mxs-dma: Use dev_err_probe() to simplify code
      dmaengine: mxs-dma: Use managed API devm_of_dma_controller_register()
      dmaengine: imx-sdma: Use devm_clk_get_prepared() to simplify code
      dmaengine: imx-sdma: Use managed API to simplify code
      dmaengine: imx-sdma: Use dev_err_probe() to simplify code
      dmaengine: fsl-edma: Use managed API dmaenginem_async_device_register()
      dmaengine: fsl-edma: Use dev_err_probe() to simplify code
      dmaengine: fsl-qdma: Use dev_err_probe() to simplify code

Jindong Yue (2):
      dmaengine: mxs-dma: Add module license and description
      dmaengine: mxs-dma: Turn MXS_DMA as tristate

 drivers/dma/Kconfig         |  2 +-
 drivers/dma/fsl-edma-main.c | 55 +++++++++++++++++------------------------
 drivers/dma/fsl-qdma.c      | 47 ++++++++++++++---------------------
 drivers/dma/imx-sdma.c      | 60 ++++++++++++++-------------------------------
 drivers/dma/mxs-dma.c       | 33 ++++++++++++-------------
 include/linux/of_dma.h      | 29 ++++++++++++++++++++++
 6 files changed, 105 insertions(+), 121 deletions(-)
---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20260114-mxsdma-module-eb20ccac4986

Best regards,
--
Frank Li <Frank.Li@nxp.com>


