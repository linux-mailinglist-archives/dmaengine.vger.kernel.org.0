Return-Path: <dmaengine+bounces-7407-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C92C9431C
	for <lists+dmaengine@lfdr.de>; Sat, 29 Nov 2025 17:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35CC93AEF27
	for <lists+dmaengine@lfdr.de>; Sat, 29 Nov 2025 16:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0750E31961C;
	Sat, 29 Nov 2025 16:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="X5ylzwYP"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011045.outbound.protection.outlook.com [52.101.125.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB6230F7EF;
	Sat, 29 Nov 2025 16:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764432293; cv=fail; b=Tz0tQa4tkLkzdlvzS29GwHAQUNnj6FbKeRzL7xzYUSB8jP1+vEhNbgSqXNIemblkxiyi7vb0UP/kkwwTTnC0HFSmiyYjngzmTUhui36iTW/jmxUMJ78Ja6pOtoyGR+weCQi0oXt7lmym/N9fKb0Ti4GSBkyqCTJ7AaATqf7puc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764432293; c=relaxed/simple;
	bh=xKI983WUU7e69VPRmJkbnJOViYhTKyJsdHVjNaFYh0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G1k0G7YSkXlKui3zmhbS6N0fkK0zc9pKWrrmnFaeSYQ5LAckSYkAT0oDOchzGRsQhMyV5n8YHMGl2InTFaH4/7T/auW28kQPS/LpUtIGF8OcqOzHLw9NZ1P5v5fUBYO1miQcI3l27rjH+Z0RT3t0eABdTh1xud9hFV+fIZr53XI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=X5ylzwYP; arc=fail smtp.client-ip=52.101.125.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cxJb1TZ8JBMWz3PBpGLjoYVeE4zx3OpxXShKqc1BHffKMsjRIcUm0ikIPI4GBuBY2BpYStwSrl6gxaWRJuPShkTcpZnVoLclQzVwOFEGo010AVAHGmKyDHHh4wUCkEHaIa27Vq6WUnde7KDubsxYxVf+hqzb3Xl0LS6JZ7UNr54LVvHBMaerqYJaFYtyC0aLgIpjcqAqbleX3mmhA54XHZqjlXBgIP/2g0InyGo+yRbx3Sanb8hXf8ycqcvQT7vw6Td6b2nBlGJCK/wjpFEwTJ+V2DBtis5lI0vkRICFqlv3jDGZQNZJyTAYWjtArmCBOIYXTyEi0skCcduR0kjFRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aWYpOjTdNqmKMBAppFdVWLFUF4BFB/B3fEJNoJSEFew=;
 b=UmUiwKji/VeMjUwkAt+OYikAW6y01/jJevVQnunNEE0CPxlESV0x4Ox4vr18Ks+yq8todJRjOmlN405XP060g3inv4ZgQBip4KD67lsYivFVmfc+VIaAHxpH4KJmPx34GzS+1AHT9PwfN0st06/7UhFoO0voh9As0lLij+X/bnXQxLyclSqO/pVWXUurt5YgGA6Fnjd9R48+rm26pkgt7OuzsE3YYt1sb9IXiyne6hrnv05li7NJlNTRQGXcbUT6aH3hcBdeC3K0fPfd1JmIk97Vj8dyhjF5AWISMNEpiQlI4SUwRgRhnbDucazMwMWTH2Gfa+izrnLmz2i81/Vx6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aWYpOjTdNqmKMBAppFdVWLFUF4BFB/B3fEJNoJSEFew=;
 b=X5ylzwYPfgVDgIPSe+AJp1ngguoBQKLDvJCmydQPtQ8BmIX1+DCDi8QPwbUdk9J6c4nLfgbaY6sxpNa/qqdOpRJVulvG1vt3QmAwWbPuK9kuM4ImrHoySsndUChvJ14GnSkgRtA2qZg22rvvy4l56F9ejKGwPjF33X1+XH6LPsg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by OS9P286MB4684.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2fa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sat, 29 Nov
 2025 16:04:41 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9366.012; Sat, 29 Nov 2025
 16:04:41 +0000
From: Koichiro Den <den@valinux.co.jp>
To: ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Frank.Li@nxp.com
Cc: mani@kernel.org,
	kwilczynski@kernel.org,
	kishon@kernel.org,
	bhelgaas@google.com,
	corbet@lwn.net,
	vkoul@kernel.org,
	jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	Basavaraj.Natikar@amd.com,
	Shyam-sundar.S-k@amd.com,
	kurt.schwemmer@microsemi.com,
	logang@deltatee.com,
	jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	robh@kernel.org,
	jbrunet@baylibre.com,
	fancer.lancer@gmail.com,
	arnd@arndb.de,
	pstanner@redhat.com,
	elfring@users.sourceforge.net
Subject: [RFC PATCH v2 22/27] ntb_netdev: Multi-queue support
Date: Sun, 30 Nov 2025 01:04:00 +0900
Message-ID: <20251129160405.2568284-23-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251129160405.2568284-1-den@valinux.co.jp>
References: <20251129160405.2568284-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0073.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7d::11) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|OS9P286MB4684:EE_
X-MS-Office365-Filtering-Correlation-Id: c0f1f13c-86b5-486c-1bba-08de2f610151
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W637mZ5i2EYTyldOgKSqzwRn22P10VO9SxdrLs/t/glc7Dmt8EIyN91oq9ch?=
 =?us-ascii?Q?ahW/ATXWhixxI1dBxznMAZNlfn6nF/3TN3l0+JyxfYuVEabSt8fBj6ExIRIH?=
 =?us-ascii?Q?9tyJMuiAI7kEzGjEAjPb6mAdqmhF1dZB7WF4yc/lajSThjJun12tTSgivpWi?=
 =?us-ascii?Q?7UgnME1N8Sx/+imRP5GFEtHog7WHvJuJiaLUN+xEr4KWbai6VH45UxxS8OA0?=
 =?us-ascii?Q?Y8hrEtAjywGLgWfY6yMmlb1BN2DkyE1LWFNfjz+Y9HYg39hhv+1fA+dVsYcG?=
 =?us-ascii?Q?2idayX1NCEGQ8gZFcmQIjsGAO45Mkcu4jSRVDgXPyyd01IqwWKJAxSm+vDth?=
 =?us-ascii?Q?SiZDrV1OnmwrjK2OZRvvu0JWcDkMwqpo7jDOouUXZJbu9q+oebVFCz1CjHI+?=
 =?us-ascii?Q?b6AyAXHslVF/oNFfZVhR4a5GtiLTL555nUXppahn3zkOgx3l/5CEDPnL1vBE?=
 =?us-ascii?Q?9E3NUekfblYwFN8J+jiAKQq2IWsf5hmdEknc4r1LXRZF9dhTMHNN3JeIpq2D?=
 =?us-ascii?Q?EOm0v+OoF0yC5eFoIRK/gRIXvVh6ABIYHxdUq4iqZxrIVuH3ESiGAQyn7GMP?=
 =?us-ascii?Q?zF7lrLzPhJbv1Csl6676nohIO0TUZV856DToPVc7RTIf4LdlX65pHlTeCm9e?=
 =?us-ascii?Q?tS96PNGoRX5b5AvRN/pXjS7MbBd5zsql66e6t1pF9zlFG3RFSZAvR69vNgaj?=
 =?us-ascii?Q?FrSE8p3e1HEmC1k77F0jaDM9tQ/yQrWBWuX34xMa/F1aa4fMhIfMOpA0Lcpe?=
 =?us-ascii?Q?QpsAkUrfemQl1iVriM0aeTJJzjC0iXx350uOrVXmvRVWREmGJ4igEQM9ls07?=
 =?us-ascii?Q?u5d+4RzW89S28CoEJ0diyoXGGTJMmvbjkMB8KZi0+UdjoW1UBZVgME61GzyH?=
 =?us-ascii?Q?jYvz5ozAkz5sznGYOy7kNxFDU7XGJo3gGHb305evXKF4NZhVIC+v85R+u+j1?=
 =?us-ascii?Q?k8Q2FmH8q2qEEFZHXhLsV7OOHRj02gSLvG/Lg/mWPGiTkqSQrvouaZVcFjRk?=
 =?us-ascii?Q?lnapZQcoAX4a8aVDLQwqLTuGq5l58UHo7uSEXNtEbwwHEHG9Mq6CQXHV+6Mu?=
 =?us-ascii?Q?uGu5UUjgdjwDjmL6KJ7dHe6RyAa02Tero3yQoB3pYZGSJCLubnT0kse5QaOg?=
 =?us-ascii?Q?jcJZe8QF27GUJGXX7xT5rL1eJpvgGnTeIUHKFTM3ghT46XAoh9anKvqX1nh/?=
 =?us-ascii?Q?yQGHVGK66EyIzO993I3ahcy4U/NbioZyCdDpm29ma3rMeKGB1HK36PQQ2BLv?=
 =?us-ascii?Q?UW0HzGTik9BzOu36ALOBvSGp22VH0Bs+FVuiyTikAupSwkvjr6P1bc7kj+Tf?=
 =?us-ascii?Q?6TIFN4iez3Jq/Y+V7gWcWCSnIoTFRctONZJdF52rX3Rg0WquL4Exgd6IJU9d?=
 =?us-ascii?Q?pNajqA9Crk0hL0JT3qVY3W1rnvGvvXTnEui+6WaoaVgLPwC5Q3lyrEeLnj1L?=
 =?us-ascii?Q?pcT2ieaC+n/dQTELKpDYbQrJQzNhfxks?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NoxqeO4O0pHNaPGIkcAtRTbggokc/eLLsW01vc9sP1YQXhWMnEZ24T0sGJrh?=
 =?us-ascii?Q?CbXYo8ixxJUVufOuxgILvNNAONxWr+bg8fufpPoU93SuD2Qwuw1OUQScPcJD?=
 =?us-ascii?Q?sUgYERk0ojDf0EuoQ0YFoJdcsVMsmUhJV2O4h3RFfig3tZ3sx2CtDXQ1iHxW?=
 =?us-ascii?Q?pRgYcquTOoAi3dDlFOnhvz24NyqKN5hk+arTM8kK3aOabZ4tb6OClS4Iy+KS?=
 =?us-ascii?Q?lujssU/fj1qqDOt7lsQBQiZrAyd5mp30/eC1V3KXcjVutDw7DnWZ3y1rQdiE?=
 =?us-ascii?Q?SHUz3rXXkPsdeD8U4qz4Pi3wQrp9Vmv2wyxVVmFxgE730TpoAGlOXAQFC92m?=
 =?us-ascii?Q?WsRbt1428RXHSY0sDG2Hni/wd3gyDoGAe3t36r6T69/+uKupeeK7WeU3AwJ3?=
 =?us-ascii?Q?46geaVVeeBTitOrWYnwsBfa4Vx6Lr6yTd6Q5qrbFYUUKeouQRDcWxcY3eq7h?=
 =?us-ascii?Q?2dmetXUQ6AF/sUcZZQOn+yMSALrlrGh1/Z6qOr5mpFufrOH+ZGmuCvxT0us3?=
 =?us-ascii?Q?Z9njiu2bjQ3MEAtox1R2u2IbVuT+PT5tsy3keXEx9aGrijW2/a9anJAO24B7?=
 =?us-ascii?Q?BNbduEpTipDGK71QeWoqjf8Kp/iF4sluMilNWqRGEKWPRtoU0PsWlU1qx0N7?=
 =?us-ascii?Q?+yvpY97JKr8OqDqf70RKD1t8qBQSuKOVT8+7a/5nzjEQZ/v3DCGUKUI2xz95?=
 =?us-ascii?Q?75SGjuHBOW6efRhQIqcvYkv58Oa4dmgtIUve6zTFc1TKfxsolOIStrPAVVIN?=
 =?us-ascii?Q?nK1SoInemfIRNLi5URAnSGZHpkBMKD8zRhEToYTSR/oZL9jAHYnlUVSomnCl?=
 =?us-ascii?Q?tIhOO1UVxzOoff4qdCSupMDBV9z4xkM1ho6kBrf2dXcsdzheG5qN96MdYHM9?=
 =?us-ascii?Q?MfidsmxGaIdTUJFOicnywsJ+jVvPHdrcAnQ3YzgSi05R5Q4lvPUedy/UpUcC?=
 =?us-ascii?Q?HF26hgbJRmYRhvJATnc91opyl8tKKL3Rly+0HKtkGEJ05LvoKboMjp+S/aWo?=
 =?us-ascii?Q?5B+OWRv21e+pv/5PuzkPwCVUymEz+rchXeGvg7yCCn44k2wa88HS2ZVhfXPq?=
 =?us-ascii?Q?PP82sqFgOqd9x8CANuJ6eyIhxOcDKw9SeK0inzoJpGvf76E2QoM2Gv32or6o?=
 =?us-ascii?Q?mI143oLh6I4lave0bldF9ArjNrxpPuikDeWVDUenQnZlgDE1k1q8e1MGcliN?=
 =?us-ascii?Q?CHOVKovBkRU3Jbbx86yNxpCTR2RFlxprYvapBI+TE7+JMdeL/AUlnMLIbh30?=
 =?us-ascii?Q?Mdnk2O7XCbX3XUmXCAS8K7GqNAA5i0/NVpP98t9zvPUybcIwthkDZyyvJeZV?=
 =?us-ascii?Q?IuqNC3xQULPeDApN3HbzfnleuOA/tNqSj8SLb5YiKu/i1iRx70Kv69EMV+XG?=
 =?us-ascii?Q?m54C8fjfFTLDvOH2B/nqbD/SNelvLvX4qN3ts3KjmW9bXim5dK/SVwTM9oqC?=
 =?us-ascii?Q?NSAAXKk6f19NBhJJuZ762aRondSaZ+qnGZiSCTck1TGNzi5sbPEcXZIe6o54?=
 =?us-ascii?Q?7iHxCEe3Qu/zkmNfe7POjE5CiCuza2CWSLzI0m67yUcmfgDp+qsOLoqG7KCB?=
 =?us-ascii?Q?mut7tdFWCQUf80K+sa4ou6a2EuIuxL0NLBCY+VDrlARSxbYFP1Py2AmlTEIQ?=
 =?us-ascii?Q?5tOnAnAkmqYbI4LsRmL0H7c=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: c0f1f13c-86b5-486c-1bba-08de2f610151
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2025 16:04:41.4389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gixmMVIUMvNIkCMm4UqCfbD+SaAvrqpNeuQRJ2M91lVtQ9KgnH4D2BEF3pzl+64lGpq5wrZyptLkS9MtpchVMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB4684

