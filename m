Return-Path: <dmaengine+bounces-10198-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPecKrry8mnNvwEAu9opvQ
	(envelope-from <dmaengine+bounces-10198-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 30 Apr 2026 08:12:10 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B7549DEA1
	for <lists+dmaengine@lfdr.de>; Thu, 30 Apr 2026 08:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 653C230143D7
	for <lists+dmaengine@lfdr.de>; Thu, 30 Apr 2026 06:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1550D374E73;
	Thu, 30 Apr 2026 06:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dM5xg/Wi"
X-Original-To: dmaengine@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011069.outbound.protection.outlook.com [52.101.62.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0073F37475C;
	Thu, 30 Apr 2026 06:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777529521; cv=fail; b=j/YwfkvnpdS9ovy9aafKIyzudHY+Ba/C/hI7+eQaJ5XrcYfsYt9csAh8/M5//ROtxC3ZiLHZfuTrwmqDtF3BVd1MGnUl6/aU79LDSbGh1jOf+whu+ZTz+sHHmpltKAD6lC7Bl68dgBgmLHctUaaDZZjHmbJXjNKvKwlF18f1RaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777529521; c=relaxed/simple;
	bh=ExxAIxriZsOFM9rm1AoYIc69hkRrOPcl8FmRwSpubls=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N55ium0TC+Wm6pnhBJyfrMciBq8xrMZXR3qmwPTTGRNdBO+UJx63MmtAJ74TLt5c8WArl0zV7w8LcMx20w8Os2TYJ1NhgHjpoMw4cQBFor7hM9g5Jow8g8Dhi9jcYyYGrASbFlxnxBNXIs9Em/2iyZ26HEys8dIR+OWhKn6Rt4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=dM5xg/Wi; arc=fail smtp.client-ip=52.101.62.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vJ69R5khFinhQqgOKTNwcYOUIs6hOJM5JjidnUqEYbcrjhM1fZOs9HamSa+jKKUZhSZh+NDywTrDT6xgGp1iMVrujd76ODPwCuG2P5GxK1LRwx4TTieWLJ2v//aKBGgdNSPw5/39ZrcsthYb7k4hQY7q6Ddp/lyJPLEsF1RFsutURtHxJ+RoFznBDEofmNVHtBXlRzs3tP2q5Qhbea7fUZV7ISsuXn4/JQfJqWhEr1RoNdD7XV2PG6Q2o+MXT/CAo8XQTAzSStzTWH9vH6Lp5ovPtny6YdaC1Xgq1DpKh0nfFoXEnMO0reIFKc6QbRzligxW2F7hM1mo2mjqu875Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ExxAIxriZsOFM9rm1AoYIc69hkRrOPcl8FmRwSpubls=;
 b=bpK2emxosSYLYwCueG673UAU58xAe85X3lf5qNIpfttVZvsqpHaSuGPtlt/x31oITQCYtUps/j8EISK7v9sQPHWEh23ac16bQ0RP56B13wdMc9qjzsH3STxupLwFmtKN2rh8vlpsZAAOzLW/QqWFiDo0kXi7uzLBWXpA+fX0+rAFizc6H1VsLdFZXtxDKaVi8w6xmTneka23vBmzRl1pl5+9Nn6qpSIbguTwKRsMep4/Rrf9nFSywUDPbuC9AWCgWnE2KnMQ1E5/+Wu9VhOh9gApB9cZpznkDMo7UBo8kti5lisdkPfEm7/EItKQSgVi6r79CWlJ0gLZpcEdAwmW+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=kernel.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ExxAIxriZsOFM9rm1AoYIc69hkRrOPcl8FmRwSpubls=;
 b=dM5xg/WiTZ/bEIPxZfCXzlr8u9KN5OnogEWii4HMSJoWTGSy52P5ItriHzYiGhaeVypBY4ExftoQNURngupzlN4bo498ANP2Eb02VZeEa4EKshvi3/o7XAObc4L5mxx+Go/mvZpHXBub+Nw6r48/vYlnsivZkuh8O/PCeQn49WE=
Received: from BN0PR04CA0173.namprd04.prod.outlook.com (2603:10b6:408:eb::28)
 by SJ5PPFCAF322559.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7cc) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 06:11:57 +0000
Received: from BN1PEPF00004687.namprd05.prod.outlook.com
 (2603:10b6:408:eb:cafe::db) by BN0PR04CA0173.outlook.office365.com
 (2603:10b6:408:eb::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Thu,
 30 Apr 2026 06:11:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN1PEPF00004687.mail.protection.outlook.com (10.167.243.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 30 Apr 2026 06:11:55 +0000
Received: from DLEE208.ent.ti.com (157.170.170.97) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Apr
 2026 01:11:54 -0500
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Apr
 2026 01:11:54 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 30 Apr 2026 01:11:54 -0500
Received: from uda1253387.dhcp.ti.com (uda1253387.dhcp.ti.com [172.24.233.12])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63U6BodZ509786;
	Thu, 30 Apr 2026 01:11:51 -0500
From: Rahul Sharma <r-sharma3@ti.com>
To: <r-sharma3@ti.com>
CC: <Frank.Li@kernel.org>, <dmaengine@vger.kernel.org>, <kristo@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<nm@ti.com>, <peter.ujfalusi@gmail.com>, <ssantosh@kernel.org>,
	<tglx@kernel.org>, <vkoul@kernel.org>
Subject: Re: [PATCH 0/2] Add runtime PM support to K3 UDMA and K3 INTA
Date: Thu, 30 Apr 2026 11:41:46 +0530
Message-ID: <20260430061146.349280-1-r-sharma3@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260429174904.4049243-1-r-sharma3@ti.com>
References: <20260429174904.4049243-1-r-sharma3@ti.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004687:EE_|SJ5PPFCAF322559:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a9564f8-8cc6-4037-6013-08dea67f6189
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|82310400026|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	SmQgItcKzT+YKLgQA1NxvsZQTpMuXTkIK4U7wjyV67wceGm9NF+znC5Xz4qQ5uPgBDrQsdOiiwrGyjrN8gjxFQYQQ7aJLSUA+R8oP+weN836qLHKW5UJ3j9XDFolv0bmNmoepaY6Aahr/1Mgj9tMsMvf1K3poNOlJCWUBNqZATGL1xzSt1p17Ol2rXcAN5PwWFzH1hBSF8Xjo6vMkSHcyo9tnOy+zszb9z3AumV4DGpQou8EkOdwlOnP+TqruZkRZeNzyxal+EJGDddWaRON3LhwfV397LyG6k2YcCaCbgHy9rZLyEDY8Xi18jpoQorZXc3J+c9+IXS3k2qd0NBZCetl6ccwmibD9MgfkO+oN4bYIgwYZqIlBJcyZXNALARc+c2c5OQcuif1HrjDK8x0bfFQuuj83FY9why9alj6r4TwukymhM14ZWpgKHUCGQAU/WvCTnCdGNssMPvsmMUiGNLcq4aIGM3PV3bWkLW1O4ggbnbQeIUVJgjysxlD4G/EOiybtmoDD/+UXUH6VO7W2LjeILoa3mAiDV3gZmzoxCn3lEbnOsCSiBRZSM3t7i17k0Qmzku5WtWep7i+atMp6elydb3vLwSWgJTMgrNQwexrT+Mf1hdqE5LJKtAR6XGCkZunonnbTFrWMU4PNqcgOlmMYgAVZeMuVQq34TT9Cj5sLOxfh+YMSyYkEN7EimWSHeSmb3tQ63Yf1+Dn02rYByWOmOloyEoN591l5mynaOO1Oo5u0bsagrIqevVBI+Pwzw3TYvwrjun5eN8zxgVyBA==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wAdlv712NjCFXCM9sdzTe40OhZhpJYOV09yJHcwyJeF3OSyzbVIT/K3ACAIGgWu+V3OrNaR+gd3oKWgckF0J7MVo4PObnJ5bmtdBUydBTE0UDUf2L8Mn2sOl8ZZlb1oRy6ECzlIFriaN4aeF6yDUR2XG8mNoPJnDqISIsHahMRTwWhUiCKpM8tUFtxtRdWexLj8uVlpRimMrFgCNYo6EnOJ9lGe2jKyX0d6dCAiJr8JdfK4SHbOBx4Uxv3m6lrl2U0AK8b1neWYL5gjzHO6uCIqzIsWRwuWvSlprcpX8cI0thA6yOB9GhKyS1HAFFkmXHhktSIYz5rxd6bL2u7X5gcWqTiMQr4u9OwiGe4bEfm8YEntYOuvXZjCCm2Kp4yenqJp68UeSbY8zTdjZmZ88u8wCT2iaLutQuCVZ4mmjaUlcmYFdB5GsTVdauDV4Am63
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 06:11:55.9479
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a9564f8-8cc6-4037-6013-08dea67f6189
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004687.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFCAF322559
X-Rspamd-Queue-Id: B0B7549DEA1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_SEVEN(0.00)[10];
	FROM_NEQ_ENVFROM(0.00)[r-sharma3@ti.com,dmaengine@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.infradead.org,ti.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-10198-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ti.com:dkim,ti.com:mid]

Hi,

This patch series consists of 2 different subsystems of Linux. But
they work together in same subsystem of SoC that is K3 DMSS(Data Movement
Subsystem).

Both patches can be merged to their respective trees, with no
inter-dependency. They have been posted together for the ease of review.

BR,
Rahul


