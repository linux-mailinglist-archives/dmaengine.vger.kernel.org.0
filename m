Return-Path: <dmaengine+bounces-12130-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id H5S1JdKYTmrmQAIAu9opvQ
	(envelope-from <dmaengine+bounces-12130-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 20:37:06 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BC17298F1
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 20:37:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=YrJ5Wg4s;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12130-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12130-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 53E423065BCB
	for <lists+dmaengine@lfdr.de>; Wed,  8 Jul 2026 18:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CDB4CA26F;
	Wed,  8 Jul 2026 18:35:36 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013041.outbound.protection.outlook.com [40.107.162.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121C64C9011;
	Wed,  8 Jul 2026 18:35:33 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783535735; cv=fail; b=l0+8zSqg5ZEzDxaHq56h0pZseMtTq4kGSJVRlFW3eb6IRv69IiNJdnwysiXTzyRPBnbC8o1NI3VkYc083p4+ECpTXdTxhvOL85lw0wWA9LznBq+NlRDqcQlA3ZRBArUmM4lENMiY8GMND3if8zg60anucY8NG4xIcG0XtaBqzjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783535735; c=relaxed/simple;
	bh=5ADtYYT9nHGg9r75fUUmD7kP+ZyXYecz9fkvhiP75w0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=fs2f0ZoICPHF28pkUBJpUqiDcch1cqH/DGXOQ0aiB8YV9afKlmfV1xKqoC07ULjDsUTfmiW9HKB1SElqAVsZc2B8C9ptHSj/jokEQgFmj2iR7kMflNVLF+hMp8WD0qrlJWHpCOqZ96JwSweq5p41X4FkcDX97XbDEVZ1mhpqsnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=YrJ5Wg4s; arc=fail smtp.client-ip=40.107.162.41
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OHrqqnFRVYhqRby2ft2GuawIFidGNUdGakK02mY/H60wH2kMdiRih7d1PqyEeh87kJ5DWH44sIQGbQngkeMQ9D9dtd3h6F5wP7aCjAFs/imnnljJVdnLmGCxhp1H3+4JOkbb+gXwyHZVyR4zNwVsvpy8eo2imsLjMtb9+CSFiFAtJbd4e2zbTIi4IpAZEXK3En+j9x/Ko6N+iBcki7+y64R8kx5nnW7AdE4knosBwSy2sBOdvHNPwxWxNwuizBGdV0T/740NMINy5vRXxgcfyhPTzs8lbfZVX+lptyc4lzm23QSRERUEjLmrG9K6vXK6nK551/GgKVLy5fCuyJm9Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GfKHLiRpgb8s2RveiTCExK/O4zj6D4vRxlr8Y7CudGA=;
 b=nTQy950AFWP9NH7gpflED7tpJjjIkcrANJPCj2LvQgpZFtXytbxZimiLy06SIbmqV4CHeTLBWh8rAbMW4jYvs5mOITgyrXKE7JXYzeGQxMOZXMWk3Krw8sSUaLUohqmOYt7P1Ny7omwMrM6t0+Ex5shAeStwdEGWhjiXF49XAoCo7ydfHkjuG07Md5XJsRzYDogBk1TnUmcnmhOfBQuKQ4z/VWmBHIPTyEH9qstir3KU4pZqsUTy79qfhC9YFGd23MAgLwYGN7JpQvI3ZuApnrrbXMo5TJEBNHdToM0p8gXeHBX3nlGVDslVDKdJBW+wYf+ap4MSXBkMwVoijTf8Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GfKHLiRpgb8s2RveiTCExK/O4zj6D4vRxlr8Y7CudGA=;
 b=YrJ5Wg4sdL1+EDa3AvlqjrqlbQom9RgydXpzy1xpjTwRwXe+2s8MDxZMvLFYG6U/S+HNfu6la42lSJVfoLc0tKt3/rrj3pegdhJ1MeKKrVu4aQy7Cnn90Tox0SNr40aaiFFrLYOusBYl1OqAN5wrq7qQthOz3y2xlFwSY0sVk/Gl2l90gZ3ubwIAP+Y69e2MnqL9W9n7rjvmEtsQTtgyE512h1AKRkdETX1W/7MhgadhqS/Ubx94F0Uar0nI0Yk9YHBzWOifce38RN7Mn4QF+qxcufjSdTsSNg/ztUFL5OUuSQrJjFZKMaNNmyxDAEENOigwlzR0jQ8P2fwyhLWPcA==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI1PR04MB9810.eurprd04.prod.outlook.com (2603:10a6:800:1df::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 18:35:30 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Wed, 8 Jul 2026
 18:35:30 +0000
From: Frank.Li@oss.nxp.com
Date: Wed, 08 Jul 2026 14:35:04 -0400
Subject: [PATCH v4 04/10] dmaengine: dw-edma: Pass down dw_edma_chan to
 reduce one level of indirection
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-edma_ll-v4-4-cc128f0afb61@nxp.com>
References: <20260708-edma_ll-v4-0-cc128f0afb61@nxp.com>
In-Reply-To: <20260708-edma_ll-v4-0-cc128f0afb61@nxp.com>
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
 linux-nvme@lists.infradead.org, Koichiro Den <den@valinux.co.jp>, 
 imx@lists.linux.dev, "Verma, Devendra" <devverma@amd.com>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783535707; l=6919;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=ErdapcPMmXhUaz/yq+JBAR/2OB2luFQ/CFcEy+/xZuA=;
 b=ItHMJshNX5br81xtbDkfiN4bKAURlGS9nqZcpyBdJ9jakeaCGhSHt/gx9Aw65TIjxsxdo76Vm
 3xLFtuokIIGDbo8uuZsDKJYlIew+zEUYQRhkpmkB1Lt8th0kH50x4er
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA0PR11CA0118.namprd11.prod.outlook.com
 (2603:10b6:806:d1::33) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI1PR04MB9810:EE_
X-MS-Office365-Filtering-Correlation-Id: 9302a07e-1581-45e1-bb07-08dedd1fb050
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|19092799006|376014|1800799024|23010399003|56012099006|22082099003|11063799006|18002099003|6133799003|921020;
X-Microsoft-Antispam-Message-Info:
	9GZWNgGZUSVrwFITNv87vWOcPnjtbC6nDEtq53L7gPh6+Vw621ny1pk/5+Q+BQ27NZRfmXYMxQK4h0Iinx9A+IAROoRQDelpUHZNYe1mbbksYMsW67UKn91jHqizfFh1FjsdJqGbTqdwiRdZVhnMvDdKXIpxC/51cPA3Mq4NtJUjFZmbrP4XcCCTeuuFmEFoxO8KLMBmx35u1YB7hq8NIskONTxe64gcY45GjRycrxMLY2B9s3qRxp7xrHZm7fYG3omKEk9ZZUqfiDvWUZ2dlWzoshlMIuA2Q9aP0JHXsaNex/7PpIc60aq6x2Y1pN7WbXtcAThbZ+tjNvlj7RXx1H9Cysg/s5FE4pz33pJrdgBvHDgwssYkv41k3JNewu3qYtGDgvSovvsvrULfgt/swM5wOL9end/CbUWz9sPDUD5O+ZUOEhCqIxFbNviE3WFq9L/DAG/X8D9NMBt3l2RChlSMPsIeEjMoFxYiXdgqrBi9jXepXr3lBVGrAvwmsDXdN23jiKuQ/KsXs7vwvLBrWZ43MjB2KT+5CeLl5ZOerO8L41MRDiSROMA/70yuo6Sa/odn/lmG8nTDoaHZoAJXzmcwZi+bN7KoFs6xC7A+a+Nb2pRRI/CTIRUI2qbYmI8fHlqGxwj/DUy2KIu2VojB3o21nrLknNnxQv/MAxr4XbYrDo4fH4zFhcbkLBkeARcHpaJob5RT/JcsiZbD0FuMOQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(19092799006)(376014)(1800799024)(23010399003)(56012099006)(22082099003)(11063799006)(18002099003)(6133799003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YnlZQ3ZVd2R0eU5Zdm41VTZDRWdTaXJUZXNQc1JpMERiQzNpNUxyZ0lyenp0?=
 =?utf-8?B?cDNrY3hyV295WnRDa2lnMjIyY2lMRjloWHZCNmdMNTR5NzdvdnI1WVptMTNh?=
 =?utf-8?B?Mkptejk3Tm8weE1XeDQ3d3hyMTZuaHQ4b2RmYW5henh5Mmc0QUpYSHk4SEdz?=
 =?utf-8?B?VXFSVzRWYkkxUlZFZzIrVm9HZGtwMzJaZ20vK3BMMVh2MmZ1QWpCemZLUjVk?=
 =?utf-8?B?U3FveUtvSVEvWk9NMzBqd0JLeFdMNlY4MGZOaEJnd0F3UmJiQkFKRWF3SzlY?=
 =?utf-8?B?S2FCL3FGcXhwWE5rclVSVGhneVFFd0dMZ3d1MytmMERYMWZhRnVNK1hhVGMz?=
 =?utf-8?B?dzhyU0IwZTQwMGlXOXF1T2VtSDBLNWQrYmpqSnI4Vndwc0hqY043OVl1YXBG?=
 =?utf-8?B?SWNnSVdGWU5KR0NFUlcvWFdCK1Q2cGdsNWp2dXFTZG0vN1puMmk5SUZyWExG?=
 =?utf-8?B?SjBvalFweVgyQXNGVitiVEN1YUhOL2hvc3lUYVJJZzNKL2ErZXFBRExRaWVO?=
 =?utf-8?B?UjVSQ2tCSlRnU2tTVmsrRkoyM2JHUFlud01hc1lxeDY2eDRBMElCZlJmM3cy?=
 =?utf-8?B?TFlpMFdzUTc2OU1sTzJ0blprbHl6cnRTZTk2d2dDa0xoNEFsQnpBbjN3Mkty?=
 =?utf-8?B?NS9GTDA3NW05eEhUaWdHMTE0MFhZT0JTVGJEYTNvY3RsY1M1dzRUdmRGaFpD?=
 =?utf-8?B?aFdSOEl6ckNxWGRKZXJuNGp4KzJFQTZZWE9leklxQTdGRnBkWitYUGdXRG9m?=
 =?utf-8?B?T2Yvemw4enpsRWlGSWVEQ0gwMU93bXk1ZmRQWStNSWVqZHdsbTdyc0JlZEZ0?=
 =?utf-8?B?REtPRlJDZCtkMXY2ZGVYbnhJdHNJci9IQncwMDMrR01jWStlOUg3T1AxcXFp?=
 =?utf-8?B?RUU3Zy9FNDUrZnlIazVWMDF3dXBRTmZHNFlDekl0djkyeGFIUTIvb1plbzJX?=
 =?utf-8?B?ZGpITUl2ei8xbjMwTU85ZExiajlEWitqd2gwQUdVZWIvd1JzWnIxVEJRSGxY?=
 =?utf-8?B?ODYrWC9jY1IzK0psNmN6ckpwdnlhNkFGSFJ1VlorUjAzK3czWWttLzRRN1ph?=
 =?utf-8?B?Uk9yNkdsZ0FRMUQ0aFJFcHNjZSs4ZEFNU0hRWHp3M21hbEJ4ckRsaEQxUjh5?=
 =?utf-8?B?SkJONTFTZ2k5RGVnZWhOeEJoanJSQ1Y5Sll6RTArSkd2bzljZ1d3dmZYMGdn?=
 =?utf-8?B?bHRUOHFLS0J3M2QvQW9sTTB6bHRsYyt4S3MwYXlxcVlHRUNVbnAyTGNMNVI3?=
 =?utf-8?B?RllEcWU4dXZlQ3hSbXpnRnZqbGtPMDFYTDJMa3EvQlQ4T3I5Mm1HK2J6NzhH?=
 =?utf-8?B?cHJxWGFTMlArY3l1TVRVeGd5dVFyWmx1d1dLQXFlSUJ0amMrMWZXa2VvWHpZ?=
 =?utf-8?B?NEQwVFNSOXVIbDRheVl5Zkc0MVVmRkdSR2hqbjhQa2lrUUVnRDd6QU5ZaXdp?=
 =?utf-8?B?Ujc3a0MzbmtDMmdiY0JXSHJqUFkrVVg4ZENBSkhzVHdVaS9LcUptN3Y0SG1P?=
 =?utf-8?B?WDVHVEVld21vcDhWdGVtWkl3UzByYkJJU1MzdnRQVTFJWWlsSlJhbDlhK2ZU?=
 =?utf-8?B?TitNeEhxUU5NY29hRm1jU3RsbkV6bmRyUHVPa1NsRWJoMGNyd0JGbjlsc2pB?=
 =?utf-8?B?WVJnWFVsbkNQNFVjcG5kZzRBOVBvdVo2N0lnbGN5VDZydGRYNUp4cmJJVGNi?=
 =?utf-8?B?VFZMWGxBT3F0Qm1FVzdmL1BGYVpwcHNTcmhTWVdjdTY3aENjNW5rRDdrMUMr?=
 =?utf-8?B?bWo2Y3JCcE9jVktZdWpNOFdBWmtPaHBaTFMrWXVoR1hPMEhvLzBzeCs3aW9t?=
 =?utf-8?B?bVFubTc0UExrc2JkL0Q4YVpDY0lWOWE0bmZOdEtEMjVpUStOdXRUYmF6N21s?=
 =?utf-8?B?dUM0S2Npc0JHaWFkejIyRnNJeDhoSzc3c1NCaXUyVEVyYzlWY0RGREloYUo3?=
 =?utf-8?B?YlN1OXBDb2kwY0tHY1B4bEtNbGRTL1FiTWExd2QxSnV6aS91YkxRNWkzNmJJ?=
 =?utf-8?B?OVo2bTY0dTUvRnJNNFNhM2ZwWnJpVDIyeU5RczBVWHRBT1ZqREFQVlBFNGxQ?=
 =?utf-8?B?S1FoS2hCMTdBWE5IMVRudWQ5N0ppeHc1V2xrOUp3LzdvRDhCV3lRVE9mOVAv?=
 =?utf-8?B?cHB1cDg3bzRxUzFBYmw1enNiVENQS3JxUUZxd09NSUpOMDRrVnliMWNvRHNa?=
 =?utf-8?B?SkZyT1IzN3ArWHFWVy8zS0p6anZRWDBKYUxSOVZkMmJqN214WU1pQ0hvSjhy?=
 =?utf-8?B?d0VCZmFiSlU1bG83ZTZhSCtFeGF0MU1DVGIwU1FBK2hoV0NMR0tHRkxQbGho?=
 =?utf-8?B?RkNVcVBVdzhLYjBOVE9OK0s5NzJwMG9NWHVwTzdHZWEyRWg3b25NcHFPenRo?=
 =?utf-8?Q?+U81FyPRXtKA+NaYrKy2/WcefSMsEqHIJ53Q7?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9302a07e-1581-45e1-bb07-08dedd1fb050
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 18:35:30.7553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hR4suxeYxnwkxZpx8oDaN9BNB1dIMGtAhO9C5lFEELu3UUbMWSKfl60woOhP8CJplJE4zUrQ33JZDNx5PWDfflZwNE2B17Xem4VL+0RbLjQG+mjDTnDkIePEXNDBozru
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9810
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12130-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mani@kernel.org,m:vkoul@kernel.org,m:Gustavo.Pimentel@synopsys.com,m:kees@kernel.org,m:gustavoars@kernel.org,m:kwilczynski@kernel.org,m:kishon@kernel.org,m:bhelgaas@google.com,m:hch@lst.de,m:cassel@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-hardening@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:den@valinux.co.jp,m:imx@lists.linux.dev,m:devverma@amd.com,m:Frank.Li@nxp.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[Frank.Li@oss.nxp.com,dmaengine@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@oss.nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.nxp.com:from_mime,nxp.com:mid,nxp.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,valinux.co.jp:email,vger.kernel.org:from_smtp,NXP1.onmicrosoft.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 09BC17298F1

From: Frank Li <Frank.Li@nxp.com>

Some helper functions do not use any information from dw_edma_chunk, so
passing a dw_edma_chan pointer directly avoids an unnecessary level of
pointer dereferencing and simplifies data access.

Tested-by: Koichiro Den <den@valinux.co.jp>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
changes in v4
- collect Koichiro tag
---
 drivers/dma/dw-edma/dw-edma-v0-core.c | 22 ++++++++++------------
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 23 +++++++++++------------
 2 files changed, 21 insertions(+), 24 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index 51e50f1fdcac4..c341aa5343417 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -276,13 +276,12 @@ dw_edma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 	return ret;
 }
 
-static void dw_edma_v0_write_ll_data(struct dw_edma_chunk *chunk, int i,
+static void dw_edma_v0_write_ll_data(struct dw_edma_chan *chan, int i,
 				     u32 control, u32 size, u64 sar, u64 dar)
 {
 	ptrdiff_t ofs = i * sizeof(struct dw_edma_v0_lli);
-	struct dw_edma_chan *chan = chunk->chan;
 
-	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
+	if (chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
 		struct dw_edma_v0_lli *lli = chan->ll_region.vaddr.mem + ofs;
 
 		lli->transfer_size = size;
@@ -300,13 +299,12 @@ static void dw_edma_v0_write_ll_data(struct dw_edma_chunk *chunk, int i,
 	}
 }
 
-static void dw_edma_v0_write_ll_link(struct dw_edma_chunk *chunk,
+static void dw_edma_v0_write_ll_link(struct dw_edma_chan *chan,
 				     int i, u32 control, u64 pointer)
 {
 	ptrdiff_t ofs = i * sizeof(struct dw_edma_v0_lli);
-	struct dw_edma_chan *chan = chunk->chan;
 
-	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
+	if (chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
 		struct dw_edma_v0_llp *llp = chan->ll_region.vaddr.mem + ofs;
 
 		llp->llp.reg = pointer;
@@ -339,7 +337,7 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 				control |= DW_EDMA_V0_RIE;
 		}
 
-		dw_edma_v0_write_ll_data(chunk, i++, control, child->sz,
+		dw_edma_v0_write_ll_data(chan, i++, control, child->sz,
 					 child->sar, child->dar);
 	}
 
@@ -347,10 +345,10 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 	if (!chunk->cb)
 		control |= DW_EDMA_V0_CB;
 
-	dw_edma_v0_write_ll_link(chunk, i, control, chan->ll_region.paddr);
+	dw_edma_v0_write_ll_link(chan, i, control, chan->ll_region.paddr);
 }
 
-static void dw_edma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
+static void dw_edma_v0_sync_ll_data(struct dw_edma_chan *chan)
 {
 	/*
 	 * In case of remote eDMA engine setup, the DW PCIe RP/EP internal
@@ -360,8 +358,8 @@ static void dw_edma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
 	 * LL memory in a hope that the MRd TLP will return only after the
 	 * last MWr TLP is completed
 	 */
-	if (!(chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
-		readl(chunk->chan->ll_region.vaddr.io);
+	if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
+		readl(chan->ll_region.vaddr.io);
 }
 
 static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
@@ -437,7 +435,7 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 			  upper_32_bits(chan->ll_region.paddr));
 	}
 
-	dw_edma_v0_sync_ll_data(chunk);
+	dw_edma_v0_sync_ll_data(chan);
 
 	/* Doorbell */
 	SET_RW_32(dw, chan->dir, doorbell,
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 20089d57f8ab0..156b1cc225091 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -152,13 +152,12 @@ dw_hdma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 	return ret;
 }
 
-static void dw_hdma_v0_write_ll_data(struct dw_edma_chunk *chunk, int i,
+static void dw_hdma_v0_write_ll_data(struct dw_edma_chan *chan, int i,
 				     u32 control, u32 size, u64 sar, u64 dar)
 {
 	ptrdiff_t ofs = i * sizeof(struct dw_hdma_v0_lli);
-	struct dw_edma_chan *chan = chunk->chan;
 
-	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
+	if (chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
 		struct dw_hdma_v0_lli *lli = chan->ll_region.vaddr.mem + ofs;
 
 		lli->transfer_size = size;
@@ -176,13 +175,12 @@ static void dw_hdma_v0_write_ll_data(struct dw_edma_chunk *chunk, int i,
 	}
 }
 
-static void dw_hdma_v0_write_ll_link(struct dw_edma_chunk *chunk,
+static void dw_hdma_v0_write_ll_link(struct dw_edma_chan *chan,
 				     int i, u32 control, u64 pointer)
 {
 	ptrdiff_t ofs = i * sizeof(struct dw_hdma_v0_lli);
-	struct dw_edma_chan *chan = chunk->chan;
 
-	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
+	if (chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
 		struct dw_hdma_v0_llp *llp = chan->ll_region.vaddr.mem + ofs;
 
 		llp->llp.reg = pointer;
@@ -198,6 +196,7 @@ static void dw_hdma_v0_write_ll_link(struct dw_edma_chunk *chunk,
 
 static void dw_hdma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 {
+	struct dw_edma_chan *chan = chunk->chan;
 	struct dw_edma_burst *child;
 	u32 control = 0, i = 0;
 
@@ -205,17 +204,17 @@ static void dw_hdma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 		control = DW_HDMA_V0_CB;
 
 	list_for_each_entry(child, &chunk->burst->list, list)
-		dw_hdma_v0_write_ll_data(chunk, i++, control, child->sz,
+		dw_hdma_v0_write_ll_data(chan, i++, control, child->sz,
 					 child->sar, child->dar);
 
 	control = DW_HDMA_V0_LLP | DW_HDMA_V0_TCB;
 	if (!chunk->cb)
 		control |= DW_HDMA_V0_CB;
 
-	dw_hdma_v0_write_ll_link(chunk, i, control, chunk->chan->ll_region.paddr);
+	dw_hdma_v0_write_ll_link(chan, i, control, chunk->chan->ll_region.paddr);
 }
 
-static void dw_hdma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
+static void dw_hdma_v0_sync_ll_data(struct dw_edma_chan *chan)
 {
 	/*
 	 * In case of remote HDMA engine setup, the DW PCIe RP/EP internal
@@ -225,8 +224,8 @@ static void dw_hdma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
 	 * LL memory in a hope that the MRd TLP will return only after the
 	 * last MWr TLP is completed
 	 */
-	if (!(chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
-		readl(chunk->chan->ll_region.vaddr.io);
+	if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
+		readl(chan->ll_region.vaddr.io);
 }
 
 static void dw_hdma_v0_core_ll_start(struct dw_edma_chunk *chunk, bool first)
@@ -261,7 +260,7 @@ static void dw_hdma_v0_core_ll_start(struct dw_edma_chunk *chunk, bool first)
 			HDMA_V0_CONSUMER_CYCLE_STAT | HDMA_V0_CONSUMER_CYCLE_BIT);
 	}
 
-	dw_hdma_v0_sync_ll_data(chunk);
+	dw_hdma_v0_sync_ll_data(chan);
 
 	/* Doorbell */
 	SET_CH_32(dw, chan->dir, chan->id, doorbell, HDMA_V0_DOORBELL_START);

-- 
2.43.0


