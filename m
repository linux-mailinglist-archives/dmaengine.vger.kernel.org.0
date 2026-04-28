Return-Path: <dmaengine+bounces-10168-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2P4oFNZ28GlgTwEAu9opvQ
	(envelope-from <dmaengine+bounces-10168-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 28 Apr 2026 10:59:02 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E55F8480C00
	for <lists+dmaengine@lfdr.de>; Tue, 28 Apr 2026 10:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 984EC305BACC
	for <lists+dmaengine@lfdr.de>; Tue, 28 Apr 2026 08:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D903D8122;
	Tue, 28 Apr 2026 08:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ISQAxTU2"
X-Original-To: dmaengine@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013022.outbound.protection.outlook.com [40.93.196.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CBD3D75D6;
	Tue, 28 Apr 2026 08:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777366380; cv=fail; b=Ik1VlX1xjagF8BCXygwIgN2Kza5bqfLLacXaO/uUwZ89/azx0pLcQOilvcH6TIR89sklCaj+sJLn+kYUrZc5x/hOUOx5y5jxpxskpGnon5qOS3dsBdUZMflBHC/2TomY9X/qSzDnfJCKveqWDVWmuwEc3CbADmjnK+lmNbi1mTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777366380; c=relaxed/simple;
	bh=rRd29+OQorD3WuRnaw6Q+p3LOPHfIhEgee4niBKOyiA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U7PcPbvkkK0Xb/Z/mLIJOEKJp3uWu+Y67U0MHPd9OisAvAVxPwqfKyXy+uvMADNPMPydX+12CIjTgj4a193MhaYAt/rFlRi9xIhpnEqP0vN67/bfjWeyP3UaA19so8CJI9s7HmD617HsNlHgEW43cOduyGGtlWbpU3IpTdBrPVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ISQAxTU2; arc=fail smtp.client-ip=40.93.196.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qdGZfChWGQu6AuaDi9Wajn0REmcbkIRoZC7RXawCPWpSNxoULAn9gdO56bjDxmvJRzQKwf23kIMhIU7iMNI+TQuMNgXOyixag9NufCL6GMFoG/k+rqnD7SsgHu4KY5vTQt6ZsfPAf6J6yzDyqWC5Svb+UjyTcR/50ypoa10c6hlDDl8KfT34yevMBOscT84jRz+EFNKkAyuiIZ1lnKZssa8MxMLeRpwFwPWaxsepQn3evlVnQ/E6oAXSwxgJMD3XzOzivZa3oXGwXnoT/nlnJ+TDFL1BnIyLT0oCD62p3LnbuyT5QgKA6HXRd9MP4FcupQblBfdBh37k/RMMGvp8ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xYMBNPuz1rkaqhoR8y3ORSFkge5zn2vzjJqHy/8hnqc=;
 b=SOhgxIH0dYnTGgAH7QQYRLKl+MQU1KlquASPpLHljOmPbNB6hQPNWBF+dF6SjF2nj4nGSA9+K43OdIHFRaXGArwU01+sB7PfBZsMXzR/XymmEmP/H3EijHmpLo/xuu1kOMSfF6lGFaKxlK6SGq6QeJZDUDCtD4y1QhLjDQBp+Kuam6iODWlV6aC/O5hMBPh1dGSIK+y9Bhb2IQbEXMXatJY4MLATOXQKdqTaHNnqdf1xuxQvcN40srWQP4TAD3L0O+vZOvc41mT8A1DTKBlHbIz5tXE5M01t1Za/BdZutp9XCIUjXTSZpGvbRZERQuvunrdPcSNxYJuVPgSqsMFr7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=nxp.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xYMBNPuz1rkaqhoR8y3ORSFkge5zn2vzjJqHy/8hnqc=;
 b=ISQAxTU2oZ8K1Jysw2IhMRoOjnJMIR8H3X0+00zJUnq4JCjqVqMUqV86Kj6gjd5kvVqjXjTdpWtTFgmWm5QEKKjUqdNk2csKjMdEOeT8B3x01+gd0ZlkEcGbM0LvjGwzziDRCrBDPt3ZO7mA/piuY++5YT998JmBAKHpUqxpIPs=
Received: from BN9PR03CA0398.namprd03.prod.outlook.com (2603:10b6:408:111::13)
 by CH0PR10MB7484.namprd10.prod.outlook.com (2603:10b6:610:182::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 08:52:54 +0000
Received: from BN2PEPF00004FBA.namprd04.prod.outlook.com
 (2603:10b6:408:111:cafe::13) by BN9PR03CA0398.outlook.office365.com
 (2603:10b6:408:111::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Tue,
 28 Apr 2026 08:52:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN2PEPF00004FBA.mail.protection.outlook.com (10.167.243.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 28 Apr 2026 08:52:54 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Apr
 2026 03:52:53 -0500
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Apr
 2026 03:52:53 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 28 Apr 2026 03:52:53 -0500
Received: from uda0498651.dhcp.ti.com (uda0498651.dhcp.ti.com [172.24.233.239])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63S8q6MR623293;
	Tue, 28 Apr 2026 03:52:49 -0500
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nm@ti.com>,
	<ssantosh@kernel.org>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>,
	<Frank.li@nxp.com>, <s-adivi@ti.com>
CC: <r-sharma3@ti.com>, <gehariprasath@ti.com>
Subject: [PATCH v6 09/19] dmaengine: ti: k3-udma: move resource management functions to k3-udma-common.c
Date: Tue, 28 Apr 2026 14:21:38 +0530
Message-ID: <20260428085202.1724548-10-s-adivi@ti.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBA:EE_|CH0PR10MB7484:EE_
X-MS-Office365-Filtering-Correlation-Id: 7442b7ed-5bc3-4b6c-86c5-08dea5038974
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|7416014|376014|921020|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	1JnaCYnj3NNjIJEqbA9TYrWTmVuPmLvWbejTidcUMTV4uNgzXDkggaILDaFRIdqprzSLrz/wHlkCRCsij+NF69Q8ZCQiCy22qgzN+vuTQ5wKLcoXTbwGBsZ0u/vryYDXY3JeVCMFHvj2nWuZWsT3P2kVhrAk143h7HG1N6XxMZHye4G3l4v9ZYqN3NvEa/k7GGHY/4ZSRL5suU1Lpy/9V0bgSWbfcGYyzZTRUEKYoVtB+9Ak3IlPG8sYsOGwo9j+Uc8G+Jq0lqPVBvRPGe2+pZBk6EZj78JYTJMTHAzqrJ4H5xVEYqCtRH9A+r4Ho3oMOYXm7hXjz+tlqeXmvj3GwvFEJ4Wumu3Fdnw6GYOKsCAsiSbZbdHs6iKjlx94soNROex5xDBAWaFZYztIPC88lGYeaxeDeZEyPHYsF2Eu+R2zMUClc+rQeHFJnpfkmddicgDds2QHub6lqlU9ARMbbNWvzJfTeGwJNXn4+dkevmBG4EEO2Vy2O8MRlVtBG4BG7zgARAuWFbxDvB0r2W9LuR96iIqsYYkJSaVffj2XtMK3KmcQRJdfx7fsJGHGr9SuKwn/6KYjpGVCLLyfYy3SkvTennWde5DKSJdeMh8WcjuSyJfxN1ng3BIlUoSUGtP0Ggzdjd1EEyIQ4QxkoW/8LwGQOySw0ywrSHAcBi4hTf32p9XLpcLud4XWTSJWQNrzTWCkOFsr7tw+WgbM7oaci90gBZ+36UWiKtyVlhrVcar/M+2GkXPPsf4yHNPcrThKosBmyuNpIGHvIBmx4aqFgppj47apZ8OnIro3J2OCgA8tZDKJJcYHzng5PWH09ujK
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(7416014)(376014)(921020)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ihs4j05CuiM7qTMaOYru8TSSmW5SfWbs68juIqdkN8WycM6saon2VuZ8Fmcf50/ZmfeLGoEh9BXIfdQF4t7mriYyqnQfKQml7TfVpHRnii2GeL2Ke4XSDWO2JGHwyWsdIbhHtkySsDaVOVeoECCS9Jx9MYs6Szk8kSkSSMc/I5k3WVYdU89FOJBQjhd5gDyZkzMw4eCmjsTGA2COZAKyWB7fNifNQK316tzyOYvAmj0qvqp/gZEPj6iYRFCrZhj1QJkHPCiWgWPMBwLziLbiZo/rATaIybzQVYBhnvEg9dMM3qF/UFrqM7/7/yedf85hfsZ+k5Ke59Vn04fxZfpRL4gMXUfLHan0Ind3elej1AU6wLoGnaHBu5kaOma5uNhQm/obVhg8L6Aeg2VYZ876Bje6QC2WFrX5wBfm/BAYt0MJhMjuXPk6Ru+48Azej7z6
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 08:52:54.1538
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7442b7ed-5bc3-4b6c-86c5-08dea5038974
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7484
X-Rspamd-Queue-Id: E55F8480C00
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,ti.com,vger.kernel.org,lists.infradead.org,nxp.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10168-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s-adivi@ti.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ti.com:email,ti.com:dkim,ti.com:mid];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[10]

Move functions responsible for allocation and release of udma
resources such as channels, rings and flows from k3-udma.c
to the common k3-udma-common.c file.

The implementation of these functions is largely shared between K3 UDMA
and K3 UDMA v2. This refactor improves code reuse and maintainability
across multiple variants.

No functional changes intended.

Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
---
 drivers/dma/ti/k3-udma-common.c | 442 ++++++++++++++++++++++++++++++++
 drivers/dma/ti/k3-udma.c        | 423 ------------------------------
 drivers/dma/ti/k3-udma.h        |  21 ++
 3 files changed, 463 insertions(+), 423 deletions(-)

diff --git a/drivers/dma/ti/k3-udma-common.c b/drivers/dma/ti/k3-udma-common.c
index 472eedc4663a9..882d27b3c9ee5 100644
--- a/drivers/dma/ti/k3-udma-common.c
+++ b/drivers/dma/ti/k3-udma-common.c
@@ -1891,5 +1891,447 @@ enum dmaengine_alignment udma_get_copy_align(struct udma_dev *ud)
 }
 EXPORT_SYMBOL_GPL(udma_get_copy_align);
 
+/**
+ * __udma_alloc_gp_rflow_range - alloc range of GP RX flows
+ * @ud: UDMA device
+ * @from: Start the search from this flow id number
+ * @cnt: Number of consecutive flow ids to allocate
+ *
+ * Allocate range of RX flow ids for future use, those flows can be requested
+ * only using explicit flow id number. if @from is set to -1 it will try to find
+ * first free range. if @from is positive value it will force allocation only
+ * of the specified range of flows.
+ *
+ * Returns -ENOMEM if can't find free range.
+ * -EEXIST if requested range is busy.
+ * -EINVAL if wrong input values passed.
+ * Returns flow id on success.
+ */
+int __udma_alloc_gp_rflow_range(struct udma_dev *ud, int from, int cnt)
+{
+	int start, tmp_from;
+	DECLARE_BITMAP(tmp, K3_UDMA_MAX_RFLOWS);
+
+	tmp_from = from;
+	if (tmp_from < 0)
+		tmp_from = ud->rchan_cnt;
+	/* default flows can't be allocated and accessible only by id */
+	if (tmp_from < ud->rchan_cnt)
+		return -EINVAL;
+
+	if (tmp_from + cnt > ud->rflow_cnt)
+		return -EINVAL;
+
+	bitmap_or(tmp, ud->rflow_gp_map, ud->rflow_gp_map_allocated,
+		  ud->rflow_cnt);
+
+	start = bitmap_find_next_zero_area(tmp,
+					   ud->rflow_cnt,
+					   tmp_from, cnt, 0);
+	if (start >= ud->rflow_cnt)
+		return -ENOMEM;
+
+	if (from >= 0 && start != from)
+		return -EEXIST;
+
+	bitmap_set(ud->rflow_gp_map_allocated, start, cnt);
+	return start;
+}
+EXPORT_SYMBOL_GPL(__udma_alloc_gp_rflow_range);
+
+int __udma_free_gp_rflow_range(struct udma_dev *ud, int from, int cnt)
+{
+	if (from < ud->rchan_cnt)
+		return -EINVAL;
+	if (from + cnt > ud->rflow_cnt)
+		return -EINVAL;
+
+	bitmap_clear(ud->rflow_gp_map_allocated, from, cnt);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(__udma_free_gp_rflow_range);
+
+struct udma_rflow *__udma_get_rflow(struct udma_dev *ud, int id)
+{
+	/*
+	 * Attempt to request rflow by ID can be made for any rflow
+	 * if not in use with assumption that caller knows what's doing.
+	 * TI-SCI FW will perform additional permission check ant way, it's
+	 * safe
+	 */
+
+	if (id < 0 || id >= ud->rflow_cnt)
+		return ERR_PTR(-ENOENT);
+
+	if (test_bit(id, ud->rflow_in_use))
+		return ERR_PTR(-ENOENT);
+
+	if (ud->rflow_gp_map) {
+		/* GP rflow has to be allocated first */
+		if (!test_bit(id, ud->rflow_gp_map) &&
+		    !test_bit(id, ud->rflow_gp_map_allocated))
+			return ERR_PTR(-EINVAL);
+	}
+
+	dev_dbg(ud->dev, "get rflow%d\n", id);
+	set_bit(id, ud->rflow_in_use);
+	return &ud->rflows[id];
+}
+EXPORT_SYMBOL_GPL(__udma_get_rflow);
+
+void __udma_put_rflow(struct udma_dev *ud, struct udma_rflow *rflow)
+{
+	if (!test_bit(rflow->id, ud->rflow_in_use)) {
+		dev_err(ud->dev, "attempt to put unused rflow%d\n", rflow->id);
+		return;
+	}
+
+	dev_dbg(ud->dev, "put rflow%d\n", rflow->id);
+	clear_bit(rflow->id, ud->rflow_in_use);
+}
+EXPORT_SYMBOL_GPL(__udma_put_rflow);
+
+#define UDMA_RESERVE_RESOURCE(res)					\
+struct udma_##res *__udma_reserve_##res(struct udma_dev *ud,	\
+					       enum udma_tp_level tpl,	\
+					       int id)			\
+{									\
+	if (id >= 0) {							\
+		if (test_bit(id, ud->res##_map)) {			\
+			dev_err(ud->dev, "res##%d is in use\n", id);	\
+			return ERR_PTR(-ENOENT);			\
+		}							\
+	} else {							\
+		int start;						\
+									\
+		if (tpl >= ud->res##_tpl.levels)			\
+			tpl = ud->res##_tpl.levels - 1;			\
+									\
+		start = ud->res##_tpl.start_idx[tpl];			\
+									\
+		id = find_next_zero_bit(ud->res##_map, ud->res##_cnt,	\
+					start);				\
+		if (id == ud->res##_cnt) {				\
+			return ERR_PTR(-ENOENT);			\
+		}							\
+	}								\
+									\
+	set_bit(id, ud->res##_map);					\
+	return &ud->res##s[id];						\
+}
+
+UDMA_RESERVE_RESOURCE(bchan);
+EXPORT_SYMBOL_GPL(__udma_reserve_bchan);
+UDMA_RESERVE_RESOURCE(tchan);
+EXPORT_SYMBOL_GPL(__udma_reserve_tchan);
+UDMA_RESERVE_RESOURCE(rchan);
+EXPORT_SYMBOL_GPL(__udma_reserve_rchan);
+
+int udma_get_tchan(struct udma_chan *uc)
+{
+	struct udma_dev *ud = uc->ud;
+	int ret;
+
+	if (uc->tchan) {
+		dev_dbg(ud->dev, "chan%d: already have tchan%d allocated\n",
+			uc->id, uc->tchan->id);
+		return 0;
+	}
+
+	/*
+	 * mapped_channel_id is -1 for UDMA, BCDMA and PKTDMA unmapped channels.
+	 * For PKTDMA mapped channels it is configured to a channel which must
+	 * be used to service the peripheral.
+	 */
+	uc->tchan = __udma_reserve_tchan(ud, uc->config.channel_tpl,
+					 uc->config.mapped_channel_id);
+	if (IS_ERR(uc->tchan)) {
+		ret = PTR_ERR(uc->tchan);
+		uc->tchan = NULL;
+		return ret;
+	}
+
+	if (ud->tflow_cnt) {
+		int tflow_id;
+
+		/* Only PKTDMA have support for tx flows */
+		if (uc->config.default_flow_id >= 0)
+			tflow_id = uc->config.default_flow_id;
+		else
+			tflow_id = uc->tchan->id;
+
+		if (test_bit(tflow_id, ud->tflow_map)) {
+			dev_err(ud->dev, "tflow%d is in use\n", tflow_id);
+			clear_bit(uc->tchan->id, ud->tchan_map);
+			uc->tchan = NULL;
+			return -ENOENT;
+		}
+
+		uc->tchan->tflow_id = tflow_id;
+		set_bit(tflow_id, ud->tflow_map);
+	} else {
+		uc->tchan->tflow_id = -1;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(udma_get_tchan);
+
+int udma_get_rchan(struct udma_chan *uc)
+{
+	struct udma_dev *ud = uc->ud;
+	int ret;
+
+	if (uc->rchan) {
+		dev_dbg(ud->dev, "chan%d: already have rchan%d allocated\n",
+			uc->id, uc->rchan->id);
+		return 0;
+	}
+
+	/*
+	 * mapped_channel_id is -1 for UDMA, BCDMA and PKTDMA unmapped channels.
+	 * For PKTDMA mapped channels it is configured to a channel which must
+	 * be used to service the peripheral.
+	 */
+	uc->rchan = __udma_reserve_rchan(ud, uc->config.channel_tpl,
+					 uc->config.mapped_channel_id);
+	if (IS_ERR(uc->rchan)) {
+		ret = PTR_ERR(uc->rchan);
+		uc->rchan = NULL;
+		return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(udma_get_rchan);
+
+int udma_get_chan_pair(struct udma_chan *uc)
+{
+	struct udma_dev *ud = uc->ud;
+	int chan_id, end;
+
+	if ((uc->tchan && uc->rchan) && uc->tchan->id == uc->rchan->id) {
+		dev_info(ud->dev, "chan%d: already have %d pair allocated\n",
+			 uc->id, uc->tchan->id);
+		return 0;
+	}
+
+	if (uc->tchan) {
+		dev_err(ud->dev, "chan%d: already have tchan%d allocated\n",
+			uc->id, uc->tchan->id);
+		return -EBUSY;
+	} else if (uc->rchan) {
+		dev_err(ud->dev, "chan%d: already have rchan%d allocated\n",
+			uc->id, uc->rchan->id);
+		return -EBUSY;
+	}
+
+	/* Can be optimized, but let's have it like this for now */
+	end = min(ud->tchan_cnt, ud->rchan_cnt);
+	/*
+	 * Try to use the highest TPL channel pair for MEM_TO_MEM channels
+	 * Note: in UDMAP the channel TPL is symmetric between tchan and rchan
+	 */
+	chan_id = ud->tchan_tpl.start_idx[ud->tchan_tpl.levels - 1];
+	for (; chan_id < end; chan_id++) {
+		if (!test_bit(chan_id, ud->tchan_map) &&
+		    !test_bit(chan_id, ud->rchan_map))
+			break;
+	}
+
+	if (chan_id == end)
+		return -ENOENT;
+
+	set_bit(chan_id, ud->tchan_map);
+	set_bit(chan_id, ud->rchan_map);
+	uc->tchan = &ud->tchans[chan_id];
+	uc->rchan = &ud->rchans[chan_id];
+
+	/* UDMA does not use tx flows */
+	uc->tchan->tflow_id = -1;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(udma_get_chan_pair);
+
+int udma_get_rflow(struct udma_chan *uc, int flow_id)
+{
+	struct udma_dev *ud = uc->ud;
+	int ret;
+
+	if (!uc->rchan) {
+		dev_err(ud->dev, "chan%d: does not have rchan??\n", uc->id);
+		return -EINVAL;
+	}
+
+	if (uc->rflow) {
+		dev_dbg(ud->dev, "chan%d: already have rflow%d allocated\n",
+			uc->id, uc->rflow->id);
+		return 0;
+	}
+
+	uc->rflow = __udma_get_rflow(ud, flow_id);
+	if (IS_ERR(uc->rflow)) {
+		ret = PTR_ERR(uc->rflow);
+		uc->rflow = NULL;
+		return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(udma_get_rflow);
+
+void udma_put_rchan(struct udma_chan *uc)
+{
+	struct udma_dev *ud = uc->ud;
+
+	if (uc->rchan) {
+		dev_dbg(ud->dev, "chan%d: put rchan%d\n", uc->id,
+			uc->rchan->id);
+		clear_bit(uc->rchan->id, ud->rchan_map);
+		uc->rchan = NULL;
+	}
+}
+EXPORT_SYMBOL_GPL(udma_put_rchan);
+
+void udma_put_tchan(struct udma_chan *uc)
+{
+	struct udma_dev *ud = uc->ud;
+
+	if (uc->tchan) {
+		dev_dbg(ud->dev, "chan%d: put tchan%d\n", uc->id,
+			uc->tchan->id);
+		clear_bit(uc->tchan->id, ud->tchan_map);
+
+		if (uc->tchan->tflow_id >= 0)
+			clear_bit(uc->tchan->tflow_id, ud->tflow_map);
+
+		uc->tchan = NULL;
+	}
+}
+EXPORT_SYMBOL_GPL(udma_put_tchan);
+
+void udma_put_rflow(struct udma_chan *uc)
+{
+	struct udma_dev *ud = uc->ud;
+
+	if (uc->rflow) {
+		dev_dbg(ud->dev, "chan%d: put rflow%d\n", uc->id,
+			uc->rflow->id);
+		__udma_put_rflow(ud, uc->rflow);
+		uc->rflow = NULL;
+	}
+}
+EXPORT_SYMBOL_GPL(udma_put_rflow);
+
+void udma_free_tx_resources(struct udma_chan *uc)
+{
+	if (!uc->tchan)
+		return;
+
+	k3_ringacc_ring_free(uc->tchan->t_ring);
+	k3_ringacc_ring_free(uc->tchan->tc_ring);
+	uc->tchan->t_ring = NULL;
+	uc->tchan->tc_ring = NULL;
+
+	udma_put_tchan(uc);
+}
+EXPORT_SYMBOL_GPL(udma_free_tx_resources);
+
+void udma_free_rx_resources(struct udma_chan *uc)
+{
+	if (!uc->rchan)
+		return;
+
+	if (uc->rflow) {
+		struct udma_rflow *rflow = uc->rflow;
+
+		k3_ringacc_ring_free(rflow->fd_ring);
+		k3_ringacc_ring_free(rflow->r_ring);
+		rflow->fd_ring = NULL;
+		rflow->r_ring = NULL;
+
+		udma_put_rflow(uc);
+	}
+
+	udma_put_rchan(uc);
+}
+EXPORT_SYMBOL_GPL(udma_free_rx_resources);
+
+void udma_free_chan_resources(struct dma_chan *chan)
+{
+	struct udma_chan *uc = to_udma_chan(chan);
+	struct udma_dev *ud = to_udma_dev(chan->device);
+
+	udma_terminate_all(chan);
+	if (uc->terminated_desc) {
+		ud->reset_chan(uc, false);
+		udma_reset_rings(uc);
+	}
+
+	cancel_delayed_work_sync(&uc->tx_drain.work);
+
+	if (uc->irq_num_ring > 0) {
+		free_irq(uc->irq_num_ring, uc);
+
+		uc->irq_num_ring = 0;
+	}
+	if (uc->irq_num_udma > 0) {
+		free_irq(uc->irq_num_udma, uc);
+
+		uc->irq_num_udma = 0;
+	}
+
+	/* Release PSI-L pairing */
+	if (uc->psil_paired && ud->psil_unpair) {
+		ud->psil_unpair(ud, uc->config.src_thread,
+				  uc->config.dst_thread);
+		uc->psil_paired = false;
+	}
+
+	vchan_free_chan_resources(&uc->vc);
+	tasklet_kill(&uc->vc.task);
+
+	bcdma_free_bchan_resources(uc);
+	udma_free_tx_resources(uc);
+	udma_free_rx_resources(uc);
+	udma_reset_uchan(uc);
+
+	if (uc->use_dma_pool) {
+		dma_pool_destroy(uc->hdesc_pool);
+		uc->use_dma_pool = false;
+	}
+}
+EXPORT_SYMBOL_GPL(udma_free_chan_resources);
+
+void bcdma_put_bchan(struct udma_chan *uc)
+{
+	struct udma_dev *ud = uc->ud;
+
+	if (uc->bchan) {
+		dev_dbg(ud->dev, "chan%d: put bchan%d\n", uc->id,
+			uc->bchan->id);
+		clear_bit(uc->bchan->id, ud->bchan_map);
+		uc->bchan = NULL;
+		uc->tchan = NULL;
+	}
+}
+EXPORT_SYMBOL_GPL(bcdma_put_bchan);
+
+void bcdma_free_bchan_resources(struct udma_chan *uc)
+{
+	if (!uc->bchan)
+		return;
+
+	k3_ringacc_ring_free(uc->bchan->tc_ring);
+	k3_ringacc_ring_free(uc->bchan->t_ring);
+	uc->bchan->tc_ring = NULL;
+	uc->bchan->t_ring = NULL;
+	k3_configure_chan_coherency(&uc->vc.chan, 0);
+
+	bcdma_put_bchan(uc);
+}
+EXPORT_SYMBOL_GPL(bcdma_free_bchan_resources);
+
 MODULE_DESCRIPTION("Texas Instruments K3 UDMA Common Library");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 89c887bc86a34..753acf1e13fa2 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -423,135 +423,6 @@ static irqreturn_t udma_udma_irq_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-/**
- * __udma_alloc_gp_rflow_range - alloc range of GP RX flows
- * @ud: UDMA device
- * @from: Start the search from this flow id number
- * @cnt: Number of consecutive flow ids to allocate
- *
- * Allocate range of RX flow ids for future use, those flows can be requested
- * only using explicit flow id number. if @from is set to -1 it will try to find
- * first free range. if @from is positive value it will force allocation only
- * of the specified range of flows.
- *
- * Returns -ENOMEM if can't find free range.
- * -EEXIST if requested range is busy.
- * -EINVAL if wrong input values passed.
- * Returns flow id on success.
- */
-static int __udma_alloc_gp_rflow_range(struct udma_dev *ud, int from, int cnt)
-{
-	int start, tmp_from;
-	DECLARE_BITMAP(tmp, K3_UDMA_MAX_RFLOWS);
-
-	tmp_from = from;
-	if (tmp_from < 0)
-		tmp_from = ud->rchan_cnt;
-	/* default flows can't be allocated and accessible only by id */
-	if (tmp_from < ud->rchan_cnt)
-		return -EINVAL;
-
-	if (tmp_from + cnt > ud->rflow_cnt)
-		return -EINVAL;
-
-	bitmap_or(tmp, ud->rflow_gp_map, ud->rflow_gp_map_allocated,
-		  ud->rflow_cnt);
-
-	start = bitmap_find_next_zero_area(tmp,
-					   ud->rflow_cnt,
-					   tmp_from, cnt, 0);
-	if (start >= ud->rflow_cnt)
-		return -ENOMEM;
-
-	if (from >= 0 && start != from)
-		return -EEXIST;
-
-	bitmap_set(ud->rflow_gp_map_allocated, start, cnt);
-	return start;
-}
-
-static int __udma_free_gp_rflow_range(struct udma_dev *ud, int from, int cnt)
-{
-	if (from < ud->rchan_cnt)
-		return -EINVAL;
-	if (from + cnt > ud->rflow_cnt)
-		return -EINVAL;
-
-	bitmap_clear(ud->rflow_gp_map_allocated, from, cnt);
-	return 0;
-}
-
-static struct udma_rflow *__udma_get_rflow(struct udma_dev *ud, int id)
-{
-	/*
-	 * Attempt to request rflow by ID can be made for any rflow
-	 * if not in use with assumption that caller knows what's doing.
-	 * TI-SCI FW will perform additional permission check ant way, it's
-	 * safe
-	 */
-
-	if (id < 0 || id >= ud->rflow_cnt)
-		return ERR_PTR(-ENOENT);
-
-	if (test_bit(id, ud->rflow_in_use))
-		return ERR_PTR(-ENOENT);
-
-	if (ud->rflow_gp_map) {
-		/* GP rflow has to be allocated first */
-		if (!test_bit(id, ud->rflow_gp_map) &&
-		    !test_bit(id, ud->rflow_gp_map_allocated))
-			return ERR_PTR(-EINVAL);
-	}
-
-	dev_dbg(ud->dev, "get rflow%d\n", id);
-	set_bit(id, ud->rflow_in_use);
-	return &ud->rflows[id];
-}
-
-static void __udma_put_rflow(struct udma_dev *ud, struct udma_rflow *rflow)
-{
-	if (!test_bit(rflow->id, ud->rflow_in_use)) {
-		dev_err(ud->dev, "attempt to put unused rflow%d\n", rflow->id);
-		return;
-	}
-
-	dev_dbg(ud->dev, "put rflow%d\n", rflow->id);
-	clear_bit(rflow->id, ud->rflow_in_use);
-}
-
-#define UDMA_RESERVE_RESOURCE(res)					\
-static struct udma_##res *__udma_reserve_##res(struct udma_dev *ud,	\
-					       enum udma_tp_level tpl,	\
-					       int id)			\
-{									\
-	if (id >= 0) {							\
-		if (test_bit(id, ud->res##_map)) {			\
-			dev_err(ud->dev, "res##%d is in use\n", id);	\
-			return ERR_PTR(-ENOENT);			\
-		}							\
-	} else {							\
-		int start;						\
-									\
-		if (tpl >= ud->res##_tpl.levels)			\
-			tpl = ud->res##_tpl.levels - 1;			\
-									\
-		start = ud->res##_tpl.start_idx[tpl];			\
-									\
-		id = find_next_zero_bit(ud->res##_map, ud->res##_cnt,	\
-					start);				\
-		if (id == ud->res##_cnt) {				\
-			return ERR_PTR(-ENOENT);			\
-		}							\
-	}								\
-									\
-	set_bit(id, ud->res##_map);					\
-	return &ud->res##s[id];						\
-}
-
-UDMA_RESERVE_RESOURCE(bchan);
-UDMA_RESERVE_RESOURCE(tchan);
-UDMA_RESERVE_RESOURCE(rchan);
-
 static int bcdma_get_bchan(struct udma_chan *uc)
 {
 	struct udma_dev *ud = uc->ud;
@@ -585,223 +456,6 @@ static int bcdma_get_bchan(struct udma_chan *uc)
 	return 0;
 }
 
-static int udma_get_tchan(struct udma_chan *uc)
-{
-	struct udma_dev *ud = uc->ud;
-	int ret;
-
-	if (uc->tchan) {
-		dev_dbg(ud->dev, "chan%d: already have tchan%d allocated\n",
-			uc->id, uc->tchan->id);
-		return 0;
-	}
-
-	/*
-	 * mapped_channel_id is -1 for UDMA, BCDMA and PKTDMA unmapped channels.
-	 * For PKTDMA mapped channels it is configured to a channel which must
-	 * be used to service the peripheral.
-	 */
-	uc->tchan = __udma_reserve_tchan(ud, uc->config.channel_tpl,
-					 uc->config.mapped_channel_id);
-	if (IS_ERR(uc->tchan)) {
-		ret = PTR_ERR(uc->tchan);
-		uc->tchan = NULL;
-		return ret;
-	}
-
-	if (ud->tflow_cnt) {
-		int tflow_id;
-
-		/* Only PKTDMA have support for tx flows */
-		if (uc->config.default_flow_id >= 0)
-			tflow_id = uc->config.default_flow_id;
-		else
-			tflow_id = uc->tchan->id;
-
-		if (test_bit(tflow_id, ud->tflow_map)) {
-			dev_err(ud->dev, "tflow%d is in use\n", tflow_id);
-			clear_bit(uc->tchan->id, ud->tchan_map);
-			uc->tchan = NULL;
-			return -ENOENT;
-		}
-
-		uc->tchan->tflow_id = tflow_id;
-		set_bit(tflow_id, ud->tflow_map);
-	} else {
-		uc->tchan->tflow_id = -1;
-	}
-
-	return 0;
-}
-
-static int udma_get_rchan(struct udma_chan *uc)
-{
-	struct udma_dev *ud = uc->ud;
-	int ret;
-
-	if (uc->rchan) {
-		dev_dbg(ud->dev, "chan%d: already have rchan%d allocated\n",
-			uc->id, uc->rchan->id);
-		return 0;
-	}
-
-	/*
-	 * mapped_channel_id is -1 for UDMA, BCDMA and PKTDMA unmapped channels.
-	 * For PKTDMA mapped channels it is configured to a channel which must
-	 * be used to service the peripheral.
-	 */
-	uc->rchan = __udma_reserve_rchan(ud, uc->config.channel_tpl,
-					 uc->config.mapped_channel_id);
-	if (IS_ERR(uc->rchan)) {
-		ret = PTR_ERR(uc->rchan);
-		uc->rchan = NULL;
-		return ret;
-	}
-
-	return 0;
-}
-
-static int udma_get_chan_pair(struct udma_chan *uc)
-{
-	struct udma_dev *ud = uc->ud;
-	int chan_id, end;
-
-	if ((uc->tchan && uc->rchan) && uc->tchan->id == uc->rchan->id) {
-		dev_info(ud->dev, "chan%d: already have %d pair allocated\n",
-			 uc->id, uc->tchan->id);
-		return 0;
-	}
-
-	if (uc->tchan) {
-		dev_err(ud->dev, "chan%d: already have tchan%d allocated\n",
-			uc->id, uc->tchan->id);
-		return -EBUSY;
-	} else if (uc->rchan) {
-		dev_err(ud->dev, "chan%d: already have rchan%d allocated\n",
-			uc->id, uc->rchan->id);
-		return -EBUSY;
-	}
-
-	/* Can be optimized, but let's have it like this for now */
-	end = min(ud->tchan_cnt, ud->rchan_cnt);
-	/*
-	 * Try to use the highest TPL channel pair for MEM_TO_MEM channels
-	 * Note: in UDMAP the channel TPL is symmetric between tchan and rchan
-	 */
-	chan_id = ud->tchan_tpl.start_idx[ud->tchan_tpl.levels - 1];
-	for (; chan_id < end; chan_id++) {
-		if (!test_bit(chan_id, ud->tchan_map) &&
-		    !test_bit(chan_id, ud->rchan_map))
-			break;
-	}
-
-	if (chan_id == end)
-		return -ENOENT;
-
-	set_bit(chan_id, ud->tchan_map);
-	set_bit(chan_id, ud->rchan_map);
-	uc->tchan = &ud->tchans[chan_id];
-	uc->rchan = &ud->rchans[chan_id];
-
-	/* UDMA does not use tx flows */
-	uc->tchan->tflow_id = -1;
-
-	return 0;
-}
-
-static int udma_get_rflow(struct udma_chan *uc, int flow_id)
-{
-	struct udma_dev *ud = uc->ud;
-	int ret;
-
-	if (!uc->rchan) {
-		dev_err(ud->dev, "chan%d: does not have rchan??\n", uc->id);
-		return -EINVAL;
-	}
-
-	if (uc->rflow) {
-		dev_dbg(ud->dev, "chan%d: already have rflow%d allocated\n",
-			uc->id, uc->rflow->id);
-		return 0;
-	}
-
-	uc->rflow = __udma_get_rflow(ud, flow_id);
-	if (IS_ERR(uc->rflow)) {
-		ret = PTR_ERR(uc->rflow);
-		uc->rflow = NULL;
-		return ret;
-	}
-
-	return 0;
-}
-
-static void bcdma_put_bchan(struct udma_chan *uc)
-{
-	struct udma_dev *ud = uc->ud;
-
-	if (uc->bchan) {
-		dev_dbg(ud->dev, "chan%d: put bchan%d\n", uc->id,
-			uc->bchan->id);
-		clear_bit(uc->bchan->id, ud->bchan_map);
-		uc->bchan = NULL;
-		uc->tchan = NULL;
-	}
-}
-
-static void udma_put_rchan(struct udma_chan *uc)
-{
-	struct udma_dev *ud = uc->ud;
-
-	if (uc->rchan) {
-		dev_dbg(ud->dev, "chan%d: put rchan%d\n", uc->id,
-			uc->rchan->id);
-		clear_bit(uc->rchan->id, ud->rchan_map);
-		uc->rchan = NULL;
-	}
-}
-
-static void udma_put_tchan(struct udma_chan *uc)
-{
-	struct udma_dev *ud = uc->ud;
-
-	if (uc->tchan) {
-		dev_dbg(ud->dev, "chan%d: put tchan%d\n", uc->id,
-			uc->tchan->id);
-		clear_bit(uc->tchan->id, ud->tchan_map);
-
-		if (uc->tchan->tflow_id >= 0)
-			clear_bit(uc->tchan->tflow_id, ud->tflow_map);
-
-		uc->tchan = NULL;
-	}
-}
-
-static void udma_put_rflow(struct udma_chan *uc)
-{
-	struct udma_dev *ud = uc->ud;
-
-	if (uc->rflow) {
-		dev_dbg(ud->dev, "chan%d: put rflow%d\n", uc->id,
-			uc->rflow->id);
-		__udma_put_rflow(ud, uc->rflow);
-		uc->rflow = NULL;
-	}
-}
-
-static void bcdma_free_bchan_resources(struct udma_chan *uc)
-{
-	if (!uc->bchan)
-		return;
-
-	k3_ringacc_ring_free(uc->bchan->tc_ring);
-	k3_ringacc_ring_free(uc->bchan->t_ring);
-	uc->bchan->tc_ring = NULL;
-	uc->bchan->t_ring = NULL;
-	k3_configure_chan_coherency(&uc->vc.chan, 0);
-
-	bcdma_put_bchan(uc);
-}
-
 static int bcdma_alloc_bchan_resources(struct udma_chan *uc)
 {
 	struct k3_ring_cfg ring_cfg;
@@ -847,19 +501,6 @@ static int bcdma_alloc_bchan_resources(struct udma_chan *uc)
 	return ret;
 }
 
-static void udma_free_tx_resources(struct udma_chan *uc)
-{
-	if (!uc->tchan)
-		return;
-
-	k3_ringacc_ring_free(uc->tchan->t_ring);
-	k3_ringacc_ring_free(uc->tchan->tc_ring);
-	uc->tchan->t_ring = NULL;
-	uc->tchan->tc_ring = NULL;
-
-	udma_put_tchan(uc);
-}
-
 static int udma_alloc_tx_resources(struct udma_chan *uc)
 {
 	struct k3_ring_cfg ring_cfg;
@@ -917,25 +558,6 @@ static int udma_alloc_tx_resources(struct udma_chan *uc)
 	return ret;
 }
 
-static void udma_free_rx_resources(struct udma_chan *uc)
-{
-	if (!uc->rchan)
-		return;
-
-	if (uc->rflow) {
-		struct udma_rflow *rflow = uc->rflow;
-
-		k3_ringacc_ring_free(rflow->fd_ring);
-		k3_ringacc_ring_free(rflow->r_ring);
-		rflow->fd_ring = NULL;
-		rflow->r_ring = NULL;
-
-		udma_put_rflow(uc);
-	}
-
-	udma_put_rchan(uc);
-}
-
 static int udma_alloc_rx_resources(struct udma_chan *uc)
 {
 	struct udma_dev *ud = uc->ud;
@@ -2024,51 +1646,6 @@ static int udma_resume(struct dma_chan *chan)
 	return 0;
 }
 
-static void udma_free_chan_resources(struct dma_chan *chan)
-{
-	struct udma_chan *uc = to_udma_chan(chan);
-	struct udma_dev *ud = to_udma_dev(chan->device);
-
-	udma_terminate_all(chan);
-	if (uc->terminated_desc) {
-		ud->reset_chan(uc, false);
-		udma_reset_rings(uc);
-	}
-
-	cancel_delayed_work_sync(&uc->tx_drain.work);
-
-	if (uc->irq_num_ring > 0) {
-		free_irq(uc->irq_num_ring, uc);
-
-		uc->irq_num_ring = 0;
-	}
-	if (uc->irq_num_udma > 0) {
-		free_irq(uc->irq_num_udma, uc);
-
-		uc->irq_num_udma = 0;
-	}
-
-	/* Release PSI-L pairing */
-	if (uc->psil_paired) {
-		navss_psil_unpair(ud, uc->config.src_thread,
-				  uc->config.dst_thread);
-		uc->psil_paired = false;
-	}
-
-	vchan_free_chan_resources(&uc->vc);
-	tasklet_kill(&uc->vc.task);
-
-	bcdma_free_bchan_resources(uc);
-	udma_free_tx_resources(uc);
-	udma_free_rx_resources(uc);
-	udma_reset_uchan(uc);
-
-	if (uc->use_dma_pool) {
-		dma_pool_destroy(uc->hdesc_pool);
-		uc->use_dma_pool = false;
-	}
-}
-
 static struct platform_driver udma_driver;
 static struct platform_driver bcdma_driver;
 static struct platform_driver pktdma_driver;
diff --git a/drivers/dma/ti/k3-udma.h b/drivers/dma/ti/k3-udma.h
index 797e8b0c5b85e..e4b512d9ffb2e 100644
--- a/drivers/dma/ti/k3-udma.h
+++ b/drivers/dma/ti/k3-udma.h
@@ -654,6 +654,27 @@ void udma_dbg_summary_show(struct seq_file *s,
 			   struct dma_device *dma_dev);
 #endif /* CONFIG_DEBUG_FS */
 
+int __udma_alloc_gp_rflow_range(struct udma_dev *ud, int from, int cnt);
+int __udma_free_gp_rflow_range(struct udma_dev *ud, int from, int cnt);
+struct udma_rflow *__udma_get_rflow(struct udma_dev *ud, int id);
+void __udma_put_rflow(struct udma_dev *ud, struct udma_rflow *rflow);
+int udma_get_tchan(struct udma_chan *uc);
+int udma_get_rchan(struct udma_chan *uc);
+int udma_get_chan_pair(struct udma_chan *uc);
+int udma_get_rflow(struct udma_chan *uc, int flow_id);
+void udma_put_rchan(struct udma_chan *uc);
+void udma_put_tchan(struct udma_chan *uc);
+void udma_put_rflow(struct udma_chan *uc);
+void udma_free_tx_resources(struct udma_chan *uc);
+void udma_free_rx_resources(struct udma_chan *uc);
+void udma_free_chan_resources(struct dma_chan *chan);
+void bcdma_put_bchan(struct udma_chan *uc);
+void bcdma_free_bchan_resources(struct udma_chan *uc);
+
+struct udma_bchan *__udma_reserve_bchan(struct udma_dev *ud, enum udma_tp_level tpl, int id);
+struct udma_tchan *__udma_reserve_tchan(struct udma_dev *ud, enum udma_tp_level tpl, int id);
+struct udma_rchan *__udma_reserve_rchan(struct udma_dev *ud, enum udma_tp_level tpl, int id);
+
 /* Direct access to UDMA low lever resources for the glue layer */
 int xudma_navss_psil_pair(struct udma_dev *ud, u32 src_thread, u32 dst_thread);
 int xudma_navss_psil_unpair(struct udma_dev *ud, u32 src_thread,
-- 
2.53.0


