Return-Path: <dmaengine+bounces-8613-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCljFHiRfGkQNwIAu9opvQ
	(envelope-from <dmaengine+bounces-8613-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 12:09:44 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0B7B9D5E
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 12:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B1CF30A6C4A
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 11:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DE5378D80;
	Fri, 30 Jan 2026 11:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uloOlt1B"
X-Original-To: dmaengine@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012027.outbound.protection.outlook.com [40.107.209.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57823793B8;
	Fri, 30 Jan 2026 11:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769771031; cv=fail; b=OvZUdFnAHbeDX9UEwNqKnd/LfLGznjlcatA4zQCw1807zLRLSaheByouHuuPrmgoD2S9sfpiNAfeWeGSYosOqH0pFgLCX9DpATWXbsqbE5MYTGoSu8iTp/fYXM4h2IiAGRtIAh0Ko9A/6hSPjVaVttBfKmyGUSWO91WDWd3W9fA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769771031; c=relaxed/simple;
	bh=3Q9sMgogYqMp7ccaHRLqe5IN+oAj1gpt5lnvms8L2+M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VQb5JhrBhtUjCbhNwGBful4yzctPhuvhznHenk6kAxQfhtMF9wG3HO5TOP4DvrbW6pdpWru6D1iW6hEcgjtZRFx+7NWTiVd6ure1+HZAwNXecfSCVtY8XcZxehKdQIs+0toX8SrurILQmacZIcCVYd2u8bqgkQTFV+pZrWEArJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=uloOlt1B; arc=fail smtp.client-ip=40.107.209.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C3c3L/mmls1Pa2cD9ByCjYeFaKGINHmjxmO05THw0NG8J0i/ipgKly1awy6VGOllM85jLqrfWq3U5MXNglYxb03vZiWBII2Lpg9Nlo0ytHD/k/spP152qBiqAsi4OISTmdCXjFRxjaIYkIe7x1d6LF1ctpsXHRkXbX3Ui+SkCXr21+H69Z1YAfdLMhlWpOvSUanJssLtTfrg6gekPbG12yrYCopWM5Adt3YyO34acnb0gQ257b5nI7jMJowTHMpDtf7JxsqK4fq5BevyIoggTlAnMRDVHS83CQxZ3GiRUPt2dLzQKcM0NM4RzOx4IbqtLHO2OHlE1mFxX8WTzejv+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u7scuP+k3EL/DWvLce/mgyErywI5Jo90lB5SroW8zQw=;
 b=luR8+++VIDfVgsbVIUdqo7KU/uGscWDk+w33GiL/R+C/TDl3SrzTzVkYGS1Vclw1aD2lVnXIqkVf6lxDSLbM0tox5QJ+uQPpKZyCTDxpMNY44X99UZUp+J8aDt6B5qUBZwvFtekJ4Bo8mDBBOqDK+NtUNpXZ6UlpsQDQNYQfsJaRp36JVymC+Bi0OkUF5nlQHGMBJwrZY5My0aN6wuKG6lHU/w3fR3OrDfUUlyHQG+iI6wZl7DJd+ZzvzMAKWJLAAEf+UiSXKu1Y6ul7PaQa3YWfuwNoD+f3GZN/PffAkGIJnlhIcOxRmRV1fVuqg4KwZ1U3Q5UNOu/mTah9JSFZBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u7scuP+k3EL/DWvLce/mgyErywI5Jo90lB5SroW8zQw=;
 b=uloOlt1BavhaqhLI+ykkHjUnFXdxGhrXn+bQMV2GdLF23PZnNDgDdDJG3Y7hXOyuPdGmE0QhzRaeXisvXrefKwxJj0z1019z+yp05YAJ9JLdYeTVofdflq5Ra1m2bt+fbPWj8yJk91YWW1mccROnAgVQJofGCf9RduPQEGYNQ78=
Received: from BYAPR11CA0092.namprd11.prod.outlook.com (2603:10b6:a03:f4::33)
 by CH3PR10MB7414.namprd10.prod.outlook.com (2603:10b6:610:155::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Fri, 30 Jan
 2026 11:03:44 +0000
Received: from SJ5PEPF000001F2.namprd05.prod.outlook.com
 (2603:10b6:a03:f4:cafe::e6) by BYAPR11CA0092.outlook.office365.com
 (2603:10b6:a03:f4::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.10 via Frontend Transport; Fri,
 30 Jan 2026 11:03:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ5PEPF000001F2.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 30 Jan 2026 11:03:42 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 30 Jan
 2026 05:03:31 -0600
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 30 Jan
 2026 05:03:31 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 30 Jan 2026 05:03:31 -0600
Received: from uda0498651.dhcp.ti.com (uda0498651.dhcp.ti.com [172.24.233.239])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60UB2HBt1204392;
	Fri, 30 Jan 2026 05:03:27 -0600
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nm@ti.com>,
	<ssantosh@kernel.org>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>, <s-adivi@ti.com>
CC: <r-sharma3@ti.com>, <gehariprasath@ti.com>
Subject: [PATCH v4 16/19] dmaengine: ti: k3-udma-v2: Add support for PKTDMA V2
Date: Fri, 30 Jan 2026 16:31:56 +0530
Message-ID: <20260130110159.359501-17-s-adivi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260130110159.359501-1-s-adivi@ti.com>
References: <20260130110159.359501-1-s-adivi@ti.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F2:EE_|CH3PR10MB7414:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e1dd2c9-0835-4db3-fb44-08de5fef3ad2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|376014|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KWJFeRGbXKe03TeBv+PiBG89fwflCm17cQVrkOlNbCOta4s+1sqypHDCgDbp?=
 =?us-ascii?Q?NCTXjAaZ+240ckVq/HJfeKy1cbOYnEJgy8WadZj9sDPpnOJz+4neOPu5DKIE?=
 =?us-ascii?Q?a8+0XaNCHCimr2BbPeq8vjMn1FhN70g3HLL9OpoKloCA8z8XEb+PWn3+dPTZ?=
 =?us-ascii?Q?PlIO/xRGx1ZFWgDmdu0RFIuQHfTp4QEfJ7J/pjJ1Y2GzBVDNDFVzti3loa6V?=
 =?us-ascii?Q?lGCMbLfUvGhylchBCq3IZjrJ0BsifT7C9PovJwyV1C31SwkIUz/ZxIS21laj?=
 =?us-ascii?Q?UJSP6IjQLui2aKZNRRpD2oe805DmjwJjpLLeeqvcDiKzPHQx2m2B2IJ7Rr6e?=
 =?us-ascii?Q?YUQFfAQwHBGcvKpA2Bfw90ayzNVdw/2hBPgHKW/JAQwUaPm91qJ8U9JFN2xg?=
 =?us-ascii?Q?GCZyXwHkpxh0E0J0AhKtZOhUUMHf/vAhQ3qiOhFyaC17QXBruRvVAfFQW9X3?=
 =?us-ascii?Q?3ygOSKIsyq3tB2aZSYhk/eHbmrhdu2JrV92Vg9ncv91ZHfiQCS0UZwXSspZP?=
 =?us-ascii?Q?uVOvq4NEgDQ5e/J0f964rWxv4wfiVOqLNxuKPYQKEOsB2l5/KGrEBYwDEt8r?=
 =?us-ascii?Q?Xl6HWWsjgNDsrYIbJ7V980SUUYkaioPBnSWqFY6007psQQAgfTpm1pIFSJzg?=
 =?us-ascii?Q?Q8ckdQCwCP/u2jASESTz/YlP/vWSNWJvgJ3m1+sFx5hOaz3jx8rcrH2I/stc?=
 =?us-ascii?Q?wp8/ZhCLx8h4ufFe3fM1azqAIFPh2dc7+A2i8saF82Q9yeaahr7YBWaGt7k9?=
 =?us-ascii?Q?VjWkZdZbRLOVNbE+ZnMjLACXJKdPbI2IFA7TtDDQs1cXSiVPAWotd57a71cV?=
 =?us-ascii?Q?8BqokcGmlY7JQlxCRQbBEzUZ6n0VukomFDXGraHdvdxFIgpPmVPvQ5/0RyCz?=
 =?us-ascii?Q?1WTcMs8enc0wHrLv+qtgaD9b7rzurKdVO7cq56oYy/qVv1qexjSVXINz2hFK?=
 =?us-ascii?Q?jwDqOet4Rqk4s5uAp9cDgSHRtSMpnNkGF3n750CiLv+HeDVA51/UxaASCc5g?=
 =?us-ascii?Q?+huXHyquE67A/BBQfIZzOr3Bl/7kP0qv8DAk6bE8cLQ7DRV1i8Q3i+24toOt?=
 =?us-ascii?Q?no78l14MlPUd1mo0HjNguiKphCvvMvgRUVnSqgyoO1ICKw8AlglviCZdDFKi?=
 =?us-ascii?Q?ejnWjQjWVb2KoUOalJ96yZUY2jUFbx6vlpyeCHV/crjFWt5bBCwmS4JzpcOg?=
 =?us-ascii?Q?cb+ewSsn7aSML7Ttz+05j1N8AOO66SjPsm53d2qbLemrHo6R3MazBP5vKSgi?=
 =?us-ascii?Q?2mQQ6Uh5vtleeHFkB+LkdV3AYn9hBKPVDFR1laZo2JWgyXcfeFqUCiqhhYEz?=
 =?us-ascii?Q?bBHhVpI1SaoDAljAfkuO5V6jr5Ev+lFZWD/Oc+JpZESHgjb10Ukkd0fOveXK?=
 =?us-ascii?Q?km3iEJiO0xOA4VtrhgESkKJ/FwVcgh4WOdrrwFphxjRwjVjMt10DKdfUa2fW?=
 =?us-ascii?Q?TN90FmQGuiYswMkj1B37c4dTPZNzvrNWtKyfC6kofGAEP67DfM+T5PZbPbWa?=
 =?us-ascii?Q?jyI11MBnT/6zMeEHsDYhEPqv+oIfZR8Nz2h+9pTb91QRC+rBXWnJvJXb1J8O?=
 =?us-ascii?Q?9ytsmrqoNCglUCqzeYAp9bAESeWx1oBnxluDNMr3S9QTfg954XzGexlVKenT?=
 =?us-ascii?Q?tKkoNjqtkydcsEeejWUM+fDu/woXw9CEPH4eHcjvkSOigs2BQMrGGtNXtvLn?=
 =?us-ascii?Q?iATU6fkRKxVjvEsBk048HxOc4+M=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(376014)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DBXsmIbKLT8GWO0LPoB64WXtqSEM7a1Uq/vJkGgoeWNZ+I/8Ini0jQulkVp2vqRQJSD5xzFwcY6xhdBgY1GZ/2KoagdCgBvzXZu3CSpciYMNPwsQkl6pgrkYY0QVEd09ywxlObQYP1egLe7fxDon3G3c5MVNXBiI21si195K+ZcRnbiv/fqfhhZWOcVZImHgYFEKT5JDiZBL4wSKyyRSk6u4PZCsH5LudOur5evShGKJrJ6zf9ccIIijfx8UbFPxplJ53LxKxMDGBcu6ozn5meuo/qfAVoDuLF1N7LYyPv7Kfej+zS6rvUIEUiOeYke7La/N8ih2XzFpy07QeZLJCZ5FMYy/Zd1XLQk0C0lpkaUjXr5VCf2ClWRxgYb2dcZwJ6xbAXNUcg+7LGKENfF8Rg6uFS+zR28xjlHylz5pvh+9sNf5vx0wdGDPle0PQYPs
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 11:03:42.0580
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e1dd2c9-0835-4db3-fb44-08de5fef3ad2
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7414
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8613-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,ti.com,vger.kernel.org,lists.infradead.org];
	DKIM_TRACE(0.00)[ti.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s-adivi@ti.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:email,ti.com:dkim,ti.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,out_irq.np:url];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 9F0B7B9D5E
X-Rspamd-Action: no action

The PKTDMA V2 is different than the existing PKTDMA supported by the
k3-udma driver.

The changes in PKTDMA V2 are:
- Autopair: There is no longer a need for PSIL pair and AUTOPAIR bit
  needs to set in the RT_CTL register.
- Static channel mapping: Each channel is mapped to a single
  peripheral.
- Direct IRQs: There is no INT-A and interrupt lines from DMA are
  directly connected to GIC.
- Remote side configuration handled by DMA. So no need to write to
  PEER registers to START / STOP / PAUSE / TEARDOWN.

Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
---
 drivers/dma/ti/k3-udma-common.c |  29 ++++-
 drivers/dma/ti/k3-udma-v2.c     | 219 ++++++++++++++++++++++++++++++--
 drivers/dma/ti/k3-udma.h        |   3 +
 3 files changed, 232 insertions(+), 19 deletions(-)

diff --git a/drivers/dma/ti/k3-udma-common.c b/drivers/dma/ti/k3-udma-common.c
index ba0fc048234ac..d6459bcc17599 100644
--- a/drivers/dma/ti/k3-udma-common.c
+++ b/drivers/dma/ti/k3-udma-common.c
@@ -2461,12 +2461,21 @@ int pktdma_setup_resources(struct udma_dev *ud)
 
 	ud->tchan_map = devm_kmalloc_array(dev, BITS_TO_LONGS(ud->tchan_cnt),
 					   sizeof(unsigned long), GFP_KERNEL);
+	bitmap_zero(ud->tchan_map, ud->tchan_cnt);
 	ud->tchans = devm_kcalloc(dev, ud->tchan_cnt, sizeof(*ud->tchans),
 				  GFP_KERNEL);
-	ud->rchan_map = devm_kmalloc_array(dev, BITS_TO_LONGS(ud->rchan_cnt),
-					   sizeof(unsigned long), GFP_KERNEL);
-	ud->rchans = devm_kcalloc(dev, ud->rchan_cnt, sizeof(*ud->rchans),
-				  GFP_KERNEL);
+	if (ud->match_data->type == DMA_TYPE_PKTDMA_V2) {
+		ud->rchan_map = ud->tchan_map;
+		ud->rchans = ud->tchans;
+		ud->chan_map = ud->tchan_map;
+		ud->chans = ud->tchans;
+	} else {
+		ud->rchan_map = devm_kmalloc_array(dev, BITS_TO_LONGS(ud->rchan_cnt),
+						   sizeof(unsigned long), GFP_KERNEL);
+		bitmap_zero(ud->rchan_map, ud->rchan_cnt);
+		ud->rchans = devm_kcalloc(dev, ud->rchan_cnt, sizeof(*ud->rchans),
+					  GFP_KERNEL);
+	}
 	ud->rflow_in_use = devm_kcalloc(dev, BITS_TO_LONGS(ud->rflow_cnt),
 					sizeof(unsigned long),
 					GFP_KERNEL);
@@ -2474,6 +2483,8 @@ int pktdma_setup_resources(struct udma_dev *ud)
 				  GFP_KERNEL);
 	ud->tflow_map = devm_kmalloc_array(dev, BITS_TO_LONGS(ud->tflow_cnt),
 					   sizeof(unsigned long), GFP_KERNEL);
+	bitmap_zero(ud->tflow_map, ud->tflow_cnt);
+
 
 	if (!ud->tchan_map || !ud->rchan_map || !ud->tflow_map || !ud->tchans ||
 	    !ud->rchans || !ud->rflows || !ud->rflow_in_use)
@@ -2502,6 +2513,7 @@ int setup_resources(struct udma_dev *ud)
 		ret = bcdma_setup_resources(ud);
 		break;
 	case DMA_TYPE_PKTDMA:
+	case DMA_TYPE_PKTDMA_V2:
 		ret = pktdma_setup_resources(ud);
 		break;
 	default:
@@ -2511,7 +2523,7 @@ int setup_resources(struct udma_dev *ud)
 	if (ret)
 		return ret;
 
-	if (ud->match_data->type == DMA_TYPE_BCDMA_V2) {
+	if (ud->match_data->type >= DMA_TYPE_BCDMA_V2) {
 		ch_count = ud->bchan_cnt + ud->tchan_cnt;
 		if (ud->bchan_cnt)
 			ch_count -= bitmap_weight(ud->bchan_map, ud->bchan_cnt);
@@ -2572,6 +2584,13 @@ int setup_resources(struct udma_dev *ud)
 			 ud->rchan_cnt - bitmap_weight(ud->rchan_map,
 						       ud->rchan_cnt));
 		break;
+	case DMA_TYPE_PKTDMA_V2:
+		dev_info(dev,
+			 "Channels: %d (tchan + rchan: %u)\n",
+			 ch_count,
+			 ud->chan_cnt - bitmap_weight(ud->chan_map,
+						       ud->chan_cnt));
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/dma/ti/k3-udma-v2.c b/drivers/dma/ti/k3-udma-v2.c
index af06d25fd598b..6761a079025ba 100644
--- a/drivers/dma/ti/k3-udma-v2.c
+++ b/drivers/dma/ti/k3-udma-v2.c
@@ -744,6 +744,146 @@ static int bcdma_v2_alloc_chan_resources(struct dma_chan *chan)
 	return ret;
 }
 
+static int pktdma_v2_alloc_chan_resources(struct dma_chan *chan)
+{
+	struct udma_chan *uc = to_udma_chan(chan);
+	struct udma_dev *ud = to_udma_dev(chan->device);
+	u32 irq_ring_idx;
+	__be32 addr[2] = {0, 0};
+	struct of_phandle_args out_irq;
+	int ret;
+
+	/*
+	 * Make sure that the completion is in a known state:
+	 * No teardown, the channel is idle
+	 */
+	reinit_completion(&uc->teardown_completed);
+	complete_all(&uc->teardown_completed);
+	uc->state = UDMA_CHAN_IS_IDLE;
+
+	switch (uc->config.dir) {
+	case DMA_MEM_TO_DEV:
+		/* Slave transfer synchronized - mem to dev (TX) transfer */
+		dev_dbg(uc->ud->dev, "%s: chan%d as MEM-to-DEV\n", __func__,
+			uc->id);
+
+		ret = udma_v2_alloc_tx_resources(uc);
+		if (ret) {
+			uc->config.remote_thread_id = -1;
+			return ret;
+		}
+
+		uc->config.src_thread = ud->psil_base + uc->tchan->id;
+		uc->config.dst_thread = uc->config.remote_thread_id;
+		uc->config.dst_thread |= K3_PSIL_DST_THREAD_ID_OFFSET;
+
+		irq_ring_idx = uc->config.mapped_channel_id;
+		break;
+	case DMA_DEV_TO_MEM:
+		/* Slave transfer synchronized - dev to mem (RX) transfer */
+		dev_dbg(uc->ud->dev, "%s: chan%d as DEV-to-MEM\n", __func__,
+			uc->id);
+
+		ret = udma_v2_alloc_rx_resources(uc);
+		if (ret) {
+			uc->config.remote_thread_id = -1;
+			return ret;
+		}
+
+		uc->config.src_thread = uc->config.remote_thread_id;
+		uc->config.dst_thread = (ud->psil_base + uc->rchan->id) |
+					K3_PSIL_DST_THREAD_ID_OFFSET;
+
+		irq_ring_idx = uc->config.mapped_channel_id;
+		udma_write(uc->rflow->reg_rt, UDMA_RX_FLOWRT_RFA, BIT(28));
+		break;
+	default:
+		/* Can not happen */
+		dev_err(uc->ud->dev, "%s: chan%d invalid direction (%u)\n",
+			__func__, uc->id, uc->config.dir);
+		return -EINVAL;
+	}
+
+	/* check if the channel configuration was successful */
+	if (ret)
+		goto err_res_free;
+
+	if (udma_is_chan_running(uc)) {
+		dev_warn(ud->dev, "chan%d: is running!\n", uc->id);
+		ud->reset_chan(uc, false);
+		if (udma_is_chan_running(uc)) {
+			dev_err(ud->dev, "chan%d: won't stop!\n", uc->id);
+			ret = -EBUSY;
+			goto err_res_free;
+		}
+	}
+
+	uc->dma_dev = dmaengine_get_dma_device(chan);
+	uc->hdesc_pool = dma_pool_create(uc->name, uc->dma_dev,
+					 uc->config.hdesc_size, ud->desc_align,
+					 0);
+	if (!uc->hdesc_pool) {
+		dev_err(ud->ddev.dev,
+			"Descriptor pool allocation failed\n");
+		uc->use_dma_pool = false;
+		ret = -ENOMEM;
+		goto err_res_free;
+	}
+
+	uc->use_dma_pool = true;
+
+	uc->psil_paired = true;
+
+	out_irq.np = dev_of_node(ud->dev);
+	out_irq.args_count = 1;
+	out_irq.args[0] = irq_ring_idx;
+	ret = of_irq_parse_raw(addr, &out_irq);
+	if (ret)
+		return ret;
+
+	uc->irq_num_ring = irq_create_of_mapping(&out_irq);
+
+	ret = devm_request_irq(ud->dev, uc->irq_num_ring, udma_v2_ring_irq_handler,
+			       IRQF_TRIGGER_HIGH, uc->name, uc);
+
+	if (ret) {
+		dev_err(ud->dev, "chan%d: ring irq request failed\n", uc->id);
+		goto err_irq_free;
+	}
+
+	uc->irq_num_udma = 0;
+
+	udma_reset_rings(uc);
+
+	INIT_DELAYED_WORK_ONSTACK(&uc->tx_drain.work,
+				  udma_check_tx_completion);
+
+	if (uc->tchan)
+		dev_dbg(ud->dev,
+			"chan%d: tchan%d, tflow%d, Remote thread: 0x%04x\n",
+			uc->id, uc->tchan->id, uc->tchan->tflow_id,
+			uc->config.remote_thread_id);
+	else if (uc->rchan)
+		dev_dbg(ud->dev,
+			"chan%d: rchan%d, rflow%d, Remote thread: 0x%04x\n",
+			uc->id, uc->rchan->id, uc->rflow->id,
+			uc->config.remote_thread_id);
+	return 0;
+
+err_irq_free:
+	uc->irq_num_ring = 0;
+err_res_free:
+	udma_free_tx_resources(uc);
+	udma_free_rx_resources(uc);
+
+	udma_reset_uchan(uc);
+
+	dma_pool_destroy(uc->hdesc_pool);
+	uc->use_dma_pool = false;
+
+	return ret;
+}
+
 static enum dma_status udma_v2_tx_status(struct dma_chan *chan,
 					 dma_cookie_t cookie,
 					 struct dma_tx_state *txstate)
@@ -838,6 +978,7 @@ static int udma_v2_resume(struct dma_chan *chan)
 }
 
 static struct platform_driver bcdma_v2_driver;
+static struct platform_driver pktdma_v2_driver;
 
 static bool udma_v2_dma_filter_fn(struct dma_chan *chan, void *param)
 {
@@ -847,7 +988,8 @@ static bool udma_v2_dma_filter_fn(struct dma_chan *chan, void *param)
 	struct udma_chan *uc;
 	struct udma_dev *ud;
 
-	if (chan->device->dev->driver != &bcdma_v2_driver.driver)
+	if (chan->device->dev->driver != &bcdma_v2_driver.driver &&
+	    chan->device->dev->driver != &pktdma_v2_driver.driver)
 		return false;
 
 	uc = to_udma_chan(chan);
@@ -890,7 +1032,7 @@ static bool udma_v2_dma_filter_fn(struct dma_chan *chan, void *param)
 	ucc->notdpkt = ep_config->notdpkt;
 	ucc->ep_type = ep_config->ep_type;
 
-	if (ud->match_data->type == DMA_TYPE_BCDMA_V2 &&
+	if (ud->match_data->type >= DMA_TYPE_BCDMA_V2 &&
 	    ep_config->mapped_channel_id >= 0) {
 		ucc->mapped_channel_id = ep_config->mapped_channel_id;
 		ucc->default_flow_id = ep_config->default_flow_id;
@@ -989,11 +1131,33 @@ static struct udma_match_data bcdma_v2_am62l_data = {
 	.rchan_cnt = 128,
 };
 
+static struct udma_match_data pktdma_v2_am62l_data = {
+	.type = DMA_TYPE_PKTDMA_V2,
+	.psil_base = 0x1000,
+	.enable_memcpy_support = false, /* PKTDMA does not support MEM_TO_MEM */
+	.flags = UDMA_FLAGS_J7_CLASS,
+	.statictr_z_mask = GENMASK(23, 0),
+	.burst_size = {
+		TI_SCI_RM_UDMAP_CHAN_BURST_SIZE_64_BYTES, /* Normal Channels */
+		0, /* No H Channels */
+		0, /* No UH Channels */
+	},
+	.tchan_cnt = 97,
+	.rchan_cnt = 97,
+	.chan_cnt = 97,
+	.tflow_cnt = 112,
+	.rflow_cnt = 112,
+};
+
 static const struct of_device_id udma_of_match[] = {
 	{
 		.compatible = "ti,am62l-dmss-bcdma",
 		.data = &bcdma_v2_am62l_data,
 	},
+	{
+		.compatible = "ti,am62l-dmss-pktdma",
+		.data = &pktdma_v2_am62l_data,
+	},
 	{ /* Sentinel */ },
 };
 
@@ -1012,15 +1176,22 @@ static int udma_v2_get_mmrs(struct platform_device *pdev, struct udma_dev *ud)
 	if (IS_ERR(ud->mmrs[V2_MMR_GCFG]))
 		return PTR_ERR(ud->mmrs[V2_MMR_GCFG]);
 
-	ud->bchan_cnt = ud->match_data->bchan_cnt;
-	/* There are no tchan and rchan in BCDMA_V2.
+	/* There are no tchan and rchan in BCDMA_V2 and PKTDMA_V2.
 	 * Duplicate chan as tchan and rchan to keep the common code
-	 * in k3-udma-common.c functional for BCDMA_V2.
+	 * in k3-udma-common.c functional.
 	 */
-	ud->chan_cnt = ud->match_data->chan_cnt;
-	ud->tchan_cnt = ud->match_data->chan_cnt;
-	ud->rchan_cnt = ud->match_data->chan_cnt;
-	ud->rflow_cnt = ud->chan_cnt;
+	if (ud->match_data->type == DMA_TYPE_BCDMA_V2) {
+		ud->bchan_cnt = ud->match_data->bchan_cnt;
+		ud->chan_cnt = ud->match_data->chan_cnt;
+		ud->tchan_cnt = ud->match_data->chan_cnt;
+		ud->rchan_cnt = ud->match_data->chan_cnt;
+		ud->rflow_cnt = ud->chan_cnt;
+	} else if (ud->match_data->type == DMA_TYPE_PKTDMA_V2) {
+		ud->chan_cnt = ud->match_data->chan_cnt;
+		ud->tchan_cnt = ud->match_data->tchan_cnt;
+		ud->rchan_cnt = ud->match_data->rchan_cnt;
+		ud->rflow_cnt = ud->match_data->rflow_cnt;
+	}
 
 	for (i = 1; i < V2_MMR_LAST; i++) {
 		if (i == V2_MMR_BCHANRT && ud->bchan_cnt == 0)
@@ -1075,6 +1246,7 @@ static int udma_v2_probe(struct platform_device *pdev)
 	ud->reset_chan = udma_v2_reset_chan;
 	ud->decrement_byte_counters = udma_v2_decrement_byte_counters;
 	ud->bcdma_setup_sci_resources = NULL;
+	ud->pktdma_setup_sci_resources = NULL;
 
 	ret = udma_v2_get_mmrs(pdev, ud);
 	if (ret)
@@ -1082,7 +1254,14 @@ static int udma_v2_probe(struct platform_device *pdev)
 
 	struct k3_ringacc_init_data ring_init_data = {0};
 
-	ring_init_data.num_rings = ud->bchan_cnt + ud->chan_cnt;
+	if (ud->match_data->type == DMA_TYPE_BCDMA_V2) {
+		ring_init_data.num_rings = ud->bchan_cnt + ud->chan_cnt;
+	} else if (ud->match_data->type == DMA_TYPE_PKTDMA_V2) {
+		ring_init_data.num_rings = ud->rflow_cnt;
+
+		ud->rflow_rt = devm_platform_ioremap_resource_byname(pdev, "ringrt");
+		ring_init_data.base_rt = ud->rflow_rt;
+	}
 
 	ud->ringacc = k3_ringacc_dmarings_init(pdev, &ring_init_data);
 
@@ -1091,8 +1270,10 @@ static int udma_v2_probe(struct platform_device *pdev)
 
 	dma_cap_set(DMA_SLAVE, ud->ddev.cap_mask);
 
-	dma_cap_set(DMA_CYCLIC, ud->ddev.cap_mask);
-	ud->ddev.device_prep_dma_cyclic = udma_prep_dma_cyclic;
+	if (ud->match_data->type != DMA_TYPE_PKTDMA_V2) {
+		dma_cap_set(DMA_CYCLIC, ud->ddev.cap_mask);
+		ud->ddev.device_prep_dma_cyclic = udma_prep_dma_cyclic;
+	}
 
 	ud->ddev.device_config = udma_slave_config;
 	ud->ddev.device_prep_slave_sg = udma_prep_slave_sg;
@@ -1106,8 +1287,18 @@ static int udma_v2_probe(struct platform_device *pdev)
 	ud->ddev.dbg_summary_show = udma_dbg_summary_show;
 #endif
 
-	ud->ddev.device_alloc_chan_resources =
-		bcdma_v2_alloc_chan_resources;
+	switch (ud->match_data->type) {
+	case DMA_TYPE_BCDMA_V2:
+		ud->ddev.device_alloc_chan_resources =
+			bcdma_v2_alloc_chan_resources;
+		break;
+	case DMA_TYPE_PKTDMA_V2:
+		ud->ddev.device_alloc_chan_resources =
+			pktdma_v2_alloc_chan_resources;
+		break;
+	default:
+		return -EINVAL;
+	}
 
 	ud->ddev.device_free_chan_resources = udma_free_chan_resources;
 
diff --git a/drivers/dma/ti/k3-udma.h b/drivers/dma/ti/k3-udma.h
index ca726ea9864ae..b91e645831f64 100644
--- a/drivers/dma/ti/k3-udma.h
+++ b/drivers/dma/ti/k3-udma.h
@@ -23,8 +23,11 @@
 #define UDMA_RX_FLOW_ID_FW_OES_REG	0x80
 #define UDMA_RX_FLOW_ID_FW_STATUS_REG	0x88
 
+#define UDMA_RX_FLOWRT_RFA             0x8
+
 /* BCHANRT/TCHANRT/RCHANRT registers */
 #define UDMA_CHAN_RT_CTL_REG		0x0
+#define UDMA_CHAN_RT_CFG_REG		0x4
 #define UDMA_CHAN_RT_SWTRIG_REG		0x8
 #define UDMA_CHAN_RT_STDATA_REG		0x80
 
-- 
2.34.1


