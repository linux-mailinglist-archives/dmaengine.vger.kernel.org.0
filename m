Return-Path: <dmaengine+bounces-9283-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKsYClOuqWn+CAEAu9opvQ
	(envelope-from <dmaengine+bounces-9283-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 05 Mar 2026 17:24:51 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9E2215647
	for <lists+dmaengine@lfdr.de>; Thu, 05 Mar 2026 17:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3902C302E12E
	for <lists+dmaengine@lfdr.de>; Thu,  5 Mar 2026 16:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC253A4F49;
	Thu,  5 Mar 2026 16:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DU+zr0lm"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013060.outbound.protection.outlook.com [52.101.72.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5119539FCA6;
	Thu,  5 Mar 2026 16:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772727889; cv=fail; b=swwO2USAZWGUvIk/EEFjMbkRWU4VSsISNnNPklRHsNkF/MlhMZAofu6ZXcIXR0pSnt4z9mpBMqFje9+ZglHU9xc1tXUigoqZU/nvY3fKC4ivYLhlwgzt9Bx4NelnYlJ+WqwvIrhxoFu72bgg9ptu5BWeZUJlcTaWLXBBgtdLVxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772727889; c=relaxed/simple;
	bh=r4iAfdzfJ0xdjufsBk/of7I5VHr6RAnFLrdEyJrTHnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lgsBGL0tmfmaUf4ePUOY0if7cl4GgnfXKSwLjBXtFf4bPLz09miFgD+owlhZbdGgMaRDPh+fRi5rgw63YIN/zhXk6Qnp2Z09uV0WSOSZoR8TphTX2lw3GnSASvTG7eZTMQpoAfxjfZrdOb8LsBt4I8438fSTyNOrHt/WtsOqSc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DU+zr0lm; arc=fail smtp.client-ip=52.101.72.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xdyZ+M5MjA+lNW/3u8wlBRJZw94Avto1OZuR15rtvDz69d/aeEViD363GOxqJbd+KrLSxyzwHgNIrRWY1LdEm7DEoJXck5VbIYQm5547undAC844r2P81+HjEJUDRU9NBBl5NDxf4mZQ2nUnJcnB8MkNdOu3vXY+/dT30W1m65gV6Gr5k6NxrYMZgBGtAstXkSIKqaPgcKD1EFrIMp7PKcO51z/LlqVwGmosc1kIkJA+cBP/ZDyG315QQdbfTog9FKbl6tAUQeFRv2V+IRQR4AZWNhgLpcYp9iwGk9upLQTWPkLr7UdenZa3PwFaYUyF+q/vlT9AemjHaaicm1ygXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U7kIez0CI/HMbKpKYUI72o1FQGwDef8viWHIH7PjsuY=;
 b=Xvonbx50QDZWUzwCI3TKKTpkAGqkWy0Kf6cSaHSt6woInB7c621RsamvVBjU7w1yrpE8I5ougnFJXk+yYSVfv81Tp4jkR6OSkkrhgc97BUpCm1Qx0SrGOmH944yIIrra8Lb0g4nNdE7nauE6UZWulGa5PJIE8l/HhQdj6ilwAmksmPrqUTWwxQ6FzZRK7AqIMeTfOKCWRIaNKN0ZhVtL9iD79xnJ+jDLhIWAqz52nBkae580aWwYjl1/IE8D94kGbxwuHitTw5L1A+oYLNpRa2bul5H8GZbfg93j2/1gPArdUggVvuzHDBK8mzpPpVex6f8a9kNY9NEPxWE8DIzeJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7kIez0CI/HMbKpKYUI72o1FQGwDef8viWHIH7PjsuY=;
 b=DU+zr0lmc8W3SycNzLOAJk5q8QCo8AszFzJrBndrX/cGBPR52l5E93JSFDEotypKQx+n6DHIFYkAwM94+rm6M6K5V5ky8rvZ6ovq2mVujHqg9gBt5P3tf/jjF6p+rgIfAvD6ssfuMxZKns0GKGdhT9XSBnK0WQ6DKiIJCb0VlOAVPQxY5txMXClimSNHVAZUZKaNBdFhv0Jrsm6kFwdzpDO4GLspYPqghIYHiODtPS/riwaXyrHAjZfLAZjimIvEaAhGDyaLYXdOQaKMoOo6UXkg/SAE71f6AnZUBYZLO1xX8L+HFKF8ty564x4KZkhBAgpKzH0hVbNgrXX/Rvdeew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by GV1PR04MB10968.eurprd04.prod.outlook.com (2603:10a6:150:20c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 16:24:42 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9654.020; Thu, 5 Mar 2026
 16:24:42 +0000
Date: Thu, 5 Mar 2026 11:24:35 -0500
From: Frank Li <Frank.li@nxp.com>
To: LUO Haowen <luo-hw@foxmail.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: dw-edma: Fix multiple times setting of the
 CYCLE_STATE and CYCLE_BIT bits for HDMA.
Message-ID: <aamuQwFDJnJf0jyg@lizhi-Precision-Tower-5810>
References: <20260304025049.324220-1-luo-hw@foxmail.com>
 <tencent_CB11AA9F3920C1911AF7477A9BD8EFE0AD05@qq.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_CB11AA9F3920C1911AF7477A9BD8EFE0AD05@qq.com>
X-ClientProxiedBy: PH8PR02CA0010.namprd02.prod.outlook.com
 (2603:10b6:510:2d0::21) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|GV1PR04MB10968:EE_
X-MS-Office365-Filtering-Correlation-Id: 8574e3d3-5970-43b4-8403-08de7ad3b4a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|52116014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	vOWvR36+clHJ+oHJbbS+xXr9TpzocjRQ3E0Z6VnOw+BT+ozGWGfkFVD32Y1EbnWEZNYKEl0xZ9yJBSQOuErKhD4+cPXuZ2juraq5swyMATqbLEGSjbKncB2k+RQ/BQtSVT5A1mfuOjjYXnlrY0FSLyvXdu5/NV2I+5tOOxKuEQbrZqR38oKV6EhHZNhqMN7nQFtSqgYcgQB47L9NiAf3rCT1Ctu6WKq5GassDD613rWGuju3mosW4mg9eZ3L3gNCdUy1MsPK/VvP0JWD4cs+n+2Ux9efCmZeBsD5ZnA/eoNlncGnwHEh5LS5+EVcn27ykEL0Mkw6y5MoT2TuSDwGgG2x3nBXQTB/TeGIMSZv4RXgCjO9O6jiquxzYXjrMbnlleECf1oc1gOYAaiwBG+blkvNuDNQHCi77cdZOY+M+kEh/h+rdkhIRCd4mmPINknU95BxPFYD0Lm5QJbqC5fGJRR5litB9WM50GcbiqcoHE/DxE99lCv8WAmx2112mFl3HB7+HDd1f3hqX7y+ptkM5sMASjk4mdNTdmPTOfcizaJMuE7c+QhCcavXpGbXvHehhoNFmS2pkGj9jAMq9x9FMseIhYT7Gb+7kOR+eOwM3L4s0qzJgqEi5dqlGMwyqD+LkORL8YyHoOkeTiG2km0CxfT8hE2QUCWJm6vjyRJ3VbZdOZvpvs2v4CVBr7dUi/Ya3iAoW/HZFmuTn2THuvx9l2OEeG4I4F/bj3iZqMDHq9vZBn/ZMLveQbKY5WF0uT5MazBp9gAVe1vY2FV43W4h3QpV2t0MuOf3HNI5jIxtjpg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(52116014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AVAJbmdGrAJcCwdS7O8ppKBgdus8nbWgd9V9k4GfhErHmPA1zvkjZWSjID0w?=
 =?us-ascii?Q?Qn7yFk/3e0Q94dD4yCu6pQrOZN8zs7q99kyvSzqdllDAy7L8lS0C3uIA385v?=
 =?us-ascii?Q?SdytSU+b3rn+PEOHOdicg0SMGwFQiD9QG3sS1zedBXs8+PYOnq79RnB91rvV?=
 =?us-ascii?Q?S+UW61XAsWjSUno6pLpbxngs3yAvVUucM9Elc2AM+T9amHN7zkPzjLUY3IhB?=
 =?us-ascii?Q?vpSr9AXOlhBGK6Z3FQil3VZxdlHZZCZqDOcz7MYAvMfYbL/HrXlXXrQtCPQS?=
 =?us-ascii?Q?KKZOk0HYoQ11QQGe0wJJDp4sTUdGLMH708h0NUrjhUH/G0nNRV+rS5F32i18?=
 =?us-ascii?Q?IM+q+yjOUUzvus5L2Wp9jdTzEszk75p9p4b8p37HwTcrodSL7hH4hRQ2Xnxh?=
 =?us-ascii?Q?wQ9N62jnEFeCl6C0riZIAe3RGubUif7mQD1hril2RTxiIVM48K8TyWPz5qS9?=
 =?us-ascii?Q?w1Yf48PVxzfIUnlQyHTLGPkp/QNRmmhb0xnUEj6RpzPb6wH0ftCiS9XCdfmA?=
 =?us-ascii?Q?39aSNmtvJ1JsJW9jIOLyOlTjzcSp50vPVl7R9eZVtn+TwF8xAFeBOt7OSw1Y?=
 =?us-ascii?Q?dNEMyqfNdWviK8gW4Pld3J9dUIUC9PlQjiBtFZHJIcC15jBdKPj0z/fNCArA?=
 =?us-ascii?Q?rFfFVoVDTr2qqdPjS80caMYpDdjgv5btGaFUtZUYYJ7Ksc0mZN+vCK57hJEu?=
 =?us-ascii?Q?q0GE1gzrGDWf0tyWM6zB7S9IlM560BTIFVxecyLBCi7Vu/eWS11GVcK8afT0?=
 =?us-ascii?Q?X4z+q+z5HZ085Z1fqAanD3cGkk9187iY49KojlX7tnr1+QTFPK/qXXzYpF4Z?=
 =?us-ascii?Q?HG9t/a4iuTyI/pUa/3CPsaCsoPoZqK1zv7D9sPCfpNEwl/kc/wmOs9tkdngQ?=
 =?us-ascii?Q?9B/vIviFdT2FKxTDa0VTlCYBx2rxGIIjbHPzKQ6I25gC77U8EBflH1pVQQWe?=
 =?us-ascii?Q?om8UHADplMoYXezNM0I62Ns0o46akFxm487SzdpHAkLdIR+2ZsZZCFjy2YmV?=
 =?us-ascii?Q?mW5DPGgy68BUiCbEjEGfIZli2uWUqi/YqsM2pRNs8q7zvvGAWDVFzG8GlMy4?=
 =?us-ascii?Q?gh+IP3Ju+WQ19E1CP+6ADlKICtLQAuOIDuMkqR9Gh9SnaORgTp0ApimLtvcV?=
 =?us-ascii?Q?3/+aVybevUsL0Aa1jynk3Cec5ODsjLTXZxDp+JUkDaAy7HkbyUoPmiPc9/E8?=
 =?us-ascii?Q?u8Loo5i45hN0mwgrA5+DNELnfsFvIPJBlRed+hAdIOIN9Zy+nmzm90Ht5/9Q?=
 =?us-ascii?Q?4dzWxIf5u7PdtH49bkClsYXnnbPFcpeaolHnmzakDO8z9DM6nek8+Yd5sOHP?=
 =?us-ascii?Q?4ZDWkZQH5f7kNrSmPSNOiTqx0vTOb3F/cSgd+92M86K6gOpQsz0NgujzbTJx?=
 =?us-ascii?Q?C0b5Gi6bF9aWwnhdF+4GVPspA6rpwp1lt8jCAxlOZwZZ20dFp2osfgl/NCSU?=
 =?us-ascii?Q?ltw1wlBdNSdTZq6SanBvnTFR5s6ON5X88dbp2qd3kVDsZARtVTFYOwkOFVhz?=
 =?us-ascii?Q?SMEjii/j3Y0eXpIY4MWOWIr7nyTK752uMVQ3ImvxpL2bQumFX0efNaXyUZy2?=
 =?us-ascii?Q?TiStzTpin5Ev00hYXDX93+c0XSpw4VL1AXJ8HyZS5AQxG1UZHCRChc9O9iFS?=
 =?us-ascii?Q?BcZDUbT8E1gWQA8U3/wBaYMokJ1b5y8Dcma6avDMVXlxnYrC7IJrRefTN8gk?=
 =?us-ascii?Q?bn76xrv+x4xH5YAT0Vb+ClQ88ZVtMqihOTdVryQVRjfe3gtU/cuILQQhA5/I?=
 =?us-ascii?Q?K72J5KCiOA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8574e3d3-5970-43b4-8403-08de7ad3b4a4
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 16:24:42.2373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dt/ZnlyRVI+TaSxx+HigQEw1pCRXcYrbRnsNXh7rfSsnVDp/ONL+f3n3x+zFT969tq34toZrI/oPHkVR0/NNCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10968
X-Rspamd-Queue-Id: BB9E2215647
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9283-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[foxmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-0.994];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,nxp.com:dkim,nxp.com:email,gxmicro.cn:email]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 02:45:09PM +0800, LUO Haowen wrote:
> Others have submitted this issue (https://lore.kernel.org/dmaengine/
> 20240722030405.3385-1-zhengdongxiong@gxmicro.cn/),
> but it has not been fixed yet. Therefore, more supplementary information
> is provided here.
>
> As mentioned in the "PCS-CCS-CB-TCB" Producer-Consumer Synchronization of
> "DesignWare Cores PCI Express Controller Databook, version 6.00a":
>
> 1. The Consumer CYCLE_STATE (CCS) bit in the register only needs to be
> initialized once; the value will update automatically to be
> ~CYCLE_BIT (CB) in the next chunk.
> 2. The Consumer CYCLE_BIT bit in the register is loaded from the LL
> element and tested against CCS. When CB = CCS, the data transfer is
> executed. Otherwise not.
>
> The current logic sets customer (HDMA) CS and CB bits to 1 in each chunk
> while setting the producer (software) CB of odd chunks to 0 and even
> chunks to 1 in the linked list. This is leading to a mismatch between
> the producer CB and consumer CS bits.
>
> This issue can be reproduced by setting the transmission data size to
> exceed one chunk. By the way, in the EDMA using the same "PCS-CCS-CB-TCB"
> mechanism, the CS bit is only initialized once and this issue was not
> found. Refer to
> drivers/dma/dw-edma/dw-edma-v0-core.c:dw_edma_v0_core_start.
>
> So fix this issue by initializing the CYCLE_STATE and CYCLE_BIT bits
> only once.
>
> Fixes: e74c39573d35 ("dmaengine: dw-edma: Add support for native HDMA")
> Signed-off-by: LUO Haowen <luo-hw@foxmail.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>
> v2:
> - Add Fixes tag as suggested by maintainer
>
>  drivers/dma/dw-edma/dw-hdma-v0-core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> index e3f8db4fe..ce8f7254b 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> @@ -252,10 +252,10 @@ static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
>  			  lower_32_bits(chunk->ll_region.paddr));
>  		SET_CH_32(dw, chan->dir, chan->id, llp.msb,
>  			  upper_32_bits(chunk->ll_region.paddr));
> +		/* Set consumer cycle */
> +		SET_CH_32(dw, chan->dir, chan->id, cycle_sync,
> +			HDMA_V0_CONSUMER_CYCLE_STAT | HDMA_V0_CONSUMER_CYCLE_BIT);
>  	}
> -	/* Set consumer cycle */
> -	SET_CH_32(dw, chan->dir, chan->id, cycle_sync,
> -		  HDMA_V0_CONSUMER_CYCLE_STAT | HDMA_V0_CONSUMER_CYCLE_BIT);
>
>  	dw_hdma_v0_sync_ll_data(chunk);
>
> --
> 2.34.1
>

