Return-Path: <dmaengine+bounces-9354-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOR4OR/wrmmFKgIAu9opvQ
	(envelope-from <dmaengine+bounces-9354-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 09 Mar 2026 17:06:55 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E769723C6DF
	for <lists+dmaengine@lfdr.de>; Mon, 09 Mar 2026 17:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A1D1130B18F6
	for <lists+dmaengine@lfdr.de>; Mon,  9 Mar 2026 15:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C523E0C51;
	Mon,  9 Mar 2026 15:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GBMAup7e"
X-Original-To: dmaengine@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011057.outbound.protection.outlook.com [52.101.65.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783733D7D6D;
	Mon,  9 Mar 2026 15:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773071444; cv=fail; b=fjmcWxMQXV19hjE5TRIXeKDbQnz7WldYXVGAukz7kQnZxATG3gVoS3x/kPOr3VcYVLJap2qTxtzAwTKQcwvRlZGwHdl8P8M0QyiKvZyh/djY0lUFESQvdhcYmCaf8xoJ5FU4shzmEmnTRqnIDahZbE1YPpcWK65dz0hy4HZrnXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773071444; c=relaxed/simple;
	bh=TTLHUxxuOjv6lt5zt80FKmnS0lRR42uZ9XX37SUnK+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pxve9jpsWiQIeVgW1J7vvIXefWeCtByujI/W9u2FyGoUqXFUKcsQmgX9uvw91s09pmVEmvqsGFJYRkyetaialNXS66A5XfPnOJ8J0SOQTGx2JEC8syxSPIWVZiyhHA2Ft3gWHXVpE+lPm3UoR4qRms2swCI7mq3ojmfzbDPpOc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GBMAup7e; arc=fail smtp.client-ip=52.101.65.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UGKvVDBwUwreS0RSorlRPop360Mm2eg2xfwv5DHshp6qMbIiVniCAfHrdCCRx62QOjxrGWzOEwJT+/7pRzk134mzNPXF6zy0cPrwnGZjJmBtHsr3D0KY2fl4o+ML895vnTaNXGrd5ZZ87VfyhmKnNbMewlAdy5uC9jK6IwNs+gXgmhmUVsZ4LyygW/oXEflroebcQ0GOsPpoBOB7hKpQgqGjcwuJM5fHLZwXmJjlcICLecmJ4p8xfwr0dsfP533SZ1aK0O1meq1UXpMDxLxwfHuyGxvgnSPA4JTf4Dw/W2htApkqVFQVhb14j25qLK2zdpBPkTGN15yt14HkAO9/KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TTLHUxxuOjv6lt5zt80FKmnS0lRR42uZ9XX37SUnK+w=;
 b=DyWd3ZzTCHyIaPrCFEeVvhkUYBMStHbBBHi9JQ2LV4NwD//RyENU7vfbQIF0C+pZGwImaVXRMOekPJSdqmvxq2ZC3UUU0FAx31c6r5OIqB8oD69Ac76kGZiEBAGZYSpQFM2F7QFjpPAzJiLRTEIJLVnIRgAjPeV3OPWOkhrO9Yp8Xve6PVbiMaRxMobhLcxu1GQULwbPhI0xB8kWSeE6hk28cRcJ1J7QFdmaB8/OD24ajfHLZJ3/iMaD9UnOb6QHS/X04TZM2EuHlZBuNgo2BoDEvuXQyVFjl7IktCdTHqu0ppwUnbJ1CA9TdgvvPSHweJanFqLoThHq37WoaUt7Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TTLHUxxuOjv6lt5zt80FKmnS0lRR42uZ9XX37SUnK+w=;
 b=GBMAup7e8Wx7j8O7PRzbemS9TwjvhmNugyzetNXrLIM8vcUzN7lPSTm019J+PQTJ0K8wB4I8rvMGnlpYPWklxHkHZtLpHqssYw5Bh/RCYpg/3PeFfkTB/c1fcEPvNgVIDft5KVDlSS576r9jT7uEMJVKluu/j3d+BMe9F226uG/n/6W++jKe8T07u68ZFh402PyD0/HkrGtBBIT50rvb564HLhbt/TWWhUzxirQFML3Dre0tqamhhJwg0Bj2F+BzCWpEUTkFfz2ss/eceI+R3OBV/ItAo+/mBC/zfLCHRyhvnKkJUb1lECYLjH6VqVXIoAPJ4nWd/Q+gnz5qcDJg8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AS1PR04MB9310.eurprd04.prod.outlook.com (2603:10a6:20b:4de::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.22; Mon, 9 Mar
 2026 15:50:40 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9678.017; Mon, 9 Mar 2026
 15:50:38 +0000
Date: Mon, 9 Mar 2026 11:50:30 -0400
From: Frank Li <Frank.li@nxp.com>
To: xianwei.zhao@amlogic.com
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, linux-amlogic@lists.infradead.org,
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v6 2/3] dmaengine: amlogic: Add general DMA driver for A9
Message-ID: <aa7sRockHl9uBybj@lizhi-Precision-Tower-5810>
References: <20260309-amlogic-dma-v6-0-63349d23bd4b@amlogic.com>
 <20260309-amlogic-dma-v6-2-63349d23bd4b@amlogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309-amlogic-dma-v6-2-63349d23bd4b@amlogic.com>
X-ClientProxiedBy: PH8PR20CA0006.namprd20.prod.outlook.com
 (2603:10b6:510:23c::11) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AS1PR04MB9310:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ab0f491-73ef-446b-aa12-08de7df39c39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|52116014|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	wdznjPJi5AEJgMoIuCd6cY4kZ8Vjs079Xry23isixugrFKmdpMvdHG91Zki2+Xoc7jjJ/v6q4yVJP72ZY45t6uubky2W2y5J2j4mofWDzCMxZ4e5LDXXUxA7SuDWMfYnqPcmioW0lPbC0sNZu7ik4HDiutwa+r2DKGIxzwNG+bvIELLzPeO1WWVeDv0uvYp+IbPeFcGydpCKy3iKS5zIugTWr46C5a+omYC+AhtKcGcnUlgzlo1zG/MWW4lwwDoIOUGvAT6DLABRxiAuKt5L7lDKCgtxOdwNVYT3sbK2PawMND1sCR/UYJxzDrnsW0YIsbOur8c+6O1Pyf0NcStCJe/2quWkO1gIDggBUoILtwI8i8wAmFF9uJqnrYvEEmxuizG3/5I8URfABOAbPr0lyMKLxOejhbvgXLiCV6DLnaMSfotveHnJFqY0rKXV2eIeOuiPmrPsEJy1wiNXiGkYSZUg/CBEi1D1dgH2Fn61vGb9CZ9tuDBysra77Ldc8/sd+3nluD9uavHjqHtJYa3phFf32adC87bBxlbKLEL4em4uQeXMEPNJ2+dOA+oGPaoZTBlxcJehOYKUjyRNBnyHrTDNUWY4Rpe2aZDgd3udGFkybjyq77svXoHYuN40fXnnrMJPousmzu9Bn5+lKOQDddFhSwJmIY8Asj5zyywEFKL+Wm0Mox5BW0/9Q/QTT8BWodx01nB52s6eN4A7ZcskZZmt+F2q7BwUf2QmLo5C6YbonIyQzISdu0jWOBCkxKXPnTSS7ghD0+zh66TYT5Cb4HsdHXN6rVzyABPUluJVrdY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(52116014)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?llDRp1yHS0KiwNn70I1wUCuQsjEf1DQQB7US32s3Ah0B30DY4c5EAe11QgrV?=
 =?us-ascii?Q?oSx+/pMTVgrFym7Vg/ZXnQslSTBLgYOKnWjy9kKs6WnS/FnOOSrVPgKuuiWd?=
 =?us-ascii?Q?ddS0npSK0K7mW0pcpJaKSdXnEjY7GWKFD/bFE0DnXaP9is61Q1EXSwsfJ4rO?=
 =?us-ascii?Q?YteE9R0AqmG3oHthEQrzlEn23n1E3rct+bzVjKGXXt49PZ3h3HUPPZNgFy8L?=
 =?us-ascii?Q?lTlbDXwBfX/dBjCsB3+swPRdoo1/4Ods1+RrdZZ/etTLkZSG4+YtOpEbZLQ1?=
 =?us-ascii?Q?eBno0iPdbq8Bldnc5xFWXyKJJFBtV8ki61aFJVVH5+nvpKEICb3LUglVkmwg?=
 =?us-ascii?Q?TOP9xnEm7MOOFOVX/uzHXIpFh0YrIyXFWL92wZqvritZuXf+oh1lFJWfvg8v?=
 =?us-ascii?Q?CHO+2nXc9PsaYDGNSMK1UONZji6keye3r+FbtdDbsSglMAerf0buIyR1kJ3H?=
 =?us-ascii?Q?1sDdqSSDH51LSaqAkSZroZW4ziP28lt3fD/elVt860aQSqx9fFvT7S8bqtQ7?=
 =?us-ascii?Q?TY7nBIuH9snIrUgVY2EUZiBDnsKI2iNraiKwlDi/oj87VkcDphOitkYYWBgA?=
 =?us-ascii?Q?FO2Oi10qVvH5Hk+WSQs7NqLXK+B+8gesEmtSBVscCicdTBjKEAIB4L2XoG+7?=
 =?us-ascii?Q?WnMQQHJrcFA0UV1lWAGOKfR1FIH22nBkeZPf4U1eoEd5gWs0wBCsMLCrlqTf?=
 =?us-ascii?Q?eBtMCNPgHAi/gVrqMYd2zKoiTitrw7deiv/XKH4GFu0L0xW2wCypb7noOKnY?=
 =?us-ascii?Q?eQP97uhxlL4pPWWfmvYRM1A6zJyiLBqPsxoo1hZm9eybG+uZ9O3RfjpiQhrw?=
 =?us-ascii?Q?YlsrHObR0XoxQbOUOmoHt7qMFIMmMN1iyf9//lNmhBejF91yOiuXxhPZGGCt?=
 =?us-ascii?Q?0g2oQ1BhlMEbB3FXdNOMStEQ5oDJVMfzKAynEzxUHpuo+368FFPoE6xYP2Eg?=
 =?us-ascii?Q?CBuT9NZOaZJmwrdV6RTFWqx5U5p6E1w15ZztEAmN9edoLfd+mFiFC05xzahy?=
 =?us-ascii?Q?SY7eGeCJLr5M/EMzel1/OmlXlP2fcH2TCVWe8UTUkcj4Oti9KsWjfe5uSvFB?=
 =?us-ascii?Q?01qCMJtCb2lGoI4mjO99Nkf2wOL6EtewZYlntifwk+RpVVSLomg/GpZgDrwx?=
 =?us-ascii?Q?7qDAsgS6NybpZSqweuEHQE5mpIpm/O6JpaZu6CH52jkCIPajUKbVMI7OJLiV?=
 =?us-ascii?Q?CQRH6NJYIr7yAcwsAD43uqxNFJe97uAm67lrWbkIBirVaMOjCfPigUWfy2A/?=
 =?us-ascii?Q?1+It/ortYRqX+fd5zmPM7AUaqAo0qNm47KNRKfUY6YjsRFLue7iC4jPBgKmq?=
 =?us-ascii?Q?ECYbTfcefPe3qpWQtGCbk+mCDvuWr27ulMKU+HTVAkdn3aDkT3Ke3Kz2FQDn?=
 =?us-ascii?Q?3GwHYSirJFGpFIwWsYdPrie39s3QJgnkTayd/Cs2YD1foEB2M8pRXHeOggJ9?=
 =?us-ascii?Q?sthYVdGebGBaI4xxH43gkPFr/3NpRYz0jsIFX1R/wgFmJ0sqhHDOmKRlu45p?=
 =?us-ascii?Q?AR/+bp0Ab80iQZ3qIEzNrz0PNQ9sm7GHLEadl+uyPoQZqySs6V9DJmSD9w0r?=
 =?us-ascii?Q?YSed6+GngO/XGeA6lfjCIdVs+aj/8Muc9yMtesxqUBMrgC/iz4iacxHHqEED?=
 =?us-ascii?Q?WF0NG4JuIWN4I4ChB4tgzeibnODIT13Q2MlNe41qfbSP2mIaJYyR6emvdhZw?=
 =?us-ascii?Q?Ja8i62FzHumfnttWrGhQX7Zln3NrEOF2HsY0ZPxLHANTmyf0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ab0f491-73ef-446b-aa12-08de7df39c39
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 15:50:38.7588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tmkoX2jS+yWlOfrtXjVLl2dmxw/f/CrYdgMYKh7M1U2gEeqvjIbwDq9V7Kr4yOFtKCyA+yGghSLf/xIKONaetQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9310
X-Rspamd-Queue-Id: E769723C6DF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9354-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-0.978];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,amlogic.com:email,nxp.com:dkim,nxp.com:email]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 06:33:53AM +0000, Xianwei Zhao via B4 Relay wrote:
> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
>
> Amlogic A9 SoCs include a general-purpose DMA controller that can be used
> by multiple peripherals, such as I2C PIO and I3C. Each peripheral group
> is associated with a dedicated DMA channel in hardware.
>
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
Reviewed-by: Frank Li <Frank.Li@nxp.com>