ntb_transport can now scale throughput across multiple queue pairs when
remote eDMA is enabled on ntb_transport (use_remote_edma=1).

Teach ntb_netdev to allocate multiple ntb_transport queue pairs and
expose them as a multi-queue net_device. In particular, when remote eDMA
is enabled, each queue pair can be serviced in parallel by the eDMA
engine.

With this patch, up to N queue pairs are created, where N is chosen as
follows:

  - By default, N is num_online_cpus(), to give each CPU its own queue.
  - If the ntb_num_queues module parameter is non-zero, it overrides the
    default and requests that many queues.
  - In both cases the requested value is capped at a fixed upper bound
    to avoid unbounded allocations, and by the number of queue pairs
    actually available from ntb_transport.

If only one queue pair can be created (or ntb_num_queues=1 is set), the
driver effectively falls back to the previous single-queue behaviour.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/net/ntb_netdev.c | 341 ++++++++++++++++++++++++++++-----------
 1 file changed, 243 insertions(+), 98 deletions(-)

diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
index fbeae05817e9..7aeca35b46c5 100644
--- a/drivers/net/ntb_netdev.c
+++ b/drivers/net/ntb_netdev.c
@@ -53,6 +53,8 @@
 #include <linux/pci.h>
 #include <linux/ntb.h>
 #include <linux/ntb_transport.h>
