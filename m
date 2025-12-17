Return-Path: <dmaengine+bounces-7790-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D78A5CC8EB5
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 17:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CD992305C1F3
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 16:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5471A34D3AD;
	Wed, 17 Dec 2025 16:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Gc9MiSa2"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010024.outbound.protection.outlook.com [52.101.229.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5622034C986;
	Wed, 17 Dec 2025 16:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765990289; cv=fail; b=uH0IcDTdumiHbgmDMwkhZ5kJkIEU6LSD2paaaPXXWWfD6EyjD7UF97jKOqxhmR0UTKkd0b71fNSZDLDspP+XooJHlA9ZUZPUqK7jOVs4n3xBhYDUCID+kjVGAep6aOMTIZCbFRaVYE8e5xN/+RUG3LTjrPaVORrpZ/NFnEk9wtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765990289; c=relaxed/simple;
	bh=8/qQNmtlnXto+tyqn4YMVyv35slMxXS48SuROZp6/as=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IiopoQHnXqbQNrG9Xt+Uh2QD8ULd57jtMp2ipncHxs0F+UmIyXEtAm1suas1wWEFj4LrvSDsQt/Bq0Km2ufY5/SVJR9DnT4cuaQ5B3TYANmUQZ+72wFGyREGiqG7mQV4C+qFutfC2+kZMMJkc0ZGQIt4aq7ig+COY4j0uH0muk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Gc9MiSa2; arc=fail smtp.client-ip=52.101.229.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XHD8cods0irIIy09MyOugNPY6GA9FcP0QdcezMFDHXq1vQJH92IR7enu2LS8ywJvrlvhOGCS5WqIKAlIvubO7IeSLov79P3aujA1coLEpv/XqoPQam8XhMbjkO4ARM0G7Am6b7H4JRwNtyujTLs9wKS7xIfdfCo181a03A2v60V88crTJG5px/iR34Wv8X+/+MoD9Q/zmuVrTa3RTezXxnTkyB8VPt2qyeSiTHU5beFjqvS96mbs41Osmofv7bZOgnkwLrkhUtRZU3/7Xaru8J7+cVIsdIH1tj9tgP3HUphRNxdANWpqZI3upwgBd6Zp+LMN7nPG4njGdRB4Px5rjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJyF2DKW5ad2jiOFfko7k3RP3AiZhrVA2ovXjyjQ77Q=;
 b=Q9ci9XPopzCU/+XuoWaG4fXNJMVa74UieTmoBrHZTxEd8645O4v1WjKm/AU4oYBx6ILC96MSAuJ2sVt7OouJeIgiubvwvaXGDVqXfKKEtI4yoUuesKxf70NG6KdBbTFMDXMHc+XHPP2GHE2OE5G+a63ZzyJob0Wz2ZsnEHsY6pM+L6w858TkFZDL2DJ9JB1LJxqhLml/tZZNjQsnICEu6+ZzN3ybiTMKdPavM+T9rVqd1pp24s3L2VKzc2Xayn4B7mkD15pbtHA2V7R0NjmOqWkfbT+p11W1P3BbIGqNF11JmmFIsucay/D4TR7J12lsTOyQC0glDJQlnI5oq9Kc6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJyF2DKW5ad2jiOFfko7k3RP3AiZhrVA2ovXjyjQ77Q=;
 b=Gc9MiSa2Tfr+j3un14KOLs/L9hNedfzAOngxTmLXj82Cmld2fxFmt3kMnC83l3Tz/oAqphI3+MeYcLd2W/GK71nhCBv/EwKj4QjiyC8Wv4uUsCYOTFjwS5SrYrR/4zmV8Durj2s1JzAnA3XdrZ3NdZLNPaGnXYyIBcueC9FdiIA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by TYCP286MB2863.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:306::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 15:16:38 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 15:16:38 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Frank.Li@nxp.com,
	dave.jiang@intel.com,
	ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: mani@kernel.org,
	kwilczynski@kernel.org,
	kishon@kernel.org,
	bhelgaas@google.com,
	corbet@lwn.net,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	vkoul@kernel.org,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	jdmason@kudzu.us,
	allenbh@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Basavaraj.Natikar@amd.com,
	Shyam-sundar.S-k@amd.com,
	kurt.schwemmer@microsemi.com,
	logang@deltatee.com,
	jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	utkarsh02t@gmail.com,
	jbrunet@baylibre.com,
	dlemoal@kernel.org,
	arnd@arndb.de,
	elfring@users.sourceforge.net,
	den@valinux.co.jp
