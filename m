Return-Path: <dmaengine+bounces-11725-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RyKVDqxYOWq4qwcAu9opvQ
	(envelope-from <dmaengine+bounces-11725-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 17:45:48 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 091876B0D97
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 17:45:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=QF4HEdAw;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11725-lists+dmaengine=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="dmaengine+bounces-11725-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1389F300862B
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 15:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1203C98BE;
	Mon, 22 Jun 2026 15:45:43 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010048.outbound.protection.outlook.com [52.101.69.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C47F3C81B5;
	Mon, 22 Jun 2026 15:45:38 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782143143; cv=fail; b=u4WVUNcNre6K26rVUcw5mGn+WBtmWImwC9iZl6ZzHrpXpvxTFfiDKpCs/VbOgkFBiaDlnBJSf3HNXQMbZo1TTrXG8Kpbp6Jppm8zbqLziqC7MeBv9wv22HSieAxclxLpvdMnbxPYwRO4Nqj9Nc3Z+k9IeZ8InvEOGW9AKld3ZmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782143143; c=relaxed/simple;
	bh=NVgyZ3CekH1IvbZRpYgpVMq9lEuJJaYBDUbqBAHgHcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=D4PxIBBA7dQIdg0YKD15fki3XgZliWCeaajiFU7HT5OJbhCReh/mXMoVdg4VsheDm/BduxGQeJQh2V9VYMOqkzWKLYnabGyvdEO/85ZV6hwVx9e2Dk8J/usL2dzdfapXhLwIBpATnfS+7lvYvpL7rqv/96hK6seSu1IBufajNOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=QF4HEdAw; arc=fail smtp.client-ip=52.101.69.48
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vIo1KmKFepIAGSIoszmudu7wsfqxEsE9/5V8BBTrohdhqLAVJFsJ0u8g+0IP8xj7V5Li1+Uk63nza2MUiUTNUiVvsqoOK6nkMEWdRgBlMGuHMHASm8JXZn1obrmQ5j6+2uIRZbuAyTfqRj9eckDrReRtHmidLW5+c45KPGzI9Zx+HmfkGJ5CtUuXOJT/qY7nX/SQipxqsQ4PRn/hXFBHkE7acIgqTG7Meovbbs8cJtCWu2Mwy7/Yo7YvmvCr2vAm5L8K15lc+F6iEBFuCvFY5VnaQhT11gusKnaXVF+4rto3T7s0wBbUEYt5JYXykhpsCVZdF0xwuS/lyEa2WHde9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r15tK4gAOppyk5ypnVcRMUdfLU04onfXwganvcd2tMk=;
 b=A6DWwq6AjTUdsRBcA6NTwkp1ofS0BrZgc8e84CnYsDXDB/MSYY0U29a9OIcgxMnvdpNJm/9i8uwnyZBo4MzaWfBt4R1gOLW7SIFqfhXc8/xTHGhbK48lDnWSYb5yt0gHv5dBoqtAd07NAGS8HHI17N0HxkKA1GtBkXUSIyytzniYmW4atbnFPQp0ppALXfVegP3Gh6Tj+GU9OxniTb0SsSseByDiq37yEEEHGEmWnaaOcKFSMeIyztCZDqb16rHR9tWhgPP4ni8XLcA4FGMPMdIWQtbmlbTefH1X31WhUzQ/yMr25ViDipfy0syiPUQVIwXpMLWpTNao//yNARjuFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r15tK4gAOppyk5ypnVcRMUdfLU04onfXwganvcd2tMk=;
 b=QF4HEdAwGFcG7/mHPInTSepgQXdSCzXbLM/q/6JrK4VeQpMF8GVvi8+tG5/26YyGmf1wP7QEqQo2tpTDYMbUIzNPaEnmBJYIbqp+0G6cMxl1Mvc1Ks36UWHJHN43zkyoVpfZLeKOtFMmsAjkyrt+SlIynQdOvbVTNKu+4pECsxtAx/quWRDb18om2ie3R7TiCu3jyqqxUWfjSONX8debFaGJkdoLzcIlINmvo6cz4fWyW0W3hxuhR13Sx6kGYbzBfwYgfETAEHs7CzAC5CdV8xdI9v/Qd1nVrqWE8G9IEXAqzejLGHceYdU3YE7uLFu5kjB8zuAmN5eUaXQwM3i+kA==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DU4PR04MB10500.eurprd04.prod.outlook.com (2603:10a6:10:55e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 15:45:34 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 15:45:34 +0000
Date: Mon, 22 Jun 2026 10:45:26 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 02/13] dmaengine: dw-edma: Add core quiesce operations
Message-ID: <ajlYltc0vvKdaXxE@SMW015318>
References: <20260620170040.3756043-1-den@valinux.co.jp>
 <20260620170040.3756043-3-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260620170040.3756043-3-den@valinux.co.jp>
X-ClientProxiedBy: SA1P222CA0083.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:35e::21) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DU4PR04MB10500:EE_
X-MS-Office365-Filtering-Correlation-Id: f4e5ce51-3e62-4967-9b71-08ded0754c08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|23010399003|376014|366016|18002099003|22082099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	buza00rmCM/ea7pu4rolQz+ojkWUKT2uOaINOiR6YWY6B2z/IATyl6ytMDVDe7WBYPulskTK9vSwcrPqAbt77iQB/Uqv+N7hMx4HBUM8BEOEUaYrcUEEHk5hbHRnRVjFiARfeQIrAoXin0o94GSrZ6276OKVYqEORMkSeEaJfhC/KfmAJYUfsYTq7sjd/LdvaJzZK+42m3tgEch7BU7fn3J5S0g7Vmp4QtMqIF8V8UXo3iyQEu/qFwSApnGgvPMD0q4Ui2QI6XKTYdHfDhTcHuv8UmsYcP97OFQVaWVrw/6l17GdaA9ak45eclcqaBoHkFJyO2dNsUeHRksmXe9PSqlHVPkuLGBkwk2DMyFApgKfcrkSly6hXOTlJ9o5cKMH23J/73PaJyyjfX+/RZg88aH0siMZkkAriSOknH/Zqd6GSQFRWDLdD+OmdUgM4R/BzbiwQMQKdDb5Z2zJwbQNsC9d0VC50cBaK3UjSZiMCmr1RnEUnUIBy0pzHHLDvKJgE+d8AledTxy6wiCCivEDenugdszzKSUtikBDqMVpvGL1EV7Blk+vULFZiOcYLje7SJ8VksUqjbah5z+pLL7nzBE/fZt9zeH26cXLdLODzLLrD4qNXViE420RVwbb7tQwXoq4jdBraVmVC50bMSbfI8xLtrFjkLglzb3WTaZIn/0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(23010399003)(376014)(366016)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V4zPkwtuvWcwc4YF9ExUbKp0U3ba99OJHi1TY6kqeQWObTzBty4HcoKusBQ7?=
 =?us-ascii?Q?gaRhNknxHmBPw9p3C5lZEYdv02jt5iDJcLA6O8GgHajpiHrQIbchRejc4NNB?=
 =?us-ascii?Q?cpnVW5KaO0LthlQAgK8hXihRpGPxTl9sXazpCTHUh2MEmQAh9SyfzrwGIM8I?=
 =?us-ascii?Q?l7p+iinS5KIyb6KwGuGlgntrafMVHh/rA1ix6UaL4Q+OeHe543uByTawQtGa?=
 =?us-ascii?Q?dMGtTkrHEbokAUYmXC5RS+Iy2zx+gswwUB7gUr9PHj3kBLYV3bRU6PuukEPl?=
 =?us-ascii?Q?gRytc398HGXjt5tq8ktEAD7JkybVbj8N0iNduqKs+lFhjWGkgA5e8gtFm+++?=
 =?us-ascii?Q?RcosolXXqczTPiGl+kM6PrWniREV9+/hQsGdSULxGzVY59MUCA/+srRKnSOK?=
 =?us-ascii?Q?WdwT5PnUiUmBlfmUF9UtL51AbkwGJCLCj/HrsvWIm3OCnPGw5HBT6nUFSGf1?=
 =?us-ascii?Q?tcw8h8P80zpeIWeCSU3mYGhkgcIbvYlLMsOoHG6piTcnVUf+AbYM5mUow9/H?=
 =?us-ascii?Q?Qjc1soB+oJEqCNBa+df5MMq03lZjJRqKmRCXfiWSnhGQMWfBH/gTMld0lcBk?=
 =?us-ascii?Q?T6vHFWxaT03MWUtWHZ72JsZ0lpbtikcE/GcrPJoGOiaeEhncPRJlaanDgLuS?=
 =?us-ascii?Q?a7b4fT3g5hhs6Hpjl2EMkN6fUoJHnggvmnyIYGWyjbRjlT1OoGe49mfIPpH+?=
 =?us-ascii?Q?8PviXT4QCGFrQ+M6rGMqZMF9iLTO8gxzf5L8rwiLknE+TZplpsLx1dl1ubB5?=
 =?us-ascii?Q?2qFtNgbptjqaCcUG6Ov6ft5g1oOXdgW3YJ1qKyNy6VP1Z3BIHExrdvyjL8mV?=
 =?us-ascii?Q?Y10ZmkYlliSs7M7U5UFd32K6HsAOj4F/GD8rfMNKZU/GWdwoXZ8WpUgRAWJI?=
 =?us-ascii?Q?k8uNi4kaGhXIWOe3ktAH1b5ULbe844btbKAdzkSADstp8WdmPsoF0doJBixc?=
 =?us-ascii?Q?c5dQNUVdR0r0LZNRGap718ZKuvO2zivjiIhLQyCcEfRkO4RK8vpfRxWHCx+6?=
 =?us-ascii?Q?JFqKzQjD838vDg87c6MThJ3A2tEF2M9bgVKEMltxvMeoBGF2frrN+5RYeW4h?=
 =?us-ascii?Q?eZZd7ScfVzqfWSEgacqe8WphUALVgq/fJX25wTDqgPO+2hYLViKYsukMSO06?=
 =?us-ascii?Q?p+kp2knMtynjKb0GN+nGsq4HXA1x/wpqmJS+xj2lKJLD8LqnUpdGomAkf+FN?=
 =?us-ascii?Q?vdwL9nWltqNuIr5Fkq7crh95j8xD0jauXSb/7pP/rNU3/fCZN2/Pu5vdglNq?=
 =?us-ascii?Q?2XgkrAgzaQjXFmSacYfZp/UpYfpKrKzxB/Ue/aVcGAZOXDTk4PzKa0vIGfOY?=
 =?us-ascii?Q?JV9XcU0i1u0uwM3R/2D6rSQl2rBK1Y6FJeGTfPugh4yPBgj0RXpHd5p2XY7Q?=
 =?us-ascii?Q?34dSf20xYeKIDIBg2kFBhOE+IRBH9JEnqoOO29bV7k62FrDTs8KfJsfZqHK0?=
 =?us-ascii?Q?3egUmloUeC6O5rIbYnKLsupS+pfA6gnhlipdKl7st0WQkvPCe4DT/mHhYHm8?=
 =?us-ascii?Q?hUPprOv0b/2VF5D3aYPbW4XTATgjWKOCCcbuemlv98WZCUrpI4HTUPQ3VSFj?=
 =?us-ascii?Q?8dVd0FBJMsPf39Nubj8GjSsvVeMMQrow82lcl2z7k6C1XgUyeWboMyp45nFU?=
 =?us-ascii?Q?y5f05H9g+42oQKD2iBxq+x7CQZRUpy9kbH0z9TJg4v2CJq40eK5fElCAg4kE?=
 =?us-ascii?Q?iHI2yxvI1VyiUewyw1uUiclIBV3rgsd3uAlKipHS6uMX4KRyiYvJvCUhpES4?=
 =?us-ascii?Q?wZYs7YHv/usKKYjNH5WownSoa3YBLTKQmOhfVLF98feBskc4njQG?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4e5ce51-3e62-4967-9b71-08ded0754c08
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 15:45:34.1308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YxaA87kJDKrrW/+ieQagvVnoJRLgxzQoZEObxpeEH1UdnGOxgimIwSCZGTwwnzTocGkSEbg1T0FaEMqSAph6Fe8K73fiqkN6hFT8o2REJrnp4+cBRDjVESC9Fw7cQy8U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10500
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11725-lists,dmaengine=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:den@valinux.co.jp,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:mani@kernel.org,m:marek.vasut+renesas@mailbox.org,m:yoshihiro.shimoda.uh@renesas.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:marek.vasut@mailbox.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,oss.nxp.com:from_mime,valinux.co.jp:email,SMW015318:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,NXP1.onmicrosoft.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 091876B0D97

On Sun, Jun 21, 2026 at 02:00:29AM +0900, Koichiro Den wrote:
> Add core operations that quiesce only the resources represented by a
> dw-edma instance, separate from the existing full controller off path.
>
> For v0 eDMA and HDMA compatible register layouts, quiescing one channel
> must quiesce the whole direction because the enable and interrupt
> mask/clear registers are direction-wide. For HDMA native, the operation
> can quiesce the represented per-channel registers directly.
>
> No caller is added yet, so this is a no-functional-change preparation
> for delegated channel reclaim and partial-owned remove paths.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes in v3:
>   - New patch. Add quiesce primitives before delegated-channel release
>     and partial-owned remove start using them.
>   - Note: Devendra's under-review "dmaengine: dw-edma: Enable HDMA 64R/W
>     Channels" series may require a follow-up rebase if it lands first.
>
>  drivers/dma/dw-edma/dw-edma-core.h    | 14 ++++++++++++++
>  drivers/dma/dw-edma/dw-edma-v0-core.c | 24 ++++++++++++++++++++++++
>  drivers/dma/dw-edma/dw-hdma-v0-core.c | 27 +++++++++++++++++++++++++++
>  3 files changed, 65 insertions(+)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
> index 42f2f25ef377..f9d4e0411f8f 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.h
> +++ b/drivers/dma/dw-edma/dw-edma-core.h
> @@ -122,6 +122,8 @@ typedef void (*dw_edma_handler_t)(struct dw_edma_chan *);
>
>  struct dw_edma_core_ops {
>  	void (*off)(struct dw_edma *dw);
> +	void (*quiesce)(struct dw_edma *dw);
> +	void (*ch_quiesce)(struct dw_edma_chan *chan);
>  	u16 (*ch_count)(struct dw_edma *dw, enum dw_edma_dir dir);
>  	enum dma_status (*ch_status)(struct dw_edma_chan *chan);
>  	irqreturn_t (*handle_int)(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
> @@ -174,6 +176,18 @@ void dw_edma_core_off(struct dw_edma *dw)
>  	dw->core->off(dw);
>  }
>
> +static inline
> +void dw_edma_core_quiesce(struct dw_edma *dw)
> +{
> +	dw->core->quiesce(dw);
> +}
> +
> +static inline
> +void dw_edma_core_ch_quiesce(struct dw_edma_chan *chan)
> +{
> +	chan->dw->core->ch_quiesce(chan);
> +}
> +
>  static inline
>  u16 dw_edma_core_ch_count(struct dw_edma *dw, enum dw_edma_dir dir)
>  {
> diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> index 1781ba4f022e..316d8c94eff9 100644
> --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> @@ -160,6 +160,15 @@ static inline u32 readl_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
>  	readl_ch(dw, dir, ch, &(__dw_ch_regs(dw, dir, ch)->name))
>
>  /* eDMA management callbacks */
> +static void dw_edma_v0_core_dir_off(struct dw_edma *dw, enum dw_edma_dir dir)
> +{
> +	SET_RW_32(dw, dir, int_mask,
> +		  EDMA_V0_DONE_INT_MASK | EDMA_V0_ABORT_INT_MASK);
> +	SET_RW_32(dw, dir, int_clear,
> +		  EDMA_V0_DONE_INT_MASK | EDMA_V0_ABORT_INT_MASK);
> +	SET_RW_32(dw, dir, engine_en, 0);
> +}
> +
>  static void dw_edma_v0_core_off(struct dw_edma *dw)
>  {
>  	SET_BOTH_32(dw, int_mask,
> @@ -169,6 +178,19 @@ static void dw_edma_v0_core_off(struct dw_edma *dw)
>  	SET_BOTH_32(dw, engine_en, 0);
>  }
>
> +static void dw_edma_v0_core_quiesce(struct dw_edma *dw)
> +{
> +	if (dw->wr_ch_cnt)
> +		dw_edma_v0_core_dir_off(dw, EDMA_DIR_WRITE);
> +	if (dw->rd_ch_cnt)
> +		dw_edma_v0_core_dir_off(dw, EDMA_DIR_READ);
> +}
> +
> +static void dw_edma_v0_core_ch_quiesce(struct dw_edma_chan *chan)
> +{
> +	dw_edma_v0_core_dir_off(chan->dw, chan->dir);
> +}
> +
>  static u16 dw_edma_v0_core_ch_count(struct dw_edma *dw, enum dw_edma_dir dir)
>  {
>  	u32 num_ch;
> @@ -546,6 +568,8 @@ static resource_size_t dw_edma_v0_core_db_offset(struct dw_edma *dw)
>
>  static const struct dw_edma_core_ops dw_edma_v0_core = {
>  	.off = dw_edma_v0_core_off,
> +	.quiesce = dw_edma_v0_core_quiesce,
> +	.ch_quiesce = dw_edma_v0_core_ch_quiesce,
>  	.ch_count = dw_edma_v0_core_ch_count,
>  	.ch_status = dw_edma_v0_core_ch_status,
>  	.handle_int = dw_edma_v0_core_handle_int,
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> index 7ba6bdbffc17..63c30a6eb88c 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> @@ -70,6 +70,16 @@ static u32 dw_hdma_v0_core_int_setup(struct dw_edma_chan *chan, u32 val)
>  }
>
>  /* HDMA management callbacks */
> +static void dw_hdma_v0_core_ch_off(struct dw_edma *dw, enum dw_edma_dir dir,
> +				   u16 id)
> +{
> +	SET_CH_32(dw, dir, id, int_setup,
> +		  HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
> +	SET_CH_32(dw, dir, id, int_clear,
> +		  HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
> +	SET_CH_32(dw, dir, id, ch_en, 0);
> +}
> +
>  static void dw_hdma_v0_core_off(struct dw_edma *dw)
>  {
>  	int id;
> @@ -83,6 +93,21 @@ static void dw_hdma_v0_core_off(struct dw_edma *dw)
>  	}
>  }
>
> +static void dw_hdma_v0_core_quiesce(struct dw_edma *dw)
> +{
> +	int id;
> +
> +	for (id = 0; id < dw->wr_ch_cnt; id++)
> +		dw_hdma_v0_core_ch_off(dw, EDMA_DIR_WRITE, id);
> +	for (id = 0; id < dw->rd_ch_cnt; id++)
> +		dw_hdma_v0_core_ch_off(dw, EDMA_DIR_READ, id);
> +}
> +
> +static void dw_hdma_v0_core_ch_quiesce(struct dw_edma_chan *chan)
> +{
> +	dw_hdma_v0_core_ch_off(chan->dw, chan->dir, chan->id);
> +}
> +
>  static u16 dw_hdma_v0_core_ch_count(struct dw_edma *dw, enum dw_edma_dir dir)
>  {
>  	/*
> @@ -362,6 +387,8 @@ static resource_size_t dw_hdma_v0_core_db_offset(struct dw_edma *dw)
>
>  static const struct dw_edma_core_ops dw_hdma_v0_core = {
>  	.off = dw_hdma_v0_core_off,
> +	.quiesce = dw_hdma_v0_core_quiesce,
> +	.ch_quiesce = dw_hdma_v0_core_ch_quiesce,
>  	.ch_count = dw_hdma_v0_core_ch_count,
>  	.ch_status = dw_hdma_v0_core_ch_status,
>  	.handle_int = dw_hdma_v0_core_handle_int,
> --
> 2.51.0
>

