Return-Path: <dmaengine+bounces-7522-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9CBCABC84
	for <lists+dmaengine@lfdr.de>; Mon, 08 Dec 2025 03:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD93330358C2
	for <lists+dmaengine@lfdr.de>; Mon,  8 Dec 2025 01:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60E3259CBF;
	Mon,  8 Dec 2025 01:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="VYmAh2S3"
X-Original-To: dmaengine@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011046.outbound.protection.outlook.com [40.107.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DF9246770;
	Mon,  8 Dec 2025 01:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765159075; cv=fail; b=GUwbNpN1fPjQvgkkzL9A8uFoKNOKO4icgKrSaQnqJqj6GNHimzlqMMvDuWIxkkUDMjjbaAapiqCiVvHAVrz1Gtdm6WdzIe9g+qMINh8OBzAnCBUvf0O9oU+LhnHl5q347wZ9WuvWfgoCQAdiV4ME0ulnZF3Pa7JnDjxEc5aeWYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765159075; c=relaxed/simple;
	bh=YA1xT1j7oJnO0/b2xoZy4rr1qOT7Eb3ly7hWgtVRYII=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Ng+8MVYpA04Swyt7lJJ+xMs2EtV6VyDZROHZY72k/L3Jw32YegU1E1RjOKnOE1hItKSZMsBOU5qUMWAX9mdOAGszWtprjatmuNoEh4yf/xPZuEbHRckKN3dunZqm2LjN9hLz0BGq5YCmAXLgLn49a8p0qcpEBuHV3CS5XIWiSzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=VYmAh2S3; arc=fail smtp.client-ip=40.107.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S8el2ergvO2nzkJiPAUoatqaqdqnn/2K4lLuNooKVVDw8bEbhHMS2wmeUECLOpImT9oQYrz0v/P9jEKJe0WEHx0lDXecGZvflbPIhOxG19dDWS7teTGqTOJEl5zG8rvOYbfO+r+zUkzoC3cru/xFgG3epMqXkTerXmA+vw7oIl33aMOxNEcQlEnAujBHNjC/fTpeH59En+FRMm/drr+IgRrfA/hitH7KI7iIuywFkw+eP1QfpcM0XK2wzycuuMaydfYD52obWEz9nRm1R54Z2z3nsKMCHSmVfJSnYESgs7eS8MPoOpmaFmy0KmGNfW8/TP4I//DhkWpBMsdWxQwjOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o9cdUh3mItJC1WnIui3yYwmkq7Hx9dHX/GzdjCYq5ow=;
 b=pTJf3VAhzJfBJmmlKe5eA+8yn/t15ZKgoJRxs2/QoAesn56EYjsSrHwJAdk2q/HdcQH3wNcRSYJZvu8kDpsLSawz7IZ4qJT3OnEg6tlWX9kkGqCEFZnQd4dXvHNZ0Ml3/FesGUPawB2XTnCvRU+MFPG94TvZ0KCosBs8ySU0nKtEwdbWqktQ6ebsSgzFtDc2kdRMAtm6oG+NLYpLJ8RzBEdr156mkRVLBWEP6CoxsCgdvfvQovRlWYbOSU267FC6HGpwpKSnmAFQ7pjKNtmF+rexkqL1qnzWI0xd4uD99vmLUBOEgtVI4vY4AyvPG7pCnPoMPI3D/RUNN7VfnEsIdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9cdUh3mItJC1WnIui3yYwmkq7Hx9dHX/GzdjCYq5ow=;
 b=VYmAh2S3aixYCzPei5AN9BJOhRPrFD1VIrBlJLZMUHlj7Dgq6WJAB+Bl40qsSKAXjWwDATWMI/znOutlefv2z+3MKcURVx6lyOiAMbp0rQXkKj40yfGPFTw7Rz45D2b1qs0dmk1bBAB6O5ELsx4sgMTuaeZw7pKyteMXCqvv5HxA/HKpZ3mtLX46AdIZDzAD2YTbiynAYp0DcIZQCqFJWc84eGLVDB0vMub08QIVb5KuEAX1BMBKXiuI0iP4irpwgfC+s1HPnf9NVY/PFCMG0IE7+IhKABZ1uqBvCDMqKUQNcK6IYOg19f7xHstU7Isf06QwJvBiQv+A6KLGYupghg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS4PR03MB8447.namprd03.prod.outlook.com (2603:10b6:8:322::12)
 by SJ0PR03MB6341.namprd03.prod.outlook.com (2603:10b6:a03:38c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 01:57:51 +0000
Received: from DS4PR03MB8447.namprd03.prod.outlook.com
 ([fe80::4682:710e:536c:360a]) by DS4PR03MB8447.namprd03.prod.outlook.com
 ([fe80::4682:710e:536c:360a%2]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 01:57:51 +0000
From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
To: Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Subject: [PATCH v2 0/4] Add Agilex5 AXI DMA support
Date: Mon,  8 Dec 2025 09:57:41 +0800
Message-ID: <cover.1764927089.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0237.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::32) To DS4PR03MB8447.namprd03.prod.outlook.com
 (2603:10b6:8:322::12)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR03MB8447:EE_|SJ0PR03MB6341:EE_
X-MS-Office365-Filtering-Correlation-Id: c29a5134-57e9-4bac-b8e8-08de35fd31d8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dTFfuI3RRAXoHmuqFXZ+5TEzbSDpUCtV8LtBYrvstPGm2CsePT3op65nUKm+?=
 =?us-ascii?Q?hOHhBgiHzgV62PVbLX4TrYCRr8fq0eOU1HpZkwFbsAeiMybiFtHaT51V9Yqo?=
 =?us-ascii?Q?cCIKNTs1pil2SW+tm3XGgEsdmzCjTjqlBSYVvqaZy6RmnMt9rSFT9HSpdyWQ?=
 =?us-ascii?Q?yiNVjv/mqTqNDVeCxPTaIBUMO12rFTUxCeyZQp3WJPlqv93ia3BsIr4wk6Bi?=
 =?us-ascii?Q?7IMJppXpNK8ZDOUoOHnR6VF5eWbf3y2It8ZuE2bLRmFuA8Bf1rN33kbx3uHk?=
 =?us-ascii?Q?O0zqocJdl4eNdNd5b4Cj2M/Tvy3IxBG4T7vOZPxDoEqLYpgEy8jrp1LNts5z?=
 =?us-ascii?Q?/Xlkw3jku/1P6Q0MKsm+X7vcL1/xCuwccvAVbYJ0IxP3/ceJ3Z3HeRZoutEZ?=
 =?us-ascii?Q?uWaC3Zu6vTCRmI/Upk7hrASE0n7kYuxZm9g9GEw8fjCZIzEt1HzBYPoHtcjk?=
 =?us-ascii?Q?44pON7rPcDqA87YhXFljv8Z/LztyIJL4AOzJRUuUGAx6RZIAKvXxOAfxeET2?=
 =?us-ascii?Q?xB8B7u3HhKUh453uaZ/VMXiGhVr+cRX0ARtzlRKi1l8kxmajHtRjVLBz8N2m?=
 =?us-ascii?Q?U3a6qBRmyisWpxwcqtdP+sL/pCrdQbdDKMXMdSgdhaRWkvAyqG/spHgoL+6o?=
 =?us-ascii?Q?nFQ//TBoK8jGqPFIN97xGa2zI2BdT9jhMYkHdiFiE3bq89WmcxaAd7/djIi5?=
 =?us-ascii?Q?YlonKi6PLpJEX/ABbyNRdAbjXlqySjWFrbgN2w3IfBm31Qrov105hh0ZgY7Z?=
 =?us-ascii?Q?yMQj/B+S9H7106SpPsvYZ3njh0Pn9yr/K7PcjEGeZwgOapG2dhqai0h59nzI?=
 =?us-ascii?Q?I7Z91jnJdtr5D2H8nS4O7Gabk30gWBiZk/MyxCo7KyBJVh2p7ThF/00n8InK?=
 =?us-ascii?Q?61gAWGU2OSK+pqWdkEjpVotpjFeen6bAGdPB/SbWinWRsLemEWwwUWdJ/jY7?=
 =?us-ascii?Q?Hk5/hOczPVAikbUKbByDxs1MwjpYWZHUY7bk3r0T3l+N+S7UXa5K3Fiphgn9?=
 =?us-ascii?Q?ulmj67BEF2zNCImGBtdgFfYacao7rcAVvMpu8YDk/DnnoRBDpgpUGmfcdI1I?=
 =?us-ascii?Q?bPQBlRGQUSk/XEV3cOQE8PxVtaSJ3X9XmbbX9arNbqhXtvm0IImIRnPP4p6W?=
 =?us-ascii?Q?e/o756XnVzggdVlHkxIGOOGr/rmLUNCedoDidGcJKCcw6MK9ki+YNuFhH5DX?=
 =?us-ascii?Q?zZVTGFKKUi3jJYiHsInUKl+HMfg4PkW2pALsiAOAZFeQRTAQalz5SyZmAIE1?=
 =?us-ascii?Q?fPZfb7RvHYDT1UMPIuGzyNhcwrX7YwrjBNSEqOxeox1QTpMCgaZBa+iPoFxI?=
 =?us-ascii?Q?9e+hFoE+tvI64JQpEyn6CW5pEho7azfmMeUNbPbEHssYcrns3KqtsS4qIQoQ?=
 =?us-ascii?Q?qIAqXAsbM92cjCmS9s5tEflu+NF0cNBcOvrjq+JzdD7IRudxk7ciUZdVorPm?=
 =?us-ascii?Q?t4nI2/S0Cj3pURIlda9KGrKkLxj5Pkjcl2OMnMmIgBMu82RfLaH6+wqqpVcj?=
 =?us-ascii?Q?OnbM9l2WRdQQTdIPPwdJvE/24GsuUeQasMA4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR03MB8447.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?97v6DvRfHGgbospRgCItFQ1wJ+ReauAE+06mypTYxG2j43W2KPPtKIOVVf2s?=
 =?us-ascii?Q?Mytc0zGPvo+mnY1WCROpadO+f/FbOtiRWFvpzI7anPnHalTBmc0zVCQhM/J8?=
 =?us-ascii?Q?mOSF9IkQcWXAeKVl7tfdF0ORcgP9G4SL2P2DBqdlOtlXAi0/TFm5mnSP4C34?=
 =?us-ascii?Q?ClpDRNIYL4JFdrczaskkx5m7X1DivHyBYmTaknrxpwVpSO1aCTGomWCWccrL?=
 =?us-ascii?Q?ELDeTJlozVbI1q8cTRa3diwRttpmxmF0vXMvZ8snOVaIpUkCb15aeOyXIupE?=
 =?us-ascii?Q?Kw+GZtvE0UKpQKF9SfJBFFQAd1/e6JY91GKgzjAu/9KDz5RFxS4NC3gVj88j?=
 =?us-ascii?Q?cMzz/qQgxHGopZP4HqmG0KbSBV5ePD+jolgJL9ya6ZushPhpefeovehlOjrg?=
 =?us-ascii?Q?rtCcsvvhooqgIfbZT97SfQ4B/wsU9NpyhNMfw7ZUv2gPiRJ+cm/FyqnqsPz4?=
 =?us-ascii?Q?8dYggj2YnMCZGAS3FAB1Ji4fDZJqJ6+zORIqhM8jYMCqw6pmkcRU5imghEUG?=
 =?us-ascii?Q?l1XnXuwwaeT7GpdvSWSTAN0sHFqt7xpB1AlvyeT6mQ/n5vgyXdhCrZ6sPO//?=
 =?us-ascii?Q?9gvcvVxRidUXWjTwRfbm8xwE6ihpaZpa31QJw70moZsplEW8YLNOb64nfPlK?=
 =?us-ascii?Q?EaorWy6HUPReHVxNOha//8Guto0Yn93vcmaz6ySFVstafsnUtcUYAjpbTjsh?=
 =?us-ascii?Q?zgrIDA0tz1MLDoJECrVfVQ7+6M0RQ7FwaPTevjiGTRBU9rRXA03RKGssaA3K?=
 =?us-ascii?Q?HD+WPHHnDxgaW4O1I67GEDUcvJBip+R/p3x1Db30P3EIgoxUHK/0jscyRHKu?=
 =?us-ascii?Q?78yCG3bh4cwhhvjjMSdo0TpFuF5w6KLclpJlBUBH2sjF7WES+OtU9xuW+Uvm?=
 =?us-ascii?Q?LbdxbcRFVMebuAbkgX19tPty/aUx3HQV1gnYUzK2Aa+C78g4XusGEFRLLXX9?=
 =?us-ascii?Q?Q5yNu9+4MnsH+6ZtYb5fKTH2yPo11bsKoT5H3vGNV0auY/1QumxRUclBa2mR?=
 =?us-ascii?Q?3G0RVHVNK+uglDMTcBpEHwsVDIHstGYSx62XfZIWVXAlx+/vradE0IVljxPs?=
 =?us-ascii?Q?50MBma7ZhrVaTUky8SGhpDgdjcAyI6lYwIaQ1rjAZ25YhRVZ6tC+nKxQjF5+?=
 =?us-ascii?Q?OVewTVCRXcLXzf92rbjAFNv7rVYB8ky9eooKyBZTd5w4bCLH2Up5qC7272qH?=
 =?us-ascii?Q?2lnGBOr8bxLIzQ5JLr/Eor2JmQ9keYe4tRRYs5CRNOtxpH1zHk0UnG5fEx0e?=
 =?us-ascii?Q?chcvJI59qZkmcG60L4ZxbnC06sX77auOxLhFO8C95LGSRrAtD7jxKB7ISki8?=
 =?us-ascii?Q?H0BY9HDyyNYAMg9fvnYZ09i5+8Oe0pMOcdh47llBRskxvwa0srknd9LtYX7/?=
 =?us-ascii?Q?C0pLeSAUNg1Nmjf6stqBlvqy0a6dVhwLdMUAODypW148u91ak71dYtDX1qok?=
 =?us-ascii?Q?swYZREbqKFThFXxznZsiXUuH0q2JYi+KHIrHRrVUUhI9DCaMtjI6kAcmxkZT?=
 =?us-ascii?Q?UZtzU0mvSr1TpcZDW1nCp7SY9Dl/zxyAcgAhEffAFgKQDaSCCWuwgpyQbCoe?=
 =?us-ascii?Q?7kZ2dRfw2RqDfFebrjA3EQQOHuFXRxSD7Qj0TE92eGXfbiH2n55CeLO9I8ru?=
 =?us-ascii?Q?9A=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c29a5134-57e9-4bac-b8e8-08de35fd31d8
X-MS-Exchange-CrossTenant-AuthSource: DS4PR03MB8447.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 01:57:51.4996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cFbn1JVrvRjKqEzWI7CAnUlXtmWWEBMg9W3c0+8yMHQlSsrTT2Lb271EkndJhTLelZATgJBfy8xS3r6BExyk9B6dwxwjpXWDsneobabLqd0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6341

This series introduces support for Agilex5 SoC in the Synopsys DesignWare
AXI DMA binding and updates the device tree to use the platform-specific
compatible string.

The Agilex5 only has 40-bit DMA addressable bit instead of 64-bit. Hence,
this specific addition will enable driver to handle this limitation.

---
Notes:
This patch series is applied on socfpga maintainer's tree
https://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git/log/?h=socfpga_dts_for_v6.19

Changes in v2:
	- Add dma-ranges property.
	- Add address-cells and size-cells due to warning when dma-ranges
	  is define without address-cells and size-cells present. Also
	  prevent kernel panic if address-cells and size-cells are not
	  defined.
	- Add driver support to handle defined properties and set the DMA
	  BIT MASK according to value from DT.
	- Rename "arm64: dts: agilex5: Use platform-specific compatible for
          AXI DMA" to "arm64: dts: intel: agilex5: Add dma-ranges and
          address cells to dma node"

This changes is validated on:
	- intel/socfpga_agilex5_socdk.dtb
	- snps,dw-axi-dmac.yaml
	- snps,dw-axi-dmac.yaml intel/socfpga_agilex5_socdk.dtb
	- Agilex5 devkit
---
Khairul Anuar Romli (4):
  dt-bindings: dma: snps,dw-axi-dmac: Add compatible string for Agilex5
  dt-bindings: dma: snps,dw-axi-dmac: Add #address-cells and #size-cells
  arm64: dts: intel: agilex5: Add dma-ranges and address cells to dma
    node
  dma: dw-axi-dmac: Add support for Agilex5 and dynamic bus width

 .../bindings/dma/snps,dw-axi-dmac.yaml        | 33 ++++++++--
 .../arm64/boot/dts/intel/socfpga_agilex5.dtsi | 12 +++-
 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 63 ++++++++++++++++++-
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  1 +
 4 files changed, 101 insertions(+), 8 deletions(-)

-- 
2.43.7


