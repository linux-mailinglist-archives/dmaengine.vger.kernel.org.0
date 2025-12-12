Return-Path: <dmaengine+bounces-7595-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D95CB9EF1
	for <lists+dmaengine@lfdr.de>; Fri, 12 Dec 2025 23:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2624330DD3AB
	for <lists+dmaengine@lfdr.de>; Fri, 12 Dec 2025 22:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5413B30FF20;
	Fri, 12 Dec 2025 22:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gby9dwxE"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013044.outbound.protection.outlook.com [52.101.72.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F13430B511;
	Fri, 12 Dec 2025 22:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765578385; cv=fail; b=XHvlTR/mLQyobZB/qS6wYTNw+6WWQRDO0aGc4NxAr6aOMy+k+gbWc9rUQZe8NCHGztU/GPkOnj82tCwvAnK/uEtlSF2dDi1ytrU0YcCcaIyPh9KnPz1wccLQSx4ucf83IsFuUDgDlxen1kP3U5T3YTix+QjnCpxeOoS3C+Km0QM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765578385; c=relaxed/simple;
	bh=4IOZc5bn/cXuVYiNt9uCCiSLEc7b5zqzANKyR82eX7A=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=e/umWFi94Onq8/53Fsbn4xqmsX3qmdkqkzP0FQgE2qqHZ47OimG9dSzV1Fj7B4DcoYP0OLcSqwZAKD0oN9OBdihNoGO5tq/fvtkli+p3SF/5bYzFXMlnFjFYcoLDDxRHy8O7vdp9q7e1WpSfCcBJTu4fvdnRa+TjVBmTQcbEuek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gby9dwxE; arc=fail smtp.client-ip=52.101.72.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qT8StS4lqLleDnbjs7Ft6LwXAD0Tf/JgZQ7+uU7Wb41/E9I/GxDEi48ymMq3UdhuU5P8TO7Nze0xl04w42tA+sOdqEVMLOLdSyHHl2T2ruKxsIq70gs92g2aXsTMn27wE8LMp2SeKYtbGfgvMBaFAGt0vPGMi0l4OltuM8Qm/fKGsbCLWVn8rjAuPLhHpHUyE4pBa5YMk1XtoXENHtZjdwlY8K/wLqlnEOtpG7URMR/687A4hAed8eLuZ/kU8WYVLPhFNX7IEqxpjfttAU4cW8Rj8DX8PwstGxUC8Ro3LcNbzNdtDiuNSyKPxCaBF/AWZJd/IT8cNS1q9+yUPK5Hug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cMM6RnKeP9dwko9pP4440Xhy39FCuGEWL4X4if0SsO4=;
 b=jWyqLyZGg3BEXUDqAplGpcxURvZdqqmfRwVtf05gGXGqPJo8CIGjqNra2CIh4fYmHfpfltpwRMLcGSAJNTEF79OC0MjaFMisBq8QQz/XL+Z1URSfSKUk3i1o9FCnMFS5bnMjTIkSjrDAQCwDj2BY+Qp6UIH/DwPcXMkzt7rnK9MVoagmrB7+ReF87cvpvLa5MuHzl432Z87YcsjViWC+geEDvXUXQ6QZLsoJyU3wMoGkOMKIGGrwMuNpSjfcFshjVtsY03j0rdcYgv8W3NR4EhiClK1XBKVsEGkB/GUWkNcShiRKGBH104fiHnB6xe5qxCGDlRno0xRoxPSqdsMinQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMM6RnKeP9dwko9pP4440Xhy39FCuGEWL4X4if0SsO4=;
 b=gby9dwxE+JrmvPPwLtOT44AehXA3Zfp1zQj7n677gxR0sZD5KZ5FkTzd8HodZCT54xwJRrD79QKL2ZJevX4BMGuza3aI6pgxE7ZiJjybCW/zta5CHrfDOl/JaZKtnrA8B2uGSiRDtNVQ7XSHbcTA09WePcYH/0ZK2F/MJSR5MIUThxFMIW/YHwdaZFhTx1eRt7A1yPd54KZvwiHhfv38dkw79RBu6aDf+chCpUMfZoUqgEURNmtdLwKsTWITk66DHyLNNWgxoOHTTWWMk13PL4PUVYviN/Qj/B1HmHKW1FIwbhnoVgfG1pYU2p9jK/oip4yDCk02nywsl8wgrMD2dA==
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
Date: Fri, 12 Dec 2025 17:24:42 -0500
Subject: [PATCH 03/11] dmaengine: dw-edma: Add xfer_sz field to struct
 dw_edma_chunk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251212-edma_ll-v1-3-fc863d9f5ca3@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765578298; l=1785;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=4IOZc5bn/cXuVYiNt9uCCiSLEc7b5zqzANKyR82eX7A=;
 b=ntxELZLOqrjEhrbSLf83c0q/WF1Bi0k9OQ0sgYM9hdLcJe7CPj9c0q2P0l/v3wLlNLdgVGs3i
 M4Pi6ex/ltgCWywroC6WJTEgiX0n9I2hGEV7Yh16SrsoY/OxP4OqJFB
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
X-MS-Office365-Filtering-Correlation-Id: aa3635f7-6fe2-4d05-1bbe-08de39cd5249
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|7416014|52116014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aDF1NWxWdlRBeXc5Q2dDempNL2doQ2F6S2tjL2ZVV29HNkZZbmw3bHozRGpU?=
 =?utf-8?B?ZGNNNFIrK1NqR3NsZ1R2Q3VsREErZjlRNWRLS0JWcmJUWmVrNlR1OFI5NUZT?=
 =?utf-8?B?MnNtbitXdzN0TkpqeTg0QWNEOXU2b1B6bzZiTk4zK1VwVDFPWml6eHcxR0lx?=
 =?utf-8?B?UW5CWkM2SFl2NmVpZHFJU3pNRDZLMDdwaWtSN1JNaDlWaDVycVFiT3I0cEli?=
 =?utf-8?B?S2trT0c3aVFiR3JBZW5LVmJrSVlNa20vWVdZNnFUK2NkQlA0VGZlVnhwNnA2?=
 =?utf-8?B?S2sxbFV0RDVlSVZMV3NESzd6bldDb0t6S2Z5U05lVWpHdWpHMWE5djdnVUpo?=
 =?utf-8?B?RzAzcXhib1FmV2k1U0poNmlFWWd0ZmpYZkphWHI2NW1icWoxbjdTTkNMV0tT?=
 =?utf-8?B?RitRb3M5aFUzNERaSkgvb2ZlYXdGd2ZiM3M1Z0toNmFGU0ppQzkzVTJaNHZy?=
 =?utf-8?B?UWkzSEhyZHVjTzFzZmRIM3k0MXRSYlI0TERFYkJSM01sendhYlZoSzFSZ280?=
 =?utf-8?B?MGlSbFp1TktGRzZhNE1mVzcxaTRRWTdSQklra2Q5MGhsS1lsejl5OHFFbHEr?=
 =?utf-8?B?Y2xYRm0wbXMydE5WOXZlaDhmdzJjS2lSYUlRaXVDaEFYcVhTRlBNWjhIdHll?=
 =?utf-8?B?ZnBtVmVLaGNmejMyb1JmSG9HNzRjSnB1c05PMWowd1lyaDhob1BPQ1Jlc0ln?=
 =?utf-8?B?NzlWYm5TZDRISm1WcWw5MVRNYkM4cnBQRXVEZ3Z4SzYycFpJZlVtbDl2Yk45?=
 =?utf-8?B?S2hTeUhNbzJlY0Z2U2J3SW8veUZSR0Q1N3pacUowVkNJN0MzSTB3N0QzbVlI?=
 =?utf-8?B?R29ERExLZGM1Sy9ES2c0K2JUb2hVNHBZcXZVOEYwM1c4MlU1a0xlUnBZWDE1?=
 =?utf-8?B?ajE4YW94ZDVsQVhFeWQyYzZHcHJQOFMxV0VtMXJ1VlRVL0ZqcnpDcTdGMnBw?=
 =?utf-8?B?eGRTQXJzTzNLU1JWRXE5ZEp3eTUxb0txRDkvZ05kQTV0U29mLzNFaERxZTFh?=
 =?utf-8?B?Q2dwNnZVTWptUnd2VkNtclY4QkE4Tjd6NlgzVTZpazRwVDIrYUlTRmpYdVdF?=
 =?utf-8?B?MWVHNDE5MTJEUVpXRGlnbHhtVkVGaHoyUW5YZ3VQRXZ4OVZBbGZhcjJ0Qm9E?=
 =?utf-8?B?czN4cStkTFlYTEQzdVhVeEpiUkxRSU9mS2tBTXZRb1Y3ZFhBVGFoVW1Bc2ti?=
 =?utf-8?B?Yk9ldlhDNmxPS2JWYktDU3hPUWlYenp2anZEQ0cxZGw0TVdHaHM1OURQRnpB?=
 =?utf-8?B?WE0rN3pQS2M5eFJ4SllBMEhVbVRlNmdCK00yanBxbVpjZHhzQ0xsQWJ5SzlP?=
 =?utf-8?B?VGhyVElubldRQ0s0SEcvMGx5R2VIYk45R3FHWEk2OXdaSlVkNDFkMFJMSHZl?=
 =?utf-8?B?MDVmbnpwcHVIOGJLcUk4K2VvNHNMVllqMXZNQVBDekFXUjZpc1BmbC9hbnl5?=
 =?utf-8?B?U2VjN2hGOG1tcHJkVUcxN1FoaHBzbEk2UHlkTUZaUzkyTG5QOTE5cExSdEQ2?=
 =?utf-8?B?S3c5ZlBMSXdSbmNqNXhnTk16NWFuUDBGWkgzV0doRjI1Y3R0TjdvOWREemsy?=
 =?utf-8?B?bjdESnk1ZUlUK2ZjMXpuVUNaU1c0MXFCbGdNMzl5Y3ZjekU2YkZpZkZZQ0pn?=
 =?utf-8?B?R2lOd1VYb2pPQkQ1SzI5QnF3dE9yWUl5cVpqMXV5MEhLdHRvMWlaNVpSSm9M?=
 =?utf-8?B?QW1wVFRvSzlKTGg1NHdFUmU3bEdQZDVZcGpqczFVSFMva1dQN0U0SmNiQWlv?=
 =?utf-8?B?SU5LWG04bVgrK3IxWjJONkkrZEhxWG8wWXZKZG9MZEpGSGdFL0c2N3hCMkQ0?=
 =?utf-8?B?clZZSDBidzd5eDdpSU16dGNOK3RmWjB5UDNaODRkNEVERDRiOFBMWEhmdWR5?=
 =?utf-8?B?NGVXeVhBTnIrK0RnV0VxbVhVbytUT3gwZG1zZjFvT3kyRlVDMlNrVk1wYTlF?=
 =?utf-8?B?N291RzRqdDJibjNxbjBXc203a1l2czY2a2FqdEVrdU85THNtVS96QUFsOG5E?=
 =?utf-8?B?VWk3OUszVTFZenlLUVlna0tzSkxjRmYwM09kcWp0TE5kTWtad0VrZExhdDlR?=
 =?utf-8?B?UWNpTUQzckxQaFpHTGRXKzgrcmdFQ0MwYThIUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y216RVJIWGFDNEk3NTVwaE5sOFhUQjM2dGE3QmMydTlHN0R3Y2l0aDNlUHlD?=
 =?utf-8?B?a3hTQ3FiVlAyZFZsTzRMajZ4amllMTBLanVhSGdYVUdWc1BWQUlXT2pYeHZT?=
 =?utf-8?B?cUhTUS90ZEpaN3JFV1FtNVZyTXRkTTRxSnZ0MnpueUJ5dXRSWG0xaEJjSTNy?=
 =?utf-8?B?eVhBT3cwSEtGbWNrMWc2WjMvVWRIRjcyZmx1cmgydVNHVmhLWVNpVnpISnM4?=
 =?utf-8?B?RTZkZTFWd0xkKzN6ZXBjTlpaZFNHYzhQTkdKTElPRExDVGRhQ1pVbXlqbjlS?=
 =?utf-8?B?T05aR2dlbkd2TVZPbW1HdmM1RFJFazVvTGE2c3VwUjJpZDY5cFN0MENWWUFq?=
 =?utf-8?B?T01KcmNGMnI0ZHFSWkNCcTIzV2tibitOa2R2enpLWGlkYlZrbzhWU2VtNTJR?=
 =?utf-8?B?WDZ0TTRPZkNxaStIVHU1V1c3RUx5SzBwWlJFRGk3dk9oSi91aXVXSzY5eCta?=
 =?utf-8?B?U1VMMkhXRVozc0xMSkRwR01iRkFYUlB0Q09aRWxoUFkvLzFRTmRJeFEyVWZ6?=
 =?utf-8?B?b0IwMDBwbjNnSFpHWXlYUUZWWHRSS29mYmhSM0N0dzhnMjVFM1BLUUZ3MDBN?=
 =?utf-8?B?VExlS25lbzJJbmZSZUN3UlJtNXdvajcvVFhTcGZmaHV3SGNsZXBxTUFQL05B?=
 =?utf-8?B?b0p1b3MrSEJ5OG12dXBEMFRZdk80R0lvOWl1SmdNbzYxcHFUSVo3NDYwcm5I?=
 =?utf-8?B?dDhmSFhtOU1UMWIrb3NLMldiQ2hxNURoT3h2M052Vy9pbDE1elQ4VnRMQmZs?=
 =?utf-8?B?MHM5NUJSVVV6ZTA3NDJqQnJDZzZpNkErOSs5d09LbldWZjdvY1htaUVMYmd6?=
 =?utf-8?B?K1k0Tkd0V2tlMG1FanhzMVRrenIxMjN1VWsyQVVkZVpPOUh0MlUzbWRiUFky?=
 =?utf-8?B?bHVYaXducEZPbHlKYW1jdnBGa0RhaEkyMUlMSVdDY1djOVRKeFVJTVE3aDhY?=
 =?utf-8?B?MS92RDJLOFhMR1JOZ1hwbEE4ZXlCbnFsd0h3c0lSdWFSa1l6NVpMZUpPTE9o?=
 =?utf-8?B?Qjg2SlBVMWIzZlBVRkprTTJXTlRCMTFNYzFGNW43QWJqNHE1OCtnMFNDRFkw?=
 =?utf-8?B?UnNXQlJReTRGU0lCK051TjlxT0JlREJaZmhQVmViWkZJTWJTL0w3Y21xZDFi?=
 =?utf-8?B?Y3F6SDZVY1JmT01sdk5pNEJQTmVLMExUc3hjT3hGcVkvM3NxZ0M2NVUxMzVm?=
 =?utf-8?B?VWpMQ2cyUnVQQ3BKUjVRVVpNbEJqTmNVRXJmeGJ0dXYyNWJMdUczWk1rSWJ3?=
 =?utf-8?B?bFQraEhBY1NJb0thdGtSSm9jMEZtS1hwNkljdUFvYmlLWlJMQnVwWTh4dDFj?=
 =?utf-8?B?OHFxQ2ZUU1dpWldtT0w5OGxabkJKQXhmZlFWeUxJOThSZHVuN3gwMU5sYzls?=
 =?utf-8?B?dkNFa3RsOXhyVGoyeERyMUR1WGFNNkkwTEcvQllINXdVVXJLVlBwVkNlY3hO?=
 =?utf-8?B?bUs0ZkE3cUZkR3d3QVo5cU1CdnFqendTZUd6anBmcHdoNTVwU2dkZEd3bmtP?=
 =?utf-8?B?NFRaZndTVUEyRHAxU3lFRWVoSWxFZmJDN1hwL1RkSWE2VnJiOFZBc2d3cHJi?=
 =?utf-8?B?UDV3TXBlMnVPTnMvUTQ5VFErNXpxdERGaDRkWlVibUhIc3BJMElEZnNkd0J0?=
 =?utf-8?B?ZGdtRDRKVXpxWHdqQlpid0tmNWlDdW9teUt6OHQ3R1RRb0RFYVRvY2JWalM0?=
 =?utf-8?B?L25wdzZJbFlGUGdZMmFJRTFkeG9JTGFpYVZUeXR5U3JpSm1IeTBjaWdjS1lO?=
 =?utf-8?B?VUlOOEFwVDlWWjFIQ1JHWTlwRUhrbTJHTWpDb0NHU3NDSGJHZkxBRDFvbS9F?=
 =?utf-8?B?WkVIUGJUNzZoZkdpeG5FaENDRzF0dmppMlFOdk84YVdTVkFub2xQTHNaOGFK?=
 =?utf-8?B?OTJqbG5kMWlWZGp0QitIUzNmeVFjb2IyYnZlRXRPZHd0UStLT0dKVUphQmo1?=
 =?utf-8?B?dUdoMDNOc2J5QW15SVkvd1FTcnJNNytrRjVnYmdTUVMwalZxVU54d2gyTEo0?=
 =?utf-8?B?RGxFWm5YMm1WQ1hueFJyUklyT29KMC9YQUQ0VkIwLzh5R3Q3aTRrR2grYWVp?=
 =?utf-8?B?ZFE2aXpHUUVhclFNU2hDL2NQM3RFSUJoWkxaSUUzeVA4aXpxR1UrRHZnV3ZI?=
 =?utf-8?Q?lwcg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa3635f7-6fe2-4d05-1bbe-08de39cd5249
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 22:25:14.6028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E2+msoJzEM1r+5qiJkqL3igweO4e7o0xWPUoylG+27/gaH6BgeG9Vfv2CxpYFRCg/rn63WgKXR5G/1JjEbM4qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9053

