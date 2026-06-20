Return-Path: <dmaengine+bounces-11678-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dX/gD1f5Nmr8HAcAu9opvQ
	(envelope-from <dmaengine+bounces-11678-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 22:34:31 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 748456A9B25
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 22:34:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=D1j2GU+n;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11678-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11678-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 161F2301779A
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 20:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42247245012;
	Sat, 20 Jun 2026 20:34:27 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010024.outbound.protection.outlook.com [52.101.61.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED713B7A8;
	Sat, 20 Jun 2026 20:34:25 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781987667; cv=fail; b=gBOspQHZN+IFlzczjaT5sPENOmiX1tMZVl94ApH3xlQkDk39vEmC/v14e5hZyzmgLoYtMAQr9MUqSVHmGCV97NdIBFgRxFEeIJrfIDJsaMg2Q40M4ELh9lL5YPKSdBUhd+4d+brv9HQ9/r37hJDZ4lNaIHBM+PQzihw+uCzo/3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781987667; c=relaxed/simple;
	bh=E+IvEeITYLr4q7zeZGsqEZre2zontyZ2v8RQevvuAYM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dtfGzeFXpK5BnbUGXohYR48qeay++hViJjDgb0S5i9PdLVhXYHTzLnv27humXwWZ8cDv6m7ijExYYSzL7L6UIOGfe6C4QDDSsqMKRD3eWER59GP+rrEUEymSBpTOOMfukV5iVYk2WC68lO9Vv+GkZtE2uV4VelX3AQNPa569hMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=D1j2GU+n; arc=fail smtp.client-ip=52.101.61.24
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LoNSVw39mRRWyEL+4Tod8HXepeiAdJ74LE9MsJxMIZR+c+YXoctLIVXblEMrD+q3m6P7TZVbjHmmlfn+GK6d6dLTs/9KXJkd7jJ33Ul2Q5n7k7sthkrn/ylEf8729cICtVuf3bDA8vKMUlAvnB+VF2z1vAnNgOFrIvvKm8pqLKtQGRH1cGGg4Lm6OEAUy+mNj8SRc1qzztmfcz6gGka6PnCxW4l6g/awcRUwHAYPWwjywyEWvEdKO+SZMwgpIRFMX1ye1ixL9oq8/J3sfW0I6l6BGVGQagdwuVXn5/o8PNJGoxwpoy3OCI1izD0kEWYswrPFahqT24G4HwV86r4B8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gYheX4moOhTQnQaollOkYdZ+dexVEJz0LGsTVIaj3dg=;
 b=iTp8mISYnZz8uU3/DkDepBpAFNbLunVoK6WPLRo8JigZtEQQjGnw0ZPD0ttC0euVNfpikzQJc3mq5aI0YmiSA44oyDx1x46LXAtaMN53LHh1qgmrPRq/sCFYbNtr68LiiV4pgjmI2jX0pjOWRXvK9129oqOBF3V0ft9567110nvM1LW6IcZTU/NOXiaz8BRNdPkqUAY2iu3tqQPXRl/p9/Y2weCZ38I78X8rR1wU8Y/vRoiyVK3i31wH3tJS6RHiHUeQoJ+kMW9kpVv2MvBENHTajqkvBDIQY2BHvPAIqgpL/BdMBEdaBTAtVDhU9KlVAELeWrdIvLIcp+zG0dy4Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gYheX4moOhTQnQaollOkYdZ+dexVEJz0LGsTVIaj3dg=;
 b=D1j2GU+nXywyDKCLYl/KJ6I/agYbOpzeF7+xWzhMhY3U0YShCES2pk/L+Fl8tePbGqZnc4lsyUDoEYvf05EospiWjumHXeATAVNDy3y8GwRMoOlyyKma4kVWqxKTMQOcLqVyM3NsMRIaxUqyBy3X6qvR15JhGc5a9DAAQt6IuYQ=
Received: from CH2PR04CA0025.namprd04.prod.outlook.com (2603:10b6:610:52::35)
 by DM4PR12MB6254.namprd12.prod.outlook.com (2603:10b6:8:a5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Sat, 20 Jun
 2026 20:34:20 +0000
Received: from CH3PEPF00000013.namprd21.prod.outlook.com
 (2603:10b6:610:52:cafe::7b) by CH2PR04CA0025.outlook.office365.com
 (2603:10b6:610:52::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.18 via Frontend Transport; Sat,
 20 Jun 2026 20:34:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000013.mail.protection.outlook.com (10.167.244.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.0 via Frontend Transport; Sat, 20 Jun 2026 20:34:20 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sat, 20 Jun
 2026 15:34:20 -0500
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Sat, 20 Jun 2026 15:34:17 -0500
From: Suraj Gupta <suraj.gupta2@amd.com>
To: <vkoul@kernel.org>, <Frank.Li@kernel.org>, <michal.simek@amd.com>,
	<linux-kernel@vger.kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<srinivas.neeli@amd.com>, <dev@folker-schwesinger.de>
Subject: [PATCH RESEND 0/3] dmaengine: xilinx_dma: Fixes and optimizations for AXIDMA and MCDMA channel management
Date: Sun, 21 Jun 2026 02:04:13 +0530
Message-ID: <20260620203417.4000360-1-suraj.gupta2@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000013:EE_|DM4PR12MB6254:EE_
X-MS-Office365-Filtering-Correlation-Id: 3531ae58-d103-493b-2146-08decf0b4ec5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|3023799007|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	YpDAE90PWAalLanh1usa4XKzRE+ud+4jQCrOnYrncCdc0vJ1lP66U0347H6KlVA2AP8UjK9A1tGOLqLqvdQx6YrMGFnwK4AQAcULtYDU9/Cf5LPkpS7nlkOd/y2+TYwrBwLvHFvILX7v3rdNLBgqyfMtwWtgzzucNvO952Uxfb5RKjZhdCvlGNBo5pJyda6lYLa27L/BjtEFFkqDxNK805928xX6dSvcyY50dQPQTYCwY4QLKL0P9z0JR8XmpL5gsWV4qAfIUhNQnNiJq8iJ4yDoV5O7SmWAqDBPe6iDBfM8IlvtRHfp6GqB4wGMV5RenuUs2IuoIqaGmH14/iXj+OSu2ibzyqtPfGmDGSUA4iYxnKjc1gMNj5XsIj92RX9OEEcqNg3iI0vtfcatoHeZ3C4Zy9W96YL2asnDMUnk1VHBv6TO3/nN88y3o8DBHpAyPuCz02nEmBHHGwAvQ4sWt63zKxJcszwcfNtHR+t/PnLOjiGpVLoOA5QOaHdKQaNhblR12aLUOPH8cFXTjpTO29j3Gd5UCE+xNW+I14ghBUJztNPMP/Sl6UjdDOooRtxNtuG7R7oWzUuGvniZgW2+t9szWWdmybKKKLPoKd1+Ssp8ZbO6anWUGZfGqtFQdJnjtsTapA2b+UA9qBPygKxB19g72sBQxg11Q7OaOAFbPwejdSg/yl8Hxt4a5hluOJfX
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(3023799007)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	p9U2wnc/7L7aJLrZDM49DlJzttsYDYLoyISs6Bs9yBfHEh+HuoEuvPvoQB4ptqQFkyh2w0Fn99ry0FfQy5Vn1Ircr2LjE8LCVJH0eaEUhv335nIE3qlaUWktjHx8pRPgKy7UFpHQkFBhd9bpJdxdUvihm6Ozvn4iwxc+lQBTOXll/I3+LahAi7w8nef+lLkyW3Vu4BZZNPqsSilIURy0gLJW/Y0qFcZ9yVpxo4iXCCbTNWISkL78WiqraMOqByl9Ku9jiOgvoFcwnZOlE+dqB7wKWA976pgMNU0/c4LHR1hRKsNmGBfFAHcP4R2/seP+1m5hlzTFbYZ7HMooG7KS99p8ic7T0HHJna/LU87J9B5lcoRJIiPhK+E8PhfS65iihmK55Q3lxOPBqOjJ2owzqtXZoUvPRTppeGCKBZpDeuzF7YhHTnPTxJR02FcZ3cj3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2026 20:34:20.5988
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3531ae58-d103-493b-2146-08decf0b4ec5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000013.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6254
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11678-lists,dmaengine=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[suraj.gupta2@amd.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:michal.simek@amd.com,m:linux-kernel@vger.kernel.org,m:dmaengine@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:srinivas.neeli@amd.com,m:dev@folker-schwesinger.de,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[suraj.gupta2@amd.com,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amd.com:dkim,amd.com:mid,amd.com:from_mime];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 748456A9B25

This patch series addresses issues and optimizations in the Xilinx
AXI DMA and MCDMA drivers:
1. Fix channel idle state management in the interrupt handlers.
2. Enable transfer chaining by removing unnecessary idle restrictions.
3. Optimize control register writes and channel start logic.


Changes in V2:
- Apply similar fixes and optimizations to MCDMA as well.
- Expand the 1/3 commit description with when the described issue occurs.

Suraj Gupta (3):
  dmaengine: xilinx_dma: Fix channel idle state management in AXIDMA and
    MCDMA interrupt handlers
  dmaengine: xilinx_dma: Enable transfer chaining for AXIDMA and MCDMA
    by removing idle restriction
  dmaengine: xilinx_dma: Optimize control register write and channel
    start logic for AXIDMA and MCDMA in corresponding start_transfer()

 drivers/dma/xilinx/xilinx_dma.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

-- 
2.25.1

