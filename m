Return-Path: <dmaengine+bounces-5185-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD82DAB9525
	for <lists+dmaengine@lfdr.de>; Fri, 16 May 2025 06:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A9404E7F29
	for <lists+dmaengine@lfdr.de>; Fri, 16 May 2025 04:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F7522DA06;
	Fri, 16 May 2025 04:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="kq44fD8z"
X-Original-To: dmaengine@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11010046.outbound.protection.outlook.com [52.101.51.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B151B22F775;
	Fri, 16 May 2025 04:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.51.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747368394; cv=fail; b=DvjRhuySA7Ary8zkZErBqMvPARHz5GFOpmb/im6XmWiHMxKINiK5y7Md2qpj2UrgabteXXICMqNGSaOXw/OWdF3kwpxlhTIDchYFcwkBn/5sph+A+tKvTQyJUQ+c6wVILr0Z5q+9bNX1ju4ln840u6vL6uTsJvbuwZLEUCs5JoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747368394; c=relaxed/simple;
	bh=7+M8VIpe7BNEhY8Fws3P7AsbFSNlv/IYhvsxkhSVEvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QxpQE9sNqCyWRRbfV2sEgNweN41TXMgbM3HnbvDWU7NpjuQ+jNHAblxerHB/+/hQwKnuLlpbRGNuOEW9NaRx7G/rycFdVwX5JB4OEA1TJzNl3Zof0bASrJlcl2+r91CvhjEpNjpMy4ThEsO4U7Ojqc3xmtQ2vTZznRugfr+eJ08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=kq44fD8z; arc=fail smtp.client-ip=52.101.51.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HabL78sL+nbAWOL6uXZeWAki14fFCUNrOBpbbepHSBRcyH+Ws15U6DURjSJNKFuElyq2+0XPDY9EJFenvqK3kbQgJKl7zXj7rzoZhXqhq4pqqhGsUn6U3Pk1jcVkllWUbrtbcCGEYZOLFSIlNolpFNShl2REpfJtfsKl4+pOdQXavFdMCcgZ5dssl+cc1KkvVYIE0CHwxDcJEJ+sjyZmGNriDISP/g2Lu+oH9W09xro/C4Y4pFG71c+UycIAusJ994nxDEM6NUsmV1ScwW52CNeW3/pGblckGVB+HdPwmKL4mRdZNbfmcb4iHind4vzldW539H+YdSTWOpYwUp1j8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2KG1yPnUYLTj7Q4FEDXtugyvdqH3ixK4FiYSzV0b6A0=;
 b=PO4ODMnzze/c4FlyBus5wGXVHlwEI62biAA9vHhk7UG+1ixKvmMXKPtYSpCoGbDH9Uwv7gZGqZaMy+ZJ5G+X6ySVivJnfDnhLJILChFGK4yA29ussBmkHJ5JVQz1qj6pH2qA9RqX+2tsdrLdmt9fGo/AK+AX+xCdeasNidgEUR8pif/F045JQ/1DAtT2/a8VdV54qJOhCGwigi5Rto8aIVKngrguYBu/FqPIRckiiR+Wza2frmW1qpcUMeLRY0rCnf7EudNaSTcD1rhR+yRvnPdkjdAx2bbradBm+v5Y3dwxmLvqK/iBdKZ6x+WDYKrSxS0T+vTRmnMlVJe4X1xFWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2KG1yPnUYLTj7Q4FEDXtugyvdqH3ixK4FiYSzV0b6A0=;
 b=kq44fD8z8JmhFfZsCfOm/KysdwwZmc5wFWANuQJG0iXoBsKnf0pqXF/7DGMI9NiJmpR6K2rbifFX2W8inSeZzxBR0SAzsEck60PBMf6Fdu7ZVA2DYxUQmMPI+Yhl9t0d/OZJuDmw+MTrlJMb8aiE0eMSRRPFPdJRbjWvLiZ9ncZqqcVRk1hY3/7Q+Aa2yuzd4e/fYQID3udk+ILeP0P89VeA9SFNm9mxiQzpOY1aC05I2xE+ImxYuc6D8ecDRugUr77crNWWz7jJ+UbJdhALcinidi20NGVy19IvgnW84k5t1yxd4xVgEVfx8IAZ1HNHSwKdLxQO8Z24JbHp7oM+7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM8PR03MB6230.namprd03.prod.outlook.com (2603:10b6:8:3c::13) by
 SJ2PR03MB7093.namprd03.prod.outlook.com (2603:10b6:a03:4fb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Fri, 16 May
 2025 04:06:31 +0000
Received: from DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::c297:4c45:23cb:7f71]) by DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::c297:4c45:23cb:7f71%7]) with mapi id 15.20.8722.031; Fri, 16 May 2025
 04:06:31 +0000
