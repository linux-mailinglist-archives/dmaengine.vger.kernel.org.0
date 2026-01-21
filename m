Return-Path: <dmaengine+bounces-8436-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SG/zHS4TcWlEcgAAu9opvQ
	(envelope-from <dmaengine+bounces-8436-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 18:55:58 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDBA5AD1F
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 18:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D5F6B76EEF4
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 16:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D323A89BF;
	Wed, 21 Jan 2026 16:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YwkoLrox"
X-Original-To: dmaengine@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012045.outbound.protection.outlook.com [52.101.66.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF91342507;
	Wed, 21 Jan 2026 16:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769013565; cv=fail; b=LNXIoo1HIjyzEF6zc9QBsQIb0eAfhPIKClUtlO0UWJZpZNriHJxnTPRvS8Hm+jd/AibIDUKsMhsAeWvvvaew7Q0GmlxGV143c6OHN35Rrka87RPVoMmmcePPQ2lRy/xqJ51DF2czZLoNoy5hXT18wTncgRtBydx8bCIS7ksOnc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769013565; c=relaxed/simple;
	bh=VNsblpBWDn1d0323jiNT1WIC6FqqgZ3TRx7vC/bhKsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DXGNXnHhrZCUbMS4cVKd2iZM8w4G8F6x7cDrFLLZokpEjJ5NT9Ga4fFH5qYr8HICVM5lAeAJp3/Ob7/35GU4Nao3Iu5sy5pLcZM+BUxakmL8lUrq9In3as+UEBuxFW5+cah0vszmTyB69KU3vTZ0O8KZrnq8JJZomwE2Z6ldxGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YwkoLrox; arc=fail smtp.client-ip=52.101.66.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bzTiSJ/GbXFaczjHDLphjr9ao9oNjykFohKULxiarTuxC7KvP8kEdLGY9vMnMJe0AtBRqGfEJZpclCzgWaLFzHibRKhS7fAGSfVCpJbfRQJO34bDhPQbL/pbv9KtBza/S++HbLcUTpInPt59pZdpagCXCFMmMFjRqttBP9n39wtC1rNL+It++IztPCvpMonEMFaiuQXB1TgK/3BSgY+A4Z7Oi6GV3in7ZUmGo3qy6KN5r6hRsX1o7RpkxQPe9+jdlDIFV1M5yAjsncW0aRcmxmpLlEByh6tXih1PmRIVt9LOlv3hbMax8P4i0frXb5eh7RfhxAOzhOZdjbpgFMK0Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/2m2XoosrQWtQIl+yHJwLWiiau4AW2aroU9n8X60dNw=;
 b=oeU3AZ6QNscwqnxepn+ivhpNWOVPV5AlMjJGIvlHG5g2sAo48CVY20tpjKNHu6NOa4EVeM1MyLSJDeRrtsy23Xk4ILrUL79G/nvM4OQKOquA3DrblDFpzB4OEDejS0LH6lutfIBZEo8QTK08l/zqmd4phTi2WLAM21dm5TGuybw4415tkKqAiXAh6yHu8kkpPuOkyxfQRUr6tBVQ49Ti39hjNZUm3hu/SwKHybVJWu/4iDLnnzyTB7XLI/G/aI8TONRfWXOucHgAFScTf9DI9uUEzUR2tAPLrSj0nFtMxlD1zY8rph0EIvMTXXkO/GT9A75H1IGwp7Zl9uoHgvg9Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/2m2XoosrQWtQIl+yHJwLWiiau4AW2aroU9n8X60dNw=;
 b=YwkoLroxON4nXtGUu84WFWP8mQHRIzYzENuFWYGj5GXkmw8YoSHfnLKFgDjRA2I8/8cQ7D4Fs7JqpTG0yLFKBNjvLg5Ohj6ZlPOBcy8y81O6VtYktbvG8bKbapfK23SiQcIVwo8KR+ZlFXRQK914fEcdr03IXzFWOqFSpKh3Whlp9GFcryMsDpWQP5UYqFqQmn8g368Jc49PZlwGGyMnWRlXgmaBN4nOPvu62nQ4u57fMqjS+6gTfZ5FaxH1agOUvv/HMGpjp5bFIGEbXDQtuUB1Zw0yVM9tgycMmkKCrOQwLaktzgTirUs4Oi3wvNQL1d8THanGX8IE2KSwdu/1YQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by VI2PR04MB11026.eurprd04.prod.outlook.com (2603:10a6:800:279::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Wed, 21 Jan
 2026 16:39:19 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9520.011; Wed, 21 Jan 2026
 16:39:19 +0000
Date: Wed, 21 Jan 2026 11:39:13 -0500
From: Frank Li <Frank.li@nxp.com>
To: Devendra K Verma <devendra.verma@amd.com>
Cc: bhelgaas@google.com, mani@kernel.org, vkoul@kernel.org,
	dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, michal.simek@amd.com
Subject: Re: [PATCH v9 0/2] Add AMD MDB Endpoint and non-LL mode Support
Message-ID: <aXEBMWSFF4jh+pop@lizhi-Precision-Tower-5810>
References: <20260119091009.70288-1-devendra.verma@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119091009.70288-1-devendra.verma@amd.com>
X-ClientProxiedBy: SA1P222CA0077.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::24) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|VI2PR04MB11026:EE_
X-MS-Office365-Filtering-Correlation-Id: 6204c192-3f3f-481e-57d2-08de590b9fed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VCmyfzcqJ4GfqWX7poSd6wPtYEeVL09M3eGLHU9JFL0e1qJAx47K5nkryDQy?=
 =?us-ascii?Q?FASUztvbjs2kK2XjG3XFIKDycMWulaSkZFPPutaDTVeb3Fscgd+S7EEsLkaw?=
 =?us-ascii?Q?TLVBwfyb/f9DaYeqnVce5oRqwGKGbC7dwcMFGclL7wXe7FAHEmju4BjsMyeU?=
 =?us-ascii?Q?dRVGN55VCBj9ktyEpxIZ+42g2dXmioiVN5oI5phPyJp5y4af4DWsoXkOXCeV?=
 =?us-ascii?Q?CkqF0Gwn6wb9YP52XIoAAtbCJBH+M8VIuNGW8T04fTE8DbWTw7Yd6LNVa7sg?=
 =?us-ascii?Q?21rqEMRQ+F5kfASBmhzpLIwFYeAH8iEufyE+G7oCqp+8jY2/VCitIPtnxaiW?=
 =?us-ascii?Q?xNJFtI8LwuJpYwStGI8ieYnyVoDS5qEk0gD5aEDNtDr5wI5SE0bF+GOP5mLB?=
 =?us-ascii?Q?HGOEueR/lDh5io0YVKsf0XaSJtR0ZRB/L169iLU7uMUvWRFkG0Lj6AS2JIdd?=
 =?us-ascii?Q?2P6+j57hZs0NiNV6VbePv1aXKUPkHYgBj7ZTgK5DbvnF3rQi2dCghGTR1p6z?=
 =?us-ascii?Q?/mGRMhyGp3CLmh6QnKDusNeOdwNFX2W6AEhrixgSz/ISHWBDcnjq+En9M5Mi?=
 =?us-ascii?Q?IxcIMEK60fofuNr10CYgm9bU/UuIsiLlB/R13aYmP9X9eDi3FrOGkyomJ9H0?=
 =?us-ascii?Q?apLLgJMOWRLXFG82O85BimIWemE31QYRtKFvClGE8dtar+pVXey8Hiq0xs1f?=
 =?us-ascii?Q?PWb4MbfBYKRwF3RygGIVJ74vyXkt21/ZyGDoTDIg3viaf9c92iW2xhsxd9a4?=
 =?us-ascii?Q?LL5SxjKsYHX8J4dQOHYBE9MVk3wvH/Drw4UJRhNPn+LwKET25jwVMHFCQqUw?=
 =?us-ascii?Q?cSo2KJxsaaqiXP66b2Btp9zIbJccxGZ4oV3ETTkeuVeTox8jTT57o8/qsGnb?=
 =?us-ascii?Q?gFqsKcpSdXsik0tbObI1ISuWVxARnN5pgtemYFNCSo1r5GouCtDSPcLg2eTp?=
 =?us-ascii?Q?rYY6b3LAu3LbPOEPhVPz9A+tuSYq9TO78wHMtSrA6s0ccKgVR6omNyRjdRPp?=
 =?us-ascii?Q?ZBIENp6Ei+aUJKkOUxyW3YNdPaI3LQMc8VcnEakwNjWbo2npumMV20uGmmqR?=
 =?us-ascii?Q?VPZvjFX1cu9mbeo4ieoljzwhyaDHULVkLvjBcDp40RiTUjT5yuDHMVcgxBeg?=
 =?us-ascii?Q?Sy96un9rDGrcVWoGQP4XrHrMNZT0bvUqeaGROFgFHZtmwyu7suuZAoZkJ+Vw?=
 =?us-ascii?Q?Xb6iLmK3q4oTh4L7+sOWN7Urpro0N1yAH7tQiUXeeNwiz4VbJHiw50sIU1FJ?=
 =?us-ascii?Q?qAqlRq8Tkw3XD0LcoeRI24VgQg7c9xjEL16GkIRXVKfAJs8AWEv2uH2LTm5K?=
 =?us-ascii?Q?bBX+Z4HFg43Chk++JkBIkxpnPK2Ie0oi+cp0a4rKARQJ7ZXv2SWQAuQjVUOV?=
 =?us-ascii?Q?F5HEMQ2EQuRftdvHPyW7Ts0DL4oJUAzQx+QVdUDtUR8LNVdxFDDpAnIPiIjM?=
 =?us-ascii?Q?cbguW3sqNv0X/Cm0JIMDBSmEQap3jnaTa3TikAEPizLiB7Dkh9u9llN646I0?=
 =?us-ascii?Q?hfGxYl39CwUQw7x77YVLZlWnTf0aeW32yFyNfFv5Ls8qYDP6tGfnKRyMN6fJ?=
 =?us-ascii?Q?hsCbpB9i70cVDT1lYAwgLCzOwiwUTFFf86uZc2uOYCymVMOP+tk8BvQydd7C?=
 =?us-ascii?Q?QNuKlZgUki8yJHdMM0MhEDQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s8d3KVEr+4ASHdfDoVJgF8/J5Og3cCDr+TH+f1H0Aeo4u6PyFDMxQ7q98Ma5?=
 =?us-ascii?Q?oy4R+spp5mytAYGoEMjGaBNRbSBtRHWmcTdH8v5ERw8qcnbk9jH9F67YVLNm?=
 =?us-ascii?Q?bXWmW8V6QLKhAXeIFZ9ideM/byohIe3oh7opwfWXPHnOjynWNMaCJ8evzg/O?=
 =?us-ascii?Q?jRUP782J0LDbnrMe9ZA+JGOVslBUtQhFiKrGA+FYZ8V9F/O7DSUtPCMQCZuH?=
 =?us-ascii?Q?1Zj6uVWuE72XsH1r4iNU9uI8rD5kXcNUcq+pbKRe+WK7hEegWd0wLWl9WNJH?=
 =?us-ascii?Q?32DuOrUfqIFoGSejH7+0vw/4eRE+EBUP3945BB1qYvftydaOjJMay7FFPnp/?=
 =?us-ascii?Q?O32MKk1Txj8kxJFYdTq2qtKC8SnAqeRI9EIULKXZejh2dbeNxzaPllPL1c5D?=
 =?us-ascii?Q?PLBvQuQYKzQ8NuMqWjnNFSZC02Up+Z2KdjnNPdKb+0p2pNHVOIKD6pAlg6kS?=
 =?us-ascii?Q?EoqfFYeDx1i8RBMuf3YqKaPbzmwzwzfDJ1cZ9LRJnKUXrLXP0r+JJ/nzX4EP?=
 =?us-ascii?Q?nA4dU/2+zeSRJ02tYhqXbEg9rRTPaEAwLz6ES8Sz9IwWE34MuyhOXXE3KuVe?=
 =?us-ascii?Q?deg56NicF76oTDJ8MSt+wDGpIH2KSYwTl3yeL3Br1oRYUpWVgs5vv3BclNy+?=
 =?us-ascii?Q?76CLVm0gz+T2LhvphgLLF1b1ARIzqHcSSssVSLWvy2k/GTEewofs/V5t6aKz?=
 =?us-ascii?Q?cOAoxb5CkrJMZYL/qhdBkEnSLSKMJ5bsZlFFQVMSs+Fr+J8U0NdH8W6TTMNq?=
 =?us-ascii?Q?QyYMDpT843x0lL4Px0O2Otult05q1S5ux1nfDgHYJn0X9N4DKXvSGSjJh/m+?=
 =?us-ascii?Q?2aUC0L93E9x4D//Yg+yNzHEt4CzgYRwwLm5PNW/knWQIfBc9TgVlZZjHONV8?=
 =?us-ascii?Q?HpACvrIMsdH/dMqV+9nAQO9ZYfsBIqeqC8FirvKNOqbFSfH8bcbcN2hi0FTJ?=
 =?us-ascii?Q?Jp3hgxYnab9yLmxS96g7KgzN9bmCxWa7cl/UqGtDxXGDQ3RikCa6S+yrM0Le?=
 =?us-ascii?Q?etmYfRVNTfCeRyzCm8Hc86wvoW05124Uf60Qmy/0bY2oBqLqk21enXXLBInM?=
 =?us-ascii?Q?dL8gHxez1joKBXHkLmHz2YV55Pj5vSAcasA/CpUJA/z4Ih24ux6R1/weicV2?=
 =?us-ascii?Q?OSQrJVQ1oNF57MdoZJ4PByk3VlUKMjXIfIX4K2sISYrMMdK6JAEV2ByvRzIk?=
 =?us-ascii?Q?mCGX035Ph0+LBt3q/10ez4r68GQ7odFNK6DWzMjF0Sz+tZqFC61+5Owduxdn?=
 =?us-ascii?Q?pGH3zlWHWCpE9/7rzLAhhVSMzxdnZzEkuESu+XOFzPFxPSvB++OLlUTqL9rE?=
 =?us-ascii?Q?2jAjhjKam5dbWFeZNDYSir+Ajn8IXv7nhZGrjUDWCA5IA8duEDptF3BqE3l8?=
 =?us-ascii?Q?IWELxY/uO51PLoLjqrPT5FhVuphKJhB5cyS5R7La00hcsBnuKgSeHy72pMw0?=
 =?us-ascii?Q?JOfESSuU+Lt1aCZopAomYsQWxaSIMQtsP+k0YZB9BM85IFEuuXtKvpDsPdoQ?=
 =?us-ascii?Q?/bH7TCOXGONPfgyOR+a+jdzWW1jchFI5PI/G8/poMq/ig7nMoMpujlhuI32I?=
 =?us-ascii?Q?WBZZEr1B2TmtsKM2KHf9YsYpLBSe4xFcNa28HFpIeFZhLqeN7lKpcRWFF43x?=
 =?us-ascii?Q?vIpTct87i4heQ6BT/funaJ7xox3R9eMcB8P/qtpbPPGhpK/Qd3NHTHecW7hM?=
 =?us-ascii?Q?6P27By2Rf2TH/PdEQfOAWHOJoYk5Y7/BKAArzWStr/uXoWDf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6204c192-3f3f-481e-57d2-08de590b9fed
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 16:39:19.6953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x5n1QraYZ1WBhkiw/+eSCtqM6iHdvCFyGE3s3ZXpuQhG9SBaS+Ja4omvcOn5JofX8BsY9727a3h2CNuibhhxEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11026
X-Spamd-Result: default: False [0.54 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[nxp.com,none];
	DKIM_TRACE(0.00)[nxp.com:+];
	TAGGED_FROM(0.00)[bounces-8436-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: EEDBA5AD1F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jan 19, 2026 at 02:40:07PM +0530, Devendra K Verma wrote:
> This series of patch support the following:
>
>  - AMD MDB Endpoint Support, as part of this patch following are
>    added:
>    o AMD supported device ID and vendor ID (Xilinx)
>    o AMD MDB specific driver data
>    o AMD specific VSEC capabilities to retrieve the base of
>      phys address of MDB side DDR
>    o Logic to assign the offsets to LL and data blocks if
>      more number of channels are enabled than configured
>      in the given pci_data struct.
>
>  - Addition of non-LL mode
>    o The IP supported non-LL mode functions
>    o Flexibility to choose non-LL mode via dma_slave_config
>      param peripheral_config, by the client for all the vendors
>      using HDMA IP.
>    o Allow IP utilization if LL mode is not available
>
> Devendra K Verma (2):
>   dmaengine: dw-edma: Add AMD MDB Endpoint Support
>   dmaengine: dw-edma: Add non-LL mode

There are open discussion at v8. Please give me some time to reply your
email before post new version.

Frank

>
>  drivers/dma/dw-edma/dw-edma-core.c    |  42 ++++-
>  drivers/dma/dw-edma/dw-edma-core.h    |   1 +
>  drivers/dma/dw-edma/dw-edma-pcie.c    | 223 +++++++++++++++++++++++---
>  drivers/dma/dw-edma/dw-hdma-v0-core.c |  61 ++++++-
>  drivers/dma/dw-edma/dw-hdma-v0-regs.h |   1 +
>  include/linux/dma/edma.h              |   1 +
>  6 files changed, 303 insertions(+), 26 deletions(-)
>
> --
> 2.43.0
>

