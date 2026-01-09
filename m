Return-Path: <dmaengine+bounces-8157-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5D7D0AEEC
	for <lists+dmaengine@lfdr.de>; Fri, 09 Jan 2026 16:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B6A1D30A53E8
	for <lists+dmaengine@lfdr.de>; Fri,  9 Jan 2026 15:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D65C363C78;
	Fri,  9 Jan 2026 15:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="C2FL3E5s"
X-Original-To: dmaengine@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013004.outbound.protection.outlook.com [52.101.83.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5A9363C73;
	Fri,  9 Jan 2026 15:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767972584; cv=fail; b=s689ukgvQXCj0htEp07sWh5uilsdZq6FkpjvSGHfEflZeYSBpw7jWZPN4Bc9yjsp+UTHMsG8HaKY4MBRpsTVmfbYdBYQuO0mDBRBQLd4WNC/f/z50LhtjkcsENwbrzFy5eoyKb2D309ecHYpNbTdB00EIJtAqERbKuZB3XC9XHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767972584; c=relaxed/simple;
	bh=puAsIdSpIkHkgRCiWKpN7EldmeyyFMebVkNcAtZFFqM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=nN/atYfv3UvGtG2f4YeUIc4xk182TvmIabgsHOr5Cdfa47/eL6+j0DZqxElY+ymawYtHRcB4FyDumEr10sHdzSL0PBc2CjRTOzyOpv3Lt3KmxWwFTJpC5lxQNaEzzHHgoS7VotKgFBxLubDxiem/g7hZNzo17NF2+Id1wB3dE+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=C2FL3E5s; arc=fail smtp.client-ip=52.101.83.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gSiSD5Up2PHf7pYWkA5/2/y3a3xRTHXK+gDG9vX+HoCEWp3/IklWCI4ir3Lg3iI4NhaLmHIKtmbDCnPYME9WsqNnA6lCAXdRxDuugqloUHYqgCEWn7sklS5HlXEWnMCfXfC9dRFbFv1RuTnj5ZwjBV8dji76Kjzwp2PtD/sQfVTvtVuqkmt7MD6PQ5hvAAGfINWGrqbVnFk5Ly39vkdeVu8yKXmLSce6/klz0rqK9MpqMWtoZfMl73Eu29elF7VaycxlUPaPJt1tYeBRAe4b/Ee7sCTOLF3MH1QGedvDTs2eQ7fn0ZhrM/11YfTtMZFhdEc+2/je3l67xtyEbTzf1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1jlJ41SuVri7IZ1zZP3mqwB9THPwM4myTBlaJoJrc4Q=;
 b=hHPh3xaHl72UtLr6BZEVXnpAngdy8PgNDr2w69Mg2aKJsWsnU5G/i2G49sjQdruOantOj7vtnGdTFgKktOgOlu9GZ7vNK95phUX7p6O/oIYILQB9X6KaRsl5I6pehbKSL9cvDJE8RD3RDF2RBV8B4XMk0dlWmtmZe4616GM7x6IZz+f5Isz0lvQrDj9FBvKjnRt2uPb+txGPTZkVBrgwk5VOFJBE0H7aLtH2V/vLrEu2ybiMc+pOswcJIu1MyonkMYxlaui3oSE3uj5GNEZRqZ6zpqDigWwv7FRF8RNnPBPeQ2jnm6LTTJ+PoWOWy21BqeL3ox5BYqrCcPo+3JpV+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1jlJ41SuVri7IZ1zZP3mqwB9THPwM4myTBlaJoJrc4Q=;
 b=C2FL3E5sAo7+l4qqW6sfGSkIk5JeUUGoMARrH4lrb6hIHmKF8FP6c9Bv748iMsq6CoTEp2trU3pXHTXN6YC9obm5F1xHneu2OZUlFJMswwA67lwCrwEwHQaR0z/KzC7jJiZOQWYR1iQE1vV3x9cT9tV4FMghM2X8XoQa+U/hkn1rkFQ6K7hLvbyJvsb3zGQlrTig4STwEXjpe+1rIvn2LEoUqjMsb0GUaa4wRyM/80bSYRKf7BAxw3g5iW4iJaL1QexNkuQdLwvKs5ZoXS06QDNjNKSndAvJJFYKOhF6k33i9fPmNYT5HCjCrrIJCJVRYuEdzzWJV9EuVa8zUtKDLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8957.eurprd04.prod.outlook.com (2603:10a6:102:20c::5)
 by DU0PR04MB9371.eurprd04.prod.outlook.com (2603:10a6:10:35a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Fri, 9 Jan
 2026 15:29:37 +0000
Received: from PAXPR04MB8957.eurprd04.prod.outlook.com
 ([fe80::9c5d:8cdf:5a78:3c5]) by PAXPR04MB8957.eurprd04.prod.outlook.com
 ([fe80::9c5d:8cdf:5a78:3c5%3]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 15:29:36 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 09 Jan 2026 10:28:29 -0500
Subject: [PATCH v2 09/11] dmaengine: dw-edma: Use common
 dw_edma_core_start() for both eDMA and HDMA
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-edma_ll-v2-9-5c0b27b2c664@nxp.com>
References: <20260109-edma_ll-v2-0-5c0b27b2c664@nxp.com>
In-Reply-To: <20260109-edma_ll-v2-0-5c0b27b2c664@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767972522; l=7784;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=puAsIdSpIkHkgRCiWKpN7EldmeyyFMebVkNcAtZFFqM=;
 b=PP5UY3X+SzxgkUni3NvgYt3053KpFbqEBJU8/OH6C9rcnXNPs3kC0uC56qXohwiquOv32xvFS
 RM3UD5vfIU3AphUmnrmisRt2PL5IExOk7M2hFvvf1fSfsJ6Cm+fF7fK
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR01CA0069.prod.exchangelabs.com (2603:10b6:a03:94::46)
 To PAXPR04MB8957.eurprd04.prod.outlook.com (2603:10a6:102:20c::5)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8957:EE_|DU0PR04MB9371:EE_
X-MS-Office365-Filtering-Correlation-Id: 97d12518-94a8-4ec4-a99a-08de4f93e5be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|7416014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d011emxGRE43aTBZR2NsMWpWYmpKK2dOY3IzNk9nTGllWDE1c1hWOHd4dXhJ?=
 =?utf-8?B?Z09RWGpvWU8rQTNTc3BQcUoxNjhYRTMvenJ5U1Y4QjQ4dXNXT2Q5STVzeVNm?=
 =?utf-8?B?NWY3VjFWaGhXKzJDb1g0RXF6cEgzcXZzdG41NzVUSjMyQmNjaXpPMmxMOUZx?=
 =?utf-8?B?UE9XbjJwaW45cWVvUkpMTGdmUksyUUNibHRrNlIzUTVYVzVtOFlUNFFCZ2lU?=
 =?utf-8?B?bjhJMXI1NjlTaVRXN0VyRVBDNEc4ckRjc2tvdGY3NSs5MGhRalJjOFhYanVD?=
 =?utf-8?B?dUtMTGtCRjNwVXZ6b0ZYaU5TcXBKekpqREs0VlI4NXMxRTVSajBDd00vVW94?=
 =?utf-8?B?bjVKcHN1Snh1Ym85R0Z1R3BwK3M0WXM1N1RSUlFwTitqZVl4WWljTm1jSmRr?=
 =?utf-8?B?b1o2bkFydzdrYWk1U0lBbzMybVdXc2N6U3Fsb3dYYlp2dUVreUNFTGpKaC9F?=
 =?utf-8?B?RWM0TGljZUs2Tk8rMDlDS3VlYTV2eWRrVjJCeXNyeGI1V2lJSVROMDNGeWpu?=
 =?utf-8?B?SDlOeG5JMGZGMTBBTUQvcnFQZkFqUEExWFFib3h5VE9sdXFqUkJIMU9jMzAz?=
 =?utf-8?B?T2tSc0VFMUxPU3J1R1BueWFRcVpjK0l1WHkzQnZBaTRHUnRWYzhCTWVURmQ5?=
 =?utf-8?B?ODZNbVNTblR0RDVjNTVUSFZGZ2dJaWtvcDYrSm9NcDVueDhhdWtOUnN6N0t4?=
 =?utf-8?B?QnZ0K09kVEtNQlowMDlRanE2c2RPZmliZlI0cHV3eDBWRUt5dElvcU5TRllB?=
 =?utf-8?B?TDZMQ0RCMXQybFduZmZsbHJrTERJR0syemRiZDkxWmsvN3pBSFFGb3VNRHBa?=
 =?utf-8?B?WjhmdUlCQWlnNjBPZFVlVHkzMHluUGRjSTdIM1VFKzNJcTJVMWt2cUZsQnFl?=
 =?utf-8?B?SHB1aVZTMUZVQllwRlFXUmZZWkhkdm11Qm5oWHFwVjJhR05KbVg2UmpyaHVO?=
 =?utf-8?B?aVJSaWQ3eHk1VHZZYmFtenR4azFNNTdLdlNkNlkwZ0x3Vmg4WUloc3MrWVlq?=
 =?utf-8?B?b3FBMThIUVJtemV3WHZJS3hCcnRaejByZkNoYUhqNXNCemMxc3Vsalh3TlFJ?=
 =?utf-8?B?NkhaNTRXUUl6VkZXVDl5V0ZHcEdZMUJEMjB5UGlzTmpoNlJQbmtCK2FUWGoy?=
 =?utf-8?B?Y0xDaVRzZVIzWGNXbHZYT0NCQzZabzhDa1lyYWRzWUNVQnozL2w3azlpWmpU?=
 =?utf-8?B?bjJNdDNFelRwMWsyaFRIZnpVbmpJdVlOQXEyR0JTZEdFenF0V1NHeHBEbnRr?=
 =?utf-8?B?SXA4SzBZK2tyZjRpRzVkUmprZ0ZwbnZieWg0RWdsQWNNMitBVkpuQnZvbWsy?=
 =?utf-8?B?cEZoUnhFS2hVN2FGazJuR0sremYyeXYvYlJOMVVKMHpzWHhIa3ZVZzRxR2NZ?=
 =?utf-8?B?a3ZsVW9XSTJvQ2NOMnQ1N25jZnNDUkZZSXZsV3plR0FBYlZEdUQ4QmJCb2Iw?=
 =?utf-8?B?U0xURE5pelgwQlI4K2Y2WjIvc2VldHk0QUFhR3kyZjFXQ1ZqV0pUcnlCTEZp?=
 =?utf-8?B?Q29Ra1R6NmwvRHFlK25pR2lkMk8xMTRoRlY0TTZlQXJtVWFKQ3I4Z2dnMFhy?=
 =?utf-8?B?R09lcEJZRFpZV3VsS3dScVZGdTZDNFRUSTFsRTY0elFiRTZRSnNlSlJmWlJ0?=
 =?utf-8?B?TmNMRjhnRGFBeC9ZUnpTeGVMMHJlZldNQ0xEN3BPSUpYeDhHeFJDWVl5K2tm?=
 =?utf-8?B?aGhISVRhVDRpSGJLbjEwWm1HUG5DNGI3M3BPMXMvMGI1YWt0VWJOK1NBZ0lX?=
 =?utf-8?B?eDgxRVpUc3NKSVhnZWtxcHE2bE81OStCelg2aWs3eXFQRTFVUGYvQ3VVOEhs?=
 =?utf-8?B?eG9KZ3d6TkEweE5YR1J2Ti8zYkx5bi8wenRzSmc1bGt5WW05TzMwVHBqaUZB?=
 =?utf-8?B?NGF5VXd6bWVVM3hQOXVHMlFSUHJpUmVpNFd5djRzSG1VdWFEa2dhNllaMkJS?=
 =?utf-8?B?UlduY1hmaE9mZHFVM2dEQ1FmemYrbzl6WG0rNHFHZzc4K0R6WCtPcHBxRmVL?=
 =?utf-8?B?WUsraWtiV1pSUGc3MmlsOVU1YjQ0dW9tYzFvM1RFZ2ZYUUxKLzBmdXJQUU4x?=
 =?utf-8?B?NDc0Rlk4RHIzeUJWdGdBUi8vY3REK001QWtuQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8957.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(7416014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S1VJbnZPRHFtYlU3SHluSVp5cXptZCtwcFdicjlsakZwNmprTjdUSUd6cDAy?=
 =?utf-8?B?eGEyeW4rRXhmTlFSZnZKYXRsU0FvQVA4MTdJb1pTY3kyQTg0eUJwZ0VFcm5m?=
 =?utf-8?B?QWFLemRIQkRpZGh2ZS9uZmZzNGl0VGZLRG1qaVJ5bEkyZHdtTTFpaW1TSnRU?=
 =?utf-8?B?bkZCam9oQWt2TFRTcGhsVFpIRThhL3hGUVdidXV6enJYQ2htUHExRmpMYmg4?=
 =?utf-8?B?YkNhMytxWkMwNGpLaUlNaXh5bkp6SGNsb2hPdVlIdFFKMVhxckxHYy9Fa3lj?=
 =?utf-8?B?S0dMZXU3OEY5YTJudkV4YmpTOVFWSTQ5ZmNVREY5WloxaEtFbnlXc0ZaeklL?=
 =?utf-8?B?NGZFcituc045ZmtKMFhLLy92aVBDaHcwN0RXbDRTbGt2OU5wRWovcjFHeUtU?=
 =?utf-8?B?dHZqaDQzYjdTRExHNWVnWTMwTUM4MFRVZkdvTmtVTUVreWJhYnVGMzNGSWpq?=
 =?utf-8?B?Y0FaOVZlS0hJRjBySFVNc2Z3S1RibFlScVowNExPcFBEUEdDNDR2Sm1pTGN3?=
 =?utf-8?B?Z2ZHTDRWbjNyNEJXN3oxRmkrKzY3SVQ4OTdSVE5xMVlBTEtRRVNTYURPV2ZP?=
 =?utf-8?B?M2dMSFl4Uk9JOGoyalcrZ1lVdlVoS25FYkd4Qnp6Z2xtdW81ZTRVZUIrU3Z4?=
 =?utf-8?B?bTI5SjNOSzZPaE9OTjlNNUtMbnoxZk41bjZPZi9xV2Z3TkxYYkNjVUdBVUM5?=
 =?utf-8?B?eUNZbk1qUjFiYU9SMGZxRVduQ29GNEZabHByU3JYcEt0OFRJSmdzK29HK04y?=
 =?utf-8?B?VWorNHQyZlpGcXlzeVg1SGxYakh6azg0WnlpTFZxTWZhd1p1WDVhN25XRUta?=
 =?utf-8?B?eVQ0UlM3cWVYZTduTUNXdlp0VmhMTEsxeFRWSlJaY1BhSXF1QWJRaHNrbFVR?=
 =?utf-8?B?WVZYTlVEYkxyWE53SFRpM0ZsRVBFMW84NU5ZcWk3aU9nM3k5OHMyWHpRUXNs?=
 =?utf-8?B?bFkwa0lWUDhCRVVBRmRyUzgva1I1UHk5Ym1MU3kvMktsSGxYaXBWOWR4UnRj?=
 =?utf-8?B?c1Mvdk01aXFnelY0MVVLaHU2M0Q5bWJiTXFSeHhveFZCVHV5NmxMV2ZkNzE2?=
 =?utf-8?B?QlVrRTNMNW5uT05VWWhWQnFsQityWWx1QTJPVE5QTUJ4VEtNQXpqeUJYVVJ4?=
 =?utf-8?B?UG13anRCVGtNVFNDb1ZFN3d4TkEwUlJPZDRQTitRak5Ed3FMMEI5UWtEZE44?=
 =?utf-8?B?a3BkSnRwbkkvdnF1N2FYS1VaOE1RcWY0MGcrdkdsSVo5Vk14VWRWMWwrVTJw?=
 =?utf-8?B?cnF0VmE2Z0tKSUlLeFZITmV6ZFRmZVNyT0w1ZkIyVU0rQnpJazJkNmY1eUpk?=
 =?utf-8?B?d0toOGFmNDNHMFVqcE1zTG43NWQ5S3pPdzhTUE9sYlNMSGhPU0Q4TitMRVNv?=
 =?utf-8?B?VEc4Rmp5akNaa2ZmZVhBSkFRb1lxSEFnMnZycjRrb0FGRTA3aFNsM2JmTmV0?=
 =?utf-8?B?QUYrWFhwZ0x4MTAvRmZlSzg0a3Z2cGFNb0tMNGEvbVovc3VjYUJLeWZxV2lu?=
 =?utf-8?B?eDJXNGdnZ3RQb01QSHRNTkpUMHM3TEkvanVRMm1ybEVibHpka2tpaWZYUVRC?=
 =?utf-8?B?ZzZVbW5wZ3Q3QUtmdTVJdVUwSXJ5UzFGNC95K2k0VVlkSm9lSGdibEZDdy9s?=
 =?utf-8?B?elJPOHJoZnF3SXpLMVpkakcrTGtnazdiOCt1allwcW9jeHo2OUVSQWRaa0NR?=
 =?utf-8?B?NkZtSVAyR2ZmYmRPWnJNaTJyS0U3dVZVcmRVSGZ1S1EvWXl3WWtxOEZ2d1g5?=
 =?utf-8?B?Mzc5Tm1JYld6Zlo0d1ErVktwNm96cTcxWU1abi9ybDdKQkFXZkJmUm8yOUw2?=
 =?utf-8?B?bjg2Qi9Xc1NVZVFiZXBjakNPNVVzS1U3NDhldUFJUWRESFpOdkNyR0Fqem5M?=
 =?utf-8?B?c096TEU3VDZwMFI4TWx3dkFwaHJZaWljeXROckd1b0pRVk9ab0dRYlFFTytB?=
 =?utf-8?B?RFZCN2JKMzhLUk0xSVY4bS95WElZYWQvMWRFbWo4VzN1MTJ2ak8yWEIwczFI?=
 =?utf-8?B?UVZvcmh0TGNsWHpkMkkzRzNvOXVyc0xCaVdHV21teERDbDMrZHFUcUNpdTlK?=
 =?utf-8?B?ZXk4cTFndjFJMkExNW9aOS9abWRlQVp3OW5iczEzaXlNWWN3N1ZnWUdGUlI5?=
 =?utf-8?B?bXV0bENZUkVrTlhITHluTW4vS2FZdVl6VUlmSTR6U3hRZ3h5QVJZUXd2aDV0?=
 =?utf-8?B?N0lOdFNxc2dLWHFleWlyNm9jUnVHOVVaNXV5WmNtRG9TSGF6QkpvTTJJcndj?=
 =?utf-8?B?K056WlpkUE9WRzJNZkJ3RWpIRGNNS3JJSmJiUnYvRE9EMDJxK3M4MUlNeDZs?=
 =?utf-8?B?NDMzUDFnaE9UK1Q5MUw2OE1DeGJGNkJUcjBuQkZTczRTWlQ1TWpUUT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97d12518-94a8-4ec4-a99a-08de4f93e5be
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8957.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 15:29:36.8291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SerDUPOvbE7YTNZ7KJbDuMCJTQFDT5NpgZtxfzXi0BrE9sOFzbsekV1wAlexhaFfBPvJoN3WVPxJZKG2go7T3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9371

Use common dw_edma_core_start() for both eDMA and HDMA. Remove .start()
callback functions at eDMA and HDMA.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v2
- use eDMA and HDMA
---
 drivers/dma/dw-edma/dw-edma-core.c    | 24 ++++++++++++++++--
 drivers/dma/dw-edma/dw-edma-core.h    |  7 -----
 drivers/dma/dw-edma/dw-edma-v0-core.c | 48 -----------------------------------
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 43 +++----------------------------
 4 files changed, 25 insertions(+), 97 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 5b12af20cb37156a8dec440401d956652b890d53..37918f733eb4d36c7ced6418b85a885affadc8f7 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -163,9 +163,29 @@ static void vchan_free_desc(struct virt_dma_desc *vdesc)
 	dw_edma_free_desc(vd2dw_edma_desc(vdesc));
 }
 
+static void dw_edma_core_start(struct dw_edma_chunk *chunk, bool first)
+{
+	struct dw_edma_chan *chan = chunk->chan;
+	struct dw_edma_burst *child;
+	u32 i = 0;
+	int j;
+
+	j = chunk->bursts_alloc;
+	list_for_each_entry(child, &chunk->burst->list, list) {
+		j--;
+		dw_edma_core_ll_data(chan, child, i++, chunk->cb, !j);
+	}
+
+	dw_edma_core_ll_link(chan, i, chunk->cb, chan->ll_region.paddr);
+
+	if (first)
+		dw_edma_core_ch_enable(chan);
+
+	dw_edma_core_ch_doorbell(chan);
+}
+
 static int dw_edma_start_transfer(struct dw_edma_chan *chan)
 {
-	struct dw_edma *dw = chan->dw;
 	struct dw_edma_chunk *child;
 	struct dw_edma_desc *desc;
 	struct virt_dma_desc *vd;
@@ -183,7 +203,7 @@ static int dw_edma_start_transfer(struct dw_edma_chan *chan)
 	if (!child)
 		return 0;
 
-	dw_edma_core_start(dw, child, !desc->xfer_sz);
+	dw_edma_core_start(child, !desc->xfer_sz);
 	desc->xfer_sz += child->xfer_sz;
 	dw_edma_free_burst(child);
 	list_del(&child->list);
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 09e6b25225407f5bacb2699cbba26d1bab90b0c7..0ad460e1942221c678a76e9ab2aee35f1af4eb25 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -124,7 +124,6 @@ struct dw_edma_core_ops {
 	enum dma_status (*ch_status)(struct dw_edma_chan *chan);
 	irqreturn_t (*handle_int)(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 				  dw_edma_handler_t done, dw_edma_handler_t abort);
-	void (*start)(struct dw_edma_chunk *chunk, bool first);
 	void (*ll_data)(struct dw_edma_chan *chan, struct dw_edma_burst *burst,
 			u32 idx, bool cb, bool irq);
 	void (*ll_link)(struct dw_edma_chan *chan, u32 idx, bool cb, u64 addr);
@@ -195,12 +194,6 @@ dw_edma_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 	return dw_irq->dw->core->handle_int(dw_irq, dir, done, abort);
 }
 
-static inline
-void dw_edma_core_start(struct dw_edma *dw, struct dw_edma_chunk *chunk, bool first)
-{
-	dw->core->start(chunk, first);
-}
-
 static inline
 void dw_edma_core_ch_config(struct dw_edma_chan *chan)
 {
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index 7c954af7a3e377f1fb2a250279383af4fa0d8d3e..7b4591f984ad8b6f9909db16775368ff471db2b8 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -379,36 +379,6 @@ static void dw_edma_v0_core_ch_enable(struct dw_edma_chan *chan)
 		  upper_32_bits(chan->ll_region.paddr));
 }
 
-static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
-{
-	struct dw_edma_burst *child;
-	struct dw_edma_chan *chan = chunk->chan;
-	u32 control = 0, i = 0;
-	int j;
-
-	if (chunk->cb)
-		control = DW_EDMA_V0_CB;
-
-	j = chunk->bursts_alloc;
-	list_for_each_entry(child, &chunk->burst->list, list) {
-		j--;
-		if (!j) {
-			control |= DW_EDMA_V0_LIE;
-			if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
-				control |= DW_EDMA_V0_RIE;
-		}
-
-		dw_edma_v0_write_ll_data(chan, i++, control, child->sz,
-					 child->sar, child->dar);
-	}
-
-	control = DW_EDMA_V0_LLP | DW_EDMA_V0_TCB;
-	if (!chunk->cb)
-		control |= DW_EDMA_V0_CB;
-
-	dw_edma_v0_write_ll_link(chan, i, control, chan->ll_region.paddr);
-}
-
 static void dw_edma_v0_sync_ll_data(struct dw_edma_chan *chan)
 {
 	/*
@@ -423,23 +393,6 @@ static void dw_edma_v0_sync_ll_data(struct dw_edma_chan *chan)
 		readl(chan->ll_region.vaddr.io);
 }
 
-static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
-{
-	struct dw_edma_chan *chan = chunk->chan;
-	struct dw_edma *dw = chan->dw;
-
-	dw_edma_v0_core_write_chunk(chunk);
-
-	if (first)
-		dw_edma_v0_core_ch_enable(chan);
-
-	dw_edma_v0_sync_ll_data(chan);
-
-	/* Doorbell */
-	SET_RW_32(dw, chan->dir, doorbell,
-		  FIELD_PREP(EDMA_V0_DOORBELL_CH_MASK, chan->id));
-}
-
 static void dw_edma_v0_core_ch_config(struct dw_edma_chan *chan)
 {
 	struct dw_edma *dw = chan->dw;
@@ -562,7 +515,6 @@ static const struct dw_edma_core_ops dw_edma_v0_core = {
 	.ch_count = dw_edma_v0_core_ch_count,
 	.ch_status = dw_edma_v0_core_ch_status,
 	.handle_int = dw_edma_v0_core_handle_int,
-	.start = dw_edma_v0_core_start,
 	.ll_data = dw_edma_v0_core_ll_data,
 	.ll_link = dw_edma_v0_core_ll_link,
 	.ch_doorbell = dw_edma_v0_core_ch_doorbell,
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 94350bb2bdcd6e29d8a42380160a5bd77caf4680..7f9fe3a6edd94583fd09c80a8d79527ed6383a8c 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -217,26 +217,10 @@ static void dw_hdma_v0_core_ch_enable(struct dw_edma_chan *chan)
 		  lower_32_bits(chan->ll_region.paddr));
 	SET_CH_32(dw, chan->dir, chan->id, llp.msb,
 		  upper_32_bits(chan->ll_region.paddr));
-}
-
-static void dw_hdma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
-{
-	struct dw_edma_chan *chan = chunk->chan;
-	struct dw_edma_burst *child;
-	u32 control = 0, i = 0;
-
-	if (chunk->cb)
-		control = DW_HDMA_V0_CB;
-
-	list_for_each_entry(child, &chunk->burst->list, list)
-		dw_hdma_v0_write_ll_data(chan, i++, control, child->sz,
-					 child->sar, child->dar);
-
-	control = DW_HDMA_V0_LLP | DW_HDMA_V0_TCB;
-	if (!chunk->cb)
-		control |= DW_HDMA_V0_CB;
 
-	dw_hdma_v0_write_ll_link(chan, i, control, chunk->chan->ll_region.paddr);
+	/* Set consumer cycle */
+	SET_CH_32(dw, chan->dir, chan->id, cycle_sync,
+		  HDMA_V0_CONSUMER_CYCLE_STAT | HDMA_V0_CONSUMER_CYCLE_BIT);
 }
 
 static void dw_hdma_v0_sync_ll_data(struct dw_edma_chan *chan)
@@ -253,26 +237,6 @@ static void dw_hdma_v0_sync_ll_data(struct dw_edma_chan *chan)
 		readl(chan->ll_region.vaddr.io);
 }
 
-static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
-{
-	struct dw_edma_chan *chan = chunk->chan;
-	struct dw_edma *dw = chan->dw;
-
-	dw_hdma_v0_core_write_chunk(chunk);
-
-	if (first)
-		dw_hdma_v0_core_ch_enable(chan);
-
-	/* Set consumer cycle */
-	SET_CH_32(dw, chan->dir, chan->id, cycle_sync,
-		  HDMA_V0_CONSUMER_CYCLE_STAT | HDMA_V0_CONSUMER_CYCLE_BIT);
-
-	dw_hdma_v0_sync_ll_data(chan);
-
-	/* Doorbell */
-	SET_CH_32(dw, chan->dir, chan->id, doorbell, HDMA_V0_DOORBELL_START);
-}
-
 static void dw_hdma_v0_core_ch_config(struct dw_edma_chan *chan)
 {
 	struct dw_edma *dw = chan->dw;
@@ -332,7 +296,6 @@ static const struct dw_edma_core_ops dw_hdma_v0_core = {
 	.ch_count = dw_hdma_v0_core_ch_count,
 	.ch_status = dw_hdma_v0_core_ch_status,
 	.handle_int = dw_hdma_v0_core_handle_int,
-	.start = dw_hdma_v0_core_start,
 	.ll_data = dw_hdma_v0_core_ll_data,
 	.ll_link = dw_hdma_v0_core_ll_link,
 	.ch_doorbell = dw_hdma_v0_core_ch_doorbell,

-- 
2.34.1