+#include <linux/cpumask.h>
+#include <linux/slab.h>
 
 #define NTB_NETDEV_VER	"0.7"
 
@@ -70,26 +72,84 @@ static unsigned int tx_start = 10;
 /* Number of descriptors still available before stop upper layer tx */
 static unsigned int tx_stop = 5;
 
+/*
+ * Upper bound on how many queue pairs we will try to create even if
+ * ntb_num_queues or num_online_cpus() is very large. This is an
+ * arbitrary safety cap to avoid unbounded allocations.
+ */
+#define NTB_NETDEV_MAX_QUEUES  64
+
+/*
+ * ntb_num_queues == 0 (default) means:
+ *   - use num_online_cpus() as the desired queue count, capped by
+ *     NTB_NETDEV_MAX_QUEUES.
+ * ntb_num_queues > 0:
+ *   - try to create exactly ntb_num_queues queue pairs (again capped
+ *     by NTB_NETDEV_MAX_QUEUES), but fall back to the number of queue
+ *     pairs actually available from ntb_transport.
+ */
+static unsigned int ntb_num_queues;
+module_param(ntb_num_queues, uint, 0644);
+MODULE_PARM_DESC(ntb_num_queues,
+		 "Number of NTB netdev queue pairs to use (0 = per-CPU)");
+
+struct ntb_netdev;
+
+struct ntb_netdev_queue {
+	struct ntb_netdev *ntdev;
+	struct ntb_transport_qp *qp;
+	struct timer_list tx_timer;
+	u16 qid;
+};
+
 struct ntb_netdev {
 	struct pci_dev *pdev;
 	struct net_device *ndev;
-	struct ntb_transport_qp *qp;
-	struct timer_list tx_timer;
+	unsigned int num_queues;
+	struct ntb_netdev_queue *queues;
 };
 
 #define	NTB_TX_TIMEOUT_MS	1000
 #define	NTB_RXQ_SIZE		100
 
