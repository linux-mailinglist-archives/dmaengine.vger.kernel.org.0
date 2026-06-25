Return-Path: <dmaengine+bounces-11793-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6KWID4RTPWqJ1QgAu9opvQ
	(envelope-from <dmaengine+bounces-11793-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jun 2026 18:12:52 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3146C75E8
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jun 2026 18:12:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=XUsReO7q;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11793-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11793-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 860A6300CE5A
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jun 2026 16:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27083DB964;
	Thu, 25 Jun 2026 16:10:41 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012060.outbound.protection.outlook.com [52.101.53.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138AE3B100A;
	Thu, 25 Jun 2026 16:10:39 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782403841; cv=fail; b=CSEufngEWNlUeikdtFSWRyfxOW+RhTwxyovO7v3tg4WlDoKZK248oKgjnBHB55i7KhYGEIfAFhhxv4qy3SewBNC00Reu7DVQT+Trs3rP9t+IRAOmJDT5IiStxsB0gAI7oz+m9KrkPMpKS6Ln2pIYkQYZ1F8eWr16pIFOmcjh2Ts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782403841; c=relaxed/simple;
	bh=7acK/Ch+ai3thJOCbKri4jcmbiqA/CClEBHRnDqIASw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=K+9TfZ50S9sRpSARncy2ZzuBfcpDq1rb6menNSfwRgkv1NbPDNfb1XaA80dB4Jsj7703WlZ83WXgnrV13ZfUbjlv1IX/wR8bobRV7mII3X33BgHKTeKwYhhqgqWMpWxbkIip4o9/ZuAhanKmV94HGGRXORvHhX7Bgo4BRlgKMvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XUsReO7q; arc=fail smtp.client-ip=52.101.53.60
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xq4aYZG0d/yjmwxVEaIPw00zwzLm4FIsEU0Si+wj6nkVtK4CS1NtMaGDS9SRuNGsryS23977aIv5epbDJVVnX1QyR6MmMTtq+hRykCg2H6utyPKhNQMKo1wUtlAimHNbJ+iL0xvymY2u/s6QBbwDooII16rOVPCmfiUm9vaFg2KMPhu1spVVRnDy6tjDh3yrE5G/YCPpsSvMufFDbYBaeRt3A9ylDNqt4yzuyrEvaZqXXpEBcsfWoaWExtpL11s9Mg7PTyol0Im52mFxRMMkN3Su9CilObfooMrZyP41db12HPOpGazwCqo9opzMe1/357IGeFxb3Dqxg/UYp+HXOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AvWrzenWitRXdBn/A6pWW8+BLrHtzKUzNX3DY23N3TA=;
 b=PVuI8q6woKA7CDGVCNdLjAgh/5pApOkWDDb5UKb+k0IWONlXXJVp52fIF/vHWh5N5sk5YdJrKrimEVX/TEzdWnAAplCoFbykd41OEBVy3G5nn2qlRmf/YKtMVNbP1xIdE8cKaom/CzyVKYLBpd9wokMjBac9Rj5EonfZC+d0iL1+XPO8ElgBQC/8VNCB6ICWm8VZYx/aSYwDG39ItrcZrl89jCmcoYJLicr0o49mN3EQXnTqXXs4OMyPuIJudmB1tt1pNwAYoPahr9KC1mKXjAkKs3Y1Cj1bTc+2xxds8t3FcwaEw6FzbuJHVEsZdoIv+C9qE258bbd9nyu950QYsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AvWrzenWitRXdBn/A6pWW8+BLrHtzKUzNX3DY23N3TA=;
 b=XUsReO7q6cnxdrXiLgTFVWKtbpfmpSWPRHpV5aFKsgr/CT6iAl0TSK0Y+FOg68ZBUgJfyzvkt+HV5q8BSwwX9k0TYhsNFhJ4o99turcMpmyxPUEwI6xPStXQua0H/2SGjNGS2ySQ7rdOkCYkT3emwitP4VgdhHPKTFrkDabqtno=
Received: from SJ0PR05CA0073.namprd05.prod.outlook.com (2603:10b6:a03:332::18)
 by SN7PR12MB6689.namprd12.prod.outlook.com (2603:10b6:806:273::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Thu, 25 Jun
 2026 16:10:26 +0000
Received: from BY1PEPF0001AE1A.namprd04.prod.outlook.com
 (2603:10b6:a03:332:cafe::39) by SJ0PR05CA0073.outlook.office365.com
 (2603:10b6:a03:332::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.5 via Frontend Transport; Thu, 25
 Jun 2026 16:10:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BY1PEPF0001AE1A.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 16:10:20 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 25 Jun
 2026 11:10:19 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 25 Jun
 2026 09:10:19 -0700
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 25 Jun 2026 11:10:16 -0500
From: Suraj Gupta <suraj.gupta2@amd.com>
To: <vkoul@kernel.org>, <Frank.Li@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <michal.simek@amd.com>,
	<radhey.shyam.pandey@amd.com>
CC: <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] dt-bindings: dma: xlnx,axi-dma: Restore xlnx,flush-fsync as u32
Date: Thu, 25 Jun 2026 21:40:16 +0530
Message-ID: <20260625161016.1249570-1-suraj.gupta2@amd.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1A:EE_|SN7PR12MB6689:EE_
X-MS-Office365-Filtering-Correlation-Id: 54d21fed-fa47-454f-67c1-08ded2d44132
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|82310400026|23010399003|3023799007|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	t57jEPGVwgU6foGe1ES2kH6z2N+gcq335ImD+AZCzQpbpMdOa6zUS8yb6A1uc+EfCJ9z6DQ1yj+l38s/Mm/U18WBhjnjJnyZp5oQZHcWne7ZhFYggmpEF/uAoBCQw89fMiBIB6MGi8tNyNNtsr0douJLw5vajME8yS/xwlgnrdZHEbeJ3veG8oqMPTWnJ76iLvE94cgJfCKunzktSBpD19/72v/WpeAisrGC5dJtZRAM6WOnMNbFXPAj/HQ9yUhtU0dGEBG5s/xU1RJ9ee991SGign3eHGKz+yS4+PgWaMdx2MsojahTHrdbQ2q93YaX2OB5hMgkBntzTAnS5jRMq8ieCbCJxqYOLSFJ9xM/gjWSJuMd0BUQ1kWoeT6NvPgduUtArsCB39HOKcU39CxKmigajSgXmk4FiFBvr3u5ldGDSTHWXf99VffWr+NdKA6S1mDVUmhUrspPxu852ZfRYDv8YH9vDDdZ9dL1St6CeP/7cUGzSGdcPjqPPM+VivaHtH2WA1IMmo/b9ftkm23EqA+MAXv2AT5zzEWlxRYV+bjmx8V+u2G7/cyzrkRO9JrjOO+mlbsDIZq3yu92Q8zDQGK4p2vurb+fDfGoWjrKww+s+1gVxTf915WicdoRApRdx5TS4IvyebvqgRSuGxaL0H7NHmRE7LNNvOvLNxh3Kk5QwwRcnbh7IIEbG1llJwmGQS+i4INH4fFBrvOS0skpxQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(23010399003)(3023799007)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Gk8KoFgDeJnpXY41aem68Brp9jAXwM3pW5jxIKjVqrgTZRYr3rLIDDvE7HmOrbhPp8h3lQ3BcJKB5kulMjKBGJwfLj9DfQTIEUpvrEvHjZFPpjOsFpI8rDmmJW4FLHTqojmxVMlwdniVU4Ng0vPzZoEDG82JNqqA/NNcT2ckBcCxZKorMs7FDPLT2wXyqskyA0WtWGPL48ix7yGZjlKDKhfuBAWf1/L8KY6JZCuhRGeo/i1/BNFxzAFYDJ2kXbKIWFmuosWIC5/3bE5bpOH6o8+rAM8U5Ck1izND6Qyevs2aHsF3BBgRPaqLILEGmgpdt1cg/kC+QyBsRmk8IrfXtul2LTjViHzyZwUOC3f5XBVHjDYpYMuN/IDIbek4VBAgHl2oA04jGd5JwxOMKNdz+UezJBVBzTzCoUhLRYr0ZBowPGG9S3UZpV/47+ShHe1h
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 16:10:20.1242
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54d21fed-fa47-454f-67c1-08ded2d44132
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE1A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6689
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[suraj.gupta2@amd.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:michal.simek@amd.com,m:radhey.shyam.pandey@amd.com,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11793-lists,dmaengine=lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[suraj.gupta2@amd.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8F3146C75E8

The DT schema conversion incorrectly changed xlnx,flush-fsync from a u32
property to a boolean. The original binding documented values 1, 2, and 3
to select which VDMA channel(s) flush on frame sync.
Restore the uint32 type with the documented enum values and fix the
example accordingly.

Fixes: 2d5c2952b972 ("dt-bindings: dma: xlnx,axi-dma: Convert to DT schema")
Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
---

 Documentation/devicetree/bindings/dma/xilinx/xlnx,axi-dma.yaml | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/xilinx/xlnx,axi-dma.yaml b/Documentation/devicetree/bindings/dma/xilinx/xlnx,axi-dma.yaml
index 340ae9e91cb0..95b951eea1b7 100644
--- a/Documentation/devicetree/bindings/dma/xilinx/xlnx,axi-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/xilinx/xlnx,axi-dma.yaml
@@ -81,8 +81,13 @@ properties:
     description: Should be the number of framebuffers as configured in h/w.
 
   xlnx,flush-fsync:
-    type: boolean
-    description: Tells which channel to Flush on Frame sync.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [1, 2, 3]
+    description:
+      Tells which channel to flush on frame sync.
+      1 - flush both channels
+      2 - flush mm2s channel
+      3 - flush s2mm channel
 
   xlnx,sg-length-width:
     $ref: /schemas/types.yaml#/definitions/uint32
@@ -251,7 +256,7 @@ examples:
                       "m_axi_s2mm_aclk", "m_axis_mm2s_aclk",
                       "s_axis_s2mm_aclk";
         xlnx,num-fstores = <8>;
-        xlnx,flush-fsync;
+        xlnx,flush-fsync = <1>;
         xlnx,addrwidth = <32>;
 
         dma-channel-mm2s {
-- 
2.43.0

