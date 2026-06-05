Return-Path: <dmaengine+bounces-11195-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Wau9HmNBI2pXmQEAu9opvQ
	(envelope-from <dmaengine+bounces-11195-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 05 Jun 2026 23:36:35 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E15E164B6FC
	for <lists+dmaengine@lfdr.de>; Fri, 05 Jun 2026 23:36:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=zbDqqwKH;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11195-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11195-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54F313093AAF
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jun 2026 21:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA703F6C48;
	Fri,  5 Jun 2026 21:25:22 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011007.outbound.protection.outlook.com [40.93.194.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5A43D3309;
	Fri,  5 Jun 2026 21:25:16 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780694722; cv=fail; b=BlSyj2L9jIy8jJZZsr92azS3cK0yP8nnNQEsRlkhvtDQQ1YnQZH4qLy8mluCaU4OVG9DG303Ab62q7lU+J81PUWBB6NhnBJYVW1bA0vazprbXGUTxfcrsZR6VA94NY9Dc57eRzqvvSauHHQHP8q1Nz7wTEymG9THx1LS9aOyZ3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780694722; c=relaxed/simple;
	bh=1QXa+NHT69qWLPRCj3VCmB2Oj6i8KDWd6+dAXMmaQZ0=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W5pf4kyECu0tZ+MDSW/oMROtj08DAfw1bHpOqQTTN8Iw74aIqFs/ceccoEC3ehIvqluLNC6+wfrN8oiI4wfPCPjeKhtPG0N7uKmdHjYBdZvWib3hUvVvtGXMfFtmxbmXSM4N+n41VO7tfrjFBq6lDvMfPkxe0hDf2AoKCi9oyMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zbDqqwKH; arc=fail smtp.client-ip=40.93.194.7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t6uRbfKsHahZ/5o/1CznTnMbpW5pnoNPyXd2CWy0uQKoqJRimdsZi4bvRBTmvAQtiXRf1O6lMBEiFI/Is3J8t9v58oIJ9nyzwPL25jfCLMU+LJADBk8n/AnGSNfVaEp9sOCfCX9yRf5Vdau6zE2I7HlaSUrT7X0X7lDd7EEn5RjLp5KspJi+DBpKAflIEVrzFexa3GRWtK/0KP1e+rZCWRvGml4Mq+SIoLri/+vg6lIx4HPuazvaFbv7KPWvuU+3lVnXY8eNUKtF7KaYaHQaz/quGB2u//aCrO050A/Lbjmn8ycitfANoXGzemSJzf17kgRACBBSgfgbzO7QophFWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nk6MT6+DUahtqhOi6Ui2slWstzwKz4mTLkN+3E2qS04=;
 b=rGT0Q7z+xLIA0oRIvJDgDoyLO5g2CfFlTF56LZN/L5yWd2XUP1n7QttRdDT/WOGbqZSdx/lRJ4wnAOlpQKpvIf3rEgiam7NEtLrOgxF1q5QBQP4ET7zUgvO4em3I+QRtrya9V0e5taq8nih9vCb2+a5fkhheOFcrhvqjJ9s7fKkCJlRn5c0vgrL4YUNRHSmnbRj0ULtKPLYVLY1kkSDTYbSBVqVO9LS7yDg0PkEXr3neLahFGuPQu7CSMhe6dQ1tArQl/8x4QXFpLORAlPz3Ouqb4vpR/n0zdP50VWVTMWeENBbmpXkHXdN0Ho08mE3Sfpi2ZCZv9Sp8M8YdyS3nTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nk6MT6+DUahtqhOi6Ui2slWstzwKz4mTLkN+3E2qS04=;
 b=zbDqqwKH0L0MgEr4MKibtyC2AGYK5aBV10eLBv84Ox9bF4G/Toixya0GItvb+xihtU+umww9+IhqGDQ0kJuV1HPX5tHXRpYPQ8LDKtkH47JepVYOYdB2FmTjZUl9u+tj76suelNQcLeYfsOSEA0Y55Kph5xJ13ZxHmrrRhFVy5c=
Received: from SJ0PR13CA0178.namprd13.prod.outlook.com (2603:10b6:a03:2c7::33)
 by MN2PR12MB4485.namprd12.prod.outlook.com (2603:10b6:208:269::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Fri, 5 Jun 2026
 21:25:12 +0000
Received: from BY1PEPF0001AE1B.namprd04.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::4a) by SJ0PR13CA0178.outlook.office365.com
 (2603:10b6:a03:2c7::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Fri, 5
 Jun 2026 21:25:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE1B.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 5 Jun 2026 21:25:11 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 5 Jun
 2026 16:25:11 -0500
From: Nathan Lynch <nathan.lynch@amd.com>
To: <sashiko-reviews@lists.linux.dev>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<vkoul@kernel.org>, <Frank.Li@kernel.org>
Subject: Re: [PATCH v2 04/23] dmaengine: sdxi: Feature discovery and initial
 configuration
In-Reply-To: <20260513003352.8EDB2C2BCB0@smtp.kernel.org>
References: <20260511-sdxi-base-v2-4-889cfed17e3f@amd.com>
 <20260513003352.8EDB2C2BCB0@smtp.kernel.org>
Date: Fri, 5 Jun 2026 16:25:10 -0500
Message-ID: <87v7bwd6ix.fsf@amd.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1B:EE_|MN2PR12MB4485:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bdb299a-b07c-43cd-7f98-08dec348ed5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|82310400026|1800799024|18002099003|22082099003|6133799003|4143699003|5023799004|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	Bb9cRql7F566OmMzXU33HYLjTi7Ifl/+fcLRzpQsFvsVnlEGw7F63JlFL4p6tY/zdQaGtSd7kvP4sC7jPQhcxNDyUqFPfw19hSFFSLn2PhsD3/tcyHcAxn6l1jcrXA29UlmayLHmp4o/zM+nZ+BYfWedmNBCPEhrsrdp2pzXH2kXPW9FiDI/2D6DpxXAvq6pzGbLaZAuLhJycIoBl+eUqu7jMXnIsje4lGPUlRfoq+X+9Ww6sY/O3IwPJ0cJULN56VJ17WJde23cN666LN16whSv8bKHlp/UHPgQRIO1/gZdaG6tlFHrfq1IUuf4PiWYx1+S8z3+XRRBkytsTI/TlD+cRt0UvSNsee2eZLxJIUbQmZVFRflz8aEemw9dy2+xTRkzr1CHlKXa0a3QRS70D7sWE0kDuzxQyke304smQ/biruyVm8kIkWNjXgfGagOehGi2OrEbAFJjN1Esg2c9dK0g9l2gaDNMkisBapM1FEpkYAMofteRXYj3veXNSFDtzBVkRQTSTQKLpgjoYpeD6IFnsR8r8NWqJau2FwZdQgsWHth55OeFoY2XGkhWEsIt+o3yTpyzkQYMzwpyWHvZk2nsppLTzy+lk+uIvoauJolc8j6lh30ru7TEYngg9RCb+j8cYFxXKLNbE2m6FbdLXFzM+fsB4G2vNVEvLkeMXc8uMc5Gn0g86ifbY/9f1ZHb/4CQZyVOdr9Wz9z/mmfpa+EDFz/QB1h3kjq0sb3vyfA=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(18002099003)(22082099003)(6133799003)(4143699003)(5023799004)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	svUMtoVqyx+yBWHxMGDbfWBVsm7YjwhyUZGZ8nQnQfjfLq3XUqWFDD1sjXAlcacvQ7bFiHBT5O6qmd56MRPNA9oEMvOToAC8OVA02UUdghNMM0RViRGn08u3mTFu+/IAsI3Rom/UQelFoZmmRNuCaFGcmhlnWkdGPT35ih7AW79WlGPgcmbssvd4ruwqHXz3OGbuSWWGyuhoKUpJ0rwLBkRcCXaAbOstlkgpRLlVQ6yzar9HNwlyUKnNkaUHvolhu4Y3/KcFDqxR+3tn6JDB4aLPgfYoUZq6Qtbofsf2tlYoaz7ljWMPuwWv0ybJADUaoXp9QrP/3Nwj7PAbCRlPdVE1pR4xzzG1nMABSifxNMTEam/ybnXGV7aDHUoLXyV1OTZGlaLM9tPXte0GDd9BdsaVPnxoysrqEHl6o0Zsm8AcLYgx6F60U3mBOWUV2XuC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 21:25:11.9722
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bdb299a-b07c-43cd-7f98-08dec348ed5c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE1B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4485
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:dmaengine@vger.kernel.org,m:linux-pci@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11195-lists,dmaengine=lfdr.de];
	FORGED_SENDER(0.00)[nathan.lynch@amd.com,dmaengine@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nathan.lynch@amd.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:mid,amd.com:dkim,amd.com:from_mime,amd.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E15E164B6FC

sashiko-bot@kernel.org writes:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Hardware state machine mismanagement and TOCTOU race during device initialization.
> - [Low] Use of 64-bit MMIO accessors without proper fallback causes build failures on 32-bit architectures.
> --
>
> commit 20635a3fda61c4d58fcd763198caf0840128ff21
> Author: Nathan Lynch <nathan.lynch@amd.com>
>
> dmaengine: sdxi: Feature discovery and initial configuration
>
> Discover via the capability registers the doorbell region stride, the
> maximum supported context ID, the operation groups implemented, and
> limits on buffer and control structure sizes. The driver has the
> option of writing more conservative limits to the ctl2 register, but
> it uses those supplied by the implementation for now.
>
>> diff --git a/drivers/dma/sdxi/device.c b/drivers/dma/sdxi/device.c
>> index b718ce04afa07..f9a9944ad8929 100644
>> --- a/drivers/dma/sdxi/device.c
>> +++ b/drivers/dma/sdxi/device.c
> [ ... ]
>> @@ -5,14 +5,180 @@
>> +/* Get the device to the GSV_STOP state. */
>> +static int sdxi_dev_stop(struct sdxi_dev *sdxi)
>> +{
>> +	enum sdxi_fn_gsv status = sdxi_dev_gsv(sdxi);
>> +	int ret;
>> +
>> +	dev_dbg(sdxi->dev, "attempting stop, current state: %s\n",
>> +		gsv_str(status));
>> +
>> +	switch (status) {
>> +	case SDXI_GSV_INIT:
>> +	case SDXI_GSV_ACTIVE:
>> +		sdxi_write_fn_gsr(sdxi, SDXI_GSRV_STOP_SF);
>> +		break;
>> +	case SDXI_GSV_STOPG_SF:
>> +		sdxi_write_fn_gsr(sdxi, SDXI_GSRV_STOP_HD);
>> +		break;
>> +	case SDXI_GSV_STOPG_HD:
>> +	case SDXI_GSV_ERROR:
>> +		/*
>> +		 * If hard-stopping, there's nothing to do but wait.
>> +		 * If in error state, the reset is issued below.
>> +		 */
>> +		break;
>> +	default:
>> +		/* Unrecognized state; try a reset. */
>> +		sdxi_write_fn_gsr(sdxi, SDXI_GSRV_RESET);
>> +		break;
>> +	}
>
> If the device is already in the SDXI_GSV_STOP state, does the switch fall
> through to the default case and unintentionally issue a reset?
>
> The subsequent read_poll_timeout() check would then immediately return success
> because the state evaluates as STOP before the background reset actually begins.
> Could this allow the reset to proceed in the background while the driver
> continues with initialization, potentially wiping the configuration?

No, this is ok as written; when the function is in GSV_STOP, it ignores
any value written to fn_gsr except for SDXI_GSRV_ACTIVE.

>> +/*
>> + * See SDXI 1.0 4.1.8 Activation of the SDXI Function by Software.
>> + */
>> +static int sdxi_fn_activate(struct sdxi_dev *sdxi)
>> +{
>> +	u64 version, cap0, cap1, ctl2;
>> +	int err;
>> +
>> +	/*
>> +	 * Clear any existing configuration from MMIO_CTL0 and ensure
>> +	 * the function is in GSV_STOP state.
>> +	 */
>> +	sdxi_write64(sdxi, SDXI_MMIO_CTL0, 0);
>> +	err = sdxi_dev_stop(sdxi);
>
> Does writing 0 to SDXI_MMIO_CTL0 implicitly write SDXI_GSRV_RESET (value 0)
> to the FN_GSR command field?
>
> If so, sdxi_dev_stop() might read a stale device state while the hardware is
> processing the reset, and overwrite the command field with a conflicting command
> like SDXI_GSRV_STOP_SF. Can this lead to a hardware state machine
> conflict?

I don't think there's a state machine conflict (see Figure 4-1: SDXI
Function States and State Transitions in the spec). But we probably
shouldn't change the fn_pasid_vl or fn_err_intr_en fields in the
register unless the function is already in stopped state.

Another reason to be more careful here is that we shouldn't clear
MMIO_CTL0's fn_grp_id field, which is software-assignable for function
grouping, and is read-only for VFs.


>> @@ -30,9 +34,24 @@ struct sdxi_dev {
>> +static inline u64 sdxi_read64(const struct sdxi_dev *sdxi, enum sdxi_reg reg)
>> +{
>> +	return ioread64(sdxi->ctrl_regs + reg);
>> +}
>> +
>> +static inline void sdxi_write64(struct sdxi_dev *sdxi, enum sdxi_reg reg, u64 val)
>> +{
>> +	iowrite64(val, sdxi->ctrl_regs + reg);
>> +}
>
> Can this cause build failures on 32-bit architectures?
>
> The functions use ioread64() and iowrite64(), which typically rely on readq()
> and writeq() that are not defined on 32-bit platforms.
>
> Although linux/io-64-nonatomic-lo-hi.h is included at the top of the file,
> the code does not use the macros actually provided by that header
> (e.g., ioread64_lo_hi()).

I decided to just make the driver depend on 64BIT and use readq/writeq.
We can take up 32-bit build coverage later.