Reusing ll_region.sz as the transfer size is misleading because
ll_region.sz represents the memory size of the EDMA link list, not the
amount of data to be transferred.

Add a new xfer_sz field to explicitly indicate the total transfer size
of a chunk.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/dw-edma/dw-edma-core.c | 4 ++--
 drivers/dma/dw-edma/dw-edma-core.h | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 744c60ec964102287bd32b9e55d0f3024d1d39d9..c6b014949afe82f10362711fc8a956fe60a72835 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -192,7 +192,7 @@ static int dw_edma_start_transfer(struct dw_edma_chan *chan)
 		return 0;
 
 	dw_edma_core_start(dw, child, !desc->xfer_sz);
-	desc->xfer_sz += child->ll_region.sz;
+	desc->xfer_sz += child->xfer_sz;
 	dw_edma_free_burst(child);
 	list_del(&child->list);
 	kfree(child);
@@ -477,7 +477,7 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer,
 		else if (xfer->type == EDMA_XFER_INTERLEAVED)
 			burst->sz = xfer->xfer.il->sgl[i % fsz].size;
 
-		chunk->ll_region.sz += burst->sz;
+		chunk->xfer_sz += burst->sz;
 		desc->alloc_sz += burst->sz;
 
 		if (dir == DMA_DEV_TO_MEM) {
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 71894b9e0b1539c636171738963e80a0a5ef43a4..722f3e0011208f503f426b65645ef26fbae3804b 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -57,6 +57,7 @@ struct dw_edma_chunk {
 	u32				bursts_alloc;
 
 	u8				cb;
+	u32				xfer_sz;
 	struct dw_edma_region		ll_region;	/* Linked list */
 };
 

-- 
2.34.1