Subject: [RFC PATCH v3 27/35] NTB: epf: Provide db_vector_count/db_vector_mask callbacks
Date: Thu, 18 Dec 2025 00:16:01 +0900
Message-ID: <20251217151609.3162665-28-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251217151609.3162665-1-den@valinux.co.jp>
References: <20251217151609.3162665-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0098.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::19) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|TYCP286MB2863:EE_
X-MS-Office365-Filtering-Correlation-Id: bed16d64-fd65-4656-614a-08de3d7f4656
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|10070799003|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bxnUK0xs6gXzHDZs+BMj+kl3mVIJxFuJqyoW3wNLcrlIIz+m77IoWZYoKKOM?=
 =?us-ascii?Q?YFBbJ0NPfhZcIk+LVbKCCBt2V/oEoavdvgnvk+X8NOn0su/Z4hMxr1hJT4Xh?=
 =?us-ascii?Q?cksdMwGwAARbMDvZyzlFIf+yZwUBwy0/RyS9hng1n8L1g7+DzASdQgt9NyTy?=
 =?us-ascii?Q?FGhpoNKEkRHJqjWMcRHjNNFsaYEJU+Y8ESkR2xVZQsDjaFHnxf8yqaqy7PyI?=
 =?us-ascii?Q?qIHeyVxW1M47zZ6JIFcPpyi27slQbOizQQHpFEE06spobLLSRGWWxgZI0bUt?=
 =?us-ascii?Q?9iX7qOjAD4vYXsN78FpgPFNb4KJX3VWXwkA3mWUyh6VP441eVAlbcV057fos?=
 =?us-ascii?Q?JUZi6uGrjaSjiiihIa5jNPiFVJbboyWs4QgCpURHTHyMzImDrxoWla0Y3ucH?=
 =?us-ascii?Q?Ln49CrVE868amXfIE7UNpqXsWWXEuHZ8n+O99pDyiJLDUqO0RLZOGOgCRVG/?=
 =?us-ascii?Q?/82/CF4CBUAeSjNb0kktPQkd5Q5F8E77kgqVONrHDsmYhwIHd59+FWgQYokI?=
 =?us-ascii?Q?U0rx+slQePmFb4Y/zg1RBBM/anMP/5JE+s1iAs5XKnek09bvU0/fdYQD6mJU?=
 =?us-ascii?Q?soIJH+LnhUSfc0Y7oaXZPqZQLoSIAgHZlyNNPKUPp4SRM8+E6jt/2qi3w8fn?=
 =?us-ascii?Q?R1RES0jBnhdgt7DttZHQ6BMWzPF5oW/aQCgYeT4PCL8J1WC5BZmJ+zt/ASDb?=
 =?us-ascii?Q?oiunxANPekXszQeHWNvityV1QejOnCVsUQV3VraoWLAFNVVqWvqeawouJLhz?=
 =?us-ascii?Q?RJI2v4ek4QItFIW9xl5q4FMUCocsIJ3UXGyy7uO4kcLOF+lLhivQsf9WXS6y?=
 =?us-ascii?Q?HnKboiQTEwsO+gUVCrcBrTJHVa1JXOfXMdmdDjFcnVPVJ4hC5jOBDbGKncAA?=
 =?us-ascii?Q?7vJ5RSB6qEy0rv6cs5SqOhFv/pCvKFQ5/8iKo67lzd28pvkpA5rCRebUkRen?=
 =?us-ascii?Q?0BvkIQKFb3fwitJP4x1KzC1vaN93o18TokhWRw7SID7Gj2Uta5YgQIsiyS+/?=
 =?us-ascii?Q?lFgAzUWn04DqMVC1ggF32HSuDuwHNZIaiJxXiwbEvK9n1eoXh86O+4MvdCL+?=
 =?us-ascii?Q?ji3txYmAF3B/T/VHFLJPZHXQ4J0yqtsUZc8LWOBB9zgv+GUZuXEynFoctx5A?=
 =?us-ascii?Q?TDAavRmpoGMPdOE1qZVvvPhN6TkBcmfRnB/ZwcNs5wiNkABdxeh9msCTSKB/?=
 =?us-ascii?Q?gDhw8kij7jQBYDjDt0RVwT2Z2ms0nPYHwxe7kTLYJoVqDW5PGV2+PnsWNpQq?=
 =?us-ascii?Q?zWFJutpySc5e+o9FtyJj5hzKXn6wnV3xmSOIkBW0hmQA3kTGdHEIAf9BGNZk?=
 =?us-ascii?Q?gqRAP1JOViHGZ7UaZbWFbHvFCSiGW4rNHHk0WbeGByyPM4W+dYlOGwOQ6kEm?=
 =?us-ascii?Q?fD50uC0B3nJA4m+38O9bNSI0pwPmVqtM/kA+RDsZ2Os/WbTkSwvQEcPnIGd8?=
 =?us-ascii?Q?Gnp/Iia+uwN1YNZmgL/e80sMP/RJCOqY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FVV/dTVZFs/i686KLFGOiLpYbOhgHhBJBpswRdHSOsGWvloMFXam/6kakbEE?=
 =?us-ascii?Q?NfTD8aXX5rFT+GVKq8r+uFYP92st8F/08hPSlJJmfWMdXEVPhAIuhlSgaOkA?=
 =?us-ascii?Q?Ko7ToFaU2owSTe7sheFh7MqaMP8nsvGLQOCotUgh9U5r586zkFB93u+hfYdh?=
 =?us-ascii?Q?AN6WR99SaDjt9uapWN/QgpVIM/hps0PDaW8iyUbN53m/jS7KebCQCypJoLb4?=
 =?us-ascii?Q?W6ltQ6XOPb5e2s9erAC4g3RvDIx+HtUnmqcMi+HkBBfaCm+tDWmWK2v+TB/h?=
 =?us-ascii?Q?3D4/zcyj07ykcvH45Qgm7t/yvmXxRJ6OG9lLcTcd0FVBFwYFBBMUw5q0HrjK?=
 =?us-ascii?Q?rCDshhV3QvQ7YXCf18mw+qVr1KN0yitV5Lwf7Zlot+LiTLYJ1R/fXbTLxs3O?=
 =?us-ascii?Q?HtTfXjxpkzr+4NouwM9FTy/rWavUI4O/qpOwuDU8U1sjUwMfswcpZpYpK2bi?=
 =?us-ascii?Q?NVzgK9vCI0fkaTG9MJhhYE6P3iNEeYgm12SzuEkHUgAdtPn62zhx8H03h7e2?=
 =?us-ascii?Q?N5VHwS/49quqCEyRZdhD+hcv5XJKcOKio+cCwEf0OUl0+cM6onzSTD2zy7g7?=
 =?us-ascii?Q?akHsMeDUuJrxGqcwc6F6/v8S43NbQUMxsIC7X++JHdyBhAcQhRngRiUIPeJd?=
 =?us-ascii?Q?7b0podBQHsDKH0xNko6tEQaGxW/fHQJBvNQkYLsSx1W8Vegp0qqFfNshjSd3?=
 =?us-ascii?Q?3MnKmJ+zgUYRpve3SnXGE0HQUbXJlphy0SRxOlEwdrtHpACQ5L8qdydF9UKS?=
 =?us-ascii?Q?Ypk/oEtwGtG62Rg9EbBEgE+BxQYOjXBv7ZaoU1K8v+Gt4lnLSiiuzkjyphM9?=
 =?us-ascii?Q?lDOVF5wX4wDgmWCVTztruhOFjnOkUyhvor91GnQEGtEnbaFJ+0c5WTBHg/zN?=
 =?us-ascii?Q?lPQvsOLZO1H/DdJrUvupF50MiYxOG+A+f4Ne5xBggNYrxaznU2qVTSDddKnQ?=
 =?us-ascii?Q?ImQ7zULa6/Thg6fmWipEz8qkDQn0MrNSwK2oO4VAPsvZKMog3/k+WBdl1R6y?=
 =?us-ascii?Q?LRaKYNEhut1pO+cp2ibtU+G+Bv51C+Lzjj6oe45jOkmps9Qz3XF/4qgKcY0W?=
 =?us-ascii?Q?WUraZJ5/G9hwUQYhXssLn88od9I5xhY3yR2lMK812+jck9gybomwNeTWCJUz?=
 =?us-ascii?Q?qQJISHMQNC36HhNKVx41aSpl4CheKlC2gRuL3ZYcXM2aU+ub7tZV9j5878/Y?=
 =?us-ascii?Q?1jXE/ZgPhE6o/LyDZGGuCAGouYL/R2usJcmtKW2JdTrso4eukQNJHHQ0+52G?=
 =?us-ascii?Q?KQInui7YWlVJa11rolgEcLabnuMRKiemFXjDpBDH3czlyrNAs8l9EGU57HP5?=
 =?us-ascii?Q?EkeDEpvLqElM0SaENgnOagtLh5qAFVhVG/o1UkNcTQuyP9JIX5e/ytTSPlCQ?=
 =?us-ascii?Q?M5wPLPCRuFvZDzcFZRs5BEylrAT0xTCKqhtNBcqPCeyYPKwah8fOhf0pJEMR?=
 =?us-ascii?Q?/S9nXV/jY8h6uIVwaYlPaPtcqJCvi8yM2FVvgTpax07QLsFESzbBDbs3tYXs?=
 =?us-ascii?Q?njTs/PW9a9mzvbW11e2YRmjsBuszdkW1nbXnOqP725U4nR6O1heG6YilFltq?=
 =?us-ascii?Q?auRBmA2R7JOoIUB74tOPKRXWaxiLZUZwVB7cdOefIHAXaTFp6+Ej3uoFtvQb?=
 =?us-ascii?Q?YrONHuQ4U/aEpw64kEsyOC8=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: bed16d64-fd65-4656-614a-08de3d7f4656
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 15:16:38.4206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ohPDDGGsA3cX41B+LwtYzL59olKhS28UD7AIV1KW1Yj+CGL+ZiyzCcmDrDzIamGPZPOeo7NUOoQwJP00b1wZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2863

