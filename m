Return-Path: <dmaengine+bounces-8562-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mM9VBuBQemnk5AEAu9opvQ
	(envelope-from <dmaengine+bounces-8562-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jan 2026 19:09:36 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E0828A781F
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jan 2026 19:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 36DAC303A294
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jan 2026 18:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC1F376BD1;
	Wed, 28 Jan 2026 18:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SAaChPCq"
X-Original-To: dmaengine@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013040.outbound.protection.outlook.com [52.101.83.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F532372B3C;
	Wed, 28 Jan 2026 18:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769623564; cv=fail; b=QMjKpikE5ApQB7kkuJt4rzuMOyceMb0Y9GXeK1Lg+zPbXhoKygu175iyS+FIIqeXimyks5BvEyyZPe0TvKA9FXBtve2oCCBgNTHPrIKCbWqP2d2h+AIXRg7Ezvc5Mr+1BDBJ9IIA9ZCOV+pxRxJKTkTUbRe+D3xHFKGABBXcHs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769623564; c=relaxed/simple;
	bh=yfvIjNWC4V6+JH9e/0SJKLj9JIfsclVT1DqniopxCHY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Yeok+OIBYOd5RtlMVYAEOww/BqGCjQ/YD29DCnCPvAhQ7foPJabwQL7+NTrJH760iP8enjeh/LBF0Ip7Ot68g+BP3RH0jcpN1QuAJhaZqzqlf5dPqAiMBhUUBiJQChZUiTZpx3w4bZW4QDZeIfOzW0gfMWgGPrQ2OJa/O6YeTCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SAaChPCq; arc=fail smtp.client-ip=52.101.83.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wYBBpAE++9lw+G6sZ+4XoP9xHUsVbu6tNBcq7DVaMxU9OXiHp8r4nN2I//MpSSEXdrJWYsWm5tDlRiwOylhmUFRALA7kaa4HzXdxsSIi85s8VMcb+uVvO55U2BLJGiMQ4apZYk8EYACS72R3qdASqhWQClOKZXjnSWtDAoiGee73CrlPpeaey8wlOX+LsryYmGMnP/iCEmIcQRWKToxxP6H3+o2uLegd6TCfd9XBzHuSxRIvFp5Me2+S3TgOjfjwva5hcNzrBiapcWCfyK3Uf+4KZiUei/5V4vwx8vHgIqklk1ZraCzRCmlguMIVYTDnaRwGGZBiLyKoYfG804EtcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4LFpFSDOW2wA/Nlj/4VV21e7jjG6I2aGtsv9BU+5Luk=;
 b=Vk2JBgbj7helQx96mOVGqKFNwS/Du1pQfF7eQzWOdXqHjg7h57Z0Soe/WZSZuQ8AmnvZgjaQtlurwtJ6GLZ3JkHa8798OvVLYtkuOfzccOvj0boCEpUBVQ5/QVEtcriDAxlXJdAh8h/hPa/z93hL0lSXALuDPbP0P+/OJHPAAA7XipNaKlYrwh5rgSeL0hfsoUE29UivIwmvMLM9oIudtXcL9COZmrUAwTy9s5EsWNybogRswfJPEXTSIQsR+biw+CLPTPmMlkt1tEKHdSufDeTpzi+LS92+EZ/iKyhi4UnGCwQ5NOwcfOobYp5ooOwsU1ofS0rZiEvXhhu5QNvYRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4LFpFSDOW2wA/Nlj/4VV21e7jjG6I2aGtsv9BU+5Luk=;
 b=SAaChPCqjNjAtq+L6tGQC2MdtXKrj2/z4xRi1exxJWElLBId0l3PpI1hv169YbxNv0W/dCLcrdsD69ITntc8uwMlEmNC/P8Yluo/jeHq0D3zN8ndPfaIt1dAKEuq6orIqP5kl8WPfelRIc0FHjswSnDSZEt+OOYNWLmB3GVedUIoFYBmOI/OWTq/vpeUIDfpbN0gpHOS4q4wWx4n9F6wVvfS9t/PqLN/vzjS7oAl+GUgkMe1suXISqbcOtDB/+IrCqV3CS0HhyGtVxOHmjjNShz3AbTyRj/jCZXjbLHEV4zsvVCyJ1YG+SutUIhFIHSA62NhKST3cnjZEStvyiP/YQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM9PR04MB8145.eurprd04.prod.outlook.com (2603:10a6:20b:3e1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Wed, 28 Jan
 2026 18:05:55 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9520.005; Wed, 28 Jan 2026
 18:05:55 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 28 Jan 2026 13:05:24 -0500
Subject: [PATCH RFC 05/12] dmaengine: Add DMA pool allocation in
 vchan_dma_ll_init() and API vchan_dma_ll_free()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-dma_ll_comlib-v1-5-1b1fa2c671f9@nxp.com>
References: <20260128-dma_ll_comlib-v1-0-1b1fa2c671f9@nxp.com>
In-Reply-To: <20260128-dma_ll_comlib-v1-0-1b1fa2c671f9@nxp.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, 
 imx@lists.linux.dev, joy.zou@nxp.com, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769623545; l=3578;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=yfvIjNWC4V6+JH9e/0SJKLj9JIfsclVT1DqniopxCHY=;
 b=me9qYJg42d212T36wkidx6evd69p4gfhrBHxBFMy+sqdryp8s654F6TS02q+E0t8TTnUr7iay
 NnlVVPu222mC4DUkteTUJ+LJUm3dj4jpk+F4tlGbGEQx5I3eS3NZxd9
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA9PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:806:20::14) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM9PR04MB8145:EE_
X-MS-Office365-Filtering-Correlation-Id: 40cb9ac9-e2eb-44fa-1e53-08de5e97e170
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aHpiNTJUa2p5OHJJd3pMTFU0WWdsTlgrQ0tRMW5BeVRsU2d3WFBmMkRPejFR?=
 =?utf-8?B?WUVreVlSa0pzWTEyWUhmYjBTV0tUTXUzK3lBQzR6Y2tDZ0RuWWV5cmllUHJ1?=
 =?utf-8?B?STVVdGNtbFlaeVo5Rm5lV0hyNUFJUENqYjF2WVlueHZwN2lVMU42aUlaMzBX?=
 =?utf-8?B?dEoyYkwranVZRWNJak9FZFlSMDBveVAwYWpIZG1wbUMzeGNDZU50QWd6TlpJ?=
 =?utf-8?B?Wk1SYXF0Ti9WUFQ4VmQrT0RLSUkxZ3JUTkZPSmNKWXFpTlFaSytuTzhMSENN?=
 =?utf-8?B?M04xS1ZISGtUenlmVWpOTERac3EwbWlrSHFRMnRQMVF0eUttVnBYUmJRQ1p1?=
 =?utf-8?B?NUJybGZNZnVhbDhhZmF0WmpzVWFBQ3FQd2NZNWg3SFFhOHBYcUpHODlZT2h6?=
 =?utf-8?B?bDBCR3VHZmhjUjRneVNydUVwMHNJdytLZlFyNitFaHVoTUdHK0hvQ21EUi9U?=
 =?utf-8?B?WXlCZTVLQ0tMMFlSM1hTSHRUbEwxbFVMOFRDM0pkSHdvaGdjYmQvRjBXVUJv?=
 =?utf-8?B?Z1o3SGN6Nlo0WGQyWVJISnNKckVqRWRDMVd6NGNWR2ZsSnRBZzdwN3g1dE0w?=
 =?utf-8?B?WTBZa2YwQkFvOFh4MThNQmpqODRGSlBlS0s0TW04ZlVxVnpVdEw2cTZ2eGRv?=
 =?utf-8?B?cU1YaC8vb2x6d1VVUUtpcTNaOVU5S2h0bUdMWlhoRVJTWnpOUCs4UU5UZnpL?=
 =?utf-8?B?OTJnalhKK2JXK0gyakxPTkVSdkM3aldDSnRwbHBmaWRPckVVS2RGZUl0R1VW?=
 =?utf-8?B?UzVUZk1PQW1FYmprbDhISXZKNG9vU3pYMmFZcXZZYW94MW0yK3FrUHUrRXA4?=
 =?utf-8?B?dmFlSm9id0FqVyt1bkRVdzJWRUxMbDZBdnNMVEk5MmxNclRZSlVibzQwWTlr?=
 =?utf-8?B?ajVoK2pVbUlQbllMUExtRUhpRzBXd1NIVUFoajFEWUw2SUUrZTMvTVhvRnBy?=
 =?utf-8?B?ZDRqVU93bXdESFdRTG5jamM1R2VwR3kycjdBekhNTXJJN01BS1VuUXdnTExZ?=
 =?utf-8?B?dzJCbUxaQUYwL09lcmdxMWZHZ0JNdjBBdm8yWUszczI1aFhrUTM1TjhjN3lW?=
 =?utf-8?B?SmplNUV0ZW9ycy9CL0pQemYrOGdHMEdDTGViVERZUlJ1QjZranA1a1VGM0xm?=
 =?utf-8?B?cUU4emN6VEhnTUFKSTdscEsvQzNmZFNJUVVsc2NrTDNpL1FhaGZCcG92Q3k2?=
 =?utf-8?B?MEUybE5RV05UMm5UU053WmVNWnRaSkI5ZEVKNmdRQjRXNVhMeDJraUlqZVRl?=
 =?utf-8?B?RW1EbmtmVlhCVnVidmJiMlhLU2lEbmdjQUtCMzQydWRDMTFydk9lQ2VjdVF3?=
 =?utf-8?B?Y3pFS2JISlJHTnY4ZDhKNVBSdFlFWU1adGx1MjdkWmFUeGRNdVIxM3JZRzht?=
 =?utf-8?B?VW9MbnpnTVZETGRuMVFFVE9FZGJGbENhWUF2Z0FPcWlZQ2E0LzV5Wnh2eVJw?=
 =?utf-8?B?VFRNSjEvNzlodi9CWDY1dzBweVMvWko2d3FqS210S1JxZ2tnMjh5bEFEQ05Q?=
 =?utf-8?B?SStPelZhK01xWTZvZFZVZ2pGYlRHak1XMmV3OW1xUEoycFhxbXJYTFkrTndZ?=
 =?utf-8?B?aUV5bGRWd3UzVHJXeVByM0pHcmdrenduZGdvemdtUFZia1ZVQnBBQkl5cDhx?=
 =?utf-8?B?djBGYWRlNEZNL0pzWkhXU1VlZlhZeHd3aDByUzB0bGQzK3dqRVZEazZtclNz?=
 =?utf-8?B?bzFzSkxVRmZsUDI1SEswU0dxeUlwYXZ5bk1PaEhURDM0Tnp1d25KdzUvQmt4?=
 =?utf-8?B?bWtNQld6dUxLYnJoekQ4cFYyVDBaa0ZibDYzT2pRQUVjMUpPMklSald0SUhx?=
 =?utf-8?B?SUJKUXRmemlFWlR0TXBkRWhBSU1DUnZmUFE1NjhYSUlkZEpUZ2VrdVZFT0lz?=
 =?utf-8?B?MWRSZHdFc2huYW9xUll0RkVscERUZkxNQkxmODd2SzZYenVKUW5ZcGZCRHBu?=
 =?utf-8?B?OXNJU0RKY25FTEhsQmNBS1RZWmk3K20wMlBiM2x6VmhiMkpRWkVIYUNvZXcy?=
 =?utf-8?B?UGxuNnVYY3F1Z2JLMFNqbmxnRHdyQ1BVRk52ZkRSVnptdGxpRVFzSWJ6V2xU?=
 =?utf-8?B?Q2Ivd3dpY3dpejJmYzFZZ3paSFQ2TUJNOXBnZS9GaFY3emZuTHhuUUI1cTNS?=
 =?utf-8?B?ci9ZanVJQSt3V3RYOUVnN2dVU1p5bE1Eb3lmZ2Z1SDlOQnJrb29pTE5rU0Yy?=
 =?utf-8?Q?bqzPMJEN9GknvKP/MLaN+ng=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cjg0dGlsdE9TR3FYRDVjZEJUTUxLdjI1dFd6TTQxeSt4czNnY1kvdml3dHA2?=
 =?utf-8?B?cUErNzMxM3F3MTlTN0ZnMXFXa09DL21QUkV5bTZUYXgyWlN3R2QyZmtIQm9T?=
 =?utf-8?B?cFR6bG4vakJ3WG81NzFnZThnaitHdkRvMHJmbHlNT2ljL1I5MXpZdVNzTVpr?=
 =?utf-8?B?VkFzUFpoNFc4MGFuRHZKT2MzV2tiKzhBT2kwQnJTTzViZEp5aUhZenlwblRo?=
 =?utf-8?B?cFBoY2tJcXZ0SlhLc2RXUVp4Ry9GTWFMNDZjdmdROHdBR1RzSm5COTJib2xn?=
 =?utf-8?B?OEhzWEtYT3o5M1ZBc25PY2tCV3NFZDA4RWxVSGhjVzdZRkFEc1Awb0xqamp6?=
 =?utf-8?B?d0g1UklveEVZUWJWWURMay9JeU5lVW05aTB5MTdWNFhLL0c1N3RSY1B0SEdl?=
 =?utf-8?B?TzNadW83cmRocUlaRllvd3NtaXRUL1FuRnd4VmZFVHNZaHBOUE5NaEpMZU1p?=
 =?utf-8?B?NkJZNnhrOS80RzhKRTdKci9GVXYvd1ptWk1CSytXWEZDQXpMNEJVTURHN2Zo?=
 =?utf-8?B?VDlucmc3RDl1TGhBV1ZaZmJ3UmkzTmY5RlJnM1BUSndVa1ZJWi9qYnFGY3RV?=
 =?utf-8?B?SzNQZGJhNjRnZlgwNjZaajMwV05tMWpEYkk3djRsMHd1SDZBUXZOU3ZWSzJT?=
 =?utf-8?B?U3dYY3lZVElxQlI3Yk51czhkQ3hSaTlubjhpTXVSV0NUUzBVYTZTUmZXdVMz?=
 =?utf-8?B?d1d1K3VIcGtteExYajNtSmJSTmxmRVBpVkMwdFN3S0ZDTi81bUV0TDh1Rm5v?=
 =?utf-8?B?OW8wMEZuVUM2NFRiaEJTeWx2aXdHSXNHaS9XZ0c1Q0Y1L0s0TTRQbUJVc0dk?=
 =?utf-8?B?UWpzTWdkQzlrQm1iZFhxZjRCQkdVZ2IrT3A3SnE0T1dKQzFyUUxvbEtKNGFu?=
 =?utf-8?B?bTFLdVFOQVZCcElZbnNOOFU5VWlzOWE4ZGhwcStPNm5UbzlDTW9wY2JYUklX?=
 =?utf-8?B?U1d1YWxzT2htWUo5RHNGQmlBUlR1U3k5MVcxR3ZDM0dRUTg3bXI5YjNNYVdQ?=
 =?utf-8?B?V1NsbFI0ZENOR00vcDlPQUN2dVAxczk1NVA4bTBrUSt6OUNtSUIwRiszYXlh?=
 =?utf-8?B?c0RXWmxwcUpHNlFNVW9iaWp1ZFo4aGZYdEcxSzdZUU8za05wNTJva0k3YUIv?=
 =?utf-8?B?eW04b1QvcHNsd1htSWorUEZUeUJlUXhrYmRaenFGQnJIWjhFWThkbVhvMTFF?=
 =?utf-8?B?c2p1cGd4bzJGVUttTU03bVNnWkZjYU85YXN2MDU5bVBFUFR4Z0RTdEp2dXJH?=
 =?utf-8?B?Y1FXOFFzTDhmMytsOWVqY3M3TVdTRHFUa2VZMDlDb2s3U1JpaUJ4eW9GNWFy?=
 =?utf-8?B?ZStiK29ZRFRxMzVyWHlZOC9sQVRiVVlDVzZmRmxYU2V4WXFXTDQ4Sm9yYVNT?=
 =?utf-8?B?TWYxLzI0UXFyeHkya2tUZWlSSUduWi9Hc0w5dmU0YlVQaCt5dHE5N05aRTZn?=
 =?utf-8?B?QVdyMVVlYTZPSzM3TWtWRnE0bzVjd2M1bDdsWE1HUVBLMW9wZ2VQWTlQSzc5?=
 =?utf-8?B?T0NzWEV5SWlMY0VYTjQ2TEhhaTEzeFNHZFQrL015ejEyUmxEMjVQaW5Cci9o?=
 =?utf-8?B?MkpCUk9MUVBUdzArNG9BdE0wYWFsZ1dzS1VML01JeEt3dXp6QmpvVi9xell4?=
 =?utf-8?B?bVNpSTE0MndiU0tXVVhML0hmZ3JtWk93c1dRR1k5RkdIMnBNc3FsMzRwR0h1?=
 =?utf-8?B?VlJDS2tzUWF1Rjh3czNsdzRBR09pdEN5K2pDZE1NNlhnUVZxTG1lbm9zc0g1?=
 =?utf-8?B?RFNLSzU5dUpEUTVDNXlxL040VThEcmpMVnBod2ZwWThCTGViSHhuOXkzdkxa?=
 =?utf-8?B?YWdCdnBkSytGaDBCNGw5VXpLRlU1aXZvbFgzczlRNW5jbHR4Vys4cy81aDlv?=
 =?utf-8?B?OVBNM05Kd2FpNGg3OU1tNkQvekZQS1E3STZFK0ZGbGtzKzhjNWhudUFkUHEx?=
 =?utf-8?B?TDcyM3pwWm5oQ3JXV0N6QlpSbEpQVXN1N1hpeU9lZldQOWZVYzM0MlRTT3o5?=
 =?utf-8?B?RWFKaW1FbG12NVgrM292WWhyeWxuS21OazM1Qk9FYnZSeU9UQkk0dGZyaHlV?=
 =?utf-8?B?MjkwRkpzSjNVcGQ4MDFFR25DK3ErM1Y4RUNRQjNNRDRWanRaMEphWTNVbHcw?=
 =?utf-8?B?S29uejliaUNIYzJRRzZtMUg3TnREMGUrc3NadFM3MlJ5ZGR2UjJ4UXRLZWRC?=
 =?utf-8?B?d3RGWE1udjVBdVJXWjRRZW96ZmdxMmpIV3M1YjNWQ0FFcXhpVVEzOVRXVUNI?=
 =?utf-8?B?eE4rcmQ5VjZMR1pubTkvbytBVGNrUVJadkFuMHc5OHhJVFNOd3VvMVJjTnMv?=
 =?utf-8?B?em1IMWNKazByTTFTRnNuL3RWckRpaG5GTk5RZ3padlE0c2JtdjF0Zz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40cb9ac9-e2eb-44fa-1e53-08de5e97e170
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 18:05:54.9763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l3ERZjvCMXy2DX/KirWwhBLwcgwgsnKII11lMFSgtG4uhhdOToDiCEjqWwcYCLXDwKDGhY9/OctSneClTVIGkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8145
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_FROM(0.00)[bounces-8562-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@nxp.com,dmaengine@vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[nxp.com:+]
X-Rspamd-Queue-Id: E0828A781F
X-Rspamd-Action: no action

Add DMA pool allocation in vchan_dma_ll_init() and API vchan_dma_ll_free().
Update fsl-edma to remove its local DMA pool create/free logic, as this is
now handled by the common library.

No functional change.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-common.c | 11 ++---------
 drivers/dma/ll-dma.c          | 17 +++++++++++++++++
 drivers/dma/virt-dma.h        |  1 +
 3 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index 17a8e28037f5e61d4aafbd7f32bde407ecc01a4d..1b5dcb4c333e7b9a0b1b3bd7964dcff94641bd79 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -856,12 +856,6 @@ int fsl_edma_alloc_chan_resources(struct dma_chan *chan)
 	if (ret)
 		return ret;
 
-	fsl_chan->vchan.ll.pool =
-		dma_pool_create("tcd_pool", chan->device->dev,
-				fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_TCD64 ?
-				sizeof(struct fsl_edma_hw_tcd64) : sizeof(struct fsl_edma_hw_tcd),
-				32, 0);
-
 	if (fsl_chan->txirq)
 		ret = request_irq(fsl_chan->txirq, fsl_chan->irq_handler, IRQF_SHARED,
 				 fsl_chan->chan_name, fsl_chan);
@@ -882,7 +876,7 @@ int fsl_edma_alloc_chan_resources(struct dma_chan *chan)
 	if (fsl_chan->txirq)
 		free_irq(fsl_chan->txirq, fsl_chan);
 err_txirq:
-	dma_pool_destroy(fsl_chan->vchan.ll.pool);
+	vchan_dma_ll_free(&fsl_chan->vchan);
 	clk_disable_unprepare(fsl_chan->clk);
 
 	return ret;
@@ -910,8 +904,7 @@ void fsl_edma_free_chan_resources(struct dma_chan *chan)
 		free_irq(fsl_chan->errirq, fsl_chan);
 
 	vchan_dma_desc_free_list(&fsl_chan->vchan, &head);
-	dma_pool_destroy(fsl_chan->vchan.ll.pool);
-	fsl_chan->vchan.ll.pool = NULL;
+	vchan_dma_ll_free(&fsl_chan->vchan);
 	fsl_chan->is_sw = false;
 	fsl_chan->srcid = 0;
 	fsl_chan->is_remote = false;
diff --git a/drivers/dma/ll-dma.c b/drivers/dma/ll-dma.c
index 3845cca7926eb71f008cb98d8c622cb28a2369a5..3b6de65ae83c070d2ca588abf6bca2c49c1d7bd2 100644
--- a/drivers/dma/ll-dma.c
+++ b/drivers/dma/ll-dma.c
@@ -17,6 +17,7 @@
  */
 #include <linux/cleanup.h>
 #include <linux/device.h>
+#include <linux/dmapool.h>
 #include <linux/dmaengine.h>
 #include <linux/module.h>
 #include <linux/spinlock.h>
@@ -32,10 +33,26 @@ int vchan_dma_ll_init(struct virt_dma_chan *vc,
 
 	vc->ll.ops = ops;
 
+	vc->ll.pool = dma_pool_create(dev_name(vc->chan.device->dev),
+				      vc->chan.device->dev, size, align,
+				      boundary);
+	if (!vc->ll.pool) {
+		dev_err(&vc->chan.dev->device,
+			"Unable to allocate descriptor pool\n");
+		return -ENOMEM;
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(vchan_dma_ll_init);
 
+void vchan_dma_ll_free(struct virt_dma_chan *vc)
+{
+	dma_pool_destroy(vc->ll.pool);
+	vc->ll.pool = NULL;
+}
+EXPORT_SYMBOL_GPL(vchan_dma_ll_free);
+
 int vchan_dma_ll_terminate_all(struct dma_chan *chan)
 {
 	struct virt_dma_chan *vchan = to_virt_chan(chan);
diff --git a/drivers/dma/virt-dma.h b/drivers/dma/virt-dma.h
index 82f3f8244f6eca036a027c9a4c9339fcb87e8d2c..e3311be3d917ea1e0d5f4fb0e6781c7d0737c0a5 100644
--- a/drivers/dma/virt-dma.h
+++ b/drivers/dma/virt-dma.h
@@ -276,6 +276,7 @@ static inline struct dma_ll_desc *to_dma_ll_desc(struct virt_dma_desc *vdesc)
 int vchan_dma_ll_init(struct virt_dma_chan *vc,
 		      const struct dma_linklist_ops *ops, size_t size,
 		      size_t align, size_t boundary);
+void vchan_dma_ll_free(struct virt_dma_chan *vc);
 int vchan_dma_ll_terminate_all(struct dma_chan *chan);
 #endif
 

-- 
2.34.1


