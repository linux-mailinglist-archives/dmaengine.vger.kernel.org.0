Return-Path: <dmaengine+bounces-8572-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKYJMXfUemlX+wEAu9opvQ
	(envelope-from <dmaengine+bounces-8572-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 29 Jan 2026 04:31:03 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C444BAB73C
	for <lists+dmaengine@lfdr.de>; Thu, 29 Jan 2026 04:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2D0A73028642
	for <lists+dmaengine@lfdr.de>; Thu, 29 Jan 2026 03:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760E0358D22;
	Thu, 29 Jan 2026 03:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lGyWQmTr"
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011012.outbound.protection.outlook.com [40.107.130.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9943446B7;
	Thu, 29 Jan 2026 03:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769657454; cv=fail; b=PMTK2ojbS/pUnehOr3hX4ke17zOhPE8lsem5Cz1WsZsaMKlQwmQPVfqZYbvzbREi49orsOCj3YnFqKGfARKXeilH2G8rCLQI3U9suCyiTc5JcNstCrE/XnaeGCfaM8A8aUtNMmj02moLW5aJu7lGXR7UNsizLzDOJl3ZYO7Fnbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769657454; c=relaxed/simple;
	bh=A8SF1L6M44d+nhGpsvS3apcdj3iKz4UdlH2ldOt4EBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OSUw+Nm7kyzq0T1zGRt2f4FvgSTU0Z9Jf7Cek9tSrpn6CZ7ID/WAyk4MjfSxWLLbJwqrSfPG2BfDEId+OLZ1mtqbGOCR0GcIl9jbFFxEWrxOWTbHpWa85l/NfH18Mnl7e2GN0+wWhp8EckxiahjjmbqrA23Is78NsMhiL1FCQiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lGyWQmTr; arc=fail smtp.client-ip=40.107.130.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w4Q1tg5gEbwhJgwk7iv1Cx7ocnSVrpV/ipc8rGw7o8f2Q3qzzXB2+/H4J595oOyw0u9O5b9b27Sz8RBhAJwwEq/7CC+luchUqXa+BitmwkANtARzGIlLxg9Kowv2Yj5PUKL9QHJU9618cWDZip+ptA51CDjK74G0JLqRkBUvsbBAG339p5wIWMCOhap3wzrifhUW1hJML9GRZVR27Kau/9HIGWkTHoz8YL4NU3prnWwuUtav+IHgWzJckrMVrZTOSuYmou0g3GR2q3CVz+XkvdHc5ztoD7ksKO6YkOg/qy2FpRSfx43bWT0PnhFo3RJ+59isKM63f+cj34urt8BxfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7+fYJn8n/WL3OkSZ8oYZHFQduA9QkU5wrJB7v7OZfBk=;
 b=KxEdblrzx23R+8XQNtsDoS5/XhPw3mafvdS+UD/+twwYadtztE4Yvkh8auOSY4qxiO5fk11e/6mc+zjmSLQACZ+C+Qz1iHcEkflLTdbsMGye8CwKb/Z+YW02YZzWrEpyAo7plgsqa6q8+9DK4DuLwujAEFHWbEvd6m5AdLTMP0+sj13DzvwQzSN04MO9JJetCU13gvr6HkK5MIyKCZBOA8ZVwkZzkk0t9QpZJ+fXBhfMb7oA9jrgXWLkLZtmDBpXHjMsyPYYyK/eDUL2HyvwKC1Z/ldaornoW1X3AKVSbmYeGYdzB8F3GQ17pdemN9e4XYqWgpah9GQj/ND2+6xYTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7+fYJn8n/WL3OkSZ8oYZHFQduA9QkU5wrJB7v7OZfBk=;
 b=lGyWQmTrxB9kGfN3evagw3HxR6yzvnXf7GjiN+Fco6YCIYL6D3yZVz4ZuMwwC4GstlSWY8OEsRTUHHxMf+sI8MmpbRVS7lQlAPUtcnF26ep/ZnuUSqNEKLMkgLwSyn3bL9UCD1U0wHDkcrvYU0LareQr0PQu8M4leXF4+ryIMGAcDRZIKcNlfn6HXqdSKvggBw9br6ZOXBocfBLit3NF41abRoHrgrgw7Ssz/pWX3ro9TzMD6Ue9IM0IrvRvge8dCkar5M8+biu/leneAz9PQl9c19MRxn24eS3HgEfflY0cwlWN/xRB7QXz5KfpChQ2CfMDNRq1jpcge0EAnM6H8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DB9PR04MB9452.eurprd04.prod.outlook.com (2603:10a6:10:367::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 03:30:46 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9520.005; Thu, 29 Jan 2026
 03:30:46 +0000
Date: Wed, 28 Jan 2026 22:30:39 -0500
From: Frank Li <Frank.li@nxp.com>
To: Shenghui Shi <ssh.mediatek@gmail.com>
Cc: vkoul@kernel.org, manivannan.sadhasivam@linaro.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	Shenghui Shi <brody.shi@m2semi.com>
Subject: Re: [PATCH v2] dmaengine: dw-edma: fix MSI data programming for
 multi-IRQ case
Message-ID: <aXrUX4KfhWTnCs3S@lizhi-Precision-Tower-5810>
References: <20260129022024.3995-1-brody.shi@m2semi.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129022024.3995-1-brody.shi@m2semi.com>
X-ClientProxiedBy: SJ0PR05CA0067.namprd05.prod.outlook.com
 (2603:10b6:a03:332::12) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DB9PR04MB9452:EE_
X-MS-Office365-Filtering-Correlation-Id: 08d1d6bc-1f0b-4a94-d184-08de5ee6ca6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uNFYGffJ0ek5kXPAgh5BRe4mMRb69PaMeQz/CmB9U4bK247cjVpoRsYkI530?=
 =?us-ascii?Q?yJUZGvmi3HgTO8MIeffVkP4d7JyQOdJMoSiJofVn0Z329hXM4QNO7Fimqs0c?=
 =?us-ascii?Q?afELofZKjtbSAISbyh3G9HaHG2ZDr2e1hVHxZYhUdNSxhoRqTHUAkfQxtXSJ?=
 =?us-ascii?Q?AbYN/w/1OTljZHtsNfTKtKrjfW2E6qA5VBiAsoEGB1aaiQC/lZDQCscDTn6p?=
 =?us-ascii?Q?GmT15YZGLKCDlAFyxP56/CJy/GN+MBDHw0tojC4a+kyzz/8d/Korw1LrthI4?=
 =?us-ascii?Q?Kc4uSfjvZ41UPPVCwDci+rALNkwK8SpPPU4z3Lg4Pw0fxtJt47R+u7jwp1/v?=
 =?us-ascii?Q?IEk++TYbC0qhHVAsUD48Brs7kW/Fv3/jsUI58s6XHdSxuEDmiPR+SXUtLx8/?=
 =?us-ascii?Q?5ZsHUiwfTXcZHWBVxiffruULK4yRPpzzA8z3DeHqYYavQmBCWvu1ZjLpaH+Z?=
 =?us-ascii?Q?X4YpqA2CAiL6EOOMqn/YUgqrQRWzNFOd2x2soJcywA2fctdpoa11Ef3u5nI8?=
 =?us-ascii?Q?R4BMx4YhwuFryu8x8PjkljcMV/l59oK5cwCN6oNWcU6iV0xKKJuG94uDNXaw?=
 =?us-ascii?Q?PEV3LOwdmzq0gs8Al3fLc5Z0eOmtJaHq/weEnZn4fLv1IIlap1Yg0un2ggyH?=
 =?us-ascii?Q?/jR5tjh/kh9QI4SjI2OQhn+g1TzBwqF3pO3eZoU8Ela4voymy6i1QYXTusBv?=
 =?us-ascii?Q?uiL3xkKpU3alS/WNr/dRHDWhjY0V1NBeBCNm9LsTSQmeeN6pXu1AyGVeFAZV?=
 =?us-ascii?Q?lpAAWgJVTYFh/6AU0+G6fh/b8DD9D87AQqpa6FIV7NVHrwek6loW+QbNCPnU?=
 =?us-ascii?Q?99O5hjqHN08k/fpHjbnJgCmAJdQ+OdmSyH5YE+yDaW7XyiggjRFvruZsYPoN?=
 =?us-ascii?Q?dKTMaORxDBkXn7tGmghcZsxIGaVXJY7427z5Zp8q12ACj0m+6KRnbsvM4jjL?=
 =?us-ascii?Q?LYplLNqIeVQANv42/tdMw6pS7oetFLzbBtB4VyBEMCKG/tWaLjWqthbq1R4m?=
 =?us-ascii?Q?7wJyEN39UIZJixtQvVphJf49q5zcNetLnCIIrDTCMcj9e5HLoKtp+GmVa8gR?=
 =?us-ascii?Q?Xi+grorv1trW0sJ4Oin3i1UStZWDN7JnWVIXb9J+2h5P01H9FNYqaaeIK7kR?=
 =?us-ascii?Q?6HS4u9Xa12u6W4Mtl8YkUi1MXE4KFJaj+x0QhOLEeDf3VKft7grLC40Ieemb?=
 =?us-ascii?Q?b+ybFxgXLoHm06MVWTn+tfdtcuV/tFynT/ADxTYdWvbKrHz9Ybi84tnS9iee?=
 =?us-ascii?Q?LR2VU0/XSfns5FR/9eLac0SFbqINok8rXbWubMBqLI5yN9m9rX9elHqRZuKK?=
 =?us-ascii?Q?yZ9Mmwead/yaIG7O6EGgb4pgqKiQfWfU871/YOUlB4k5XGqsDSG2npNf5M4c?=
 =?us-ascii?Q?esrGQio/lczT0cNRmnfu9JA1c8MBrQgE90AyGYHIhkQs9A5ab8fvB33ddIG5?=
 =?us-ascii?Q?7RJZWGMcFlhwgJtDs6vicZCVIMxFUhE5wkJGVcGPUrQxNmZWc6qpuuIcr47D?=
 =?us-ascii?Q?lk2+2QpPAWO0n4vgODLEVVjPtmwHxsxnrnDroNjn/MHF5GLRYxKw5yONkJNn?=
 =?us-ascii?Q?NuGwdn/pxGEVzY9w2CXtk2tFaV5kigvJVQJRURmw9P8mGRaHnhI/EGZrk5ob?=
 =?us-ascii?Q?oEfEnZPGaz6h2Vlkg9GUdpg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fzT/ZH7K8tFSIphyIASb9xwxwlKag47o5NPAymhFu5oLfyx33yB58yo8zYXG?=
 =?us-ascii?Q?YJFEOtRQCagZfH2GjxWCZNjKcEMXMTYq9iJMYFzy66uWts21mQ+Fc4sFgDRo?=
 =?us-ascii?Q?5kjKQkMCEo974yyv3D8nLrymwCb73aKaPqMtlrKt/DRtCK5k/7HGJZUPFYjk?=
 =?us-ascii?Q?NPEf9AhR6oN5Vp9QifJhaUO6M5yvApZteOgxERjfi+eRZUi77oEicpTB4oYi?=
 =?us-ascii?Q?ebbK3lqdv0S+CWSRucs4AAOhFXa+EQxI1BXR5yXHw2nc448ReJi+PF/d3pbr?=
 =?us-ascii?Q?EXRYBDhxX2ZAlSsde9buHWcP4Uq5TnGOvBEjzYK/zO8KNw4ejBcXT/5+drE3?=
 =?us-ascii?Q?/obVAn0ZZEcHsSlery2+N6Dk+c3skqUE0/wvhayXoC62yGmPa7YnNuOUn1SL?=
 =?us-ascii?Q?TBYITLiw4oq7Q57T+vZdWqgSjlm5tJ37dKmwf6H0z2GwT+zTzX3Ys/j65c0i?=
 =?us-ascii?Q?wEFKUqGM5ONTmpuk3KSH1VsZ1rWVIY8ThuLRHB63vUGZjs1gAdTzQSS0tBtq?=
 =?us-ascii?Q?uwaUwRUp/Bv8ZQpNuXXNXTuendj9C7TZ4P1A6KjNV83+CDqT8Mt+GyJBZV+n?=
 =?us-ascii?Q?DdMvScGo3FppGzjjZJTDt071WD+uPrJYO0JUE3Ws0MJF0BiEmPCjHvN1x0a5?=
 =?us-ascii?Q?pWDN58tBigtcW0J/7KaJNlAZPGDxEwcuVOTz1iQsvdFSvM0VCFN1NgEAtRne?=
 =?us-ascii?Q?uSRThOQ8RwQ0Dtz40S25L/1H5MmQV8qvYrTcuwlRvmKbxHQMpSgcQsWlOTTj?=
 =?us-ascii?Q?YUJ2/v/NanHJuMdohbPWjgEDHd+4pgENYExlyBedP9irqINL9mD0i7dNMb6p?=
 =?us-ascii?Q?IJyKRMJUTLsgo7ovqsQV37TGW9rs76S3+tE7T9ODzRRmBGLtahddoKkMNQm4?=
 =?us-ascii?Q?I5/L7WavHGlWR0Rrk1jQEbPbwUjJNqmQuKO1oWRMlsBjsMR/T2GfYTLvqElB?=
 =?us-ascii?Q?pCFaLqyFPIVGZ6o0FQiSVZClMy3bInBp5HkXq63gAne5ug7CsmRDOEJ3DuNo?=
 =?us-ascii?Q?g5qfZQBLnQ3/1fD8hgkYxgY7vx/slHOtkA16QDLa9R5Nndzi4msxr22RJNP/?=
 =?us-ascii?Q?9fc8//rExTYKtWKq2Oww5B9yStW4cMRxG73EyetQD9KJ8c5WBZdX+W7WfloN?=
 =?us-ascii?Q?wngrv6DII8bOjvSypYB01BtAzjzDnIInZ4XW9PDh8P9Pxg4UaAoFgtt6Sbab?=
 =?us-ascii?Q?WQ0RZSisFhMTyJ4FiTYuoAyu2MNxn++CRuPYGIGr+nSxdjI7kOHyx0iuIIvd?=
 =?us-ascii?Q?tV0eoniMUtuW52mTPSNttO8Mw9mtWZ/JwbkFo+0gwGnzhiBtUWDGUSb8y6qR?=
 =?us-ascii?Q?bs/yn45xztLjwrY4gvU03maCiNh+Ml0kXFMfog6OteYLs+r0Cn1o8Lg7zX/a?=
 =?us-ascii?Q?5p/pmL5UBUlTDF9scgUqkmFWrw+j7537Nm0k87m3DR2S/p3O9z39hqfp0P7v?=
 =?us-ascii?Q?wpxoSwPVHy1Yh81LwKiwih1jDyVingJbcUXCz/xA3gLGgtps3HUaW547By2Y?=
 =?us-ascii?Q?EwIboUiVcy5aHa9Sdnz/b0QfTiFj3exQBAuBj0Bo2JHrDQzpveYe8JdPTfos?=
 =?us-ascii?Q?bhFyLYbB3j2LlYbeV/dFLcBD1qbBxmGl+noZ5CpzCf9LgpW+9XyN7vxQUT4X?=
 =?us-ascii?Q?uyh47I0keCXiXsBUgfrO6Nz1/scrG8vtLt370CuDZ6ZSMVGd98WnFiCJ0oOI?=
 =?us-ascii?Q?UPfpvp3CtTDK3n2eTnoPEjqkunOmNyG8zfqYFW0i9F4AWUHplFeWk++nJ3H+?=
 =?us-ascii?Q?sFtiSCAt2Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08d1d6bc-1f0b-4a94-d184-08de5ee6ca6d
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 03:30:46.7773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0oLiLRTM/+WcaGSb4t7oCRSI4V6YhFlpFJa/zWKwa/2RAAxTC1hATrgSbWIIkjydmoKbI3lybAoQ03TTWwsLiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9452
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8572-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C444BAB73C
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 10:20:24AM +0800, Shenghui Shi wrote:
> When using MSI (not MSI-X) with multiple IRQs, the MSI data value
> must be unique per vector to ensure correct interrupt delivery.
> Currently, the driver fails to increment the MSI data per vector,
> causing interrupts to be misrouted.
>
> Fix this by caching the base MSI data and adjusting each vector's
> data accordingly during IRQ setup.
>
> This issue was reproduced and tested on:
> - Device: [20e0:2502] (rev 01)
> - Kernel: 6.8.0-90-generic
>
> Fixes: e63d79d1ff04 ("dmaengine: dw-edma: Add Synopsys DesignWare eDMA IP core driver")
>
> Signed-off-by: Shenghui Shi <brody.shi@m2semi.com>
> ---
>  drivers/dma/dw-edma/dw-edma-core.c | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index 8e5f7defa..516770388 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -844,11 +844,15 @@ static int dw_edma_irq_request(struct dw_edma *dw,
>  {
>  	struct dw_edma_chip *chip = dw->chip;
>  	struct device *dev = dw->chip->dev;
> +	struct msi_desc *msi_desc;
>  	u32 wr_mask = 1;
>  	u32 rd_mask = 1;
>  	int i, err = 0;
>  	u32 ch_cnt;
>  	int irq;
> +	u16 msi_base_data = 0;
> +	bool msi_base_valid = false;
> +	bool is_msix = false;
>
>  	ch_cnt = dw->wr_ch_cnt + dw->rd_ch_cnt;
>
> @@ -869,8 +873,15 @@ static int dw_edma_irq_request(struct dw_edma *dw,
>  			return err;
>  		}
>
> -		if (irq_get_msi_desc(irq))
> +		if (irq_get_msi_desc(irq)) {
>  			get_cached_msi_msg(irq, &dw->irq[0].msi);
> +			msi_desc = irq_get_msi_desc(irq);
> +			is_msix = msi_desc && msi_desc->pci.msi_attrib.is_msix;
> +			if (!is_msix) {
> +				msi_base_data = dw->irq[0].msi.data;
> +				msi_base_valid = true;
> +			}
> +		}

look like this dead code. Not touch dw->irq[i].msi.data at all. All local
variable will not affect else branch.

>
>  		dw->nr_irqs = 1;
>  	} else {
> @@ -896,8 +907,18 @@ static int dw_edma_irq_request(struct dw_edma *dw,
>  			if (err)
>  				goto err_irq_free;
>
> -			if (irq_get_msi_desc(irq))
> +			if (irq_get_msi_desc(irq)) {
>  				get_cached_msi_msg(irq, &dw->irq[i].msi);
> +				msi_desc = irq_get_msi_desc(irq);
> +				is_msix = msi_desc && msi_desc->pci.msi_attrib.is_msix;
> +				if (!is_msix) {
> +					if (!msi_base_valid) {
> +						msi_base_data = dw->irq[i].msi.data;
> +						msi_base_valid = true;
> +					}
> +					dw->irq[i].msi.data = (u16)(msi_base_data + i);

look like all dw->irq[i].msi.data is same for msi. (according to your
commit message).

Simple dw->irq[i].msi.data += i; should work. Needn't msi_base_data and

msi_base_valid

Frank

> +				}
> +			}
>  		}
>
>  		dw->nr_irqs = i;
> --
> 2.49.0.windows.1
>


