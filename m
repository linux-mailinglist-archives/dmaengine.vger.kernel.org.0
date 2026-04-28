Return-Path: <dmaengine+bounces-10163-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UF3/AjZ28GkMTwEAu9opvQ
	(envelope-from <dmaengine+bounces-10163-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 28 Apr 2026 10:56:22 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B82480B03
	for <lists+dmaengine@lfdr.de>; Tue, 28 Apr 2026 10:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 817A23020C65
	for <lists+dmaengine@lfdr.de>; Tue, 28 Apr 2026 08:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6E13D669F;
	Tue, 28 Apr 2026 08:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vr8wAmsb"
X-Original-To: dmaengine@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011009.outbound.protection.outlook.com [52.101.57.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9863D5672;
	Tue, 28 Apr 2026 08:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777366341; cv=fail; b=JOutgWYFRAwbPokiqvOxTmN+KDG+4T9yGKYsEkbrAXnaAV2EseXe4HcmHZDynELj+zJ2itFLeXl+yc/WImSxxV8/kpoPksijjbnJMDjqNrNqdQf+LWF+D6OdiHj/DfkxWVMfmg+2kpskd3KLV7gqq2i/P4m7sOcBQWL+MZO6Q0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777366341; c=relaxed/simple;
	bh=u/ZflzMnzCz7+K4RdT2ygD/Aji9d/9uDff8/rJXoG9k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nzn79Lo7Ik/F1EYlYMNOglM2FMuoyg6lPE+NMFlSr5IygP4TgN+HNedDds7bs3sDKiJDxFgEy/iQvxboQjE9WVkgcnoVI7KYs7mqgm0bl0DAblL/0mJWZgkPsbm2ndFeGmWTgVt2GDgh6n332u6QwA27SccSxkX5xZN2FU6X55A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=vr8wAmsb; arc=fail smtp.client-ip=52.101.57.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OKiJS5xvvhDSRIrcFtaVCnKsRT3KWKcAjP9uRCYc9PHQTljM/1Pv3gL7I/IC+XLsg1RPwNi23hNJ03wZiTuUgk1BtnCF8zDGHQqsgB3NCkElEsUHAlgb/owTfyzNztkA4eLTzIIkUtFGNYeVrLOynP5+6sMltGl2sBUvFjmH3tV9+2UczSAwLQUMUqZdKSVOHAvIiGtDxsMd8EdCi0SOtUx4uUQMSKyT3fn1SXbzSIyI4tcAxFN6JSQLT8SHBL/o7cJ2vSusQDOGV4XMx+3KkWXYZgZ34fupFOQyHtR4rIF+rmavZXBOcP+nKYXSxctzzQkNNJCPCssqffYBvcGzAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H536rpQu8oZvmBs5VIoxdxL7QuEmK3YQ/quKpyx4kcg=;
 b=p0ITyA8HCaY7tRwYkVk0Vst9JNZlAQ2BxT3GWNsbYcEmIhjMCt4Mo5pe19mbTctSQugBwvjjElZ0LaccP/1ZVU7y7hnpGPctcjS6wfYNIBxp6oUQ2efx50QB32phI6jjiYsf+1zeNrLVIgE4k3wr6mGpHsoFISgfukRs+aab3bKpHATeHhvZwYq0cJPUPhN9lMfV+knvWZMRnGDAqkJd5fSLGR+Zn9OF/UD8Lz2OCh7GHg4NGdz/tYHGdMTwbEuBIvv9e2lIvsxunu5AivJP3UTl3FgZVTeZoWqLxKMK4c8365HVpu5BI0IYxKSDZFuIgKNO9vfTxLAGhCsG20yiug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=nxp.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H536rpQu8oZvmBs5VIoxdxL7QuEmK3YQ/quKpyx4kcg=;
 b=vr8wAmsbC8C0+L1Xx9CvywGPp1SH0WHPa9HhMLxoR74+NR7AhcovhzFJjPNhoVrGH3+YgXauudmOM+evVmUXWN841G4spttsa/At4bg540eLI36C90mm44aGME50QCoPrFPATDryLTfVA2wHoMBOqw32PjI5Ag7iDbrlbOLk3iY=
Received: from CH0PR03CA0326.namprd03.prod.outlook.com (2603:10b6:610:118::9)
 by MN2PR10MB4318.namprd10.prod.outlook.com (2603:10b6:208:1d8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 08:52:18 +0000
Received: from CH2PEPF00000099.namprd02.prod.outlook.com
 (2603:10b6:610:118:cafe::77) by CH0PR03CA0326.outlook.office365.com
 (2603:10b6:610:118::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.25 via Frontend Transport; Tue,
 28 Apr 2026 08:52:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CH2PEPF00000099.mail.protection.outlook.com (10.167.244.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 28 Apr 2026 08:52:17 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Apr
 2026 03:52:16 -0500
Received: from DFLE209.ent.ti.com (10.64.6.67) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Apr
 2026 03:52:16 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 28 Apr 2026 03:52:16 -0500
Received: from uda0498651.dhcp.ti.com (uda0498651.dhcp.ti.com [172.24.233.239])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63S8q6MJ623293;
	Tue, 28 Apr 2026 03:52:12 -0500
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nm@ti.com>,
	<ssantosh@kernel.org>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>,
	<Frank.li@nxp.com>, <s-adivi@ti.com>
CC: <r-sharma3@ti.com>, <gehariprasath@ti.com>
Subject: [PATCH v6 01/19] dmaengine: ti: k3-udma: Fix sporadic crash on AM62x
Date: Tue, 28 Apr 2026 14:21:30 +0530
Message-ID: <20260428085202.1724548-2-s-adivi@ti.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260428085202.1724548-1-s-adivi@ti.com>
References: <20260428085202.1724548-1-s-adivi@ti.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000099:EE_|MN2PR10MB4318:EE_
X-MS-Office365-Filtering-Correlation-Id: d202a4eb-dc62-4a3c-637b-08dea5037352
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|7416014|376014|1800799024|56012099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	qJOo4ngF1cgMWEU5OkiS9tpjVeTPn40JYdtwpF4E5iDtNVzoZpOigk2y+OTzXDMNVYx8DlZRwgw5wl1lbgbrtQ0mEljdjx0FWhZh7RK0CTzizdDUiwhH0ot/Ilfvg9FIknT97NumGCHiGNBDNsBW8thfv3TNJVNsT2568/XwGA+OY7dEydcYRUzjZWkSBO8PC7fm0O7RfcgnowUsRz0SxpZEt9fdHQ7OZmnYjwwLWKTA5fuQ7xY/bisypa4wsUkOs9yD/U9Q84CzDGiv2jzs/ziUg2D70ZsQnCo5ziO3B3LDQuX71xjO/IuYw83LcVZwNKo/2zJCKFTsxwMpnZ+awFPn9QptTzWEoLMxBc8S+M9m77u+4jc+5Cvf0CrfdLGhldEcjvtrIvaT4TuwVd+L5PBVcrnbjziKwdFLIIaYASEqt7qDi5n1D2gpewQBio7+xesdjI+RuoAPRm+VK413UvUkD9mdjym38wcYjWki/1G0ccHdkaK986EJuKS2sycHVG0AWZyC9nR1y81SUjmHfEq5NgE9VzUBf+Bu1Bf7emGkcXSzapR4iB3RUZLwzJVJv/q57kAEVB+3/ckPJ6WqeHTxh5E7Wikk641UPmY1FWxGXxUsGrYwkZWLJUh1ck/e0q5PzzZvJYxW8m/CgByKL68zw0blLCl0oqt23+aOgiT/4NypGADhL4i4IpNbqsOnivpQ09iTLwH2hisprnRdkIfxwiLPXUp1aXu17Fa+Ied/Mj3xVAlcABsW2UjNP2Od2QVIZ2DtUi/EJKKlsFNEaXd/xneupcDp0J9h3hWldJnwrgjt5v5uxm+XVtxr/0e3
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(7416014)(376014)(1800799024)(56012099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LlywwPAcvjfi1DzcQqD0IHEodE15PvBwW4pfq/+HZvbFRk8NHZuXpMJkBVI3/nS6QJq20pOFoDWkrBtEyB5JfRKAy+hSeGufenF8Lv9+bJc1nl5TbF2N33KwAelpuHcdEuXv9/3D8u6YjolcsYWuXqORk4UPHxpoLDwGS2lNaA2MOyDB15I9zg1lWV3H5PGJV0NMlPQQJoPiBLGF83kmsHvggcN+MSvFFBij1RcCJScdK3olGZGGOurVbmn915c6m9Y/+pgH0kHXWXc/eweTARTQYbZPKYf6DTTINiDKbeEMH4qV6ejQba+2rTlvpb02B3YacZXAjQsow2tM2FBGvjT5vwRid1aIRFuBjfk4tfaCOUdLIogvHFF8K7O9byNoMRjNHx09IV7DXVw/fflM07+oupcWyhYXr542Gxu5iNjyqLxaUZJ+dyl/1iRxRHtI
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 08:52:17.0478
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d202a4eb-dc62-4a3c-637b-08dea5037352
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000099.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4318
X-Rspamd-Queue-Id: 82B82480B03
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,ti.com,vger.kernel.org,lists.infradead.org,nxp.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10163-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s-adivi@ti.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

From: Vignesh Raghavendra <vigneshr@ti.com>

ring_init_data is declared on stack and thus can contain garbage which
can lead to k3_ringacc_dmarings use junk address for ringrt base leading
to below crash during ring pop

[    1.998239] cadence-qspi fc40000.spi: couldn't determine phase-detect-selector
[    2.532106] Unable to handle kernel paging request at virtual address ffff800081a84b98
[    2.540051] Mem abort info:
[...]
[    2.629987] Workqueue: events_unbound deferred_probe_work_func
[    2.635832] pstate: 800000c5 (Nzcv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    2.642787] pc : k3_ringacc_ring_pop+0x48/0x94
[    2.647234] lr : udma_pop_from_ring+0x7c/0xb4
[...]
[    2.726250] Call trace:
[    2.728691]  k3_ringacc_ring_pop+0x48/0x94
[    2.732786]  udma_ring_irq_handler+0x34/0x218
[    2.737141]  __handle_irq_event_percpu+0x60/0x14c
[    2.741846]  handle_irq_event+0x4c/0xa8

Fix this by explicitly initializing the variable to 0.

Reported-by: Rishikesh Donadkar <r-donadkar@ti.com>
Reported-by: Kendall Willis <k-willis@ti.com>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
---
 drivers/dma/ti/k3-udma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index c964ebfcf3b68..3e9792136906a 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -5484,7 +5484,7 @@ static int udma_probe(struct platform_device *pdev)
 	if (ud->match_data->type == DMA_TYPE_UDMA) {
 		ud->ringacc = of_k3_ringacc_get_by_phandle(dev->of_node, "ti,ringacc");
 	} else {
-		struct k3_ringacc_init_data ring_init_data;
+		struct k3_ringacc_init_data ring_init_data = { 0 };
 
 		ring_init_data.tisci = ud->tisci_rm.tisci;
 		ring_init_data.tisci_dev_id = ud->tisci_rm.tisci_dev_id;
-- 
2.53.0