+static unsigned int ntb_netdev_default_queues(void)
+{
+	unsigned int n;
+
+	if (ntb_num_queues)
+		n = ntb_num_queues;
+	else
+		n = num_online_cpus();
+
+	if (!n)
+		n = 1;
+
+	if (n > NTB_NETDEV_MAX_QUEUES)
+		n = NTB_NETDEV_MAX_QUEUES;
+
+	return n;
+}
+
 static void ntb_netdev_event_handler(void *data, int link_is_up)
 {
-	struct net_device *ndev = data;
-	struct ntb_netdev *dev = netdev_priv(ndev);
+	struct ntb_netdev_queue *q = data;
+	struct ntb_netdev *dev = q->ntdev;
+	struct net_device *ndev = dev->ndev;
+	bool any_up = false;
+	unsigned int i;
 
-	netdev_dbg(ndev, "Event %x, Link %x\n", link_is_up,
-		   ntb_transport_link_query(dev->qp));
+	netdev_dbg(ndev, "Event %x, Link %x, qp %u\n", link_is_up,
+		   ntb_transport_link_query(q->qp), q->qid);
 
 	if (link_is_up) {
-		if (ntb_transport_link_query(dev->qp))
+		for (i = 0; i < dev->num_queues; i++) {
+			if (ntb_transport_link_query(dev->queues[i].qp)) {
+				any_up = true;
+				break;
+			}
+		}
+
+		if (any_up)
 			netif_carrier_on(ndev);
 	} else {
 		netif_carrier_off(ndev);
@@ -99,7 +159,9 @@ static void ntb_netdev_event_handler(void *data, int link_is_up)
 static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
 				  void *data, int len)
 {
-	struct net_device *ndev = qp_data;
+	struct ntb_netdev_queue *q = qp_data;
+	struct ntb_netdev *dev = q->ntdev;
+	struct net_device *ndev = dev->ndev;
 	struct sk_buff *skb;
 	int rc;
 
@@ -135,7 +197,8 @@ static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
 	}
 
 enqueue_again:
-	rc = ntb_transport_rx_enqueue(qp, skb, skb->data, ndev->mtu + ETH_HLEN);
+	rc = ntb_transport_rx_enqueue(q->qp, skb, skb->data,
+				      ndev->mtu + ETH_HLEN);
 	if (rc) {
 		dev_kfree_skb_any(skb);
 		ndev->stats.rx_errors++;
@@ -143,42 +206,37 @@ static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
 	}
 }
 
