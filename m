Return-Path: <dmaengine+bounces-7592-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 476B1CB9EBE
	for <lists+dmaengine@lfdr.de>; Fri, 12 Dec 2025 23:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B236D3007E49
	for <lists+dmaengine@lfdr.de>; Fri, 12 Dec 2025 22:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF5928B3E7;
	Fri, 12 Dec 2025 22:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jwSFBxUx"
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013060.outbound.protection.outlook.com [40.107.162.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D12A1D5CC6;
	Fri, 12 Dec 2025 22:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765578382; cv=fail; b=EsZt2rmG0KYHvadfmgpqXvBvUWymlYzwbKl7/GsjEjt7AX6r2NeKcneKpPMF4BbTrCj7nZ/UptOTE51UsNW0xB3FJFwNy45UNAWW4ORPxJU8O81EfiN0qYmIOknL8iXq5eDvYWH92E+QRyX9t+MZdbVG8p7MASnE6k1sZNaS734=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765578382; c=relaxed/simple;
	bh=CYwueOnbj62KXocJrTPskw+YfJQ/MjJl07WRduEw0/U=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=OUcv9uQsP3J1WCjGZO4RM1XJ3FM35xaeBYEvwn1EZHcvegmeTYSL9bmq2QQCUhRRMykNhiVGj/CVbd9wG9JabCgU0qgfoqvBIwpDb2400I9fwzweF22wmgUiwu+MTV1AmFQ3JsVQ+Lt3wV4PxQsIRcAavygVwSBZ2egTzWNKZ4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jwSFBxUx; arc=fail smtp.client-ip=40.107.162.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aD1tluTQzWYE9Ypow7hLLpl4IkK+5Xoeg9aaYoMiNltBRUAi46QiHFvBY/W7nVE9IhlGPSQIQ+G7NZ+VrG941iHgzYdiEQAjvvu2saJyvFmrVa7LXBzzSv/DRbFTg8qskdAVxveGJ5pPsogkWM06Mmx7BHd04apaRWjkKgGUMh2LcM5dW6ie26ICyRV5VZEiYF9j8g/bktyxOFp0dGkSW8yarSdg3uxuTK0RxfK+NaZLCnhY9oaudEK/kgnv3omiDf5JaK0N3n3dNdsVc38O0Q0ZUb/G0voqMRmGYEWA1tiGQj9rFQHOdZsqBrIb2Wm6K99nCGHovVLXgLPKGHGF2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VPtT/zMjd9EwCVCfxOer5C8wAwixkQ4CR099ivp2F6U=;
 b=sgyQFl/Xa+KFEIoUjO18sZOddDNnADrGEVyIReEwtIou6jdvRhmnwHUZWiuh2+jaSZSzj1zpptCCqG93l+fkKjrO27SAyWPhn+TrQwoYxOVxRi8GR/AqP2wuq90z8bjqOb7akHNH1Ybz7ShFGsU3rRbWooaldWdJFPAOQas0pQkQ6f6YYDZ4yPI34o9SSKxd0J1CU78BbKwpNovZxy+nvpRC/yURr2WYQElkkcabWIlfSr20laCWV0Euksjta5gfNkBf1PJbuRu6zwgnGfdgIxn0vHcAUbSZu5XwvCaGMNAkKr+GhAAWelqiHo+4Lh5sIaq55/NXOMMgiYTN1mUbvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VPtT/zMjd9EwCVCfxOer5C8wAwixkQ4CR099ivp2F6U=;
 b=jwSFBxUxzwKYimAUqQYEz9AT8e2INYqugijsQSg0sLjXOCz9ygLIKlMxsFQnwxReG9FJBZxPG/iLpsdGptLJl2BtEAthLyiNdm2E6nIvBweqtLr7HZOXvwJ+yJ55qFmariHpr2ohEw/oeYgI+2jGAcJ5IZS5gC2+0vZ/p8XwaQoeq3wPP9sAGBJrPbPm3xeKUgYvKvY8T7lBlq+IonrD3zoowYvewfLn4SanbYFgZ1YuelXXP7ddWrdyirW6gwz0JphRoraoAceEW/Yn1Wgs9zgHv/RNHugYmsM1TjQOkLb6tsP+nU8rcZfBHw+Cm/eSz4BRr5PhSHWYHSqhO4vNPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by GV1PR04MB9053.eurprd04.prod.outlook.com (2603:10a6:150:1c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.12; Fri, 12 Dec
 2025 22:25:06 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9412.011; Fri, 12 Dec 2025
 22:25:06 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 12 Dec 2025 17:24:40 -0500
Subject: [PATCH 01/11] dmaengine: dw-edma: Add spinlock to protect
 DONE_INT_MASK and ABORT_INT_MASK
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251212-edma_ll-v1-1-fc863d9f5ca3@nxp.com>
References: <20251212-edma_ll-v1-0-fc863d9f5ca3@nxp.com>
In-Reply-To: <20251212-edma_ll-v1-0-fc863d9f5ca3@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>, 
 Niklas Cassel <cassel@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-nvme@lists.infradead.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765578298; l=1905;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=CYwueOnbj62KXocJrTPskw+YfJQ/MjJl07WRduEw0/U=;
 b=zKIMBUu7mERZz2AxuGd5ccmi6EJ0zDurjeqDft7VYEZB+QrbMH61UwA7O1GXh1Wqx3OWXgQRv
 3i+HnRHCS5PAxGJwywxjihNu3hB/BNKauhoh+7J8dBVgC+HlsITJE5u
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR20CA0025.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::38) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|GV1PR04MB9053:EE_
X-MS-Office365-Filtering-Correlation-Id: 0661267b-6e5c-4033-95d0-08de39cd4d91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|7416014|52116014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VG1pV2RlSjRtVWZ2eWE2bE9IbW80NTJXMFR3ZnFPU0Q0RGdiR0lIMEx0UFdM?=
 =?utf-8?B?MTZjcTNoejBKM3A1RFlsYlJPQjgvaWlLb2o4SllEUXM5QWJQU2tBTXdTLzB4?=
 =?utf-8?B?UzZHd3lFNjh1WjAxTGhOZEFDTVNzbHVybWNtMFRpMmN6ZkxiV0w5eDAwb2ty?=
 =?utf-8?B?NnFPaHB4SDFYWU9PcTA2K3R0V3dmYUI5b1RicHRRVlpmTFd3dTJ6ci80L3BP?=
 =?utf-8?B?YTFuNGROSm9FWVRtTjRYMTBnbVZZZFhuYUU5cDY3N01Rbm5PbkpPanNzWlBZ?=
 =?utf-8?B?SHlYRkhWbmJaUGl6R1RNaThNVlMxVDQ3eWJVQVNpdUJGcFlNZms2ek9Bdy80?=
 =?utf-8?B?WjI5SXZHYUJnaVMvS3N6amEvY0xPdEx0UEwzOEl2QUwxbFh2NWU2ejgxSUdI?=
 =?utf-8?B?N3Z0UHkwS0lKeGd5YXI2UndLWGoyZFZKS2tMOG1lT0FPYmFGWFg3QlNIRWdU?=
 =?utf-8?B?NUdIVURtRmJRZ3NrK1A4blJjbjhIMVMweXBNVWhLUGkzaEJqQjd4ekhIWk42?=
 =?utf-8?B?dHViZVNYU0R3TkFiZkNMblN0OUhHemdJTEZwbnpTTVlkemJ4R1dMMUlpYkZK?=
 =?utf-8?B?aUI1Y01DdW5jN2xNcHRoZmlkeFgxRU04UGtkRW5ZMDFmelZiZ1JBbzhRTGxJ?=
 =?utf-8?B?QTJCeHRobFBNd1VFM05lVW15eER4czh4dFlTK0w5cE43U3VYdUVTMm9SZlhk?=
 =?utf-8?B?S0hFVklCOGRZY05zeW9FY1Z2NUJkTzVhKys3TDlTbzVmazJJaDdOeFFwakF5?=
 =?utf-8?B?UDFxSTNEU2F0TmhacDJTUVl1aVlhZmtSemdLOWhCUnFQVEswN0U3YUxyUzFS?=
 =?utf-8?B?QWJvME16RzlzWHEwcHdOSFA1dnljU3JUcDhWRldoQ1UwanBMeVBFNUpXakRv?=
 =?utf-8?B?cmJ6Q3dhb1N1STl2VFlSYzRMUDN5VC9LcnhEc3k3cVp2YlBiWk9vd3NmUnBE?=
 =?utf-8?B?bUEvRGNUdkRqbnlDWWtwclZzVW52c0kxR005VHhWTmhZdVR4c0tad0xjZUVU?=
 =?utf-8?B?S0xSYlhxMEViWTFmNTd0bS9VbWZwd1BDaXVMbU1CS0xBVzdZZnVMTTdSalhm?=
 =?utf-8?B?YytzUmZWeHF6KzZMT0UrMitTeG1QVTBxcGlpQVBCdW91TzJ0Mm92L1QxRFlq?=
 =?utf-8?B?M1d5TnhpSGx2VXpxYkNXQkc5RHc4d1l1RkluQnZNaVpqclBOTGdZMm1NYU9W?=
 =?utf-8?B?U0tuaVBrQ0licHNlSEZtTldrNk5CQ1B1WFZMdTlOY0JBU2RQNXFjdjNLNDZx?=
 =?utf-8?B?Mm45bVFFTll3cytLc0FTeXJGd2RyZEtzYWlpanR1QUZwS1RDV3FMRW9qRm1T?=
 =?utf-8?B?bytmR1I2RURoeE1wb2FoOE9oZW04VEQ4cUlCMGxnV3VuNWY2UzJ4bjZvdmt1?=
 =?utf-8?B?VTAwdkZnZC93bkt0RTJVd1l0Z25IN0JFSWttd3JLS0ZTQi9UUzhaL0wzRVg1?=
 =?utf-8?B?K3RJRWloV2FKeXJoVk1zdnU4V1ByTktBeDZ6b0NDSFRJUmVObGRneWg2MGlW?=
 =?utf-8?B?Y2ltZHo0U1FTWHA1cEVSaXlidUkvWjh2aytpMDRkaTAxUlZvS0RhTDU3LzV2?=
 =?utf-8?B?bUJLYzNOUzdHS2dxcWxTSWRlZDdqZThMVWx2TU11Yjl2QmU1R2Nld0p0Sjln?=
 =?utf-8?B?NkVLYmFZU0R4aVZJSFpuN2VQS0RScURMVFBUZ0pnNWtuK3hNVmVQbDZDOU5P?=
 =?utf-8?B?MkdVYnN4ZE1YZW1VYkRZTFYwNUtSR3RMRlVNaWRNN0dxZHRFVExTTUFpMHJF?=
 =?utf-8?B?RUdSMmhWb2FxaUdud3drdVB0S1loeHZXVTZZUktkZEs0YXFxTEdtT0k3ZHA3?=
 =?utf-8?B?ZW9BSUZzSXJPbG92QlNCMUJDbnljRXJnV1VMUUg3dlpMSTNBSzlRM05wWWRS?=
 =?utf-8?B?Y2RvVlBrNWFqMXp1VUt4Vm8rQ2RrVWtLRzM4TFowWTVGa0hFOUQ2S0swa0dR?=
 =?utf-8?B?aGQ1eWdDMGpKYkVRZVM2M2xkRGZWdGJTL2ZiZnppZ1BrMXVPdE9tTHJpMDRz?=
 =?utf-8?B?c2xlRVMrbnBqS3dweXhFT2VsMEVJV3RwQ0JWMUFrWXFiVnlRcmZDR29tUWZH?=
 =?utf-8?B?dm1pSlh5Y2hXdTlHWTZUOWdEUThZUndPMDNEdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZnowQjVOczdIcnA3N29GY2h3U1lsTEZlWC9nVDBTQ05oOVQ1Z2JQZUNPeERy?=
 =?utf-8?B?bXRWOG1NcXFJd0dMeFUyQjRJeUVmajVmZ2h5M1ZxbnBhalo3NmdCQ3U1c1BE?=
 =?utf-8?B?YlhOdUM0UUYyQTd6TzFWaDl3b3IwWkJEN3dDbXR3ZU5ucS9JRldYWE9VMWpv?=
 =?utf-8?B?WncvOHlrUEg4QkhYSFFaV1JqY2NhRndYdGdJd0JDY0oyQlo4b1grMjV5Rito?=
 =?utf-8?B?Yk85dERaelpZODFtd29hOGlVVTBBZ1grZDFCZzFSNjRQYitHTnBuc2tnSW96?=
 =?utf-8?B?dzBaekc1b2FuRG9IL0FOTzNzbllvQW1OeVpldDlzbjhCTVBOcDNDSzUxNUp0?=
 =?utf-8?B?S0JEVHpTT1A4OWVHWWdSSkJxd1VlWmF4QmI3VEtweitSQTROem1BYUlzTkww?=
 =?utf-8?B?YmtJTEY5eDI1NnRiS213MTkxWTFnemdyb08wbnNmZTRhcVh6SDNJMEZaaklO?=
 =?utf-8?B?eDNtQkEvWmpNMXNpc01rVnFoMVh3V0grMnJkeUxycnBaQ29RN1d2SnJTK1ZY?=
 =?utf-8?B?SnVBbGUwOU10elZIZ3BWdytLaGNxcUtKdVZxNXNQZlNhQmkyVDRVODZFbVJh?=
 =?utf-8?B?cHFtNEhzcEpaMXNoTGFab05NSEIxSm9nZ1NNWlo0SmNyT2UramVWTGNYVGIv?=
 =?utf-8?B?N3JaeDR0aDVLNG0wR1lUUmJndk1BK2ZXa0ZGTms0ZGhucFE2dWUzL0MrK2Uy?=
 =?utf-8?B?RGMxK2p3Vk10OTF0WTl0T1greHN0S2dDSS9qKzErdFlVNCtXcHRMSGxlbEVC?=
 =?utf-8?B?Y2Nod3JuMkNGQ2xhcFU1dlNnMHdZUEtTdHpOdXl1ZkdhSWFJZWNTZkdjOWIr?=
 =?utf-8?B?RUY0NGlCOVlLRnE4M0hsdkE5TmtlN3FjMXA2WXdmdFZhM3ZYVkJpNG5MU3NZ?=
 =?utf-8?B?cEFUMTRNSXMxVVF1dFd3TG1IM2pkQlFyUHF1ZTVPdGJiem1Na21GMUJ3NHBH?=
 =?utf-8?B?NHFtd05pdTZzNW1hVzcyRktEaVJUTlFtZTIwTlh1ZlBOVnBXZS9jeDdOSlBl?=
 =?utf-8?B?S3pWVFhtY1QzTytuUVRzdGxzU2hYcFU3dDYrY2drVEwzS2dWN2daUzZpaUcv?=
 =?utf-8?B?VzV4c1dmN0RyNHdGcVJKL2tvREhLdjB2bDFHbjg5QnNGS1B1eThMY2J2UWlu?=
 =?utf-8?B?d1BMUHBCcGN0b0JOdWlZWmFaMUE0MURhaWNieEZYZ091QzZJVEk1YnVuUDBk?=
 =?utf-8?B?bmRSSmJ5czRDL0V5bTBYakJGZTd1aEhhUlZVaHF6M1h3aGVPeU5pWDd0V3JE?=
 =?utf-8?B?V0NjaVRxTkdiM3o4Y2hIRnZPNVhtNjB6OS9keGx2OXIvUjNiZEh5Ny84TDJ2?=
 =?utf-8?B?cGF5dTZVQy9NQ2g0SWQ3OFZIZGcvYzFabnlGcXVCL3phcitKUzNkZEVKalpS?=
 =?utf-8?B?azVwWDFUZWk5VFlYQjEwaUZmN2VOazM4a2lNMG1XSHNPQWJZL3RVMkozSHRp?=
 =?utf-8?B?ZVRQck1ZZCs4WEYyLzJLck9sem5sTTB0aVVMSkw3d2pZSHVEM0tqTVZ4aEY0?=
 =?utf-8?B?cUpRVmxLTi9aZVhwNWpQZHl1RXUzdUZsUXAvM2J0ajhCd2xNQjNqbXZiTlFq?=
 =?utf-8?B?cXVXOVBsVXNCNi81ZWVGR3B6WlhQdkFVYnVtOC9RNHlkUXhCM3o2aXQyaDdo?=
 =?utf-8?B?VG0xZTZZREkzbExFQkVhZnAvOGtwdzlPSENTd3BJeFJuR0k1RHp6TmhCMEth?=
 =?utf-8?B?N3B0M0ZpODRRSzlFTCttRE0wZ0Z3Z2tZWVYzVnZxUFF6bU9jOFgyZWdGUnZT?=
 =?utf-8?B?QWIwK09iN2kyRzc3bXM4L3pqcktibUpVZjJCWE0zZUsxbFR1TUc4RngxNVdT?=
 =?utf-8?B?YXpDS3JTdHZQM201SjhETlZwZkh1eGVac3psS29uTnJ0QTIxbDdIQWR0R2JK?=
 =?utf-8?B?VEtjZ09yeGRaajZEdWcwRWpIN1UyS0RURE42dVhGME5ibE0yWGMyTGRGWTJv?=
 =?utf-8?B?ODhyaVFPLy9pd0xlMmZuWjlNay91azlMdDFjMS9wUVM2QnZHU1NaMkwwem01?=
 =?utf-8?B?L0RNOG9WSlRzNXlvVkNoeC9YVE1Gd0FYalh4MXNWQ1hBNC9NSUxMUzdxS3RI?=
 =?utf-8?B?bVlLM1lQTDJyUFhKUld0Uk5kVWZDL05CYXE1MTF5U1FPUy8wRlZmVWw1STRP?=
 =?utf-8?Q?za0NN6jmGIwG6NdIxMyr5G+sL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0661267b-6e5c-4033-95d0-08de39cd4d91
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 22:25:06.6757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lDzoNGxjJ5OS5WPCMLjBcorGBSWBMcoHsoeRxSmwklkqPQDjMBL8HjcFw3NmKlHBOD1RHYYXpkaX3FcqpO/Z5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9053

The DONE_INT_MASK and ABORT_INT_MASK registers are shared by all DMA
channels, and modifying them requires a read-modify-write sequence.
Because this operation is not atomic, concurrent calls to
dw_edma_v0_core_start() can introduce race conditions if two channels
update these registers simultaneously.

Add a spinlock to serialize access to these registers and prevent race
conditions.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/dw-edma/dw-edma-v0-core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index b75fdaffad9a4ea6cd8d15e8f43bea550848b46c..2850a9df80f54d00789144415ed2dfe31dea3965 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -364,6 +364,7 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 {
 	struct dw_edma_chan *chan = chunk->chan;
 	struct dw_edma *dw = chan->dw;
+	unsigned long flags;
 	u32 tmp;
 
 	dw_edma_v0_core_write_chunk(chunk);
@@ -408,6 +409,8 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 			}
 		}
 		/* Interrupt unmask - done, abort */
+		raw_spin_lock_irqsave(&dw->lock, flags);
+
 		tmp = GET_RW_32(dw, chan->dir, int_mask);
 		tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
 		tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
@@ -416,6 +419,9 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 		tmp = GET_RW_32(dw, chan->dir, linked_list_err_en);
 		tmp |= FIELD_PREP(EDMA_V0_LINKED_LIST_ERR_MASK, BIT(chan->id));
 		SET_RW_32(dw, chan->dir, linked_list_err_en, tmp);
+
+		raw_spin_unlock_irqrestore(&dw->lock, flags);
+
 		/* Channel control */
 		SET_CH_32(dw, chan->dir, chan->id, ch_control1,
 			  (DW_EDMA_V0_CCS | DW_EDMA_V0_LLE));

-- 
2.34.1


