Return-Path: <dmaengine+bounces-10252-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIUSBuGo+2myewMAu9opvQ
	(envelope-from <dmaengine+bounces-10252-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 06 May 2026 22:47:29 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3044E0591
	for <lists+dmaengine@lfdr.de>; Wed, 06 May 2026 22:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1E6443088E48
	for <lists+dmaengine@lfdr.de>; Wed,  6 May 2026 20:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1041B3B3BF1;
	Wed,  6 May 2026 20:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KwSphqmE"
X-Original-To: dmaengine@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013014.outbound.protection.outlook.com [52.101.83.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489C13B19C6;
	Wed,  6 May 2026 20:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778100307; cv=fail; b=ewWMJpIvVfLAdOybSe6XYc2yJVo5smjU/gutbiCIqteURtayXCugAKLA/W2658jku7J2KySLsiGNo4zyKiPfLGpw3LrXX6t/y8bn5w73PS1D8uI5VnSaQIj4Jzr0kcvWZmatI+kybIPbmK4/x30qpoKI8PesSpacW5/Y6QUVItg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778100307; c=relaxed/simple;
	bh=koXXyKc1hgZdKRxgXzvlujpzrQC7NdnB7of8UmH/EuA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=PpjQ/b7aKOjrHf3sBYX3wND0tcLe4VepNqKaYoSNjeb0JRlkal/CwjXCguEL8f6Ratyk0R1Qkh4pD34wxakq+Lpmp+6RzeMIBY9FGY7akbgHSysMdoK8l8fSrki/YUoAUz4Ul98G3HaVnvE21bQKyKJSXBGH9guMxv3u8Tgss68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KwSphqmE; arc=fail smtp.client-ip=52.101.83.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GgK0LLfwxgzk/wEWGALpaGA8KRPkAoAkm4PIfUMrKepJN2UHA7dTDZAaaPz1FMJ7TJwmToAG/CYyLNiVujr+ZQbkrVrTiJuGkZg4WAYlhgjuuic0HH2dHti7ezxtWjdgaSZ0wZpkYLLIOLRT+S7USv0aM3AGbLmxMi5x5eDpTTKl5zIshiA1tQTDnun38xVJva2Cu0ejekGIBXi+/bx03+PiXUAxHx1r+es/Dh/+EVBohCaPkZnsrSWRGvi20mSKn399tVPDWVJHhV1dLgNu6ugxaf+qdc1ioWrOXQnVmoDJQjfVsmaKLN9O/oAx4RjTfVbmr547JgLAssDaxBGYwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uplwv4EQrFrvunfm+7xhscX0/FQTAzucHl0DFTTQQC0=;
 b=mnFiADVdrsx4UD85m1CTojd4SvY18iYQPaLa5xGBjvMcP5B6+kY/1jeLjJwysZekj5MPho8bl1nYTpRfcKHPbg6oG+TRVsr8laS3yoJP7vsE8u3pQH5J9n3yapbONNeMgUsB2XnnSEUEMtOl7sktPZI27fxDwCtkkR6VhwWdgWGN6CNyXB6vr2VPQe48pJhtHVgQ5y7e5duvrw96F2C4qmAsg1NU3XoZ2/ULs5wBYxCF40ETYt93j1P791pMqwef5+L2JDxiP9Z3QqsZWzIRXbptzEPF7TE6MAiEI+odJpLOvkPrRfqjnrTdB1x/kL/M+7GPcKytPJM3W8GsXSgCVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uplwv4EQrFrvunfm+7xhscX0/FQTAzucHl0DFTTQQC0=;
 b=KwSphqmElpitvaBbeLF+xg9h1EBBU39HUdCRvOWUced+JSCnL8VoHmm1umMgGVtfpYw/bqwOYd5+dy2FGknJFg9uYmXnsb7L0eHFPfjOvNwztLEU2+WbHL1TBEhqZf0nAH0FEsyx0jq5y3a6gf9AHLfnfUcNwJbBO79Um7T9fF3Mp+uoC5C4Nmse0yvjLUzGsyLHCkOxbeCGRdxsGY4HRJY7q2pHk/wvTrEWvL9kF/F7WHBEOFJwsDcHLbyVv71JIDuwzY5ior7RqLhiqzVesKF+LKF1CSC5HXMzoIs1k9aA0wX0kLtK18AKAVxqW5GhXyu57dAWtpVGB7VSxScmXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com (2603:10a6:10:35b::7)
 by GV1PR04MB10479.eurprd04.prod.outlook.com (2603:10a6:150:1cd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 20:45:02 +0000
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4]) by DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4%4]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 20:45:02 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 06 May 2026 16:44:20 -0400
Subject: [PATCH v4 8/9] PCI: epf-mhi: Use dmaengine_prep_config_single() to
 simplify code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260506-dma_prep_config-v4-8-85b3d22babff@nxp.com>