-static int __ntb_netdev_maybe_stop_tx(struct net_device *netdev,
-				      struct ntb_transport_qp *qp, int size)
+static int ntb_netdev_maybe_stop_tx(struct ntb_netdev_queue *q, int size)
 {
-	struct ntb_netdev *dev = netdev_priv(netdev);
+	struct net_device *ndev = q->ntdev->ndev;
+
+	if (ntb_transport_tx_free_entry(q->qp) >= size)
+		return 0;
+
+	netif_stop_subqueue(ndev, q->qid);
 
-	netif_stop_queue(netdev);
 	/* Make sure to see the latest value of ntb_transport_tx_free_entry()
 	 * since the queue was last started.
 	 */
 	smp_mb();
 
-	if (likely(ntb_transport_tx_free_entry(qp) < size)) {
-		mod_timer(&dev->tx_timer, jiffies + usecs_to_jiffies(tx_time));
+	if (likely(ntb_transport_tx_free_entry(q->qp) < size)) {
+		mod_timer(&q->tx_timer, jiffies + usecs_to_jiffies(tx_time));
 		return -EBUSY;
 	}
 
-	netif_start_queue(netdev);
-	return 0;
-}
-
-static int ntb_netdev_maybe_stop_tx(struct net_device *ndev,
-				    struct ntb_transport_qp *qp, int size)
-{
-	if (netif_queue_stopped(ndev) ||
-	    (ntb_transport_tx_free_entry(qp) >= size))
-		return 0;
+	netif_wake_subqueue(ndev, q->qid);
 
-	return __ntb_netdev_maybe_stop_tx(ndev, qp, size);
+	return 0;
 }
 
 static void ntb_netdev_tx_handler(struct ntb_transport_qp *qp, void *qp_data,
 				  void *data, int len)
 {
-	struct net_device *ndev = qp_data;
+	struct ntb_netdev_queue *q = qp_data;
+	struct ntb_netdev *dev = q->ntdev;
+	struct net_device *ndev = dev->ndev;
 	struct sk_buff *skb;
-	struct ntb_netdev *dev = netdev_priv(ndev);
 
 	skb = data;
 	if (!skb || !ndev)
@@ -194,13 +252,12 @@ static void ntb_netdev_tx_handler(struct ntb_transport_qp *qp, void *qp_data,
 
 	dev_kfree_skb_any(skb);
 
-	if (ntb_transport_tx_free_entry(dev->qp) >= tx_start) {
+	if (ntb_transport_tx_free_entry(qp) >= tx_start) {
 		/* Make sure anybody stopping the queue after this sees the new
 		 * value of ntb_transport_tx_free_entry()
 		 */
 		smp_mb();
-		if (netif_queue_stopped(ndev))
-			netif_wake_queue(ndev);
+		netif_wake_subqueue(ndev, q->qid);
 	}
 }
 
@@ -208,16 +265,26 @@ static netdev_tx_t ntb_netdev_start_xmit(struct sk_buff *skb,
 					 struct net_device *ndev)
 {
 	struct ntb_netdev *dev = netdev_priv(ndev);
+	u16 qid = skb_get_queue_mapping(skb);
+	struct ntb_netdev_queue *q;
 	int rc;
 
-	ntb_netdev_maybe_stop_tx(ndev, dev->qp, tx_stop);
+	if (unlikely(!dev->num_queues))
+		goto err;
+
+	if (unlikely(qid >= dev->num_queues))
+		qid = qid % dev->num_queues;
 
-	rc = ntb_transport_tx_enqueue(dev->qp, skb, skb->data, skb->len);
+	q = &dev->queues[qid];
+
+	ntb_netdev_maybe_stop_tx(q, tx_stop);
+
+	rc = ntb_transport_tx_enqueue(q->qp, skb, skb->data, skb->len);
 	if (rc)
 		goto err;
 
 	/* check for next submit */
-	ntb_netdev_maybe_stop_tx(ndev, dev->qp, tx_stop);
+	ntb_netdev_maybe_stop_tx(q, tx_stop);
 
 	return NETDEV_TX_OK;
 
@@ -229,80 +296,103 @@ static netdev_tx_t ntb_netdev_start_xmit(struct sk_buff *skb,
 
 static void ntb_netdev_tx_timer(struct timer_list *t)
 {
-	struct ntb_netdev *dev = timer_container_of(dev, t, tx_timer);
+	struct ntb_netdev_queue *q = container_of(t, struct ntb_netdev_queue, tx_timer);
+	struct ntb_netdev *dev = q->ntdev;
 	struct net_device *ndev = dev->ndev;
 
-	if (ntb_transport_tx_free_entry(dev->qp) < tx_stop) {
-		mod_timer(&dev->tx_timer, jiffies + usecs_to_jiffies(tx_time));
+	if (ntb_transport_tx_free_entry(q->qp) < tx_stop) {
+		mod_timer(&q->tx_timer, jiffies + usecs_to_jiffies(tx_time));
 	} else {
-		/* Make sure anybody stopping the queue after this sees the new
+		/*
+		 * Make sure anybody stopping the queue after this sees the new
 		 * value of ntb_transport_tx_free_entry()
 		 */
 		smp_mb();
-		if (netif_queue_stopped(ndev))
-			netif_wake_queue(ndev);
+		netif_wake_subqueue(ndev, q->qid);
 	}
 }
 
 static int ntb_netdev_open(struct net_device *ndev)
 {
 	struct ntb_netdev *dev = netdev_priv(ndev);
+	struct ntb_netdev_queue *queue;
 	struct sk_buff *skb;
-	int rc, i, len;
-
-	/* Add some empty rx bufs */
-	for (i = 0; i < NTB_RXQ_SIZE; i++) {
-		skb = netdev_alloc_skb(ndev, ndev->mtu + ETH_HLEN);
-		if (!skb) {
-			rc = -ENOMEM;
-			goto err;
-		}
+	int rc = 0, i, len;
+	unsigned int q;
 
-		rc = ntb_transport_rx_enqueue(dev->qp, skb, skb->data,
-					      ndev->mtu + ETH_HLEN);
-		if (rc) {
-			dev_kfree_skb(skb);
-			goto err;
+	/* Add some empty rx bufs for each queue */
+	for (q = 0; q < dev->num_queues; q++) {
+		queue = &dev->queues[q];
+
+		for (i = 0; i < NTB_RXQ_SIZE; i++) {
+			skb = netdev_alloc_skb(ndev, ndev->mtu + ETH_HLEN);
+			if (!skb) {
+				rc = -ENOMEM;
+				goto err;
+			}
+
+			rc = ntb_transport_rx_enqueue(queue->qp, skb, skb->data,
+						      ndev->mtu + ETH_HLEN);
+			if (rc) {
+				dev_kfree_skb(skb);
+				goto err;
+			}
 		}
-	}
 
-	timer_setup(&dev->tx_timer, ntb_netdev_tx_timer, 0);
+		timer_setup(&queue->tx_timer, ntb_netdev_tx_timer, 0);
+	}
 
 	netif_carrier_off(ndev);
-	ntb_transport_link_up(dev->qp);
-	netif_start_queue(ndev);
+
+	for (q = 0; q < dev->num_queues; q++)
+		ntb_transport_link_up(dev->queues[q].qp);
+
+	netif_tx_start_all_queues(ndev);
 
 	return 0;
 
 err:
-	while ((skb = ntb_transport_rx_remove(dev->qp, &len)))
-		dev_kfree_skb(skb);
+	for (q = 0; q < dev->num_queues; q++) {
+		queue = &dev->queues[q];
+
+		while ((skb = ntb_transport_rx_remove(queue->qp, &len)))
+			dev_kfree_skb(skb);
+	}
 	return rc;
 }
 
 static int ntb_netdev_close(struct net_device *ndev)
 {
 	struct ntb_netdev *dev = netdev_priv(ndev);
+	struct ntb_netdev_queue *queue;
 	struct sk_buff *skb;
+	unsigned int q;
 	int len;
 
-	ntb_transport_link_down(dev->qp);
+	netif_tx_stop_all_queues(ndev);
+
+	for (q = 0; q < dev->num_queues; q++) {
+		queue = &dev->queues[q];
 
-	while ((skb = ntb_transport_rx_remove(dev->qp, &len)))
-		dev_kfree_skb(skb);
+		ntb_transport_link_down(queue->qp);
 
-	timer_delete_sync(&dev->tx_timer);
+		while ((skb = ntb_transport_rx_remove(queue->qp, &len)))
+			dev_kfree_skb(skb);
 
+		timer_delete_sync(&queue->tx_timer);
+	}
 	return 0;
 }
 
 static int ntb_netdev_change_mtu(struct net_device *ndev, int new_mtu)
 {
 	struct ntb_netdev *dev = netdev_priv(ndev);
+	struct ntb_netdev_queue *queue;
 	struct sk_buff *skb;
-	int len, rc;
+	unsigned int q, i;
+	int len, rc = 0;
 
-	if (new_mtu > ntb_transport_max_size(dev->qp) - ETH_HLEN)
+	if (new_mtu > ntb_transport_max_size(dev->queues[0].qp) - ETH_HLEN)
 		return -EINVAL;
 
 	if (!netif_running(ndev)) {
@@ -311,41 +401,54 @@ static int ntb_netdev_change_mtu(struct net_device *ndev, int new_mtu)
 	}
 
 	/* Bring down the link and dispose of posted rx entries */
-	ntb_transport_link_down(dev->qp);
+	for (q = 0; q < dev->num_queues; q++)
+		ntb_transport_link_down(dev->queues[0].qp);
 
 	if (ndev->mtu < new_mtu) {
-		int i;
-
-		for (i = 0; (skb = ntb_transport_rx_remove(dev->qp, &len)); i++)
-			dev_kfree_skb(skb);
+		for (q = 0; q < dev->num_queues; q++) {
+			queue = &dev->queues[q];
 
-		for (; i; i--) {
-			skb = netdev_alloc_skb(ndev, new_mtu + ETH_HLEN);
-			if (!skb) {
-				rc = -ENOMEM;
-				goto err;
-			}
-
-			rc = ntb_transport_rx_enqueue(dev->qp, skb, skb->data,
-						      new_mtu + ETH_HLEN);
-			if (rc) {
+			for (i = 0;
+			     (skb = ntb_transport_rx_remove(queue->qp, &len));
+			     i++)
 				dev_kfree_skb(skb);
-				goto err;
+
+			for (; i; i--) {
+				skb = netdev_alloc_skb(ndev,
+						       new_mtu + ETH_HLEN);
+				if (!skb) {
+					rc = -ENOMEM;
+					goto err;
+				}
+
+				rc = ntb_transport_rx_enqueue(queue->qp, skb,
+							      skb->data,
+							      new_mtu +
+							      ETH_HLEN);
+				if (rc) {
+					dev_kfree_skb(skb);
+					goto err;
+				}
 			}
 		}
 	}
 
 	WRITE_ONCE(ndev->mtu, new_mtu);
 
-	ntb_transport_link_up(dev->qp);
+	for (q = 0; q < dev->num_queues; q++)
+		ntb_transport_link_up(dev->queues[q].qp);
 
 	return 0;
 
 err:
-	ntb_transport_link_down(dev->qp);
+	for (q = 0; q < dev->num_queues; q++) {
+		struct ntb_netdev_queue *queue = &dev->queues[q];
+
+		ntb_transport_link_down(queue->qp);
 
-	while ((skb = ntb_transport_rx_remove(dev->qp, &len)))
-		dev_kfree_skb(skb);
+		while ((skb = ntb_transport_rx_remove(queue->qp, &len)))
+			dev_kfree_skb(skb);
+	}
 
 	netdev_err(ndev, "Error changing MTU, device inoperable\n");
 	return rc;
@@ -404,6 +507,7 @@ static int ntb_netdev_probe(struct device *client_dev)
 	struct net_device *ndev;
 	struct pci_dev *pdev;
 	struct ntb_netdev *dev;
+	unsigned int q, desired_queues;
 	int rc;
 
 	ntb = dev_ntb(client_dev->parent);
@@ -411,7 +515,9 @@ static int ntb_netdev_probe(struct device *client_dev)
 	if (!pdev)
 		return -ENODEV;
 
-	ndev = alloc_etherdev(sizeof(*dev));
+	desired_queues = ntb_netdev_default_queues();
+
+	ndev = alloc_etherdev_mq(sizeof(*dev), desired_queues);
 	if (!ndev)
 		return -ENOMEM;
 
@@ -420,6 +526,15 @@ static int ntb_netdev_probe(struct device *client_dev)
 	dev = netdev_priv(ndev);
 	dev->ndev = ndev;
 	dev->pdev = pdev;
+	dev->num_queues = 0;
+
+	dev->queues = kcalloc(desired_queues, sizeof(*dev->queues),
+			      GFP_KERNEL);
+	if (!dev->queues) {
+		rc = -ENOMEM;
+		goto err_free_netdev;
+	}
+
 	ndev->features = NETIF_F_HIGHDMA;
 
 	ndev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
@@ -436,26 +551,51 @@ static int ntb_netdev_probe(struct device *client_dev)
 	ndev->min_mtu = 0;
 	ndev->max_mtu = ETH_MAX_MTU;
 
-	dev->qp = ntb_transport_create_queue(ndev, client_dev,
-					     &ntb_netdev_handlers);
-	if (!dev->qp) {
+	for (q = 0; q < desired_queues; q++) {
+		struct ntb_netdev_queue *queue = &dev->queues[q];
+
+		queue->ntdev = dev;
+		queue->qid = q;
+		queue->qp = ntb_transport_create_queue(queue, client_dev,
+						       &ntb_netdev_handlers);
+		if (!queue->qp)
+			break;
+
+		dev->num_queues++;
+	}
+
+	if (!dev->num_queues) {
 		rc = -EIO;
-		goto err;
+		goto err_free_queues;
 	}
 
-	ndev->mtu = ntb_transport_max_size(dev->qp) - ETH_HLEN;
+	rc = netif_set_real_num_tx_queues(ndev, dev->num_queues);
+	if (rc)
+		goto err_free_qps;
+
+	rc = netif_set_real_num_rx_queues(ndev, dev->num_queues);
+	if (rc)
+		goto err_free_qps;
+
+	ndev->mtu = ntb_transport_max_size(dev->queues[0].qp) - ETH_HLEN;
 
 	rc = register_netdev(ndev);
 	if (rc)
-		goto err1;
+		goto err_free_qps;
 
 	dev_set_drvdata(client_dev, ndev);
-	dev_info(&pdev->dev, "%s created\n", ndev->name);
+	dev_info(&pdev->dev, "%s created with %u queue pairs\n",
+		 ndev->name, dev->num_queues);
 	return 0;
 
-err1:
-	ntb_transport_free_queue(dev->qp);
-err:
+err_free_qps:
+	for (q = 0; q < dev->num_queues; q++)
+		ntb_transport_free_queue(dev->queues[q].qp);
+
+err_free_queues:
+	kfree(dev->queues);
+
+err_free_netdev:
 	free_netdev(ndev);
 	return rc;
 }
@@ -464,9 +604,14 @@ static void ntb_netdev_remove(struct device *client_dev)
 {
 	struct net_device *ndev = dev_get_drvdata(client_dev);
 	struct ntb_netdev *dev = netdev_priv(ndev);
+	unsigned int q;
+
 
 	unregister_netdev(ndev);
-	ntb_transport_free_queue(dev->qp);
+	for (q = 0; q < dev->num_queues; q++)
+		ntb_transport_free_queue(dev->queues[q].qp);
+
+	kfree(dev->queues);
 	free_netdev(ndev);
 }
 
-- 
2.48.1


