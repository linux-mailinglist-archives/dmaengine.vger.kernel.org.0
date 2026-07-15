Return-Path: <dmaengine+bounces-12544-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SkWeGVc6V2rrHgEAu9opvQ
	(envelope-from <dmaengine+bounces-12544-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2026 09:44:23 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF9075B8D8
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2026 09:44:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12544-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-12544-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C07DC307EAE3
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2026 07:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2163C3C11;
	Wed, 15 Jul 2026 07:43:09 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022110.outbound.protection.outlook.com [40.107.75.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA94A3C5550;
	Wed, 15 Jul 2026 07:43:05 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784101389; cv=fail; b=Qm9QN4typy3QIiTPgiWvnf1qwy1zGXjGN5Fd1b10d9gXTAe6/av+jOfUG8haYfeVPXVTV3BQ8YgSoV1hEfOrddTFpxj2TxfrZ02EBs6uqE8MVlUtJVv0qoHTmrO5nZC5oZy6et2ityN6pQ/5FR9cYmDdCMTgePGI/9ff4IX9h/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784101389; c=relaxed/simple;
	bh=q3DtGQYqkiey59cQIxu42dejQfZvh322+5KSj1+cmVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W3BCvmEw9zY4aQcM6zlMjTVu3lZZbocr47Ni8CkL3zyLv03t3PWHzsRgOXH3A07hOKxeXE5lRR7+SZXCJzutry6Wau6RRHMCl5JwjGljczhPNu4zES9BE9o4w1c2r7zM2s1J3qXorVw1cp8NVW34x5tTPixyrbzc+eUFPX+gWHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.75.110
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FCm7c4bhCTPWHZ/C4mKDUzU7Pu6i/EQaQsuWgZtglljmSG3q322A8V9Hf9y/XY2fnVUZVy9Y4PHUm7Plc8PlVobCHOQLFOU2E4NmIu8bSeNYeGs1YWY99dFpny3xG+/MOHv7o51lQIBwjhPFtQMrJEEbuoqOfCVohGomRYBlRLFCwKj1oaPV/rRKRdzMBmpQkeHVE3S2dwn8WYERME81XNNQsNi98WmHp6rTd7dBoV8a9WUKmYun94YQTnSL4OTw9zqHEOzFvbrxkhk8Mbcs7a/kmm2GA0rXYgyU8orWNUlebWQgIg+AfCM9MIBg5jhAQqHwkIyjlWmL6xtui72GJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d8zshZZgMrng5PlukhIlocEzscHjzcZmsn8ImjX9AqE=;
 b=XYfaenZ4wzHERQChouqQ1aLlA1NSOGcbet8pCtfiOLzjtUQ4eHJU+iNUVG7WCfb1rqwLjT2qXNH6Rkcs9slN4Qn5ttUvY7JvYVfb9tB2T9QSbDrX36HHnoeTwNGwItzQ9Fu3LoiDE0b+VOU4R7Xp+Vp+Y7xbShAsj6r0NRkaf/C9l9YzrSLSK4olQu5wo3k/GlMmJsYdb3VjfXiyMGVWqlzDLDu+VV6YfPngMPUxC+7UHNoqe+X0Shw0K5G3K6BeZdznTJwxeDmm2N2mqnPLRiLzSonQ4WgPv6bOnk7YLXbPbi++gsbddt41DALOLetEtLxyY3BCDNB0g/xqDrbZUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI2PR02CA0044.apcprd02.prod.outlook.com (2603:1096:4:196::17)
 by KL1PR06MB6395.apcprd06.prod.outlook.com (2603:1096:820:e7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Wed, 15 Jul
 2026 07:43:01 +0000
Received: from SG2PEPF000B66CB.apcprd03.prod.outlook.com
 (2603:1096:4:196:cafe::33) by SI2PR02CA0044.outlook.office365.com
 (2603:1096:4:196::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.11 via Frontend Transport; Wed,
 15 Jul 2026 07:43:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66CB.mail.protection.outlook.com (10.167.240.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 07:43:01 +0000
Received: from [172.20.96.76] (unknown [172.20.96.76])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id B0E9E427CEE6;
	Wed, 15 Jul 2026 15:42:58 +0800 (CST)
Message-ID: <d7f0fa37-50f2-4c71-8004-2b85e45171f4@cixtech.com>
Date: Wed, 15 Jul 2026 15:42:58 +0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/2] dmaengine: arm-dma350: handle shared channel IRQ
 wiring on sky1
To: fugang.duan@cixtech.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, vkoul@kernel.org, ychuang3@nuvoton.com,
 schung@nuvoton.com, robin.murphy@arm.com, Frank.Li@kernel.org
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, cix-kernel-upstream@cixtech.com,
 linux-arm-kernel@lists.infradead.org
References: <20260521072924.3000282-1-jun.guo@cixtech.com>
Content-Language: en-US
From: Jun Guo <jun.guo@cixtech.com>
In-Reply-To: <20260521072924.3000282-1-jun.guo@cixtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CB:EE_|KL1PR06MB6395:EE_
X-MS-Office365-Filtering-Correlation-Id: 8df89c79-7b6b-40bf-6d86-08dee244b26f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|376014|7416014|1800799024|82310400026|3023799007|5023799004|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ARf45caTIGuydVjMiT7LtH377DkhPF+DmfHJZsxT9f7s5xOT5X2pag5th1v2MbA61K+DZJuM7lqqhtBkPKy2oO41qWJ96skoxYdu1hnqphKSnxy+p7vntL38js5ptYM3C/CBpXEbFSyovfb2a6l1+LtBWTFRN5KwvuGs72kdH/+7rqzTpDipDOXXa+zzjR4Jv8yvHjKuCxSsqjlLgAxRgCGiSoshh/US1tjIL5HpcqQo6YI3HoRROl5nqX5i609nBHuCkeMZ/3b4KcBoyUZBZWE0inSbPsD6J+GrBnszh8ebqnDV+DzF2xcxvyiuiDcuLU/SwIho0IQqA61cb9E0/cAbbztMzfdAE+KuPjSntjxLnr3UtzwOFCzVqAWXIDkf8xp56e3MKUzZXOJLRs+Y4u1UTW4sTMN+fY5iLqkYbTbGJzx4boQQUoKYMV96jmEGj9GGW7ztAB0KPkO/mI6VQBGv1Umq5r/MXK0Ec43EQcBQgcioJH06ARqExERM3nEM/d2BW99m2A+GN17EyH3KWLxV9enpp657y50nnwU4Y5a94Bww0gO0VEsr463ivZtnHlyWO8p2E5XaQijzPCXGrMfS7ePeUJNzCwoXthFBX0RJKo7lSpkYiegv5L+0XhGfxDE/liFz06vDQgsccpZE47n92serSiCgmA94Nape7D6MK3TmNjG5KKw82/YHIK2yBNfk2xOnjl4suaW6WeBT5A==
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(376014)(7416014)(1800799024)(82310400026)(3023799007)(5023799004)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TkpIvUY6LcaYe3q5X28T3b2QdX7zdtt9CCbOs1bPp18vYvuwKJVMtwpZMjccFaHpbsWc+F3Ce0wvbY3+vrGzlAQMrFfjyA9lbYx82bq4UY7ya5zFpJeePpBHMAF+PzMV3/iHzSJ9c/ECYSua19zVa4gJzx5f1QBnXxRqZL6u+RbJz2LqPDp/gNNGMSjJUE47WUBNru4cSF7yYAjHvgprmH/pMxYS1WESpPmq5LyazWYRU7hZQTLek3Pdq9mw/UIodhAor/zNgcZfLsF2YgSQga+TxyHinOSqTkFvHLYJgtYB8fekFu7G720uTNS7yl/1/ePhiBPII9bKQCrx5cdyKbk/Ko4kaXGkeLB/wn9OR6+fgA4daRUWM7mWCeoWNPTIErud/CaDxG/sGj8s5Up6DJgNMXPOJAKMP4HEqy9eK/vldm9wWQoDLM15upHcUFqI
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 07:43:01.0744
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8df89c79-7b6b-40bf-6d86-08dee244b26f
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CB.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6395
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-12544-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:fugang.duan@cixtech.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:vkoul@kernel.org,m:ychuang3@nuvoton.com,m:schung@nuvoton.com,m:robin.murphy@arm.com,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:cix-kernel-upstream@cixtech.com,m:linux-arm-kernel@lists.infradead.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jun.guo@cixtech.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[cixtech.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jun.guo@cixtech.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CAF9075B8D8

Hi all,

Gentle ping on this patch series.

I understand everyone is busy, but would appreciate any feedback or
review comments when you have a moment.

On 5/21/2026 3:29 PM, Jun Guo wrote:
> This series updates DMA-350 support for the SKY1 integration where all
> DMA
> channel interrupt outputs are wired to the same GIC SPI.
> 
> Patch 1 enables DMANSECCTRL.INTREN_ANYCHINTR in the driver so
> per-channel
> interrupt status is propagated even when channels share one parent IRQ
> line.
> 
> Patch 2 adds the SKY1 DMA-350 DT node and describes the channel
> interrupt
> sources using 8 channel entries, while all entries map to the same SPI.
> 
> Tested on CIX SKY1 with dmatest:
>    % echo 2000 > /sys/module/dmatest/parameters/timeout
>    % echo 1 > /sys/module/dmatest/parameters/iterations
>    % echo "" > /sys/module/dmatest/parameters/channel
>    % echo 1 > /sys/module/dmatest/parameters/run
> 
> Changes in v7:
> - Modify the commit log format for the driver patch.
> 
> Changes in v6:
> - Drop the dt-binding update and keep the existing 8-channel interrupt
>   schema.
> - Simplify driver change to a minimal fix:
>   enable DMANSECCTRL.INTREN_ANYCHINTR.
> - Update SKY1 DT node to describe 8 channel interrupt entries mapped
>   to one SPI.
> 
> Changes in v5:
> - Fix the formatting issue in the AI tag.
> - Remove the unnecessary "cix,sky1-dma-350".
> 
> Changes in v4:
> - Reword binding text to align with kernel style.
> - Revise the AI attribution to the standard format.
> - Remove redundant links from the commit log.
> 
> Changes in v3:
> - Rework binding compatible description to match generic-first model.
> - Keep interrupts schema support for both 1-IRQ and 8-IRQ topologies.
> - Drop SoC match-data dependency for IRQ mode selection.
> - Detect IRQ topology via platform_irq_count() in probe path.
> - Refactor IRQ handling into a shared channel handler.
> - Enable DMANSECCTRL.INTREN_ANYCHINTR only in combined IRQ mode.
> 
> Changes in v2:
> - Update to kernel standards, enhance patch description, and refactor
>   driver to use match data for hardware differentiation instead of
>   compatible strings.
> 
> Jun Guo (2):
>    dmaengine: arm-dma350: enable ANYCH interrupt for shared IRQ wiring
>    arm64: dts: cix: add sky1 DMA-350 node with channel IRQ entries
> 
>   arch/arm64/boot/dts/cix/sky1.dtsi | 14 ++++++++++++++
>   drivers/dma/arm-dma350.c          |  9 +++++++++
>   2 files changed, 23 insertions(+)
> 


