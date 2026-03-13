Return-Path: <dmaengine+bounces-9419-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJaIH3Kvs2lYZwAAu9opvQ
	(envelope-from <dmaengine+bounces-9419-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 13 Mar 2026 07:32:18 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5BC27E2AB
	for <lists+dmaengine@lfdr.de>; Fri, 13 Mar 2026 07:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 742B530F4389
	for <lists+dmaengine@lfdr.de>; Fri, 13 Mar 2026 06:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C1D3659F1;
	Fri, 13 Mar 2026 06:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mRpRkv49"
X-Original-To: dmaengine@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011041.outbound.protection.outlook.com [52.101.57.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17233537C6;
	Fri, 13 Mar 2026 06:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773383165; cv=fail; b=QaHEV8y1r64U1uB0Ops2dnzmM8FJdNrmwm34T3v64fLCq+4NyPBMvghw2dJZWLcAiDkQ95U6yCCItSgWi/OJTYMQggN1uFe44rVgUBcRvMjtDwItJe7BFO3Uxff48lR2PJZb+fsK/eik/4cPZt5UFoZq9lTMXj8OrfWG/Y61MEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773383165; c=relaxed/simple;
	bh=d4XXpRctBC+GsBwkUvOn8MD0JRnczCM6DkilEmGGyGI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=twhWAFSKcgzgG1T92ZgzTv4OZ52Eqb6CJjKGk93GDmJb+BEjK6TD5eJlhpq8V/rvrTbSjAI5S9k/M6bLoTHWtThfHxr+j437NcIYfKzngZQXWB5z6IwTExoaJFgHnXpFmZGgbRBX6bm/vYWnMHjV0eMSWUTBqjxhBUfJilGUkmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mRpRkv49; arc=fail smtp.client-ip=52.101.57.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b2s3zCwpd9MIbswcfWy3VRNQjBJmfuOff2bAl3uq5BOcsOZ02AlvBfy9OAasy6hlx7bPecVHNSF6QS3gomFAk7EQe2DhGCXjUfbSSMKBdFWRMLFC4zj48/Pz6C4PMOnhTp3zAEcwYIT52rUHVRKoZZqbB/7GcCUwZlsz4TXdlWiuQaY4JAZRBncoCEtkTx+FagPYWAJiD59xlloyjjlJQmVCt+C8Txs7xP26OUz3NLifk9rNRUkEGEFMeenFN04AJSSMAkUaPY1oWbfOdld1kEqYln/7W2XptTAJ51GUpqmizZ5DGGThFjR6RzdZKhbwLxBl6QlTR8EDWwPIUCwVMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0t6pvEs2qT4W7YFHbVVMOIAO+SkKPFgoK7D/nb3oorE=;
 b=ojAcnkQFOCyZWgJjFnqxj+29zm2vz069/uvO+J6PaM2fMFmSz1UsYMXUxOULfaZWSylC4KgRC67BH4W0YtoCYz4pbx35pYyW2rnEHi6fDhMk6sV0tj+uDi8Q7t+QVfo55WRaClUbd2I3FkFgilC4dmYW8UoXHzf8HmSMlKCW+bVWVu/3E1i9/uhJj8kYM/ds8m7uVWUGhUwCbsQ8QeLCa7MPxyLm/hzWRVt24FjzQaHADFxDaxHRTEQi38XIcWRGGO+7ipp2p9/l4caXHQgaCx6gI6O/cM+eFbs8MqPZN+T84vHLBXOxuO4x5YiPuCmtcMseVN0QlLyXlDVKLmNNeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0t6pvEs2qT4W7YFHbVVMOIAO+SkKPFgoK7D/nb3oorE=;
 b=mRpRkv49PDyzsCfFYoVXIbk9RswHTdXPIB5WmqF060Ndq+dj4SNQPsiWE+IDtxVaAW+ilhD0abIBgrNvqHMI61gTgho1z7h+5X3aWHQExthmkew0EMuJ2I+AptCrTFZukNsNiu6yEznmqUiE9qOPSEpxVGBs2vm/j+9I6a6ViUI=
Received: from SJ0P220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::27)
 by DM6PR12MB4220.namprd12.prod.outlook.com (2603:10b6:5:21d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.7; Fri, 13 Mar
 2026 06:26:00 +0000
Received: from SJ1PEPF000023D6.namprd21.prod.outlook.com
 (2603:10b6:a03:41b:cafe::62) by SJ0P220CA0017.outlook.office365.com
 (2603:10b6:a03:41b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.27 via Frontend Transport; Fri,
 13 Mar 2026 06:25:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000023D6.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.1 via Frontend Transport; Fri, 13 Mar 2026 06:25:59 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 13 Mar
 2026 01:25:58 -0500
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 13 Mar 2026 01:25:53 -0500
From: Srinivas Neeli <srinivas.neeli@amd.com>
To: Vinod Koul <vkoul@kernel.org>, <git@amd.com>, <srinivas.neeli@amd.com>
CC: Frank Li <Frank.Li@kernel.org>, Michal Simek <michal.simek@amd.com>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, Suraj Gupta <suraj.gupta2@amd.com>, "Radhey
 Shyam Pandey" <radhey.shyam.pandey@amd.com>, Thomas Gessler
	<thomas.gessler@brueckmann-gmbh.de>, Folker Schwesinger
	<dev@folker-schwesinger.de>, Tomi Valkeinen
	<tomi.valkeinen@ideasonboard.com>, Kees Cook <kees@kernel.org>, Abin Joseph
	<abin.joseph@amd.com>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH V2 4/5] dt-bindings: dma: xlnx,axi-dma: Add "xlnx,include-stscntrl-strm" property
Date: Fri, 13 Mar 2026 11:55:32 +0530
Message-ID: <20260313062533.421249-5-srinivas.neeli@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260313062533.421249-1-srinivas.neeli@amd.com>
References: <20260313062533.421249-1-srinivas.neeli@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D6:EE_|DM6PR12MB4220:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dc47325-7d18-4c30-4b9c-08de80c9648b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	7rzxQ04R9IbLAdNBjAYa6KjjNHdygjXTa3Vgcza3RUwS86YHGnBdVFiehNTTM0+1GAVZrjdXB+1/3Qx26aZ1LRVlfokvbBmCQ+dqFvnKO+1pn9270AHhQxuOYp4o+T2cmtoDxpslI9Kd4b9UkTS3Vpdeu0AyzHwUjnBXltypp4oEDZCYPswhH8psIVPnjNTQXBRPRWqC0AslWv4+FskrANQsw8R2pk3lR7SAhSn28Xv48kZZB48734EwR8QPEMdsOhRh7E50BjXbkCG7YaV8ehxPmHfLdWiVR2QIlx5t5Tlbiwtvlf8YrS9M4Vd+qicgc9zNponkjc0Rxe6EwetZIfEBkRfw/IN9ZSvycnBymUqYf/UJN+5MGbaVduLXAhNzyf60Kdiz3+qLs+1jbJpsn3Bbo8EovUsYw1nnUWIVWcpXl4FE7kI09P5csHHHOS2BlQWxyrSeAH+E/3vyzV68n/MeG5PbqaDk+wxMM2hUVM5mnZY25y/CXODFZFZch9S7DlaUHZKT3Zrp66wuk/2wf88jBLkRPqm4C29quX7/KRmXhYKUkNLUv5IpH4VF1+J0BWarwqIiPK5VOcIrbZmnVSQahfDEQMFfnlWj94ykju5nfKvVodwEHFNAUgH25CPx18uaahREYxeuqqPt6TRYBzxhbQLdedAt/tJ51k+VOLbOZUYrJA6v+gbgmyQOmTrfErdn8mm1JFJymXKzqWlTzcGEBJEjI5NNLMN4A3uhsNH1KESnc45am0LM9Oz76QU/ItTRmiatKKSnuTFdbkLn9w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	D9ba37z32cM6wAKLW+exr+uXI5FvM2MrtOdmR8GEiF33v6ZWo62NLi56sqrSPViU0WyocC1oRRrjAkg7H3FAltGVz+N6ukaAGIB2CMX4/gHXDk0XK8PDJnEVeH0lPhcp1nxEuBaEzxxPv8Kjo09IJguGkLTt7LOfXF2SmC3+KAu6OQc9x9gLRepyMXJU3qf3sei68TkQdyOqSwIMQSitgbU5tlWSuNEKydR3kV5JflileGV8OVo08Gdus/Tnps06S1CvC8+WT2kf5HHL51LLr3DkFRx/2VFJ0n9gBsg7OxWUUa9WldYsrdngOgaWSD24ss8VTnVzVEnc6zMS4QGNtt3z+e1eOy7jMB1B0Re5uZpgADG5CVF9pbKoX3gG/OYMTz34PiA/ksAReGZ4GD7n0yExeqaVzfxiun3hCLOo43kA3gIH7m1J5gcHOe4SaZzJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 06:25:59.5450
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dc47325-7d18-4c30-4b9c-08de80c9648b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4220
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9419-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srinivas.neeli@amd.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:email,amd.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: EA5BC27E2AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add an optional boolean DT property "xlnx,include-stscntrl-strm" to
indicate that the AXI DMA IP is configured with the AXI4-Stream status
and control interface. This enables the use of APP fields in DMA
descriptors for metadata reporting.

This property is distinct from "xlnx,axistream-connected" and serves a
different purpose:

- "xlnx,include-stscntrl-strm": Indicates whether APP fields are present
  in DMA descriptors. When enabled, the driver can access status/control
  metadata through these descriptor fields.

- "xlnx,axistream-connected": Indicates whether a streaming IP (client)
  is connected to the DMA IP.

These two configurations are independent of each other. For example, in
TSN (Time-Sensitive Networking) designs, a streaming client may be
connected to the DMA IP, but the status/control stream interface is not
enabled. In such cases, "xlnx,axistream-connected" would be present while
"xlnx,include-stscntrl-strm" would be absent.

Adding this property allows the driver to correctly determine descriptor
layout and access APP fields only when the hardware supports them.

Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
---
 .../devicetree/bindings/dma/xilinx/xlnx,axi-dma.yaml          | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/xilinx/xlnx,axi-dma.yaml b/Documentation/devicetree/bindings/dma/xilinx/xlnx,axi-dma.yaml
index 340ae9e91cb0..ad8afefe7ee3 100644
--- a/Documentation/devicetree/bindings/dma/xilinx/xlnx,axi-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/xilinx/xlnx,axi-dma.yaml
@@ -105,6 +105,10 @@ properties:
     type: boolean
     description: Tells whether DMA is connected to AXI stream IP.
 
+  xlnx,include-stscntrl-strm:
+    type: boolean
+    description: Tells hardware is configured with AXI4-stream status and control interface.
+
 patternProperties:
   "^dma-channel(-mm2s|-s2mm)?$":
     type: object
-- 
2.43.0