From: adrianhoyin.ng@altera.com
To: dinguyen@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Eugeniy.Paltsev@synopsys.com,
	vkoul@kernel.org,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: adrianhoyin.ng@altera.com,
	Matthew Gerlach <matthew.gerlach@altrera.com>
Subject: [PATCH 2/4] dt-bindings: mtd: cadence: Add iommus and dma-coherent properties
Date: Fri, 16 May 2025 12:05:46 +0800
Message-ID: <2fe75c0443a8481d80a3cd05a6f3ef2ca30eaa97.1747367749.git.adrianhoyin.ng@altera.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <cover.1747367749.git.adrianhoyin.ng@altera.com>
References: <cover.1747367749.git.adrianhoyin.ng@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0126.apcprd03.prod.outlook.com
 (2603:1096:4:91::30) To DM8PR03MB6230.namprd03.prod.outlook.com
 (2603:10b6:8:3c::13)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR03MB6230:EE_|SJ2PR03MB7093:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ae4b3dd-ba53-4c2d-533d-08dd942f0a38
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5YxYCGuqZu1xUwr5SdbMQCetut/ufnOoLogtadeZg6jkP3TBnLD35eeevesT?=
 =?us-ascii?Q?os0Yv4McdWGshZtMbrE6eUKX1GxbYcibnUoKu7NaLirrHtJqUCPcga23VxL9?=
 =?us-ascii?Q?X0T2mrQ7OmYw0tfiqhh+Skh3Ak+NPmm7dkyVve3PDh/rh1xrVgIH0SfaZLfc?=
 =?us-ascii?Q?rOlh3zVbd/r3Yjj9is9QEAALeA9TWQWYKcKLnUwBvYgP8YuDrQsfSBacbgQQ?=
 =?us-ascii?Q?IGT8FvDL9slgSbehLkuGSEgiuXBwnM6DJkUSOGef165fBYo+luLgtPPjd9pg?=
 =?us-ascii?Q?I/AcVhUseWYgdflEjqXQImE7jZ9GGQZi8rhtm9cor0kMa4kPj98zccU9Sx+F?=
 =?us-ascii?Q?RMxpPosUmMq3aC5AOaoPMsMpHYWW//7Sp426FlptpZ4nWwlmwPck1yCnC1+t?=
 =?us-ascii?Q?JLLXsm2PY3uAAnPbOt1RPOGFAGzmj68Wy45UBHmzXh8L5lXRI5fM+ONX/Swg?=
 =?us-ascii?Q?Mn+S34yai8s/Zpi6tysp2iV364tYL8Om3CtedHQPRH7lKCFgVAcXN4FhrDoq?=
 =?us-ascii?Q?tNoTGXAQTeaE2c9nQQ156A90h4f5uFdzGOYkvVvKs23Vet8z4o1YCmBX2PQt?=
 =?us-ascii?Q?JPLTaKhK1wtGRwNz/zyjvqKpnGxYqsAWPBVF7cevc42bkqxdlxCI0YGRsV+r?=
 =?us-ascii?Q?C7TUl0JWngdPOJq05OckVCIVgTVnNnxNozBzFFXUF7UzwGEZQtVMVVrnebGd?=
 =?us-ascii?Q?n9Zc6J8bfyfAwwJmYHPV7puENTO/WmMI6XQa0PS9XOgtPdvCAOWr8GckT+5Q?=
 =?us-ascii?Q?/8ttXbqkLzOdrYu/ypsTHmt5n59XGWtV93pA/Hk3mTP5uVcCJI3IiRwBDPTl?=
 =?us-ascii?Q?OmP05AYHjCTBf5xuAK6Z1/aN++CZzDXKcDIlQpvcxyUjsH/r89RopLRCfaDw?=
 =?us-ascii?Q?yOJtpjkqoDG2kshilVqvOuoUDtJAqk7IcmwybB+EBHlrQzCnekT2zir/ttTW?=
 =?us-ascii?Q?DyMKDjcM4fesLkxSlKAjsukyipmji77WRUZKi0smiKlQQkMEyyvNAd+F/tX6?=
 =?us-ascii?Q?8YMHkFp5GR3UL2UZZltS23p/GS5EsCU/ZDDk9+e8m31i/7WaZXbcRQUXieUN?=
 =?us-ascii?Q?//MwAiNuyo//VbYXbix4shGNoTG2ziUfcRolwqNCvmd8ACsuKwLrw/NjbBM/?=
 =?us-ascii?Q?NtsavlUkI3j3EKaWYCps7wmDYIaL0bBnktx9JW4h1054oUHMv0JGOWY5t9lt?=
 =?us-ascii?Q?rbiwsXy7kW3S1aM/S9mgceR5ne4VVg6gkm0T4lIsshaoqVCALmFHTasSib77?=
 =?us-ascii?Q?c47201ucSU2uGd72sUWaagIeyJPw3pc+OJqugMUgi0XVhJ3/x0kGG42LghHr?=
 =?us-ascii?Q?2y4SmoKntwPEJ//kROnWw08QRhlHQMxxYzURLwYADUC8DQDrxrOHvp1sPL0o?=
 =?us-ascii?Q?ppWHcp+Z9rgzPqGw+GNupfHjMNMRWhA/BszJXLOze4iBwvHrmurFno1Vy3Cn?=
 =?us-ascii?Q?IY5ywTmDVKk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR03MB6230.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P94pMUFiIt9BbEksF2/IpOd/UpqgGYzDP2aZIAaYMobpqzzMdZQFZUCzRYtu?=
 =?us-ascii?Q?hdhvWgqTp9s++9kkfD/VzS2ToEfFA4YOXpoeHhMxSpesfArIKNPhAvoq0U6R?=
 =?us-ascii?Q?DRlriBxPmZhnIympEpuuAOU0DybT/OaMaWLJUO2x4APybJPPJ4KYVnysq5WZ?=
 =?us-ascii?Q?6R+vrvdidKJfzmQzSzRi7njMq/RUKGzEGSOyCZSs/fUtAXl/ROoMCsfS0bb1?=
 =?us-ascii?Q?c1rxuZC6/qOrpZUjyI1lLwKMqtsjPucmvc3n5NzgcltUZDCkp7CmFp19y9Ba?=
 =?us-ascii?Q?ubcYt7/T50ddRuz7ZyBP/+6Eimix4LT9DRX2y0BYr7U/cd+Tm1oSsvYc2UFS?=
 =?us-ascii?Q?NzkyfSxS000Xu0DmRQjAeY3ifuxRHHywRWZpLzGmtYRZN5aCg32sGrqKXhmJ?=
 =?us-ascii?Q?g6P4lPI8gcWe58NJUuhigIn8JKXcRAtd89sw+mWCHd/dr9rgM/6Az3BPGf5g?=
 =?us-ascii?Q?tJ+vxWE/UXfVid8Wa1/tRm+2+jXSSn/jTW8HmGVruPDb8qMmy5mhGipDuXji?=
 =?us-ascii?Q?6O/lpNQDmVXFrXB1eNGtuLnZFleTM7TuUsiVgqLK5thzaz8gQmjaAgL6q68N?=
 =?us-ascii?Q?DZ1PTwWHkpW21Z7EBsuxM3zQgpGfHIwF6tPsII/lSkPrIeyGgrl86Djm474K?=
 =?us-ascii?Q?n3nM4BZYBjJBYCrCZYBp/LflVt7FSCn/7Sa8FMMVd1bo+IVgTzOuEdMz9BKz?=
 =?us-ascii?Q?BE/aOaLStZWbY+8/r0G+O0Wei1y0iL6yNuyMpTHomDFPzLzoARyMYVQ2GoDj?=
 =?us-ascii?Q?RH9Ey+qsQedqmEJurkom329qki1JL71FqxtaEFCGVqxarugAZD7dcbmiRDPq?=
 =?us-ascii?Q?uhLGUdDjgea1FSAjidwO6C/Jzg8gvxTQ/CdJL7vPOoDOFOSDal3fc/8DIgrW?=
 =?us-ascii?Q?Bm7EPGfH0eEuxDuhby7XTRhBJYxzOcsG7VGprnCA86vvrxLgoslkQKjX8hcF?=
 =?us-ascii?Q?SIt4trqchuKVOZaxd7ht9VZn58owinGtPM9gpS1rqOcMyOZ3M/H50DDmgUQQ?=
 =?us-ascii?Q?uWHjiurx3IzhBxUG9BGlzZBShsQpYkFm79U4SsblK+wi4Q6tQUbitsgRxu8E?=
 =?us-ascii?Q?RL0A/xIA6wBiHhxg6rcZJmAn/jTMvjnLtqwInmK+j59cvlLPv016CLHFq/vY?=
 =?us-ascii?Q?lcqbO4ZZtXKr41ywarvt3l7FmPJHPBkjVLk1VI/dBzlcGDL5MZ6ISJNKHE5/?=
 =?us-ascii?Q?guTDnAABgqrIAuSr0CPQoqLoipCyUVLL4HFi68koCUnEqFR8Er7mt5Ibj31I?=
 =?us-ascii?Q?1b+uT6HMHkZGBuiKhnNWsct4s+PfInedQkwt5pPdeI488fgiKuTS2tAkuboK?=
 =?us-ascii?Q?tlLG93tsOAsR9uc4k4M6B+0r+1JMHAyGj+2mJfOap7n25WbgWY/ckiL7i1zp?=
 =?us-ascii?Q?F4an71R43kzsK1v7DDa33zbk4OGRKPz65JmfOP1qqoQ1eDeeVrnBxjBKTy1M?=
 =?us-ascii?Q?98JBAedBjyPkOG0iLw/anqklbuW1ADWyftJd+RA1csnxj4+l4RKp1IgJBT6J?=
 =?us-ascii?Q?AVjuPHyp0e6zL0mId+ZIwl+xxbSQgfz3edjfCKJRzypp7c9YoFeveSKz6rqL?=
 =?us-ascii?Q?NeExbjfPHvzOgozdhOZbFoA22pAsRNggOv2uCpALY48xepCKEED587U0Jui5?=
 =?us-ascii?Q?NA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ae4b3dd-ba53-4c2d-533d-08dd942f0a38
X-MS-Exchange-CrossTenant-AuthSource: DM8PR03MB6230.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 04:06:31.5744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Facn0dhej7JxkgoAYBePSSOiMKDm4yLkut+0wHc22FJFHjELdO6M66P7kt8nVviQJb8M73Zy17ByfTi3ZRzcMnLKd1bO6ORHocqShrDP+8o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR03MB7093

From: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>

Update bindings to include iommus and dma-coherent as an optional
properties.

Signed-off-by: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@altrera.com>
---
 Documentation/devicetree/bindings/mtd/cdns,hp-nfc.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/cdns,hp-nfc.yaml b/Documentation/devicetree/bindings/mtd/cdns,hp-nfc.yaml
index e1f4d7c35a88..367257a227b1 100644
--- a/Documentation/devicetree/bindings/mtd/cdns,hp-nfc.yaml
+++ b/Documentation/devicetree/bindings/mtd/cdns,hp-nfc.yaml
@@ -40,6 +40,11 @@ properties:
   dmas:
     maxItems: 1
 
+  dma-coherent: true
+
+  iommus:
+    maxItems: 1
+
   cdns,board-delay-ps:
     description: |
       Estimated Board delay. The value includes the total round trip
-- 
2.49.GIT


