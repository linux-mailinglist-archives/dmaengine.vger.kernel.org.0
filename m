Return-Path: <dmaengine+bounces-8188-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 26610D0C26F
	for <lists+dmaengine@lfdr.de>; Fri, 09 Jan 2026 21:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A99530638B1
	for <lists+dmaengine@lfdr.de>; Fri,  9 Jan 2026 20:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A25366DDA;
	Fri,  9 Jan 2026 20:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="G2syTq+/"
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013030.outbound.protection.outlook.com [40.107.159.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4228C36657D;
	Fri,  9 Jan 2026 20:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767989647; cv=fail; b=J8Pa1dRzO0PhEvbjsrTmXgb2VtxhW9twq4ZGyaJHu5iyKM5TwxmFe5orglW90H62k20qnbpuk5MppcPPytmtwy2KeANVB2IwV7rde3/wehwn4Ou6FFTomgsXFf0XV9x/zoRNdIDVBgi3imstEjZg8vqbQMdtl9Em+B2dhvwdQ/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767989647; c=relaxed/simple;
	bh=K2PNJ3EhJXaup2m1x1DnySRdJ7fnDLBg4pm6YF19bBk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=amus8LpxHSGz+F12Sy4i3M+dI3eTB1rRQS4lDHn1wVcmmWqDdo0SwT64f0oFdQk5IP/beQZ/wxU5QTf0dFihjmbR5W/wEO9QoBpXfrHepRCIw+AyNUi58rvrtj0FGtCjFhd5m3oqly1wRoItHtK7Vq0XOLfqmzDtu4rRne+VQwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=G2syTq+/; arc=fail smtp.client-ip=40.107.159.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nQAAEZ+wxeNeLS4kV0CO66DOm9mnEHFONAdZro9ZKvHSdk2exrOEEokpmDe+5F0mSG6iDHy4CwV/MY3HyWHeGpnheRMCiAhS9BdGKqBZoJSk6XMirbXOOY0aEbmNXHrI4tlrU2VeuZtekSM5YIg5AAkrEu/9ZfFZr44KgcUhJA5aT9U6Tif7X7I9cEBdodhhWDiED+Au2vpVts/C/dc6z95yMyLW1AgIkgoYT7dHcYwArY+lFMnCe6y+xs6/Gj1Wa0TORgjcQFPQmE7+POJMPLFPVPTC/HH3fwJP4Kj3+hEavQbNm3WQwRYkRP00iKhpN/RnQC7bexkHgcsMkHd4og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NkKEPcLnD1N51p/z6jw85BgBNHYbX17cSTqitB7BHqA=;
 b=CwUkl41M0zNA+etPisayGXFg+Vl9xFBnbmpcNEYh36+e++9havOsL7EkQMIJFKVi3vjonVXMW09RMM258prFIJoZfqL2InK37IrMIPISndnYCgDTp99Xc2SqWH56PmPjMTR6LeFAsOtHWRVMEvS5RVGXMO3CEmAY1nTuk4XC/mZEeEMJ8DVhQcOP3QjR9lqsNXv6KRnjAvvSk1Ll2PWFu9t/BegCUZI6WnbdNqxjSIH59saYPUNdfKTtKuuyQ4ydL1xe4C+i736SZJ8PGtEVGOc7eiEf06a7YDIw9T64FVCelAs6ZwV2W4O+vuoTiHuGvJjgDawfr83FHk4+HwJ34A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NkKEPcLnD1N51p/z6jw85BgBNHYbX17cSTqitB7BHqA=;
 b=G2syTq+/y4bcgoaSMquxwx/LU6EKLz5vJ440dOkVJWln2YsVEWpLrOJepEj0r7nPPX29eopGfRDfPX6QxyplrGSFHokIdN3C+z0fedV7IMZdp741OQohfE+DK5Rl1siWo1OuMK1AacFKBzM6D0oWJ0mWc8HINSeyDHodJWUOqhiFdyWvnR6Ka1zhhZFS81flL6S1DqyaWWpQh4yLjDMHWiUTr79/Et243ooQnsiwBtRC7ZoDtn2llqQtxXlNU+VqyMOpB27zvYSB92BejnZq2Cd7H9WPXEkAvrl76dGPS+wEZU47fhwTR1fakgF0UZJKUo2TBTnIuvVsVx8pL+3jsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by PAXPR04MB9106.eurprd04.prod.outlook.com (2603:10a6:102:227::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.5; Fri, 9 Jan
 2026 20:14:00 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9478.004; Fri, 9 Jan 2026
 20:14:00 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 09 Jan 2026 15:13:27 -0500
Subject: [PATCH RFT 3/5] dmaengine: dw-edma: Make DMA link list work as a
 circular buffer
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260109-edma_dymatic-v1-3-9a98c9c98536@nxp.com>
References: <20260109-edma_dymatic-v1-0-9a98c9c98536@nxp.com>
In-Reply-To: <20260109-edma_dymatic-v1-0-9a98c9c98536@nxp.com>
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
 linux-nvme@lists.infradead.org, Damien Le Moal <dlemoal@kernel.org>, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767989623; l=5488;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=K2PNJ3EhJXaup2m1x1DnySRdJ7fnDLBg4pm6YF19bBk=;
 b=mfXXLfR2QU5+z5m3hpWP39P3dfRCebI+4nchWUC9aoRhI0f8aDq6GJX44LAM76C3ZzWwkyDuO
 jzu0s4JehL+DFfsS5r6/ggS4NnGlfb4LeHARLFcMO019zeaJr7d0y9g
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR05CA0073.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::14) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|PAXPR04MB9106:EE_
X-MS-Office365-Filtering-Correlation-Id: ae129440-ae16-41c1-9348-08de4fbba031
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|19092799006|7416014|376014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N0xQSEdLcHV6dnRRd002TnloQWpMd0g1amhvS0YxWldYQjhMb09mY1NmQTBN?=
 =?utf-8?B?VmJnYVd0RWxRQjExREVaUmtqWUxTN3FuS0FkTXBkT1A5RGVTd29mTkNpMmdD?=
 =?utf-8?B?b3JzQm15c1dSUkhzazM3c3dPdUxHU0x0bmFZTjl5Y0U1OGI0NEtJcEdOckxq?=
 =?utf-8?B?TWdyOW0raXhNSkpmdEtCMkc0c2hUdU1yUFhvV2k0d2lJZ3Z1YmVMZGp2ZS9I?=
 =?utf-8?B?MHpFWGFld2hURXRZVzZka0h2dlNEaGd3M28rS1FaT2J1OVFnZnBOK2FDb0lM?=
 =?utf-8?B?Q3lOUGJ2SmQxQ1pKcmozUGJLU2oydmk1U2JVMG1iQ2d3Y3F6RUlsd0RKeW1l?=
 =?utf-8?B?enpTeFBEejcvdTgvUmxMTzMrM1dBTm5relgrdVp5YzhrUXkyelh2dk0yNUFp?=
 =?utf-8?B?TXMwUEFyeU0yanZBb2g5NHd5aDRiK0lsMnhRY0lGdCtZUlQ2NGZlb3hhbUs4?=
 =?utf-8?B?TEU1aGZtVkJVL3FTdVpudi9tNE56N1hFVWF4L0pDYXYvWnNnbDVHOGZxeHRL?=
 =?utf-8?B?TTJYMTdmZEhRbm8xSmlOVmp0b2x2aHhscXd1K1U5Nk9vWTRub1VCRTJtYncx?=
 =?utf-8?B?c2FyMTluV2hEK1J3Sis1cFh5RzZJSVdBZ0IySTRtZVFEVExFUUVzYmFFUmhP?=
 =?utf-8?B?ZFJBQ29zRHE2VWVhek9EZjh3bnFIdkR3TTd6d3BFTSttV0NtREhzZ0tKNzRJ?=
 =?utf-8?B?WjErdlFnVnJQZmlHK2NNWFBRTEZsZUZxTHlZMGlMb1QvWkZJK1FUbFdUcEVh?=
 =?utf-8?B?ZlVVTmw5Wm11N05SbG1ZMzYvd0IrQmRFZDdWeENoNnN1MHd4YWpUNGFZUXc2?=
 =?utf-8?B?dGovb3VDZDErSEVoK0loYm1DZzlZbTVvRzlTL1UwaG8xeldBa3RVL1FKeW9W?=
 =?utf-8?B?NSthQkFMS3pWMitHSEQ0bXJJenprZmg2bDRXTThhb0ZkeDlZbFRyMElIWDZw?=
 =?utf-8?B?KzMzd1p5dzk2VHZ1UEZLYVZISWdSWGJHREhDcUhxNzNqU2FqZnYxUFY3TDBv?=
 =?utf-8?B?OEFVZ2JhL1czU0NCQ2dmRUp0N3NSS1BHallpSmxDMHU5L29tYXU0QkxSNXF2?=
 =?utf-8?B?RElWNjhEUXNTcElodWVtdlhTeWJvTlAvVStuOXNWck03Q2FZQVpSTlVRaXlZ?=
 =?utf-8?B?S29haWhRLzgwbzhmMkpMalFscVZUMUdQMzh1WGNFbDZxdTg1dXY0UnF4SFVp?=
 =?utf-8?B?NFFBdTYvZ1RmVXZuVnVLTndubE5mYTlSRzBPVTd6SlJ0aGJEYkNiUUVWL2JN?=
 =?utf-8?B?Rzg0WkF1RmF4M2kzTW5NbENsVjhyYjdaV0xXYjR0ZnZwODdWUkg5bmorTStH?=
 =?utf-8?B?Rit1UHloRWo2YTlUalpGQitVM1lKcFZpbVI4ekp2SzBYSFpNQm95SGIwUVVH?=
 =?utf-8?B?YzdZQUdyS0NzaUdNb0pWd3dKV3FYWXhiTjBGSzN5NitORlV6OW5FYzJxVElh?=
 =?utf-8?B?OGZmK2U0aHQvcVF0dk9hSnFyRUNsMFFoMUFRQ2dvaFcyQTBKeG9IaS9Hb3hm?=
 =?utf-8?B?MjZJbHVDY1U0NHNvaE85d2IyejJ4a3VCcGIyUnRMOU5lK2NMbWVvVGFuWWhu?=
 =?utf-8?B?THVnVnVaS2Rhd2xYYmRFZ29hNURiNTJlTTZVS3RpcnoyeWR1eHhFR0xIVUJ2?=
 =?utf-8?B?WUl5L1hOM1BkY242UDNGZHdGMkUyVkZEVzNycU41K21HZU11MzVHWXl6Q1Ja?=
 =?utf-8?B?Q0drODhxTkM4M2tZYm5mRnRuVXBiRE9OM0pySmlna3FuMGNUZm1mUnlyQ1dY?=
 =?utf-8?B?UkNZbC9jN2xPaUZsUm1YSjF3bFZKbjhxYlZTQ3daalFRYnBiRGZneUYxU1Nh?=
 =?utf-8?B?ZFFPOFdGdERKd2lJZ3FUSEtmZXB2bXA5M1lJMmxuc3JjbnVhU2JLNUEvOVNO?=
 =?utf-8?B?OUIyYTQwYkpmbTJiN0Y2bmU1MTZOb2ZXMTRBc2RzK25GY2pIMjFLd0phL1lI?=
 =?utf-8?B?NGFBZ3BaTEthNitKamo2b0RHVGJYbElELzFiMVRmZHg1M2tmVlBOWS9NaVEw?=
 =?utf-8?B?YmhNaXQ5MGVvTDNBNUN1Z2JBS2k1dk4zMS9kc1IyWWg5Sk9NaFRFZ0lzOVd3?=
 =?utf-8?B?a0hMd2UyYmtpOVczbHVKait4Q2I5c0ZOL3dWUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(19092799006)(7416014)(376014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SXFyT1Q4dVRnWVRnYUlUTCtySFZUa1U4dUlPNlFsR2Yyd1lRRkM5TFpvVlRN?=
 =?utf-8?B?ZVdrTmRoRXp5V1BUb1ZKMUY5UENZQ2RUa2lUR3BuVnQvUUVxdmdKTVFFMGZy?=
 =?utf-8?B?bzJvQzZkRTVReEFTWFZwYWFpdUdwOFZQdkN1aUxxUXVnYUtVSDhONFNyUXdl?=
 =?utf-8?B?aXhoTWRPMC9UOEQveEx5VjIzeGpKTitab25NbUdIZjVrS1RCV293eGtNR29Y?=
 =?utf-8?B?ZUEzUU9UbEprcXFsNTFhdWFBMDV2ajZ5bXBoMW8wTzZwaTN0K2VkQTlKNWZ4?=
 =?utf-8?B?aFZ3REZSU01kMDV3U0paNVo5bEZ5clVGM2RwK1ZxMzgrSzJlRFZ4TDZ5Zkxt?=
 =?utf-8?B?TXByOE00NUJ2M2JwSHBYbktNMUgwQlVIWlcxMDlCOURxOFpFQW5lVUR3OHlh?=
 =?utf-8?B?dGJtRUNoaVlvTGRtK0dMTXJoMCtxVXJyRjFacGdVemFDaHBJYTBtMmpYSG9j?=
 =?utf-8?B?Y3BOVTgybm5odnduR0I4bGFrSkdiaE9Ua3BxdFJlcmtaa2IrbW1pSXR3ZUZC?=
 =?utf-8?B?TUUrUktuQ1MvbHExMGEzOWw3aXF2R1pGTldJZCtUdGU0SmdGN3U4TVE1RjVK?=
 =?utf-8?B?UVdIS0VkYXZSZlA4NVBWaXdCUWxoSlEvajFXQkVvMWp5UGRhdVRCOXc4emZz?=
 =?utf-8?B?TGVDUnZHYW5vSnRZMnFIeFFXUHNYTXFTU1hFVnZQYXV2QVk3Q3BCSHM2a29x?=
 =?utf-8?B?QldNRnVZVXRmYTZvM2ZOYU9yb3pmaHIwb1lzTUlWb05XSHVPK3V3NXNJWXU4?=
 =?utf-8?B?WmxWOEw3YmVJaisvdWZXenI0eGViMU1JUFd3ZGY5V29aOHVMUjBqRTRjT05l?=
 =?utf-8?B?Z0dwQldLTmE3dHg5NHJFN3VZN1NLd2tPZGZyeGh4d0tHRDl4OXp1THJYQmhr?=
 =?utf-8?B?VWx0bld6bHRYYkppZjh6OUw3SGF1ZnluaGZubUhoSDJkUE04VUZGS0lUV2ht?=
 =?utf-8?B?aWVhdGxtNWd3NzZXcFI2NXhUMDBtM0JKbWx5K0lNNlBreHQwRVhpVWtmRmdU?=
 =?utf-8?B?NWFVMElVMXJaU3ByTFRnQnRoV29zOVhXcDE1RmduUWRHU3Fpb2RGTHA2a0s2?=
 =?utf-8?B?Sm1FZTlsNkpWMC9zRElmc1pBNDJCR1E4d1ZlNnNZQW5RUXlTMlUvS2dycmJ6?=
 =?utf-8?B?Rk0wa1g4WXBleEt2N2xKTDFGYVBYbndWZzZqR1ZMRCt0Z1Nmem8rZS9BNWVr?=
 =?utf-8?B?eUkzejVYZktHQzdVT3FoVCtreUJTTkdkdSt5UUJIZFVZS1dHUXJZaUY5Ujg2?=
 =?utf-8?B?OEczWWp5MFdPS1F0RmpCejIxc1pLa3AxZnphREwvVHQ1MGFRTk44aWh6b0F6?=
 =?utf-8?B?RmJROEZhNEt2TGFLNmt6MHNKb2dUUHF4RVFQNzRXWUlMUFdJVG5mVUF6cFU4?=
 =?utf-8?B?TlFUUk5NTVNvbFVMb2UvUWJjNFFJZXJwSjRmZGdqcUZZc0FSbWh5SEZyQTVO?=
 =?utf-8?B?QXdoZzhQRVZLTlVkajdSU1FOc2hVdHZidGRBQUVYMXJadnlWU21sVDg5Wk13?=
 =?utf-8?B?c2lLUmt0VWoxbXZDNDJGYW0wa01WeTZ1UnFkNFpnMWdMM1pLWjloTXNpcmgy?=
 =?utf-8?B?R3ZPUHVXRE5oZGE2RG1aSjlWUlpncFpvLzF4R0k2bkVXMmQ1NjFBTXV5dEw5?=
 =?utf-8?B?QWhveGpGdFRXS2RTSHAzZ1JvYzA4eEJHWHZOUC85VVF5eEt1a3dUekMwZ1Zw?=
 =?utf-8?B?NXMxbENxNjFQZmx1b0ZkS3J1clRXaE1CeEp2YjVxQTJkRXIxbGNLaGFzWlY3?=
 =?utf-8?B?aThTZHhnTllCd3FwbDVIdDU2V1E0MXNRZXd1dXdkQ2RWbzQvTVYzZ2RRSFNN?=
 =?utf-8?B?Mkt6K2FDd2RGSGpiZTJRZmFnTGprTERTVmQxNFR2eTdGanFvTWppT2xYbTMw?=
 =?utf-8?B?RitoK0E2MytHOTBmQ21QcFgxTGQwUWNCWEliWG5TVk5rWC9DbzUyd2s1Rmgx?=
 =?utf-8?B?UHNVNVNqWElZa2hZaC80eS9OT1UvUm5BSExvbUZkMnRQTDlqdFlSRkxuTW5Y?=
 =?utf-8?B?STc0NDQvcWZ6WHI0ZVJGQU9EODNvaFh3VENNbU1uTzluQm83Sm01TXJlVW4v?=
 =?utf-8?B?TGJIWkc3QlZXQUdsYXNXdmdrVEs1Z3dZYkxlV25XK25NVEJzTHdNL3B3RkNC?=
 =?utf-8?B?ZXhNV1Q3NEllbWE0TXJaUHNjbGY0bytCVENOaHdsc29LTkZZS2dpL0lnc1cv?=
 =?utf-8?B?QkMyeUcrVGM3V2N4cWhoT2IyNm5yUXp1VzU0WXVrS3M3b2lqY2MxOXFzNFg2?=
 =?utf-8?B?S0RMNDk3ZWRBY2k3TWtQOTVQTDVnVGUxTWFOUm5ycCt2Yjg5QzVzNmJSVVNK?=
 =?utf-8?Q?3IQVaiJZnMsAkiKViE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae129440-ae16-41c1-9348-08de4fbba031
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 20:13:59.9341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DvlB4uxwgQY08NVWuLSYY8Qx6oF1JfWoG34F5KpNk4OFhipAvh9VOKr7cfTGDeRa2K0Py48x+zkNLLWYlQdl0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9106

The existing code rebuilds the entire link list from the beginning and
resets the DMA link header for each transfer, which is unnecessary.

The DMA link list can be treated as a circular buffer, where new DMA
requests are appended at ll_head with the appropriate CB flags and push
door bell, without rebuilding the whole list.

Switch to this circular-buffer model to prepare for dynamically adding
new requests while the DMA engine is running.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/dw-edma/dw-edma-core.c | 57 +++++++++++++++++++++++++++++---------
 drivers/dma/dw-edma/dw-edma-core.h | 28 ++++++++++++++++++-
 2 files changed, 71 insertions(+), 14 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 9fb7ae4001207b2ccb058d6efa9856dded379b8f..678bbc4e65f0e2fced6efec88a3af6935d833bc6 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -51,7 +51,6 @@ dw_edma_alloc_desc(struct dw_edma_chan *chan, u32 nburst)
 
 	desc->chan = chan;
 	desc->nburst = nburst;
-	desc->cb = true;
 
 	return desc;
 }
@@ -61,27 +60,56 @@ static void vchan_free_desc(struct virt_dma_desc *vdesc)
 	kfree(vd2dw_edma_desc(vdesc));
 }
 
