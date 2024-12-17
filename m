Return-Path: <dmaengine+bounces-4008-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 196479F4DB7
	for <lists+dmaengine@lfdr.de>; Tue, 17 Dec 2024 15:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA98F1687B3
	for <lists+dmaengine@lfdr.de>; Tue, 17 Dec 2024 14:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32CB51F4E36;
	Tue, 17 Dec 2024 14:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="xIS/VIZj"
X-Original-To: dmaengine@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013047.outbound.protection.outlook.com [52.101.67.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBAA27470;
	Tue, 17 Dec 2024 14:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734445750; cv=fail; b=CZFV7DcAA8e9y2JS1tqj/peieuC8pcJ61nL0wbZbPkgFYLO8YSHRul1bb14+MJycTygem6NgYM7J4EbctNwjfs9nUxTvtf9cdgw107e7V9OhR9HxpfWoqUjPRVShq1oNv+8LyxdC7S47HLe1LmKnEOlgD+LVUMA6bB++I337D/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734445750; c=relaxed/simple;
	bh=4vHwRm8bqPS/GR8caszhMxIHaGRs6okzqYUJ64AzVHY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RXlRR4TvzqogAFg0lsbkyUAzeEN2kufcbrUG72HhoCNZKgM0Ko7OzvgvjMVGxWRjbTOV32dAhdwxY+o/0GZXHTry8JkUWH9jzHpKFaf6hiwecO/3+9/ugq8YQYnrMGERUX38wg92S1KUFW0k3F0NiuLiOMZPp/Hc8y4e67r9J0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=xIS/VIZj; arc=fail smtp.client-ip=52.101.67.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=usQ0c6Yn18noBfHzEQSflHr7ZBhOF353iBD4o+MSFoFai7VNnja3zl0Ht0UUc2M9YkojjZxhX2ex/RyUUOxCUSNq1BFmhUcbuNgoMHVt7qoWcrqhdp1L50fT1a99GFwsUx1KAZVitSz0w1vWN0T0LshJ8TIMvFSYFBz2vW5uBesOwhbeVANhHPKo+vWg2PQSBi3dxkiHprNiveqRvcy5dT6jrWH4tCFmVkQA+kwRU/9/s15S/+f8lzB3FgP2BvPT1updSI+VjJF03bAZnonH+Tq2E9GJLVGcj+Yq+5g4NgVGkDoWLiZwgPvqyFvKpCNobdfwkgnKkKEYrt8NpwPYBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yspKZkJsF7LkF3cvUUAjeLxqLDNwmDgDd1DQf78qBeU=;
 b=lOXRWhLeB+uyzQDJ5XBWB0sXi3rEz2Xzf90PRWX3R9MZu91JPOoWNIK+Vxi9BnefEdg7DuOzv50j6TcOt/LD2KhbijuuAtqSNGDXJpR3gZa7fFTu3cbnOFDuBaLtMVp795OupKtKG0Kw3UP0rWyMsi7AtNZfX45sZqMvNSHumQegdsHrA8tgAY5O0ZVKtD0J7OqJEnADgl4ZMbDKzm6qbWGm4Ile3vZypD2ZuDIpuVd5RE+XwaCfXjS20v68i7hFl59QYhxMJV2z2GQ5XjMw7jpxZssfz+gwQ9vVWIE61J4jqCOmRJMPJ/7pY7YWgMwW+US7Sy5sUGqlP2dp2IFiwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yspKZkJsF7LkF3cvUUAjeLxqLDNwmDgDd1DQf78qBeU=;
 b=xIS/VIZj7PujZeaf3+KLjx2UUKLHlaCAwP54n5+hKxoBgkevdiFIaJu8+QjG87N5H82hcKmTEaQLNpaydDfUR38lDxzzbK1/slRNe7fgJnMB7fweW31nLCfnKw/UuX174cUv5ImGY0vyMnLvy0LaAE+jVhXKKNZi+TBTW9Ttc0pziUBFVLCo7SgjrUzglTZYiTWOryzCe6aK0uRucz1XE1SnQdYSw+3bym+AdO3wbiRp6MSk3TAV0k7IC2lkj3GLdEifYFkASDy54519qha6KczDwQKGvtbQ5o9F6DeyhizoFrDdg2wW6Fpt8aT/GEQtx9rRgj0E1Zh3kZWj25HHAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9550.eurprd04.prod.outlook.com (2603:10a6:20b:4f9::17)
 by AM8PR04MB7235.eurprd04.prod.outlook.com (2603:10a6:20b:1d1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Tue, 17 Dec
 2024 14:29:05 +0000
Received: from AS4PR04MB9550.eurprd04.prod.outlook.com
 ([fe80::e28d:10f8:289:baf7]) by AS4PR04MB9550.eurprd04.prod.outlook.com
 ([fe80::e28d:10f8:289:baf7%6]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 14:29:05 +0000
Message-ID: <e52a6aab-7981-4564-b057-fcaad396f45e@oss.nxp.com>
Date: Tue, 17 Dec 2024 16:28:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] dmaengine: fsl-edma: select of_dma_xlate based on the
 dmamuxs presence
To: Frank Li <Frank.li@nxp.com>
Cc: dmaengine@vger.kernel.org, imx@lists.linux.dev,
 linux-kernel@vger.kernel.org, s32@nxp.com,
 Christophe Lizzi <clizzi@redhat.com>, Alberto Ruiz <aruizrui@redhat.com>,
 Enric Balletbo <eballetb@redhat.com>
References: <20241216075819.2066772-1-larisa.grigore@oss.nxp.com>
 <20241216075819.2066772-2-larisa.grigore@oss.nxp.com>
 <Z2BSYwDpo/CTByfZ@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Larisa Ileana Grigore <larisa.grigore@oss.nxp.com>
In-Reply-To: <Z2BSYwDpo/CTByfZ@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0205.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::12) To AS4PR04MB9550.eurprd04.prod.outlook.com
 (2603:10a6:20b:4f9::17)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9550:EE_|AM8PR04MB7235:EE_
X-MS-Office365-Filtering-Correlation-Id: c9aa2eb8-dcff-419c-a3ef-08dd1ea72397
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bW5wTFNQdVVLZU5lZkp3ZHI0M01XK3dWMFBVMzZMdDQ5YWRockxmdG9vaTJK?=
 =?utf-8?B?bTdpbnZJSHAxWEZkYWk5UTVnemJ3UnFBMnI3eXdMS0lvMWt3MytUN05TVHV3?=
 =?utf-8?B?MWNzNEl3K1E3b0VISG1sZzJhYjFVSEcwbzdXSDlIL3RlSTdPazAyS0FiWXI3?=
 =?utf-8?B?UlBqSTlURnVuT3UxcitZU04wZWZxS1ovZ241VXhoWFU5M1lkWUVHYTJHbVBL?=
 =?utf-8?B?TkYwQmpvVHlXcndmUFpvb2RkZzhseFVaczVuMU5GclVERGhpN3llY2VRQ2hi?=
 =?utf-8?B?RFhDc1JLZHZEK29RdVZnWVl0N3d2VVk2SndwVFNMN1cxYzM2a3Rxclo5VjNV?=
 =?utf-8?B?TjRKUHZqYVlDMUtCTGRtQjJBL0Fka3RNaDJFbVVmdWg4UHhsenJrdEdjdDBY?=
 =?utf-8?B?MVRLTG9BaURMM2lYUklhUTdISGNCR3d2aCtaUC9QdSs3dGZnRm45RnBwVkhI?=
 =?utf-8?B?N29XalNScXFUTnU1a0pGbEFpNXZzeFZ1eHBYYmVBVmpGRk9KbXFuRzkxVllF?=
 =?utf-8?B?OVZ5TTFkNzFDejF5b0RRVndkakpQM1pyU2tFS0VQWXNEMklkSGp1NkNRalFU?=
 =?utf-8?B?Y1NUTjZmS1FyeXB4MXJBSDZkazl1VjhHRWRzSld5bzZEMjhrdUhnSjJRQzF6?=
 =?utf-8?B?QStFWE45U3dNWG10RVNVUFFzOE5mYlp1VkU1bm41eVI1OVpUOEQ0S0dnMDVE?=
 =?utf-8?B?QmR6VDFvQStoY1Q3NXpibFIvSS9XdGJQSEkzVDkyWnVIRnlsSndzTDJ5WFJM?=
 =?utf-8?B?MzRINk5ieldiNnhDS2VOcHcwQ1hlQ1JvbUFYU25XaVlYQ282ZUxjVGg2L1VZ?=
 =?utf-8?B?S0pDNWFFR2pUUEo0UFlwTjRKTEFEcDhXMzRXVTZLODRkamh1MW9zVTJ3aFpF?=
 =?utf-8?B?QW9iRTZxZlMvR21RSTBENXhubW9FSEE0MlZLeTl5TzZ2MkU2Nlh5cENtSkRm?=
 =?utf-8?B?VTdoaktkZUpBTi9MMjdXUVdKUDZLT0FxN1k3YUxqMkE0SlNFZldwWUpZdWR0?=
 =?utf-8?B?Yk4xc2NrN0VFV3JTN2ZpNGEyMHVic0s3YXJuMDM3U2V6d2pHM29wZnFHY1Qy?=
 =?utf-8?B?K3d0bzJ6T3NPQmdhK1RmYTVVKzkrZDFlTXU1aTZCbUhacC9qbnpwZEFDbUJj?=
 =?utf-8?B?RWNBSU5adTZEekJYLzg3Q0Erck8rUEJiSmJMZ2FGWkt0UjkyZ3YwMGNRaklz?=
 =?utf-8?B?TEc2OUVLSERhdkc2UEhnYWpPbVd5VHVUV2hINTFUa2Ywa2ZuUGJ0VW00MmNL?=
 =?utf-8?B?ait3OFFzSTNpVVk0OVJmNWREcE9xajhFWndjMXJlT1BNR0hwVC9VSlhiSmZM?=
 =?utf-8?B?anRCRWxJbHRlNXZ0L2x3cEp3VktLUk1zQWk4Ym1VZSttbjFxcnFQK3Z2N1VX?=
 =?utf-8?B?ZHZCcVBENmFNK3IyZzhybFZLLy8yNksrTUFQTFEyQ08vbk1qNldFMFBuUVV1?=
 =?utf-8?B?T0lXN21IazRsbEl0bVllQ05GUUc3R056SXpvSmlENUt0UjQva2h0TTlJYUVp?=
 =?utf-8?B?cGJMM05udFJDaHA0UUdrUy9CVkxZMmE2ZHRmdFR3alJzc0l4WjdCQ0F5U1dJ?=
 =?utf-8?B?OXlPeWdTOUF1d2ZDYWFFZWIyWm80anlQYmVPZHFhd1h6K0kyQjh6czQ1Q0VL?=
 =?utf-8?B?bnFyVkFGdWhrSmFNSVY3c0tUc1ZDRHhaUThvT3MraTFiTXBwbG9EQWJDZm5T?=
 =?utf-8?B?YkxnYTNESFphNkcxR3p0TDdqUVFoeXRiRlIwUi85MjJURFQ4TFo4ZU1CZVAv?=
 =?utf-8?B?SlJlWWNRbjdFVitZUGVLQ1dTM0NlaGgyTEc4UEVPL2treldZcjdzVHVaWjdO?=
 =?utf-8?B?L3BYNSsrOXFUU1l1eEYva2I5bW1IdDNqMm5jTXZwbkRQd2NMeUFLVEo1TlQ1?=
 =?utf-8?Q?breEvIBl8hUH5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9550.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b2luWTV2TG1HWDZCV3FBNTl5cGIyN1NRaU1NUTEwODRGZTlLUzdBMDhoTnlt?=
 =?utf-8?B?OW4zeS9ZelJlck9iS0M0VFZyWXlZSnVUaWdtK3MrWWh2eGpoVkFtazhXcDg5?=
 =?utf-8?B?V1hsa25TYUh2dHFKTG90cCt3Z1lXSCtDKzdLTkhRUzE0elk3M0FSVlVMUTZL?=
 =?utf-8?B?am40dTRTYTBkOTlxV3dKRjNKZXlGRXRTL3VsUEtDQzVVUFRreGprTVdCcVpr?=
 =?utf-8?B?TE9HTUZqVUxYUVRZeTZDTG9IaXJmYUxaYWs2YlVhNGhJT09PUWx6ZVdleXZZ?=
 =?utf-8?B?VkVQZElxQTJXeEpLV3ljV0hvVnlSTXJRQUd1RHl1SlRiZi9FenoyeGZLQS9K?=
 =?utf-8?B?VzE1b3BYdTI5RnNZb3p2YW9Qb002VWxtRVdaWjEzVndCZEZIZzAyM1VybVlB?=
 =?utf-8?B?eHV6L3EyNk9YZjAyNmNxb0R3cDQrbURLTktpdmFwdkxsY2gvbHJLa01uNDBC?=
 =?utf-8?B?MjA2OVFlalpQUjJLZm9pOXpvMFY2dFk5SmtwaWJKYmFJSy9Rb1pON3VvQmM2?=
 =?utf-8?B?RVlyMk8wK0FDSE11eTdjODFjYkxVcWJvNS8zWXloZ2s0TGIyVlZ1T3lYN2JM?=
 =?utf-8?B?ZTgzbTRBN2l2Q2ZLZzkwOGk4U3I0T0JKdUZ3RnNGb1dSTjBnTmFNOE5WVmJ3?=
 =?utf-8?B?dFdBTDRCdStpK2dZR3JaSDM2cndCSHdpbm4zaTVtY3pyLzdhcWY5L0duMjF2?=
 =?utf-8?B?cDNBU1dORUUzSmpLQkRYeWlwOVA5VXpmV0VBSjcyT3hVazhJN3lSZnFKbWl0?=
 =?utf-8?B?MXVidVIrRXg1emVNVWlVcU5aTVlmN0xmNm1lR2ZrTk4rSVJKajV4aXlyUDBH?=
 =?utf-8?B?cDhsTDNqd2lNSElja1IvcHFmSGw0eFBvaW0wbm0xNWZzUmpyTXNSdHgrbGtU?=
 =?utf-8?B?WkZYR244dVNZMzZWT3ZkN0w4SmQ2OHVtdGI5bWRZc2hRcHVONzBvMjY2blI4?=
 =?utf-8?B?WWpBMjZzdFVOZ2ZlR0tkTGJxSGZWakpabGp3UjFReUlwOTNvWEFmRGVwNkZP?=
 =?utf-8?B?WURhcmRKckZqMWViQ244Skw3TFh2S00yUGhSUjF0bkVSaEJSTkUzcHh5TzVB?=
 =?utf-8?B?QzJxNmFmUG9qU2xlbFA4VTNSanF4QmdSa1hKbEg2OTdoTHArVXVUUmJ1YXkx?=
 =?utf-8?B?clNVUUF2SFdxNDRaUzdCTk84U3VSTzB5UXc5QmorOUlqUkxnWVZiVVBoZVNk?=
 =?utf-8?B?SkNzSjAxcVIrVW9QdVZRaHYzdlNZL3IvbFhqT0d2T0JhcU1KUnVESVpPc1hS?=
 =?utf-8?B?RDJDeU5PMWExZjc0RTA2dGZiQjBVTXA3TUlFdSs1L2oyOTI1LzNqZXpmSHJF?=
 =?utf-8?B?MDF0YkVNdURDS1p0VXA4WDEwNkZtZkd1NHo2eU5BM3R2QnRaLzJmampkR2k0?=
 =?utf-8?B?bmNOZFBLTmZGNXpzWFM3TlQvZ3g2UUN4NytiRUZ3SWc1ZmhOdnhLTVJIUml3?=
 =?utf-8?B?WTY4MGQya2wrempmV0ltZ3NqTWF5OTVaK2Q1SWxYbEQxb0pFNUNXMzc4N1I0?=
 =?utf-8?B?aXg1dTZXNURaYjFDSzRXR2dZWmlBTE82eFlLRXVyYzAzWlVUSW1LS2VYZ3dD?=
 =?utf-8?B?UDVIVGdmU2ZmZEIrRHFMZDBlZEE2aUdpSVB3dVVkSjdOejU3T2Z6ZU81V1pk?=
 =?utf-8?B?VTdEWnh6bGVlQ1V3T1RtY2NtcTAxdm9XVDdmY1VPbEgxNnNLaWhDSDBMb3hO?=
 =?utf-8?B?cjlvTFl5SDBndXRKcGZIdzJRdmtkb2E1MDFTUGdEby9QK1lRQk9hVXliT2pl?=
 =?utf-8?B?d2ZLWnpjWkdWNHliN2hOT2JvaXNMQ3JkZ05vbGcyQ0RzMUJ5RFVaZncreE1W?=
 =?utf-8?B?TDF2UmlJQkZ3ZG41bFlrR25wT1IyUWl3ZURHMmY1QVV4OUVoK0hqTStrcWlr?=
 =?utf-8?B?bS9zclFOWmdxdUY4N1VRbStNODVxWkcvdU1yR1BuSnZZbnBKYkV5SWRmTitl?=
 =?utf-8?B?Qkx1TGNmNTF2TVlqUGtiei9pQlljZFVXdHhmNTVMZGhqQXZzTjJaQVhLN2JX?=
 =?utf-8?B?bW5venN5RjJIWDlqSXExdGkxM2JzSVJFcWdwdS96eXBNeGF6Y2V3d2Y2SmFp?=
 =?utf-8?B?Rk8vVGVRVFhZVVhkV3E5MnJwS3dlTUZSTGRvaXArSng3VXBhQU80emlRd2N6?=
 =?utf-8?B?UmVkSHQvUStzdkRwVVFtellmM3RKaUQzb2k5U2pDWFladHBiV2daMkJzUm5U?=
 =?utf-8?B?ckE9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9aa2eb8-dcff-419c-a3ef-08dd1ea72397
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9550.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 14:29:05.5139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OhZ84F2o29WWH/ZG8nXeVraLAK076QD8zA5wgvEV8Kgy0kQuJ5bxz/JDSdCd5OKkRS1xII6m4RXLMHLkTRD8eQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7235

On 12/16/2024 6:16 PM, Frank Li wrote:
> On Mon, Dec 16, 2024 at 09:58:11AM +0200, Larisa Grigore wrote:
>> Select the of_dma_xlate function based on the dmamuxs definition rather
>> than the FSL_EDMA_DRV_SPLIT_REG flag, which pertains to the eDMA3
>> layout.
> 
> Nit: Add space line here. Need empty line between paragraphs
> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> 
Thank you Frank! Will be fixed in V2.

>> This change is a prerequisite for the S32G platforms, which integrate both
>> eDMAv3 and DMAMUX.
> 
> Nit: the same here.
> 
>> Existing platforms with FSL_EDMA_DRV_SPLIT_REG will not be impacted, as
>> they all have dmamuxs set to zero.
>>
>> Signed-off-by: Larisa Grigore <larisa.grigore@oss.nxp.com>
>> ---
>>   dcrivers/dma/fsl-edma-main.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
>> index 60de1003193a..2a7d19f51287 100644
>> --- a/drivers/dma/fsl-edma-main.c
>> +++ b/drivers/dma/fsl-edma-main.c
>> @@ -646,7 +646,7 @@ static int fsl_edma_probe(struct platform_device *pdev)
>>   	}
>>
>>   	ret = of_dma_controller_register(np,
>> -			drvdata->flags & FSL_EDMA_DRV_SPLIT_REG ? fsl_edma3_xlate : fsl_edma_xlate,
>> +a			drvdata->dmamuxs ? fsl_edma_xlate : fsl_edma3_xlate,
>>   			fsl_edma);
>>   	if (ret) {
>>   		dev_err(&pdev->dev,
>> --
>> 2.47.0
>>

Best regards,
Larisa

