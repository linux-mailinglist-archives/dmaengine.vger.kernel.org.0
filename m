Return-Path: <dmaengine+bounces-11221-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rX5mHHxbI2p+qwEAu9opvQ
	(envelope-from <dmaengine+bounces-11221-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 01:27:56 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BB564BCE1
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 01:27:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b="hv7x+s/+";
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11221-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11221-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E43A330347DB
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jun 2026 23:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6C03B42FB;
	Fri,  5 Jun 2026 23:26:49 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013040.outbound.protection.outlook.com [40.93.201.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802A73D333B;
	Fri,  5 Jun 2026 23:26:48 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780702009; cv=fail; b=EN/IaWDPqUAOR8W/rO2M+mbGtmk/p6034yJ4dBy7z6soscSyAUe5KRuzcLjaNTcOWuYTQjQK0I7kEfme/JJ8MHXz4S79rfFucKeUkdMa/LQ3jdI/zy+MyOV7UTnhp14eZb3rht4ba6gu57U/w/pmLGtgfdYYRVdZ0aea8NcrBFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780702009; c=relaxed/simple;
	bh=L41a86jmyLp6lO7jhykgClXroux/cGkqLO/dMTFRjoI=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UO5e86+L3YdPqccJbZGtxkwUeTpEpx+nlFFLVJeSRGDXDIxedCATdf90QVg5GVEjqx4BwX9d7vk/HRYriH4rU3dsBYHyTbEojXJKYHzrFkgpn23CpR6uVDduu9ZlIocecjWRKrxk2SPripmNLzSkv0EKVqu4xisEVjFA18EbTM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hv7x+s/+; arc=fail smtp.client-ip=40.93.201.40
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fcm7PXON8ynnwSlPigwCsWTs8QLUPJNKbgc1/ERuPx1kSSsqLqfFflEp2EWcxEo5olJy9ddN+QM3XBgzcWhX34jPXKL9Njncw4apGeYQjWnWYjOYZLLLyS+T+A0s/i6f3sbZwry5c6geJ3nsArPqYy51w88JgErE/t7k1hTHXNfIbs+TPQjkua+qiEteRu7l4D23Ng1OaKrC8AMCFSszRL4H+8F9HUQhOalNwJHTlf10EIXJ6Gy/mzomMPQ8OZdVCTiRvG1LuFvbC7Pt1MzyMvV4GbE7ZyrhawW2hy1m1/bQMjiA3+PEMK6Q12N5DAWf1ew7ZrcyTjJvM1hSjjwK5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ymCQEqQpsXU+m7DMNHrYlVlphOPHa1sLKZjhD0FeCt4=;
 b=R59Ftl7ocauxXQSgYY0vIgp4EXC8Xf6q27HG6qw0l2Edzeh6o4lQFjuzi+Z+DsAO7lgEral68urHIcz1rOFxUkIdg1ZTlJx/bn1EZ/QVIuDrzH5dOlBKDRFRTvAorXaFL6B07mj7mAbyR/zjjBEbYvYJ+PdnGFLYaAxORV3PVpqfGlPLLzeil0nwIsb44RP6zIQbMAXXQPdbhD3g1oYFOGEjOXvutT7D+0RZ4/vT5KH+ME9qySJlCrplpMRcDsLDIOMZT3t5vO+XVXEaCQgCuoDxN2jeUSKWHHsnPMgaRwf8OxGe8RVGQKbG3VC3n8AeZGqzJcRBc8/eOyzs/5XxjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ymCQEqQpsXU+m7DMNHrYlVlphOPHa1sLKZjhD0FeCt4=;
 b=hv7x+s/+i7khvEPG40fN+qoaPpUR6cOnNKVK+Vey3MRrrF3h6mqItHB9S1HqJJV3nGlonIgB+ooEguSz2+7j5YsxUa2D9oxtFxOkVUU2ZJkOonzmU6z3B09X8MCQtp5knrBhEwgnFn32mBuEE8mVj6H/vaZRn6MidwpGB5Q2/bE=
Received: from CY5PR15CA0146.namprd15.prod.outlook.com (2603:10b6:930:67::15)
 by LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 23:26:45 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:930:67:cafe::ad) by CY5PR15CA0146.outlook.office365.com
 (2603:10b6:930:67::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.9 via Frontend Transport; Fri, 5
 Jun 2026 23:26:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 5 Jun 2026 23:26:44 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 5 Jun
 2026 18:26:43 -0500
From: Nathan Lynch <nathan.lynch@amd.com>
To: <sashiko-reviews@lists.linux.dev>
CC: <vkoul@kernel.org>, <Frank.Li@kernel.org>, <linux-pci@vger.kernel.org>,
	<dmaengine@vger.kernel.org>
Subject: Re: [PATCH v2 08/23] dmaengine: sdxi: Install administrative context
In-Reply-To: <20260513031712.0C8EDC2BCB0@smtp.kernel.org>
References: <20260511-sdxi-base-v2-8-889cfed17e3f@amd.com>
 <20260513031712.0C8EDC2BCB0@smtp.kernel.org>
Date: Fri, 5 Jun 2026 18:26:42 -0500
Message-ID: <87pl24d0wd.fsf@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|LV5PR12MB9779:EE_
X-MS-Office365-Filtering-Correlation-Id: e8894267-39a3-4739-3575-08dec359e7d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|82310400026|1800799024|4143699003|56012099006|11063799006|5023799004|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	6Gi5YIWoAPbG5c0xoEfvX/+Ud4cQhhobnWRyIQJbq2HxFMczkOaGXgvQs1KzAjDk+3F3tbMKHdahkuYqYgBxlqPzqVuBoUXKX0EqgvRog2jEuz8CLiU+Mqgw8NyKdCN8IoDXh3OYGbqbY9hi88mtuJJMjiZzgxjon8i+ZazbSpNPIPauWMPsRPFSqQJis/Sp4ngnuqfMIwZHv6YThn1RelOQmtXGBIXB9m32YmswYZp4JNbJ6suVlPEWuWb1T0OzeqAVVRKDMIn+FvYAjHelmTic3fX6H36/MAzuqrvPDoRR5GiPGzkVTcAa4flxNHuLpAsZfsNudh5xU9f7dRD42NT2BCtsFbycbLolnDpD5+bmVyA7IOAHmeRx7RKNlv6LKz20sNEbI1WYjNTEgOgHDHZQOXUKQtIYHbDhP60K7+zNH/l8BGbgpUR+QOx5GxfeHwu4PkLXS2ZE4RlbTbdY2azlSTxmQm1SasmKam1XXI+phgiVx7jMLs5P/MBho8aFUrqltHIv93Eaf7jdw4If4zLqsN3jWIWkMH3aQRajPV3kQdyuVFlarpjAKMZPNF2zOPtupNdPOuq/3hl97Ua6yH730zmzMMFm5bm4ywYzfMF+rh+g8Lcm4o8h/9+2Bns+Wg2S3Ipl6sU8BVJLu2SitsVr27PVgfFczpN01tv3KW7ATvxRWKKWIuyEk60DmK0VW0K1KBQBuSYswdeqrC0x9f7C+9/xHVVJKnbFiju5wWY=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(4143699003)(56012099006)(11063799006)(5023799004)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+9lwD7cfL4fthK6ns+gmBBAlUObsALR4jO/bqISRzfYRMr5PS2SIFLzj4iizM6aeEiIAjg7WD3jaEaNToW9OLiQx+GDhameu5hOMyiJ/X8uoGWVMC6d8f4OFC/FIdImTOcMbAJJN86hOwbT7e7lEqY3wJqCd4GYMHV34od6OSP7KAtWL1miKGQJZCDxcVVZezalaJ4b2VEKfjBVO0EaHKCEeK9PGDAwQo4Qe8T2ily+8Q5eqLZruNHlIMIlKxLdG0/lvBKRoE0oJvUtvHjkXVUPuMzDzMKP3Oa1PKWK7TY+Uq7wthIBwsERa6RwXqvI2BWxwJgAvMmj/VJ+urxW6osI+cVoMg1fqr5arVJaxYBwGHg0u8KUlcC1qFfB8KhovALqyXik8hFHppU8+nRttcs8KEP4atLKYvHBF2cH1qZIl8uV9CH4y7B91eflSjlIz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 23:26:44.1957
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8894267-39a3-4739-3575-08dec359e7d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9779
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11221-lists,dmaengine=lfdr.de];
	FORGED_SENDER(0.00)[nathan.lynch@amd.com,dmaengine@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:linux-pci@vger.kernel.org,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nathan.lynch@amd.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:mid,amd.com:dkim,amd.com:from_mime,amd.com:email,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 01BB564BCE1

sashiko-bot@kernel.org writes:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [Critical] Hardware Use-After-Free due to missing admin context teardown
> - [High] Torn writes on 32-bit platforms exposing incomplete addresses to hardware
> - [Medium] Incorrect error check for `dma_pool_zalloc()` using the DMA handle instead of the virtual pointer
> --
>
> commit 794d6cb84f7ad6a7699311744a5e9c87b9d20316
> Author: Nathan Lynch <nathan.lynch@amd.com>
>
> dmaengine: sdxi: Install administrative context
>
> This commit serializes the context control block, akey table, and L1 entry for
> the admin context. It makes the descriptor ring, write index, and context
> status block visible to the SDXI implementation once activated.
>
>> diff --git a/drivers/dma/sdxi/context.c b/drivers/dma/sdxi/context.c
>> index 27821cfaf0311..c0b55c945cc4e 100644
>> --- a/drivers/dma/sdxi/context.c
>> +++ b/drivers/dma/sdxi/context.c
>
> [ ... ]
>
>> @@ -106,6 +112,152 @@ static struct sdxi_cxt *sdxi_alloc_cxt(struct sdxi_dev *sdxi)
>
> [ ... ]
>
>> +static int configure_cxt_ctl(struct sdxi_cxt_ctl *ctl, const struct sdxi_cxt_ctl_cfg *cfg)
>> +{
>> +	u64 ds_ring_ptr, cxt_sts_ptr, write_index_ptr;
>
> [ ... ]
>
>> +	ds_ring_ptr = FIELD_PREP(SDXI_CXT_CTL_VL, 1) |
>> +		      FIELD_PREP(SDXI_CXT_CTL_QOS, cfg->qos) |
>> +		      FIELD_PREP(SDXI_CXT_CTL_SE, cfg->se) |
>> +		      FIELD_PREP(SDXI_CXT_CTL_CSA, cfg->csa) |
>> +		      FIELD_PREP(SDXI_CXT_CTL_DS_RING_PTR,
>> +				 cfg->ds_ring_ptr >> DESC_RING_BASE_PTR_SHIFT);
>> +	/* Ensure other fields are visible before hw sees vl=1. */
>> +	dma_wmb();
>> +	WRITE_ONCE(ctl->ds_ring_ptr, cpu_to_le64(ds_ring_ptr));
>
> Can this introduce a regression with torn writes on 32-bit platforms?

As mentioned elsewhere the driver will just depend on CONFIG_64BIT for
now.


>> +static void free_admin_cxt(void *ptr)
>> +{
>> +	struct sdxi_dev *sdxi = ptr;
>> +
>> +	sdxi_free_cxt(sdxi->admin_cxt);
>> +}
>
> Does this sequence cause a use-after-free regression?
>
> In sdxi_publish_cxt(), the admin context is published to the hardware by
> setting the valid bit (VL=1) in the L1_table.
>
> When the context is torn down via the devres cleanup action free_admin_cxt(),
> it directly invokes sdxi_free_cxt(), which frees the DMA memory for the
> context control block, descriptor ring, and akey table.
>
> However, the VL bit in the hardware's L1 table entry is never cleared. Could
> this leave the hardware actively fetching from freed physical
> addresses?

No I don't think so, the code as written ensures the device is in
stopped state when we get to the point of freeing the admin context
control structures.


> Additionally, looking at the sdxi_alloc_cxt() implementation, the return value
> of dma_pool_zalloc() is checked via the DMA address instead of the virtual
> pointer:
>
> 	cxt->cxt_ctl = dma_pool_zalloc(sdxi->cxt_ctl_pool, GFP_KERNEL,
> 				       &cxt->cxt_ctl_dma);
> 	if (!cxt->cxt_ctl_dma)
> 		return NULL;
>
> Since physical address 0 is a valid DMA address on many architectures and IOMMU
> configurations, could this regression incorrectly abort initialization if a
> successful allocation returns DMA address 0? Should this code check the
> returned virtual pointer (!cxt->cxt_ctl) instead?

Valid bug but I think this is a redundant report, the bot pointed it out
elsewhere in the thread.

