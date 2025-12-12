Return-Path: <dmaengine+bounces-7596-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C397BCB9F03
	for <lists+dmaengine@lfdr.de>; Fri, 12 Dec 2025 23:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EEB0C30EC096
	for <lists+dmaengine@lfdr.de>; Fri, 12 Dec 2025 22:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BBD31195F;
	Fri, 12 Dec 2025 22:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SHLqP7BQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013060.outbound.protection.outlook.com [40.107.162.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B0B30F927;
	Fri, 12 Dec 2025 22:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765578387; cv=fail; b=X/0XbNmJuati1EP1D3kArLJBeRxQiaptEfcSqKModg6yqutqh25QBbI1nzSS//pyJZ9Cl1GdGl8k92hM6SbzVSP82wzRKgohePPgESsQPaEgzY6iEwEnEI0TmuIAHkyvs/vfOwfcNTVH5+EtmE6weT63K5eQexrgQf/0LF3ND+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765578387; c=relaxed/simple;
	bh=u7fTulRfZLwNK7ZgvfmFeAzMaJKinGgg4N76uOfzuY8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=V9eIOIvqQvSW2RhI4iE4HuzjQmtU5yDPiW3aBVagKMzYEh3teOc9uZU4Rb+xft5uftQAATyKAK/qfTgxUHjeo3VlokassHc+xcPL3qnqo/fOKw/0PSxBfY51MOmIlYAzQ0dxSo+GM//IFAocP5+VcV6Q4XNXUhW1NvJRWiMBRMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SHLqP7BQ; arc=fail smtp.client-ip=40.107.162.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eTrqkaZvQ6vSavb9VaacnPqpHWQDcbmT6YW5kXcOHk6f+OWSpeb0Wm1N7abFwAmDxlqQWyHZMwpg0EZGE50DDzlIN/KM4qLdDOygjzLS/GSC1PqrRYjwF15bQ4/El+q3XUUS3AolKuUexPFT3wV/WTVDVLL/1Pex0zudwIAHva5davzwjtUKXDE8Im8nb3GMfJJ5gzMj9yU0co5i+lOQ6ZQaRfD0YjNJfMnAEMGUs1OZEgOq+pYSktPtMC4uiFMQUur2A5byG2HqgIO2PqHNJyrJlG0Zhg/VnrjhdZBJy0DjdQB4dxi894XuC259GSueIjmvZP1MaDb/N13CEurGBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9rMUD93gy7BrF7Il4uhsuLbNwmQYd6oq2LiS0QYxwcQ=;
 b=Gz6ATqEsQo0ArZOH4rZb8256ts5xyxB+fSq86mTSmT5ucLufpLWrJDy7djt4O6S0n6CKy0Iln+lEcuj/27aLn7g0eqwjOp5MAg5yR7wSBt2AnioeJaeBhYrcxxlWE9yKfZVUhGYIfQWCkDaqsSRFE1rsWOOHhsogXFiYwZGn7ZQaZO6a86QS0tZNLhKe7hFmu3x0vZ9u7/p5rlV7YtWIzEGAwSBHVuGQeQY4pnGHiw5ULW3DpkIEjMAZnGT5caxu3Ejj62So+jOhVAn/E+5gIiMZ7xBHSzoi58YKy3FQ4sGL0p3yZFPwGrNEISqKOrqJXG5uFnyFdNP3xSglWWSETA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9rMUD93gy7BrF7Il4uhsuLbNwmQYd6oq2LiS0QYxwcQ=;
 b=SHLqP7BQ9C5QGQouEdTH5rLoV+IlSDuYQhsAQqxkEr4lUjrCdYpMp8N1fTS9/am2vmaR4YClpDwW0YOH1e9we/UpG2hBUKeIQVuuAfOxsyL6lRRNiVrF5Li1GiPVwXihU+xNZlUsf0G4UguReG9fu0P4i6+mRs0ggAgiuZlR7tQK/kIwK5MVvXsLPkByIge63kWjcQTX9SP/6NMBGrpLIdcSw+RPTZQyXaywoN0lmqD8FTo0JCQ0lSKMByfKV6t9TLAJlmbb4ldEPJjrMwtxn2/Qvq/j8kbTSYuMfJMM6A/NjJlAY1EhhjzS58Vv4QQjHSEBMg/4KScdp0+ZLUFPXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by GV1PR04MB9053.eurprd04.prod.outlook.com (2603:10a6:150:1c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.12; Fri, 12 Dec
 2025 22:25:19 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9412.011; Fri, 12 Dec 2025
 22:25:19 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 12 Dec 2025 17:24:43 -0500
Subject: [PATCH 04/11] dmaengine: dw-edma: Remove ll_max = -1 in
 dw_edma_channel_setup()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251212-edma_ll-v1-4-fc863d9f5ca3@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765578298; l=1428;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=u7fTulRfZLwNK7ZgvfmFeAzMaJKinGgg4N76uOfzuY8=;
 b=aCMiS+oVmdZLMK+hpyWUheeU3gu9xf4xtKr4BuQ0TOPIUx7FHRkLHRNkX+HzF02oca5II3d0G
 GGaFG/7kZrPBcojVtGALUUunwwGVcA1Xdr6K/fEQazmZiW+03hhfvmd
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
X-MS-Office365-Filtering-Correlation-Id: 6172f0f1-f9d6-4bc9-b1b8-08de39cd54af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|7416014|52116014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T29pdVRPTHpqRDFBanBNOGZqaFQ4QzhsZzJjYUM2V3NNblJCYURDTDBFcGJh?=
 =?utf-8?B?NUVTTzA3ai9MYUgyVzdsZWV0cGZaU0hRVkRkeGdkcWc3eW4xTkhvWElRS0Nt?=
 =?utf-8?B?dGcwcjB4U1NNSGxLU2laOEc5dGZ4TXh6U3hqRjErb2xPRWgzd3p6QVFkOFFx?=
 =?utf-8?B?K0ZoUTJSdkZQMW9YZE1GRVo5ZTlXTWtYeGg5V1NJREd5T0RwUEJGM3NVVGkw?=
 =?utf-8?B?dGY5b2dvSzVHdjEzR0xPelRxK1FxZmswTkw4eHMwSFRPYnZwWU5oZFNxM3g2?=
 =?utf-8?B?akp2TEh0bjRjSlJjb0FZRFFBbm5sMzcxakNzYnUyTkw3bW1TSTZpMDJ6LzBX?=
 =?utf-8?B?VTVwTjZFVmdqTHlQRkRsK0I3empyMDFzN256V3hZcGZKb1dLcDRNd3BKbTBH?=
 =?utf-8?B?MEtUdXNWbHNwV0RRZ3pqU0lLR3dpeGpmQ2l1cWRXQUZCY1BjZjdjOGQrdFR2?=
 =?utf-8?B?Mmgvd3l2SklDWC8zcjJ0Y1hQWW9pK0lkRWdubVhvd0YvUjVzSGUwYXE5bGkr?=
 =?utf-8?B?SjZkL0w4aHlmN05yazNESHpteDBBVzg1QVgzVGlMRk82ZlExSjlsNVljdnRt?=
 =?utf-8?B?UjNHSHRpYmNsOE5ET2VsQnRLcTBGaU9rdWo1dU45MG0rOU5SdnNHdXcvQ0hS?=
 =?utf-8?B?SW51aTQyeCtxWCswQmdmZ3IzTWhzQVNYU2RrZUlLL0VDcGJ0dXVxcVk1UHhx?=
 =?utf-8?B?M0l1bUlud25JWHRYTk42a2FoZUxlRnZSMm5ZSHN5eG5nY2xTcjZFTWFNU2Rv?=
 =?utf-8?B?MjhDYzlkTEVSalJSaDNFaHJFc1ZQcXZEMWYyZHh6a0gva1VBODlPeXdqTGFx?=
 =?utf-8?B?c2FDa05mUlQxeUpuSVE4aFdPdmFIOEJKRURMWExGalM3Nnh6UlhHOC9jeVNS?=
 =?utf-8?B?eEJzMUE2akxvbkVRWkZoejBCVE82M2dIRWU4OVNRUmFSVkFLQ3BPUkUwV3BJ?=
 =?utf-8?B?dS8yOG0rNGk5Y1NxYitwQ1d4N29BU3o3T1dST1FORVR3M2dZR0FMamFURndR?=
 =?utf-8?B?cjl6UmRacmJrZnAwM1ZDUllmaFFNZlN4dTcvTXV4VTB0cHp1amlnNi8vTWUr?=
 =?utf-8?B?MDJqRFduUXErODR0NDN6Y3BTaUN2QS8vMm5HVDJBN01yWUI4VlI3QWhYUEN6?=
 =?utf-8?B?NkkvVlNBcjd5clFZNGZaZHl2T05UamxJR2JsckdzZWNEVlpGRllDT0QzN1Rh?=
 =?utf-8?B?bWI2bjRMRUlHQVhIb3NqVXFRUFE0VnJYdUxXc21FNFprNVdianZJNThoT2lV?=
 =?utf-8?B?ZGlaYzByc1kreERaWjQ0elZjTnVYUG1ncnVzRTUwNDJQSEZZZFlaamc0azJU?=
 =?utf-8?B?Zk1rOUc2ZlNMQzJzRVJtTDRZRGMreFllNXpsV2N2V3R1aTJJN1pEeUlQb1JY?=
 =?utf-8?B?V0VxMlppTStXNFZ6Q3U4MWhsTXlkdE1DZHRrZ000ZlBpeS90MHdaQWhXYWF1?=
 =?utf-8?B?a1pmV3QzRlU5azM2TGlKOUk3MWRvT2xmVUthbVdkM29mT0cyTElmOUVpb0RI?=
 =?utf-8?B?dlVCbTJMY3VLVVZDR3JJbzdid3VKY3NHM0h2bllQQ0RzT0lINVo4cDBzc1Bo?=
 =?utf-8?B?Qlk0V2JmU1JVa0doNGM1ZUV2YVZGak1mQ2tyb1lyYlIzK0dyYnBnQzR3alBh?=
 =?utf-8?B?M1ZCQ0orMmovbHMreFB4NU5NNzNUM1B3dTdBbXVteUZ1NUFJZjdMTmVoUEFk?=
 =?utf-8?B?dzZjMVc4S0txemdnTGZQL3J6N2RiMW0vTjRrcnI0NDYwMko5RzZpZUlSZ3Bk?=
 =?utf-8?B?aWlxMlB5VG1SRFBxaW5hdDZrWFM5MW5pU1FJeHVVWWY2cDVldTh3YXNlVGkr?=
 =?utf-8?B?SDlVTjEyMVdGbUVwVEN3ZSs3RXhHVjgrZUorNXlBYXZLNDRUQ3R4UTY4MG9q?=
 =?utf-8?B?WmhCOVVuZU5DeG9kT2M0eGFJcGhtM3Fibm9GTFpKSHMyYURHS2FhZXBkS245?=
 =?utf-8?B?RjdiR2FPbEU3di9MNUR4MUJ2c00rakVYdWtYUDNsZkxRQU5rRXNld2taejVJ?=
 =?utf-8?B?TENyRUNic0ZTYU0xQjR3UXhNTXpHRlFCR3dUSGhiWlNEZXJvY2tBU2s2VDVF?=
 =?utf-8?B?Tll3V0pGSGtyMzl2V3hLVFhSN2xxZHFycWIzdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WWsvL3RPQmdURTNyeXQvSEtrb25Ma3lZaFZ2OEplcHlqd3JUN0E1SGtpMDRU?=
 =?utf-8?B?cUpMcktaN2lNL3pLbFltQzV3dDNBeERLOENpVzZjVkw2bWNEcHM2MVM2QXpm?=
 =?utf-8?B?Sjl3cEs3ZnU2dEt5eTBaNis5ZVhIQ3FHNnl3a0orejZwazRRaFJ0Z05XZk9x?=
 =?utf-8?B?bmRzN1R1RjRDTU5rRXZPcmhaV0w1MDJmN3VFQTM3eDYvdTZUejliR2d1UU9R?=
 =?utf-8?B?K3lWNG4zWVlFRzVJM2huT1BTeHRMRnFqMnlUWmxVWDF3YndtbWY3QnM3NXA5?=
 =?utf-8?B?NXdZbm9HQ1FYNmdzTXI1QUJoUlo0SEwrK1ZxWWFxcWhIWEN1RzZHSWYzYnhK?=
 =?utf-8?B?SnkzK3FPV2k4U0R1dUF1aVNFakJCSG42QkpEWEFqVC9YYmdZQkJYVUtEUTRV?=
 =?utf-8?B?VG10TnJROU5qZmRJYVpDQ1hhcHM3Sllkd1JMNW11bWJiMVFqc3ZRZ3Q4Z2dL?=
 =?utf-8?B?WmhmbzN4Zi9CbmJwUEYxS29teThuU1Y3VExySkRJRVVrV016OEpOTlh6Tm1n?=
 =?utf-8?B?SEpPMDFnSjlOcDE3Y0w0V3NQU1FKRzJaejRaRnlBSUlaS08zZ2F0M3lLb1pX?=
 =?utf-8?B?eXVPcURSb0daTnRrbWtCYnJaa2c1N2tqSzF2dVRuZ2pTM0hDRm8xS1NiZDF4?=
 =?utf-8?B?VFFwTFE5cnVDYkZ2bC9XVGIrOCtzc2t0RTVtZE80WUlHSVF5aU8xSHluajhm?=
 =?utf-8?B?UzdWNzFPWjVPN01uQ1dSTG1sdUdQd0tHZ0Q5ZkRYa1k2d1lseWg3WTFweXlF?=
 =?utf-8?B?VmFtOFVMcG5YRFBLVkFCNU5uZk1qRWwzWG91d0Z1aE1Ic2lNRWVWOVgwaElv?=
 =?utf-8?B?MmZYcmZvcnF3Um43QTM4dFFjNVNmbmF4RXJIRUFwRlhZSnhQOW1qR291anUv?=
 =?utf-8?B?UkhBaW9BWTZ4WGtOSFlOUzlwQzdNc1JtVCtWUDY1d0RJalJGN2lPMllXZHdU?=
 =?utf-8?B?ZlFySVE5RTdpTEJDRWNlVDg0OGRFckQvd1ROdFZJWUI1dStwa0REbG5lSkkx?=
 =?utf-8?B?NjRKdDQ4aSt0djREQzREallMNk1tYTQrS2JVV1Y1Q2o1ZERGREVxVmpOaUpB?=
 =?utf-8?B?NHNYck04Z0lrTWRzaUhUcjMxdkhuZjNFNFNyZ1loeUpVT0xZVUZRelRSYUZl?=
 =?utf-8?B?ZUtCbFJBdTRLNVprUnVXQ3plSXBlYU9MVUpFcDlVcmhpWFh5ZjBadlp6SXc1?=
 =?utf-8?B?ZjZybXJXa0NRVHhjTkx6TEh1UlVVUHd2RU5kZWtWZWlNMTVieGFneUYzK3RS?=
 =?utf-8?B?cXdLN242Z2R2YTBRcjI0eTZzN1l0Zm9IMmVDTUJ0d1ZabFFXVy90bFREQ0lQ?=
 =?utf-8?B?Ykc3UzFrWGUrVEpGdDk0UG04U051c2taTnhrajJyYzR2bnY0RThEaHVJOEZk?=
 =?utf-8?B?azBYNHk4UllZTmI2R1czTk14eFlGRVk4K1E4Y0NPOWVTMlYrclFJckFDK3Jv?=
 =?utf-8?B?eGllWHZzSUlYakRjcjI0SkN5N2UyNittMnA4M3BHNTVObnlJeXp5L1JSemdB?=
 =?utf-8?B?bE1Lek5ZanpWaFBvUnlobmlEYTB4OEIrNCtPaGhzS1JSVWg4TFREMTJLUXVu?=
 =?utf-8?B?d3htVWphbk5PL0RKTWZ3VVVUWkRIZEVyRWNUYmRQTkJLT05jVGdOYm1iOEpL?=
 =?utf-8?B?bmV2c0lPeDZEdDZURWphelBCRWVXdnc2NnhnY1FKUU81Z2ZOVGVKMjJXSkNL?=
 =?utf-8?B?VXhPNG9MdFJmMk5qSkZZSEdITlUxOEwyTWM1WUlMcEtLQW9yQWtEazd4bDQ0?=
 =?utf-8?B?R2s2dUQ1U0NSYUxMUDdRUitBVGhuQVFmSWRqS3JSSUxxY0EwQ3oxcmlJdlNI?=
 =?utf-8?B?Z0hlbThzRG1aSU1vYU1UZ2IyL0xOUFJVUDVoRXRIc2VkSm13VlVXb3hWNEpW?=
 =?utf-8?B?WVhQTmtqYU1sT1owL3MwUFlsS1hIU1VHNjRlSFBxVDB2ZUJtSzBlQ3dBK2s3?=
 =?utf-8?B?YmxSdENlWU9vNVJWdGxrdUVOWWlnb2NzancxMzdLSlhTTFNJcUZJanI5dXdm?=
 =?utf-8?B?WC9aQ3Z1RUtiWFJBaGM3ck0vQXhlNjdISjY1bGNLWU5EMlhzYmIyaitlb0FL?=
 =?utf-8?B?L0JkMTFrSHdMNzdCTEgrUkRzWmRzRmQzSWlraW1HRmY1dFM3NXJkWXdjdmFk?=
 =?utf-8?Q?XF2E=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6172f0f1-f9d6-4bc9-b1b8-08de39cd54af
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 22:25:18.6097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KBVUY2SRCz8igzFHPrGuGgl0V5UakjlXeRDrq73UGCvtJzMCB4Xb5krz/ifN+dLsR2SRcVzycAAJbNg6CTe+Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9053

dw_edma_channel_setup() calculates ll_max based on the size of the
ll_region, but the value is later overwritten with -1, preventing the
code from ever reaching the calculated ll_max.

Typically ll_max is around 170 for a 4 KB page and four DMA R/W channels.
It is uncommon for a single DMA request to reach this limit, so the issue
has not been observed in practice. However, if it occurs, the driver may
overwrite adjacent memory before reporting an error.

Remove the incorrect assignment so the calculated ll_max is honored

Fixes: 31fb8c1ff962d ("dmaengine: dw-edma: Improve the linked list and data blocks definition")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/dw-edma/dw-edma-core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index c6b014949afe82f10362711fc8a956fe60a72835..b154bdd7f2897d9a28df698a425afc1b1c93698b 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -770,7 +770,6 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
 			chan->ll_max = (chip->ll_region_wr[chan->id].sz / EDMA_LL_SZ);
 		else
 			chan->ll_max = (chip->ll_region_rd[chan->id].sz / EDMA_LL_SZ);
-		chan->ll_max -= 1;
 
 		dev_vdbg(dev, "L. List:\tChannel %s[%u] max_cnt=%u\n",
 			 str_write_read(chan->dir == EDMA_DIR_WRITE),

-- 
2.34.1