Provide db_vector_count() and db_vector_mask() implementations for both
ntb_hw_epf and pci-epf-vntb so that ntb_transport can map MSI vectors to
doorbell bits. Without them, the upper layer cannot identify which
doorbell vector fired and ends up scheduling rxc_db_work() for all queue
pairs, resulting in a thundering-herd effect when multiple queue pairs
(QPs) are enabled.

With this change, .peer_db_set() must honor the db_bits mask and raise
all requested doorbell interrupts, so update those implementations
accordingly.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/hw/epf/ntb_hw_epf.c               | 47 ++++++++++++-------
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 40 +++++++++++++---
 2 files changed, 63 insertions(+), 24 deletions(-)

diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
index 4ecc6b2177b4..5303a8944019 100644
--- a/drivers/ntb/hw/epf/ntb_hw_epf.c
+++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
@@ -375,7 +375,7 @@ static int ntb_epf_init_isr(struct ntb_epf_dev *ndev, int msi_min, int msi_max)
 		}
 	}
 
-	ndev->db_count = irq;
+	ndev->db_count = irq - 1;
 
 	ret = ntb_epf_send_command(ndev, CMD_CONFIGURE_DOORBELL,
 				   argument | irq);
@@ -409,6 +409,22 @@ static u64 ntb_epf_db_valid_mask(struct ntb_dev *ntb)
 	return ntb_ndev(ntb)->db_valid_mask;
 }
 