+static void dw_edma_core_reset_ll(struct dw_edma_chan *chan)
+{
+	chan->ll_head = 0;
+	chan->ll_end = 0;
+	chan->cb = true;
+
+	dw_edma_core_ll_link(chan, chan->ll_max - 1, chan->cb,
+			     chan->ll_region.paddr);
+
+	dw_edma_core_ch_enable(chan);
+}
+
+static u32 dw_edma_core_get_free_num(struct dw_edma_chan *chan)
+{
+	/*
+	 * Max entries is ll_max - 1 because last one used for link back to
+	 * start of ll_region.
+	 */
+	return (chan->ll_end + chan->ll_max - 2 - chan->ll_head) %
+		(chan->ll_max - 1);
+}
+
 static void dw_edma_core_start(struct dw_edma_desc *desc, bool first)
 {
 	struct dw_edma_chan *chan = desc->chan;
 	u32 i = 0;
+	u32 free;
+
+	for (i = desc->start_burst; i < desc->nburst; i++) {
+		free = dw_edma_core_get_free_num(chan);
 
-	for (i = 0; i < desc->nburst; i++) {
-		if (i == chan->ll_max - 1)
+		if (!free)
 			break;
 
-		dw_edma_core_ll_data(chan, &desc->burst[i + desc->start_burst],
-				     i, desc->cb,
-				     i == desc->nburst - 1 || i == chan->ll_max - 2);
+		/* Enable irq for last free entry or last burst */
+		dw_edma_core_ll_data(chan, &desc->burst[i],
+				     chan->ll_head, chan->cb,
+				     i == desc->nburst - 1 || free == 1);
+
+		chan->ll_head++;
+
+		if (chan->ll_head == chan->ll_max - 1) {
+			chan->cb = !chan->cb;
+			chan->ll_head = 0;
+		}
 	}
 
 	desc->done_burst = desc->start_burst;
 	desc->start_burst += i;
-
-	dw_edma_core_ll_link(chan, i, desc->cb, chan->ll_region.paddr);
-
-	if (first)
-		dw_edma_core_ch_enable(chan);
+	desc->ll_end = chan->ll_head;
 
 	dw_edma_core_ch_doorbell(chan);
 }
@@ -90,6 +118,10 @@ static int dw_edma_start_transfer(struct dw_edma_chan *chan)
 {
 	struct dw_edma_desc *desc;
 	struct virt_dma_desc *vd;
+	int index = dw_edma_core_ll_cur_idx(chan);
+
+	if (index < 0)
+		dw_edma_core_reset_ll(chan);
 
 	vd = vchan_next_desc(&chan->vc);
 	if (!vd)
@@ -101,8 +133,6 @@ static int dw_edma_start_transfer(struct dw_edma_chan *chan)
 
 	dw_edma_core_start(desc, !desc->start_burst);
 
-	desc->cb = !desc->cb;
-
 	return 1;
 }
 
@@ -530,6 +560,7 @@ static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
 							    DMA_TRANS_NOERROR);
 				list_del(&vd->node);
 				vchan_cookie_complete(vd);
