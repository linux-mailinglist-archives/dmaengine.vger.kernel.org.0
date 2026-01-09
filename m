Return-Path: <dmaengine+bounces-8186-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EE581D0C25D
	for <lists+dmaengine@lfdr.de>; Fri, 09 Jan 2026 21:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91B52304281A
	for <lists+dmaengine@lfdr.de>; Fri,  9 Jan 2026 20:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B418366DCE;
	Fri,  9 Jan 2026 20:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DYLmDw0s"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010045.outbound.protection.outlook.com [52.101.69.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A862E6CD3;
	Fri,  9 Jan 2026 20:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767989635; cv=fail; b=n8I+w/0LvfFGb4KnEv0qlpBHRbfg6Gq13y/FueZ4KXiQmMLfwO77pDWG6Rf31R6dddnCpPNEKGIw4raOiLVs8bQ5e58bEwwgOggjK3ApJtx7ETqZGvgtWFFbsrcDpABEhNAWmjIFTLdR+yM36zUabgh2lELXqVo4mNYZAAf3IPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767989635; c=relaxed/simple;
	bh=4ZVUajLNstFx2H3uRPcCy+DiRplt4onopXgt5uMOmBE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=kWuGncNVMwc577x/6qtNMJy+2Xaa22kU6xymx+0jJebVt8w+PZBEh4Wz/mzbQ6R/NRdBvpilSfPKY1R8XojDiYq53xDwx583E8vLpeWOYLgPVn+1JntKUaXVKn7IeFwkDZ7OjRFBBwbKIKf/LbKdB/WZC9a1Cp5yrJVTeoXBWx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DYLmDw0s; arc=fail smtp.client-ip=52.101.69.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P56h6M1bE6KpFncBnzK9SK6usgsJKvzGIE7TCBK17XJOfhp4DTURTrIAqRaDr3T5t8ZKesStd73o/WRB0v5yfzzI6lTBLaFGHtZAcybG4zIlHf/h/M63uMIVOwB7HqraP6VL40sfRidk+Tjqh5xpybvROHvDkTSgSodkwXaZKp8Z4Bv78wfqVYMsHxcKSBoUhNVkCc8ZlM1RGXv95eZgkAfUHNFrBlFtq3gky2Th7tl4F2AmyolaTnscyQKYumEyUtb8vx+CakDfQBXHHbSbxhUZ8cTl2LGnDrARM7VpC5Da5uFNt3DkOsCOqLKHKQntQxfr5AFwKO382tTexfjL4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ebyJ6iiOfs17P0AfxB06Nwo3X1VoAbPdKBiUh2PhQTY=;
 b=kOILy0EaI3zpKwNVMsROCxCmapHA/Ss66sOTJpkpmLbRRj2y1tcOePfZVdUXyfrTgtWIa51q9GvG8DjH8g/dSv2jKjamGqRurDker5Rk4NBvVhJNXTozQOFtUDrw8p9TdxRNByBpQpDQ7d7+OYTCQ1R6IC6qKqD6kemkkirzS3V2Yy+QqxBdGb+peCUmCCyn9Qy0fH+XpCdgIOXBKZKlQaDSRR1BHbg9a6Zdy2xBnKWgd/Rp3wnFX8zzKUkjkvn4627HDYsbQFfIHAuMrJNZWHuFVw0aFBGvwTVfxWW5T4bOPkGf7RjWgVLiebK5B5qClspnYN5NoWoz9azb8620RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ebyJ6iiOfs17P0AfxB06Nwo3X1VoAbPdKBiUh2PhQTY=;
 b=DYLmDw0sdGyIdO07NrpXLa6ESJpRmivxBV48mSq07N+/6ns5bKlowG7og3pGj8/Lv/UVXQXhDwvcTTYmgrtODXrBLpF1UqWIlDRSNUnQMQMtEQVbVhcF60SWBeHi6LwXjnmjP3tUaG+Up4JPFlsW8BtCmV9FcOoR1iTw2iFQXbw/PMY4ODgO+eaHWXbTML17/eLQR7rN+Ih1WSR07nDeX0n5OTSgu9w4Gs4VEP5E8MMFa8b7Bvj3FOBdP6Pj38Z0335eRqVlZzeBrQNbh+HPYRm74BXRhUQViVi+y2uIGtCglVSfji2B/Hjl1ks0HHkqBm2ErHP/f+pJIt0y1zCMlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by PAXPR04MB9106.eurprd04.prod.outlook.com (2603:10a6:102:227::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.5; Fri, 9 Jan
 2026 20:13:51 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9478.004; Fri, 9 Jan 2026
 20:13:51 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 09 Jan 2026 15:13:25 -0500
Subject: [PATCH RFT 1/5] dmaengine: dw-edma: Add dw_edma_core_ll_cur_idx()
 to get completed link entry pos
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-edma_dymatic-v1-1-9a98c9c98536@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767989623; l=4348;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=4ZVUajLNstFx2H3uRPcCy+DiRplt4onopXgt5uMOmBE=;
 b=Asy/pkjoBW3Af1g+na56/i0tgc/u/SzUSDj5xGO6bYDx8Coq0A3C7xI8uw1w9ItFmMhFMgfH9
 dv660R6mBNFBKgUtuXyfN/mP3txnKqjMEVbrXVRHzJMsZLq3rKs7vGU
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
X-MS-Office365-Filtering-Correlation-Id: 346ac84f-bbc5-4bfc-746e-08de4fbb9b4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|19092799006|7416014|376014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cktmdFRnSTlXVXZLVHh3Y3p6Ykp6Uk5LUWo5NXlNWUJmTTdtZEk4SkJieVlQ?=
 =?utf-8?B?aXFKM2N6UHhOQTNPbnFIdzJBdWQvYWlWKzRXU0VyR1VBdHd4Q2lpVDFTUDJx?=
 =?utf-8?B?Uzcva2JvZDhSaHRnYnh2OVppc0R2UlhqMzlLK3FIS2pGTEk0eG5leUJsaFE1?=
 =?utf-8?B?ZmZQWnFYaDZvekRIMlhxcHNKZ3RaczhBWm1wODI5RTdNR2cwdi9ObmZnYWZ5?=
 =?utf-8?B?YzB1SkJETElydExlcjl5K0dZdU1wNkQwZGxjQ0Q0ZlNOMFl4aG9LYVIxd3lk?=
 =?utf-8?B?RDM4YlJ4MUpqem5LakxQbHZNZThSemhaWlZSN1hYWVhENEcxcmFqR2FtaXEy?=
 =?utf-8?B?K0pIcnNGT2M1ZEN5T2lLcWZIRVVQU0wxVUlQcEtMcUVVUGNoM2dPRlU0Uzl1?=
 =?utf-8?B?S3VlaDNNWStLWVNnMFAwaWdlTUJNTVhaZVFaUHFDUWNHWWIwWmwvVHZBbm1w?=
 =?utf-8?B?M2JtSG5wRzlHTWxIY2l6TVlzUEluNlpDbExVU1hkVlBRaHNkM2NrM0oycTZW?=
 =?utf-8?B?blV3UTFISW84OFVBV1dybm1mVHZ4a3lGVlNjZlA4OXl1cTAxUlJsWUk3VjA3?=
 =?utf-8?B?S0llbUQ3N2grc3F4Qng3YlB5YzhsbE5PeHZKYXFINHg4SHpSaUJJbEZodWxC?=
 =?utf-8?B?NWtqa05UREJVZHVHdXFwUlh2T2Y0eWxadTVrbjEzZzF1VnZyaWxyNlhUa2U0?=
 =?utf-8?B?RGtoT3JZNkhUWFNNWUZSNjkrN1NmaWxEU05HUEJ4ajMyMHc2UWtaMjdvcXFS?=
 =?utf-8?B?YmsxUTN1djA1aTc3UlpIMzFOcGdvQXVQTENkT3g1V050VndHbUZOeHJhTGhR?=
 =?utf-8?B?MlRtdm9UdUtDRjVvVVlYb0FSKzRqTXhVL1ZVWlE2Rk00V09mMXg1b1Z1ckdO?=
 =?utf-8?B?eUc1cjAycVNGdXRKOFVadndodGxHZ0V3bUdRQ1N1QzRsWFJYTndaQndrVTJS?=
 =?utf-8?B?WkNsOWhxQ2toZlpOSUVQQnlQTXd4RkkrV2xmSThKUTRWNnNvNlJST1FaQ1Zj?=
 =?utf-8?B?cUVLYW82TWVzMENReWxoQ2xqVzlmcmFSQmczS2d0cjE4R1JnQzlCNmMrQTZD?=
 =?utf-8?B?R01zQ0F1cEVuWTdkV0NKeFVrb1puRVIrTlh6SHdPNHRacUd6bDNhLzgwZFNE?=
 =?utf-8?B?UHNyOVd5Y2NTQTFmdjVBNTU5TGdRUmk5dGc0eTErVFF2NnppWGM1UWxoeXB6?=
 =?utf-8?B?TlVySDNjb1JnOVlFMjFraDlzUTJtQ0JPL0pKTVc0VVhHRmxyNCsyWkE0MldS?=
 =?utf-8?B?TGU3aUU1b0l0MDAydnR0SmtKalEzUGkvazFycG1lb2JjNGFLdVQzZGtROCtj?=
 =?utf-8?B?V1JiK0dFamNjb2RoVUlrWlk3b0ZTSlNHc0xFVE81dXEzMVBiOThtbUtNK3Nw?=
 =?utf-8?B?WHdPR1dqSklpZHVIVWJkeUtNeG1sOElOeFVpbnFCaERITkxFZUJtNWNUck02?=
 =?utf-8?B?S3RHYTN2bmwvTVJzK1Z0SFg1RHJxT09vb3NiQkljZEFpbmUxczhRanpMcitM?=
 =?utf-8?B?WGJUQXlpamFxejJScy90c3E5azU0cW5Od1h5QjU2VDVNREYwSXNSRWUrZUUx?=
 =?utf-8?B?RnN5MU1saGFPN2hCeURWb0ZzblFKeGVaVGsySHgrMnY4azdEL1VKUkxrd3Q0?=
 =?utf-8?B?am1lKzBuU0tpZ2tMa0g4SjdxWlM5WnJTSDVIY0lXVkdMZklGYUt2S0pndXNz?=
 =?utf-8?B?eExaKzIwTTZzd3FpbHFRSGxnV2o1bUo4NUhiNHFQNnVBd0RwUlpQdUIvR3Zl?=
 =?utf-8?B?bFRDOElnc3pCS3p2N1k3MktkWTQ2aVZCM05qSnpHTkJRTmZhbTBWTWs3Mm1N?=
 =?utf-8?B?ekNURFZHeEZIUDk4SGVnUmRnQ0VPdmZGUk5jUzBYYlZCcXQzQ3VMcUlubXhK?=
 =?utf-8?B?ZU9rTmNaMmlIZVRyUXduOWlIWS9xeWdIa3lsRkdOZHJJMHBWbDN4NjhmZjFv?=
 =?utf-8?B?aVVuM0RvaElSYzZpY3NLQjQxQWtBVTR5TnFuZUNwSlp2T2hoN1BUUW9nNHQv?=
 =?utf-8?B?RXZRdmROR3lMWE9IL2xlaWVROWdPTm5kZUdUcVBsbmNBcGlQUytVR0JoUktQ?=
 =?utf-8?B?YUdSd0ZlVWlVUTJVd1pLcS9tV1hhRXpPMSs3dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(19092799006)(7416014)(376014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aVVTUENDUlI1Ungza3FEeXBRK1lTZWdYMUZ3S3gvQnpCcUlHRmgxUmdyVXRF?=
 =?utf-8?B?VHNLRGpibWhNSmxHanRvbDIvZjIxUWdNUnJScXZEdTlYaXhkUVBuNWU5Um44?=
 =?utf-8?B?dGpEQTFmSTFMaVNySkxCcjJUeEsrTEJ5SmNSWFlJdW1PTTYzM1lZS2tpM01z?=
 =?utf-8?B?WTNiUVhoQ2ZJUW1TbG1pMFUzTk9tZGlMU04ybmVhTlQzYXVRRkwxeDZRN3Z5?=
 =?utf-8?B?T3ZqMUR1MlVzbDFPYXdNTEhlRVpCVytiR3pWRVN5elN3UU43MlRaQ3JFRHJk?=
 =?utf-8?B?a2RWVHdzOTFYUEFGY3JiVkNJSHQrSFdvRm00VmxGNmNJUnFqWjRTQWZLWVZU?=
 =?utf-8?B?SWEvZUxzcFQ2SXZHQjlMYVlXMkt3R2dPL3VTS012RzgwWUVYZ21TT0hXelpp?=
 =?utf-8?B?WjZ5UVpJbkRPdXgzUDB4eU9ObGRvcHpsTndmVnAzeFVmUFZGMVRtcTRnL0ZO?=
 =?utf-8?B?WlpTZXRTa3I3S1NPV00xQmRLYlh0M0Y3dCtsN1ZiaHIxWHJxRmZHaERKTTcy?=
 =?utf-8?B?TGVhb1k4Y3N4SG1Od09kVE9QU21vNGNqbWpHYkhuWGkxK0hXenF3dFlUWml0?=
 =?utf-8?B?bkNQem9hTTcrcHVKd0JyUlM3anZaN09qRXhrK1NicDdSbDd6Z3ViRlRtVi8y?=
 =?utf-8?B?UUFkMXZJdDEwWGNQWC9UUXVSeTdlYnRiTXFHdDc2bDZkYVQ0OHVGV2FSMVl1?=
 =?utf-8?B?dU1lYWo5YjBuMHRZUm01eUFBZVVWZ3U5SE9JY0tndGlldHRNU2ZLdjlWbWhO?=
 =?utf-8?B?c3NpdUNzYytVZ1Jzb3dsWitabUFhT20rQWVnQ1ZjUkc5RnYzSFowQ0w3TURE?=
 =?utf-8?B?UU0vSTJHMHd2SnNMUzV6WUI5emNVSERLL3BnM1IvSXM4eFZ3VnFKT0ZyM3p4?=
 =?utf-8?B?OU9QREU2SmVMWVpITkhJV0ZSd3dzQmgwdHByN29QUFhjcXF6bmorUkNZa1JT?=
 =?utf-8?B?eTF1OE1SMUYzbkJnUzZlM2dIaEtXR3J4a3lJNXprK1BTbFpJU1A2R25QNTkz?=
 =?utf-8?B?QkFHTTBweUJZVmlTa1BsaURHekFqOHVKcU4vb2Yyak9MWURoRU5oVi9PdlJL?=
 =?utf-8?B?V2EvUTJBcjZ2MGt4Nm1JZE1IdkFRUER0eDBxeStQeTJmMDUyY2J6Y1ZuUXFs?=
 =?utf-8?B?NlI2WllBc3RWVWI1dTNsQUI2SFkrTloxOWxHc2RXU3cwRHpQYS83bFVGTG5i?=
 =?utf-8?B?VWp5Vy8wbHZVbFhIQjRwWEJMK014eU9zYURFaXFmSkNSYlJ5MDE0MXVCL1dK?=
 =?utf-8?B?STM5K2k0QmdLOVRhNWtadlUvVDV3QWlBUHBTRFArNzdmM015RldSVVNTNHY2?=
 =?utf-8?B?UFJ6c3RKMkdQSGlRNXYvckxLN1JxdEpYWEFyKzlQS3B3cUVWcDlCTGtFNmRH?=
 =?utf-8?B?dmlMNUpQYlpSUE1DckI1aG9kYVk1eFhUWFVwanp3YUI5TzgxTHZKUTJSK3c0?=
 =?utf-8?B?SkdoN1R4SWtIdFhIRG5SY1VIV2t5Ny9OYVkrQTJRbEdWd2JGOEYzQlFEdFFK?=
 =?utf-8?B?bE9tdTBGRTdCR2x2V3pKa1pha2IyRjQ2S2FvMkw0bHlRd2lWWFdoaXQ5d2Vl?=
 =?utf-8?B?aFdzZUp3YW9uTzZLbjRJeGFNTW5ya0FNTGlZUGZpZHArdE0wTm9MY1ROQVhz?=
 =?utf-8?B?U0Y0N241MGV1Z1ZPODZ5SytnNE5YTlh4SlZDTndpN3hFOWxRMzVoMTlBSEww?=
 =?utf-8?B?UzhITWVySlRKVG5uSnFlWkFUTHFMVFB2N1NxWVBqeXJNYmFQUFltL05SNHNt?=
 =?utf-8?B?T3FWUHRlR2tWTjNjM1JyMlZLeW8rTWtvNUtTakVJTHVua1lSNWhweFNnV0tx?=
 =?utf-8?B?OFRDaXJOTjZCQnlxSzNnelI1T3FkYnhFWDV2aU5mUVJsMGxsenRqU1ZoMFhC?=
 =?utf-8?B?UjJXNzI1b0hEV1pQRnNIYXVaa0ljeEwvSjdnb3dOeVUvN3BZYnZTVFRDS3ll?=
 =?utf-8?B?b0RvTE13ak9xUjhuWVIyY3pIM2pwZDl3bnJ3QWlOdi9aUkhBcGFSakZ5TmlQ?=
 =?utf-8?B?eWNPcEVMWm5JVUVnOTRMT1hSckpScUpHRlQrbEhVQUJBNXREcjFSNWswblNr?=
 =?utf-8?B?Q0w1bE1HTU9tdnVtZW5hQlNnODU3RlhjOEVsMW8zdkRldXlIQ1FqYWJ2M215?=
 =?utf-8?B?ZWIzMjk0bHBTeDJ6WEhUWjlpaHBOQ25CVnpTQTBjd1c3eDF6Mml1V0lWWjFJ?=
 =?utf-8?B?S3hOR2duL2UvWCtVSHNZckMvUjhFK1d4cG1SelNjTFphem1nUnFxTFVhZm5H?=
 =?utf-8?B?bEdscGJ4U1NYam5hbU5ieUtoS2NQalFtbGhPR2p1akVrUUFaTHhTYXFmTWZk?=
 =?utf-8?Q?kshareBZgXMN5W+XdU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 346ac84f-bbc5-4bfc-746e-08de4fbb9b4a
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 20:13:51.7036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GvPttzHkels1SX2xGs92Gs1UkZOodbQBIAM+WAK6F5Uoj/B760gr/ut1m3IFaAl9f7a2R7ANUQzIdV58dcOqDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9106

Add dw_edma_core_ll_cur_idx() to get completed DMA link entry position to
prepare support dymatic add DMA request during DMA running.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/dw-edma/dw-edma-core.h    | 10 ++++++++++
 drivers/dma/dw-edma/dw-edma-v0-core.c | 17 +++++++++++++++++
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 17 +++++++++++++++++
 3 files changed, 44 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 31039eb85079cbbd38a90d249091113ad646c6f9..d68c4592c6177e4fe2a2ae8a645bb065279ac45d 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -123,6 +123,7 @@ struct dw_edma_core_ops {
 	void (*ll_data)(struct dw_edma_chan *chan, struct dw_edma_burst *burst,
 			u32 idx, bool cb, bool irq);
 	void (*ll_link)(struct dw_edma_chan *chan, u32 idx, bool cb, u64 addr);
+	int (*ll_cur_idx)(struct dw_edma_chan *chan);
 	void (*ch_doorbell)(struct dw_edma_chan *chan);
 	void (*ch_enable)(struct dw_edma_chan *chan);
 	void (*ch_config)(struct dw_edma_chan *chan);
@@ -164,6 +165,15 @@ struct dw_edma_chan *dchan2dw_edma_chan(struct dma_chan *dchan)
 	return vc2dw_edma_chan(to_virt_chan(dchan));
 }
 
+/*
+ * Get current DMA running idx.
+ * < 0 means channel have not initialized or hardware reset by PCI link lost
+ */
+static inline int dw_edma_core_ll_cur_idx(struct dw_edma_chan *chan)
+{
+	return chan->dw->core->ll_cur_idx(chan);
+}
+
 static inline u64 dw_edma_core_get_ll_paddr(struct dw_edma_chan *chan)
 {
 	if (chan->dir == EDMA_DIR_WRITE)
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index 7b4591f984ad8b6f9909db16775368ff471db2b8..edc71a4dbc798386508e15f44e85c23e7e50f2ee 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -504,6 +504,22 @@ static void dw_edma_v0_core_ch_doorbell(struct dw_edma_chan *chan)
 		  FIELD_PREP(EDMA_V0_DOORBELL_CH_MASK, chan->id));
 }
 
+static int dw_edma_v0_core_ll_cur_idx(struct dw_edma_chan *chan)
+{
+	u64 paddr;
+	u32 val;
+
+	/* LL region never cross 4G memory boundary, so only check low 32bit */
+	val = GET_CH_32(chan->dw, chan->dir, chan->id, llp.lsb);
+	paddr = dw_edma_core_get_ll_paddr(chan);
+
+	/* DMA have not setup or DMA engine reset because PCIe link lost */
+	if (!val)
+		return -EINVAL;
+
+	return (val - (paddr & 0xFFFFFFFF)) / EDMA_LL_SZ;
+}
+
 /* eDMA debugfs callbacks */
 static void dw_edma_v0_core_debugfs_on(struct dw_edma *dw)
 {
@@ -517,6 +533,7 @@ static const struct dw_edma_core_ops dw_edma_v0_core = {
 	.handle_int = dw_edma_v0_core_handle_int,
 	.ll_data = dw_edma_v0_core_ll_data,
 	.ll_link = dw_edma_v0_core_ll_link,
+	.ll_cur_idx = dw_edma_v0_core_ll_cur_idx,
 	.ch_doorbell = dw_edma_v0_core_ch_doorbell,
 	.ch_enable = dw_edma_v0_core_ch_enable,
 	.ch_config = dw_edma_v0_core_ch_config,
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 7f9fe3a6edd94583fd09c80a8d79527ed6383a8c..8e5bdcd208b5c2553ac45f744a4c678932ea5a03 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -285,6 +285,22 @@ static void dw_hdma_v0_core_ch_doorbell(struct dw_edma_chan *chan)
 	SET_CH_32(dw, chan->dir, chan->id, doorbell, HDMA_V0_DOORBELL_START);
 }
 
+static int dw_hdma_v0_core_ll_cur_idx(struct dw_edma_chan *chan)
+{
+	u64 paddr;
+	u32 val;
+
+	/* LL region never cross 4G memory boundary, so only check low 32bit */
+	val = GET_CH_32(chan->dw, chan->dir, chan->id, llp.lsb);
+	paddr = dw_edma_core_get_ll_paddr(chan);
+
+	/* DMA have not setup or DMA engine reset because PCIe link lost */
+	if (!val)
+		return -EINVAL;
+
+	return (val - (paddr & 0xFFFFFFFF)) / EDMA_LL_SZ;
+}
+
 /* HDMA debugfs callbacks */
 static void dw_hdma_v0_core_debugfs_on(struct dw_edma *dw)
 {
@@ -298,6 +314,7 @@ static const struct dw_edma_core_ops dw_hdma_v0_core = {
 	.handle_int = dw_hdma_v0_core_handle_int,
 	.ll_data = dw_hdma_v0_core_ll_data,
 	.ll_link = dw_hdma_v0_core_ll_link,
+	.ll_cur_idx = dw_hdma_v0_core_ll_cur_idx,
 	.ch_doorbell = dw_hdma_v0_core_ch_doorbell,
 	.ch_enable = dw_hdma_v0_core_ch_enable,
 	.ch_config = dw_hdma_v0_core_ch_config,

-- 
2.34.1


