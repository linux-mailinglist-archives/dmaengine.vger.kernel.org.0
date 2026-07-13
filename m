Return-Path: <dmaengine+bounces-12423-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FgBbKhUuVWr1kwAAu9opvQ
	(envelope-from <dmaengine+bounces-12423-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 20:27:33 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDBD74E78B
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 20:27:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("body hash did not verify") header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=DryEkRRN;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12423-lists+dmaengine=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="dmaengine+bounces-12423-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C07E63006D5E
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 18:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED03353A71;
	Mon, 13 Jul 2026 18:27:28 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011014.outbound.protection.outlook.com [52.101.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59C33537CD;
	Mon, 13 Jul 2026 18:27:26 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783967248; cv=fail; b=I9cIqD0KUE1MbHTAJAgu3deiaYLr3fHOdTVKY7t/rOPlu2jYVMTAJYu1qoCo1GKTugpi6VbEEd2ppPDBwjEDK4xFccqR4AngJPrbbucRnjgKE3exjYzLEjng7cybZqKog7wa0HVLuuH7wbnaiT2czF6HQf4BW6Uu6QDn0lgCa5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783967248; c=relaxed/simple;
	bh=I03mvByIEfdJ59/1OfI7gZ7ZA0y1Mx+buTDbNmHQx/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=P3LlViNgVrGI91tL3tp5WuOv6w7GD57eR6KMuev4Fa/N1MVGEOk4R2aKYPV6dRqTS5pJiW/J+ObTh/quyJZib2yiOA/sIIrQZjAxvYYjpcnu0TynwJLuao4vSWbfG8LvnxYQEyZy9TM1axCsmfriLv8OFLWSYLvbtqkjjMBVAiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=fail (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=DryEkRRN reason="signature verification failed"; arc=fail smtp.client-ip=52.101.65.14
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J5KgMcbSeSeEDRb7myI3jvmx2DyQFfGiVN3IeuYRcHqsN/TtJgmsvxBixJ8UMKW73ZkVOm1mTx+MHxlrriRCrudu848RTL/7OIEdm4gGX8/LIFbzHak6e27RqXZTbJurPv5HmWBQpXFBgZbgwnMCPqTRt/tOJQ3a1GOogn8i8i+2uCuZjfe59nel7Fb0C4IaluxE6rvVdLnCbxDUXO9Bs5Y0NcWN+wJUk/225d4PiuaiFy579OK+jRLvNSbuEKz+dQA6yZbr7Y4Ur7P3m7yjjpryYkxVtEiGjGBs49iDQok1vLCdjAM9U3tByhUUy2mUgXg96b+nDvQqv50bGyt8Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fxn0a3+AmWhDz3SMmB1e7ByA2/R4Tmt6h/cz0OP+avU=;
 b=MyBvGQE6g5uNZxSw1YqJnXG+dPI054Qk0g3eERVE4in2BHKqiz8DS6xAiZLP8ZJCEAgM3LX1iZVgJbgtFA6sQC1pgm7bQdU7CruksDv1op1/yHmBm55FrXGx5x10XYs2r+Rfrv91CrdHFKEz8O2vHqhrW2evYMp90K9nQHxtpNYjIQunjHMQK285yljT5RA9naKOzJfglblOrQmEEtv+pxYD+Ma5mgovq74aYNVCLiQ4r9z6n994Dj75OmwxZ59EOfy4FmXOO7FPVI0Hgn4qdP32Tvss/Y5n+7y97YdflyEAYfUyq4Ue4X+/zOJcX7DewjXlYMtAdt+EcG4ovMAg7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fxn0a3+AmWhDz3SMmB1e7ByA2/R4Tmt6h/cz0OP+avU=;
 b=DryEkRRNyPWdf5/yPEbChYYKQojwfzdrLQVZhsIr3z0BCznPpcfiER+QdGYRpx5rJaZ1JfhegSz1NT5zBJjgdvQJgiOBQaf4iBzvJ27sKWoVJKR96HzoOr08bd1c2Ca3ziys8eRApB8BTmKEZ5WFIZNW4TchNvlrZV+DPJIQM6IhQzNKojjWLhGiSqU4y2QFGyu65q6c/8g3C4vW4yTJeUDl7pOLtMrkRUL2ImgL525E+es66uu6aTvpP+MTgXI2y3wuWpo+2D+RXkCtRvPR6rUJ8pyQqe/I0p/R9TjSpDjgssrD3pCo6LgY4lBK6WNv8vrPII9G46Esxu8iF9DA+Q==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA4PR04MB7646.eurprd04.prod.outlook.com (2603:10a6:102:f3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 18:27:24 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0181.019; Mon, 13 Jul 2026
 18:27:24 +0000
Date: Mon, 13 Jul 2026 13:27:15 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: sashiko-reviews@lists.linux.dev
Cc: dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, vkoul@kernel.org,
	imx@lists.linux.dev, Frank.Li@kernel.org
Subject: Re: [PATCH v7 09/10] dmaengine: dw-edma: Use burst array instead of
 linked list
Message-ID: <alUuA4SfGY6R0cF3@SMW015318>
References: <20260713-edma_ll-v7-0-6fb7498c901e@nxp.com>
 <20260713-edma_ll-v7-9-6fb7498c901e@nxp.com>
 <20260713172522.3571F1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260713172522.3571F1F000E9@smtp.kernel.org>
X-ClientProxiedBy: PH0PR07CA0067.namprd07.prod.outlook.com
 (2603:10b6:510:f::12) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA4PR04MB7646:EE_
X-MS-Office365-Filtering-Correlation-Id: fcb8d34e-2453-4302-50e7-08dee10c6267
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|19092799006|366016|1800799024|376014|22082099003|18002099003|6133799003|4143699003|11063799006|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info:
	bQD4oAJPF2zQQ/psUcAesrEwVCwJk69ZL88YzDNhm0h77rWMPPsX9ZYuK1zmMNLSS3wJiF3JiJ6oQXoUWQf9JAw3sGj4BKKOYHbpUmhTUMiVPppJl1NPcEjjx9KvlJWSNgF/0RMsBjHNnLNcE/PB5/Bo2qwXEeXdUM4ULyetbbm9yyM0ZjaNehkatREheCdpUVTxPxta0h2FG012YnKEtX5ZFfk1Ovy8kYK0f4+3d+E/6sHFgVlrQ8JExU6JF79IAMHaYaBN1pPaDTTj5zGsbO9Lip2uTjujCxAHYODDolAMZIKUCSKxlxQQsZTfyV3UlN/lSnVZyXVI7lYPMJRSvZPgcr8AIUAu4BhnOKIrR3rlbjZL2FN/Ds7Xr+O9keyvFciFJL/FFP0P8GwW5qjFBYuUBGRaqS85b3HzSUPWhANEPhK/f1vC/A/zy6sEOG+QYCe4ZHIvDnSXgekTY86kQ1xNEU4i6KRWTJVlHOQZSzqc5+EA2vELaPYpipKYvBHOtpyz+vVdC85HzvkOCYz+rKUQdIOEYzljjkJSgNrfUB0w2Er8bakkYM18tHDAlX5MtC5INnVLz732dybbqATzynOyGNWtI2Qt6HCKeXq59JY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(366016)(1800799024)(376014)(22082099003)(18002099003)(6133799003)(4143699003)(11063799006)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?omLwP4sPAQyWLtfIgCAsrUREnBO/89jPsuA3QVhAa5hkHyAquGSUpwobIo?=
 =?iso-8859-1?Q?2Rf7ysw1y8/EiWOuiySaScZYHeqCUXH54/YSxANM5XxJHsXbJqQS34dr2v?=
 =?iso-8859-1?Q?ELfjdwABETsR6LDxg17xNzy7MyntaeYrT6pIJrqwtQUU0wEMSOeY49VqFM?=
 =?iso-8859-1?Q?UMU0bI26TIfZTt5HpKApFaxNWFk/4QAg6Z/2jMcx8cQhWr4p/hgadsGAU0?=
 =?iso-8859-1?Q?uLirQDODxUw373kGi1xUi8+cR45tWBUthVgQfi7DFJLkN4xDTI0lya2Dg4?=
 =?iso-8859-1?Q?2ir3nVzjjSzOTepYtcPBh0rkSof7YlzDzABuiP/VmbXbTBI1nLNFqBeNtY?=
 =?iso-8859-1?Q?E85xe/q339P5fVAVp+EutWaifcVe852tLlBe4LVsHqawmEF/upO923Y20C?=
 =?iso-8859-1?Q?GQV9gS2M7xPeBFumSRXpc3Aim/11InkSHArlbluH0fQiFZbKPKos/xop0x?=
 =?iso-8859-1?Q?qM3b78bXQdwCuvDA3cZwDyekgoXXT+sBjKMLNzxkzKRx1c2TGFTCmu5g7n?=
 =?iso-8859-1?Q?rOCGlry3rj4sJiWuZkRDTrvDyHY195MFIChaoCSar/8SDGnki5YOS69PWD?=
 =?iso-8859-1?Q?bVbo9bEya/pwhqA/ngH8obJAJOdhtIpHFg2IrylkSwhDwafnPqCBfSXxqG?=
 =?iso-8859-1?Q?ForRXpFAo2KvdY+7UXazEeyxf/laMUfMey9eATu4KnkSOtEYc9DRjddSeq?=
 =?iso-8859-1?Q?FU3bI9cOP5gY8U+bPzpbmINnXYOGBD2wy1q2t300BZ+1XdgEp1KfH/J+hN?=
 =?iso-8859-1?Q?RUmsYfFtSdFly+YmvzhlatxFZ9rrGlDNDprHppTD2H35dVWJ9Sin0auaQp?=
 =?iso-8859-1?Q?/54X+BZBIOB9salI0jhLfm9wtqheJETBlqnkSWsJJeaBFhkR6BcjYqgNid?=
 =?iso-8859-1?Q?ozv8K21VTRGTc1M5Y3i25W9prsMk2ehn8Fie7DPE6hO2j9LoZ16B/ntJB2?=
 =?iso-8859-1?Q?aDiGN0J6ITt7dKjAb2HgL7cZdrg3IrrRPMV7B5QH2LwkPCUUW8B/Wm0IAI?=
 =?iso-8859-1?Q?c+ZzovKi1/BjRJPXVU5gUXouDHaCsl45FAMU1PUb+V4EvEXPlwBc9wgqH2?=
 =?iso-8859-1?Q?WSvkKr3Az+g4ivfXWZ/8b+7HLV6EHk4rRBSd7YUzxxpxHsiYy4TZeRpl3U?=
 =?iso-8859-1?Q?V4nvk2/an1DFpB3WmugzXm9sscNJPskaFgSb2KdV8EH1LaU09JsoLYUmVh?=
 =?iso-8859-1?Q?BBSYuDN/Ut2UNfZzbmHjJh1lXCVA3d/EBEN8l2Esf6fhcnA98GACzO22pm?=
 =?iso-8859-1?Q?TzAe8+mVYqekGVUr6YcALbmlq649I6d/6/U96Uh+/Q6uzuWbe+O1nJ+HXv?=
 =?iso-8859-1?Q?yV7NeDULYoJEaVvnsivrbhjg5+P5qIlkCkKyUC2+NBbf+wutscocPbsQnW?=
 =?iso-8859-1?Q?ctoDisx6vbH/AVGIAQ3+zkY9OjsgppwQ9iVCdh3o8zwQEQiXabT2R3JPHh?=
 =?iso-8859-1?Q?Qgbqq7W2RyL+mqa4icWVsperyBiLaBeZndffQMBAWFxgD3k0DUmyYlvjMJ?=
 =?iso-8859-1?Q?WU/yqiKvsHEWQqKOH3xnk/I4nEUUUkhJstZ7sV/U4+zPHHgXdM9YPn0wtj?=
 =?iso-8859-1?Q?9SxRzevpm/00j670ULS7u1SkHbt9ZOs4WmaDJjGsFV2AfgwfxHvXtiLKhU?=
 =?iso-8859-1?Q?+Xiuu9kAF9zZqo8C+7Pi+pWzKK1IGZ733qVz70JWnoAwhXMdN5qy+Smp2v?=
 =?iso-8859-1?Q?ziHYcXNm3PK0HjObn2jtaWUnqGwoR1prCIEpmqJWdGAEmiKWKs9MaWC3bc?=
 =?iso-8859-1?Q?tnGL8H7GXR23isUfGzdVNej4cJ5L/KnnSe9l6oVEwUPhs5dr3YP7YvxLrD?=
 =?iso-8859-1?Q?h7jhGT73wNky0Cru+OayHYs5iZqPRunQ6r32e6jMCPap69yut7ZE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcb8d34e-2453-4302-50e7-08dee10c6267
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 18:27:24.2623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jngSs8KsVCH8btVKU5lcBjEcb0tLd2i/e+qC5WW/NH80MwLtSha9l36AKXhlHmovIUzWL7IoaZxkfMluDGXNrS1xaosL0X+yiZw2rcYpb+IF0rTcNJyu9o3P817WMke7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7646
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.14 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_REJECT(1.00)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12423-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:dmaengine@vger.kernel.org,m:linux-pci@vger.kernel.org,m:vkoul@kernel.org,m:imx@lists.linux.dev,m:Frank.Li@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:-];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.nxp.com:from_mime,valinux.co.jp:email,amd.com:email,sashiko.dev:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,SMW015318:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9DDBD74E78B

On Mon, Jul 13, 2026 at 05:25:21PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
>
> New issues:
> - [High] Early break in scatter-gather loop leaves `chunk->nburst` incorrectly sized, causing uninitialized descriptors to be submitted to the hardware.
> - [Medium] A zero value for `bursts_max` due to small linked-list region sizes causes a fatal divide-by-zero exception.
> - [Medium] Replacing multiple small slab allocations with a single large flexible array allocation in atomic context risks memory allocation failures.
>
> Pre-existing issues:
> - [High] `dw_edma_device_resume` calls `dw_edma_start_transfer` without holding the channel lock, causing list corruption.
> --
>
> --- Patch [9]: [PATCH v7 09/10] dmaengine: dw-edma: Use burst array instead of linked list ---
> commit 7aeaeaa1123dc1b005fda28afac5f4dff692b62b
> Author: Frank Li <Frank.Li@nxp.com>
>
> dmaengine: dw-edma: Use burst array instead of linked list
>
> Creating a DMA descriptor requires at least three kzalloc() calls because
> each burst is allocated as a linked-list node. Since the number of bursts
> is already known when the descriptor is created, a linked list is not
> necessary. Allocate a burst array when creating each chunk to simplify the
> code and eliminate one kzalloc() call.
>
> Tested-by: Koichiro Den <den@valinux.co.jp>
> Tested-By: Devendra Verma <devendra.verma@amd.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
>
> > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > index f52d9fd18e573..c028011cc61ca 100644
> > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> [ ... ]
> > -static struct dw_edma_chunk *dw_edma_alloc_chunk(struct dw_edma_desc *desc)
> > +static struct dw_edma_chunk *dw_edma_alloc_chunk(struct dw_edma_desc *desc, u32 nburst)
> >  {
> >  	struct dw_edma_chan *chan = desc->chan;
> >  	struct dw_edma_chunk *chunk;
> >
> > -	chunk = kzalloc_obj(*chunk, GFP_NOWAIT);
> > +	chunk = kzalloc_flex(*chunk, burst, nburst, GFP_NOWAIT);
>
> [Severity: Medium]
> Does this single large flexible array allocation risk failing under memory
> pressure?
>
> If the hardware configuration results in a large linked-list region,
> bursts_max can exceed 2700. This turns what used to be many small 24-byte
> allocations into a high-order contiguous allocation in an atomic context
> with GFP_NOWAIT, which is highly likely to fail if memory is fragmented.

This is most likely never happen. It is should be wrong if such bigger
linked list by once trasfer.

>
> [ ... ]
> > @@ -166,23 +103,17 @@ static void vchan_free_desc(struct virt_dma_desc *vdesc)
> >  static void dw_edma_core_start(struct dw_edma_chunk *chunk, bool first)
> >  {
> >  	struct dw_edma_chan *chan = chunk->chan;
> [ ... ]
> > -	j = chunk->bursts_alloc;
> > -	list_for_each_entry(child, &chunk->burst->list, list) {
> > -		j--;
> > -		dw_edma_core_ll_data(chan, child, i++, chunk->cb, !j);
> > -	}
> > +	for (i = 0; i < chunk->nburst; i++)
> > +		dw_edma_core_ll_data(chan, &chunk->burst[i], i, chunk->cb,
> > +				     i == chunk->nburst - 1);
>
> [Severity: High]
> Can this loop submit uninitialized trailing descriptors to the hardware if
> the scatter-gather loop breaks early?
>
> In dw_edma_device_transfer(), if the SG list is exhausted before reaching
> cnt (which can happen if the original length was passed instead of the
> mapped length), the loop breaks out early.

This never happen because pre-alloc enough space it.

>
> Since chunk->nburst is pre-allocated and not reduced to the actual number
> of prepared elements, this dw_edma_core_start() loop will process the
> remaining zero-initialized elements.
>
> Because the completion interrupt flag is only set when
> i == chunk->nburst - 1, the valid elements won't trigger an interrupt,
> and the zero-initialized elements might cause a hardware hang.
>
> [ ... ]
> > @@ -206,14 +137,13 @@ static int dw_edma_start_transfer(struct dw_edma_chan *chan)
> >  	if (!desc)
> >  		return 0;
> >
> > -	child = list_first_entry_or_null(&desc->chunk->list,
> > +	child = list_first_entry_or_null(&desc->chunk_list,
> >  					 struct dw_edma_chunk, list);
>
> [Severity: High]
> This is a pre-existing issue, but does dw_edma_device_resume() call
> dw_edma_start_transfer() without holding the channel lock?
>
> When the dmaengine core invokes device_resume() without holding the
> virtual channel lock, dw_edma_device_resume() modifies the channel state
> and calls dw_edma_start_transfer().
>
> Because dw_edma_start_transfer() calls vchan_next_desc() and reads the
> chunk lists locklessly, this can race with concurrent interrupts
> (dw_edma_done_interrupt) or software calls (dw_edma_device_issue_pending)
> that legitimately take chan->vc.lock to modify these same lists.
>
> Can this lead to list corruption or a use-after-free?
>
> [ ... ]
> > @@ -530,15 +456,15 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer,
> >  		if (xfer->type == EDMA_XFER_SCATTER_GATHER && !sg)
> >  			break;
> >
> > -		if (chunk->bursts_alloc == bursts_max) {
> > -			chunk = dw_edma_alloc_chunk(desc);
> > +		if (!(i % bursts_max)) {
> > +			u32 n = min(cnt - i, bursts_max);
> > +
> > +			chunk = dw_edma_alloc_chunk(desc, n);
>
> [Severity: Medium]
> Does this modulo operation risk a divide-by-zero exception if bursts_max
> is zero?
>
> If the hardware or device tree configures a linked-list region size
> between 24 and 47 bytes, ll_max will evaluate to 0.

It is wrong dt config. dt region should be n*4k space. and next patch
remove bursts_max.

Frank

>
> This leaves bursts_max at 0, which would cause the kernel to panic when
> evaluating this modulo operation.
>
> --
> Sashiko AI review · https://sashiko.dev/#/patchset/20260713-edma_ll-v7-0-6fb7498c901e@nxp.com?part=9