References: <20260506-dma_prep_config-v4-0-85b3d22babff@nxp.com>
In-Reply-To: <20260506-dma_prep_config-v4-0-85b3d22babff@nxp.com>
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
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778100264; l=4679;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=koXXyKc1hgZdKRxgXzvlujpzrQC7NdnB7of8UmH/EuA=;
 b=D6+2W02cUCo/yB0GdmIdQ+ysK/lJWLYo1wDg/05CKpGwNQdoYtKAwFfx+DCaEkp7RNUpwwmA/
 grR5PO65aLtACwI4YcaFpXccifQqTOLK98i96+Ms+bJEwtF/0gDD5ot
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
X-MS-Office365-Filtering-Correlation-Id: 086c959c-8ec3-4204-82f1-08deabb058d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|52116014|1800799024|7416014|22082099003|921020|18002099003|38350700014|56012099003;
X-Microsoft-Antispam-Message-Info:
	iK+ZW4cpK09bpM/L94piNvtTGmpiotGLR4L6Lu/TyMaz2K2DzGxVXQRlSM6L6I9Lp3I+MCmJjvcKv6z/1i/anR0coitbk0Q3SrHVNHeRN/mX/teISYby9n9UOYj2PYGmyZz+m7PQEv8/0/jDA/arTevvms2wghxfQkXlJR8JZuUx2Qv8rPhAml3Y28syVmwTAoCzFCNHrmXVRkpFzlMebmZV7wlfsAamIcLoKl8bscsC9sq22+LFVpqt+aobJ+ga5Ar+Bnc7wSM723ccgSDzq4XX38ceVkcfn1e9TriVCmrrS2aUwWLnwe+T8BII/o13fi2/wya1u+JKqeUQxUXfWKOKqmkQ2A/VPrEB2RNDimisowccV/FYE+eMqyBDNXD+N9zkZL1aORGTtWbpo1F90y7Jge2zebuZ4cVE0wOANYvhZzzOsSaPR3jDGiBbgNc9IMIvhIlyhXvch0sm5l6TIyzOLaWKAqTBH3DwYFcPt5vkbShO+VwmRWohnenUED5ogh2QI1sq6KN83DxTO041HbVOl0ebGqI1N7qgLyoOolv1kfGXcexnEHp8Xaz8vOxOnnBV4DWEmqLnkFSM+zm/W6WjldU/PzkkdoAVwEGAtFfQWxsPYkl9EXQrvcWCJ0Vf1ZM6p2yK75An+Xfeqnhp8fsgqa7kywuwQ5AOQ5nFkTO9RASs8eM7QNRyzJqvNQi6cNnizr0l/EXj0LEi7/UMd4oHPnTU16AK3kX8jLi1JHIZEUrmEkfDyzwWinIFjVhLWEvplDc97ix0mOX1UPdDnw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9372.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(52116014)(1800799024)(7416014)(22082099003)(921020)(18002099003)(38350700014)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RlV1RkpuVUM2RWozbFkyM2t3YjB0emZrdmsxMStQc1FpUVd4bDhwVVBhc0FB?=
 =?utf-8?B?cHlMdys2bHl2elN0NWd6MS95ZFZhditQOHJUaFpqMlBoNzR6WHJMTUxaUWdh?=
 =?utf-8?B?WWpXcllBZVRxQ2pEdThxYlhuWXF3SENLMlNYMUdzd1VWVzEwSzI1MitIWkN3?=
 =?utf-8?B?RiswaWRrWTBzdThENm5aOVVpeUVVeVVqSGd0VXZ5STFFc0FZcTh4ZDU4SW5m?=
 =?utf-8?B?TTF3NXJicFhjMS9YUDBOSnBFR2hDelVjMXRwU2VocmM3TDVLanN5Z0YzakNp?=
 =?utf-8?B?b1lOQm5DM2U5WUw2bXNaWUt0Z3BoOHhDNFY3Y1QyRTl4ckxVVUFvSUI2RDZX?=
 =?utf-8?B?UmFEUUNxL0I0UFJ2Smk3TElLdnN2MUxxVHRZMnZpd2YvSEpVTTJoZks0V2hV?=
 =?utf-8?B?bXBrd2YyVXoyQlpQQVRCay90WmhpSFlna1B1ejZEQ3J4cDBYQUllSTNCOTFO?=
 =?utf-8?B?VmNXK1RkYWZWN0l2am9WR0UyaGd0NStKYnNqRUpTR1U4TFNaZGFBSXpYQ1Vw?=
 =?utf-8?B?UXZUVzZnYkRTZVlvUmNYNE9ZS0RMRXhYMTZjdU1IdkNua1NGb3dYNUsxZXJ2?=
 =?utf-8?B?dVlwQjlyRlR0NXZNOU9OSlc4Z21ObUFKVUVpbnpETFg1Y1JGSTJ5Rk1PdjJr?=
 =?utf-8?B?N0pYcWh4SHdwdERzenNRZVArelpVbS9mZ1cyZEhod2RNaHZFVkx1RXpxczVy?=
 =?utf-8?B?N2xGQzZsQzVNRDNUMWtad3FzZzZ0TnlkdkxGa2hDRVk1VEYxbFhIZWIvTHdY?=
 =?utf-8?B?N012dkRUdk51aVpmdTk2TUhaWWsxSWtjMkNqaTZLNm9xOVRUNjMyQ1VGVG5B?=
 =?utf-8?B?d05JTnI5WC9ERExVSlEvYjBHRytveHY5Y3FNMk1LeDJaQ2xPZFVFdnY5RkRy?=
 =?utf-8?B?eThZN04xaDllREpYTHVyV3A5Nzh5SXZXTkZiVzk1S3M1bXhScFVzbWVBT0tB?=
 =?utf-8?B?aUNJZUhCNXJ0bFpTNHQ1UnFjQzdwS2U3UUMrd2VRS1VFc1V6SFlCcWxCSFlq?=
 =?utf-8?B?N0FNc0o3TytYV2tMQUltQnFOVDFYRmVMSG00cHJkN1V6WE9qZUNLR1J0MkRV?=
 =?utf-8?B?dnBEVWdrZjBPTGhDbnpQV0ZsWHFYVkZ4UFA0TzJyc0ZnNXRXZ09BaDkrUzZB?=
 =?utf-8?B?SDhVRDgyS01ZWTcrdWVmaHhGTEdybDFKTDArblRaYjR3RmVhS0h4Ry80bUJ4?=
 =?utf-8?B?MGloem1RbWhFUHFlWmdUYnhHK29yTUZoTGtHTXY4anJvYnBDTU81WTlBcXlk?=
 =?utf-8?B?MmVhVEI3WkRwM2NkY0dZVkgvMG1yRXFZbmVXSE5NQ2JhQTQ3TmIreXJlSFY4?=
 =?utf-8?B?QnBsN3dDTTUvVUR5cTAwWS9QV3Jvc2pxVzZ1NitRT3piWDMweXMzbmUvT2xY?=
 =?utf-8?B?a3VUV3IwbXlaa3RJYnpoRStEdnRlMGhRa3NhcE84MzR4MjR4YkY4Sis1RVZw?=
 =?utf-8?B?OEVveUtxQWJPTk0zZlQzK2hLeCtXeTJsTHcyT2RYakhLanlWVStDYVFKRXhO?=
 =?utf-8?B?ZkUzLzk0ZFdIc2c4TE5HQ0ZBTlZRTzB5SXg5ZGJkVm0wZ3Z2Y05DT3VzWE5G?=
 =?utf-8?B?bUNSd2pYWk5Obmg2bnJwZ1RHLy9uS05KQS8wbnJHWUxkWlZRRXByTklrMVo1?=
 =?utf-8?B?elQ3bzNZckZBZHN4c0pFcXpnMi9jSElYQjkxMXIxTnNvMWU3a0NTYXRCN1VP?=
 =?utf-8?B?OXkrcjNFcGFleEd4Y0ZEVnY3cDZsTlIvQWVZWUwxUmo2Q09zbk9ab0NKWWN4?=
 =?utf-8?B?TXA0bW0zaWpESyszM0VMRUtkcm5sc2J1aHJ6MjVZN3Ntb3E0TGhSTFB1UXlh?=
 =?utf-8?B?UFZ1bHkxRFhtYnkzMlZOMFNiLzFWNW4rVmVPWmZBRWJoN0hvYUVCQm5VWlhO?=
 =?utf-8?B?V3Q5U2FRdEhtWFV4cS95Vk0rSlhOZng1bjJIUUlzYm9NUTFoODlrK1k0aVRP?=
 =?utf-8?B?NVFCTEh4WGtCWUdBSmk1dmZmQlJzTkZWc0RMOE5Oa2lQZ1FsbWo2WGRCWUQw?=
 =?utf-8?B?Vm5VSm9tMFZaWmVRR0dxQWdrMWNvajNBN1pqUkVtSVM1RkQ5SkMyT2hjM0to?=
 =?utf-8?B?Z0NBWU9oaldTa3RMcW5Rcjg0WnBQZWFPNHVNNlZnWDZNUGZZN3BKR0F6cTdh?=
 =?utf-8?B?QTFycktXMkFTWWlyYVBPWkkzTnJCbldwT2N5azd3ZnZ0WG1SOExzdnRpc3ZS?=
 =?utf-8?B?QzFUZzVHVWpTWEFxTEJDN0RwLzN5T3NRL0h0a2ZWNFhJUllqdUtkMTVSeU9D?=
 =?utf-8?B?K1VVbGhiM2RzNjBPVUp6WlozcGlZSEEzWWFjR29oKzYvaU4rOWJHenk5blJ0?=
 =?utf-8?B?ZjRQaXpmaENwc2VHdHNZaXZ3eldXS0pTQ1NlT09jQjVVaFliUE5XQT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 086c959c-8ec3-4204-82f1-08deabb058d7
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9372.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 20:45:02.7441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ZgAnCVF/5rv2LKLG3hDFs5h70OGeXJYNCZPhZJdIJY5mMyED7Mp7FH1yGYvOoMKCa81gzqw/phYL8gRnzR8Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10479
X-Rspamd-Queue-Id: BF3044E0591
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10252-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nxp.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Use dmaengine_prep_config_single() to simplify
pci_epf_mhi_edma_read[_sync]() and pci_epf_mhi_edma_write[_sync]().

