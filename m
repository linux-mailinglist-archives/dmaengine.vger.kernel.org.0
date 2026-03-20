Return-Path: <dmaengine+bounces-9556-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uK/SEOAavWnG6QIAu9opvQ
	(envelope-from <dmaengine+bounces-9556-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 20 Mar 2026 11:01:04 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B20E2D868A
	for <lists+dmaengine@lfdr.de>; Fri, 20 Mar 2026 11:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9420F30238DC
	for <lists+dmaengine@lfdr.de>; Fri, 20 Mar 2026 09:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0969238B140;
	Fri, 20 Mar 2026 09:59:06 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022126.outbound.protection.outlook.com [52.101.126.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE8138B12D;
	Fri, 20 Mar 2026 09:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774000745; cv=fail; b=acIcWK+QjJ6/PmQHodLVal6LHowxxquRKYu4/R9VdrlJx1Vn1E2wvq5TyPKgif7m4NVpdAM++yYZUb8q4SfYFWcSYJwLz2kerw/VBizSvNi1CJPYP20oocS5KYlk+pxGmh15YeePGlW/EAv165l5TD8RmtsOyiPQfc5ym8pv5y4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774000745; c=relaxed/simple;
	bh=uUbOo5KtAg+8DK9Ca1uoORAPs91QSjzCMGjKJaAqp1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qiqYba6XLCfVHtMM3VLlcHZg/DrFJBYxIIuB2B64xMbtm+3gwcmBIVZuKGQY9tnnbwQA5vscuIbB3DKFxSCOrkFn/7N7c1LpEENE3kEYVthhtKaleSCIPwy4dQoh736wxLMBXlV259k0OGTCHSmGqwUcAVXafy2eLs/fzqoEXGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.126.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k7lFuMFykPjRf5jUe1GvkDrpaDziCRDqfbs0ajm5pdvmxhdBq97rZupFe2/nrYwquuOfEpfTGCNPNbjv+/mZgwgK688ZYgXYY29CtZNZk2cXZhkJGHQVrar7xyGq4GoDPkXjBENL9CENNQ3a53ZQq0YIOxrgAYViCdGLz3vHvK/6iWtKsyGEE/jbHgJ7eWNIdpd/7gx9IC6b/EGq2qvH+UzFGyLZ//wzKUp2TWzHsOAtf3VgQTgw4Wp+Kc/EjoyKL6ne8/686ej3d4pc3BddFqyIKX4C+JeaMQvhFG4J7rG7GwpGWkA5YZ0O0810+Ig0HlQMLC5TVu8B8Oub6Jhrtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8GZbaPzqXlxKLuDM+TfBjyOaeC/Soh7/jpxS1F9Ls3o=;
 b=kytiDITFhR1K6bxoz0Dfz3ZpbzUph4CzqF4h8ZElANNOvZ02IWb6lMInGQDMIU1AZ6xjfRLhMHYhYlfFeGqqHAQx5+8ogplY/A+1UNFRXfiBb1wGB1MtHzow7++yVY9bRFPsR5xJ0yNyHYNQ4zDRk+1FHHYYiOt/tmuL+dCaAH2O15/xvX4W8h+cROBCA7TqAPmhXsZxvKzrLEzuS9IX/2pBTlrS6X+iNMWUU+Uy7lklUJAi7fqKG786L8pnTKdOByM4kJC+uB7wPEFjvt2uBvKFOQAtHLihztZkNt5LIffSoHQMpPnMsnEz9u8Yk94AoO+FwKgez5XiN2BCLrvpWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from PS2PR01CA0005.apcprd01.prod.exchangelabs.com
 (2603:1096:300:2d::17) by TY0PR06MB5609.apcprd06.prod.outlook.com
 (2603:1096:400:31e::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.23; Fri, 20 Mar
 2026 09:59:00 +0000
Received: from TY2PEPF0000AB84.apcprd03.prod.outlook.com
 (2603:1096:300:2d:cafe::53) by PS2PR01CA0005.outlook.office365.com
 (2603:1096:300:2d::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.23 via Frontend Transport; Fri,
 20 Mar 2026 09:59:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB84.mail.protection.outlook.com (10.167.253.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Fri, 20 Mar 2026 09:58:59 +0000
Received: from nchen-desktop (unknown [172.16.64.25])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id DC4FC4126F92;
	Fri, 20 Mar 2026 17:58:58 +0800 (CST)
Date: Fri, 20 Mar 2026 17:58:57 +0800
From: Peter Chen <peter.chen@cixtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jun Guo <jun.guo@cixtech.com>, fugang.duan@cixtech.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, vkoul@kernel.org,
	ychuang3@nuvoton.com, schung@nuvoton.com, robin.murphy@arm.com,
	Frank.Li@kernel.org, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	cix-kernel-upstream@cixtech.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/3] dt-bindings: dma: arm-dma350: document generic
 and combined IRQ topologies
Message-ID: <ab0aYUK1NlUV3riG@nchen-desktop>
References: <20260319101723.246539-1-jun.guo@cixtech.com>
 <20260319101723.246539-2-jun.guo@cixtech.com>
 <20260320-vengeful-violet-cockle-382580@quoll>
 <ab0VoTut0u4f7EVr@nchen-desktop>
 <41254f6c-3ce3-4566-acf4-f0bf764565f3@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <41254f6c-3ce3-4566-acf4-f0bf764565f3@kernel.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB84:EE_|TY0PR06MB5609:EE_
X-MS-Office365-Filtering-Correlation-Id: 521018a9-86ed-4f16-35c3-08de86674f0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|7416014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	0J2RDivcqm7xKMmYd3XScnLfMkAOs4emr3OoHAYHQ6Z+F8QMOX+PljmruP8okbqQWtfMXzLjEBzmYpVIlmnNOwAD4vcKWbjVsEW5ydVjLdJO4Qku/9RryCyYuBbDiLPl5kHADunmrAQ8/JjFcOSA88YbsJ1O9wqaLq8nWDJo2cshUVD8XfKymexh+10GrPXx5OndYbZ5vvKSxGoufITYy1XoxpWpOOj1eQbafZeMsHJuYTTJQZQaWgRiwjKN+jywIcuQTgMANZkmbVyxmoqFp3xCXqnxnElBTQnieV4pWtdwWTDZDRO9S1yJnsD5AbdoTdA8POC7UUf9Vb4239RZytUCQ/SzEOMGGSpjLush8N7+/7GBIlcSXE5weaebAS/gbnxxAJqaLz34ZQhVhowknI1HUnJbK30i0wJWYjMFP2JIKsEt0WJZRKGgTNHZWoNO3DQ4nIkwhyCXm9o+jJqZ9+d3MbgUQ59316UFlcu7qk5uA7VLOH2QAHJbwIrHEvUp0nST5xe/X3jb1GPT1LdkhIE+JA/PlprdZSxpIPJpFYQ3PT7nwojBSxtj9wMFXw2MiUFO9lEF46B8rxF3LU38YRBaIIbzQiGIoOEKteYqLQpkeg6GN2WfSiR6j19w1v4PsS+10RgDVFdSX23/ep923A29CqMeq1lZi093LTGpwwnBR1mDHU32uF8rNe7rqrPoNTS4+u79vDwTZK/JVG4/+GD7Nj4vBmXHDImLSRhR/I2Stx3yPEFTKM7uLFhSnGvU414oCyVi0nrQ01HFM0BqVg==
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(7416014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	h8pPphuYHh5klIs0ADkMWTKFH9oKeC0+iHnTDeUux470SOmZul1RSAlisIlS1EKZKj6T/dJAF8Q3N0x2imtoPAg1KZfHBke3MWb3NO3R0QmJXg8ebPM59Xh3ZWdeRjHQrN2ZqGjYCZqOLlIGIkl7c5RLGl7Iw7UgNlzLwX5MEIeE+FAFCJC9nnFlLz+iAOQjMu62Tv0dRnEpiXRbOGVR9rM8pW3imCnqr9KrIGv4+KFThOo8avl0yUJ1IF6T5daNpyTCCSV1RLh7fQlm4XoAUzPex5WX8q+84F9aPyFrQkDkMbVWv0k2HZILnHJ3Rjuu8sXX3fm1iZZgUwVOm9tVmqM3BNqWEgKoBBMBQzak2ym21f/T3dObCepDrtYf+qaoEbcf0zjbejE1bWhhWgSZpL9XwGtLs5D8dOELZE4Fsk6UDY8IOVGZ2AYb1NUIbVf6
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 09:58:59.6943
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 521018a9-86ed-4f16-35c3-08de86674f0a
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB84.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5609
X-Spamd-Result: default: False [2.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9556-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7];
	DMARC_NA(0.00)[cixtech.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peter.chen@cixtech.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	NEURAL_SPAM(0.00)[0.190];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,checkpatch.pl:url]
X-Rspamd-Queue-Id: 9B20E2D868A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 26-03-20 10:43:10, Krzysztof Kozlowski wrote:
> EXTERNAL EMAIL
> 
> On 20/03/2026 10:38, Peter Chen wrote:
> > On 26-03-20 10:12:53, Krzysztof Kozlowski wrote:
> >> EXTERNAL EMAIL
> >>
> >> On Thu, Mar 19, 2026 at 06:17:21PM +0800, Jun Guo wrote:
> >>> Update the DMA-350 DT binding to match the current driver behavior.
> >>>
> >>> Allow both:
> >>> - "arm,dma-350" as the generic compatible, and
> >>> - "cix,sky1-dma-350", "arm,dma-350" for SoC-specific fallback usage.
> >>>
> >>> Also document interrupt topology variants supported by hardware
> >>> integration:
> >>> - one combined interrupt for all channels, or
> >>> - one interrupt per channel (up to 8 channels).
> >>>
> >>> This patch is Assisted-by: Cursor: GPT-5.3 Codex.
> >>
> >> Wrong tag, please read carefully the guideline before using LLM tools.
> >>
> >
> > Hi Krzysztof,
> >
> > It is the trade off for coding-assistants.rst suggestion and
> > passing checkpatch.pl. Currently, checkpatch.pl reports the
> > error for tag without email address. So we choose to add tag
> > description at patch context.
> 
> You still have to use correct tag.

You mean even checkpatch.pl reports below error, we still add it
"Assisted-by: Cursor: GPT-5.3 Codex" as tag?

WARNING: Non-standard signature: Assisted-by:
#14:
Assisted-by: Cursor: GPT-5.3 Codex

ERROR: Unrecognized email address: 'Cursor: GPT-5.3 Codex'
#14:
Assisted-by: Cursor: GPT-5.3 Codex

> You ignored rest of the email
> message, so I assume you agree that you should not send LLM microslop?
> 

I am not the patch author, Jun will reply it.
I come in to discuss this patch duo to I suggested Jun adding LLM tag
at patch context.

-- 

Best regards,
Peter

