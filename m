Return-Path: <dmaengine+bounces-11714-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TynRJxzBOGpahgcAu9opvQ
	(envelope-from <dmaengine+bounces-11714-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 06:59:08 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 109A26ACA47
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 06:59:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("body hash did not verify") header.d=valinux.co.jp header.s=selector1 header.b=q8oYq5rj;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11714-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-11714-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed)" header.from=valinux.co.jp (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 13338300E5D1
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 04:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF33351C28;
	Mon, 22 Jun 2026 04:59:04 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020122.outbound.protection.outlook.com [52.101.229.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EED118AE2
	for <dmaengine@vger.kernel.org>; Mon, 22 Jun 2026 04:59:02 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782104344; cv=fail; b=u7I1iJbpzczmChtEn/iYVV92o0e3knnfeNSuoMJFJOtASl48P0bUeyzIu5H+5juuYUFQUSCFu5Pg6kE0MvdaVWQaG4AB36QU8vsdGD2fst3vPJaof7/gT/55DszRuXc6mr+B/p5MRy6gHAXH0mhwwZ1o+2UMYtX7X6IhkX3w9wE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782104344; c=relaxed/simple;
	bh=inxcjcrkZj3rIdNO7RAJCUcAGPn5G8aVWx3sNrPVAjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YvD9CCxifdgVHM/WnK72iEvzD+pVrkrcptnRE7vKlDCgS0D4120UTZS3L5mCFzBQIUSzeprsWnLztfJSdKerkMVzMEbmB4f4F6gg6zMx5Gua4RiPh1PSgD/P5KO88EJvhVsGsM/PdkHzn3S0vQgMO2wKMx4DAOn/eAgDsQd2fXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=fail (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=q8oYq5rj reason="signature verification failed"; arc=fail smtp.client-ip=52.101.229.122
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PV7S4K83q76Tqme7vUJba9x5Zv4G6f72n/KEhaThQfL9vCUwDF1veV5mtSDTfc3n8kC98EcF6JsFAorIhDRcuoPHW2GKlra2hYyUwh2ET2ex6BixHve8oSkH2DCJOz0xkeSpSEk72ICrDry7ncO4TsWWr/los8r+Njx9q6NzWvt3PZTA6eqbED3I6O32DzysMSFvMscFe+FhDfOv41JKLqNmI4+2UXFmp/Hi3qdCmikNWl9hl7EPwZ+ls8MC9xL1xaa8F0C4vM7rMHjZl211WHpsHE1SVcMWSAVUbT/dsNtyGAOf/1bNYdOXkpcHiW7eEdIISCOw5vmY5355D7vqXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cN37D4nto3X6zkcOG5v1upXRDah8E09dHuEtloPhjnw=;
 b=mHqksMSYwKKX1i+tEQIsI5Qh4goPv/aApOmuhflshObfhMndoSvlqe/jPAezK7jzFqsTexVbQxDIiMd4I+DZe6Zt96A6uWlEZ9PD3LHhyQ5Ld6bRM88aBEK6t844wVNUus9MnnZA3VwHqAP0dAgPPtUvLi9qFWh7ZHk/Q+BnoaeZWjPXUb9GopF6VmDlHOBvC7j6cgceJog85UWi0INfcbBU7hYCAqXn208ZnN2FwcUBrv4m7bdNQW7rzdn5as+JLOurYA9tsOQsuCc3V/O6qX1T+JsuS33veHcP6knfZRh2/uu2/eP4MH7BfiPIIFZWxV1D1bYHbR5i9WBj7wAiFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cN37D4nto3X6zkcOG5v1upXRDah8E09dHuEtloPhjnw=;
 b=q8oYq5rjUVhwXB4aHTitno++SDSZOpci2viM4pPXhJoSrond5rX5KnKfo7OgzvDicx1Xeg4GPGUUnm6LChVtiqHVeApQY99kfXX2ovWgMmXTuzGMs0cb7+gkGg/mVYESPeh0ElRpVqtlIzs8ByMzR9+XPOzLXydGRoEcgpCDMOI=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYTP286MB3526.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:39e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 04:58:58 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 04:58:58 +0000
Date: Mon, 22 Jun 2026 13:58:57 +0900
From: Koichiro Den <den@valinux.co.jp>
To: sashiko-reviews@lists.linux.dev
Cc: Frank.Li@kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v3 04/13] dmaengine: dw-edma: Initialize IRQ data before
 requesting IRQs
Message-ID: <tgkwvxdosgmd72uyygqghjfynou4fd2nfdqldet4rfn6ekgl5f@tv54kq33sznf>
References: <20260620170040.3756043-1-den@valinux.co.jp>
 <20260620170040.3756043-5-den@valinux.co.jp>
 <20260620171637.7E6C81F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260620171637.7E6C81F000E9@smtp.kernel.org>
X-ClientProxiedBy: TY4P301CA0018.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2b1::16) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYTP286MB3526:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fb268f9-30af-4843-e669-08ded01af82e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|10070799003|366016|1800799024|4143699003|3023799007|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	+gzdp2KTnhXU/9mtqu9TIvytUxY/QLuH9OVq7tMuaQW26oBMoiJdnjknIAk3fMUoK23kAjJ5+7ksBXlQ7SZYHzma/Um5HPTuyF2vGe+inAqysmND5N2iDzL9T66p3W933EV6M5NP4YTYRzSwt/UqQTrXPCx43PR51liwkWXE7sgMiEv6JR18X4rMGjMWg79vmeX31RAn8oUU7i6Y1xtDNrtn2AKhFnn7e90GhFgPAYlXHqr55wkKGxBH2XyImOmMlDtAGH2qqTen+e+htne/5rzfO80Tu5THBfDaGCJxuwVlIN4zXcdqQOB/O6QW2vLR81HDTNq+WCTSEz99KLv0+w0M58kNdxwPcbnBH/53PUc5NUeXd0tdFF+PMBfHvBib+7kFX002Djg3HVMGFUptJOS054yXiWKN3hPNqfsfxRuQdWSI9clvih8ER9F/iVT+lGzLT4JPP4bzXGz73nOSjIiH+zPg0Y5jU0o7dZKDL/e9EoQe54diPhPgyfdZwgoGZzxv5+z0qWSS1cQ/sqGIankWz0EZREdgfynMq9oRvHHKVm+GlbxEjMnFExYDDq0S37DQ8Y3Bc6JUo4drMIwt5b/ul2hpiXw1hFYN14oewGI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(10070799003)(366016)(1800799024)(4143699003)(3023799007)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?89zJU/n0YcS5dPdo72Gt7iHSziAHKepTnpbZGWPorlAfa99b+70Nfe9j7m?=
 =?iso-8859-1?Q?XYVC71DWaXyulVCNaq8PXVzZqoMEqOwQB/ZHpKMcyAOnfGDozFv/1v49I5?=
 =?iso-8859-1?Q?5GpvefhkBD3NIheLLNrL4TOJqtUr6eudx3aTrmpW0jFTBf2WhBvfJBIXhp?=
 =?iso-8859-1?Q?fb5l51FK6RHg9OpXuuX8QF2izQgoeJH527aNMOQUF6Id3gEN0OY/SdyIlN?=
 =?iso-8859-1?Q?+d2aMDGsFKMIDMO9DSuzUrRCklDPowXW4fgkHEsumvg0Laq309AkvmDOq+?=
 =?iso-8859-1?Q?Yf/tOgA6//2MCCg4dZqqsjurKn+xq0nk9Fv8K8a3FBeTOAi/wWKzavYRPG?=
 =?iso-8859-1?Q?rbYE42epLWbTUc5xOTHQ1ucy+O4KxrC/rDTcMaVddK2O9/p4L5giZQeR5R?=
 =?iso-8859-1?Q?wyR31ba1OB46eSi0nRB1WHsYK/MiOd3q+DqGZsk+Ve9IhrjgPR87GQzhf0?=
 =?iso-8859-1?Q?Xu5q3TQyIAbXGO6vJyrIVc8r+fJT+xw2BVZW8vKK2bqesBNyxgGUhe1u56?=
 =?iso-8859-1?Q?yw/BRHgY8Wyk3WgO3gANbS8LgFk+/MjYQ9IDMYR4KXG0mnP/jTZr5g36po?=
 =?iso-8859-1?Q?UYZPv9YENgi/OdB6jsxePCSYRRh0uLwbcv0/iTsw7tjcNQbfu7Q64HwrkZ?=
 =?iso-8859-1?Q?DQFH0yA0ejEmvevfNwhwZRykUUeNZRTjs2ZE6VzeELIpsba57hauQEpqLX?=
 =?iso-8859-1?Q?6d/wqPvudPW3Qsb9WObHmmPaOQRS8sRzMMT2I/8tINWTgFx2LAXjaJ9Ezu?=
 =?iso-8859-1?Q?z1/3ks5LF8uGJEMuBL93z/4jkxCf2yRSUY6K7hoRBjYD8vwwfx3y9dH6Yy?=
 =?iso-8859-1?Q?/iQTGVZKcR7ZdHw88mbVRzq2qr9BNH1Nhwd+ZBot/fu/RkLu3LCeIOwujh?=
 =?iso-8859-1?Q?RPeydYV4HPKBYlxDwqH09qjHxQI3zhGawViauwnp6IrsfAithzOqQt+lmB?=
 =?iso-8859-1?Q?1X7cvSL0jwaY3wndG4FOVipfBgKKZO3m2RI3WVrrkenvSUFCIRuUIsyWwC?=
 =?iso-8859-1?Q?gGyzkEBLshRjDFN136BTRHpF5RmZZTESS73DvBf5a5nqcXqwjjMVy0dLen?=
 =?iso-8859-1?Q?jpgN+BQppwFXYj58K6sp8/HJgWGSITz4DKjD4r1PJ6dMCEKgnIjAH1jSJy?=
 =?iso-8859-1?Q?AIAsHeTd0PsMsP25W8QwMehXtzUprGRbGTQwgEPXtuQEp+eJrgCmnLj7QA?=
 =?iso-8859-1?Q?AuMYDTBuoiqKIgBbnUs1ca2G0wXjsRdpV4egMgmRB704U6iZGSNIwODA71?=
 =?iso-8859-1?Q?AOE3Te+iLRj0wB7smdw/Y1WPS+1qYMlxnfIaSzLJ71yKf9SMOV9xEwOKQx?=
 =?iso-8859-1?Q?AF/O+DCPkWmI3I/WS3g1glXVUeroZxI8pG+5RN2DzJbyEtVYrIuZCk/y3Q?=
 =?iso-8859-1?Q?eu9bsNDWdL6qkf7nOs93NacRYv/l4gA59r71Gpqbw0n6MU7BPzmNDUqvtU?=
 =?iso-8859-1?Q?1i443DUf6WtCXzadQtP/o3moIOp+Myp/IdJ08RF/7Fp2LR6lnmwkNw534w?=
 =?iso-8859-1?Q?IvQ/zdiNBHoYQdGu1RNr4dsxhX3PkrBiP8+WYfZ4LVgI951XdN1JZfcXhB?=
 =?iso-8859-1?Q?iyaCk9Dag8tdmCHdYq8y1HJGn+Iu01zNVC8MPYoVNAuGldC6uMfNod3fRT?=
 =?iso-8859-1?Q?Jrv6lUbCzCb5sZyfw1tgIXUI39PkIjFaAo56s2rg9tH6VzYU3txVgzjiSd?=
 =?iso-8859-1?Q?JIHwg/xYQB4YI0oqk3q777VClmBL0fg90tJ6kb8gCYU/7FjCfEHpu44rmX?=
 =?iso-8859-1?Q?Kd8E4W7ic9Uj8gHMDnZ7oLdWcha1jKpr9ihsc/FtbCgUaWC4FNq8H6/fSd?=
 =?iso-8859-1?Q?8jBtKRGT/nTLdRhkIgv8sPtVwkd9vNTG9CaghBlS9P0VgQSoqNCc?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fb268f9-30af-4843-e669-08ded01af82e
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 04:58:58.7420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JM8B9FBt72X75kBUFm13WtVY51e2RKyiZ4w4FtFpfC8l/GZ+V64sGLSCdYD21S2eWtY+NLhbXxqOiFQ1eiwO3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYTP286MB3526
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.14 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_REJECT(1.00)[valinux.co.jp:s=selector1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[valinux.co.jp : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11714-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:Frank.Li@kernel.org,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[valinux.co.jp:-];
	MISSING_XM_UA(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 109A26ACA47

On Sat, Jun 20, 2026 at 05:16:37PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] The `dw_edma_device_terminate_all()` function fails to immediately halt the DMA hardware, leading to memory corruption or IOMMU faults when clients subsequently unmap and free DMA memory.

Yes, I agree.

I have fixes in this area in another series, which is under review:

  [PATCH 00/17] dmaengine: dw-edma: Support dynamic LL appends
  https://lore.kernel.org/dmaengine/20260615154111.2174161-1-den@valinux.co.jp/

In particular, patches 03/17, 04/17, and 05/17 add the missing synchronize path,
clean up terminated virt-dma descriptors, and serialize channel state checks.

Those fixes were needed by the dynamic append work, since "dynamic append" would
make the existing termination weakness easier to hit without them. I may still
split them out as a smaller fix series if that makes the dependency easier to
review.

> --
> 
> commit e17b2c11b8213371ac3e2d7a92dfd8d2c53290ea
> Author: Koichiro Den <den@valinux.co.jp>
> 
> dmaengine: dw-edma: Initialize IRQ data before requesting IRQs
> 
> This patch fixes a potential NULL pointer dereference in the dw-edma driver
> by setting the dw back pointer in struct dw_edma_irq before installing
> the IRQ handlers. This ensures the pointer is valid if a shared interrupt
> triggers immediately after request_irq().
> 
> > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > index ca0504eac1fca..c782eaa12021e 100644
> > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > @@ -943,7 +943,6 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
> >  		else
> >  			irq->rd_mask |= BIT(chan->id);
> >  
> > -		irq->dw = dw;
> 
> [Severity: High]
> This is a pre-existing issue, but does dw_edma_device_terminate_all() fail
> to immediately halt the DMA hardware?
> 
> drivers/dma/dw-edma/dw-edma-core.c:dw_edma_device_terminate_all() {
>     ...
> 	} else {
> 		chan->request = EDMA_REQ_STOP;
> 	}
> 
> 	return err;
> }
> 
> The dmaengine_terminate_sync() API mandates that a DMA channel is
> synchronously stopped, or that the driver implements device_synchronize to
> wait for completion.
> 
> However, dw_edma_device_terminate_all() sets chan->request = EDMA_REQ_STOP
> and returns 0 without writing to the hardware to halt the transfer or
> implementing device_synchronize.
> 
> If the DMA engine client assumes the channel is stopped, might it proceed
> to unmap and free the DMA memory while the DMA hardware continues to read
> or write to this unmapped physical memory?
> 
> Could this lead to use-after-free and memory corruption or IOMMU faults?

Yes. More precisely, device_terminate_all() may be asynchronous, but then the
driver must provide device_synchronize() so dmaengine_terminate_sync() can wait
until the channel has actually stopped.

That is what patches 03/17, 04/17, and 05/17 in the other series address.

Best regards,
Koichiro


> 
> [ ... ]
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260620170040.3756043-1-den@valinux.co.jp?part=4