No functional change.

Tested-by: Niklas Cassel <cassel@kernel.org>
Acked-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Keep mutex lock because sync with other function.
---
 drivers/pci/endpoint/functions/pci-epf-mhi.c | 52 +++++++++-------------------
 1 file changed, 16 insertions(+), 36 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
index 7f5326925ed54abf4ae75c465dfe0a9bab37ce40..c3e3b58fb86cd75e175b69ca45530610c500b99e 100644
--- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
+++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
@@ -328,12 +328,6 @@ static int pci_epf_mhi_edma_read(struct mhi_ep_cntrl *mhi_cntrl,
 	config.direction = DMA_DEV_TO_MEM;
 	config.src_addr = buf_info->host_addr;
 
-	ret = dmaengine_slave_config(chan, &config);
-	if (ret) {
-		dev_err(dev, "Failed to configure DMA channel\n");
-		goto err_unlock;
-	}
-
 	dst_addr = dma_map_single(dma_dev, buf_info->dev_addr, buf_info->size,
 				  DMA_FROM_DEVICE);
 	ret = dma_mapping_error(dma_dev, dst_addr);
@@ -342,9 +336,10 @@ static int pci_epf_mhi_edma_read(struct mhi_ep_cntrl *mhi_cntrl,
 		goto err_unlock;
 	}
 
-	desc = dmaengine_prep_slave_single(chan, dst_addr, buf_info->size,
-					   DMA_DEV_TO_MEM,
-					   DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
+	desc = dmaengine_prep_config_single(chan, dst_addr, buf_info->size,
+					    DMA_DEV_TO_MEM,
+					    DMA_CTRL_ACK | DMA_PREP_INTERRUPT,
+					    &config);
 	if (!desc) {
 		dev_err(dev, "Failed to prepare DMA\n");
 		ret = -EIO;
@@ -401,12 +396,6 @@ static int pci_epf_mhi_edma_write(struct mhi_ep_cntrl *mhi_cntrl,
 	config.direction = DMA_MEM_TO_DEV;
 	config.dst_addr = buf_info->host_addr;
 
-	ret = dmaengine_slave_config(chan, &config);
-	if (ret) {
-		dev_err(dev, "Failed to configure DMA channel\n");
-		goto err_unlock;
-	}
-
 	src_addr = dma_map_single(dma_dev, buf_info->dev_addr, buf_info->size,
 				  DMA_TO_DEVICE);
 	ret = dma_mapping_error(dma_dev, src_addr);
@@ -415,9 +404,10 @@ static int pci_epf_mhi_edma_write(struct mhi_ep_cntrl *mhi_cntrl,
 		goto err_unlock;
 	}
 
-	desc = dmaengine_prep_slave_single(chan, src_addr, buf_info->size,
-					   DMA_MEM_TO_DEV,
-					   DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
+	desc = dmaengine_prep_config_single(chan, src_addr, buf_info->size,
+					    DMA_MEM_TO_DEV,
+					    DMA_CTRL_ACK | DMA_PREP_INTERRUPT,
+					    &config);
 	if (!desc) {
 		dev_err(dev, "Failed to prepare DMA\n");
 		ret = -EIO;
@@ -506,12 +496,6 @@ static int pci_epf_mhi_edma_read_async(struct mhi_ep_cntrl *mhi_cntrl,
 	config.direction = DMA_DEV_TO_MEM;
 	config.src_addr = buf_info->host_addr;
 
-	ret = dmaengine_slave_config(chan, &config);
-	if (ret) {
-		dev_err(dev, "Failed to configure DMA channel\n");
-		goto err_unlock;
-	}
-
 	dst_addr = dma_map_single(dma_dev, buf_info->dev_addr, buf_info->size,
 				  DMA_FROM_DEVICE);
 	ret = dma_mapping_error(dma_dev, dst_addr);
@@ -520,9 +504,10 @@ static int pci_epf_mhi_edma_read_async(struct mhi_ep_cntrl *mhi_cntrl,
 		goto err_unlock;
 	}
 
-	desc = dmaengine_prep_slave_single(chan, dst_addr, buf_info->size,
-					   DMA_DEV_TO_MEM,
-					   DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
+	desc = dmaengine_prep_config_single(chan, dst_addr, buf_info->size,
+					    DMA_DEV_TO_MEM,
+					    DMA_CTRL_ACK | DMA_PREP_INTERRUPT,
+					    &config);
 	if (!desc) {
 		dev_err(dev, "Failed to prepare DMA\n");
 		ret = -EIO;
@@ -585,12 +570,6 @@ static int pci_epf_mhi_edma_write_async(struct mhi_ep_cntrl *mhi_cntrl,
 	config.direction = DMA_MEM_TO_DEV;
 	config.dst_addr = buf_info->host_addr;
 
-	ret = dmaengine_slave_config(chan, &config);
-	if (ret) {
-		dev_err(dev, "Failed to configure DMA channel\n");
-		goto err_unlock;
-	}
-
 	src_addr = dma_map_single(dma_dev, buf_info->dev_addr, buf_info->size,
 				  DMA_TO_DEVICE);
 	ret = dma_mapping_error(dma_dev, src_addr);
@@ -599,9 +578,10 @@ static int pci_epf_mhi_edma_write_async(struct mhi_ep_cntrl *mhi_cntrl,
 		goto err_unlock;
 	}
 
-	desc = dmaengine_prep_slave_single(chan, src_addr, buf_info->size,
-					   DMA_MEM_TO_DEV,
-					   DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
+	desc = dmaengine_prep_config_single(chan, src_addr, buf_info->size,
+					    DMA_MEM_TO_DEV,
+					    DMA_CTRL_ACK | DMA_PREP_INTERRUPT,
+					    &config);
 	if (!desc) {
 		dev_err(dev, "Failed to prepare DMA\n");
 		ret = -EIO;

-- 
2.43.0