+static int ntb_epf_db_vector_count(struct ntb_dev *ntb)
+{
+	return ntb_ndev(ntb)->db_count;
+}
+
+static u64 ntb_epf_db_vector_mask(struct ntb_dev *ntb, int db_vector)
+{
+	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
+
+	db_vector--; /* vector 0 is reserved for link events */
+	if (db_vector < 0 || db_vector >= ndev->db_count)
+		return 0;
+
+	return ndev->db_valid_mask & BIT_ULL(db_vector);
+}
+
 static int ntb_epf_db_set_mask(struct ntb_dev *ntb, u64 db_bits)
 {
 	return 0;
@@ -492,26 +508,21 @@ static int ntb_epf_peer_mw_get_addr(struct ntb_dev *ntb, int idx,
 static int ntb_epf_peer_db_set(struct ntb_dev *ntb, u64 db_bits)
 {
 	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
-	u32 interrupt_num = ffs(db_bits) + 1;
-	struct device *dev = ndev->dev;
+	u32 interrupt_num;
 	u32 db_entry_size;
 	u32 db_offset;
 	u32 db_data;
-
-	if (interrupt_num >= ndev->db_count) {
-		dev_err(dev, "DB interrupt %d greater than Max Supported %d\n",
-			interrupt_num, ndev->db_count);
-		return -EINVAL;
-	}
+	int i;
 
 	db_entry_size = readl(ndev->ctrl_reg + NTB_EPF_DB_ENTRY_SIZE);
 
-	db_data = readl(ndev->ctrl_reg + NTB_EPF_DB_DATA(interrupt_num));
-	db_offset = readl(ndev->ctrl_reg + NTB_EPF_DB_OFFSET(interrupt_num));
-
-	writel(db_data, ndev->db_reg + (db_entry_size * interrupt_num) +
-	       db_offset);
-
+	for_each_set_bit(i, (unsigned long *)&db_bits, ndev->db_count) {
+		interrupt_num = i + 1;
+		db_data = readl(ndev->ctrl_reg + NTB_EPF_DB_DATA(interrupt_num));
+		db_offset = readl(ndev->ctrl_reg + NTB_EPF_DB_OFFSET(interrupt_num));
+		writel(db_data, ndev->db_reg + (db_entry_size * interrupt_num) +
+		       db_offset);
+	}
 	return 0;
 }
 
@@ -541,6 +552,8 @@ static const struct ntb_dev_ops ntb_epf_ops = {
 	.spad_count		= ntb_epf_spad_count,
 	.peer_mw_count		= ntb_epf_peer_mw_count,
 	.db_valid_mask		= ntb_epf_db_valid_mask,
+	.db_vector_count	= ntb_epf_db_vector_count,
+	.db_vector_mask		= ntb_epf_db_vector_mask,
 	.db_set_mask		= ntb_epf_db_set_mask,
 	.mw_set_trans		= ntb_epf_mw_set_trans,
 	.mw_clear_trans		= ntb_epf_mw_clear_trans,
@@ -591,8 +604,8 @@ static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
 	int ret;
 
 	/* One Link interrupt and rest doorbell interrupt */
-	ret = ntb_epf_init_isr(ndev, NTB_EPF_MIN_DB_COUNT + NTB_EPF_IRQ_RESERVE,
-			       NTB_EPF_MAX_DB_COUNT + NTB_EPF_IRQ_RESERVE);
+	ret = ntb_epf_init_isr(ndev, NTB_EPF_MIN_DB_COUNT + 1 + NTB_EPF_IRQ_RESERVE,
+			       NTB_EPF_MAX_DB_COUNT + 1 + NTB_EPF_IRQ_RESERVE);
 	if (ret) {
 		dev_err(dev, "Failed to init ISR\n");
 		return ret;
diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index c89f5b0775fa..c47186fe4f75 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -1384,6 +1384,22 @@ static u64 vntb_epf_db_valid_mask(struct ntb_dev *ntb)
 	return BIT_ULL(ntb_ndev(ntb)->db_count) - 1;
 }
 
+static int vntb_epf_db_vector_count(struct ntb_dev *ntb)
+{
+	return ntb_ndev(ntb)->db_count;
+}
+
+static u64 vntb_epf_db_vector_mask(struct ntb_dev *ntb, int db_vector)
+{
+	struct epf_ntb *ndev = ntb_ndev(ntb);
+
+	db_vector--; /* vector 0 is reserved for link events */
+	if (db_vector < 0 || db_vector >= ndev->db_count)
+		return 0;
+
+	return BIT_ULL(db_vector);
+}
+
 static int vntb_epf_db_set_mask(struct ntb_dev *ntb, u64 db_bits)
 {
 	return 0;
@@ -1509,20 +1525,28 @@ static int vntb_epf_peer_spad_write(struct ntb_dev *ndev, int pidx, int idx, u32
 
 static int vntb_epf_peer_db_set(struct ntb_dev *ndev, u64 db_bits)
 {
-	u32 interrupt_num = ffs(db_bits) + 1;
 	struct epf_ntb *ntb = ntb_ndev(ndev);
 	u8 func_no, vfunc_no;
-	int ret;
+	u64 failed = 0;
+	int i;
 
 	func_no = ntb->epf->func_no;
 	vfunc_no = ntb->epf->vfunc_no;
 
-	ret = pci_epc_raise_irq(ntb->epf->epc, func_no, vfunc_no,
-				PCI_IRQ_MSI, interrupt_num + 1);
-	if (ret)
-		dev_err(&ntb->ntb.dev, "Failed to raise IRQ\n");
+	for_each_set_bit(i, (unsigned long *)&db_bits, ntb->db_count) {
+		/*
+		 * DB bit i is MSI interrupt (i + 2).
+		 * Vector 0 is used for link events and MSI vectors are
+		 * 1-based for pci_epc_raise_irq().
+		 */
+		if (pci_epc_raise_irq(ntb->epf->epc, func_no, vfunc_no,
+				      PCI_IRQ_MSI, i + 2))
+			failed |= BIT_ULL(i);
+	}
+	if (failed)
+		dev_err(&ntb->ntb.dev, "Failed to raise IRQ (0x%llx)\n", failed);
 
-	return ret;
+	return failed ? -EIO : 0;
 }
 
 static u64 vntb_epf_db_read(struct ntb_dev *ndev)
@@ -1596,6 +1620,8 @@ static const struct ntb_dev_ops vntb_epf_ops = {
 	.spad_count		= vntb_epf_spad_count,
 	.peer_mw_count		= vntb_epf_peer_mw_count,
 	.db_valid_mask		= vntb_epf_db_valid_mask,
+	.db_vector_count	= vntb_epf_db_vector_count,
+	.db_vector_mask		= vntb_epf_db_vector_mask,
 	.db_set_mask		= vntb_epf_db_set_mask,
 	.mw_set_trans		= vntb_epf_mw_set_trans,
 	.mw_clear_trans		= vntb_epf_mw_clear_trans,
-- 
2.51.0


