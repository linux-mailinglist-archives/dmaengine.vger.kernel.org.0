Return-Path: <dmaengine+bounces-8741-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLmJCqKIg2niowMAu9opvQ
	(envelope-from <dmaengine+bounces-8741-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 04 Feb 2026 18:57:54 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DAA6EB47C
	for <lists+dmaengine@lfdr.de>; Wed, 04 Feb 2026 18:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D952B30022C3
	for <lists+dmaengine@lfdr.de>; Wed,  4 Feb 2026 17:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB13840B6C7;
	Wed,  4 Feb 2026 17:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="e87T3vV5"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013042.outbound.protection.outlook.com [52.101.72.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E50340F8D8;
	Wed,  4 Feb 2026 17:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770227871; cv=fail; b=upifIQIABuJz7wFYudEJCQ65PaapXEz7UoKZa20PXSs6vsQdbgT4B4LvLjuEihKPBBFJn+5IYAU7I+c3iYrT2BH9KnQNx8E0Dj3peNDQ7CZuYc6lMq5WzuXbYPCosVSBn+RNjBBxYUfpWRZiD1yprir1slILVn7u4tCCLzGqM6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770227871; c=relaxed/simple;
	bh=VimPjdrUNBq0d8CL8ZDbGd8wvfA7JqpAWP3PwNWNs2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lg8oP2E4oZV+SwsU+/PrfWG8eRj/g/uY/wawn+00Tznb/6KW6WTOcP/1TnkdQ/j2ptPV738X1gYIf5hSl54aFJn2DNfIYPUDRVCRVpekI/FNjKlCjm7fDCOvkzD4nBmZ4+db45XaP5rvS++IhCNDkPPgzVRxaXgHHuzElvkm3kg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=e87T3vV5; arc=fail smtp.client-ip=52.101.72.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h2oKSEE9Z9C6+8BACwts4qSvsPyzWm2S6A6quH/ntBeMt+jq9PnFgcDFmk1drQHWOooXHWkLFHcPR7bPrLsCSOO7omuMVPoOxIuUj2TKruoIPH8agZ1wnhfH61jYBGznw/rNDkih78sUm30J4U1NR1Kn9NAR7y+3Pbm30tuEEfTMSU1Luw7hNAXugksCK94x1575rpnyMHVOw7Xi5DzU5WCoPoszSZ/0xtCEpx3q4A25KZbPuJBcvE5iqX4mK5XhBli9+ijy5bULET0leyhou+usEHL9tCImbOPVdEKC6mdlhvnpAfm3LkQGB/MdZ4CHz0cWhFrqrmZ85pp0Y4RayQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wb5dfLaEkSCa9nhYpzIDTb/ZEUeroZIM7kFNGZvwQgM=;
 b=sjzEDO8EhQbXwCzBR7rRVRGqeTIYa4oPkw/CK5yNj5NIk+mPUAAz8nkqLpCzzlei39M8wTDThLIxxiiMq0Ixxm3dcPmwLA7KTB8nU0E//h8VZwn61dO6gsWmMymkdSA28yJWRy+7uto+C0LMRWmNAsj1gFR84xwfkSWqNzoTpjBKWiFKzq17Gc12KuqUe06HAIYRG+Xq1hx158IuQJDGexoMlHJStwWT0lZ3zuek4ewqiA6iUbB5n3gyRwbfVPNPZh5FkYqSfjzQVm7CLzQDNy2pPkZeUzweEzmiOzqlDF6oBgjY1Qu01O/CjFHK7KcwH8Tc4oZi4pvR5cbeXM1FzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wb5dfLaEkSCa9nhYpzIDTb/ZEUeroZIM7kFNGZvwQgM=;
 b=e87T3vV5/W0Uj3bqySLv3Qm3/ckfVqSBO0cdh6HGrwFRAiIDclJFMqd6ixtFKM4ylYhA9JlRKFTczHvBQADCHOq0Nx7pmwK4pJNsqlFp3GaD9Ps59MMAZ/zbR0rYRsWDiWjX/F99+OvEfa50A/yuNPqttBqF1p6+0hV312GZLH03i6suJdeb1C0wSNsHn6CnQO20p1+VcZ0M/gimNmTxQ5KfgIQdvpVrcM+BpleUsUixM8X4bhfKzxC0YVF/E2y7F3mZhT29iufEq617ZM9VdWXVqW9E7YT3jufjr+Mb3WZc3WV1xWgeHo9Djl4Ym+FDLuTfusfCLqlW5YD6BLUxxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PR3PR04MB7305.eurprd04.prod.outlook.com (2603:10a6:102:83::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 4 Feb
 2026 17:57:48 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 17:57:48 +0000
Date: Wed, 4 Feb 2026 12:57:40 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: vkoul@kernel.org, mani@kernel.org, jingoohan1@gmail.com,
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org,
	bhelgaas@google.com, dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 07/11] PCI: dwc: Record integrated eDMA register window
Message-ID: <aYOIlDiH-X8Aq7rw@lizhi-Precision-Tower-5810>
References: <20260204145440.950609-1-den@valinux.co.jp>
 <20260204145440.950609-8-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204145440.950609-8-den@valinux.co.jp>
X-ClientProxiedBy: BY5PR16CA0011.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::24) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PR3PR04MB7305:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f423464-2c95-46e7-bc04-08de6416e888
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|19092799006|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?krVOKL+50WSy/t8MKfNGC3kTIf2DZTCdPi6gDkRZdjufVxoUXtb1aT7rr/dI?=
 =?us-ascii?Q?1HdQJgiXj2pPcuNT+qvSFXHKP2NLexjVSkqT6BfYHVVSzYyXLksROdN69lVv?=
 =?us-ascii?Q?CCSGRU9o/u0xlxSapSCdSJ/6hf8HLUpbiiIy5jjMzo9oTPmfsLgp2EOYln0x?=
 =?us-ascii?Q?5yjBAlvMdMp5iIyjfgM8TX/sobTMW+LN6oi5+UGMtg0Z1wjXWPTQRe+zNqN6?=
 =?us-ascii?Q?MdHVNqnbjtDg6wN4w/xrhPCCVKwW8H+hh5rH5hG17HTc2UQ4suasGqq/BfKC?=
 =?us-ascii?Q?9jBprvCPFBUsnuSNODupj4w5TWlAdQLWEhkpXSsCRK66uEl0V/IXDkg+i/er?=
 =?us-ascii?Q?XmvAO61xWgGxHYT91STZafJ1lRhwaCJkffqeAXCvt1tq0TVOTxzlpcB/p6df?=
 =?us-ascii?Q?Gy8ykqPwm3N6nxzY15kDyp+8Mb1dI23EaYTEwqulM4fMi4f/2nGrKCl7pjYv?=
 =?us-ascii?Q?yMYQ7wjh2iP/uNFO1+xirJM6s2167Ogt9/Xzg63yKuo8tOX1ID6oJr+saSaY?=
 =?us-ascii?Q?a/7rWbMoD/UCC8V4C8i60odOjV1q2XcjEJy4QvzLMLMmtKJD0RRcz8AtxPAF?=
 =?us-ascii?Q?/Wfx/vqu9yfx3EPGUSoMf1EGKTWYOkfeEtdWlCzdven+KFypa2DAbdieDrXv?=
 =?us-ascii?Q?Kk0GtJIm3uI21fLT/B4+b8xi4+8CfZBJdO/aWhzz0NgBp/xUDutBzrkG8WJA?=
 =?us-ascii?Q?g4/q4mxSt5uu94OSsqL5Kl7ZiF7AWpN/51MgQO8RLorPRInW+A49iUlFUXhK?=
 =?us-ascii?Q?Hyu5XmHD/V9GQvhEi5F+Lgdjwtm1e8DAgKLbhmuG0IM5LOvW3joPzSCIOOm1?=
 =?us-ascii?Q?aom+vSQKfUX7YqgZDMpS3MyvNkJx8Y1dlNc2padG31W1jodCD6fbEW2HAGYW?=
 =?us-ascii?Q?BJzHpwgtBfRw0uRDVEovma3hk+PQ/ojx816IR4mj8qNtpkzNhAbn/a1c5gfH?=
 =?us-ascii?Q?1u33rxy/G8eyBaOFV6q7zJfHo59luqfZN999ohRCuHrgJa5T3iejXtR52/SG?=
 =?us-ascii?Q?S53L3JevyOSRs9SBcKNOx1sYUaul/5PfC6c/w0qxIu+WrqnjPn7MGeqfVZaA?=
 =?us-ascii?Q?TiCzpF11FT0MN7F5rcSaqH2Gei47AiEE8bQLlgiwnrAsZF4ivVP0WWB/oGUq?=
 =?us-ascii?Q?+o5QeiZLMgqzDgwLTERlNNgazracqOzQisD+BCvzpotv3qrx8XR7w1gYKMd9?=
 =?us-ascii?Q?AYqie6FtpKjrajE/PMrRZnZFcQtchTEAXgCOatkzXRIYhqzAmGQC9wYqt5ZQ?=
 =?us-ascii?Q?FTH8ybEy4XbGNc3w1wfYsXwsedKs0eCORamaRCYtSgGTXDozlwsLmiTQ8LWN?=
 =?us-ascii?Q?46VtdgpxtnjwUhShxLTiP/YOxCnqPWaGVXNYDvUxbZp4dZnaFyCvfsBhVgmo?=
 =?us-ascii?Q?6TMo3XPITajkyo9Ao9Rxv9vyeDoR+xzHMvphOw+7SYh+uHsdoS0BQFeLC6uP?=
 =?us-ascii?Q?t11FogNClqY0h9tja9IKaTX2Vfu4PrGHV7uRkTHGcYGSAjwgk6gi/i3We4aG?=
 =?us-ascii?Q?lkWfrJtsUz2I71x1dZFsjysAOVwpUHakM5hJwJQOkjsYqpO1Zv+aMF8cDJNH?=
 =?us-ascii?Q?nw9aRHDBrcHUkay3RYknLsU6AMDL4X9eVcnMy9bih8BIA38jEBqnshlYZz6c?=
 =?us-ascii?Q?cn/Sq/rttAJWX+uTB2WrFD0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(19092799006)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gVmNxX9R/jbRjexxgW3Lu0RPh1OV27z6uUXTWfy/yaF4D8M2XgeZkeVKYfWY?=
 =?us-ascii?Q?0+k68OKZwVgAOKaw5We7HXjCMutKWcPnNK0TATsANu6KzAyc6pLWiI1xkvNz?=
 =?us-ascii?Q?xnkiYcQJHAfF71JIwOJaX8f9tJJFKfnovtFjlN8pocbFzV4ov23q5g/3zaHM?=
 =?us-ascii?Q?eHp29muefH1FM6LreyMvDtE0xGA9wYFWNp0PWFyJKrLGjS2Z2jPL9nUKOrtG?=
 =?us-ascii?Q?J0MyxZ87vz0YyyN6CMJieZQ6BkyI7b5KfOBMW8sjh9iz99w50mjeaxK53J7O?=
 =?us-ascii?Q?INwChCIgwfw5rIoROAYPStmeyRwhSRpcTbwYKqYpJMYVR5PHYekuxHJeOl9N?=
 =?us-ascii?Q?IGW66XIbCJnEygRAOSL/l10wHYX/xcpv+BBnae4hEzTDooYmVK0czpONqF58?=
 =?us-ascii?Q?Knw3nzuA60alQ+lyL3PtSBGwdpG0bhzWSzAns5BJiQUQ83WnbCxK7fh8hep3?=
 =?us-ascii?Q?rsqYrgQgkG5pwZSRFhniepe6TPLqdCGZcqLuSswRTIkB2IIJy8k45us5CBtt?=
 =?us-ascii?Q?Ntb/8jb1GVXF1AhgXs5tjiOq2/Kgx6Ql/j/QN6Oo/Go36Pc4yIjsL3j+sim5?=
 =?us-ascii?Q?d+6XvEwQHNyQWvJc6Rz/ZVU/FMYTSv+jq1JmGxtLVeOtPgJCcuYGHHa9BkBs?=
 =?us-ascii?Q?8UychktHn+Epl6Ev9rY1REg07A3IhxwZUH8UgJSNDQ3mBOKT6ZjnL5szRl1z?=
 =?us-ascii?Q?FK6cby2IYgWFFBtzqnlwRyT+0IPbegl7y2KG5sr3Sb43lmXn/VzhKXTxatcR?=
 =?us-ascii?Q?3gC2RzjZHjulM4zUcdGCEA+JtfZWtl7P8QNCIQwRWB6p6JOTak9TZw2gwsew?=
 =?us-ascii?Q?jbCwX8PouCDGjgYvvbzZXTT197gGPuTjfYCCFUlqAP9F+PUB5sIw12RP+BLd?=
 =?us-ascii?Q?iBoVQdHJ+NTQdnYHvelOk7N21KSbtIC/00wmyJb9rtbnq/DSiFNBAvHl4BKu?=
 =?us-ascii?Q?gD4h2wj8ESwkVH8GxdXGcp/GljL/ovjk8vgR1gxgcR94lHpuGprMf9XegsXm?=
 =?us-ascii?Q?EAlq4R3zCaAdhVGuU2F4hbsmE0DbKeGq5kp/h8LlGSPUcUCTGEs/HE8r9+CV?=
 =?us-ascii?Q?bvLuK2AmUfv336phPLRHekj2RGqnMD/F9qIRND6AOmy4eSIBJrpyv5O+h/2G?=
 =?us-ascii?Q?y5vctkwe2coN3+/6uKLfHZiT5yBGZ7y+4WeLq1ORhUb3f1KF8LtxtK6NRvbA?=
 =?us-ascii?Q?f8dVReHwm0WYgUPUmQrS2FzNIrP50Aq2UABb5KrlrG+ums9KuqxzedrNG8lL?=
 =?us-ascii?Q?XZej45WWY+4QwXFbGgrlsKC1Fi2UKuptmQ6jR6q0IigdwBLJcepHsQOHEqt8?=
 =?us-ascii?Q?x3cVqBrL4Rmg7EWVfGSiLofze/Q8DzrXS6utBfGB8WRxoVHZwzLswDnYF4tS?=
 =?us-ascii?Q?D1LxnM0uKzT5LrBjNmohZY8mOeQdC45CbCHx22Y9fjcWNoRz6cCpTEsC3OOX?=
 =?us-ascii?Q?mVYwqVkXjOYbH5/EcrAGRQeKtr7+PTLrUsxH1sVsshtkE1891qzlxrRBqwWH?=
 =?us-ascii?Q?3+DZ37mZq5ILq7geVxP8TfAoBQOJU8x2xA/q3aZRMc4Jc1hk/nAzl3grabN5?=
 =?us-ascii?Q?m9jFVsfis7Lc9iuVx6fnZ4ZlHtETJSVmUjUna9dGb1VuLvJB0D099gLiDB7Z?=
 =?us-ascii?Q?pMuPwfwIx+7crN8/YsLUpSIV4d7ObxrijAKD/WFJ4MCOrrHRcvNvUWifD7/m?=
 =?us-ascii?Q?7CkoH0vTcyCmkiDT3ZUbAvBDhLplX59SCbY3k3bMAdGXQUN1L4vAJIF7w+uU?=
 =?us-ascii?Q?nC+dFnH9+Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f423464-2c95-46e7-bc04-08de6416e888
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 17:57:48.8222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vI9wX4D5qIZ6g/HISfHgPSSHG3ubny8WjA/OdCZelkAjn6cZTS3mmLTqktZD5oJu5gHD4VaKH16qrdXHSKPLVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7305
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,google.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8741-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 8DAA6EB47C
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 11:54:35PM +0900, Koichiro Den wrote:
> Some DesignWare PCIe controllers integrate an eDMA block whose registers
> are located in a dedicated register window. Endpoint function drivers
> may need the physical base and size of this window to map/expose it to a
> peer.
>
> Record the physical base and size of the integrated eDMA register window
> in struct dw_pcie.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/pci/controller/dwc/pcie-designware.c | 4 ++++
>  drivers/pci/controller/dwc/pcie-designware.h | 2 ++
>  2 files changed, 6 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 18331d9e85be..d97ad9d2aa9b 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -162,8 +162,12 @@ int dw_pcie_get_resources(struct dw_pcie *pci)
>  			pci->edma.reg_base = devm_ioremap_resource(pci->dev, res);
>  			if (IS_ERR(pci->edma.reg_base))
>  				return PTR_ERR(pci->edma.reg_base);
> +			pci->edma_reg_phys = res->start;
> +			pci->edma_reg_size = resource_size(res);
>  		} else if (pci->atu_size >= 2 * DEFAULT_DBI_DMA_OFFSET) {
>  			pci->edma.reg_base = pci->atu_base + DEFAULT_DBI_DMA_OFFSET;
> +			pci->edma_reg_phys = pci->atu_phys_addr + DEFAULT_DBI_DMA_OFFSET;
> +			pci->edma_reg_size = pci->atu_size - DEFAULT_DBI_DMA_OFFSET;
>  		}
>  	}
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 43d7606bc987..88e4a9e514e8 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -542,6 +542,8 @@ struct dw_pcie {
>  	int			max_link_speed;
>  	u8			n_fts[2];
>  	struct dw_edma_chip	edma;
> +	phys_addr_t		edma_reg_phys;
> +	resource_size_t		edma_reg_size;
>  	bool			l1ss_support;	/* L1 PM Substates support */
>  	struct clk_bulk_data	app_clks[DW_PCIE_NUM_APP_CLKS];
>  	struct clk_bulk_data	core_clks[DW_PCIE_NUM_CORE_CLKS];
> --
> 2.51.0
>