+				chan->ll_end = desc->ll_end;
 			}
 
 			/* Continue transferring if there are remaining chunks or issued requests.
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index d68c4592c6177e4fe2a2ae8a645bb065279ac45d..fd4b086a36441cc3209131e4274d6c47de4d616c 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -60,9 +60,10 @@ struct dw_edma_desc {
 	u32				alloc_sz;
 	u32				xfer_sz;
 
+	u32				ll_end;
+
 	u32				done_burst;
 	u32				start_burst;
-	u8				cb;
 	u32				nburst;
 	struct dw_edma_burst            burst[] __counted_by(nburst);
 };
@@ -73,9 +74,34 @@ struct dw_edma_chan {
 	int				id;
 	enum dw_edma_dir		dir;
 
+	/*
+	 * Add new entry from ll_header.
+	 *
+	 *      ll_end	             ll_head
+	 *         │	      	        │
+	 *         ▼                    ▼
+	 * ┌─────────────────────────────────────────┌─┐
+	 * │SSSSSSSDDDDDDDDDDDDDDDDDDDDDSSSSSSSSSSSSS│ │
+	 * └─────────────────────────────────────────└┬┘
+	 *  ▲                                         │
+	 *  └─────────────────────────────────────────┘
+	 *                                   DMA Link To Region Start
+	 * D: eDMA owned LL entry
+	 * S: Software owned LL entry.
+	 *
+	 * ll_header == ll_end means all own by software, all previous DMA
+	 * already done.
+	 *
+	 * Software at lease owned one entry, all D is impossible.
+	 */
+	u32				ll_head;
+	u32				ll_end;
+
 	u32				ll_max;
 	struct dw_edma_region		ll_region;	/* Linked list */
 
+	bool				cb;
+
 	struct msi_msg			msi;
 
 	enum dw_edma_request		request;

-- 
2.34.1


